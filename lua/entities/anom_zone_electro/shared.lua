ENT.Base = "cotz_anomaly_zone"
ENT.Type = "anim"
ENT.PrintName = "Static Ground"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Category = "S.T.A.L.K.E.R. Anomalies"

sound.Add({
	name = "cotz_zone_electro_idle",
	channel = CHAN_STATIC,
	volume = 0.15,
	level = 65,
	pitch = 125,
	sound = "anomaly/electra_idle1.wav",
})

if CLIENT then
	ENT.IdleParticle = "cotz_anom_zone_electro"
	ENT.IdleSound = "cotz_zone_electro_idle"
	ENT.ScreenTint = Vector(0, 0, 1)
end
