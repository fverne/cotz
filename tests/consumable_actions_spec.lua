-- Run from the repository root: luatex --luaonly tests/consumable_actions_spec.lua
SERVER, CLIENT = true, false
table.Copy = function(value)
	if type(value) ~= "table" then return value end
	local result = {}
	for key, entry in pairs(value) do result[key] = table.Copy(entry) end

	return result
end
local completed
local fullness = 100
local action
ix = {util = {GetMaterial = function(path) return path end,
	PlayerPerformItemAction = function(_, _, name, _, callback) action = name completed = callback end}, chat = {Send = function() end}}
ix.item = {list = {}}
dofile("gamemodes/ix_cotz/schema/libs/sh_economystats.lua")
IsValid = function(value) return type(value) == "table" end
ITEM = {functions = {}}
local file = assert(io.open("gamemodes/ix_cotz/schema/items/base/sh_consumables.lua"))
local source = file:read("*a")
file:close()
assert(load(source:gsub("!", "not ")))()
local base = ITEM
local inventory = {Add = function() return true end}
local character = {data = {}, GetData = function(self, key, default)
	if key == "hunger" or key == "thirst" then return fullness end
	return self.data[key] or default
end, SetData = function(self, key, value) self.data[key] = value end, GetInventory = function() return inventory end}
local client = {GetCharacter = function() return character end, EmitSound = function() end,
	AddBuff = function() end, SetHunger = function() end, SetThirst = function() end, IncreaseDrunkLevel = function() end,
	UpdateThirstState = function() end, UpdateHungerState = function() end}
for _, case in ipairs({
	{"drink_bottlewater", "Drinking"}, {"drink_vodka_1", "Drinking"},
	{"drink_energydrink_3", "Drinking"}, {"food_bread", "Eating"},
}) do
	ITEM = setmetatable({functions = {}}, {__index = base})
	dofile("gamemodes/ix_cotz/schema/items/consumables/sh_" .. case[1] .. ".lua")
	ITEM.uniqueID = case[1]
	ix.item.list[case[1]] = ITEM
	ITEM.player = client
	function ITEM:GetData(_, default) return default end
	function ITEM:SetData() end
	action = nil
	ITEM.functions.use.OnRun(ITEM)
	assert(action == case[2], case[1] .. " uses the correct consumption action")
	local key = case[2] == "Drinking" and "drinksConsumed" or "foodConsumed"
	local before = character.data.economyStats or {}
	assert(not before[key] or not before[key][case[1]], "starting an action does not count consumption")
	completed(client)
	assert(character.data.economyStats[key][case[1]] == 1, "completed action records one serving")
end
local before = table.Copy(character.data.economyStats)
fullness = 160
client.Notify = function() end
completed = nil
assert(ITEM.functions.use.OnRun(ITEM) == false and completed == nil, "rejected consumption starts no action")
assert(character.data.economyStats.foodConsumed.food_bread == before.foodConsumed.food_bread,
	"rejected consumption does not inflate favourites")
fullness = 100
ITEM = {functions = {}}
local cookedFile = assert(io.open("gamemodes/ix_cotz/schema/items/base/sh_cooked.lua"))
local cookedSource = cookedFile:read("*a")
cookedFile:close()
assert(load(cookedSource:gsub("!", "not ")))()
ITEM.base, ITEM.uniqueID, ITEM.player = "base_cooked", "economyMeal", client
ITEM.GetHunger = function() return 20 end
ITEM.GetThirst = function() return -5 end
ix.item.list.economyMeal = ITEM
ITEM.functions.use.OnRun(ITEM)
assert(not character.data.economyStats.foodConsumed.economyMeal, "pending meals do not count")
completed(client)
assert(character.data.economyStats.foodConsumed.economyMeal == 1, "completed cooked meals count as food")
print("PASS: beverage and food action labels")
