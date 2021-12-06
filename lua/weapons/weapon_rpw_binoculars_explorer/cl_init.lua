include( "shared.lua" )

language.Add("weapon_rpw_binoculars_explorer", "Explorer Binoculars")															

SWEP.PrintName 				= "Explorer Binoculars"
SWEP.Slot 					= 0
SWEP.SlotPos 				= 1
SWEP.DrawAmmo 				= false
SWEP.DrawCrosshair 			= false
SWEP.ViewModelFlip 			= false

SWEP.WepSelectIcon 			= surface.GetTextureID("vgui/swepicons/weapon_rpw_binoculars_explorer")
SWEP.DrawWeaponInfoBox		= false
SWEP.BounceWeaponIcon 		= false 

SWEP.ViewModelFOV			= 65

local mat_bino_overlay = Material( "vgui/hud/rpw_binoculars_overlay_uk" )

function SWEP:DrawHUD()
	if (self.Zoom_InZoom) then
	
		local w = ScrW()
		local h = ScrH()
		
		surface.SetMaterial( mat_bino_overlay )
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRect( 0 ,-(w-h)/2 ,w ,w )
		
	end
end

function SWEP:AdjustMouseSensitivity()
	if (self.Zoom_InZoom) then
		local zoom = 90/self.Owner:GetFOV()
		local adjustedsens = 1 / zoom
		return adjustedsens
	end
end
