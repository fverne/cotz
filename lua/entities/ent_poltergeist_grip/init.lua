AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.HitDamage = 20
ENT.HitKnockback = 220
ENT.HitHullRadius = 18

local CARRIER_MODEL = "models/hunter/misc/sphere025x025.mdl"
local LIFT_PARTICLE = "wick_art_gravity_dist"
local HIT_SOUND = "physics/concrete/boulder_impact_hard2.wav"
local MAX_HOLD_SECONDS = 8
local FLIGHT_SECONDS = 1.5
local STALL_GRACE = 0.2
local STALL_SPEED_SQR = 200 ^ 2
local HOVER_PULL = 4
local HOVER_WOBBLE = 10
local HOVER_SPIN = 40
local THROW_SPIN = 400
local REBOUND_SCALE = 0.2
local SETTLE_SECONDS = 0.75
local SETTLE_RETRY = 0.25
local CONJURED_LINGER = 4

function ENT:Initialize()
	self:SetModel(CARRIER_MODEL)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:SetNoDraw(true)
end

-- Conjured objects belong to this grip and are removed after release; borrowed props stay in the world.
function ENT:Grab(object, conjured, hoverHeight)
	local physics = object:GetPhysicsObject()
	if not IsValid(physics) then return false end

	self.cotzObject = object
	self.cotzConjured = conjured
	self.cotzOriginalGravity = physics:IsGravityEnabled()
	self.cotzOriginalGroup = object:GetCollisionGroup()
	self.cotzHoverPosition = object:GetPos() + Vector(0, 0, hoverHeight)
	self.cotzPhase = math.Rand(0, math.pi * 2)
	self.cotzHeldSince = CurTime()
	object.cotzPoltergeistHeld = true
	-- This group ignores player collision, so engine crush damage cannot replace the grip's own hit.
	object:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	physics:EnableGravity(false)
	physics:Wake()
	ParticleEffect(LIFT_PARTICLE, object:WorldSpaceCenter(), angle_zero)

	return true
end

function ENT:IsHolding()
	return IsValid(self.cotzObject) and not self.cotzThrownAt and not self.cotzDroppedAt
end

function ENT:Hurl(target, speed)
	if not self:IsHolding() then return false end
	local physics = self.cotzObject:GetPhysicsObject()
	if not IsValid(physics) then return false end

	local origin = self.cotzObject:WorldSpaceCenter()
	local radius = self.HitHullRadius
	self.cotzThrownAt = CurTime()
	self.cotzLastCenter = origin
	self.cotzTrace = {
		mins = Vector(-radius, -radius, -radius), maxs = Vector(radius, radius, radius),
		mask = MASK_SHOT_HULL, filter = {self, self.cotzObject, self:GetOwner()},
	}
	physics:Wake()
	local aim = self:GetOwner():STALKERNPCPredictAim(target, origin, speed)
	physics:SetVelocity((aim - origin):GetNormalized() * speed)
	physics:AddAngleVelocity(VectorRand() * THROW_SPIN)

	return true
end

function ENT:Drop()
	if self.cotzDroppedAt then return end

	self.cotzDroppedAt = CurTime()
	local physics = IsValid(self.cotzObject) and self.cotzObject:GetPhysicsObject()
	if IsValid(physics) then
		physics:EnableGravity(self.cotzOriginalGravity)
		physics:Wake()
	end
end

function ENT:CheckHit()
	local object = self.cotzObject
	local center = object:WorldSpaceCenter()
	self.cotzTrace.start, self.cotzTrace.endpos = self.cotzLastCenter, center
	self.cotzLastCenter = center

	local trace = util.TraceHull(self.cotzTrace)
	local victim = trace.Entity
	if not IsValid(victim) or not (victim:IsPlayer() or victim:IsNPC()) or victim:Health() <= 0 then return false end
	local owner = self:GetOwner()
	if not owner:STALKERNPCCanAttackThis(victim) then return false end

	local physics = object:GetPhysicsObject()
	local direction = IsValid(physics) and physics:GetVelocity():GetNormalized() or vector_up
	local info = DamageInfo()
	info:SetDamage(self.HitDamage)
	info:SetDamageType(DMG_CLUB)
	info:SetAttacker(owner)
	info:SetInflictor(self)
	info:SetDamagePosition(trace.HitPos)
	info:SetDamageForce(direction * self.HitKnockback)
	victim:TakeDamageInfo(info)
	if victim:IsPlayer() then victim:SetVelocity(direction * self.HitKnockback) end
	sound.Play(HIT_SOUND, trace.HitPos, 75)
	if IsValid(physics) then physics:SetVelocity(physics:GetVelocity() * REBOUND_SCALE) end

	return true
end

-- Restoring player collision while a player overlaps the object would trap them inside it.
function ENT:ObjectOverlapsPlayer()
	local mins, maxs = self.cotzObject:WorldSpaceAABB()
	for _, entity in ipairs(ents.FindInBox(mins, maxs)) do
		if entity:IsPlayer() and entity:Alive() then return true end
	end

	return false
end

function ENT:Restore()
	local object = self.cotzObject
	if self.cotzRestored or not IsValid(object) then return end

	self.cotzRestored = true
	local physics = object:GetPhysicsObject()
	if IsValid(physics) then physics:EnableGravity(self.cotzOriginalGravity) end
	object:SetCollisionGroup(self.cotzOriginalGroup)
	object.cotzPoltergeistHeld = nil
end

function ENT:Think()
	local object = self.cotzObject
	local physics = IsValid(object) and object:GetPhysicsObject()
	if not IsValid(physics) then
		self:Remove()
		return
	end

	local now = CurTime()
	local owner = self:GetOwner()
	local abandoned = not IsValid(owner) or owner.IsAlive == false or owner.cotzSleeping
	if self.cotzDroppedAt then
		if now >= self.cotzDroppedAt + SETTLE_SECONDS then
			if self.cotzConjured then
				SafeRemoveEntityDelayed(object, CONJURED_LINGER)
				self.cotzRestored = true
				self:Remove()
				return
			end
			if not self:ObjectOverlapsPlayer() then
				self:Restore()
				self:Remove()
				return
			end
			self:NextThink(now + SETTLE_RETRY)

			return true
		end
	elseif abandoned then
		self:Drop()
	elseif self.cotzThrownAt then
		local flown = now - self.cotzThrownAt
		if self:CheckHit() or flown >= FLIGHT_SECONDS
			or (flown >= STALL_GRACE and physics:GetVelocity():LengthSqr() < STALL_SPEED_SQR) then
			self:Drop()
		end
	elseif now - self.cotzHeldSince >= MAX_HOLD_SECONDS then
		self:Drop()
	else
		local wobble = Vector(0, 0, math.sin(now * 5 + self.cotzPhase) * HOVER_WOBBLE)
		physics:Wake()
		physics:SetVelocity((self.cotzHoverPosition + wobble - object:GetPos()) * HOVER_PULL)
		physics:AddAngleVelocity(VectorRand() * HOVER_SPIN)
	end
	self:NextThink(now)

	return true
end

-- Removal can arrive before the settle delay, for example from a map cleanup.
function ENT:OnRemove()
	if self.cotzRestored or not IsValid(self.cotzObject) then return end

	if self.cotzConjured then
		self.cotzObject:Remove()
	else
		self:Restore()
	end
end
