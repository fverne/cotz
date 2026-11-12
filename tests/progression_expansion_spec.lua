-- Run from the addon root: luatex --luaonly tests/progression_expansion_spec.lua
local context = dofile("tests/helpers/townnpcs.lua")
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local function putLine(character, id, line)
	local record = ix.progression.GetCharacterProgression(character)
	record.lines[id] = line
	ix.progression.SetCharacterProgression(character, record)
end

local target = "cotz/town/old-timer/v3/knives/knife4"
local parent = "cotz/town/old-timer/v3/knives/knife3"
local stock = target .. "/stock"
local owner = context.fixture.character()
putLine(owner, parent, {completed = true, completionRewardsPaid = true})
putLine(owner, target, {
	active = true, requirements = {medic_bandage_1 = 10, value_bolts = 4},
	complexData = {medic_bandage_1 = 2, value_bolts = 1},
	rewardCredit = {money = 9.25, reputation = 3.5},
	selections = {{item = "medic_bandage_1"}, {item = "value_bolts"}},
})
check(not ix.progression.IsActive(owner, target), "new intermission gates an already active unfinished unlock")
ix.progression.AssignActiveRequirements(owner)
check(ix.progression.IsActive(owner, stock), "completed parents activate newly inserted intermissions")
local line = ix.progression.GetLine(owner, target)
check(line.requirements.medic_bandage_1 == 2 and line.complexData.medic_bandage_1 == 2,
	"conversion retains fulfilled nonvaluable contributions without requesting more")
check(line.requirements.value_bolts == 4 and line.complexData.value_bolts == 1,
	"eligible saved requests and their contributions remain unchanged")
check(#line.requirementConversions == 1 and line.requirementConversions[1].quantity == 8,
	"only the outstanding invalid units are converted")
local replacement = line.requirementConversions[1].to
check(ix.progression.definitions[target].allowedRequirements[replacement] and line.requirements[replacement] == 8,
	"converted units require a saved eligible regional item")
check(line.rewardCredit.money == 9.25 and line.rewardCredit.reputation == 3.5,
	"conversion preserves recorded cash and reputation without repricing old contributions")
ix.progression.AssignActiveRequirements(owner)
local restored = ix.progression.GetLine(owner, target)
check(#restored.requirementConversions == 1 and restored.requirementConversions[1].to == replacement,
	"reinitialization never rerolls or repeats a saved conversion")
check(owner.money == 0, "conversion and activation never pay early")
putLine(owner, stock, {completed = true, completionRewardsPaid = true})
check(ix.progression.IsActive(owner, target), "finishing the inserted stage restores the existing request")

local introduction = "cotz/town/old-timer/v3/knives/knife2"
local traveller = context.fixture.character()
check(not ix.progression.definitions[introduction].allowedRequirements.value_controller,
	"Pripyat-only salvage is outside the local introduction")
putLine(traveller, introduction, {active = true, requirementPolicy = 3, requirements = {value_controller = 5},
	complexData = {value_controller = 1}})
ix.progression.AssignActiveRequirements(traveller)
local converted = ix.progression.GetLine(traveller, introduction)
check(converted.requirementConversions[1].quantity == 4 and converted.requirements.value_controller == 1,
	"a valuable from an unavailable region is converted while its old contribution stays credited")
check(converted.requirementPolicy == 4, "policy-three saves upgrade to the protected Swamps request policy")
local secondStep = "cotz/town/old-timer/v3/knives/knife3"
local returning = context.fixture.character()
putLine(returning, introduction, {completed = true, completionRewardsPaid = true})
putLine(returning, secondStep, {active = true, requirementPolicy = 3,
	requirements = {value_sensor_d = 4}, complexData = {value_sensor_d = 1}})
ix.progression.AssignActiveRequirements(returning)
local localRequest = ix.progression.GetLine(returning, secondStep)
check(localRequest.requirementConversions[1].quantity == 3 and localRequest.requirements.value_sensor_d == 1,
	"the second Swamps milestone replaces only outstanding later-region goods")
local localItem = localRequest.requirementConversions[1].to
check(ix.progression.definitions[secondStep].allowedRequirements[localItem],
	"the replacement is obtainable within the protected Swamps introduction")
local existing = context.fixture.character()
local brassIntro = "cotz/town/brass/v3/regular-ammo/22lr"
putLine(existing, brassIntro, {active = true, requirementPolicy = 3,
	requirements = {value_coffee = 4}, complexData = {value_coffee = 1}})
ix.progression.AssignActiveRequirements(existing)
local saved = ix.progression.GetLine(existing, brassIntro)
check(saved.requirements.value_coffee == 4 and saved.complexData.value_coffee == 1
	and #saved.requirementConversions == 0,
	"a valid saved assignment is not rerolled merely to match the new contact specialty")
local veteran = context.fixture.character()
putLine(veteran, introduction, {completed = true, completionRewardsPaid = true,
	requirements = {medic_bandage_1 = 2}, complexData = {medic_bandage_1 = 2}})
ix.progression.AssignActiveRequirements(veteran)
check(not ix.progression.GetLine(veteran, introduction).requirementConversions,
	"completed requests are never converted or reopened")

local meleeStock = "cotz/town/old-timer/v3/melee/sledgehammer/stock"
local meleePurchase = "cotz/town/old-timer/v3/melee/hatchet"
local shopper, other = context.fixture.character(), context.fixture.character()
putLine(shopper, meleeStock, {completed = true, completionRewardsPaid = true})
check(ix.progression.GetStockBonus(shopper, "'Old Timer'", "hatchet") == 0,
	"a stock completion cannot bypass purchase access")
putLine(shopper, meleePurchase, {completed = true, completionRewardsPaid = true})
check(ix.progression.GetStockBonus(shopper, "'Old Timer'", "hatchet") == 1
	and ix.progression.GetStockBonus(shopper, "'Old Timer'", "machete") == 1,
	"grouped stock rewards apply to every previously unlocked item")
check(ix.progression.GetStockBonus(other, "'Old Timer'", "hatchet") == 0,
	"stock rewards remain personal to each character")
putLine(shopper, meleeStock, {completed = true, completionRewardsPaid = true})
check(ix.progression.GetStockBonus(shopper, "'Old Timer'", "hatchet") == 1,
	"repeated completion cannot stack a capacity bonus")
check(ix.townNPCs.contacts.ledger.difficultyMultiplier == 3, "Ledger retains the user's threefold effort")

local hagglerID = "cotz/town/haggler/v3/pact-cqb/toz106"
local customer = context.fixture.character()
putLine(customer, hagglerID, {
	active = true, requirementPolicy = 4, requirementModesVersion = 2,
	requirements = {value_antique_vase = 4}, complexData = {value_antique_vase = 2},
	selections = {{item = "value_antique_vase", mode = "any", choices = {"value_antique_vase"}}},
	rewardCredit = {money = 150},
})
ix.progression.AssignActiveRequirements(customer)
local opening = ix.progression.GetLine(customer, hagglerID)
check(opening.requirements.value_antique_vase == 4 and opening.complexData.value_antique_vase == 2,
	"Haggler's category refresh preserves the existing target and delivered credit")
check(opening.requirementModesVersion == 3 and opening.rewardCredit.money == 150,
	"Haggler's refresh retains monetary credit and records its migration")
for _, itemID in ipairs(opening.selections[1].choices) do
	check(itemID ~= "value_antique_vase" and ix.progression.GetRequirementKey(hagglerID, itemID, customer),
		"ordinary supplies satisfy the retained category counter")
end
local choices = table.concat(opening.selections[1].choices, ",")
ix.progression.AssignActiveRequirements(customer)
check(table.concat(ix.progression.GetLine(customer, hagglerID).selections[1].choices, ",") == choices,
	"Haggler's category refresh runs once")

local record = ix.progression.GetCharacterProgression(customer)
record.lines[hagglerID].selections[1].name = "Shop supplies (Marsh)"
ix.progression.SetCharacterProgression(customer, record)
local category = ix.progression.GetRequirementLabel(hagglerID, opening.selections[1].item, customer)
check(category:find("Swamps", 1, true) and not category:find("Marsh", 1, true),
	"saved category labels display the corrected region name")
check(ix.progression.GetLine(customer, hagglerID).selections[1].name == "Shop supplies (Marsh)",
	"displaying the corrected region does not rewrite saved assignments")
print("PASS: " .. checks .. " progression expansion and saved-label checks")
