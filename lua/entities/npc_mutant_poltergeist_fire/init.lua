AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.PoachingType = "firepoltergeist"
ENT.PolterSkin = 1
ENT.ElementImmunity = DMG_BURN
ENT.DeathParticle = "wick_art_fire_smoke"

ENT.PainSoundEnabled = true
ENT.PainSound = {name = "Stalker.Poltergeist.Pain", min = 1, max = 2}

local LEAD_SECONDS = 0.35
local GROUND_PROBE_UP = Vector(0, 0, 24)
local GROUND_PROBE_DOWN = Vector(0, 0, 256)

ENT.Abilities = {
	{
		name = "flames",
		maxRange = 1500,
		cooldown = 8,
		initialCooldown = 2,
		recovery = 0.5,
		cancelOnTargetLoss = false,
		phases = {
			{duration = 0.6, sound = "Stalker.Poltergeist.Attack1"},
			{duration = 1, method = "PoltergeistFlame"},
			{duration = 1, method = "PoltergeistFlame"},
			{duration = 0.4, method = "PoltergeistFlame"},
		},
	},
}

-- Marks the ground where the enemy is heading; the flame entity gives its own warning before burning.
function ENT:PoltergeistFlame(enemy)
	if not enemy or not self:Visible(enemy) then return end

	local aim = enemy:GetPos() + enemy:GetVelocity() * LEAD_SECONDS
	local trace = util.TraceLine({
		start = aim + GROUND_PROBE_UP, endpos = aim - GROUND_PROBE_DOWN, mask = MASK_SOLID,
		filter = {self, enemy},
	})
	if not trace.Hit or trace.StartSolid or trace.HitSky then return end

	local flame = ents.Create("ent_poltergeist_flame")
	if not IsValid(flame) then return end
	flame:SetPos(trace.HitPos)
	flame:SetOwner(self)
	flame:Spawn()
end
