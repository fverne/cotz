AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Karlik.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 1

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Karlik.Melee"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 1

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Karlik.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 3

ENT.CanSpecial = true

--ENT.SNPCClass="C_MONSTER_LAB"
ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.CanWarp = 0

ENT.hp = 800

ENT.WantToWarp = false
ENT.IsWarping = 0
ENT.warpdelay = 0

ENT.CanThrow = 0

ENT.IsThrow1 = 0
ENT.throw1_1 = 0

ENT.IsThrow2 = 0
ENT.throw2_1 = 0
ENT.throw2_2 = 0

ENT.WantToKnock = false
ENT.CanKnock = 0
ENT.knocking = 0
ENT.secondKnock = 0

ENT.NextAbilityTime = 0

ENT.MinRangeDist = 800
ENT.MaxRangeDist = 1500
ENT.VisibleSchedule = SCHED_ALERT_FACE
ENT.RangeSchedule = SCHED_IDLE_STAND

function ENT:Initialize()
	self.Model = "models/maver1k_XVII/Stalker/mutants/karlik.mdl"
	self:STALKERNPCInit(Vector(-32,-32,40),MOVETYPE_STEP)
	
	self.MinRangeDist = 800
	self.MaxRangeDist = 1500
	self:SetBloodColor(BLOOD_COLOR_ZOMBIE)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Claw.Miss" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 0
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_MISSILEDEFENSE)
	TEMP_MeleeTable.distance[1] = 21
	TEMP_MeleeTable.radius[1] = 60
	TEMP_MeleeTable.time[1] = 0.6
	TEMP_MeleeTable.bone[1] = "right_hand"
	self:STALKERNPCSetMeleeParams(1,"stand_idle_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	
	self:SetHealth(self.hp)	
	
	self:SetMaxHealth(self:Health())

	self.CanWarp = CurTime()+1
	self.CanThrow = CurTime()+1
	self.CanKnock = CurTime()+1
	
	self.NextAbilityTime = CurTime()+1
	
	self.MustWarp = 0
	
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()
	if( self.CanWarp < CurTime() && self.WantToWarp && self.IsWarping == 0) then
		self:STALKERNPCClearAnimation()
		self:STALKERNPCPlayAnimation("stand_blinded_2",1)
		self.IsWarping = 1
		self.warpdelay = CurTime() + 1.2
	end

	if(self.warpdelay < CurTime() && self.IsWarping == 1) then
		sound.Play("Stalker.Controller.Control.3",self:GetPos())
		self.Entity:SetNWBool( "Teleport", true )
		self.Entity:SetNWVector( "OldPos", self:GetPos()+Vector(0,0,45))

		self:SetPos(self:GetTeleportLocation())
		self.IsWarping = 0
		self.WantToWarp = false
		self.CanWarp = CurTime()+10
		self:STALKERNPCClearAnimation()
	end

	if self:GetEnemy() then
		local dist = self:GetPos():Distance(self:GetEnemy():GetPos())

		if dist < self.MinRangeDist/2 then
			self.WantToKnock = true
		end
	end

	if self.throw1_1 < CurTime() && self.IsThrow1 == 1 then
		self.IsThrow1 = 0

		if(IsValid(self:GetEnemy())&&self:GetEnemy()!=nil&&self:GetEnemy()!=NULL) then
			TEMP_ShootPoint = self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter()
		end

		self:STALKERNPCPlaySoundRandom(100,"Stalker.Karlik.Push",1,1)

		local TEMP_ShootPos = self:GetPos()+Vector(0,0,50)+(self:GetForward()*15)
					
		local TEMP_Grav = ents.Create("ent_karlik_ball")
		TEMP_Grav:SetPos(TEMP_ShootPos)
		TEMP_Grav:SetAngles((TEMP_ShootPoint-TEMP_ShootPos):Angle())
		TEMP_Grav:Spawn()
							
		TEMP_Grav:SetOwner(self)
							
		TEMP_Grav:GetPhysicsObject():SetVelocity((TEMP_ShootPoint-TEMP_ShootPos):GetNormalized()*2000)

		self:STALKERNPCClearAnimation()

	end

	if self.throw2_1 < CurTime() && self.IsThrow2 == 1 then
		self.IsThrow2 = 2

		if(IsValid(self:GetEnemy())&&self:GetEnemy()!=nil&&self:GetEnemy()!=NULL) then
			TEMP_ShootPoint = self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter()
		end

		self:STALKERNPCPlaySoundRandom(100,"Stalker.Karlik.Push",1,1)

		local TEMP_ShootPos = self:GetPos()+Vector(0,0,50)+(self:GetForward()*15)
					
		local TEMP_Grav = ents.Create("ent_karlik_ball")
		TEMP_Grav:SetPos(TEMP_ShootPos)
		TEMP_Grav:SetAngles((TEMP_ShootPoint-TEMP_ShootPos):Angle())
		TEMP_Grav:Spawn()
							
		TEMP_Grav:SetOwner(self)
							
		TEMP_Grav:GetPhysicsObject():SetVelocity((TEMP_ShootPoint-TEMP_ShootPos):GetNormalized()*2000)

	end

	if self.throw2_2 < CurTime() && self.IsThrow2 == 2 then
		self.IsThrow2 = 0

		if(IsValid(self:GetEnemy())&&self:GetEnemy()!=nil&&self:GetEnemy()!=NULL) then
			TEMP_ShootPoint = self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter()
		end

		self:STALKERNPCPlaySoundRandom(100,"Stalker.Karlik.Push",1,1)

		local TEMP_ShootPos = self:GetPos()+Vector(0,0,50)+(self:GetForward()*15)
					
		local TEMP_Grav = ents.Create("ent_karlik_ball")
		TEMP_Grav:SetPos(TEMP_ShootPos)
		TEMP_Grav:SetAngles((TEMP_ShootPoint-TEMP_ShootPos):Angle())
		TEMP_Grav:Spawn()
							
		TEMP_Grav:SetOwner(self)
							
		TEMP_Grav:GetPhysicsObject():SetVelocity((TEMP_ShootPoint-TEMP_ShootPos):GetNormalized()*2000)

		self:STALKERNPCClearAnimation()
	end

	if self.WantToKnock && self.CanKnock < CurTime() then
		self:STALKERNPCClearAnimation()
		self:STALKERNPCPlayAnimation("stand_attack_3",1)

		self.CanKnock = CurTime() + 10
		self.secondKnock = CurTime() + 1.6
		
		self.WantToKnock = false
		self.knocking = 1
	end

	if self.secondKnock < CurTime() && self.knocking == 1 then
		for k,v in pairs(ents.FindInSphere( self:GetPos(), self.MinRangeDist )) do
			if(v == self) then continue end
			local dirnormal =((v:GetPos() + self:OBBCenter()) - (self:GetPos() - Vector(0,0,96))):GetNormal()

			local phys = v:GetPhysicsObject()
			if IsValid(phys) then
				v:GetPhysicsObject():SetVelocity(dirnormal*700)
			end
			if v:IsPlayer() then
				v:SetVelocity(dirnormal*700)
			end

			
		end

		self.Entity:SetNWBool( "Knocking", true )

		self.knocking = 0
		self:STALKERNPCClearAnimation()
	end
end


function ENT:STALKERNPCDistanceForMeleeTooSmall()

end

function ENT:STALKERNPCDistanceForMeleeTooBig() 
	if(self.PlayingAnimation==false) then

		if(self.CanThrow < CurTime()) then
			local TEMP_Rand = math.random(1,9)
			
			if(TEMP_Rand < 3) then
				self.CanThrow = CurTime() + 4
				
				self:STALKERNPCPlayAnimation("stand_attack_0", 1 )

				self.IsThrow1 = 1
				self.throw1_1 = CurTime() + 1.1
					
			end

			if(TEMP_Rand == 7) then
				self.CanThrow = CurTime() + 6
				
				self:STALKERNPCPlayAnimation("stand_attack_1", 1 )

				self.IsThrow2 = 1
				self.throw2_1 = CurTime() + 0.7
				self.throw2_2 = CurTime() + 1.4
					
			end
		end
	end
end

function ENT:STALKERNPCDamageTake(dmginfo,mul)
	if(self.CanWarp < CurTime()) then
		local TEMP_Rand = math.random(1,3)
		
		if(TEMP_Rand==1) then
			self.WantToWarp = true
		end
	end
	
	return mul
end


function ENT:GetTeleportLocation( )
	local tracegood = false
	local teleres

	local firstTrace = util.TraceLine( {
			start = self:GetPos() + Vector(0,0,64),
			endpos = self:GetPos() + Vector(0,0,800),
			filter = "npc_mutant_karlik",
			mask = MASK_ALL,
			ignoreworld = false
		} )

	repeat
		local trace = util.TraceHull( {
			start = firstTrace.HitPos - Vector(0,0,-64),
			endpos = self:GetEnemy():GetPos() + Vector(math.random(-1200,1200),math.random(-1200,1200),-400),
			mins = Vector( -32, -32, 0 ),
			maxs = Vector( 32, 32, 64 ),
			filter = "npc_mutant_karlik",
			mask = MASK_ALL,
			ignoreworld = false
		} )

		if !trace.HitSky && trace.HitPos:Distance(self:GetEnemy():GetPos()) > 600 then
			tracegood = true
			teleres = trace.HitPos
		end

	until tracegood


	return teleres
end