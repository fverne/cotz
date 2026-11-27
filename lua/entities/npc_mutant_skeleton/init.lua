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

ENT.hp = 120
ENT.hpvar = 10

ENT.FBR = 5
ENT.FBRAP = 80
ENT.BR = 0

ENT.CanFakeDeath = true
ENT.FakeDeathPending = false
ENT.FakeDeathResTimer = 0
ENT.FakeDeathAnimSet = 0

ENT.NextAbilityTime = 0

ENT.MinRangeDist = 800
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_IDLE_WANDER 
ENT.RangeSchedule = SCHED_CHASE_ENEMY

local ANIMATION_END_MARGIN = 0.1
local GRAB_DAMAGE = 7
local GRAB_REACH = 25

ENT.Abilities = {
	{
		name = "fakeDeath",
		triggerOnly = true,
		cancelOnTargetLoss = false,
		onFinish = "SkeletonEndFakeDeath",
		phases = {
			{duration = 0, method = "SkeletonCollapse"},
			{duration = 0, method = "SkeletonLieStill"},
			{duration = 0, method = "SkeletonStandUp"},
		},
	},
	{
		name = "grab",
		meleeRange = "outside",
		maxRange = 100,
		chance = 0.5,
		cooldown = 15,
		recovery = 10,
		cancelOnTargetLoss = false,
		validate = "SkeletonHasVictim",
		onFinish = "SkeletonReleaseVictim",
		phases = {
			{duration = 1.2, melee = 6, method = "SkeletonSeize"},
			{duration = 1.3, method = "SkeletonDrain"},
			{duration = 0, method = "SkeletonFinishGrab", untilAnimationDone = true, maxDuration = 3},
		},
	},
}

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
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 30
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 0.7
	TEMP_MeleeTable.bone[1] = "bip01_r_hand"
	self:STALKERNPCSetMeleeParams(1,"stand_attack_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 25
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 30
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 0.7
	TEMP_MeleeTable.bone[1] = "bip01_l_hand"
	self:STALKERNPCSetMeleeParams(2,"stand_attack_1",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 25
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 30
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 0.7
	TEMP_MeleeTable.bone[1] = "bip01_l_hand"
	self:STALKERNPCSetMeleeParams(3,"stand_attack_2",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	
	TEMP_MeleeTable.damage[1] = 25
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 30
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 0.7
	TEMP_MeleeTable.bone[1] = "bip01_l_hand"
	self:STALKERNPCSetMeleeParams(4,"stand_attack_3",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	TEMP_MeleeTable.damage[1] = 25
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 30
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 1.2
	TEMP_MeleeTable.bone[1] = "bip01_l_hand"
	TEMP_MeleeTable.damage[2] = 25
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_SLASH)
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
	-- A queued fake death waits for the current attack to finish.
	if self.FakeDeathPending and self:STALKERNPCTriggerAbility("fakeDeath") then
		self.FakeDeathPending = false
	end
end

function ENT:SkeletonFakeDeathSequence(stage)
	local sequence = "fake_death_" .. self.FakeDeathAnimSet .. "_" .. stage
	local _, duration = self:LookupSequence(sequence)

	return sequence, duration - ANIMATION_END_MARGIN
end

function ENT:SkeletonCollapse(_, state)
	self:STALKERNPCAbilityPlaySequence(state, self:SkeletonFakeDeathSequence(0))
	self.ShouldEmitSound = false
	state.collisionGroup = self:GetCollisionGroup()
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
end

function ENT:SkeletonLieStill(_, state)
	local sequence = self:SkeletonFakeDeathSequence(1)
	self:STALKERNPCAbilityPlaySequence(state, sequence, self.FakeDeathResTimer - state.phaseStart)
end

function ENT:SkeletonStandUp(_, state)
	self:STALKERNPCAbilityPlaySequence(state, self:SkeletonFakeDeathSequence(2))
end

function ENT:SkeletonEndFakeDeath(state)
	self.ShouldEmitSound = true
	self:SetCollisionGroup(state.collisionGroup)
end

function ENT:SkeletonSeize(enemy, state)
	self:SetPos(self:GetPos() + self:GetForward() * GRAB_REACH)
	state.victim = enemy
	if enemy and enemy:IsPlayer() then enemy:Freeze(true) end
end

-- A victim that disappears mid-grab ends it; after the release, the grab animation may finish.
function ENT:SkeletonHasVictim(state)
	return state.released or IsValid(state.victim)
end

function ENT:SkeletonDrain(_, state)
	local victim = state.victim
	if not IsValid(victim) then return end

	local damage = DamageInfo()
	damage:SetDamage(GRAB_DAMAGE)
	damage:SetAttacker(self)
	damage:SetDamageType(DMG_SONIC)
	damage:SetInflictor(self)
	damage:SetDamagePosition(victim:NearestPoint(self:GetPos()))
	victim:TakeDamageInfo(damage)
end

function ENT:SkeletonFinishGrab(_, state)
	self:SkeletonDrain(nil, state)
	self:SkeletonReleaseVictim(state)
end

function ENT:SkeletonReleaseVictim(state)
	local victim = state.victim
	state.victim, state.released = nil, true
	if IsValid(victim) and victim:IsPlayer() then victim:Freeze(false) end
end

function ENT:STALKERNPCOnDeath()

end

function ENT:STALKERNPCDamageTake(dmginfo,mul)

	--fakedeath
	if ( ((self:Health() - dmginfo:GetDamage()) < 30) and self.CanFakeDeath ) then
		dmginfo:SetDamage(0)
		self.CanFakeDeath = false
		self.FakeDeathPending = true
		self.FakeDeathResTimer = CurTime() + 15
		self.FakeDeathAnimSet = math.random(0,3)
		self:SetHealth(self:GetMaxHealth())
	end

	return mul
end
