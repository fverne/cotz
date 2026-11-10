-- Run from the repository root: luatex --luaonly tests/cyclic_garbage_loot_spec.lua
local root = "gamemodes/ix_cotz/plugins/"
local function read(path)
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()

	return source
end

SERVER = true
COLLISION_GROUP_WORLD = 20
PLUGIN = {}
ix = {
	util = {Include = function(path) dofile(root .. "cycliccontainer/" .. path) end},
	command = {Add = function() end},
	type = {string = 1},
	randomitems = {tables = {}},
}
-- Only the unrelated legacy Think/display code needs GLua operator translation.
assert(load(read(root .. "cycliccontainer/sh_plugin.lua"):gsub("!=", "~=")))()
local plugin = PLUGIN
local category = assert(plugin.categoryDefs.stash_map_garbage)
assert(category.appearTime == 1200 and category.disappearTime == 3600, "Keep existing cycle timing")
assert(#category.allowedStashTypes > 0, "Garbage needs selectable stash types")

for _, path in ipairs({
	"worldspawn_garbage_regular.lua",
	"worldspawn_garbage_rare.lua",
	"reward_consumable.lua",
	"reward_ammo_low.lua",
	"task_rewards_ammo.lua",
}) do
	assert(read(root .. "randomitem/libs/sh_randomitems.lua"):find("pools/" .. path, 1, true),
		"Loot pool file must be included at runtime: " .. path)
	dofile(root .. "randomitem/pools/" .. path)
end

local seenPools = {}
for _, stashType in ipairs(category.allowedStashTypes) do
	local groups = assert(plugin.stashTypes[stashType], "Unknown stash type: " .. stashType)
	assert(#groups > 0, "Garbage regular stashes must not select an empty loot definition")
	table.Random = function() return stashType end
	local added, removed = {}, false
	local inventory = {
		GetItems = function() return {{Remove = function() removed = true end}} end,
		Add = function(_, id, quantity, data)
			assert(removed, "Clear old contents before refilling")
			assert(quantity == 1 and type(data) == "table", "Preserve item insertion contract")
			added[#added + 1] = id
		end,
	}
	ix.util.GetRandomItemFromPool = function(poolID)
		local pool = assert(ix.randomitems.tables[poolID], "Unknown loot pool: " .. poolID)
		assert(#pool > 0, "Empty loot pool: " .. poolID)
		assert(not poolID:match("^worldspawn_%d$"), "Use Garbage's own regional salvage")
		seenPools[poolID] = true

		return pool[1][2]
	end
	local container = {
		GetCyclicalCategory = function() return "stash_map_garbage" end,
		GetInventory = function() return inventory end,
		SetNoDraw = function(_, hidden) assert(hidden == false, "Show appearing stashes") end,
		SetCollisionGroup = function() end,
	}
	plugin:AppearContainer(container)
	assert(#added == #groups, "Every configured loot selection must reach the inventory")
end
assert(seenPools.worldspawn_garbage_regular, "Regular Garbage salvage must be obtainable")
assert(seenPools.worldspawn_garbage_rare, "Rare Garbage salvage must be obtainable")

Vector = function() return {} end
Angle = Vector
Color = Vector
PLUGIN = {map_presets = {}}
dofile(root .. "firsttimesetup/presets/sh_rp_garbage_cotz.lua")
local regularStashes = 0
for _, container in ipairs(PLUGIN.map_presets.rp_garbage_cotz.containers) do
	if container.cyclicalCategory == "stash_map_garbage" then
		regularStashes = regularStashes + 1
	end
end
assert(regularStashes > 0, "The Garbage preset must use the repaired category")
print("PASS: every Garbage regular cyclic stash selection refills with loaded regional loot")
