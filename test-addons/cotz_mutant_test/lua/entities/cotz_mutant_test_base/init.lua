AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

-- The inherited melee scheduler subtracts this from the configured hit time.
local BASE_HIT_TIME_OFFSET = 0.2

local function registerAttack(npc, index, attack)
	local melee = npc:STALKERNPCCreateMeleeTable()
	melee.damage[1] = attack.damage
	melee.damagetype[1] = attack.damageType
	melee.distance[1] = npc.MeleeAttackDistance
	-- The base passes the half-angle directly to math.cos, with 360 as its full-circle sentinel.
	melee.radius[1] = attack.arc == 360 and 360 or math.rad(attack.arc * 0.5)
	melee.time[1] = attack.windup + BASE_HIT_TIME_OFFSET
	melee.bone[1] = attack.bone
	npc:STALKERNPCSetMeleeParams(index, attack.sequence, 1, melee, {npc.hitSound}, {npc.missSound})
end

local function rejectSpawn(npc, reason)
	ErrorNoHalt(string.format("[COTZ Mutant Tests] %s: %s\n", npc:GetClass(), reason))
	npc:Remove()
end

function ENT:Initialize()
	if not self.STALKERNPCInit then
		rejectSpawn(self, "stalker_ai is missing")
		return
	end
	if not self.Model or not util.IsValidModel(self.Model) then
		rejectSpawn(self, "missing model " .. (self.Model or "for the abstract base"))
		return
	end

	self:SetHullType(self.hullType)
	self:STALKERNPCInit(self.hullSize, MOVETYPE_STEP)
	self:SetViewOffset(self.viewOffset)

	for _, attack in ipairs(self.attacks) do
		local sequence, duration = self:LookupSequence(attack.sequence)
		if sequence < 0 or duration <= attack.windup then
			rejectSpawn(self, "missing or too short attack sequence " .. attack.sequence)
			return
		end
	end

	local health = self.hp + math.random(-self.hpvar, self.hpvar)
	self:SetHealth(health)
	self:SetMaxHealth(health)

	if self.tint then
		self:SetRenderMode(RENDERMODE_TRANSCOLOR)
		self:SetColor(self.tint)
		self:DrawShadow(false)
	end

	-- Inherited melee registration appends to its sound tables. Keep all attack slots per entity.
	self.MeleeAttackSequence = {}
	self.MeleeAttackGesture = {}
	self.MeleeDamageCount = {}
	self.MeleeDamageTime = {}
	self.MeleeDamageDamage = {}
	self.MeleeDamageType = {}
	self.MeleeDamageDistance = {}
	self.MeleeDamageBone = {}
	self.MeleeDamageRadius = {}
	self.MeleeHitSound = {}
	self.MeleeMissSound = {}

	for index, attack in ipairs(self.attacks) do
		registerAttack(self, index, attack)
	end
end

function ENT:STALKERNPCMeleeAttackEvent()
	self:EmitSound(self.windupSound, self.soundLevel)
end

function ENT:STALKERNPCOnDeath()
	sound.Play(self.deathSound, self:GetPos(), self.soundLevel)
end
