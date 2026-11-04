-- Run from the repository root: luatex --luaonly tests/valuable_pools_spec.lua
ix = {}
dofile("gamemodes/ix_cotz/plugins/progression/definitions/sh_requirementpools.lua")
local items = {}
local itemSources = {}
local reviewedItems = {}
for key, pool in pairs(ix.progression.itemPools) do
	if key:match("^valuables_") then
		for _, candidate in ipairs(pool.candidates) do reviewedItems[candidate.item] = true end
	end
end
local questItems = {}
local questFiles = assert(io.popen("rg --files gamemodes/ix_cotz/schema/items/quests"))
for path in questFiles:lines() do questItems[assert(path:match("/sh_(.+)%.lua$"))] = true end
questFiles:close()
local files = assert(io.popen(
	"rg --files gamemodes/ix_cotz/schema/items/valuables_test "
		.. "gamemodes/ix_cotz/schema/items/valuable gamemodes/ix_cotz/schema/items/quests"
))
for path in files:lines() do
	local itemID = path:match("/sh_(.+)%.lua$")
	if not questItems[itemID] and (path:find("/valuables_test/", 1, true) or reviewedItems[itemID]) then
		local id = path:match("/sh_(.+)%.lua$")
		assert(id, "Unexpected valuable definition: " .. path)
		items[id] = true
		local sourceFile = assert(io.open(path))
		itemSources[id] = sourceFile:read("*a")
		sourceFile:close()
	end
end
files:close()
local assigned = {}
local poolCount, itemCount = 0, 0
for id, pool in pairs(ix.progression.itemPools) do
	if id:match("^valuables_") then
		poolCount = poolCount + 1
		assert(#pool.candidates >= 1 and #pool.candidates <= 12, "Pool must contain 1-12 candidates: " .. id)
		for _, candidate in ipairs(pool.candidates) do
			assert(not questItems[candidate.item], "Quest item leaked into hand-ins: " .. candidate.item)
			assert(items[candidate.item], "Pool references a missing valuable: " .. candidate.item)
			assert(not assigned[candidate.item], "Valuable appears in multiple review pools: " .. candidate.item)
			assigned[candidate.item] = id
			local expected = id:gsub("^valuables_", ""):gsub("_", " ")
			local label = itemSources[candidate.item]:match('ITEM.valuableCategory = "([^"]+)"')
			assert(label == expected, "Valuable category differs from its pool: " .. candidate.item)
		end
	end
end
for id in pairs(items) do
	itemCount = itemCount + 1
	assert(assigned[id], "Valuable has not been reviewed for hand-ins: " .. id)
end
assert(assigned.value_med_bloodsample == "valuables_research_samples", "Blood samples are research stock")
assert(not assigned.value_container_meds, "Quest transport cases are excluded from hand-ins")
assert(assigned.value_flash_card_slider == "valuables_flash_media", "Recovered media is not task cargo")
assert(assigned.value_toolset == "valuables_workshop_tools", "Hand tools stay separate from tiered toolboxes")
print(string.format("PASS: %d valuables covered by %d valid hand-in pools", itemCount, poolCount))
