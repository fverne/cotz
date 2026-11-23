local ADDON = "test-addons/cotz_mutant_test/lua/entities/"
local BASE = ADDON .. "cotz_mutant_test_base/"
local registry = {}
local downloads = {}
local errors = {}

SERVER = true
RENDERGROUP_OPAQUE, RENDERGROUP_TRANSLUCENT, RENDERMODE_TRANSCOLOR = 1, 2, 3
HULL_TINY, HULL_WIDE_HUMAN, HULL_HUMAN, MOVETYPE_STEP = 4, 5, 6, 7
DMG_SLASH, DMG_CLUB, DMG_RADIATION = 8, 9, 10

function Vector(x, y, z) return {x, y, z} end
function Color(r, g, b, a) return {r, g, b, a} end
function ErrorNoHalt(message) errors[#errors + 1] = message end
function AddCSLuaFile(fileName) downloads[#downloads + 1] = fileName or "self" end
function include(fileName) dofile(BASE .. fileName) end

list = {
	Set = function(kind, class, data)
		assert(kind == "NPC")
		registry[class] = data
	end,
}

util = {
	IsValidModel = function() return true end,
}

ENT = {}
dofile(BASE .. "init.lua")
local base = ENT
assert(base.Base == "stalker_ai")
assert(downloads[1] == "shared.lua" and downloads[2] == "cl_init.lua")

local function newNPC(class, definition)
	local npc = setmetatable({hits = {}}, {__index = definition})

	function npc:GetClass() return class end
	function npc:SetHullType(value) self.appliedHull = value end
	function npc:STALKERNPCInit(size, moveType)
		assert(moveType == MOVETYPE_STEP and size == definition.hullSize)
	end
	function npc:SetViewOffset(value) self.appliedViewOffset = value end
	function npc:LookupSequence() return 0, 1.4 end
	function npc:SetHealth(value) self.health = value end
	function npc:SetMaxHealth(value) self.maxHealth = value end
	function npc:SetRenderMode(value) self.renderMode = value end
	function npc:SetColor(value) self.appliedColor = value end
	function npc:DrawShadow(value) self.shadow = value end
	function npc:Remove() self.removed = true end
	function npc:STALKERNPCCreateMeleeTable()
		return {damage = {}, damagetype = {}, distance = {}, radius = {}, time = {}, bone = {}}
	end
	function npc:STALKERNPCSetMeleeParams(index, sequence, count, melee, hits, misses)
		local attack = definition.attacks[index]
		assert(sequence == attack.sequence and count == 1)
		assert(hits[1] == definition.hitSound and misses[1] == definition.missSound)
		assert(melee.damage[1] == attack.damage and melee.damagetype[1] == attack.damageType)
		assert(melee.distance[1] == definition.MeleeAttackDistance and melee.bone[1] == attack.bone)
		assert(math.abs(melee.time[1] - 0.2 - attack.windup) < 0.0001)
		self.hits[index] = melee
	end

	return npc
end

for _, id in ipairs({"tarakan", "karlito", "radogeist"}) do
	local class = "npc_mutant_test_" .. id
	ENT = setmetatable({}, {__index = base})
	dofile(ADDON .. class .. ".lua")
	local definition = ENT
	assert(definition.Base == "cotz_mutant_test_base")
	assert(registry[class].Class == class and registry[class].Category == "COTZ Mutant Tests")

	local npc = newNPC(class, definition)
	npc:Initialize()
	assert(not npc.removed)
	assert(npc.health == npc.maxHealth and math.abs(npc.health - definition.hp) <= definition.hpvar)
	assert(npc.appliedHull == definition.hullType and npc.appliedViewOffset == definition.viewOffset)
	assert(#npc.hits == #definition.attacks)

	local nextNpc = newNPC(class, definition)
	nextNpc:Initialize()
	assert(npc.MeleeHitSound ~= nextNpc.MeleeHitSound and npc.MeleeDamageTime ~= nextNpc.MeleeDamageTime)

	if id == "radogeist" then
		assert(npc.hits[1].radius[1] == 360 and npc.hits[1].damagetype[1] == DMG_RADIATION)
		assert(npc.renderMode == RENDERMODE_TRANSCOLOR and npc.appliedColor == definition.tint)
	else
		assert(npc.hits[1].radius[1] == math.rad(definition.attacks[1].arc / 2))
	end

	local badSequence = newNPC(class, definition)
	function badSequence:LookupSequence() return -1, 0 end
	badSequence:Initialize()
	assert(badSequence.removed and #badSequence.hits == 0)
end

assert(#errors == 3)
assert(#downloads == 5)

SERVER = false
ENT = {}
dofile(BASE .. "cl_init.lua")
assert(ENT.Base == "stalker_ai" and ENT.Initialize == nil)
for _, id in ipairs({"tarakan", "karlito", "radogeist"}) do
	ENT = {}
	dofile(ADDON .. "npc_mutant_test_" .. id .. ".lua")
	assert(ENT.Base == "cotz_mutant_test_base" and ENT.Initialize == nil)
end
assert(#downloads == 5)

print("Mutant test addon specs passed")
