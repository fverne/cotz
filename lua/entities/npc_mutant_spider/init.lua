AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Spider.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 3

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Spider.Melee"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 3

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Spider.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 3

ENT.ChasingSoundEnabled = true
ENT.ChasingSound.name = "Stalker.Spider.Chase"
ENT.ChasingSound.min = 1
ENT.ChasingSound.max = 4
ENT.ChasingSound.chance = 20

--ENT.SNPCClass="C_MONSTER_LAB"
ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.hp = 270
ENT.hpvar = 50

ENT.flatbulletresistance = 2
ENT.percentbulletresistance = 10

ENT.CanJump = 0
ENT.isAttacking = 0
ENT.jumping1 = 0
ENT.jumping2 = 0

ENT.NextAbilityTime = 0

ENT.IsTeleporting = 0
ENT.CanTeleportTimer = 0

ENT.CanSpit = 0
ENT.spitting = 0
ENT.IsSpitting = 0

ENT.MinRangeDist = 800
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_IDLE_WANDER 
ENT.RangeSchedule = SCHED_CHASE_ENEMY

function ENT:Initialize()
	self.Model = "models/darkmessiah/spider_regular.mdl"
	self:STALKERNPCInit(Vector(-16,-16,70),MOVETYPE_STEP)
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Dog.Miss1" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 35
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 40
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 0.8
	TEMP_MeleeTable.bone[1] = "SK_Head_End"
	self:STALKERNPCSetMeleeParams(1,"attack_4",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()

	//Jumping attack
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	TEMP_MeleeTable.damage[1] = 15
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_ACID)
	TEMP_MeleeTable.distance[1] = 64
	TEMP_MeleeTable.radius[1] = 40
	TEMP_MeleeTable.time[1] = 1.3
	TEMP_MeleeTable.bone[1] = "SK_R_Leg_a3"
	TEMP_MeleeTable.damage[2] = 15
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_ACID)
	TEMP_MeleeTable.distance[2] = 64
	TEMP_MeleeTable.radius[2] = 40
	TEMP_MeleeTable.time[2] = 1.3
	TEMP_MeleeTable.bone[2] = "SK_L_Leg_a3"
	TEMP_MeleeTable.damage[3] = 15
	TEMP_MeleeTable.damagetype[3] = bit.bor(DMG_ACID)
	TEMP_MeleeTable.distance[3] = 64
	TEMP_MeleeTable.radius[3] = 40
	TEMP_MeleeTable.time[3] = 1.3
	TEMP_MeleeTable.bone[3] = "SK_R_Leg_b3"
	TEMP_MeleeTable.damage[4] = 15
	TEMP_MeleeTable.damagetype[4] = bit.bor(DMG_ACID)
	TEMP_MeleeTable.distance[4] = 64
	TEMP_MeleeTable.radius[4] = 40
	TEMP_MeleeTable.time[4] = 1.3
	TEMP_MeleeTable.bone[4] = "SK_L_Leg_b3"
	self:STALKERNPCSetMeleeParams(4,"attack_2",4, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	
	self:SetMaxHealth(self:Health())
	
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()
	if (self.jumping1 < CurTime()) and self.isAttacking == 1 and self:GetEnemy() then
		local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
		local dirnormal =((self:GetEnemy():GetPos() + Vector(0,0,128) + self:OBBCenter()) - (self:GetPos())):GetNormal()

		self:SetVelocity((dirnormal*(distance*1.5)))

		self:STALKERNPCPlayAnimation("attack_2",4)
		self:STALKERNPCMakeMeleeAttack(4)
		self:EmitSound("Stalker.Rodent.Melee2")
		self.isAttacking = 2
	end

	if (self.jumping2 < CurTime()) and self.isAttacking == 2 then
		self:STALKERNPCClearAnimation()
		self.NextAbilityTime = CurTime()+0.5
		self.isAttacking = 0
	end

	if (!self.PlayingAnimation) then
		if (self.IsTeleporting == 1) then
			self:STALKERNPCPlayAnimation("desummoned")
			local _, dur = self:LookupSequence("desummoned")
			self.IsTeleporting = 2
			self.TeleportTimer = CurTime()+dur+0.8
			self:EmitSound("Stalker.Spider.Spider")
			self.ShouldEmitSound = false
			self.OldCollisionGroup = self:GetCollisionGroup()
			self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
		end
	end

	if (self.IsTeleporting == 2 and self.TeleportTimer < CurTime()) then
		self:DoTeleport()
		self:STALKERNPCPlayAnimation("summoned")
		self.IsTeleporting = 3
		self.ShouldEmitSound = true
		self:SetCollisionGroup(self.OldCollisionGroup)
		self:EmitSound("Stalker.Spider.Burrow")

		local _, dur = self:LookupSequence("summoned")
		self.TeleportTimer = CurTime()+dur

	end

	if( self.IsTeleporting == 3 and self.TeleportTimer < CurTime()) then
		self:STALKERNPCClearAnimation()
		self.IsTeleporting = 0
	end

	if (self.IsSpitting == 1 and self.spitting < CurTime()) then
		self.IsSpitting = 2
		self.spitting = CurTime() + 0.5

		local TEMP_POORGUY = self:GetEnemy()
		if(TEMP_POORGUY:Visible(self)) then	
			local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
			local TEMP_ShootPoint = TEMP_POORGUY:GetPos()+TEMP_POORGUY:OBBCenter()+Vector(0,0,distance/8)

			local TEMP_ShootPos = self:GetPos()+Vector(0,0,50)+(self:GetForward()*15)
					
			local TEMP_Grav = ents.Create("ent_spider_ball")
			TEMP_Grav:SetPos(TEMP_ShootPos)
			TEMP_Grav:SetAngles((TEMP_ShootPoint-TEMP_ShootPos):Angle())
			TEMP_Grav:Spawn()
							
			TEMP_Grav:SetOwner(self)
							
			TEMP_Grav:GetPhysicsObject():SetVelocity((TEMP_ShootPoint-TEMP_ShootPos):GetNormalized()*1500)
		end
	end

	if( self.IsSpitting == 2 and self.spitting < CurTime()) then
		self.IsSpitting = 0
		self:STALKERNPCClearAnimation()
	end
end

function ENT:STALKERNPCOnDeath()

end

function ENT:STALKERNPCDamageTake(dmginfo,mul)

	if(dmginfo:GetDamageType() == DMG_BULLET) then
		dmginfo:SetDamage(dmginfo:GetDamage()*(1 - (self.percentbulletresistance/100)))
		dmginfo:SubtractDamage(self.flatbulletresistance)
		dmginfo:SetDamage(math.max(0,dmginfo:GetDamage())) --So he can't heal from our attacks
	end

	if( math.random(100) > 70) and self.CanTeleportTimer < CurTime() then
		self.IsTeleporting = 1
		self.CanTeleportTimer = CurTime() + 15
	end

	return mul
end

function ENT:DoTeleport()
	self:SetPos(self:GetTeleportLocation())
end

//little aggressive jump
function ENT:STALKERNPCDistanceForMeleeTooBig() 
	if(self.PlayingAnimation==false) then
		if self:Health() > 0.5*self:GetMaxHealth() then

			local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
			if distance < 1200 and distance > 300 then
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
		else
			local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
			if(self.CanSpit < CurTime() and distance < 800)then
				self.CanSpit = CurTime() + 4
				self.spitting = CurTime() + 0.8
				self.IsSpitting = 1
				self:STALKERNPCPlayAnimation("attack_web")

				
				local TEMP_ShootPoint = self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter()+Vector(0,0,distance/8)

				local TEMP_ShootPos = self:GetPos()+Vector(0,0,50)+(self:GetForward()*15)
				local _, yaw, _ = (TEMP_ShootPoint-TEMP_ShootPos):GetNormalized():Angle():Unpack()
				local pitch, _, roll = self:GetAngles():Unpack()

				self:SetAngles(Angle(pitch,yaw,roll))
			end
		end
	end
end


function ENT:GetTeleportLocation( )
	local tracegood = false
	local teleres
	local tracecnt = 0

	local firstTrace = util.TraceLine( {
			start = self:GetPos() + Vector(0,0,64),
			endpos = self:GetPos() + Vector(0,0,400),
			filter = "npc_mutant_spider",
			mask = MASK_ALL,
			ignoreworld = false
		} )

	repeat
		local trace = util.TraceHull( {
			start = firstTrace.HitPos - Vector(0,0,-64),
			endpos = self:GetPos() + Vector(math.random(-1200,1200),math.random(-1200,1200),-400),
			mins = Vector( -32, -32, 0 ),
			maxs = Vector( 32, 32, 64 ),
			filter = "npc_mutant_spider",
			mask = MASK_ALL,
			ignoreworld = false
		} )

		if (!trace.HitSky && trace.HitPos:Distance(self:GetEnemy():GetPos()) > 600) then
			tracegood = true
			teleres = trace.HitPos
		end

		tracecnt = tracecnt + 1

		if tracecnt > 50 then
			tracegood = true
			teleres = self:GetPos() -- Teleport to original position if we cant find a position
		end

	until tracegood


	return teleres
end