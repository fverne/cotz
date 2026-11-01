-- Run from the repository root: luatex --luaonly tests/valuable_loot_spec.lua
ix = {randomitems = {tables = {}}}
local root = "gamemodes/ix_cotz/plugins/randomitem/"
local prices = {}
local files = assert(io.popen("rg --files gamemodes/ix_cotz/schema/items/valuables_test"))
for path in files:lines() do
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()
	prices[path:match("/sh_(.+)%.lua$")] = assert(tonumber(source:match("ITEM.price = (%d+)")))
end
files:close()
local maps = {
	{"worldspawn_1", "worldspawn_2"},
	{"worldspawn_garbage_regular", "worldspawn_garbage_rare"},
	{"worldspawn_3", "worldspawn_4"},
	{"worldspawn_5", "worldspawn_6"},
}
local seen = {}
local previous = {0, 0}
local loader = assert(io.open(root .. "libs/sh_randomitems.lua"))
local includes = loader:read("*a")
loader:close()
for _, pair in ipairs(maps) do
	local means = {}
	for rarity, key in ipairs(pair) do
		assert(includes:find("pools/" .. key .. ".lua", 1, true), "Unloaded pool: " .. key)
		dofile(root .. "pools/" .. key .. ".lua")
		local weight, value = 0, 0
		local totalWeight, weaponWeight = 0, 0
		local unique = {}
		for _, row in ipairs(ix.randomitems.tables[key]) do
			assert(type(row[1]) == "number" and row[1] > 0, "Invalid loot weight")
			local id = row[2][1]
			totalWeight = totalWeight + row[1]
			if row[2][2] and row[2][2].durability then weaponWeight = weaponWeight + row[1] end
			if prices[id] then
				assert(not unique[id], "Duplicate new valuable in " .. key .. ": " .. id)
				unique[id] = true
				seen[id] = true
				assert(row[2][2] == nil, "Recovered valuables must spawn as whole items")
				weight = weight + row[1]
				value = value + row[1] * prices[id]
			end
		end
		assert(totalWeight == 10000, "Whole pool must total 10,000 weight: " .. key)
		assert(weaponWeight <= 400, "Weapons must remain occasional finds: " .. key)
		assert(weight > 0, "No new loot in " .. key)
		means[rarity] = value / weight
		assert(means[rarity] > previous[rarity], "Regional new-loot value must rise: " .. key)
		previous[rarity] = means[rarity]
		for _, id in ipairs({"value_soap", "value_shampoo", "value_coffee"}) do
			if rarity == 1 then assert(unique[id], "Household loot missing from " .. key) end
		end
	end
	assert(means[2] > means[1], "Rare loot must be more valuable than regular loot")
end
local count = 0
for id in pairs(prices) do
	assert(seen[id], "No world acquisition route: " .. id)
	count = count + 1
end
print(string.format("PASS: %d valuables reachable through eight loaded, themed loot pools", count))
