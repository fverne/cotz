AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Think()
	-- self:SetAngles(self:GetVelocity():Angle():Forward())
end

function ENT:Use(activator, caller)
	return false
end

function ENT:OnRemove()
	return false
end

local vel, len

function ENT:PhysicsCollide(data, physobj)
	if math.abs(data.OurOldVelocity:Length() - self:GetVelocity():Length()) > 5 then
		self:EmitSound("physics/metal/metal_grenade_impact_hard" .. math.random(1, 3) .. ".wav", 80, 100)
	end

	self:selfDestruct()
end

function ENT:selfDestruct()
	if self.HadEnough then
		return
	end

	self.HadEnough = true

	if self.DontDestroy then return end

	util.BlastDamage(self, self.Owner, self:GetPos(), self.BlastRadius, self.BlastDamage)

	local fx = ents.Create("cw_kk_ins2_particles")
	fx:processProjectile(self)
	fx:Spawn()

	SafeRemoveEntity(self)
end

function ENT:OnTakeDamage(dmg)
	self:selfDestruct()
end
