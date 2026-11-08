-- Run from the addon root: luatex --luaonly tests/town_preview_spec.lua
local checks = 0
local function check(value, message) checks = checks + 1 assert(value, message) end
SERVER, CLIENT = true, false
function Vector(x, y, z) return {x = x, y = y, z = z} end
function Angle(p, y, r) return {p = p, y = y, r = r} end
IsValid = function(value) return type(value) == "table" and not value.invalid end
local position = setmetatable(Vector(1, 2, 3), {__add = function(self) return self end})
function position:DistToSqr(other) return other.distance or 0 end
local client = {GetEyeTraceNoCursor = function() return {HitPos = position, HitNormal = position} end,
	EyeAngles = function() return Angle(30, 45, 10) end,
	GetPos = function() return position end, IsPlayer = function() return true end,
	IsAdmin = function(self) return not self.demoted end}
local now = 0
CurTime = function() return now end
local packet, receiver
util = {AddNetworkString = function() end}
net = {Start = function() end, WriteEntity = function(npc) packet = npc end, Send = function() end,
	Receive = function(_, callback) receiver = callback end}
local created, undone = {}, {}
local defaultIdle = "pose_zero"
local function create(class)
	local npc = {class = class}
	function npc:GetClass() return self.class end
	function npc:SetPos(value) self.position = value end
	function npc:SetAngles(value) self.angles = value end
	function npc:Spawn() self.spawned = true end
	function npc:LoadTemplate(value) self.template = value end
	function npc:LookupSequence(value) return value == "pose_zero" and 0 or -1 end
	function npc:GetPos() return self.position end
	function npc:GetIdleAnim() return defaultIdle end
	function npc:GetSequenceCount() return 1 end
	function npc:GetSequenceName(index) return index == 0 and "pose_zero" or "" end
	function npc:Remove() self.invalid = true end
	function npc:SetNoBubble(value) self.noBubble = value end
	function npc:SetTownSpawnAnim(value) self.animation = value end
	function npc:SetAnim() self.played = true end
	created[#created + 1] = npc

	return npc
end
ents = {Create = create, FindByClass = function(class)
	local result = {}
	for _, npc in ipairs(created) do
		if npc.class == class and not npc.invalid then result[#result + 1] = npc end
	end
	return result
end}
undo = {Create = function() end, AddEntity = function(npc) undone[#undone + 1] = npc end,
	SetPlayer = function() end, Finish = function() end}
ix = {npctemplates = {templates = {medicnpc = {}}}}
PLUGIN = {contacts = {jitters = {template = "medicnpc"}}}
dofile("gamemodes/ix_cotz/plugins/townnpcs/libs/sv_preview.lua")
local town = PLUGIN
check(town:RunCommandTownNPCPreview(client, "missing", "pose_zero"):find("Unknown") and #created == 0,
	"unknown contacts and templates cannot spawn previews")
town:RunCommandTownNPCPreview(client, "jitters", "pose_zero")
local first = created[1]
check(first.template == "medicnpc" and first.animation == "pose_zero" and first.played,
	"contact slugs resolve templates and sequence index zero is accepted")
check(first.angles.p == 0 and first.angles.y == 45 and first.angles.r == 0,
	"preview uses the administrator's yaw without pitch or roll")
check(first.class == "ix_townnpc_preview" and first.noBubble and undone[1] == first,
	"preview uses its isolated class and participates in undo")
town:RunCommandTownNPCPreview(client, "medicnpc", "missing")
check(created[2].invalid and not first.invalid, "an invalid sequence removes only the rejected preview")
town:RunCommandTownNPCPreview(client, "medicnpc", "pose_zero")
check(first.invalid and not created[3].invalid, "a new pose replaces the administrator's previous preview")
local secondClient = setmetatable({}, {__index = client})
town:RunCommandTownNPCPreview(secondClient, "jitters", "pose_zero")
check(not created[3].invalid and not created[4].invalid, "administrators have independent previews")
town:PlayerDisconnected(client)
check(created[3].invalid and not created[4].invalid, "disconnect cleans up only the departing administrator")
local preview = created[4]
town:OpenTownNPCPreview(secondClient, preview)
check(packet == preview, "owner can open their nearby preview picker")
packet = nil
town:OpenTownNPCPreview(secondClient, preview)
check(packet == nil, "picker opens are rate limited")
check(not town:SetTownNPCPreviewSequence(client, preview, 0), "another administrator cannot change this preview")
check(town:SetTownNPCPreviewSequence(secondClient, preview, 0), "owner can select sequence index zero")
check(not town:SetTownNPCPreviewSequence(secondClient, preview, 0), "sequence changes are server rate limited")
now = 1
check(not town:SetTownNPCPreviewSequence(secondClient, preview, 1), "out-of-range sequences are rejected")
now = 2
preview.position.distance = 192 ^ 2 + 1
check(not town:SetTownNPCPreviewSequence(secondClient, preview, 0), "distant preview changes are rejected")
preview.position.distance = nil
secondClient.demoted = true
check(not town:SetTownNPCPreviewSequence(secondClient, preview, 0), "permissions are rechecked after demotion")
secondClient.demoted = nil
net.ReadEntity = function() return preview end
net.ReadUInt = function(bits) check(bits == 16, "sequence index has a bounded typed payload") return 0 end
receiver(nil, secondClient)
check(preview.animation == "pose_zero", "network handler applies a validated owner selection")
function secondClient:GetEyeTraceNoCursor() return {Entity = preview} end
dofile("gamemodes/ix_cotz/plugins/townnpcs/libs/sv_spawnpoints.lua")
town:RunCommandTownNPCGetSpawnPoint(secondClient)
check(packet == preview, "existing spawn-point capture accepts the disposable subclass")
ENT = {}
dofile("gamemodes/ix_cotz/plugins/townnpcs/entities/entities/ix_townnpc_preview.lua")
check(ENT.Base == "ix_vendor_adv" and ENT.bNoPersist and not ENT.isVendor
	and not ENT:CanAccess(client) and not ENT:CanTalkTo(client), "preview cannot trade, talk or persist")
local source = assert(io.open("gamemodes/ix_cotz/plugins/vendor_adv/sh_plugin.lua")):read("*a")
local save = assert(source:match("(function PLUGIN:SaveData%(%)\n.-)\n\tfunction PLUGIN:LoadData"))
table.Add = function(firstList, secondList)
	for _, value in ipairs(secondList) do firstList[#firstList + 1] = value end
end
PLUGIN = {SetData = function(self, value) self.saved = value end}
assert(load(save))()
PLUGIN:SaveData()
check(#PLUGIN.saved == 0, "the real vendor save routine does not save posing copies")
ix.progression = {}
local lookup = assert(io.open("gamemodes/ix_cotz/plugins/progression/libs/sh_progression.lua")):read("*a")
lookup = assert(lookup:match("(function ix.progression.GetNPCFromName.-)\nfunction ix.progression.CanBuyItem"))
assert(load(lookup))()
check(ix.progression.GetNPCFromName("Jitters") == nil, "posing copies cannot satisfy contact lookup")
town:OnUnload()
check(preview.invalid, "plugin unload removes remaining posing copies")
town:RunCommandTownNPCPreview(client, "jitters")
check(created[#created].animation == "pose_zero", "omitted sequence uses the model's configured idle")
defaultIdle = "missing"
town:RunCommandTownNPCPreview(client, "jitters")
check(created[#created].animation == "pose_zero", "missing configured idle falls back to the first model sequence")
town:OnUnload()
print("PASS: " .. checks .. " town preview checks")
