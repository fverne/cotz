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

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Zombie.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 3

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Zombie.Hit"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 2

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Zombie.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 2

ENT.ChasingSoundEnabled = true
ENT.ChasingSound.name = "Stalker.Zombie.Chase"
ENT.ChasingSound.min = 1
ENT.ChasingSound.max = 2
ENT.ChasingSound.chance = 20

--ENT.SNPCClass="C_MONSTER_LAB"
ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.hp = 240
ENT.hpvar = 50

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

function ENT:Initialize()
	self.Model = "models/monsters/zombie.mdl"
	self:STALKERNPCInit(Vector(-24,-24,90),MOVETYPE_STEP)
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
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
			self:EmitSound("Stalker.Zombie.Die1")
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

end

function ENT:STALKERNPCOnDeath()

end

function ENT:STALKERNPCDamageTake(dmginfo,mul)
	TEMP_Mul = mul
	--hacky shit code for checking for headshots
	local pos = dmginfo:GetDamagePosition()
	local hitgroup = 0

	headbonepos, headboneang = self:GetBonePosition(self:GetHitBoxBone( 11, 0 ))
	chestbonepos, chestboneang = self:GetBonePosition(self:GetHitBoxBone( 10, 0 ))

	headbonepos = headbonepos + Vector (0,0,4)
	
	local distancetohead = pos - headbonepos
	local distancetochest = pos - chestbonepos
	
	if  math.abs(distancetohead.x) + math.abs(distancetohead.y) + math.abs(distancetohead.z) < math.abs(distancetochest.x) + math.abs(distancetochest.y) + math.abs(distancetochest.z) then
		TEMP_Mul = 2
	else
		TEMP_Mul = 0.8
	end
	--hacky shit code end

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