ENT.Base = "cotz_anomaly_zone"
ENT.Type = "anim"
ENT.PrintName = "Smouldering Ground"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Category = "S.T.A.L.K.E.R. Anomalies"

sound.Add({
	name = "cotz_zone_fire_idle",
	channel = CHAN_STATIC,
	volume = 0.15,
	level = 65,
	pitch = 70,
	sound = "anomaly/par_idle.wav",
})

if CLIENT then
	ENT.IdleParticle = "cotz_anom_zone_fire"
	ENT.IdleSound = "cotz_zone_fire_idle"
	ENT.IdleLight = "smoulder"
	ENT.IdleLightOffset = Vector(0, 0, 20)
	ENT.ScreenTint = Vector(1, 0, 0)
end
