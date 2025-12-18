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

ENT.hp = 200
ENT.hpvar = 50
ENT.injuredact = ACT_RUN_AIM_PISTOL

ENT.FBR = 5
ENT.FBRAP = 3
ENT.BR = 15

ENT.NextAbilityTime = 0

ENT.MinRangeDist = 0
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_RUN_RANDOM
ENT.RangeSchedule = SCHED_CHASE_ENEMY

ENT.flatbulletresistance = 3
ENT.percentbulletresistance = 10

function ENT:Initialize()
	self.Model = "models/monsters/snork2.mdl"
	self:STALKERNPCInit(Vector(-24,-24,70),MOVETYPE_STEP)
	
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Snork.Hit1" }
	
	local TEMP_MeleeMissTable = { "Stalker.Snork.Miss1" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 35
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 21
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 0.8
	TEMP_MeleeTable.bone[1] = "bip01_r_foot"
	self:STALKERNPCSetMeleeParams(1,"stand_attack_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 35
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 21
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 0.5
	TEMP_MeleeTable.bone[1] = "bip01_r_hand"
	self:STALKERNPCSetMeleeParams(2,"stand_attack_1",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 25
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 64
	TEMP_MeleeTable.radius[1] = 128
	TEMP_MeleeTable.time[1] = 0.8
	TEMP_MeleeTable.bone[1] = "bip01_r_foot"
	TEMP_MeleeTable.damage[2] = 25
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[2] = 64
	TEMP_MeleeTable.radius[2] = 128
	TEMP_MeleeTable.time[2] = 0.85
	TEMP_MeleeTable.bone[2] = "bip01_l_foot"
	self:STALKERNPCSetMeleeParams(4,"attack_run_0",2, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	//Jumping attacks
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 25
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 80
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 0.9
	TEMP_MeleeTable.bone[1] = "bip01_r_hand"
	TEMP_MeleeTable.damage[2] = 25
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[2] = 80
	TEMP_MeleeTable.radius[2] = 80
	TEMP_MeleeTable.time[2] = 1
	TEMP_MeleeTable.bone[2] = "bip01_l_hand"
	self:STALKERNPCSetMeleeParams(5,"stand_attack_3",2, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	
	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	
	self:SetMaxHealth(self:Health())

	self.CanJump = CurTime()+1

	self.NextAbilityTime = CurTime()+1
	
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()
	-- npc wounded animation
	if self:Health() < (self:GetMaxHealth() * 0.33) then
		self:SetMovementActivity(self.injuredact)
	end

	-- LONGJUMP
	if self.longjumping1 < CurTime() && self.IsLongJumping == 1 then 
		if(IsValid(self)&&self!=nil&&self!=NULL) and self:GetEnemy() then
			self:STALKERNPCClearAnimation()
			local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
			local dirnormal =((self:GetEnemy():GetPos() + Vector(0,0,128) + self:OBBCenter()) - (self:GetPos())):GetNormal()

			self:SetVelocity((dirnormal*(distance*1.5)))
			self:STALKERNPCPlayAnimation("stand_attack_3",5)
			self:STALKERNPCMakeMeleeAttack(5)
			self:EmitSound("Stalker.Snork.Die2")
			self.IsLongJumping = 2
		end
			
	end

	if self.longjumping2 < CurTime() && self.IsLongJumping == 2 and self:IsOnGround() then 
		if(IsValid(self)&&self!=nil&&self!=NULL) then
			self:STALKERNPCStopAllTimers()
			self:STALKERNPCClearAnimation()
			self.NextAbilityTime = CurTime()+1.5
			self.IsLongJumping = 0
		end
	end
	-- LONGJUMP END


	-- SMALL JUMP
	if (self.jumping1 < CurTime()) and self.isAttacking == 1 then
		local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
		local dirnormal =((self:GetEnemy():GetPos() + Vector(0,0,32) + self:OBBCenter()) - (self:GetPos())):GetNormal()

		self:SetVelocity((dirnormal*(distance*3)))		
		self:STALKERNPCPlayAnimation("attack_run_0",4)
		self:STALKERNPCMakeMeleeAttack(4)
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
			if distance > 200 && distance < 800 then
				if(TEMP_Rand==1) then		
					self.CanLongJump = CurTime()+6
					self.CanJump = CurTime()+3

					self.IsLongJumping = 1

					self.longjumping1 = CurTime()+0.01
					self.longjumping2 = CurTime()+2

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

function ENT:STALKERNPCDamageTake(dmginfo,mul) 
	if(dmginfo:GetDamageType() == DMG_BULLET) then
		dmginfo:SetDamage(dmginfo:GetDamage()*(1 - (self.percentbulletresistance/100)))
		dmginfo:SubtractDamage(self.flatbulletresistance)
		dmginfo:SetDamage(math.max(0,dmginfo:GetDamage())) --So he can't heal from our attacks
	end
end