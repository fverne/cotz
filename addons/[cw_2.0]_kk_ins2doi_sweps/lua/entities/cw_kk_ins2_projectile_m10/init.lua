AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.BurnDuration = 20

ENT.ExplodeRadius = 300
ENT.ExplodeDamage = 50

function ENT:Use(activator, caller)
	return false
end

function ENT:OnRemove()
	return false
end

local vel, len

function ENT:PhysicsCollide(data, physobj)
	timer.Simple(0, function()
		if IsValid(self) then
			self:PhysicsDestroy()
			self:selfDestruct()
		end
	end)
end

function ENT:selfDestruct()
	if self.ded then
		return
	end

	self.ded = true

	if self:WaterLevel() == 0 then
		local smokeScreen = ents.Create("cw_smokescreen_impact")
		smokeScreen:SetPos(self:GetPos())
		smokeScreen:Spawn()

		local fx = ents.Create("cw_kk_ins2_particles")
		fx:processProjectile(self)
		fx:Spawn()

		if self:WaterLevel() == 0 then
			fx:Ignite(self.BurnDuration, self.ExplodeRadius)

			-- local bn = ents.Create("cw_kk_ins2_burn")
			-- bn:processProjectile(self)
			-- bn:Spawn()
		end

		self:SetNoDraw(true)
	end

	SafeRemoveEntityDelayed(self, 30)
end
