-- Run from the addon root: luatex --luaonly tests/catalogue_stock_order_spec.lua
local fixture = dofile("tests/helpers/progression.lua")
local api = fixture.api
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end

PLUGIN = {}
dofile("gamemodes/ix_cotz/plugins/townnpcs/libs/sh_00_townnpcs.lua")
dofile("gamemodes/ix_cotz/plugins/townnpcs/libs/sh_catalogue.lua")
local town = PLUGIN
local npc = "Stock Test"
local first = town:StepID("stock-test", "ST01")
local purchase = town:StepID("stock-test", "ST02")
local stock = town:StepID("stock-test", "ST03")
ix.item.list.test_stock_item = {name = "Test item", price = 100}
for _, id in ipairs({first, purchase, stock}) do
	api.Register(id, {keyNpc = npc, defaultActive = id == first, prerequisites = {},
		nextProgressions = {}, vendorUnlocks = {}})
	town.steps[id] = {}
end
api.definitions[purchase].prerequisites = {first}
api.definitions[stock].prerequisites = {first}
town.contacts["stock-test"] = {
	id = "stock-test", name = npc, supplies = {},
	catalogue = {test_stock_item = {step = "ST02", terms = {nil, 1, "SELLANDBUY", 1, 48, 1}}},
	progression = {{id = "ST03", stock = {item = "test_stock_item", bonus = 1}}},
}
town.upgradeChains = {}
town:BuildCatalogue()
local owner = fixture.character()
local record = api.GetCharacterProgression(owner)
record.lines[first] = {completed = true}
record.lines[stock] = {active = true}
api.SetCharacterProgression(owner, record)
check(not api.IsActive(owner, stock), "a sibling stock milestone waits for its purchase unlock")
record.lines[purchase] = {completed = true}
api.SetCharacterProgression(owner, record)
check(api.IsActive(owner, stock), "earning the purchase unlock opens the stock milestone")
local prerequisites = api.definitions[stock].prerequisites
check(#prerequisites == 2, "existing story prerequisite is retained alongside the purchase prerequisite")
town:BuildCatalogue()
check(#api.definitions[stock].prerequisites == 2, "recompiling does not duplicate the stock prerequisite")
print("PASS: " .. checks .. " catalogue stock order checks")
