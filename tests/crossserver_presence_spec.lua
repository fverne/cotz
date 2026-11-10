-- Run from the addon root: luatex --luaonly tests/crossserver_presence_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local now = 100
function CurTime() return now end
function SysTime() return now end
function Color(r, g, b) return {r = r, g = g, b = b} end
local packets, packet, receiver = {}, nil, nil
net = {
	Start = function() packet = {} end,
	Send = function() packets[#packets + 1] = packet end,
	Receive = function(_, callback) receiver = callback end,
}
local function write(value) packet[#packet + 1] = value end
net.WriteBool, net.WriteString = write, write
net.WriteUInt = function(value, bits)
	assert(value >= 0 and value < 2 ^ bits)
	write(value)
end
local function serialize(value)
	if (type(value) ~= "table") then return tostring(value) end
	local entries = {}
	for key, item in pairs(value) do entries[#entries + 1] = key .. ":" .. serialize(item) end
	table.sort(entries)
	return table.concat(entries, ";")
end
local jsonValues = {}
local function encode(value)
	local key = serialize(value)
	jsonValues[key] = value
	return key
end
util = {JSONToTable = function(value) return jsonValues[value] end, AddNetworkString = function() end, SHA256 = function(value) return value end, TableToJSON = encode}
game = {GetIPAddress = function() return "test" end}
local liveData = {leaderboardStats = {tasksCompleted = 15, taskEarnings = 900, species = {private = true}},
	privateVendorHistory = "private"}
local liveProgression = {lines = {["test/one"] = {completed = true}}}
local character = {
	GetID = function() return 70 end,
	GetData = function() return liveData end,
	GetProgression = function() return liveProgression end,
}
local client = {GetCharacter = function() return character end}
player = {GetHumans = function() return {client} end}
string.ToColor = function() return Color(105, 139, 87) end
ix = {config = {Add = function() end, Get = function(_, default) return default end}}
SERVER, CLIENT = true, false
PLUGIN = {}
local root = "gamemodes/ix_cotz/plugins/simplecrossserverdata/"
ix.plugin = ix.plugin or {Get = function() end}
dofile(root .. "sh_presence.lua")
dofile(root .. "sv_presence.lua")
dofile("gamemodes/ix_cotz/plugins/jobsystem/libs/sh_leaderboard.lua")
local rows = {}
for id = 1, 70 do
	rows[id] = {character_id = id, name = "Scout " .. id, pdaavatar = "portrait.png", state = "online",
		map = "map_b", squad_id = "squad", squad_name = "Scouts", squad_color = "105 139 87 255"}
end
ix.townNPCs = {contacts = {test = {name = "Tester", progression = {{id = "one"}}}},
	StepID = function(_, slug, id) return slug .. "/" .. id end,
	GetNetworkAccess = function() return {} end,
	FilterNetworkRecord = function(_, _, record) return record end}
rows[1].progression = encode({lines = {["test/one"] = {completed = true}}})
ix.crossserver.PublishRoster(rows)
check(#packets == 3, "large rosters use bounded typed network chunks")
check(packets[1][4] == 32 and packets[3][4] == 6, "chunk record counts match the payload")
SERVER, CLIENT = false, true
dofile(root .. "sh_presence.lua")
local function receive(values)
	local index = 0
	local function read() index = index + 1 return values[index] end
	net.ReadBool, net.ReadUInt, net.ReadString = read, read, read
	receiver()
	check(index == #values, "client consumes exactly the typed packet payload")
end
receive(packets[1])
check(not ix.crossserver.roster, "partial snapshots never replace the visible roster")
receive(packets[2])
check(not ix.crossserver.roster, "intermediate chunks remain pending")
receive(packets[3])
check(ix.crossserver.roster[1].profile.leaderboardStats.favoriteContact == "Tester",
	"remote favorite contacts read the saved progression column")
check(ix.crossserver.roster[1].name == "Scout 1" and ix.crossserver.roster[70].squadName == "Scouts",
	"completed snapshot preserves character identity and public squad data")
check(ix.crossserver.roster[70].squadColor.g == 139, "typed colors survive the round trip")
local profile = ix.crossserver.roster[70].profile
check(profile.leaderboardStats.tasksCompleted == 15 and profile.leaderboardStats.taskEarnings == 900
	and profile.leaderboardStats.favoriteContact == "Tester",
	"local public profiles use live server counters and progression before character save")
check(profile.privateVendorHistory == nil and profile.leaderboardStats.species == nil
	and profile.progression == nil, "roster profiles exclude private character data and raw progression")
packets = {}
ix.crossserver.PublishRoster(rows)
check(#packets == 1 and packets[1][1] == false and #packets[1] == 1,
	"unchanged snapshots only send a freshness acknowledgement")
now = now + 5
receive(packets[1])
check(ix.crossserver.rosterFresh == now, "freshness acknowledgements refresh the last successful read")
packets = {}
liveData.leaderboardStats.tasksCompleted = 16
ix.crossserver.PublishRoster(rows)
check(#packets == 3 and packets[1][1] == true, "unsaved counter changes publish a replacement snapshot")
for _, values in ipairs(packets) do receive(values) end
check(ix.crossserver.roster[70].profile.leaderboardStats.tasksCompleted == 16,
	"updated live totals survive the roster round trip")
packets = {}
ix.crossserver.PublishRoster({})
receive(packets[1])
check(next(ix.crossserver.roster) == nil, "empty snapshots clear disconnected and expired characters")
check(ix.crossserver.GetPresenceText({state = "offline"}, true) == "OFFLINE", "shared labels include offline")
check(
	ix.crossserver.GetPresenceText({state = "unknown"}, true) == "STATUS UNAVAILABLE",
	"hidden presence stays unavailable"
)
check(ix.crossserver.GetPresenceText({state = "online", map = "map_b"}, true) == "ONLINE: MAP_B",
	"shared labels include the remote map")
check(ix.crossserver.GetPresenceText({state = "travelling", destination = "map_c"}, true, true) == "TRAVELLING: MAP_C",
	"travelling takes precedence over a still connected local entity")
ix.plugin.Get = function() return {mapdata = {rp_marsh_cs = {name = "Swamps"}}} end
game.GetMap = function() return "rp_marsh_cs" end
check(ix.crossserver.GetPresenceText({state = "online"}, true, true) == "ONLINE: SWAMPS",
	"local presence uses the configured friendly map name")
check(ix.crossserver.GetPresenceText({state = "online", map = "rp_marsh_cs"}, true, false) == "ONLINE: SWAMPS",
	"remote presence uses the same friendly map name")
check(ix.crossserver.GetPresenceColor({state = "online"}, true, true).r == 105,
	"local online status uses green")
check(ix.crossserver.GetPresenceColor({state = "online"}, true, false).g == 140,
	"remote online status uses teal")
check(ix.crossserver.GetPresenceColor({state = "online"}, false, false).r == 116,
	"stale presence stays muted")
print("cross-server presence: " .. checks .. " checks passed")
