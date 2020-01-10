--[[ Load up our shared code. ]]--

include('shared.lua')

--[[ Include these modules, because they're clientside.]]--

if CLIENT then
	if istable(SWEP.ClSIDE_MODULES) then
		for k,v in pairs(SWEP.ClSIDE_MODULES) do
			include(v)
		end
	end
end

--[[ Include these modules, because they're shared.]]--

if CLIENT then
	for k,v in pairs(SWEP.SH_MODULES) do
		include(v)
	end
end

--[[Actual clientside values]]--

SWEP.PrintName				= ""				// 'Nice' Weapon name (Shown on HUD)	
SWEP.Slot				= 4				// Slot in the weapon selection menu
SWEP.SlotPos				= 1				// Position in the slot
SWEP.DrawAmmo				= true				// Should draw the default HL2 ammo counter				// Should draw the default crosshair
SWEP.DrawWeaponInfoBox			= false				// Should draw the weapon info box
SWEP.BounceWeaponIcon   			= false				// Should the weapon icon bounce?