AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.PainSoundEnabled = true
ENT.PainSound.name = "Stalker.Rodent.Pain"
ENT.PainSound.min = 1
ENT.PainSound.max = 6

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Rodent.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 3

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Rodent.Melee"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 4

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Rodent.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 4

ENT.ChasingSoundEnabled = true
ENT.ChasingSound.name = "Stalker.Rodent.Chase"
ENT.ChasingSound.min = 1
ENT.ChasingSound.max = 4
ENT.ChasingSound.chance = 20

--ENT.SNPCClass="C_MONSTER_LAB"
ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.hp = 7
ENT.hpvar = 2

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
				duration = 0, leap = "long", melee = 4, animation = "attack3", sound = "Stalker.Rodent.Melee2",
				untilGrounded = true, untilAnimationDone = true, maxDuration = 4.8,
			},
		},
	},
}

function ENT:Initialize()
	self.Model = "models/stalkertnb/rodent1.mdl"
	self:STALKERNPCInit(Vector(-16,-16,70),MOVETYPE_STEP)
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Dog.Miss1" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 6
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 40
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 0.6
	TEMP_MeleeTable.bone[1] = "bip01_head"
	self:STALKERNPCSetMeleeParams(1,"attack1",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 6
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 40
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 0.3
	TEMP_MeleeTable.bone[1] = "bip01_head"
	self:STALKERNPCSetMeleeParams(2,"attack1",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)


	//Jumping attack
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	TEMP_MeleeTable.damage[1] = 4
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 128
	TEMP_MeleeTable.radius[1] = 40
	TEMP_MeleeTable.time[1] = 0.3
	TEMP_MeleeTable.bone[1] = "bip01_r_forearm"
	TEMP_MeleeTable.damage[2] = 4
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[2] = 128
	TEMP_MeleeTable.radius[2] = 40
	TEMP_MeleeTable.time[2] = 0.4
	TEMP_MeleeTable.bone[2] = "bip01_l_forearm"
	TEMP_MeleeTable.damage[3] = 4
	TEMP_MeleeTable.damagetype[3] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[3] = 128
	TEMP_MeleeTable.radius[3] = 40
	TEMP_MeleeTable.time[3] = 0.7
	TEMP_MeleeTable.bone[3] = "bip01_r_forearm"
	TEMP_MeleeTable.damage[4] = 4
	TEMP_MeleeTable.damagetype[4] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[4] = 128
	TEMP_MeleeTable.radius[4] = 40
	TEMP_MeleeTable.time[4] = 0.8
	TEMP_MeleeTable.bone[4] = "bip01_l_forearm"
	self:STALKERNPCSetMeleeParams(4,"attack2",4, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	
	self:SetMaxHealth(self:Health())
	
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCOnDeath()

end

function ENT:STALKERNPCDamageTake(dmginfo,mul)
	return mul
end
