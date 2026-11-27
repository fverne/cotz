-- Run from the addon root: luatex --luaonly tests/spawnsaver_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local timers = {}
timer = {Simple = function(_, callback) timers[#timers + 1] = callback end}
game = {GetMap = function() return "rp_marsh_cs" end}
IsValid = function(value) return value and not value.invalid end
angle_zero = {p = 0, y = 0, r = 0}
local saveOverride, restoreOverride
hook = {Run = function(name)
	if name == "GetCharacterSavePosition" then return saveOverride end
	if name == "GetCharacterRestorePosition" then return restoreOverride end
end}
local vectorMeta = {}
function Vector(x, y, z) return setmetatable({x = x, y = y, z = z}, vectorMeta) end
vectorMeta.__sub = function(a, b) return Vector(a.x - b.x, a.y - b.y, a.z - b.z) end
isvector = function(value) return getmetatable(value) == vectorMeta end
-- Arrival hulls are clear and need no nudge, so the plain height adjustment applies.
util = {TraceHull = function() return {StartSolid = false} end}
ix = {util = {FindClearSpawnPosition = function() end}}
PLUGIN = {}
assert(loadfile("gamemodes/ix_cotz/plugins/spawnsaver.lua"))()

local function point(x, z)
	return Vector(x, 20, z or 30)
end

local function actor()
	local client = {position = point(100), angles = {p = 0, y = 90, r = 0}}
	local character = {data = {}}
	client.character = character
	function client:GetCharacter() return self.character end
	function client:GetPos() return self.position end
	function client:EyeAngles() return self.angles end
	function client:SetPos(value) self.position = value end
	function client:SetEyeAngles(value) self.angles = value end
	function client:OBBMins() return Vector(-16, -16, 0) end
	function client:OBBMaxs() return Vector(16, 16, 72) end
	function character:GetPlayer() return client end
	function character:GetData(key) return self.data[key] end
	function character:SetData(key, value) self.data[key] = value end

	return client, character
end

local function flush()
	local queued = timers
	timers = {}
	for _, callback in ipairs(queued) do callback() end
end

local client, character = actor()
PLUGIN:CharacterPreSave(character)
local saved = character:GetData("pos")
check(saved[1] == client.position and saved[2] == client.angles, "disconnect records position and facing")

-- Helix: PrePlayerLoadedCharacter -> Setup/CharacterLoaded -> Spawn/loadout -> PlayerLoadedCharacter.
PLUGIN:PrePlayerLoadedCharacter(client, character)
client.position = point(999)
check(PLUGIN:CharacterPreSave(character) == nil, "skipping position capture does not block other save hooks")
check(character:GetData("pos") == saved, "setup saves preserve the disconnect location")
PLUGIN:PlayerLoadedCharacter(client, character)
PLUGIN:CharacterPreSave(character)
check(character:GetData("pos") == saved, "load hooks cannot overwrite the location before the deferred restore")
flush()
check(client.position == saved[1] and client.angles == saved[2], "retry restores the original location and facing")
check(character:GetData("pos") == nil, "restored position retains its existing one-shot behavior")
client.position = point(200)
PLUGIN:CharacterPreSave(character)
check(character:GetData("pos")[1] == client.position, "normal saves resume after restoration")

local otherClient, other = actor()
other.data.pos = {point(400), angle_zero, game.GetMap()}
PLUGIN:PrePlayerLoadedCharacter(client, other)
PLUGIN:PlayerLoadedCharacter(client, other)
local before = client.position
flush()
check(client.position == before and other:GetData("pos") ~= nil,
	"a deferred callback cannot teleport a player using a different character or consume that character's location")
otherClient.character = nil
local otherSaved = other:GetData("pos")
PLUGIN:CharacterPreSave(other)
check(other:GetData("pos") == otherSaved, "saving an inactive character preserves its location")

local arriving, arrival = actor()
arrival.data.newpos = {point(500, 80), angle_zero, game.GetMap()}
PLUGIN:PrePlayerLoadedCharacter(arriving, arrival)
PLUGIN:PlayerLoadedCharacter(arriving, arrival)
flush()
check(arriving.position.x == 500 and arriving.position.z == 64 and arrival.data.newpos == nil,
	"cross-server arrivals retain precedence and the existing height adjustment")

saveOverride = {point(700), angle_zero, game.GetMap()}
PLUGIN:CharacterPreSave(character)
check(character.data.pos[1] == saveOverride[1], "hideout outside-position override remains effective")
saveOverride = nil
restoreOverride = {point(800), angle_zero, game.GetMap()}
PLUGIN:PrePlayerLoadedCharacter(client, character)
PLUGIN:PlayerLoadedCharacter(client, character)
flush()
check(client.position == restoreOverride[1], "hideout restoration override remains effective")
restoreOverride = false
character.data.pos = {point(900), angle_zero, game.GetMap()}
before = client.position
PLUGIN:PrePlayerLoadedCharacter(client, character)
PLUGIN:PlayerLoadedCharacter(client, character)
flush()
check(client.position == before, "a restore hook can defer placement for an asynchronous hideout arrival")
restoreOverride = nil
PLUGIN:CharacterPreSave(character)
check(character.data.pos[1] == client.position, "a deferred placement does not permanently disable later saves")

local disconnected, abandoned = actor()
abandoned.data.pos = {point(600), angle_zero, game.GetMap()}
PLUGIN:PrePlayerLoadedCharacter(disconnected, abandoned)
PLUGIN:PlayerLoadedCharacter(disconnected, abandoned)
disconnected.invalid = true
flush()
check(abandoned.data.pos ~= nil, "disconnecting before restoration preserves the location")

print("Spawn Saver: " .. checks .. " checks passed")
