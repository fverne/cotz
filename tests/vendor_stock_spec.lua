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
	WriteFloat = function() end,
	WriteBool = function() end,
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
ix.item.list.ammo = {isAmmo = true}
ix.item.list.drink_bottlewater = {category = "Consumables"}
ix.item.list.medic_bandage_1 = {category = "Aid"}
ix.item.list.drug_adrenaline = {category = "Aid"}
ix.item.list.rifle = {isWeapon = true}
local policies = {
	ammo = {4, 12},
	drink_bottlewater = {4, 12},
	medic_bandage_1 = {3, 12},
	drug_adrenaline = {2, 12},
	value_kerosene = {2, 12},
	lowtiercookerfuel = {2, 12},
	rifle = {1, 48},
}
local legacyItems = {trophy = {nil, nil, VENDOR_BUYONLY}}
for uniqueID in pairs(policies) do
	legacyItems[uniqueID] = {nil, 100, VENDOR_SELLANDBUY, 100, 0.5, 10}
end
ix.vendorStock.ApplyDefaults(legacyItems)
for uniqueID, expected in pairs(policies) do
	local data = legacyItems[uniqueID]
	check(data[VENDOR_STOCK] == expected[1] and data[VENDOR_MAXSTOCK] == expected[1],
		"saved catalog is capped for " .. uniqueID)
	check(data[VENDOR_RESTOCK_INTERVAL] == expected[2] and data[VENDOR_RESTOCK_AMOUNT] == 1,
		"saved catalog receives the correct refill policy for " .. uniqueID)
end
check(legacyItems.trophy[VENDOR_MAXSTOCK] == nil, "buy-only entries remain uncapped")
legacyItems.rifle[VENDOR_STOCK] = 0
ix.vendorStock.ApplyDefaults(legacyItems)
check(legacyItems.rifle[VENDOR_STOCK] == 0, "catalog migration does not refill depleted stock")
local limitedShop = vendor()
limitedShop.items = legacyItems
local shopper = character()
for uniqueID, expected in pairs(policies) do
	limitedShop.items[uniqueID][VENDOR_STOCK] = expected[1]
end
now = now + 47 * 3600
check(limitedShop:GetStock("rifle", shopper) == 1, "equipment starts with one item")
now = now + 47 * 3600
limitedShop:TakeStock("rifle", 1, shopper)
now = now + 3600
check(limitedShop:GetStock("rifle", shopper) == 0, "full shelves cannot bank idle refill time")
now = now + 47 * 3600 - 1
check(limitedShop:GetStock("rifle", shopper) == 0, "equipment waits the full 48 hours")
now = now + 1
check(limitedShop:GetStock("rifle", shopper) == 1, "equipment refills one at 48 hours")
limitedShop:TakeStock("ammo", 4, shopper)
now = now + 12 * 3600 - 1
check(limitedShop:GetStock("ammo", shopper) == 0, "consumables wait the full 12 hours")
now = now + 1
check(limitedShop:GetStock("ammo", shopper) == 1, "consumables refill only one at 12 hours")
now = now + 120 * 3600
check(limitedShop:GetStock("ammo", shopper) == 4, "offline refill respects the reduced cap")
limitedShop:AddItemToList("rifle", nil, 100, "SELLANDBUY", 100, 1, 10)
check(limitedShop.items.rifle[VENDOR_MAXSTOCK] == 1, "existing catalog entries are not overwritten")
local addedShop = vendor()
addedShop:AddItemToList("rifle", nil, 100, "SELLANDBUY", 100, 1, 10)
check(addedShop.items.rifle[VENDOR_MAXSTOCK] == 1
	and addedShop.items.rifle[VENDOR_RESTOCK_INTERVAL] == 48
	and addedShop.items.rifle[VENDOR_RESTOCK_AMOUNT] == 1,
	"new progression items use absolute limits despite legacy arguments")
dofile(base .. "libs/sh_npctemplates.lua")
local catalogEntries = 0
for _, template in pairs(ix.npctemplates.templates) do
	for uniqueID, data in pairs(template.items or {}) do
		if data[VENDOR_MODE] ~= VENDOR_BUYONLY then
			catalogEntries = catalogEntries + 1
			local maximum = data[VENDOR_MAXSTOCK]
			local interval = data[VENDOR_RESTOCK_INTERVAL]
			check(data[VENDOR_STOCK] == maximum, "default stock starts full for " .. uniqueID)
			check((maximum == 1 and interval == 48)
				or (maximum >= 2 and maximum <= 4 and interval == 12),
				"default entry follows a stock policy for " .. uniqueID)
			check(data[VENDOR_RESTOCK_AMOUNT] == 1, "default entry replenishes one for " .. uniqueID)
		end
	end
end
check(catalogEntries > 0, "default sale entries were checked")
ix.item.list["22lr"] = {isAmmo = true}
ix.item.list["45acp"] = {isAmmo = true}
ix.item.list["45acp41"] = {isAmmo = true}
local templateShop = vendor()
local templateMethods = {
	"Model", "Skin", "NoBubble", "DisplayName", "Description", "BuyAll", "Sherpa",
	"SoundGroup", "AnimGroupId", "IdleAnim",
}
for _, name in ipairs(templateMethods) do
	templateShop["Set" .. name] = function() end
	templateShop["Get" .. name] = function() end
end
local physicsRebuilt = false
templateShop.InitPhysObj = function() physicsRebuilt = true end
templateShop:LoadTemplate("technpc")
check(physicsRebuilt, "template model changes rebuild vendor collision physics")
check(templateShop.items["22lr"][VENDOR_MAXSTOCK] == 4
	and templateShop.items["22lr"][VENDOR_RESTOCK_AMOUNT] == 1,
	"template loading does not multiply consumable stock")
check(templateShop.items.ruger1022[VENDOR_MAXSTOCK] == 1
	and templateShop.items.ruger1022[VENDOR_RESTOCK_INTERVAL] == 48,
	"template loading enforces equipment limits")
-- Personal capacity must not refill shelves or mutate the shared catalogue.
local ranked = character()
local rankedOther = character()
local rankShop = vendor()
rankShop.items = {ammo = {10, 4, VENDOR_SELLANDBUY, 4, 12, 1},
	rifle = {10, 1, VENDOR_SELLANDBUY, 1, 48, 1}}
ix.progression.GetStockBonus = function(owner, npc, id)
	return id == "ammo" and (owner.rank or 0) or 0
end
check(rankShop:GetStock("ammo", ranked) == 4, "ranked shop starts at base stock")
now = now + 120 * 3600
ranked.rank = 1
local current, maximum = rankShop:GetStock("ammo", ranked)
check(current == 4 and maximum == 5, "capacity upgrade cannot bank old full-shelf time")
check(rankShop:GetStock("ammo", rankedOther) == 4, "another character keeps base capacity")
check(rankShop.items.ammo[VENDOR_MAXSTOCK] == 4, "capacity leaves the shared catalogue unchanged")
now = now + 12 * 3600
check(rankShop:GetStock("ammo", ranked) == 5, "new space fills at the original interval")
rankShop:TakeStock("ammo", 5, ranked)
ranked.rank = 2
current, maximum = rankShop:GetStock("ammo", ranked)
check(current == 0 and maximum == 6, "second capacity milestone does not refill depleted stock")
check(ix.vendorStock.GetItems(ranked, rankShop).ammo[VENDOR_MAXSTOCK] == 6,
	"personal shop copy exposes the actual maximum")
local rankedFresh = character()
rankedFresh.rank = 2
current, maximum = rankShop:GetStock("ammo", rankedFresh)
check(current == 4 and maximum == 6, "uninitialized stock does not give free upgraded starting supply")
now = now + 12 * 3600
check(rankShop:GetStock("ammo", ranked) == 1, "capacity does not increase passive refill quantity")
rankShop:TakeStock("ammo", 1, ranked)
rankShop:TakeStock("rifle", 1, ranked)
check(ix.vendorStock.TaskRestock(ranked, rankShop, "first"), "first qualifying completion replenishes")
check(rankShop:GetStock("ammo", ranked) == 1, "20 percent uses upgraded capacity with fractions")
check(not ix.vendorStock.TaskRestock(ranked, rankShop, "first"), "same milestone cannot restock twice")
for serial = 1, 4 do
	check(ix.vendorStock.TaskRestock(ranked, rankShop, "job", serial), "new job serial can replenish")
end
check(rankShop:GetStock("ammo", ranked) == 6, "five completions accumulate and clamp fractional stock")
check(rankShop:GetStock("rifle", ranked) == 1, "one-stock equipment needs five fractional contributions")
check(not ix.vendorStock.TaskRestock(ranked, rankShop, "job", 4), "repeated job serial cannot replenish")
rankShop.items.ammo[VENDOR_RESTOCK_INTERVAL] = 0
local _, disabledMaximum = rankShop:GetStock("ammo", ranked)
check(disabledMaximum == 4, "disabled refill policy receives no capacity benefit")

check(string.find(ix.vendorStock.FormatStock(0, 1, 0.4), "0.40 task credit", 1, true),
	"shop explains fractional progress when no complete item has replenished")
-- An already-open shop receives a complete policy before rendering a newly unlocked item.
local packets, packet = {}, nil
net.Start = function(name) packet = {name = name} end
local function writeField(kind, value, bits)
	packet[#packet + 1] = {kind = kind, value = value, bits = bits}
end
net.WriteString = function(value) writeField("string", value) end
net.WriteUInt = function(value, bits) writeField("uint", value, bits) end
net.WriteFloat = function(value) writeField("float", value) end
net.WriteBool = function(value) writeField("bool", value) end
net.Send = function() packets[#packets + 1] = packet end
local liveShop, liveOwner = vendor(), character()
liveShop.items = {optic = {1.5, 1, VENDOR_SELLANDBUY, 1, 48, 1}}
liveOwner:GetPlayer().ixVendorAdv = liveShop
ix.vendorStock.Refresh(liveOwner, liveShop)
check(#packets == 1 and packets[1].name == "ixVendorAdvStock", "live unlock sends a personal stock packet")
local readIndex = 0
local function readField(kind, bits)
	readIndex = readIndex + 1
	local field = packets[1][readIndex]
	check(field and field.kind == kind and field.bits == bits, "stock protocol field matches client reader")

	return field.value
end
net.ReadString = function() return readField("string") end
net.ReadUInt = function(bits) return readField("uint", bits) end
net.ReadFloat = function() return readField("float") end
net.ReadBool = function() return readField("bool") end
local rendered = false
local clientShop = {items = {}}
local panel = {entity = clientShop, sellingList = {}}
function panel:addItem(id)
	local policy = self.entity.items[id]
	check(policy[VENDOR_MODE] == VENDOR_SELLANDBUY and policy[VENDOR_PRICE] == 1.5,
		"new item has the correct sale mode and custom price before rendering")
	check(policy[VENDOR_RESTOCK_INTERVAL] == 48 and policy[VENDOR_RESTOCK_AMOUNT] == 1,
		"new item retains its replenishment policy")
	self.sellingList[id] = {stock = {SetText = function() rendered = true end}}
end
ix.gui = {vendor = panel}
local sourceFile = assert(io.open(base .. "sh_plugin.lua"))
local source = sourceFile:read("*a")
sourceFile:close()
local start = assert(source:find('net.Receive("ixVendorAdvStock"', 1, true))
local finish = assert(source:find('net.Receive("ixVendorAdvAddItem"', start, true))
assert((loadstring or load)(source:sub(start, finish - 1)))()
handlers.ixVendorAdvStock()
check(rendered and readIndex == #packets[1], "live item appears without reopening and consumes the complete packet")

print(string.format("PASS: %d personal vendor stock checks", checks))
