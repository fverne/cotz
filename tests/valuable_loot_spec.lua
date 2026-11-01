-- Run from the repository root: luatex --luaonly tests/valuable_loot_spec.lua
ix = {randomitems = {tables = {}}}
local root = "gamemodes/ix_cotz/plugins/randomitem/"
local prices = {}
dofile("gamemodes/ix_cotz/plugins/progression/definitions/sh_requirementpools.lua")
local reviewedItems = {}
for key, pool in pairs(ix.progression.itemPools) do
	if key:match("^valuables_") then
		for _, candidate in ipairs(pool.candidates) do reviewedItems[candidate.item] = true end
	end
end
local files = assert(io.popen("rg --files gamemodes/ix_cotz/schema/items/valuables_test gamemodes/ix_cotz/schema/items/valuable"))
for path in files:lines() do
	local itemID = path:match("/sh_(.+)%.lua$")
	if path:find("/valuables_test/", 1, true) or reviewedItems[itemID] then
		local file = assert(io.open(path))
		local source = file:read("*a")
		file:close()
		prices[path:match("/sh_(.+)%.lua$")] = assert(tonumber(source:match("ITEM.price = (%d+)")))
	end
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
local worldSeen = seen
local humanSeen = {}
dofile(root .. "pools/human_npc_drops.lua")
for key, rows in pairs(ix.randomitems.tables) do
	if key:match("_loot$") then
		for _, row in ipairs(rows) do humanSeen[row[2][1]] = true end
	end
end
local npcOnly = {
	"value_badge_bandit",
	"value_badge_merc",
	"value_badge_military",
	"value_badge_renegade",
	"value_barter_walletwz",
	"value_bogatir_moreman_tag",
	"value_chevron_bear",
	"value_info_militaryflash",
	"value_intelligence",
	"value_key_danexert",
	"value_letter",
	"value_military_secret_documents_1",
	"value_military_secret_documents_2",
	"value_military_secret_documents_3",
	"value_other_bage_ng",
	"value_photograph_album",
	"value_spec_tgflashkey",
	"value_strelets_amulet",
	"value_thin_diary",
	"value_wallet",
}
for _, id in ipairs(npcOnly) do
	assert(not worldSeen[id], "NPC pocket valuable leaked into worldspawn: " .. id)
	assert(humanSeen[id], "NPC pocket valuable has no acquisition route: " .. id)
end
for id in pairs(humanSeen) do seen[id] = true end
dofile(root .. "pools/cache_misc.lua")
local cacheSeen = {}
for key, rows in pairs(ix.randomitems.tables) do
	if key:match("^cache_documents_tier") or key:match("^cache_valuables_tier") then
		for _, row in ipairs(rows) do cacheSeen[row[2][1]] = true end
	end
end
local cacheDocuments = {
	"value_documents_10",
	"value_documents_11",
	"value_documents_13",
	"value_documents_14",
	"value_documents_9",
	"value_handbook_circuits",
	"value_info_tgdocs",
	"value_lab_journal",
	"value_med_journal_1",
	"value_med_journal_2",
	"value_scientistdiary",
}
for _, id in ipairs(cacheDocuments) do
	assert(not worldSeen[id], "High-end document leaked into worldspawn: " .. id)
	assert(cacheSeen[id], "High-end document has no cache route: " .. id)
end
for id in pairs(cacheSeen) do seen[id] = true end

local count = 0
for id in pairs(prices) do
	assert(seen[id], "No world, human or cache acquisition route: " .. id)
	count = count + 1
end
print(string.format("PASS: %d valuables reachable through loaded world, human or cache loot pools", count))
