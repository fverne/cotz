AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Izlom.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 5

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Izlom.Melee"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 4

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Izlom.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 5

ENT.ChasingSoundEnabled = true
ENT.ChasingSound.name = "Stalker.Izlom.Chase"
ENT.ChasingSound.min = 1
ENT.ChasingSound.max = 13
ENT.ChasingSound.chance = 15

--ENT.SNPCClass="C_MONSTER_LAB"
ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.hp = 600
ENT.hpvar = 100

ENT.FleeTime = 0
ENT.MustFlee = false
ENT.CanPull = 0
ENT.isAttacking = 0
ENT.pulling1 = 0
ENT.pulling2 = 0

ENT.CanGrab = 0
ENT.grabbing1 = 0
ENT.grabbing2 = 0
ENT.grabbing3 = 0
ENT.IsGrabbing = 0

ENT.CanSpecial = true

ENT.MinRangeDist = 800
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_IDLE_WANDER 
ENT.RangeSchedule = SCHED_CHASE_ENEMY

ENT.TEMP_PunchDamage1 = 0
ENT.TEMP_PunchDamage2 = 0

function ENT:Initialize()
	self.Model = "models/monsters/izlom.mdl"
	self:STALKERNPCInit(Vector(-24,-24,70),MOVETYPE_STEP)
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Izlom.Miss1" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 55
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 100
	TEMP_MeleeTable.radius[1] = 128
	TEMP_MeleeTable.time[1] = 1.0
	TEMP_MeleeTable.bone[1] = "bip01_l_hand"
	self:STALKERNPCSetMeleeParams(1,"stand_attack_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 25
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 100
	TEMP_MeleeTable.radius[1] = 128
	TEMP_MeleeTable.time[1] = 0.3
	TEMP_MeleeTable.bone[1] = "bip01_l_hand"
	self:STALKERNPCSetMeleeParams(3,"stand_run_attack_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 40
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 100
	TEMP_MeleeTable.radius[1] = 128
	TEMP_MeleeTable.time[1] = 1.1
	TEMP_MeleeTable.bone[1] = "bip01_r_hand"
	TEMP_MeleeTable.damage[2] = 20
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[2] = 100
	TEMP_MeleeTable.radius[2] = 128
	TEMP_MeleeTable.time[2] = 2.1
	TEMP_MeleeTable.bone[2] = "bip01_r_hand"
	self:STALKERNPCSetMeleeParams(4,"stand_attack_1",2, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	
	self:SetMaxHealth(self:Health())
	
	self:SetRenderMode(RENDERMODE_TRANSALPHA)

	self.TEMP_PunchDamage2 = DamageInfo()
							
	self.TEMP_PunchDamage2:SetDamage(20)
	self.TEMP_PunchDamage2:SetInflictor(self)
	self.TEMP_PunchDamage2:SetDamageType(DMG_BULLET)
	self.TEMP_PunchDamage2:SetAttacker(self)
	self.TEMP_PunchDamage2:SetDamageForce(Vector(0,0,0))

end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()
	-- PULLING
	if (self.pulling1 < CurTime()) and self.isAttacking == 1 and self:GetEnemy() then
		local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
		local dirnormal =((self:GetPos() + self:OBBCenter()) - (self:GetEnemy():GetPos())):GetNormal()
		dirnormal[3] = 0.25

		self:GetEnemy():SetVelocity((dirnormal*(distance*1.5)))

		if(self:GetEnemy().ConsumeStamina) then
			self:GetEnemy():ConsumeStamina(35)
		end

		self:STALKERNPCPlayAnimation("stand_run_attack_0",3)
		self:STALKERNPCMakeMeleeAttack(3)
		self:EmitSound("Stalker.Izlom.Melee1")
		self.isAttacking = 2
	end
	if (self.pulling2 < CurTime()) and self.isAttacking == 2 then
		self:STALKERNPCStopAllTimers()
		self:STALKERNPCClearAnimation()
		self.NextAbilityTime = CurTime()+0.5
		self.isAttacking = 0
	end
	-- PULLING END

	-- GRAB
	if self.grabbing1 < CurTime() && self.IsGrabbing == 1 then
		if(IsValid(self)&&self!=nil&&self!=NULL) then
			self:STALKERNPCStopAllTimers()
			self:STALKERNPCClearAnimation()

			self:STALKERNPCPlayAnimation("stand_attack_1",4)
			self:STALKERNPCMakeMeleeAttack(4)

			self:EmitSound("Stalker.Izlom.Chase10")
			self.IsGrabbing = 2
		end
	end

	if self.grabbing2 < CurTime() && self.IsGrabbing == 2 then
		if(IsValid(self)&&self!=nil&&self!=NULL) and self.GrabTarget then

			if(!IsValid(self.GrabTarget)) then
				self.IsGrabbing = 0
				self.GrabTarget = nil
			end
			self:STALKERNPCStopAllTimers()
			self:STALKERNPCClearAnimation()

			self.GrabTarget:Freeze(false)			
			self.GrabTarget:SetLocalVelocity(((self.GrabTarget:GetPos() - self:GetPos()):GetNormal() + self:GetUp()*5)*120)
			self.GrabTarget = nil
			self.IsGrabbing = 0
		end
	end
	-- GRAB END
end

//little aggressive jump
function ENT:STALKERNPCDistanceForMeleeTooBig() 
	if(self.PlayingAnimation==false) then
		local distance = (self:GetPos():Distance(self:GetEnemy():GetPos())) or 0
		if distance > 256 and distance < 512 then
			if(self.CanPull<CurTime()) then
				local TEMP_Rand = math.random(1,5)
				
				if(TEMP_Rand==1) then		
					self.CanPull = CurTime()+7
					self.isAttacking = 1
					self.pulling1 = CurTime()+0.2
					self.pulling2 = CurTime()+0.9
				end
			end
		end

		if distance < 125 then
			if(self.CanGrab < CurTime()) then
				local TEMP_Rand = math.random(1,5)
				
				if(TEMP_Rand==1) then		
					self.CanGrab = CurTime()+15

					local target = self:GetEnemy()
					self.GrabTarget = target
					target:Freeze(true)

					self.grabbing1 = CurTime() + 0.1
					self.grabbing2 = CurTime() + 2.1
					self.IsGrabbing = 1
				end
			end
		end
	end
end

function ENT:STALKERNPCOnKilled()
	if self.GrabTarget then
		self.GrabTarget:Freeze(false)
	end
end

function ENT:STALKERNPCRemove() 
	if self.GrabTarget then
		self.GrabTarget:Freeze(false)
	end
end