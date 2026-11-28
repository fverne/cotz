AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.PainSoundEnabled = true
ENT.PainSound.name = "Stalker.Pseudodog.Pain"
ENT.PainSound.min = 1
ENT.PainSound.max = 2

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Pseudodog.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 2

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Pseudodog.Melee"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 4

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Pseudodog.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 3

ENT.ChasingSoundEnabled = true
ENT.ChasingSound.name = "Stalker.Pseudodog.Chase"
ENT.ChasingSound.min = 1
ENT.ChasingSound.max = 4
ENT.ChasingSound.chance = 20

--ENT.SNPCClass="C_MONSTER_LAB"
ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.hp = 5


ENT.NextAbilityTime = 0
ENT.PackTimer = 0

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
				duration = 0, leap = "long", melee = 3, sound = "Stalker.Pseudodog.Melee1",
				untilAnimationDone = true, maxDuration = 4.8,
			},
		},
	},
}

function ENT:Initialize()
	self.Model = "models/monsters/psydog.mdl"
	self:STALKERNPCInit(Vector(-24,-24,70),MOVETYPE_STEP)
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()

	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Dog.Miss1" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	

	TEMP_MeleeTable.damage[1] = 5
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SONIC)
	TEMP_MeleeTable.distance[1] = 90
	TEMP_MeleeTable.radius[1] = 50
	TEMP_MeleeTable.time[1] = 0.4
	TEMP_MeleeTable.bone[1] = "bip01_head"
	self:STALKERNPCSetMeleeParams(1,"stand_attack_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 5
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SONIC)
	TEMP_MeleeTable.distance[1] = 128
	TEMP_MeleeTable.radius[1] = 75
	TEMP_MeleeTable.time[1] = 0.4
	TEMP_MeleeTable.bone[1] = "bip01_head"
	self:STALKERNPCSetMeleeParams(3,"jump_attack_all",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	self:SetHealth(self.hp)	
	self:SetMaxHealth(self:Health())
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCHitSomething()
	self:Disperse()
end

function ENT:Disperse()
	if self.dispersing then return end
	self.dispersing = true

	local effectData = EffectData()
	effectData:SetOrigin(self:GetPos() + Vector(0, 0, 32))
	effectData:SetScale(120)
	effectData:SetNormal(self:GetForward())
	effectData:SetAngles(self:GetAngles())
	util.Effect("ThumperDust", effectData)

	SafeRemoveEntityDelayed(self, 0)
end

function ENT:STALKERNPCDamageTake(dmginfo, mul)
	self:Disperse()
	return 0
end

function ENT:STALKERNPCOnDeath()							

end
