include("shared.lua")

sound.Add({
	name = "buzz_idle",
	channel = CHAN_STATIC,
	volume = 0.25,
	level = 70,
	pitch = 100,
	sound = "anomaly/buzz_idle.wav",
})

ENT.IdleParticle = "kisel"
ENT.IdleSound = "buzz_idle"
ENT.IdleLight = "chemical"

include("cotz/anomalies/cl_idle.lua")
