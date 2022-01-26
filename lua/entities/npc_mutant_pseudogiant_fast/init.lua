AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Pseudogiant.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 2

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Pseudogiant.Melee"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 4

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Pseudogiant.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 4

ENT.ChasingSoundEnabled = true
ENT.ChasingSound.name = "Stalker.Pseudogiant.Chase"
ENT.ChasingSound.min = 1
ENT.ChasingSound.max = 7
ENT.ChasingSound.chance = 5

--ENT.SNPCClass="C_MONSTER_LAB"
ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.hp = 5000
ENT.hpvar = 1250

ENT.CanJump = 0
ENT.isAttacking = 0
ENT.jumping1 = 0
ENT.jumping2 = 0

ENT.CanBigJump = 0
ENT.isBigJumping = 0
ENT.bigjumping1 = 0
ENT.bigjumping2 = 0

ENT.NextAbilityTime = 0

ENT.MinRangeDist = 800
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_IDLE_WANDER 
ENT.RangeSchedule = SCHED_CHASE_ENEMY

ENT.flatbulletresistance = 3
ENT.percentbulletresistance = 25

function ENT:Initialize()
	self.Model = "models/monsters/gigant.mdl"
	self:STALKERNPCInit(Vector(-48,-48,70),MOVETYPE_STEP)
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Dog.Miss1" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 60
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 128
	TEMP_MeleeTable.radius[1] = 128
	TEMP_MeleeTable.time[1] = 0.66
	TEMP_MeleeTable.bone[1] = "bip01_spine"
	self:STALKERNPCSetMeleeParams(1,"stand_attack_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 60
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 128
	TEMP_MeleeTable.radius[1] = 128
	TEMP_MeleeTable.time[1] = 0.4
	TEMP_MeleeTable.bone[1] = "bip01_spine"
	self:STALKERNPCSetMeleeParams(2,"stand_attack_1",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 30
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 100
	TEMP_MeleeTable.radius[1] = 256
	TEMP_MeleeTable.time[1] = 0.6
	TEMP_MeleeTable.bone[1] = "bip01_r_foot"
	self:STALKERNPCSetMeleeParams(3,"stand_attack_2",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 50
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 128
	TEMP_MeleeTable.radius[1] = 128
	TEMP_MeleeTable.time[1] = 1.3
	TEMP_MeleeTable.bone[1] = "bip01_l_foot"
	self:STALKERNPCSetMeleeParams(5,"jump_attack_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)


	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 20
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 128
	TEMP_MeleeTable.radius[1] = 128
	TEMP_MeleeTable.time[1] = 0.45
	TEMP_MeleeTable.bone[1] = "bip01_l_foot"
	self:STALKERNPCSetMeleeParams(6,"stand_attack_run_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))	
	
	self:SetMaxHealth(self:Health())
	
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()

	-- BIG JUMP 
	if (self.bigjumping1 < CurTime() and self.isBigJumping == 1 and self:GetEnemy()) then
		local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
		local dirnormal =((self:GetEnemy():GetPos() + Vector(0,0,48) + self:OBBCenter()) - (self:GetPos())):GetNormal()

		self:SetVelocity((dirnormal*(distance*2)))

		self.isBigJumping = 2
	end

	if (self.bigjumping2 < CurTime() and self.isBigJumping == 2 and self:IsOnGround()) then
		self:STALKERNPCStopAllTimers()
		self:STALKERNPCClearAnimation()

		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + Vector(0,0,-16) )
		effectdata:SetStart( self:GetPos() + Vector( 0, 0, math.Rand( -100, 170) ) )
		effectdata:SetOrigin( self:GetPos() + Vector( 0, 0, math.Rand( -100, 170) ))
		effectdata:SetNormal(  self:GetUp() )
		effectdata:SetScale( 200 )
		effectdata:SetRadius( 16 )
		effectdata:SetMagnitude( 8 )
		util.Effect( "ThumperDust", effectdata )

		for _,v in pairs(ents.FindInSphere( self:GetPos(), 512 )) do
			if(v == self) then continue end
			local distance = self:GetPos():Distance(v:GetPos())

			local fulldamage = 150
			TEMP_TargetDamage = DamageInfo()
									
			TEMP_TargetDamage:SetDamage(fulldamage * ((512-distance)/512))
			TEMP_TargetDamage:SetInflictor(self)
			TEMP_TargetDamage:SetDamageType(DMG_BULLET)
			TEMP_TargetDamage:SetAttacker(self)
			TEMP_TargetDamage:SetDamagePosition(v:NearestPoint(self:GetPos()+self:OBBCenter()))
			TEMP_TargetDamage:SetDamageForce(((v:GetPos() + self:OBBCenter()) - (self:GetPos())):GetNormal())

			v:TakeDamageInfo(TEMP_TargetDamage)
		end

		self.isBigJumping = 0
	end

	-- SMALL JUMP
	if (self.jumping1 < CurTime()) and self.isAttacking == 1 then
		local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
		local dirnormal =((self:GetEnemy():GetPos() + Vector(0,0,32) + self:OBBCenter()) - (self:GetPos())):GetNormal()

		self:SetVelocity((dirnormal*(distance*3)))

		self:STALKERNPCPlayAnimation("stand_attack_run_0",6)
		self:STALKERNPCMakeMeleeAttack(6)
		self:EmitSound("Stalker.Pseudogiant.Melee1")
		self.isAttacking = 2
	end

	if (self.jumping2 < CurTime()) and self.isAttacking == 2 then
		self:STALKERNPCStopAllTimers()
		self:STALKERNPCClearAnimation()
		self.NextAbilityTime = CurTime()+0.5
		self.isAttacking = 0
	end
end

function ENT:STALKERNPCOnDeath()

end

function ENT:STALKERNPCDistanceForMeleeTooBig() 
	if(self.PlayingAnimation==false) then
		local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
		if distance < 200 then
			if(self.CanJump<CurTime()) then
				local TEMP_Rand = math.random(1,5)
				
				if(TEMP_Rand==1) then		
					self.CanJump = CurTime()+6
					self.isAttacking = 1
					self.jumping1 = CurTime()+0.3
					self.jumping2 = CurTime()+0.8
				end
			end
		end

		if (distance > 300 and distance < 1200) then
			if(self.CanBigJump<CurTime()) then
				local TEMP_Rand = math.random(1,5)

				if(TEMP_Rand==1) then		
					self.CanBigJump = CurTime()+10
					self.isBigJumping = 1
					self.bigjumping1 = CurTime()+0.3
					self.bigjumping2 = CurTime()+0.8

					self:EmitSound("Stalker.Pseudogiant.Idle1")
					self:STALKERNPCPlayAnimation("jump_attack_0",5)
					self:STALKERNPCMakeMeleeAttack(5)
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