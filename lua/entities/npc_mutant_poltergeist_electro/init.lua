AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.PoachingType = "electropoltergeist"
ENT.PolterSkin = 4
ENT.ElementImmunity = DMG_SHOCK
ENT.DeathParticle = "wick_anomaly_electra_activated"

ENT.PainSoundEnabled = true
ENT.PainSound = {name = "Stalker.Poltergeist.Pain", min = 1, max = 2}

local DISCHARGE_RADIUS = 220
local DISCHARGE_DAMAGE = 18
local CHARGE_PARTICLE = "wick_art_electro_sparks"
local DISCHARGE_PARTICLE = "wick_anomaly_electra_activated"
local DISCHARGE_SOUND = "ambient/energy/zap9.wav"
local SPARK_OFFSET = Vector(32, 0, 32)
local SPARK_SPEED = 420

ENT.Abilities = {
	{
		name = "discharge",
		maxRange = DISCHARGE_RADIUS,
		cooldown = 6,
		initialCooldown = 1,
		recovery = 0.5,
		cancelOnTargetLoss = false,
		phases = {
			{duration = 0.7, method = "PoltergeistCharge"},
			{duration = 0.3, method = "PoltergeistDischarge"},
		},
	},
	{
		name = "volley",
		maxRange = 1500,
		cooldown = 7,
		initialCooldown = 2,
		recovery = 0.5,
		cancelOnTargetLoss = false,
		phases = {
			{duration = 0.8, method = "PoltergeistCharge"},
			{duration = 0.45, method = "PoltergeistSpark"},
			{duration = 0.45, method = "PoltergeistSpark"},
			{duration = 0.3, method = "PoltergeistSpark"},
		},
	},
}

function ENT:PoltergeistCharge()
	ParticleEffect(CHARGE_PARTICLE, self:WorldSpaceCenter(), angle_zero)
	self:EmitSound("Stalker.Poltergeist.Attack2")
end

function ENT:PoltergeistDischarge()
	ParticleEffect(DISCHARGE_PARTICLE, self:WorldSpaceCenter(), angle_zero)
	self:EmitSound(DISCHARGE_SOUND, 85)
	self:STALKERNPCAbilityPulse(DISCHARGE_RADIUS, DISCHARGE_DAMAGE, DMG_SHOCK, true)
end

function ENT:PoltergeistSpark(enemy)
	if not enemy or not self:Visible(enemy) then return end

	self:STALKERNPCAbilityLaunchProjectile("ent_poltergeist_spark", enemy, SPARK_SPEED, SPARK_OFFSET)
end
