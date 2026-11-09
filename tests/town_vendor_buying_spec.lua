-- Run from the repository root: luatex --luaonly tests/town_vendor_buying_spec.lua
local context = dofile("tests/helpers/townnpcs.lua")
local town = ix.townNPCs
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local fresh = context.fixture.character()
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
check(not town:CanSellItem("drink_spirit_1", "'Haggler'"), "Haggler does not become a general buyer")
check(not town:CanSellItem("ak74", cook.name), "Spicy Lemon does not buy unrelated firearms")
check(not town:CanBuyItem(fresh, "ak74", "'Haggler'"), "Buying firearms does not add new purchase routes")
check(not town:CanBuyItem(fresh, "drink_spirit_1", cook.name), "Buying spirits does not add new purchase routes")
check(not ix.progression.CanBuyItem(fresh, "'Haggler'", "mp153"), "Existing purchase milestones still apply")
check(not town.contacts.haggler.wantedItems.ak74, "Buying firearms does not add progression hand-in candidates")

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
for _, contact in ipairs({town.contacts.haggler, cook}) do
	ix.npctemplates.templates[contact.template] = {}
	local catalogue = town.catalogues[contact.name]
	vendors:ConfigureTownTemplate(contact, catalogue, stock)
	local items = ix.npctemplates.templates[contact.template].items
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
	local extra = contact == cook and "drink_spirit_1" or "ak74"
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
