AddCSLuaFile("shared.lua")
include("shared.lua")
include("STALKERNPCBaseVars.lua")

ENT.PainSoundEnabled = true
ENT.PainSound.name = "Stalker.Bloodsucker.Pain"
ENT.PainSound.min = 1
ENT.PainSound.max = 3

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Bloodsucker.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 4

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Bloodsucker.Hit"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 5

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Bloodsucker.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 3

ENT.ChasingSoundEnabled = true
ENT.ChasingSound.name = "Stalker.Bloodsucker.Chase"
ENT.ChasingSound.min = 1
ENT.ChasingSound.max = 3
ENT.ChasingSound.chance = 20
ENT.ChasingSound.noCooldown = true
ENT.ChasingSound.interval = 3

ENT.SNPCClass = "C_MONSTER_PLAYERFOCUS"

ENT.hp = 200
ENT.hpvar = 20
ENT.injuredact = ACT_RUN_AIM_PISTOL

ENT.FBR = 5
ENT.FBRAP = 5
ENT.BR = 20

ENT.NextAbilityTime = 0

ENT.MinRangeDist = 0
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_RUN_RANDOM
ENT.RangeSchedule = SCHED_CHASE_ENEMY

ENT.navigationLeapRange = 100
ENT.navigationLeapAimHeight = 96
ENT.navigationLeapSpeed = 2

local SWAMP_MODEL = "models/monsters/krovosos2.mdl"
local SWAMP_SKINS = {2, 5}
local CLAW_MELEE_COUNT = 2
local LUNGE_MELEE = 3
local INJURED_FRACTION = 0.33
local CLOAK_RANGE_SQR = 225 ^ 2
local CLOAK_ALPHA = 55
local CLOAK_CHECK_INTERVAL = 0.35

ENT.Abilities = {
	{
		name = "jump",
		navigationLeap = "long",
		meleeRange = "outside",
		maxRange = ENT.navigationLeapRange,
		chance = 0.5,
		cooldown = 9,
		recovery = 1,
		phases = {
			{duration = 0.2},
			{
				duration = 0.8, leap = "long", melee = LUNGE_MELEE, sound = "Stalker.Bloodsucker.Hit1",
				untilGrounded = true, maxDuration = 5,
			},
		},
	},
}

function ENT:Initialize()
	self.Model = SWAMP_MODEL
	self:STALKERNPCInit(Vector(-28, -28, 70), MOVETYPE_STEP)
	-- The base picks a random skin; this variant only wears the two marsh ones.
	self:SetSkin(SWAMP_SKINS[math.random(#SWAMP_SKINS)])
	self:SetBloodColor(BLOOD_COLOR_RED)
	self:DropToFloor()

	local hitSounds = {"Stalker.Snork.Hit1"}
	local missSounds = {"Stalker.Snork.Miss1"}

	for index, claw in ipairs({
		{sequence = "stand_attack_0", bone = "bip01_l_hand"},
		{sequence = "stand_attack_1", bone = "bip01_r_hand"},
	}) do
		local melee = self:STALKERNPCCreateMeleeTable()
		melee.damage[1] = 30
		melee.damagetype[1] = DMG_SLASH
		melee.distance[1] = 81
		melee.radius[1] = 80
		melee.time[1] = 1
		melee.bone[1] = claw.bone
		self:STALKERNPCSetMeleeParams(index, claw.sequence, 1, melee, hitSounds, missSounds)
	end

	local lunge = self:STALKERNPCCreateMeleeTable()
	for hit, swing in ipairs({{time = 0.5, bone = "bip01_l_hand"}, {time = 0.8, bone = "bip01_r_hand"}}) do
		lunge.damage[hit] = 30
		lunge.damagetype[hit] = DMG_SLASH
		lunge.distance[hit] = 81
		lunge.radius[hit] = 120
		lunge.time[hit] = swing.time
		lunge.bone[hit] = swing.bone
	end
	self:STALKERNPCSetMeleeParams(LUNGE_MELEE, "stand_attack_run_0", 2, lunge, hitSounds, missSounds)

	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	self:SetMaxHealth(self:Health())
	self.NextAbilityTime = CurTime() + 1
	self:SetRenderMode(RENDERMODE_TRANSCOLOR)
	self:DrawShadow(false)
	self:SetCloakAlpha(255)
end

-- Server-side alpha, networked through the entity color, so every client sees the same cloak.
function ENT:SetCloakAlpha(alpha)
	if self.cloakAlpha == alpha then return end
	self.cloakAlpha = alpha
	self:SetColor(Color(255, 255, 255, alpha))
end

-- Cloaked until the enemy comes close or the bloodsucker is mid-ability, which reveals it.
function ENT:UpdateCloak()
	local now = CurTime()
	if now < (self.cloakNextCheck or 0) then return end
	self.cloakNextCheck = now + CLOAK_CHECK_INTERVAL

	local target = self:GetEnemy()
	local near = IsValid(target) and self:GetPos():DistToSqr(target:GetPos()) <= CLOAK_RANGE_SQR
	self:SetCloakAlpha((near or self.PlayingAnimation) and 255 or CLOAK_ALPHA)
end

-- The lunge swing belongs to the leap, so ordinary melee only picks the two claws.
function ENT:STALKERNPCSelectMeleeAttack()
	return math.random(CLAW_MELEE_COUNT)
end

function ENT:STALKERNPCThink()
	if self:Health() < self:GetMaxHealth() * INJURED_FRACTION then
		self:SetMovementActivity(self.injuredact)
	end

	self:UpdateCloak()
end
