include("shared.lua")

sound.Add({
	name = "electra_idle",
	channel = CHAN_STATIC,
	volume = 0.3,
	level = 70,
	pitch = 100,
	sound = "anomaly/electra_idle1.wav",
})

ENT.IdleParticle = "electra_static"
ENT.IdleSound = "electra_idle"
ENT.IdleLight = "activation"

include("cotz/anomalies/cl_idle.lua")

function ENT:StartTouch()
	self:StopSound("electra_idle")
end
