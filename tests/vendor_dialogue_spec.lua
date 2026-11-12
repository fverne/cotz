-- Run from the repository root: luatex --luaonly tests/vendor_dialogue_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

SERVER, CLIENT = true, false
PLUGIN = {}
local receivers, reads, readIndex, sent = {}, {}, 0, {}
local function read()
	readIndex = readIndex + 1

	return reads[readIndex]
end

net = {
	Receive = function(name, callback) receivers[name] = callback end,
	ReadString = read, ReadEntity = read, ReadTable = read,
	Start = function() sent = {} end,
	WriteEntity = function(value) sent.target = value end,
	WriteString = function(value) sent.tree = value end,
	Send = function() end,
}
util = {AddNetworkString = function() end}
netstream = {Hook = function() end}
IsValid = function(value) return type(value) == "table" and value.valid ~= false end
isentity = IsValid
isfunction = function(value) return type(value) == "function" end
local playerMeta = {}
FindMetaTable = function() return playerMeta end
local unlocked = false
ix = {
	meta = {character = {}}, type = {text = 1},
	char = {RegisterVar = function() end}, inventory = {Register = function() end},
	util = {Include = function() end}, config = {Add = function() end},
	progression = {CanUseNPC = function() return unlocked end},
	dialogue = {list = {}},
}
local base = "gamemodes/ix_cotz/plugins/"
dofile(base .. "sherpas/sh_plugin.lua")
ENT = {}
dofile(base .. "vendor_adv/entities/entities/ix_vendor_adv.lua")
local vendor = ENT
ENT = nil
local calls = 0
ix.sherpa.Open = function() calls = calls + 1 end
ix.sherpa.OpenPersonalStorage = function() calls = calls + 1 end
local tree = {}
DIALOGUE = {addTopic = function(id, topic) tree[id] = topic end}
dofile(base .. "sherpas/dialogue/sh_sherpa.lua")
DIALOGUE = nil
ix.dialogue.list.sherpa = {tree = tree}
dofile(base .. "dialogue/sh_plugin.lua")
local character = {}
local client = setmetatable({character = character, distance = 0}, {__index = playerMeta})
function client:GetCharacter() return self.character end
function client:GetPos() return self end
function client:DistToSqr() return self.distance * self.distance end
function client:Freeze() end
local function target(class, sherpa, dialogueID)
	local entity = setmetatable({class = class, sherpa = sherpa, dialogueid = dialogueID, allowed = true},
		{__index = vendor})
	function entity:GetClass() return self.class end
	function entity:GetSherpa() return self.sherpa end
	function entity:GetPos() return self end
	function entity:GetDisplayName() return "Quartermaster" end
	function entity:CanTalkTo() return self.allowed end

	return entity
end

local function receive(network, entity, treeID, topicID)
	reads, readIndex = {treeID or "sherpa", topicID or "TradeTopic", entity, {}}, 0
	receivers[network](0, client)
end

for _, class in ipairs({"ix_hideout_vendor", "ix_sherpa_vendor", "ix_vendor_adv"}) do
	-- Legacy advanced vendors can retain a template dialogue ID despite opening the Sherpa tree.
	local entity = target(class, true, class == "ix_vendor_adv" and "00templatenpc" or "sherpa")
	for _, topicID in ipairs({"TradeTopic", "DonateTopic", "ManageTopic", "StorageTopic"}) do
		local before = calls
		receive("ixPostCallback", entity, "sherpa", topicID)
		check(calls == before + 1, class .. " dispatches " .. topicID .. " to its server service")
	end
	client:dialogue("sherpa", entity)
	check(sent.tree == "sherpa", "Sherpa dialogue does not use town progression locks")
	check(entity:CanAccess(client), "legacy Sherpa services do not use town progression locks")
	local before = calls
	entity.allowed = false
	receive("ixPostCallback", entity)
	check(calls == before, "vendor access denial blocks callbacks")
	entity.allowed = true
	client.distance = 193
	receive("ixPostCallback", entity)
	check(calls == before, "distant requests are rejected")
	client.distance = 0
	receive("ixPostCallback", entity, "00templatenpc")
	receive("ixPostCallback", entity, "sherpa", "missing")
	client.character = nil
	receive("ixPostCallback", entity)
	client.character = character
	entity.valid = false
	receive("ixPostCallback", entity)
	check(calls == before, "wrong trees, missing topics, invalid entities and absent characters are rejected")
end

local town = target("ix_vendor_adv", false, "town")
ix.dialogue.list.town = {tree = {Action = {}}}
for network, callback in pairs({ixPreCallback = "preCallback", ixPostCallback = "postCallback",
	ixDialogueResolveDynamic = "ResolveDynamicOption", ixPreDynamicCallback = "DynamicPreCallback"}) do
	ix.dialogue.list.town.tree.Action[callback] = function() calls = calls + 1 end
	local before = calls
	receive(network, town, "town", "Action")
	check(calls == before, "locked town vendors retain access restrictions")
	unlocked = true
	receive(network, town, "town", "Action")
	check(calls == before + 1, "ordinary town " .. callback .. " still dispatches")
	unlocked = false
end
client:dialogue("town", town)
check(sent.tree == "progressionlocked", "ordinary town dialogue retains its progression lock")
local before = calls
receive("ixPostCallback", target("prop_physics", false, "sherpa"))
check(calls == before, "unrelated entity classes cannot invoke vendor actions")
print("PASS: " .. checks .. " vendor dialogue checks")
