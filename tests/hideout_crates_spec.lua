-- Run from the repository root: luatex --luaonly tests/hideout_crates_spec.lua
local fixture = dofile("tests/helpers/progression.lua")
ix.progression.itemPools.hideoutFixture = {name = "Packing", candidates = {{item = "artifact_bolt"}}}
ix.progression.Register("hideoutInstallationFixture", {
	name = "Storage improvement", briefing = "Assemble a crate and install it in your room.",
	keyNpc = "'Cleaner'", progMap = "rp_marsh_cs", defaultActive = true, hideoutLevel = 2,
	requirementSlots = {{pool = "hideoutFixture", quantity = 3, mode = "any"}},
	requirementModesVersion = 2, categoryChoiceRange = {3, 4},
	progressthresholds = {1}, progressfunctions = {}, BuildResponse = ix.progression.BuildDeliveryResponse,
})
local id = "hideoutInstallationFixture"
local fresh = fixture.character()
ix.progression.InitializeCharacterProgression(fresh)
assert(ix.progression.GetLine(fresh, id).requirements == nil)
assert(next(ix.progression.GetRequirements(fresh, id)) == nil)
assert(#ix.progression.GetDeliveryOptions(fresh, id) == 0)
local definition = ix.progression.definitions[id]
local text = ix.progression.DescribeTask(definition, definition.keyNpc, {}, fresh)
assert(text:find("Craft and install", 1, true))
assert(not text:find("Qualified matches", 1, true))
print("PASS: new hideout objectives require installation without assigning duplicate supply deliveries")

local legacy = fixture.character()
ix.progression.InitializeCharacterProgression(legacy)
local record = ix.progression.GetCharacterProgression(legacy)
record.lines[id] = {requirements = {artifact_bolt = 3}, active = true}
record.lines[id].complexData = {artifact_bolt = 1}
record.lines[id].requirementModesVersion = 1
record.lines[id].selections = {{item = "artifact_bolt", mode = "any", choices = {"artifact_bolt"}, name = "Packing"}}
ix.progression.SetCharacterProgression(legacy, record)
ix.progression.AssignActiveRequirements(legacy)
assert(ix.progression.GetRequirements(legacy, id).artifact_bolt == 3)
assert(ix.progression.GetComplexProgressionValue(legacy, id).artifact_bolt == 1)
assert(ix.progression.GetLine(legacy, id).requirementModesVersion == 1)
text = ix.progression.DescribeTask(definition, definition.keyNpc, {}, legacy)
assert(text:find("REQUIRED ITEMS:", 1, true))
assert(text:find("saved supply request remains valid", 1, true))
assert(ix.progression.AddComplexProgressionValue(legacy, id, {"artifact_bolt", 2}) == 2)
assert(ix.progression.IsCompleted(legacy, id))
print("PASS: unfinished saved requests retain selections and contributions and can still complete")

ix.progression.SetCompleted(fresh, id)
assert(ix.progression.IsCompleted(fresh, id))
assert(next(ix.progression.GetComplexProgressionValue(fresh, id)) == nil)
assert(ix.progression.GetLine(fresh, id).requirements == nil)
print("PASS: an installation completes the same milestone without a synthetic hand-in")

local savedItem = ITEM
ITEM = {}
dofile("gamemodes/ix_cotz/plugins/hideouts/items/base/sh_hideoutcrate.lua")
local baseItem = ITEM
for _, family in ipairs({"general", "ammo", "medical", "weapon", "gear", "fridge"}) do
	ITEM = setmetatable({data = {cotzHideoutCrate = {level = 12, squad = true, version = 1}}}, {__index = baseItem})
	dofile("gamemodes/ix_cotz/plugins/hideouts/items/hideoutcrate/sh_hideout_crate_" .. family .. ".lua")
	function ITEM:GetData(key, default) return self.data[key] or default end
	assert(ITEM.width == 2 and ITEM.height == 2 and ITEM.price == 0 and ITEM.weight == 1)
	assert(ITEM:GetName():find("squad level 12", 1, true))
	assert(ITEM:GetDescription():find(ITEM.longdesc, 1, true))
	assert(ITEM:GetDescription():find("upgrade menu", 1, true))
end
ITEM = savedItem
print("PASS: all six concrete crate items display scope, level, authored background and installation instructions")
