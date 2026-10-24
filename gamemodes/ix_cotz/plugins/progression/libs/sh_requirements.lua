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

	function ix.progression.ValidateRequirementPools()
		for progressionID, definition in pairs(ix.progression.definitions) do
			if definition.requirementSlots then
				assert(#definition.requirementSlots > 0, "Empty delivery requirements: " .. progressionID)
			end
			for _, slot in ipairs(definition.requirementSlots or {}) do
				validateSlot(slot)
			end
		end
	end

	local function rollRequirements(definition)
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
			requirements[candidate.item] = slot.quantity
			selections[index] = { pool = slot.pool, item = candidate.item }
			usedItems[candidate.item] = true
		end

		return requirements, selections
	end

	function ix.progression.AssignActiveRequirements(character)
		local record = ix.progression.GetCharacterProgression(character)
		local identifiers = {}
		for progressionID, definition in pairs(ix.progression.definitions) do
			if definition.requirementSlots then
				identifiers[#identifiers + 1] = progressionID
			end
		end
		table.sort(identifiers)
		local changed = false
		for _, progressionID in ipairs(identifiers) do
			local line = record.lines[progressionID] or {}
			if not line.requirements and ix.progression.IsActive(character, progressionID) then
				local definition = ix.progression.definitions[progressionID]
				line.requirements, line.selections = rollRequirements(definition)
				line.assignmentVersion = ASSIGNMENT_VERSION
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
