AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Bloodsucker.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 4

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Bloodsucker.Hit"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 5

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Bloodsucker.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 3

ENT.ChasingSoundEnabled = true
ENT.ChasingSound.name = "Stalker.Bloodsucker.Chase"
ENT.ChasingSound.min = 1
ENT.ChasingSound.max = 3
ENT.ChasingSound.chance = 20

ENT.CanSpecial = true

--ENT.SNPCClass="C_MONSTER_LAB"
ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.CanJump = 0
ENT.CanSuck = 0

ENT.hp = 300
ENT.hpvar = 25

ENT.FBR = 5
ENT.FBRAP = 5
ENT.BR = 20

ENT.NextAbilityTime = 0

ENT.MinRangeDist = 0
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_RUN_RANDOM
ENT.RangeSchedule = SCHED_CHASE_ENEMY

ENT.jumping1 = 0
ENT.jumping2 = 0
ENT.IsJumping = 0
ENT.succing1 = 0
ENT.succing2 = 0
ENT.succing3 = 0
ENT.succing4 = 0
ENT.IsSuccing = 0

ENT.PostSuccRunFinish = 0

ENT.SuccVictim = nil

TEMP_TargetDamage = 0
distance = 0

function ENT:Initialize()
	self.Model = "models/monsters/krovosos.mdl"
	self:STALKERNPCInit(Vector(-28,-28,70),MOVETYPE_STEP)
	
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Snork.Hit1" }
	
	local TEMP_MeleeMissTable = { "Stalker.Snork.Miss1" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 30
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 81
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 1
	TEMP_MeleeTable.bone[1] = "bip01_l_hand"
	self:STALKERNPCSetMeleeParams(1,"stand_attack_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 30
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 81
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 1
	TEMP_MeleeTable.bone[1] = "bip01_r_hand"
	self:STALKERNPCSetMeleeParams(2,"stand_attack_1",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 30
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 81
	TEMP_MeleeTable.radius[1] = 120
	TEMP_MeleeTable.time[1] = 0.5
	TEMP_MeleeTable.bone[1] = "bip01_l_hand"
	TEMP_MeleeTable.damage[2] = 30
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[2] = 81
	TEMP_MeleeTable.radius[2] = 120
	TEMP_MeleeTable.time[2] = 0.8
	TEMP_MeleeTable.bone[2] = "bip01_r_hand"
	self:STALKERNPCSetMeleeParams(4,"stand_attack_run_0",2, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 15
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SONIC)
	TEMP_MeleeTable.distance[1] = 81
	TEMP_MeleeTable.radius[1] = 512
	TEMP_MeleeTable.time[1] = 1
	TEMP_MeleeTable.bone[1] = "bip01_r_hand"
	TEMP_MeleeTable.damage[2] = 30
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[2] = 81
	TEMP_MeleeTable.radius[2] = 120
	TEMP_MeleeTable.time[2] = 3.3
	TEMP_MeleeTable.bone[2] = "bip01_r_hand"
	self:STALKERNPCSetMeleeParams(6,"vampire",2, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	
	self:SetMaxHealth(self:Health())

	self.CanJump = CurTime()+1

	self.NextAbilityTime = CurTime()+1
	
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()
	if(self.PostSuccRunFinish<CurTime()) then
		self.RangeSchedule = SCHED_CHASE_ENEMY
	else
		self.RangeSchedule = SCHED_RUN_FROM_ENEMY_FALLBACK
	end

	-- JUMP
	if self.jumping1 < CurTime() && self.IsJumping == 1 then
		if(IsValid(self)&&self!=nil&&self!=NULL) then
			local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
			local dirnormal =((self:GetEnemy():GetPos() + Vector(0,0,96) + self:OBBCenter()) - (self:GetPos())):GetNormal()

			self:SetVelocity((dirnormal*(distance*2)))

			self:STALKERNPCPlayAnimation("stand_attack_run_0",4)
			self:STALKERNPCMakeMeleeAttack(4)
			self:EmitSound("Stalker.Bloodsucker.Hit1")
			self.IsJumping = 2
		end
	end

	if self.jumping2 < CurTime() && self.IsJumping == 2 and self:IsOnGround() then
		if(IsValid(self)&&self!=nil&&self!=NULL) then
			self:STALKERNPCStopAllTimers()
			self:STALKERNPCClearAnimation()
			self.NextAbilityTime = CurTime()+1
			self.IsJumping = 0
		end
	end
	-- JUMP END

	-- SUCC
	if self.succing1 < CurTime() && self.IsSuccing == 1 then
		if(IsValid(self)&&self!=nil&&self!=NULL) then
			self:EmitSound("Stalker.Bloodsucker.Feed")
			self:SetHealth(math.Clamp(self:Health()+125,0,self:GetMaxHealth()))
			self.IsSuccing = 2
		end
	end
	if self.succing2 < CurTime() && self.IsSuccing == 2 then
		if(IsValid(self)&&self!=nil&&self!=NULL) then
			self:SetHealth(math.Clamp(self:Health()+125,0,self:GetMaxHealth()))
			self.IsSuccing = 3
		end
	end

	if self.succing3 < CurTime() && self.IsSuccing == 3 then
		if(IsValid(self)&&self!=nil&&self!=NULL) then
			self:SetHealth(math.Clamp(self:Health()+125,0,self:GetMaxHealth()))
			self.IsSuccing = 4
		end
	end

	if self.succing4 < CurTime() && self.IsSuccing == 4 then
		if(IsValid(self)&&self!=nil&&self!=NULL) then
			self.NextAbilityTime = CurTime()+1

			self:SetHealth(math.Clamp(self:Health()+125,0,self:GetMaxHealth()))
			self.SuccVictim:Freeze(false)
			self.SuccVictim = nil
			self.IsSuccing = 0

			self.PostSuccRunFinish = CurTime() + 10

		end
	end
	-- SUCC END
end

//little aggressive jump
function ENT:STALKERNPCDistanceForMeleeTooBig() 
	if self.NextAbilityTime < CurTime() then
		if(self.PlayingAnimation==false) then
			local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
			if distance < 100 then
				if(self.CanJump<CurTime()) then
					local TEMP_Rand = math.random(1,5)
				
					if(TEMP_Rand==1) then		
						self.CanJump = CurTime()+9
						self.NextAbilityTime = CurTime()+4

						self.jumping1 = CurTime() + 0.2
						self.jumping2 = CurTime() + 1
						self.IsJumping = 1

					end
				end
			end
		end

		if(self.PlayingAnimation==false) then
			distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
			if distance < 75 then
				if(self.CanSuck<CurTime()) then
					local TEMP_Rand = math.random(1,5)
				
					if(TEMP_Rand==1) then		
						self.CanSuck = CurTime()+15

						local target = self:GetEnemy()
						target:Freeze(true)

						self.SuccVictim = target

						self.NextAbilityTime = CurTime()+4

						self:STALKERNPCPlayAnimation("vampire",6)
						self:STALKERNPCMakeMeleeAttack(6)

						self.succing1 = CurTime() + 0.2
						self.succing2 = CurTime() + 1.2
						self.succing3 = CurTime() + 2.2
						self.succing4 = CurTime() + 3.2
						self.IsSuccing = 1
	
					end
				end
			end
		end
	end
end

function ENT:STALKERNPCOnKilled()
	if self.SuccVictim then
		self.SuccVictim:Freeze(false)
	end
end

function ENT:STALKERNPCRemove() 
	if self.SuccVictim then
		self.SuccVictim:Freeze(false)
	end
end