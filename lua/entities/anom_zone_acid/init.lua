AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

-- Explicit balancing parameters used by the spreadsheet export/import tool.
ENT.BalanceDamage = 5
ENT.BalanceCooldown = 1

ENT.ZoneDamageType = DMG_ACID
ENT.ZoneHitSound = "ambient/levels/canals/toxic_slime_sizzle3.wav"
