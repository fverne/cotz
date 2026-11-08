-- Run from the repository root: luatex --luaonly tests/hands_passage_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local vectorMeta = {}
vectorMeta.__index = vectorMeta
vectorMeta.__add = function(a, b) return setmetatable({x = a.x + b.x, y = a.y + b.y, z = a.z + b.z}, vectorMeta) end
local function vector(x, y, z) return setmetatable({x = x, y = y, z = z}, vectorMeta) end
local timers, playerMeta, players = {}, {}, {}
SERVER, CLIENT = true, false
COLLISION_GROUP_PLAYER, COLLISION_GROUP_PASSABLE_DOOR, COLLISION_GROUP_PLAYER_MOVEMENT = 5, 15, 8
MASK_PLAYERSOLID = 123
PLUGIN = {}
FindMetaTable = function() return playerMeta end
IsValid = function(value) return type(value) == "table" and not value.invalid end
timer = {
	Remove = function(key) timers[key] = nil end,
	Create = function(key, delay, count, callback) timers[key] = {delay = delay, callback = callback} end,
}
player = {Iterator = function() return ipairs(players) end}
local stuck, allSolid = false, false
util = {TraceHull = function(data)
	check(data.mask == MASK_PLAYERSOLID and data.collisiongroup == COLLISION_GROUP_PLAYER_MOVEMENT,
		"restoration checks normal player movement collisions")
	return {StartSolid = stuck, AllSolid = allSolid}
end}
local function character(data)
	return {data = data or {}, saves = 0,
		GetData = function(self, key, default) if self.data[key] == nil then return default end return self.data[key] end,
		SetData = function(self, key, value) self.data[key] = value end,
		Save = function(self) self.saves = self.saves + 1 end}
end
local function entity(index, x)
	local client = setmetatable({nw = {}, group = 5, character = character(), position = vector(x, 0, 0)},
		{__index = playerMeta})
	function client:EntIndex() return index end
	players[#players + 1] = client
	return client
end
function playerMeta:IsPlayer() return true end
function playerMeta:Alive() return self.alive ~= false end
function playerMeta:IsSolid() return self.solid ~= false end
function playerMeta:Crouching() return self.crouched end
function playerMeta:GetHull() return vector(-16, -16, 0), vector(16, 16, 72) end
function playerMeta:GetHullDuck() return vector(-16, -16, 0), vector(16, 16, 36) end
function playerMeta:GetPos() return self.position end
function playerMeta:GetCharacter() return self.character end
function playerMeta:GetCollisionGroup() return self.group end
function playerMeta:SetCollisionGroup(value) self.group = value end
function playerMeta:SetNWBool(key, value) self.nw[key] = value end
function playerMeta:GetNWBool(key, default) if self.nw[key] == nil then return default end return self.nw[key] end
local path = "gamemodes/ix_cotz/plugins/corechanges/sh_handspassage.lua"
dofile(path)
local owner, other = entity(1, 0), entity(2, 100)
check(PLUGIN:ShouldCollide(owner, other) == nil, "player collisions use engine groups instead of ShouldCollide")
check(PLUGIN:ShouldCollide({IsSTALKERNPC = true}, {IsSTALKERNPC = true}) == false,
	"the unrelated STALKER NPC collision rule survives")
check(owner:SetHandsPassage(true) and owner.group == 15, "passage uses the passable-door collision group")
check(owner:GetHandsPassage() and owner.character.data.cotzHandsPassage and owner.character.saves == 1,
	"enabling saves the per-character toggle immediately")
check(next(timers) == nil, "passage never starts an expiry timer")
other.position = vector(10, 0, 0)
other:SetHandsPassage(true)
check(not owner:SetHandsPassage(false) and owner.group == 15 and owner.character.data.cotzHandsPassage,
	"overlapping another passable character cannot disable passage or change the saved preference")
other.position = vector(100, 0, 0)
stuck = true
check(not owner:SetHandsPassage(false) and owner:GetHandsPassage(), "a world/prop obstruction blocks restoration")
stuck, allSolid = false, true
check(not owner:SetHandsPassage(false), "an all-solid trace also blocks restoration")
allSolid = false
check(owner:SetHandsPassage(false) and owner.group == 5 and not owner.character.data.cotzHandsPassage,
	"moving clear permits disabling and saves the disabled toggle")
owner.group = 9
owner:SetHandsPassage(true)
owner:SetHandsPassage(false)
check(owner.group == 9, "disabling restores the previous collision group")
owner.group = 5
owner:SetHandsPassage(true)
local saved = owner.character.data
local reconnected = entity(3, 200)
reconnected.character = character(saved)
PLUGIN:PostPlayerLoadout(reconnected)
check(reconnected:GetHandsPassage() and reconnected.group == 15, "a fresh player entity restores saved passage")
reconnected.group = 5
PLUGIN:PostPlayerLoadout(reconnected)
check(reconnected.group == 15, "respawning reapplies the saved preference after the engine resets groups")
owner.character = character()
owner.group = 5
other.position = vector(0, 0, 0)
PLUGIN:PostPlayerLoadout(owner)
local pending = timers["cotz/hands/restore-collision/1"]
check(pending and owner:GetHandsPassage() and owner.group == 15 and owner.character.data.cotzHandsPassage == nil,
	"a character switch defers unsafe restoration without enabling passage on the new character")
other.position = vector(100, 0, 0)
pending.callback()
check(not owner:GetHandsPassage() and owner.group == 5 and next(timers) == nil,
	"deferred restoration completes once the overlapping player moves away")
other.position = vector(0, 0, 50)
owner.crouched = true
owner:SetHandsPassage(true)
check(owner:SetHandsPassage(false), "crouching uses the shorter hull when players do not actually overlap")
owner.crouched = false
owner:SetHandsPassage(true)
check(not owner:SetHandsPassage(false), "standing at the same position overlaps the other hull")
other.alive = false
check(owner:SetHandsPassage(false), "a dead player's hull does not block restoration")
other.alive, other.position = true, vector(100, 0, 0)
owner:SetHandsPassage(true)
other.position = vector(0, 0, 0)
owner.character = character()
PLUGIN:PostPlayerLoadout(owner)
local stale = timers["cotz/hands/restore-collision/1"]
owner.character = character({cotzHandsPassage = true})
stale.callback()
check(owner:GetHandsPassage() and not timers["cotz/hands/restore-collision/1"],
	"a pending restoration cannot change a replacement character")
other.position = vector(100, 0, 0)
owner:SetHandsPassage(false)

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
util.TraceLine = function() return {Entity = target} end
IsFirstTimePredicted = function() return true end
function SWEP:GetOwner() return owner end
function SWEP:IsHoldingObject() return held end
function SWEP:SetNextSecondaryFire(value) self.nextSecondary = value end
SWEP:SecondaryAttack()
check(owner:GetHandsPassage() and not owner.message:find("minute", 1, true),
	"lowered right-click enables persistent passage")
other.position = vector(0, 0, 0)
SWEP:SecondaryAttack()
check(owner:GetHandsPassage() and owner.message:find("Move clear", 1, true), "unsafe toggle reports how to move clear")
other.position, target = vector(100, 0, 0), nil
SWEP:SecondaryAttack()
check(not owner:GetHandsPassage(), "another lowered right-click stops passage without aiming at a player")
raised, target = true, other
ix = {config = {Get = function(_, default) return default end}}
function other:IsDoor() return false end
function other:SetVelocity() self.pushed = true end
owner.character.GetAttribute = function() return 0 end
function owner:EmitSound() end
function SWEP:SetNextPrimaryFire() end
SWEP:SecondaryAttack()
check(other.pushed and not owner:GetHandsPassage(), "raised-hand pushing retains its original behavior")
SERVER, CLIENT = false, true
dofile(path)
owner.nw["cotz/hands/player-passage"] = true
check(owner:GetHandsPassage(), "client prediction reads the replicated toggle without a collision proxy")
print(string.format("PASS: %d hands passage checks", checks))
