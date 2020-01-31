AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Snork.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 2

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Snork.Melee"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 4

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Snork.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 3

ENT.ChasingSoundEnabled = true
ENT.ChasingSound.name = "Stalker.Snork.Idle"
ENT.ChasingSound.min = 1
ENT.ChasingSound.max = 3
ENT.ChasingSound.chance = 20

ENT.CanSpecial = true

--ENT.SNPCClass="C_MONSTER_LAB"
ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.CanJump = 0
ENT.isAttacking = 0
ENT.jumping1 = 0
ENT.jumping2 = 0
ENT.CanLongJump = 0

ENT.IsLongJumping = 0
ENT.longjumping1 = 0
ENT.longjumping2 = 0

ENT.hp = 175

ENT.NextAbilityTime = 0

ENT.MinRangeDist = 0
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_RUN_RANDOM
ENT.RangeSchedule = SCHED_CHASE_ENEMY

function ENT:Initialize()
	self.Model = "models/stalkertnb/snork1.mdl"
	self:STALKERNPCInit(Vector(-24,-24,90),MOVETYPE_STEP)
	
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Snork.Hit1" }
	
	local TEMP_MeleeMissTable = { "Stalker.Snork.Miss1" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 35
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 21
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 1
	TEMP_MeleeTable.bone[1] = "ValveBiped.Bip01_R_Hand"
	self:STALKERNPCSetMeleeParams(1,"attackA",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 35
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 21
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 1
	TEMP_MeleeTable.bone[1] = "ValveBiped.Bip01_R_Hand"
	self:STALKERNPCSetMeleeParams(2,"attackB",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 35
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 21
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 1
	TEMP_MeleeTable.bone[1] = "ValveBiped.Bip01_L_Hand"
	self:STALKERNPCSetMeleeParams(3,"attackC",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 35
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 21
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 1
	TEMP_MeleeTable.bone[1] = "ValveBiped.Bip01_L_Hand"
	self:STALKERNPCSetMeleeParams(4,"attackD",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 35
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 21
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 1
	TEMP_MeleeTable.bone[1] = "ValveBiped.Bip01_L_Hand"
	TEMP_MeleeTable.damage[2] = 35
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[2] = 21
	TEMP_MeleeTable.radius[2] = 80
	TEMP_MeleeTable.time[2] = 1.2
	TEMP_MeleeTable.bone[2] = "ValveBiped.Bip01_R_Hand"
	self:STALKERNPCSetMeleeParams(5,"attackE",2, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 35
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 21
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 1
	TEMP_MeleeTable.bone[1] = "ValveBiped.Bip01_L_Hand"
	TEMP_MeleeTable.damage[2] = 35
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[2] = 21
	TEMP_MeleeTable.radius[2] = 80
	TEMP_MeleeTable.time[2] = 1.2
	TEMP_MeleeTable.bone[2] = "ValveBiped.Bip01_R_Hand"
	self:STALKERNPCSetMeleeParams(6,"attackF",2, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)


	//Jumping attacks
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 35
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 100
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 1
	TEMP_MeleeTable.bone[1] = "ValveBiped.Bip01_L_Hand"
	TEMP_MeleeTable.damage[2] = 35
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[2] = 100
	TEMP_MeleeTable.radius[2] = 80
	TEMP_MeleeTable.time[2] = 1.2
	TEMP_MeleeTable.bone[2] = "ValveBiped.Bip01_R_Hand"
	self:STALKERNPCSetMeleeParams(7,"attackF",2, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 35
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 100
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 1
	TEMP_MeleeTable.bone[1] = "ValveBiped.Bip01_L_Hand"
	self:STALKERNPCSetMeleeParams(8,"attackC",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	self:SetHealth(self.hp)	
	
	self:SetMaxHealth(self:Health())

	self.CanJump = CurTime()+1

	self.NextAbilityTime = CurTime()+1
	
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()
	local distance = 0
	if self:GetEnemy() then
		local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
	end
	

	-- LONGJUMP
	if self.longjumping1 < CurTime() && self.IsLongJumping == 1 then 
		if(IsValid(self)&&self!=nil&&self!=NULL) then
			local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
			self:SetLocalVelocity(((self:GetEnemy():GetPos() + self:OBBCenter()) -(self:GetPos() + self:OBBCenter())):GetNormal()*400 +self:GetForward()*(8*distance) +self:GetUp()*math.Clamp((0.5 * distance),150,400))
			self:STALKERNPCPlayAnimation("attackF",7)
			self:STALKERNPCMakeMeleeAttack(7)
			self:EmitSound("Stalker.Snork.Die2")
			self.IsLongJumping = 2
		end
			
	end

	if self.longjumping2 < CurTime() && self.IsLongJumping == 2 then 
		if(IsValid(self)&&self!=nil&&self!=NULL) then
			self:STALKERNPCStopAllTimers()
			self:STALKERNPCClearAnimation()
			self.NextAbilityTime = CurTime()+0.5
			self.IsLongJumping = 0
		end
	end
	-- LONGJUMP END


	-- SMALL JUMP
	if (self.jumping1 < CurTime()) and self.isAttacking == 1 then
		self:SetLocalVelocity(((self:GetEnemy():GetPos() + self:OBBCenter()) -(self:GetPos() + self:OBBCenter())):GetNormal()*400 +self:GetForward()*(14*distance) +self:GetUp()*math.Clamp((0.5 * distance),150,400))
		self:STALKERNPCPlayAnimation("attackC",8)
		self:STALKERNPCMakeMeleeAttack(8)
		self:EmitSound("Stalker.Snork.Die2")
		self.isAttacking = 2		
	end

	if (self.jumping2 < CurTime()) and self.isAttacking == 2 then
		self:STALKERNPCStopAllTimers()
		self:STALKERNPCClearAnimation()
		self.NextAbilityTime = CurTime()+0.5
		self.isAttacking = 0
	end
end


function ENT:STALKERNPCDistanceForMeleeTooBig() 
	if(self.PlayingAnimation==false) then
		if(self.CanLongJump<CurTime()) then
			local TEMP_Rand = math.random(1,5)

			local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
			if distance > 200 then
				if(TEMP_Rand==1) then		
					self.CanLongJump = CurTime()+6
						
					--self:STALKERNPCPlayAnimation("releasecrab",6)
					self:STALKERNPCPlayAnimation("Stand_to_crouch",1)

					self.IsLongJumping = 1

					self.longjumping1 = CurTime()+0.4
					self.longjumping1 = CurTime()+2

				end
			end
		end

	end

	if(self.PlayingAnimation==false) then
		local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
		if distance < 200 then
			if(self.CanJump<CurTime()) then
				local TEMP_Rand = math.random(1,5)
			
				if(TEMP_Rand==1) then		
					self.CanJump = CurTime()+3
					self.isAttacking = 1
					self.jumping1 = CurTime()+0.2
					self.jumping2 = CurTime()+5
				end
			end
		end
	end
end