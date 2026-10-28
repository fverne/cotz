-- Run from the addon root: luatex --luaonly tests/helix_upgrade_spec.lua
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end

local function loadMethod(path, signature, target)
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()
	local start = assert(source:find(signature, 1, true))
	local finish = assert(source:find("\nend", start, true)) + 3
	local method = source:sub(start, finish)
	-- These selected inventory methods use GLua negation/inequality but no continue statements.
	method = method:gsub("!=", "~="):gsub("!", "not ")
	assert(not method:find("continue", 1, true), "Select methods executable without changing loop control")
	assert(load(method, "@" .. path, "t", setmetatable(target, {__index = _G})))()
end

istable = function(value)
	return type(value) == "table"
end
local function copy(value)
	local result = {}
	for key, entry in pairs(value) do
		result[key] = entry
	end

	return result
end

table.Copy = copy
table.Merge = function(target, source)
	for key, value in pairs(source) do
		target[key] = value
	end
end

local inventoryMeta = {}
local inventoryPath = "gamemodes/helix/gamemode/core/meta/sh_inventory.lua"
local inventories = {}
local environment = {META = inventoryMeta, ix = {item = {inventories = inventories}}}
for _, method in ipairs({"Iter", "GetItems", "HasItems", "GetID"}) do
	loadMethod(inventoryPath, "function META:" .. method .. "(", environment)
end
local function inventory(id, width, height, slots)
	local result = setmetatable({id = id, w = width, h = height, slots = slots}, {__index = inventoryMeta})
	inventories[id] = result

	return result
end

local rifle = {id = 1, uniqueID = "rifle", data = {}}
local bag = {id = 2, uniqueID = "bag", isBag = true, data = {id = 20}}
local innerBag = {id = 3, uniqueID = "inner_bag", isBag = true, data = {id = 30}}
local ammo = {id = 4, uniqueID = "ammo", data = {}}
local main = inventory(10, 4, 2, {
	[1] = {[1] = rifle, [2] = rifle},
	[2] = {[1] = rifle, [2] = rifle},
	[3] = {[1] = true, [2] = bag},
})
inventory(20, 1, 1, {{innerBag}})
inventory(30, 1, 1, {{ammo}})
local count, positions = 0, {}
for item, x, y in main:Iter() do
	count = count + 1
	check(not positions[item], "multi-slot item is yielded once")
	positions[item] = {x, y}
end
check(count == 2, "iterator skips reserved cells, empty columns and nested contents")
check(positions[rifle][1] == 1 and positions[rifle][2] == 1, "iterator returns the occupied cell coordinates")
check(positions[bag][1] == 3 and positions[bag][2] == 2, "iterator reaches items after reserved cells")
check(main:GetItems()[ammo.id] == ammo, "recursive enumeration retains nested bag items")
check(main:GetItems(true)[ammo.id] == nil, "onlyMain excludes nested bags")
check(main:HasItems({"rifle", "ammo"}), "multi-item search reaches nested bags")
check(not main:HasItems({"rifle", "rifle"}), "one multi-slot rifle cannot satisfy two required rifles")
local empty = inventory(40, 2, 2, {})
check(empty:Iter()() == nil, "empty iterator terminates")
local iter = main:Iter()
iter()
iter()
check(iter() == nil and iter() == nil, "exhausted iterator stays exhausted")

local stamina = {}
loadMethod("gamemodes/ix_cotz/plugins/stm/sh_plugin.lua", "function PLUGIN:SetupMove(", {PLUGIN = stamina})
local client = {
	exhausted = true,
	walkSpeed = 130,
	GetNetVar = function(self) return self.exhausted end,
	GetWalkSpeed = function(self) return self.walkSpeed end,
}
local move = {
	speed = 300,
	GetMaxClientSpeed = function(self) return self.speed end,
	SetMaxClientSpeed = function(self, speed) self.speed = speed end,
}
stamina:SetupMove(client, move)
check(move.speed == 130, "exhaustion caps sprinting to current walk speed")
move.speed = 1
stamina:SetupMove(client, move)
check(move.speed == 1, "exhaustion cannot increase a stricter movement limit")
client.exhausted = false
move.speed = 300
stamina:SetupMove(client, move)
check(move.speed == 300, "recovered stamina leaves modified sprint speed intact")
client.exhausted = true
client.walkSpeed = 1
stamina:SetupMove(client, move)
check(move.speed == 1, "heavy encumbrance remains effective while exhausted")

VENDOR_SELLANDBUY, VENDOR_SELLONLY, VENDOR_BUYONLY = 1, 2, 3
VENDOR_PRICE, VENDOR_STOCK, VENDOR_MODE, VENDOR_MAXSTOCK = 1, 2, 3, 4
local entityMeta = {}
local access, sherpa, money, stock = true, false, 100, 1
local character = {
	HasSherpaVendor = function() return sherpa end,
	HasMoney = function(_, price) return money >= price end,
}
client.GetCharacter = function() return character end
local items = {rifle = {price = 10}}
local vendorEnvironment = {
	ENT = entityMeta,
	ix = {
		item = {list = items, instances = {}},
	},
}
local entityPath = "gamemodes/ix_cotz/plugins/vendor_adv/entities/entities/ix_vendor_adv.lua"
loadMethod(entityPath, "function ENT:CanSellToPlayer(", vendorEnvironment)
loadMethod(entityPath, "function ENT:GetPrice(", vendorEnvironment)
local vendor = setmetatable({
	items = {rifle = {[VENDOR_MODE] = VENDOR_SELLANDBUY}},
	CanAccess = function() return access end,
	GetDisplayName = function() return "Trader" end,
	GetStock = function() return stock end,
}, {__index = entityMeta})
check(vendor:CanSellToPlayer(client, "rifle"), "available ordinary stock can be purchased")
vendor.items.rifle[VENDOR_MODE] = VENDOR_BUYONLY
check(not vendor:CanSellToPlayer(client, "rifle"), "buy-only vendor cannot sell to player")
vendor.items.rifle[VENDOR_MODE] = nil
check(not vendor:CanSellToPlayer(client, "rifle"), "disabled trade mode cannot sell")
vendor.items.rifle[VENDOR_MODE] = VENDOR_SELLONLY
money = 0
check(not vendor:CanSellToPlayer(client, "rifle"), "ordinary purchase needs enough money")
sherpa = true
check(vendor:CanSellToPlayer(client, "rifle"), "Sherpa withdrawal remains free")
stock = 0
check(not vendor:CanSellToPlayer(client, "rifle"), "Sherpa cannot withdraw depleted stock")
stock = nil
check(not vendor:CanSellToPlayer(client, "rifle"), "Sherpa missing stock is not unlimited")
sherpa, money = false, 100
check(vendor:CanSellToPlayer(client, "rifle"), "ordinary unlimited stock stays available")
access = false
check(not vendor:CanSellToPlayer(client, "rifle"), "vendor access is authoritative")
access = true
check(not vendor:CanSellToPlayer(client, "unknown"), "unknown item cannot be purchased")
check(vendor:GetPrice("unknown") == 0, "unknown item pricing does not dereference nil")
check(vendor:GetPrice("rifle") == 10, "catalog price is retained")
loadMethod(entityPath, "function ENT:GetStock(", vendorEnvironment)
local sharedVendor = setmetatable({items = {rifle = {10, 2, VENDOR_SELLANDBUY, 5}}}, {__index = entityMeta})
check(sharedVendor:GetStock("rifle", character) == 2, "dev stock is shared vendor stock")
sharedVendor.items.rifle[VENDOR_STOCK] = 1
check(sharedVendor:GetStock("rifle", {}) == 1, "another character sees the same depleted shelf")
check(sharedVendor:GetStock("unknown") == nil, "unknown catalog entry has no stock")


local renderer = {requestList = {}, cache = {}}
local renderedMaterial, renderedCamera, captures, writes = nil, nil, 0, 0
renderer.renderEntity = {
	SetModel = function() end,
	SetMaterial = function(_, material) renderedMaterial = material end,
	LookupBone = function() return nil end,
}
renderer.renderHook = function(self)
	renderedCamera = self.info
end
local rendererEnvironment = {
	ikon = renderer,
	schemaName = "test",
	ScrW = function() return 1920 end,
	ScrH = function() return 1080 end,
	IsValid = function() return true end,
	render = {
		GetRenderTarget = function() end,
		PushRenderTarget = function() end,
		PopRenderTarget = function() end,
		Capture = function() captures = captures + 1 return "png" end,
	},
	file = {
		Write = function() writes = writes + 1 end,
		Delete = function() end,
	},
	timer = {Simple = function(_, callback) callback() end},
	Material = function(path) return path end,
}
loadMethod("gamemodes/helix/gamemode/core/libs/thirdparty/cl_ikon.lua",
	"function ikon:renderIcon(", rendererEnvironment)
local camera = {fov = 45}
check(renderer:renderIcon("custom", 2, 2, "model", camera, false, "custom/material"),
	"material-aware renderer accepts the trailing material argument")
check(renderedMaterial == "custom/material" and renderedCamera == camera,
	"custom material and camera reach rendering")
check(renderer:renderIcon("normal", 1, 1, "model", camera, true),
	"upstream renderer call signature remains valid")
check(renderedMaterial == "", "unmodified icon resets the previous material")
check(renderer.cache.normal ~= nil and renderer.cache.custom == nil,
	"upstream updateCache argument retains its position and meaning")
check(captures == 2 and writes == 3, "each call captures once and optional cache refresh writes once more")

print(string.format("PASS: %d Helix upgrade regression checks", checks))
