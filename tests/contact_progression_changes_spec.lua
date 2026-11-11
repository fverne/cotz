-- Run from the addon root: luatex --luaonly tests/contact_progression_changes_spec.lua
local context = dofile("tests/helpers/townnpcs.lua")
ix.plugin = {Get = function() end}
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local function id(contact, step)
	return ix.townNPCs:StepID(contact, "v3/" .. step)
end
local function complete(character, identifier)
	local record = ix.progression.GetCharacterProgression(character)
	record.lines[identifier] = {completed = true}
	ix.progression.SetCharacterProgression(character, record)
end

local technut = ix.townNPCs.contacts.technut
local suitOwner = context.fixture.character()
local previousSuit
local suitCount = 0
for _, step in ipairs(technut.progression) do
	check(not step.intermissionFor and not step.id:match("/stock$"), "Technut has no stock intermissions")
	if step.branch == "suits" then
		suitCount = suitCount + 1
		local identifier = ix.townNPCs:StepID("technut", step.id)
		local definition = ix.progression.definitions[identifier]
		check(#step.requires == (previousSuit and 1 or 0), "authored suits have only their preceding suit gate")
		for _, required in ipairs(definition.prerequisites) do
			check(not required:match("/stock$"), "compiled suit gates contain no stock intermissions")
		end
		if previousSuit then
			check(definition.prerequisites[1] == previousSuit, "suit order is preserved")
			check(not ix.progression.IsActive(suitOwner, identifier), "later suits wait for the preceding suit")
			ix.progression.SetCompleted(suitOwner, previousSuit)
		end
		check(ix.progression.IsActive(suitOwner, identifier), "the next suit opens without a stock delivery")
		previousSuit = identifier
	end
end
check(suitCount == 14, "all fourteen original suit stages remain")
check(technut.progression[1].stock.item == "suit_anorak", "the initial anorak stock step remains")
check(ix.progression.IsActive(suitOwner, id("technut", "painting/painting")), "painting remains independent")

local returningSuitOwner = context.fixture.character()
local retainedSuit = id("technut", "suits/suit_trenchcoat_black")
local retiredStock = retainedSuit .. "/stock"
local savedProgress = ix.progression.GetCharacterProgression(returningSuitOwner)
savedProgress.lines[id("technut", "suits/suit_mailjacket")] = {completed = true}
savedProgress.lines[retainedSuit] = {
	active = true, requirements = {value_nuts = 3}, complexData = {value_nuts = 1}, requirementPolicy = 4,
}
savedProgress.lines[retiredStock] = {active = true, complexData = {value_bolts = 1}}
ix.progression.SetCharacterProgression(returningSuitOwner, savedProgress)
ix.progression.AssignActiveRequirements(returningSuitOwner)
check(ix.progression.IsActive(returningSuitOwner, retainedSuit), "saved unfinished suits no longer wait for stock")
check(ix.progression.GetComplexProgressionValue(returningSuitOwner, retainedSuit).value_nuts == 1,
	"retained suits preserve partial contributions")
check(not ix.progression.definitions[retiredStock]
	and not ix.progression.IsActive(returningSuitOwner, retiredStock), "retired stock cannot become active")
check(ix.progression.GetComplexProgressionValue(returningSuitOwner, retiredStock).value_bolts == 1,
	"retired stock contributions remain saved history")

for step, prerequisite in pairs({
	["stimpaks/medic_stimpak_1"] = "medkits/medic_medkit_6",
	["antirad/medic_antirad_1"] = "medkits/medic_medkit_2",
	["antipsychotics/medic_antipsychotic_1"] = "medkits/medic_medkit_4",
	["psy-healing/medic_psyheal_1"] = "medkits/medic_medkit_4",
	["anomaly-detector/anomalydetector"] = "instruments/geigercounter",
}) do
	local contact = step:find("anomaly", 1, true) and "atlas" or "jitters"
	local character = context.fixture.character()
	local identifier = id(contact, step)
	check(not ix.progression.IsActive(character, identifier), "the new parent gates " .. step)
	complete(character, id(contact, prerequisite))
	check(ix.progression.IsActive(character, identifier), "completing the parent opens " .. step)
	complete(character, identifier)
	check(ix.progression.IsCompleted(character, identifier), "completed unlocks remain completed")
end

local accessID = id("ballast", "hideout/access")
local target = {
	GetClass = function() return "ix_vendor_adv" end,
	GetDisplayName = function() return "'Ballast'" end,
	GetPos = function() return context.fixture.position end,
	CanAccess = function() return true end,
}
for _, choice in ipairs({"crowbar", "bat"}) do
	local character = context.fixture.character()
	local item = {name = choice}
	function item:GetData(key, default) return self[key] or default end
	function item:Remove() self.removed = true end
	character.client.Notify = function() end
	character.inventory = {
		HasItem = function(_, itemID) return itemID == choice and not item.removed and item end,
	}
	check(not ix.progression.IsActive(character, id("ballast", "hideout/01")),
		"initial access precedes unfinished improvements")
	ix.progression.AssignActiveRequirements(character)
	local text = ix.progression.DescribeTask(ix.progression.definitions[accessID], "'Ballast'", nil, character)
	check(text:find("1 bat or crowbar", 1, true), "the request describes a single alternative hand-in")
	local options = ix.progression.GetDeliveryOptions(character, accessID)
	check(#options == 1 and options[1].dyndata.itemid == choice, "either inventory choice gets a hand-in action")
	item.equip = true
	check(not ix.progression.TurnIn(character.client, target, accessID, choice), "equipped tools cannot be consumed")
	item.equip = nil
	check(not ix.progression.TurnIn(character.client, target, accessID, "knife1"), "unlisted tools are rejected")
	check(ix.progression.TurnIn(character.client, target, accessID, choice), "either tool completes access")
	check(item.removed and ix.progression.IsCompleted(character, accessID), "one tool is consumed for access")
	check(ix.progression.IsActive(character, id("ballast", "hideout/01")), "improvements open after access")
	check(not ix.progression.TurnIn(character.client, target, accessID, choice), "duplicate requests cannot pay twice")
	check(ix.progression.GetLine(character, accessID).complexData.crowbar == 1,
		"both alternatives share the same saved contribution")
end

for contactID, tool in pairs({cleaner = "sledgehammer", ledger = "fubar"}) do
	local contact = ix.townNPCs.contacts[contactID]
	context.fixture.SetMap(contact.map)
	local identifier = id(contactID, "hideout/access")
	local character = context.fixture.character()
	local item = {name = tool}
	function item:GetData(key, default) return self[key] or default end
	function item:Remove() self.removed = true end
	character.client.Notify = function() end
	character.inventory = {
		HasItem = function(_, itemID) return itemID == tool and not item.removed and item end,
	}
	local contactTarget = {
		GetClass = target.GetClass,
		GetDisplayName = function() return contact.name end,
		GetPos = target.GetPos,
		CanAccess = target.CanAccess,
	}
	check(ix.progression.IsActive(character, identifier), "local initial access starts available")
	check(not ix.progression.IsActive(character, id(contactID, "hideout/01")),
		"initial access gates unfinished local improvements")
	ix.progression.AssignActiveRequirements(character)
	check(ix.progression.GetRequirements(character, identifier)[tool] == 1,
		"initial access requires exactly one tool despite the contact difficulty multiplier")
	local options = ix.progression.GetDeliveryOptions(character, identifier)
	check(#options == 1 and options[1].dyndata.itemid == tool, "the required tool has a hand-in action")
	item.equip = true
	check(not ix.progression.TurnIn(character.client, contactTarget, identifier, tool),
		"equipped access tools cannot be consumed")
	item.equip = nil
	check(not ix.progression.TurnIn(character.client, contactTarget, identifier, "crowbar"),
		"other tools cannot substitute for the local requirement")
	check(not ix.progression.TurnIn(character.client, target, identifier, tool),
		"access tools must be delivered to the owning contact")
	check(ix.progression.TurnIn(character.client, contactTarget, identifier, tool), "the local tool completes access")
	check(item.removed and ix.progression.IsCompleted(character, identifier), "one local access tool is consumed")
	check(ix.progression.IsActive(character, id(contactID, "hideout/01")), "access opens local improvements")
	check(not ix.progression.TurnIn(character.client, contactTarget, identifier, tool),
		"duplicate local access requests are rejected")
end
context.fixture.SetMap("rp_marsh_cs")

PLUGIN = ix.townNPCs
dofile("gamemodes/ix_cotz/plugins/townnpcs/libs/sh_networkservices.lua")
local character = context.fixture.character()
for _, allowed in pairs(ix.townNPCs:GetNetworkAccess(character)) do
	check(allowed, "all scoreboard features start available")
end
local returning = context.fixture.character()
for _, step in ipairs({"networkSearch", "networkSquads", "networkRanking", "emissionWarnings"}) do
	complete(returning, id("mute", "stalkernet/" .. step))
end
check(ix.progression.IsActive(returning, id("mute", "stalkernet/eventBroadcasts")),
	"retained emission completion opens Pripyat reports without completing retired activity work")
local maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"}
local steps = {"networkSearch", "networkSquads", "networkRanking", "eventBroadcasts"}
for index, map in ipairs(maps) do
	check(not ix.townNPCs:CanReceiveMutantReports(character, map), "reports require the regional milestone")
	complete(character, id("mute", "stalkernet/" .. steps[index]))
	check(ix.townNPCs:CanReceiveMutantReports(character, map), "retained milestone IDs unlock regional reports")
	for later = index + 1, #maps do
		check(not ix.townNPCs:CanReceiveMutantReports(character, maps[later]), "later regions remain locked")
	end
end
check(not ix.townNPCs:CanReceiveMutantReports(character, "unknown"), "unknown maps get no mutant reports")

local hagglerBarters = 0
ix.npcbarter = {Register = function(npc)
	if npc == "'Haggler'" then hagglerBarters = hagglerBarters + 1 end
end}
dofile("gamemodes/ix_cotz/plugins/npcbarter/sh_definitions.lua")
check(hagglerBarters == 0, "Haggler registers no barters")

local town = PLUGIN
PLUGIN = {}
ix.command = {Add = function() end}
ix.type = {string = 1, text = 2}
dofile("gamemodes/ix_cotz/plugins/hideouts/sh_personal.lua")
local fresh = context.fixture.character()
check(not PLUGIN:GetPersonalUnlock(fresh, "claim", 1), "Ballast enforces initial access on new room claims")
complete(fresh, accessID)
check(PLUGIN:GetPersonalUnlock(fresh, "claim", 1), "completing access allows room claims")
complete(fresh, id("ballast", "hideout/01"))
check(PLUGIN:GetPersonalUnlock(fresh, "ammo", 1), "existing improvement IDs keep their storage gates")
local originalGetMap = game.GetMap
for _, contactID in ipairs({"ballast", "cleaner", "ledger"}) do
	local contact = ix.townNPCs.contacts[contactID]
	game.GetMap = function() return contact.map end
	local character = context.fixture.character()
	local allowed, reason = PLUGIN:GetPersonalUnlock(character, "claim", 1)
	check(not allowed and reason:find(contact.name, 1, true), "new claims name the local access contact")
	complete(character, id(contactID, "hideout/01"))
	check(PLUGIN:GetPersonalUnlock(character, "ammo", 1), "saved improvements remain usable before access")
	check(not PLUGIN:GetPersonalUnlock(character, "claim", 1), "saved improvements do not bypass new claims")
	complete(character, id(contactID, "hideout/access"))
	check(PLUGIN:GetPersonalUnlock(character, "claim", 1), "local access enables new room claims")
end
game.GetMap = originalGetMap
PLUGIN = town

CLIENT, SERVER = true, false
local dialogue = {townContact = "ballast", tree = {
	GREETING = {options = {}}, BackTopic = {options = {}},
}}
function dialogue.addTopic(name, topic) dialogue.tree[name] = topic end
for _, method in ipairs({"ConfigureTownServices", "ConfigureTaskRewards",
	"ConfigureCustomization", "ConfigureBarterVisibility"}) do
	ix.dialogue[method] = function() end
end
dofile("gamemodes/ix_cotz/plugins/dialogue/libs/sh_towncontacts.lua")
ix.dialogue.ConfigureTownContact(dialogue, ix.townNPCs.contacts.ballast)
local viewer = context.fixture.character()
ix.progression.GetRequirements = function() return {crowbar = 1} end
dialogue.tree.TownView:DynamicPreCallback(viewer.client, target, {identifier = accessID})
check(dialogue.tree.TownView.response:find("REQUIRED ITEMS:", 1, true)
	and dialogue.tree.TownView.response:find("1 bat or crowbar", 1, true),
	"the dialogue menu itself includes required names and quantities")
print("PASS: " .. checks .. " contact progression changes checks")
