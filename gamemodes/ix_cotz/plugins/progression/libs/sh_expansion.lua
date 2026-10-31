ix.progression = ix.progression or {}

local function includesItem(items, itemID)
	for _, eligible in ipairs(items) do
		if eligible == itemID then
			return true
		end
	end

	return false
end

local function definitionBonus(definition, npcName, itemID)
	local bonus = 0
	for _, reward in ipairs(definition.stockUnlocks or {}) do
		if reward.npc == npcName and includesItem(reward.items, itemID) then
			bonus = math.max(bonus, reward.bonus)
		end
	end

	return bonus
end

function ix.progression.GetStockBonus(character, npcName, itemID)
	if not character or not ix.progression.CanBuyItem(character, npcName, itemID) then
		return 0
	end
	local bonus = 0
	for id, definition in pairs(ix.progression.definitions) do
		if definition.stockUnlocks and ix.progression.IsCompleted(character, id) then
			bonus = math.max(bonus, definitionBonus(definition, npcName, itemID))
		end
	end

	return bonus
end

function ix.progression.BuildDeliveryResponse(self, npcName, status, character)
	local line = character and ix.progression.GetLine(character, self.id) or status or {}
	local parts = {self.name}
	if self.briefing then parts[#parts + 1] = self.briefing end
	if self.stageCount then
		parts[#parts + 1] = string.format("Part %d of %d. "
			.. "Final equipment authorisation requires the complete programme.", self.stageIndex, self.stageCount)
	end
	if line.completed then
		parts[#parts + 1] = "Programme complete. Claim any pending item rewards below."
	elseif self.progressthresholds then
		local value = line.value or 0
		parts[#parts + 1] = string.format("Qualified matches completed: %d/%d.", value,
			self.progressthresholds[#self.progressthresholds])
	else
		parts[#parts + 1] = "REQUIRED ITEMS:"
		for itemID, amount in pairs(ix.progression.GetRequirements(character, self.id)) do
			parts[#parts + 1] = string.format("%d %s", amount - (line.complexData[itemID] or 0),
				ix.item.list[itemID].name)
		end
	end
	for _, unlock in ipairs(self.vendorUnlocks or {}) do
		parts[#parts + 1] = "Purchase access: " .. ix.item.list[unlock.args[1]].name
	end
	for _, unlock in ipairs(self.stockUnlocks or {}) do
		parts[#parts + 1] = string.format("Stock reward: +%d maximum stock for selected items.",
			unlock.bonus)
		parts[#parts + 1] = "Refill speed unchanged; no automatic refill."
	end

	return table.concat(parts, "\n")
end

function ix.progression.DescribeItemReward(reward)
	local item = ix.item.list[reward.item]
	local quantity = reward.quantity or (reward.data or {}).quantity or item.quantity or item.ammoAmount
	if type(quantity) ~= "number" or quantity <= 0 then return item.name end
	local unit = "uses"
	if reward.item == "bagrubles" then
		unit = quantity == 1 and "ruble" or "rubles"
	elseif item.isAmmo or item.ammoAmount then
		unit = quantity == 1 and "round" or "rounds"
	elseif quantity == 1 then
		unit = "use"
	end

	return item.name .. " (" .. quantity .. " " .. unit .. ")"
end

local function benefitText(benefits)
	local parts = {}
	for _, reward in ipairs(benefits.items or {}) do
		parts[#parts + 1] = "One " .. ix.progression.DescribeItemReward(reward)
	end
	for _, reward in ipairs(benefits.services or {}) do
		parts[#parts + 1] = string.format("%d %s credit at %s", reward.amount, reward.service, reward.npc)
	end

	return parts
end

function ix.progression.GetBenefitSummary(definition, character)
	local parts = benefitText(definition.completionBenefits or {})
	for _, reward in ipairs(definition.serviceDiscounts or {}) do
		parts[#parts + 1] = string.format("%g%% %s discount at %s", reward.fraction * 100,
			reward.service, reward.npc)
	end
	if definition.recognition then parts[#parts + 1] = "Recognition: " .. definition.recognition end
	local value = ix.progression.GetProgressionValue(character, definition.id)
	for level, threshold in ipairs(definition.progressthresholds or {}) do
		if threshold > value then
			local benefits = definition.checkpointBenefits and definition.checkpointBenefits[level]
			for _, part in ipairs(benefitText(benefits or {})) do
				parts[#parts + 1] = "Next checkpoint: " .. part
			end
			break
		end
	end

	return table.concat(parts, "; ")
end

function ix.progression.DescribeTask(definition, npcName, status, character)
	local line = ix.progression.GetLine(character, definition.id)
	if line.completed then
		return ix.progression.BuildDeliveryResponse(definition, npcName, status, character)
	end
	local text = definition:BuildResponse(npcName, status, character)
	local benefits = ix.progression.GetBenefitSummary(definition, character)
	if benefits ~= "" then text = text .. "\nRewards: " .. benefits end
	-- Town responses already include the shared stock reward summary.
	if definition.BuildResponse ~= ix.progression.BuildDeliveryResponse and not definition.townContact then
		for _, reward in ipairs(definition.stockUnlocks or {}) do
			text = text .. string.format("\nStock reward: +%d maximum stock "
				.. "for selected items; refill speed unchanged.", reward.bonus)
		end
	end

	return text
end

function ix.progression.GetDeliveryOptions(character, progressionID)
	local definition = ix.progression.definitions[progressionID]
	if not definition then
		return {}
	end
	local line = ix.progression.GetLine(character, progressionID)
	local options = {}
	local function addOption(label, data)
		options[#options + 1] = {statement = label, topicID = "ViewProgression", dyndata = data}
	end
	if line.pendingRewards and #line.pendingRewards > 0 then
		addOption("Claim pending reward", {progid = progressionID, itemid = "claim"})
	end
	if not ix.progression.IsActive(character, progressionID) then
		return options
	end
	for itemID, amount in pairs(ix.progression.GetRequirements(character, progressionID)) do
		if (line.complexData[itemID] or 0) < amount and character:GetInventory():HasItem(itemID) then
			addOption("Hand over " .. ix.item.list[itemID].name, {progid = progressionID, itemid = itemID})
		end
	end

	table.sort(options, function(first, second)
		local firstClaim, secondClaim = first.dyndata.itemid == "claim", second.dyndata.itemid == "claim"
		if firstClaim ~= secondClaim then return firstClaim end

		return first.statement < second.statement
	end)

	return options
end

if SERVER then
	local CLAIM_DATA_KEY = "progressionRewardClaim"

	function ix.progression.PrepareReward(character, progressionID, line, reward)
		line.rewardSerial = (line.rewardSerial or 0) + 1
		local owner = character.GetID and character:GetID() or tostring(character)
		reward.token = tostring(owner) .. "/" .. progressionID .. "/" .. line.rewardSerial

		return reward
	end

	function ix.progression.QueueReward(character, progressionID, reward)
		local record = ix.progression.GetCharacterProgression(character)
		local line = ix.progression.GetLine(character, progressionID)
		line.pendingRewards = line.pendingRewards or {}
		line.pendingRewards[#line.pendingRewards + 1] =
			ix.progression.PrepareReward(character, progressionID, line, reward)
		record.lines[progressionID] = line
		ix.progression.SetCharacterProgression(character, record)
		character:Save()
	end

	local function finishClaim(character, progressionID, token)
		local record = ix.progression.GetCharacterProgression(character)
		local line = record.lines[progressionID]
		local reward = line and line.pendingRewards and line.pendingRewards[1]
		if not reward or reward.token ~= token then
			return false
		end
		table.remove(line.pendingRewards, 1)
		line.claiming = nil
		ix.progression.SetCharacterProgression(character, record)
		character:Save()
		ix.dialogue.notifyItemGet(character:GetPlayer(), ix.progression.DescribeItemReward(reward))
		hook.Run("cotz/progression/reward-claimed", character, progressionID, line)

		return true
	end

	function ix.progression.ClaimRewards(character, progressionID)
		local line = ix.progression.GetLine(character, progressionID)
		if line.claiming or not line.pendingRewards or #line.pendingRewards == 0 then
			return false
		end
		local reward = line.pendingRewards[1]
		local inventory = character:GetInventory()
		for _, item in pairs(inventory.GetItems and inventory:GetItems() or {}) do
			if item:GetData(CLAIM_DATA_KEY) == reward.token then
				return finishClaim(character, progressionID, reward.token)
			end
		end
		-- Helix returns a reserved slot before its asynchronous item insert completes.
		line.claiming = true
		local record = ix.progression.GetCharacterProgression(character)
		record.lines[progressionID] = line
		ix.progression.SetCharacterProgression(character, record)
		character:Save()
		local data = table.Copy(reward.data or {})
		if reward.quantity then data.quantity = reward.quantity end
		data[CLAIM_DATA_KEY] = reward.token
		local delivered = inventory:Add(reward.item, 1, data)
		if delivered == true then
			-- Synchronous inventory implementations can acknowledge delivery immediately.
			finishClaim(character, progressionID, reward.token)
		elseif not delivered then
			record = ix.progression.GetCharacterProgression(character)
			record.lines[progressionID].claiming = nil
			ix.progression.SetCharacterProgression(character, record)
			character:Save()
		end

		return delivered ~= false and delivered ~= nil
	end

	hook.Add("InventoryItemAdded", "cotz/progression/confirm-reward", function(_, inventory, item)
		local token = item:GetData(CLAIM_DATA_KEY)
		if not token then
			return
		end
		local character = ix.char and ix.char.loaded[inventory.owner]
		if not character then
			return
		end
		local record = ix.progression.GetCharacterProgression(character)
		for id, line in pairs(record.lines) do
			local reward = line.pendingRewards and line.pendingRewards[1]
			if reward and reward.token == token then
				finishClaim(character, id, token)
				break
			end
		end
	end)
end
