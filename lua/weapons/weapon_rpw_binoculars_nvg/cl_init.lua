include( "shared.lua" )

language.Add("weapon_rpw_binoculars_nvg", "NV Binoculars")

surface.CreateFont( "rangefindernvg", {														
	font = "Arial",
	extended = false,
	size = 32,
	weight = 600,
	blursize = 1,
	scanlines = 2,
	antialias = false,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )																					

SWEP.PrintName 				= "NVG Binoculars"
SWEP.Slot 					= 0
SWEP.SlotPos 				= 1
SWEP.DrawAmmo 				= false
SWEP.DrawCrosshair 			= false
SWEP.ViewModelFlip 			= false

SWEP.WepSelectIcon 			= surface.GetTextureID("vgui/swepicons/weapon_rpw_binoculars_nvg")
SWEP.DrawWeaponInfoBox		= false
SWEP.BounceWeaponIcon 		= false 

SWEP.ViewModelFOV			= 65

local mat_bino_overlay = Material( "vgui/hud/rpw_binoculars_overlay" )
local mat_color = Material( "pp/colour" )
local mat_noise = Material( "vgui/hud/nvg_noise" )

function SWEP:DrawHUD()
	if (self.Zoom_InZoom) then																-- This part is for drawing the overlay and night vision.
		local w = ScrW()
		local h = ScrH()
		local nvon = self:GetNWBool( "nvon", true )
		if (nvon) then
			//local dlight = DynamicLight(self:EntIndex())
			//dlight.r = 255
			//dlight.g = 255
			//dlight.b = 255
			//dlight.minlight = 0
			//dlight.style = 0
			//dlight.Brightness = 0.1
			//dlight.Pos = EyePos()
			//dlight.Size = 2048
			//dlight.Decay = 10000
			//dlight.DieTime = CurTime() + 0.1
		
			render.UpdateScreenEffectTexture()
			
			mat_color:SetTexture( "$fbtexture", render.GetScreenEffectTexture() )

			mat_color:SetFloat( "$pp_colour_addr", -255 )
			mat_color:SetFloat( "$pp_colour_addg", 0 )
			mat_color:SetFloat( "$pp_colour_addb", -255 )
			mat_color:SetFloat( "$pp_colour_mulr", 0 )
			mat_color:SetFloat( "$pp_colour_mulg", 0 )
			mat_color:SetFloat( "$pp_colour_mulb", 0 )
			mat_color:SetFloat( "$pp_colour_brightness", 0.01 )
			mat_color:SetFloat( "$pp_colour_contrast", 5 )
			mat_color:SetFloat( "$pp_colour_colour", 1 )

			render.SetMaterial( mat_color )
			render.DrawScreenQuad()
			
			
			surface.SetMaterial( mat_noise )
			surface.SetDrawColor( 0, 255, 0, 100 )
			surface.DrawTexturedRect( 0+math.Rand(-128,128), 0+math.Rand(-128,128), w, h )
			
			surface.SetMaterial( mat_noise )
			surface.SetDrawColor( 0, 255, 0, 100 )
			surface.DrawTexturedRect( 0+math.Rand(-64,64), 0+math.Rand(-64,64), w, h )
		end
		
		surface.SetMaterial( mat_bino_overlay )
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRect( 0 ,-(w-h)/2 ,w ,w )
		
		if (nvon) then
			DrawBloom(0.5,1,10,10,2,1,1,1,1)
		end
		
		local tr = self.Owner:GetEyeTrace()
		local range = (math.ceil(10*(tr.StartPos:Distance(tr.HitPos)*0.024))/10)
		
		if tr.HitSky then
			range = "-"
		else
			range = range.."m"
		end
		
		surface.SetTextColor( 255, 255, 255, 255 )
		
		if (nvon) then
			surface.SetTextColor( 255, 255, 0, 255 )
		end
		
		surface.SetFont( "stalkertitlefont" )
		surface.SetTextPos( (w*0.165), (h/2) + 16 )
		surface.DrawText( "RANGE: "..range )
		
		local zoom = math.ceil((90/self.Owner:GetFOV())*10)/10
		
		surface.SetTextPos( (w*0.165), (h/2) + 42 )
		surface.DrawText( "ZOOM: "..zoom.."x" )
		
		local text = "NV OFF"
		if (nvon) then
			text = "PASSIVE NV"
		end
		
		surface.SetTextPos( (w*7/10), (h*2)/3 )
		surface.DrawText( text )
	end
end

function SWEP:AdjustMouseSensitivity()
	if (self.Zoom_InZoom) then
		local zoom = 90/self.Owner:GetFOV()
		local adjustedsens = 1 / zoom
		return adjustedsens
	end
end
