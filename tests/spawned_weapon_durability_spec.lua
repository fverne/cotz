-- Run from the repository root: luatex --luaonly tests/spawned_weapon_durability_spec.lua
-- Every firearm that enters the world outside a trader must be worn enough to need a technician.
-- The floor and the cap coincide, so found firearms always spawn at exactly this value.
local MIN_DURABILITY = 5
local MAX_DURABILITY = 5
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end

local function read(path)
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()

	return source
end

local function list(command)
	local paths = {}
	local pipe = assert(io.popen(command))
	for path in pipe:lines() do paths[#paths + 1] = path end
	pipe:close()
	assert(#paths > 0, "no files matched: " .. command)

	return paths
end

local firearms = {}
for _, path in ipairs(list("ls gamemodes/ix_cotz/schema/items/newweapons/sh_*.lua")) do
	firearms[path:match("/sh_([^/]+)%.lua$")] = true
end

local function checkEntry(itemID, data, source)
	if not firearms[itemID] then return false end
	local durability = data and data.durability
	check(durability ~= nil, source .. " omits durability for " .. itemID .. ", which would spawn it pristine")
	check(durability >= MIN_DURABILITY and durability <= MAX_DURABILITY,
		source .. " spawns " .. itemID .. " outside the found durability range")

	return true
end

local plugins = "gamemodes/ix_cotz/plugins/"
ix = {randomitems = {tables = {}}}
-- Special sales are paid trader stock, so they keep pristine weapons.
for _, path in ipairs(list("ls " .. plugins .. "randomitem/pools/*.lua")) do
	if not path:find("/specialsale_", 1, true) then dofile(path) end
end
local pooled = 0
for poolID, rows in pairs(ix.randomitems.tables) do
	for _, row in ipairs(rows) do
		if checkEntry(row[2][1], row[2][2], poolID) then pooled = pooled + 1 end
	end
end
check(pooled > 700, "firearm loot and reward pools were inspected")

local fallback = read(plugins .. "randomitem/libs/sh_randomitems.lua"):match('"mp5",%s*{.-%["durability"%]%s*=%s*([%d.]+)')
check(tonumber(fallback) >= MIN_DURABILITY and tonumber(fallback) <= MAX_DURABILITY,
	"default pool firearm is within the found durability range")

PLUGIN = {}
dofile(plugins .. "hidestashspawner/sh_definitions.lua")
local stashed = 0
for tier, stashes in pairs(PLUGIN.StashItems) do
	for _, stash in ipairs(stashes) do
		for _, entry in ipairs(stash) do
			if checkEntry(entry[1], entry[2], "hidden stash " .. tier) then stashed = stashed + 1 end
		end
	end
end
check(stashed > 0, "hidden stash firearms were inspected")

local dropped = 0
for _, path in ipairs(list("ls lua/entities/npc_human_*/init.lua")) do
	for itemID, data in read(path):gmatch('{"([%w_]+)",%s*(%b{})') do
		local durability = tonumber(data:match('%["durability"%]%s*=%s*([%d.]+)'))
		if checkEntry(itemID, {durability = durability}, path) then dropped = dropped + 1 end
	end
end
check(dropped > 0, "NPC weapon drops were inspected")

ix.taskRewards = {}
dofile(plugins .. "jobsystem/definitions/sh_rewardsettings.lua")
check(ix.taskRewards.settings.weaponReferenceDurability == MAX_DURABILITY,
	"reward budgets value weapons against the same durability cap")

print("PASS: " .. checks .. " spawned weapon durability checks")
