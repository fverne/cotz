-- Run from the repository root: luatex --luaonly tests/mutant_harvest_spec.lua
-- Every mutant must be harvestable, and everything a corpse yields must exist as an item.
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end

local function read(path)
	local file = io.open(path)
	if not file then return end
	local source = file:read("*a")
	file:close()

	return source
end

local function list(command)
	local paths = {}
	local pipe = assert(io.popen(command))
	for path in pipe:lines() do paths[#paths + 1] = path end
	pipe:close()
	assert(#paths > 0, "No files listed by: " .. command)

	return paths
end

ix = {}
local poaching = read("gamemodes/ix_cotz/plugins/mutantpoaching/sv_plugin.lua")
local definitions = assert(poaching:match("^(.-)local POACH_DISTANCE"))
assert(load(definitions, "@mutantpoaching definitions"))()

local items = {}
for _, path in ipairs(list("rg --files gamemodes/ix_cotz/schema/items -g 'sh_*.lua'")) do
	items[path:match("sh_([^/]+)%.lua$")] = path
end

local weaponTables = read("gamemodes/ix_cotz/schema/libs/sh_weapontables.lua")
for mutant, harvest in pairs(ix.poaching.MutantParts) do
	check(items[harvest.meattype], mutant .. " yields a missing item: " .. harvest.meattype)
	local meat = read(items[harvest.meattype])
	local meal = meat:match('ITEM%.meal%s*=%s*"([^"]+)"')
	if meal then check(items[meal], harvest.meattype .. " cooks into a missing meal: " .. meal) end
	for _, part in ipairs(harvest.parts) do
		check(items[part[1]], mutant .. " yields a missing item: " .. part[1])
		if part[1]:sub(1, 5) == "hide_" then
			check(weaponTables:find('ix.armortables.attachments["' .. part[1] .. '"]', 1, true),
				part[1] .. " has no suit attachment entry")
		end
	end
end

-- Legacy classes whose corpse identity predates PoachingType, mapped through their model.
local MODEL_ALIASES = {["models/maver1k_xvii/stalker/mutants/karlik.mdl"] = "models/monsters/karlik.mdl"}
-- Phantoms leave nothing behind. Classes with noRagdoll have no corpse either.
local UNHARVESTED = {npc_mutant_psydog_phantom = true}
local byModel = {}
for model, mutant in pairs(ix.poaching.MutantTable) do
	check(ix.poaching.MutantParts[mutant], model .. " names an unknown harvest: " .. mutant)
	byModel[model:lower()] = mutant
end

for _, path in ipairs(list("rg --files lua/entities -g '**/npc_mutant_*/init.lua'")) do
	local class = path:match("(npc_mutant_[%w_]+)/init%.lua$")
	local source = read(path)
	local poachingType = source:match('ENT%.PoachingType%s*=%s*"([^"]+)"')
	if poachingType then
		check(ix.poaching.MutantParts[poachingType], class .. " names an unknown harvest: " .. poachingType)
	elseif not UNHARVESTED[class] and not source:find("ENT%.noRagdoll%s*=%s*true") then
		-- ragdollModel replaces the body model on death.
		local model = source:match('self%.ragdollModel%s*=%s*"([^"]+)"')
			or source:match('self%.Model%s*=%s*"([^"]+)"') or source:match('local [%u_]*MODEL = "([^"]+)"')
		check(model, class .. " has no recognisable corpse model; set ENT.PoachingType")
		model = model:lower()
		check(byModel[MODEL_ALIASES[model] or model],
			class .. " cannot be poached; add its model to MutantTable or set ENT.PoachingType: " .. model)
	end
end

local menu = read("lua/autorun/snpcmutants.lua")
for _, class in ipairs({
	"npc_mutant_bloodsucker_swamp", "npc_mutant_mimic", "npc_mutant_poltergeist_fire",
	"npc_mutant_poltergeist_electro", "npc_mutant_poltergeist_tele",
}) do
	check(menu:find(class, 1, true), class .. " is missing from the spawn menu")
end

print(string.format("PASS: %d mutant harvest checks", checks))
