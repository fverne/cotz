AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

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

ENT.hp = 500
ENT.hpvar = 100

ENT.flatbulletresistance = 2
ENT.percentbulletresistance = 10

ENT.IgniteTime = 0

ENT.CanSpew = 0
ENT.isAttacking = 0
ENT.jumping1 = 0
ENT.jumping2 = 0

ENT.NextAbilityTime = 0

ENT.MinRangeDist = 800
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_IDLE_WANDER 
ENT.RangeSchedule = SCHED_CHASE_ENEMY


function ENT:Initialize()
	self.Model = "models/monsters/slep_dog2.mdl"
	self.ragdollModel = "models/monsters/slep_dog.mdl"

	self:STALKERNPCInit(Vector(-24,-24,70),MOVETYPE_STEP)
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Dog.Miss1" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 20
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 100
	TEMP_MeleeTable.radius[1] = 128
	TEMP_MeleeTable.time[1] = 0.6
	TEMP_MeleeTable.bone[1] = "bip01_head"
	self:STALKERNPCSetMeleeParams(1,"stand_attack_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	self:STALKERNPCSetMeleeParams(2,"stand_attack_1",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	self:STALKERNPCSetMeleeParams(3,"stand_attack_2",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 15
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BURN)
	TEMP_MeleeTable.distance[1] = 256
	TEMP_MeleeTable.radius[1] = 128
	TEMP_MeleeTable.time[1] = 0.2
	TEMP_MeleeTable.bone[1] = "bip01_head"

	TEMP_MeleeTable.damage[2] = 15
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_BURN)
	TEMP_MeleeTable.distance[2] = 384
	TEMP_MeleeTable.radius[2] = 128
	TEMP_MeleeTable.time[2] = 0.3
	TEMP_MeleeTable.bone[2] = "bip01_head"

	TEMP_MeleeTable.damage[3] = 15
	TEMP_MeleeTable.damagetype[3] = bit.bor(DMG_BURN)
	TEMP_MeleeTable.distance[3] = 384
	TEMP_MeleeTable.radius[3] = 128
	TEMP_MeleeTable.time[3] = 0.4
	TEMP_MeleeTable.bone[3] = "bip01_head"

	TEMP_MeleeTable.damage[4] = 15
	TEMP_MeleeTable.damagetype[4] = bit.bor(DMG_BURN)
	TEMP_MeleeTable.distance[4] = 256
	TEMP_MeleeTable.radius[4] = 128
	TEMP_MeleeTable.time[4] = 0.5
	TEMP_MeleeTable.bone[4] = "bip01_head"

	TEMP_MeleeTable.damage[5] = 15
	TEMP_MeleeTable.damagetype[5] = bit.bor(DMG_BURN)
	TEMP_MeleeTable.distance[5] = 384
	TEMP_MeleeTable.radius[5] = 128
	TEMP_MeleeTable.time[5] = 0.6
	TEMP_MeleeTable.bone[5] = "bip01_head"

	TEMP_MeleeTable.damage[6] = 15
	TEMP_MeleeTable.damagetype[6] = bit.bor(DMG_BURN)
	TEMP_MeleeTable.distance[6] = 384
	TEMP_MeleeTable.radius[6] = 128
	TEMP_MeleeTable.time[6] = 0.7
	TEMP_MeleeTable.bone[6] = "bip01_head"

	TEMP_MeleeTable.damage[7] = 15
	TEMP_MeleeTable.damagetype[7] = bit.bor(DMG_BURN)
	TEMP_MeleeTable.distance[7] = 256
	TEMP_MeleeTable.radius[7] = 128
	TEMP_MeleeTable.time[7] = 0.8
	TEMP_MeleeTable.bone[7] = "bip01_head"

	TEMP_MeleeTable.damage[8] = 15
	TEMP_MeleeTable.damagetype[8] = bit.bor(DMG_BURN)
	TEMP_MeleeTable.distance[8] = 384
	TEMP_MeleeTable.radius[8] = 128
	TEMP_MeleeTable.time[8] = 0.9
	TEMP_MeleeTable.bone[8] = "bip01_head"

	TEMP_MeleeTable.damage[9] = 15
	TEMP_MeleeTable.damagetype[9] = bit.bor(DMG_BURN)
	TEMP_MeleeTable.distance[9] = 384
	TEMP_MeleeTable.radius[9] = 128
	TEMP_MeleeTable.time[9] = 1.0
	TEMP_MeleeTable.bone[9] = "bip01_head"

	self:STALKERNPCSetMeleeParams(5,"stand_attack_0",9, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	
	self:SetMaxHealth(self:Health())
	
	self:SetModelScale(1.5)
	
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()
	if self.IgniteTime < CurTime() then
		self:Ignite(30)
		self.IgniteTime = CurTime() + 29
	end

	if (self.jumping1 < CurTime()) and self.isAttacking == 1 then

		self.Entity:SetNWBool( "Burn", true )

		self:STALKERNPCPlayAnimation("stand_attack_0",5)
		self:STALKERNPCMakeMeleeAttack(5)
		self:EmitSound("Stalker.Dog.Melee1")
		self.isAttacking = 2
	end
	if (self.jumping2 < CurTime()) and self.isAttacking == 2 then
		self:STALKERNPCStopAllTimers()
		self:STALKERNPCClearAnimation()
		self.Entity:SetNWBool( "Burn", false )
		self.NextAbilityTime = CurTime()+0.5
		self.isAttacking = 0
	end
end

function ENT:STALKERNPCOnDeath()
	self.Entity:SetNWBool( "Burn", false )
end

//little aggressive jump
function ENT:STALKERNPCDistanceForMeleeTooBig() 
	if(self.PlayingAnimation==false) then
		local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
		if distance < 200 then
			if(self.CanSpew < CurTime()) then
				local TEMP_Rand = math.random(1,5)
				
				if(TEMP_Rand==1) then		
					self.CanSpew = CurTime()+3
					self.isAttacking = 1
					self.jumping1 = CurTime()+0.2
					self.jumping2 = CurTime()+1.5
				end
			end
		end
	end
end

function ENT:STALKERNPCDamageTake(dmginfo,mul) 
	if(dmginfo:GetDamageType() == DMG_BULLET) then
		dmginfo:SetDamage(dmginfo:GetDamage()*(1 - (self.percentbulletresistance/100)))
		dmginfo:SubtractDamage(self.flatbulletresistance)
		dmginfo:SetDamage(math.max(0,dmginfo:GetDamage())) --So he can't heal from our attacks
	end

	if dmginfo:IsDamageType(DMG_BURN) then
		return 0
	end

	return TEMP_Mul
end