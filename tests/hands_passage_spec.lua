-- Run from the repository root: luatex --luaonly tests/hands_passage_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local timers, playerMeta = {}, {}
SERVER, CLIENT = true, false
PLUGIN = {}
FindMetaTable = function() return playerMeta end
IsValid = function(value) return type(value) == "table" and not value.invalid end
timer = {
	Remove = function(key) timers[key] = nil end,
	Create = function(key, delay, count, callback) timers[key] = {delay = delay, callback = callback} end,
}
local function entity(isPlayer, index)
	return setmetatable({nw = {}, changes = 0}, {__index = function(_, key)
		if key == "IsPlayer" then return function() return isPlayer end end
		if key == "EntIndex" then return function() return index end end
		return playerMeta[key]
	end})
end
function playerMeta:SetCustomCollisionCheck(value) self.custom = value end
function playerMeta:CollisionRulesChanged() self.changes = self.changes + 1 end
function playerMeta:SetNWBool(key, value) self.nw[key] = value end
function playerMeta:GetNWBool(key, default)
	if self.nw[key] == nil then return default end
	return self.nw[key]
end
local path = "gamemodes/ix_cotz/plugins/corechanges/sh_handspassage.lua"
dofile(path)
local owner, other, prop, npc = entity(true, 1), entity(true, 2), entity(false, 3), entity(false, 4)
check(PLUGIN:ShouldCollide(owner, other) == nil, "ordinary players keep default collisions")
owner:SetHandsPassage(true)
check(PLUGIN:ShouldCollide(owner, other) == false and PLUGIN:ShouldCollide(other, owner) == false,
	"passage ignores player collisions in both entity orders")
check(PLUGIN:ShouldCollide(owner, prop) == nil and PLUGIN:ShouldCollide(npc, owner) == nil,
	"passage preserves prop, NPC and other entity collisions")
check(owner.custom and owner.changes == 1, "enabling passage immediately invalidates cached collision rules")
local expiry = timers["cotz/hands/player-passage/1"]
check(expiry.delay == 60, "passage expires after one minute")
expiry.callback()
check(not owner.cotzHandsPassage and owner.changes == 2, "expiry restores player collisions and invalidates rules")
owner:SetHandsPassage(true)
PLUGIN:PlayerDeath(owner)
check(not owner.cotzHandsPassage and not timers["cotz/hands/player-passage/1"], "death clears passage and expiry")

-- Load the actual schema SWEP, translating its legacy GLua operators for standalone Lua.
SWEP = {Primary = {}, Secondary = {}}
Model = function(value) return value end
Angle = function() return {} end
AddCSLuaFile = function() end
hook = {Add = function() end}
CurTime = function() return 100 end
local source = assert(io.open("gamemodes/ix_cotz/entities/weapons/ix_hands.lua")):read("*a")
source = source:gsub("!=", "~="):gsub("!", "not ")
assert(load(source, "@ix_hands.lua"))()
local raised, held, target = false, false, other
function owner:GetShootPos() return setmetatable({}, {__add = function() return {} end}) end
function owner:GetAimVector() return setmetatable({}, {__mul = function() return {} end}) end
function owner:IsWepRaised() return raised end
function owner:Notify(message) self.message = message end
util = {TraceLine = function() return {Entity = target} end}
IsFirstTimePredicted = function() return true end
function SWEP:GetOwner() return owner end
function SWEP:IsHoldingObject() return held end
function SWEP:SetNextSecondaryFire(value) self.nextSecondary = value end
SWEP:SecondaryAttack()
check(owner.cotzHandsPassage and owner.message:find("one minute", 1, true),
	"lowered right-click on another player enables passage instead of pushing")
target = nil
SWEP:SecondaryAttack()
check(not owner.cotzHandsPassage, "another lowered right-click stops passage even without aiming at a player")

raised, target = true, other
ix = {config = {Get = function(_, default) return default end}}
function other:IsDoor() return false end
function other:SetVelocity() self.pushed = true end
function owner:GetCharacter() return {GetAttribute = function() return 0 end} end
function owner:EmitSound() end
function SWEP:SetNextPrimaryFire() end
SWEP:SecondaryAttack()
check(other.pushed and not owner.cotzHandsPassage, "raised-hand pushing retains its original behavior")

SERVER, CLIENT = false, true
dofile(path)
function owner:SetNWVarProxy(key, callback) self.proxy = callback end
owner.nw["cotz/hands/player-passage"] = true
PLUGIN:NetworkEntityCreated(owner)
check(owner.cotzHandsPassage, "a newly visible player initializes its replicated passage state")
owner.proxy(owner, "cotz/hands/player-passage", true, false)
check(not owner.cotzHandsPassage, "client network changes refresh cached player collision state")
print(string.format("PASS: %d hands passage checks", checks))
