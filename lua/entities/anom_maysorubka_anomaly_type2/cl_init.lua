include("shared.lua")

sound.Add({
	name = "myasorubka_idle",
	channel = CHAN_STATIC,
	volume = 0.3,
	level = 70,
	pitch = 100,
	sound = "anomaly/myasorubka_idle.wav",
})

ENT.IdleParticle = "tramplin_type2"
ENT.IdleSound = "myasorubka_idle"
ENT.IdleLight = "activation"

ENT.IdleRestartTranslucent = true
ENT.IdleRestartModel = "models/anomaly/anomaly_fix.mdl"

include("cotz/anomalies/cl_idle.lua")
