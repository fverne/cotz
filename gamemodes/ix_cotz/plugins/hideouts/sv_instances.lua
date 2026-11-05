local PLUGIN = PLUGIN

local MAX_ALLOCATION_CHECKS = 4096
local BOUNDS_INSET = Vector(1, 1, 1)
local FLOOR_TRACE_OFFSET = Vector(0, 0, 80)
local MIN_FLOOR_NORMAL = 0.5
local UTILITY_FLOOR_CLEARANCE = 2
local ENTRANCE_DISTANCE_SQUARED = 160 * 160
local ENTRY_COOLDOWN = 2
local LEGACY_STORAGE_WIDTH = 8
local LEGACY_STORAGE_HEIGHT = 6
local RETURN_OFFSETS = { Vector(64, 0, 8), Vector(-64, 0, 8) }

function PLUGIN:Contains(position, mins, maxs)
	return position.x >= mins.x
		and position.y >= mins.y
		and position.z >= mins.z
		and position.x <= maxs.x
		and position.y <= maxs.y
		and position.z <= maxs.z
end

function PLUGIN:Overlaps(aMin, aMax, bMin, bMax)
	return aMin.x < bMax.x
		and aMax.x > bMin.x
		and aMin.y < bMax.y
		and aMax.y > bMin.y
		and aMin.z < bMax.z
		and aMax.z > bMin.z
end

function PLUGIN:FindInstance(position)
	for _, instance in pairs(self.instances) do
		if self:Contains(position, instance.mins, instance.maxs) then
			return instance
		end
	end
end

function PLUGIN:SetTemplatePoint(client, id, point, x, y, z)
	local template = self.state.templates[id]
	if not template then
		return false, "Unknown template."
	end
	if point ~= "spawn" and point ~= "exit" and point ~= "storage" and point ~= "vendor" then
		return false, "Point must be spawn, exit, storage, or vendor."
	end
	local standing = x == nil and y == nil and z == nil
	if not standing and (x == nil or y == nil or z == nil) then
		return false, "Omit all coordinates to use your position, or provide x, y and z."
	end
	local position, facing
	if standing then
		local instance = self:FindInstance(client:GetPos())
		local record = instance and self:GetHideout(instance.id)
		if not record or record.template ~= id then
			return false, "Stand inside a loaded hideout using template " .. id .. "."
		end
		position = client:GetPos() - instance.origin
		if point == "spawn" then
			facing = Angle(0, client:EyeAngles().y, 0)
		else
			local entity = instance[point]
			if IsValid(entity) then
				-- Feet mark the floor; lift centered utility models clear of it.
				position.z = position.z + math.max(0, -entity:OBBMins().z) + UTILITY_FLOOR_CLEARANCE
			end
		end
	else
		position = Vector(x, y, z)
	end
	if not self:Contains(position, template.mins, template.maxs) then
		return false, "The point must be within the template bounds."
	end
	local affected = {}
	for _, instance in pairs(self.instances) do
		local record = self:GetHideout(instance.id)
		if record and record.template == id then
			local markerRoles = instance.template and instance.template.dupeMarkerRoles
			if markerRoles and markerRoles[point] then
				return false, "This point uses a dupe marker. Move it in the build, save the dupe and reload the hideout."
			end
			if instance.state ~= "active" or instance.saving then
				return false, "Wait for hideouts using this template to finish loading or saving."
			end
			affected[#affected + 1] = instance
		end
	end
	local previous = point == "spawn" and template.spawns or template[point]
	local previousFacing = template.facing
	if point == "spawn" then
		template.spawns = { position }
	else
		template[point] = position
	end
	if facing then
		template.facing = facing
	end
	if not self:Persist() then
		if point == "spawn" then
			template.spawns = previous
		else
			template[point] = previous
		end
		template.facing = previousFacing

		return false, "Could not save the template."
	end
	if point ~= "spawn" then
		for _, instance in ipairs(affected) do
			local entity = instance[point]
			if IsValid(entity) then
				entity:SetPos(instance.origin + position)
			end
		end
	end

	return true,
		"Updated "
			.. point
			.. " for template "
			.. id
			.. "."
			.. (
				point == "spawn" and " This applies to future entries."
				or " Loaded hideouts have been updated."
			)
end

local function isAllocationClear(instancePlugin, template, mins, maxs, clearance)
	for _, other in pairs(instancePlugin.instances) do
		if instancePlugin:Overlaps(mins, maxs, other.mins - clearance, other.maxs + clearance) then
			return false
		end
	end
	if not util.IsInWorld(mins + BOUNDS_INSET) or not util.IsInWorld(maxs - BOUNDS_INSET) then
		return false
	end

	-- World tests use brush geometry; entity clearance is checked separately.
	local origin = mins - template.mins
	local trace = util.TraceHull({
		start = origin,
		endpos = origin,
		mins = template.mins + BOUNDS_INSET,
		maxs = template.maxs - BOUNDS_INSET,
		mask = MASK_SOLID_BRUSHONLY,
	})
	if trace.StartSolid or trace.AllSolid or trace.Hit then
		return false
	end
	for _, entity in ipairs(ents.FindInBox(mins, maxs)) do
		-- Trigger brushes can have a solid type while their flags make them non-blocking.
		if IsValid(entity) and (entity:IsPlayer() or entity:IsSolid()) then
			return false
		end
	end

	return true
end

local function allocateInArea(instancePlugin, template, area, size, gap)
	local checks = 0
	local clearance = Vector(gap, gap, gap)
	for x = area.mins.x, area.maxs.x - size.x, size.x + gap do
		for y = area.mins.y, area.maxs.y - size.y, size.y + gap do
			checks = checks + 1
			if checks > MAX_ALLOCATION_CHECKS then
				break
			end

			local mins = Vector(x, y, area.mins.z)
			local maxs = mins + size
			if maxs.z > area.maxs.z then
				continue
			end
			if isAllocationClear(instancePlugin, template, mins, maxs, clearance) then
				return mins - template.mins, mins, maxs
			end
		end
	end
end

function PLUGIN:Allocate(template)
	local gap = ix.config.Get("hideoutGap", 512)
	local size = template.maxs - template.mins
	if size.x <= 0 or size.y <= 0 or size.z <= 0 then
		return nil, nil, nil, "The hideout template has invalid bounds."
	end
	if not self.state or table.IsEmpty(self.state.areas or {}) then
		return nil, nil, nil, "No hideout allocation area is configured on this map. "
			.. "An administrator must mark an empty map volume for hideouts."
	end
	local fitsArea = false
	for _, area in pairs(self.state.areas) do
		local available = area.maxs - area.mins
		if size.x <= available.x and size.y <= available.y and size.z <= available.z then
			fitsArea = true
			local origin, mins, maxs = allocateInArea(self, template, area, size, gap)
			if origin then return origin, mins, maxs end
		end
	end
	if not fitsArea then
		return nil, nil, nil, string.format(
			"No configured hideout area can fit this template. Required space: %g x %g x %g units.",
			size.x, size.y, size.z
		)
	end

	return nil, nil, nil, "No clear, unreserved hideout placement was found in the configured areas."
end

function PLUGIN:FindSafePosition(client, candidates)
	local mins, maxs = client:GetHull()
	for _, position in ipairs(candidates) do
		if not isvector(position) or not util.IsInWorld(position) then
			continue
		end
		local trace = util.TraceHull({
			start = position,
			endpos = position,
			mins = mins,
			maxs = maxs,
			filter = client,
			mask = MASK_PLAYERSOLID,
		})
		local floor = util.TraceHull({
			start = position,
			endpos = position - FLOOR_TRACE_OFFSET,
			mins = mins,
			maxs = maxs,
			filter = client,
			mask = MASK_PLAYERSOLID,
		})
		if
			not trace.StartSolid
			and not trace.AllSolid
			and not trace.Hit
			and floor.Hit
			and floor.HitNormal.z > MIN_FLOOR_NORMAL
		then
			return position
		end
	end
end

function PLUGIN:ValidateDupe(dupe, template)
	if table.Count(dupe.Entities) > ix.config.Get("hideoutEntityLimit", 256) then
		return false, "The template exceeds the entity limit."
	end
	for _, data in pairs(dupe.Entities) do
		if not self.allowedShellClasses[data.Class] and data.Class ~= "ix_dupedummyitem"
			and data.Class ~= "ix_hideout_marker" then
			return false, "Unsupported shell entity: " .. tostring(data.Class)
		end
	end
	if not isvector(dupe.HeadEnt.Pos) then
		return false, "The dupe has no paste anchor."
	end

	return true
end

function PLUGIN:TagEntity(instance, entity)
	entity.ixHideout = instance.id
	entity:SetNetVar("cotzHideoutID", instance.id)
	entity:SetNetVar("hideoutEditable", instance.props[entity] == true or entity:GetClass() == "ix_hideout_vendor")
	entity.bNoPersist = true
	instance.entities[entity] = true
	local record = self:GetHideout(instance.id)
	entity:SetNetVar("owner", record.owner)
	if entity.CPPISetOwner then
		local character = ix.char.loaded[record.owner]
		local owner = instance.props[entity] and character and character:GetPlayer()
		entity:CPPISetOwner(IsValid(owner) and owner or game.GetWorld())
	end
end

function PLUGIN:CreateUtility(instance, class, localPosition, model, localAngles)
	local entity = ents.Create(class)
	if not IsValid(entity) then
		return
	end
	entity:SetModel(model)
	entity:SetPos(instance.origin + localPosition)
	entity:SetAngles(localAngles or angle_zero)
	entity:Spawn()
	self:TagEntity(instance, entity)
	local physics = entity:GetPhysicsObject()
	if IsValid(physics) then
		physics:EnableMotion(false)
	end

	return entity
end

function PLUGIN:RestoreStorage(instance, callback)
	local record = self:GetHideout(instance.id)
	local function attach(inventory)
		if self.instances[instance.id] ~= instance or instance.state ~= "loading" then
			return
		end
		instance.inventory = inventory
		inventory.vars.hideout = instance.id
		callback(true)
	end
	if record.storageID then
		local inventory = ix.inventory.Get(record.storageID)
		if inventory then
			attach(inventory)
		else
			ix.inventory.Restore(record.storageID, LEGACY_STORAGE_WIDTH, LEGACY_STORAGE_HEIGHT, attach)
		end
	else
		-- New hideouts use each visitor's character bank. Retain an existing
		-- private inventory only to migrate/recover its old contents.
		callback(true)
	end
end

local function activateInstance(instancePlugin, instance)
	instance.state = "active"
	local callbacks = instance.callbacks
	instance.callbacks = {}
	for _, complete in ipairs(callbacks) do
		complete(true, instance)
	end
	if table.IsEmpty(instance.occupants) and table.IsEmpty(instance.pending) then
		instancePlugin:UnloadInstance(instance)
	end
end

local function restoreInstanceItems(instancePlugin, instance)
	instancePlugin:RestoreFloorItems(instance, function(ok, reason)
		if instancePlugin.instances[instance.id] ~= instance then
			return
		end
		if not ok then
			instancePlugin:FailLoad(instance, reason)

			return
		end

		activateInstance(instancePlugin, instance)
	end)
end

local function restoreInstanceContents(instancePlugin, instance)
	instancePlugin:RestoreStorage(instance, function(ok, reason)
		if instancePlugin.instances[instance.id] ~= instance then
			return
		end
		if not ok then
			instancePlugin:FailLoad(instance, reason)

			return
		end

		instancePlugin:SeedItems(instance, function(seedsOK, seedReason)
			if not seedsOK then
				instancePlugin:FailLoad(instance, seedReason)

				return
			end

			restoreInstanceItems(instancePlugin, instance)
		end)
	end)
end

local function captureSeed(record, key, entity, origin)
	record.seeds = record.seeds or {}
	if record.seeds[tostring(key)] then
		return true
	end

	local represented = entity:GetRepresentedItem()
	if not represented or not ix.item.list[represented[1]] then
		return false
	end

	record.seeds[tostring(key)] = {
		uniqueID = represented[1],
		data = table.Copy(represented[2] or {}),
		pos = entity:GetPos() - origin,
		angles = entity:GetAngles(),
		movable = entity:GetShouldUnfreeze(),
	}

	return true
end

function PLUGIN:SpawnInstance(record, callback)
	local template = self:GetTemplate(record)
	local dupePlugin = ix.plugin.Get("advdupeint")
	if not template or not dupePlugin then
		callback(false, "The hideout template or AdvDupe integration is unavailable.")

		return
	end
	local origin, mins, maxs, allocationReason = self:Allocate(template)
	if not origin then
		callback(false, allocationReason)

		return
	end
	local instance = {
		id = record.id,
		origin = origin,
		mins = mins,
		maxs = maxs,
		state = "loading",
		occupants = {},
		pending = {},
		entities = {},
		items = {},
		props = {},
		shell = {},
		created = CurTime(),
		callbacks = { callback },
	}
	instance.dupeID = "hideout:" .. record.id .. ":" .. SysTime()
	self.instances[record.id] = instance
	dupePlugin:SpawnDupe(template.dupe, instance.dupeID, nil, origin, {
		noItems = true,
		keepDummies = true,
		validate = function(dupe)
			return self:ValidateDupe(dupe, template)
		end,
	}, function(ok, entities, source)
		if self.instances[record.id] ~= instance then
			return
		end
		if not ok then
			self:FailLoad(instance, entities)

			return
		end
		for _, entity in pairs(entities) do
			if not IsValid(entity) then
				continue
			end
			self:TagEntity(instance, entity)
			local entMin, entMax = entity:WorldSpaceAABB()
			if
				entity:GetSolid() ~= SOLID_NONE
				and (not self:Contains(entMin, mins, maxs) or not self:Contains(entMax, mins, maxs))
			then
				self:FailLoad(instance, "The dupe extends outside its configured bounds.")

				return
			end
		end
		local resolved, markerReason = self:ResolveTemplateMarkers(instance, source or {}, template)
		if not resolved then
			self:FailLoad(instance, markerReason)

			return
		end
		instance.template = resolved
		for key, entity in pairs(source or {}) do
			if not IsValid(entity) then
				continue
			end
			if entity:GetClass() == "ix_dupedummyitem" then
				if not captureSeed(record, key, entity, origin) then
					self:FailLoad(instance, "An item dummy references an invalid item.")

					return
				end
				entity:Remove()
				continue
			end
			local saved = record.shell[tostring(key)]
			if saved == false then
				entity:Remove()
			elseif saved then
				self:ApplyPropData(entity, saved, origin)
			end
			instance.shell[tostring(key)] = entity
		end
		for _, data in ipairs(record.furnishings or {}) do
			if not self.allowedShellClasses[data.class] or not util.IsValidModel(data.model) then
				self:FailLoad(instance, "A saved furnishing is invalid.")

				return
			end
			local entity = ents.Create(data.class)
			if not IsValid(entity) then
				self:FailLoad(instance, "Could not create a furnishing.")

				return
			end
			entity:SetModel(data.model)
			entity:Spawn()
			self:ApplyPropData(entity, data, origin)
			instance.props[entity] = true
			self:TagEntity(instance, entity)
		end
		instance.exit = self:CreateUtility(
			instance,
			"ix_hideout_exit",
			resolved.exit,
			"models/props_c17/consolebox01a.mdl",
			resolved.exitAngles
		)
		local needsStorage = not resolved.dupeMarkerRoles or resolved.dupeMarkerRoles.storage or record.storageID
		if needsStorage then
			instance.storage = self:CreateUtility(
				instance,
				"ix_hideout_storage",
				resolved.storage,
				"models/props_junk/wood_crate001a.mdl",
				resolved.storageAngles
			)
		end
		if not IsValid(instance.exit) or needsStorage and not IsValid(instance.storage) then
			self:FailLoad(instance, "Could not create hideout utilities.")

			return
		end
		restoreInstanceContents(self, instance)
	end)
end

function PLUGIN:FailLoad(instance, reason)
	self:DetachFloorItems(instance)
	self:RemoveInstance(instance)
	for _, callback in ipairs(instance.callbacks or {}) do
		callback(false, reason or "Could not load hideout.")
	end
end

function PLUGIN:RemoveInstance(instance)
	instance.state = "unloaded"
	self:CloseStorage(instance)
	self:DetachFloorItems(instance)
	for entity in pairs(instance.entities) do
		if IsValid(entity) then
			entity:Remove()
		end
	end
	local dupePlugin = ix.plugin.Get("advdupeint")
	if dupePlugin then
		dupePlugin:DespawnDupe(instance.dupeID)
	end
	self.instances[instance.id] = nil
end

function PLUGIN:CloseStorage(instance, onlyClient)
	for id, inventory in pairs(instance.personalInventories or {}) do
		if inventory.storageInfo and inventory.storageInfo.entity == instance.storage then
			self:CloseInventoryStorage(inventory, onlyClient)
		end
		if not onlyClient then
			instance.personalInventories[id] = nil
		end
	end
	local inventory = instance.inventory
	if not inventory then
		return
	end
	self:CloseInventoryStorage(inventory, onlyClient)
end

function PLUGIN:CloseInventoryStorage(inventory, onlyClient)
	if onlyClient and not table.HasValue(inventory:GetReceivers(), onlyClient) then
		return
	end
	local receivers = onlyClient and { onlyClient } or inventory:GetReceivers()
	if #receivers > 0 and inventory.storageInfo then
		net.Start("ixStorageExpired")
		net.WriteUInt(inventory:GetID(), 32)
		net.Send(receivers)
	end
	for _, client in ipairs(receivers) do
		if IsValid(client) then
			ix.storage.RemoveReceiver(client, inventory)
		else
			inventory:RemoveReceiver(client)
		end
	end
	if onlyClient then
		return
	end
	if inventory.storageInfo then
		ix.storage.Close(inventory)
	end
end

function PLUGIN:UnloadInstance(instance)
	if (instance.operations or 0) > 0 then instance.unloadRequested = true return end
	if instance.state ~= "active" and instance.state ~= "failed" then
		return
	end
	if not table.IsEmpty(instance.occupants) or not table.IsEmpty(instance.pending) then
		return
	end
	if instance.saving then
		instance.unloadRequested = true

		return
	end
	instance.state = "saving"
	instance.created = CurTime()
	self:CloseStorage(instance)
	self:SaveInstance(instance, function(ok)
		if self.instances[instance.id] ~= instance then
			return
		end
		if ok then
			self:RemoveInstance(instance)
		else
			instance.state = "failed"
			ErrorNoHalt("[Hideouts] Save failed; retained instance " .. instance.id .. "\n")
		end
	end)
end

function PLUGIN:IsNearEntrance(client, entranceID)
	local entrance = self.state.entrances[entranceID]

	return entrance and client:GetPos():DistToSqr(entrance.pos) <= ENTRANCE_DISTANCE_SQUARED
end

function PLUGIN:RequestEntry(client, id)
	local record = self:GetHideout(id)
	if not self:CanAccess(client, record) then
		return false, "You cannot enter that hideout."
	end
	if not self:IsNearEntrance(client, record.entrance) then
		return false, "Move closer to the hideout entrance."
	end
	if
		not client:Alive()
		or client:InVehicle()
		or client:GetMoveType() == MOVETYPE_NOCLIP
		or client:GetLocalVar("inArena")
		or client.ixHideoutPending
	then
		return false, "You cannot enter a hideout right now."
	end
	if self.members[client] then
		return false, "Leave your current hideout first."
	end
	if (client.ixNextHideout or 0) > CurTime() then
		return false, "Please wait before entering again."
	end
	client.ixNextHideout = CurTime() + ENTRY_COOLDOWN
	local character = client:GetCharacter()
	local request = { character = character:GetID(), entrance = record.entrance }
	client.ixHideoutPending = request
	local function complete(ok, result)
		if not IsValid(client) or client.ixHideoutPending ~= request then
			return
		end
		if not ok then
			client.ixHideoutPending = nil
			client:Notify(result)

			return
		end
		self:AdmitPlayer(client, request, result)
	end
	local instance = self.instances[record.id]
	if instance then
		if instance.state == "loading" then
			instance.callbacks[#instance.callbacks + 1] = complete
		elseif instance.state == "active" and not instance.saving then
			complete(true, instance)
		else
			client.ixHideoutPending = nil

			return false, "The hideout is saving. Try again shortly."
		end
	else
		self:SpawnInstance(record, complete)
	end

	return true
end

function PLUGIN:AdmitPlayer(client, request, instance)
	local character = client:GetCharacter()
	local record = self:GetHideout(instance.id)
	if
		not character
		or character:GetID() ~= request.character
		or not client:Alive()
		or not self:CanAccess(client, record)
		or not self:IsNearEntrance(client, request.entrance)
		or self.members[client]
	then
		client.ixHideoutPending = nil

		return
	end
	local template = self:GetTemplate(record)
	local candidates = {}
	for _, offset in ipairs(template.spawns) do
		candidates[#candidates + 1] = instance.origin + offset
	end
	local destination = self:FindSafePosition(client, candidates)
	if not destination then
		client.ixHideoutPending = nil
		client:Notify("The hideout spawn is blocked.")

		return
	end
	local returnPoint = { client:GetPos(), client:EyeAngles(), game.GetMap() }
	instance.pending[client] = { request = request, time = CurTime() }
	character:SetData("hideoutReturn", returnPoint)
	character:Save(function()
		local pending = instance.pending[client]
		instance.pending[client] = nil
		if IsValid(client) and client.ixHideoutPending == request then
			client.ixHideoutPending = nil
		end
		if
			not pending
			or self.instances[instance.id] ~= instance
			or instance.state ~= "active"
			or instance.saving
			or not IsValid(client)
			or client:GetCharacter() ~= character
			or not client:Alive()
			or not self:IsNearEntrance(client, request.entrance)
			or not self:CanAccess(client, record)
		then
			if table.IsEmpty(instance.pending) and table.IsEmpty(instance.occupants) then
				self:UnloadInstance(instance)
			end

			return
		end
		-- Recheck after the asynchronous save; another entrant may occupy this spawn.
		local safe = self:FindSafePosition(client, candidates)
		if not safe then
			client:Notify("The hideout spawn is blocked.")
			self:UnloadInstance(instance)

			return
		end
		instance.occupants[client] = { character = character:GetID(), returnPoint = returnPoint }
		self.members[client] = instance.id
		client:SetLocalVar("hideout", instance.id)
		client:SetPos(safe)
		client:SetEyeAngles(self:GetSpawnFacing(instance, safe))
		local regeneration = ix.plugin.Get("passiveregeneration")
		if regeneration then
			regeneration:RegeneratePlayer(client, true)
		end
	end)
end

function PLUGIN:GetOutsidePosition(client, returnPoint, record)
	local candidates = {}
	if returnPoint and returnPoint[3] == game.GetMap() then
		candidates[#candidates + 1] = returnPoint[1]
	end
	local entrance = record and self.state.entrances[record.entrance]
	if entrance then
		candidates[#candidates + 1] = entrance.outside
		for _, offset in ipairs(RETURN_OFFSETS) do
			candidates[#candidates + 1] = entrance.pos + offset
		end
	end
	if self.state.recovery then
		candidates[#candidates + 1] = self.state.recovery
	end

	return self:FindSafePosition(client, candidates)
end

function PLUGIN:LeaveHideout(client, teleport, preserveReturn)
	local instance = self.instances[self.members[client]]
	if not instance then
		return false, "You are not inside a hideout."
	end
	local occupant = instance.occupants[client]
	if teleport then
		local position = self:GetOutsidePosition(client, occupant.returnPoint, self:GetHideout(instance.id))
		if not position then
			return false, "The return position is blocked. Contact an administrator."
		end
		client:SetPos(position)
		client:SetEyeAngles(occupant.returnPoint[2] or angle_zero)
	end
	instance.occupants[client] = nil
	instance.pending[client] = nil
	self.members[client] = nil
	if IsValid(client) then
		client:SetLocalVar("hideout", nil)
		self:CloseStorage(instance, client)
		local character = client:GetCharacter()
		if not preserveReturn and character and character:GetID() == occupant.character then
			character:SetData("hideoutReturn", nil)
			character:Save()
		end
	end
	self:UnloadInstance(instance)

	return true
end
