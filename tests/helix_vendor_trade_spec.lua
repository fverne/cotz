-- Run from the addon root: luatex --luaonly tests/helix_vendor_trade_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local function read(path)
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()

	return source
end

local function execute(source, environment)
	-- The selected vendor functions use GLua negation/inequality, with no continue statements.
	assert(not source:find("continue", 1, true))
	source = source:gsub("!=", "~="):gsub("!", "not ")
	assert(load(source, "vendor-trade", "t", environment))()
end

local now, requestedItem, handler = 100, "rifle", nil
local saves, tradeEvents, vendorMoney = 0, 0, 0
local entityMeta = {}
local environment = setmetatable({
	ENT = entityMeta,
	VENDOR_PRICE = 1, VENDOR_STOCK = 2, VENDOR_MODE = 3, VENDOR_MAXSTOCK = 4,
	VENDOR_SELLANDBUY = 1, VENDOR_SELLONLY = 2, VENDOR_BUYONLY = 3,
	CurTime = function() return now end,
	IsValid = function(value) return type(value) == "table" and not value.invalid end,
	L = function(value) return value end,
	PLUGIN = {SaveData = function() saves = saves + 1 end},
	hook = {Run = function(event)
		if event == "CharacterVendorTraded" then tradeEvents = tradeEvents + 1 end
	end},
	ix = {
		item = {list = {rifle = {name = "Rifle", price = 10}}, instances = {}},
		currency = {Get = function(value) return value end},
	},
	net = {
		Receive = function(_, callback) handler = callback end,
		ReadString = function() return requestedItem end,
		ReadUInt = function() return 0 end,
		ReadBool = function() return false end,
		Start = function() end, WriteString = function() end,
		WriteUInt = function() end, Send = function() end,
	},
}, {__index = _G})
local base = "gamemodes/ix_cotz/plugins/vendor_adv/"
local entitySource = read(base .. "entities/entities/ix_vendor_adv.lua")
for _, name in ipairs({"GetStock", "GetPrice", "CanSellToPlayer", "SetStock", "AddStock", "TakeStock"}) do
	local start = assert(entitySource:find("function ENT:" .. name .. "(", 1, true))
	local serverMethod = entitySource:sub(start - 1, start - 1) == "\t"
	local finish = assert(entitySource:find(serverMethod and "\n\tend" or "\nend", start, true))
	execute(entitySource:sub(start, finish + (serverMethod and 4 or 3)), environment)
end
local pluginSource = read(base .. "sh_plugin.lua")
local start = assert(pluginSource:find('net.Receive("ixVendorAdvTrade"', 1, true))
local finish = assert(pluginSource:find("\nelse", start, true))
execute(pluginSource:sub(start, finish - 1), environment)
local position = {Distance = function() return 0 end}
local shop = setmetatable({
	items = {rifle = {10, 2, 1, 5}}, receivers = {},
	GetDisplayName = function() return "Trader" end,
	GetPos = function() return position end,
	GetBuyAll = function() return false end,
	CanAccess = function(_, client) return not client.denied end,
	GiveMoney = function(_, value) vendorMoney = vendorMoney + value end,
}, {__index = entityMeta})
shop.SherpaTakeStock = entityMeta.TakeStock
local function buyer()
	local character = {money = 100, received = 0}
	local client = {
		ixVendorAdv = shop,
		GetCharacter = function() return character end,
		GetPos = function() return position end,
		NotifyLocalized = function() end,
		Notify = function() end,
	}
	character.HasSherpaVendor = function(self) return self.sherpa == true end
	character.HasMoney = function(self, value) return self.money >= value end
	character.TakeMoney = function(self, value) self.money = self.money - value end
	character.GetInventory = function(self)
		return {Add = function() self.received = self.received + 1 return true end}
	end

	return character, client
end
local function trade(client)
	now = now + 1
	handler(0, client)
end
local first, clientA = buyer()
local second, clientB = buyer()
trade(clientA)
check(first.received == 1 and first.money == 90, "purchase grants one item and charges catalog price")
check(shop:GetStock("rifle") == 1 and vendorMoney == 10, "purchase consumes one shared unit")
trade(clientB)
check(second.received == 1 and second.money == 90, "another character can buy the remaining unit")
check(shop:GetStock("rifle") == 0, "both characters consume the same shelf stock")
trade(clientA)
check(first.received == 1 and first.money == 90, "empty shared shelves cannot grant or charge")
check(saves == 2 and tradeEvents == 2, "only successful purchases save and emit trade hooks")
shop:SetStock("rifle", 2)
shop.items.rifle[3] = 3
trade(clientA)
check(first.received == 1 and shop:GetStock("rifle") == 2, "buy-only mode rejects purchase requests")
shop.items.rifle[3] = nil
trade(clientA)
check(first.received == 1, "disabled trade mode rejects purchase requests")
shop.items.rifle[3] = 2
clientA.denied = true
trade(clientA)
check(first.received == 1 and first.money == 90, "access is checked again at trade time")
clientA.denied = false
requestedItem = "unknown"
trade(clientA)
check(first.received == 1 and first.money == 90, "unknown items have no trade side effects")
requestedItem = "rifle"
first.money = 0
trade(clientA)
check(first.received == 1 and shop:GetStock("rifle") == 2, "unaffordable purchase is rejected")
first.sherpa = true
trade(clientA)
check(first.received == 2 and first.money == 0, "dev's existing Sherpa withdrawal stays free")
check(shop:GetStock("rifle") == 1, "Sherpa withdrawal uses shared stock")
trade(clientB)
check(second.received == 2 and shop:GetStock("rifle") == 0, "ordinary buyer sees Sherpa's stock depletion")
trade(clientA)
check(first.received == 2, "Sherpa cannot withdraw depleted shared stock")
shop.items.rifle[4] = nil
trade(clientA)
check(first.received == 2, "Sherpa without explicit stock is not unlimited")
trade(clientB)
check(second.received == 3, "ordinary unlimited catalog entries still sell")
clientB.ixVendorAdv = {invalid = true}
trade(clientB)
check(second.received == 3, "stale vendor sessions are rejected before dereferencing")
clientB.GetCharacter = function() return nil end
trade(clientB)
check(second.received == 3, "characterless trade requests are rejected")
check(saves == 5 and tradeEvents == 5, "rejected requests never trigger trade persistence/hooks")

print(string.format("PASS: %d dev shared-stock vendor trade checks", checks))
