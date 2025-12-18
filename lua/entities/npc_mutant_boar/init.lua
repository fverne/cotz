AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Boar.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 2

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Boar.Melee"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 2

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Boar.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 2

ENT.ChasingSoundEnabled = true
ENT.ChasingSound.name = "Stalker.Boar.Chase"
ENT.ChasingSound.min = 1
ENT.ChasingSound.max = 2
ENT.ChasingSound.chance = 100

--ENT.SNPCClass="C_MONSTER_LAB"
ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.hp = 180
ENT.hpvar = 20
ENT.injuredact = ACT_DOD_RUN_ZOOM_BOLT

ENT.FBR = 0
ENT.FBRAP = 5
ENT.BR = 5

ENT.NextAbilityTime = 0

ENT.MinRangeDist = 800
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_IDLE_WANDER 
ENT.RangeSchedule = SCHED_CHASE_ENEMY

function ENT:Initialize()
	self.Model = "models/monsters/boar.mdl"
	self:STALKERNPCInit(Vector(-42,-42,70),MOVETYPE_STEP)
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Dog.Miss1" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 60
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 100
	TEMP_MeleeTable.radius[1] = 64
	TEMP_MeleeTable.time[1] = 1
	TEMP_MeleeTable.bone[1] = "bip01_head"
	self:STALKERNPCSetMeleeParams(1,"stand_attack_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	TEMP_MeleeTable.damage[1] = 30
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 125
	TEMP_MeleeTable.radius[1] = 64
	TEMP_MeleeTable.time[1] = 0.85
	TEMP_MeleeTable.bone[1] = "bip01_r_forearm"
	self:STALKERNPCSetMeleeParams(2,"stand_attack_1",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)


	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	TEMP_MeleeTable.damage[1] = 30
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 100
	TEMP_MeleeTable.radius[1] = 64
	TEMP_MeleeTable.time[1] = 0.65
	TEMP_MeleeTable.bone[1] = "bip01_head"
	self:STALKERNPCSetMeleeParams(3,"stand_attack_2",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	

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

end

function ENT:STALKERNPCOnDeath()

end

function ENT:STALKERNPCDamageTake(dmginfo,mul) 
	TEMP_Mul = mul
	local headMultiplier = 0.75 // thick skull
	local torsoMultiplier = 1 // boar is more vulnerable in torso
	local limbMultiplier = 1

	local torsoHitGroups = {
		[2] = true,
		[3] = true,
	}
	local limbHitgroups = {
		[4] = true,
		[5] = true,
		[6] = true,
		[7] = true,
	}

	if(self.LastDamageHitgroup == 1)then // head
		TEMP_Mul = 0.50 * headMultiplier 
	elseif (torsoHitGroups[self.LastDamageHitgroup]) then // chest + stomach
		TEMP_Mul = 1 * torsoMultiplier 
	elseif (limbHitgroups[self.LastDamageHitgroup]) then // limb
		TEMP_Mul = 4 * limbMultiplier
	end

	return TEMP_Mul
end
