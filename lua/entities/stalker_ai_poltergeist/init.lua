AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("STALKERNPCBaseVars.lua")

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Poltergeist.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 4

ENT.SNPCClass = "C_MONSTER_PLAYERFOCUS"
ENT.IdleSequence = "stand_idle_0"

ENT.MovementMode = "fly"
ENT.FlightSpeed = 220
ENT.FlightMoveSequence = "stand_walk_fwd_0"
ENT.FlightWanderRadius = 320
ENT.FlightWanderHeight = {32, 112}

ENT.hp = 350
ENT.hpvar = 25

ENT.FBR = 2
ENT.FBRAP = 5
ENT.BR = 20

ENT.NextAbilityTime = 0

ENT.Model = "models/monsters/poltergeist.mdl"
ENT.PolterSkin = 0
ENT.OrbitRadiusMin, ENT.OrbitRadiusMax = 300, 560
ENT.OrbitHeightMin, ENT.OrbitHeightMax = 80, 170
ENT.OrbitSecondsMin, ENT.OrbitSecondsMax = 2.5, 4.5

local ORBIT_ATTEMPTS = 6
local ORBIT_ARRIVAL = 32
local FALLBACK_HEIGHT = 96
local FALLBACK_RADIUS = 200
local EVADE_INTERVAL = 1.5
local REVEAL_SECONDS = 0.25
local LAUGH_MIN, LAUGH_MAX = 5, 11
local LAUGH_COUNT = 6
local SIGHT_RANGE = 1500
local SIGHT_HALF_ANGLE = 180

function ENT:Initialize()
	self:STALKERNPCInit(Vector(-22, -22, 56), MOVETYPE_STEP)
	self:SetSkin(self.PolterSkin)
	-- Blood would mark the invisible body.
	self:SetBloodColor(DONT_BLEED)
	self:DrawShadow(false)
	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	self:SetMaxHealth(self:Health())
	self.cotzNextLaugh = CurTime() + math.Rand(LAUGH_MIN, LAUGH_MAX)
end

-- Poltergeists never strike by hand.
function ENT:STALKERNPCMeleePlay()
end

-- They sense in every direction, not only where the body faces.
function ENT:STALKERNPCTryToFindEnemy()
	if ix and ix.eventController then
		local _, count = ix.eventController:FindCombatEnemy(self, SIGHT_RANGE, SIGHT_HALF_ANGLE, true)

		return count or 0
	end

	-- self.BaseClass on a concrete poltergeist is this class, so name the mutant base explicitly.
	return baseclass.Get("stalker_ai").STALKERNPCTryToFindEnemy(self)
end

function ENT:PoltergeistPickOrbit(enemy)
	local center = enemy:GetPos()
	local sight = enemy:WorldSpaceCenter()
	for _ = 1, ORBIT_ATTEMPTS do
		local angle = math.Rand(0, math.pi * 2)
		local radius = math.Rand(self.OrbitRadiusMin, self.OrbitRadiusMax)
		local offset = Vector(math.cos(angle) * radius, math.sin(angle) * radius,
			math.Rand(self.OrbitHeightMin, self.OrbitHeightMax))
		local trace = util.TraceLine({
			start = center + offset, endpos = sight, mask = MASK_SHOT, filter = {self, enemy},
		})
		if not trace.Hit and not trace.StartSolid then return offset end
	end

	-- Cramped rooms: stay on the current side of the enemy, just above head height.
	local away = self:GetPos() - center
	away.z = 0
	away:Normalize()

	return away * FALLBACK_RADIUS + Vector(0, 0, FALLBACK_HEIGHT)
end

function ENT:STALKERNPCFlightCombatGoal(enemy, now)
	if not self.cotzOrbit or enemy ~= self.cotzOrbitEnemy or now >= self.cotzNextOrbit then
		self.cotzOrbit = self:PoltergeistPickOrbit(enemy)
		self.cotzOrbitEnemy = enemy
		self.cotzNextOrbit = now + math.Rand(self.OrbitSecondsMin, self.OrbitSecondsMax)
	end

	return enemy:GetPos() + self.cotzOrbit, ORBIT_ARRIVAL
end

function ENT:STALKERNPCThink()
	local now = CurTime()
	if now < self.cotzNextLaugh then return end

	self.cotzNextLaugh = now + math.Rand(LAUGH_MIN, LAUGH_MAX)
	self:EmitSound("Stalker.Poltergeist.Idle" .. math.random(LAUGH_COUNT))
end

function ENT:STALKERNPCDamageTake(dmginfo, mul)
	-- Each element shrugs off its own kind of damage.
	if self.ElementImmunity and dmginfo:IsDamageType(self.ElementImmunity) then return 0 end

	local now = CurTime()
	self:SetNWFloat("cotzPolterReveal", now + REVEAL_SECONDS)
	if now >= (self.cotzNextEvade or 0) then
		self.cotzNextEvade = now + EVADE_INTERVAL
		self.cotzNextOrbit = 0
	end

	return mul
end

function ENT:STALKERNPCOnDeath()
	if self.DeathParticle then ParticleEffect(self.DeathParticle, self:WorldSpaceCenter(), angle_zero) end
end
