AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.HitBoxToHitGroup = {
	[0] = HITGROUP_HEAD,
	[16] = HITGROUP_CHEST,
	[15] = HITGROUP_STOMACH,
	[5] = HITGROUP_RIGHTARM,
	[2] = HITGROUP_LEFTARM,
	[12] = HITGROUP_RIGHTLEG,
	[8] = HITGROUP_LEFTLEG
}

ENT.DieSoundEnabled = false
ENT.MeleeSoundEnabled = false
ENT.IdlingSoundEnabled = false
ENT.ChasingSoundEnabled = false

--ENT.SNPCClass="C_MONSTER_LAB"
ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.hp = 800
ENT.hpvar = 150

ENT.CanFakeDeath = true
ENT.FakeDeath = 0
ENT.FakeDeathTimer = 0
ENT.FakeDeathTimer2 = 0
ENT.FakeDeathResTimer = 0
ENT.FakeDeathAnimSet = 0

ENT.NextAbilityTime = 0

ENT.MinRangeDist = 800
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_IDLE_WANDER 
ENT.RangeSchedule = SCHED_CHASE_ENEMY

ENT.GrabTarget = nil
ENT.CanGrab = 0
ENT.IsGrabbing = 0
ENT.grabbing1 = 0
ENT.grabbing2 = 0

function ENT:Initialize()
	self.Model = "models/monsters/skelet.mdl"
	self:STALKERNPCInit(Vector(-24,-24,70),MOVETYPE_STEP)
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_MECH)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Zombie.Miss1" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 25
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 30
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 0.7
	TEMP_MeleeTable.bone[1] = "bip01_r_hand"
	self:STALKERNPCSetMeleeParams(1,"stand_attack_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 25
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 30
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 0.7
	TEMP_MeleeTable.bone[1] = "bip01_l_hand"
	self:STALKERNPCSetMeleeParams(2,"stand_attack_1",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 25
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 30
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 0.7
	TEMP_MeleeTable.bone[1] = "bip01_l_hand"
	self:STALKERNPCSetMeleeParams(3,"stand_attack_2",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	
	TEMP_MeleeTable.damage[1] = 25
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 30
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 0.7
	TEMP_MeleeTable.bone[1] = "bip01_l_hand"
	self:STALKERNPCSetMeleeParams(4,"stand_attack_3",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	TEMP_MeleeTable.damage[1] = 25
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 30
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 1.2
	TEMP_MeleeTable.bone[1] = "bip01_l_hand"
	TEMP_MeleeTable.damage[2] = 25
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[2] = 30
	TEMP_MeleeTable.radius[2] = 80
	TEMP_MeleeTable.time[2] = 1.9
	TEMP_MeleeTable.bone[2] = "bip01_l_hand"
	self:STALKERNPCSetMeleeParams(6,"stand_attack_sasi",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	
	self:SetMaxHealth(self:Health())

	self.CanFakeDeath = math.random(0,100) > 50 --50/50 if the zombie can fakedeath

	self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()
	if (!self.PlayingAnimation) then
		if (self.FakeDeath == 1) then
			self:STALKERNPCPlayAnimation("fake_death_"..self.FakeDeathAnimSet.."_0")
			local _, dur = self:LookupSequence("fake_death_"..self.FakeDeathAnimSet.."_0")
			self.FakeDeath = 2
			self.FakeDeathTimer = CurTime()+dur-0.1
			self.ShouldEmitSound = false
			self.OldCollisionGroup = self:GetCollisionGroup()
			self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
		end
	end

	if (self.FakeDeath == 2 and self.FakeDeathTimer < CurTime()) then
		self:STALKERNPCPlayAnimation("fake_death_"..self.FakeDeathAnimSet.."_1")
		if (self.FakeDeathResTimer < CurTime()) then
			self.FakeDeath = 3
		end
	end

	if (self.FakeDeath == 3) then
		self:STALKERNPCPlayAnimation("fake_death_"..self.FakeDeathAnimSet.."_2")
		local _, dur = self:LookupSequence("fake_death_"..self.FakeDeathAnimSet.."_2")
		self.FakeDeath = 4
		self.FakeDeathTimer2 = CurTime() + dur-0.1
	end

	if (self.FakeDeath == 4 and self.FakeDeathTimer2 < CurTime()) then
		self:STALKERNPCClearAnimation()
		self.FakeDeath = 0
		self.ShouldEmitSound = true
		self:SetCollisionGroup(self.OldCollisionGroup)
	end

	-- GRAB
	if self.grabbing1 < CurTime() && self.IsGrabbing == 1 then
		if(IsValid(self)&&self!=nil&&self!=NULL) then
			local dmg = DamageInfo()
			dmg:SetDamage(7)
			dmg:SetAttacker(self)
			dmg:SetDamageType(DMG_SONIC)
			dmg:SetInflictor(self)
			dmg:SetDamagePosition(self.GrabTarget:NearestPoint(self:GetPos()))

			self.GrabTarget:TakeDamageInfo(dmg)

			self.IsGrabbing = 2
		end
	end

	if self.grabbing2 < CurTime() && self.IsGrabbing == 2 then
		if(IsValid(self)&&self!=nil&&self!=NULL) then
			self.NextAbilityTime = CurTime()+10

			local dmg = DamageInfo()
			dmg:SetDamage(7)
			dmg:SetAttacker(self)
			dmg:SetDamageType(DMG_SONIC)
			dmg:SetInflictor(self)
			dmg:SetDamagePosition(self.GrabTarget:NearestPoint(self:GetPos()))

			self.GrabTarget:TakeDamageInfo(dmg)

			self.GrabTarget:Freeze(false)
			self.GrabTarget = nil
			self.IsGrabbing = 0

		end
	end
end

function ENT:STALKERNPCOnDeath()

end

function ENT:STALKERNPCDamageTake(dmginfo,mul)
	TEMP_Mul = mul
	TEMP_Mul = 0.8

	--fakedeath
	if ( ((self:Health() - dmginfo:GetDamage()) < 30) and self.CanFakeDeath ) then
		dmginfo:SetDamage(0)
		self.CanFakeDeath = false
		self.FakeDeath = 1
		self.FakeDeathResTimer = CurTime() + 15
		self.FakeDeathAnimSet = math.random(0,3)
		self:SetHealth(self:GetMaxHealth())
	end

	return TEMP_Mul
end

function ENT:STALKERNPCDistanceForMeleeTooBig() 
	if self.NextAbilityTime < CurTime() then
		if(self.PlayingAnimation==false) then
			distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
			if distance < 100 then
				if(self.CanGrab<CurTime()) then
					local TEMP_Rand = math.random(1,5)
				
					if(TEMP_Rand==1) then		
						self.CanGrab = CurTime()+15

						self:SetPos(self:GetPos() + (self:GetForward()*25))

						local target = self:GetEnemy()
						target:Freeze(true)

						self.GrabTarget = target

						self.NextAbilityTime = CurTime()+4

						self:STALKERNPCPlayAnimation("stand_attack_sasi",6)
						self:STALKERNPCMakeMeleeAttack(6)

						self.grabbing1 = CurTime() + 1.2
						self.grabbing2 = CurTime() + 2.5

						self.IsGrabbing = 1
	
					end
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