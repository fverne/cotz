AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:processProjectile(ent)
	if !IsValid(ent) then
		return
	end

	self._initPos = ent:GetPos()
	self._initAng = ent:GetAngles()
	self._initDuration = ent.BurnDuration
	self._initRange = ent.ExplodeRadius
end

function ENT:Initialize()
	self._initPos = self._initPos or Vector()
	self._initAng = self._initAng or Angle()
	self._initDuration = self._initDuration or 30
	self._initRange = self._initRange or 300

	self:SetModel("models/weapons/flare.mdl")

	self:DrawShadow(false)
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)

	self:SetPos(self._initPos)
	self:SetAngles(self._initAng)

	self:Ignite(self._initDuration, self._initRange)

	SafeRemoveEntityDelayed(self, self._initDuration or 30)
end

function ENT:Use(activator, caller)
	return false
end

function ENT:Think()
	self:StopParticles()
end
