local PLUGIN = PLUGIN
local DUPE_NAME_PATTERN = "^[%w_%-]+$"
PLUGIN.name = "AdvDupe2 integration"
PLUGIN.author = "gumlefar"
PLUGIN.description = "Server-owned AdvDupe2 instances."

if SERVER then
	ix.AdvDupeIntegration = ix.AdvDupeIntegration or {}
	ix.AdvDupeIntegration.CreatedEntities = ix.AdvDupeIntegration.CreatedEntities or {}
	PLUGIN.operations = PLUGIN.operations or {}

	local function trackEntity(operation, entity)
		if operation.entityLookup[entity] then
			return
		end

		operation.entityLookup[entity] = true
		operation.entities[#operation.entities + 1] = entity
	end

	local function freezeEntity(entity)
		for index = 0, entity:GetPhysicsObjectCount() - 1 do
			local physics = entity:GetPhysicsObjectNum(index)
			if IsValid(physics) then
				physics:EnableMotion(false)
			end
		end
		if entity.CPPISetOwner then
			entity:CPPISetOwner(game.GetWorld())
		end
	end

	function PLUGIN:ReadDupe(name)
		if not AdvDupe2 or not AdvDupe2.duplicator then
			return nil, "AdvDupe2 is unavailable."
		end
		if not isstring(name) or not name:match(DUPE_NAME_PATTERN) then
			return nil, "Invalid dupe filename."
		end
		local contents = file.Read(AdvDupe2.DataFolder .. "/STALKERDupes/" .. name .. ".txt", "DATA")
		if not contents then
			return nil, "Dupe file not found: " .. name
		end
		local ok, success, dupe = pcall(AdvDupe2.Decode, contents)
		if not ok then
			ErrorNoHalt("[AdvDupe2] Decode failed: " .. tostring(success) .. "\n")
		end
		if
			not ok
			or not success
			or not istable(dupe)
			or not istable(dupe.Entities)
			or not istable(dupe.HeadEnt)
		then
			return nil, "Could not decode dupe: " .. name
		end

		return dupe
	end

	-- Optional options/callback arguments preserve event/arena callers.
	function PLUGIN:SpawnDupe(name, uniqueID, offset, position, options, callback)
		uniqueID = uniqueID or name
		options = options or {}
		if ix.AdvDupeIntegration.CreatedEntities[uniqueID] then
			if callback then
				callback(false, "That dupe instance already exists.")
			end

			return false, "That dupe instance already exists."
		end
		local dupe, err = self:ReadDupe(name)
		if not dupe then
			if callback then
				callback(false, err)
			end

			return false, err
		end
		if options.validate then
			local valid, reason = options.validate(dupe)
			if not valid then
				if callback then
					callback(false, reason)
				end

				return false, reason
			end
		end
		local operation = { entities = {}, entityLookup = {}, pending = 0, callback = callback }
		self.operations[uniqueID] = operation
		ix.AdvDupeIntegration.CreatedEntities[uniqueID] = operation.entities
		local target = (position or dupe.HeadEnt.Pos or vector_origin) + (offset or vector_origin)
		-- Capture entities created by callbacks, including partial pastes that throw.
		self.pasteCapture = operation
		local ok, entities, constraints = pcall(
			AdvDupe2.duplicator.Paste,
			nil,
			dupe.Entities,
			dupe.Constraints or {},
			nil,
			nil,
			target,
			true
		)
		self.pasteCapture = nil
		if not ok then
			ErrorNoHalt("[AdvDupe2] Paste failed: " .. tostring(entities) .. "\n")
		end
		if not ok or not istable(entities) then
			self:DespawnDupe(uniqueID)
			if callback then
				callback(false, "AdvDupe2 paste failed: " .. tostring(entities))
			end

			return false, "AdvDupe2 paste failed."
		end
		operation.source = entities
		for _, entity in pairs(entities) do
			if not IsValid(entity) then
				continue
			end

			trackEntity(operation, entity)
			freezeEntity(entity)
		end
		for _, entity in pairs(istable(constraints) and constraints or {}) do
			if IsValid(entity) then
				trackEntity(operation, entity)
			end
		end
		if options.noItems then
			for _, entity in pairs(entities) do
				if
					not options.keepDummies
					and IsValid(entity)
					and entity:GetClass() == "ix_dupedummyitem"
				then
					entity:Remove()
				end
			end
			self:CompleteDupe(uniqueID, operation)
		else
			self:ItemDummiesToItems(entities, uniqueID, operation)
		end

		return true, operation.entities
	end

	function PLUGIN:CompleteDupe(uniqueID, operation)
		if self.operations[uniqueID] ~= operation or operation.pending > 0 then
			return
		end
		if operation.callback then
			local callback = operation.callback
			operation.callback = nil
			callback(true, operation.entities, operation.source)
		end
	end

	function PLUGIN:OnEntityCreated(entity)
		if self.pasteCapture then
			trackEntity(self.pasteCapture, entity)
		end
	end

	function PLUGIN:PostCleanupMap()
		for _, uniqueID in ipairs(table.GetKeys(ix.AdvDupeIntegration.CreatedEntities)) do
			self:DespawnDupe(uniqueID)
		end
	end

	function PLUGIN:DespawnDupe(uniqueID)
		local entities = ix.AdvDupeIntegration.CreatedEntities[uniqueID]
		self.operations[uniqueID] = nil
		ix.AdvDupeIntegration.CreatedEntities[uniqueID] = nil
		for _, entity in pairs(entities or {}) do
			if IsValid(entity) then
				entity:Remove()
			end
		end
	end

	local function finishDummyItem(dupePlugin, uniqueID, operation, movable, item, entity)
		if operation and dupePlugin.operations[uniqueID] ~= operation then
			if IsValid(entity) then
				entity:Remove()
			end
			ix.item.instances[item:GetID()] = nil

			return
		end
		if IsValid(entity) then
			local physics = entity:GetPhysicsObject()
			if IsValid(physics) then
				physics:EnableMotion(movable)
			end
			entity.bTemporary = true
			if operation then
				trackEntity(operation, entity)
			end
		end
		if operation then
			operation.pending = operation.pending - 1
			dupePlugin:CompleteDupe(uniqueID, operation)
		end
	end

	function PLUGIN:ItemDummiesToItems(entities, uniqueID, operation)
		local dummies = {}
		for _, entity in pairs(entities or ents.FindByClass("ix_dupedummyitem")) do
			if IsValid(entity) and entity:GetClass() == "ix_dupedummyitem" then
				dummies[#dummies + 1] = entity
			end
		end
		if operation then
			operation.pending = #dummies
		end
		for _, dummy in ipairs(dummies) do
			local represented = dummy:GetRepresentedItem()
			local movable = dummy:GetShouldUnfreeze()
			if represented and ix.item.list[represented[1]] then
				ix.item.Spawn(represented[1], dummy:GetPos(), function(item, entity)
					finishDummyItem(self, uniqueID, operation, movable, item, entity)
				end, dummy:GetAngles(), represented[2] or {})
			elseif operation then
				operation.pending = operation.pending - 1
			end
			dummy:Remove()
		end
		if operation then
			self:CompleteDupe(uniqueID, operation)
		end
	end
end

ix.command.Add("debug_spawndupe", {
	adminOnly = true,
	arguments = ix.type.string,
	OnRun = function(self, client, name)
		local ok, err = PLUGIN:SpawnDupe(name)
		if not ok then
			return err
		end
	end,
})

ix.command.Add("debug_despawndupe", {
	adminOnly = true,
	arguments = ix.type.string,
	OnRun = function(self, client, name)
		PLUGIN:DespawnDupe(name)
	end,
})

ix.command.Add("debug_convertdupeitems", {
	adminOnly = true,
	OnRun = function()
		PLUGIN:ItemDummiesToItems()
	end,
})

function ix.util.SpawnAdvDupe2Dupe(name, uniqueID, offset, position)
	return ix.plugin.Get("advdupeint"):SpawnDupe(name, uniqueID, offset, position)
end

function ix.util.DepawnAdvDupe2Dupe(uniqueID)
	return ix.plugin.Get("advdupeint"):DespawnDupe(uniqueID)
end

function PLUGIN:PlayerSpawnSENT(client)
	if not client then
		return true
	end
	if not client:IsAdmin() then
		return false
	end
end

function PLUGIN:PlayerSpawnedSENT(client)
	if not client then
		return true
	end
end

function PLUGIN:PlayerSpawnRagdoll(client)
	if not client then
		return true
	end
end
