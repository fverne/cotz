AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

-- Explicit balancing parameters used by the spreadsheet export/import tool.
-- BalanceCooldown is the time between hits on the same victim; BalanceRadius is the loop's radius.
ENT.BalanceDamage = 30
ENT.BalanceCooldown = 1
ENT.BalanceRadius = 260

ENT.Speed = 140
ENT.HitRadius = 80
ENT.CometDamageType = DMG_BURN
ENT.CometHitParticle = "cotz_anom_gravity_shield"
ENT.CometHitSound = "ambient/fire/ignite.wav"
