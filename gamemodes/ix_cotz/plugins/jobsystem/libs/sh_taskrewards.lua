ix.taskRewards = ix.taskRewards or {}

local PROFILES = {
	["'Old Timer'"] = {"12gauge", "22lr", "9x18", "medic_bandage_1", "medic_bandage_2"},
	["'Technut'"] = {"22lr", "45acp41", "attachment_fabric_1", "attachment_ceramicplate_1"},
	["'Jitters'"] = {"medic_bandage_1", "medic_medkit_1", "medic_bandage_2", "medic_medkit_3"},
	["'Cleaner'"] = {"12gauge", "22lr", "9x19", "hidestash_1", "hidestash_2", "hidestash_3"},
	["'Haggler'"] = {"12gauge", "9x18", "762x25", "762x39", "762x54", "45acp41"},
	["'Spicy Lemon'"] = {"drink_bottlewater", "drink_bottletea", "food_can_sprats", "lowtiercookerfuel"},
	["'Mute'"] = {"headlamp", "geigercounter", "binoculars_5", "compass"},
	["'Quartermaster'"] = {"545x39", "556x45", "762x39", "762x51", "9x19"},
	["'Boss'"] = {"545x39", "556x45", "762x51", "12gaugetr"},
	["'Smartass'"] = {"9x19", "pso1", "cmore", "acog", "shortdot"},
	["'Egghead'"] = {"medic_stimpak_1", "medic_psyheal_2", "medic_antirad_2"},
	["'Beanstalk'"] = {"9x19", "medic_antirad_1", "medic_psyheal_1"},
	["'Intern'"] = {"medic_antirad_1", "medic_psyheal_1", "medic_medkit_5"},
	["'Computer'"] = {"medic_antirad_1", "medic_psyheal_2"},
	["'The Original'"] = {"food_can_tushonka", "drink_bottlewater", "lowtiercookerfuel", "medic_bandage_1"},
	["'Hoarder'"] = {"500magnum", "127x55", "700nitro", "338lapua", "57x28"},
	["'Arena Master'"] = {"medic_bandage_1", "medic_medkit_1"},
	["'???'"] = {"medic_psyheal_2", "medic_antirad_2"},
	["NPC"] = {"drink_bottlewater", "drink_bottletea", "medic_bandage_1"},
}
local MAX_PACKAGE_ITEMS = 64
local CHOICE_COUNT = 3
local DIFFICULTY_REPUTATION = {medium = 250, hard = 1600}
local JOB_EQUIPMENT_LIMITS = {2500, 7500, 15000, 30000, 50000}
local JOB_SUPPLY_CASH_SHARE = 0.5
local JOB_CASH_RATE = 0.55
local CASH_ROUNDING_EPSILON = 0.000000001
local JOB_MIN_FILL = 0.25
local JOB_MAX_FILL = 0.6
local JOB_TIER_FILL = 0.1
local JOB_MIN_CONDITION = 30
local JOB_MAX_CONDITION = 60
local JOB_TIER_CONDITION = 10
local MAX_DEPTH = 12
local GENERATED_QUANTITIES = {
	value_capacitors = 2.5,
	value_9vbattery = 2.5,
	value_sparkplug = 1.5,
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

function ix.taskRewards.BuildJobChoices(character, npc, tier, seed)
	tier = math.Clamp(math.floor(tonumber(tier) or 1), 1, #JOB_EQUIPMENT_LIMITS)
	local candidates = {}
	for _, itemID in ipairs(PROFILES[npc] or PROFILES["NPC"]) do
		if ix.item.list[itemID] and ix.progression.CanBuyItem(character, npc, itemID) then
			candidates[#candidates + 1] = itemID
		end
	end
	local equipment = equipmentChoices(character, npc, JOB_EQUIPMENT_LIMITS[tier], 0)
	local hash = 0
	for index = 1, #seed do hash = (hash * 31 + seed:byte(index)) % 65521 end
	local result = {}
	local count = math.min(CHOICE_COUNT, #candidates + (#equipment > 0 and 1 or 0))
	for index = 1, count do
		local isEquipment = #equipment > 0 and index == count
		local itemID = isEquipment and equipment[hash % #equipment + 1]
			or candidates[(hash + index - 1) % #candidates + 1]
		local item = ix.item.list[itemID]
		local data = {}
		local label = item.name .. " x1"
		local roll = ((hash + index * 7919) % 101) / 100
		if item.isWeapon or item.isBodyArmor then
			local condition = math.min(100, math.floor(JOB_MIN_CONDITION + (tier - 1) * JOB_TIER_CONDITION
				+ roll * (JOB_MAX_CONDITION - JOB_MIN_CONDITION)))
			data.durability = condition
			if item.isWeapon then data.wear = condition end
			label = label .. " (" .. condition .. "% durability"
				.. (item.isWeapon and ", " .. condition .. "% wear condition" or "") .. ")"
		elseif item.quantity or item.ammoAmount then
			local capacity = math.max(1, math.floor(average(item.quantity or item.ammoAmount, 1)))
			local fill = math.min(1, JOB_MIN_FILL + (tier - 1) * JOB_TIER_FILL
				+ roll * (JOB_MAX_FILL - JOB_MIN_FILL))
			data.quantity = math.max(1, math.floor(capacity * fill))
			label = label .. " (" .. data.quantity .. (item.isAmmo and " rounds)" or " uses)")
		end
		result[#result + 1] = {label = label, items = {{item = itemID, data = data}}}
	end

	return result
end

function ix.taskRewards.BuildChoices(character, npc, budget, seed, catalogue)
	local candidates = {}
	for _, itemID in ipairs(catalogue or PROFILES[npc] or PROFILES["NPC"]) do
		local item = ix.item.list[itemID]
		local unit = item and ix.taskRewards.UnitValue(itemID) or 0
		if unit > 0 and unit <= budget and ix.progression.CanBuyItem(character, npc, itemID) then
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
		if remainder > 0 then
			rewards[#rewards + 1] = {item = "bagrubles", data = {quantity = remainder}}
			label = label .. " + " .. remainder .. " rubles"
		end
		result[#result + 1] = {label = label, items = rewards}
	end
	if #result == 0 and budget >= 1 then
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
	if job.requiredItem then
		local amount = count or average(job.numberRec, 1)
		local reference = ix.taskRewards.HandInUnitValue(job.requiredItem) * amount

		return math.ceil(math.max(reference, deliveredValue or 0) * JOB_CASH_RATE - CASH_ROUNDING_EPSILON)
	end
	local base = average(job.moneyReward, 0) + ix.taskRewards.JobBudget(job) * JOB_SUPPLY_CASH_SHARE

	return math.ceil(base * JOB_CASH_RATE - CASH_ROUNDING_EPSILON)
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
