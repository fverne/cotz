-- Run from the addon root: luatex --luaonly tests/progression_services_spec.lua
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end
local function copy(value)
	if type(value) ~= "table" then return value end
	local result = {}
	for key, item in pairs(value) do result[key] = copy(item) end

	return result
end
SERVER, CLIENT = true, false
math.Clamp = function(value, minimum, maximum) return math.max(minimum, math.min(maximum, value)) end
math.Round = function(value) return math.floor(value + 0.5) end
table.Copy = copy
table.Count = function(value)
	local count = 0
	for _ in pairs(value) do count = count + 1 end

	return count
end
local now = 100
CurTime = function() return now end
IsValid = function(value) return type(value) == "table" and not value.invalid end
istable = function(value) return type(value) == "table" end
isnumber = function(value) return type(value) == "number" end
tobool = function(value) return value == true end
hook = {Add = function() end, Run = function() end}
game = {GetMap = function() return "rp_marsh_cs" end}
local position = {DistToSqr = function() return 0 end}
local config = {bankW = 2, bankH = 2, bankWMax = 4, bankHMax = 4}
ix = {
	meta = {character = {}}, progression = {definitions = {}},
	config = {Get = function(key, default) return config[key] or default end},
	currency = {Get = function(value) return tostring(value) end},
	item = {list = {medic_antirad_1 = {name = "Antirad"}}},
	dialogue = {notifyMoneyLost = function() end}, chat = {Send = function() end},
}
local base = "gamemodes/ix_cotz/plugins/progression/"
dofile(base .. "libs/sh_storage.lua")
dofile(base .. "libs/sh_progression.lua")
dofile(base .. "libs/sh_expansion.lua")
dofile(base .. "libs/sh_services.lua")
local api = ix.progression
api.AssignActiveRequirements = function() end
function api.Register(id, definition)
	definition.id = id
	api.definitions[id] = definition
end
local meta = ix.meta.character
meta.__index = meta
function meta:GetData(key, default)
	local value = self.data[key]
	if value == nil then return default end

	return value
end
function meta:SetData(key, value) self.data[key] = value end
function meta:GetInventory() return self.inventory end
function meta:GetPlayer() return self.client end
function meta:GetName() return "Service Tester" end
function meta:GetID() return self.id end
function meta:HasMoney(amount) return self.money >= amount end
function meta:TakeMoney(amount) self.money = self.money - amount end
function meta:Save() self.saves = self.saves + 1 end
local nextID = 0
local function actor()
	nextID = nextID + 1
	local character = setmetatable({id = nextID, data = {}, money = 2000000, saves = 0}, meta)
	character.inventory = {items = {}, rewards = {}}
	function character.inventory:GetItems() return self.items end
	function character.inventory:Add(item, _, data)
		self.rewards[#self.rewards + 1] = {item = item, data = data}

		return true
	end
	character.client = {character = character, health = 50, maxHealth = 125, radiation = 10, psyHealth = 80}
	local client = character.client
	function client:GetCharacter() return self.character end
	function client:GetPos() return position end
	function client:Health() return self.health end
	function client:GetMaxHealth() return self.maxHealth end
	function client:SetHealth(value) self.health = value end
	function client:SetMaxHealth(value) self.maxHealth = value end
	function client:getRadiation() return self.radiation end
	function client:setRadiation(value) self.radiation = value end
	function client:GetPsyHealth() return self.psyHealth end
	function client:SetPsyHealth(value) self.psyHealth = value end
	function client:GetWeapon() return {invalid = true} end
	function client:RecalculateResistances() self.recalculated = true end
	function client:Notify(text) self.notification = text end
	api.InitializeCharacterProgression(character)

	return character
end
local function vendor(name)
	return {GetDisplayName = function() return name end, GetPos = function() return position end,
		CanAccess = function() return true end}
end
local function complete(character, id)
	api.Register(id, {nextProgressions = {}})
	api.SetCompleted(character, id)
end
local function repairItem(character, id, weapon)
	local item = {id = id, canRepair = true, isWeapon = weapon, isBodyArmor = not weapon, data = {wear = 80, durability = 70}}
	function item:GetID() return self.id end
	function item:GetName() return "Test equipment" end
	function item:GetData(key, default)
		if self.data[key] ~= nil then return self.data[key] end

		return default
	end
	function item:SetData(key, value) self.data[key] = value end
	function item:GetRepairCost() return 10 end
	character.inventory.items[id] = item

	return item
end
local tech, doctor, arena, cleaner, wish = vendor("'Technut'"), vendor("'Jitters'"),
	vendor("'Arena Master'"), vendor("'Cleaner'"), vendor("'???'")
local first, second = actor(), actor()
local firstItem, secondItem = repairItem(first, 11, true), repairItem(second, 22, true)
local credit = {services = {{npc = "'Technut'", service = "repair", amount = 100}}}
check(api.GrantBenefits(first, "creditFixture", credit, "once"), "credit granted")
check(not api.GrantBenefits(first, "creditFixture", credit, "once"), "credit claim is idempotent")
check(api.GetServiceCredit(first, "'Technut'", "repair") == 100, "credit has the stated face value")
check(api.GetServiceCredit(first, "'Boss'", "repair") == 0, "credit belongs to the named provider")
check(api.GetServiceCredit(second, "'Technut'", "repair") == 0, "another character has no credit")
local offer = api.BuildServiceOffer(first.client, tech, "repair", {itemid = 11, cost = 0, type = "hp"})
check(offer.baseCost == 400 and offer.cost == 300 and offer.field == "wear", "repair ignores forged price and field")
api.ConfirmService({}, first.client, tech, "repair", {itemid = 11, cost = 300})
api.ConfirmService({}, second.client, tech, "repair", {itemid = 22, cost = 400})
local firstMoney, secondMoney = first.money, second.money
check(api.ExecuteService(first.client, tech, "repair", true), "first concurrent quote executes")
check(firstItem.data.wear == 100 and secondItem.data.wear == 80, "one shopper cannot overwrite another shopper's repair")
check(first.money == firstMoney - 300, "only the uncovered fee is charged")
check(api.GetServiceCredit(first, "'Technut'", "repair") == 0, "actual credit is consumed once")
check(not api.ExecuteService(first.client, tech, "repair", true), "confirmation cannot replay")
check(api.ExecuteService(second.client, tech, "repair", true), "second shopper retains their own quote")
check(secondItem.data.wear == 100 and second.money == secondMoney - 400, "second shopper pays their own fee")
check(not api.BuildServiceOffer(first.client, tech, "repair", {itemid = 22}), "another character's item rejected")
firstItem.data.wear = 50
api.ConfirmService({}, first.client, tech, "repair", {itemid = 11})
now = now + 61
check(not api.ExecuteService(first.client, tech, "repair", true), "expired quote rejected")
check(firstItem.data.wear == 50, "expired service changes no equipment")
api.ConfirmService({}, first.client, tech, "repair", {itemid = 11})
first.client.character = second
check(not api.ExecuteService(first.client, tech, "repair", true), "switching characters invalidates quote")
first.client.character = first
api.ConfirmService({}, first.client, tech, "repair", {itemid = 11})
check(not api.ExecuteService(first.client, vendor("'Technut'"), "repair", true), "different NPC instance cannot redeem quote")
api.ConfirmService({}, first.client, tech, "repair", {itemid = 11})
firstItem.data.wear = 40
check(not api.ExecuteService(first.client, tech, "repair", true), "higher fee requires new consent")
api.GrantBenefits(first, "treatmentFixture", {services = {{npc = "'Jitters'", service = "treatment", amount = 1000}}}, "once")
local medical = api.GetTreatmentOptions(first.client, doctor)
check(#medical == 4, "clinic retains all four treatment options")
local allOffer = api.BuildServiceOffer(first.client, doctor, "treatment", {type = "all", cost = 0})
check(allOffer.baseCost == 260 and allOffer.credit == 260 and allOffer.cost == 0,
	"combined treatment applies credit once and respects increased maximum health")
local clinicBefore = api.GetServiceCredit(first, "'Jitters'", "treatment")
api.ConfirmService({}, first.client, doctor, "treatment", {type = "all"})
check(api.ExecuteService(first.client, doctor, "treatment", true), "credit can cover treatment")
check(first.client.health == 125 and first.client.radiation == 0 and first.client.psyHealth == 100,
	"treatment restores the intended state without reducing wished health")
check(api.GetServiceCredit(first, "'Jitters'", "treatment") == clinicBefore - 260, "unused treatment credit is retained")
api.ConfirmService({}, first.client, doctor, "treatment", {type = "all"})
check(api.ExecuteService(first.client, doctor, "treatment", true), "zero-cost already-healthy treatment is safe")
check(api.GetServiceCredit(first, "'Jitters'", "treatment") == clinicBefore - 260, "zero fee consumes no credit")
check(#api.GetTreatmentOptions(first.client, arena) == 1, "arena does not acquire clinic radiation/psy services")
check(not api.BuildServiceOffer(first.client, cleaner, "treatment", {type = "hp"}), "unsupported service provider rejected")
api.Register("arenaDiscount", {keyNpc = "'Arena Master'", nextProgressions = {},
	serviceDiscounts = {{npc = "'Arena Master'", service = "treatment", fraction = 0.1}}})
api.SetCompleted(first, "arenaDiscount")
first.client.health = 25
local discounted = api.BuildServiceOffer(first.client, arena, "treatment", {type = "hp"})
check(discounted.baseCost == 200 and discounted.cost == 180, "earned discount changes only the named fee")
check(api.GetServiceDiscount(second, "'Arena Master'", "treatment") == 0, "discount is personal")
api.Register("sameDiscount", {nextProgressions = {}, serviceDiscounts = {{npc = "'Arena Master'", service = "treatment", fraction = 0.1}}})
api.SetCompleted(first, "sameDiscount")
check(api.GetServiceDiscount(first, "'Arena Master'", "treatment") == 0.1, "alternative discounts do not add together")
check(not api.BuildServiceOffer(first.client, cleaner, "storage", {direction = "horizontally"}), "storage still requires its access milestone")
complete(first, "cleanerItemDelivery_Storage")
api.GrantBenefits(first, "storageFixture", {services = {{npc = "'Cleaner'", service = "storage", amount = 300}}}, "once")
local expansion = api.BuildServiceOffer(first.client, cleaner, "storage", {direction = "horizontally", cost = 0})
check(expansion.baseCost == math.Round(120 ^ (1 + 2 / 5.5)), "storage retains its existing price curve")
api.ConfirmService({}, first.client, cleaner, "storage", {direction = "horizontally"})
check(api.ExecuteService(first.client, cleaner, "storage", true), "storage credit redeems through normal expansion")
check(first:GetData("bankW") == 3, "storage grows only one step")
first:SetData("bankW", 4)
local retainedStorageCredit = api.GetServiceCredit(first, "'Cleaner'", "storage")
check(not api.BuildServiceOffer(first.client, cleaner, "storage", {direction = "horizontally"}), "maximum storage remains a hard limit")
check(api.GetServiceCredit(first, "'Cleaner'", "storage") == retainedStorageCredit, "full storage does not convert credit to money")
check(not api.BuildServiceOffer(first.client, wish, "wish", {type = "hp"}), "wish contact still requires Computer completion")
complete(first, "computer_artifactTasks")
api.GrantBenefits(first, "wishFixture", {services = {{npc = "'???'", service = "wish", amount = 25000}}}, "once")
api.ConfirmService({}, first.client, wish, "wish", {type = "hp", cost = 999999})
check(api.ExecuteService(first.client, wish, "wish", true), "first wish retains zero price")
check(api.GetServiceCredit(first, "'???'", "wish") == 25000, "free wish does not spend credit")
local paidWish = api.BuildServiceOffer(first.client, wish, "wish", {type = "carryinc", cost = 0})
check(paidWish.baseCost == 1000000 and paidWish.cost == 975000, "later wish has a real fee before credit")
api.ConfirmService({}, first.client, wish, "wish", {type = "carryinc"})
check(api.ExecuteService(first.client, wish, "wish", true), "wish credit offsets a positive fee")
check(api.GetServiceCredit(first, "'???'", "wish") == 0, "wish allowance cannot be reused")
check(not api.BuildServiceOffer(first.client, wish, "wish", {type = "carryinc"}), "existing permanent wish cannot repeat")
check(not api.BuildServiceOffer(first.client, wish, "wish", {type = "weapon", itemid = 22}), "wish cannot alter another character's item")
local suit = repairItem(first, 33, false)
check(not api.BuildServiceOffer(first.client, wish, "wish", {type = "weapon", itemid = 33}), "suit cannot masquerade as weapon wish")
local suitOffer = api.BuildServiceOffer(first.client, tech, "repair", {itemid = 33})
check(suitOffer.baseCost == 600 and suitOffer.field == "durability", "suit repair costs are doubled")
local bossOffer = api.BuildServiceOffer(first.client, vendor("'Boss'"), "repair", {itemid = 33})
check(bossOffer.baseCost == 600 and bossOffer.cost == 600, "Boss charges the same doubled repair price")
api.Register("repairDiscount", {nextProgressions = {},
	serviceDiscounts = {{npc = "'Technut'", service = "repair", fraction = 0.05}}})
local discountCharacter = actor()
repairItem(discountCharacter, 44, false)
api.SetCompleted(discountCharacter, "repairDiscount")
local discountedRepair = api.BuildServiceOffer(discountCharacter.client, tech, "repair", {itemid = 44})
check(discountedRepair.baseCost == 600 and discountedRepair.cost == 570,
	"earned repair discount applies after doubling the base price")
local restored = actor()
restored.data = copy(first.data)
check(api.GetServiceCredit(restored, "'Jitters'", "treatment") == api.GetServiceCredit(first, "'Jitters'", "treatment"),
	"remaining service credit survives character restoration")
check(not api.GrantBenefits(restored, "treatmentFixture", {services = {{npc = "'Jitters'", service = "treatment", amount = 1000}}}, "once"),
	"reconnect cannot replay a service-credit grant")
check(not pcall(api.ValidateBenefits, {completionBenefits = {items = {{item = "missing_item"}}}}), "unknown reward items fail validation")
check(not pcall(api.ValidateBenefits, {serviceDiscounts = {{npc = "'Arena Master'", service = "treatment", fraction = 1}}}),
	"unbounded discounts fail validation")
check(not pcall(api.ValidateBenefits, {completionBenefits = {services = {{npc = "'???'", service = "repair", amount = 50}}}}),
	"unsupported service rewards fail validation")

-- Exercise actual NPC confirmation callbacks rather than only the helper API.
local function loadTopic(filename, name)
	local file = assert(io.open("gamemodes/ix_cotz/plugins/dialogue/dialogue/" .. filename))
	local source = file:read("*a")
	file:close()
	local start = assert(source:find('DIALOGUE.addTopic("' .. name .. '"', 1, true))
	local finish = source:find("\nDIALOGUE.addTopic", start + 1, true) or #source + 1
	local result
	DIALOGUE = {addTopic = function(_, topic) result = topic end}
	assert((loadstring or load)(source:sub(start, finish - 1)))()
	DIALOGUE = nil

	return result
end
local confirmation = loadTopic("sh_technpc.lua", "ConfirmRepair")
firstItem.data.wear = 90
confirmation:DynamicPreCallback(first.client, tech, {itemid = 11, cost = 0})
confirmation:ResolveDynamicOption(first.client, tech, {accepted = true})
check(firstItem.data.wear == 90, "forged cheap confirmation cannot repair an item")
confirmation:DynamicPreCallback(first.client, tech, {itemid = 11, cost = 200})
confirmation:ResolveDynamicOption(first.client, tech, {accepted = true})
check(firstItem.data.wear == 100, "real repair confirmation uses recalculated per-player quote")
local clinical = loadTopic("sh_medicnpc.lua", "ConfirmHeal")
first.client.health = 75
clinical:DynamicPreCallback(first.client, doctor, {type = "hp", cost = 0})
clinical:ResolveDynamicOption(first.client, doctor, {accepted = true})
check(first.client.health == 125, "real clinic confirmation uses the shared bounded service path")
check(api.ResolveServiceOffer(first.client, tech, "repair", false) == "BackTopic",
	"invalid service payload is rejected before indexing")
firstItem.data.wear = 90
local serviceTopic, serviceData = api.ResolveServiceOffer(first.client, tech, "repair", {itemid = 11, cost = 0})
check(serviceTopic == "ConfirmRepair" and serviceData.cost == 200,
	"service selection replaces a forged client price with the authoritative fee")
check(api.ResolveServiceOffer(first.client, cleaner, "storage", {option = "use"}) == "OpenStorage",
	"unlocked storage remains available through the service menu")
print(string.format("PASS: %d progression service checks", checks))
