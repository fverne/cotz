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
			local file = assert(io.open(path))
			local source = file:read("*a")
			file:close()
			local quantity = tonumber(source:match("ITEM.quantity = (%d+)"))
			ix.item.list[id] = {name = id, price = 100, quantity = quantity,
				isFieldCargo = path:find("/items/jobcargo/", 1, true) ~= nil}
		end
	end
end
itemFiles:close()
ix.jobs = ix.jobs or {}
ix.jobs.field = ix.jobs.field or {}
ix.taskRewards = ix.taskRewards or {}
for _, name in ipairs({"settings", "rewardsettings", "fieldsettings", "killcredit"}) do
	dofile("gamemodes/ix_cotz/plugins/jobsystem/definitions/sh_" .. name .. ".lua")
end
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
dofile(base .. "jobsystem/libs/sh_tooljobs.lua")
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
ix.randomitems = {tables = {}}
for _, pool in ipairs({"worldspawn_1", "worldspawn_2", "worldspawn_garbage_regular",
	"worldspawn_garbage_rare", "worldspawn_3", "worldspawn_4", "worldspawn_5", "worldspawn_6",
	"human_npc_drops", "cache_misc", "ix_entbox_drops", "ix_wood_entbox_drops", "ix_paper_entbox_drops"}) do
	dofile(base .. "randomitem/pools/" .. pool .. ".lua")
end
ix.item.list.value_nuts.quantity = 20
ix.item.list.value_bolts.quantity = 20
ix.item.list.value_kerosene.quantity = 8
ix.item.list.medic_bandage_1.quantity = 3
ix.item.list.medic_medkit_1.quantity = 3
town:BuildJobs()
local function request(contact, difficulty, item)
	return ix.jobs.list["cotz/town/" .. contact .. "/" .. difficulty .. "/" .. item].numberRec
end
check(request("technut", "easy", "value_nuts") == 3, "easy uses nuts minimum yield, not value floor")
check(request("technut", "medium", "value_nuts") == 8, "medium uses one maximum batch")
check(request("technut", "hard", "value_nuts") == 9, "hard nuts require more than one maximum batch")
check(request("latch", "easy", "value_bolts") == 4, "bolts use their own minimum")
check(request("latch", "hard", "value_bolts") == 9, "bolts hard exceeds maximum batch")
check(request("gasket", "easy", "value_kerosene") == 2, "explicit spawn data overrides container capacity")
check(request("jitters", "hard", "medic_bandage_1") > 3, "hard medical work exceeds spawned uses")
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
local deliveryContacts = 0
for id, contact in pairs(town.contacts) do
	if contact.job.deliveryTiers then
		deliveryContacts = deliveryContacts + 1
		for _, difficulty in ipairs({"easy", "medium", "hard"}) do
			local settings = contact.job.deliveryTiers[difficulty]
			local seen = {}
			check(settings.quantity == (difficulty == "hard" and 2 or 1), "whole-item quantities stay small")
			for _, poolID in ipairs(settings.pools) do
				for _, candidate in ipairs(ix.progression.itemPools[poolID].candidates) do
					check(not seen[candidate.item], "delivery tier cannot register duplicate items")
					seen[candidate.item] = true
					local jobID = "cotz/town/" .. id .. "/" .. difficulty .. "/" .. candidate.item
					local job = ix.jobs.list[jobID]
					check(job and job.requiredItem == candidate.item, "new valuables register real delivery jobs")
					if not ix.item.list[candidate.item].quantity then
						check(job.numberRec == settings.quantity, "whole-item requests retain tier quantities")
					end
				end
			end
		end
	end
end
check(deliveryContacts == 12, "all twelve delivery contacts have regional additions")
check(not ix.jobs.list["cotz/town/mute/easy/value_field_laptop"], "Marsh easy work excludes laptops")
check(ix.jobs.list["cotz/town/mute/hard/value_field_laptop"], "Mute can commission Pripyat computers")

check(contactCount == 27 and count == 646, "all contacts and proposed steps are registered")
local cargoCount, recipientCount, dropCount = 0, 0, 0
for _, contact in pairs(town.contacts) do
	for _, step in ipairs(contact.progression) do
		if step.field and step.field.cargo then
			cargoCount = cargoCount + 1
			local definition = ix.jobs.list["cotz/town/commission/" .. contact.id .. "/" .. step.id]
			check(ix.item.list[step.field.cargo].isFieldCargo,
				"authored cargo inherits binding and transfer protection")
			check(definition.fieldCargo == step.field.cargo and definition.fieldCargoName == step.field.label,
				"commission registration preserves its explicit cargo and identity")
			if step.field.recipient then
				recipientCount = recipientCount + 1
				local recipient = town.contacts[step.field.recipient]
				check(recipient and recipient ~= contact and not recipient.access,
					"current courier destinations are distinct contacts with no progression access gate")
				check(definition.fieldRecipient == recipient.name and definition.fieldRecipientMap == recipient.map,
					"NPC delivery destinations compile to the actual vendor identity and home map")
				check(step.objective:find(recipient.name, 1, true), "the objective names its actual delivery recipient")
			end
			if step.field.kind == "deadDrop" then dropCount = dropCount + 1 end
		end
	end
end
check(cargoCount == 312 and recipientCount == 76 and dropCount == 6,
	"authored commissions use custom recovery cargo, contact deliveries and field-cache deliveries")
check(#town:ValidateContacts() == 0, "all current cargo and recipient declarations validate")
check(town.contacts["arena-master"].map == "rp_marsh_cs", "arena stays with the Marsh dupe")
check(town.contacts.latch.map == "mz_garbage", "Garbage uses the supplied map ID")
check(town.contacts.smartass.map == "rp_waystation", "Smartass lives in Waystation")
check(town.contacts.spool.map == "mz_garbage", "Spool lives in Garbage")
for tier, difficulty in ipairs({"easy", "medium", "hard"}) do
	local id = "cotz/town/smartass/" .. difficulty .. "/dataExtract"
	local job = ix.jobs.list[id]
	check(job and job.toolItem == "dataextractor", "Smartass issues extraction tools")
	check(job.toolData.ntypes == ({1, 2, 5})[tier], "extraction difficulty sets computer count")
	check(job.toolData.finishedtrigger == id and job.listenTrigger == id, "extraction triggers match")
	check(job.numberRec == 1 and not job.fieldType, "one finished drive completes extraction")
	check(job.CanAcceptTask and job.OnTaskComplete and job.OnTaskAbandon, "tool lifecycle is installed")
	check(ix.jobs.list["cotz/town/spool/" .. difficulty].fieldType == "triangulation",
		"Spool retains triangulation")
end
local fullCount = ix.progression.AuditDefinitions()
check(fullCount == 646 + standaloneCount, "town trees coexist only with separate non-town content")
check(not ix.progression.definitions.oldTimerKillIntro, "superseded town definitions are absent")
for item, gate in pairs(town.itemGates) do
	check(ix.progression.definitions[gate.id], "each catalogue item has an explicit current progression gate")
end
local equipmentCount = 0
for _ in pairs(town.itemGates) do equipmentCount = equipmentCount + 1 end
check(equipmentCount > 210, "expanded equipment allocations are present in contact catalogues")
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
check(#ix.progression.GetLine(hunter, firstKnife).pendingRewards == 0, "tracker does not duplicate job supplies")
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
	check(offered.TownDeliveries and tree.TownDeliveries.ResolveDynamicOption,
		"every contact exposes the conditional incoming-delivery action")
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
local deliveryReader = character()
local incomingJobs = {}
deliveryReader.GetJobs = function() return incomingJobs end
local incomingTree = ix.dialogue.list[ix.npctemplates.templates[town.contacts.ledger.template].dialogueid].tree
local incoming = incomingTree.TownDeliveries
check(not incoming.ShouldAdd(nil, deliveryReader.client), "incoming delivery dialogue is hidden without cargo")
incomingJobs["'Ballast'"] = {rewardKey = "job:incoming", fieldTask = {
	recipient = "'Ledger'", cargoName = "Landing record", stage = "carrying",
}}
check(incoming.ShouldAdd(nil, deliveryReader.client), "the actual receiving contact exposes incoming cargo")
local oldSortedPairs, oldCurTime = SortedPairs, CurTime
SortedPairs, CurTime = pairs, function() return 100 end
local incomingOptions = incoming.GetDynamicOptions(nil, deliveryReader.client)
check(#incomingOptions == 1 and incomingOptions[1].dyndata.claim == "job:incoming",
	"delivery options carry the accepted assignment claim")
local previousInteract, previousDeliver = town.CanInteract, ix.jobs.field.DeliverToContact
local deliveredCalls = 0
local receivingVendor = {}
ix.jobs.field.DeliverToContact = function(client, target, npc, claim)
	check(client == deliveryReader.client and target == receivingVendor and npc == "'Ballast'"
		and claim == "job:incoming", "dialogue forwards the selected owner and claim to authoritative delivery")
	deliveredCalls = deliveredCalls + 1
end
town.CanInteract = function() return false end
incoming.ResolveDynamicOption(nil, deliveryReader.client, receivingVendor, incomingOptions[1].dyndata)
check(deliveredCalls == 0, "inaccessible receiving vendors cannot invoke a delivery")
town.CanInteract = function() return true end
incoming.ResolveDynamicOption(nil, deliveryReader.client, receivingVendor, incomingOptions[1].dyndata)
incoming.ResolveDynamicOption(nil, deliveryReader.client, receivingVendor, incomingOptions[1].dyndata)
check(deliveredCalls == 1, "incoming delivery dialogue rate-limits repeated requests on the server")
incomingJobs["'Ballast'"].fieldTask.stage = "delivered"
check(not incoming.ShouldAdd(nil, deliveryReader.client), "receipted cargo disappears from incoming delivery dialogue")
town.CanInteract, ix.jobs.field.DeliverToContact = previousInteract, previousDeliver
SortedPairs, CurTime = oldSortedPairs, oldCurTime

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
local fieldStep = town.contacts.atlas.progression[2]
local savedCargo, savedRecipient = fieldStep.field.cargo, fieldStep.field.recipient
fieldStep.field.cargo = "missing_cargo"
errors = town:ValidateContacts()
check(#errors == 1 and errors[1]:find("AT02 uses invalid bound cargo missing_cargo", 1, true),
	"invalid custom cargo prevents town startup")
fieldStep.field.cargo, fieldStep.field.recipient = savedCargo, "missing-contact"
errors = town:ValidateContacts()
check(#errors == 1 and errors[1]:find("AT02 uses invalid delivery recipient missing-contact", 1, true),
	"unknown delivery recipients prevent town startup")
fieldStep.field.recipient = "atlas"
check(#town:ValidateContacts() == 1, "a commission cannot name its own issuer as an intermediate recipient")
fieldStep.field.recipient = savedRecipient
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
check(included["definitions/sh_config.lua"] and included["definitions/sh_equipment.lua"], "shared configuration and equipment families are explicitly loaded")
local notify, message = ix.progression.Notify
ix.progression.Notify = function(_, _, text) message = text end
ix.dialogue.notifyReputationReceive = function() end
ix.dialogue.notifyMoneyReceive = function() end
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

-- Equipment dependencies must remain acyclic after crossing contact trees.
local visiting, visited = {}, {}
local function visit(id)
	check(not visiting[id], "progression graph has no cycle at " .. id)
	if visited[id] then return end
	visiting[id] = true
	for _, required in ipairs(ix.progression.definitions[id].prerequisites or {}) do visit(required) end
	visiting[id], visited[id] = nil, true
end
for id in pairs(town.steps) do visit(id) end

-- Reward overhaul: exhaustive acquisition coverage and shared, deterministic gates.
local gunFiles = assert(io.popen("rg --files gamemodes/ix_cotz/schema/items/newweapons"))
local availableGuns, reservedGuns = 0, 0
for path in gunFiles:lines() do
	local itemID = path:match("/sh_([^/]+)%.lua$")
	if town:IsPurchaseExcluded(itemID) then
		reservedGuns = reservedGuns + 1
	else
		check(town.itemGates[itemID], "every non-reserved gun has a purchase route: " .. itemID)
		availableGuns = availableGuns + 1
	end
end
gunFiles:close()
check(availableGuns == 122 and reservedGuns == 8, "all 130 guns are accounted for")
for itemID, allocation in pairs(town.variantUnlocks) do
	check(not town.itemGates[itemID], "variants cannot enter the purchase catalogue")
	check(ix.progression.definitions[town:StepID(allocation.contact, allocation.step)],
		"every conversion has a valid milestone")
end
local medkit = "medic_medkit_2"
check(not town.contacts.wake.catalogue[medkit].unlockContact, "Wake's medicine has local progression")
local shared = character()
local jittersGate = town.itemGates[medkit].sellers["'Jitters'"].id
local wakeGate = town.itemGates[medkit].sellers["'Wake'"].id
local record = ix.progression.GetCharacterProgression(shared)
record.lines[jittersGate] = {completed = true}
ix.progression.SetCharacterProgression(shared, record)
check(town:CanBuyItem(shared, medkit, "'Jitters'"), "Jitters recognises his own unlock")
check(not town:CanBuyItem(shared, medkit, "'Wake'"), "Jitters cannot unlock Wake's medicine")
local independent = character()
local record = ix.progression.GetCharacterProgression(independent)
record.lines[wakeGate] = {completed = true}
ix.progression.SetCharacterProgression(independent, record)
check(town:CanBuyItem(independent, medkit, "'Wake'"), "Wake can unlock medicine independently")
check(not town:CanBuyItem(independent, medkit, "'Jitters'"), "Wake cannot unlock Jitters's medicine")
for _, seller in ipairs({"'Jitters'", "'Wake'", "'Quartermaster'"}) do
	local lower = town.itemGates.medic_medkit_1.sellers[seller]
	local higher = town.itemGates.medic_medkit_2.sellers[seller]
	local found = false
	for _, id in ipairs(ix.progression.definitions[higher.id].prerequisites) do
		if id == lower.id then found = true end
	end
	check(found, "each seller requires its own previous medkit tier")
end
for _, item in ipairs({"backpack_4", "backpack_5", "backpack_4_large", "backpack_5_large"}) do
	check(town:IsPurchaseExcluded(item) and not town.itemGates[item], "top backpack is reserved: " .. item)
end
local carrying = character()
local record = ix.progression.GetCharacterProgression(carrying)
for id, step in pairs(town.steps) do
	if step.capacity then record.lines[id] = {completed = true} end
end
ix.progression.SetCharacterProgression(carrying, record)
check(town:GetCapacityBonus(carrying, "weight") == 5, "five small weight awards total five kilograms")
check(town:GetCapacityBonus(carrying, "rows") == 2, "two separate inventory awards total two rows")
check(town:GetCapacityBonus(character(), "rows") == 0, "capacity belongs to the character")
local commissionReward = character()
local id = town:StepID("ballast", "BA02")
local record = ix.progression.GetCharacterProgression(commissionReward)
record.lines[id] = {completed = true}
ix.progression.SetCharacterProgression(commissionReward, record)
ix.progression.PayCompletionRewards(commissionReward, id)
local earned = commissionReward.money
check(earned == town.steps[id].completionCash, "field commissions receive exactly their listed payment")
ix.progression.PayCompletionRewards(commissionReward, id)
check(commissionReward.money == earned, "completion payments cannot be replayed")
local oldValue = ix.item.list.suit_sunrise_anarchist
ix.item.list.suit_sunrise_anarchist = {baseSuit = "suit_sunrise"}
check(town:IsPurchaseExcluded("suit_sunrise_anarchist"), "variants are blocked even at saved vendors")
check(not town:CanChangeSuitVariant(character(), "suit_sunrise_anarchist"), "conversion requires earned progress")
local variantOwner = character()
local record = ix.progression.GetCharacterProgression(variantOwner)
local variant = town.variantUnlocks.suit_sunrise_anarchist
record.lines[town:StepID(variant.contact, variant.step)] = {completed = true}
ix.progression.SetCharacterProgression(variantOwner, record)
check(not town:CanChangeSuitVariant(variantOwner, "suit_sunrise_anarchist"), "variant cannot bypass its base suit")
record.lines[town.itemGates.suit_sunrise.id] = {completed = true}
ix.progression.SetCharacterProgression(variantOwner, record)
check(town:CanChangeSuitVariant(variantOwner, "suit_sunrise_anarchist"), "base plus variant milestones allow conversion")
local sibling = town.variantUnlocks.suit_sunrise_authority
check(sibling.step ~= variant.step or sibling.contact ~= variant.contact,
	"variants within a suit family have separate unlock milestones")
local oldSibling = ix.item.list.suit_sunrise_authority
ix.item.list.suit_sunrise_authority = {baseSuit = "suit_sunrise"}
check(not town:CanChangeSuitVariant(variantOwner, "suit_sunrise_authority"),
	"unlocking Anarchist conversion does not authorise Authority conversion")
ix.item.list.suit_sunrise_authority = oldSibling
ix.item.list.suit_sunrise_anarchist = oldValue

local upgrading = character({townNPCProgression = {counts = {}, claims = {}, opponents = {}, pending = {}}})
local record = ix.progression.GetCharacterProgression(upgrading)
local oldCommission = town:StepID("ballast", "BA02")
local oldHandIn = town:StepID("ballast", "BA01")
record.lines[oldCommission] = {completed = true}
record.lines[oldHandIn] = {completed = true, rewardCredit = {money = 9000, reputation = 0}}
ix.progression.SetCharacterProgression(upgrading, record)
town:InitializeTownCharacter(upgrading)
check(upgrading:GetData("townNPCProgression").rewardVersion == 2, "existing saves migrate reward policy once")
check(upgrading.money == 9000, "migration preserves accrued credit without retroactive commission cash")
town:InitializeTownCharacter(upgrading)
check(upgrading.money == 9000, "reconnect cannot repeat migrated rewards")

print(string.format("PASS: %d town NPC checks", checks))
