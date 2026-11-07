-- Run from the addon root: luatex --luaonly tests/disabled_town_items_spec.lua
SERVER = true
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

ix = {item = {list = {pda = {}, water = {}}}, progression = {definitions = {}}}
PLUGIN = {}
local root = "gamemodes/ix_cotz/plugins/"
dofile(root .. "townnpcs/libs/sh_00_townnpcs.lua")
local town = PLUGIN
local contact = {
	id = "test", name = "Test", template = "test", disabledItems = {pda = true},
	supplies = {"water"}, catalogue = {}, job = {},
	progression = {{id = "TEST01", kind = "tracker", requires = {}}},
}
town.contacts = {test = contact}
town.byName = {Test = contact}
town.settings = {jobRewards = {
	easy = {money = 1, reputation = 1}, medium = {money = 1, reputation = 1}, hard = {money = 1, reputation = 1},
}}
dofile(root .. "townnpcs/libs/sh_validation.lua")
check(#town:ValidateContacts() == 0, "disabled item without a live allocation is valid")
check(town:CanBuyItem({}, "pda", "Test") == false, "stale vendor rows cannot sell a disabled item")
check(town:CanBuyItem({}, "water", "Test") ~= false, "ordinary supplies remain available")
contact.progression[1].stock = {item = "pda", bonus = 1}
check(table.concat(town:ValidateContacts(), "\n"):find("disabled stock item", 1, true),
	"stock for a disabled suggestion is rejected")
contact.progression[1].stock = nil
contact.supplies[2] = "pda"
check(table.concat(town:ValidateContacts(), "\n"):find("disabled item in supplies", 1, true),
	"disabled suggestions cannot return as ordinary supplies")
contact.supplies[2] = nil
contact.catalogue.pda = {step = "TEST01", terms = {nil, 1, "SELLANDBUY", 1, 48, 1}}
check(table.concat(town:ValidateContacts(), "\n"):find("disabled item in catalogue", 1, true),
	"catalogue restoration is rejected")
dofile(root .. "townnpcs/libs/sh_catalogue.lua")
local ok, err = pcall(function() town:BuildCatalogue() end)
check(not ok and tostring(err):find("Disabled town item", 1, true),
	"compilation cannot bypass the author-disabled check")

ix.npctemplates = {templates = {test = {items = {pda = {nil, 50, 1, 50, 12, 1}}}}}
ix.vendorStock = {ApplyDefaults = function() end}
PLUGIN = {}
dofile(root .. "vendor_adv/libs/sh_towncontacts.lua")
local vendorPlugin = PLUGIN
local stock = {initial = 2, maximum = 2, interval = 12, amount = 1}
local catalogue = {{args = {"pda", nil, 1, "SELLANDBUY", 1, 48, 1}}}
contact.supplies[2] = "pda"
vendorPlugin:ConfigureTownTemplate(contact, catalogue, stock)
check(not ix.npctemplates.templates.test.items.pda, "template assembly removes and never re-adds disabled items")
local vendor = {items = {pda = {nil, 50, 1, 50, 12, 1}}}
function vendor:GetBuyAll() return self.buyAll or false end
function vendor:SetBuyAll(value) self.buyAll = value end
function vendor:AddItemToList(item, ...)
	self.items[item] = {...}
end
check(vendorPlugin:RefreshTownVendor(vendor, contact, catalogue, stock), "saved disabled rows are removed")
check(not vendor.items.pda and vendor.items.water, "saved refresh retains allowed supplies only")
check(not vendorPlugin:RefreshTownVendor(vendor, contact, catalogue, stock), "repeated refresh is idempotent")
vendor.items.pda = {nil, 1, 1, 1, 12, 1}
function vendor:GetDisplayName() return "Test" end
ents = {FindByClass = function() return {vendor} end}
local saved = 0
function vendorPlugin:SaveData() saved = saved + 1 end
town.catalogues = {Test = catalogue}
town.settings.supplyStock = stock
vendorPlugin:RefreshTownVendors(town)
check(not vendor.items.pda and saved == 1, "town refresh saves removal of disabled rows")
vendorPlugin:RefreshTownVendors(town)
check(saved == 1, "unchanged town refresh does not write again")
contact.buyAll, contact.buyScale = true, 0.3
check(vendorPlugin:RefreshTownVendor(vendor, contact, catalogue, stock),
	"buyer policy changes are persisted even when item rows do not change")
check(vendor:GetBuyAll() and vendor.scale == 0.3, "saved buyers receive the approved thirty-percent rate")
check(not vendorPlugin:RefreshTownVendor(vendor, contact, catalogue, stock), "buyer policy refresh is idempotent")
check(town:CanSellItem("unrequested", "Test"), "buy-all contacts accept goods outside their wanted pools")
print("PASS: " .. checks .. " disabled town item checks")
