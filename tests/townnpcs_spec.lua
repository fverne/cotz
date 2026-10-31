-- Run from the repository root: luatex --luaonly tests/townnpcs_spec.lua
dofile("tests/helpers/progression.lua")
SERVER = true
CLIENT = false
PLUGIN = {}
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local base = "gamemodes/ix_cotz/plugins/"
ix.util.Include = function(path) return dofile("gamemodes/" .. path) end
for _, library in ipairs({"sh_storage", "sh_progression", "sh_requirements", "sh_expansion", "sh_services"}) do
	dofile(base .. "progression/libs/" .. library .. ".lua")
end
ix.progression.definitions = {}
ix.progression.Register = function(id, definition)
	definition.id = id
	ix.progression.definitions[id] = definition
end
for _, name in ipairs({"computer_story", "computerprog", "hoarderprog", "noosphereprog", "communityprog"}) do
	dofile(base .. "progression/definitions/sh_" .. name .. ".lua")
end
local standaloneCount = 0
for _ in pairs(ix.progression.definitions) do standaloneCount = standaloneCount + 1 end
ix.item.list = {}
local itemFiles = assert(io.popen("rg --files gamemodes/ix_cotz/schema/items gamemodes/ix_cotz/plugins"))
for path in itemFiles:lines() do
	if path:find("/items/", 1, true) then
		local id = path:match("/sh_([^/]+)%.lua$")
		if id then
			ix.item.list[id] = {name = id, price = 100, quantity = 1}
		end
	end
end
itemFiles:close()
dofile(base .. "jobsystem/libs/sh_taskrewards.lua")
dofile(base .. "progression/libs/sh_rewards.lua")
dofile(base .. "progression/libs/sv_rewards.lua")
ix.jobs = {list = {}, jobsbycategory = {}, field = {
	sources = {}, settings = {}, IsAvailable = function() return true end,
}}
for _, kind in ipairs({"recovery", "sensor", "triangulation", "deadDrop", "defence"}) do
	ix.jobs.field.settings[kind] = {sources = {}}
end
ix.jobs.register = function(definition, id)
	ix.jobs.list[id] = definition
	for _, category in ipairs(definition.categories) do
		ix.jobs.jobsbycategory[category] = ix.jobs.jobsbycategory[category] or {}
		table.insert(ix.jobs.jobsbycategory[category], id)
	end
end
dofile(base .. "townnpcs/libs/sh_00_townnpcs.lua")
for _, name in ipairs({"sh_catalogue", "sh_jobs", "sh_progressions", "sh_sites", "sh_validation", "sv_runtime"}) do
	dofile(base .. "townnpcs/libs/" .. name .. ".lua")
end
local definitions = assert(io.popen("rg --files gamemodes/ix_cotz/plugins/townnpcs/definitions"))
local paths = {}
for path in definitions:lines() do paths[#paths + 1] = path end
definitions:close()
table.sort(paths)
for _, path in ipairs(paths) do dofile(path) end
local town = ix.townNPCs
town:BuildProgressions()
town:BuildJobs()
town:ConfigureSources()
town.installed = true
local count, contactCount = 0, 0
local homeCategories = {}
for _, contact in pairs(town.contacts) do
	contactCount = contactCount + 1
	local key = contact.map .. "/" .. contact.job.category
	check(not homeCategories[key], "repeatable category must be unique per home map")
	homeCategories[key] = true
	check(contact.map ~= "rp_pripyat_remaster", "Pripyat has no home contact")
	local root, forks, joins = 0, 0, 0
	for _, step in ipairs(contact.progression) do
		local definition = ix.progression.definitions[town:StepID(contact.id, step.id)]
		count = count + 1
		if definition.defaultActive then root = root + 1 end
		if #definition.nextProgressions > 1 then forks = forks + 1 end
		if #definition.prerequisites > 1 then joins = joins + 1 end
		for _, slot in ipairs(definition.requirementSlots or {}) do
			for _, candidate in ipairs(ix.progression.itemPools[slot.pool].candidates) do
				check(ix.item.list[candidate.item], "requirements use real registered items")
			end
		end
	end
	check(root == 1 and forks > 0 and joins > 0, "each contact has a sparse tree, not a linear chain")
end
check(contactCount == 27 and count == 646, "all contacts and proposed steps are registered")
check(town.contacts["arena-master"].map == "rp_marsh_cs", "arena stays with the Marsh dupe")
check(town.contacts.latch.map == "mz_garbage", "Garbage uses the supplied map ID")
local fullCount = ix.progression.AuditDefinitions()
check(fullCount == 646 + standaloneCount, "town trees coexist only with separate non-town content")
check(not ix.progression.definitions.oldTimerKillIntro, "superseded town definitions are absent")
for item, gate in pairs(town.itemGates) do
	check(ix.progression.definitions[gate.id], "each catalogue item has an explicit current progression gate")
end
local equipmentCount = 0
for _ in pairs(town.itemGates) do equipmentCount = equipmentCount + 1 end
check(equipmentCount == 210, "all current equipment allocations remain in contact catalogues")
check(not town.legacy and not town.previousPrerequisites and not town.CanContinueLegacy,
	"the town runtime has no migration or legacy compatibility layer")
local currentMap = "rp_marsh_cs"
game.GetMap = function() return currentMap end
local function character(data)
	local value = setmetatable({data = data or {}, saves = 0, replications = 0, money = 0}, ix.meta.character)
	value.inventory = {
		GetItems = function() return {} end,
		HasItem = function() end,
		Add = function() return false end,
	}
	value.client = {
		GetCharacter = function() return value end,
		IsBot = function() return false end,
		getReputation = function() return value.reputation or 0 end,
		addReputation = function(_, amount) value.reputation = (value.reputation or 0) + amount end,
		SteamID64 = function() return tostring(value) end,
	}
	return value
end
for _, contact in pairs(town.contacts) do
	currentMap = contact.map
	for _, step in ipairs(contact.progression) do
		local id = town:StepID(contact.id, step.id)
		local definition = ix.progression.definitions[id]
		local owner = character({townNPCProgression = {counts = {}, claims = {}, opponents = {}, pending = {}}})
		local record = {lines = {[id] = {active = true}}}
		for _, required in ipairs(definition.prerequisites) do record.lines[required] = {completed = true} end
		local access = ix.progression.npcRequirements[contact.name]
		if access then record.lines[access] = {completed = true} end
		ix.progression.SetCharacterProgression(owner, record)
		if step.kind == "delivery" then
			for item, amount in pairs(ix.progression.GetRequirements(owner, id)) do
				check(ix.progression.AddComplexProgressionValue(owner, id, {item, amount}) == amount,
					"current delivery requirements complete without a retired definition")
			end
		else
			check(ix.progression.SetProgressionValue(owner, id, step.target or 1),
				"current counter/commission completes without compatibility callbacks")
		end
		check(ix.progression.IsCompleted(owner, id), "every current town objective can complete")
		local money = owner.money
		check(not ix.progression.AddProgressionValue(owner, id, 1), "completed objectives reject repeated advancement")
		check(owner.money == money, "repeated advancement cannot repay completion rewards")
	end
end
currentMap = "rp_marsh_cs"
local fresh = character()
town:InitializeTownCharacter(fresh)
check(ix.progression.IsActive(fresh, town:StepID("old-timer", "OT01")), "fresh character starts the modern tree")
check(not ix.progression.IsActive(fresh, "oldtimerItemDelivery_Knife1"), "fresh character gets no legacy duplicates")
local obsolete = character({progression = {lines = {oldtimerItemDelivery_Knife2 = {completed = true}}}})
town:InitializeTownCharacter(obsolete)
check(not town:CanBuyItem(obsolete, "knife3"), "retired completions cannot unlock current equipment")
check(not obsolete:GetData("townNPCProgression").legacy, "initialization does not create legacy compatibility state")
local qualified = character()
town:InitializeTownCharacter(qualified)
local qm = town:StepID("quartermaster", "QM11")
local data = ix.progression.GetCharacterProgression(qualified)
for _, required in ipairs(ix.progression.definitions[qm].prerequisites) do
	if required ~= town:StepID("old-timer", "OT12") then data.lines[required] = {completed = true} end
end
data.lines[qm] = {active = true}
ix.progression.SetCharacterProgression(qualified, data)
check(not ix.progression.IsActive(qualified, qm), "Quartermaster cannot bypass the survival knife milestone")
data.lines[town:StepID("old-timer", "OT12")] = {completed = true}
ix.progression.SetCharacterProgression(qualified, data)
check(ix.progression.IsActive(qualified, qm), "cross-NPC prerequisite opens the bayonet milestone")

local hunter = character()
town:InitializeTownCharacter(hunter)
ix.progression.SetCompleted(hunter, town:StepID("old-timer", "OT01"))
ix.progression.SetCompleted(hunter, town:StepID("old-timer", "OT02"))
hunter:SetData("jobClaimsPaid", {["'Old Timer'"] = 1})
town:JobCompleted(hunter.client, "'Old Timer'", "cotz/town/old-timer/easy")
check(hunter:GetData("townNPCProgression").counts["'Old Timer'"] == 1, "valid completion advances its contact counter")
town:JobCompleted(hunter.client, "'Old Timer'", "cotz/town/old-timer/easy")
check(hunter:GetData("townNPCProgression").counts["'Old Timer'"] == 1, "repeated completion cannot advance twice")
hunter:SetData("jobClaimsPaid", {["'Old Timer'"] = 2})
town:JobCompleted(hunter.client, "'Old Timer'", "cotz/town/old-timer/easy")
local firstKnife = town:StepID("old-timer", "OT03")
check(ix.progression.IsCompleted(hunter, firstKnife), "cumulative hunting checkpoint completes its active node")
check(ix.progression.CanUseNPC(hunter, "'Haggler'"), "current milestone directly opens Haggler access")
check(#ix.progression.GetLine(hunter, firstKnife).pendingRewards == 1, "full inventory keeps the earned fixed reward")
check(not town:CanAcceptJob(hunter, "'Old Timer'", ix.jobs.list["cotz/town/spoor/easy"]),
	"another contact's job cannot be accepted through a forged identifier")
check(not town:CanAcceptJob(hunter, "'Old Timer'", ix.jobs.list["cotz/town/old-timer/hard"]),
	"hard work cannot bypass server reputation requirements")
local courier = character()
town:InitializeTownCharacter(courier)
ix.progression.SetCompleted(courier, town:StepID("ballast", "BA01"))
local commissionID = "cotz/town/commission/ballast/BA02"
local commission = {identifier = commissionID, numberRec = 1}
check(ix.taskRewards.PrepareJob(courier, "'Ballast'", commission), "commission gets a unique claim")
check(commission.moneyReward == 0 and #commission.rewardChoices == 0, "finite work has no repeatable cash/supply offer")
courier:SetData("jobClaimsPaid", {["'Ballast'"] = commission.progressionClaim})
town:JobCompleted(courier.client, "'Ballast'", commissionID)
check(ix.progression.IsCompleted(courier, town:StepID("ballast", "BA02")),
	"commission completion advances its exact node")
check((courier:GetData("townNPCProgression").counts["'Ballast'"] or 0) == 0,
	"authored work does not count as a repeatable completion")
check(ix.taskRewards.TraderBonusProgress(courier, "'Ballast'").count == nil,
	"finite commission has not created a five-task bonus")
local interrupted = character()
town:InitializeTownCharacter(interrupted)
ix.progression.SetCompleted(interrupted, town:StepID("ballast", "BA01"))
interrupted:SetData("jobClaimsPaid", {["'Ballast'"] = 101})
local advance = ix.progression.SetProgressionValue
ix.progression.SetProgressionValue = function() error("simulated interruption") end
local succeeded = pcall(function() town:JobCompleted(interrupted.client, "'Ballast'", commissionID) end)
ix.progression.SetProgressionValue = advance
check(not succeeded, "fault injection interrupts commission advancement")
check(interrupted:GetData("townNPCProgression").pending["'Ballast'"], "interrupted commission keeps its journal")
town:InitializeTownCharacter(interrupted)
local recoveredID = town:StepID("ballast", "BA02")
check(ix.progression.IsCompleted(interrupted, recoveredID), "reloading resumes the journaled commission")
check(not interrupted:GetData("townNPCProgression").pending["'Ballast'"], "finished commission clears its journal")
local rewards = #ix.progression.GetLine(interrupted, recoveredID).pendingRewards
town:InitializeTownCharacter(interrupted)
check(#ix.progression.GetLine(interrupted, recoveredID).pendingRewards == rewards,
	"repeated recovery cannot queue the same completion reward twice")
local missingBenefit = character()
town:InitializeTownCharacter(missingBenefit)
ix.progression.SetCompleted(missingBenefit, recoveredID)
town:InitializeTownCharacter(missingBenefit)
check(ix.progression.GetLine(missingBenefit, recoveredID).benefitsClaimed.completion,
	"completed modern milestones recover benefits omitted by an interrupted completion")
check(town.Initialize == nil, "plugin helpers cannot accidentally register the engine Initialize hook")
local arenaCharacter = character()
town:InitializeTownCharacter(arenaCharacter)
local opponent = {SteamID64 = function() return "different-human" end, IsBot = function() return false end}
town:ArenaCompleted(arenaCharacter.client, opponent)
town:ArenaCompleted(arenaCharacter.client, opponent)
check(arenaCharacter:GetData("townNPCProgression").counts["'Arena Master'"] == 1,
	"arena counts distinct opponents even before an authored bout is active")
local before = arenaCharacter:GetData("townNPCProgression").counts["'Arena Master'"]
currentMap = "mz_garbage"
town:ArenaCompleted(arenaCharacter.client, {SteamID64 = function() return "another-human" end,
	IsBot = function() return false end})
check(arenaCharacter:GetData("townNPCProgression").counts["'Arena Master'"] == before,
	"arena progression is bound to Marsh")

-- Load actual conversation definitions. GLua-only continue statements are inside unused service callbacks;
-- reject their execution rather than pretending this standalone suite tests those callbacks.
currentMap = "rp_marsh_cs"
net = {Receive = function() end}
util = {AddNetworkString = function() end}
hook = {Add = function() end}
ix.util.GetMaterial = function() end
local filenames = {}
local files = assert(io.popen("rg --files gamemodes/ix_cotz/plugins/dialogue/dialogue"))
for path in files:lines() do filenames[#filenames + 1] = path:match("([^/]+)$") end
files:close()
table.sort(filenames)
file = {Find = function() return filenames end}
ix.util.Include = function(path)
	local fullPath = "gamemodes/" .. path
	local handle = assert(io.open(fullPath))
	local source = handle:read("*a")
	handle:close()
	source = source:gsub("(\n[ \t]*)continue([ \t]*\n)",
		"%1error(\"Unexecuted GLua callback\")%2")
	assert(load(source, "@" .. fullPath, "t", _G))()
end
PLUGIN = {uniqueID = "dialogue"}
dofile(base .. "dialogue/libs/sh_dialogue.lua")
ix.dialogue.LoadFromDir("ix_cotz/plugins/dialogue/dialogue")
dofile(base .. "vendor_adv/libs/sh_npctemplates.lua")
ix.vendorStock = {ApplyDefaults = function() end}
local vendorPlugin = {}
PLUGIN = vendorPlugin
dofile(base .. "vendor_adv/libs/sh_towncontacts.lua")
ix.plugin = {Get = function(id) if id == "vendor_adv" then return vendorPlugin end return town end}
dofile(base .. "dialogue/libs/sh_towncontacts.lua")
town:InstallContacts()
local expectedModels = {
	["owlnpc"] = "models/legends/chich.mdl",
	["technpc"] = "models/legends/griyc.mdl",
	["tutorialnpc"] = "models/legends/shram.mdl",
	["cooknpc"] = "models/legends/makar.mdl",
	["tradernpc"] = "models/legends/krohobor.mdl",
	["stalkernetnpc"] = "models/legends/petruha.mdl",
	["ecologistnpc"] = "models/legends/ozerskiy.mdl",
	["ecologistnpc2"] = "models/legends/sokolov2.mdl",
	["ecologistnpc3"] = "models/legends/vasilev.mdl",
	["unisgnpc"] = "models/mirotvor/mirotvor3.mdl",
	["unisgnpc2"] = "models/mirotvor/mirotvor7.mdl",
	["unisgnpc3"] = "models/mirotvor/mirotvor2.mdl",
	["raritynpc"] = "models/legends/black3.mdl",
	["computernpc"] = "models/props_lab/servers.mdl",
	["medicnpc"] = "models/legends/feldsher.mdl",
	["firststalkernpc"] = "models/legends/freeman.mdl",
	["cconnpc"] = "models/legends/klikoso.mdl",
	["arenanpc"] = "models/legends/garyk.mdl",
	["ratnpc"] = "models/monsters/rat.mdl",
}
for template, model in pairs(expectedModels) do
	check(ix.npctemplates.templates[template].model == model, "splitting templates preserves existing models")
end
for _, contact in pairs(town.contacts) do
	local tree = ix.dialogue.list[ix.npctemplates.templates[contact.template].dialogueid].tree
	local offered = {}
	for _, option in ipairs(tree.GREETING.options) do offered[option] = true end
	check(offered.TownProgression and offered.TradeTopic, "all contacts expose progression and trading")
	check(offered.AboutWorkTopic, "all contacts expose the work status menu")
	check(not offered.AboutProgression, "only the current progression action is offered")
	check(not tree.AboutProgression and not tree.GetTask and not tree.ConfirmTask and not tree.ViewProgression,
		"superseded topics are deleted from the definition, not hidden")
	check(tree.TradeTopic.postCallback == ix.dialogue.OpenVendor, "all town trading uses the owning shared handler")
	check(contact.job.kind == "arena" or offered.GetTaskByDifficulty, "non-arena contacts offer their category")
	check(tree.TownView and tree.TownCommission and tree.TownHandIn, "finite commissions and hand-ins are wired")
	check(tree.AboutWorkTopic.response == contact.job.description, "each callback belongs to its own contact")
	check(not contact.dialogue.progression:find("branch"), "NPC speech does not explain graph internals")
	for _, step in ipairs(contact.progression) do
		check(not step.completion:find("Your contribution is recorded"), "completion text uses the contact's voice")
		check(not step.briefing:find("rp_") and not step.briefing:find("mz_"), "NPC speech uses region names")
		if contact.id == "mute" then
			check(step.briefing:sub(1, 2) == "**" and step.completion:sub(1, 2) == "**",
				"Mute retains his nonverbal presentation")
		end
	end
end
local vendor = {
	items = {medic_bandage_1 = {321, 0, 2, 7, 99, 1}},
	GetDisplayName = function() return "'Jitters'" end,
}
local originalEntry = vendor.items.medic_bandage_1
vendor.AddItemToList = function(self, item, price, stock, mode, maximum, interval, amount)
	self.items[item] = {price, stock, mode, maximum, interval, amount}
end
check(vendorPlugin:RefreshTownVendor(vendor, town.contacts.jitters, town.catalogues["'Jitters'"] or {},
	town.settings.supplyStock), "saved vendors receive missing catalogue and supply entries")
check(vendor.items.medic_bandage_1 == originalEntry and originalEntry[1] == 321 and originalEntry[2] == 0,
	"refresh preserves existing depleted stock and staff customisations")
check(not vendorPlugin:RefreshTownVendor(vendor, town.contacts.jitters, town.catalogues["'Jitters'"] or {},
	town.settings.supplyStock), "repeated vendor refresh is idempotent")

PLUGIN = town
local builders = {"BuildProgressions", "BuildJobs", "ConfigureSources", "InstallContacts"}
local originals, installed = {}, {}
for _, name in ipairs(builders) do
	originals[name] = town[name]
	town[name] = function() installed[#installed + 1] = name end
end
town.installed = false
town:Install()
check(town.installed and #installed == 4, "startup validates actual template identities and all home categories")
for index, name in ipairs(builders) do
	check(installed[index] == name, "startup builds registries in dependency order")
	town[name] = originals[name]
end

local commands = {}
ix.command = {Add = function(name, definition) commands[name] = definition end}
ix.type = {string = "string"}
local savedPoints
local sitePlugin = {
	GetData = function(self, default, global, ignoreMap)
		check(ignoreMap == true, "field sites load all map regions")
		return {recovery = {mz_garbage = {{"saved-garbage-point"}}}}
	end,
	SetData = function(self, data, global, ignoreMap)
		check(ignoreMap == true, "field sites persist independently of the current map")
		savedPoints = data
	end,
}
PLUGIN = sitePlugin
PLUGIN.siteDefinitions = {recovery = {rp_marsh_cs = {{"shared-marsh-point"}}, mz_garbage = {{"default"}}}}
dofile(base .. "townnpcs/libs/sv_sites.lua")
PLUGIN:LoadData()
check(PLUGIN.recoveryPoints.rp_marsh_cs[1][1] == "shared-marsh-point", "shared definitions fill unsaved map regions")
check(PLUGIN.recoveryPoints.mz_garbage[1][1] == "saved-garbage-point", "local authoring overrides shared map defaults")
PLUGIN:SaveData()
check(savedPoints.recovery.rp_marsh_cs and savedPoints.recovery.mz_garbage, "saving retains both map regions")
for _, name in ipairs({
	"TownNPCPlace", "TownNPCAddFieldPoint", "TownNPCRemoveFieldPoint", "TownNPCExportFieldPoints",
}) do
	check(commands[name] and commands[name].adminOnly, "placement and site authoring commands are admin-only")
end

local savedRequires = town.contacts.atlas.progression[1].requires
town.contacts.atlas.progression[1].requires = {"AT_missing"}
local errors = town:ValidateContacts()
check(#errors == 1 and errors[1]:find("atlas: AT01 requires missing step AT_missing", 1, true),
	"definition diagnostics identify the contact, objective and invalid prerequisite")
town.contacts.atlas.progression[1].requires = savedRequires
local available = ix.jobs.field.IsAvailable
ix.jobs.field.IsAvailable = function(definition) return definition.fieldMap ~= "mz_garbage" end
local missing = town:GetMissingFieldSites()
check(missing["recovery on mz_garbage"] > 0, "missing field sites are reported by mechanic and region")
ix.jobs.field.IsAvailable = available
local oldJobs, oldCategories = ix.jobs.list, ix.jobs.jobsbycategory
ix.jobs.list, ix.jobs.jobsbycategory = {}, {}
town.contacts.atlas.job.rewards = {
	easy = {money = 17, reputation = 3},
	medium = {money = 19, reputation = 5},
	hard = {money = 23, reputation = 7},
}
town:BuildJobs()
check(ix.jobs.list["cotz/town/atlas/easy"].moneyReward == 17,
	"contact definitions can override default repeatable payouts")
check(ix.jobs.list["cotz/town/atlas/hard"].repReward == 7,
	"contact definitions can override reputation per difficulty")
town.contacts.atlas.job.rewards = nil
ix.jobs.list, ix.jobs.jobsbycategory = oldJobs, oldCategories
local include = ix.util.Include
local included = {}
ix.util.Include = function(path)
	local source = assert(io.open(base .. "townnpcs/" .. path))
	source:close()
	included[path] = (included[path] or 0) + 1
end
PLUGIN = town
dofile(base .. "townnpcs/sh_plugin.lua")
ix.util.Include = include
for slug in pairs(town.contacts) do
	local path = "definitions/sh_" .. slug:gsub("-", "_") .. ".lua"
	check(included[path] == 1, "the real plugin entry point explicitly includes each contact exactly once")
end
check(included["definitions/sh_config.lua"] and included["definitions/sh_equipment.lua"]
	and included["definitions/sh_pools.lua"], "shared configuration and equipment families are explicitly loaded")
local notify, message = ix.progression.Notify
ix.progression.Notify = function(_, _, text) message = text end
local quiet = character()
town:InitializeTownCharacter(quiet)
ix.progression.SetCompleted(quiet, town:StepID("old-timer", "OT19"))
ix.progression.SetCompleted(quiet, town:StepID("mute", "MU02"))
local quietCheckpoint = town:StepID("mute", "MU03")
ix.progression.SetProgressionValue(quiet, quietCheckpoint, town.steps[quietCheckpoint].target)
check(message == town.steps[quietCheckpoint].completion,
	"completion notifications preserve the authored line without adding speech before Mute's gesture")
ix.progression.Notify = notify

local stockReader = character()
for _, definition in pairs(ix.progression.definitions) do
	if definition.townContact and #(definition.stockUnlocks or {}) > 0 then
		local text = ix.progression.DescribeTask(definition, definition.keyNpc, {}, stockReader)
		local _, count = text:gsub("Stock reward:", "")
		check(count == #definition.stockUnlocks, "town stock rewards are described once")
	end
end

print(string.format("PASS: %d town NPC checks", checks))
