AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Tark.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 3

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Tark.Melee"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 3

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Tark.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 3

ENT.ChasingSoundEnabled = true
ENT.ChasingSound.name = "Stalker.Tark.Chase"
ENT.ChasingSound.min = 1
ENT.ChasingSound.max = 4
ENT.ChasingSound.chance = 20

--ENT.SNPCClass="C_MONSTER_LAB"
ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.hp = 500
ENT.hpvar = 100

ENT.FleeTime = 0
ENT.MustFlee = false
ENT.CanJump = 0
ENT.isAttacking = 0
ENT.jumping1 = 0
ENT.jumping2 = 0

ENT.NextAbilityTime = 0

ENT.MinRangeDist = 800
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_IDLE_WANDER 
ENT.RangeSchedule = SCHED_CHASE_ENEMY


function ENT:Initialize()
	self.Model = "models/monsters/tark.mdl"
	self:STALKERNPCInit(Vector(-24,-24,70),MOVETYPE_STEP)
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Dog.Miss1" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 55
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 100
	TEMP_MeleeTable.radius[1] = 64
	TEMP_MeleeTable.time[1] = 0.8
	TEMP_MeleeTable.bone[1] = "bip01_head"
	self:STALKERNPCSetMeleeParams(1,"stand_attack_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	TEMP_MeleeTable.damage[1] = 35
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 100
	TEMP_MeleeTable.radius[1] = 64
	TEMP_MeleeTable.time[1] = 0.6
	TEMP_MeleeTable.bone[1] = "bip01_l_forearm"
	TEMP_MeleeTable.damage[2] = 35
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[2] = 100
	TEMP_MeleeTable.radius[2] = 64
	TEMP_MeleeTable.time[2] = 0.7
	TEMP_MeleeTable.bone[2] = "bip01_r_forearm"
	self:STALKERNPCSetMeleeParams(2,"stand_attack_1",2, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 50
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 50
	TEMP_MeleeTable.radius[1] = 64
	TEMP_MeleeTable.time[1] = 0.9
	TEMP_MeleeTable.bone[1] = "bip01_head"
	self:STALKERNPCSetMeleeParams(4,"jump_attack_1",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	
	self:SetMaxHealth(self:Health())
	
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()
	if (self.jumping1 < CurTime()) and self.isAttacking == 1 then
		self:SetVelocity(((self:GetEnemy():GetPos() + self:OBBCenter()) -(self:GetPos() + self:OBBCenter())):GetNormal()*500 +self:GetForward()*(12*distance) +self:GetUp()*math.Clamp((distance),150,400))
		self:STALKERNPCPlayAnimation("jump_attack_1",4)
		self:STALKERNPCMakeMeleeAttack(4)
		self:EmitSound("Stalker.Tark.Melee1")
		self.isAttacking = 2
	end
	if (self.jumping2 < CurTime()) and self.isAttacking == 2 and self:IsOnGround() then
		self:STALKERNPCStopAllTimers()
		self:STALKERNPCClearAnimation()
		self.NextAbilityTime = CurTime()+0.5
		self.isAttacking = 0
	end
end

function ENT:STALKERNPCOnDeath()
	return mul
end

//little aggressive jump
function ENT:STALKERNPCDistanceForMeleeTooBig() 
	if(self.PlayingAnimation==false) then
		local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
		if distance < 350 then
			if(self.CanJump<CurTime()) then
				local TEMP_Rand = math.random(1,5)
				
				if(TEMP_Rand==1) then		
					self.CanJump = CurTime()+3
					self.isAttacking = 1
					self.jumping1 = CurTime()+0.2
					self.jumping2 = CurTime()+1
				end
			end
		end
	end
end