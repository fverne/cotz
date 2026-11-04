-- Run from the repository root: luatex --luaonly tests/town_delivery_sources_spec.lua
ix = {randomitems = {tables = {}}}
Vector = function(...) return {...} end
Angle = function(...) return {...} end
local root = "gamemodes/ix_cotz/plugins/"
local function readFile(path)
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()

	return source
end

local includes = readFile(root .. "randomitem/libs/sh_randomitems.lua")
local function loadPool(name)
	local path = "randomitem/pools/" .. name .. ".lua"
	assert(includes:find(path, 1, true), "Acquisition pool is not loaded: " .. name)
	dofile(root .. path)
end

local sources = {}
local function addPool(name)
	for _, row in ipairs(assert(ix.randomitems.tables[name], "Missing acquisition pool: " .. name)) do
		if row[1] > 0 then sources[row[2][1]] = name end
	end
end

for _, name in ipairs({
	"worldspawn_1", "worldspawn_2", "worldspawn_3", "worldspawn_4", "worldspawn_5", "worldspawn_6",
	"worldspawn_garbage_regular", "worldspawn_garbage_rare",
	"ix_entbox_drops", "ix_wood_entbox_drops", "ix_paper_entbox_drops",
}) do
	loadPool(name)
	-- Box files contain multiple material-specific tables.
end
loadPool("human_npc_drops")
for name in pairs(ix.randomitems.tables) do addPool(name) end

-- Follow actual stash distributions and kit selections, including consumables omitted from world loot.
loadPool("cache_misc")
loadPool("reward_consumable")
local kits = {}
for tier = 1, 3 do
	loadPool("stash_tier_" .. tier)
	for _, row in ipairs(ix.randomitems.tables["hidestash_tier_" .. tier]) do
		if row[1] > 0 then kits[row[2][1]] = true end
	end
end
for id in pairs(kits) do
	ITEM = {}
	local path = "gamemodes/ix_cotz/schema/items/kits/sh_" .. id .. ".lua"
	local source = readFile(path):gsub("/%*.-%*/", "")
	assert(load(source, "@" .. path))()
	for _, selection in ipairs(ITEM.items) do
		for _, choice in ipairs(selection) do
			if choice[1] > 0 and ix.randomitems.tables[choice[2]] then addPool(choice[2]) end
		end
	end
end

-- Harvested parts, hides and raw meat are spawned by the installed poaching implementation.
local poaching = readFile(root .. "mutantpoaching/sv_plugin.lua")
local definitions = assert(poaching:match("^(.-)local POACH_DISTANCE"))
assert(load(definitions, "@mutantpoaching definitions"))()
for _, mutant in pairs(ix.poaching.MutantTable) do
	local drops = assert(ix.poaching.MutantParts[mutant], "Missing mutant harvest: " .. mutant)
	sources[drops.meattype] = "mutant harvest"
	for _, part in ipairs(drops.parts) do
		if part[2] > 0 then sources[part[1]] = "mutant harvest" end
	end
end

-- Artifact requirements also have live anomaly-field spawn lists.
PLUGIN = {anomalydefs = {}}
dofile(root .. "anomalycontroller/sh_anomalydefs.lua")
for _, definition in pairs(PLUGIN.anomalydefs) do
	for _, tier in ipairs({"commonArtifacts", "rareArtifacts", "veryRareArtifacts"}) do
		for _, item in ipairs(definition[tier] or {}) do sources[item] = "anomaly field" end
	end
end

-- These are acquisition checks, not reward/vendor/crafting-only allowances.
assert(not sources.meal_boar, "Cooked meals must not count as natural loot")
assert(sources.food_can_beans == "reward_consumable", "Canned food has a reachable hidden-cache route")
assert(sources.part_boar == "mutant harvest", "Hunting specimens have a harvest route")
dofile(root .. "progression/definitions/sh_requirementpools.lua")
local contacts, deliveries, slots, candidates = 0, 0, 0, 0
PLUGIN = {
	Register = function(_, slug, contact)
		contacts = contacts + 1
		for _, step in ipairs(contact.progression) do
			if step.kind == "delivery" then deliveries = deliveries + 1 end
			for _, slot in ipairs(step.requirements or {}) do
				slots = slots + 1
				local pool = assert(ix.progression.itemPools[slot.pool], "Unknown requirement pool: " .. slot.pool)
				for _, candidate in ipairs(pool.candidates) do
					candidates = candidates + 1
					assert(sources[candidate.item], slug .. "/" .. step.id .. " requests an item without loot: "
						.. candidate.item .. " (" .. slot.pool .. ")")
				end
			end
		end
	end,
}
local files = assert(io.popen("rg --files " .. root .. "townnpcs/definitions"))
for path in files:lines() do
	if readFile(path):find("PLUGIN:Register(", 1, true) then dofile(path) end
end
files:close()
assert(contacts == 27 and deliveries == 307 and slots == 796,
	"Audit must include every town contact and every slot of its finite deliveries")
print(string.format("PASS: %d town contacts, %d delivery slots, %d candidate acquisition routes",
	contacts, slots, candidates))
