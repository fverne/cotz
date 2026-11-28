ENT.Base = "cotz_anomaly_base"
ENT.Type = "anim"
ENT.PrintName = "Tesla"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Category = "S.T.A.L.K.E.R. Anomalies"

ENT.TriggerMins = Vector(-20, -20, 0)
ENT.TriggerMaxs = Vector(20, 20, 60)

sound.Add({
	name = "cotz_tesla_idle",
	channel = CHAN_STATIC,
	volume = 0.35,
	level = 75,
	pitch = 70,
	sound = "anomaly/electra_idle1.wav",
})

sound.Add({
	name = "cotz_tesla_charge",
	channel = CHAN_STATIC,
	volume = 0.8,
	level = 95,
	pitch = {150, 160},
	sound = "anomaly/electra_hit1.mp3",
})

sound.Add({
	name = "cotz_tesla_blast",
	channel = CHAN_STATIC,
	volume = 1,
	level = 115,
	pitch = {80, 90},
	sound = "anomaly/electra_blast1.mp3",
})

if CLIENT then
	ENT.IdleParticle = "cotz_anom_tesla_idle"
	ENT.IdleSound = "cotz_tesla_idle"
	ENT.IdleLight = "tesla"
	ENT.IdleLightOffset = Vector(0, 0, 35)
end
