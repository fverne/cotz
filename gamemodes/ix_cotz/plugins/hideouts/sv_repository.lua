local PLUGIN = PLUGIN

function PLUGIN:NormalizeIDKeys(records)
	local normalized = {}
	for id, value in pairs(records or {}) do
		normalized[tostring(id)] = value
	end

	return normalized
end

function PLUGIN:LoadData()
	-- Map cleanup reloads plugin data; leave retained item rows as the authority.
	self.state =
		self:GetData({ version = 1, nextID = 1, hideouts = {}, templates = {}, areas = {}, entrances = {} })
	-- Helix's default JSON decoder converts numeric-looking object keys to
	-- numbers. Runtime IDs are strings, including guest, shell and seed keys.
	self.state.hideouts = self:NormalizeIDKeys(self.state.hideouts)
	self.state.templates = self:NormalizeIDKeys(self.state.templates)
	self.state.areas = self:NormalizeIDKeys(self.state.areas)
	self.state.entrances = self:NormalizeIDKeys(self.state.entrances)
	self.state.retired = self:NormalizeIDKeys(self.state.retired)
	self.state.locations = self:NormalizeIDKeys(self.state.locations)
	for _, template in pairs(self.state.templates) do
		template.containers = self:NormalizeIDKeys(template.containers)
	end
	for _, record in pairs(self.state.retired) do
		record.containers = self:NormalizeIDKeys(record.containers)
		for _, slot in pairs(record.containers) do slot.guests = self:NormalizeIDKeys(slot.guests) end
		record.personalLayout = self:NormalizeIDKeys(record.personalLayout)
	end
	local nextID = tonumber(self.state.nextID) or 1
	for id, record in pairs(self.state.hideouts) do
		record.id = id
		record.template = tostring(record.template)
		record.entrance = tostring(record.entrance)
		record.guests = self:NormalizeIDKeys(record.guests)
		record.shell = self:NormalizeIDKeys(record.shell)
		record.seeds = self:NormalizeIDKeys(record.seeds)
		record.furnishings = record.furnishings or {}
		record.ownerType = record.ownerType or "character"
		record.access = record.access or "squad"
		record.containers = self:NormalizeIDKeys(record.containers)
		for _, slot in pairs(record.containers) do slot.guests = self:NormalizeIDKeys(slot.guests) end
		record.personalLayout = self:NormalizeIDKeys(record.personalLayout)
		if tonumber(id) then
			nextID = math.max(nextID, tonumber(id) + 1)
		end
	end
	self.state.nextID = nextID
	self.state.version = 2
	self.instances = self.instances or {}
	self.members = self.members or {}
	self.ready = true
end

function PLUGIN:Persist()
	if not self.ready then
		return false
	end
	self.state.revision = (self.state.revision or 0) + 1
	self:SetData(self.state)
	-- SetData has no failure result; verify the file rather than its in-memory cache.
	local saved = self:GetData(nil, false, false, true)

	return istable(saved) and saved.revision == self.state.revision
end

function PLUGIN:GetHideout(id)
	return self.state and self.state.hideouts[tostring(id)]
end

function PLUGIN:GetHideoutName(record)
	if record.ownerType == "squad" then return record.name end
	local character = ix.char.loaded[record.owner]
	local ownerName = character and character:GetName() or record.ownerName or "Character #" .. record.owner

	return ownerName .. "'s " .. record.name
end

function PLUGIN:GetTemplate(record)
	local instance = record and self.instances[record.id]
	if instance and instance.template then return instance.template end

	return record and self.state.templates[record.template]
end

function PLUGIN:CanAccess(client, record)
	local character = IsValid(client) and client:GetCharacter()

	return character
		and record
		and not record.deleting
		and (record.owner == character:GetID() or (record.guests or {})[tostring(character:GetID())] == true)
end

function PLUGIN:GrantHideout(client, templateID, entranceID, name, locationID)
	local character = client:GetCharacter()
	if not self.ready or not character then
		return false, "Character data is not ready."
	end
	if not self.state.templates[templateID] then
		return false, "Unknown hideout template."
	end
	if not self.state.entrances[entranceID] then
		return false, "Unknown entrance."
	end
	local limit = ix.config.Get("hideoutPersonalLimit", 0)
	local owned = 0
	for _, record in pairs(self.state.hideouts) do
		if record.ownerType ~= "squad" and record.owner == character:GetID() then owned = owned + 1 end
	end
	if limit > 0 and owned >= limit then return false, "That character has reached the personal storage limit." end
	local id = tostring(self.state.nextID or 1)
	self.state.nextID = tonumber(id) + 1
	self.state.hideouts[id] = {
		id = id,
		owner = character:GetID(),
		ownerName = character:GetName(),
		template = templateID,
		entrance = entranceID,
		name = name,
		location = locationID,
		personalVersion = 1,
		guests = {},
		furnishings = {},
		shell = {},
	}
	if not self:Persist() then
		self.state.hideouts[id] = nil

		return false, "Could not save the hideout."
	end

	return true, id
end

function PLUGIN:DeleteHideout(id, callback)
	local record = self:GetHideout(id)
	if not record then
		callback(false, "Unknown hideout.")

		return
	end
	local active = self.instances[record.id]
	if (self.personalPurchases or {})[record.id] or (self.capacityPurchases or {})[record.id] then
		callback(false, "Wait for the pending hideout purchase.")
		return
	end
	if active and (active.operations or 0) > 0 then
		callback(false, "Wait for the pending economic operation before deleting this hideout.")
		return
	end
	record.deleting = true
	if not self:Persist() then
		callback(false, "Could not save the deletion marker.")

		return
	end
	local instance = self.instances[record.id]
	if instance then
		for client in pairs(instance.occupants) do
			local ok = self:LeaveHideout(client, true)
			if not ok then
				callback(false, "Evacuate occupants before deleting this hideout.")

				return
			end
		end
		for client in pairs(instance.pending) do
			if IsValid(client) then
				client.ixHideoutPending = nil
			end
		end
		instance.pending = {}
		if instance.state == "loading" then
			self:FailLoad(instance, "The hideout was deleted.")
		else
			self:RemoveInstance(instance)
		end
	end
	local query = mysql:Select("ix_items")
	query:Where("inventory_id", 0)
	query:WhereLike("data", "\"cotzHideout\"")
	query:Callback(function(rows)
		local ids = {}
		for _, row in ipairs(rows or {}) do
			local data = util.JSONToTable(row.data or "{}") or {}
			local location = data.cotzHideout
			if
				istable(location)
				and location.schema == Schema.folder
				and location.map == game.GetMap()
				and tostring(location.id) == record.id
			then
				ids[#ids + 1] = tonumber(row.item_id)
			end
		end
		self:DeleteHideoutRows(record, ids, callback)
	end)
	query:Execute()
end

function PLUGIN:DeleteHideoutRows(record, ids, callback)
	if #ids > 0 then
		local query = mysql:Delete("ix_items")
		query:WhereIn("item_id", ids)
		query:Where("inventory_id", 0)
		query:Callback(function()
			self:DeleteHideoutRows(record, {}, callback)
		end)
		query:Execute()

		return
	end
	if record.storageID then
		local inventoryID = record.storageID
		local query = mysql:Delete("ix_items")
		query:Where("inventory_id", inventoryID)
		query:Callback(function()
			local remove = mysql:Delete("ix_inventories")
			remove:Where("inventory_id", inventoryID)
			remove:Callback(function()
				ix.item.inventories[inventoryID] = nil
				record.storageID = nil
				self:DeleteHideoutRows(record, {}, callback)
			end)
			remove:Execute()
		end)
		query:Execute()

		return
	end
	-- Keep inventory references recoverable after character deletion or explicit retirement.
	if record.shop or next(record.containers or {}) then
		self.state.retired = self.state.retired or {}
		self.state.retired[record.id] = table.Copy(record)
	end
	self.state.hideouts[record.id] = nil
	if not self:Persist() then
		self.state.hideouts[record.id] = record
		callback(false, "Could not save hideout deletion.")
		return
	end
	self:ReleaseSquadHome(record, function(ok)
		callback(ok, ok and "Hideout deleted." or "Hideout retired; its ownership claim could not be released.")
	end)
end

function PLUGIN:GetItemLocation(item)
	local location = item:GetData("cotzHideout")
	if istable(location) and location.schema == Schema.folder and location.map == game.GetMap() then
		return location
	end
end

function PLUGIN:GetEntityItem(entity)
	-- ix_item:GetItemTable returns the shared definition in this schema, not
	-- the persistent item instance. Resolve the actual Helix instance by ID.

	return IsValid(entity) and ix.item.instances[entity.ixItemID] or nil
end

function PLUGIN:MakeItemLocation(instance, entity)
	local physics = entity:GetPhysicsObject()
	local item = self:GetEntityItem(entity)
	local previous = item and self:GetItemLocation(item)

	return {
		schema = Schema.folder,
		map = game.GetMap(),
		id = instance.id,
		seed = previous and previous.seed or nil,
		pos = entity:GetPos() - instance.origin,
		angles = entity:GetAngles(),
		movable = IsValid(physics) and physics:IsMotionEnabled() or false,
	}
end

function PLUGIN:SeedItems(instance, callback)
	if not self:Persist() then
		callback(false, "Could not save initial item definitions.")

		return
	end
	local query = mysql:Select("ix_items")
	query:Where("inventory_id", 0)
	query:WhereLike("data", "\"cotzHideout\"")
	query:Callback(function(rows)
		if self.instances[instance.id] ~= instance or instance.state ~= "loading" then
			return
		end
		local existing = {}
		for _, row in ipairs(rows or {}) do
			local data = util.JSONToTable(row.data or "{}") or {}
			local location = data.cotzHideout
			if
				istable(location)
				and location.schema == Schema.folder
				and location.map == game.GetMap()
				and tostring(location.id) == instance.id
				and location.seed
			then
				existing[location.seed] = true
			end
		end
		self:SeedNextItem(
			instance,
			table.GetKeys(self:GetHideout(instance.id).seeds or {}),
			1,
			existing,
			callback
		)
	end)
	query:Execute()
end

function PLUGIN:SeedNextItem(instance, keys, index, existing, callback)
	if self.instances[instance.id] ~= instance or instance.state ~= "loading" then
		return
	end
	local record = self:GetHideout(instance.id)
	local key = keys[index]
	if not key then
		callback(self:Persist(), "Could not save item initialization.")

		return
	end
	local seed = record.seeds[key]
	if seed.initialized or existing[key] then
		seed.initialized = true
		self:SeedNextItem(instance, keys, index + 1, existing, callback)

		return
	end
	local data = table.Copy(seed.data)
	data.cotzHideout = {
		schema = Schema.folder,
		map = game.GetMap(),
		id = instance.id,
		seed = key,
		pos = seed.pos,
		angles = seed.angles,
		movable = seed.movable,
	}
	-- The location and seed key are inserted in the same authoritative row.
	-- If initialization is interrupted, the next load finds this row instead
	-- of creating another item. No players are admitted until flags are saved.
	ix.item.Instance(0, seed.uniqueID, data, 1, 1, function(item)
		if self.instances[instance.id] ~= instance or instance.state ~= "loading" then
			return
		end
		seed.initialized = true
		self:SeedNextItem(instance, keys, index + 1, existing, callback)
	end)
end

function PLUGIN:SaveFloorItem(instance, entity, callback)
	local item = self:GetEntityItem(entity)
	if not item or item.invID ~= 0 then
		if callback then
			callback(true)
		end

		return
	end
	local location = self:MakeItemLocation(instance, entity)
	-- SetData updates the shared Helix item data; the conditional write cannot
	-- turn an already-picked-up item back into a world item.
	item:SetData("cotzHideout", location, false, true)
	entity.bTemporary = true
	entity.ixHideout = instance.id
	instance.items[item:GetID()] = entity
	local data = util.TableToJSON(item.data)
	local query = mysql:Update("ix_items")
	query:Update("data", data)
	query:Where("item_id", item:GetID())
	query:Where("inventory_id", 0)
	query:Callback(function()
		if not callback then
			return
		end
		local verify = mysql:Select("ix_items")
		verify:Select("data")
		verify:Select("inventory_id")
		verify:Where("item_id", item:GetID())
		verify:Callback(function(rows)
			local row = istable(rows) and rows[1]
			callback(row ~= nil and tonumber(row.inventory_id) == 0 and row.data == data)
		end)
		verify:Execute()
	end)
	query:Execute()
end

function PLUGIN:RestoreFloorItems(instance, callback)
	local query = mysql:Select("ix_items")
	query:Where("inventory_id", 0)
	query:WhereLike("data", "\"cotzHideout\"")
	query:Callback(function(rows)
		if self.instances[instance.id] ~= instance or instance.state ~= "loading" then
			return
		end
		for _, row in ipairs(rows or {}) do
			local data = util.JSONToTable(row.data or "{}") or {}
			local location = data.cotzHideout
			if
				not istable(location)
				or location.schema ~= Schema.folder
				or location.map ~= game.GetMap()
				or tostring(location.id) ~= instance.id
			then
				continue
			end
			local itemID = tonumber(row.item_id)
			if
				not ix.item.list[row.unique_id]
				or not isvector(location.pos)
				or not isangle(location.angles)
			then
				callback(false, "An item has invalid saved data; its row has been retained.")

				return
			end
			local item = ix.item.instances[itemID] or ix.item.New(row.unique_id, itemID)
			if not item or item.invID ~= nil and item.invID ~= 0 then
				callback(false, "An item is already owned by another inventory.")

				return
			end
			if IsValid(item:GetEntity()) then
				callback(false, "An item already has a world entity.")

				return
			end
			item.data = data
			item.invID = 0
			item.characterID = tonumber(row.character_id)
			item.playerID = row.player_id ~= "NULL" and row.player_id ~= "" and row.player_id or nil
			ix.item.inventories[0][itemID] = item
			if self.ShouldQueuePersonalFloorItem and self:ShouldQueuePersonalFloorItem(instance) then
				instance.queuedItems = instance.queuedItems or {}
				instance.queuedItems[itemID] = true
				continue
			end
			local entity = item:Spawn(instance.origin + location.pos, location.angles)
			if not IsValid(entity) then
				callback(false, "Could not restore a hideout item.")

				return
			end
			entity.bTemporary = true
			entity.ixHideout = instance.id
			instance.items[itemID] = entity
			local physics = entity:GetPhysicsObject()
			if IsValid(physics) then
				physics:EnableMotion(location.movable == true)
			end
		end
		callback(true)
	end)
	query:Execute()
end

function PLUGIN:DetachFloorItems(instance)
	for id in pairs(instance.queuedItems or {}) do
		local item = ix.item.instances[id]
		if item and item.invID == 0 then
			ix.item.inventories[0][id] = nil
			ix.item.instances[id] = nil
		end
	end
	instance.queuedItems = nil
	for id, entity in pairs(instance.items) do
		local item = ix.item.instances[id]
		if item and item.invID == 0 and IsValid(entity) then
			entity.ixIsSafe = true
			entity:Remove()
			ix.item.inventories[0][id] = nil
			ix.item.instances[id] = nil
		end
	end
	instance.items = {}
end

function PLUGIN:SerializeProp(entity, origin)
	local physics = entity:GetPhysicsObject()
	local data = {
		class = entity:GetClass(),
		placedBy = entity.cotzPlacedBy,
		model = entity:GetModel(),
		pos = entity:GetPos() - origin,
		angles = entity:GetAngles(),
		skin = entity:GetSkin(),
		color = entity:GetColor(),
		material = entity:GetMaterial(),
		movable = IsValid(physics) and physics:IsMotionEnabled() or false,
		bodygroups = {},
		submaterials = {},
	}
	for _, group in ipairs(entity:GetBodyGroups()) do
		data.bodygroups[tostring(group.id)] = entity:GetBodygroup(group.id)
	end
	for index in ipairs(entity:GetMaterials()) do
		local material = entity:GetSubMaterial(index - 1)
		if material ~= "" then
			data.submaterials[tostring(index - 1)] = material
		end
	end

	return data
end

function PLUGIN:ApplyPropData(entity, data, origin)
	entity.cotzPlacedBy = data.placedBy
	entity:SetPos(origin + data.pos)
	entity:SetAngles(data.angles)
	entity:SetSkin(data.skin or 0)
	entity:SetColor(data.color or color_white)
	entity:SetMaterial(data.material or "")
	for id, value in pairs(data.bodygroups or {}) do
		entity:SetBodygroup(tonumber(id), value)
	end
	for id, value in pairs(data.submaterials or {}) do
		entity:SetSubMaterial(tonumber(id), value)
	end
	local physics = entity:GetPhysicsObject()
	if IsValid(physics) then
		physics:EnableMotion(data.movable == true)
	end
end

function PLUGIN:SaveInstance(instance, callback)
	if (instance.operations or 0) > 0 then
		if callback then callback(false) end
		return
	end
	if self.AuditVendor then self:AuditVendor(instance) end
	if self.AuditContainers and not instance.saving then self:AuditContainers(instance) end
	if instance.saving then
		if callback then
			callback(false)
		end

		return
	end
	instance.saving = true
	instance.saveStarted = CurTime()
	local record = self:GetHideout(instance.id)
	local furnishings = {}
	for entity in pairs(instance.props) do
		if IsValid(entity) then
			furnishings[#furnishings + 1] = self:SerializeProp(entity, instance.origin)
		end
	end
	record.furnishings = furnishings
	for key, entity in pairs(instance.shell) do
		record.shell[key] = IsValid(entity) and self:SerializeProp(entity, instance.origin) or false
	end
	if not self:Persist() then
		instance.saving = false
		if callback then
			callback(false)
		end

		return
	end
	local pending, complete = 0, true
	local entities = {}
	for _, entity in pairs(instance.items) do
		local item = self:GetEntityItem(entity)
		if item and item.invID == 0 then
			entities[#entities + 1] = entity
		end
	end
	pending = #entities
	if pending == 0 then
		instance.saving = false
		if callback then
			callback(true)
		end

		return
	end
	for _, entity in ipairs(entities) do
		self:SaveFloorItem(instance, entity, function(ok)
			complete = complete and ok
			pending = pending - 1
			if pending == 0 then
				instance.saving = false
				if callback then
					callback(complete)
				end
			end
		end)
	end
end
