-- Run from the addon root with Lua 5.1+ or: luatex --luaonly tests/progression_spec.lua
-- Uses the real progression library/definitions with small GMod/Helix stand-ins.
local function copy(value)
	if type(value) ~= "table" then return value end
	local result = {}
	for key, entry in pairs(value) do result[key] = copy(entry) end
	return result
end
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end
SERVER = true
CLIENT = false
istable = function(value) return type(value) == "table" end
isnumber = function(value) return type(value) == "number" end
isfunction = function(value) return type(value) == "function" end
tobool = function(value) return value == true or value == 1 end
IsValid = function(value) return type(value) == "table" and not value.invalid end
Vector = function(x, y, z) return {x = x, y = y, z = z} end
Angle = Vector
unpack = unpack or table.unpack
table.Copy = copy
local timers, messages, callbacks, currentMap = {}, {}, {}, "rp_marsh_cs"
timer = {Simple = function(delay, callback) timers[#timers + 1] = callback end}
hook = {Add = function(event, id, callback) callbacks[id] = callback end}
game = {GetMap = function() return currentMap end}
local position = {DistToSqr = function() return 0 end}
local vendors = {}
ents = {FindByClass = function() return vendors end}
ix = {
	meta = {character = {}}, progression = {definitions = {}},
	chat = {Send = function(...) messages[#messages + 1] = {...} end},
	item = {list = setmetatable({}, {__index = function(_, key) return {name = key} end})},
	util = {GetValueFromProgressionTurnin = function(item, amount) return amount, amount * 2 end},
	dialogue = {notifyReputationReceive = function() end, notifyMoneyReceive = function() end},
	command = {Add = function() end}, type = {character = 1, string = 2},
	npctemplates = {templates = {}}
}
local meta = ix.meta.character
meta.__index = meta
function meta:GetData(key) return self.data[key] end
function meta:SetData(key, value) self.data[key] = value self.replications = self.replications + 1 end
function meta:GetPlayer() return self.client end
function meta:GetInventory() return self.inventory end
function meta:GiveMoney(amount) self.money = self.money + amount end
function meta:Save() self.saves = self.saves + 1 end
local function character()
	local char = setmetatable({data = {}, replications = 0, saves = 0, money = 0}, meta)
	char.client = {
		GetCharacter = function() return char end,
		GetPos = function() return position end,
		addReputation = function(_, amount) char.reputation = (char.reputation or 0) + amount end
	}
	return char
end
local base = "gamemodes/ix_cotz/plugins/progression/"
dofile(base.."libs/sh_storage.lua")
dofile(base.."libs/sh_progression.lua")
local api = ix.progression
function api.Register(id, definition) api.definitions[id] = definition end
for _, filename in ipairs({"definitions", "technutprog", "cleanerprog", "hagglerprog", "muteprog", "oldtimerprog", "quarterprog", "spicylemonprog", "jittersprog", "eggheadprog", "bossprog"}) do
	dofile(base.."sh_"..filename..".lua")
end

local a, b = character(), character()
check(not pcall(api.GetCharacterProgression, nil), "owner is mandatory")
check(not pcall(api.GetCharacterProgression, {}), "owner must be a Helix character")
api.InitializeCharacterProgression(a)
api.InitializeCharacterProgression(b)
api.InitializeCharacterProgression(a)
check(a.replications == 1, "initialization is idempotent")
check(not pcall(api.SetCharacterProgression, a, {version = 99, lines = {}}), "unknown versions rejected")
local snapshot = api.GetCharacterProgression(a)
snapshot.lines.example = {value = 4}
check(a.data.progression.lines.example == nil, "reads return snapshots")
api.SetCharacterProgression(a, snapshot)
snapshot.lines.example.value = 99
check(api.GetCharacterProgression(a).lines.example.value == 4, "writes copy snapshots")
check(next(b.data.progression.lines) == nil, "storage is isolated")
local restored = character()
restored.data = copy(a.data)
api.InitializeCharacterProgression(restored)
check(restored.replications == 0 and api.GetLine(restored, "example").value == 4, "restore preserves stored state")

local count, complexCount, numericCount = 0, 0, 0
for id, definition in pairs(api.definitions) do
	count = count + 1
	for _, nextID in ipairs(definition.nextProgressions or {}) do
		check(api.definitions[nextID] ~= nil, id.." references an existing successor")
	end
	a, b = character(), character()
	api.InitializeCharacterProgression(a)
	api.InitializeCharacterProgression(b)
	local requirement = api.npcRequirements[definition.keyNpc]
	if requirement then api.SetCompleted(a, requirement) end
	api.SetActive(a, id, true)
	currentMap = definition.progMap
	if definition.GetItemIds then
		complexCount = complexCount + 1
		local completionCount = 0
		local original = definition.OnComplete
		definition.OnComplete = function(owner)
			completionCount = completionCount + 1
			if original then original(owner) end
		end
		check(not api.AddComplexProgressionValue(a, id, {"invalid", 1}), "invalid requirement rejected")
		for item, amount in pairs(definition:GetItemIds()) do
			check(not api.AddComplexProgressionValue(a, id, {item, -1}), "negative contribution rejected")
			check(not api.AddComplexProgressionValue(a, id, {item, 0/0}), "NaN contribution rejected")
			check(api.AddComplexProgressionValue(a, id, {item, amount + 100}) == amount, "contribution capped at remaining requirement")
		end
		check(api.IsCompleted(a, id), id.." completes")
		check(completionCount == 1, id.." completion callback runs once")
		for item in pairs(definition:GetItemIds()) do
			check(not api.AddComplexProgressionValue(a, id, {item, 1}), "completed line rejects repeats")
		end
		check(completionCount == 1, "repeated requests cannot replay completion")
		definition.OnComplete = original
	else
		numericCount = numericCount + 1
		local last = definition.progressthresholds[#definition.progressthresholds]
		check(api.AddProgressionValue(a, id, last), id.." numeric progression advances")
		check(api.IsCompleted(a, id), id.." numeric progression completes")
		local scheduled = #timers
		api.InvokeProgression(a, id)
		check(#timers == scheduled, "threshold effects do not replay")
		check(not api.AddProgressionValue(a, id, 1), "completed numeric line rejects repeats")
		check(type(definition:BuildResponse(definition.keyNpc, api.GetLine(b, id))) == "string", "numeric response receives line state")
	end
	check(not api.IsCompleted(b, id), "other character never completes")
	check(next(api.GetComplexProgressionValue(b, id)) == nil, "other character receives no contributions")
	for _, nextID in ipairs(definition.nextProgressions or {}) do
		check(api.GetLine(a, nextID).active == true, "successor activated for owner")
		check(b.data.progression.lines[nextID] == nil, "successor not activated for others")
	end
	for _, unlock in ipairs(definition.vendorUnlocks or {}) do
		check(api.CanBuyItem(a, unlock.npc, unlock.args[1]), "owner may buy unlocked item")
		check(not api.CanBuyItem(b, unlock.npc, unlock.args[1]), "other character cannot buy unlocked item")
	end
end
check(count == 139, "all definitions exercised")

-- Turn-in requests must match NPC, map, inventory, remaining amount and owner.
currentMap = "rp_marsh_cs"
a, b = character(), character()
local inventoryItem = {quantity = 5}
function inventoryItem:GetData(key, default) return self[key] or default end
function inventoryItem:SetData(key, value) self[key] = value end
function inventoryItem:Remove() self.removed = true end
a.inventory = {HasItem = function(_, id) if id == "artifact_bolt" and not inventoryItem.removed then return inventoryItem end end}
local target = {
	GetClass = function() return "ix_vendor_adv" end,
	GetDisplayName = function() return "'Cleaner'" end,
	GetPos = function() return position end,
	CanAccess = function() return true end
}
check(not api.TurnIn(a.client, target, "bossItemDelivery_1", "artifact_bolt"), "wrong NPC rejected")
check(not api.TurnIn(a.client, target, "cleanerItemDelivery_Storage", "invalid"), "wrong item rejected")
currentMap = "rp_waystation"
check(not api.TurnIn(a.client, target, "cleanerItemDelivery_Storage", "artifact_bolt"), "wrong map rejected")
currentMap = "rp_marsh_cs"
check(api.TurnIn(a.client, target, "cleanerItemDelivery_Storage", "artifact_bolt"), "valid turn-in accepted")
check(inventoryItem.quantity == 4 and a.money == 2 and a.reputation == 1, "only required amount consumed and rewarded")
check(not api.TurnIn(a.client, target, "cleanerItemDelivery_Storage", "artifact_bolt"), "duplicate turn-in rejected")
check(a.money == 2 and inventoryItem.quantity == 4 and not api.IsCompleted(b, "cleanerItemDelivery_Storage"), "duplicate requests cannot award rewards or affect others")
check(a.saves == 1, "turn-in saves character after rewards")

-- Inventory removal can fail; never grant progress or rewards in that case.
local c = character()
c.inventory = a.inventory
inventoryItem.quantity = 1
inventoryItem.Remove = function() return false end
check(not api.TurnIn(c.client, target, "cleanerItemDelivery_Storage", "artifact_bolt"), "failed item removal rejected")
check(c.money == 0 and not api.IsCompleted(c, "cleanerItemDelivery_Storage"), "failed removal gives no progress or rewards")
inventoryItem.Remove = function(self) self.removed = true end
check(api.TurnIn(c.client, target, "cleanerItemDelivery_Storage", "artifact_bolt") and inventoryItem.removed, "whole-stack turn-in removes inventory item")

-- A delayed personal message must not target a different selected character.
messages = {}
api.Notify(a, "NPC", "hello")
check(#messages == 1 and messages[1][5][1] == a.client, "message sent only to owner")
a.client.GetCharacter = function() return b end
api.Notify(a, "NPC", "late")
check(#messages == 1, "delayed message suppressed after switching characters")

-- World arrivals unlock once globally without sharing personal service access.
local worldSave
PLUGIN = {worldDataLoaded = true}
function PLUGIN:SaveData() worldSave = copy(self.worldUnlocks) end
dofile(base.."libs/sv_world.lua")
currentMap = "rp_marsh_cs"
local spawnCount, catalogCount = 0, 0
for _, definition in pairs(api.definitions) do
	if definition.worldNPC then ix.npctemplates.templates[definition.worldNPC.template] = {name = definition.worldNPC.template} end
end
ix.util.SpawnAdvVendor = function(template)
	spawnCount = spawnCount + 1
	vendors[#vendors + 1] = {GetDisplayName = function() return template end, AddItemToList = function() end}
end
local catalog = {}
vendors[#vendors + 1] = {
	GetDisplayName = function() return "'Technut'" end,
	AddItemToList = function(_, item)
		if not catalog[item] then catalog[item] = true catalogCount = catalogCount + 1 end
	end
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
ix.jobs = {list = {test = {categories = {}}}}
for _, job in ipairs({
	{"OldTimer_oldTimerKillIntro", "oldTimerKillIntro", "'Old Timer'", "mutantkilleasy"},
	{"Boss_dataTasks", "boss_dataTasks", "'Boss'", "dataextracteasy"},
	{"smartass_rfTasks", "smartass_rfTasks", "'Smartass'", "scanRFeasy"},
	{"computer_artifactTasks", "computer_artifactTasks", "'Computer'", "artifactcollect_computer"},
	{"intern_gasAnalyzerReadings", "intern_gasAnalyzerReadings", "'Intern'", "scanareahard"}
}) do
	a, b = character(), character()
	local definition = api.definitions[job[2]]
	local requirement = api.npcRequirements[definition.keyNpc]
	if requirement then api.SetCompleted(a, requirement) end
	currentMap = definition.progMap
	api.SetActive(a, job[2], true)
	ix.jobs.list.test.categories = {job[4]}
	callbacks[job[1]](a.client, "wrong NPC", "test")
	check(api.GetProgressionValue(a, job[2]) == 0, "wrong job NPC ignored")
	callbacks[job[1]](a.client, job[3], "test")
	check(api.GetProgressionValue(a, job[2]) == 1, "job hook credits its character")
	check(api.GetProgressionValue(b, job[2]) == 0, "job hook does not credit others")
end

-- Real plugin lifecycle archives global data and waits for vendor loading.
ix.util.Include = function(filename) dofile(base..filename) end
local oldGlobal = {oldTimerKillIntro = {completed = true}}
local savedPluginData = copy(oldGlobal)
function PLUGIN:GetData() return savedPluginData end
function PLUGIN:SetData(value) savedPluginData = value end
local setupCalls = 0
PLUGIN.worldDataLoaded = nil
function PLUGIN:SetupProgressionWorld() setupCalls = setupCalls + 1 end
dofile(base.."sh_plugin.lua")
PLUGIN:LoadData()
check(PLUGIN.worldUnlocks.oldTimerKillIntro, "legacy completion preserves global NPC arrival")
PLUGIN:Think()
check(setupCalls == 0, "world setup waits for saved vendors")
PLUGIN:PostLoadData()
check(setupCalls == 1, "world setup runs after saved vendors load")
PLUGIN:SaveData()
check(savedPluginData.version == 2 and savedPluginData.legacy.oldTimerKillIntro.completed, "global save archived")
check(savedPluginData.worldUnlocks.oldTimerKillIntro, "world arrivals stored alongside legacy archive")
PLUGIN.worldUnlocks.computer_artifactTasks = true
PLUGIN:SaveData()
PLUGIN.worldUnlocks = {}
PLUGIN:LoadData()
check(PLUGIN.worldUnlocks.computer_artifactTasks, "new global arrivals survive a save/load cycle")
PLUGIN:SaveData()
check(savedPluginData.legacy.legacy == nil, "archive does not nest on subsequent loads")
a = character()
PLUGIN:PlayerLoadedCharacter(a.client, a)
check(next(a.data.progression.lines) == nil, "legacy completion not imported into character")

-- Real dialogue network handlers enforce progression before invoking callbacks.
local networkHandlers, readStrings, readTarget = {}, {}, nil
util = {AddNetworkString = function() end}
net = {
	Receive = function(name, callback) networkHandlers[name] = callback end,
	ReadString = function() return table.remove(readStrings, 1) end,
	ReadEntity = function() return readTarget end,
	ReadTable = function() return {} end
}
netstream = {Hook = function() end}
local playerMeta = {}
FindMetaTable = function() return playerMeta end
ix.config = {Add = function() end}
dofile("gamemodes/ix_cotz/plugins/dialogue/sh_plugin.lua")
local invoked = 0
local topic = {}
for _, callback in ipairs({"preCallback", "postCallback", "ResolveDynamicOption", "DynamicPreCallback"}) do
	topic[callback] = function() invoked = invoked + 1 end
end
ix.dialogue.list = {owlnpc = {tree = {OpenStorage = topic, TradeTopic = topic}}, technpc = {tree = {ConfirmPaint = topic}}}
readTarget = {
	dialogueid = "owlnpc",
	GetClass = function() return "ix_vendor_adv" end,
	GetPos = function() return position end,
	CanAccess = function() return true end
}
local function request(network, tree, topicID, client)
	readStrings = {tree, topicID}
	networkHandlers[network](0, client or a.client)
end
for _, network in ipairs({"ixPreCallback", "ixPostCallback", "ixDialogueResolveDynamic", "ixPreDynamicCallback"}) do
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
readTarget.CanAccess = function() return false end
request("ixPreDynamicCallback", "technpc", "ConfirmPaint")
check(invoked == 2, "NPC access restriction enforced")
readTarget.CanAccess = function() return true end
position.DistToSqr = function() return 193 * 193 end
request("ixPreDynamicCallback", "technpc", "ConfirmPaint")
check(invoked == 2, "remote dialogue request rejected")
position.DistToSqr = function() return 0 end

-- Exercise real interaction methods while leaving unrelated GLua entity code unloaded.
local vendorFile = assert(io.open("gamemodes/ix_cotz/plugins/vendor_adv/entities/entities/ix_vendor_adv.lua"))
local vendorSource = vendorFile:read("*a")
vendorFile:close()
ENT = {}
local compile = loadstring or load
assert(compile(vendorSource:match("(function ENT:CanAccess.-)function ENT:GetStock")))()
assert(compile(vendorSource:match("(function ENT:Use.-)function ENT:SetDialogueID")))()
table.IsEmpty = function(value) return next(value) == nil end
ix.faction = {indices = {[1] = {uniqueID = "stalker"}}}
ix.class = {list = {}}
hook.Run = function() end
isentity = IsValid
local dialogueTree
net.Start = function() end
net.WriteEntity = function() end
net.WriteString = function(value) dialogueTree = value end
net.Send = function() end
local lockedCharacter = character()
local client = lockedCharacter.client
client.Team = function() return 1 end
client.dialogue = playerMeta.dialogue
client.Freeze = function() end
local vendor = setmetatable({
	dialogueid = "tradernpc", factions = {}, classes = {}, messages = {},
	GetClass = function() return "ix_vendor_adv" end,
	GetDisplayName = function() return "'Haggler'" end,
	GetPos = function() return position end,
}, {__index = ENT})
check(vendor:CanTalkTo(client) and not vendor:CanAccess(client), "locked character can talk but cannot use services")
vendor:Use(client)
check(dialogueTree == "progressionlocked", "locked interaction opens limited dialogue")
local lockedDialogue = {tree = {}}
lockedDialogue.addTopic = function(id, data) lockedDialogue.tree[id] = data end
DIALOGUE = lockedDialogue
dofile("gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_progressionlocked.lua")
DIALOGUE = nil
check(#lockedDialogue.tree.GREETING.options == 2, "limited greeting offers introduction and goodbye")
for _, entry in pairs(lockedDialogue.tree) do
	check(not entry.preCallback and not entry.postCallback and not entry.IsDynamic,
		"limited dialogue has no service callbacks")
end
readTarget = vendor
ix.dialogue.list.tradernpc = {tree = {TradeTopic = topic}}
request("ixPostCallback", "tradernpc", "TradeTopic", client)
check(invoked == 2, "locked character cannot forge full dialogue callbacks")
api.SetCompleted(lockedCharacter, "oldTimerKillIntro")
check(vendor:CanAccess(client), "personal milestone grants service access")
vendor:Use(client)
check(dialogueTree == "tradernpc", "unlocked interaction opens normal dialogue")
vendor.factions = {other = true}
check(not vendor:CanTalkTo(client) and not vendor:CanAccess(client), "faction restrictions still apply to dialogue")

-- Client API permits snapshots but does not expose mutation functions.
ix.progression = nil
SERVER = false
CLIENT = true
dofile(base.."libs/sh_storage.lua")
dofile(base.."libs/sh_progression.lua")
check(ix.progression.SetCharacterProgression == nil and ix.progression.SetCompleted == nil, "client has no mutation API")
check(ix.progression.GetLine(a, "cleanerItemDelivery_Storage").completed, "client reads character-owned data")
print(string.format("PASS: %d checks; %d definitions (%d delivery, %d numeric)", checks, count, complexCount, numericCount))
