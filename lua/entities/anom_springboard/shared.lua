ENT.Base = "cotz_anomaly_base"
ENT.Type = "anim"
ENT.PrintName = "Springboard"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Category = "S.T.A.L.K.E.R. Anomalies"

ENT.TriggerMins = Vector(-80, -80, -5)
ENT.TriggerMaxs = Vector(80, 80, 50)

sound.Add({
	name = "cotz_springboard_idle",
	channel = CHAN_STATIC,
	volume = 0.25,
	level = 70,
	pitch = 120,
	sound = "anomaly/myasorubka_idle.wav",
})

if CLIENT then
	ENT.IdleParticle = "cotz_anom_springboard_idle"
	ENT.IdleSound = "cotz_springboard_idle"
	ENT.IdleLight = "gravity"
	ENT.IdleLightOffset = Vector(0, 0, 30)
end
