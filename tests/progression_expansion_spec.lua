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
putLine(traveller, introduction, {active = true, requirements = {value_controller = 5},
	complexData = {value_controller = 1}})
ix.progression.AssignActiveRequirements(traveller)
local converted = ix.progression.GetLine(traveller, introduction)
check(converted.requirementConversions[1].quantity == 4 and converted.requirements.value_controller == 1,
	"a valuable from an unavailable region is converted while its old contribution stays credited")
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
print("PASS: " .. checks .. " progression expansion persistence and stock checks")
