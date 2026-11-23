local ADDON = "test-addons/cotz_workshop_mutants/lua/"
local BASE = ADDON .. "entities/cotz_workshop_mutant_base/"
local ROSTER = "cotz_workshop_mutants/roster.lua"
local CATEGORY = "COTZ Workshop Mutants"
local PREFIX = "npc_mutant_workshop_"
local roster = dofile(ADDON .. ROSTER)
local sources = {}
local count = 0

for id, profile in pairs(roster) do
	assert(not sources[profile.source], profile.source)
	assert(id:match("^[a-z0-9_]+$"), id)
	assert(profile.name and profile.name ~= "", id)
	sources[profile.source] = true
	count = count + 1
	if profile.summon then assert(roster[profile.summon], id) end
	if profile.models then
		assert(profile.health > 0 and #profile.models > 0 and #profile.bounds == 3, id)
		assert(profile.movement ~= "fly" and profile.movement ~= "swim" or profile.speed > 0, id)
		for _, action in ipairs({"melee", "leap", "ranged"}) do
			local attack = profile[action]
			if attack then
				assert(attack.windup > 0 and attack.range > 0 and attack.damage, id)
				if attack.cooldown then assert(attack.cooldown >= 1.7, id) end
			end
		end
	else
		assert(profile.variants and #profile.variants == 5, id)
		for _, variant in ipairs(profile.variants) do assert(roster[variant].models, variant) end
	end
end
assert(count == 132 and sources.vj_sent_phantom)

RENDERGROUP_OPAQUE, RENDERGROUP_TRANSLUCENT, ACT_WALK, ACT_RUN = 1, 2, 3, 4
local registrations, spawnMenu
function include(fileName)
	if fileName == ROSTER then return roster end
	return dofile(BASE .. fileName)
end

function AddCSLuaFile() end
function Vector(x, y, z) return {x, y, z} end

scripted_ents = {
	Register = function(entity, class)
		assert(not registrations[class] and class:sub(1, #PREFIX) == PREFIX)
		assert(entity.Base == "cotz_workshop_mutant_base" and entity.Type == "ai")
		registrations[class] = entity
	end,
}
list = {
	Set = function(kind, class, data)
		assert(kind == "NPC" and data.Class == class and data.Category == CATEGORY)
		spawnMenu[class] = data.Name
	end,
}

for _, server in ipairs({true, false}) do
	SERVER = server
	registrations, spawnMenu = {}, {}
	dofile(ADDON .. "cotz_workshop_mutants/sh_register.lua")
	for id, profile in pairs(roster) do
		local class = PREFIX .. id
		assert(spawnMenu[class] == profile.name, id)
		assert(registrations[class].workshopProfile == (server and profile or nil), id)
	end
	if server then assert(#registrations[PREFIX .. "phantom"].workshopVariants == 5) end
end

ENT = {}
dofile(BASE .. "init.lua")
assert(ENT.Base == "stalker_ai")

local now = 10
function CurTime() return now end
local target = {}
function IsValid(entity) return entity == target end

local npc = setmetatable({
	PlayingAnimation = true,
	workshopAction = {kind = "ranged", target = target, impactAt = 11, finishAt = 12},
}, {__index = ENT})
function npc:CanWorkshopAttack() return false end
function npc:STALKERNPCClearAnimation() self.PlayingAnimation = false end
function npc:GetPos() error("a lost target must not be used at impact") end
npc:UpdateWorkshopAction()
assert(npc.workshopAction.impactAt == 11)
now = 11
npc:UpdateWorkshopAction()
assert(npc.workshopAction.impactAt == nil and npc.PlayingAnimation)
now = 12
npc:UpdateWorkshopAction()
assert(npc.workshopAction == nil and not npc.PlayingAnimation)

assert(roster.duble.ranged.damageType == "DMG_BULLET")
assert(roster.poltergeist3.ranged.damageType == "DMG_BURN")
assert(roster.rotan.movement == "swim" and roster.raven2.movement == "fly")
assert(roster.burer.summon == "burer2" and roster.psydog.summon == "phantom_pseudodog")
print("Workshop mutant roster and attack lifecycle checks passed")
