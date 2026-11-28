AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

-- Explicit balancing parameters used by the spreadsheet export/import tool.
ENT.BalanceDamage = 6
ENT.BalanceCooldown = 1

ENT.ZoneDamageType = DMG_BURN
ENT.ZoneHitSound = "ambient/fire/ignite.wav"
