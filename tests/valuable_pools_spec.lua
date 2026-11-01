-- Run from the repository root: luatex --luaonly tests/valuable_pools_spec.lua
ix = {}
dofile("gamemodes/ix_cotz/plugins/progression/definitions/sh_requirementpools.lua")
local items = {}
local files = assert(io.popen("rg --files gamemodes/ix_cotz/schema/items/valuables_test"))
for path in files:lines() do
	local id = path:match("/sh_(.+)%.lua$")
	assert(id, "Unexpected valuable definition: " .. path)
	items[id] = true
end
files:close()
local assigned = {}
local poolCount, itemCount = 0, 0
for id, pool in pairs(ix.progression.itemPools) do
	if id:match("^valuables_") then
		poolCount = poolCount + 1
		assert(#pool.candidates >= 4 and #pool.candidates <= 12, "Pool must contain 4-12 candidates: " .. id)
		for _, candidate in ipairs(pool.candidates) do
			assert(items[candidate.item], "Pool references a missing valuable: " .. candidate.item)
			assert(not assigned[candidate.item], "Valuable appears in multiple review pools: " .. candidate.item)
			assigned[candidate.item] = id
		end
	end
end
for id in pairs(items) do
	itemCount = itemCount + 1
	assert(assigned[id], "Valuable has not been reviewed for hand-ins: " .. id)
end
assert(assigned.value_med_bloodsample == "valuables_research_samples", "Blood samples are research stock")
assert(assigned.value_container_meds == "valuables_specialist_cases", "A transport case is not clinical stock")
assert(assigned.value_flash_card_slider == "valuables_flash_media", "Recovered media is not task cargo")
assert(assigned.value_toolset == "valuables_workshop_tools", "Hand tools stay separate from tiered toolboxes")
print(string.format("PASS: %d valuables covered by %d valid hand-in pools", itemCount, poolCount))
