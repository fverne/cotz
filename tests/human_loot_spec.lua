-- Run from the repository root: luatex --luaonly tests/human_loot_spec.lua
ix = {randomitems = {tables = {}}}
dofile("gamemodes/ix_cotz/plugins/randomitem/pools/human_npc_drops.lua")
local function read(path)
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()

	return source
end
local known = {}
local files = assert(io.popen("rg --files gamemodes/ix_cotz/schema/items gamemodes/ix_cotz/plugins"))
for path in files:lines() do
	if path:find("/items/", 1, true) then
		local id = path:match("/sh_([^/]+)%.lua$")
		if id then known[id] = true end
	end
end
files:close()
local references = {}
local entities = assert(io.popen("rg --files lua/entities | rg '/npc_human_[^/]+/init.lua$'"))
local count = 0
for path in entities:lines() do
	local key = assert(read(path):match('ENT.lootGroup = "([^"]+)"'))
	assert(ix.randomitems.tables[key], "NPC uses missing pool: " .. path)
	local class = path:match('/npc_human_([^/]+)/init.lua$')
	local group, role = class:match("^(.*)_([^_]+)$")
	role = ({pistolman = "pistol", rifleman = "rifle", shotgunner = "shotgun"})[role] or role
	assert(key == group .. "_" .. role .. "_loot", "Wrong faction/role pool: " .. path)
	references[key] = true
	count = count + 1
end
entities:close()
local pools = 0
for key, rows in pairs(ix.randomitems.tables) do
	pools = pools + 1
	assert(references[key], "Unused human loot pool: " .. key)
	local total, unique = 0, {}
	local valuables = 0
	for _, row in ipairs(rows) do
		local id, data = row[2][1], row[2][2]
		assert(known[id], "Unknown human loot item: " .. id)
		assert(not unique[id], "Duplicate human loot item: " .. key .. "/" .. id)
		unique[id] = true
		if id:match("^value_") then valuables = valuables + 1 end
		assert(not id:match("^food_"), "Filling food must not appear in human loot")
		assert(row[1] > 0 and row[1] % 1 == 0, "Weights must be positive integers")
		assert(not data or not data.durability, "Pocket loot must not duplicate weapon drops")
		if data then assert(data.quantity and data.quantity >= 1, "Invalid pocket stack") end
		total = total + row[1]
	end
	assert(valuables >= 12, "Each NPC role needs non-quest pocket-loot variety: " .. key)
	assert(total == 10000, "Pool must total 10,000: " .. key)
	if key:match("^z_") then
		for id in pairs(unique) do
			assert(not id:match("^drink_") and not id:match("^drug_"), "Zombies carry kit remnants")
		end
	end
end
assert(pools == 20 and count == 20, "Every installed human NPC must use its faction and role pool")
for key, id in pairs({bandit_sniper_loot = "762x54", merc_sniper_loot = "762x51",
	mili_rifle_loot = "545x39", merc_rifle_loot = "556x45", bandit_shotgun_loot = "12gauge"}) do
	local found = false
	for _, row in ipairs(ix.randomitems.tables[key]) do
		if row[2][1] == id then found = true end
	end
	assert(found, "Role ammunition missing: " .. key)
end
print("PASS: 20 human NPCs use 20 valid, food-free faction/role loot pools")
