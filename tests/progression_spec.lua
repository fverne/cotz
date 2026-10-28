-- Run from the addon root with Lua 5.1+ or: luatex --luaonly tests/progression_spec.lua
-- Uses the real progression library/definitions with small GMod/Helix stand-ins.
local function copy(value)
	if type(value) ~= "table" then
		return value
	end
	local result = {}
	for key, entry in pairs(value) do
		result[key] = copy(entry)
	end

	return result
end
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end
math.random = function(minimum)
	return minimum
end
SERVER = true
CLIENT = false
istable = function(value)
	return type(value) == "table"
end
isnumber = function(value)
	return type(value) == "number"
end
isfunction = function(value)
	return type(value) == "function"
end
tobool = function(value)
	return value == true or value == 1
end
IsValid = function(value)
	return type(value) == "table" and not value.invalid
end
Vector = function(x, y, z)
	return { x = x, y = y, z = z }
end
Angle = Vector
unpack = unpack or table.unpack
table.Copy = copy
local timers, messages, callbacks, currentMap = {}, {}, {}, "rp_marsh_cs"
local lostItems = {}
timer = {
	Simple = function(delay, callback)
		timers[#timers + 1] = callback
	end,
}
hook = {
	Run = function() end,
	Add = function(event, id, callback)
		callbacks[id] = callback
	end,
}
game = {
	GetMap = function()
		return currentMap
	end,
}
local position = {
	DistToSqr = function()
		return 0
	end,
}
local vendors = {}
ents = {
	FindByClass = function()
		return vendors
	end,
}
ix = {
	meta = { character = {} },
	progression = { definitions = {} },
	chat = {
		Send = function(...)
			messages[#messages + 1] = { ... }
		end,
	},
	item = { list = setmetatable({}, {
		__index = function(_, key)
			return { name = key }
		end,
	}) },
	util = {
		GetValueFromProgressionTurnin = function(item, amount)
			return amount, amount * 2
		end,
	},
	dialogue = {
		notifyReputationReceive = function() end,
		notifyMoneyReceive = function() end,
		notifyItemGet = function() end,
		notifyItemLost = function(client, description)
			lostItems[#lostItems + 1] = { client = client, description = description }
		end,
	},
	command = { Add = function() end },
	type = { character = 1, string = 2 },
	npctemplates = { templates = {} },
}
local meta = ix.meta.character
local function addReward(inventory, itemID, amount, data)
	inventory.rewards = inventory.rewards or {}
	inventory.rewards[#inventory.rewards + 1] = { item = itemID, amount = amount, data = copy(data) }

	return true
end
meta.__index = meta
function meta:GetData(key, default)
	if self.data[key] == nil then return default end

	return self.data[key]
end
function meta:SetData(key, value)
	self.data[key] = value
	self.replications = self.replications + 1
end
function meta:GetJobs()
	return self.jobs or {}
end
function meta:SetJobs(jobs)
	self.jobs = jobs
end
function meta:GetPlayer()
	return self.client
end
function meta:GetName()
	return self.name or "Test Stalker"
end
function meta:GetInventory()
	return self.inventory
end
function meta:GiveMoney(amount)
	self.money = self.money + amount
end
function meta:Save()
	self.saves = self.saves + 1
end
local function character()
	local char = setmetatable({ data = {}, replications = 0, saves = 0, money = 0 }, meta)
	char.inventory = { Add = addReward }
	char.client = {
		GetCharacter = function()
			return char
		end,
		GetPos = function()
			return position
		end,
		addReputation = function(_, amount)
			char.reputation = (char.reputation or 0) + amount
		end,
	}

	return char
end
local base = "gamemodes/ix_cotz/plugins/progression/"
dofile(base .. "libs/sh_storage.lua")
dofile(base .. "libs/sh_progression.lua")
dofile(base .. "libs/sh_requirements.lua")
dofile(base .. "libs/sh_expansion.lua")
dofile(base .. "libs/sh_services.lua")
dofile("gamemodes/ix_cotz/plugins/jobsystem/libs/sh_taskrewards.lua")
dofile(base .. "libs/sh_rewards.lua")
dofile("gamemodes/ix_cotz/plugins/jobsystem/libs/sv_taskrewards.lua")
dofile(base .. "libs/sv_rewards.lua")
local api = ix.progression
function api.Register(id, definition)
	definition.id = id
	api.definitions[id] = definition
end
for _, filename in ipairs({
	"requirementpools",
	"definitions",
	"technutprog",
	"cleanerprog",
	"hagglerprog",
	"muteprog",
	"oldtimerprog",
	"quarterprog",
	"spicylemonprog",
	"jittersprog",
	"eggheadprog",
	"bossprog",
	"beanstalkprog",
	"computerprog",
	"originalprog",
	"hoarderprog",
	"noosphereprog",
	"communityprog",
	"smartassprog",
	"arenaprog",
}) do
	dofile(base .. "sh_" .. filename .. ".lua")
end

local a, b = character(), character()
check(not pcall(api.GetCharacterProgression, nil), "owner is mandatory")
check(not pcall(api.GetCharacterProgression, {}), "owner must be a Helix character")
api.InitializeCharacterProgression(a)
api.InitializeCharacterProgression(b)
api.InitializeCharacterProgression(a)
check(a.replications == 2, "initialization and requirement assignment are idempotent")
check(not pcall(api.SetCharacterProgression, a, {lines = false}), "invalid record shape rejected")
local snapshot = api.GetCharacterProgression(a)
snapshot.lines.example = { value = 4 }
check(a.data.progression.lines.example == nil, "reads return snapshots")
api.SetCharacterProgression(a, snapshot)
snapshot.lines.example.value = 99
check(api.GetCharacterProgression(a).lines.example.value == 4, "writes copy snapshots")
check(b.data.progression.lines.example == nil, "storage is isolated")
local restored = character()
restored.data = copy(a.data)
api.InitializeCharacterProgression(restored)
check(
	restored.replications == 0 and api.GetLine(restored, "example").value == 4,
	"restore preserves stored state"
)

local count, complexCount, numericCount = 0, 0, 0
for id, definition in pairs(api.definitions) do
	count = count + 1
	for _, nextID in ipairs(definition.nextProgressions or {}) do
		check(api.definitions[nextID] ~= nil, id .. " references an existing successor")
	end
	a, b = character(), character()
	api.InitializeCharacterProgression(a)
	api.InitializeCharacterProgression(b)
	local requirement = api.npcRequirements[definition.keyNpc]
	if requirement then
		api.SetCompleted(a, requirement)
	end
	for _, required in ipairs(definition.prerequisites or {}) do
		api.SetCompleted(a, required)
	end
	api.SetActive(a, id, true)
	currentMap = definition.progMap
	if definition.requirementSlots then
		complexCount = complexCount + 1
		local response = definition:BuildResponse(definition.keyNpc, {}, a)
		check(type(response) == "string" and #response > 0, "delivery descriptions receive their character")
		local firstPool = api.itemPools[definition.requirementSlots[1].pool]
		if firstPool.tier ~= "fixed" then
			for item, amount in pairs(api.GetRequirements(a, id)) do
				local standard = string.find(response, amount .. " " .. ix.item.list[item].name, 1, true)
				local computer = string.find(response, ix.item.list[item].name .. " : " .. amount, 1, true)
				local pieces =
					string.find(response, amount .. " pieces of " .. ix.item.list[item].name, 1, true)
				local radio = string.find(response, ix.item.list[item].name .. ": " .. amount, 1, true)
				check(
					standard or computer or pieces or radio,
					id .. ": description matches " .. amount .. " " .. item
				)
			end
		end
		local completionCount = 0
		local original = definition.OnComplete
		definition.OnComplete = function(owner)
			completionCount = completionCount + 1
			if original then
				original(owner)
			end
		end
		check(not api.AddComplexProgressionValue(a, id, { "invalid", 1 }), "invalid requirement rejected")
		for item, amount in pairs(api.GetRequirements(a, id)) do
			check(not api.AddComplexProgressionValue(a, id, { item, -1 }), "negative contribution rejected")
			check(not api.AddComplexProgressionValue(a, id, { item, 0 / 0 }), "NaN contribution rejected")
			check(
				api.AddComplexProgressionValue(a, id, { item, amount + 100 }) == amount,
				"contribution capped at remaining requirement"
			)
		end
		check(api.IsCompleted(a, id), id .. " completes")
		check(completionCount == 1, id .. " completion callback runs once")
		for item in pairs(api.GetRequirements(a, id)) do
			check(not api.AddComplexProgressionValue(a, id, { item, 1 }), "completed line rejects repeats")
		end
		check(completionCount == 1, "repeated requests cannot replay completion")
		definition.OnComplete = original
	else
		numericCount = numericCount + 1
		local last = definition.progressthresholds[#definition.progressthresholds]
		if last > 1 then
			check(api.AddProgressionValue(a, id, last - 1), id .. " advances below personal threshold")
			check(not api.IsCompleted(a, id), id .. " waits for the final personal task")
		end
		check(api.AddProgressionValue(a, id, 1), id .. " numeric progression advances")
		check(api.IsCompleted(a, id), id .. " numeric progression completes")
		local scheduled = #timers
		api.InvokeProgression(a, id)
		check(#timers == scheduled, "threshold effects do not replay")
		check(not api.AddProgressionValue(a, id, 1), "completed numeric line rejects repeats")
		check(
			type(definition:BuildResponse(definition.keyNpc, api.GetLine(b, id))) == "string",
			"numeric response receives line state"
		)
	end
	check(not api.IsCompleted(b, id), "other character never completes")
	check(next(api.GetComplexProgressionValue(b, id)) == nil, "other character receives no contributions")
	for _, nextID in ipairs(definition.nextProgressions or {}) do
		check(api.GetLine(a, nextID).active == true, "successor activated for owner")
		check(api.GetLine(b, nextID).active ~= true, "successor not activated for others")
	end
	for _, unlock in ipairs(definition.vendorUnlocks or {}) do
		check(api.CanBuyItem(a, unlock.npc, unlock.args[1]), "owner may buy unlocked item")
		check(not api.CanBuyItem(b, unlock.npc, unlock.args[1]), "other character cannot buy unlocked item")
	end
end
check(count >= 220, "all expanded definitions exercised")

-- Use a one-unit fixture to isolate partial-stack consumption and payout checks.
local storageQuantity = api.definitions.cleanerItemDelivery_Storage.requirementSlots[1].quantity
api.definitions.cleanerItemDelivery_Storage.requirementSlots[1].quantity = 1

-- Turn-in requests must match NPC, map, inventory, remaining amount and owner.
currentMap = "rp_marsh_cs"
a, b = character(), character()
local inventoryItem = { quantity = 5 }
function inventoryItem:GetData(key, default)
	return self[key] or default
end
function inventoryItem:SetData(key, value)
	self[key] = value
end
function inventoryItem:Remove()
	self.removed = true
end
a.inventory = {
	Add = addReward,
	HasItem = function(_, id)
		if id == "artifact_bolt" and not inventoryItem.removed then
			return inventoryItem
		end
	end,
}
local target = {
	GetClass = function()
		return "ix_vendor_adv"
	end,
	GetDisplayName = function()
		return "'Cleaner'"
	end,
	GetPos = function()
		return position
	end,
	CanAccess = function()
		return true
	end,
}
check(not api.TurnIn(a.client, target, "bossItemDelivery_1", "artifact_bolt"), "wrong NPC rejected")
check(not api.TurnIn(a.client, target, "cleanerItemDelivery_Storage", "invalid"), "wrong item rejected")
currentMap = "rp_waystation"
check(not api.TurnIn(a.client, target, "cleanerItemDelivery_Storage", "artifact_bolt"), "wrong map rejected")
currentMap = "rp_marsh_cs"
local accepted, response = api.TurnIn(a.client, target, "cleanerItemDelivery_Storage", "artifact_bolt")
check(accepted, "valid turn-in accepted")
check(#lostItems == 1 and lostItems[1].client == a.client, "only accepted delivery notifies its owner")
check(lostItems[1].description == "artifact_bolt x1", "lost-item notification uses consumed quantity")
check(string.find(response, "task is complete", 1, true), "completed hand-in confirms task completion")
check(
	inventoryItem.quantity == 4 and a.money == 2 and a.reputation == 1,
	"only required amount consumed and rewarded"
)
check(
	not api.TurnIn(a.client, target, "cleanerItemDelivery_Storage", "artifact_bolt"),
	"duplicate turn-in rejected"
)
check(
	a.money == 2 and inventoryItem.quantity == 4 and not api.IsCompleted(b, "cleanerItemDelivery_Storage"),
	"duplicate requests cannot award rewards or affect others"
)
check(#lostItems == 1, "duplicate delivery sends no lost-item notification")
check(a.saves >= 2, "assignment and turn-in both save character")

-- Inventory removal can fail; never grant progress or rewards in that case.
local c = character()
c.inventory = a.inventory
inventoryItem.quantity = 1
inventoryItem.Remove = function()
	return false
end
check(
	not api.TurnIn(c.client, target, "cleanerItemDelivery_Storage", "artifact_bolt"),
	"failed item removal rejected"
)
check(
	c.money == 0 and not api.IsCompleted(c, "cleanerItemDelivery_Storage"),
	"failed removal gives no progress or rewards"
)
check(#lostItems == 1, "failed removal sends no lost-item notification")
inventoryItem.Remove = function(self)
	self.removed = true
end
check(
	api.TurnIn(c.client, target, "cleanerItemDelivery_Storage", "artifact_bolt") and inventoryItem.removed,
	"whole-stack turn-in removes inventory item"
)

api.definitions.cleanerItemDelivery_Storage.requirementSlots[1].quantity = storageQuantity

-- Completion broadcasts preserve the personalised dialogue and NPC sender.
messages = {}
a.name = "Finishing Stalker"
api.Notify(a, "NPC", "Finishing Stalker, you've earned my trust.")
check(#messages == 1 and messages[1][5] == nil, "completion message broadcast to all players")
check(messages[1][2] == "npcpdainternal", "completion broadcast uses GPDA")
check(messages[1][6].name == "NPC", "completion broadcast keeps NPC sender")
check(
	messages[1][6].message == "Finishing Stalker, you've earned my trust.",
	"completion broadcast preserves dialogue without adding a completion suffix"
)
a.client.GetCharacter = function()
	return b
end
api.Notify(a, "NPC", "late")
check(#messages == 1, "delayed message suppressed after switching characters")

-- Exercise every completion and story threshold, including delayed follow-up speakers.
local dialogueOwner = character()
dialogueOwner.name = "Stalker 100%"
local dialogueCount = 0
for id, definition in pairs(api.definitions) do
	timers, messages = {}, {}
	if definition.OnComplete then
		definition.OnComplete(dialogueOwner)
	end
	for _, callback in pairs(definition.progressfunctions or {}) do
		callback:OnRun(dialogueOwner)
	end
	local timerIndex = 1
	while timerIndex <= #timers do
		timers[timerIndex]()
		timerIndex = timerIndex + 1
	end
	for _, broadcast in ipairs(messages) do
		dialogueCount = dialogueCount + 1
		local dialogue = broadcast[6].message
		check(broadcast[5] == nil, id .. ": personalised dialogue remains global")
		check(
			string.find(dialogue, dialogueOwner:GetName(), 1, true),
			id .. ": dialogue addresses the unlocking character by name"
		)
		check(not string.find(dialogue, "PLACEHOLDER", 1, true), id .. ": completion dialogue is finished")
		check(not string.find(dialogue, "Completed by", 1, true), id .. ": dialogue has no generic suffix")
	end
end
check(dialogueCount >= 143, "all progression announcements were exercised")
timers, messages = {}, {}

-- World arrivals unlock once globally without sharing personal service access.
local worldSave
PLUGIN = { worldDataLoaded = true }
function PLUGIN:SaveData()
	worldSave = copy(self.worldUnlocks)
end
dofile(base .. "libs/sv_world.lua")
currentMap = "rp_marsh_cs"
local spawnCount, catalogCount = 0, 0
for _, definition in pairs(api.definitions) do
	if definition.worldNPC then
		ix.npctemplates.templates[definition.worldNPC.template] = { name = definition.worldNPC.template }
	end
end
ix.util.SpawnAdvVendor = function(template)
	spawnCount = spawnCount + 1
	vendors[#vendors + 1] = {
		GetDisplayName = function()
			return template
		end,
		GetBuyAll = function() return false end,
		AddItemToList = function() end,
	}
end
local catalog = {}
vendors[#vendors + 1] = {
	GetDisplayName = function()
		return "'Technut'"
	end,
	AddItemToList = function(_, item)
		if not catalog[item] then
			catalog[item] = true
			catalogCount = catalogCount + 1
		end
	end,
}
PLUGIN:SetupProgressionWorld()
check(spawnCount == 0, "NPC arrivals wait for global unlocks")
for id, definition in pairs(api.definitions) do
	if definition.worldNPC and definition.progMap == currentMap then
		api.SetCompleted(a, id)
		check(worldSave[id], "first personal completion saves global arrival")
		check(not api.IsCompleted(b, id), "global arrival does not complete another character's milestone")
		api.SetCompleted(b, id)
	end
end
local spawned, stocked = spawnCount, catalogCount
PLUGIN:SetupProgressionWorld()
check(spawned == 3 and spawnCount == spawned, "world NPCs spawned once per map")
check(stocked > 0 and catalogCount == stocked, "catalog setup is idempotent")
PLUGIN.worldUnlocks = copy(worldSave)
vendors = {}
PLUGIN:SetupProgressionWorld()
check(spawnCount == spawned + 3, "saved global arrivals restore missing NPCs")
currentMap = api.definitions.computer_artifactTasks.progMap
api.SetCompleted(a, "computer_artifactTasks")
check(spawnCount == spawned + 4, "arrival on the second map is also global")

-- Exercise every job-completion hook against the real registered line.
ix.jobs = { list = { test = { categories = {} } } }
for _, job in ipairs({
	{ "cotz/progression/old-timer-kill-intro", "oldTimerKillIntro", "'Old Timer'", "mutantkilleasy" },
	{ "cotz/progression/boss-data-tasks", "boss_dataTasks", "'Boss'", "dataextracteasy" },
	{ "cotz/progression/smartass-rf-tasks", "smartass_rfTasks", "'Smartass'", "scanRFeasy" },
	{
		"cotz/progression/computer-artifact-tasks",
		"computer_artifactTasks",
		"'Computer'",
		"artifactcollect_computer",
	},
	{
		"cotz/progression/intern-gas-analyzer-readings",
		"intern_gasAnalyzerReadings",
		"'Intern'",
		"scanareahard",
	},
}) do
	a, b = character(), character()
	local definition = api.definitions[job[2]]
	local requirement = api.npcRequirements[definition.keyNpc]
	if requirement then
		api.SetCompleted(a, requirement)
	end
	currentMap = definition.progMap
	api.SetActive(a, job[2], true)
	ix.jobs.list.test.categories = { job[4] }
	callbacks[job[1]](a.client, "wrong NPC", "test")
	check(api.GetProgressionValue(a, job[2]) == 0, "wrong job NPC ignored")
	callbacks[job[1]](a.client, job[3], "test")
	check(api.GetProgressionValue(a, job[2]) == 1, "job hook credits its character")
	check(api.GetProgressionValue(b, job[2]) == 0, "job hook does not credit others")
end

-- Global arrivals persist independently and wait for vendor loading.
ix.util.Include = function(filename)
	dofile(base .. filename)
end
local savedPluginData = {worldUnlocks = {oldTimerKillIntro = true}}
function PLUGIN:GetData()
	return savedPluginData
end
function PLUGIN:SetData(value)
	savedPluginData = value
end
local setupCalls = 0
PLUGIN.worldDataLoaded = nil
function PLUGIN:SetupProgressionWorld()
	setupCalls = setupCalls + 1
end
dofile(base .. "sh_plugin.lua")
PLUGIN:LoadData()
check(PLUGIN.worldUnlocks.oldTimerKillIntro, "saved global NPC arrival restored")
PLUGIN:Think()
check(setupCalls == 0, "world setup waits for saved vendors")
PLUGIN:PostLoadData()
check(setupCalls == 1, "world setup runs after saved vendors load")
PLUGIN:SaveData()
check(
	savedPluginData.worldUnlocks.oldTimerKillIntro,
	"world arrivals are saved"
)
check(savedPluginData.worldUnlocks.oldTimerKillIntro, "world arrival flag persists")
PLUGIN.worldUnlocks.computer_artifactTasks = true
PLUGIN:SaveData()
PLUGIN.worldUnlocks = {}
PLUGIN:LoadData()
check(PLUGIN.worldUnlocks.computer_artifactTasks, "new global arrivals survive a save/load cycle")
PLUGIN:SaveData()
a = character()
PLUGIN:PlayerLoadedCharacter(a.client, a)
check(not api.IsCompleted(a, "oldTimerKillIntro"), "global arrival does not grant personal completion")

-- Real dialogue network handlers enforce progression before invoking callbacks.
local networkHandlers, readStrings, readTarget = {}, {}, nil
util = { AddNetworkString = function() end }
net = {
	Receive = function(name, callback)
		networkHandlers[name] = callback
	end,
	ReadString = function()
		return table.remove(readStrings, 1)
	end,
	ReadEntity = function()
		return readTarget
	end,
	ReadTable = function()
		return {}
	end,
}
netstream = { Hook = function() end }
local playerMeta = {}
FindMetaTable = function()
	return playerMeta
end
ix.config = { Add = function() end }
ix.util.Include = function(filename)
	dofile("gamemodes/ix_cotz/plugins/dialogue/" .. filename)
end
dofile("gamemodes/ix_cotz/plugins/dialogue/sh_plugin.lua")
local invoked = 0
local topic = {}
for _, callback in ipairs({ "preCallback", "postCallback", "ResolveDynamicOption", "DynamicPreCallback" }) do
	topic[callback] = function()
		invoked = invoked + 1
	end
end
ix.dialogue.list = {
	owlnpc = { tree = { OpenStorage = topic, TradeTopic = topic } },
	technpc = { tree = { ConfirmPaint = topic } },
}
readTarget = {
	dialogueid = "owlnpc",
	GetClass = function()
		return "ix_vendor_adv"
	end,
	GetPos = function()
		return position
	end,
	CanAccess = function()
		return true
	end,
}
local function request(network, tree, topicID, client)
	readStrings = { tree, topicID }
	networkHandlers[network](0, client or a.client)
end
for _, network in ipairs({
	"ixPreCallback",
	"ixPostCallback",
	"ixDialogueResolveDynamic",
	"ixPreDynamicCallback",
}) do
	request(network, "owlnpc", "OpenStorage")
end
check(invoked == 0, "locked storage blocked in all network paths")
api.SetCompleted(a, "cleanerItemDelivery_Storage")
request("ixPostCallback", "owlnpc", "OpenStorage")
check(invoked == 1, "unlocked storage callback accepted")
request("ixPostCallback", "technpc", "ConfirmPaint")
check(invoked == 1, "forged dialogue tree rejected")
readTarget.dialogueid = "technpc"
request("ixPreDynamicCallback", "technpc", "ConfirmPaint")
check(invoked == 1, "locked painting callback rejected")
api.SetCompleted(a, "technutItemDelivery_SuitPainting")
request("ixPreDynamicCallback", "technpc", "ConfirmPaint")
check(invoked == 2, "unlocked painting callback accepted")
readTarget.invalid = true
request("ixPreDynamicCallback", "technpc", "ConfirmPaint")
check(invoked == 2, "invalid dialogue target rejected")
readTarget.invalid = false
readTarget.CanAccess = function()
	return false
end
request("ixPreDynamicCallback", "technpc", "ConfirmPaint")
check(invoked == 2, "NPC access restriction enforced")
readTarget.CanAccess = function()
	return true
end
position.DistToSqr = function()
	return 193 * 193
end
request("ixPreDynamicCallback", "technpc", "ConfirmPaint")
check(invoked == 2, "remote dialogue request rejected")
position.DistToSqr = function()
	return 0
end

-- Exercise real interaction methods while leaving unrelated GLua entity code unloaded.
local vendorFile = assert(io.open("gamemodes/ix_cotz/plugins/vendor_adv/entities/entities/ix_vendor_adv.lua"))
local vendorSource = vendorFile:read("*a")
vendorFile:close()
ENT = {}
local compile = loadstring or load
assert(compile(vendorSource:match("(function ENT:CanAccess.-)function ENT:GetStock")))()
assert(compile(vendorSource:match("(function ENT:Use.-)function ENT:SetDialogueID")))()
table.IsEmpty = function(value)
	return next(value) == nil
end
ix.faction = { indices = { [1] = { uniqueID = "stalker" } } }
ix.class = { list = {} }
hook.Run = function() end
isentity = IsValid
local dialogueTree
net.Start = function() end
net.WriteEntity = function() end
net.WriteString = function(value)
	dialogueTree = value
end
net.Send = function() end
local lockedCharacter = character()
local client = lockedCharacter.client
client.Team = function()
	return 1
end
client.dialogue = playerMeta.dialogue
client.Freeze = function() end
local vendor = setmetatable({
	dialogueid = "tradernpc",
	factions = {},
	classes = {},
	messages = {},
	GetClass = function()
		return "ix_vendor_adv"
	end,
	GetDisplayName = function()
		return "'Haggler'"
	end,
	GetPos = function()
		return position
	end,
}, { __index = ENT })
check(
	vendor:CanTalkTo(client) and not vendor:CanAccess(client),
	"locked character can talk but cannot use services"
)
vendor:Use(client)
check(dialogueTree == "progressionlocked", "locked interaction opens limited dialogue")
local lockedDialogue = { tree = {} }
lockedDialogue.addTopic = function(id, data)
	lockedDialogue.tree[id] = data
end
DIALOGUE = lockedDialogue
dofile("gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_progressionlocked.lua")
DIALOGUE = nil
check(#lockedDialogue.tree.GREETING.options == 2, "limited greeting offers introduction and goodbye")
for _, entry in pairs(lockedDialogue.tree) do
	check(
		not entry.preCallback and not entry.postCallback and not entry.IsDynamic,
		"limited dialogue has no service callbacks"
	)
end
readTarget = vendor
ix.dialogue.list.tradernpc = { tree = { TradeTopic = topic } }
request("ixPostCallback", "tradernpc", "TradeTopic", client)
check(invoked == 2, "locked character cannot forge full dialogue callbacks")
api.SetCompleted(lockedCharacter, "oldTimerKillIntro")
check(vendor:CanAccess(client), "personal milestone grants service access")
vendor:Use(client)
check(dialogueTree == "tradernpc", "unlocked interaction opens normal dialogue")
vendor.factions = { other = true }
check(
	not vendor:CanTalkTo(client) and not vendor:CanAccess(client),
	"faction restrictions still apply to dialogue"
)

-- Fresh requirements are assigned server-side and saved once per unlock.
math.random = function(minimum)
	return minimum
end
local first = character()
api.InitializeCharacterProgression(first)
check(not api.GetLine(first, "hagglerItemDelivery_1_stage1").requirements, "locked NPC has no assignment yet")
api.SetCompleted(first, "oldTimerKillIntro")
local firstRequirements = api.GetRequirements(first, "hagglerItemDelivery_1_stage1")
local openingQuantity = api.definitions.hagglerItemDelivery_1_stage1.requirementSlots[1].quantity
check(firstRequirements.value_nuts == openingQuantity, "opening quest assigns its paced quantity")
check(not firstRequirements.value_toiletpaper, "opening quest requests only one item type")
local savedAssignment = copy(first.data)
local savedCalls = first.saves
math.random = function(_, maximum)
	return maximum
end
api.AssignActiveRequirements(first)
local sameRequirements = api.GetRequirements(first, "hagglerItemDelivery_1_stage1")
check(
	sameRequirements.value_nuts == openingQuantity and first.saves == savedCalls,
	"reopening cannot reroll or resave assignments"
)
local second = character()
api.InitializeCharacterProgression(second)
api.SetCompleted(second, "oldTimerKillIntro")
local secondRequirements = api.GetRequirements(second, "hagglerItemDelivery_1_stage1")
check(
	secondRequirements.value_bolts == openingQuantity and not secondRequirements.value_nuts,
	"another character receives a different pool item"
)
firstRequirements.value_nuts = 999
check(
	api.GetRequirements(first, "hagglerItemDelivery_1_stage1").value_nuts == openingQuantity,
	"requirements queries return snapshots"
)
local reconnected = character()
reconnected.data = copy(savedAssignment)
api.InitializeCharacterProgression(reconnected)
check(
	api.GetRequirements(reconnected, "hagglerItemDelivery_1_stage1").value_nuts == openingQuantity,
	"reconnect preserves selected items"
)
local savedMap = currentMap
currentMap = "rp_pripyat_remaster"
check(
	api.GetRequirements(reconnected, "hagglerItemDelivery_1_stage1").value_nuts == openingQuantity,
	"map transfer cannot reroll assignments"
)
currentMap = savedMap
check(
	not api.AddComplexProgressionValue(first, "hagglerItemDelivery_1_stage1", { "value_bolts", 1 }),
	"another pool candidate is rejected unless personally assigned"
)
for _, slot in ipairs(api.definitions.hagglerItemDelivery_1_stage1.requirementSlots) do
	check(slot.quantity > 0 and slot.quantity % 1 == 0, "slot quantities are positive integers")
end
local keyCharacter = character()
api.SetActive(keyCharacter, "quarterMasterDelivery_activateItem", true)
check(
	api.GetRequirements(keyCharacter, "quarterMasterDelivery_activateItem").quest_flashdrive == 1,
	"story keys retain their exact identity and single quantity"
)
local detectorID = "eggheadItemDelivery_Detector3"
local selectionRandom = math.random
for roll = 1, 2 do
	math.random = function(minimum, maximum)
		return roll == 1 and minimum or maximum
	end
	local researcher = character()
	api.InitializeCharacterProgression(researcher)
	api.SetCompleted(researcher, api.npcRequirements[api.definitions[detectorID].keyNpc])
	api.SetActive(researcher, detectorID, true)
	local requirements = api.GetRequirements(researcher, detectorID)
	local line = api.GetLine(researcher, detectorID)
	local specimenCount = 0
	for _, amount in pairs(requirements) do
		specimenCount = specimenCount + 1
		check(amount >= 1, "hard detector requests positive specimen quantities")
	end
	check(specimenCount == 6 and #line.selections == 6, "final detector trial retains all six anomaly families")
	for index, selection in ipairs(line.selections) do
		local quantity = api.definitions[detectorID].requirementSlots[index].quantity
		check(requirements[selection.item] == quantity, "saved detector categories match assigned specimens")
	end
end
math.random = selectionRandom
local auditedDefinitions, auditedContacts = api.AuditDefinitions()
check(auditedDefinitions == 227 and auditedContacts == 19, "full runtime graph audit covers all contacts")
local originalPrerequisites = api.definitions.originalSurvival1.prerequisites
api.definitions.originalSurvival1.prerequisites = {"originalSurvival1"}
check(not pcall(api.AuditDefinitions), "runtime audit rejects prerequisite cycles")
api.definitions.originalSurvival1.prerequisites = originalPrerequisites
local invalidPool = api.itemPools.fasteners
api.itemPools.fasteners = nil
check(not pcall(api.ValidateRequirementPools), "invalid pool definitions fail validation")
api.itemPools.fasteners = invalidPool

-- Check the real dialogue producer, visible description, UI selection and server consumer together.
SERVER = false
dofile("gamemodes/ix_cotz/plugins/dialogue/libs/sh_dialogue.lua")
SERVER = true
local dialogue = { tree = {} }
dialogue.addTopic = function(id, data)
	dialogue.tree[id] = data
end
DIALOGUE = dialogue
dofile("gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_medicnpc.lua")
DIALOGUE = nil
local patient = character()
math.random = function(minimum)
	return minimum
end
api.InitializeCharacterProgression(patient)
local chosenItem, chosenAmount = next(api.GetRequirements(patient, "jittersItemDelivery_medical1_stage1"))
local stack = { quantity = chosenAmount + 1 }
function stack:GetData(key, default)
	return self[key] or default
end
function stack:SetData(key, value)
	self[key] = value
end
patient.inventory = {
	Add = addReward,
	HasItem = function(_, id)
		return id == chosenItem and stack or nil
	end,
}
local medic = {
	dialogueid = "medicnpc",
	GetClass = function()
		return "ix_vendor_adv"
	end,
	GetDisplayName = function()
		return "'Jitters'"
	end,
	GetPos = function()
		return position
	end,
	CanAccess = function()
		return true
	end,
}
CLIENT = true
local view = dialogue.tree.ViewProgression
view:DynamicPreCallback(patient.client, medic, { identifier = "jittersItemDelivery_medical1_stage1" })
check(
	string.find(view.response, chosenAmount .. " " .. chosenItem, 1, true),
	"dialogue describes actual personal quantities"
)
local options = view:GetDynamicOptions(patient.client, medic)
check(
	#options == 1
		and options[1].dyndata.progid == "jittersItemDelivery_medical1_stage1"
		and options[1].dyndata.itemid == chosenItem,
	"dialogue options use the established payload contract"
)
local panelType
vgui = {
	Register = function(_, panel)
		panelType = panel
	end,
}
ix.util.GetMaterial = function() end
net.WriteTable = function() end
net.SendToServer = function() end
dofile("gamemodes/ix_cotz/plugins/dialogue/derma/cl_dialogue.lua")
local pickedTopic, pickedData
local panel = setmetatable({
	target = medic,
	treeID = "medicnpc",
	tree = dialogue.tree,
	options = {
		Add = function()
			return {
				Dock = function() end,
				DockMargin = function() end,
				SetText = function() end,
				SetTextColor = function() end,
				SetFont = function() end,
				SetMouseInputEnabled = function() end,
				SetWrap = function() end, SetAutoStretchVertical = function() end,
			}
		end,
	},
	startTopic = function(_, id, data)
		pickedTopic, pickedData = id, data
	end,
}, { __index = panelType })
LocalPlayer = function()
	return patient.client
end
Color = function()
	return {}
end
panel:prepareDynamicOptions(options, {})
panel.buttonList[1].DoClick()
check(
	pickedTopic == "HandInComplexProgressionItemTopic" and pickedData.itemid == chosenItem,
	"real UI forwards the selected payload to the hand-in topic"
)
dialogue.tree[pickedTopic]:DynamicPreCallback(patient.client, medic, pickedData)
check(dialogue.tree[pickedTopic].waitForProgressionResponse, "client waits for authoritative hand-in response")
CLIENT = false
dialogue.tree[pickedTopic]:DynamicPreCallback(patient.client, medic, pickedData)
check(string.find(dialogueTree, chosenItem, 1, true), "server sends accepted item in dialogue response")
local deliveredResponse
ix.gui = { dialogue = panel }
ix.config.Get = function() end
panel.dialogue = function(_, _, text)
	deliveredResponse = text
end
readTarget = medic
readStrings = { dialogueTree }
networkHandlers["cotz/dialogue/progression-response"]()
check(deliveredResponse == dialogueTree, "client renders server-confirmed hand-in response")
readTarget = target
readStrings = { "stale response" }
networkHandlers["cotz/dialogue/progression-response"]()
check(deliveredResponse == dialogueTree, "response for another NPC does not enter the dialogue")
check(
	stack.quantity == 1
		and api.GetComplexProgressionValue(patient, pickedData.progid)[chosenItem] == chosenAmount,
	"real server consumer accepts only the assigned remaining quantity"
)

local notificationsBeforeRetry = #lostItems
dialogue.tree[pickedTopic]:DynamicPreCallback(patient.client, medic, pickedData)
check(string.find(dialogueTree, "couldn't accept", 1, true), "rejected delivery returns an honest NPC response")
check(#lostItems == notificationsBeforeRetry, "rejected dialogue retry shows no lost-item icon")

-- The real reward helper prices the consumed fraction, not the whole remaining stack.
local rewardFile = assert(io.open("gamemodes/ix_cotz/schema/libs/sh_fverneutils.lua"))
local rewardSource = rewardFile:read("*a")
rewardFile:close()
math.Round = function(value)
	return math.floor(value + 0.5)
end
assert(compile(rewardSource:sub(1, assert(rewardSource:find("-- Performs", 1, true)) - 1)))()
local pricedStack = {
	quantity = 10,
	price = 100,
	GetData = function()
		return 10
	end,
	GetPrice = function()
		return 100
	end,
}
local _, partialMoney = ix.util.GetValueFromProgressionTurnin(pricedStack, 2)
local _, fullMoney = ix.util.GetValueFromProgressionTurnin(pricedStack, 10)
check(partialMoney == 13 and fullMoney == 65, "progression cash is sixty-five percent of consumed value")
local fullReputation = ix.util.GetValueFromProgressionTurnin(pricedStack, 10)
check(math.abs(fullReputation - 2 * (5 + 10 ^ 0.25)) < 0.000001, "reputation credit is doubled")
check(_G.value == nil, "reward calculation does not leak global mutable state")

-- Rounding credits accumulate across requests, so splitting a stack cannot multiply rewards.
api.itemPools.reward_test = { candidates = { { item = "reward_test" } } }
api.Register("reward_test", {
	keyNpc = "Tester",
	progMap = currentMap,
	defaultActive = true,
	requirementSlots = { { pool = "reward_test", quantity = 10 } },
})
local function rewardCharacter(useAmmoDefault)
	local owner = character()
	local inventoryStack
	owner.inventory = {
		Add = addReward,
		HasItem = function()
			return inventoryStack
		end,
	}
	local function supply(amount)
		inventoryStack = { quantity = 10, price = 1, remaining = amount }
		if useAmmoDefault then
			inventoryStack.quantity = nil
			inventoryStack.ammoAmount = 10
		end
		function inventoryStack:GetData()
			return useAmmoDefault and self.ammoAmount or self.remaining
		end
		function inventoryStack:GetPrice()
			local maximum = self.quantity or self.ammoAmount

			return math.Round(self.price * self:GetData("quantity", maximum) / maximum)
		end
		function inventoryStack:Remove()
			return true
		end
	end

	return owner, supply
end
local bulk, supplyBulk = rewardCharacter()
local split, supplySplit = rewardCharacter()
local rewardNPC = {
	GetClass = function()
		return "ix_vendor_adv"
	end,
	GetDisplayName = function()
		return "Tester"
	end,
	GetPos = function()
		return position
	end,
	CanAccess = function()
		return true
	end,
}
supplyBulk(10)
check(api.TurnIn(bulk.client, rewardNPC, "reward_test", "reward_test"), "whole reward stack accepted")
for _ = 1, 10 do
	supplySplit(1)
	check(api.TurnIn(split.client, rewardNPC, "reward_test", "reward_test"), "split reward stack accepted")
	if not api.IsCompleted(split, "reward_test") then
		check(split.money == 0 and not split.reputation, "partial deliveries pay no currency or reputation")
		check(not split.inventory.rewards, "partial deliveries give no item rewards")
	end
end
check(
	bulk.money == split.money and bulk.reputation == split.reputation,
	"splitting the same quantity cannot multiply currency or reputation"
)
check(
	not api.TurnIn(split.client, rewardNPC, "reward_test", "reward_test"),
	"completed reward ledger rejects repeats"
)
check(bulk.money == 1 and bulk.reputation == 11, "completion rounds cash up once and preserves reputation")
check(not bulk.inventory.rewards, "singleton pools give money instead of items")
local ammoOwner, supplyAmmo = rewardCharacter(true)
supplyAmmo(10)
check(api.TurnIn(ammoOwner.client, rewardNPC, "reward_test", "reward_test"), "ammo default stack accepted")
check(api.IsCompleted(ammoOwner, "reward_test"), "ammo without quantity data contributes the full ammoAmount")
local moneyBeforeRepeat = split.money
api.PayCompletionRewards(split, "reward_test")
check(
	split.money == moneyBeforeRepeat and not split.inventory.rewards,
	"repeated completion cannot pay the singleton bonus twice"
)

-- Progression completion pays its money and reputation without a selectable supply bonus.
ix.item.list.drug_cigarette_3 = { name = "Star", quantity = 10, price = 100 }
ix.item.list.drug_cigarette_4 = { name = "Spark", quantity = 10, price = 100 }
ix.item.list.drug_cigarette_5 = { name = "Lucky Strike", quantity = 20, price = 200 }
ix.item.list.drug_cigarette_6 = { name = "Marlboro", quantity = 20, price = 200 }
local completionCalls = 0
api.Register("reward_groups", {
	keyNpc = "Tester",
	progMap = currentMap,
	defaultActive = true,
	requirementSlots = {
		{ pool = "cigarettes", quantity = 12 },
		{ pool = "premium_cigarettes", quantity = 3 },
	},
	OnComplete = function()
		completionCalls = completionCalls + 1
	end,
})
local groupOwner = character()
local stocks = {}
local function installInventory(owner)
	owner.inventory = {
		Add = addReward,
		HasItem = function(_, itemID)
			return stocks[itemID]
		end,
	}
end
local function supplyItem(itemID, quantity)
	local stock = setmetatable({ remaining = quantity }, { __index = ix.item.list[itemID] })
	function stock:GetData(_, default)
		return self.remaining or default
	end
	function stock:SetData(_, value)
		self.remaining = value
	end
	function stock:Remove()
		stocks[itemID] = nil
	end
	stocks[itemID] = stock
end
installInventory(groupOwner)
supplyItem("drug_cigarette_3", 10)
accepted, response = api.TurnIn(groupOwner.client, rewardNPC, "reward_groups", "drug_cigarette_3")
check(accepted, "first stack accepted")
check(string.find(response, "I still need 2 more", 1, true), "partial delivery reports remaining units")
check(groupOwner.money == 0 and not groupOwner.reputation, "unfinished group task pays nothing")
local reloadedOwner = character()
reloadedOwner.data = copy(groupOwner.data)
groupOwner = reloadedOwner
installInventory(groupOwner)
api.InitializeCharacterProgression(groupOwner)
supplyItem("drug_cigarette_3", 10)
accepted, response = api.TurnIn(groupOwner.client, rewardNPC, "reward_groups", "drug_cigarette_3")
check(accepted, "restored credit accepts remainder")
check(string.find(response, "other supplies", 1, true), "fulfilled item explains other requirements remain")
check(stocks.drug_cigarette_3.remaining == 8, "excess units remain in the submitted stack")
check(groupOwner.money == 0 and not groupOwner.inventory.rewards, "fulfilling one group pays nothing")
supplyItem("drug_cigarette_5", 3)
check(api.TurnIn(groupOwner.client, rewardNPC, "reward_groups", "drug_cigarette_5"), "last group completes task")
check(groupOwner.money == 98, "completion pays sixty-five percent of all 150 currency of consumed items")
local expectedReputation = math.floor(2 * (5 + 10 ^ 0.25) * (12 / 10 + 3 / 20) + 0.5)
check(groupOwner.reputation == expectedReputation, "completion sums doubled reputation from every group")
check(not (groupOwner:GetData("taskRewardOffers", {}) or {})["progression:reward_groups"],
	"progression completion does not create a supply offer")
check(not groupOwner.inventory.rewards, "progression pays currency and reputation without selectable supplies")
check(not ix.taskRewards.SelectOffer(groupOwner, "Tester", "progression:reward_groups", 1),
	"progression supply selection is unavailable")
check(completionCalls == 1, "completion callback runs once alongside the rewards")
local completedRestore = character()
completedRestore.data = copy(groupOwner.data)
api.PayCompletionRewards(completedRestore, "reward_groups")
check(completedRestore.money == 0 and not completedRestore.inventory.rewards, "save/load cannot replay rewards")

-- Only singleton groups add extra currency in a task with mixed group sizes.
ix.item.list.reward_test = { name = "Singleton", price = 100 }
api.Register("reward_mixed", {
	keyNpc = "Tester",
	progMap = currentMap,
	defaultActive = true,
	requirementSlots = {
		{ pool = "cigarettes", quantity = 2 },
		{ pool = "reward_test", quantity = 2 },
	},
})
local mixedOwner = character()
installInventory(mixedOwner)
supplyItem("reward_test", 1)
check(api.TurnIn(mixedOwner.client, rewardNPC, "reward_mixed", "reward_test"), "partial singleton accepted")
check(mixedOwner.money == 0 and not mixedOwner.inventory.rewards, "singleton bonus waits for completion")
local mixedReload = character()
mixedReload.data = copy(mixedOwner.data)
mixedOwner = mixedReload
installInventory(mixedOwner)
supplyItem("reward_test", 1)
check(api.TurnIn(mixedOwner.client, rewardNPC, "reward_mixed", "reward_test"), "restored singleton accepted")
supplyItem("drug_cigarette_3", 2)
check(api.TurnIn(mixedOwner.client, rewardNPC, "reward_mixed", "drug_cigarette_3"), "mixed task completes")
check(mixedOwner.money == 143, "singleton and alternative pools use the same sixty-five percent cash rate")
check(not ix.taskRewards.SelectOffer(mixedOwner, "Tester", "progression:reward_mixed", 1),
	"mixed task has no selectable supply reward")
check(not mixedOwner.inventory.rewards, "mixed task retains only its money and reputation payout")
api.definitions.reward_mixed = nil

-- Overflow remains a durable claim; no alternative is rerolled or dropped into the world.
local overflow = character()
overflow.inventory.Add = function() return false end
ix.taskRewards.CreateOffer(overflow, "overflow", "Tester", 35, "Overflow")
ix.taskRewards.SelectOffer(overflow, "Tester", "overflow", 1)
ix.taskRewards.EarnOffer(overflow, "overflow")
local pending = api.GetLine(overflow, "taskRewardClaims").pendingRewards
check(#pending == 1 and pending[1].data.quantity == 35, "full inventory preserves the exact selected reward")
check(not ix.taskRewards.ClaimNext(overflow), "full inventory cannot acknowledge an undelivered reward")
overflow.inventory.Add = addReward
check(ix.taskRewards.ClaimNext(overflow), "queued reward can be claimed after making space")
check(#overflow.inventory.rewards == 1, "retry delivers once")

api.definitions.reward_groups = nil
api.definitions.reward_test = nil
api.itemPools.reward_test = nil
check(
	api.GetNeededItems(first).value_nuts and not api.GetNeededItems(first).value_bolts,
	"inventory highlights contain personally assigned items only"
)
check(
	api.GetComplexProgressionValue(patient, "jittersItemDelivery_medical1_stage1")[chosenItem] == chosenAmount,
	"completed-stage credit is retained even when the next stage needs the same item"
)

-- Capacity rank is the greatest applicable reward, never the sum of alternative branches.
local supplyOwner = character()
api.SetCompleted(supplyOwner, "oldTimerKillIntro")
api.SetCompleted(supplyOwner, "hagglerItemDelivery_11")
check(api.GetStockBonus(supplyOwner, "'Haggler'", "12gauge") == 1, "first supply milestone adds one")
api.SetCompleted(supplyOwner, "hagglerItemDelivery_1211")
api.SetCompleted(supplyOwner, "hagglerItemDelivery_22111")
check(api.GetStockBonus(supplyOwner, "'Haggler'", "12gauge") == 2, "alternative second ranks do not stack")
check(api.GetStockBonus(supplyOwner, "'Haggler'", "akm") == 0, "guns receive no capacity benefit")
check(api.GetStockBonus(supplyOwner, "'Quartermaster'", "12gauge") == 0, "capacity belongs to its issuing NPC")
local soldier = character()
api.SetCompleted(soldier, "quarterMasterDelivery_activateItem")
check(api.IsActive(soldier, "quartermasterItemDelivery_1_stage1"), "flashdrive enables military progression")
check(not api.IsCompleted(soldier, "hagglerItemDelivery_1211"), "military access requires no Haggler milestone")
local scientist = character()
check(not api.IsActive(scientist, "eggheadItemDelivery_Detector1"), "scientists unavailable before map-2 story")
api.SetActive(scientist, "smartass_rfTasks", true)
currentMap = "rp_waystation"
api.AddProgressionValue(scientist, "smartass_rfTasks", 1)
check(api.GetLine(scientist, "smartass_rfTasks").benefitsClaimed["checkpoint:1"],
	"first RF checkpoint records its supply claim")
check(not api.CompleteCheckpoint(scientist, "smartass_rfTasks", 1), "checkpoint supplies cannot replay")
check(not api.CanBuyItem(scientist, "'Smartass'", "pso1"), "optic requires the third RF job")
api.AddProgressionValue(scientist, "smartass_rfTasks", 2)
check(api.CanBuyItem(scientist, "'Smartass'", "pso1"), "third RF job grants basic optic access")
check(not api.CanUseNPC(scientist, "'Egghead'"), "RF preparation cannot unlock scientists early")
api.AddProgressionValue(scientist, "smartass_rfTasks", 2)
check(api.CanUseNPC(scientist, "'Egghead'"), "scientists unlock at original final RF count")
currentMap = "rp_marsh_cs"

-- Helix reserves slots before its database callback; claims remain pending until confirmation.
local asyncOwner = character()
api.QueueReward(asyncOwner, "arenaProgramme1", {item = "medic_medkit_1"})
local reservedData
asyncOwner.inventory = {
	owner = 4242,
	Add = function(_, _, _, data) reservedData = data return 3 end,
}
check(api.ClaimRewards(asyncOwner, "arenaProgramme1"), "asynchronous inventory slot reserved")
check(api.GetLine(asyncOwner, "arenaProgramme1").claiming, "in-flight reward blocks re-entry")
check(#api.GetLine(asyncOwner, "arenaProgramme1").pendingRewards == 1,
	"slot reservation alone does not erase durable pending reward")
check(not api.ClaimRewards(asyncOwner, "arenaProgramme1"), "duplicate in-flight claim rejected")
local interruptedClaim = copy(asyncOwner.data)
local insertedItem = {GetData = function(_, key) return reservedData[key] end}
ix.char = {loaded = {[4242] = asyncOwner}}
callbacks["cotz/progression/confirm-reward"](nil, asyncOwner.inventory, insertedItem)
check(#api.GetLine(asyncOwner, "arenaProgramme1").pendingRewards == 0, "database insertion confirms delivery")
local claimRestored = character()
claimRestored.data = interruptedClaim
local attemptedDuplicate = 0
claimRestored.inventory = {
	GetItems = function() return {insertedItem} end,
	Add = function() attemptedDuplicate = attemptedDuplicate + 1 return true end,
}
api.InitializeCharacterProgression(claimRestored)
check(api.ClaimRewards(claimRestored, "arenaProgramme1"), "restored claim recognizes already inserted item")
check(attemptedDuplicate == 0, "restart between item insertion and acknowledgement cannot duplicate reward")
ix.char = nil

-- Match participation is optional progression and repeated opponents cannot farm it.
local contender, opponent = character(), character()
contender.client.SteamID64 = function() return "100" end
contender.client.IsBot = function() return false end
opponent.client.SteamID64 = function() return "200" end
opponent.client.IsBot = function() return false end
callbacks["cotz/progression/arena-programme"](contender.client, opponent.client)
check(api.IsCompleted(contender, "arenaProgramme1"), "authoritative arena match advances programme")
callbacks["cotz/progression/arena-programme"](contender.client, opponent.client)
check(not api.IsCompleted(contender, "arenaProgramme2"), "same opponent cannot advance another arena rank")

-- Split stages share rounding and one final alternative-item payout.
ix.item.list.medic_bandage_1 = {name = "Bandage", price = 100, quantity = 10}
for _, candidate in ipairs(api.itemPools.tobacco.candidates) do
	ix.item.list[candidate.item] = {name = candidate.item, price = 100, quantity = 10}
end
local programmeOwner = character()
local programmeID = "jittersItemDelivery_medical1"
local programmeFirst = programmeID .. "_stage1"
local programmeItem, firstCount = next(api.GetRequirements(programmeOwner, programmeFirst))
local programmeStack
programmeOwner.inventory = {
	Add = addReward,
	HasItem = function(_, id) return id == programmeItem and programmeStack or nil end,
}
local function programmeSupply(amount)
	programmeStack = {quantity = 10, price = 100, remaining = amount}
	function programmeStack:GetData(key, default)
		if key == "quantity" then return self.remaining end

		return default
	end
	function programmeStack:GetPrice() return 100 * self:GetData("quantity", 10) / 10 end
	function programmeStack:Remove() programmeStack = nil end
end
local programmeNPC = {
	GetClass = function() return "ix_vendor_adv" end,
	GetDisplayName = function() return "'Jitters'" end,
	GetPos = function() return position end,
	CanAccess = function() return true end,
}
programmeSupply(firstCount)
check(api.TurnIn(programmeOwner.client, programmeNPC, programmeFirst, programmeItem), "programme preparation accepted")
check(not programmeOwner.inventory.rewards, "preparation cannot multiply the minimum-one item reward")
local finalItem, finalCount = next(api.GetRequirements(programmeOwner, programmeID))
check(finalItem == programmeItem, "split stages retain the same personal pool selection")
programmeSupply(finalCount)
check(api.TurnIn(programmeOwner.client, programmeNPC, programmeID, programmeItem), "programme final stage accepted")
local totalUnits = firstCount + finalCount
local expectedReputation = math.floor(2 * (5 + 10 ^ 0.25) * totalUnits / 10 + 0.5)
check(programmeOwner.reputation == expectedReputation, "programme reputation rounds its cumulative credit")
check(programmeOwner.money == math.ceil(6.5 * totalUnits), "programme cash uses cumulative hand-ins at the new premium")
check(not (programmeOwner:GetData("taskRewardOffers", {}) or {})["progression:" .. programmeID],
	"multi-stage progression does not create selectable rewards")
check(not programmeOwner.inventory.rewards, "programme completion pays money and reputation only")
local previousMoney = programmeOwner.money
local previousReputation = programmeOwner.reputation
api.PayCompletionRewards(programmeOwner, programmeID)
check(programmeOwner.money == previousMoney and programmeOwner.reputation == previousReputation,
	"final payout cannot be replayed")

-- A themed commission pays its stated supplies and the ordinary consumed-value cash once.
local newcomer = character()
local provisionID, provisionCount = next(api.GetRequirements(newcomer, "originalSurvival1"))
local provisions = {quantity = 10, price = 100}
function provisions:GetData(key, default)
	return key == "quantity" and provisionCount or default
end
function provisions:GetPrice() return self:GetData("quantity", 10) * 10 end
function provisions:Remove() self.removed = true end
newcomer.inventory.HasItem = function(_, id)
	return id == provisionID and not provisions.removed and provisions or nil
end
local originalNPC = {
	GetClass = function() return "ix_vendor_adv" end,
	GetDisplayName = function() return "'The Original'" end,
	GetPos = function() return position end,
	CanAccess = function() return true end,
}
check(api.TurnIn(newcomer.client, originalNPC, "originalSurvival1", provisionID),
	"newcomer commission completes through the real hand-in path")
check(newcomer.money == math.ceil(provisionCount * 6.5), "fixed commissions receive the same sixty-five percent cash rate")
check(#newcomer.inventory.rewards == 1
	and #api.GetLine(newcomer, "originalSurvival1").pendingRewards == 1,
	"commission retains the second advertised supply as a durable pending claim")
check(api.ClaimRewards(newcomer, "originalSurvival1"), "second commission supply can be claimed")
check(#newcomer.inventory.rewards == 2, "commission replaces the random pool bonus with two stated supplies")
check(newcomer.inventory.rewards[1].item == "food_can_tushonka"
	and newcomer.inventory.rewards[2].item == "drink_bottlewater", "commission grants exactly its advertised supplies")
api.PayCompletionRewards(newcomer, "originalSurvival1")
check(#newcomer.inventory.rewards == 2 and newcomer.money == math.ceil(provisionCount * 6.5),
	"fixed commission cash and supplies cannot be replayed")
local intelligenceWorker = character()
api.SetActive(intelligenceWorker, "boss_dataTasks", true)
currentMap = "rp_waystation"
api.AddProgressionValue(intelligenceWorker, "boss_dataTasks", 1)
check(api.GetServiceCredit(intelligenceWorker, "'Technut'", "repair") == 500,
	"first Boss job grants the advertised repair credit")
check(not api.CompleteCheckpoint(intelligenceWorker, "boss_dataTasks", 1)
	and api.GetServiceCredit(intelligenceWorker, "'Technut'", "repair") == 500,
	"natural checkpoint credits remain one-time")
currentMap = "rp_marsh_cs"

-- Split dialogue reveals current requirements, and the next stage activates without a timer.
local clubber = character()
api.InitializeCharacterProgression(clubber)
local clubbingFirst, clubbingFinal = "oldtimerItemDelivery_Melee_stage1", "oldtimerItemDelivery_Melee"
local clubbingDefinition = api.definitions[clubbingFirst]
check(api.IsActive(clubber, clubbingFirst) and not api.IsActive(clubber, clubbingFinal),
	"Clubbing starts with only part one active")
local clubbingRecord = api.GetCharacterProgression(clubber)
local savedFinalRequirements = copy(clubbingRecord.lines[clubbingFinal].requirements)
clubbingRecord.lines[clubbingFinal].requirements = {future_stage_secret = 99}
ix.item.list.future_stage_secret = {name = "FUTURE_REQUIREMENT_MARKER"}
api.SetCharacterProgression(clubber, clubbingRecord)
local clubbingText = api.DescribeTask(clubbingDefinition, "'Old Timer'", {}, clubber)
check(not clubbingText:find("FUTURE_REQUIREMENT_MARKER", 1, true)
	and not clubbingText:find("Later stages", 1, true), "split descriptions do not disclose future-stage requirements")
local clubbingItem, clubbingCount = next(api.GetRequirements(clubber, clubbingFirst))
check(clubbingText:find(ix.item.list[clubbingItem].name, 1, true), "current stage requirements remain visible")
clubbingRecord = api.GetCharacterProgression(clubber)
clubbingRecord.lines[clubbingFinal].requirements = savedFinalRequirements
api.SetCharacterProgression(clubber, clubbingRecord)
local clubbingStack = {quantity = clubbingCount, price = 100}
function clubbingStack:GetData(_, default) return default end
function clubbingStack:Remove() self.removed = true end
clubber.inventory.HasItem = function(_, id)
	return id == clubbingItem and not clubbingStack.removed and clubbingStack or nil
end
local clubbingNPC = {GetClass = function() return "ix_vendor_adv" end,
	GetDisplayName = function() return "'Old Timer'" end,
	GetPos = function() return position end, CanAccess = function() return true end}
check(api.TurnIn(clubber.client, clubbingNPC, clubbingFirst, clubbingItem), "Clubbing part one completes by hand-in")
check(api.IsActive(clubber, clubbingFinal) and not api.IsActive(clubber, clubbingFirst),
	"Clubbing part two activates immediately after part one, without running timers")
local visibleClubbing = {}
for _, id in ipairs(api.GetActiveProgressions(clubber, "'Old Timer'")) do visibleClubbing[id] = true end
check(visibleClubbing[clubbingFinal] and not visibleClubbing[clubbingFirst],
	"reopening Old Timer's progression list replaces completed part one with part two")
check(api.definitions[clubbingFinal].name == "Clubbing - 2/2", "Clubbing's final stage is explicitly labelled part two")

-- Client API permits snapshots but does not expose mutation functions.
ix.progression = nil
SERVER = false
CLIENT = true
dofile(base .. "libs/sh_storage.lua")
dofile(base .. "libs/sh_progression.lua")
dofile(base .. "libs/sh_requirements.lua")
dofile(base .. "libs/sh_expansion.lua")
dofile(base .. "libs/sh_services.lua")
check(
	ix.progression.SetCharacterProgression == nil
		and ix.progression.SetCompleted == nil
		and ix.progression.AssignActiveRequirements == nil,
	"client has no mutation API"
)
ix.progression.definitions = api.definitions
check(
	ix.progression.GetRequirements(first, "hagglerItemDelivery_1_stage1").value_nuts == openingQuantity,
	"client reads saved personal requirements"
)
check(ix.progression.GetLine(a, "cleanerItemDelivery_Storage").completed, "client reads character-owned data")
print(
	string.format(
		"PASS: %d checks; %d definitions (%d delivery, %d numeric)",
		checks,
		count,
		complexCount,
		numericCount
	)
)
