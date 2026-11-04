-- Run from the addon root: luatex --luaonly tests/squads_characters_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local queue, queries, errors, receivers = {}, {}, {}, {}
local database = {ix_characters = {}, ix_squads_squads = {}}
local humans = {}
local now = 100
SERVER, CLIENT = true, false
PLUGIN = {}
Schema = {folder = "ix_cotz"}
function IsValid(value) return type(value) == "table" and value.valid end
function istable(value) return type(value) == "table" end
function isstring(value) return type(value) == "string" end
function Color(r, g, b) return {r = r, g = g, b = b} end
function CurTime() return now end
function ErrorNoHalt(value) errors[#errors + 1] = value end
player = {GetHumans = function() return humans end}
util = {AddNetworkString = function() end}
local handlers = {}
net = {
	Receive = function(name, callback) handlers[name] = callback end,
	Start = function() end, WriteTable = function() end, WriteString = function() end,
	WriteBool = function() end, WriteUInt = function() end, Send = function(value) receivers = value end,
}
local function copy(value)
	local result = {}
	for key, entry in pairs(value) do result[key] = entry end
	return result
end
local function matches(row, where)
	for key, value in pairs(where) do
		if (tostring(row[key]) ~= tostring(value)) then return false end
	end
	return true
end
local queryMethods = {}
function queryMethods:Where(key, value) self.where[key] = value end
function queryMethods:Select() end
function queryMethods:Update(key, value) self.values[key] = value end
function queryMethods:Insert(key, value) self.values[key] = value end
function queryMethods:Callback(callback) self.callback = callback end
function queryMethods:Execute()
	queries[#queries + 1] = self
	queue[#queue + 1] = function()
		local rows = database[self.table]
		local results = {}
		if (self.kind == "Insert") then rows[#rows + 1] = copy(self.values) end
		for index = #rows, 1, -1 do
			local row = rows[index]
			if (matches(row, self.where)) then
				if (self.kind == "Select") then results[#results + 1] = copy(row) end
				if (self.kind == "Delete") then table.remove(rows, index) end
				if (self.kind == "Update") then
					for key, value in pairs(self.values) do row[key] = value end
				end
			end
		end
		if (self.callback) then self.callback(self.kind == "Select" and results or nil) end
	end
end
mysql = {}
for _, kind in ipairs({"Select", "Update", "Insert", "Delete"}) do
	mysql[kind] = function(_, name)
		return setmetatable({kind = kind, table = name, where = {}, values = {}}, {__index = queryMethods})
	end
end
local function flush()
	local limit = 1000
	while (#queue > 0) do
		limit = limit - 1
		assert(limit > 0, "query loop")
		table.remove(queue, 1)()
	end
end
ix = {squad = {}, char = {loaded = {}, RegisterVar = function() end}, type = {},
	util = {Include = function() end, GetMaterial = function(path) return path end}, command = {Add = function(name, command) ix.command[name] = command end}}
ix.middleclass = function()
	local class = {}
	function class:New(...)
		local instance = setmetatable({}, {__index = self})
		instance:Initialize(...)
		return instance
	end
	return class
end
local root = "gamemodes/ix_cotz/plugins/squads/"
local sharedFile = assert(io.open(root .. "sh_plugin.lua"))
local sharedSource = sharedFile:read("*a"):gsub("!=", "~="):gsub("!", "not ")
sharedFile:close()
assert(load(sharedSource))()
local metaFile = assert(io.open(root .. "meta/sh_squad.lua"))
local metaSource = metaFile:read("*a"):gsub("!=", "~="):gsub("!", "not ")
metaFile:close()
assert(load(metaSource))()
dofile(root .. "sv_plugin.lua")
local file = assert(io.open(root .. "sv_hooks.lua"))
local source = file:read("*a"):gsub("!=", "~="):gsub("!", "not ")
file:close()
assert(load(source))()
local function character(id, account, squadID)
	local row = {id = id, steamid = account, name = "Character " .. id, model = "models/error.mdl",
		schema = Schema.folder, squad_id = squadID or "NULL", squad_officer = 0}
	database.ix_characters[#database.ix_characters + 1] = row
	local char = {id = id, squadID = row.squad_id, officer = 0, name = row.name}
	function char:GetID() return self.id end
	function char:GetSquadID() return self.squadID end
	function char:SetSquadID(value) self.squadID = value end
	function char:GetSquadOfficer() return self.officer end
	function char:SetSquadOfficer(value) self.officer = value end
	function char:GetSquadName() return self.squadName or "" end
	function char:SetSquadName(value) self.squadName = value end
	function char:GetName() return self.name end
	function char:GetPdaavatar() return "vgui/icons/face_31.png" end
	function char:GetSquadColor() return self.color or {} end
	function char:SetSquadColor(color) self.color = color end
	function char:GetModel() return row.model end
	ix.char.loaded[id] = char
	return char, row
end
local function client(char)
	local value = {valid = true, char = char}
	function value:GetCharacter() return self.char end
	function value:SetLocalVar(key, entry) self[key] = entry end
	function value:IsPlayer() return true end
	function value:NotifyLocalized() end
	function value:Notify() end
	humans[#humans + 1] = value
	return value
end
local founder, founderRow = character(1, "same-account")
local alt, altRow = character(2, "same-account")
local member, memberRow = character(3, "member-account")
local founderClient, memberClient = client(founder), client(member)
local squad
ix.squad.New("Alpha", founder, function(value) squad = value end)
ix.squad.New("Duplicate", founder, function() error("duplicate creation callback") end)
flush()
check(squad and squad.owner == "char:1" and squad.leaderID == 1, "new squads have a character leader")
check(#database.ix_squads_squads == 1, "repeated creation cannot create a second squad")
check(founderRow.squad_id == "char:1" and altRow.squad_id == "NULL", "creation persists only the founding character")
check(squad:IsLeader(founderClient), "founding character has leadership")
founderClient.char = alt
check(not squad:IsLeader(founderClient) and squad:GetRank(founderClient) == nil,
	"account alternate inherits no permissions")
check(#squad:GetReceivers() == 0, "switching characters stops roster reception")
founderClient.char = founder
ix.squad.AddMember(memberClient, founderClient)
flush()
check(squad.members[3] == 0 and memberRow.squad_id == "char:1", "joining persists membership by character")
ix.squad.ChangeRank(3, founderClient)
flush()
check(squad.members[3] == 1 and memberRow.squad_officer == 1, "promotion updates the exact character")
founderClient.char = alt
ix.squad.KickMember(3, founderClient)
flush()
check(squad.members[3] == 1, "alternate character cannot moderate the founder's squad")
founderClient.char = founder
memberClient.char = alt
ix.squad.KickMember(3, founderClient)
flush()
check(member:GetSquadID() == "NULL" and alt:GetSquadID() == "NULL", "offline moderation targets the selected character")
check(memberRow.squad_id == "NULL" and founderRow.squad_id == "char:1", "kick does not update an entire account")
memberClient.char = member
ix.squad.AddMember(memberClient, founderClient)
flush()
ix.squad.Leave(memberClient)
flush()
check(member:GetSquadID() == "NULL" and squad.members[3] == nil, "leaving clears character membership")
local offline, offlineRow = character(4, "same-account", "char:1")
squad.members[4] = 0
ix.char.loaded[4] = nil
ix.squad.Disband("char:1")
flush()
check(offlineRow.squad_id == "NULL", "disband clears unloaded members")
check(founder:GetSquadID() == "NULL" and #database.ix_squads_squads == 0, "disband clears leader and squad record")
local legacyRows = {{id = "10", steamid = "legacy"}, {id = "11", steamid = "other"}}
check(ix.squad.ResolveLeader("legacy", legacyRows) == 10, "unambiguous legacy owner resolves to a character")
legacyRows[2].steamid = "legacy"
check(not ix.squad.ResolveLeader("legacy", legacyRows), "ambiguous legacy ownership is never guessed")
ix.squad.legacyLeaders.legacy = 11
check(ix.squad.ResolveLeader("legacy", legacyRows) == 11, "explicit legacy mapping selects the requested member")
ix.squad.legacyLeaders.legacy = 999
check(not ix.squad.ResolveLeader("legacy", legacyRows), "legacy mapping cannot appoint a nonmember")
check(ix.squad.ResolveLeader("char:10", legacyRows) == 10, "new keys resolve leadership without account lookup")
-- Restore offline names and normalize SQL string ranks.
local restoredChar, restoredRow = character(10, "legacy", "legacy")
local otherChar, otherRow = character(11, "legacy", "legacy")
otherRow.squad_officer = "1"
ix.squad.legacyLeaders.legacy = 10
database.ix_squads_squads[#database.ix_squads_squads + 1] = {owner = "legacy", name = "Old squad"}
local restored
ix.squad.Restore("legacy", 10, function(value) restored = value end)
flush()
check(restored.leaderID == 10 and restored.members[11] == 1, "restore uses character IDs and numeric ranks")
check(restored.memberInfo[11].name == otherRow.name, "offline roster uses saved character names")
-- Unresolved records stay intact, including on character load.
ix.squad.list.legacy = nil
ix.squad.legacyLeaders.legacy = nil
local legacyClient = client(restoredChar)
PLUGIN:PlayerLoadedCharacter(legacyClient, restoredChar)
flush()
check(restoredChar:GetSquadID() == "legacy" and #errors == 1, "ambiguous legacy saves are retained and reported")
-- Invitations bind both characters, not player UserIDs or accounts.
local invitee = character(20, "invitee")
local inviteeClient = client(invitee)
inviteeClient.squad_invite = {expires = now + 30, targetID = 21, inviterID = 10, squadID = "legacy"}
ix.squad.AcceptInvite(inviteeClient)
check(invitee:GetSquadID() == "NULL" and not inviteeClient.squad_invite,
	"wrong-character invitations are consumed and rejected")
-- Delete an inactive alternate without affecting its account's leader character.
local leader = character(30, "shared-deletion")
local inactive = character(31, "shared-deletion")
local leaderClient = client(leader)
local deletionSquad
ix.squad.New("Deletion", leader, function(value) deletionSquad = value end)
flush()
PLUGIN:PreCharacterDeleted(leaderClient, inactive)
flush()
check(ix.squad.list[deletionSquad.owner] == deletionSquad,
	"deleting an unrelated alternate does not disband leadership")
-- Successful invitation acceptance is character-scoped and cannot replay.
inviteeClient.squad_invite = {expires = now + 30, targetID = 20, inviterID = 30,
	squadID = deletionSquad.owner}
ix.squad.AcceptInvite(inviteeClient)
flush()
check(invitee:GetSquadID() == deletionSquad.owner, "valid invitation joins the intended character")
local queryCount = #queries
ix.squad.AcceptInvite(inviteeClient)
check(#queries == queryCount, "accepted invitations cannot replay")
-- A player who switches characters while restoration is pending receives no old-character updates.
local staleChar = character(40, "stale", "char:40")
local staleClient = client(staleChar)
database.ix_squads_squads[#database.ix_squads_squads + 1] = {owner = "char:40", name = "Stale"}
PLUGIN:PlayerLoadedCharacter(staleClient, staleChar)
staleClient.char = alt
flush()
check(staleChar:GetSquadName() == "" and alt:GetSquadName() == "", "stale restore does not update a switched character")
-- Disband invalidates an in-flight restore rather than resurrecting its cache.
ix.squad.list["char:40"] = nil
local restoredAfterDisband
ix.squad.Restore("char:40", 40, function(value) restoredAfterDisband = value end)
table.remove(queue, 1)() -- squad row read; membership query is now in flight
ix.squad.Disband("char:40")
flush()
check(not restoredAfterDisband and not ix.squad.list["char:40"], "disband cannot be undone by an old restore callback")
PLUGIN:PreCharacterDeleted(leaderClient, leader)
flush()
check(not ix.squad.list[deletionSquad.owner] and invitee:GetSquadID() == "NULL",
	"deleting the leader disbands only that character's squad")
print("squads characters: " .. checks .. " checks passed")
