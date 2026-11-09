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
local selling = false
local saves, tradeEvents, vendorMoney = 0, 0, 0
local entityMeta = {}
math.Clamp = function(value, minimum, maximum)
	return math.max(minimum, math.min(value, maximum))
end
local environment = setmetatable({
	SERVER = true,
	game = {GetMap = function() return "marsh" end},
	ENT = entityMeta,
	VENDOR_PRICE = 1, VENDOR_STOCK = 2, VENDOR_MODE = 3, VENDOR_MAXSTOCK = 4,
	VENDOR_RESTOCK_INTERVAL = 5, VENDOR_RESTOCK_AMOUNT = 6,
	VENDOR_SELLANDBUY = 1, VENDOR_SELLONLY = 2, VENDOR_BUYONLY = 3,
	CurTime = function() return now end,
	IsValid = function(value) return type(value) == "table" and not value.invalid end,
	L = function(value) return value end,
	PLUGIN = {SaveData = function() saves = saves + 1 end},
	hook = {Run = function(event)
		if event == "CharacterVendorTraded" then tradeEvents = tradeEvents + 1 end
	end},
	ix = {
		vendorStock = {},
		progression = {CanBuyItem = function(_, _, item) return item ~= "locked" end},
		item = {list = {rifle = {name = "Rifle", price = 10, GetPrice = function() end}}, instances = {[99] = {GetPrice = function() return 1 end}}},
		currency = {Get = function(value) return value end},
	},
	net = {
		Receive = function(_, callback) handler = callback end,
		ReadString = function() return requestedItem end,
		ReadUInt = function() return 99 end,
		ReadBool = function() return selling end,
		Start = function() end, WriteString = function() end,
		WriteUInt = function() end, Send = function() end,
		WriteBool = function() end, WriteFloat = function() end,
	},
}, {__index = _G})
local base = "gamemodes/ix_cotz/plugins/vendor_adv/"
execute(read(base .. "libs/sv_stock.lua"), environment)
local entitySource = read(base .. "entities/entities/ix_vendor_adv.lua")
for _, name in ipairs({"GetStock", "GetStockInterval", "GetPrice", "CanSellToPlayer", "SetStock", "AddStock",
	"TakeStock", "HasMoney", "GetMoney", "SetMoney", "GiveMoney", "TakeMoney"}) do
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
	items = {rifle = {10, 1, 1, 5, 0, 0}}, receivers = {},
	GetDisplayName = function() return "Trader" end,
	GetPos = function() return position end,
	GetBuyAll = function() return false end,
	CanAccess = function(_, client) return not client.denied end,
	GiveMoney = function(_, value) vendorMoney = vendorMoney + value end,
}, {__index = entityMeta})
shop.SherpaTakeStock = entityMeta.TakeStock
local function buyer()
	local character = {money = 100, received = 0, data = {}}
	local client = {
		ixVendorAdv = shop,
		GetCharacter = function() return character end,
		GetPos = function() return position end,
		NotifyLocalized = function() end,
		Notify = function() end,
	}
	character.GetData = function(self, key, default) return self.data[key] or default end
	character.SetData = function(self, key, value) self.data[key] = value end
	character.GetVendorStock = function(self) return self.stock or {} end
	character.SetVendorStock = function(self, value) self.stock = value end
	character.GetPlayer = function() return client end
	character.Save = function() end
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
check(shop:GetStock("rifle", first) == 0 and vendorMoney == 0,
	"purchase consumes personal stock without funding a vendor balance")
check(shop:GetStock("rifle", second) == 1, "purchase leaves another character stock intact")
check(shop.items.rifle[2] == 1, "purchase leaves catalog seed stock intact")
trade(clientB)
check(second.received == 1 and second.money == 90, "another character can buy their own unit")
check(shop:GetStock("rifle", first) == 0 and shop:GetStock("rifle", second) == 0,
	"each character depletes their own stock")
trade(clientA)
check(first.received == 1 and first.money == 90, "empty personal shelves cannot grant or charge")
check(saves == 2 and tradeEvents == 2, "only successful purchases save and emit trade hooks")
shop:SetStock("rifle", 1, first)
shop:SetStock("rifle", 1, second)
shop.items.rifle[3] = 3
trade(clientA)
check(first.received == 1 and shop:GetStock("rifle", first) == 1, "buy-only mode rejects purchase requests")
shop.items.rifle[3] = nil
trade(clientA)
check(first.received == 1, "disabled trade mode rejects purchase requests")
shop.items.rifle[3] = 2
clientA.denied = true
trade(clientA)
check(first.received == 1 and first.money == 90, "access is checked again at trade time")
clientA.denied = false
environment.ix.item.list.locked = {name = "Locked", price = 10}
shop.items.locked = {10, 1, 2, 1, 0, 0}
requestedItem = "locked"
trade(clientA)
check(first.received == 1 and first.money == 90, "progression-locked purchases are rejected")
requestedItem = "unknown"
trade(clientA)
check(first.received == 1 and first.money == 90, "unknown items have no trade side effects")
requestedItem = "rifle"
first.money = 0
trade(clientA)
check(first.received == 1 and shop:GetStock("rifle", first) == 1, "unaffordable purchase is rejected")
first.sherpa = true
trade(clientA)
check(first.received == 1 and first.money == 0, "Sherpa access grants cannot bypass ordinary vendor payment")
local opened = 0
environment.ix.sherpa = {
	IsVendor = function(entity) return entity.sherpaMode == true end,
	Open = function() opened = opened + 1 end,
}
shop.sherpaMode = true
trade(clientA)
check(opened == 1 and first.received == 1, "legacy trade requests to Sherpas use the instance trading endpoint")
check(shop:GetStock("rifle", first) == 1, "Sherpa routing does not consume legacy counted stock")
shop.sherpaMode = false
first.sherpa = false
trade(clientB)
check(second.received == 2 and shop:GetStock("rifle", second) == 0,
	"ordinary buyers continue to consume their personal catalogue stock")
trade(clientA)
check(first.received == 1, "unaffordable purchases remain rejected after Sherpa routing")
shop.items.rifle[4] = nil
trade(clientA)
check(first.received == 1, "unlimited catalogue stock still requires payment")
trade(clientB)
check(second.received == 3, "ordinary unlimited catalog entries still sell")
clientB.ixVendorAdv = {invalid = true}
trade(clientB)
check(second.received == 3, "stale vendor sessions are rejected before dereferencing")
clientB.GetCharacter = function() return nil end
trade(clientB)
check(second.received == 3, "characterless trade requests are rejected")
check(saves == 4 and tradeEvents == 4, "rejected requests never trigger trade persistence/hooks")

clientA.GetCharacter = function() return first end
local owned = {}
local sold = {uniqueID = "rifle", name = "Rifle", id = 99}
function sold:GetID() return self.id end
function sold:GetData(_, default) return default end
function sold:Remove() owned[self.id] = nil return true end
owned[99] = sold
environment.ix.item.instances[99] = sold
environment.ix.item.list.rifle.GetData = sold.GetData
first.GetInventory = function() return {GetItems = function() return owned end} end
first.GiveMoney = function(self, amount) self.money = self.money + amount end
environment.timer = {Simple = function() end}
shop.money = 0
selling = true
trade(clientA)
check(first.money == 5 and not owned[99], "A vendor with a saved zero balance pays for an accepted sale")
trade(clientA)
check(first.money == 5, "Repeated sale requests cannot pay for an already removed instance")
shop.money = -100
check(shop:HasMoney(1000000), "Even negative legacy balances cannot limit payouts")
shop:SetMoney(1)
check(shop.money == nil and shop:GetMoney() == nil, "Cash setters cannot re-enable a vendor balance")
entityMeta.GiveMoney(shop, 100)
shop:TakeMoney(100)
check(shop.money == nil, "Vendor cash credits and debits remain disabled")

local policy = {}
local policyEnvironment = setmetatable({PLUGIN = policy}, {__index = environment})
execute(read("gamemodes/ix_cotz/plugins/corechanges/sv_vendorcash.lua"), policyEnvironment)
local standardMeta = {}
policyEnvironment.ENT = standardMeta
local standardSource = read("gamemodes/helix/plugins/vendor/entities/entities/ix_vendor.lua")
for _, name in ipairs({"HasMoney", "SetMoney"}) do
	local firstLine = assert(standardSource:find("function ENT:" .. name .. "(", 1, true))
	local closing = name == "SetMoney" and "\n\tend" or "\nend"
	local lastLine = assert(standardSource:find(closing, firstLine, true))
	execute(standardSource:sub(firstLine, lastLine + #closing - 1), policyEnvironment)
end
local standard = setmetatable({money = 0, receivers = {}}, {__index = standardMeta})
check(policy:CanPlayerUseVendor(clientA, standard) == nil,
	"The cash policy preserves access-hook dispatch")
check(standard.money == nil and standard:HasMoney(1000000), "Standard vendors open without a cash limit")
standard.money = 1
check(policy:CanPlayerTradeWithVendor(clientA, standard, "rifle", true) == nil,
	"The cash policy preserves trade-hook dispatch")
check(standard.money == nil and standard:HasMoney(1000000),
	"Standard vendor trades ignore balances re-enabled through the legacy editor")

print(string.format("PASS: %d personal-stock vendor trade checks", checks))
