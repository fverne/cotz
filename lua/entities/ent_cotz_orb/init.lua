AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Speed = 1000
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
