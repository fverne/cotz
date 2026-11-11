-- Run from the addon root: luatex --luaonly tests/kit_opening_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local pending, received, messages, properties = {}, {}, {}, {}
IsValid = function(value) return value ~= nil end
Vector = function(...) return {...} end
Angle = Vector
Color = Vector
timer = {Simple = function(_, callback) pending[#pending + 1] = callback end}
ix = {
	taskRewards = {IsTaskKit = function() return true end},
	util = {
		GetRandomItemFromPool = function(pool) return {pool, {quantity = 3}} end,
		PropertyDesc = function(_, description) properties[#properties + 1] = description end,
	},
	chat = {Send = function(_, _, message) messages[#messages + 1] = message end},
}
local inventory = {Add = function(_, item, _, data)
	received[#received + 1] = {item = item, data = data}

	return true
end}
local character = {GetInventory = function() return inventory end}
local client = {
	GetCharacter = function() return character end,
	GetItemDropPos = function() return {} end,
}
local basePath = "gamemodes/ix_cotz/schema/items/base/sh_kits.lua"
local file = assert(io.open(basePath, "r"))
local source = file:read("*a")
file:close()
ITEM = {functions = {}, hooks = {}}
function ITEM:Hook(name, callback) self.hooks[name] = callback end
assert(load(source:gsub("!", "not "), "@" .. basePath))()
local kitBase = ITEM

for _, id in ipairs({"kit_mixed_high", "kit_reward_ammo_tier01"}) do
	ITEM = setmetatable({}, {__index = kitBase})
	dofile("gamemodes/ix_cotz/schema/items/kits/sh_" .. id .. ".lua")
	local item = ITEM
	item.uniqueID, item.player = id, client
	function item:GetData(_, default) return default end
	pending, received, messages, properties = {}, {}, {}, {}
	check(item.functions.Open.OnCanRun(item), id .. " opens from inventory")
	check(item.functions.Open.OnRun(item) ~= false, id .. " uses normal consumption after opening")
	check(#pending == #item.items, id .. " schedules each configured loot slot")
	for _, callback in ipairs(pending) do callback() end
	check(#received == #item.items and received[1].data.quantity == 3, id .. " delivers configured loot")
	item.hooks.Open(item)
	check(#messages == 1, id .. " announces opening")
	item:PopulateTooltip({})
	check(properties[1] == "Openable, contains items", id .. " tooltip describes opening")
	check(not item:GetDescription():find("Redeem", 1, true), id .. " has no NPC redemption instructions")
	item.entity = {}
	check(not item.functions.Open.OnCanRun(item), id .. " cannot be opened in the world")
end

print("PASS: " .. checks .. " kit opening checks")
