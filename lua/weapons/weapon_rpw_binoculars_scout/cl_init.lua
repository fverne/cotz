include( "shared.lua" )

language.Add("weapon_rpw_binoculars_scout", "Scouting Binoculars")

surface.CreateFont( "rangefinderscout", {														
	font = "Arial",
	extended = false,
	size = 32,
	weight = 600,
	blursize = 2,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )																					

SWEP.PrintName 				= "Scout Binoculars"
SWEP.Slot 					= 0
SWEP.SlotPos 				= 1
SWEP.DrawAmmo 				= false
SWEP.DrawCrosshair 			= false
SWEP.ViewModelFlip 			= false

SWEP.WepSelectIcon 			= surface.GetTextureID("vgui/swepicons/weapon_rpw_binoculars_scout")
SWEP.DrawWeaponInfoBox		= false
SWEP.BounceWeaponIcon 		= false 

SWEP.ViewModelFOV			= 65

local mat_bino_overlay = Material( "vgui/hud/rpw_binoculars_overlay_usa" )

function SWEP:DrawHUD()
	if (self.Zoom_InZoom) then																-- This part is for drawing the overlay and night vision.
	
		local w = ScrW()
		local h = ScrH()
		
		surface.SetMaterial( mat_bino_overlay )
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRect( 0 ,-(w-h)/2 ,w ,w )
		
		local tr = self.Owner:GetEyeTrace()
		
		local man = "None"
		
		if (LocalPlayer():GetEyeTraceNoCursor().Entity && IsValid((LocalPlayer():GetEyeTraceNoCursor().Entity)) && !(LocalPlayer():GetEyeTraceNoCursor().Entity:GetClass() == "player") ) then
			man = Localize( LocalPlayer():GetEyeTraceNoCursor().Entity:GetClass(), LocalPlayer():GetEyeTraceNoCursor().Entity:GetClass() )
		end
		
		draw.Text({
			text = "Target: "..man,
			font = "stalkertitlefont",
			pos = {w/2, h/2},
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_TOP,
			color = Color(0,0,0,255)
		})
		
	end
end

function SWEP:AdjustMouseSensitivity()
	if (self.Zoom_InZoom) then
		local zoom = 90/self.Owner:GetFOV()
		local adjustedsens = 1 / zoom
		return adjustedsens
	end
end
