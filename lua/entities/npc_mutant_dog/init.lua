AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.PainSoundEnabled = true
ENT.PainSound.name = "Stalker.Dog.Pain"
ENT.PainSound.min = 1
ENT.PainSound.max = 7

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Dog.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 2

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Dog.Melee"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 4

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Dog.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 4

ENT.ChasingSoundEnabled = true
ENT.ChasingSound.name = "Stalker.Dog.Idle"
ENT.ChasingSound.min = 1
ENT.ChasingSound.max = 4
ENT.ChasingSound.chance = 20

--ENT.SNPCClass="C_MONSTER_LAB"
ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.hp = 100
ENT.hpvar = 15
ENT.injuredact = ACT_RUN_AIM_PISTOL

ENT.FBR = 2
ENT.FBRAP = 4

ENT.FleeTime = 0
ENT.MustFlee = false

ENT.NextAbilityTime = 0

ENT.MinRangeDist = 800
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_IDLE_WANDER 
ENT.RangeSchedule = SCHED_CHASE_ENEMY


ENT.navigationLeapRange = 200

ENT.navigationLeapAimHeight = 32
ENT.navigationLeapSpeed = 3

ENT.Abilities = {
	{
		name = "jump",
		navigationLeap = "long",
		meleeRange = "outside",
		maxRange = ENT.navigationLeapRange,
		chance = 0.5,
		cooldown = 3,
		recovery = 0.5,
		phases = {
			{duration = 0.2},
			{
				duration = 0.8, leap = "long", melee = 5, sound = "Stalker.Dog.Melee1",
				untilGrounded = true, maxDuration = 5,
			},
		},
	},
}

function ENT:Initialize()
	self.Model = "models/monsters/slep_dog2.mdl"
	self:STALKERNPCInit(Vector(-24,-24,70),MOVETYPE_STEP)
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Dog.Miss1" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 20
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 100
	TEMP_MeleeTable.radius[1] = 64
	TEMP_MeleeTable.time[1] = 0.6
	TEMP_MeleeTable.bone[1] = "bip01_head"
	self:STALKERNPCSetMeleeParams(1,"stand_attack_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	self:STALKERNPCSetMeleeParams(2,"stand_attack_1",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	self:STALKERNPCSetMeleeParams(3,"stand_attack_2",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 20
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 50
	TEMP_MeleeTable.radius[1] = 64
	TEMP_MeleeTable.time[1] = 0.6
	TEMP_MeleeTable.bone[1] = "bip01_head"
	self:STALKERNPCSetMeleeParams(5,"jump_ataka_01",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	
	self:SetMaxHealth(self:Health())
	
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()
	-- npc wounded animation
	if self:Health() < (self:GetMaxHealth() * 0.33) then
		self:SetMovementActivity(self.injuredact)
	end

	if self.FleeTime < CurTime() then self.MustFlee = false end

	if self.MustFlee then
		self.RangeSchedule = SCHED_RUN_RANDOM
	else
		self.RangeSchedule = SCHED_CHASE_ENEMY
	end
end

function ENT:STALKERNPCOnDeath()
	for j, i in pairs (ents.FindInSphere(self:GetPos(), 256 )) do
		if i:GetClass() == "npc_mutant_dog" then
			i:RunAway()
		end
	end
end

function ENT:RunAway()
	if self.cotzCombatLeash then return end
	if (!self.HasLeader) then
		self.MustFlee = true
		self:SetSchedule(SCHED_RUN_FROM_ENEMY)
		self.FleeTime = CurTime() + 5
	end
end
