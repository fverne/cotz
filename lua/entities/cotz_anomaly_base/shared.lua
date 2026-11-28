-- Shared base for the COTZ field anomalies added with cotz_anomalies.pcf. It is never spawned itself and its
-- class deliberately lacks the anom_ prefix that the detector, controller and balance tooling look for.
ENT.Base = "base_anim"
ENT.Type = "anim"
ENT.PrintName = "Anomaly Base"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Category = "S.T.A.L.K.E.R. Anomalies"
ENT.Author = "COTZ"
ENT.AutomaticFrameAdvance = true

-- Touch trigger bounds around the origin.
ENT.TriggerMins = Vector(-60, -60, -5)
ENT.TriggerMaxs = Vector(60, 60, 80)
