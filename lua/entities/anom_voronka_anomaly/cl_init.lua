include("shared.lua")

sound.Add({
	name = "voronka_idle",
	channel = CHAN_STATIC,
	volume = 0.4,
	level = 70,
	pitch = 100,
	sound = "anomaly/voronka_idle.wav",
})

ENT.IdleParticle = "cotz_anom_vortex_idle"
ENT.IdleSound = "voronka_idle"
ENT.IdleLight = "gravity"
ENT.IdleLightOffset = Vector(0, 0, 50)
ENT.IdleModel = "models/anomaly/anomaly_fix.mdl"

ENT.IdleRestartTranslucent = true
ENT.IdleRestartModel = "models/anomaly/anomaly_fix.mdl"

include("cotz/anomalies/cl_idle.lua")
