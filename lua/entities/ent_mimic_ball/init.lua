AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Speed = 1100
ENT.LifeTime = 4
ENT.HullRadius = 8
ENT.ImpactDamage = 15
ENT.PsyDamage = 20

local IMPACT_SOUND = "npc/mimic/hit_0.ogg"

-- Two separate damage events: the PsyHealth plugin consumes sonic damage and zeroes that DamageInfo.
function ENT:Impact(trace)
	sound.Play(IMPACT_SOUND, trace.HitPos, 75)
	if self:DamageVictim(trace.Entity, self.ImpactDamage, DMG_CLUB) then
		self:DamageVictim(trace.Entity, self.PsyDamage, DMG_SONIC)
	end
end
