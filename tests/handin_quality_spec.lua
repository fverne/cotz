-- Run from the repository root: luatex --luaonly tests/handin_quality_spec.lua
dofile("tests/helpers/progression.lua")
math.Clamp = function(value, minimum, maximum) return math.max(minimum, math.min(maximum, value)) end
local utilFile = assert(io.open("gamemodes/ix_cotz/schema/libs/sh_util.lua"))
local utilSource = utilFile:read("*a")
utilFile:close()
assert(load(utilSource:sub(1, assert(utilSource:find("-- Performs various", 1, true)) - 1)))()
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local function base(name)
	local file = assert(io.open("gamemodes/ix_cotz/schema/items/base/sh_" .. name .. ".lua"))
	local source = file:read("*a")
	file:close()
	ITEM = {functions = {}}
	assert(load(source:gsub("!", "not ")))()

	return ITEM
end
local function instance(definition, weight, tier)
	local result = setmetatable({data = {weight = weight, tier = tier}}, {__index = definition})
	function result:GetData(key, default)
		if self.data[key] ~= nil then return self.data[key] end

		return default
	end
	function result:GetWeight() return self:GetData("weight", self.weight) end

	return result
end
local part = base("mutantparts")
part.price, part.pricepertier, part.baseweight = 100, 20, 2
ix.item.list.quality_part = part
local normal, heavy = instance(part, 2, 1), instance(part, 4, 1)
check(ix.taskRewards.HandInUnitValue("quality_part", normal) == 120, "ordinary weight preserves tier value")
check(ix.taskRewards.HandInUnitValue("quality_part", heavy) == 240, "double weight doubles specimen credit")
check(ix.taskRewards.HandInUnitValue("quality_part", instance(part, nil, 1)) == 120,
	"old specimens without saved weights retain ordinary value")
local job = {requiredItem = "quality_part", wholeItems = true, tier = 1}
check(ix.taskRewards.FixedMoney(job, 1, 100) == 500, "ordinary specimens retain the easy minimum")
check(ix.taskRewards.FixedMoney(job, 1, 200) == 1000, "quality increases cash even below the minimum")
local normalRep, normalCash = ix.util.GetValueFromProgressionTurnin(normal, 1, "quality_part")
local heavyRep, heavyCash = ix.util.GetValueFromProgressionTurnin(heavy, 1, "quality_part")
check(heavyCash == normalCash * 2 and heavyRep > normalRep, "finite hand-ins retain weighted cash and reputation")
local meat = base("cookable")
meat.price, meat.BaseWeight, meat.meal = 100, 1, "meal_quality"
meat.GetWeight = normal.GetWeight
ix.item.list.meat_quality = meat
local meal = base("cooked")
meal.price, meal.GetWeight = 120, normal.GetWeight
ix.item.list.meal_quality = meal
for _, id in ipairs({"meat_quality", "meal_quality"}) do
	local definition = ix.item.list[id]
	local value = ix.taskRewards.HandInUnitValue(id)
	check(value == definition.price * 2, "definition quotes use the uncooked reference weight: " .. id)
	local actual = ix.taskRewards.HandInUnitValue(id, instance(definition, 2), true)
	check(actual == value * 2, "saved meat/meal weight is applied exactly once: " .. id)
	check(ix.taskRewards.FixedMoney({requiredItem = id, tier = 1}, 1, actual) == 1000,
		"better meat/meal increases the minimum cash reward: " .. id)
end
print("PASS: " .. checks .. " hand-in quality checks")
