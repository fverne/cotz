AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Think()
	if (self._timeToLive + 30) < CurTime() then
		SafeRemoveEntity(self)
	end
end

function ENT:Use(activator, caller)
	return false
end

function ENT:OnRemove()
	return false
end

local vel, len

function ENT:PhysicsCollide(data, physobj)
	if data.Speed > 250 then
		local ent = data.HitEntity

		if IsValid(ent) and (ent:IsPlayer() or ent:IsNPC()) then
			ent:Ignite(self.AfterBurn, self.BurnRadius)
		end
	end

	self:EmitSound("physics/metal/metal_grenade_impact_hard" .. math.random(1, 3) .. ".wav", 80, 100)

	vel = physobj:GetVelocity()
	len = vel:Length()

	if len > 500 then
		physobj:SetVelocity(vel * 0.6)
	end

end
