ix.progression = ix.progression or {}

local function savedSelection(character, progressionID, itemID)
	if not character then return end
	local line = ix.progression.GetLine(character, progressionID)
	for _, selection in ipairs(line.selections or {}) do
		if selection.item == itemID and selection.mode then return selection end
	end
end

function ix.progression.GetRequirementKey(progressionID, itemID, character)
	if character then
		local line = ix.progression.GetLine(character, progressionID)
		for _, selection in ipairs(line.selections or {}) do
			for _, choice in ipairs(selection.choices or {}) do
				if choice == itemID then return selection.item end
			end
		end
		for _, selection in ipairs(line.selections or {}) do
			if selection.item == itemID and selection.choices then return nil end
		end
	end
	local definition = ix.progression.definitions[progressionID]
	local required = definition and (definition.requirementAlternatives or {})[itemID]
	if required and savedSelection(character, progressionID, required) then return itemID end

	return required or itemID
end

function ix.progression.GetRequirementChoices(progressionID, itemID, character)
	local selection = savedSelection(character, progressionID, itemID)
	if selection and selection.choices then return table.Copy(selection.choices) end
	local definition = ix.progression.definitions[progressionID]
	local choices = {itemID}
	for alternative, required in pairs(definition and definition.requirementAlternatives or {}) do
		if required == itemID then choices[#choices + 1] = alternative end
	end
	table.sort(choices)

	return choices
end

function ix.progression.GetRequirementUnitSize(progressionID, itemID, character)
	local key = ix.progression.GetRequirementKey(progressionID, itemID, character)
	local selection = key and savedSelection(character, progressionID, key)

	return selection and selection.unitSizes and selection.unitSizes[itemID] or 1
end

function ix.progression.GetRequirementLabel(progressionID, itemID, character)
	local names = {}
	for _, choice in ipairs(ix.progression.GetRequirementChoices(progressionID, itemID, character)) do
		local size = ix.progression.GetRequirementUnitSize(progressionID, choice, character)
		local name = ix.item.list[choice].name
		names[#names + 1] = size > 1 and (name .. " x" .. size) or name
	end
	local selection = savedSelection(character, progressionID, itemID)
	if selection and selection.unitSizes then
		return selection.name .. " batches (any mix; per batch: " .. table.concat(names, ", ") .. ")"
	end
	if selection and selection.mode == "any" then
		return selection.name .. " (any mix: " .. table.concat(names, ", ") .. ")"
	end

	return table.concat(names, " or ")
end

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

local function collectNeededItems(character)
	local result, contacts = {}, {}
	local known = character:GetData("knownProgressionTopics", {})
	for progressionID, definition in pairs(ix.progression.definitions) do
		if known[progressionID] and ix.progression.IsActive(character, progressionID) then
			local contributed = ix.progression.GetComplexProgressionValue(character, progressionID)
			for item, amount in pairs(ix.progression.GetRequirements(character, progressionID)) do
				local remaining = amount - (contributed[item] or 0)
				if remaining > 0 then
					for _, choice in ipairs(ix.progression.GetRequirementChoices(progressionID, item, character)) do
						local size = ix.progression.GetRequirementUnitSize(progressionID, choice, character)
						result[choice] = (result[choice] or 0) + remaining * size
						contacts[choice] = contacts[choice] or {}
						contacts[choice][definition.keyNpc] = true
					end
				end
			end
		end
	end

	return result, contacts
end

function ix.progression.GetNeededItems(character)
	local items = collectNeededItems(character)

	return items
end

function ix.progression.GetNeededItemContacts(character)
	local _, contacts = collectNeededItems(character)

	return contacts
end

if SERVER then
	local function validateSlot(slot)
		local pool = ix.progression.itemPools[slot.pool]
		assert(pool and #pool.candidates > 0, "Unknown or empty requirement pool: " .. tostring(slot.pool))
		assert(slot.mode == nil or slot.mode == "any" or slot.mode == "random", "Invalid requirement mode")
		local quantity = slot.quantity
		assert(isnumber(quantity) and quantity > 0 and quantity % 1 == 0, "Invalid requirement quantity")
		for _, candidate in ipairs(pool.candidates) do
			assert(ix.item.list[candidate.item], "Unknown requirement item: " .. tostring(candidate.item))
			local size = (ix.progression.requirementBatchSizes or {})[candidate.item] or 1
			assert(isnumber(size) and size >= 1 and size % 1 == 0, "Invalid requirement batch size")
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

	local function validateAlternatives(definition)
		if not definition.requirementAlternatives then return end
		local requirementItems = {}
		for _, slot in ipairs(definition.requirementSlots or {}) do
			for _, candidate in ipairs(validateSlot(slot).candidates) do requirementItems[candidate.item] = true end
		end
		for alternative, required in pairs(definition.requirementAlternatives) do
			assert(ix.item.list[alternative] and ix.item.list[required], "Unknown alternative requirement item")
			assert(alternative ~= required and not definition.requirementAlternatives[required],
				"Alternative requirements must point directly to a canonical item")
			assert(not requirementItems[alternative], "Alternative item also occupies a requirement slot")
			assert(requirementItems[required], "Alternative requirement has no canonical slot")
		end
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
			validateAlternatives(definition)
			local range = definition.categoryChoiceRange
			if range then
				assert(isnumber(range[1]) and isnumber(range[2]) and range[1] > 0
					and range[1] % 1 == 0 and range[2] % 1 == 0 and range[2] >= range[1],
					"Invalid category subset range: " .. progressionID)
			end
			local accepted = {}
			for _, slot in ipairs(definition.requirementSlots or {}) do
				if definition.categoryOnly then
					assert(slot.mode == "any", "Opening town requests must be category-wide: " .. progressionID)
				end
				if slot.mode then
					for _, candidate in ipairs(validateSlot(slot).candidates) do
						assert(definition.categoryChoiceRange or not accepted[candidate.item],
							"Overlapping requirement slots: " .. progressionID)
						accepted[candidate.item] = true
					end
				end
				local pool = validateSlot(slot)
				if definition.requirementPolicy then
					for _, candidate in ipairs(pool.candidates) do
						assert(definition.allowedRequirements[candidate.item],
							"Ineligible town requirement: " .. progressionID .. "/" .. candidate.item)
					end
				end
			end
		end
	end

	function ix.progression.AuditDefinitions()
		ix.progression.ValidateRequirementPools()
		local visiting, complete = {}, {}
		local function visit(id)
			if complete[id] then return end
			assert(not visiting[id], "Progression dependency cycle at " .. tostring(id))
			local definition = ix.progression.definitions[id]
			assert(definition, "Unknown progression dependency: " .. tostring(id))
			visiting[id] = true
			for _, required in ipairs(definition.prerequisites or {}) do visit(required) end
			local gate = ix.progression.npcRequirements[definition.keyNpc]
			if gate and gate ~= id then visit(gate) end
			for predecessor, source in pairs(ix.progression.definitions) do
				for _, successor in ipairs(source.nextProgressions or {}) do
					if successor == id then visit(predecessor) end
				end
			end
			visiting[id] = nil
			complete[id] = true
		end
		local count, contacts = 0, {}
		for id, definition in pairs(ix.progression.definitions) do
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

	local function makeSelection(definition, slot, itemID, reserved, used)
		local choices = {itemID}
		if slot.mode == "any" then
			for _, candidate in ipairs(validateSlot(slot).candidates) do
				local choice = candidate.item
				if choice ~= itemID and not reserved[choice] and not used[choice] then
					choices[#choices + 1] = choice
				end
			end
		end
		for alternative, required in pairs(definition.requirementAlternatives or {}) do
			if required == itemID and not reserved[alternative] and not used[alternative] then
				choices[#choices + 1] = alternative
			end
		end
		table.sort(choices)
		for _, choice in ipairs(choices) do used[choice] = true end

		return {pool = slot.pool, item = itemID, mode = slot.mode or "random",
			choices = choices, name = validateSlot(slot).name or slot.pool}
	end

	local function batchSize(itemID)
		return (ix.progression.requirementBatchSizes or {})[itemID] or 1
	end

	local function subsetGroups(slot, used)
		local eligible, groups = {}, {}
		for _, candidate in ipairs(validateSlot(slot).candidates) do
			if not used[candidate.item] then eligible[candidate.item] = true end
		end
		-- Fasteners must be offered together, including when categories overlap other slots.
		if eligible.value_nuts and eligible.value_bolts then groups[#groups + 1] = {"value_nuts", "value_bolts"} end
		eligible.value_nuts, eligible.value_bolts = nil, nil
		local ordered = {}
		for itemID in pairs(eligible) do ordered[#ordered + 1] = itemID end
		table.sort(ordered)
		for _, itemID in ipairs(ordered) do groups[#groups + 1] = {itemID} end

		return groups
	end

	local function takeSubset(groups, choices, maximum, used, weights)
		while #groups > 0 and #choices < maximum do
			local best, options = math.huge, {}
			for index, group in ipairs(groups) do
				local weight = 0
				for _, itemID in ipairs(group) do weight = weight + (weights[itemID] or 0) end
				weight = weight / #group
				if #choices + #group <= maximum and weight <= best then
					if weight < best then best, options = weight, {} end
					options[#options + 1] = index
				end
			end
			if #options == 0 then break end
			local group = table.remove(groups, options[math.random(1, #options)])
			for _, itemID in ipairs(group) do
				choices[#choices + 1] = itemID
				used[itemID] = true
			end
		end
	end

	local function buildSubsetSelections(definition, requirements, selections, line)
		local used, categories, weights = {}, {}, {}
		local range = definition.categoryChoiceRange
		for index, selection in ipairs(selections) do
			local slot = definition.requirementSlots[index]
			if slot.mode == "any" then
				local count = #validateSlot(slot).candidates
				for _, candidate in ipairs(validateSlot(slot).candidates) do
					weights[candidate.item] = (weights[candidate.item] or 0) + 1
				end
				categories[#categories + 1] = {index = index, count = count,
					target = math.random(range[1], range[2]), choices = {}}
			else
				selections[index] = makeSelection(definition, slot, selection.item, {}, used)
			end
		end
		table.sort(categories, function(first, second)
			if first.count == second.count then return first.index < second.index end

			return first.count < second.count
		end)
		for _, category in ipairs(categories) do
			local slot = definition.requirementSlots[category.index]
			local groups = subsetGroups(slot, used)
			takeSubset(groups, category.choices, range[1], used, weights)
			assert(#category.choices >= range[1], "Not enough distinct category choices: " .. definition.id)
		end
		for _, category in ipairs(categories) do
			local index = category.index
			local slot, selection = definition.requirementSlots[index], selections[index]
			local groups = subsetGroups(slot, used)
			takeSubset(groups, category.choices, category.target, used, weights)
			table.sort(category.choices)
			local sizes = {}
			for _, itemID in ipairs(category.choices) do sizes[itemID] = batchSize(itemID) end
			selections[index] = {pool = slot.pool, item = selection.item, mode = "any",
				choices = category.choices, name = validateSlot(slot).name, unitSizes = sizes}
			local supplied = line and (line.complexData or {})[selection.item] or 0
			if not line or supplied < requirements[selection.item] then
				requirements[selection.item] = math.max(requirements[selection.item], line and range[1] or category.target)
			end
		end

		return selections
	end

	local function rollRequirements(definition, character, record)
		local requirements, selections, usedItems = {}, {}, {}
		for index, slot in ipairs(definition.requirementSlots) do
			local candidates = {}
			for _, candidate in ipairs(validateSlot(slot).candidates) do
				if not usedItems[candidate.item] then candidates[#candidates + 1] = candidate end
			end
			assert(#candidates > 0, "Requirement slots have no distinct item selection")
			local fixedAnchor = slot.mode == "any" and not definition.categoryChoiceRange
			local candidate = candidates[fixedAnchor and 1 or math.random(1, #candidates)]
			if definition.milestoneGroup then
				candidate = programmeSelection(record, definition.milestoneGroup, slot.pool) or candidate
			end
			local size = definition.batchSizedRequirements and slot.mode == "random" and batchSize(candidate.item) or 1
			requirements[candidate.item] = slot.quantity * size
			selections[index] = {pool = slot.pool, item = candidate.item}
			usedItems[candidate.item] = true
		end
		if definition.categoryChoiceRange then
			return requirements, buildSubsetSelections(definition, requirements, selections)
		end
		local usedChoices = {}
		for index, selection in ipairs(selections) do
			local slot = definition.requirementSlots[index]
			if slot.mode then
				selections[index] = makeSelection(definition, slot, selection.item, usedItems, usedChoices)
			end
		end

		return requirements, selections
	end

	local function upgradeRequirementModes(definition, line)
		if not definition.requirementModesVersion or line.completed or not line.requirements
			or line.requirementModesVersion == definition.requirementModesVersion then return false end
		local selections, reserved, used, ordered = {}, {}, {}, {}
		for itemID in pairs(line.requirements) do reserved[itemID] = true end
		for _, selection in ipairs(line.selections or {}) do
			local itemID = selection.item
			-- Region-policy conversions can leave a fulfilled historical key beside its pending replacement.
			for _, conversion in ipairs(line.requirementConversions or {}) do
				if conversion.from == itemID and line.requirements[conversion.to] then itemID = conversion.to end
			end
			if reserved[itemID] and not ordered[itemID] then
				selections[#selections + 1] = itemID
				ordered[itemID] = true
			end
		end
		local remaining = {}
		for itemID in pairs(reserved) do
			if not ordered[itemID] then remaining[#remaining + 1] = itemID end
		end
		table.sort(remaining)
		for _, itemID in ipairs(remaining) do selections[#selections + 1] = itemID end
		line.selections = {}
		for index, itemID in ipairs(selections) do
			local slot = definition.requirementSlots[index]
			if slot then
				line.selections[index] = makeSelection(definition, slot, itemID, reserved, used)
			end
		end
		if definition.categoryChoiceRange then
			line.selections = buildSubsetSelections(definition, line.requirements, line.selections, line)
		end
		-- Keep item keys, credited deliveries and money; completed categories are not reopened.
		line.requirementModesVersion = definition.requirementModesVersion

		return true
	end

	local function replacementCandidates(definition, line, used, itemID, index)
		local slotIndex = math.min(index, #definition.requirementSlots)
		for selectionIndex, selection in ipairs(line.selections or {}) do
			if selection.item == itemID then slotIndex = selectionIndex break end
		end
		-- Keep the corresponding slot when possible, then search the other disjoint slots.
		for offset = 0, #definition.requirementSlots - 1 do
			local slot = definition.requirementSlots[(slotIndex + offset - 1) % #definition.requirementSlots + 1]
			local candidates = {}
			for _, candidate in ipairs(validateSlot(slot).candidates) do
				if not used[candidate.item] then candidates[#candidates + 1] = candidate.item end
			end
			if #candidates > 0 then return candidates end
		end

		error("No eligible replacement for saved requirement: " .. definition.id)
	end

	local function convertRequirements(definition, line)
		if not definition.requirementPolicy or line.requirementPolicy == definition.requirementPolicy
			or line.completed or not line.requirements then return false end
		local used, pending = {}, {}
		for itemID, quantity in pairs(line.requirements) do
			local supplied = (line.complexData or {})[itemID] or 0
			if supplied < quantity and not definition.allowedRequirements[itemID] then
				pending[#pending + 1] = {item = itemID, remaining = quantity - supplied, supplied = supplied}
			else
				used[itemID] = true
			end
		end
		table.sort(pending, function(first, second) return first.item < second.item end)
		line.requirementConversions = line.requirementConversions or {}
		for index, old in ipairs(pending) do
			local candidates = replacementCandidates(definition, line, used, old.item, index)
			local replacement = candidates[math.random(1, #candidates)]
			used[replacement] = true
			line.requirements[old.item] = old.supplied > 0 and old.supplied or nil
			line.requirements[replacement] = (line.requirements[replacement] or 0) + old.remaining
			line.requirementConversions[#line.requirementConversions + 1] = {
				from = old.item, to = replacement, quantity = old.remaining, policy = definition.requirementPolicy,
			}
		end
		line.requirementPolicy = definition.requirementPolicy

		return true
	end

	local function canActivateIntermission(character, definition, line)
		if not definition.intermissionFor or (line and (line.completed or line.active)) then return false end
		for _, required in ipairs(definition.prerequisites or {}) do
			if not ix.progression.IsCompleted(character, required) then return false end
		end

		return true
	end

	function ix.progression.AssignActiveRequirements(character)
		local record = ix.progression.GetCharacterProgression(character)
		local identifiers, activeGroups = {}, {}
		local changed = false
		for progressionID, definition in pairs(ix.progression.definitions) do
			local line = record.lines[progressionID]
			if canActivateIntermission(character, definition, line) then
				line = line or {}
				line.active = true
				record.lines[progressionID] = line
				changed = true
			end
			if line and convertRequirements(definition, line) then changed = true end
			if line and upgradeRequirementModes(definition, line) then changed = true end
		end
		if changed then ix.progression.SetCharacterProgression(character, record) end
		for progressionID, definition in pairs(ix.progression.definitions) do
			if definition.requirementSlots then
				identifiers[#identifiers + 1] = progressionID
				if definition.milestoneGroup and ix.progression.IsActive(character, progressionID) then
					activeGroups[definition.milestoneGroup] = true
				end
			end
		end
		table.sort(identifiers)
		for _, progressionID in ipairs(identifiers) do
			local line = record.lines[progressionID] or {}
			local definition = ix.progression.definitions[progressionID]
			local accessible = ix.progression.IsActive(character, progressionID)
				or activeGroups[definition.milestoneGroup]
			if not line.requirements and accessible then
				line.requirements, line.selections = rollRequirements(definition, character, record)
				line.requirementPolicy = definition.requirementPolicy
				line.requirementModesVersion = definition.requirementModesVersion
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
