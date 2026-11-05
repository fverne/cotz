local PLUGIN = PLUGIN
local STORAGE_DISTANCE_SQUARED = 128 * 128
local MENU_COOLDOWN = 1
local STORAGE_COOLDOWN = 1
local AUDIT_INTERVAL = 1
local MAX_PROP_COUNT = 64
local MAX_HIDEOUT_ID_LENGTH = 20

function PLUGIN:PostLoadData()
	self:SpawnEntrances()
end

function PLUGIN:SpawnEntrances()
	if not self.ready then
		return
	end
	self.entranceEntities = self.entranceEntities or {}
	for _, entity in pairs(self.entranceEntities) do
		if IsValid(entity) then
			entity:Remove()
		end
	end
	self.entranceEntities = {}
	for id, definition in pairs(self.state.entrances) do
		local entity = ents.Create("ix_hideout_entrance")
		if not IsValid(entity) then
			continue
		end
		entity:SetPos(definition.pos)
		entity:SetAngles(definition.angles)
		entity:SetModel("models/props_lab/keypad.mdl")
		entity.ixEntranceID = id
		entity:Spawn()
		if definition.invisible then entity:SetNoDraw(true) end
		self.entranceEntities[id] = entity
	end
end

function PLUGIN:ShowEntrance(client, entranceID)
	if not client:GetCharacter() or not self:IsNearEntrance(client, entranceID) then
		return
	end
	if (client.ixHideoutMenuTime or 0) > CurTime() then
		return
	end
	client.ixHideoutMenuTime = CurTime() + MENU_COOLDOWN
	local records = {}
	for _, record in pairs(self.state.hideouts) do
		if record.entrance == entranceID and self:CanAccess(client, record) then
			records[#records + 1] = {id = record.id, name = record.name, manage = self:CanManageHideout(client, record)}
		end
	end
	netstream.Start(client, "ixHideoutMenu", entranceID, records)
end

function PLUGIN:OpenLegacyStorage(client, id)
	local instance = self.instances[id]
	if
		not instance
		or self.members[client] ~= id
		or instance.state ~= "active"
		or instance.saving
		or not instance.inventory
		or client:GetPos():DistToSqr(instance.storage:GetPos()) > STORAGE_DISTANCE_SQUARED
	then
		return false, "Stand near the storage in that loaded hideout."
	end
	ix.storage.Open(
		client,
		instance.inventory,
		{ entity = instance.storage, name = "Former Hideout Storage", searchTime = 0 }
	)

	return true
end

function PLUGIN:GetStorageHideout(inventory)
	if not inventory then
		return
	end
	if inventory.vars and inventory.vars.hideout then
		return inventory.vars.hideout
	end
	local entity = inventory.storageInfo and inventory.storageInfo.entity

	return IsValid(entity) and entity.ixHideout or nil
end

function PLUGIN:ShouldSaveWorldItem(entity)
	if entity.ixHideout then
		return false
	end
	local item = self:GetEntityItem(entity)
	local location = item and self:GetItemLocation(item)
	if location then
		return false
	end
end

function PLUGIN:ShouldRestoreWorldItem(data)
	if istable(data.cotzHideout) then
		return false
	end
end

function PLUGIN:OnItemSpawned(entity)
	-- Helix calls this after SetItem and SetPos, so dropped items can be claimed
	-- before a later periodic scan or world save sees them.
	local instance = self:FindInstance(entity:GetPos())
	if instance then
		if instance.state == "active" then
			self:SaveFloorItem(instance, entity)
		elseif instance.state == "loading" then
			entity.bTemporary = true
			entity.ixHideout = instance.id
			instance.items[entity.ixItemID] = entity
		end
	end
end

function PLUGIN:OnEntityCreated(entity)
	-- Creation fires before SetPos/owner setup. Inspect the finished entity on
	-- the next tick, keeping player-owned weapons out of instance cleanup.
	timer.Simple(0, function()
		self:TrackRuntimeEntity(entity)
	end)
end

function PLUGIN:TrackRuntimeEntity(entity)
	if not IsValid(entity) or entity.ixHideout or entity:IsPlayer() or entity:GetClass() == "ix_item" then
		return
	end
	local owner = entity.GetOwner and entity:GetOwner()
	local parent = entity.GetParent and entity:GetParent()
	if IsValid(owner) and owner:IsPlayer() or IsValid(parent) and parent:IsPlayer() then
		return
	end
	local instance = self:FindInstance(entity:GetPos())
	if instance and (instance.state == "active" or instance.state == "loading") then
		self:TagEntity(instance, entity)
	end
end

function PLUGIN:PrepareHideoutItemTransfer(item, oldInventory, inventory)
	-- The caller writes this data together with inventory_id in one UPDATE.
	local location = self:GetItemLocation(item)
	if location and inventory and inventory:GetID() > 0 then
		local instance = self.instances[tostring(location.id)]
		local entity = instance and instance.items[item:GetID()]
		if instance then
			instance.items[item:GetID()] = nil
		end
		if IsValid(entity) then
			entity.ixHideout = nil
			entity.bTemporary = nil
		end
		item:SetData("cotzHideout", nil, false, true)

		return true
	end
end

function PLUGIN:PrepareHideoutItemDrop(item, client)
	local instance = IsValid(client) and self.instances[self.members[client]]
	if instance then
		item:SetData("cotzHideout", {
			schema = Schema.folder,
			map = game.GetMap(),
			id = instance.id,
			pos = client:GetPos() - instance.origin,
			angles = angle_zero,
			movable = true,
		}, false, true)

		return true
	elseif item:GetData("cotzHideout") then
		item:SetData("cotzHideout", nil, false, true)

		return true
	end
end

function PLUGIN:CanTransferHideoutItem(item, current, target, client)
	client = client or item.player or current and current.GetOwner and current:GetOwner()
	local memberInstance = IsValid(client) and self.instances[self.members[client]]
	if memberInstance and (memberInstance.state ~= "active" or memberInstance.saving) then
		return false
	end
	local location = self:GetItemLocation(item)
	local id = location and item.invID == 0 and tostring(location.id) or nil
	local currentID, targetID = self:GetStorageHideout(current), self:GetStorageHideout(target)
	local storageID = currentID or targetID
	if currentID and targetID and currentID ~= targetID then
		return false
	end
	local instance = self.instances[storageID or id]
	if (id or storageID) and (not instance or instance.state ~= "active" or instance.saving) then
		return false
	end
	if id and (not IsValid(client) or self.members[client] ~= instance.id) then
		return false
	end
	if storageID and instance then
		-- Helix also checks inventory receivers; this rejects stale storage
		-- operations after exit and operations outside the storage radius.
		if
			not IsValid(client)
			or self.members[client] ~= instance.id
			or not IsValid(instance.storage)
			or client:GetPos():DistToSqr(instance.storage:GetPos()) > STORAGE_DISTANCE_SQUARED
		then
			return false
		end
	end
end

function PLUGIN:OnItemActionCompleted(client, action, item, entity)
	-- Helix safely removes world entities after successful actions. A consumed
	-- floor item must also lose its row, otherwise it would return on reload.
	local location = self:GetItemLocation(item)
	if not location or item.invID ~= 0 or not IsValid(entity) then
		return
	end
	local instance = self.instances[tostring(location.id)]
	if instance then
		instance.items[item:GetID()] = nil
	end
	local query = mysql:Delete("ix_items")
	query:Where("item_id", item:GetID())
	query:Where("inventory_id", 0)
	query:Execute()
	ix.item.inventories[0][item:GetID()] = nil
	ix.item.instances[item:GetID()] = nil
end

function PLUGIN:CanPlayerInteractItem(client, action, value)
	local item = isentity(value) and self:GetEntityItem(value)
		or isnumber(value) and ix.item.instances[value]
		or value
	local membership = self.members[client]
	local memberInstance = membership and self.instances[membership]
	if memberInstance and (memberInstance.state ~= "active" or memberInstance.saving) then
		return false
	end
	if not istable(item) or not item.GetData then
		return
	end
	local location = self:GetItemLocation(item)
	if location and item.invID == 0 then
		local instance = self.instances[tostring(location.id)]
		if not instance or instance.state ~= "active" or instance.saving or membership ~= instance.id then
			return false
		end
	end
end

function PLUGIN:CanPlayerUseCharacter(client, character)
	if character and self.IsCharacterOperationPending and self:IsCharacterOperationPending(character) then
		return false, "Wait for your pending storage or shop operation to finish."
	end
	if character and character.cotzHideoutStale then
		if (client.cotzHideoutReloadAt or 0) <= CurTime() then
			client.cotzHideoutReloadAt = CurTime() + 2
			ix.char.Restore(client, function()
				local restored = ix.char.loaded[character:GetID()]
				if IsValid(client) and restored then restored:Sync(client) end
			end, true, character:GetID())
		end
		return false, "Your character state is being refreshed. Select the character again shortly."
	end
	if client.cotzHideoutOperation then return false, "Wait for the storage or shop operation to finish." end
	if client.ixHideoutPending then
		return false, "Wait for hideout entry to finish."
	end
	local instance = self.instances[self.members[client]]
	if instance and instance.saving then
		return false, "Wait for the hideout save to finish."
	end
end

function PLUGIN:PrePlayerLoadedCharacter(client)
	client.ixHideoutPending = nil
	if self.members[client] then
		self:LeaveHideout(client, false, true)
	end
end

function PLUGIN:PlayerLoadedCharacter(client, character)
	local saved = character:GetData("hideoutReturn")
	if saved then
		local position = self:GetOutsidePosition(client, saved)
		if position then
			-- Spawn Saver reads this value on its deferred load callback.
			character:SetData("pos", { position, saved[2] or angle_zero, game.GetMap() })
			character:SetData("hideoutReturn", nil)
		end
	end
end

function PLUGIN:PlayerDisconnected(client)
	client.ixHideoutPending = nil
	if self.members[client] then
		self:LeaveHideout(client, false, true)
	end
end

function PLUGIN:PreCharacterDeleted(client, character)
	for _, id in ipairs(table.GetKeys(self.state.hideouts)) do
		local record = self:GetHideout(id)
		if record.ownerType ~= "squad" and record.owner == character:GetID() then
			self:DeleteHideout(id, function(ok, reason)
				if not ok then
					ErrorNoHalt(
						"[Hideouts] Could not delete character hideout " .. id .. ": " .. reason .. "\n"
					)
				end
			end)
		elseif record.guests[tostring(character:GetID())] then
			record.guests[tostring(character:GetID())] = nil
		end
	end
	self:Persist()
end

function PLUGIN:PlayerSpawn(client)
	-- Handles a final respawn after the revive window. Reviving in place does
	-- not call this hook; downed bodies retain their membership.
	if client.ixHideoutReviving then
		return
	end
	local instance = self.instances[self.members[client]]
	if instance then
		timer.Simple(0, function()
			if
				IsValid(client)
				and self.instances[instance.id] == instance
				and self.members[client] == instance.id
			then
				self:LeaveHideout(client, true)
			end
		end)
	end
end

function PLUGIN:PlayerDeath(client)
	local instance = self.instances[self.members[client]]
	if not instance then
		return
	end
	local corpse = ix.temp and ix.temp.Corpses and ix.temp.Corpses[client] or client:GetRagdollEntity()
	if IsValid(corpse) then
		self:TagEntity(instance, corpse)
	end
end

function PLUGIN:PrePlayerRevived(client)
	client.ixHideoutReviving = true
	timer.Simple(0, function()
		if IsValid(client) then
			client.ixHideoutReviving = nil
		end
	end)
end

function PLUGIN:GetCharacterSavePosition(character)
	local client = character:GetPlayer()
	local instance = self.instances[self.members[client]]
	local occupant = instance and instance.occupants[client]
	if occupant and occupant.character == character:GetID() then
		return occupant.returnPoint
	end

	return character:GetData("hideoutReturn")
end

function PLUGIN:GetCharacterRestorePosition(client, character, saved)
	local returnPoint = character:GetData("hideoutReturn")
	local inArea = false
	for _, area in pairs(self.state and self.state.areas or {}) do
		if isvector(saved[1]) and self:Contains(saved[1], area.mins, area.maxs) then
			inArea = true
			break
		end
	end
	if not returnPoint and not inArea then
		return
	end
	local position = self:GetOutsidePosition(client, returnPoint)
	if not position then
		client:Notify("Your hideout return point is blocked; your normal spawn will be used.")

		return false
	end
	character:SetData("hideoutReturn", nil)

	return { position, returnPoint and returnPoint[2] or angle_zero, game.GetMap() }
end

function PLUGIN:PhysgunPickup(client, entity)
	if entity:GetClass():find("^ix_hideout_") then
		return false
	end
	if entity.ixHideout then
		local instance = self.instances[entity.ixHideout]
		if
			not instance
			or instance.state ~= "active"
			or instance.saving
			or self.members[client] ~= instance.id
		then
			return false
		end
		if not instance.props[entity] then
			return false
		end
	end
end

function PLUGIN:CanTool(client, trace)
	if IsValid(trace.Entity) and (trace.Entity.ixHideout or trace.Entity:GetClass():find("^ix_hideout_")) then
		return false
	end
end

function PLUGIN:CanProperty(client, property, entity)
	if entity.ixHideout or entity:GetClass():find("^ix_hideout_") then
		return false
	end
end

function PLUGIN:EntityTakeDamage(entity, damage)
	if self:ShouldBlockSafeZoneDamage(entity, damage) then
		damage:SetDamage(0)

		return true
	end
	local instance = entity.ixHideout and self.instances[entity.ixHideout]
	if not instance then
		return
	end
	local class = entity:GetClass()
	if
		instance.state ~= "active"
		or instance.saving
		or class:find("^ix_hideout_")
		or self.allowedShellClasses[class] and not instance.props[entity]
	then
		damage:SetDamage(0)

		return true
	end
end

function PLUGIN:ShouldBlockSafeZoneDamage(entity, damage)
	if
		self:IsPlayerInSafeZone(entity)
		or self:IsPlayerInSafeZone(damage:GetAttacker())
		or self:IsPlayerInSafeZone(damage:GetInflictor())
	then
		return true
	end
end

function PLUGIN:IsPlayerInSafeZone(entity)
	if not IsValid(entity) then
		return
	end
	local instance = self:FindInstance(entity:GetPos())
	if instance and instance.state ~= "unloaded" then
		return true
	end
end

function PLUGIN:PlayerSpawnProp(client, model)
	local instance = self.instances[self.members[client]]
	if
		instance
		and (instance.state ~= "active" or instance.saving or table.Count(instance.props) >= MAX_PROP_COUNT)
	then
		return false
	end
	if instance and ix.container and ix.container.stored[model:lower()] then
		return false
	end
end

function PLUGIN:PlayerSpawnedProp(client, model, entity)
	local instance = self.instances[self.members[client]]
	if not instance or not IsValid(entity) then
		return
	end
	if
		instance.state ~= "active"
		or instance.saving
		or not self:Contains(entity:GetPos(), instance.mins, instance.maxs)
	then
		entity:Remove()

		return
	end
	local mins, maxs = entity:WorldSpaceAABB()
	if
		not self:Contains(mins, instance.mins, instance.maxs)
		or not self:Contains(maxs, instance.mins, instance.maxs)
	then
		entity:Remove()

		return
	end
	-- Registered container models would be converted into destructive generic
	-- containers by Helix. Use the dedicated hideout storage instead.
	if ix.container and ix.container.stored[model:lower()] then
		entity:Remove()

		return
	end
	instance.props[entity] = true
	self:TagEntity(instance, entity)
end

function PLUGIN:PlayerSpawnSENT(client)
	if IsValid(client) and self.members[client] then
		return false
	end
end

function PLUGIN:PlayerSpawnVehicle(client)
	if self.members[client] then
		return false
	end
end

function PLUGIN:PlayerSpawnNPC(client)
	if self.members[client] then
		return false
	end
end

function PLUGIN:PlayerSpawnRagdoll(client)
	if IsValid(client) and self.members[client] then
		return false
	end
end

function PLUGIN:PlayerSpawnEffect(client)
	if self.members[client] then
		return false
	end
end

function PLUGIN:PreCleanupMap()
	self:EvacuateAll()
	-- Cleanup cannot wait for asynchronous database callbacks. Preserve item
	-- rows immediately; each row remains the sole restorable representation.
	for _, id in ipairs(table.GetKeys(self.instances)) do
		local instance = self.instances[id]
		if not instance.saving and instance.state ~= "loading" then
			self:SaveInstance(instance)
		end
		self:RemoveInstance(instance)
	end
end

function PLUGIN:EvacuateAll()
	for client in pairs(self.members) do
		if IsValid(client) then
			self:LeaveHideout(client, true)
		end
	end
	for _, instance in pairs(self.instances) do
		if instance.state == "loading" then
			self:FailLoad(instance, "Hideout loading was canceled by map cleanup.")
		end
	end
end

function PLUGIN:ShutDown()
	self:SaveData()
end

function PLUGIN:SaveData()
	if not self.ready then
		return
	end
	for _, instance in pairs(self.instances) do
		if instance.state == "active" and not instance.saving then
			self:SaveInstance(instance)
		end
	end
	self:Persist()
end

local function auditPendingEntries(self, instance)
	for client, pending in pairs(instance.pending) do
		if not IsValid(client) or CurTime() - pending.time > ix.config.Get("hideoutLoadTimeout", 30) then
			instance.pending[client] = nil
			if IsValid(client) then
				client.ixHideoutPending = nil
				client:Notify("Hideout entry timed out.")
			end
		end
	end
end

local function auditInstanceEntities(self, instance)
	for _, entity in ipairs(ents.FindInBox(instance.mins, instance.maxs)) do
		if
			entity:IsPlayer()
			and entity:Alive()
			and self.members[entity] ~= instance.id
			and not instance.pending[entity]
		then
			local position = self:GetOutsidePosition(entity, nil, self:GetHideout(instance.id))
			if position then
				entity:SetPos(position)
			end
		elseif entity:GetClass() == "ix_item" and not entity.ixHideout then
			self:SaveFloorItem(instance, entity)
		end
	end
	for entity in pairs(instance.props) do
		if IsValid(entity) and not self:Contains(entity:GetPos(), instance.mins, instance.maxs) then
			entity:SetPos(instance.origin + self:GetTemplate(self:GetHideout(instance.id)).storage)
		end
	end
	for _, entity in pairs(instance.items) do
		if IsValid(entity) and not self:Contains(entity:GetPos(), instance.mins, instance.maxs) then
			entity:SetPos(instance.origin + self:GetTemplate(self:GetHideout(instance.id)).storage)
		end
	end
end

local function auditInstance(self, instance)
	auditPendingEntries(self, instance)

	if
		instance.state == "loading"
		and CurTime() - instance.created > ix.config.Get("hideoutLoadTimeout", 30)
	then
		self:FailLoad(instance, "Hideout loading timed out. Saved items have been retained.")

		return
	end
	if
		instance.saving
		and instance.state ~= "failed"
		and CurTime() - (instance.saveStarted or instance.created)
			> ix.config.Get("hideoutLoadTimeout", 30)
	then
		instance.state = "failed"
		ErrorNoHalt("[Hideouts] Save timed out; instance retained: " .. instance.id .. "\n")
	end
	if instance.state ~= "active" then
		return
	end
	if table.IsEmpty(instance.occupants) and table.IsEmpty(instance.pending) then
		self:UnloadInstance(instance)

		return
	end
	auditInstanceEntities(self, instance)

	if instance.unloadRequested and not instance.saving then
		instance.unloadRequested = nil
		self:UnloadInstance(instance)
	elseif not instance.saving and (instance.nextCheckpoint or 0) < CurTime() then
		instance.nextCheckpoint = CurTime() + ix.config.Get("hideoutCheckpoint", 30)
		self:SaveInstance(instance)
	end
end

function PLUGIN:Think()
	if not self.ready or (self.nextAudit or 0) > CurTime() then
		return
	end
	self.nextAudit = CurTime() + AUDIT_INTERVAL
	for client, id in pairs(self.members) do
		local instance = self.instances[id]
		local occupant = instance and instance.occupants[client]
		local character = IsValid(client) and client:GetCharacter()
		if not character or not occupant or occupant.character ~= character:GetID() then
			if instance then
				self:LeaveHideout(client, false)
			else
				self.members[client] = nil
			end
		elseif client:Alive() and not self:Contains(client:GetPos(), instance.mins, instance.maxs) then
			self:LeaveHideout(client, false)
		end
	end
	for _, instance in pairs(self.instances) do
		auditInstance(self, instance)
	end
end

netstream.Hook("ixHideoutEnter", function(client, id)
	if not isstring(id) or #id > MAX_HIDEOUT_ID_LENGTH then
		return
	end
	local ok, err = PLUGIN:RequestEntry(client, id)
	if not ok then
		client:Notify(err)
	end
end)
