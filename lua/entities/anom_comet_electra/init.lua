AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

-- Explicit balancing parameters used by the spreadsheet export/import tool.
-- BalanceCooldown is the time between hits on the same victim; BalanceRadius is the loop's radius.
ENT.BalanceDamage = 40
ENT.BalanceCooldown = 1.5
ENT.BalanceRadius = 220

-- Faster and less predictable than the Comet: fewer, sharper turns.
ENT.Speed = 190
ENT.HitRadius = 60
ENT.Waypoints = 5
ENT.CometDamageType = DMG_SHOCK
ENT.CometHitParticle = "cotz_anom_electra_hit"
ENT.CometHitSound = "anomaly/electra_hit1.mp3"
