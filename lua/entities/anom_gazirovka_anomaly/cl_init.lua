include("shared.lua")

sound.Add({
	name = "buzz_idle",
	channel = CHAN_STATIC,
	volume = 0.25,
	level = 70,
	pitch = 100,
	sound = "anomaly/buzz_idle.wav",
})

ENT.IdleParticle = "gazirovka"
ENT.IdleSound = "buzz_idle"

ENT.IdleRestartTranslucent = true
ENT.IdleRestartModel = "models/anomaly/anomaly_fix.mdl"

include("cotz/anomalies/cl_idle.lua")
