-- Run from the repository root: luatex --luaonly tests/consumable_actions_spec.lua
CLIENT = false
local action
ix = {util = {GetMaterial = function(path) return path end,
	PlayerPerformBlackScreenAction = function(_, name) action = name end}, chat = {Send = function() end}}
IsValid = function(value) return type(value) == "table" end
ITEM = {functions = {}}
local file = assert(io.open("gamemodes/ix_cotz/schema/items/base/sh_consumables.lua"))
local source = file:read("*a")
file:close()
assert(load(source:gsub("!", "not ")))()
local base = ITEM
local inventory = {Add = function() return true end}
local character = {GetData = function() return 100 end, GetInventory = function() return inventory end}
local client = {GetCharacter = function() return character end, EmitSound = function() end,
	UpdateThirstState = function() end, UpdateHungerState = function() end}
for _, case in ipairs({
	{"drink_bottlewater", "Drinking"}, {"drink_vodka_1", "Drinking"},
	{"drink_energydrink_3", "Drinking"}, {"food_bread", "Eating"},
}) do
	ITEM = setmetatable({functions = {}}, {__index = base})
	dofile("gamemodes/ix_cotz/schema/items/consumables/sh_" .. case[1] .. ".lua")
	ITEM.player = client
	function ITEM:GetData(_, default) return default end
	function ITEM:SetData() end
	action = nil
	ITEM.functions.use.OnRun(ITEM)
	assert(action == case[2], case[1] .. " uses the correct consumption action")
end
print("PASS: beverage and food action labels")
