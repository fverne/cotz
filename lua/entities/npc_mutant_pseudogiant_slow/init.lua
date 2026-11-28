AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.PainSoundEnabled = true
ENT.PainSound.name = "Stalker.PseudogiantSlow.Pain"
ENT.PainSound.min = 1
ENT.PainSound.max = 3

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

ENT.hp = 4000
ENT.hpvar = 100
ENT.injuredact = ACT_DOD_PRONE_ZOOM_BAZOOKA

ENT.NextAbilityTime = 0

ENT.MinRangeDist = 800
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_IDLE_WANDER 
ENT.RangeSchedule = SCHED_CHASE_ENEMY

ENT.FBR = 15
ENT.FBRAP = 5
ENT.BR = 12

local SLAM_RADIUS = 512
local SLAM_DAMAGE = 350
local SLAM_FORCE = 400
local SLAM_PUSH = 500
local SLAM_AIM_HEIGHT = Vector(0, 0, 160)

ENT.Abilities = {
	{
		name = "slam",
		meleeRange = "outside",
		maxRange = 300,
		chance = 0.5,
		cooldown = 9,
		phases = {
			{duration = 0.3},
			{duration = 1.5, melee = 5, sound = "Stalker.Pseudogiant.Idle1", untilGrounded = true, maxDuration = 5},
			{duration = 0, method = "PseudogiantSlam"},
		},
	},
}

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
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 128
	TEMP_MeleeTable.radius[1] = 128
	TEMP_MeleeTable.time[1] = 0.75
	TEMP_MeleeTable.bone[1] = "head"
	self:STALKERNPCSetMeleeParams(1,"stand_attack_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()

	TEMP_MeleeTable.damage[1] = 70
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 128
	TEMP_MeleeTable.radius[1] = 128
	TEMP_MeleeTable.time[1] = 0.75
	TEMP_MeleeTable.bone[1] = "lefttophand"
	self:STALKERNPCSetMeleeParams(2,"stand_attack_1",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	TEMP_MeleeTable.damage[1] = 110
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 128
	TEMP_MeleeTable.radius[1] = 128
	TEMP_MeleeTable.time[1] = 0.5
	TEMP_MeleeTable.bone[1] = "head"
	self:STALKERNPCSetMeleeParams(3,"stand_attack_2",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()


	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 70
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
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
	-- npc wounded animation
	if self:Health() < (self:GetMaxHealth() * 0.33) then
		self:SetMovementActivity(self.injuredact)
	end
end

-- The kick throws everything nearby away from the right hand, which is the original's launch point.
function ENT:PseudogiantSlam()
	self:STALKERNPCAbilityDust()

	local origin = self:GetPos()
	local hand = self:GetBonePosition(self:LookupBone("righthand"))
	for _, target in ipairs(ents.FindInSphere(origin, SLAM_RADIUS)) do
		local falloff = (SLAM_RADIUS - origin:Distance(target:GetPos())) / SLAM_RADIUS
		if target ~= self and falloff > 0 then
			local direction = (target:GetPos() + SLAM_AIM_HEIGHT - hand):GetNormalized()
			local info = DamageInfo()
			info:SetDamage(SLAM_DAMAGE * falloff)
			info:SetInflictor(self)
			info:SetDamageType(DMG_CLUB)
			info:SetAttacker(self)
			info:SetDamagePosition(target:NearestPoint(hand + self:OBBCenter()))
			info:SetDamageForce(direction * SLAM_FORCE)
			target:TakeDamageInfo(info)
			target:SetVelocity(direction * SLAM_PUSH)
		end
	end
end

function ENT:STALKERNPCOnDeath()

end

function ENT:STALKERNPCDamageTake(dmginfo,mul) 
	local TEMP_Mul = mul
	local headMultiplier = 1.5 // head is weakpoint for pseudogiant
	local torsoMultiplier = 1 
	local limbMultiplier = 1

	local torsoHitGroups = {
		[2] = true,
		[3] = true,
	}
	local limbHitgroups = {
		[4] = true,
		[5] = true,
		[6] = true,
		[7] = true,
	}

	if(self.LastDamageHitgroup == 1)then // head
		TEMP_Mul = 0.50 * headMultiplier 
	elseif (torsoHitGroups[self.LastDamageHitgroup]) then // chest + stomach
		TEMP_Mul = 1 * torsoMultiplier 
	elseif (limbHitgroups[self.LastDamageHitgroup]) then // limb
		TEMP_Mul = 4 * limbMultiplier
	end

	return TEMP_Mul
end