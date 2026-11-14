-- Run from the repository root: luatex --luaonly tests/town_vendor_buying_spec.lua
local context = dofile("tests/helpers/townnpcs.lua")
local town = ix.townNPCs
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local fresh = context.fixture.character()
ix.item.list.weapon_barrel_makarov = {
	name = "Makarov Barrel", category = "Weapon Components", price = 40,
	isWeaponServiceItem = true, componentKind = "barrel", weaponID = "makarov",
}
for _, contact in pairs(town.contacts) do
	if contact.enforceCatalogue then
		town:BuildBuyingItems(contact)
		check(town:CanSellItem("weapon_barrel_makarov", contact.name), "Town vendors accept workshop components")
		check(not town:CanBuyItem(fresh, "weapon_barrel_makarov", contact.name),
			"Component buying does not create component purchase routes")
	end
end
check(town:CanBuyItem(fresh, "map_usb_swamps", town.contacts.atlas.name),
	"Atlas sells the Swamps map before any progression")
ITEM = {}
dofile("gamemodes/ix_cotz/plugins/pda/items/mapusb/sh_map_usb_swamps.lua")
check(ITEM.price == 1000, "Swamps map costs 1,000 rubles")
ix.item.list.map_usb_swamps.price = ITEM.price
ITEM = nil
table.IsEmpty = function(value) return next(value) == nil end
for _, contact in pairs(town.contacts) do
	if contact.enforceCatalogue then
		for item in pairs(contact.catalogue) do
			check(town:CanSellItem(item, contact.name), "Vendors buy their catalogue goods before purchase unlocks")
		end
		for _, item in ipairs(contact.supplies) do
			check(town:CanSellItem(item, contact.name), "Vendors buy their ordinary supplies")
		end
	end
end
for _, item in ipairs({"9x19", "762x39ap", "makarov", "ak74", "mp153"}) do
	check(town:CanSellItem(item, "'Haggler'"), "Haggler buys ammunition and firearms: " .. item)
end
local cook = town.contacts["spicy-lemon"]
for _, item in ipairs(cook.buyItems) do
	check(town:CanSellItem(item, cook.name), "Spicy Lemon buys strong alcohol: " .. item)
end
local kitchenItems = {}
for item, definition in pairs(ix.item.list) do
	if definition.category == "Cookable Meat" or definition.category == "Cooked Meat" then
		kitchenItems[#kitchenItems + 1] = item
		check(town:CanSellItem(item, cook.name), "Spicy Lemon buys every meat and meal: " .. item)
		check(not town:CanBuyItem(fresh, item, cook.name), "Meat buying does not add purchase routes: " .. item)
	end
end
check(#kitchenItems > 0, "Meat and meal definitions are present in the fixture")
check(not town:CanSellItem("drink_spirit_1", "'Haggler'"), "Haggler does not become a general buyer")
check(not town:CanSellItem("ak74", cook.name), "Spicy Lemon does not buy unrelated firearms")
check(not town:CanBuyItem(fresh, "ak74", "'Haggler'"), "Buying firearms does not add new purchase routes")
check(not town:CanBuyItem(fresh, "drink_spirit_1", cook.name), "Buying spirits does not add new purchase routes")
check(not ix.progression.CanBuyItem(fresh, "'Haggler'", "mp153"), "Existing purchase milestones still apply")
check(not town.contacts.haggler.wantedItems.ak74, "Buying firearms does not add progression hand-in candidates")

local specimenItems = {}
local categoryCounts = {Artifacts = 0, ["Mutant Parts"] = 0}
for item, definition in pairs(ix.item.list) do
	if categoryCounts[definition.category] then
		specimenItems[#specimenItems + 1] = item
		categoryCounts[definition.category] = categoryCounts[definition.category] + 1
		for _, id in ipairs({"beanstalk", "egghead", "intern"}) do
			local contact = town.contacts[id]
			check(town:CanSellItem(item, contact.name), "Bunker scientists buy every artifact and part: " .. id .. "/" .. item)
		end
	end
end
check(categoryCounts.Artifacts > 0 and categoryCounts["Mutant Parts"] > 0, "Both specimen categories are loaded")

VENDOR_MODE, VENDOR_BUYONLY, VENDOR_SELLANDBUY = 3, 3, 1
ix.vendorStock = {
	ApplyDefaults = function() end,
	GetItems = function(_, vendor) return table.Copy(vendor.items) end,
}
ix.npctemplates = {templates = {}}
PLUGIN = {}
dofile("gamemodes/ix_cotz/plugins/vendor_adv/libs/sh_towncontacts.lua")
local vendors = PLUGIN
local stock = {initial = 1, maximum = 1, interval = 48, amount = 1}
local entityFile = assert(io.open("gamemodes/ix_cotz/plugins/vendor_adv/entities/entities/ix_vendor_adv.lua"))
local entitySource = entityFile:read("*a")
entityFile:close()
local priceMethod = assert(entitySource:match("(function ENT:GetPrice%([^\n]*.-\nend)"))
local vendorMeta = {}
assert(load(priceMethod, "vendor-price", "t", setmetatable({ENT = vendorMeta}, {__index = _G})))()
VENDOR_PRICE = 1
ix.item.instances = ix.item.instances or {}
ix.item.list.town_scale_test = {price = 100}
for _, mode in ipairs({"omitted", "false"}) do
	local contact = {
		name = "Scale test", template = "town_scale_test", enforceCatalogue = true,
		buyScale = 0.2, supplies = {"town_scale_test"}, buyingItems = {town_scale_test = true},
	}
	if mode == "false" then contact.buyAll = false end
	ix.npctemplates.templates[contact.template] = {}
	vendors:ConfigureTownTemplate(contact, {}, stock)
	local template = ix.npctemplates.templates[contact.template]
	check(template.scale == 0.2 and template.buyAll == false,
		"Templates apply buyScale with buyAll " .. mode)
	local vendor = setmetatable({items = {}, scale = 0.5}, {__index = vendorMeta})
	function vendor:GetBuyAll() return self.buyAll or false end
	function vendor:SetBuyAll(value) self.buyAll = value end
	check(vendors:RefreshTownVendor(vendor, contact, {}, stock), "Saved vendors receive buyScale")
	check(vendor.scale == 0.2 and not vendor:GetBuyAll(), "Scaling keeps restricted buying")
	check(vendor:GetPrice("town_scale_test", true) == 20, "Restricted buyers pay the scaled price")
	check(vendor:GetPrice("town_scale_test") == 100, "Buy scale preserves player purchase prices")
	check(not vendors:RefreshTownVendor(vendor, contact, {}, stock), "Scale refresh is idempotent")
	contact.buyScale = 0
	check(vendors:RefreshTownVendor(vendor, contact, {}, stock), "Zero buy scale refreshes saved vendors")
	check(vendor:GetPrice("town_scale_test", true) == 0, "Zero buy scale produces zero payout")
end
ix.npctemplates.templates.town_scale_test = nil
ix.item.list.town_scale_test = nil
local atlas = town.contacts.atlas
ix.npctemplates.templates[atlas.template] = {}
vendors:ConfigureTownTemplate(atlas, town.catalogues[atlas.name], stock)
local mapStock = ix.npctemplates.templates[atlas.template].items.map_usb_swamps
check(ix.npctemplates.templates[atlas.template].items.weapon_barrel_makarov[3] == VENDOR_BUYONLY,
	"Component buying uses buy-only vendor rows")
check(mapStock and mapStock[3] == VENDOR_SELLANDBUY, "Atlas templates include Swamps map sale stock")
check((mapStock[1] or ix.item.list.map_usb_swamps.price) == 1000, "Atlas's map purchase price is 1,000 rubles")
local savedAtlas = {items = {}, GetBuyAll = function() return false end, SetBuyAll = function() end}
check(vendors:RefreshTownVendor(savedAtlas, atlas, town.catalogues[atlas.name], stock),
	"Existing Atlas placements gain stock without world setup")
check(savedAtlas.items.map_usb_swamps[3] == VENDOR_SELLANDBUY, "Existing Atlas placements can sell maps")
check(savedAtlas.items.weapon_barrel_makarov[3] == VENDOR_BUYONLY,
	"Saved vendors gain component buying without first-time setup")
check(not vendors:RefreshTownVendor(savedAtlas, atlas, town.catalogues[atlas.name], stock),
	"Atlas stock reconciliation is idempotent")
for _, contact in ipairs({town.contacts.haggler, cook, town.contacts.beanstalk, town.contacts.egghead, town.contacts.intern}) do
	ix.npctemplates.templates[contact.template] = {}
	local catalogue = town.catalogues[contact.name]
	vendors:ConfigureTownTemplate(contact, catalogue, stock)
	local items = ix.npctemplates.templates[contact.template].items
	if contact == cook then
		for _, item in ipairs(kitchenItems) do
			check(items[item] and items[item][3] == VENDOR_BUYONLY, "Templates buy meat and meals: " .. item)
		end
	end
	for _, item in ipairs(contact.supplies) do
		check(items[item][3] == VENDOR_SELLANDBUY and items[item][2] ~= nil,
			"Ordinary supplies retain sale stock when also bought")
	end
	local vendor = {items = {}, receivers = {}}
	function vendor:GetBuyAll() return self.buyAll or false end
	function vendor:SetBuyAll(value) self.buyAll = value end
	function vendor:GetDisplayName() return contact.name end
	check(vendors:RefreshTownVendor(vendor, contact, catalogue, stock), "Saved vendors gain buying rows")
	check(not vendors:RefreshTownVendor(vendor, contact, catalogue, stock), "Buying refresh is idempotent")
	if contact == cook then
		for _, item in ipairs(kitchenItems) do
			check(vendor.items[item] and vendor.items[item][3] == VENDOR_BUYONLY,
				"Saved vendors gain meat and meal buying rows: " .. item)
		end
	end
	local extra = contact == cook and "drink_spirit_1" or "ak74"
	if contact.bunker then
		for _, item in ipairs(specimenItems) do
			check(items[item] and vendor.items[item], "Templates and saved bunker vendors buy specimens: " .. item)
		end
		extra = specimenItems[1]
	end
	check(vendor.items[extra][3] == VENDOR_BUYONLY, "Extra buying goods never become sale stock")

	local sentItems
	CAMI = {PlayerHasAccess = function() return false end}
	ix.log = {Add = function() end}
	net = {
		Start = function() end, WriteEntity = function() end, WriteUInt = function() end,
		WriteFloat = function() end, Send = function() end,
		WriteTable = function(value) sentItems = value end,
	}
	fresh.inventory.Sync = function() end
	local client = {GetCharacter = function() return fresh end}
	dofile("gamemodes/ix_cotz/plugins/dialogue/integrations/sh_trade.lua")
	ix.dialogue.OpenVendor(nil, client, vendor)
	check(sentItems[extra] and sentItems[extra][3] == VENDOR_BUYONLY,
		"Trade menus show extra buying goods despite missing purchase routes")
	if contact == town.contacts.haggler then
		check(sentItems.mp153 and sentItems.mp153[3] == VENDOR_BUYONLY,
			"Locked catalogue firearms remain sellable in the trade menu")
		check(vendor.items.mp153[3] == VENDOR_SELLANDBUY, "Menu filtering does not mutate shared trade modes")
	end
end
local haggler = town.contacts.haggler
haggler.disabledItems = {ak74 = true}
town:BuildBuyingItems(haggler)
check(not town:CanSellItem("ak74", haggler.name), "Disabled goods override category buying")
print("PASS: " .. checks .. " town vendor buying checks")
