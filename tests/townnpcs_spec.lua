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
for _, name in ipairs({"settings", "rewardsettings", "fieldsettings", "killcredit", "regionalcatalogue"}) do
	dofile("gamemodes/ix_cotz/plugins/jobsystem/definitions/sh_" .. name .. ".lua")
end
dofile(base .. "jobsystem/libs/sh_taskrewards.lua")
dofile(base .. "progression/libs/sh_rewards.lua")
dofile(base .. "progression/libs/sv_rewards.lua")
ix.jobs = {settings = ix.jobs.settings, regionalCatalogue = ix.jobs.regionalCatalogue,
	list = {}, jobsbycategory = {}, field = {
	sources = {}, settings = {}, IsAvailable = function() return true end,
}}
for _, kind in ipairs({"recovery", "sensor", "triangulation", "deadDrop", "defence"}) do
	ix.jobs.field.settings[kind] = {sources = {}}
end
local originalFindMetaTable = FindMetaTable
FindMetaTable = function() return {} end
dofile(base .. "jobsystem/libs/sh_jobs.lua")
dofile(base .. "jobsystem/libs/sh_regionaljobs.lua")
FindMetaTable = originalFindMetaTable
dofile(base .. "jobsystem/libs/sh_tooljobs.lua")
dofile(base .. "townnpcs/libs/sh_00_townnpcs.lua")
for _, name in ipairs({"sh_catalogue", "sh_jobs", "sh_regionaljobs", "sh_progressions", "sh_sites", "sh_validation", "sv_runtime"}) do
	dofile(base .. "townnpcs/libs/" .. name .. ".lua")
end
local definitions = assert(io.popen("rg --files gamemodes/ix_cotz/plugins/townnpcs/definitions"))
local paths = {}
for path in definitions:lines() do paths[#paths + 1] = path end
definitions:close()
table.sort(paths)
for _, path in ipairs(paths) do dofile(path) end
ix.townNPCs:BuildProgressions()
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
local descriptionStep
for _, step in ipairs(ix.townNPCs.contacts.gasket.progression) do
	if step.field and step.field.cargo then descriptionStep = step break end
end
local originalCargoDescription = descriptionStep.field.description
descriptionStep.field.description = "A recorder labelled with generator service dates."
ix.townNPCs:BuildJobs()
local describedJob = ix.jobs.list["cotz/town/commission/gasket/" .. descriptionStep.id]
check(describedJob.fieldCargoDescription == descriptionStep.field.description,
	"commission registration carries the optional cargo description")
descriptionStep.field.description = originalCargoDescription
describedJob.fieldCargoDescription = originalCargoDescription
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
for _, contact in pairs(ix.townNPCs.contacts) do
	if contact.legacyJob.kind == "delivery" then
		for _, difficulty in ipairs({"easy", "medium", "hard"}) do
			local prefix = "cotz/town/" .. contact.id .. "/" .. difficulty .. "/"
			for id, job in pairs(ix.jobs.list) do
				if id:sub(1, #prefix) == prefix then
					check((job.requiredPool ~= nil) == (difficulty == "easy"),
						"only easy deliveries accept a complete category")
					if job.requiredPool then
						local member = false
						for _, candidate in ipairs(ix.progression.itemPools[job.requiredPool].candidates) do
							member = member or candidate.item == job.requiredItem
						end
						check(member, "original delivery reference belongs to the accepted category")
						check(job.desc:find("Any item in this category counts", 1, true),
							"easy offers explain category alternatives")
					end
				end
			end
		end
	end
end
ix.townNPCs:ConfigureSources()
ix.townNPCs.installed = true
local count, contactCount = 0, 0
local homeCategories = {}
for _, contact in pairs(ix.townNPCs.contacts) do
	contactCount = contactCount + 1
	local key = contact.map .. "/" .. contact.job.category
	if contact.job.kind == "none" then key = key .. "/" .. contact.id end
	check(not homeCategories[key], "repeatable category must be unique per home map")
	homeCategories[key] = true
	check(contact.map ~= "rp_pripyat_remaster", "Pripyat has no home contact")
	local root, forks, joins = 0, 0, 0
	for _, step in ipairs(contact.progression) do
		local definition = ix.progression.definitions[ix.townNPCs:StepID(contact.id, step.id)]
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
	check(#contact.progression == 0 or (root == 1 and forks > 0 and joins > 0), "each contact has a sparse tree, not a linear chain")
end
local deliveryContacts = 0
for id, contact in pairs(ix.townNPCs.contacts) do
	if contact.legacyJob.deliveryTiers then
		deliveryContacts = deliveryContacts + 1
		for _, difficulty in ipairs({"easy", "medium", "hard"}) do
			local settings = contact.legacyJob.deliveryTiers[difficulty]
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
check(deliveryContacts == 11, "research artifact requests replace Egghead's ordinary valuables additions")
check(not ix.jobs.list["cotz/town/mute/easy/value_field_laptop"], "Marsh easy work excludes laptops")
check(ix.jobs.list["cotz/town/mute/hard/value_field_laptop"], "Mute can commission Pripyat computers")

check(contactCount == 27 and count == 600, "The Original remains a contact without active progression")
local convertedCount, remainingFields = 0, 0
for _, contact in pairs(ix.townNPCs.contacts) do
	local converted, fields = 0, 0
	for _, step in ipairs(contact.progression) do
		if step.kind == "field" then fields = fields + 1 end
		if step.retiredCommission then
			converted = converted + 1
			check(step.kind == "delivery" and not step.field and #step.requirements > 0,
				"converted commissions use ordinary delivery slots without field interactions")
			local job = ix.jobs.list["cotz/town/commission/" .. contact.id .. "/" .. step.id]
			check(job and not job.fieldType and not job.CanAcceptTask(),
				"saved commission identity remains claimable but cannot issue another field assignment")
		end
	end
	check(math.abs(converted - fields) <= 1, "each contact converts half its field progressions, rounded")
	convertedCount, remainingFields = convertedCount + converted, remainingFields + fields
end
check(convertedCount == 150 and remainingFields == 150, "retained contacts preserve the field/delivery split")
local cargoCount, recipientCount, dropCount = 0, 0, 0
for _, contact in pairs(ix.townNPCs.contacts) do
	for _, step in ipairs(contact.progression) do
		if step.field then
			local job = ix.jobs.list["cotz/town/commission/" .. contact.id .. "/" .. step.id]
			check(type(step.field.label) == "string" and step.field.label ~= ""
				and type(step.field.description) == "string" and step.field.description ~= "",
				"every field commission supplies its narrative cargo identity")
			check(job.fieldCargoName == step.field.label and job.fieldCargoDescription == step.field.description,
				"custom and standard-results commissions register their narrative cargo identity")
		end
		if step.field and step.field.cargo then
			cargoCount = cargoCount + 1
			local definition = ix.jobs.list["cotz/town/commission/" .. contact.id .. "/" .. step.id]
			check(ix.item.list[step.field.cargo].isFieldCargo,
				"authored cargo inherits binding and transfer protection")
			check(definition.fieldCargo == step.field.cargo and definition.fieldCargoName == step.field.label,
				"commission registration preserves its explicit cargo and identity")
			if step.field.recipient then
				recipientCount = recipientCount + 1
				local recipient = ix.townNPCs.contacts[step.field.recipient]
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
check(cargoCount == 146 and recipientCount == 35 and dropCount == 3,
	"authored commissions use custom recovery cargo, contact deliveries and field-cache deliveries")
check(#ix.townNPCs:ValidateContacts() == 0, "all current cargo and recipient declarations validate")
check(ix.townNPCs.contacts["arena-master"].map == "rp_marsh_cs", "arena stays with the Marsh dupe")
check(ix.townNPCs.contacts.latch.map == "rp_garbage_cotz", "Garbage uses the supplied map ID")
check(ix.townNPCs.contacts.smartass.map == "rp_waystation", "Smartass lives in Waystation")
check(ix.townNPCs.contacts.spool.map == "rp_garbage_cotz", "Spool lives in Garbage")
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
check(fullCount == 600 + standaloneCount, "town trees coexist only with separate non-town content")
check(not ix.progression.definitions.oldTimerKillIntro, "superseded town definitions are absent")
for item, gate in pairs(ix.townNPCs.itemGates) do
	check(ix.progression.definitions[gate.id], "each catalogue item has an explicit current progression gate")
end
local equipmentCount = 0
for _ in pairs(ix.townNPCs.itemGates) do equipmentCount = equipmentCount + 1 end
check(equipmentCount > 210, "expanded equipment allocations are present in contact catalogues")
check(not ix.townNPCs.legacy and not ix.townNPCs.previousPrerequisites and not ix.townNPCs.CanContinueLegacy,
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
		Notify = function() end,
		GetCharacter = function() return value end,
		IsBot = function() return false end,
		getReputation = function() return value.reputation or 0 end,
		addReputation = function(_, amount) value.reputation = (value.reputation or 0) + amount end,
		SteamID64 = function() return tostring(value) end,
	}
	return value
end
local oldHandIn = character()
local oldHandInID = ix.townNPCs:StepID("old-timer", "OT01")
ix.progression.SetCharacterProgression(oldHandIn, {lines = {
	[oldHandInID] = {
		active = true,
		requirements = {food_can_sprats = 2},
		selections = {{pool = "canned_food", item = "food_can_sprats"}},
		complexData = {food_can_sprats = 1},
	},
}})
ix.progression.AssignActiveRequirements(oldHandIn)
local oldRequirements = ix.progression.GetRequirements(oldHandIn, oldHandInID)
check(oldRequirements.food_can_sprats == 2 and next(oldRequirements, "food_can_sprats") == nil,
	"FTS retuning preserves an already saved requirement outside the new availability pool")
check(ix.progression.GetComplexProgressionValue(oldHandIn, oldHandInID).food_can_sprats == 1,
	"FTS retuning preserves partial contributions")
check(ix.progression.AddComplexProgressionValue(oldHandIn, oldHandInID, {"food_can_sprats", 1}) == 1
	and ix.progression.IsCompleted(oldHandIn, oldHandInID),
	"the saved old request completes using only its remaining unit")

local savedDelivery = character({townNPCProgression = {
	counts = {}, claims = {}, opponents = {}, pending = {
		["'Old Timer'"] = {identifier = "cotz/town/commission/old-timer/OT04", serial = 1},
	},
}})
local savedID = ix.townNPCs:StepID("old-timer", "OT04")
local savedRecord = {lines = {[savedID] = {active = true}}}
for _, required in ipairs(ix.progression.definitions[savedID].prerequisites) do
	savedRecord.lines[required] = {completed = true, completionRewardsPaid = true}
end
ix.progression.SetCharacterProgression(savedDelivery, savedRecord)
ix.townNPCs:RecoverCompletions(savedDelivery)
check(ix.progression.IsCompleted(savedDelivery, savedID),
	"a converted commission's interrupted field completion still settles the same milestone")
check(not savedDelivery:GetData("townNPCProgression").pending["'Old Timer'"],
	"converted commission recovery clears the pending journal")
local savedCash = savedDelivery.money
check(savedCash == ix.townNPCs.steps[savedID].completionCash, "saved field completion receives its milestone payment")
ix.townNPCs:RecoverCompletions(savedDelivery)
check(savedDelivery.money == savedCash, "saved field completion cannot pay twice after conversion")

for _, contact in pairs(ix.townNPCs.contacts) do
	currentMap = contact.map
	for _, step in ipairs(contact.progression) do
		local id = ix.townNPCs:StepID(contact.id, step.id)
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
			check(ix.progression.SetProgressionValue(owner, id, definition.progressthresholds[1]),
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
ix.townNPCs:InitializeTownCharacter(fresh)
check(ix.progression.IsActive(fresh, ix.townNPCs:StepID("old-timer", "OT01")), "fresh character starts the modern tree")
check(not ix.progression.IsActive(fresh, "oldtimerItemDelivery_Knife1"), "fresh character gets no legacy duplicates")
local obsolete = character({progression = {lines = {oldtimerItemDelivery_Knife2 = {completed = true}}}})
ix.townNPCs:InitializeTownCharacter(obsolete)
check(not ix.townNPCs:CanBuyItem(obsolete, "knife3"), "retired completions cannot unlock current equipment")
check(not obsolete:GetData("townNPCProgression").legacy, "initialization does not create legacy compatibility state")
local qualified = character()
ix.townNPCs:InitializeTownCharacter(qualified)
local qm = ix.townNPCs.itemGates.knife4.id
local knifePrerequisite = ix.townNPCs.itemGates.knife3.id
local data = ix.progression.GetCharacterProgression(qualified)
for _, required in ipairs(ix.progression.definitions[qm].prerequisites) do
	if required ~= knifePrerequisite then data.lines[required] = {completed = true} end
end
data.lines[qm] = {active = true}
ix.progression.SetCharacterProgression(qualified, data)
check(not ix.progression.IsActive(qualified, qm), "advanced knife cannot bypass the survival knife milestone")
data.lines[knifePrerequisite] = {completed = true}
ix.progression.SetCharacterProgression(qualified, data)
check(ix.progression.IsActive(qualified, qm), "preceding knife prerequisite opens the bayonet milestone")

local hunter = character()
ix.townNPCs:InitializeTownCharacter(hunter)
for _, contact in pairs(ix.townNPCs.contacts) do
	check(ix.progression.CanUseNPC(hunter, contact.name),
		"fresh characters can access every town contact without progression")
end
ix.progression.SetCompleted(hunter, ix.townNPCs:StepID("old-timer", "OT01"))
ix.progression.SetCompleted(hunter, ix.townNPCs:StepID("old-timer", "OT02"))
hunter:SetData("jobClaimsPaid", {["'Old Timer'"] = 1})
ix.townNPCs:JobCompleted(hunter.client, "'Old Timer'", "cotz/town/old-timer/easy")
check(hunter:GetData("townNPCProgression").counts["'Old Timer'"] == 1, "valid completion advances its contact counter")
ix.townNPCs:JobCompleted(hunter.client, "'Old Timer'", "cotz/town/old-timer/easy")
check(hunter:GetData("townNPCProgression").counts["'Old Timer'"] == 1, "repeated completion cannot advance twice")
hunter:SetData("jobClaimsPaid", {["'Old Timer'"] = 2})
ix.townNPCs:JobCompleted(hunter.client, "'Old Timer'", "cotz/town/old-timer/easy")
local firstKnife = ix.townNPCs:StepID("old-timer", "OT03")
check(not ix.progression.IsCompleted(hunter, firstKnife), "three-times effort requires six jobs instead of two")
for claim = 3, 6 do
	hunter:SetData("jobClaimsPaid", {["'Old Timer'"] = claim})
	ix.townNPCs:JobCompleted(hunter.client, "'Old Timer'", "cotz/town/old-timer/easy")
end
check(ix.progression.IsCompleted(hunter, firstKnife), "cumulative hunting checkpoint completes its active node")
check(ix.progression.CanUseNPC(hunter, "'Haggler'"), "Haggler remains accessible after completing a milestone")
check(#(ix.progression.GetLine(hunter, firstKnife).pendingRewards or {}) == 0, "tracker does not duplicate job supplies")
check(not ix.townNPCs:CanAcceptJob(hunter, "'Old Timer'", ix.jobs.list["cotz/town/spoor/easy"]),
	"another contact's job cannot be accepted through a forged identifier")
check(not ix.townNPCs:CanAcceptJob(hunter, "'Old Timer'", ix.jobs.list["cotz/town/old-timer/hard"]),
	"hard work cannot bypass server reputation requirements")
local courier = character()
ix.townNPCs:InitializeTownCharacter(courier)
ix.progression.SetCompleted(courier, ix.townNPCs:StepID("ballast", "BA01"))
local commissionID = "cotz/town/commission/ballast/BA02"
local commission = {identifier = commissionID, numberRec = 1}
check(ix.taskRewards.PrepareJob(courier, "'Ballast'", commission), "commission gets a unique claim")
check(commission.moneyReward == 0 and #commission.rewardChoices == 0, "finite work has no repeatable cash/supply offer")
courier:SetData("jobClaimsPaid", {["'Ballast'"] = commission.progressionClaim})
ix.townNPCs:JobCompleted(courier.client, "'Ballast'", commissionID)
check(ix.progression.IsCompleted(courier, ix.townNPCs:StepID("ballast", "BA02")),
	"commission completion advances its exact node")
check((courier:GetData("townNPCProgression").counts["'Ballast'"] or 0) == 0,
	"authored work does not count as a repeatable completion")
check(ix.taskRewards.TraderBonusProgress(courier, "'Ballast'").count == nil,
	"finite commission has not created a five-task bonus")
local interrupted = character()
ix.townNPCs:InitializeTownCharacter(interrupted)
ix.progression.SetCompleted(interrupted, ix.townNPCs:StepID("ballast", "BA01"))
interrupted:SetData("jobClaimsPaid", {["'Ballast'"] = 101})
local advance = ix.progression.SetProgressionValue
ix.progression.SetProgressionValue = function() error("simulated interruption") end
local succeeded = pcall(function() ix.townNPCs:JobCompleted(interrupted.client, "'Ballast'", commissionID) end)
ix.progression.SetProgressionValue = advance
check(not succeeded, "fault injection interrupts commission advancement")
check(interrupted:GetData("townNPCProgression").pending["'Ballast'"], "interrupted commission keeps its journal")
ix.townNPCs:InitializeTownCharacter(interrupted)
local recoveredID = ix.townNPCs:StepID("ballast", "BA02")
check(ix.progression.IsCompleted(interrupted, recoveredID), "reloading resumes the journaled commission")
check(not interrupted:GetData("townNPCProgression").pending["'Ballast'"], "finished commission clears its journal")
local rewards = #(ix.progression.GetLine(interrupted, recoveredID).pendingRewards or {})
ix.townNPCs:InitializeTownCharacter(interrupted)
check(#(ix.progression.GetLine(interrupted, recoveredID).pendingRewards or {}) == rewards,
	"repeated recovery cannot queue the same completion reward twice")
local missingBenefit = character()
ix.townNPCs:InitializeTownCharacter(missingBenefit)
ix.progression.SetCompleted(missingBenefit, recoveredID)
ix.townNPCs:InitializeTownCharacter(missingBenefit)
check(ix.progression.GetLine(missingBenefit, recoveredID).benefitsClaimed.completion,
	"completed modern milestones recover benefits omitted by an interrupted completion")
check(ix.townNPCs.Initialize == nil, "plugin helpers cannot accidentally register the engine Initialize hook")
local arenaCharacter = character()
ix.townNPCs:InitializeTownCharacter(arenaCharacter)
local opponent = {SteamID64 = function() return "different-human" end, IsBot = function() return false end}
ix.townNPCs:ArenaCompleted(arenaCharacter.client, opponent)
ix.townNPCs:ArenaCompleted(arenaCharacter.client, opponent)
check(arenaCharacter:GetData("townNPCProgression").counts["'Arena Master'"] == nil,
	"removed arena progression does not accumulate opponents")
local before = arenaCharacter:GetData("townNPCProgression").counts["'Arena Master'"]
currentMap = "rp_garbage_cotz"
ix.townNPCs:ArenaCompleted(arenaCharacter.client, {SteamID64 = function() return "another-human" end,
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
ix.plugin = {Get = function(id) if id == "vendor_adv" then return vendorPlugin end return ix.townNPCs end}
dofile(base .. "dialogue/libs/sh_towncontacts.lua")
dofile(base .. "dialogue/libs/sh_townservices.lua")
ix.townNPCs:InstallContacts()
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
local function hasOption(topic, topicID)
	for _, option in ipairs(topic.options) do
		if option == topicID then return true end
	end

	return false
end
for _, contact in pairs(ix.townNPCs.contacts) do
	local tree = ix.dialogue.list[ix.npctemplates.templates[contact.template].dialogueid].tree
	local offered = {}
	for _, option in ipairs(tree.GREETING.options) do offered[option] = true end
	for _, topicID in ipairs({"InterestZoneLifeTopic", "InterestTownRelationsTopic"}) do
		check(hasOption(tree.QuestionsTopic, topicID), "personal subjects are offered by each contact's questions menu")
		check(not offered[topicID] and not hasOption(tree.BackTopic, topicID),
			"personal subjects do not displace root actions")
	end
	check(hasOption(tree.InterestZoneLifeTopic, "InterestPersonalFollowup")
		or hasOption(tree.InterestTownRelationsTopic, "InterestPersonalFollowup"),
		"each contact's personal follow-up is reachable from its subject")
	for _, topicID in ipairs({"InterestZoneLifeTopic", "InterestTownRelationsTopic", "InterestPersonalFollowup"}) do
		check(hasOption(tree[topicID], "QuestionsBackTopic"), "personal replies return to the questions menu")
		if contact.id == "mute" then
			check(tree[topicID].response:sub(1, 2) == "**" and tree[topicID].response:sub(-2) == "**",
				"Mute's new personal replies preserve nonverbal presentation")
		end
	end
	check(offered.TradeTopic and (offered.TownProgression == true) == (#contact.progression > 0),
		"only contacts with active milestones expose progression")
	check(offered.AboutWorkTopic, "all contacts expose the work status menu")
	check(not offered.AboutProgression, "only the current progression action is offered")
	check(not tree.AboutProgression and not tree.GetTask and not tree.ConfirmTask and not tree.ViewProgression,
		"superseded topics are deleted from the definition, not hidden")
	check(tree.TradeTopic.postCallback == ix.dialogue.OpenVendor, "all town trading uses the owning shared handler")
	check(contact.job.kind == "none" or offered.GetTaskByDifficulty, "assigned contacts offer their category")
	if contact.job.kind ~= "none" then
		check(tree.GetTaskByDifficulty.response == contact.dialogue.work,
			"work offers display their contact's explanation instead of a generic spoken line")
		local dialogue = ix.dialogue.list[ix.npctemplates.templates[contact.template].dialogueid]
		ix.dialogue.ConfigureTaskRewards(dialogue)
		check(tree.GetTaskByDifficulty.response == contact.dialogue.work,
			"reward reconfiguration preserves the contact's work explanation")
	end
	check(#contact.progression == 0 or (tree.TownView and tree.TownCommission and tree.TownHandIn),
		"active finite commissions and hand-ins are wired")
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
local incomingTree = ix.dialogue.list[ix.npctemplates.templates[ix.townNPCs.contacts.ledger.template].dialogueid].tree
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
local previousInteract, previousDeliver = ix.townNPCs.CanInteract, ix.jobs.field.DeliverToContact
local deliveredCalls = 0
local receivingVendor = {}
ix.jobs.field.DeliverToContact = function(client, target, npc, claim)
	check(client == deliveryReader.client and target == receivingVendor and npc == "'Ballast'"
		and claim == "job:incoming", "dialogue forwards the selected owner and claim to authoritative delivery")
	deliveredCalls = deliveredCalls + 1
end
ix.townNPCs.CanInteract = function() return false end
incoming.ResolveDynamicOption(nil, deliveryReader.client, receivingVendor, incomingOptions[1].dyndata)
check(deliveredCalls == 0, "inaccessible receiving vendors cannot invoke a delivery")
ix.townNPCs.CanInteract = function() return true end
incoming.ResolveDynamicOption(nil, deliveryReader.client, receivingVendor, incomingOptions[1].dyndata)
incoming.ResolveDynamicOption(nil, deliveryReader.client, receivingVendor, incomingOptions[1].dyndata)
check(deliveredCalls == 1, "incoming delivery dialogue rate-limits repeated requests on the server")
incomingJobs["'Ballast'"].fieldTask.stage = "delivered"
check(not incoming.ShouldAdd(nil, deliveryReader.client), "receipted cargo disappears from incoming delivery dialogue")
ix.townNPCs.CanInteract, ix.jobs.field.DeliverToContact = previousInteract, previousDeliver
SortedPairs, CurTime = oldSortedPairs, oldCurTime

local vendor = {
	items = {medic_bandage_1 = {321, 0, 2, 7, 99, 1}},
	GetDisplayName = function() return "'Jitters'" end,
}
local originalEntry = vendor.items.medic_bandage_1
vendor.AddItemToList = function(self, item, price, stock, mode, maximum, interval, amount)
	self.items[item] = {price, stock, mode, maximum, interval, amount}
end
check(vendorPlugin:RefreshTownVendor(vendor, ix.townNPCs.contacts.jitters, ix.townNPCs.catalogues["'Jitters'"] or {},
	ix.townNPCs.settings.supplyStock), "saved vendors receive missing catalogue and supply entries")
check(vendor.items.medic_bandage_1 ~= originalEntry and vendor.items.medic_bandage_1[3] == 1,
	"the approved catalogue replaces stale policies without changing character-owned stock histories")
check(not vendorPlugin:RefreshTownVendor(
	vendor, ix.townNPCs.contacts.jitters, ix.townNPCs.catalogues["'Jitters'"] or {}, ix.townNPCs.settings.supplyStock
), "repeated vendor refresh is idempotent")

PLUGIN = ix.townNPCs
local builders = {"BuildProgressions", "BuildJobs", "ConfigureSources", "InstallContacts"}
local originals, installed = {}, {}
for _, name in ipairs(builders) do
	originals[name] = ix.townNPCs[name]
	ix.townNPCs[name] = function() installed[#installed + 1] = name end
end
ix.townNPCs.installed = false
ix.townNPCs:Install()
check(ix.townNPCs.installed and #installed == 4, "startup validates actual template identities and all home categories")
for index, name in ipairs(builders) do
	check(installed[index] == name, "startup builds registries in dependency order")
	ix.townNPCs[name] = originals[name]
end

local commands = {}
ix.command = {Add = function(name, definition) commands[name] = definition end}
ix.type = {string = "string"}
local savedPoints
local sitePlugin = {
	GetData = function(self, default, global, ignoreMap)
		check(ignoreMap == true, "field sites load all map regions")
		return {recovery = {rp_garbage_cotz = {{"saved-garbage-point"}}}}
	end,
	SetData = function(self, data, global, ignoreMap)
		check(ignoreMap == true, "field sites persist independently of the current map")
		savedPoints = data
	end,
}
PLUGIN = sitePlugin
PLUGIN.siteDefinitions = {recovery = {rp_marsh_cs = {{"shared-marsh-point"}}, rp_garbage_cotz = {{"default"}}}}
dofile(base .. "townnpcs/libs/sh_commands.lua")
dofile(base .. "townnpcs/libs/sv_sites.lua")
PLUGIN:LoadData()
check(PLUGIN.recoveryPoints.rp_marsh_cs[1][1] == "shared-marsh-point", "shared definitions fill unsaved map regions")
check(PLUGIN.recoveryPoints.rp_garbage_cotz[1][1] == "saved-garbage-point", "local authoring overrides shared map defaults")
PLUGIN:SaveData()
check(savedPoints.recovery.rp_marsh_cs and savedPoints.recovery.rp_garbage_cotz, "saving retains both map regions")
for _, name in ipairs({
	"TownNPCPlace", "TownNPCAddFieldPoint", "TownNPCRemoveFieldPoint", "TownNPCExportFieldPoints",
}) do
	check(commands[name] and commands[name].adminOnly, "placement and site authoring commands are admin-only")
end

local savedRequires = ix.townNPCs.contacts.atlas.progression[1].requires
ix.townNPCs.contacts.atlas.progression[1].requires = {"AT_missing"}
local errors = ix.townNPCs:ValidateContacts()
check(#errors == 1 and errors[1]:find("atlas: AT01 requires missing step AT_missing", 1, true),
	"definition diagnostics identify the contact, objective and invalid prerequisite")
ix.townNPCs.contacts.atlas.progression[1].requires = savedRequires
local fieldStep = ix.townNPCs.contacts.atlas.progression[2]
local savedCargo, savedRecipient = fieldStep.field.cargo, fieldStep.field.recipient
fieldStep.field.cargo = "missing_cargo"
errors = ix.townNPCs:ValidateContacts()
check(#errors == 1 and errors[1]:find("AT02 uses invalid bound cargo missing_cargo", 1, true),
	"invalid custom cargo prevents town startup")
fieldStep.field.cargo, fieldStep.field.recipient = savedCargo, "missing-contact"
errors = ix.townNPCs:ValidateContacts()
check(#errors == 1 and errors[1]:find("AT02 uses invalid delivery recipient missing-contact", 1, true),
	"unknown delivery recipients prevent town startup")
fieldStep.field.recipient = "atlas"
check(#ix.townNPCs:ValidateContacts() == 1, "a commission cannot name its own issuer as an intermediate recipient")
fieldStep.field.recipient = savedRecipient
local available = ix.jobs.field.IsAvailable
ix.jobs.field.IsAvailable = function(definition) return definition.fieldMap ~= "rp_garbage_cotz" end
local missing = ix.townNPCs:GetMissingFieldSites()
check(missing["recovery on rp_garbage_cotz"] > 0, "missing field sites are reported by mechanic and region")
ix.jobs.field.IsAvailable = available
local oldJobs, oldCategories = ix.jobs.list, ix.jobs.jobsbycategory
ix.jobs.list, ix.jobs.jobsbycategory = {}, {}
ix.townNPCs.contacts.atlas.job.rewards = {
	easy = {money = 17, reputation = 3},
	medium = {money = 19, reputation = 5},
	hard = {money = 23, reputation = 7},
}
ix.townNPCs:BuildJobs()
check(ix.jobs.list["cotz/town/v2/atlas/easy/mutant"].moneyReward == 17,
	"contact definitions can override default repeatable payouts")
check(ix.jobs.list["cotz/town/v2/atlas/hard/anomaly"].repReward == 7,
	"contact definitions can override reputation per difficulty")
ix.townNPCs.contacts.atlas.job.rewards = nil
ix.jobs.list, ix.jobs.jobsbycategory = oldJobs, oldCategories
local include = ix.util.Include
local included = {}
ix.util.Include = function(path)
	local source = assert(io.open(base .. "townnpcs/" .. path))
	source:close()
	included[path] = (included[path] or 0) + 1
end
PLUGIN = ix.townNPCs
dofile(base .. "townnpcs/sh_plugin.lua")
ix.util.Include = include
for slug in pairs(ix.townNPCs.contacts) do
	local path = "definitions/sh_" .. slug:gsub("-", "_") .. ".lua"
	check(included[path] == 1, "the real plugin entry point explicitly includes each contact exactly once")
end
check(included["definitions/sh_config.lua"] and included["definitions/sh_equipment.lua"], "shared configuration and equipment families are explicitly loaded")
local notify, message = ix.progression.Notify
ix.progression.Notify = function(_, _, text) message = text end
ix.dialogue.notifyReputationReceive = function() end
ix.dialogue.notifyMoneyReceive = function() end
local quiet = character()
ix.townNPCs:InitializeTownCharacter(quiet)
ix.progression.SetCompleted(quiet, ix.townNPCs:StepID("old-timer", "OT19"))
ix.progression.SetCompleted(quiet, ix.townNPCs:StepID("mute", "MU02"))
local quietCheckpoint = ix.townNPCs:StepID("mute", "MU03")
ix.progression.SetProgressionValue(quiet, quietCheckpoint,
	ix.progression.definitions[quietCheckpoint].progressthresholds[1])
check(message == quiet:GetName() .. ", " .. ix.townNPCs.steps[quietCheckpoint].completion,
	"town completion notifications identify the completing character, including gesture replies")
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
for id in pairs(ix.townNPCs.steps) do visit(id) end

-- Reward overhaul: exhaustive acquisition coverage and shared, deterministic gates.
local gunFiles = assert(io.popen("rg --files gamemodes/ix_cotz/schema/items/newweapons"))
local availableGuns, reservedGuns = 0, 0
for path in gunFiles:lines() do
	local itemID = path:match("/sh_([^/]+)%.lua$")
	if ix.townNPCs:IsPurchaseExcluded(itemID) then
		reservedGuns = reservedGuns + 1
	else
		check(ix.townNPCs.itemGates[itemID], "every non-reserved gun has a purchase route: " .. itemID)
		availableGuns = availableGuns + 1
	end
end
gunFiles:close()
check(availableGuns == 122 and reservedGuns == 8, "all 130 guns are accounted for")
for itemID, allocation in pairs(ix.townNPCs.variantUnlocks) do
	check(not ix.townNPCs.itemGates[itemID], "variants cannot enter the purchase catalogue")
	check(ix.progression.definitions[ix.townNPCs:StepID(allocation.contact, allocation.step)],
		"every conversion has a valid milestone")
end
local medkit = "medic_medkit_2"
check(not ix.townNPCs.contacts.wake.catalogue[medkit].unlockContact, "Wake's medicine has local progression")
local shared = character()
local jittersGate = ix.townNPCs.itemGates[medkit].sellers["'Jitters'"].id
local wakeGate = ix.townNPCs.itemGates[medkit].sellers["'Wake'"].id
local record = ix.progression.GetCharacterProgression(shared)
record.lines[jittersGate] = {completed = true}
ix.progression.SetCharacterProgression(shared, record)
check(ix.townNPCs:CanBuyItem(shared, medkit, "'Jitters'"), "Jitters recognises his own unlock")
check(not ix.townNPCs:CanBuyItem(shared, medkit, "'Wake'"), "Jitters cannot unlock Wake's medicine")
local independent = character()
local record = ix.progression.GetCharacterProgression(independent)
record.lines[wakeGate] = {completed = true}
ix.progression.SetCharacterProgression(independent, record)
check(ix.townNPCs:CanBuyItem(independent, medkit, "'Wake'"), "Wake can unlock medicine independently")
check(not ix.townNPCs:CanBuyItem(independent, medkit, "'Jitters'"), "Wake cannot unlock Jitters's medicine")
for _, seller in ipairs({"'Jitters'", "'Wake'"}) do
	local lower = ix.townNPCs.itemGates.medic_medkit_1.sellers[seller]
	local higher = ix.townNPCs.itemGates.medic_medkit_2.sellers[seller]
	local found = false
	for _, id in ipairs(ix.progression.definitions[higher.id].prerequisites) do
		if id == lower.id then found = true end
	end
	check(found, "each seller requires its own previous medkit tier")
end
for _, item in ipairs({"backpack_4", "backpack_5", "backpack_4_large", "backpack_5_large"}) do
	check(
		ix.townNPCs:IsPurchaseExcluded(item) and not ix.townNPCs.itemGates[item],
		"top backpack is reserved: " .. item
	)
end
local carrying = character()
local record = ix.progression.GetCharacterProgression(carrying)
for id, step in pairs(ix.townNPCs.steps) do
	if step.capacity then record.lines[id] = {completed = true} end
end
ix.progression.SetCharacterProgression(carrying, record)
check(ix.townNPCs:GetCapacityBonus(carrying, "weight") == 5, "five small weight awards total five kilograms")
check(ix.townNPCs:GetCapacityBonus(carrying, "rows") == 2, "two separate inventory awards total two rows")
check(ix.townNPCs:GetCapacityBonus(character(), "rows") == 0, "capacity belongs to the character")
local commissionReward = character()
local id = ix.townNPCs:StepID("ballast", "BA02")
local record = ix.progression.GetCharacterProgression(commissionReward)
record.lines[id] = {completed = true}
ix.progression.SetCharacterProgression(commissionReward, record)
ix.progression.PayCompletionRewards(commissionReward, id)
local earned = commissionReward.money
check(earned == ix.townNPCs.steps[id].completionCash, "field commissions receive exactly their listed payment")
ix.progression.PayCompletionRewards(commissionReward, id)
check(commissionReward.money == earned, "completion payments cannot be replayed")
local oldValue = ix.item.list.suit_sunrise_anarchist
ix.item.list.suit_sunrise_anarchist = {baseSuit = "suit_sunrise"}
check(ix.townNPCs:IsPurchaseExcluded("suit_sunrise_anarchist"), "variants are blocked even at saved vendors")
check(
	not ix.townNPCs:CanChangeSuitVariant(character(), "suit_sunrise_anarchist"),
	"conversion requires earned progress"
)
local variantOwner = character()
local record = ix.progression.GetCharacterProgression(variantOwner)
local variant = ix.townNPCs.variantUnlocks.suit_sunrise_anarchist
record.lines[ix.townNPCs:StepID(variant.contact, variant.step)] = {completed = true}
ix.progression.SetCharacterProgression(variantOwner, record)
check(
	not ix.townNPCs:CanChangeSuitVariant(variantOwner, "suit_sunrise_anarchist"),
	"variant cannot bypass its base suit"
)
record.lines[ix.townNPCs.itemGates.suit_sunrise.id] = {completed = true}
ix.progression.SetCharacterProgression(variantOwner, record)
check(
	ix.townNPCs:CanChangeSuitVariant(variantOwner, "suit_sunrise_anarchist"),
	"base plus variant milestones allow conversion"
)
local sibling = ix.townNPCs.variantUnlocks.suit_sunrise_authority
check(sibling.step ~= variant.step or sibling.contact ~= variant.contact,
	"variants within a suit family have separate unlock milestones")
local oldSibling = ix.item.list.suit_sunrise_authority
ix.item.list.suit_sunrise_authority = {baseSuit = "suit_sunrise"}
check(not ix.townNPCs:CanChangeSuitVariant(variantOwner, "suit_sunrise_authority"),
	"unlocking Anarchist conversion does not authorise Authority conversion")
ix.item.list.suit_sunrise_authority = oldSibling
ix.item.list.suit_sunrise_anarchist = oldValue

local upgrading = character({townNPCProgression = {counts = {}, claims = {}, opponents = {}, pending = {}}})
local record = ix.progression.GetCharacterProgression(upgrading)
local oldCommission = ix.townNPCs:StepID("ballast", "BA02")
local oldHandIn = ix.townNPCs:StepID("ballast", "BA01")
record.lines[oldCommission] = {completed = true}
record.lines[oldHandIn] = {completed = true, rewardCredit = {money = 9000, reputation = 0}}
ix.progression.SetCharacterProgression(upgrading, record)
ix.townNPCs:InitializeTownCharacter(upgrading)
check(upgrading:GetData("townNPCProgression").rewardVersion == 2, "existing saves migrate reward policy once")
check(upgrading.money == 9000, "migration preserves accrued credit without retroactive commission cash")
ix.townNPCs:InitializeTownCharacter(upgrading)
check(upgrading.money == 9000, "reconnect cannot repeat migrated rewards")

-- Regional coverage and authoring-only future rewards.
do
	local services = {
		["cotz/town/ballast/BA12"] = true, ["cotz/town/technut/TN13"] = true,
		["cotz/town/mute/MU09"] = true, ["cotz/town/mute/MU15"] = true,
		["cotz/town/intern/IN15"] = true,
	}
	local liveCount, placeholderOnly, plannedCount, cashOnly = 0, 0, 0, 0
	local families = {}
	local function ancestors(id, result)
		result = result or {}
		for _, parent in ipairs(ix.progression.definitions[id].prerequisites) do
			if not result[parent] then
				result[parent] = true
				ancestors(parent, result)
			end
		end

		return result
	end
	for id, step in pairs(ix.townNPCs.steps) do
		local definition = ix.progression.definitions[id]
		local live = #definition.vendorUnlocks > 0 or #(definition.variantUnlocks or {}) > 0
			or step.stock or step.capacity or #(step.discounts or {}) > 0 or services[id]
			or #(definition.townServices or {}) > 0
		local planned = #(step.plannedUnlocks or {}) > 0
		check(live or (step.completionCash or 0) > 0,
			"every milestone grants an unlock or completion cash: " .. id)
		if live then liveCount = liveCount + 1 elseif planned then placeholderOnly = placeholderOnly + 1 end
		if not live then cashOnly = cashOnly + 1 end
		check(not definition.plannedUnlocks, "planned metadata never enters the runtime reward definition")
		local text = ix.progression.GetBenefitSummary(definition, character())
		for _, reward in ipairs(step.plannedUnlocks or {}) do
			plannedCount = plannedCount + 1
			families[reward.kind] = true
			check(reward.status == "unimplemented", "future rewards are explicitly inactive")
			check(not text:find(reward.name, 1, true), "future reward is absent from the benefit summary")
			check(not ix.progression.definitions[reward.id], "future reward creates no progression entitlement")
		end
		if step.stock then
			local owner = character()
			local record = ix.progression.GetCharacterProgression(owner)
			for parent in pairs(ancestors(id)) do record.lines[parent] = {completed = true} end
			ix.progression.SetCharacterProgression(owner, record)
			local npc = definition.keyNpc
			local before = ix.progression.GetStockBonus(owner, npc, step.stock.item)
			record.lines[id] = {completed = true}
			ix.progression.SetCharacterProgression(owner, record)
			check(ix.progression.GetStockBonus(owner, npc, step.stock.item) > before,
				"every stock reward improves its prerequisites' effective capacity: " .. id)
			check(step.stock.bonus <= 4, "stock bonuses respect the allocation budget")
		end
	end
	check(liveCount + cashOnly == 600,
		"functional unlocks and paid commissions account for every retained step")
	for _, kind in ipairs({"passage", "cosmetic", "storage", "barter", "supplyExchange", "information", "recipe"}) do
		check(families[kind], "all planned mechanic families have authored allocations")
	end
	local todoCount = 0
	for slug in pairs(ix.townNPCs.contacts) do
		local file = assert(io.open(base .. "townnpcs/definitions/sh_" .. slug:gsub("-", "_") .. ".lua"))
		local source = file:read("*a")
		source = source:match("^(.-)\tretiredProgression") or source
		file:close()
		for _ in source:gmatch("%-%- TODO:[^\n]+\n\t\t\t\t{") do todoCount = todoCount + 1 end
	end
	check(todoCount == plannedCount, "every planned entry has its own immediately preceding TODO")
	for _, slug in ipairs({"jitters", "wake"}) do
		local contact = ix.townNPCs.contacts[slug]
		local owner = character()
		check(not ix.townNPCs:CanBuyItem(owner, "medic_bandage_1", contact.name),
			"starting bandages follow the planned purchase gate")
		for _, item in ipairs({"medic_medkit_1", "medic_antirad_1"}) do
			local route = contact.catalogue[item]
			check(route and tonumber(route.step:sub(3)) <= 3, "basic medicine unlocks in the local introduction")
			for parent in pairs(ancestors(ix.townNPCs:StepID(slug, route.step))) do
				check(ix.progression.definitions[parent].townContact == slug,
					"introductory medicine has no external contact prerequisite")
			end
		end
	end
	for _, slug in ipairs({"old-timer", "brass", "quartermaster"}) do
		local contact = ix.townNPCs.contacts[slug]
		check(#contact.supplies == 0, "planned providers have no starting sale ammunition")
	end
	local owner = character()
	local record = ix.progression.GetCharacterProgression(owner)
	local ammo = "545x39"
	local brass = ix.townNPCs.itemGates[ammo].sellers["'Brass'"]
	local quartermaster = ix.townNPCs.itemGates[ammo].sellers["'Quartermaster'"]
	record.lines[brass.id] = {completed = true}
	ix.progression.SetCharacterProgression(owner, record)
	check(ix.progression.CanBuyItem(owner, "'Brass'", ammo), "Brass recognises his local ammunition milestone")
	check(not ix.progression.CanBuyItem(owner, "'Quartermaster'", ammo),
		"Brass does not unlock Quartermaster's ammunition")
	check(not ix.townNPCs:CanBuyItem(owner, ammo, "'Mute'"), "unlisted sellers cannot inherit another shop's gate")
	record.lines = {[quartermaster.id] = {completed = true}}
	ix.progression.SetCharacterProgression(owner, record)
	check(ix.progression.CanBuyItem(owner, "'Quartermaster'", ammo), "Quartermaster's ordinary calibre is local")
	check(not ix.progression.CanBuyItem(owner, "'Brass'", ammo), "local ammunition unlocks work independently both ways")
	for _, chain in ipairs(ix.townNPCs.upgradeChains) do
		for index = 2, #chain do
			local lower, higher = ix.townNPCs.itemGates[chain[index - 1]], ix.townNPCs.itemGates[chain[index]]
			for npc, route in pairs(higher and higher.sellers or {}) do
				local previous = lower
				if chain[index]:sub(1, 6) == "medic_" then previous = lower and lower.sellers[npc] end
				if previous and not previous.ungated and not route.ungated and previous.id ~= route.id then
					check(ancestors(route.id)[previous.id], "every duplicate tier retains its canonical predecessor")
				end
			end
		end
	end
	for item, slug in pairs(ix.townNPCs.canonicalSellers) do
		check(ix.townNPCs.itemGates[item].npc == ix.townNPCs.contacts[slug].name,
			"canonical tier ownership follows authored data, not table iteration")
	end
	for item, step in pairs({binoculars_2 = "AT01", binoculars_1 = "AT08", binoculars_4 = "AT15",
		binoculars_3 = "AT22"}) do
		check(
			ix.townNPCs.itemGates[item].id == ix.townNPCs:StepID("atlas", step),
			"Atlas owns the canonical binocular chain"
		)
	end
	for index = 1, 5 do
		local item = "binoculars_" .. index
		check(not ix.townNPCs.contacts.mute.catalogue[item] and not ix.progression.CanBuyItem(owner, "'Mute'", item),
			"Mute cannot sell binoculars, including stale saved vendor rows")
		for _, candidate in ipairs(ix.townNPCs.contacts.mute.rewards.bonusItems or {}) do
			check(candidate ~= item, "Mute's future bonus offers contain no binoculars")
		end
	end
	-- Completing a redistributed permanent entitlement never queues another consumable payout.
	local existing = character()
	local existingRecord = ix.progression.GetCharacterProgression(existing)
	existingRecord.lines[ix.townNPCs:StepID("atlas", "AT01")] = {
		completed = true, completionRewardsPaid = true, benefitsClaimed = {completion = true},
	}
	ix.progression.SetCharacterProgression(existing, existingRecord)
	ix.townNPCs:InitializeTownCharacter(existing)
	check(
		ix.townNPCs:CanBuyItem(existing, "binoculars_2", "'Atlas'"),
		"completed saves derive their reassigned entitlement"
	)
	local pending = ix.progression.GetLine(existing, ix.townNPCs:StepID("atlas", "AT01")).pendingRewards or {}
	check(existing.money == 0 and #pending == 0,
		"new permanent access does not replay completion gifts or cash")
	print(string.format("Reward coverage: %d functional, %d placeholder-only, %d planned unlocks",
		liveCount, placeholderOnly, plannedCount))
end

print(string.format("PASS: %d town NPC checks", checks))
