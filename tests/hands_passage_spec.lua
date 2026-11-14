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
local deferred = {}
local function flushDeferred()
	local callbacks = deferred
	deferred = {}
	for _, callback in ipairs(callbacks) do callback() end
end
SERVER, CLIENT = true, false
COLLISION_GROUP_PLAYER, COLLISION_GROUP_PASSABLE_DOOR, COLLISION_GROUP_PLAYER_MOVEMENT = 5, 15, 8
MASK_PLAYERSOLID = 123
PLUGIN = {}
FindMetaTable = function() return playerMeta end
IsValid = function(value) return type(value) == "table" and not value.invalid end
timer = {
	Simple = function(delay, callback) deferred[#deferred + 1] = callback end,
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
function playerMeta:GetActiveWeapon() return self.weapon end
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
function playerMeta:SetCustomCollisionCheck(value)
	assert(IsValid(self), "Tried to use a NULL entity!")
	self.customCollision = value
end
function playerMeta:CollisionRulesChanged()
	assert(IsValid(self), "Tried to use a NULL entity!")
	self.collisionUpdates = (self.collisionUpdates or 0) + 1
	self.passageAtRefresh = self.cotzHandsPassage
end
function playerMeta:SetNWVarProxy(key, callback)
	self.proxies = self.proxies or {}
	self.proxies[key] = callback
end
function playerMeta:SetNWBool(key, value) self.nw[key] = value end
function playerMeta:GetNWBool(key, default) if self.nw[key] == nil then return default end return self.nw[key] end
local path = "gamemodes/ix_cotz/plugins/corechanges/sh_handspassage.lua"
dofile(path)
local owner, other = entity(1, 0), entity(2, 100)
check(PLUGIN:ShouldCollide(owner, other) == nil, "ordinary player collisions do not override other handlers")
check(PLUGIN:ShouldCollide({IsSTALKERNPC = true}, {IsSTALKERNPC = true}) == false,
	"the unrelated STALKER NPC collision rule survives")
check(owner:SetHandsPassage(true) and owner.group == 5, "passage preserves the normal collision group")
check(owner.customCollision and owner.passageAtRefresh, "enabling updates cached collision rules immediately")
check(PLUGIN:ShouldCollide(owner, other) == false and PLUGIN:ShouldCollide(other, owner) == false,
	"one enabled player permits passage in both movement directions")
owner.weapon = {GetClass = function() return "weapon_physgun" end}
PLUGIN:PlayerSwitchWeapon(owner)
flushDeferred()
check(PLUGIN:ShouldCollide(owner, other) == nil and PLUGIN:ShouldCollide(other, owner) == nil,
	"physgun targeting retains normal player collisions in both orders")
check(owner:GetHandsPassage() and owner.character.data.cotzHandsPassage,
	"physgun use preserves the saved passage preference")
local previousUpdates = owner.collisionUpdates
PLUGIN:PlayerSwitchWeapon(owner)
flushDeferred()
check(owner.collisionUpdates == previousUpdates, "unchanged weapons do not refresh collision rules")
owner.weapon = nil
PLUGIN:PlayerSwitchWeapon(owner)
flushDeferred()
check(PLUGIN:ShouldCollide(owner, other) == false, "holstering restores passage")
other.weapon = {GetClass = function() return "weapon_physgun" end}
PLUGIN:PlayerSwitchWeapon(other)
flushDeferred()
check(PLUGIN:ShouldCollide(owner, other) == nil, "the target's physgun also preserves collisions")
other.weapon = nil
PLUGIN:PlayerSwitchWeapon(other)
flushDeferred()
PLUGIN:PlayerSwitchWeapon(owner, nil, {GetClass = function() return "weapon_physgun" end})
flushDeferred()
check(PLUGIN:ShouldCollide(owner, other) == false, "a denied switch uses the actual active weapon")
PLUGIN:WeaponEquip({}, owner)
PLUGIN:PlayerSwitchWeapon(owner)
check(#deferred == 1, "multiple weapon events coalesce into one deferred check")
owner.weapon = {GetClass = function() return "weapon_physgun" end}
flushDeferred()
check(PLUGIN:ShouldCollide(owner, other) == nil, "pickup checks the active weapon after equip completes")
owner.weapon = nil
PLUGIN:PlayerDroppedWeapon(owner, {})
flushDeferred()
check(PLUGIN:ShouldCollide(owner, other) == false, "dropping or stripping the physgun restores passage")
owner.weapon = {GetClass = function() return "weapon_physgun" end}
PLUGIN:PlayerSwitchWeapon(owner)
flushDeferred()
owner.alive = false
PLUGIN:PlayerDeath(owner)
flushDeferred()
check(not owner.cotzHandsPhysgun, "death clears the exception even if the active weapon still exists")
owner.alive, owner.weapon = true, nil
PLUGIN:WeaponEquip({}, owner)
owner.invalid = true
flushDeferred()
owner.invalid = nil
check(#deferred == 0, "a queued refresh safely handles a disconnected player")
check(PLUGIN.PlayerPostThink == nil, "passage installs no per-tick player hook")
local prop = {IsPlayer = function() return false end}
check(PLUGIN:ShouldCollide(owner, prop) == nil and PLUGIN:ShouldCollide(prop, owner) == nil,
	"passage preserves collisions with non-player entities")
check(owner:GetHandsPassage() and owner.character.data.cotzHandsPassage and owner.character.saves == 1,
	"enabling saves the per-character toggle immediately")
check(next(timers) == nil, "passage never starts an expiry timer")
other.position = vector(10, 0, 0)
other:SetHandsPassage(true)
check(not owner:SetHandsPassage(false) and owner.group == 5 and owner.character.data.cotzHandsPassage,
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
check(owner.group == 9, "toggling preserves an existing custom collision group")
owner.group = 5
owner:SetHandsPassage(true)
local saved = owner.character.data
local reconnected = entity(3, 200)
reconnected.character = character(saved)
PLUGIN:PostPlayerLoadout(reconnected)
check(reconnected:GetHandsPassage() and reconnected.group == 5, "a fresh player entity restores saved passage")
reconnected.group = 5
PLUGIN:PostPlayerLoadout(reconnected)
check(reconnected.group == 5, "respawning reapplies the saved preference without replacing the engine group")
owner.character = character()
owner.group = 5
other.position = vector(0, 0, 0)
PLUGIN:PostPlayerLoadout(owner)
local pending = timers["cotz/hands/restore-collision/1"]
check(pending and owner:GetHandsPassage() and owner.group == 5 and owner.character.data.cotzHandsPassage == nil,
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
other:SetHandsPassage(false)
check(PLUGIN:ShouldCollide(owner, other) == nil and owner.passageAtRefresh == false,
	"disabling refreshes the cached rule and restores ordinary player collisions")
owner.group, owner.cotzHandsCollisionGroup = 15, 9
owner.nw["cotz/hands/player-passage"] = true
PLUGIN:PostPlayerLoadout(owner)
check(owner.group == 9 and owner.cotzHandsCollisionGroup == nil,
	"loadout restores a collision group left by the previous implementation")
flushDeferred()
SERVER, CLIENT = false, true
owner.nw["cotz/hands/player-passage"] = true
dofile(path)
check(owner:GetHandsPassage() and owner.cotzHandsPassage and owner.customCollision,
	"existing client entities initialize from replicated passage on reload")
local remote = entity(4, 300)
remote.nw["cotz/hands/player-passage"] = true
PLUGIN:NetworkEntityCreated(remote)
check(remote.cotzHandsPassage and remote.customCollision,
	"newly networked players initialize passage for late joiners")
local proxy = remote.proxies["cotz/hands/player-passage"]
local updates = remote.collisionUpdates
remote.invalid = true
proxy(remote, "cotz/hands/player-passage", true, false)
check(remote.collisionUpdates == updates and remote.cotzHandsPassage,
	"a proxy receiving an invalid entity skips collision methods and cached state changes")
remote.invalid = nil
proxy(remote, "cotz/hands/player-passage", true, false)
check(remote.collisionUpdates == updates + 1 and remote.passageAtRefresh == false,
	"replication invalidates collision rules using the proxy value before GetNWBool changes")
owner.proxies["cotz/hands/player-passage"](owner, "cotz/hands/player-passage", true, false)
check(PLUGIN:ShouldCollide(remote, owner) == nil,
	"client collision rules use the updated cache even while NW getters still expose old values")
proxy(remote, "cotz/hands/player-passage", false, true)
check(PLUGIN:ShouldCollide(remote, owner) == false and PLUGIN:ShouldCollide(owner, remote) == false,
	"replicated passage applies symmetrically on the client")
local physgunProxy = remote.proxies["cotz/hands/physgun-active"]
physgunProxy(remote, "cotz/hands/physgun-active", false, true)
check(PLUGIN:ShouldCollide(remote, owner) == nil and PLUGIN:ShouldCollide(owner, remote) == nil,
	"replicated physgun state suspends passage before the NW getter updates")
physgunProxy(remote, "cotz/hands/physgun-active", true, false)
check(PLUGIN:ShouldCollide(remote, owner) == false, "replicated holstering restores passage")
print(string.format("PASS: %d hands passage checks", checks))
