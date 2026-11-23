AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Spawnable = false

function ENT:Initialize()
	if CLIENT then return end
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self:SetUseType(SIMPLE_USE)
	local physics = self:GetPhysicsObject()

	if IsValid(physics) then physics:Wake() end
end

function ENT:Use(activator)
	if not SERVER or self.AnomalyUsed or not activator:IsPlayer() then return end
	local received = activator:GiveAmmo(self.AmmoCount, self.AmmoType, false)
	if received < 1 then return end
	self.AmmoCount = self.AmmoCount - received

	if self.AmmoCount <= 0 then
		self.AnomalyUsed = true
		self:Remove()
	end
end

function ENT:Draw()
	self:DrawModel()
end
