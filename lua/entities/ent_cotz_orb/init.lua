AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Speed = 1000
ENT.TurnRate = 0 -- Degrees per second towards HomingTarget.
ENT.LifeTime = 4
ENT.HullRadius = 6

local CARRIER_MODEL = "models/hunter/misc/sphere025x025.mdl"

function ENT:Initialize()
	-- Entities without a model are not networked; the client draws a sprite instead of this one.
	self:SetModel(CARRIER_MODEL)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:DrawShadow(false)
	self.cotzExpires = CurTime() + self.LifeTime
end

function ENT:Impact()
end

function ENT:Expire()
end

-- Damages one living player or NPC as the mutant that fired the orb.
function ENT:DamageVictim(victim, amount, damageType)
	if not IsValid(victim) or not (victim:IsPlayer() or victim:IsNPC()) or victim:Health() <= 0 then return false end
	local owner = self:GetOwner()
	local attacker = IsValid(owner) and owner or self
	if attacker.STALKERNPCCanAttackThis and not attacker:STALKERNPCCanAttackThis(victim) then return false end

	local info = DamageInfo()
	info:SetDamage(amount)
	info:SetDamageType(damageType)
	info:SetAttacker(attacker)
	info:SetInflictor(self)
	info:SetDamagePosition(victim:WorldSpaceCenter())
	info:SetDamageForce(self.cotzVelocity:GetNormalized() * amount)
	victim:TakeDamageInfo(info)

	return true
end

function ENT:Steer(elapsed)
	local target = self.HomingTarget
	if self.TurnRate <= 0 or not IsValid(target) or target:Health() <= 0 then return end

	local current = self.cotzVelocity:GetNormalized()
	local wanted = (target:WorldSpaceCenter() - self:GetPos()):GetNormalized()
	local angle = math.deg(math.acos(math.Clamp(current:Dot(wanted), -1, 1)))
	if angle <= 0 then return end

	local blend = math.min(1, self.TurnRate * elapsed / angle)
	self.cotzVelocity = LerpVector(blend, current, wanted):GetNormalized() * self.Speed
end

function ENT:Think()
	if self.cotzFinished then return end

	local now = CurTime()
	if not self.cotzVelocity then
		local radius = self.HullRadius
		self.cotzVelocity = self:GetForward() * self.Speed
		self.cotzLastMove = now
		self.cotzTrace = {
			mins = Vector(-radius, -radius, -radius), maxs = Vector(radius, radius, radius),
			mask = MASK_SHOT_HULL, filter = {self, self:GetOwner()},
		}
		self:NextThink(now)

		return true
	end

	local elapsed = now - self.cotzLastMove
	self.cotzLastMove = now
	self:Steer(elapsed)

	local position = self:GetPos()
	self.cotzTrace.start = position
	self.cotzTrace.endpos = position + self.cotzVelocity * elapsed
	local trace = util.TraceHull(self.cotzTrace)
	if trace.Hit or now >= self.cotzExpires then
		self.cotzFinished = true
		if trace.Hit then
			self:SetPos(trace.HitPos)
			self:Impact(trace)
		else
			self:Expire()
		end
		self:Remove()

		return
	end

	self:SetPos(self.cotzTrace.endpos)
	self:NextThink(now)

	return true
end
