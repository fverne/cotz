ENT.Base = "cotz_anomaly_comet"
ENT.Type = "anim"
ENT.PrintName = "Ball Lightning"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Category = "S.T.A.L.K.E.R. Anomalies"

sound.Add({
	name = "cotz_ball_lightning_idle",
	channel = CHAN_STATIC,
	volume = 0.5,
	level = 80,
	pitch = 140,
	sound = "anomaly/electra_idle1.wav",
})

if CLIENT then
	ENT.IdleParticle = "cotz_anom_comet_electra"
	ENT.IdleLayers = {"cotz_anom_electra_idle_2"}
	ENT.IdleSound = "cotz_ball_lightning_idle"
	ENT.IdleLight = "cometElectric"
end
