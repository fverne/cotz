-- Run from the repository root: luatex --luaonly tests/human_weaponprops_spec.lua
-- Every loadout weapon needs a hand placement for an Anomaly world model, and the table must not hold stale entries.
-- The placements themselves come from the weapon models and the rig's hand frame, so they are checked in game.
local function read(path)
	local file = io.open(path)
	if not file then return nil end
	local source = file:read("*a")
	file:close()

	return source
end

local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local function loadEntity(path)
	ENT = {}
	AddCSLuaFile, include = function() end, function() end
	assert(loadfile(path))()
	local entity = ENT
	ENT = nil

	return entity
end

local function checkHand(hand, name)
	check(type(hand) == "table" and #hand.pos == 3 and #hand.ang == 3, name .. " has a complete hand placement")
	for _, value in ipairs({hand.pos[1], hand.pos[2], hand.pos[3], hand.ang[1], hand.ang[2], hand.ang[3]}) do
		check(type(value) == "number", name .. " hand placement is numeric")
	end
	for index = 1, 3 do check(math.abs(hand.pos[index]) < 25, name .. " keeps the weapon within reach of the hand") end
end

local itemPaths = {}
local files = assert(io.popen("rg --files gamemodes | rg '/items/'"))
for path in files:lines() do
	local id = path:match("/sh_([^/]+)%.lua$")
	if id then itemPaths[id] = path end
end
files:close()

local props = loadEntity("lua/entities/cotz_human_base/weaponprops.lua").WeaponProps
local used = {}
local loadouts = assert(io.popen("rg --files lua/entities | rg '/npc_human_[^/]+/init.lua$'"))
for path in loadouts:lines() do
	for id in assert(read(path)):gmatch('{{"([%w_]+)"') do used[id] = true end
end
loadouts:close()

for id in pairs(used) do
	local entry = props[id]
	check(entry, "Loadout weapon has no hand placement: " .. id)
	local item = assert(read(itemPaths[id] or ""), "Loadout weapon has no item definition: " .. id)
	local class = assert(item:match('ITEM.class%s*=%s*"([^"]+)"'), "Item has no weapon class: " .. id)
	local swep = assert(read("lua/weapons/" .. class .. "/shared.lua") or read("lua/weapons/" .. class .. ".lua"),
		"Item class has no SWEP: " .. class)
	local hold = swep:match('\n%s*SWEP.HoldType%s*=%s*"([^"]+)"')
	check(entry.hold == (hold == "pistol" and "pistol" or "rifle"), id .. " hold style follows its SWEP hold type")
	check(entry.model:find("^models/flaymi/anomaly/weapons/w_models/"), id .. " holds an Anomaly world model")
	checkHand(entry.hand, id)
end
for id in pairs(props) do check(used[id], "Hand placement is unused by any loadout: " .. id) end

local melee = loadEntity("lua/entities/npc_human_bandit_melee/init.lua")
for _, loadout in ipairs(melee.MeleeLoadouts) do
	checkHand(loadout.hand, loadout.model)
	check(loadout.damage <= 10, "Melee bandits keep their damage low")
end

print("PASS: " .. checks .. " human weapon prop checks")
