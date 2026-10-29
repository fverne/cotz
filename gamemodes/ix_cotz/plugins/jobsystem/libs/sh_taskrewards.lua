ix.taskRewards = ix.taskRewards or {}

local PROFILES = {
	["'Old Timer'"] = {
		"12gauge", "22lr", "9x18", "medic_bandage_1", "medic_bandage_2", "sharpening_stone",
		"sharpening_stone_fine", "drink_bottlewater", "food_can_tushonka", "medic_medkit_1",
	},
	["'Technut'"] = {
		"22lr", "45acp41", "attachment_fabric_1", "attachment_ceramicplate_1", "9x18", "45acp", "medic_bandage_2",
	},
	["'Jitters'"] = {
		"medic_bandage_1", "medic_medkit_1", "medic_bandage_2", "medic_medkit_3", "medic_medkit_2",
		"medic_antirad_1", "drug_painkillers",
	},
	["'Cleaner'"] = {"12gauge", "22lr", "9x19", "medic_bandage_1", "drink_bottlewater", "lowtiercookerfuel"},
	["'Haggler'"] = {
		"12gauge", "9x18", "762x25", "762x39", "762x54", "45acp41", "45acp", "9x19", "food_can_beans",
	},
	["'Spicy Lemon'"] = {
		"drink_bottlewater", "drink_bottletea", "food_can_sprats", "lowtiercookerfuel", "food_bread",
		"food_can_beans", "food_can_corn", "food_raisins", "drug_caffeine",
	},
	["'Mute'"] = {
		"headlamp", "geigercounter", "binoculars_5", "compass", "drink_bottlewater", "medic_bandage_1",
		"drug_caffeine",
	},
	["'Quartermaster'"] = {
		"545x39", "556x45", "762x39", "762x51", "9x19", "medic_bandage_1", "medic_medkit_1", "drug_painkillers",
	},
	["'Boss'"] = {
		"545x39", "556x45", "762x51", "12gaugetr", "medic_bandage_1", "medic_medkit_1", "drug_painkillers",
	},
	["'Smartass'"] = {"9x19", "pso1", "cmore", "acog", "shortdot", "45acp", "medic_medkit_1", "drug_caffeine"},
	["'Egghead'"] = {
		"medic_stimpak_1", "medic_psyheal_2", "medic_antirad_2", "medic_antipsychotic_1", "drug_caffeine",
		"medic_medkit_1",
	},
	["'Beanstalk'"] = {
		"9x19", "medic_antirad_1", "medic_psyheal_1", "medic_antipsychotic_1", "drug_caffeine", "medic_medkit_1",
	},
	["'Intern'"] = {
		"medic_antirad_1", "medic_psyheal_1", "medic_medkit_5", "medic_antipsychotic_1", "drug_caffeine",
		"medic_medkit_1",
	},
	["'Computer'"] = {
		"medic_antirad_1", "medic_psyheal_2", "medic_antipsychotic_1", "drug_caffeine", "medic_medkit_1",
	},
	["'The Original'"] = {
		"food_can_tushonka", "drink_bottlewater", "lowtiercookerfuel", "medic_bandage_1", "food_bread",
		"food_can_beans", "drink_bottletea",
	},
	["'Hoarder'"] = {
		"500magnum", "127x55", "700nitro", "338lapua", "57x28", "45acp", "drug_painkillers", "drink_bottlewater",
	},
	["'Arena Master'"] = {
		"medic_bandage_1", "medic_medkit_1", "medic_bandage_2", "drug_painkillers", "drug_caffeine",
	},
	["'???'"] = {
		"medic_psyheal_2", "medic_antirad_2", "medic_antipsychotic_1", "drug_caffeine", "medic_medkit_1",
	},
	["NPC"] = {"drink_bottlewater", "drink_bottletea", "medic_bandage_1"},
}
local SUPPLY_CATALOGUE_VERSION = 3
local MAX_PACKAGE_ITEMS = 64
local CHOICE_COUNT = 3
local DIFFICULTY_REPUTATION = {medium = 250, hard = 1600}
local JOB_SUPPLY_SHARE = 1
local JOB_MAX_SUPPLY_ITEMS = 2
local JOB_MIN_SUPPLY_BUDGET = 600
local BONUS_INTERVAL = 5
local CREDIT_PREMIUM = 1.3
local JOB_SUPPLY_CASH_SHARE = 0.5
local JOB_CASH_RATE = 0.50
-- Preserve supply budgets and non-delivery cash independently of turn-in payouts.
local JOB_REFERENCE_CASH_RATE = 0.55
local CASH_ROUNDING_EPSILON = 0.000000001
local MAX_DEPTH = 12
local GENERATED_QUANTITIES = {
	value_capacitors = 2.5,
	value_9vbattery = 2.5,
	value_sparkplug = 1.5,
	value_pcpart_ram = 1.5,
	value_screws = 1.5,
	value_pcpart_cpu = 1.5,
	value_nuts = 5.5,
	value_battery = 3.5,
	value_bolts = 6,
	value_gasoline = 2.5,
	value_propanetank = 2.5,
	value_currency_euro = 1,
	value_currency_dollar = 1,
	value_currency_rubles_coins = 1,
}

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
		value = quote:GetPrice()
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
		local generated = GENERATED_QUANTITIES[itemID] or average(item.quantity or item.ammoAmount, 1)
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
	if not item or item.isWeapon or item.isBodyArmor then return false end
	if item.isAmmo or item.sharpnessRestored then return true end
	local consumable = item.base == "base_aid" or item.base == "base_consumables"
		or itemID:match("^medic_") or itemID:match("^drug_")
		or itemID:match("^food_") or itemID:match("^drink_") or itemID == "lowtiercookerfuel"
		or itemID == "hidestasher_cleaningkit"

	return consumable and type(item.quantity) == "number" and item.quantity > 0 or false
end

local function canReceiveSupply(character, npc, itemID)
	return ix.progression.CanUseNPC(character, npc) and ix.taskRewards.IsConsumableSupply(itemID)
end

function ix.taskRewards.SupplyCatalogue(character, npc)
	local result, seen = {}, {}
	local function consider(itemID)
		if not seen[itemID] and canReceiveSupply(character, npc, itemID) then
			result[#result + 1] = itemID
			seen[itemID] = true
		end
	end
	for _, itemID in ipairs(PROFILES[npc] or PROFILES["NPC"]) do consider(itemID) end
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
		local reference = ix.taskRewards.HandInUnitValue(job.requiredItem) * amount

		return math.ceil(math.max(reference, deliveredValue or 0) * rate - CASH_ROUNDING_EPSILON)
	end
	local base = average(job.moneyReward, 0) + ix.taskRewards.JobBudget(job) * JOB_SUPPLY_CASH_SHARE

	return math.ceil(base * rate - CASH_ROUNDING_EPSILON)
end

function ix.taskRewards.SupplyBudget(job, count)
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

	return string.format("Five-task bonus with %s: %d/%d completed\nBonus value earned: %d rubles.",
		npc, progress.count or 0, ix.taskRewards.BonusInterval(), progress.budget or 0)
end

function ix.taskRewards.BuildJobChoices(character, npc, budget, seed)
	local candidates = {}
	for _, itemID in ipairs(ix.taskRewards.SupplyCatalogue(character, npc)) do
		local unit = ix.taskRewards.UnitValue(itemID)
		if unit > 0 and unit <= budget then candidates[#candidates + 1] = itemID end
	end
	local hash = 0
	for index = 1, #seed do hash = (hash * 31 + seed:byte(index)) % 65521 end
	local result = {}
	for index = 1, math.min(CHOICE_COUNT, #candidates) do
		local itemID = candidates[(hash + index - 1) % #candidates + 1]
		local item = ix.item.list[itemID]
		local capacity = math.max(1, math.floor(average(item.quantity or item.ammoAmount, 1)))
		local units = math.min(capacity * JOB_MAX_SUPPLY_ITEMS,
			math.floor(budget / ix.taskRewards.UnitValue(itemID)))
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
	local result = {}
	local catalogue = ix.taskRewards.SupplyCatalogue(character, npc)
	for _, choice in ipairs(ix.taskRewards.BuildChoices(character, npc, budget, seed, catalogue, true)) do
		if choice.items[1].item ~= "bagrubles" then result[#result + 1] = choice end
	end
	local credit = math.floor(budget * CREDIT_PREMIUM)
	if ix.progression.ServiceCreditCapacity
		and ix.progression.ServiceCreditCapacity(character, "'Technut'", "repair") >= credit then
		result[#result + 1] = {label = "Technut repair credit: " .. credit .. " rubles", items = {},
			services = {{npc = "'Technut'", service = "repair", amount = credit}}}
	end

	return result
end

function ix.taskRewards.BuildChoices(character, npc, budget, seed, catalogue, suppliesOnly)
	local candidates = {}
	for _, itemID in ipairs(catalogue or PROFILES[npc] or PROFILES["NPC"]) do
		local item = ix.item.list[itemID]
		local unit = item and ix.taskRewards.UnitValue(itemID) or 0
		local eligible = suppliesOnly and canReceiveSupply(character, npc, itemID)
			or not suppliesOnly and ix.progression.CanBuyItem(character, npc, itemID)
		if unit > 0 and unit <= budget and eligible then
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
		local quantity = isEquipment and 1 or math.floor(budget / ix.taskRewards.UnitValue(itemID))
		local rewards = {}
		for _ = 1, MAX_PACKAGE_ITEMS do
			if quantity <= 0 then break end
			local count = math.min(stack, quantity)
			rewards[#rewards + 1] = {item = itemID, data = (item.quantity or item.ammoAmount)
				and {quantity = count} or {}}
			quantity = quantity - count
		end
		local units = isEquipment and 1
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
		result[1] = {label = "Supply allowance: " .. math.floor(budget) .. " rubles",
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

function ix.taskRewards.HandInUnitValue(itemID, instance)
	local item = assert(ix.item.list[itemID], "Unknown task requirement: " .. tostring(itemID))
	local quotedItem = instance or item
	local units = quotedItem.quantity and average(quotedItem.quantity, 1) or 1
	local value = ix.taskRewards.UnitValue(itemID) * (item.quantity and 1 or average(item.ammoAmount, 1))
	if instance and instance.GetPrice then
		units = quotedItem.quantity and math.max(1, instance:GetData("quantity", units)) or 1
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

	return value
end

function ix.taskRewards.FixedMoney(job, count, deliveredValue)
	local rate = job.requiredItem and JOB_CASH_RATE or JOB_REFERENCE_CASH_RATE

	return fixedMoney(job, count, deliveredValue, rate)
end

function ix.taskRewards.CanTakeDifficulty(character, difficulty)
	if difficulty == "easy" then return true end
	local required = DIFFICULTY_REPUTATION[difficulty]

	return required ~= nil and character:GetPlayer():getReputation() >= required
end

function ix.taskRewards.CanSelectOffer(character, npc, key, offer)
	if not offer or offer.npc ~= npc or type(key) ~= "string" then return false end
	if not key:match("^job:") or offer.earned then return true end
	local job = character:GetJobs()[npc]

	return job ~= nil and job.rewardKey == key
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
	for _, items in pairs(PROFILES) do
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
