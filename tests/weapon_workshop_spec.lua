-- Run from the addon root: luatex --luaonly tests/weapon_workshop_spec.lua
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end

local function copy(value)
	if type(value) ~= "table" then return value end
	local result = {}
	for key, entry in pairs(value) do result[key] = copy(entry) end

	return result
end

local function read(path)
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()

	return source
end

SERVER, CLIENT = true, false
table.Copy = copy
table.HasValue = function(values, target)
	for _, value in pairs(values) do if value == target then return true end end

	return false
end
math.Clamp = function(value, minimum, maximum) return math.max(minimum, math.min(maximum, value)) end
local roll, rolls, now = 0.1, 0, 100
math.Rand = function() rolls = rolls + 1 return roll end
CurTime = function() return now end
IsValid = function(value) return type(value) == "table" and not value.invalid end
ErrorNoHalt = function(message) error(message) end
SortedPairs = function(values)
	local keys, index = {}, 0
	for key in pairs(values) do keys[#keys + 1] = key end
	table.sort(keys)

	return function()
		index = index + 1
		local key = keys[index]
		if key then return key, values[key] end
	end
end
local timers = {}
timer = {Simple = function(_, callback) timers[#timers + 1] = callback end}
local function tick()
	local callbacks = timers
	timers = {}
	for _, callback in ipairs(callbacks) do callback() end
end
local veto
hook = {Run = function(event, _, _, itemID)
	if event == "CanPlayerInteractItem" and veto == itemID then return false end
end}
PLUGIN = {}
local workshop = PLUGIN
ix = {
	item = {list = {}, instances = {}}, char = {loaded = {}}, randomitems = {tables = {}},
	plugin = {Get = function() return workshop end},
	currency = {Get = function(amount) return amount .. " RU" end},
	progression = {definitions = {}, CanUseNPC = function(character) return not character.denied end},
	dialogue = {OrderOptions = function(options) return options end},
}
local base = "gamemodes/ix_cotz/plugins/weaponservice/"
dofile(base .. "sh_catalogue.lua")
dofile(base .. "sh_service.lua")
dofile(base .. "sh_dialogue.lua")
dofile(base .. "sv_delivery.lua")
dofile(base .. "sv_transactions.lua")
dofile("gamemodes/ix_cotz/plugins/progression/libs/sh_services.lua")
ITEM = {functions = {}}
dofile(base .. "items/base/sh_weaponcomponents.lua")
local componentBase = ITEM
ITEM = {functions = {}}
dofile(base .. "items/base/sh_weaponsalvage.lua")
local salvageBase = ITEM
local weightSource = read("gamemodes/ix_cotz/schema/items/base/sh_valuable.lua")
local weightStart = assert(weightSource:find("function ITEM:GetWeight()", 1, true))
weightSource = weightSource:sub(weightStart)
assert(load(weightSource, "@valuable weight", "t", {ITEM = salvageBase}))()
check(componentBase.base == "base_valuable" and salvageBase.base == "base_valuable",
	"immediate folders select bases that retain valuable mechanics")
local counts = {}
for id, entry in pairs(workshop.catalogue) do
	local source = read("gamemodes/ix_cotz/schema/items/newweapons/sh_" .. id .. ".lua")
	ix.item.list[id] = {uniqueID = id, name = source:match('ITEM.name%s*=%s*"([^"]+)"'),
		price = tonumber(source:match("ITEM.price%s*=%s*(%d+)")), class = "cw_" .. id}
	counts[entry.tier] = (counts[entry.tier] or 0) + 1
	for _, kind in ipairs({"barrel", "receiver"}) do
		local componentID = workshop:ComponentID(id, kind)
		ITEM = setmetatable({uniqueID = componentID}, {__index = componentBase})
		dofile(base .. "items/weaponcomponents/sh_" .. componentID .. ".lua")
		ix.item.list[componentID] = ITEM
	end
end
for _, family in pairs(workshop.salvageFamilies) do
	ITEM = setmetatable({uniqueID = family.item}, {__index = salvageBase})
	dofile(base .. "items/weaponsalvage/sh_" .. family.item .. ".lua")
	ix.item.list[family.item] = ITEM
	check(ITEM.quantity == 1 and ITEM.maxStack == 10 and ITEM.flatweight == 0 and ITEM.weight > 0,
		"each concrete salvage item declares initial units, cap and per-part weight")
end
local ingredientsToLoad = {}
for _, definition in pairs(ix.item.list) do
	for id in pairs(definition.recipe or {}) do
		if not ix.item.list[id] then ingredientsToLoad[id] = true end
	end
end
for id in pairs(ingredientsToLoad) do
	local file
	for _, folder in ipairs({"valuable", "valuables_test"}) do
		file = io.open("gamemodes/ix_cotz/schema/items/" .. folder .. "/sh_" .. id .. ".lua")
		if file then break end
	end
	assert(file, "missing recipe ingredient " .. id)
	local source = file:read("*a")
	file:close()
	ix.item.list[id] = {uniqueID = id, name = id, price = tonumber(source:match("ITEM.price%s*=%s*(%d+)")),
		quantity = tonumber(source:match("ITEM.quantity%s*=%s*(%d+)"))}
end
dofile("gamemodes/ix_cotz/plugins/randomitem/pools/task_rewards_weapons.lua")
for _, pool in ipairs({"worldspawn_1", "worldspawn_garbage_regular", "worldspawn_3", "worldspawn_4",
	"worldspawn_garbage_rare", "worldspawn_5", "worldspawn_6"}) do
	dofile("gamemodes/ix_cotz/plugins/randomitem/pools/" .. pool .. ".lua")
end
local function ingredientAvailable(id, tier)
	local pools = {"worldspawn_1"}
	if tier >= 3 then pools[#pools + 1] = "worldspawn_garbage_regular" end
	if tier >= 4 then pools[#pools + 1] = "worldspawn_3" end
	if tier >= 5 then pools[#pools + 1], pools[#pools + 2] = "worldspawn_garbage_rare", "worldspawn_4" end
	if tier >= 6 then pools[#pools + 1], pools[#pools + 2] = "worldspawn_5", "worldspawn_6" end
	for _, pool in ipairs(pools) do
		for _, entry in ipairs(ix.randomitems.tables[pool]) do
			if entry[2][1] == id and (tier >= 3 or entry[1] >= 50) then return true end
		end
	end

	return false
end
workshop:AuditCatalogue()
local expectedCounts = {11, 12, 14, 19, 57, 8, 9}
for tier, count in ipairs(expectedCounts) do check(counts[tier] == count, "reviewed tier distribution") end
check(workshop.catalogue.f2000.tier == 5, "F2000 uses its highest-weight occurrence")
check(workshop.catalogue.fnfal.family == "long_rifle", "full-power battle rifle uses long rifle salvage")
check(workshop.catalogue.vss.family == "intermediate", "9x39 uses intermediate salvage")
check(workshop.catalogue.sako85varmint.family == "pistol_smg", "rimfire uses light salvage")
for id, weapon in pairs(workshop.catalogue) do
	local total = 0
	for _, kind in ipairs({"barrel", "receiver"}) do
		local item = ix.item.list[workshop:ComponentID(id, kind)]
		local materialValue = 0
		for ingredient, quantity in pairs(item.recipe) do
			materialValue = materialValue + ix.item.list[ingredient].price * quantity
			check(ix.item.list[ingredient].salvageFamily or ingredientAvailable(ingredient, weapon.tier),
				id .. " uses ingredients available in its map difficulty band")
		end
		check(item.recipe[workshop.salvageFamilies[weapon.family].item] ~= nil, "every recipe uses its family")
		check(item.isWeaponServiceItem, "component inherits service vendor restriction marker")
		check(item.price >= 20 and item.price <= 200, "component item value stays between 20 and 200")
		if kind == "barrel" and weapon.tier >= 6 then
			check(item.recipe.value_gyroscope or item.recipe.value_controller or item.recipe.value_electr_card_programmer,
				"top-tier barrel requires a Pripyat-sourced barter item")
			local lateItem = item.recipe.value_gyroscope and "value_gyroscope"
				or item.recipe.value_controller and "value_controller" or "value_electr_card_programmer"
			check(not ingredientAvailable(lateItem, 5), "top-tier specialist input has no early-region source")
		end
		total = total + math.ceil(ix.item.list[id].price * item.commissionRate) + materialValue
	end
	local fraction = total / ix.item.list[id].price
	check(fraction >= 0.6 and fraction <= 0.8, id .. " rebuild is within nominal budget")
end
local nextActor, nextItem = 0, 0
local position = {DistToSqr = function(self) return self.distance or 0 end}
local itemMethods = {}
function itemMethods:GetData(key, default)
	if self.data[key] == nil then return default end

	return self.data[key]
end
function itemMethods:SetData(key, value) self.data[key] = value end
function itemMethods:GetCharacterID() return self.owner.id end
function itemMethods:Remove()
	if self.failRemoval then return false end
	self.owner.inventory.items[self.id] = nil
	ix.item.instances[self.id] = nil

	return true
end
local function add(character, id, data)
	nextItem = nextItem + 1
	local item = setmetatable({id = nextItem, uniqueID = id, data = copy(data or {}), owner = character}, {
		__index = function(_, key) return itemMethods[key] or ix.item.list[id][key] end,
	})
	character.inventory.items[item.id] = item
	ix.item.instances[item.id] = item

	return item
end
local function actor()
	nextActor = nextActor + 1
	local character = {id = nextActor, data = {}, money = 1000000, saves = {}}
	function character:GetData(key, default) return self.data[key] or default end
	function character:SetData(key, value) self.data[key] = copy(value) end
	function character:GetID() return self.id end
	function character:GetPlayer() return self.client end
	function character:GetInventory() return self.inventory end
	function character:HasMoney(amount) return self.money >= amount end
	function character:TakeMoney(amount) self.money = self.money - amount end
	function character:Save(callback)
		if self.delaySave then self.saves[#self.saves + 1] = callback or function() end
		elseif callback then callback() end
	end
	function character:UpdateWeight() self.weightUpdated = true end
	character.inventory = {items = {}, inserts = {}}
	function character.inventory:GetItems() return self.items end
	function character.inventory:Add(id, _, data)
		if self.full then return false, "noFit" end
		self.inserts[#self.inserts + 1] = {item = id, data = copy(data)}

		return 2, 3, 99
	end
	local client = {character = character, weapon = {invalid = true}}
	function client:GetCharacter() return self.character end
	function client:GetPos() return position end
	function client:GetWeapon() return self.weapon end
	function client:Notify(message) self.message = message end
	character.client = client
	ix.char.loaded[character.id] = character

	return character, client
end
local function vendor(name)
	return {GetClass = function() return "ix_vendor_adv" end, GetSherpa = function() return false end,
		GetDisplayName = function() return name or "'Technut'" end, CanAccess = function(self) return not self.denied end,
		GetPos = function() return position end}
end
local tech, boss = vendor(), vendor("'Boss'")
local function ingredients(character, weaponID, kind)
	for id, count in pairs(ix.item.list[workshop:ComponentID(weaponID, kind)].recipe) do
		if ix.item.list[id].quantity then add(character, id, {quantity = count})
		else for _ = 1, count do add(character, id) end end
	end
end
local function quote(client, target, item, action)
	now = now + 1
	local offer = workshop:BuildOffer(client, target, {itemid = item.id, action = action})
	workshop:QuoteWorkshop(client, target, {itemid = item.id, action = action, cost = offer and offer.cost,
		durability = offer and offer.durability, cleanliness = offer and offer.cleanliness})

	return offer
end
local function acknowledge(character)
	local insert = table.remove(character.inventory.inserts, 1)
	if not insert then return end
	local item = add(character, insert.item, insert.data)
	-- Bag inserts can have no inventory.owner; the item still identifies its character.
	workshop:InventoryItemAdded(nil, {}, item)

	return item
end
local function settle(character)
	for _ = 1, 70 do
		acknowledge(character)
		tick()
		if #workshop:Pending(character) == 0 and #character.inventory.inserts == 0 then return end
	end
	error("delivery did not settle")
end

local stackActor, stackClient = actor()
local stackSource = add(stackActor, "weapon_parts_pistol_smg", {quantity = 6})
local stackTarget = add(stackActor, "weapon_parts_pistol_smg", {quantity = 7})
stackSource.player = stackClient
local combine = salvageBase.functions.combine
check(stackSource.maxStack == 10 and stackSource.quantity == 1, "salvage declares stack cap and legacy unit default")
check(combine.OnCanRun(stackSource, {stackTarget.id}), "matching owned salvage can combine")
check(combine.OnRun(stackSource, {stackTarget.id}) == false, "manual stack mutation prevents automatic removal")
check(stackTarget.data.quantity == 10 and stackSource.data.quantity == 3,
	"combining caps target at ten and preserves remainder")
check(not combine.OnCanRun(stackSource, {stackTarget.id}), "full stack rejects another merge")
check(workshop:CountItem(stackActor, "weapon_parts_pistol_smg") == 13, "quantity-aware inventory counts all parts")
check(math.abs(stackTarget:GetWeight() - 1) < 0.00001 and stackTarget:GetPrice() == 400,
	"stack weight and nominal price scale per part")
local mixed = add(stackActor, "weapon_parts_shotgun")
check(not combine.OnCanRun(stackSource, {mixed.id}), "different salvage families cannot combine")
check(not combine.OnCanRun(stackSource, {stackSource.id}), "self-combination rejected")
check(not combine.OnCanRun(stackSource, {}), "malformed target rejected")
local foreignStack = actor()
local foreignPart = add(foreignStack, "weapon_parts_pistol_smg")
check(not combine.OnCanRun(stackSource, {foreignPart.id}), "foreign stack rejected")
local freeTarget = add(stackActor, "weapon_parts_pistol_smg", {quantity = 3})
stackSource.cotzWorkshopLocked = true
check(not combine.OnCanRun(stackSource, {freeTarget.id}), "unacknowledged source cannot merge")
stackSource.cotzWorkshopLocked = nil
freeTarget.cotzWorkshopLocked = true
check(not combine.OnCanRun(stackSource, {freeTarget.id}), "unacknowledged target cannot merge")
freeTarget.cotzWorkshopLocked = nil
stackSource.failRemoval = true
combine.OnRun(stackSource, {freeTarget.id})
check(freeTarget.data.quantity == 3 and stackSource.data.quantity == 3,
	"failed full-source removal cannot duplicate stack quantity")
stackSource.failRemoval = nil
veto = freeTarget.id
combine.OnRun(stackSource, {freeTarget.id})
check(freeTarget.data.quantity == 3 and stackSource.data.quantity == 3, "target interaction veto preserves both stacks")
veto = nil
check(combine.OnRun(stackSource, {freeTarget.id}) == false and not stackActor.inventory.items[stackSource.id],
	"complete merge removes source once")
check(freeTarget.data.quantity == 6 and stackActor.weightUpdated, "complete merge conserves units and refreshes carry weight")
combine.OnRun(stackSource, {freeTarget.id})
check(freeTarget.data.quantity == 6, "repeated merge cannot reuse a removed source")
local legacyPart = add(stackActor, "weapon_parts_pistol_smg")
legacyPart.player = stackClient
check(legacyPart:GetPrice() == 40 and legacyPart:GetWeight() == 0.1, "saved quantity-less salvage still represents one part")
combine.OnRun(legacyPart, {freeTarget.id})
check(freeTarget.data.quantity == 7, "legacy single part can join a new stack")

local vendorActor, vendorClient = actor()
local componentSale = add(vendorActor, "weapon_barrel_makarov")
check(workshop:CanPlayerTradeWithVendor(vendorClient, tech, componentSale.uniqueID, true) == nil,
	"component sales continue through normal vendor checks")
check(workshop:CanPlayerTradeWithVendor(vendorClient, tech, componentSale.uniqueID, false) == false,
	"vendors cannot sell workshop components back to players")
componentSale.cotzWorkshopLocked = true
check(workshop:CanPlayerTradeWithVendor(vendorClient, tech, componentSale.uniqueID, true) == false,
	"component cannot be sold before delivery receipt is saved")
componentSale.cotzWorkshopLocked = nil
check(workshop:CanPlayerTradeWithVendor(vendorClient, tech, "weapon_parts_pistol_smg", true) == false,
	"salvage retains its existing vendor restriction")

local stackSpend, stackSpendClient = actor()
local stackGun = add(stackSpend, "makarov")
ingredients(stackSpend, "makarov", "barrel")
local partsID = "weapon_parts_pistol_smg"
for _, item in pairs(stackSpend.inventory.items) do
	if item.uniqueID == partsID then item.data.quantity = 10 end
end
quote(stackSpendClient, tech, stackGun, "barrel")
check(workshop:ExecuteWorkshop(stackSpendClient, tech, true), "component recipe accepts a salvage stack")
check(workshop:CountItem(stackSpend, partsID) == 8, "barter consumes exact part count from stack")
settle(stackSpend)

local guaranteed, chance = workshop:SalvageYield(1, 50, 80)
check(guaranteed == 0 and math.abs(chance - 0.2) < 0.00001, "tier-one damaged/dirty probability")
guaranteed, chance = workshop:SalvageYield(5, 80, 80)
check(guaranteed == 1 and math.abs(chance - 0.6) < 0.00001, "fractional multi-part probability")
guaranteed, chance = workshop:SalvageYield(7, 100, 100)
check(guaranteed == 4 and chance == 0, "top tier yields four at perfect condition")
check(workshop:SalvageYield(7, 100, 0) == 0, "zero cleanliness gives zero salvage")
check(workshop:SalvageYield(7, -20, 200) == 0, "condition inputs are clamped")

local character, client = actor()
local gun = add(character, "makarov", {durability = 30, wear = 80})
check(#workshop:WorkshopOptions(client, tech, "WorkshopComponents") == 2, "owned gun reveals its recipes")
local duplicate = add(character, "makarov")
check(#workshop:WorkshopOptions(client, tech, "WorkshopComponents") == 2, "duplicate model deduplicates recipes")
check(#workshop:WorkshopOptions(client, tech, "WorkshopRebuild") == 2, "rebuilds identify separate instances")
duplicate:Remove()
local missing = quote(client, tech, gun, "barrel")
check(missing.blocked and not client.cotzWorkshopQuote, "missing ingredients cannot create executable quote")
ingredients(character, "makarov", "barrel")
local cash = character.money
local offer = quote(client, tech, gun, "barrel")
check(workshop:ExecuteWorkshop(client, tech, true), "component barter succeeds")
check(character.money == cash - offer.cost, "commission charged once")
check(#workshop:Pending(character) == 1 and #character.inventory.inserts == 1,
	"reserved slot retains pending delivery until insert acknowledgement")
check(not workshop:ExecuteWorkshop(client, tech, true), "duplicate confirmation cannot buy twice")
local delivered = acknowledge(character)
check(delivered and #workshop:Pending(character) == 0, "database acknowledgement clears pending output")
tick()
check(workshop:CountItem(character, "weapon_barrel_makarov") == 1, "component delivered exactly once")
add(character, "weapon_receiver_makarov")
quote(client, tech, gun, "rebuild")
check(workshop:ExecuteWorkshop(client, tech, true), "matching pair rebuilds gun")
check(gun.data.durability == 100 and gun.data.wear == 80, "rebuild restores durability and preserves cleanliness")
check(not character.inventory.items[delivered.id], "component consumed")
check(workshop:BuildOffer(client, tech, {itemid = gun.id, action = "rebuild"}).blocked ~= nil,
	"full durability rebuild unavailable")

local other, otherClient = actor()
local otherGun = add(other, "makarov", {durability = 10})
add(other, "weapon_barrel_tokarev")
add(other, "weapon_receiver_tokarev")
check(workshop:BuildOffer(otherClient, tech, {itemid = otherGun.id, action = "rebuild"}).blocked ~= nil,
	"wrong-model components cannot repair weapon")
check(not workshop:BuildOffer(otherClient, tech, {itemid = gun.id, action = "dismantle"}), "foreign weapon rejected")
check(not workshop:BuildOffer(otherClient, vendor("'Haggler'"), {itemid = otherGun.id, action = "dismantle"}),
	"non-technician rejected")
tech.denied = true
check(not workshop:CanUse(otherClient, tech), "vendor access enforced")
tech.denied = nil
position.distance = 193 ^ 2
check(not workshop:CanUse(otherClient, tech), "distance enforced")
position.distance = nil

ingredients(other, "makarov", "barrel")
other.money = 0
check(quote(otherClient, tech, otherGun, "barrel").blocked ~= nil, "insufficient money rejected")
other.money = 10000
other.data.progressionServiceCredits = {["'Technut'/repair"] = 1000}
offer = quote(otherClient, tech, otherGun, "barrel")
check(offer.cost == 0 and offer.credit == 180, "provider repair credit covers commission")
check(workshop:BuildOffer(otherClient, boss, {itemid = otherGun.id, action = "barrel"}).cost == 180,
	"other provider cannot spend Technut credit")
check(workshop:ExecuteWorkshop(otherClient, tech, true), "credit-funded purchase succeeds")
check(other.data.progressionServiceCredits["'Technut'/repair"] == 820, "credit deducted exactly once")
settle(other)

local salvageActor, salvageClient = actor()
local salvageGun = add(salvageActor, "pkm", {durability = 100, wear = 100, ammo = 1})
check(quote(salvageClient, tech, salvageGun, "dismantle").blocked ~= nil, "loaded gun cannot be dismantled")
salvageGun.data.ammo, salvageGun.data.attachments = 0, {"scope"}
check(quote(salvageClient, tech, salvageGun, "dismantle").blocked ~= nil, "attachments protected")
salvageGun.data.attachments, salvageGun.data.equip = {}, true
check(quote(salvageClient, tech, salvageGun, "dismantle").blocked ~= nil, "equipped weapon protected")
salvageGun.data.equip = false
salvageActor.inventory.full = true
quote(salvageClient, tech, salvageGun, "dismantle")
check(workshop:ExecuteWorkshop(salvageClient, tech, true), "dismantling commits with a full inventory")
check(not salvageActor.inventory.items[salvageGun.id], "dismantled weapon removed")
check(#workshop:Pending(salvageActor) == 1 and workshop:Pending(salvageActor)[1].data.quantity == 4,
	"four salvage units survive failed insertion as one stack")
local originalRolls = rolls
now = now + 1
check(not workshop:CollectWorkshopItems(salvageClient, tech), "full-inventory collection preserves reward")
check(#workshop:Pending(salvageActor) == 1 and rolls == originalRolls, "claim never rerolls salvage")
salvageActor.inventory.full = nil
workshop:PlayerLoadedCharacter(salvageClient, salvageActor)
tick()
check(#salvageActor.inventory.inserts == 1, "character load resumes fixed delivery")
salvageActor.delaySave = true
delivered = acknowledge(salvageActor)
check(delivered.cotzWorkshopLocked, "delivery stays unusable until receipt save completes")
check(workshop:CanTransferItem(delivered) == false, "unacknowledged receipt cannot transfer")
check(workshop:CanPlayerInteractItem(salvageClient, "drop", delivered.id) == false, "receipt blocks item actions")
salvageActor.delaySave = nil
table.remove(salvageActor.saves, 1)()
check(not delivered.cotzWorkshopLocked, "receipt save releases delivered item")
tick()
settle(salvageActor)
check(workshop:CountItem(salvageActor, "weapon_parts_long_rifle") == 4, "all four parts delivered once")

local failure, failureClient = actor()
local failureGun = add(failure, "makarov", {durability = 10})
-- Nuts are consumed first; a later full-item failure must restore the split stack.
add(failure, "value_nuts", {quantity = 10})
add(failure, "value_bolts", {quantity = 10})
add(failure, "weapon_parts_pistol_smg").failRemoval = true
add(failure, "weapon_parts_pistol_smg")
cash = failure.money
quote(failureClient, tech, failureGun, "barrel")
check(not workshop:ExecuteWorkshop(failureClient, tech, true), "failed input removal aborts exchange")
check(workshop:CountItem(failure, "value_nuts") == 10 and failure.money == cash,
	"partial stack restored and commission not charged")
check(workshop:CountItem(failure, "value_bolts") == 10, "second partial ingredient stack is also restored")
check(#workshop:Pending(failure) == 0, "failed barter awards no component")

local refundActor, refundClient = actor()
local refundGun = add(refundActor, "makarov")
add(refundActor, "value_nuts", {quantity = 1})
add(refundActor, "value_nuts", {quantity = 1})
add(refundActor, "value_bolts", {quantity = 1})
add(refundActor, "weapon_parts_pistol_smg").failRemoval = true
add(refundActor, "weapon_parts_pistol_smg")
quote(refundClient, tech, refundGun, "barrel")
check(not workshop:ExecuteWorkshop(refundClient, tech, true), "late failure aborts after earlier full removals")
check(#workshop:Pending(refundActor) == 2, "removed stacks queued as exact refunds")
settle(refundActor)
check(workshop:CountItem(refundActor, "value_nuts") == 2, "split-stack refunds preserve original quantities")

local stale, staleClient = actor()
local staleGun = add(stale, "f2000", {durability = 80, wear = 80})
quote(staleClient, tech, staleGun, "dismantle")
staleGun.data.wear = 50
check(not workshop:ExecuteWorkshop(staleClient, tech, true), "condition change invalidates confirmed probabilities")
quote(staleClient, tech, staleGun, "dismantle")
staleClient.character = character
check(not workshop:ExecuteWorkshop(staleClient, tech, true), "character swap invalidates quote")
staleClient.character = stale
quote(staleClient, tech, staleGun, "dismantle")
now = now + 61
check(not workshop:ExecuteWorkshop(staleClient, tech, true), "expired quote rejected")
quote(staleClient, tech, staleGun, "dismantle")
staleGun.failRemoval = true
check(not workshop:ExecuteWorkshop(staleClient, tech, true), "failed weapon removal gives no salvage")
check(#workshop:Pending(stale) == 0 and stale.inventory.items[staleGun.id], "failed dismantle preserves gun")

local equipped, equippedClient = actor()
local equippedGun = add(equipped, "makarov", {equip = true, durability = 90, wear = 50})
equippedClient.weapon = {durability = 20, cleanliness = 33}
function equippedClient.weapon:GetWeaponDurability() return self.durability end
function equippedClient.weapon:GetWeaponWear() return self.cleanliness end
function equippedClient.weapon:SetWeaponDurability(value) self.durability = value end
add(equipped, "weapon_barrel_makarov")
add(equipped, "weapon_receiver_makarov")
offer = quote(equippedClient, tech, equippedGun, "rebuild")
check(offer.durability == 20 and offer.cleanliness == 33, "equipped quote reads live SWEP condition")
check(workshop:ExecuteWorkshop(equippedClient, tech, true), "equipped gun can be rebuilt")
check(equippedClient.weapon.durability == 100 and equippedGun.data.durability == 100,
	"equipped SWEP and item both repaired")
check(equippedClient.weapon.cleanliness == 33 and equippedGun.data.wear == 33,
	"live cleanliness preserved and saved without restoring stale data")

local pendingActor, pendingClient = actor()
local pendingGun = add(pendingActor, "f2000", {durability = 80, wear = 80})
roll = 0.59
quote(pendingClient, tech, pendingGun, "dismantle")
check(workshop:ExecuteWorkshop(pendingClient, tech, true), "fractional salvage commits")
check(#workshop:Pending(pendingActor) == 1 and workshop:Pending(pendingActor)[1].data.quantity == 2,
	"fractional roll awards extra part within one stack")
-- Legacy queues and refunds can still contain additional separately tokened items.
workshop:QueueWorkshopItems(pendingActor, {{item = "weapon_receiver_makarov"}})
local freshCharacter = actor()
pendingClient.character = freshCharacter
delivered = acknowledge(pendingActor)
tick()
check(delivered.owner == pendingActor and #freshCharacter.inventory.inserts == 0,
	"late database insert stays on original character")
check(#workshop:Pending(pendingActor) == 1 and #pendingActor.inventory.inserts == 0,
	"delivery stops after character switch")
pendingClient.character = pendingActor
workshop:PlayerLoadedCharacter(pendingClient, pendingActor)
tick()
settle(pendingActor)
check(workshop:CountItem(pendingActor, "weapon_parts_intermediate") == 2,
	"character reconnect resumes remaining fixed reward")

local reconcile, reconcileClient = actor()
workshop:QueueWorkshopItems(reconcile, {{item = "weapon_barrel_makarov"}})
local token = workshop:Pending(reconcile)[1].token
add(reconcile, "weapon_barrel_makarov", {weaponWorkshopDelivery = token})
check(workshop:DeliverWorkshopItem(reconcile), "saved pending claim reconciles existing inserted token")
check(#reconcile.inventory.inserts == 0 and #workshop:Pending(reconcile) == 0,
	"reconciliation does not create a duplicate")
tick()

local reconnectOld, reconnectClient = actor()
workshop:QueueWorkshopItems(reconnectOld, {{item = "weapon_barrel_makarov"}})
workshop:DeliverWorkshopItem(reconnectOld)
local reconnectNew = actor()
ix.char.loaded[reconnectNew.id] = nil
reconnectNew.id, reconnectNew.data, reconnectNew.client = reconnectOld.id, copy(reconnectOld.data), reconnectClient
ix.char.loaded[reconnectNew.id] = reconnectNew
reconnectClient.character = reconnectNew
delivered = acknowledge(reconnectOld)
check(#workshop:Pending(reconnectNew) == 1 and not workshop:DeliverWorkshopItem(reconnectNew),
	"old insert callback cannot issue another copy into an already restored character object")
add(reconnectNew, delivered.uniqueID, delivered.data)
workshop:PlayerLoadedCharacter(reconnectClient, reconnectNew)
tick()
check(#workshop:Pending(reconnectNew) == 0 and #reconnectNew.inventory.inserts == 0,
	"next inventory restoration reconciles older in-flight token without duplication")

local blocked, blockedClient = actor()
local blockedGun = add(blocked, "makarov")
ingredients(blocked, "makarov", "barrel")
quote(blockedClient, tech, blockedGun, "barrel")
veto = blockedGun.id
quote(blockedClient, tech, blockedGun, "dismantle")
check(not workshop:ExecuteWorkshop(blockedClient, tech, true), "item-interaction veto blocks dismantling")
check(blocked.inventory.items[blockedGun.id], "veto preserves source weapon")
veto = nil

local changedPrice, changedClient = actor()
local changedGun = add(changedPrice, "makarov")
ingredients(changedPrice, "makarov", "barrel")
changedPrice.data.progressionServiceCredits = {["'Technut'/repair"] = 1000}
quote(changedClient, tech, changedGun, "barrel")
ix.item.list.makarov.price = 1800
check(not workshop:ExecuteWorkshop(changedClient, tech, true), "higher base commission invalidates even a credit-covered quote")
ix.item.list.makarov.price = 900
check(workshop:CountItem(changedPrice, "weapon_parts_pistol_smg") == 2, "price rejection preserves inputs")

local capacityFirst = actor()
local capacitySecond = actor()
workshop:QueueWorkshopItems(capacityFirst, {{item = "weapon_barrel_makarov"}})
workshop:QueueWorkshopItems(capacitySecond, {{item = "weapon_receiver_makarov"}})
workshop.settings.maxDeliveries = 1
check(workshop:DeliverWorkshopItem(capacityFirst), "first pending insert occupies bounded in-flight capacity")
check(not workshop:DeliverWorkshopItem(capacitySecond) and #workshop:Pending(capacitySecond) == 1,
	"in-flight limit preserves excess claim without allocating another insert")
acknowledge(capacityFirst)
tick()
check(workshop:DeliverWorkshopItem(capacitySecond), "acknowledgement releases in-flight capacity")
settle(capacitySecond)
workshop.settings.maxDeliveries = 128

local zeroActor, zeroClient = actor()
local zeroGun = add(zeroActor, "pkm", {durability = 100, wear = 0})
local beforeRolls = rolls
quote(zeroClient, tech, zeroGun, "dismantle")
check(workshop:ExecuteWorkshop(zeroClient, tech, true), "confirmed zero-yield dismantle destroys weapon")
check(#workshop:Pending(zeroActor) == 0 and rolls == beforeRolls, "integer zero yield does not roll or award parts")

local empty, emptyClient = actor()
add(empty, "weapon_barrel_makarov")
check(#workshop:WorkshopOptions(emptyClient, tech, "WorkshopComponents") == 0,
	"component possession alone does not reveal recipe")
local dialogue = {tree = {GREETING = {options = {}}, BackTopic = {options = {}}}}
dialogue.addTopic = function(id, data) dialogue.tree[id] = data end
workshop:ConfigureDialogue(dialogue)
workshop:ConfigureDialogue(dialogue)
check(#dialogue.tree.GREETING.options == 1 and #dialogue.tree.BackTopic.options == 1,
	"technician integration is idempotent")
CLIENT, SERVER = true, false
dialogue.tree.WorkshopConfirm.DynamicPreCallback(dialogue.tree.WorkshopConfirm, emptyClient, tech,
	{itemid = -1, action = "dismantle"})
check(#dialogue.tree.WorkshopConfirm.GetDynamicOptions(nil, emptyClient, tech) == 0,
	"invalid quote has no confirm option")

local included = {}
ix.util = {Include = function(path)
	included[#included + 1] = path
	if path:sub(1, 3) ~= "sv_" then dofile(base .. path) end
end}
dofile(base .. "sh_plugin.lua")
check(#included == 5, "shared entry explicitly includes every service module")
check(included[4] == "sv_delivery.lua" and included[5] == "sv_transactions.lua", "server code uses realm prefixes")
ix.dialogue.list = {technpc = dialogue, unisgnpc2 = {tree = {GREETING = {options = {}}, BackTopic = {options = {}}}}}
local bossDialogue = ix.dialogue.list.unisgnpc2
bossDialogue.addTopic = function(id, data) bossDialogue.tree[id] = data end
workshop:InitializedPlugins()
check(bossDialogue.tree.WeaponWorkshop and dialogue.tree.WeaponWorkshop,
	"initialization installs both technician trees after item discovery")
print("PASS: " .. checks .. " weapon workshop checks")
