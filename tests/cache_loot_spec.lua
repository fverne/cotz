-- Run from the repository root: luatex --luaonly tests/cache_loot_spec.lua
ix = {randomitems = {tables = {}}}
Vector = function() return {} end
Angle = Vector
local function read(path)
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()

	return source
end
local root = "gamemodes/ix_cotz/plugins/randomitem/pools/"
dofile(root .. "cache_misc.lua")
local prices = {}
local files = assert(io.popen("rg --files gamemodes/ix_cotz/schema/items/valuable gamemodes/ix_cotz/schema/items/valuables_test"))
for path in files:lines() do
	local id = path:match("/sh_([^/]+)%.lua$")
	prices[id] = tonumber(read(path):match("ITEM.price%s*=%s*(%d+)"))
end
files:close()
local previous = {documents = 0, valuables = 0}
for tier = 1, 4 do
	ITEM = {}
	local source = read("gamemodes/ix_cotz/schema/items/kits/sh_kit_hidestash_" .. tier .. ".lua")
	-- The legacy alternative definition is a GLua block comment, not active kit content.
	source = source:gsub("/%*.-%*/", "")
	assert(load(source))()
	assert(#ITEM.items == 7, "Cache must retain its original seven loot selections")
	local selection = ITEM.items[6]
	assert(selection[1][1] == 6 and selection[1][2] == "cache_valuables_tier" .. tier,
		"Rare valuables must be the common sixth selection")
	assert(selection[2][1] == 1 and selection[2][2] == "cache_artifact_tier1", "Retain artifact alternative")
	assert(ITEM.items[7][1][2] == "cache_documents_tier" .. tier, "Every kit must award a document")
	for _, family in ipairs({"documents", "valuables"}) do
		local key = "cache_" .. family .. "_tier" .. tier
		local rows = assert(ix.randomitems.tables[key], "Missing cache pool: " .. key)
		local total, value, seen = 0, 0, {}
		for _, row in ipairs(rows) do
			local id = row[2][1]
			assert(prices[id], "Unknown cache valuable: " .. id)
			assert(not seen[id], "Duplicate cache valuable: " .. id)
			seen[id] = true
			assert(row[1] > 0 and row[1] % 1 == 0, "Invalid cache weight")
			assert(not row[2][2], "Cache valuables must be whole single items")
			total = total + row[1]
			value = value + prices[id] * row[1]
		end
		for _, row in ipairs(rows) do
			for _, other in ipairs(rows) do
				local price = prices[row[2][1]]
				local otherPrice = prices[other[2][1]]
				if price < otherPrice then
					assert(row[1] >= other[1], "Expensive cache items must not be more common")
				elseif price == otherPrice then
					assert(math.abs(row[1] - other[1]) <= 1, "Equal prices need equal odds within rounding")
				end
				local difference = math.abs(row[1] * price - other[1] * otherPrice)
				assert(difference <= price + otherPrice, "Cache weights must follow inverse item price")
			end
		end
		assert(total == 10000, "Cache pool must total 10,000")
		assert(value / total > previous[family], "Cache value must rise by tier")
		previous[family] = value / total
	end
end
for tier = 1, 3 do
	dofile(root .. "stash_tier_" .. tier .. ".lua")
	for _, row in ipairs(ix.randomitems.tables["hidestash_tier_" .. tier]) do
		assert(row[2][1]:match("^kit_hidestash_[1-4]$"), "Hidden stash must award a configured kit")
	end
end
print("PASS: hidden cache kits reach eight valid, escalating document/valuable pools")
