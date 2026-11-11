-- Run from the addon root: luatex --luaonly tests/progression_subsets_spec.lua
local originalRandom = math.random
local context = dofile("tests/helpers/townnpcs.lua")
math.random = originalRandom
local checks, rolls = 0, 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local catalogue = ix.progression.definitions
ix.progression.npcRequirements = {}
for seed = 1, 20 do
	math.randomseed(seed)
	for id, definition in pairs(catalogue) do
		if definition.categoryChoiceRange then
			local compiled = table.Copy(definition)
			compiled.prerequisites = {}
			compiled.defaultActive = true
			ix.progression.definitions = {[id] = compiled}
			local character = context.fixture.character()
			ix.progression.AssignActiveRequirements(character)
			local line = ix.progression.GetLine(character, id)
			local used = {}
			for _, selection in ipairs(line.selections) do
				local members = {}
				for _, itemID in ipairs(selection.choices) do
					check(not used[itemID], "one donated item can belong to only one saved counter: " .. id)
					used[itemID], members[itemID] = true, true
				end
				if selection.mode == "any" then
					rolls = rolls + 1
					check(#selection.choices >= 3 and #selection.choices <= 4,
						"every category saves three or four accepted types: " .. id)
					check(members.value_nuts == members.value_bolts, "nuts and bolts are offered together")
					check(line.requirements[selection.item] >= 3, "category totals require at least three batches")
				end
			end
		end
	end
end

ix.progression.definitions = {}
ix.progression.itemPools.subsetFixture = {name = "Workshop supplies", candidates = {
	{item = "value_nuts"}, {item = "value_bolts"}, {item = "value_glue_1"}, {item = "value_glue_2"},
	{item = "value_tape_duct"}, {item = "value_hose"}, {item = "value_wire_copper"},
}}
ix.progression.itemPools.specificSubsetFixture = {name = "Textile supplies",
	candidates = {{item = "value_tarp"}}}
local id = "subsetFixture"
ix.progression.Register(id, {
	id = id, keyNpc = "Subset Test", progMap = "rp_marsh_cs", defaultActive = true,
	name = "Workshop delivery", BuildResponse = ix.progression.BuildDeliveryResponse,
	requirementModesVersion = 2, categoryChoiceRange = {3, 4}, batchSizedRequirements = true,
	requirementSlots = {{pool = "subsetFixture", quantity = 3, mode = "any"},
		{pool = "specificSubsetFixture", quantity = 2, mode = "random"}},
})
local a, choices, distinct = nil, nil, {}
for seed = 1, 40 do
	math.randomseed(seed)
	local character = context.fixture.character()
	ix.progression.AssignActiveRequirements(character)
	local selection = ix.progression.GetLine(character, id).selections[1]
	distinct[table.concat(selection.choices, ",")] = true
	local members = {}
	for _, itemID in ipairs(selection.choices) do members[itemID] = true end
	if members.value_nuts then a, choices = character, members end
end
local variety = 0
for _ in pairs(distinct) do variety = variety + 1 end
check(variety > 5, "characters receive different category subsets")
check(a and choices.value_bolts, "a fastener offer contains both nuts and bolts")
local line = ix.progression.GetLine(a, id)
local key, quantity = line.selections[1].item, line.requirements[line.selections[1].item]
local function item(quantity)
	local result = {quantity = quantity}
	function result:GetData(key, default)
		if self[key] == nil then return default end

		return self[key]
	end
	function result:SetData(key, value) self[key] = value end
	function result:Remove()
		if self.failRemoval then return false end
		self.removed = true
	end

	return result
end
local items = {value_nuts = item(5), value_bolts = item(4), value_tarp = item(2)}
local whole
for itemID in pairs(choices) do
	if itemID ~= "value_nuts" and itemID ~= "value_bolts" then whole = itemID end
end
items[whole] = item(quantity - 2)
a.inventory = {HasItem = function(_, itemID)
	local value = items[itemID]

	return value and not value.removed and value
end}
local unselected
for _, candidate in ipairs(ix.progression.itemPools.subsetFixture.candidates) do
	if not choices[candidate.item] then unselected = candidate.item end
end
items[unselected] = item(99)
local target = {
	GetClass = function() return "ix_vendor_adv" end,
	GetDisplayName = function() return "Subset Test" end,
	GetPos = function() return context.fixture.position end,
	CanAccess = function() return true end,
}
check(not ix.progression.TurnIn(a.client, target, id, unselected) and items[unselected].quantity == 99,
	"an unselected item from the catalogue cannot satisfy a saved subset")
check(ix.progression.GetRequirementUnitSize(id, "value_nuts", a) == 3
	and ix.progression.GetRequirementUnitSize(id, "value_bolts", a) == 4,
	"batch sizes use spawned quantities instead of stack capacities")
local description = ix.progression.BuildDeliveryResponse(ix.progression.definitions[id], "Subset Test", nil, a)
check(description:find("batches (any mix; per batch:", 1, true)
	and description:find("value_nuts x3", 1, true) and description:find("value_bolts x4", 1, true),
	"task text states the actual quantity cost of each accepted type")
local valued, originalValue = {}, ix.util.GetValueFromProgressionTurnin
ix.util.GetValueFromProgressionTurnin = function(instance, consumed, itemID)
	valued[itemID] = consumed

	return originalValue(instance, consumed, itemID)
end
check(ix.progression.TurnIn(a.client, target, id, "value_nuts") and items.value_nuts.quantity == 2,
	"one nut batch consumes three units and leaves surplus")
check(ix.progression.GetComplexProgressionValue(a, id)[key] == 1,
	"three nuts credit one category batch")
check(not ix.progression.TurnIn(a.client, target, id, "value_nuts"), "two loose nuts cannot buy a whole batch")
for _, option in ipairs(ix.progression.GetDeliveryOptions(a, id)) do
	check(option.dyndata.itemid ~= "value_nuts", "incomplete batches have no hand-in action")
end
items.value_bolts.failRemoval = true
check(not ix.progression.TurnIn(a.client, target, id, "value_bolts")
	and ix.progression.GetComplexProgressionValue(a, id)[key] == 1,
	"failed batch removal cannot grant contribution")
items.value_bolts.failRemoval = nil
check(ix.progression.TurnIn(a.client, target, id, "value_bolts") and items.value_bolts.removed,
	"four bolts credit another batch in the same counter")
check(valued.value_nuts == 3 and valued.value_bolts == 4, "valuation uses raw quantities actually consumed")
check(ix.progression.TurnIn(a.client, target, id, whole)
	and ix.progression.GetComplexProgressionValue(a, id)[key] == quantity,
	"whole supplies and quantity-bearing valuables can fill the same category total")
check(not ix.progression.IsCompleted(a, id), "the specific request is still required")
check(ix.progression.TurnIn(a.client, target, id, "value_tarp") and ix.progression.IsCompleted(a, id),
	"completing the specific request finishes and pays the delivery")
local paid = a.money
check(not ix.progression.TurnIn(a.client, target, id, "value_tarp") and a.money == paid,
	"duplicate completion cannot pay twice")
ix.util.GetValueFromProgressionTurnin = originalValue

local legacy = context.fixture.character()
local record = ix.progression.GetCharacterProgression(legacy)
record.lines[id] = {active = true, requirementModesVersion = 1,
	requirements = {value_tape_duct = 2, value_tarp = 2},
	complexData = {value_tape_duct = 1, value_tarp = 1}, rewardCredit = {money = 100},
	selections = {{pool = "subsetFixture", item = "value_tape_duct", mode = "any"},
		{pool = "specificSubsetFixture", item = "value_tarp", mode = "random"}}}
ix.progression.SetCharacterProgression(legacy, record)
ix.progression.AssignActiveRequirements(legacy)
local migrated = ix.progression.GetLine(legacy, id)
check(migrated.requirementModesVersion == 2 and migrated.requirements.value_tape_duct == 3,
	"unfinished legacy category totals receive the three-batch minimum once")
check(migrated.complexData.value_tape_duct == 1 and migrated.rewardCredit.money == 100
	and migrated.requirements.value_tarp == 2 and migrated.complexData.value_tarp == 1,
	"subset migration retains delivered credit and the original specific request")
check(#migrated.selections[1].choices >= 3 and #migrated.selections[1].choices <= 4,
	"old full-category requests become a saved subset")
local saves = legacy.saves
ix.progression.AssignActiveRequirements(legacy)
check(legacy.saves == saves, "subset migration does not reroll or save again")
local fulfilled = context.fixture.character()
record = ix.progression.GetCharacterProgression(fulfilled)
record.lines[id] = {active = true, requirementModesVersion = 1,
	requirements = {value_tape_duct = 1, value_tarp = 2}, complexData = {value_tape_duct = 1},
	selections = {{item = "value_tape_duct"}, {item = "value_tarp"}}}
ix.progression.SetCharacterProgression(fulfilled, record)
ix.progression.AssignActiveRequirements(fulfilled)
check(ix.progression.GetRequirements(fulfilled, id).value_tape_duct == 1,
	"an already fulfilled category is not reopened by the minimum")

local b = context.fixture.character()
ix.progression.AssignActiveRequirements(b)
local saved = ix.progression.GetLine(b, id)
local snapshot = table.concat(saved.selections[1].choices, ",")
local savedSize = saved.selections[1].unitSizes.value_nuts
ix.progression.itemPools.subsetFixture.candidates = {{item = "value_nails"}}
ix.progression.requirementBatchSizes.value_nuts = 99
check(ix.progression.GetRequirementUnitSize(id, "value_nuts", a) == 3, "saved batch costs remain frozen")
ix.progression.AssignActiveRequirements(b)
local restored = ix.progression.GetLine(b, id)
check(table.concat(restored.selections[1].choices, ",") == snapshot
	and restored.selections[1].unitSizes.value_nuts == savedSize,
	"pool and batch edits cannot reroll saved choices or costs")

ix.progression.itemPools.nutSpecificFixture = {name = "Fasteners", candidates = {{item = "value_nuts"}}}
ix.progression.requirementBatchSizes.value_nuts = 3
ix.progression.definitions = {}
ix.progression.Register("specificBatchFixture", {
	keyNpc = "Subset Test", progMap = "rp_marsh_cs", defaultActive = true,
	BuildResponse = ix.progression.BuildDeliveryResponse, batchSizedRequirements = true,
	requirementModesVersion = 2,
	requirementSlots = {{pool = "nutSpecificFixture", quantity = 2, mode = "random"}},
})
local specific = context.fixture.character()
ix.progression.AssignActiveRequirements(specific)
check(ix.progression.GetRequirements(specific, "specificBatchFixture").value_nuts == 6,
	"a two-item specific request needs two natural batches, not two loose nuts")
local oldSpecific = context.fixture.character()
record = ix.progression.GetCharacterProgression(oldSpecific)
record.lines.specificBatchFixture = {active = true, requirementModesVersion = 1,
	requirements = {value_nuts = 2}, complexData = {value_nuts = 1},
	selections = {{item = "value_nuts", mode = "random", choices = {"value_nuts"}}}}
ix.progression.SetCharacterProgression(oldSpecific, record)
ix.progression.AssignActiveRequirements(oldSpecific)
check(ix.progression.GetRequirements(oldSpecific, "specificBatchFixture").value_nuts == 2,
	"an existing specific raw-unit target is not multiplied during migration")
ix.progression.requirementBatchSizes.value_nuts = 0
check(not pcall(ix.progression.ValidateRequirementPools), "invalid batch sizes fail the audit")
ix.progression.requirementBatchSizes.value_nuts = 3
ix.progression.definitions.specificBatchFixture.categoryChoiceRange = {4, 3}
check(not pcall(ix.progression.ValidateRequirementPools), "invalid subset ranges fail the audit")
print("PASS: " .. checks .. " subset checks across " .. rolls .. " category assignments")
