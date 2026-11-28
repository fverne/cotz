AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.PainSoundEnabled = true
ENT.PainSound.name = "Stalker.Izlom.Pain"
ENT.PainSound.min = 1
ENT.PainSound.max = 3

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Izlom.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 5

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Izlom.Melee"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 4

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Izlom.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 5

ENT.ChasingSoundEnabled = true
ENT.ChasingSound.name = "Stalker.Izlom.Chase"
ENT.ChasingSound.min = 1
ENT.ChasingSound.max = 13
ENT.ChasingSound.chance = 15

--ENT.SNPCClass="C_MONSTER_LAB"
ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.hp = 450
ENT.hpvar = 30
ENT.injuredact = ACT_RUN_AIM_PISTOL

ENT.FBR = 3
ENT.FBRAP = 3
ENT.BR = 8

ENT.FleeTime = 0
ENT.MustFlee = false

ENT.CanSpecial = true

ENT.MinRangeDist = 800
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_IDLE_WANDER 
ENT.RangeSchedule = SCHED_CHASE_ENEMY

ENT.TEMP_PunchDamage1 = 0
ENT.TEMP_PunchDamage2 = 0

ENT.navigationRangedRange = 512
ENT.navigationRangedMinRange = 256

local PULL_STRENGTH = 1.5
local PULL_LIFT = 0.38
local PULL_STAMINA = 35
local THROW_LIFT = 5
local THROW_SPEED = 120

ENT.Abilities = {
	{
		name = "pull",
		meleeRange = "outside",
		minRange = ENT.navigationRangedMinRange,
		maxRange = ENT.navigationRangedRange,
		chance = 0.5,
		cooldown = 7,
		recovery = 0.5,
		phases = {
			{duration = 0.2},
			{duration = 0.7, method = "IzlomPull", melee = 3, sound = "Stalker.Izlom.Melee1"},
		},
	},
	{
		name = "grab",
		meleeRange = "outside",
		maxRange = 125,
		chance = 0.5,
		cooldown = 15,
		cancelOnTargetLoss = false,
		validate = "IzlomHasVictim",
		onFinish = "IzlomReleaseVictim",
		phases = {
			{duration = 0.1, method = "IzlomSeize"},
			{duration = 2, melee = 4, sound = "Stalker.Izlom.Chase10"},
			{duration = 0, method = "IzlomThrow"},
		},
	},
}

function ENT:Initialize()
	self.Model = "models/monsters/izlom.mdl"
	self:STALKERNPCInit(Vector(-24,-24,70),MOVETYPE_STEP)
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Izlom.Miss1" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 55
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 100
	TEMP_MeleeTable.radius[1] = 128
	TEMP_MeleeTable.time[1] = 1.0
	TEMP_MeleeTable.bone[1] = "bip01_l_hand"
	self:STALKERNPCSetMeleeParams(1,"stand_attack_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 25
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 100
	TEMP_MeleeTable.radius[1] = 128
	TEMP_MeleeTable.time[1] = 0.3
	TEMP_MeleeTable.bone[1] = "bip01_l_hand"
	self:STALKERNPCSetMeleeParams(3,"stand_run_attack_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 40
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 100
	TEMP_MeleeTable.radius[1] = 128
	TEMP_MeleeTable.time[1] = 1.1
	TEMP_MeleeTable.bone[1] = "bip01_r_hand"
	TEMP_MeleeTable.damage[2] = 20
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[2] = 100
	TEMP_MeleeTable.radius[2] = 128
	TEMP_MeleeTable.time[2] = 2.1
	TEMP_MeleeTable.bone[2] = "bip01_r_hand"
	self:STALKERNPCSetMeleeParams(4,"stand_attack_1",2, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	
	self:SetMaxHealth(self:Health())
	
	self:SetRenderMode(RENDERMODE_TRANSALPHA)

	self.TEMP_PunchDamage2 = DamageInfo()
							
	self.TEMP_PunchDamage2:SetDamage(20)
	self.TEMP_PunchDamage2:SetInflictor(self)
	self.TEMP_PunchDamage2:SetDamageType(DMG_BULLET)
	self.TEMP_PunchDamage2:SetAttacker(self)
	self.TEMP_PunchDamage2:SetDamageForce(Vector(0,0,0))

end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()
	-- npc wounded animation
	if self:Health() < (self:GetMaxHealth() * 0.33) then
		self:SetMovementActivity(self.injuredact)
	end

end

function ENT:IzlomPull(enemy)
	if not enemy then return end

	local distance = self:GetPos():Distance(enemy:GetPos())
	local direction = (self:GetPos() + self:OBBCenter() - enemy:GetPos()):GetNormalized()
	direction.z = PULL_LIFT
	enemy:SetVelocity(direction * (distance * PULL_STRENGTH))
	if enemy.ConsumeStamina then enemy:ConsumeStamina(PULL_STAMINA) end
end

function ENT:IzlomSeize(enemy, state)
	state.victim = enemy
	if enemy and enemy:IsPlayer() then enemy:Freeze(true) end
end

function ENT:IzlomHasVictim(state)
	return state.released or IsValid(state.victim)
end

function ENT:IzlomThrow(_, state)
	local victim = state.victim
	self:IzlomReleaseVictim(state)
	if not IsValid(victim) then return end

	local direction = (victim:GetPos() - self:GetPos()):GetNormalized() + self:GetUp() * THROW_LIFT
	victim:SetLocalVelocity(direction * THROW_SPEED)
end

function ENT:IzlomReleaseVictim(state)
	local victim = state.victim
	state.victim, state.released = nil, true
	if IsValid(victim) and victim:IsPlayer() then victim:Freeze(false) end
end
