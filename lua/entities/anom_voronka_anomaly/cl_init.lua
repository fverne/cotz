include("shared.lua")

sound.Add({
	name = "voronka_idle",
	channel = CHAN_STATIC,
	volume = 0.4,
	level = 70,
	pitch = 100,
	sound = "anomaly/voronka_idle.wav",
})

ENT.IdleParticle = "voronka"
ENT.IdleSound = "voronka_idle"
ENT.IdleLight = "activation"
ENT.IdleModel = "models/anomaly/anomaly_fix.mdl"

ENT.IdleRestartTranslucent = true
ENT.IdleRestartModel = "models/anomaly/anomaly_fix.mdl"

include("cotz/anomalies/cl_idle.lua")
