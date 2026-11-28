include("shared.lua")

sound.Add({
	name = "myasorubka_idle",
	channel = CHAN_STATIC,
	volume = 0.3,
	level = 70,
	pitch = 100,
	sound = "anomaly/myasorubka_idle.wav",
})

ENT.IdleParticle = "cotz_anom_bubble_idle"
ENT.IdleSound = "myasorubka_idle"
ENT.IdleLight = "gravity"
ENT.IdleLightOffset = Vector(0, 0, 40)

ENT.IdleRestartTranslucent = true

include("cotz/anomalies/cl_idle.lua")
