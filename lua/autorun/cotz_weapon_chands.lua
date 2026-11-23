if SERVER then
	AddCSLuaFile()
	AddCSLuaFile("cotz_weapon_chands/sh_definitions.lua")
	AddCSLuaFile("cotz_weapon_chands/sh_models.lua")
	AddCSLuaFile("cotz_weapon_chands/cl_hands.lua")
end

include("cotz_weapon_chands/sh_models.lua")

if CLIENT then
	include("cotz_weapon_chands/cl_hands.lua")
end
