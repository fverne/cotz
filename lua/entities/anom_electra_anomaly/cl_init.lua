include("shared.lua")

sound.Add({
	name = "electra_idle",
	channel = CHAN_STATIC,
	volume = 0.3,
	level = 70,
	pitch = 100,
	sound = "anomaly/electra_idle1.wav",
})

ENT.IdleParticle = "cotz_anom_electra_idle"
ENT.IdleSound = "electra_idle"
ENT.IdleLight = "electric"
ENT.IdleLightOffset = Vector(0, 0, 30)

include("cotz/anomalies/cl_idle.lua")

function ENT:StartTouch()
	self:StopSound("electra_idle")
end
