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

function ix.progression.GetLine(character, progid)
	local line = ix.progression.GetCharacterProgressionLine(character, progid)
	line.value = line.value or 0
	line.complexData = line.complexData or {}
	line.hasfuncrun = line.hasfuncrun or {}
	return line
end

function ix.progression.IsCompleted(character, progid)
	return ix.progression.GetLine(character, progid).completed == true
end

function ix.progression.CanUseNPC(character, npcname)
	if (not character) then return false end
	local required = ix.progression.npcRequirements[npcname]
	return not required or ix.progression.IsCompleted(character, required)
end

function ix.progression.IsActive(character, progid)
	local definition = ix.progression.definitions[progid]
	if (not definition) then return false end
	local line = ix.progression.GetLine(character, progid)
	if (line.completed or not ix.progression.CanUseNPC(character, definition.keyNpc)) then return false end
	if (line.active ~= nil) then return line.active == true end
	return definition.defaultActive == true
end

function ix.progression.GetProgressionValue(character, progid)
	return ix.progression.GetLine(character, progid).value
end

function ix.progression.GetComplexProgressionValue(character, progid)
	return ix.progression.GetLine(character, progid).complexData
end

function ix.progression.GetComplexProgressionReqs(progid)
	local definition = ix.progression.definitions[progid]
	return definition and definition.GetItemIds and definition:GetItemIds() or {}
end

function ix.progression.GetActiveProgressions(character, npcidentifier)
	local result = {}
	for progid, definition in pairs(ix.progression.definitions) do
		if (definition.keyNpc == npcidentifier and ix.progression.IsActive(character, progid)) then
			result[#result + 1] = progid
		end
	end
	table.sort(result)
	return result
end

function ix.progression.GetNPCFromName(npcname)
	for _, entity in ipairs(ents.FindByClass("ix_vendor_adv")) do
		if (entity:GetDisplayName() == npcname) then return entity end
	end
end

function ix.progression.CanBuyItem(character, npcname, itemid)
	if (not ix.progression.CanUseNPC(character, npcname)) then return false end
	local locked = false
	for progid, definition in pairs(ix.progression.definitions) do
		for _, unlock in ipairs(definition.vendorUnlocks or {}) do
			if (unlock.npc == npcname and unlock.args[1] == itemid) then
				locked = true
				if (ix.progression.IsCompleted(character, progid)) then return true end
			end
		end
	end
	return not locked
end

if (SERVER) then
	local function UpdateLine(character, progid, callback)
		assert(ix.progression.definitions[progid], "Unknown progression: "..tostring(progid))
		local record = ix.progression.GetCharacterProgression(character)
		local line = ix.progression.GetLine(character, progid)
		callback(line)
		record.lines[progid] = line
		ix.progression.SetCharacterProgression(character, record)
	end

	function ix.progression.SetActive(character, progid, active)
		UpdateLine(character, progid, function(line) line.active = tobool(active) end)
	end

	function ix.progression.SetCompleted(character, progid)
		local definition = ix.progression.definitions[progid]
		assert(definition, "Unknown progression: "..tostring(progid))
		local record = ix.progression.GetCharacterProgression(character)
		local line = ix.progression.GetLine(character, progid)
		line.active = false
		line.completed = true
		record.lines[progid] = line
		for _, nextID in ipairs(definition.nextProgressions or {}) do
			assert(ix.progression.definitions[nextID], "Unknown progression: "..nextID)
			record.lines[nextID] = record.lines[nextID] or {}
			if (not record.lines[nextID].completed) then record.lines[nextID].active = true end
		end
		ix.progression.SetCharacterProgression(character, record)
		if ix.progression.UnlockWorldNPC then ix.progression.UnlockWorldNPC(progid) end
	end

	function ix.progression.Notify(character, name, message)
		local client = character:GetPlayer()
		if (IsValid(client) and client:GetCharacter() == character) then
			ix.chat.Send(nil, "npcpdainternal", "", nil, {client}, {name = name, message = message})
		end
	end

	local function CanAdvance(character, progid)
		local definition = ix.progression.definitions[progid]
		return definition and definition.progMap == game.GetMap() and ix.progression.IsActive(character, progid)
	end

	function ix.progression.InvokeProgressionLevel(character, progid, level)
		local definition = ix.progression.definitions[progid]
		local callback = definition and definition.progressfunctions and definition.progressfunctions[level]
		if (not callback or ix.progression.GetLine(character, progid).hasfuncrun[tostring(level)]) then return end
		-- Mark before calling out so repeated requests cannot run this threshold twice.
		UpdateLine(character, progid, function(line) line.hasfuncrun[tostring(level)] = true end)
		callback:OnRun(character)
	end

	function ix.progression.InvokeProgression(character, progid)
		local definition = ix.progression.definitions[progid]
		local value = ix.progression.GetProgressionValue(character, progid)
		for level, threshold in ipairs(definition.progressthresholds or {}) do
			if (value >= threshold) then ix.progression.InvokeProgressionLevel(character, progid, level) end
		end
	end

	function ix.progression.SetProgressionValue(character, progid, amount)
		if (not CanAdvance(character, progid) or not isnumber(amount) or amount ~= amount or amount == math.huge or amount == -math.huge) then return false end
		local definition = ix.progression.definitions[progid]
		local thresholds = definition.progressthresholds or {}
		local final = thresholds[#thresholds]
		amount = math.max(0, final and math.min(amount, final) or amount)
		UpdateLine(character, progid, function(line) line.value = amount end)
		ix.progression.InvokeProgression(character, progid)
		if (final and amount >= final) then ix.progression.SetCompleted(character, progid) end
		character:Save()
		return true
	end

	function ix.progression.AddProgressionValue(character, progid, amount)
		if (not isnumber(amount)) then return false end
		return ix.progression.SetProgressionValue(character, progid, ix.progression.GetProgressionValue(character, progid) + amount)
	end

	-- Retain the historical spelling for extensions, with the new owner argument.
	ix.progression.AddProgessionValue = ix.progression.AddProgressionValue

	function ix.progression.RemoveProgressionValue(character, progid, amount)
		if (not isnumber(amount)) then return false end
		return ix.progression.AddProgressionValue(character, progid, -amount)
	end

	function ix.progression.AddComplexProgressionValue(character, progid, data)
		if (not CanAdvance(character, progid) or not istable(data)) then return false end
		local itemid, amount = data[1], data[2]
		local required = ix.progression.GetComplexProgressionReqs(progid)[itemid]
		if (not required or not isnumber(amount) or amount ~= amount or amount <= 0 or amount == math.huge) then return false end
		local line = ix.progression.GetLine(character, progid)
		amount = math.min(math.floor(amount), required - (line.complexData[itemid] or 0))
		if (amount <= 0) then return false end
		line.complexData[itemid] = (line.complexData[itemid] or 0) + amount
		local completed = true
		for id, count in pairs(ix.progression.GetComplexProgressionReqs(progid)) do
			if ((line.complexData[id] or 0) < count) then completed = false end
		end
		UpdateLine(character, progid, function(stored)
			stored.complexData = line.complexData
			if (completed) then stored.completed = true stored.active = false end
		end)
		if (completed) then
			ix.progression.SetCompleted(character, progid)
			local definition = ix.progression.definitions[progid]
			if (definition.OnComplete) then definition.OnComplete(character) end
		end
		return amount
	end

	-- The server derives the accepted quantity and rewards from inventory state.
	function ix.progression.TurnIn(client, target, progid, itemid)
		local character = client:GetCharacter()
		local definition = ix.progression.definitions[progid]
		if (not character or not IsValid(target) or target:GetClass() ~= "ix_vendor_adv" or not definition
			or target:GetDisplayName() ~= definition.keyNpc or client:GetPos():DistToSqr(target:GetPos()) > 192 * 192
			or not target:CanAccess(client) or not CanAdvance(character, progid)) then return false end
		local required = ix.progression.GetComplexProgressionReqs(progid)[itemid]
		if (not required) then return false end
		local remaining = required - (ix.progression.GetComplexProgressionValue(character, progid)[itemid] or 0)
		local item = character:GetInventory():HasItem(itemid)
		if (not item or remaining <= 0) then return false end
		local available = item:GetData("quantity", item.quantity or 1)
		if (not isnumber(available) or available ~= available or available == math.huge) then return false end
		local amount = math.floor(math.min(available, remaining))
		if (amount <= 0) then return false end
		local reputation, money = ix.util.GetValueFromProgressionTurnin(item, amount)
		-- Consume before running completion callbacks or giving rewards.
		if (amount == available) then
			if (item:Remove() == false) then return false end
		else
			item:SetData("quantity", available - amount)
		end
		ix.progression.AddComplexProgressionValue(character, progid, {itemid, amount})
		client:addReputation(reputation)
		character:GiveMoney(money)
		ix.dialogue.notifyReputationReceive(client, reputation)
		ix.dialogue.notifyMoneyReceive(client, money)
		character:Save()
		return true
	end
end
