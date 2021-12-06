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
ENT.MeleeSound.max = 2

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Pseudogiant.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 4

ENT.ChasingSoundEnabled = true
ENT.ChasingSound.name = "Stalker.Pseudogiant.Chase"
ENT.ChasingSound.min = 1
ENT.ChasingSound.max = 4
ENT.ChasingSound.chance = 5

--ENT.SNPCClass="C_MONSTER_LAB"
ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.hp = 7500
ENT.hpvar = 2500

ENT.CanSlam = 0
ENT.isSlamming = 0
ENT.slamming1 = 0
ENT.slamming2 = 0

ENT.NextAbilityTime = 0

ENT.MinRangeDist = 800
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_IDLE_WANDER 
ENT.RangeSchedule = SCHED_CHASE_ENEMY

ENT.flatbulletresistance = 6
ENT.percentbulletresistance = 35

function ENT:Initialize()
	self.Model = "models/monsters/gigant3.mdl"
	self:STALKERNPCInit(Vector(-48,-48,70),MOVETYPE_STEP)
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Dog.Miss1" }

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 85
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 128
	TEMP_MeleeTable.radius[1] = 128
	TEMP_MeleeTable.time[1] = 0.75
	TEMP_MeleeTable.bone[1] = "head"
	self:STALKERNPCSetMeleeParams(1,"stand_attack_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()

	TEMP_MeleeTable.damage[1] = 70
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 128
	TEMP_MeleeTable.radius[1] = 128
	TEMP_MeleeTable.time[1] = 0.75
	TEMP_MeleeTable.bone[1] = "lefttophand"
	self:STALKERNPCSetMeleeParams(2,"stand_attack_1",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	TEMP_MeleeTable.damage[1] = 110
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 128
	TEMP_MeleeTable.radius[1] = 128
	TEMP_MeleeTable.time[1] = 0.5
	TEMP_MeleeTable.bone[1] = "head"
	self:STALKERNPCSetMeleeParams(3,"stand_attack_2",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()


	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 70
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 128
	TEMP_MeleeTable.radius[1] = 128
	TEMP_MeleeTable.time[1] = 1.5
	TEMP_MeleeTable.bone[1] = "righthand"
	self:STALKERNPCSetMeleeParams(5,"stand_kick_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	
	self:SetMaxHealth(self:Health())
	
	self:SetRenderMode(RENDERMODE_TRANSALPHA)

	--To make sure our bone lookups are correct

	local pos = self:GetBonePosition(0)
	if pos == self:GetPos() then
		pos = self:GetBoneMatrix(0):GetTranslation()
	end

end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()
	-- SLAM 
	if (self.slamming1 < CurTime() and self.isSlamming == 1 and self:GetEnemy()) then
		self:EmitSound("Stalker.Pseudogiant.Idle1")
		self:STALKERNPCPlayAnimation("stand_kick_0",5)
		self:STALKERNPCMakeMeleeAttack(5)
		self.isSlamming = 2
	end

	if (self.slamming2 < CurTime() and self.isSlamming == 2 and self:IsOnGround()) then
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

			local bonepos = self:GetBonePosition( self:LookupBone("righthand") )

			local distance = self:GetPos():Distance(v:GetPos())
			local dirvector = ((v:GetPos()+Vector(0,0,160)) - (bonepos)):GetNormal()

			local fulldamage = 350
			TEMP_TargetDamage = DamageInfo()
									
			TEMP_TargetDamage:SetDamage(fulldamage * ((512-distance)/512))
			TEMP_TargetDamage:SetInflictor(self)
			TEMP_TargetDamage:SetDamageType(DMG_BULLET)
			TEMP_TargetDamage:SetAttacker(self)
			TEMP_TargetDamage:SetDamagePosition(v:NearestPoint(bonepos+self:OBBCenter()))
			TEMP_TargetDamage:SetDamageForce(dirvector*400)

			v:TakeDamageInfo(TEMP_TargetDamage)
			v:SetVelocity(dirvector*500)
		end

		self.isSlamming = 0
	end
end

function ENT:STALKERNPCOnDeath()

end

function ENT:STALKERNPCDistanceForMeleeTooBig() 
	if(self.PlayingAnimation==false) then
		local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
		if distance < 300 then
			if(self.CanSlam<CurTime()) then
				local TEMP_Rand = math.random(1,5)
				
				if(TEMP_Rand==1) then		
					self.CanSlam = CurTime()+9
					self.isSlamming = 1
					self.slamming1 = CurTime()+0.3
					self.slamming2 = CurTime()+1.8
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