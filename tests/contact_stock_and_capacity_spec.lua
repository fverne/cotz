-- Run from the addon root: luatex --luaonly tests/contact_stock_and_capacity_spec.lua
local context = dofile("tests/helpers/townnpcs.lua")
dofile("tests/helpers/town_dialogue.lua")
ix.dialogue.notifyReputationReceive = function() end
ix.dialogue.notifyMoneyReceive = function() end
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local function includes(values, target)
	for _, value in ipairs(values) do
		if value == target then return true end
	end

	return false
end
local fresh = context.fixture.character()
for slug, item in pairs({spool = "helm_tanker", latch = "mask_cloth"}) do
	local contact = ix.townNPCs.contacts[slug]
	check(includes(contact.supplies, item) and not contact.catalogue[item], "the former unlock is starting stock")
	check(ix.progression.CanBuyItem(fresh, contact.name, item), "fresh characters can buy the new starting stock")
	local row = ix.npctemplates.templates[contact.template].items[item]
	check(row and row[2] > 0 and row[3] ~= 3 and row[4] > 0, "the actual vendor template offers sellable stock")
	for _, step in ipairs(contact.progression) do
		check(not step.id:find("/" .. item, 1, true), "the removed item has no active milestone")
		for _, required in ipairs(step.requires) do
			check(not required:find("/" .. item, 1, true), "successors have no retired prerequisite")
		end
	end
end

local placements = {
	["v3/carry-weight/01"] = {"backpack_duffle", "backpack_sanitar"},
	["v3/carry-weight/02"] = {"backpack_tbag", "backpack_tourist"},
	["v3/inventory-rows/01"] = {"backpack_takedown_1", "backpack_takedown_2"},
	["v3/carry-weight/03"] = {"backpack_vkbo", "backpack_pilgrim"},
	["v3/carry-weight/04"] = {"backpack_3", "backpack_2"},
	["v3/inventory-rows/02"] = {"backpack_2", "backpack_1_large"},
	["v3/carry-weight/05"] = {"backpack_3_large", "backpack_2_large"},
}
local wake = ix.townNPCs.contacts.wake
local positions = {}
for index, step in ipairs(wake.progression) do positions[step.id] = index end
local weight, rows = 0, 0
for capacity, backpacks in pairs(placements) do
	local previous, following = "v3/backpacks/" .. backpacks[1], "v3/backpacks/" .. backpacks[2]
	local capacityID = ix.townNPCs:StepID("wake", capacity)
	local definition = ix.progression.definitions[capacityID]
	check(positions[previous] < positions[capacity] and positions[capacity] < positions[following],
		"capacity upgrades are displayed between their backpacks")
	check(#definition.prerequisites == 1 and definition.prerequisites[1] == ix.townNPCs:StepID("wake", previous),
		"each capacity side branch requires only its preceding backpack")
	check(#definition.nextProgressions == 0, "capacity upgrades are one-depth leaves")
	check(not includes(ix.progression.definitions[ix.townNPCs:StepID("wake", following)].prerequisites, capacityID),
		"the next backpack is independent of the optional capacity milestone")
	local character = context.fixture.character()
	local record = ix.progression.GetCharacterProgression(character)
	check(not ix.progression.IsActive(character, capacityID), "capacity stays hidden before its backpack milestone")
	record.lines[ix.townNPCs:StepID("wake", previous)] = {completed = true}
	ix.progression.SetCharacterProgression(character, record)
	check(ix.progression.IsActive(character, capacityID),
		"saved backpack completion reveals a capacity upgrade without any earlier capacity completions")
	for _, required in ipairs(ix.progression.definitions[ix.townNPCs:StepID("wake", following)].prerequisites) do
		record.lines[required] = {completed = true}
	end
	record.lines[ix.townNPCs:StepID("wake", following)] = {active = true}
	ix.progression.SetCharacterProgression(character, record)
	check(ix.progression.IsActive(character, ix.townNPCs:StepID("wake", following)),
		"unfinished saved backpacks can continue without buying optional capacity")
	if definition.capacityReward.kind == "weight" then weight = weight + definition.capacityReward.amount
	else rows = rows + definition.capacityReward.amount end
end
check(weight == 5 and rows == 2, "the capacity totals remain five kilograms and two rows")
for _, step in ipairs(wake.progression) do
	local identifier = ix.townNPCs:StepID("wake", step.id)
	check(ix.progression.IsActive(fresh, identifier), "a fresh character can follow backpacks and reveal optional capacity")
	if not step.capacity then ix.progression.SetCompleted(fresh, identifier) end
end
for capacity in pairs(placements) do
	local identifier = ix.townNPCs:StepID("wake", capacity)
	check(not ix.progression.IsCompleted(fresh, identifier) and ix.progression.IsActive(fresh, identifier),
		"all optional upgrades remain available after finishing every backpack without buying capacity")
	ix.progression.SetCompleted(fresh, identifier)
end
for _, step in ipairs(ix.townNPCs.contacts.suture.progression) do
	if step.variantBase then check(step.name:match(" variants$"), "every conversion milestone says variants") end
end

ix.npcbarter = {barterdict = {}, activebarters = {}}
function ix.npcbarter.Register(npc, identifier, definition)
	ix.npcbarter.barterdict[npc] = ix.npcbarter.barterdict[npc] or {}
	ix.npcbarter.barterdict[npc][identifier] = definition
	ix.npcbarter.activebarters[identifier] = definition.defaultActive
end
dofile("gamemodes/ix_cotz/plugins/npcbarter/sh_definitions.lua")
dofile("gamemodes/ix_cotz/plugins/npcbarter/libs/sh_npcbarter.lua")
local quartermaster = {GetDisplayName = function() return "'Quartermaster'" end}
local tree = ix.dialogue.list.unisgnpc.tree
local viewer = context.fixture.character()
viewer.inventory = {GetItems = function() return {} end}
for _, root in ipairs({"GREETING", "BackTopic"}) do
	check(includes(tree[root].options, "StartBarter"), "the regular barter menu remains reachable")
	for _, option in ipairs(tree[root]:GetDynamicOptions(viewer.client, quartermaster)) do
		check(option.dyndata.kind ~= "barter", "Quartermaster exposes no direct barter entries at the main menu")
	end
end
local options = tree.StartBarter:GetDynamicOptions(viewer.client, quartermaster)
check(#options == 6, "all six regular ammunition barters remain available")
for _, option in ipairs(options) do
	check(option.dyndata.identifier:match("^rareammobarterquartermaster"), "only regular barters remain")
end
check(not ix.npcbarter.barterdict["'Quartermaster'"].foreignammobarterquartermaster1
	and not ix.npcbarter.barterdict["'Quartermaster'"].foreignammobarterquartermaster2,
	"the two main-menu ammunition-kit barters are removed")
print("PASS: " .. checks .. " contact stock and capacity checks")
