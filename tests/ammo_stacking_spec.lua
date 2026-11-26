-- Run from the repository root: luatex --luaonly tests/ammo_stacking_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

SERVER, CLIENT = true, false
local timers, weightUpdates, locked = {}, 0, {}
timer = {Simple = function(_, callback) timers[#timers + 1] = callback end}
local function runTimers()
	local pending = timers
	timers = {}
	for _, callback in ipairs(pending) do callback() end
end
IsValid = function(value) return type(value) == "table" end

ix = {meta = {item = {}}, char = {loaded = {}}, weight = {Update = function() weightUpdates = weightUpdates + 1 end}}
ix.plugin = {Get = function()
	return {IsOperationLocked = function(_, item) return locked[item.id] end}
end}

dofile("gamemodes/ix_cotz/schema/meta/sh_itemstack.lua")
ITEM = {functions = {}}
dofile("gamemodes/ix_cotz/schema/items/base/sh_newammo.lua")
local base = ITEM
PLUGIN = {}
dofile("gamemodes/ix_cotz/plugins/ammo.lua")
local plugin = PLUGIN

local items, nextID = {}, 0
local inventory = {owner = 7}
function inventory:GetItems() return items end
function inventory:GetItemByID(id) return items[id] end
ix.char.loaded[7] = {GetInventory = function() return inventory end}

local function newItem(ammo, quantity, data)
	nextID = nextID + 1
	local item = setmetatable({id = nextID, ammo = ammo, data = data or {}}, {__index = function(_, key)
		return base[key] or ix.meta.item[key]
	end})
	item.data.quantity = quantity
	function item:GetData(key, default)
		if self.data[key] == nil then return default end
		return self.data[key]
	end
	function item:SetData(key, value) self.data[key] = value end
	function item:Remove() items[self.id] = nil end
	items[item.id] = item

	return item
end
local function reset()
	items, weightUpdates, locked = {}, 0, {}
end
local function add(item)
	plugin:InventoryItemAdded(nil, inventory, item)
end

local stack = newItem("545", 100)
local other = newItem("545ap", 100)
local incoming = newItem("545", 50)
add(incoming)
check(items[incoming.id], "merging waits for the add to finish")
runTimers()
check(not items[incoming.id] and stack:GetStackQuantity() == 150, "incoming rounds join the matching stack")
check(other:GetStackQuantity() == 100, "other ammo types are untouched")
check(weightUpdates == 1, "carry weight refreshes after a merge")

reset()
local low, high = newItem("545", 100), newItem("545", 290)
incoming = newItem("545", 220)
add(incoming)
runTimers()
check(high:GetStackQuantity() == 300 and low:GetStackQuantity() == 300, "fullest stacks fill first")
check(items[incoming.id] and incoming:GetStackQuantity() == 10, "overflow stays in the incoming box")

reset()
newItem("545", 300)
incoming = newItem("545", 30)
add(incoming)
runTimers()
check(incoming:GetStackQuantity() == 30 and weightUpdates == 0, "full stacks accept nothing")

reset()
stack = newItem("545", 10)
incoming = newItem("545", 20, {cotzKeepSeparate = true})
add(incoming)
runTimers()
check(items[incoming.id] and stack:GetStackQuantity() == 10, "split stacks stay separate")
check(incoming:GetData("cotzKeepSeparate") == nil, "the split exemption applies once")
add(incoming)
runTimers()
check(not items[incoming.id] and stack:GetStackQuantity() == 30, "a split stack merges when it re-enters")

reset()
local first, second = newItem("545", 10), newItem("545", 20)
add(first)
add(second)
runTimers()
check((items[first.id] == nil) ~= (items[second.id] == nil), "two new boxes leave one stack")
check((items[first.id] or items[second.id]):GetStackQuantity() == 30, "no rounds are lost or duplicated")

reset()
stack = newItem("545", 10)
incoming = newItem("545", 20)
add(incoming)
items[incoming.id] = nil
runTimers()
check(stack:GetStackQuantity() == 10, "an item that already left is ignored")

reset()
stack = newItem("545", 10)
locked[stack.id] = true
incoming = newItem("545", 20)
add(incoming)
runTimers()
check(items[incoming.id] and stack:GetStackQuantity() == 10, "stacks in a pending hideout operation are skipped")

reset()
stack = newItem("545", 10)
incoming = newItem("545", 20)
plugin:InventoryItemAdded(nil, {owner = 7}, incoming)
plugin:InventoryItemAdded(nil, {}, incoming)
check(#timers == 0, "stashes and other containers do not auto-merge")

reset()
istable = function(value) return type(value) == "table" end
isnumber = function(value) return type(value) == "number" end
AngleRand = function() end
local added, dropped = {}, 0
ix.item = {SpawnTemporary = function() dropped = dropped + 1 end}
local player = {
	GetCharacter = function()
		return {GetInventory = function()
			return {Add = function(_, _, _, data) added[#added + 1] = data return true end}
		end}
	end,
	EmitSound = function() end,
}
stack = newItem("545", 15)
stack.player = player
for _, data in ipairs({{}, {-100}, {0}, {0.5}, {2}, {"5"}, {15}, {300}, {0 / 0}, {math.huge}}) do
	check(base.functions.split.OnRun(stack, data) == false, "rejected splits keep the item")
end
base.functions.split.OnRun(stack)
check(#added == 0 and dropped == 0 and stack:GetStackQuantity() == 15, "invalid split amounts change nothing")
base.functions.split.OnRun(stack, {5})
check(#added == 1 and added[1].quantity == 5 and stack:GetStackQuantity() == 10, "offered amounts split")

print("ammo stacking: " .. checks .. " checks passed")
