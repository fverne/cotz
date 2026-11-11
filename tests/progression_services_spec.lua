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
dofile("tests/helpers/character_vars.lua")
dofile(base .. "libs/sh_storage.lua")
dofile(base .. "libs/sh_progression.lua")
dofile(base .. "libs/sh_expansion.lua")
dofile(base .. "libs/sh_services.lua")
ix.progression.AssignActiveRequirements = function() end
function ix.progression.Register(id, definition)
	definition.id = id
	ix.progression.definitions[id] = definition
end
ix.meta.character.__index = ix.meta.character
function ix.meta.character:GetData(key, default)
	local value = self.data[key]
	if value == nil then return default end

	return value
end
function ix.meta.character:SetData(key, value) self.data[key] = value end
function ix.meta.character:GetInventory() return self.inventory end
function ix.meta.character:GetPlayer() return self.client end
function ix.meta.character:GetName() return "Service Tester" end
function ix.meta.character:GetID() return self.id end
function ix.meta.character:HasMoney(amount) return self.money >= amount end
function ix.meta.character:TakeMoney(amount) self.money = self.money - amount end
function ix.meta.character:Save() self.saves = self.saves + 1 end
local nextID = 0
local function actor()
	nextID = nextID + 1
	local character = setmetatable({id = nextID, data = {}, vars = {}, money = 2000000, saves = 0}, ix.meta.character)
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
	ix.progression.InitializeCharacterProgression(character)

	return character
end
local function vendor(name)
	return {GetDisplayName = function() return name end, GetPos = function() return position end,
		CanAccess = function() return true end}
end
local function complete(character, id)
	ix.progression.Register(id, {nextProgressions = {}})
	ix.progression.SetCompleted(character, id)
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
	vendor("'Arena Master'"), vendor("'Ballast'"), vendor("'???'")

local function loadRepairCost(baseName)
	local path = "gamemodes/ix_cotz/schema/items/base/sh_" .. baseName .. ".lua"
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()
	local first = assert(source:find("function ITEM:GetRepairCost()", 1, true))
	local last = assert(source:find("\nend", first, true)) + 3
	local environment = {ITEM = {}, math = math}
	assert(load(source:sub(first, last), "@" .. path, "t", environment))()

	return environment.ITEM.GetRepairCost
end

for _, baseName in ipairs({"suit", "gear", "newweapons"}) do
	local character = actor()
	local item = repairItem(character, 1, baseName == "newweapons")
	item.GetRepairCost = loadRepairCost(baseName)
	for _, pricing in ipairs({{price = 1000, full = 2000}, {price = 6690, full = 3768}}) do
		item.price = pricing.price
		for _, condition in ipairs({0, 50, 100}) do
			item.data.wear, item.data.durability = condition, condition
			local offer = ix.progression.BuildServiceOffer(character.client, tech, "repair", {itemid = 1})
			if condition == 100 then
				check(offer == nil, baseName .. " at full condition needs no repair")
			else
				check(offer and offer.baseCost == pricing.full * (100 - condition) / 100,
					baseName .. " uses suit pricing at " .. condition .. "% for price " .. item.price)
			end
		end
	end
end

for _, equipment in ipairs({
	{name = "mask", isGasmask = true},
	{name = "helmet", isHelmet = true},
	{name = "combined headgear", isGasmask = true, isHelmet = true},
	{name = "sealed suit", isGasmask = true, isHelmet = true, isBodyArmor = true},
}) do
	local character = actor()
	local item = repairItem(character, 1, false)
	item.isGasmask, item.isHelmet, item.isBodyArmor = equipment.isGasmask, equipment.isHelmet, equipment.isBodyArmor
	item.price = 1000
	item.GetRepairCost = loadRepairCost(equipment.isBodyArmor and "suit" or "gear")
	for _, condition in ipairs({0, 50}) do
		item.data.durability = condition
		local expected = equipment.isBodyArmor and (condition == 0 and 2000 or 1000)
			or (condition == 0 and 667 or 333)
		for _, provider in ipairs({tech, vendor("'Boss'")}) do
			local offer = ix.progression.BuildServiceOffer(character.client, provider, "repair", {itemid = 1})
			check(offer and offer.baseCost == expected and offer.cost == expected,
				equipment.name .. " has the intended repair fee at " .. condition .. "%")
		end
	end
end

local first, second = actor(), actor()
local firstItem, secondItem = repairItem(first, 11, true), repairItem(second, 22, true)
local credit = {services = {{npc = "'Technut'", service = "repair", amount = 100}}}
check(ix.progression.GrantBenefits(first, "creditFixture", credit, "once"), "credit granted")
check(not ix.progression.GrantBenefits(first, "creditFixture", credit, "once"), "credit claim is idempotent")
check(ix.progression.GetServiceCredit(first, "'Technut'", "repair") == 100, "credit has the stated face value")
check(ix.progression.GetServiceCredit(first, "'Boss'", "repair") == 0, "credit belongs to the named provider")
check(ix.progression.GetServiceCredit(second, "'Technut'", "repair") == 0, "another character has no credit")
local noGiftOwner = actor()
check(ix.progression.GrantBenefits(noGiftOwner, "noGiftFixture", {
	items = {{item = "medic_bandage_1"}},
	services = {{npc = "'Technut'", service = "repair", amount = 100}},
}, "completion"), "non-item benefits still grant with stale gift fields")
check(#noGiftOwner.inventory.rewards == 0
	and #(ix.progression.GetLine(noGiftOwner, "noGiftFixture").pendingRewards or {}) == 0,
	"completion benefits never deliver or queue gift items")
check(ix.progression.GetServiceCredit(noGiftOwner, "'Technut'", "repair") == 100,
	"removing item gifts preserves service credits")
local giftSummary = ix.progression.GetBenefitSummary({id = "noGiftFixture", completionBenefits = {
	items = {{item = "medic_bandage_1"}},
}}, noGiftOwner)
check(giftSummary == "", "progression descriptions do not advertise stale item gifts")
local offer = ix.progression.BuildServiceOffer(first.client, tech, "repair", {itemid = 11, cost = 0, type = "hp"})
check(offer.baseCost == 400 and offer.cost == 300 and offer.field == "wear", "repair ignores forged price and field")
ix.progression.ConfirmService({}, first.client, tech, "repair", {itemid = 11, cost = 300})
ix.progression.ConfirmService({}, second.client, tech, "repair", {itemid = 22, cost = 400})
local firstMoney, secondMoney = first.money, second.money
check(ix.progression.ExecuteService(first.client, tech, "repair", true), "first concurrent quote executes")
check(firstItem.data.wear == 100 and secondItem.data.wear == 80, "one shopper cannot overwrite another shopper's repair")
check(first.money == firstMoney - 300, "only the uncovered fee is charged")
check(ix.progression.GetServiceCredit(first, "'Technut'", "repair") == 0, "actual credit is consumed once")
check(not ix.progression.ExecuteService(first.client, tech, "repair", true), "confirmation cannot replay")
check(ix.progression.ExecuteService(second.client, tech, "repair", true), "second shopper retains their own quote")
check(secondItem.data.wear == 100 and second.money == secondMoney - 400, "second shopper pays their own fee")
check(
	not ix.progression.BuildServiceOffer(first.client, tech, "repair", {itemid = 22}),
	"another character's item rejected"
)
firstItem.data.wear = 50
ix.progression.ConfirmService({}, first.client, tech, "repair", {itemid = 11})
now = now + 61
check(not ix.progression.ExecuteService(first.client, tech, "repair", true), "expired quote rejected")
check(firstItem.data.wear == 50, "expired service changes no equipment")
ix.progression.ConfirmService({}, first.client, tech, "repair", {itemid = 11})
first.client.character = second
check(not ix.progression.ExecuteService(first.client, tech, "repair", true), "switching characters invalidates quote")
first.client.character = first
ix.progression.ConfirmService({}, first.client, tech, "repair", {itemid = 11})
check(
	not ix.progression.ExecuteService(first.client, vendor("'Technut'"), "repair", true),
	"different NPC instance cannot redeem quote"
)
ix.progression.ConfirmService({}, first.client, tech, "repair", {itemid = 11})
firstItem.data.wear = 40
check(not ix.progression.ExecuteService(first.client, tech, "repair", true), "higher fee requires new consent")
ix.progression.GrantBenefits(
	first,
	"treatmentFixture",
	{services = {{npc = "'Jitters'", service = "treatment", amount = 1000}}},
	"once"
)
local medical = ix.progression.GetTreatmentOptions(first.client, doctor)
check(#medical == 4, "clinic retains all four treatment options")
local allOffer = ix.progression.BuildServiceOffer(first.client, doctor, "treatment", {type = "all", cost = 0})
check(allOffer.baseCost == 260 and allOffer.credit == 260 and allOffer.cost == 0,
	"combined treatment applies credit once and respects increased maximum health")
local clinicBefore = ix.progression.GetServiceCredit(first, "'Jitters'", "treatment")
ix.progression.ConfirmService({}, first.client, doctor, "treatment", {type = "all"})
check(ix.progression.ExecuteService(first.client, doctor, "treatment", true), "credit can cover treatment")
check(first.client.health == 125 and first.client.radiation == 0 and first.client.psyHealth == 100,
	"treatment restores the intended state without reducing wished health")
check(
	ix.progression.GetServiceCredit(first, "'Jitters'", "treatment") == clinicBefore - 260,
	"unused treatment credit is retained"
)
ix.progression.ConfirmService({}, first.client, doctor, "treatment", {type = "all"})
check(
	ix.progression.ExecuteService(first.client, doctor, "treatment", true),
	"zero-cost already-healthy treatment is safe"
)
check(
	ix.progression.GetServiceCredit(first, "'Jitters'", "treatment") == clinicBefore - 260,
	"zero fee consumes no credit"
)
check(
	#ix.progression.GetTreatmentOptions(first.client, arena) == 1,
	"arena does not acquire clinic radiation/psy services"
)
check(
	not ix.progression.BuildServiceOffer(first.client, cleaner, "treatment", {type = "hp"}),
	"unsupported service provider rejected"
)
ix.progression.Register("arenaDiscount", {keyNpc = "'Arena Master'", nextProgressions = {},
	serviceDiscounts = {{npc = "'Arena Master'", service = "treatment", fraction = 0.1}}})
ix.progression.SetCompleted(first, "arenaDiscount")
first.client.health = 25
local discounted = ix.progression.BuildServiceOffer(first.client, arena, "treatment", {type = "hp"})
check(discounted.baseCost == 200 and discounted.cost == 180, "earned discount changes only the named fee")
check(ix.progression.GetServiceDiscount(second, "'Arena Master'", "treatment") == 0, "discount is personal")
ix.progression.Register(
	"sameDiscount",
	{nextProgressions = {}, serviceDiscounts = {{npc = "'Arena Master'", service = "treatment", fraction = 0.1}}}
)
ix.progression.SetCompleted(first, "sameDiscount")
check(
	ix.progression.GetServiceDiscount(first, "'Arena Master'", "treatment") == 0.1,
	"alternative discounts do not add together"
)
check(
	not ix.progression.BuildServiceOffer(first.client, cleaner, "storage", {direction = "horizontally"}),
	"storage still requires its access milestone"
)
complete(first, "cotz/town/ballast/BA12")
first:SetData("bankW", 4)
check(not ix.progression.BuildServiceOffer(first.client, cleaner, "storage", {direction = "horizontally"}),
	"retired bank access stays disabled even with its old completion")
check(first:GetData("bankW") == 4, "retiring bank service preserves paid storage dimensions")
check(
	not ix.progression.BuildServiceOffer(first.client, wish, "wish", {type = "hp"}),
	"wish contact still requires Computer completion"
)
complete(first, "computer_artifactTasks")
ix.progression.GrantBenefits(
	first,
	"wishFixture",
	{services = {{npc = "'???'", service = "wish", amount = 25000}}},
	"once"
)
ix.progression.ConfirmService({}, first.client, wish, "wish", {type = "hp", cost = 999999})
check(ix.progression.ExecuteService(first.client, wish, "wish", true), "first wish retains zero price")
check(ix.progression.GetServiceCredit(first, "'???'", "wish") == 25000, "free wish does not spend credit")
local paidWish = ix.progression.BuildServiceOffer(first.client, wish, "wish", {type = "carryinc", cost = 0})
check(paidWish.baseCost == 1000000 and paidWish.cost == 975000, "later wish has a real fee before credit")
ix.progression.ConfirmService({}, first.client, wish, "wish", {type = "carryinc"})
check(ix.progression.ExecuteService(first.client, wish, "wish", true), "wish credit offsets a positive fee")
check(ix.progression.GetServiceCredit(first, "'???'", "wish") == 0, "wish allowance cannot be reused")
check(
	not ix.progression.BuildServiceOffer(first.client, wish, "wish", {type = "carryinc"}),
	"existing permanent wish cannot repeat"
)
check(
	not ix.progression.BuildServiceOffer(first.client, wish, "wish", {type = "weapon", itemid = 22}),
	"wish cannot alter another character's item"
)
local suit = repairItem(first, 33, false)
check(
	not ix.progression.BuildServiceOffer(first.client, wish, "wish", {type = "weapon", itemid = 33}),
	"suit cannot masquerade as weapon wish"
)
local suitOffer = ix.progression.BuildServiceOffer(first.client, tech, "repair", {itemid = 33})
check(suitOffer.baseCost == 600 and suitOffer.field == "durability", "suit repair costs are doubled")
local bossOffer = ix.progression.BuildServiceOffer(first.client, vendor("'Boss'"), "repair", {itemid = 33})
check(bossOffer.baseCost == 600 and bossOffer.cost == 600, "Boss charges the same doubled repair price")
ix.progression.Register("repairDiscount", {nextProgressions = {},
	serviceDiscounts = {{npc = "'Technut'", service = "repair", fraction = 0.05}}})
local discountCharacter = actor()
repairItem(discountCharacter, 44, false)
ix.progression.SetCompleted(discountCharacter, "repairDiscount")
local discountedRepair = ix.progression.BuildServiceOffer(discountCharacter.client, tech, "repair", {itemid = 44})
check(discountedRepair.baseCost == 600 and discountedRepair.cost == 570,
	"earned repair discount applies after doubling the base price")
local maskItem = repairItem(discountCharacter, 45, false)
maskItem.isBodyArmor, maskItem.isGasmask = false, true
maskItem.price = 1000
maskItem.GetRepairCost = loadRepairCost("gear")
maskItem.data.durability = 0
local discountedMask = ix.progression.BuildServiceOffer(discountCharacter.client, tech, "repair", {itemid = 45})
check(discountedMask.baseCost == 667 and discountedMask.cost == 634,
	"earned discount applies after reducing headgear repair costs to one third")
ix.progression.ConfirmService({}, discountCharacter.client, tech, "repair", {itemid = 45, cost = 634})
local maskMoney = discountCharacter.money
check(ix.progression.ExecuteService(discountCharacter.client, tech, "repair", true)
	and maskItem.data.durability == 100 and discountCharacter.money == maskMoney - 634,
	"headgear repair restores condition and charges the reduced discounted fee")
local restored = actor()
restored.data = copy(first.data)
restored.vars = copy(first.vars)
check(ix.progression.GetServiceCredit(
	restored,
	"'Jitters'",
	"treatment"
) == ix.progression.GetServiceCredit(first, "'Jitters'", "treatment"),
	"remaining service credit survives character restoration")
check(not ix.progression.GrantBenefits(
	restored,
	"treatmentFixture",
	{services = {{npc = "'Jitters'", service = "treatment", amount = 1000}}},
	"once"
),
	"reconnect cannot replay a service-credit grant")
check(
	not pcall(ix.progression.ValidateBenefits, {completionBenefits = {items = {{item = "missing_item"}}}}),
	"progression gift fields fail validation"
)
check(not pcall(
	ix.progression.ValidateBenefits,
	{serviceDiscounts = {{npc = "'Arena Master'", service = "treatment", fraction = 1}}}
),
	"unbounded discounts fail validation")
check(not pcall(
	ix.progression.ValidateBenefits,
	{completionBenefits = {services = {{npc = "'???'", service = "repair", amount = 50}}}}
),
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
check(ix.progression.ResolveServiceOffer(first.client, tech, "repair", false) == "BackTopic",
	"invalid service payload is rejected before indexing")
firstItem.data.wear = 90
local serviceTopic, serviceData = ix.progression.ResolveServiceOffer(
	first.client,
	tech,
	"repair",
	{itemid = 11, cost = 0}
)
check(serviceTopic == "ConfirmRepair" and serviceData.cost == 200,
	"service selection replaces a forged client price with the authoritative fee")
check(ix.progression.ResolveServiceOffer(first.client, cleaner, "storage", {option = "use"}) == "BackTopic",
	"retired storage is unavailable through forged service-menu requests")
print(string.format("PASS: %d progression service checks", checks))
