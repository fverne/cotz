AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

-- Explicit balancing parameters used by the spreadsheet export/import tool.
ENT.BalanceDamage = 6
ENT.BalanceCooldown = 1.2

ENT.ZoneDamageType = DMG_SHOCK
ENT.ZoneHitParticle = "cotz_anom_electra_hit"
ENT.ZoneHitSound = "anomaly/electra_hit1.mp3"
