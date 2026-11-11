-- Run from the addon root: luatex --luaonly tests/progression_requirement_modes_spec.lua
local fixture = dofile("tests/helpers/progression.lua")
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local function makeItem(quantity)
	local item = {quantity = quantity}
	function item:GetData(key, default)
		if self[key] == nil then return default end

		return self[key]
	end
	function item:SetData(key, value) self[key] = value end
	function item:Remove()
		if self.failRemoval then return false end
		self.removed = true
	end

	return item
end
local function inventory(character, items)
	character.inventory = {
		HasItem = function(_, itemID)
			local item = items[itemID]

			return item and not item.removed and item
		end,
	}
end
ix.progression.definitions = {}
ix.progression.itemPools.modeTextiles = {name = "Textile supplies",
	candidates = {{item = "value_sewingkit"}, {item = "value_tarp"}}}
ix.progression.itemPools.modeWorkshop = {name = "Workshop supplies",
	candidates = {{item = "value_tape_duct"}, {item = "value_glue_2"}, {item = "value_glue_1"}}}
local id = "modeFixture"
ix.progression.Register(id, {
	keyNpc = "Technut", progMap = "rp_marsh_cs", defaultActive = true, requirementModesVersion = 1,
	name = "Mixed delivery", BuildResponse = ix.progression.BuildDeliveryResponse,
	requirementSlots = {
		{pool = "modeTextiles", quantity = 3, mode = "random"},
		{pool = "modeWorkshop", quantity = 6, mode = "any"},
	},
})
local a, b = fixture.character(), fixture.character()
math.random = function(minimum) return minimum end
ix.progression.AssignActiveRequirements(a)
math.random = function(_, maximum) return maximum end
ix.progression.AssignActiveRequirements(b)
check(ix.progression.GetRequirements(a, id).value_sewingkit == 3, "one character rolls sewing supplies")
check(ix.progression.GetRequirements(b, id).value_tarp == 3, "another character rolls tarpaulins")
check(#ix.progression.GetRequirementChoices(id, "value_sewingkit", a) == 1,
	"specific requests accept only the saved item")
check(#ix.progression.GetRequirementChoices(id, "value_tape_duct", a) == 3,
	"category requests accept the complete saved candidate list")
local choices = ix.progression.GetRequirementChoices(id, "value_tape_duct", a)
choices[1] = "invalid"
check(ix.progression.GetRequirementChoices(id, "value_tape_duct", a)[1] ~= "invalid",
	"callers cannot change saved choices")
a:SetData("knownProgressionTopics", {[id] = true})
local needed = ix.progression.GetNeededItems(a)
check(needed.value_sewingkit == 3 and needed.value_glue_2 == 6 and needed.value_tape_duct == 6
	and not needed.value_tarp, "highlights include category alternatives and only the rolled specific item")
local description = ix.progression.BuildDeliveryResponse(ix.progression.definitions[id], "Technut", nil, a)
check(description:find("Workshop supplies (any mix:", 1, true)
	and description:find("3 value_sewingkit", 1, true), "task text distinguishes mixed and specific requests")
local target = {
	GetClass = function() return "ix_vendor_adv" end,
	GetDisplayName = function() return "Technut" end,
	GetPos = function() return fixture.position end,
	CanAccess = function() return true end,
}
local items = {value_tape_duct = makeItem(2), value_glue_2 = makeItem(5),
	value_sewingkit = makeItem(3), value_tarp = makeItem(3)}
inventory(a, items)
check(not ix.progression.TurnIn(a.client, target, id, "value_tarp") and not items.value_tarp.removed,
	"unselected specific alternatives cannot be donated")
items.value_tape_duct.failRemoval = true
check(not ix.progression.TurnIn(a.client, target, id, "value_tape_duct")
	and not ix.progression.GetComplexProgressionValue(a, id).value_tape_duct,
	"failed removal grants no category contribution")
items.value_tape_duct.failRemoval = nil
check(ix.progression.TurnIn(a.client, target, id, "value_tape_duct"), "first category member is accepted")
check(ix.progression.TurnIn(a.client, target, id, "value_glue_2"), "a different member fills the same counter")
check(ix.progression.GetComplexProgressionValue(a, id).value_tape_duct == 6
	and items.value_glue_2.quantity == 1, "category totals clamp consumption and preserve surplus")
check(not ix.progression.IsCompleted(a, id) and a.money == 0,
	"category completion alone cannot finish or pay a mixed request")
check(not ix.progression.TurnIn(a.client, target, id, "value_glue_2")
	and items.value_glue_2.quantity == 1, "fulfilled categories cannot consume more items")
check(ix.progression.TurnIn(a.client, target, id, "value_sewingkit")
	and ix.progression.IsCompleted(a, id), "the saved specific item finishes the request")
local paid = a.money
check(not ix.progression.TurnIn(a.client, target, id, "value_sewingkit") and a.money == paid,
	"duplicate hand-ins cannot pay twice")
check(not ix.progression.IsCompleted(b, id), "another character's progress stays isolated")

local restored = fixture.character()
restored.vars = fixture.copy(b.vars)
restored.data = fixture.copy(b.data)
local before = restored.saves
ix.progression.AssignActiveRequirements(restored)
check(restored.saves == before and ix.progression.GetRequirements(restored, id).value_tarp == 3,
	"reconnect preserves the item roll without another save")
ix.progression.itemPools.modeWorkshop.candidates = {{item = "value_nails"}}
ix.progression.definitions[id].requirementSlots[2].quantity = 99
ix.progression.AssignActiveRequirements(restored)
check(#ix.progression.GetRequirementChoices(id, "value_tape_duct", restored) == 3
	and ix.progression.GetRequirements(restored, id).value_tape_duct == 6,
	"definition edits do not change saved alternatives or quantities")
ix.progression.definitions[id].requirementAlternatives = {value_nails = "value_tape_duct"}
check(ix.progression.GetRequirementKey(id, "value_nails", restored) == "value_nails",
	"later alternative-map edits cannot expand a saved request")
ix.progression.definitions[id].requirementAlternatives = nil
local serverSaves = restored.saves
SERVER = false
check(#ix.progression.GetRequirementChoices(id, "value_tape_duct", restored) == 3
	and restored.saves == serverSaves, "clients can read saved choices without mutating state")
SERVER = true

local old = fixture.character()
local record = ix.progression.GetCharacterProgression(old)
record.lines[id] = {
	active = true, requirements = {value_sewingkit = 3, value_tape_duct = 6},
	complexData = {value_sewingkit = 1, value_tape_duct = 2}, rewardCredit = {money = 100},
	selections = {{pool = "oldTextiles", item = "value_sewingkit"},
		{pool = "oldWorkshop", item = "value_tape_duct"}},
}
ix.progression.SetCharacterProgression(old, record)
ix.progression.AssignActiveRequirements(old)
local line = ix.progression.GetLine(old, id)
check(line.requirements.value_tape_duct == 6 and line.complexData.value_tape_duct == 2
	and line.rewardCredit.money == 100, "migration preserves old quantities, contributions and credit")
check(ix.progression.GetRequirementKey(id, "value_nails", old) == "value_tape_duct"
	and ix.progression.GetRequirementKey(id, "value_glue_2", old) == "value_glue_2",
	"migration snapshots current category membership alongside the original canonical item")
check(ix.progression.GetRequirements(old, id).value_sewingkit == 3
	and #ix.progression.GetRequirementChoices(id, "value_sewingkit", old) == 1,
	"migration never rerolls an existing specific request")
local saves = old.saves
ix.progression.AssignActiveRequirements(old)
check(old.saves == saves, "mode migration is idempotent")
record = ix.progression.GetCharacterProgression(old)
record.lines[id].completed = true
record.lines[id].requirementModesVersion = nil
ix.progression.SetCharacterProgression(old, record)
ix.progression.AssignActiveRequirements(old)
check(not ix.progression.GetLine(old, id).requirementModesVersion,
	"completed historical records are not migrated")

local opening = fixture.character()
record = ix.progression.GetCharacterProgression(opening)
record.lines[id] = {active = true, requirements = {value_sewingkit = 3, value_tape_duct = 6},
	complexData = {value_sewingkit = 1}, selections = {{item = "value_sewingkit"}, {item = "value_tape_duct"}}}
ix.progression.SetCharacterProgression(opening, record)
ix.progression.definitions[id].requirementSlots[1].mode = "any"
ix.progression.AssignActiveRequirements(opening)
check(ix.progression.GetRequirementKey(id, "value_tarp", opening) == "value_sewingkit"
	and ix.progression.GetComplexProgressionValue(opening, id).value_sewingkit == 1,
	"opening requests broaden to a category without replacing old item keys or credited deliveries")
local convertedID = "convertedOpeningFixture"
ix.progression.Register(convertedID, {
	keyNpc = "Technut", progMap = "rp_marsh_cs", defaultActive = true,
	requirementModesVersion = 1, requirementPolicy = 4, categoryOnly = true,
	allowedRequirements = {value_sewingkit = true, value_tarp = true},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	requirementSlots = {{pool = "modeTextiles", quantity = 3, mode = "any"}},
})
local converted = fixture.character()
record = ix.progression.GetCharacterProgression(converted)
record.lines[convertedID] = {active = true, requirementPolicy = 3,
	requirements = {value_engine = 3}, complexData = {value_engine = 1},
	selections = {{pool = "oldPool", item = "value_engine"}}}
ix.progression.SetCharacterProgression(converted, record)
ix.progression.AssignActiveRequirements(converted)
local convertedLine = ix.progression.GetLine(converted, convertedID)
check(convertedLine.requirements.value_engine == 1 and convertedLine.complexData.value_engine == 1,
	"a region-policy conversion preserves the fulfilled historical contribution")
check(convertedLine.selections[1].mode == "any" and convertedLine.selections[1].item ~= "value_engine"
	and #convertedLine.selections[1].choices == 2,
	"mode migration attaches the category to the pending replacement rather than the fulfilled old key")

local slots = ix.progression.definitions[id].requirementSlots
slots[1].mode = "invalid"
check(not pcall(ix.progression.ValidateRequirementPools), "unknown modes fail the definition audit")
slots[1].mode = "random"
slots[2].pool = slots[1].pool
check(not pcall(ix.progression.ValidateRequirementPools), "overlapping authored slots fail the audit")
slots[2].pool = "modeWorkshop"
ix.progression.definitions[id].categoryOnly = true
check(not pcall(ix.progression.ValidateRequirementPools), "opening chains reject specific slots")
print("PASS: " .. checks .. " mixed progression requirement checks")
