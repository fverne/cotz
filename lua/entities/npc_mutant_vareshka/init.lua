AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.PainSoundEnabled = true
ENT.PainSound.name = "Stalker.Vareshka.Pain"
ENT.PainSound.min = 1
ENT.PainSound.max = 3

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Vareshka.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 3

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Vareshka.Melee"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 4

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Vareshka.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 4

ENT.ChasingSoundEnabled = true
ENT.ChasingSound.name = "Stalker.Vareshka.Chase"
ENT.ChasingSound.min = 1
ENT.ChasingSound.max = 4
ENT.ChasingSound.chance = 20

ENT.CanSpecial = true

--ENT.SNPCClass="C_MONSTER_LAB"
ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.hp = 400
ENT.hpvar = 50

ENT.FBR = 10
ENT.FBRAP = 15
ENT.BR = 15

ENT.NextAbilityTime = 0

ENT.MinRangeDist = 0
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_RUN_RANDOM
ENT.RangeSchedule = SCHED_CHASE_ENEMY

ENT.navigationLeapRange = 800
ENT.navigationLeapMinRange = 400
ENT.navigationShortLeapRange = 400

ENT.navigationLeapAimHeight = 128
ENT.navigationLeapSpeed = 1.5
ENT.navigationShortLeapAimHeight = 32
ENT.navigationShortLeapSpeed = 3

local LANDING_RADIUS = 512
local LANDING_DAMAGE = 25

ENT.Abilities = {
	{
		name = "longJump",
		navigationLeap = "long",
		meleeRange = "outside",
		minRange = ENT.navigationLeapMinRange,
		maxRange = ENT.navigationLeapRange,
		chance = 0.5,
		cooldown = 6,
		linkedCooldowns = {shortJump = 3},
		recovery = 1.5,
		phases = {
			{duration = 0.01},
			{
				duration = 0.49, leap = "long", melee = 3, sound = "Stalker.Vareshka.Hit1",
				untilGrounded = true, maxDuration = 5,
			},
			{duration = 0, method = "VareshkaLand"},
		},
	},
	{
		name = "shortJump",
		navigationLeap = "short",
		meleeRange = "outside",
		maxRange = ENT.navigationShortLeapRange,
		chance = 0.5,
		cooldown = 3,
		recovery = 0.5,
		phases = {
			{duration = 0.2},
			{
				duration = 0, leap = "short", melee = 3, sound = "Stalker.Vareshka.Chase4",
				untilAnimationDone = true, maxDuration = 4.8,
			},
		},
	},
}

function ENT:Initialize()
	self.Model = "models/monsters/vareshka.mdl"
	self:STALKERNPCInit(Vector(-24,-24,70),MOVETYPE_STEP)
	
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Vareshka.Hit1" }
	
	local TEMP_MeleeMissTable = { "Stalker.Snork.Miss1" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 65
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 21
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 0.8
	TEMP_MeleeTable.bone[1] = "bip01_l_hand"
	self:STALKERNPCSetMeleeParams(1,"attack_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	//Jumping attack
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 65
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 80
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 0.9
	TEMP_MeleeTable.bone[1] = "bip01_r_hand"
	self:STALKERNPCSetMeleeParams(3,"attack_1",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	
	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	
	self:SetMaxHealth(self:Health())

	self.NextAbilityTime = CurTime()+1
	
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:VareshkaLand()
	self:STALKERNPCAbilityGroundSlam(LANDING_RADIUS, LANDING_DAMAGE, DMG_CLUB)
end
