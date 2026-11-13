-- Run from the addon root with luatex --luaonly tests/mapscene_visibility_spec.lua.
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local vectorMeta = {}
vectorMeta.__index = vectorMeta
function Vector(x, y, z)
	return setmetatable({x = x, y = y, z = z}, vectorMeta)
end
function vectorMeta.__add(a, b) return Vector(a.x + b.x, a.y + b.y, a.z + b.z) end
function vectorMeta.__sub(a, b) return Vector(a.x - b.x, a.y - b.y, a.z - b.z) end
function vectorMeta.__mul(a, b) return Vector(a.x * b, a.y * b, a.z * b) end
function vectorMeta:Dot(other) return self.x * other.x + self.y * other.y + self.z * other.z end
function vectorMeta:LengthSqr() return self:Dot(self) end
function vectorMeta:DistToSqr(other) return (self - other):LengthSqr() end
function isvector(value) return getmetatable(value) == vectorMeta end
local angleMeta = {}
angleMeta.__index = angleMeta
function Angle() return setmetatable({}, angleMeta) end
function angleMeta.__add() return Angle() end
function angleMeta:Up() return Vector(0, 0, 1) end
function angleMeta:Right() return Vector(0, 1, 0) end
function math.Clamp(value, minimum, maximum) return math.max(minimum, math.min(value, maximum)) end
function Lerp(_, _, target) return target end
function IsValid(value) return value ~= nil and value ~= false end
local now = 0
function CurTime() return now end
function FrameTime() return 0 end
bit = {bor = function() return 0 end}
ix = {command = {Add = function() end}, type = {bool = 1, optional = 2, number = 3}, gui = {}}
util = {AddNetworkString = function() end}
local receivers = {}
local active, position
local messages = {}
net = {
	Receive = function(name, callback) receivers[name] = callback end,
	ReadBool = function() return active end,
	ReadVector = function() return position end,
	Start = function(name) check(name == "cotz/mapscene/visibility", "uses the pooled visibility message") end,
	WriteBool = function(value) active = value end,
	WriteVector = function(value) position = value end,
	SendToServer = function() messages[#messages + 1] = {active = active, position = position} end,
}
local file = assert(io.open("gamemodes/helix/plugins/mapscene.lua"))
local source = file:read("*a"):gsub("!=", "~="):gsub("!", "not ")
file:close()
CLIENT = false
PLUGIN = {}
assert(load(source))()
local serverPlugin = PLUGIN
local staticOrigin = Vector(10000, 10000, 100)
local start = Vector(20000, 0, 100)
local finish = Vector(24000, 0, 100)
serverPlugin.scenes = {
	{staticOrigin, Angle()},
	{origin = start, finish, Angle(), Angle()},
}
local client = {}
local origins = {}
function AddOriginToPVS(origin) origins[#origins + 1] = origin end
local function send(origin, enabled)
	now = now + 0.3
	position, active = origin, enabled ~= false
	receivers["cotz/mapscene/visibility"](0, client)
end
check(serverPlugin:SetupPlayerVisibility(client) == nil, "visibility hook does not stop other handlers")
check(#origins == 0, "ordinary players have no extra PVS")
send(staticOrigin)
serverPlugin:SetupPlayerVisibility(client)
check(origins[#origins] == staticOrigin, "distant static camera enters the PVS")
local middle = Vector(22000, 0, 100)
send(middle)
serverPlugin:SetupPlayerVisibility(client)
check(origins[#origins] == middle, "moving scene midpoint enters the PVS")
position = staticOrigin
receivers["cotz/mapscene/visibility"](0, client)
check(client.ixMapSceneOrigin == middle, "rapid updates are rate limited")
send(Vector(22000, 6, 106))
check(client.ixMapSceneOrigin ~= nil, "camera mouse parallax is accepted")
send(Vector(25000, 0, 100))
check(client.ixMapSceneOrigin == nil, "positions beyond a moving scene endpoint are rejected")
send(Vector(22000, 1000, 100))
check(client.ixMapSceneOrigin == nil, "positions off the configured path are rejected")
send(Vector(0 / 0, 0, 0))
check(client.ixMapSceneOrigin == nil, "non-finite positions are rejected")
send(staticOrigin)
send(nil, false)
check(client.ixMapSceneOrigin == nil, "leaving the menu clears camera visibility")
send(staticOrigin)
now = now + 3
local count = #origins
serverPlugin:SetupPlayerVisibility(client)
check(#origins == count, "stale camera visibility expires")
serverPlugin.scenes = {[start] = {finish, Angle(), Angle()}}
send(middle)
check(client.ixMapSceneOrigin == middle, "legacy vector-keyed moving scenes are supported")
serverPlugin.scenes = {{origin = start, start, Angle(), Angle()}}
send(start)
check(client.ixMapSceneOrigin == start, "zero-length moving paths are supported")

CLIENT = true
PLUGIN = {scenes = {{staticOrigin, Angle()}}}
assert(load(source))()
table.IsEmpty = function(value) return next(value) == nil end
table.Random = function(value) return value[1], 1 end
gui = {MousePos = function() return 400, 300 end}
surface = {ScreenWidth = function() return 800 end, ScreenHeight = function() return 600 end}
ix.gui.characterMenu = {IsClosing = function() return false end}
local view = PLUGIN:CalcView()
check(view.origin:DistToSqr(staticOrigin) == 0, "static camera remains unchanged")
check(#messages == 1 and messages[1].active, "rendering a mapscene starts visibility updates")
PLUGIN:CalcView()
check(#messages == 1, "client updates are throttled")
now = now + 0.3
PLUGIN:CalcView()
check(#messages == 2, "active visibility is refreshed")
ix.gui.characterMenu.IsClosing = function() return true end
now = now + 0.3
PLUGIN:CalcView()
check(#messages == 3 and not messages[3].active, "closing the menu sends a stop update")
now = now + 0.3
PLUGIN:CalcView()
check(#messages == 3, "inactive cameras do not send repeated updates")
print("mapscene_visibility_spec: " .. checks .. " checks passed")
