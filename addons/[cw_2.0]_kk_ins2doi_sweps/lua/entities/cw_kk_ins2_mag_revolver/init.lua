if not CustomizableWeaponry then return end
if not CustomizableWeaponry.magSystem then return end

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

CustomizableWeaponry.magSystem:bindEntityToMagType("cw_kk_ins2_mag_revolver", "revLoader")
