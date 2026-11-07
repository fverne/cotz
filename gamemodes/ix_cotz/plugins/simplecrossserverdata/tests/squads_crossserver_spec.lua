-- Run from the addon root: luatex --luaonly gamemodes/ix_cotz/plugins/simplecrossserverdata/tests/squads_crossserver_spec.lua (also requires python3).
local checks = 0
local function check(value, message) checks = checks + 1 assert(value, message) end
local stem = os.tmpname()
local statementPath, databasePath, resultPath = stem .. ".sql", stem .. ".db", stem .. ".lua"
local failure
local function execute(statement)
	local file = assert(io.open(statementPath, "w"))
	file:write(statement)
	file:close()
	local command = "python3 tests/support/squads_sqlite_bridge.py " .. statementPath
		.. " " .. databasePath .. " " .. resultPath
	assert(os.execute(command))
	local rows, errorText = dofile(resultPath)
	failure = errorText
	return rows
end
local function query(statement)
	local rows = execute(statement)
	assert(rows ~= false, failure)
	return rows
end
query([[CREATE TABLE ix_characters (id INTEGER PRIMARY KEY, schema TEXT, steamid TEXT,
	name TEXT, pdaavatar TEXT, squad_id TEXT DEFAULT 'NULL', squad_officer INTEGER DEFAULT 0)]])
query([[CREATE TABLE ix_squads_squads (owner TEXT PRIMARY KEY, name TEXT, description TEXT, color TEXT)]])
query([[INSERT INTO ix_characters VALUES (1,'ix_cotz','account','Leader','leader.png','char:1',0)]])
query([[INSERT INTO ix_characters VALUES (2,'ix_cotz','other','Member','member.png','char:1',0)]])
query([[INSERT INTO ix_characters VALUES (3,'ix_cotz','account','Alt','alt.png','NULL',0)]])
query([[INSERT INTO ix_characters VALUES (4,'another','other','Foreign','foreign.png','char:1',1)]])
query([[INSERT INTO ix_squads_squads VALUES ('char:1','Legacy','Message','NULL')]])
-- Public presence now selects these existing character columns for its leaderboard.
query([[ALTER TABLE ix_characters ADD COLUMN data TEXT DEFAULT '{}']])
query([[ALTER TABLE ix_characters ADD COLUMN reputation INTEGER DEFAULT 0]])
query([[ALTER TABLE ix_characters ADD COLUMN progression MEDIUMTEXT DEFAULT '{}']])
local humans, sent, errors = {}, {}, {}
local now, map = 100, "map_a"
local hashes = 0
SERVER, CLIENT = true, false
PLUGIN = {}
Schema = {folder = "ix_cotz"}
function CurTime() return now end
function SysTime() return now end
function IsValid(value) return type(value) == "table" and value.valid end
function isstring(value) return type(value) == "string" end
function isnumber(value) return type(value) == "number" end
function istable(value) return type(value) == "table" end
function Color(r, g, b) return {r = r, g = g, b = b, a = 255} end
function ErrorNoHalt(value) errors[#errors + 1] = value end
math.Clamp = function(value, low, high) return math.max(low, math.min(high, value)) end
string.Trim = function(value) return value:match("^%s*(.-)%s*$") end
string.utf8sub = string.sub
string.ToColor = function() return Color(105, 139, 87) end
string.FromColor = function(color) return color.r .. " " .. color.g .. " " .. color.b .. " 255" end
local function serialize(value)
	if (type(value) ~= "table") then return tostring(value) end
	local parts = {}
	for key, item in pairs(value) do parts[#parts + 1] = tostring(key) .. ":" .. serialize(item) end
	table.sort(parts)
	return table.concat(parts, ";")
end
util = {AddNetworkString = function() end, TableToJSON = serialize,
	SHA256 = function() hashes = hashes + 1 return string.format("%064x", hashes) end}
local timers = {}
timer = {Simple = function(_, callback) timers[#timers + 1] = callback end}
game = {GetIPAddress = function() return "test" end, GetMap = function() return map end}
sql = {Query = execute, LastError = function() return failure end}
mysql = {module = "sqlite"}
sql.SQLStr = function(value, withoutQuotes)
	local escaped = tostring(value):gsub("'", "''")
	return withoutQuotes and escaped or ("'" .. escaped .. "'")
end
sql.QueryValue = function() return 0 end
local mysqlFile = assert(io.open("gamemodes/helix/gamemode/core/libs/thirdparty/sv_mysql.lua"))
local mysqlSource = mysqlFile:read("*a"):gsub("!=", "~="):gsub("!", "not ")
mysqlFile:close()
assert(load(mysqlSource))()
dofile("gamemodes/ix_cotz/plugins/simplecrossserverdata/sv_mysql.lua")
player = {GetHumans = function() return humans end}
hook = {Run = function() end}
net = {Start = function() end, WriteString = function() end, WriteTable = function() end,
	Send = function(value) sent[#sent + 1] = value end}
ix = {squad = {list = {}, legacyLeaders = {}}, char = {cache = {account = {1, 3}, other = {2}}, loaded = {},
		vars = {squadID = {}, squadOfficer = {}}},
	config = {Add = function() end, Get = function(_, default) return default end},
	util = {IsColor = function(value) return type(value) == "table" and value.r ~= nil end}}
function ix.squad.ResolveLeader(id, rows)
	local leader = tonumber(id:match("^char:(%d+)$"))
	for _, row in ipairs(rows) do if tonumber(row.id) == leader then return leader end end
end
function ix.squad.GetPlayer(id)
	for _, client in ipairs(humans) do
		if (client.char and client.char:GetID() == id) then return client end
	end
end
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
local file = assert(io.open(root .. "meta/sh_squad.lua"))
local source = file:read("*a"):gsub("!=", "~="):gsub("!", "not ")
file:close()
assert(load(source))()
function ix.squad.Register(id, name, data)
	local squad = ix.squad.meta:New(id, name)
	for key, value in pairs(data or {}) do squad[key] = value end
	ix.squad.list[id] = squad
	return squad
end
local function character(id)
	local value = {id = id, squad = "NULL", rank = 0, name = "", color = {}}
	function value:GetID() return self.id end
	function value:GetSquadID() return self.squad end
	function value:SetSquadID(entry) self.squad = entry end
	function value:GetSquadOfficer() return self.rank end
	function value:SetSquadOfficer(entry) self.rank = entry end
	function value:GetSquadName() return self.name end
	function value:SetSquadName(entry) self.name = entry end
	function value:GetSquadColor() return self.color end
	function value:SetSquadColor(entry) self.color = entry end
	function value:GetName() return "Character " .. id end
	function value:GetPdaavatar() return "avatar_" .. id .. ".png" end
	function value:Kick() self.kicked = true end
	return value
end
local function client(char)
	local value = {valid = true, char = char}
	function value:GetCharacter() return self.char end
	function value:SteamID64() return self.char.id == 2 and "other" or "account" end
	function value:SetLocalVar(key, entry) self[key] = entry end
	function value:Notify(text) self.notice = text end
	function value:NotifyLocalized(key) self.localizedNotice = key end
	function value:Alive() return false end
	return value
end
-- A separate Lua environment preserves the first process's library namespace after loading the second.
local serverAEnvironment = setmetatable({
	ix = setmetatable({
		crossserver = {},
		squad = setmetatable({}, {__index = ix.squad}),
	}, {__index = ix}),
	PLUGIN = {},
}, {__index = _G})
assert(loadfile("gamemodes/ix_cotz/plugins/simplecrossserverdata/sv_presence.lua", "t", serverAEnvironment))()
serverAEnvironment.PLUGIN = {}
assert(loadfile(root .. "sv_crossserver.lua", "t", serverAEnvironment))()
serverAEnvironment.ix.squad.cross.Initialize()
check(serverAEnvironment.ix.squad.cross.ready, "schema initializes using real SQL")
check(ix.char.vars.squadID.bSaveLoadInitialOnly and ix.char.vars.squadOfficer.bSaveLoadInitialOnly,
	"Helix full saves cannot overwrite authoritative membership")
check(query("SELECT member_rank FROM ix_squads_members WHERE scope='ix_cotz' AND character_id=1")[1].member_rank == "2",
	"migration promotes only the resolved founder")
check(#query("SELECT * FROM ix_squads_members WHERE scope='another'") == 0, "migration is schema scoped")
local leader, member, alt = character(1), character(2), character(3)
alt.squad = "stale"
local leaderClient, memberClient = client(leader), client(member)
humans = {leaderClient, memberClient}
ix.char.loaded = {[1] = leader, [2] = member, [3] = alt}
serverAEnvironment.ix.squad.cross.Refresh()
check(leader:GetSquadID() == "char:1" and member:GetSquadID() == "char:1", "refresh updates Helix cached objects")
check(alt:GetSquadID() == "NULL", "Helix account cache refreshes inactive alternatives without inheriting membership")
serverAEnvironment.ix.squad.cross.Claim(leaderClient, leader)
check(serverAEnvironment.ix.squad.cross.sessions[1].claimed, "presence session is claimed")
local oldSession = serverAEnvironment.ix.squad.cross.sessions[1]
-- Simulate another process, sharing SQL but with its own Helix character cache.
map = "map_b"
ix.crossserver = {}
PLUGIN = {}
dofile("gamemodes/ix_cotz/plugins/simplecrossserverdata/sv_presence.lua")
PLUGIN = {}
dofile(root .. "sv_crossserver.lua")
ix.squad.cross.Initialize()
local remoteLeader = character(1)
local remoteClient = client(remoteLeader)
humans = {remoteClient}
ix.char.loaded = {[1] = remoteLeader}
ix.squad.cross.Claim(remoteClient, remoteLeader)
check(remoteLeader.kicked, "a second server cannot take over a live character lease")
remoteLeader.kicked = nil
map = "map_a"
local handedOff
serverAEnvironment.ix.squad.cross.BeginTransfer(leader, "map_b", function(success) handedOff = success end)
check(handedOff, "transfer publishes its handoff after database success")
map = "map_b"
ix.squad.cross.Claim(remoteClient, remoteLeader)
check(ix.squad.cross.sessions[1] and ix.squad.cross.sessions[1].claimed, "destination acquires the transfer session")
local newToken = ix.squad.cross.sessions[1].token
oldSession.travelling = false
serverAEnvironment.ix.squad.cross.Heartbeat(1, oldSession)
check(leader.kicked, "a source that lost its lease unloads its obsolete character session")
serverAEnvironment.ix.squad.cross.Release(1, oldSession)
check(query("SELECT session FROM ix_squads_presence WHERE character_id=1")[1].session == newToken,
	"source disconnect cannot clear the destination session")
ix.squad.cross.Refresh()
check(ix.squad.list["char:1"].memberInfo[1].map == "map_b", "roster includes remote presence map")
ix.squad.cross.ChangeRank(2, remoteClient)
check(query("SELECT member_rank FROM ix_squads_members WHERE scope='ix_cotz' AND character_id=2")[1].member_rank == "1",
	"remote promotion updates the exact authoritative character")
ix.squad.cross.ChangeRank(2, remoteClient, 1)
ix.squad.cross.ChangeRank(2, remoteClient, 1)
check(query("SELECT member_rank FROM ix_squads_members WHERE scope='ix_cotz' AND character_id=2")[1].member_rank == "1",
	"repeated desired-rank requests cannot toggle the target back")
ix.squad.cross.KickMember(2, remoteClient)
check(query("SELECT squad_id FROM ix_squads_members WHERE scope='ix_cotz' AND character_id=2")[1].squad_id == "NULL",
	"remote kick clears authoritative membership")
check(query("SELECT squad_id FROM ix_characters WHERE id=2")[1].squad_id == "char:1",
	"legacy character data is not the authority after migration")
-- Shared invitations survive the inviter changing maps; acceptance reads canonical permissions.
local inviteeClient = client(alt)
humans = {remoteClient, inviteeClient}
ix.char.loaded[3] = alt
ix.squad.cross.Invite(inviteeClient, remoteClient)
check(remoteClient.notice:find("invitation sent", 1, true), "sender receives committed invite notification")
check(inviteeClient.localizedNotice == "squad_invite", "target receives invite notification")
check(inviteeClient.squad_invite ~= nil, "shared invitation is delivered to the target character")
ix.squad.cross.AcceptInvite(inviteeClient)
check(query("SELECT squad_id FROM ix_squads_members WHERE character_id=3")[1].squad_id == "char:1",
	"shared invitation acceptance joins the intended character")
ix.squad.cross.AcceptInvite(inviteeClient)
check(alt:GetSquadID() == "char:1", "replayed acceptance does not alter membership")
ix.squad.cross.Leave(inviteeClient)
check(alt:GetSquadID() == "NULL", "shared leave clears the exact cached character")
ix.squad.cross.SaveSettings(remoteClient, {name = "Shared name", description = "Shared message"})
check(query("SELECT name FROM ix_squads_state WHERE squad_id='char:1'")[1].name == "Shared name",
	"settings are persisted in the authoritative state")
local message = "O'Brien'; DROP TABLE ix_squads_members; --"
ix.squad.cross.SaveSettings(remoteClient, {description = message})
check(query("SELECT description FROM ix_squads_state WHERE squad_id='char:1'")[1].description == message,
	"wrapper escaping preserves apostrophes and SQL-like user text as data")
check(#query("SELECT * FROM ix_squads_members") > 0, "SQL-like text cannot execute an additional statement")
-- Simulate a demotion on another process while this server still has stale permissions cached.
query("UPDATE ix_squads_members SET member_rank=0 WHERE character_id=1")
ix.squad.cross.SaveSettings(remoteClient, {name = "Unauthorized"})
check(query("SELECT name FROM ix_squads_state WHERE squad_id='char:1'")[1].name == "Shared name",
	"database permissions reject stale cached leadership")
query("UPDATE ix_squads_members SET member_rank=2 WHERE character_id=1")
query("UPDATE ix_squads_presence SET expires=0 WHERE character_id=1")
ix.squad.cross.Refresh()
check(ix.squad.list["char:1"].memberInfo[1].state == "offline", "expired sessions are not reported online")
ix.squad.cross.Heartbeat(1, ix.squad.cross.sessions[1])
local originalHook = hook.Run
hook.Run = function() return false end
ix.squad.cross.Heartbeat(1, ix.squad.cross.sessions[1])
ix.squad.cross.Refresh()
check(ix.squad.list["char:1"].memberInfo[1].state == "unknown"
	and ix.squad.list["char:1"].memberInfo[1].map == "", "hidden characters do not expose remote presence")
hook.Run = originalHook
-- A stale cached leader cannot edit after disbanding in SQL.
ix.squad.cross.Disband("char:1", 1)
ix.squad.cross.SaveSettings(remoteClient, {name = "Should not survive"})
check(query("SELECT active FROM ix_squads_state WHERE squad_id='char:1'")[1].active == "0",
	"disband leaves an authoritative tombstone")
check(remoteLeader:GetSquadID() == "NULL", "remote disband clears loaded character mirrors")
ix.squad.cross.ready = false
ix.squad.cross.Initialize()
check(query("SELECT squad_id FROM ix_squads_members WHERE character_id=2")[1].squad_id == "NULL",
	"restart migration cannot resurrect a kicked member")
check(query("SELECT active FROM ix_squads_state WHERE squad_id='char:1'")[1].active == "0",
	"restart migration cannot resurrect a disbanded squad")
-- New squads use distinct keys; members can join after their previous squad was disbanded.
local created
ix.squad.cross.New("New group", remoteLeader, function(value) created = value end)
check(created and created.owner ~= "char:1", "creation makes a new stable key after disband")
check(query("SELECT member_rank FROM ix_squads_members WHERE character_id=1")[1].member_rank == "2",
	"new founder membership is authoritative")
-- The public roster uses the same leases and visibility rules as squad member presence.
query("UPDATE ix_squads_presence SET expires=" .. "CAST(strftime('%s', 'now') AS INTEGER)" .. "+45, hidden=0 WHERE character_id=1")
query("INSERT INTO ix_squads_presence (scope,character_id,session,map,state,expires,hidden,name) VALUES "
	.. "('ix_cotz',3,'remote','map_c','travelling'," .. "CAST(strftime('%s', 'now') AS INTEGER)" .. "+45,0,'Remote loner'),"
	.. "('another',4,'foreign','map_d','online'," .. "CAST(strftime('%s', 'now') AS INTEGER)" .. "+45,0,'Foreign')")
local rosterRows
ix.char.vars.progression = {field = "progression", default = {lines = {}}}
query([[UPDATE ix_characters SET progression = '{"lines":{"fixture":{"completed":true}}}' WHERE id = 1]])
local publish = ix.crossserver.PublishRoster
ix.crossserver.PublishRoster = function(rows) rosterRows = rows end
hook.Run = function(event, queryObject)
	if (event == "cotz/crossserver/roster-query") then return PLUGIN[event](PLUGIN, queryObject) end
end
ix.crossserver.RefreshRoster()
check(#rosterRows == 2, "public roster includes active characters across maps and excludes other schemas")
check(rosterRows[1].progression == '{"lines":{"fixture":{"completed":true}}}',
	"the real roster SQL selects the separate progression column")
check(rosterRows[1].squad_name == "New group" and rosterRows[2].squad_id == nil,
	"public roster joins authoritative squad display metadata and includes loners")
query("UPDATE ix_squads_presence SET hidden=1 WHERE character_id=3")
ix.crossserver.RefreshRoster()
check(#rosterRows == 1, "hidden remote characters are removed from the public roster")
query("UPDATE ix_squads_presence SET expires=0 WHERE character_id=1")
ix.crossserver.RefreshRoster()
check(#rosterRows == 0, "expired sessions are removed from the public roster")
hook.Run = originalHook
ix.crossserver.PublishRoster = publish

check(#errors == 0, "all emitted SQL succeeds")
-- Exercise the bundled save implementation, not a duplicate model of its field filtering.
local savedSQL
local originalUpdate = mysql.Update
mysql.Update = function()
	return {Update = function(_, field) savedSQL = savedSQL or {} savedSQL[field] = true end,
		Where = function() end, Callback = function() end, Execute = function() end}
end
ix.meta, ix.db = {}, {}
ix.char.vars.squadID.field = "squad_id"
ix.char.vars.squadOfficer.field = "squad_officer"
ix.char.vars.name = {field = "name"}
local characterFile = assert(io.open("gamemodes/helix/gamemode/core/meta/sh_character.lua"))
local characterSource = characterFile:read("*a"):gsub("!=", "~="):gsub("!", "not ")
characterFile:close()
assert(load(characterSource))()
local saveCharacter = setmetatable({id = 1, vars = {squadID = "stale", squadOfficer = 2, name = "Name"}},
	{__index = ix.meta.character})
ix.meta.character.Save(saveCharacter)
check(savedSQL.name and not savedSQL.squad_id and not savedSQL.squad_officer,
	"the installed Helix save preserves names but excludes stale membership fields")
mysql.Update = originalUpdate
local gotFailure
local broken = mysql:Select("ix_squads_state")
broken:Select("deliberately_missing_column")
ix.squad.cross.Query(broken, function(_, failureText)
	gotFailure = failureText
end)
check(gotFailure and #errors == 1, "query errors are reported and delivered to the caller")
local fakeQuery = {setOption = function() end, start = function() end, lastInsert = function() return 0 end}
mysql.module = "mysqloo"
mysqloo = {OPTION_NAMED_FIELDS = 1}
mysql.connection = {query = function() return fakeQuery end,
	escape = function(_, value) return value:gsub("'", "''") end}
local completions = 0
local constant = mysql:Select():SelectValue(1)
ix.squad.cross.Query(constant, function() completions = completions + 1 end)
timers[#timers]()
fakeQuery.onSuccess(fakeQuery, {})
check(completions == 1, "late query completion cannot run after the timeout callback")
mysql.module, mysql.connection = "sqlite", nil
local previousHumans = humans
humans = {}
ix.plugin = {Get = function(name)
	if name == "hideouts" then
		return {state = {hideouts = {{ownerType = "squad", squadID = created.owner}}}}
	end
end}
ix.squad.cross.RefreshSquads()
check(ix.squad.list[created.owner] and ix.squad.list[created.owner].hideoutFresh == now,
	"provisioned hideouts retain fresh squad authority while all members are offline")
humans = previousHumans
for _, path in ipairs({statementPath, databasePath, resultPath, stem}) do os.remove(path) end
print("squads cross-server: " .. checks .. " checks passed")
