-- Run from the repository root: luatex --luaonly tests/regular_ammo_spec.lua
local fixture = dofile("tests/helpers/progression.lua")
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

PLUGIN = {}
dofile("gamemodes/ix_cotz/plugins/townnpcs/libs/sh_00_townnpcs.lua")
dofile("gamemodes/ix_cotz/plugins/townnpcs/libs/sh_catalogue.lua")
local town = PLUGIN
town.upgradeChains = {}
town.regularAmmoChain = {"first", "gap", "last", "unused"}
town.ammoVariants = {lasthp = "last", lastap = "last"}
town.canonicalSellers = {first = "a", gap = "a", last = "a", lasthp = "a", lastap = "a"}
for _, item in ipairs({"first", "gap", "last", "unused", "lasthp", "lastap"}) do
	ix.item.list[item] = {name = item, isAmmo = true}
end
for slug, items in pairs({a = {"first", "gap", "last", "lasthp", "lastap"},
	b = {"first", "last", "lasthp", "lastap"}}) do
	local contact = {id = slug, name = slug, supplies = {}, catalogue = {}, progression = {}}
	town.contacts[slug] = contact
	for index, item in ipairs(items) do
		local step = "S" .. index
		local id = town:StepID(slug, step)
		contact.catalogue[item] = {step = step, terms = {100, 1, "SELLONLY", 1, 48, 1}}
		town.steps[id] = {}
		ix.progression.Register(id, {keyNpc = slug, defaultActive = true, prerequisites = {},
			nextProgressions = {}, vendorUnlocks = {}})
	end
end
town:BuildCatalogue()
local first = town:StepID("b", "S1")
local last = town:StepID("b", "S2")
local hollowPoint = town:StepID("b", "S3")
local armourPiercing = town:StepID("b", "S4")
local prerequisites = ix.progression.definitions[last].prerequisites
check(#prerequisites == 1 and prerequisites[1] == first,
	"a shop skips absent calibres and requires its own preceding regular load")
check(not town.itemGates.unused, "unstocked tail ammunition creates no purchase route")
local owner = fixture.character()
check(not ix.progression.IsActive(owner, last), "the later regular load starts locked")
local state = ix.progression.GetCharacterProgression(owner)
state.lines[town:StepID("a", "S1")] = {completed = true}
ix.progression.SetCharacterProgression(owner, state)
check(not ix.progression.IsActive(owner, last), "another seller's first load cannot open this shop's next load")
state.lines[first] = {completed = true}
ix.progression.SetCharacterProgression(owner, state)
check(ix.progression.IsActive(owner, last), "the local predecessor opens the next regular milestone")
check(not ix.progression.CanBuyItem(owner, "b", "last"), "opening a milestone does not grant its purchase")
check(not ix.progression.IsActive(owner, hollowPoint), "HP still waits for local regular ammunition")
state.lines[last] = {completed = true}
ix.progression.SetCharacterProgression(owner, state)
check(ix.progression.IsActive(owner, hollowPoint), "regular ammunition opens its local HP upgrade")
check(not ix.progression.IsActive(owner, armourPiercing), "AP still waits for local HP")
state.lines[hollowPoint] = {completed = true}
state.lines[first] = nil
ix.progression.SetCharacterProgression(owner, state)
check(ix.progression.IsActive(owner, armourPiercing), "local regular and HP completions open AP")
check(ix.progression.CanBuyItem(owner, "b", "last"), "existing completed purchases survive the new chain")
print("PASS: " .. checks .. " regular ammunition checks")
