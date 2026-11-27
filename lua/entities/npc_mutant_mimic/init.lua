AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("STALKERNPCBaseVars.lua")
include("sv_perches.lua")

ENT.PainSoundEnabled = true
ENT.PainSound.name = "Stalker.Mimic.Pain"
ENT.PainSound.min = 1
ENT.PainSound.max = 3

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Mimic.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 4

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Mimic.Melee"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 3

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Mimic.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 4

ENT.ChasingSoundEnabled = true
ENT.ChasingSound.name = "Stalker.Mimic.Chase"
ENT.ChasingSound.min = 1
ENT.ChasingSound.max = 3
ENT.ChasingSound.chance = 20

ENT.SNPCClass = "C_MONSTER_PLAYERFOCUS"
ENT.IdleSequence = "idle"

ENT.hp = 450
ENT.hpvar = 25

ENT.FBR = 3
ENT.FBRAP = 8
ENT.BR = 15

ENT.NextAbilityTime = 0

local MIMIC_MODEL = "models/monsters/mimikria.mdl"
local AMBUSH_SECONDS = 1.4
local HUNT_SECONDS = 30
local HUNT_INTERVAL = 2
local GROUND_SECONDS_MIN, GROUND_SECONDS_MAX = 6, 9
local FIRST_FLIGHT_MIN, FIRST_FLIGHT_MAX = 3, 5
local PERCH_RETRY = 2
local ORB_SPEED = 1100
local ORB_OFFSET = Vector(36, 0, 56)
local VANISH_PARTICLE = "wick_pfx_bloodsucker_invisible_out"
local APPEAR_PARTICLE = "wick_pfx_bloodsucker_invisible_in"
local TELEPORT_EFFECT_HEIGHT = Vector(0, 0, 40)

ENT.Abilities = {
	{
		name = "ambush",
		triggerOnly = true,
		cancelOnTargetLoss = false,
		phases = {
			{duration = AMBUSH_SECONDS, animation = "idle", attackIndex = 0},
		},
	},
	{
		name = "aerial",
		canUse = "MimicCanFly",
		maxRange = 1800,
		recovery = 0.4,
		cancelOnTargetLoss = false,
		uninterruptible = true,
		onFinish = "MimicLand",
		phases = {
			{duration = 0.35, animation = "fly", method = "MimicVanish"},
			{duration = 0.9, animation = "attack", method = "MimicTakePerch"},
			{duration = 0.5, method = "MimicShoot"},
			{duration = 0.9, animation = "attack", method = "MimicTakePerch"},
			{duration = 0.5, method = "MimicShoot"},
		},
	},
}

function ENT:Initialize()
	self.Model = MIMIC_MODEL
	self:STALKERNPCInit(Vector(-20, -20, 78), MOVETYPE_STEP)
	self:SetBloodColor(BLOOD_COLOR_RED)
	self:DropToFloor()

	local melee = self:STALKERNPCCreateMeleeTable()
	melee.damage[1] = 22
	melee.damagetype[1] = DMG_SLASH
	melee.distance[1] = 45
	melee.radius[1] = 80
	melee.time[1] = 0.65
	melee.bone[1] = "bip01_r_hand"
	self:STALKERNPCSetMeleeParams(1, "attack2", 1, melee, {"Stalker.Claw.Hit"}, {"Stalker.Claw.Miss"})

	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	self:SetMaxHealth(self:Health())
	self.cotzNextFlight = CurTime() + math.Rand(FIRST_FLIGHT_MIN, FIRST_FLIGHT_MAX)
end

function ENT:STALKERNPCSelectMeleeAttack()
	return 1
end

-- Entry point for container ambushes: announce the arrival, then go after the player who opened it.
function ENT:MimicAmbush(quarry)
	self.cotzQuarry = quarry
	self.cotzQuarryCharacter = quarry:GetCharacter()
	self.cotzHuntUntil = CurTime() + HUNT_SECONDS
	self.cotzNextFlight = CurTime() + AMBUSH_SECONDS + math.Rand(FIRST_FLIGHT_MIN, FIRST_FLIGHT_MAX)
	self:STALKERNPCWake()
	self:EmitSound("Stalker.Mimic.Ambush")
	self:STALKERNPCTriggerAbility("ambush")
end

function ENT:MimicEngageQuarry()
	local quarry = self.cotzQuarry
	if not IsValid(quarry) or not quarry:Alive() or quarry:GetCharacter() ~= self.cotzQuarryCharacter
		or CurTime() >= self.cotzHuntUntil then
		self.cotzQuarry, self.cotzQuarryCharacter = nil, nil
		return
	end

	-- For the length of the hunt the mimic tracks its quarry even around corners.
	if ix and ix.eventController then
		ix.eventController:SetCombatTarget(self, quarry, quarry:GetPos(), CurTime())
	else
		self:AddEntityRelationship(quarry, D_HT, 99)
		self:SetEnemy(quarry)
		self:UpdateEnemyMemory(quarry, quarry:GetPos())
	end
end

-- The base calls this after abilities update, so the hunt starts on the tick the arrival ends.
function ENT:STALKERNPCThink()
	if not self.cotzQuarry or self.cotzAbility or IsValid(self:GetEnemy()) then return end

	local now = CurTime()
	if now < (self.cotzNextHunt or 0) then return end
	self.cotzNextHunt = now + HUNT_INTERVAL
	self:MimicEngageQuarry()
end

-- Falling back would waste a ranged attacker; hold position and let the aerial attack reach the target.
function ENT:STALKERNPCWithdrawUnreachable()
	self:STALKERNPCHoldNavigationPosition()

	return true
end

function ENT:MimicCanFly(enemy)
	local now = CurTime()
	if now < (self.cotzNextFlight or 0) then return false end

	self.cotzPlannedPerch = self:MimicFindPerch(enemy)
	if not self.cotzPlannedPerch then self.cotzNextFlight = now + PERCH_RETRY end

	return self.cotzPlannedPerch ~= nil
end

function ENT:MimicFace(position)
	self:SetAngles(Angle(0, (position - self:GetPos()):Angle().y, 0))
end

function ENT:MimicTeleport(position)
	ParticleEffect(VANISH_PARTICLE, self:GetPos() + TELEPORT_EFFECT_HEIGHT, angle_zero)
	self:SetPos(position)
	self:SetLocalVelocity(vector_origin)
	ParticleEffect(APPEAR_PARTICLE, position + TELEPORT_EFFECT_HEIGHT, angle_zero)
	self:EmitSound("Stalker.Mimic.Vanish" .. math.random(3))
end

function ENT:MimicSetAirborne(airborne)
	if (self.cotzAirborne == true) == airborne then return end

	self.cotzAirborne = airborne
	if airborne then
		self:CapabilitiesRemove(CAP_MOVE_GROUND)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetGroundEntity(NULL)
	else
		self:CapabilitiesAdd(CAP_MOVE_GROUND)
		self:SetMoveType(MOVETYPE_STEP)
	end
end

function ENT:MimicVanish(_, state)
	state.takeoff = self:GetPos()
	self.cotzUnreachableRecovery, self.cotzNavigationRetreat = nil, nil
	self.cotzNavigationIntent, self.cotzNavigationMotion = nil, nil
	self:StopMoving()
end

function ENT:MimicTakePerch(enemy)
	-- The first perch was checked just before takeoff; later ones must differ from the current position.
	local position = self.cotzPlannedPerch
	self.cotzPlannedPerch = nil
	if not position and enemy then position = self:MimicFindPerch(enemy, self:GetPos()) end
	if not enemy or not position then
		self:STALKERNPCFinishAbility(false)
		return
	end

	self:MimicSetAirborne(true)
	self:MimicTeleport(position)
	self:MimicFace(enemy:GetPos())
end

function ENT:MimicShoot(enemy)
	if not enemy or not self:Visible(enemy) then return end

	self:MimicFace(enemy:GetPos())
	self:EmitSound("Stalker.Mimic.Melee" .. math.random(3))
	self:STALKERNPCAbilityLaunchProjectile("ent_mimic_ball", enemy, ORB_SPEED, ORB_OFFSET)
end

-- Runs however the attack ends, including sleep. A mimic killed in the air simply falls as a corpse.
function ENT:MimicLand(state)
	self.cotzPlannedPerch = nil
	self.cotzNextFlight = CurTime() + math.Rand(GROUND_SECONDS_MIN, GROUND_SECONDS_MAX)
	if not self.cotzAirborne or self.IsAlive == false or self:IsMarkedForDeletion() then return end

	local enemy = self:GetEnemy()
	local landing = not self.cotzSleeping and IsValid(enemy) and self:MimicFindLanding(enemy)
	self:MimicSetAirborne(false)
	self:MimicTeleport(landing or state.takeoff)
	self:DropToFloor()
	self:EmitSound("Stalker.Mimic.Land" .. math.random(2))
	if IsValid(enemy) then self:MimicFace(enemy:GetPos()) end
	self.cotzCombatScheduleDirty = true
	self.NextRun = 0
end
