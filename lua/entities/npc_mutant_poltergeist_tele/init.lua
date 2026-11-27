AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("sv_telekinesis.lua")

ENT.PoachingType = "telepoltergeist"
ENT.PolterSkin = 0
ENT.DeathParticle = "wick_anomaly_trampmlin_blast"

ENT.PainSoundEnabled = true
ENT.PainSound = {name = "Stalker.Poltergeist.TelePain", min = 1, max = 2}
ENT.DieSound = {name = "Stalker.Poltergeist.TeleDie", min = 1, max = 2}

local SHOVE_RADIUS = 220
local SHOVE_DAMAGE = 8
local SHOVE_SPEED = 550
local SHOVE_LIFT = 220
local SHOVE_PARTICLE = "wick_anomaly_trampmlin_blast"
local SHOVE_SOUND = "npc/poltergeist/tele_get_0.ogg"

ENT.Abilities = {
	{
		name = "shove",
		maxRange = SHOVE_RADIUS,
		cooldown = 7,
		initialCooldown = 1,
		recovery = 0.5,
		cancelOnTargetLoss = false,
		phases = {
			{duration = 0.6, sound = "Stalker.Poltergeist.Attack3"},
			{duration = 0.3, method = "PoltergeistShove"},
		},
	},
	{
		name = "hurl",
		maxRange = 1500,
		cooldown = 7,
		initialCooldown = 2,
		recovery = 0.5,
		cancelOnTargetLoss = false,
		onFinish = "PoltergeistReleaseHeld",
		phases = {
			{duration = 0.3, sound = "Stalker.Poltergeist.Attack1"},
			{duration = 1.3, method = "PoltergeistGather"},
			{duration = 0.55, method = "PoltergeistHurl"},
			{duration = 0.55, method = "PoltergeistHurl"},
			{duration = 0.8, method = "PoltergeistHurl"},
		},
	},
}

function ENT:PoltergeistShove()
	local origin = self:WorldSpaceCenter()
	ParticleEffect(SHOVE_PARTICLE, origin, angle_zero)
	self:EmitSound(SHOVE_SOUND, 85)
	for _, client in ipairs(ents.FindInSphere(origin, SHOVE_RADIUS)) do
		if client:IsPlayer() and client:Alive() and self:STALKERNPCCanAttackThis(client) and self:Visible(client) then
			local away = (client:WorldSpaceCenter() - origin):GetNormalized()
			client:SetVelocity(away * SHOVE_SPEED + Vector(0, 0, SHOVE_LIFT))
		end
	end
	self:STALKERNPCAbilityPulse(SHOVE_RADIUS, SHOVE_DAMAGE, DMG_CLUB, true)
end
