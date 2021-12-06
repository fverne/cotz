AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")


ENT.PainSoundEnabled = true
ENT.PainSound.name = "Stalker.Controller.Pain"
ENT.PainSound.min = 1
ENT.PainSound.max = 6

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Controller.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 2
ENT.hp = 1500
ENT.hpvar = 100

ENT.CanSpecial = true

ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.CanSpecialTimer = 0
ENT.SpecialAttack = 0
ENT.special1 = 0
ENT.special2 = 0

ENT.MinRangeDist = 900
ENT.MaxRangeDist = 1500
ENT.VisibleSchedule = SCHED_RUN_FROM_ENEMY_FALLBACK
ENT.RangeSchedule = SCHED_RUN_RANDOM

function ENT:Initialize()
	self.Model = "models/monsters/tibet.mdl"
	self:STALKERNPCInit(Vector(-16,-16,70),MOVETYPE_STEP)
	
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Claw.Miss" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 19
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH, DMG_CLUB)
	TEMP_MeleeTable.distance[1] = 21
	TEMP_MeleeTable.radius[1] = 60
	TEMP_MeleeTable.time[1] = 0.8
	TEMP_MeleeTable.bone[1] = "bip01_r_hand"
	TEMP_MeleeTable.damage[2] = 19
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_SLASH, DMG_CLUB)
	TEMP_MeleeTable.distance[2] = 21
	TEMP_MeleeTable.radius[2] = 60
	TEMP_MeleeTable.time[2] = 1.2
	TEMP_MeleeTable.bone[2] = "bip01_l_hand"
	self:STALKERNPCSetMeleeParams(1,"S_Melee2",2, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	
	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	self.MaxVictims = 0


	self.GoingToSpawnThem = false
	self.NextSpawn = 0


	self:SetMaxHealth(self:Health())
	
	
	self.Victims = {}
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()

	if(self.CanSpecialTimer < CurTime()) then
		self.CanSpecial = true
	end


	if (self.special1 < CurTime() and self.SpecialAttack == 1) then
		self:EmitSound("Stalker.Controller.Control.3")	
		
		if (IsValid(self:GetEnemy())&&self:GetEnemy()!=nil&&self:GetEnemy()!=nil) then
			local TEMP_POORGUY = self:GetEnemy()
			if(TEMP_POORGUY:Visible(self)) then	
				local TEMP_ShootPoint = TEMP_POORGUY:GetPos()+TEMP_POORGUY:OBBCenter()

				local TEMP_ShootPos = self:GetPos()+Vector(0,0,50)+(self:GetForward()*15)
					
				local TEMP_Grav = ents.Create("ent_swampcontroller_ball")
				TEMP_Grav:SetPos(TEMP_ShootPos)
				TEMP_Grav:SetAngles((TEMP_ShootPoint-TEMP_ShootPos):Angle())
				TEMP_Grav:Spawn()
							
				TEMP_Grav:SetOwner(self)
							
				TEMP_Grav:GetPhysicsObject():SetVelocity((TEMP_ShootPoint-TEMP_ShootPos):GetNormalized()*2500)
				self:STALKERNPCClearAnimation()
			end

			self.SpecialAttack = 2
		end
	end

	if (self.special2 < CurTime() and self.SpecialAttack == 2) then
		self:STALKERNPCClearAnimation()
		self.SpecialAttack = 0
	end
end

function ENT:STALKERNPCDistanceForMeleeTooBig() 
	if(self.CanSpecial==true) then
		local TEMP_ShootPoint = self:GetPos()+(self:GetForward()*1000)
		if(self:GetEnemy()) then
			TEMP_ShootPoint = self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter()
		end
		local TEMP_ShootPos = self:GetPos()+Vector(0,0,50)+(self:GetForward()*15)

		local _, yaw, _ = (TEMP_ShootPoint-TEMP_ShootPos):GetNormalized():Angle():Unpack()
		local pitch, _, roll = self:GetAngles():Unpack()

		self:SetAngles(Angle(pitch,yaw,roll))

		self:STALKERNPCPlayAnimation("psy_attack_0")
		
		self:STALKERNPCPlaySoundRandom(100,"Stalker.Controller.SpecialAttack",1,1)

		self.special1 = CurTime() + 2
		self.special2 = CurTime() + 2.1
		self.SpecialAttack = 1

		self.CanSpecial = false
		self.CanSpecialTimer = CurTime()+9
	end
end

function ENT:STALKERNPCRemove()
end