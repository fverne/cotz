AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

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

ENT.CanJump = 0
ENT.isAttacking = 0
ENT.jumping1 = 0
ENT.jumping2 = 0
ENT.CanLongJump = 0

ENT.IsLongJumping = 0
ENT.longjumping1 = 0
ENT.longjumping2 = 0

ENT.hp = 1200
ENT.hpvar = 200

ENT.NextAbilityTime = 0

ENT.MinRangeDist = 0
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_RUN_RANDOM
ENT.RangeSchedule = SCHED_CHASE_ENEMY

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
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 21
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 0.8
	TEMP_MeleeTable.bone[1] = "bip01_l_hand"
	self:STALKERNPCSetMeleeParams(1,"attack_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	//Jumping attack
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 85
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 80
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 0.9
	TEMP_MeleeTable.bone[1] = "bip01_r_hand"
	self:STALKERNPCSetMeleeParams(3,"attack_1",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	
	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	
	self:SetMaxHealth(self:Health())

	self.CanJump = CurTime()+1

	self.NextAbilityTime = CurTime()+1
	
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()
	-- LONGJUMP
	if self.longjumping1 < CurTime() && self.IsLongJumping == 1 then 
		if(IsValid(self)&&self!=nil&&self!=NULL) and self:GetEnemy() then
			self:STALKERNPCClearAnimation()
			local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
			local dirnormal =((self:GetEnemy():GetPos() + Vector(0,0,128) + self:OBBCenter()) - (self:GetPos())):GetNormal()

			self:SetVelocity((dirnormal*(distance*1.5)))
			self:STALKERNPCPlayAnimation("attack_1",3)
			self:STALKERNPCMakeMeleeAttack(3)
			self:EmitSound("Stalker.Vareshka.Hit1")
			self.IsLongJumping = 2
		end
			
	end

	if self.longjumping2 < CurTime() && self.IsLongJumping == 2 and self:IsOnGround() then 
		if(IsValid(self)&&self!=nil&&self!=NULL) then
			self:STALKERNPCStopAllTimers()
			self:STALKERNPCClearAnimation()
			self.NextAbilityTime = CurTime()+1.5
			self.IsLongJumping = 0

			for _,v in pairs(ents.FindInSphere( self:GetPos(), 512 )) do
				if(v == self) then continue end
				local distance = self:GetPos():Distance(v:GetPos())

				local fulldamage = 80
				TEMP_TargetDamage = DamageInfo()
									
				TEMP_TargetDamage:SetDamage(fulldamage * ((512-distance)/512))
				TEMP_TargetDamage:SetInflictor(self)
				TEMP_TargetDamage:SetDamageType(DMG_BULLET)
				TEMP_TargetDamage:SetAttacker(self)
				TEMP_TargetDamage:SetDamagePosition(v:NearestPoint(self:GetPos()+self:OBBCenter()))
				TEMP_TargetDamage:SetDamageForce(((v:GetPos() + self:OBBCenter()) - (self:GetPos())):GetNormal())

				v:TakeDamageInfo(TEMP_TargetDamage)
			end

			local effectdata = EffectData()
			effectdata:SetOrigin( self:GetPos() + Vector(0,0,-16) )
			effectdata:SetStart( self:GetPos() + Vector( 0, 0, math.Rand( -100, 170) ) )
			effectdata:SetOrigin( self:GetPos() + Vector( 0, 0, math.Rand( -100, 170) ))
			effectdata:SetNormal(  self:GetUp() )
			effectdata:SetScale( 200 )
			effectdata:SetRadius( 16 )
			effectdata:SetMagnitude( 8 )
			util.Effect( "ThumperDust", effectdata )
		end
	end
	-- LONGJUMP END


	-- SMALL JUMP
	if (self.jumping1 < CurTime()) and self.isAttacking == 1 then
		self:SetVelocity(((self:GetEnemy():GetPos() + self:OBBCenter()) -(self:GetPos() + self:OBBCenter())):GetNormal()*400 +self:GetForward()*(14*distance) +self:GetUp()*math.Clamp((0.5 * distance),150,400))
		self:STALKERNPCPlayAnimation("attack_1",3)
		self:STALKERNPCMakeMeleeAttack(3)
		self:EmitSound("Stalker.Vareshka.Chase4")
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
			if distance > 400 && distance < 800 then
				if(TEMP_Rand==1) then		
					self.CanLongJump = CurTime()+6
					self.CanJump = CurTime()+3

					self.IsLongJumping = 1

					self.longjumping1 = CurTime()+0.01
					self.longjumping2 = CurTime()+0.5

				end
			end
		end

	end

	if(self.PlayingAnimation==false) then
		local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
		if distance < 400 then
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