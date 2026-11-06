-- Focused regressions for the November playtest fixes; run from the addon root.
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local function method(path, name)
	local file = assert(io.open(path))
	local text = file:read("*a")
	file:close()
	local start = assert(text:find(name, 1, true))
	local finish = text:find("\nend", start, true)
	local source = text:sub(start, finish + 3):gsub("!=", "~="):gsub("!", "not ")
	assert(load(source))()
end
Schema, PLUGIN, SWEP = {}, {}, {}
method("gamemodes/ix_cotz/schema/sh_hooks.lua", "function Schema:CanPlayerInteractItem(")
local client = {Alive = function() return false end, GetLocalVar = function() return false end}
isentity = function(value) return type(value) == "table" and value.isEntity end
isnumber = function(value) return type(value) == "number" end
ix = {item = {instances = {[1] = {invID = 10}, [2] = {invID = 0}}}}
check(Schema:CanPlayerInteractItem(client, "use", 1) == false,
	"dead clients cannot use an inventory item sent by instance ID")
check(Schema:CanPlayerInteractItem(client, "use", {invID = 10}) == false,
	"dead clients cannot use an inventory item table")
check(Schema:CanPlayerInteractItem(client, "take", {isEntity = true}) == nil,
	"world entity interactions keep their existing rules")
check(Schema:CanPlayerInteractItem(client, "use", 2) == nil,
	"world instances keep their existing rules")
check(Schema:CanPlayerInteractItem(client, "use", 999) == nil,
	"unknown item IDs are left to the dispatcher's validation")
client.Alive = function() return true end
check(Schema:CanPlayerInteractItem(client, "use", 1) == nil,
	"living clients continue to other validators")
method("gamemodes/ix_cotz/plugins/arena/sv_plugin.lua", "function PLUGIN:CanPlayerInteractItem(")
check(PLUGIN:CanPlayerInteractItem(client) == nil, "arena allows later item validation")
client.GetLocalVar = function() return true end
check(PLUGIN:CanPlayerInteractItem(client) == false, "arena spectators remain blocked")
method("gamemodes/ix_cotz/plugins/suits/sh_plugin.lua", "function PLUGIN:EntityTakeDamage(")
hook = {Run = function() end}
client.IsPlayer = function() return true end
client.Alive = function() return false end
PLUGIN:EntityTakeDamage(client, {GetAttacker = function() error("dead suit processing continued") end})
check(true, "dead players exit suit damage before looking up armor")
IsValid = function(entity) return type(entity) == "table" and not entity.invalid end
method("lua/weapons/cw_base/cl_model.lua", "function SWEP:getMuzzlePosition(")
method("lua/weapons/cw_base/cl_model.lua", "function SWEP:GetTracerOrigin(")
SWEP.dt = {}
SWEP.GetPos = function() return "weapon position" end
check(SWEP:getMuzzlePosition() == nil, "missing viewmodel has no attachment")
check(SWEP:GetTracerOrigin() == "weapon position", "missing attachment uses weapon position")
SWEP.CW_VM = {invalid = true, GetAttachment = function() error("NULL entity accessed") end}
check(SWEP:getMuzzlePosition() == nil, "removed viewmodel is never dereferenced")
SWEP.CW_VM = {GetAttachment = function() return {Pos = "muzzle position"} end}
check(SWEP:GetTracerOrigin() == "muzzle position", "valid viewmodel keeps tracer origin")
local Vec = {}
Vec.__index = Vec
function Vector(x, y, z) return setmetatable({x = x, y = y, z = z}, Vec) end
function Vec.__sub(a, b) return Vector(a.x - b.x, a.y - b.y, a.z - b.z) end
function Vec:LengthSqr() return self.x ^ 2 + self.y ^ 2 + self.z ^ 2 end
function Vec:DistToSqr(other) return (self - other):LengthSqr() end
function Angle(_, y) return {y = y} end
local now = 0
CurTime = function() return now end
local commands = {}
local npc = {position = Vector(0, 0, 0), angles = Angle(0, 0), vars = {}}
function npc:GetPos() return self.position end
function npc:SetPos(position) self.position = position end
function npc:GetAngles() return self.angles end
function npc:SetAngles(angles) self.angles = angles end
function npc:GetNetVar(key, default) return self.vars[key] or default end
function npc:SetNetVar(key, value) self.vars[key] = value end
function npc:SetTownSpawnAnim(animation) self.spawnAnimation = animation end
function npc:SetAnim() end
ix = {type = {string = 1}, command = {Add = function(name, data) commands[name] = data end},
	progression = {GetNPCFromName = function() return npc end}}
game = {GetMap = function() return "test" end}
local contact = {id = "mute", name = "Mute", map = "test"}
local savedData = {}
PLUGIN = {contacts = {mute = contact}, byName = {Mute = contact},
	siteDefinitions = {recovery = {test = {{Vector(25, 0, 0)}}}}}
PLUGIN.SetData = function(_, data) savedData = data end
PLUGIN.GetData = function() return savedData end
table.Copy = function(value)
	local result = {}
	for key, entry in pairs(value) do result[key] = entry end

	return result
end
util = {AddNetworkString = function() end}
dofile("gamemodes/ix_cotz/plugins/townnpcs/libs/sh_commands.lua")
dofile("gamemodes/ix_cotz/plugins/townnpcs/libs/sv_spawnpoints.lua")
dofile("gamemodes/ix_cotz/plugins/townnpcs/libs/sv_sites.lua")
check(commands.TownNPCGetSpawnPoint.adminOnly and commands.TownNPCClearSpawnPoints.adminOnly,
	"spawn point capture and edits require admin permission")
local points = {
	{position = Vector(0, 0, 0), angles = Angle(0, 0)},
	{position = Vector(1000, 0, 0), angles = Angle(0, 90)},
}
PLUGIN.spawnPoints = {test = {mute = points}}
PLUGIN:SaveData()
PLUGIN.spawnPoints = nil
PLUGIN:LoadData()
check(#PLUGIN.spawnPoints.test.mute == 2, "spawn points survive save and reload")
check(#PLUGIN.recoveryPoints.test == 1, "loading spawn positions preserves field sites")
ents = {FindByClass = function() return {npc} end}
npc.GetDisplayName = function() return "Mute" end
math.random = function() return 1 end
PLUGIN:ApplyTownSpawnPoints()
check(npc.position.x == 1000, "first restart chooses a different point on the same map")
check(savedData.lastSpawnPositions.test.mute.x == 1000, "previous restart selection is persisted")
check(not PLUGIN.Think and not PLUGIN.StepTownPatrol, "no patrol tick or walking behavior remains")
PLUGIN:ApplyTownSpawnPoints()
check(npc.position.x == 1000, "repeated startup calls do not move contacts during a session")
-- Simulate restart with a stale vendor save still at the original location.
npc.position = Vector(0, 0, 0)
PLUGIN.spawnPositionsApplied = nil
PLUGIN:LoadData()
PLUGIN:ApplyTownSpawnPoints()
check(npc.position.x == 0, "next restart excludes the persisted previous selection")
PLUGIN.spawnPositionsApplied = nil
PLUGIN:LoadData()
PLUGIN:ApplyTownSpawnPoints()
check(npc.position.x == 1000, "following restart changes position again")
commands.TownNPCClearSpawnPoints.OnRun(nil, client, "mute")
check(not PLUGIN.spawnPoints.test.mute and npc.position.x == 1000,
	"clearing points leaves the NPC stationary")
PLUGIN.spawnPositionsApplied = nil
PLUGIN:ApplyTownSpawnPoints()
check(npc.position.x == 1000, "unconfigured contacts retain their normal vendor position")
savedData = {patrolPoints = {test = {mute = points}}}
PLUGIN:LoadData()
check(#PLUGIN.spawnPoints.test.mute == 2, "previous patrol points are retained as spawn positions")
PLUGIN:SaveData()
check(savedData.spawnPoints.test.mute and not savedData.patrolPoints,
	"saving migrates the obsolete patrol key without losing positions")
local function squadMember(id, position)
	return {GetCharacter = function() return {GetSquadID = function() return id end} end,
		GetNWEntity = function() return nil end, GetPos = function() return position end}
end
local observer = squadMember("one", Vector(0, 0, 0))
local member = squadMember("one", Vector(50, 0, 0))
local stranger = squadMember("two", Vector(75, 0, 0))
local corpse = {GetPos = function() return Vector(150, 0, 0) end}
member.GetNWEntity = function() return corpse end
player = {GetHumans = function() return {observer, member, stranger} end}
local origins = {}
AddOriginToPVS = function(position) origins[#origins + 1] = position end
local file = assert(io.open("gamemodes/ix_cotz/plugins/squads/sv_hooks.lua"))
local source = file:read("*a")
file:close()
local visibilityStart = assert(source:find("local visibilityMembers", 1, true))
assert(load(source:sub(visibilityStart)))()
PLUGIN:SetupPlayerVisibility(observer)
check(#origins == 1 and origins[1].x == 150, "squad visibility follows the corpse and excludes other squads")
member.GetCharacter = function() return {GetSquadID = function() return "two" end} end
origins = {}
PLUGIN:SetupPlayerVisibility(observer)
check(#origins == 0, "leaving a squad immediately removes its visibility access")
SERVER = true
local chatPacket
ix.chat = {Send = function(_, kind, text, _, receivers, data)
	chatPacket = {kind = kind, text = text, receivers = receivers, data = data}
end}
ix.config = {Get = function(_, default) return default end}
local present = true
npc.GetDisplayName = function() return "Mute" end
ents = {FindByClass = function() return present and {npc} or {} end}
local recipient = {GetPos = function() return Vector(0, 0, 0) end}
local distant = {GetPos = function() return Vector(1000, 0, 0) end}
player.GetHumans = function() return {recipient, distant} end
local character = {GetPlayer = function() return recipient end}
recipient.GetCharacter = function() return character end
recipient.Notify = function(_, text) recipient.notice = text end
dofile("gamemodes/ix_cotz/plugins/progression/libs/sh_progression.lua")
ix.progression.Notify(character, "Mute", "A local notice.")
check(chatPacket.kind == "cotz_npc_say" and #chatPacket.receivers == 1,
	"NPC speech uses local named chat and excludes distant listeners")
check(chatPacket.data.name == "Mute", "NPC speech retains the speaker name")
present = false
chatPacket = nil
ix.progression.Notify(character, "Mute", "A private notice.")
check(not chatPacket and recipient.notice == "Mute: A private notice.",
	"an absent NPC gives the affected character a private notification")
print("Playtest fixes: " .. checks .. " checks passed")
