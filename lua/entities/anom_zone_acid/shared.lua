ENT.Base = "cotz_anomaly_zone"
ENT.Type = "anim"
ENT.PrintName = "Acid Mist"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Category = "S.T.A.L.K.E.R. Anomalies"

sound.Add({
	name = "cotz_zone_acid_idle",
	channel = CHAN_STATIC,
	volume = 0.2,
	level = 65,
	pitch = 70,
	sound = "anomaly/buzz_idle.wav",
})

if CLIENT then
	ENT.IdleParticle = "cotz_anom_zone_acid"
	ENT.IdleSound = "cotz_zone_acid_idle"
	ENT.ScreenTint = Vector(0, 1, 0)
end
