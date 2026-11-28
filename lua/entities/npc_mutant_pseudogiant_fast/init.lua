AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.PainSoundEnabled = true
ENT.PainSound.name = "Stalker.PseudogiantFast.Pain"
ENT.PainSound.min = 1
ENT.PainSound.max = 6

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Pseudogiant.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 2

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Pseudogiant.Melee"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 4

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Pseudogiant.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 4

ENT.ChasingSoundEnabled = true
ENT.ChasingSound.name = "Stalker.Pseudogiant.Chase"
ENT.ChasingSound.min = 1
ENT.ChasingSound.max = 7
ENT.ChasingSound.chance = 5

--ENT.SNPCClass="C_MONSTER_LAB"
ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.hp = 2500
ENT.hpvar = 100

ENT.NextAbilityTime = 0

ENT.MinRangeDist = 800
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_IDLE_WANDER 
ENT.RangeSchedule = SCHED_CHASE_ENEMY

ENT.FBR = 15
ENT.FBRAP = 5
ENT.BR = 12

ENT.navigationLeapRange = 1200
ENT.navigationLeapMinRange = 300
ENT.navigationShortLeapRange = 200

ENT.navigationLeapAimHeight = 48
ENT.navigationLeapSpeed = 2
ENT.navigationShortLeapAimHeight = 32
ENT.navigationShortLeapSpeed = 3

local LANDING_RADIUS = 512
local LANDING_DAMAGE = 60

ENT.Abilities = {
	{
		name = "shortJump",
		navigationLeap = "short",
		meleeRange = "outside",
		maxRange = ENT.navigationShortLeapRange,
		chance = 0.5,
		cooldown = 6,
		recovery = 0.5,
		phases = {
			{duration = 0.3},
			{duration = 0.5, leap = "short", melee = 6, sound = "Stalker.Pseudogiant.Melee1"},
		},
	},
	{
		name = "bigJump",
		navigationLeap = "long",
		meleeRange = "outside",
		minRange = ENT.navigationLeapMinRange,
		maxRange = ENT.navigationLeapRange,
		chance = 0.5,
		cooldown = 10,
		phases = {
			{duration = 0.3, melee = 5, sound = "Stalker.Pseudogiant.Idle1"},
			{duration = 0.5, leap = "long", untilGrounded = true, maxDuration = 5},
			{duration = 0, method = "PseudogiantLand"},
		},
	},
}

function ENT:Initialize()
	self.Model = "models/monsters/gigant.mdl"
	self:STALKERNPCInit(Vector(-48,-48,70),MOVETYPE_STEP)
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Dog.Miss1" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 60
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 128
	TEMP_MeleeTable.radius[1] = 128
	TEMP_MeleeTable.time[1] = 0.66
	TEMP_MeleeTable.bone[1] = "bip01_spine"
	self:STALKERNPCSetMeleeParams(1,"stand_attack_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 60
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 128
	TEMP_MeleeTable.radius[1] = 128
	TEMP_MeleeTable.time[1] = 0.4
	TEMP_MeleeTable.bone[1] = "bip01_spine"
	self:STALKERNPCSetMeleeParams(2,"stand_attack_1",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 30
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 100
	TEMP_MeleeTable.radius[1] = 256
	TEMP_MeleeTable.time[1] = 0.6
	TEMP_MeleeTable.bone[1] = "bip01_r_foot"
	self:STALKERNPCSetMeleeParams(3,"stand_attack_2",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 60
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 128
	TEMP_MeleeTable.radius[1] = 128
	TEMP_MeleeTable.time[1] = 1.3
	TEMP_MeleeTable.bone[1] = "bip01_l_foot"
	self:STALKERNPCSetMeleeParams(5,"jump_attack_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)


	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 20
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 128
	TEMP_MeleeTable.radius[1] = 128
	TEMP_MeleeTable.time[1] = 0.45
	TEMP_MeleeTable.bone[1] = "bip01_l_foot"
	self:STALKERNPCSetMeleeParams(6,"stand_attack_run_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))	
	
	self:SetMaxHealth(self:Health())
	
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:PseudogiantLand()
	self:STALKERNPCAbilityGroundSlam(LANDING_RADIUS, LANDING_DAMAGE, DMG_CLUB)
end

function ENT:STALKERNPCOnDeath()

end
