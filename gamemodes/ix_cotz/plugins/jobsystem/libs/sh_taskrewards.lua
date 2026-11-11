ix.taskRewards = ix.taskRewards or {}
local SUPPLY_CATALOGUE_VERSION = ix.taskRewards.settings.supplyCatalogueVersion
local MAX_PACKAGE_ITEMS = ix.taskRewards.settings.maxPackageItems
local CHOICE_COUNT = ix.taskRewards.settings.choiceCount
local JOB_SUPPLY_SHARE = ix.taskRewards.settings.jobSupplyShare
local JOB_MAX_SUPPLY_ITEMS = ix.taskRewards.settings.jobMaxSupplyItems
local JOB_MIN_SUPPLY_BUDGET = ix.taskRewards.settings.jobMinSupplyBudget
local BONUS_INTERVAL = ix.taskRewards.settings.bonusInterval
local CREDIT_PREMIUM = ix.taskRewards.settings.creditPremium
local JOB_SUPPLY_CASH_SHARE = ix.taskRewards.settings.jobSupplyCashShare
local JOB_CASH_RATE = ix.taskRewards.settings.jobCashRate
local JOB_REFERENCE_CASH_RATE = ix.taskRewards.settings.jobReferenceCashRate
local CASH_ROUNDING_EPSILON = ix.taskRewards.settings.cashRoundingEpsilon
local MAX_DEPTH = ix.taskRewards.settings.maxDepth
local townProfiles = {}

function ix.taskRewards.SetProfile(npc, items)
	ix.taskRewards.settings.profiles[npc] = table.Copy(items)
end

function ix.taskRewards.SetTownProfile(npc, profile)
	townProfiles[npc] = table.Copy(profile)
end

local function average(value, default)
	if type(value) == "table" then
		return ((value[1] or default) + (value[2] or value[1] or default)) / 2
	end

	return type(value) == "number" and value or default
end

function ix.taskRewards.UnitValue(itemID)
	local item = assert(ix.item.list[itemID], "Unknown task reward: " .. tostring(itemID))
	if itemID == "bagrubles" then return 1 end
	local units = average(item.quantity or item.ammoAmount, 1)

	local value = item.price or 0
	if item.GetPrice then
		local quote = setmetatable({GetData = function(_, key, default)
			if key == "quantity" then return units end

			return default
		end}, {__index = item})
		-- Weight-priced items can quote zero before their instance weight exists.
		local quotedValue = quote:GetPrice()
		if quotedValue ~= 0 then value = quotedValue end
	end

	return math.max(0, value) / math.max(1, units)
end

local expectedItem
local function expectedPool(poolID, depth)
	local pool = ix.randomitems.tables[poolID]
	assert(pool and #pool > 0, "Unknown task reward pool: " .. tostring(poolID))
	local weight, value = 0, 0
	for _, entry in ipairs(pool) do
		weight = weight + entry[1]
		value = value + entry[1] * expectedItem(entry[2][1], entry[2][2], depth + 1)
	end

	return weight > 0 and value / weight or 0
end

expectedItem = function(itemID, data, depth)
	assert(depth <= MAX_DEPTH, "Recursive task reward kit: " .. tostring(itemID))
	local item = assert(ix.item.list[itemID], "Unknown task reward: " .. tostring(itemID))
	if type(item.items) ~= "table" or #item.items == 0 then
		local generated = ix.taskRewards.settings.generatedQuantities[itemID]
			or average(item.quantity or item.ammoAmount, 1)
		local quantity = average((data or {}).quantity, generated)
		local condition = item.isWeapon and average((data or {}).durability, 100) / 100 or 1

		return ix.taskRewards.UnitValue(itemID) * quantity * condition
	end
	local value = 0
	for _, slot in ipairs(item.items) do
		local weight, slotValue = 0, 0
		for _, entry in ipairs(slot) do
			weight = weight + entry[1]
			slotValue = slotValue + entry[1] * expectedPool(entry[2], depth + 1)
		end
		value = value + (weight > 0 and slotValue / weight or 0)
	end
	for _, entry in ipairs(item.itemsForcedDrop or {}) do
		value = value + expectedItem(entry[1], entry[2], depth + 1)
	end

	return value
end

function ix.taskRewards.ExpectedValue(itemID, data)
	return expectedItem(itemID, data, 0)
end

function ix.taskRewards.IsTaskKit(itemID)
	if not itemID:match("^kit_") then return false end
	if itemID:match("^kit_reward_") then return true end
	for _, job in pairs(ix.jobs and ix.jobs.list or {}) do
		for _, entry in ipairs(type(job.reward) == "table" and job.reward or {job.reward}) do
			local id = type(entry) == "table" and entry[1] or entry
			if id == itemID and itemID:match("^kit_") then return true end
		end
	end

	return itemID == "kit_ammo_rare" or itemID == "kit_ammo_m_rare"
end

local function equipmentChoices(character, npc, budget, minimum)
	local result, used = {}, {}
	local function consider(itemID)
		local item = ix.item.list[itemID]
		local value = item and ix.taskRewards.UnitValue(itemID) or 0
		if not used[itemID] and item and (item.isWeapon or item.isBodyArmor)
			and value >= (minimum or budget * 0.6) and value <= budget
			and ix.progression.CanBuyItem(character, npc, itemID) then
			result[#result + 1] = itemID
			used[itemID] = true
		end
	end
	for _, template in pairs(ix.npctemplates and ix.npctemplates.templates or {}) do
		if template.name == npc then
			for id, data in pairs(template.items) do
				if data[3] ~= 3 then consider(id) end
			end
		end
	end
	for _, definition in pairs(ix.progression.definitions) do
		for _, unlock in ipairs(definition.vendorUnlocks or {}) do
			if unlock.npc == npc then consider(unlock.args[1]) end
		end
	end
	table.sort(result)

	return result
end

function ix.taskRewards.SupplyCatalogueVersion()
	return SUPPLY_CATALOGUE_VERSION
end

function ix.taskRewards.IsConsumableSupply(itemID)
	local item = ix.item.list[itemID]
	if not item or item.isWeapon or item.isBodyArmor or item.isFieldCargo then return false end
	if itemID == "value_currency_euro" or itemID == "value_currency_dollar" then return true end
	if itemID:match("^value_") then return false end
	local parent = item
	for _ = 1, MAX_DEPTH do
		if parent.base == "base_valuable" or parent.base == "base_valuables_test"
			or parent.base == "base_quests" then return false end
		parent = ix.item.base and ix.item.base[parent.base]
		if not parent then break end
	end
	if itemID == "hidestash_1" or itemID == "hidestash_2" or itemID == "hidestash_3" then return true end
	if item.isAmmo or item.sharpnessRestored then return true end
	local consumable = item.base == "base_aid" or item.base == "base_consumables"
		or item.base == "base_hidestashers" or itemID == "hidestasher_cleaningkit"
		or itemID:match("^medic_") or itemID:match("^drug_")
		or itemID:match("^food_") or itemID:match("^drink_") or itemID == "lowtiercookerfuel"

	return consumable and type(item.quantity) == "number" and item.quantity > 0 or false
end

local function canReceiveSupply(character, npc, itemID)
	if not ix.taskRewards.IsConsumableSupply(itemID) then return false end

	return ix.progression.CanUseNPC(character, npc)
end

function ix.taskRewards.SupplyCatalogue(character, npc)
	local result, seen = {}, {}
	local function consider(itemID)
		if not seen[itemID] and canReceiveSupply(character, npc, itemID) then
			result[#result + 1] = itemID
			seen[itemID] = true
		end
	end
	local profile = townProfiles[npc]
	if profile then
		for _, package in ipairs(profile.packages) do
			for _, itemID in ipairs(package.items) do consider(itemID) end
		end
		table.sort(result)

		return result
	end
	for _, itemID in ipairs(ix.taskRewards.settings.profiles[npc] or ix.taskRewards.settings.profiles["NPC"]) do
		consider(itemID)
	end
	for _, definition in pairs(ix.progression.definitions) do
		for _, unlock in ipairs(definition.vendorUnlocks or {}) do
			if unlock.npc == npc then consider(unlock.args[1]) end
		end
	end
	table.sort(result)

	return result
end

local function fixedMoney(job, count, deliveredValue, rate)
	if job.requiredItem then
		local amount = count or average(job.numberRec, 1)
		local reference = ix.taskRewards.HandInUnitValue(job.requiredItem, nil, job.wholeItems) * amount
		local base = ix.taskRewards.settings.jobHandInBaseMoney[math.Clamp(job.tier or 1, 1, 3)]

		return base + math.ceil(math.max(reference, deliveredValue or 0) * rate - CASH_ROUNDING_EPSILON)
	end
	local base = average(job.moneyReward, 0) + ix.taskRewards.JobBudget(job) * JOB_SUPPLY_CASH_SHARE

	return math.ceil(base * rate - CASH_ROUNDING_EPSILON)
end

function ix.taskRewards.SupplyBudget(job, count)
	if job.requiredItem then
		local base = ix.taskRewards.settings.jobHandInBaseMoney[math.Clamp(job.tier or 1, 1, 3)]

		return math.max(JOB_MIN_SUPPLY_BUDGET, math.floor(base * JOB_SUPPLY_SHARE))
	end

	return math.max(JOB_MIN_SUPPLY_BUDGET,
		math.floor(fixedMoney(job, count, nil, JOB_REFERENCE_CASH_RATE) * JOB_SUPPLY_SHARE))
end

function ix.taskRewards.BonusInterval()
	return BONUS_INTERVAL
end

function ix.taskRewards.TraderBonusProgress(character, npc)
	local state = character:GetData("taskCompletionBonus", {})
	if state.traders then return table.Copy(state.traders[npc] or {}) end
	local latestNPC, latestClaim = nil, 0
	for trader, claim in pairs(state.claims or {}) do
		if claim > latestClaim then latestNPC, latestClaim = trader, claim end
	end
	if npc == latestNPC then return {count = state.count or 0, budget = state.budget or 0} end

	return {}
end

function ix.taskRewards.BonusStatus(character, npc)
	local progress = ix.taskRewards.TraderBonusProgress(character, npc)

	return string.format("Five-task bonus with %s: %d/%d completed. Reward revealed when earned.",
		npc, progress.count or 0, ix.taskRewards.BonusInterval())
end

local function themedChoices(character, npc, budget, seed, maximumItems, packages)
	local result = {}
	local hash = 0
	for index = 1, #seed do hash = (hash * 31 + seed:byte(index)) % 65521 end
	for _, package in ipairs(packages) do
		local candidates = {}
		for _, itemID in ipairs(package.items) do
			local item = ix.item.list[itemID]
			local unit = item and ix.taskRewards.UnitValue(itemID) or 0
			local minimum = item and item.isAmmo
				and math.floor(item.ammoAmount * ix.taskRewards.settings.ammoRewardFraction) or 1
			if unit > 0 and unit * minimum <= budget and canReceiveSupply(character, npc, itemID) then
				candidates[#candidates + 1] = itemID
			end
		end
		if #candidates > 0 then
			local itemID = candidates[hash % #candidates + 1]
			local item = ix.item.list[itemID]
			local stack = math.max(1, math.floor(average(item.quantity or item.ammoAmount, 1)))
			local quantity = item.isAmmo and math.floor(stack * ix.taskRewards.settings.ammoRewardFraction)
				or math.min(stack * maximumItems, math.floor(budget / ix.taskRewards.UnitValue(itemID)))
			local rewards, remaining = {}, quantity
			while remaining > 0 do
				local units = math.min(stack, remaining)
				rewards[#rewards + 1] = {item = itemID,
					data = (item.quantity or item.ammoAmount) and {quantity = units} or {}}
				remaining = remaining - units
			end
			local unitLabel = item.isAmmo and " rounds" or itemID:match("^value_currency_") and " notes" or " uses"
			local amount = (item.quantity or item.ammoAmount) and " (" .. quantity .. unitLabel .. ")"
				or " x" .. quantity
			result[#result + 1] = {label = package.label .. ": " .. item.name .. amount, items = rewards}
		end
	end

	return result
end

function ix.taskRewards.ChoiceValue(choice)
	local value = choice.money or 0
	for _, reward in ipairs(choice.items or {}) do
		value = value + ix.taskRewards.ExpectedValue(reward.item, reward.data)
	end

	return value
end

function ix.taskRewards.BuildJobChoices(character, npc, budget, seed, tier)
	local profile = townProfiles[npc]
	if profile and not ix.progression.CanUseNPC(character, npc) then return {} end
	if profile and profile.cashPerTier then
		local money = profile.cashPerTier * math.Clamp(tier or 1, 1, 3)

		return {{label = "Payment: " .. money .. " rubles", money = money, items = {}}}
	end
	if profile then
		return themedChoices(character, npc, budget, seed, JOB_MAX_SUPPLY_ITEMS, profile.packages)
	end
	local candidates = {}
	for _, itemID in ipairs(ix.taskRewards.SupplyCatalogue(character, npc)) do
		local unit = ix.taskRewards.UnitValue(itemID)
		local item = ix.item.list[itemID]
		local minimum = item.isAmmo and math.floor(item.ammoAmount * ix.taskRewards.settings.ammoRewardFraction) or 1
		if unit > 0 and unit * minimum <= budget then candidates[#candidates + 1] = itemID end
	end
	local hash = 0
	for index = 1, #seed do hash = (hash * 31 + seed:byte(index)) % 65521 end
	local result = {}
	for index = 1, math.min(CHOICE_COUNT, #candidates) do
		local itemID = candidates[(hash + index - 1) % #candidates + 1]
		local item = ix.item.list[itemID]
		local capacity = math.max(1, math.floor(average(item.quantity or item.ammoAmount, 1)))
		local units = item.isAmmo and math.floor(capacity * ix.taskRewards.settings.ammoRewardFraction)
			or math.min(capacity * JOB_MAX_SUPPLY_ITEMS, math.floor(budget / ix.taskRewards.UnitValue(itemID)))
		local rewards, labels = {}, {}
		while units > 0 do
			local quantity = math.min(capacity, units)
			local data = (item.quantity or item.ammoAmount) and {quantity = quantity} or {}
			rewards[#rewards + 1] = {item = itemID, data = data}
			labels[#labels + 1] = item.name .. ((item.quantity or item.ammoAmount)
				and " (" .. quantity .. (item.isAmmo and " rounds)" or " uses)") or " x1")
			units = units - quantity
		end
		result[#result + 1] = {label = table.concat(labels, " + "), items = rewards}
	end

	return result
end

function ix.taskRewards.BuildBonusChoices(character, npc, budget, seed)
	local profile = townProfiles[npc]
	if profile and not ix.progression.CanUseNPC(character, npc) then return {} end
	if profile then
		local choices = themedChoices(character, npc, budget, seed, MAX_PACKAGE_ITEMS,
			profile.bonusPackages or profile.packages)
		if profile.bonusCash and budget >= 1 then
			local money = math.floor(budget)
			choices[#choices + 1] = {label = "Payment: " .. money .. " rubles", money = money, items = {}}
		end

		return choices
	end
	local catalogue = ix.taskRewards.SupplyCatalogue(character, npc)
	local choices = ix.taskRewards.BuildChoices(character, npc, budget, seed, catalogue, true)
	local credit = math.floor(budget * CREDIT_PREMIUM)
	if (npc == "'Technut'" or npc == "'Boss'") and credit > 0
		and ix.progression.ServiceCreditCapacity(character, npc, "repair") >= credit then
		choices[#choices + 1] = {label = npc .. " repair credit: " .. credit .. " rubles", items = {},
			services = {{npc = npc, service = "repair", amount = credit}}}
	end

	return choices
end

function ix.taskRewards.BuildChoices(character, npc, budget, seed, catalogue, suppliesOnly)
	local candidates = {}
	for _, itemID in ipairs(catalogue
		or ix.taskRewards.settings.profiles[npc] or ix.taskRewards.settings.profiles["NPC"]) do
		local item = ix.item.list[itemID]
		local unit = item and ix.taskRewards.UnitValue(itemID) or 0
		local eligible = suppliesOnly and canReceiveSupply(character, npc, itemID)
			or not suppliesOnly and ix.progression.CanBuyItem(character, npc, itemID)
		local minimum = suppliesOnly and item and item.isAmmo
			and math.floor(item.ammoAmount * ix.taskRewards.settings.ammoRewardFraction) or 1
		if unit > 0 and unit * minimum <= budget and eligible then
			candidates[#candidates + 1] = itemID
		end
	end
	local hash = 0
	for index = 1, #seed do hash = (hash * 31 + seed:byte(index)) % 65521 end
	local equipment = not catalogue and equipmentChoices(character, npc, budget) or {}
	local result = {}
	local count = math.min(CHOICE_COUNT, #candidates + (#equipment > 0 and 1 or 0))
	for index = 1, count do
		local isEquipment = #equipment > 0 and index == count
		local selected = #candidates > 0 and (hash + index - 1) % #candidates + 1 or 1
		local itemID = isEquipment and equipment[hash % #equipment + 1] or candidates[selected]
		local item = ix.item.list[itemID]
		local stack = math.max(1, math.floor(average(item.quantity or item.ammoAmount, 1)))
		local quantity = suppliesOnly and item.isAmmo
			and math.floor(stack * ix.taskRewards.settings.ammoRewardFraction)
			or isEquipment and 1 or math.floor(budget / ix.taskRewards.UnitValue(itemID))
		local rewards = {}
		for _ = 1, MAX_PACKAGE_ITEMS do
			if quantity <= 0 then break end
			local count = math.min(stack, quantity)
			rewards[#rewards + 1] = {item = itemID, data = (item.quantity or item.ammoAmount)
				and {quantity = count} or {}}
			quantity = quantity - count
		end
		local units = suppliesOnly and item.isAmmo
			and math.floor(stack * ix.taskRewards.settings.ammoRewardFraction)
			or isEquipment and 1
			or math.min(math.floor(budget / ix.taskRewards.UnitValue(itemID)), stack * MAX_PACKAGE_ITEMS)
		local remainder = math.floor(budget - units * ix.taskRewards.UnitValue(itemID))
		local label = item.name .. " x" .. units
		if remainder > 0 and not suppliesOnly then
			rewards[#rewards + 1] = {item = "bagrubles", data = {quantity = remainder}}
			label = label .. " + " .. remainder .. " rubles"
		end
		result[#result + 1] = {label = label, items = rewards}
	end
	if #result == 0 and budget >= 1 and not suppliesOnly then
		result[1] = {label = "Reward allowance: " .. math.floor(budget) .. " rubles",
			items = {{item = "bagrubles", data = {quantity = math.floor(budget)}}}}
	end

	return result
end

function ix.taskRewards.JobBudget(job)
	local budget = 0
	local rewards = type(job.reward) == "table" and job.reward or {job.reward}
	for _, entry in ipairs(rewards) do
		local itemID = type(entry) == "table" and entry[1] or entry
		if type(itemID) == "string" then
			budget = budget + ix.taskRewards.ExpectedValue(itemID, type(entry) == "table" and entry[2] or nil)
		end
	end

	return budget
end

function ix.taskRewards.HandInUnitValue(itemID, instance, wholeItem)
	local item = assert(ix.item.list[itemID], "Unknown task requirement: " .. tostring(itemID))
	local quotedItem = instance or item
	local units = average(quotedItem.quantity or quotedItem.ammoAmount, 1)
	local value = ix.taskRewards.UnitValue(itemID)
	if instance and instance.GetPrice then
		units = math.max(1, instance:GetData("quantity", units))
		value = instance:GetPrice() / units
	end
	local baseValue = value
	local function consider(vendor)
		local entry = (vendor.items or {})[itemID]
		if not vendor.buyAll and (not entry or entry[3] == 2) then return end
		local price = entry and entry[1]
		local sale = price and price < 5 and baseValue * price
			or (price and price / units or baseValue) * (vendor.scale or 0.5)
		value = math.max(value, sale)
	end
	-- Include configured traders even when their map entity has not spawned yet.
	for _, vendor in pairs(ix.npctemplates and ix.npctemplates.templates or {}) do consider(vendor) end
	if SERVER and ents then
		for _, vendor in ipairs(ents.FindByClass("ix_vendor_adv")) do
			consider({items = vendor.items, scale = vendor.scale, buyAll = vendor:GetBuyAll()})
		end
	end

	return wholeItem and value * units or value
end

function ix.taskRewards.FixedMoney(job, count, deliveredValue)
	local rate = job.requiredItem and JOB_CASH_RATE or JOB_REFERENCE_CASH_RATE

	return fixedMoney(job, count, deliveredValue, rate)
end

function ix.taskRewards.CanTakeDifficulty(character, difficulty)
	if difficulty == "easy" then return true end
	local required = ix.taskRewards.settings.difficultyReputation[difficulty]

	return required ~= nil and character:GetPlayer():getReputation() >= required
end

function ix.taskRewards.HasUnclaimedRewards(character, npc)
	for key, offer in pairs(character:GetData("taskRewardOffers", {})) do
		if offer.npc == npc and offer.earned and (key:match("^job:") or key:match("^bonus:")) then
			return true
		end
	end
	for _, reward in ipairs(ix.progression.GetLine(character, "taskRewardClaims").pendingRewards or {}) do
		-- Older queued rewards have no issuer; collect them before accepting more work anywhere.
		if reward.taskNPC == nil or reward.taskNPC == npc then return true end
	end

	return false
end

function ix.taskRewards.CanSelectOffer(character, npc, key, offer)
	if not offer or offer.npc ~= npc or type(key) ~= "string" then return false end
	if offer.selected and not offer.retrySelected then return false end
	if key:match("^progression:") then return false end
	if offer.earned then return true end
	if not key:match("^job:") and not key:match("^bonus:") then return true end
	if not key:match("^job:") or not offer.ready then return false end
	local job = character:GetJobs()[npc]

	return job ~= nil and job.rewardKey == key and job.isCompleted
		and (not job.fieldTask or ix.jobs.field.CanComplete(character, job)) or false
end

function ix.taskRewards.Summary(offer)
	local labels = {}
	for index, choice in ipairs(offer and offer.choices or {}) do
		labels[#labels + 1] = (offer.selected == index and "[Selected] " or "") .. choice.label
	end

	return table.concat(labels, "; ")
end

function ix.taskRewards.BarterChoices(character, npc, barterID, barter)
	local candidates, seen = {}, {}
	local function visit(itemID, depth)
		assert(depth <= MAX_DEPTH, "Recursive ammunition barter kit")
		local item = ix.item.list[itemID]
		if item.isAmmo and not seen[itemID] then
			candidates[#candidates + 1] = itemID
			seen[itemID] = true
		end
		for _, slot in ipairs(item.items or {}) do
			for _, entry in ipairs(slot) do
				local pool = ix.randomitems.tables[entry[2]]
				for _, drop in ipairs(pool or {}) do visit(drop[2][1], depth + 1) end
			end
		end
	end
	local reward = barter.barterItem
	visit(reward[1], 0)
	table.sort(candidates)
	local budget = ix.taskRewards.ExpectedValue(reward[1], reward[3]) * (reward[2] or 1)

	return ix.taskRewards.BuildChoices(character, npc, budget, "barter:" .. barterID, candidates)
end

function ix.taskRewards.Validate()
	for npc, profile in pairs(townProfiles) do
		assert(profile.cashPerTier or #profile.packages > 0, "Empty reward profile: " .. npc)
		assert(#profile.packages <= CHOICE_COUNT, "Too many reward packages: " .. npc)
		for _, packages in ipairs({profile.packages, profile.bonusPackages or profile.packages}) do
			for _, package in ipairs(packages) do
				assert(type(package.label) == "string" and #package.items > 0, "Empty reward package: " .. npc)
				for _, id in ipairs(package.items) do
					assert(ix.item.list[id], "Unknown town reward: " .. id)
					assert(ix.taskRewards.IsConsumableSupply(id), "Non-consumable town reward: " .. id)
				end
			end
		end
	end
	for _, items in pairs(ix.taskRewards.settings.profiles) do
		for _, id in ipairs(items) do assert(ix.item.list[id], "Unknown contact supply: " .. id) end
	end
	for _, job in pairs(ix.jobs.list) do ix.taskRewards.JobBudget(job) end
	for _, recipes in pairs(ix.npcbarter and ix.npcbarter.barterdict or {}) do
		for _, recipe in pairs(recipes) do
			if ix.taskRewards.IsTaskKit(recipe.barterItem[1]) then
				ix.taskRewards.ExpectedValue(recipe.barterItem[1], recipe.barterItem[3])
			end
		end
	end
end
