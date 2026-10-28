ix.progression = ix.progression or {}

local ASSIGNMENT_VERSION = 1

function ix.progression.GetRequirements(character, progressionID)
	local definition = ix.progression.definitions[progressionID]
	if not definition or not definition.requirementSlots then
		return {}
	end
	local line = ix.progression.GetLine(character, progressionID)
	if SERVER and not line.requirements and ix.progression.IsActive(character, progressionID) then
		ix.progression.AssignActiveRequirements(character)
		line = ix.progression.GetLine(character, progressionID)
	end

	return line.requirements or {}
end

ix.progression.GetComplexProgressionReqs = ix.progression.GetRequirements

function ix.progression.GetNeededItems(character)
	local result = {}
	for progressionID in pairs(ix.progression.definitions) do
		if ix.progression.IsActive(character, progressionID) then
			local contributed = ix.progression.GetComplexProgressionValue(character, progressionID)
			for item, amount in pairs(ix.progression.GetRequirements(character, progressionID)) do
				local remaining = amount - (contributed[item] or 0)
				if remaining > 0 then
					result[item] = (result[item] or 0) + remaining
				end
			end
		end
	end

	return result
end

if SERVER then
	local function validateSlot(slot)
		local pool = ix.progression.itemPools[slot.pool]
		assert(pool and #pool.candidates > 0, "Unknown or empty requirement pool: " .. tostring(slot.pool))
		local quantity = slot.quantity
		assert(isnumber(quantity) and quantity > 0 and quantity % 1 == 0, "Invalid requirement quantity")
		for _, candidate in ipairs(pool.candidates) do
			assert(ix.item.list[candidate.item], "Unknown requirement item: " .. tostring(candidate.item))
		end

		return pool
	end

	local function validateCatalogueReward(definition, unlock)
		assert(ix.item.list[unlock.args[1]], "Unknown catalogue reward: " .. unlock.args[1])
		if not unlock.threshold then return end
		for _, threshold in ipairs(definition.progressthresholds or {}) do
			if threshold == unlock.threshold then return end
		end
		error("Unknown catalogue threshold: " .. definition.id)
	end

	function ix.progression.ValidateRequirementPools()
		for progressionID, definition in pairs(ix.progression.definitions) do
			if ix.progression.ValidateBenefits then ix.progression.ValidateBenefits(definition) end
			assert(type(definition.BuildResponse) == "function", "Missing request dialogue: " .. progressionID)
			for _, nextID in ipairs(definition.nextProgressions or {}) do
				assert(ix.progression.definitions[nextID], "Unknown successor: " .. tostring(nextID))
			end
			for _, required in ipairs(definition.prerequisites or {}) do
				assert(ix.progression.definitions[required], "Unknown prerequisite: " .. tostring(required))
			end
			local previous = 0
			for _, threshold in ipairs(definition.progressthresholds or {}) do
				assert(type(threshold) == "number" and threshold > previous and threshold % 1 == 0,
					"Invalid progression threshold: " .. progressionID)
				previous = threshold
			end
			assert(#(definition.checkpointBenefits or {}) < #(definition.progressthresholds or {})
				or not definition.checkpointBenefits, "Checkpoint overlaps final completion: " .. progressionID)
			for _, unlock in ipairs(definition.vendorUnlocks or {}) do
				validateCatalogueReward(definition, unlock)
			end
			if definition.requirementSlots then
				assert(#definition.requirementSlots > 0, "Empty delivery requirements: " .. progressionID)
			end
			for _, slot in ipairs(definition.requirementSlots or {}) do
				validateSlot(slot)
			end
		end
	end

	function ix.progression.AuditDefinitions()
		ix.progression.ValidateRequirementPools()
		local visiting, complete = {}, {}
		local definitions = ix.progression.definitions
		local function visit(id)
			if complete[id] then return end
			assert(not visiting[id], "Progression dependency cycle at " .. tostring(id))
			local definition = definitions[id]
			assert(definition, "Unknown progression dependency: " .. tostring(id))
			visiting[id] = true
			for _, required in ipairs(definition.prerequisites or {}) do visit(required) end
			local gate = ix.progression.npcRequirements[definition.keyNpc]
			if gate and gate ~= id then visit(gate) end
			for predecessor, source in pairs(definitions) do
				for _, successor in ipairs(source.nextProgressions or {}) do
					if successor == id then visit(predecessor) end
				end
			end
			visiting[id] = nil
			complete[id] = true
		end
		local count, contacts = 0, {}
		for id, definition in pairs(definitions) do
			visit(id)
			count = count + 1
			contacts[definition.keyNpc] = true
		end
		local contactCount = 0
		for _ in pairs(contacts) do contactCount = contactCount + 1 end

		return count, contactCount
	end

	local function savedPoolSelection(selections, poolID)
		for _, selection in ipairs(selections or {}) do
			if selection.pool == poolID then
				return {item = selection.item}
			end
		end
	end

	local function programmeSelection(record, groupID, poolID)
		for stageID, stage in pairs(record.lines) do
			local definition = ix.progression.definitions[stageID]
			if definition and definition.milestoneGroup == groupID then
				local candidate = savedPoolSelection(stage.selections, poolID)
				if candidate then
					return candidate
				end
			end
		end
	end

	local function rollRequirements(definition, character, record)
		local requirements, selections = {}, {}
		local usedItems = {}
		for index, slot in ipairs(definition.requirementSlots) do
			local pool = validateSlot(slot)
			local candidates = {}
			for _, candidate in ipairs(pool.candidates) do
				if not usedItems[candidate.item] then
					candidates[#candidates + 1] = candidate
				end
			end
			assert(#candidates > 0, "Requirement slots have no distinct item selection")
			local candidate = candidates[math.random(1, #candidates)]
			if definition.milestoneGroup then
				candidate = programmeSelection(record, definition.milestoneGroup, slot.pool) or candidate
			end
			requirements[candidate.item] = slot.quantity
			selections[index] = { pool = slot.pool, item = candidate.item }
			usedItems[candidate.item] = true
		end

		return requirements, selections
	end

	function ix.progression.AssignActiveRequirements(character)
		local record = ix.progression.GetCharacterProgression(character)
		local identifiers, activeGroups = {}, {}
		for progressionID, definition in pairs(ix.progression.definitions) do
			if definition.requirementSlots then
				identifiers[#identifiers + 1] = progressionID
				local final = record.lines[definition.milestoneGroup] or {}
				if definition.milestoneGroup and ix.progression.IsActive(character, progressionID)
					and (not final.requirements or final.segmentVersion) then
					activeGroups[definition.milestoneGroup] = true
				end
			end
		end
		table.sort(identifiers)
		local changed = false
		for _, progressionID in ipairs(identifiers) do
			local line = record.lines[progressionID] or {}
			local definition = ix.progression.definitions[progressionID]
			local accessible = ix.progression.IsActive(character, progressionID)
				or activeGroups[definition.milestoneGroup]
			if not line.requirements and accessible then
				line.requirements, line.selections = rollRequirements(definition, character, record)
				line.assignmentVersion = ASSIGNMENT_VERSION
				line.segmentVersion = 1
				record.lines[progressionID] = line
				changed = true
			end
		end
		if not changed then
			return false
		end
		ix.progression.SetCharacterProgression(character, record)
		character:Save()

		return true
	end
end
