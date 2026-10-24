-- Run from the addon root: luatex --luaonly tests/vendor_stock_spec.lua
local function copy(value)
	if type(value) ~= "table" then
		return value
	end
	local result = {}
	for key, entry in pairs(value) do
		result[key] = copy(entry)
	end

	return result
end

local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end

SERVER = true
CLIENT = false
PLUGIN = {}
ENT = {}
local now, currentMap, recipient, sentMessage = 100000, "marsh", nil, nil
os.time = function()
	return now
end
CurTime = function()
	return now
end
math.Clamp = function(value, minimum, maximum)
	return math.max(minimum, math.min(value, maximum))
end
table.Copy = copy
table.IsEmpty = function(value)
	return next(value) == nil
end
IsValid = function(value)
	return type(value) == "table" and not value.invalid
end
L = function(value)
	return value
end
local handlers = {}
local requestedItem = "apple"
net = {
	Start = function(message)
		sentMessage = message
	end,
	WriteString = function() end,
	WriteUInt = function() end,
	Send = function(client)
		recipient = client
	end,
	Receive = function(name, callback)
		handlers[name] = callback
	end,
	ReadString = function()
		return requestedItem
	end,
	ReadUInt = function()
		return 0
	end,
	ReadBool = function()
		return false
	end,
}
util = { AddNetworkString = function() end }
CAMI = {
	RegisterPrivilege = function() end,
	PlayerHasAccess = function()
		return false
	end,
}
properties = { Add = function() end }
hook = { Run = function() end }
game = {
	GetMap = function()
		return currentMap
	end,
}
ix = {
	config = {
		Add = function() end,
		Get = function()
			return 10
		end,
	},
	log = { AddType = function() end },
	faction = { indices = { [1] = { uniqueID = "stalker" } } },
	class = { list = {} },
	item = { list = { apple = { name = "Apple", price = 10 } }, instances = {}, Spawn = function() end },
	progression = {
		CanUseNPC = function()
			return true
		end,
		CanBuyItem = function()
			return true
		end,
	},
	currency = {
		Get = function(value)
			return value
		end,
	},
}
local base = "gamemodes/ix_cotz/plugins/vendor_adv/"
dofile(base .. "sh_plugin.lua")
PLUGIN.SaveData = function() end
dofile(base .. "entities/entities/ix_vendor_adv.lua")
dofile(base .. "libs/sv_stock.lua")
local position = {
	Distance = function()
		return 0
	end,
}
local function character()
	local character = { data = {}, money = 1000, received = 0, saves = 0 }
	local client = {
		GetCharacter = function()
			return character
		end,
		Team = function()
			return 1
		end,
		GetPos = function()
			return position
		end,
		NotifyLocalized = function(self, message)
			self.notification = message
		end,
	}
	function character:GetData(key, default)
		return self.data[key] or default
	end
	function character:SetData(key, value, noReplication)
		check(noReplication == true, "stock records are server-only")
		self.data[key] = copy(value)
	end
	function character:GetPlayer()
		return client
	end
	function character:Save()
		self.saves = self.saves + 1
	end
	function character:HasMoney(amount)
		return self.money >= amount
	end
	function character:TakeMoney(amount)
		self.money = self.money - amount
	end
	function character:HasSherpaVendor()
		return false
	end
	function character:GetInventory()
		return {
			Add = function()
				self.received = self.received + 1
				return true
			end,
		}
	end

	return character, client
end
local function vendor()
	return setmetatable({
		items = { apple = { 10, 5, VENDOR_SELLANDBUY, 10, 0.5, 2 }, unlimited = { 10 } },
		factions = {},
		classes = {},
		receivers = {},
		GetDisplayName = function()
			return "Trader"
		end,
		GetPos = function()
			return position
		end,
		GetBuyAll = function()
			return false
		end,
	}, { __index = ENT })
end
local a, clientA = character()
local b, clientB = character()
local shop = vendor()
clientA.ixVendorAdv, clientB.ixVendorAdv = shop, shop
shop.receivers = { clientA, clientB }
check(shop:GetStock("apple", a) == 5 and shop:GetStock("apple", b) == 5, "fresh characters get initial stock")
shop:TakeStock("apple", 2, a)
check(shop:GetStock("apple", a) == 3 and shop:GetStock("apple", b) == 5, "purchases are isolated")
check(recipient == clientA and sentMessage == "ixVendorAdvStock", "updates target only the stock owner")
check(shop.items.apple[VENDOR_STOCK] == 5, "trade does not mutate the NPC catalog")
local restored = character()
restored.data = copy(a.data)
check(shop:GetStock("apple", restored) == 3, "stock survives character restoration")
check(vendor():GetStock("apple", a) == 3, "NPC respawns do not reset personal stock")
currentMap = "pripyat"
check(shop:GetStock("apple", a) == 5, "different maps have separate vendor stock")
currentMap = "marsh"
now = now + 1800
check(shop:GetStock("apple", a) == 5, "elapsed interval replenishes personal stock")
check(shop:GetStock("apple", a) == 5, "reopening cannot replay restocks")
now = now + 1800 * 100
check(shop:GetStock("apple", a) == 10, "offline restocking is capped")
shop:TakeStock("apple", 20, a)
check(shop:GetStock("apple", a) == 0, "stock never becomes negative")
shop.items.apple[VENDOR_RESTOCK_INTERVAL] = 0
now = now + 1800
check(shop:GetStock("apple", a) == 0, "zero interval disables restocking")
check(shop:GetStock("unlimited", a) == nil, "unlimited catalog items remain unlimited")
local snapshot = ix.vendorStock.GetItems(b, shop)
snapshot.apple[VENDOR_STOCK] = 99
check(
	shop:GetStock("apple", b) == 5 and shop.items.apple[VENDOR_STOCK] == 5,
	"shop views are independent copies"
)
check(not pcall(ix.vendorStock.Get, nil, shop, "apple"), "stock queries require a character")
shop:SherpaAddStock("gift", 2, a)
check(shop:GetStock("gift", a) == 2 and shop:GetStock("gift", b) == 0, "sherpa deposits are personal")
shop:SherpaTakeStock("gift", 2, a)
check(
	shop.items.gift ~= nil and shop:GetStock("gift", a) == 0,
	"withdrawals do not delete the shared catalog"
)

-- Exercise the real purchase network handler, including depletion and persistence.
local buyer, buyerClient = character()
local other, otherClient = character()
local trader = vendor()
trader.items.apple[VENDOR_STOCK] = 1
buyerClient.ixVendorAdv, otherClient.ixVendorAdv = trader, trader
handlers.ixVendorAdvTrade(0, buyerClient)
check(buyer.received == 1 and buyer.money == 990, "purchase grants item and charges buyer")
check(
	trader:GetStock("apple", buyer) == 0 and trader:GetStock("apple", other) == 1,
	"network purchase uses personal stock"
)
check(buyer.saves == 1, "purchase immediately saves personal stock")
now = now + 1
handlers.ixVendorAdvTrade(0, buyerClient)
check(buyer.received == 1 and buyer.money == 990, "empty stock cannot grant items or charge money")
handlers.ixVendorAdvTrade(0, otherClient)
check(other.received == 1, "another character can buy the same catalog item")
local selectedCharacter = character()
buyerClient.GetCharacter = function()
	return selectedCharacter
end
check(
	trader:GetStock("apple", selectedCharacter) == 1,
	"another character on the same client has independent stock"
)
buyerClient.ixVendorAdvEditing = trader
trader.receivers = { buyerClient, otherClient, buyerClient }
PLUGIN:PlayerLoadedCharacter(buyerClient)
check(
	buyerClient.ixVendorAdv == nil and buyerClient.ixVendorAdvEditing == nil,
	"character switching clears vendor session"
)
check(
	#trader.receivers == 1 and trader.receivers[1] == otherClient,
	"switching removes stale stock receivers"
)
check(
	sentMessage == "ixVendorAdvClose" and recipient == buyerClient,
	"switching closes only that client's shop"
)
print(string.format("PASS: %d personal vendor stock checks", checks))
