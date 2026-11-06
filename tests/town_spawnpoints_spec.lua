-- Run from the repository root: luatex --luaonly tests/town_spawnpoints_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local function copy(value)
	if type(value) ~= "table" then return value end
	local result = setmetatable({}, getmetatable(value))
	for key, entry in pairs(value) do result[key] = copy(entry) end

	return result
end

table.Copy = copy
local vectorMeta = {}
vectorMeta.__index = vectorMeta
function Vector(x, y, z) return setmetatable({x = x, y = y, z = z}, vectorMeta) end
function vectorMeta:DistToSqr(other)
	return (self.x - other.x) ^ 2 + (self.y - other.y) ^ 2 + (self.z - other.z) ^ 2
end
function Angle(p, y, r) return {p = p, y = y, r = r} end
function IsValid(value) return type(value) == "table" and not value.invalid end
function SortedPairs(value)
	local keys = {}
	for key in pairs(value) do keys[#keys + 1] = key end
	table.sort(keys)
	local index = 0

	return function()
		index = index + 1
		local key = keys[index]
		if key then return key, value[key] end
	end
end

SERVER, CLIENT = true, false
HUD_PRINTCONSOLE = 2
bit = {bor = function(first, second) return first + second end}
local map = "rp_marsh_cs"
game = {GetMap = function() return map end}
local commands, savedData, warnings = {}, {}, {}
ErrorNoHalt = function(message) warnings[#warnings + 1] = message end
local base = "gamemodes/ix_cotz/plugins/"
local contact = {id = "mute", name = "Mute", map = map}
local townPlugin = {
	contacts = {mute = contact}, byName = {Mute = contact}, siteDefinitions = {},
	SetData = function(_, data) savedData = copy(data) end,
	GetData = function() return copy(savedData) end,
}
PLUGIN = townPlugin
ENT = {}
dofile(base .. "vendor_adv/entities/entities/ix_vendor_adv.lua")
local npc = setmetatable({position = Vector(0, 0, 0), angles = Angle(0, 45, 0),
	idle = "normal_idle", spawnAnim = "", sequence = -1, resets = 0, group = 0}, {__index = ENT})
function npc:GetPos() return self.position end
function npc:SetPos(value) self.position = value end
function npc:GetAngles() return self.angles end
function npc:SetAngles(value) self.angles = value end
function npc:GetDisplayName() return "Mute" end
function npc:GetIdleAnim() return self.idle end
function npc:GetTownSpawnAnim() return self.spawnAnim end
function npc:SetTownSpawnAnim(value) self.spawnAnim = value end
function npc:GetAnimGroupId() return self.group end
function npc:LookupSequence(name)
	return ({work = 0, sit = 2, normal_idle = 3})[name] or -1
end
function npc:GetSequence() return self.sequence end
function npc:IsSequenceFinished() return self.finished end
function npc:ResetSequence(value)
	self.sequence, self.finished = value, false
	self.resets = self.resets + 1
end
function npc:SetCycle(value) self.cycle = value end
ents = {FindByClass = function() return {npc} end}
ix = {
	type = {string = 1, optional = 8, bool = 2},
	command = {Add = function(name, data) commands[name] = data end},
	progression = {GetNPCFromName = function() return npc end},
	plugin = {Get = function(id) return id == "townnpcs" and townPlugin or nil end},
	util = {Include = function() end},
}
dofile(base .. "townnpcs/libs/sv_spawnpoints.lua")
dofile(base .. "townnpcs/libs/sv_sites.lua")
local position = Vector(0, 0, 0)
local output = {}
local client = {
	GetPos = function() return position end,
	GetAngles = function() return Angle(0, 90, 0) end,
	PrintMessage = function(_, _, message) output[#output + 1] = message end,
}
for _, name in ipairs({"TownNPCAddSpawnPoint", "TownNPCClearSpawnPoints", "TownNPCExportSpawnPoints"}) do
	check(commands[name].adminOnly, name .. " requires administrator access")
end
local add = commands.TownNPCAddSpawnPoint.OnRun
add(nil, client, "mute", "missing")
check(townPlugin.spawnPoints == nil, "invalid animation cannot modify saved points")
add(nil, client, "unknown", "sit")
map = "another"
add(nil, client, "mute", "sit")
check(townPlugin.spawnPoints == nil, "unknown and foreign contacts cannot acquire points")
map = contact.map
add(nil, client, "mute", "sit")
local points = townPlugin.spawnPoints[map].mute
check(#points == 1 and points[1].idleanim == "sit", "original location can receive its own animation")
position = Vector(1000, 0, 0)
add(nil, client, "mute", "work")
check(#points == 2 and points[2].idleanim == "work", "alternate accepts sequence ID zero")
check(points[2].angles.y == 90 and points[1].angles.y == 45, "both points retain their own facing")
check(npc:GetPos().x == 0 and npc:GetTownSpawnAnim() == "", "authoring does not change the live NPC")
add(nil, client, "mute")
check(#points == 2, "duplicate without an animation is rejected")
commands.TownNPCExportSpawnPoints.OnRun(nil, client)
local exported = assert(load("return {" .. table.concat(output) .. "}"))().townnpcs
check(exported.mute[2].idleanim == "work", "console export is valid preset Lua with per-point animations")
check(exported.mute[1].position.x == 0 and exported.mute[2].angles.y == 90, "export retains transforms")

math.random = function() return 1 end
townPlugin:LoadData()
townPlugin:ApplyTownSpawnPoints()
check(npc.position.x == 1000 and npc.spawnAnim == "work" and npc.sequence == 0,
	"restart selects a new location and applies its animation")
check(savedData.lastSpawnPositions[map].mute.x == 1000, "selection history is saved immediately")
check(npc.idle == "normal_idle", "spawn override preserves the vendor's saved default animation")
townPlugin:ApplyTownSpawnPoints()
check(npc.position.x == 1000, "repeated PostLoadData does not move the contact again")
local resets = npc.resets
npc.group = 99
npc:SetAnim()
check(npc.resets == resets, "random gesture requests do not interrupt a placement animation")
npc.finished = true
npc:SetAnim()
check(npc.resets == resets + 1 and npc.cycle == 0, "completed placement animation restarts from its beginning")
npc.group = 0
townPlugin.spawnPositionsApplied = nil
townPlugin:LoadData()
townPlugin:ApplyTownSpawnPoints()
check(npc.position.x == 0 and npc.spawnAnim == "sit", "next restart excludes the persisted previous position")
townPlugin.spawnPoints[map].mute[2].idleanim = "removed_from_model"
townPlugin:SaveData()
townPlugin.spawnPositionsApplied = nil
townPlugin:LoadData()
townPlugin:ApplyTownSpawnPoints()
check(#warnings == 1 and npc.spawnAnim == "" and npc.sequence == 3,
	"invalid saved sequence is reported and falls back to normal vendor animation")
townPlugin.spawnPoints[map].mute[1].idleanim = nil
townPlugin:SaveData()
townPlugin.spawnPositionsApplied = nil
townPlugin:LoadData()
townPlugin:ApplyTownSpawnPoints()
check(npc.position.x == 0 and npc.spawnAnim == "", "legacy position-only points use normal vendor animation")
position = Vector(0, 0, 0)
add(nil, client, "mute", "default")
check(townPlugin.spawnPoints[map].mute[1].idleanim == "", "default clears an existing point's animation override")
for index = 3, 16 do
	townPlugin.spawnPoints[map].mute[index] = {position = Vector(index * 1000, 0, 0), angles = Angle(0, 0, 0)}
end
add(nil, client, "mute", "sit")
check(townPlugin.spawnPoints[map].mute[1].idleanim == "sit", "animation editing works at the point limit")
position = Vector(17000, 0, 0)
add(nil, client, "mute", "sit")
check(#townPlugin.spawnPoints[map].mute == 16, "additional points cannot exceed the command limit")

-- Load the real FTS entry point with only its legacy inequality spelling translated for standalone Lua.
PLUGIN = {}
local file = assert(io.open(base .. "firsttimesetup/sh_plugin.lua"))
local source = file:read("*a"):gsub("!=", "~=")
file:close()
assert(load(source))()
local setupPlugin = PLUGIN
for _, name in ipairs({"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"}) do
	dofile(base .. "firsttimesetup/presets/sh_" .. name .. ".lua")
	check(type(setupPlugin.map_presets[name].plugindata.townnpcs) == "table", "preset supports town points: " .. name)
end
local deploy = setupPlugin.PluginDataDeployFunctions.townnpcs
townPlugin.spawnPoints.another = {other = {}}
local previous = townPlugin.spawnPoints[map]
deploy(nil, map)
deploy({mute = {}}, "another")
check(townPlugin.spawnPoints[map] == previous and townPlugin.spawnPoints.another.other,
	"missing optional data and foreign-map deployment preserve existing points")
deploy(exported, map)
check(#townPlugin.spawnPoints[map].mute == 2 and townPlugin.spawnPoints.another.other,
	"FTS imports current map points and preserves other maps")
check(townPlugin.lastSpawnPositions[map] == nil and savedData.spawnPoints[map].mute[2].idleanim == "work",
	"FTS saves imported poses and resets only the deployed map's history")
exported.mute[2].idleanim = "sit"
check(townPlugin.spawnPoints[map].mute[2].idleanim == "work", "runtime edits cannot mutate preset definitions")
local dumped = setupPlugin.PluginDataGetFunctions.townnpcs()
local formatted = setupPlugin.PluginDataFormatFunctions.townnpcs("mute", dumped.mute)
local roundTrip = assert(load("return {" .. formatted .. "}"))()
check(roundTrip.mute[2].idleanim == "work", "FTSDumpPluginData formatter retains animations")
check(npc.position.x == 0 and townPlugin.spawnPositionsApplied, "FTS import leaves live placement until restart")
townPlugin.spawnPositionsApplied = nil
townPlugin:LoadData()
townPlugin:ApplyTownSpawnPoints()
check(npc.position.x == 1000 and npc.spawnAnim == "work", "imported FTS points apply at the next restart")
local getPlugin = ix.plugin.Get
ix.plugin.Get = function() end
check(next(setupPlugin.PluginDataGetFunctions.townnpcs()) == nil, "FTS dump tolerates a disabled town plugin")
deploy(exported, map)
ix.plugin.Get = getPlugin
commands.TownNPCClearSpawnPoints.OnRun(nil, client, "mute")
check(townPlugin.spawnPoints[map].mute == nil and townPlugin.lastSpawnPositions[map].mute == nil,
	"clear removes both points and restart history")
check(npc.position.x == 1000, "clear leaves the live NPC in place")

SERVER, CLIENT = false, true
ENT = {}
dofile(base .. "vendor_adv/entities/entities/ix_vendor_adv.lua")
local clientNPC = setmetatable(copy(npc), {__index = ENT})
CurTime = function() return 10 end
function clientNPC:GetNoBubble() return true end
function clientNPC:SetNextClientThink() end
clientNPC.nextNoise, clientNPC.nextAnimCheck = 100, 100
clientNPC.spawnAnim, clientNPC.townSpawnAnim = "sit", "work"
clientNPC:Think()
check(clientNPC.sequence == 2, "client reacts to the networked placement animation before its periodic check")
resets = clientNPC.resets
clientNPC.finished = true
clientNPC:Think()
check(clientNPC.resets == resets + 1, "client loops a finished placement sequence without waiting 15 seconds")
clientNPC:Think()
check(clientNPC.resets == resets + 1, "client leaves an unfinished placement sequence playing")
clientNPC.spawnAnim = ""
clientNPC:Think()
check(clientNPC.sequence == 3, "client returns to ordinary vendor idle when the override disappears")

print("town_spawnpoints_spec: " .. checks .. " checks passed")
