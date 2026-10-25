ix.progression = ix.progression or {}
ix.progression.definitions = ix.progression.definitions or {}

-- World NPCs are shared entities; access to their services belongs to a character.
ix.progression.npcRequirements = {
	["'Haggler'"] = "oldTimerKillIntro",
	["'Spicy Lemon'"] = "oldTimerItemDelivery_mainMeat",
	["'Mute'"] = "oldTimerItemDelivery_mainStatue",
	["'Egghead'"] = "smartass_rfTasks",
	["'Beanstalk'"] = "smartass_rfTasks",
	["'Intern'"] = "smartass_rfTasks",
	["'Computer'"] = "intern_gasAnalyzerReadings",
	["'???'"] = "computer_artifactTasks",
}

function ix.progression.GetLine(character, progressionID)
	local line = ix.progression.GetCharacterProgressionLine(character, progressionID)
	line.value = line.value or 0
	line.complexData = line.complexData or {}
	line.hasfuncrun = line.hasfuncrun or {}

	return line
end

function ix.progression.IsCompleted(character, progressionID)
	return ix.progression.GetLine(character, progressionID).completed == true
end

function ix.progression.CanUseNPC(character, npcName)
	if not character then
		return false
	end
	local required = ix.progression.npcRequirements[npcName]

	return not required or ix.progression.IsCompleted(character, required)
end

function ix.progression.IsActive(character, progressionID)
	local definition = ix.progression.definitions[progressionID]
	if not definition then
		return false
	end
	local line = ix.progression.GetLine(character, progressionID)
	if line.completed or not ix.progression.CanUseNPC(character, definition.keyNpc) then
		return false
	end
	if line.active ~= nil then
		return line.active == true
	end

	return definition.defaultActive == true
end

function ix.progression.GetProgressionValue(character, progressionID)
	return ix.progression.GetLine(character, progressionID).value
end

function ix.progression.GetComplexProgressionValue(character, progressionID)
	return ix.progression.GetLine(character, progressionID).complexData
end

function ix.progression.GetActiveProgressions(character, npcIdentifier)
	local result = {}
	for progressionID, definition in pairs(ix.progression.definitions) do
		if definition.keyNpc == npcIdentifier and ix.progression.IsActive(character, progressionID) then
			result[#result + 1] = progressionID
		end
	end
	table.sort(result)

	return result
end

function ix.progression.GetNPCFromName(npcName)
	for _, entity in ipairs(ents.FindByClass("ix_vendor_adv")) do
		if entity:GetDisplayName() == npcName then
			return entity
		end
	end
end

function ix.progression.CanBuyItem(character, npcName, itemID)
	if not ix.progression.CanUseNPC(character, npcName) then
		return false
	end
	local locked = false
	for progressionID, definition in pairs(ix.progression.definitions) do
		for _, unlock in ipairs(definition.vendorUnlocks or {}) do
			if unlock.npc == npcName and unlock.args[1] == itemID then
				locked = true
				if ix.progression.IsCompleted(character, progressionID) then
					return true
				end
			end
		end
	end

	return not locked
end

if SERVER then
	local function updateLine(character, progressionID, callback)
		assert(ix.progression.definitions[progressionID], "Unknown progression: " .. tostring(progressionID))
		local record = ix.progression.GetCharacterProgression(character)
		local line = ix.progression.GetLine(character, progressionID)
		callback(line)
		record.lines[progressionID] = line
		ix.progression.SetCharacterProgression(character, record)
	end

	function ix.progression.SetActive(character, progressionID, active)
		updateLine(character, progressionID, function(line)
			line.active = tobool(active)
		end)
		ix.progression.AssignActiveRequirements(character)
	end

	function ix.progression.SetCompleted(character, progressionID)
		local definition = ix.progression.definitions[progressionID]
		assert(definition, "Unknown progression: " .. tostring(progressionID))
		local record = ix.progression.GetCharacterProgression(character)
		local line = ix.progression.GetLine(character, progressionID)
		line.active = false
		line.completed = true
		record.lines[progressionID] = line
		for _, nextID in ipairs(definition.nextProgressions or {}) do
			assert(ix.progression.definitions[nextID], "Unknown progression: " .. nextID)
			record.lines[nextID] = record.lines[nextID] or {}
			if not record.lines[nextID].completed then
				record.lines[nextID].active = true
			end
		end
		ix.progression.SetCharacterProgression(character, record)
		ix.progression.AssignActiveRequirements(character)
		if ix.progression.UnlockWorldNPC then
			ix.progression.UnlockWorldNPC(progressionID)
		end
	end

	function ix.progression.Notify(character, name, message)
		local client = character:GetPlayer()
		if IsValid(client) and client:GetCharacter() == character then
			ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
				name = name,
				message = message,
			})
		end
	end

	local function canAdvance(character, progressionID)
		local definition = ix.progression.definitions[progressionID]

		return definition
			and definition.progMap == game.GetMap()
			and ix.progression.IsActive(character, progressionID)
	end

	function ix.progression.InvokeProgressionLevel(character, progressionID, level)
		local definition = ix.progression.definitions[progressionID]
		local callback = definition and definition.progressfunctions and definition.progressfunctions[level]
		if not callback or ix.progression.GetLine(character, progressionID).hasfuncrun[tostring(level)] then
			return
		end
		-- Mark before calling out so repeated requests cannot run this threshold twice.
		updateLine(character, progressionID, function(line)
			line.hasfuncrun[tostring(level)] = true
		end)
		callback:OnRun(character)
	end

	function ix.progression.InvokeProgression(character, progressionID)
		local definition = ix.progression.definitions[progressionID]
		local value = ix.progression.GetProgressionValue(character, progressionID)
		for level, threshold in ipairs(definition.progressthresholds or {}) do
			if value >= threshold then
				ix.progression.InvokeProgressionLevel(character, progressionID, level)
			end
		end
	end

	function ix.progression.SetProgressionValue(character, progressionID, amount)
		if
			not canAdvance(character, progressionID)
			or not isnumber(amount)
			or amount ~= amount
			or amount == math.huge
			or amount == -math.huge
		then
			return false
		end
		local definition = ix.progression.definitions[progressionID]
		local thresholds = definition.progressthresholds or {}
		local final = thresholds[#thresholds]
		amount = math.max(0, final and math.min(amount, final) or amount)
		updateLine(character, progressionID, function(line)
			line.value = amount
		end)
		ix.progression.InvokeProgression(character, progressionID)
		if final and amount >= final then
			ix.progression.SetCompleted(character, progressionID)
		end
		character:Save()

		return true
	end

	function ix.progression.AddProgressionValue(character, progressionID, amount)
		if not isnumber(amount) then
			return false
		end

		return ix.progression.SetProgressionValue(
			character,
			progressionID,
			ix.progression.GetProgressionValue(character, progressionID) + amount
		)
	end

	-- Retain the historical spelling for extensions, with the new owner argument.
	ix.progression.AddProgessionValue = ix.progression.AddProgressionValue

	function ix.progression.RemoveProgressionValue(character, progressionID, amount)
		if not isnumber(amount) then
			return false
		end

		return ix.progression.AddProgressionValue(character, progressionID, -amount)
	end

	function ix.progression.AddComplexProgressionValue(character, progressionID, data)
		if not canAdvance(character, progressionID) or not istable(data) then
			return false
		end
		local itemID, amount = data[1], data[2]
		local required = ix.progression.GetRequirements(character, progressionID)[itemID]
		if not required or not isnumber(amount) or amount ~= amount or amount <= 0 or amount == math.huge then
			return false
		end
		local line = ix.progression.GetLine(character, progressionID)
		amount = math.min(math.floor(amount), required - (line.complexData[itemID] or 0))
		if amount <= 0 then
			return false
		end
		line.complexData[itemID] = (line.complexData[itemID] or 0) + amount
		local completed = true
		for id, count in pairs(ix.progression.GetRequirements(character, progressionID)) do
			if (line.complexData[id] or 0) < count then
				completed = false
			end
		end
		updateLine(character, progressionID, function(stored)
			stored.complexData = line.complexData
			if completed then
				stored.completed = true
				stored.active = false
			end
		end)
		if completed then
			ix.progression.SetCompleted(character, progressionID)
			ix.progression.PayCompletionRewards(character, progressionID)
			local definition = ix.progression.definitions[progressionID]
			if definition.OnComplete then
				definition.OnComplete(character)
			end
		end

		return amount
	end

	-- The server derives the accepted quantity and rewards from inventory state.
	function ix.progression.TurnIn(client, target, progressionID, itemID)
		local character = client:GetCharacter()
		local definition = ix.progression.definitions[progressionID]
		if
			not character
			or not IsValid(target)
			or target:GetClass() ~= "ix_vendor_adv"
			or not definition
			or target:GetDisplayName() ~= definition.keyNpc
			or client:GetPos():DistToSqr(target:GetPos()) > 192 * 192
			or not target:CanAccess(client)
			or not canAdvance(character, progressionID)
		then
			return false
		end
		local required = ix.progression.GetRequirements(character, progressionID)[itemID]
		if not required then
			return false
		end
		local remaining = required
			- (ix.progression.GetComplexProgressionValue(character, progressionID)[itemID] or 0)
		local item = character:GetInventory():HasItem(itemID)
		if not item or remaining <= 0 then
			return false
		end
		local available = item:GetData("quantity", item.quantity or item.ammoAmount or 1)
		if not isnumber(available) or available ~= available or available == math.huge then
			return false
		end
		local amount = math.floor(math.min(available, remaining))
		if amount <= 0 then
			return false
		end
		local itemName = item.name or ix.item.list[itemID].name
		local reputation, money = ix.util.GetValueFromProgressionTurnin(item, amount)
		-- Consume before running completion callbacks or giving rewards.
		if amount == available then
			if item:Remove() == false then
				return false
			end
		else
			item:SetData("quantity", available - amount)
		end
		ix.dialogue.notifyItemLost(client, string.format("%s x%d", itemName, amount))
		ix.progression.AccrueTurnInRewards(character, progressionID, reputation, money, itemID)
		ix.progression.AddComplexProgressionValue(character, progressionID, { itemID, amount })
		character:Save()
		local response = string.format("Received %d x %s for %s. ", amount, itemName, definition.name)
		if ix.progression.IsCompleted(character, progressionID) then
			response = response .. "That's everything I asked for. The task is complete, and your reward is paid."
		elseif remaining > amount then
			response = response .. string.format("I still need %d more of this item to meet the request.", remaining - amount)
		else
			response = response .. "That's enough of this item. Bring the other supplies to finish the task."
		end

		return true, response
	end
end
