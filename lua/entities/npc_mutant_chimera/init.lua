AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.PainSoundEnabled = true
ENT.PainSound.name = "Stalker.Chimera.Pain"
ENT.PainSound.min = 1
ENT.PainSound.max = 5

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Chimera.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 1

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Chimera.Hit"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 3

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Chimera.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 2

ENT.ChasingSoundEnabled = true
ENT.ChasingSound.name = "Stalker.Chimera.Idle"
ENT.ChasingSound.min = 1
ENT.ChasingSound.max = 2
ENT.ChasingSound.chance = 20

ENT.CanSpecial = true

--ENT.SNPCClass="C_MONSTER_LAB"
ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.hp = 850
ENT.hpvar = 20
ENT.injuredact = ACT_WALK_PISTOL

ENT.FBR = 5
ENT.FBRAP = 10
ENT.BR = 45

ENT.NextAbilityTime = 0

ENT.MinRangeDist = 0
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_RUN_RANDOM
ENT.RangeSchedule = SCHED_CHASE_ENEMY


ENT.navigationLeapRange = 1200
ENT.navigationLeapMinRange = 300

ENT.navigationLeapAimHeight = 128
ENT.navigationLeapSpeed = 1.5

ENT.Abilities = {
	{
		name = "jump",
		navigationLeap = "long",
		meleeRange = "outside",
		minRange = ENT.navigationLeapMinRange,
		maxRange = ENT.navigationLeapRange,
		chance = 0.5,
		cooldown = 3,
		initialCooldown = 1,
		recovery = 0.5,
		phases = {
			{duration = 0.2},
			{
				duration = 0, leap = "long", melee = 1, sound = "Stalker.Chimera.Hit4",
				untilGrounded = true, untilAnimationDone = true, maxDuration = 4.8,
			},
		},
	},
}

function ENT:Initialize()
	self.Model = "models/monsters/chimera2.mdl"
	self:STALKERNPCInit(Vector(-48,-48,70),MOVETYPE_STEP)
	
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Snork.Miss1" }

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 100
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 50
	TEMP_MeleeTable.radius[1] = 100
	TEMP_MeleeTable.time[1] = 0.6
	TEMP_MeleeTable.bone[1] = "head_boss"
	TEMP_MeleeTable.damage[2] = 100
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[2] = 50
	TEMP_MeleeTable.radius[2] = 100
	TEMP_MeleeTable.time[2] = 1
	TEMP_MeleeTable.bone[2] = "head_boss"
	self:STALKERNPCSetMeleeParams(1,"jump_attack_0",2, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	
	self:SetMaxHealth(self:Health())

	self.NextAbilityTime = CurTime()+1
	
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()
	-- npc wounded animation
	if self:Health() < (self:GetMaxHealth() * 0.33) then
		self:SetMovementActivity(self.injuredact)
	end
end
