AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

-- Slow and straight: it is aimed ahead of its target, who can dodge by changing direction.
ENT.Speed = 420
ENT.LifeTime = 5
ENT.HullRadius = 10
ENT.DischargeDamage = 14
ENT.DischargeRadius = 80

local DISCHARGE_PARTICLE = "wick_anomaly_electra_activated"
local DISCHARGE_SOUND = "ambient/energy/zap1.wav"

function ENT:Discharge()
	local position = self:GetPos()
	ParticleEffect(DISCHARGE_PARTICLE, position, angle_zero)
	sound.Play(DISCHARGE_SOUND, position, 80)

	for _, victim in ipairs(ents.FindInSphere(position, self.DischargeRadius)) do
		if victim ~= self:GetOwner() and (victim:IsPlayer() or victim:IsNPC())
			and not util.TraceLine({
				start = position, endpos = victim:WorldSpaceCenter(), mask = MASK_SOLID_BRUSHONLY,
			}).Hit then
			self:DamageVictim(victim, self.DischargeDamage, DMG_SHOCK)
		end
	end
end

function ENT:Impact()
	self:Discharge()
end

function ENT:Expire()
	self:Discharge()
end
