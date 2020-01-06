AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end

function ENT:processProjectile(ent)
	if !IsValid(ent) then
		return
	end

	self._initPos = ent:GetPos()
	self._initAng = ent:GetAngles()
	self._initClass = ent:GetClass()

	self._followEnt =
		self.db[self._initClass] and
		self.db[self._initClass].followProjectile and
		ent
end

function ENT:Initialize()
	if not self._initClass then
		return
	end

	self:SetModel("models/weapons/flare.mdl")

	self:DrawShadow(false)
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)

	self:SetPos(self._initPos)
	self:SetAngles(self._initAng)

	local tweak = self._dbStr2int[self._initClass] or 0
	self:SetProjectileClass(tweak)

	self.followedProjectile = self._followEnt

	SafeRemoveEntityDelayed(self, self.db[self._initClass].effectDuration or 30)
end

function ENT:Use(activator, caller)
	return false
end

local offset = Vector(0,0,10)
local angle = Angle()

function ENT:Think()
	if IsValid(self.followedProjectile) then
		self:SetPos(self.followedProjectile:GetPos() + offset)
		self:SetAngles(angle)
	end
end
