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

ENT.hp = 100
ENT.hpvar = 15

ENT.FBR = 2
ENT.FBRAP = 4

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
	if self.FleeTime < CurTime() then self.MustFlee = false end

	if self.MustFlee then
		self.RangeSchedule = SCHED_RUN_RANDOM
	else
		self.RangeSchedule = SCHED_CHASE_ENEMY
	end

	if (self.jumping1 < CurTime()) and self.isAttacking == 1 then
		local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
		local dirnormal =((self:GetEnemy():GetPos() + Vector(0,0,32) + self:OBBCenter()) - (self:GetPos())):GetNormal()

		self:SetVelocity((dirnormal*(distance*3)))		

		self:STALKERNPCPlayAnimation("jump_ataka_01",5)
		self:STALKERNPCMakeMeleeAttack(5)
		self:EmitSound("Stalker.Dog.Melee1")
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
	for j, i in pairs (ents.FindInSphere(self:GetPos(), 256 )) do
		if i:GetClass() == "npc_mutant_dog" then
			i:RunAway()
		end
	end
	
	return mul
end

function ENT:RunAway()
	if (!self.HasLeader) then
		self.MustFlee = true
		self:SetSchedule(SCHED_RUN_FROM_ENEMY)
		self.FleeTime = CurTime() + 5
	end
end

//little aggressive jump
function ENT:STALKERNPCDistanceForMeleeTooBig() 
	if(self.PlayingAnimation==false) then
		local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
		if distance < 200 then
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