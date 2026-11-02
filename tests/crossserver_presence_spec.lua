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
local client = {GetCharacter = function() return {} end}
player = {GetHumans = function() return {client} end}
string.ToColor = function() return Color(105, 139, 87) end
ix = {config = {Add = function() end, Get = function(_, default) return default end}}
SERVER, CLIENT = true, false
PLUGIN = {}
local root = "gamemodes/ix_cotz/plugins/simplecrossserverdata/"
dofile(root .. "sh_presence.lua")
dofile(root .. "sv_presence.lua")
dofile("gamemodes/ix_cotz/plugins/jobsystem/libs/sh_leaderboard.lua")
local cross = ix.crossserver
local rows = {}
for id = 1, 70 do
	rows[id] = {character_id = id, name = "Scout " .. id, pdaavatar = "portrait.png", state = "online",
		map = "map_b", squad_id = "squad", squad_name = "Scouts", squad_color = "105 139 87 255"}
end
cross.PublishRoster(rows)
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
check(not cross.roster, "partial snapshots never replace the visible roster")
receive(packets[2])
check(not cross.roster, "intermediate chunks remain pending")
receive(packets[3])
check(cross.roster[1].name == "Scout 1" and cross.roster[70].squadName == "Scouts",
	"completed snapshot preserves character identity and public squad data")
check(cross.roster[70].squadColor.g == 139, "typed colors survive the round trip")
packets = {}
cross.PublishRoster(rows)
check(#packets == 1 and packets[1][1] == false and #packets[1] == 1,
	"unchanged snapshots only send a freshness acknowledgement")
now = now + 5
receive(packets[1])
check(cross.rosterFresh == now, "freshness acknowledgements refresh the last successful read")
packets = {}
cross.PublishRoster({})
receive(packets[1])
check(next(cross.roster) == nil, "empty snapshots clear disconnected and expired characters")
check(cross.GetPresenceText({state = "offline"}, true) == "OFFLINE", "shared labels include offline")
check(cross.GetPresenceText({state = "unknown"}, true) == "STATUS UNAVAILABLE", "hidden presence stays unavailable")
check(cross.GetPresenceText({state = "online", map = "map_b"}, true) == "ONLINE · map_b",
	"shared labels include the remote map")
check(cross.GetPresenceText({state = "travelling", destination = "map_c"}, true, true) == "TRAVELLING · map_c",
	"travelling takes precedence over a still connected local entity")
print("cross-server presence: " .. checks .. " checks passed")
