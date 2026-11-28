ENT.Base = "cotz_anomaly_comet"
ENT.Type = "anim"
ENT.PrintName = "Comet"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Category = "S.T.A.L.K.E.R. Anomalies"

sound.Add({
	name = "cotz_comet_idle",
	channel = CHAN_STATIC,
	volume = 0.6,
	level = 80,
	pitch = 100,
	sound = "anomaly/kometa.wav",
})

if CLIENT then
	ENT.IdleParticle = "cotz_anom_comet_fire"
	ENT.IdleSound = "cotz_comet_idle"
	ENT.IdleLight = "cometFire"
end
