-- Run from the repository root: luatex --luaonly tests/suit_attachment_chain_spec.lua
local fixture = dofile("tests/helpers/progression.lua")
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

PLUGIN = {}
local root = "gamemodes/ix_cotz/plugins/townnpcs/"
dofile(root .. "libs/sh_00_townnpcs.lua")
dofile(root .. "libs/sh_catalogue.lua")
dofile(root .. "definitions/sh_equipment.lua")
local town = PLUGIN
local attachmentChain
for _, chain in ipairs(town.upgradeChains) do
	if chain[1]:find("^attachment_") then
		check(not attachmentChain, "standard suit attachments share one chain")
		attachmentChain = chain
	end
end
check(attachmentChain and #attachmentChain == 13, "the chain covers master's thirteen standard suit attachments")
local positions = {}
for index, item in ipairs(attachmentChain) do
	check(item:find("^attachment_") and not positions[item], "the chain contains distinct attachments without hides")
	check(not item:find("_4$"), "anomalous plates outside master's unlocks are excluded")
	positions[item] = index
	ix.item.list[item] = {name = item}
end
for _, family in ipairs({"steelplate", "ceramicplate", "fabric", "kevlar"}) do
	local previous
	for tier = 1, 3 do
		local position = positions["attachment_" .. family .. "_" .. tier]
		if position then
			check(not previous or previous < position, "each material retains master's ascending tier order")
			previous = position
		end
	end
end
check(positions.attachment_aluframe < positions.attachment_steelframe, "aluminium frames precede steel frames")
town.upgradeChains = {attachmentChain}
town.variantUnlocks, town.ammoVariants, town.ammoUnlockOrder, town.regularAmmoChain = {}, {}, {}, {}
local purchases = 0
for _, slug in ipairs({"latch", "suture", "carbon"}) do
	dofile(root .. "definitions/sh_" .. slug .. ".lua")
	local contact = town.contacts[slug]
	local catalogue = {}
	for item, allocation in pairs(contact.catalogue) do
		if item:find("^attachment_") then
			check(positions[item], "every existing standard attachment purchase belongs to the chain")
			catalogue[item] = allocation
			purchases = purchases + 1
			local id = town:StepID(slug, allocation.step)
			town.steps[id] = {}
			ix.progression.Register(id, {keyNpc = contact.name, defaultActive = true, prerequisites = {},
				nextProgressions = {}, vendorUnlocks = {}})
		end
	end
	contact.catalogue, contact.supplies, contact.progression, contact.enforceCatalogue = catalogue, {}, {}, false
end
check(purchases == #attachmentChain, "the chain neither omits nor adds attachment purchases")
town:BuildCatalogue()
for index = 2, #attachmentChain do
	local previous = town.itemGates[attachmentChain[index - 1]].id
	local current = town.itemGates[attachmentChain[index]].id
	local prerequisites = ix.progression.definitions[current].prerequisites
	check(#prerequisites == 1 and prerequisites[1] == previous,
		"each attachment requires its canonical predecessor across sellers")
end
local owner = fixture.character()
local previous = town.itemGates.attachment_kevlar_1.id
local frame = town.itemGates.attachment_aluframe.id
check(not ix.progression.IsActive(owner, frame), "Carbon's frame milestone waits for Suture's Kevlar milestone")
local state = ix.progression.GetCharacterProgression(owner)
state.lines[previous] = {completed = true}
ix.progression.SetCharacterProgression(owner, state)
check(ix.progression.IsActive(owner, frame), "the canonical predecessor opens the next seller's milestone")
check(not ix.progression.CanBuyItem(owner, town.itemGates.attachment_aluframe.npc, "attachment_aluframe"),
	"opening the frame milestone does not immediately grant its purchase")
state.lines[frame] = {completed = true}
state.lines[previous] = nil
ix.progression.SetCharacterProgression(owner, state)
check(ix.progression.CanBuyItem(owner, town.itemGates.attachment_aluframe.npc, "attachment_aluframe"),
	"an existing completed milestone retains its purchase permission")
print("PASS: " .. checks .. " suit attachment chain checks")
