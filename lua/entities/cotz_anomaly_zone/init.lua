AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

local fx = include("cotz/anomalies/sv_fx.lua")

function ENT:Touch(entity)
	if not fx.IsCreature(entity) or not self:CanHurt(entity, self.BalanceCooldown) then return end

	fx.Damage(self, entity, self.BalanceDamage, self.ZoneDamageType)
	if self.ZoneHitParticle then
		fx.Hit(entity, self.ZoneHitParticle)
	end
	if self.ZoneHitSound then
		entity:EmitSound(self.ZoneHitSound, 65, math.random(90, 110), 0.6)
	end
end
