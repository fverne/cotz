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

	local impactAngle = math.deg(math.acos(data.OurOldVelocity:GetNormalized():Dot(data.HitNormal:GetNormalized()))) // so much math

	if data.Speed > 100 and impactAngle < 70 then
		timer.Simple(0, function()
			if IsValid(self) then
				self:selfDestruct()
			end
		end)
	end
end

function ENT:selfDestruct()
	self.HadEnough = true

	if self.DontDestroy then return end

	util.BlastDamage(self, self.Owner, self:GetPos(), self.BlastRadius, self.BlastDamage)

	local fx = ents.Create("cw_kk_ins2_particles")
	fx:processProjectile(self)
	fx:Spawn()

	SafeRemoveEntity(self)
end

function ENT:OnTakeDamage(dmg)
	if self.HadEnough then return end

	self:selfDestruct()
end
