AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.PainSoundEnabled = true
ENT.PainSound.name = "Stalker.Burer.Pain"
ENT.PainSound.min = 1
ENT.PainSound.max = 1

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Burer.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 1

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Burer.Melee"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 1

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Burer.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 3

ENT.CanSpecial = true

--ENT.SNPCClass="C_MONSTER_LAB"
ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.hp = 600
ENT.hpvar = 50

ENT.FBR = 6
ENT.FBRAP = 10
ENT.BR = 30

ENT.NextAbilityTime = 0

local BLAST_OFFSET = Vector(15, 0, 50)
local BLAST_SPEED = 2000
local STAMINA_DRAIN = 80
local STAMINA_PUNCH = 40
local SHIELD_ODDS = 3
local SHIELD_DAMAGE_SCALE = 0.1
local SHIELD_AIRBOAT_SCALE = 0.5
local SHIELD_EFFECT_OFFSET = 20
local SHIELD_EFFECT = "cotz_anom_gravity_shield"
-- Shotgun pellets and rapid fire would otherwise stack a smoke-trailing effect per hit.
local SHIELD_EFFECT_INTERVAL = 0.1

ENT.Abilities = {
	{
		name = "stamina",
		canUse = "BurerCanDrainStamina",
		meleeRange = "outside",
		chance = 0.4,
		cooldown = 15,
		initialCooldown = 1,
		recovery = 0.5,
		cancelOnTargetLoss = false,
		phases = {
			{duration = 0.4, animation = "S_Stamina_Attack"},
			{duration = 1.8, method = "BurerDrainStamina"},
		},
	},
	{
		name = "blast",
		meleeRange = "outside",
		chance = 0.5,
		cooldown = 5,
		initialCooldown = 1,
		recovery = 0.5,
		phases = {
			{duration = 0.9, animation = "S_Power_Attack"},
			{duration = 1.3, method = "BurerBlast"},
		},
	},
	{
		name = "shield",
		triggerOnly = true,
		interrupts = true,
		cooldown = 10,
		initialCooldown = 1,
		cancelOnTargetLoss = false,
		phases = {
			{duration = 0.6, animation = "S_Shield_Start"},
			{duration = {1.4, 3.4}, animation = "S_Shield_Idle"},
			{duration = 0.3, animation = "S_Shield_End"},
		},
	},
}

ENT.MinRangeDist = 800
ENT.MaxRangeDist = 1500
ENT.VisibleSchedule = SCHED_RUN_FROM_ENEMY_FALLBACK
ENT.RangeSchedule = SCHED_RUN_RANDOM

ENT.navigationRangedRange = 1500

function ENT:Initialize()
	self.Model = "models/gsc/s.t.a.l.k.e.r/monsters/burer.mdl"
	self:STALKERNPCInit(Vector(-32,-32,70),MOVETYPE_STEP)
	
	
	self.MinRangeDist = 800
	self.MaxRangeDist = 1500
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Claw.Miss" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 19
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 21
	TEMP_MeleeTable.radius[1] = 60
	TEMP_MeleeTable.time[1] = 0.6
	TEMP_MeleeTable.bone[1] = "right_hand"
	TEMP_MeleeTable.damage[2] = 19
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[2] = 21
	TEMP_MeleeTable.radius[2] = 60
	TEMP_MeleeTable.time[2] = 1.3
	TEMP_MeleeTable.bone[2] = "left_hand"
	self:STALKERNPCSetMeleeParams(1,"S_Melee",2, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	
	self:SetMaxHealth(self:Health())

	self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:BurerCanDrainStamina(enemy)
	if not enemy:IsPlayer() then return false end
	local weapon = enemy:GetActiveWeapon()

	return IsValid(weapon) and weapon:GetNoDraw() == false
end

function ENT:BurerDrainStamina(enemy)
	if not enemy or not enemy:IsPlayer() then return end

	local punch = Angle(
		math.random(-1, 1) * STAMINA_PUNCH,
		math.random(-1, 1) * STAMINA_PUNCH,
		math.random(-1, 1) * STAMINA_PUNCH
	)
	enemy:ViewPunch(punch)
	enemy:RestoreStamina(-STAMINA_DRAIN)
end

function ENT:BurerBlast(enemy)
	self:STALKERNPCAbilityLaunchProjectile("ent_burer_wave", enemy, BLAST_SPEED, BLAST_OFFSET)
	self:STALKERNPCPlaySoundRandom(100, "Stalker.Burer.Push", 1, 1)
end

function ENT:STALKERNPCDamageTake(dmginfo, mul)
	if math.random(1, SHIELD_ODDS) == 1 then self:STALKERNPCTriggerAbility("shield") end
	if self.Animation ~= "S_Shield_Idle" then return mul end

	if CurTime() >= (self.nextShieldEffect or 0) then
		self.nextShieldEffect = CurTime() + SHIELD_EFFECT_INTERVAL

		local center = self:GetPos() + self:OBBCenter()
		local offset = dmginfo:GetDamagePosition() - center
		ParticleEffect(SHIELD_EFFECT, center + offset:GetNormalized() * SHIELD_EFFECT_OFFSET, offset:Angle())
	end

	if dmginfo:GetDamageType() == DMG_AIRBOAT then return SHIELD_AIRBOAT_SCALE end

	return SHIELD_DAMAGE_SCALE
end
