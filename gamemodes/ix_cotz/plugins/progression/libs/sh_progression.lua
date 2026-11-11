ix.progression = ix.progression or {}
ix.progression.definitions = ix.progression.definitions or {}

-- World NPCs are shared entities; access to their services belongs to a character.
ix.progression.npcRequirements = {
	["'???'"] = "computer_artifactTasks",
}

function ix.progression.GetKnownActiveProgressions(character, npc)
	local known = character:GetData("knownProgressionTopics", {})
	local result = {}
	for _, id in ipairs(ix.progression.GetActiveProgressions(character, npc)) do
		if known[id] then result[#result + 1] = id end
	end

	return result
end

if SERVER then
	function ix.progression.DiscoverTopics(character, npc)
		local known = table.Copy(character:GetData("knownProgressionTopics", {}))
		local changed = false
		for _, id in ipairs(ix.progression.GetActiveProgressions(character, npc)) do
			if not known[id] then known[id], changed = true, true end
		end
		if not changed then return end
		character:SetData("knownProgressionTopics", known)
		character:Save()
	end
end

function ix.progression.GetLine(character, progressionID)
	local line = ix.progression.GetCharacterProgressionLine(character, progressionID)
	line.value = line.value or 0
	line.complexData = line.complexData or {}
	line.hasfuncrun = line.hasfuncrun or {}

	return line
end

function ix.progression.IsCompleted(character, progressionID)
	local line = ix.progression.GetLine(character, progressionID)
	local definition = ix.progression.definitions[progressionID]
	if line.completed then
		return true
	end
	if definition and definition.milestoneGroup and definition.milestoneGroup ~= progressionID then
		return ix.progression.GetLine(character, definition.milestoneGroup).completed == true
	end

	return false
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
	for _, required in ipairs(definition.prerequisites or {}) do
		if not ix.progression.IsCompleted(character, required) then
			return false
		end
	end
	if definition.milestoneGroup and definition.milestoneGroup ~= progressionID then
		local final = ix.progression.GetLine(character, definition.milestoneGroup)
		if final.completed then
			return false
		end
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
		if definition.keyNpc == npcIdentifier and ix.progression.CanUseNPC(character, npcIdentifier)
			and ix.progression.IsActive(character, progressionID) then
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
	if itemID:match("^meal_") or itemID:match("^meat_") then return false end
	if not ix.progression.CanUseNPC(character, npcName) then
		return false
	end
	if ix.townNPCs then
		local allowed = ix.townNPCs:CanBuyItem(character, itemID, npcName)
		if allowed ~= nil then return allowed end
	end
	local locked = false
	for progressionID, definition in pairs(ix.progression.definitions) do
		for _, unlock in ipairs(definition.vendorUnlocks or {}) do
			if unlock.npc == npcName and unlock.args[1] == itemID then
				locked = true
				if ix.progression.IsCompleted(character, progressionID)
					or (unlock.threshold and ix.progression.GetProgressionValue(character, progressionID) >= unlock.threshold) then
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
		if line.completed then
			return
		end
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
		if ix.townNPCs then ix.townNPCs:OnCompleted(character, progressionID) end
		ix.progression.AssignActiveRequirements(character)
		local client = character:GetPlayer()
		if ix.vendorStock and ix.vendorStock.Refresh and IsValid(client) and IsValid(client.ixVendorAdv) then
			ix.vendorStock.Refresh(character, client.ixVendorAdv)
		end
		if ix.progression.UnlockWorldNPC then
			ix.progression.UnlockWorldNPC(progressionID)
		end
	end

	function ix.progression.Notify(character, name, message)
		local client = character:GetPlayer()
		if IsValid(client) and client:GetCharacter() == character then
			local npc = ix.progression.GetNPCFromName(name)
			if not IsValid(npc) then
				client:Notify(name .. ": " .. message)

				return
			end
			local receivers = {}
			local range = ix.config.Get("chatRange", 280)
			for _, listener in ipairs(player.GetHumans()) do
				if listener:GetPos():DistToSqr(npc:GetPos()) <= range ^ 2 then
					receivers[#receivers + 1] = listener
				end
			end
			ix.chat.Send(nil, "cotz_npc_say", message, false, receivers, {name = name})
		end
	end

	local function canAdvance(character, progressionID)
		local definition = ix.progression.definitions[progressionID]

		return definition
			and (definition.progMap == game.GetMap() or definition.progMap == "*")
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
			if definition.completionBenefits then
				ix.progression.GrantBenefits(character, progressionID, definition.completionBenefits, "completion")
			end
			if definition.completionMessage then
				local message = definition.completionMessage
				if not definition.townContact then message = character:GetName() .. ", " .. message end
				ix.progression.Notify(character, definition.keyNpc,
					message)
			end
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
		local requirements = ix.progression.GetRequirements(character, progressionID)
		local itemID = ix.progression.GetRequirementKey(progressionID, data[1], character)
		local amount = data[2]
		local required = requirements[itemID]
		if not required or not isnumber(amount) or amount ~= amount or amount <= 0 or amount == math.huge then
			return false
		end
		local line = ix.progression.GetLine(character, progressionID)
		local definition = ix.progression.definitions[progressionID]
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
		end)
		if completed then
			ix.progression.SetCompleted(character, progressionID)
			ix.progression.PayCompletionRewards(character, progressionID)
			local definition = ix.progression.definitions[progressionID]
			if definition.OnComplete then
				definition.OnComplete(character)
			end
			if definition.completionMessage then
				local message = definition.completionMessage
				if not definition.townContact then message = character:GetName() .. ", " .. message end
				ix.progression.Notify(character, definition.keyNpc,
					message)
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
			or not (definition.progMap == game.GetMap() or definition.progMap == "*")
			or not ix.progression.CanUseNPC(character, definition.keyNpc)
		then
			return false
		end
		if itemID == "claim" then return false end
		if not canAdvance(character, progressionID) then
			return false
		end
		local requirements = ix.progression.GetRequirements(character, progressionID)
		local requirementKey = ix.progression.GetRequirementKey(progressionID, itemID, character)
		local required = requirements[requirementKey]
		if not required then
			return false
		end
		local remaining = required
			- (ix.progression.GetComplexProgressionValue(character, progressionID)[requirementKey] or 0)
		local item = character:GetInventory():HasItem(itemID)
		if not item or remaining <= 0 or item:GetData("equip", false) == true then
			return false
		end
		local available = item:GetData("quantity", item.quantity or item.ammoAmount or 1)
		if not isnumber(available) or available ~= available or available == math.huge then
			return false
		end
		local size = ix.progression.GetRequirementUnitSize(progressionID, itemID, character)
		local amount = math.min(math.floor(available / size), remaining)
		if amount <= 0 then
			return false
		end
		local consumed = amount * size
		local itemName = item.name or ix.item.list[itemID].name
		local reputation, money = ix.util.GetValueFromProgressionTurnin(item, consumed, itemID)
		-- Consume before running completion callbacks or giving rewards.
		if consumed == available then
			if item:Remove() == false then
				return false
			end
		else
			item:SetData("quantity", available - consumed)
		end
		ix.dialogue.notifyItemLost(client, string.format("%s x%d", itemName, consumed))
		ix.progression.AccrueTurnInRewards(character, progressionID, reputation, money, itemID)
		ix.progression.AddComplexProgressionValue(character, progressionID, { itemID, amount })
		character:Save()
		local response = string.format("Received %d x %s. ", consumed, itemName)
		if ix.progression.IsCompleted(character, progressionID) then
			response = response .. "Task complete. Claim any pending rewards here."
		elseif remaining > amount then
			response = response .. string.format("Still needed: %d.", remaining - amount)
		else
			response = response .. "Bring the remaining items."
		end

		return true, response
	end
end
