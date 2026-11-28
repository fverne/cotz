ENT.Base = "cotz_anomaly_base"
ENT.Type = "anim"
ENT.PrintName = "Psy Pocket"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Category = "S.T.A.L.K.E.R. Anomalies"

ENT.TriggerMins = Vector(-20, -20, 0)
ENT.TriggerMaxs = Vector(20, 20, 60)

-- Explicit balancing parameter used by the spreadsheet export/import tool; clients use it for the distortion.
ENT.BalanceRadius = 150

sound.Add({
	name = "cotz_psy_idle",
	channel = CHAN_STATIC,
	volume = 0.35,
	level = 75,
	pitch = 60,
	sound = "anomaly/teleport_idle.wav",
})

sound.Add({
	name = "cotz_psy_voices",
	channel = CHAN_STATIC,
	volume = 0.8,
	level = 80,
	pitch = {85, 100},
	sound = "gsc/s.t.a.l.k.e.r/effects/psy_voices.wav",
})

if CLIENT then
	ENT.IdleParticle = "cotz_anom_psy_idle"
	ENT.IdleLayers = {"cotz_anom_psy_glow"}
	ENT.IdleSound = "cotz_psy_idle"
	ENT.IdleLight = "psy"
	ENT.IdleLightOffset = Vector(0, 0, 40)
end
