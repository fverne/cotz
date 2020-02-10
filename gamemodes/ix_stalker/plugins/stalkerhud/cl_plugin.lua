local Texture2 = Material("stalker/ui/bar.png", "noclamp smooth") 
local Texture7 = Material("stalker/ui/hud_hunger.png", "noclamp smooth") 
local gun = Material("vgui/hud/gun.png", "noclamp smooth")
local gun2 = Material("vgui/hud/gun2.png", "noclamp smooth") 
local gun3 = Material("vgui/hud/gun3.png", "noclamp smooth") 
local gun4 = Material("vgui/hud/gun4.png", "noclamp smooth") 
local Texture1 = Material("stalker/ui/health.png", "noclamp smooth") 
local Ammo = Material("stalker/ui/ammo.png", "noclamp smooth") 

surface.CreateFont("stalkermainmenufont", {
	font = "stalker2",
	size = ScreenScale(8),
	extended = true,
	weight = 500
})
surface.CreateFont("stalkerregularsmallfont", {
	font = "alsina",
	size = ScreenScale(6),
	extended = true,
	weight = 500
})
surface.CreateFont("stalkerregularfont", {
	font = "alsina",
	size = ScreenScale(8),
	extended = true,
	weight = 500
})
surface.CreateFont("stalkerregulartitlefont", {
	font = "alsina",
	size = ScreenScale(12),
	extended = true,
	weight = 500
})
surface.CreateFont("stalkerregularbigfont", {
	font = "alsina",
	size = ScreenScale(18),
	extended = true,
	weight = 500
})
surface.CreateFont("stalkertitlefont", {
	font = "type-ra",
	size = ScreenScale(16),
	extended = true,
	weight = 500
})

local color = {}
color["$pp_colour_addr"] = 0
color["$pp_colour_addg"] = 0
color["$pp_colour_addb"] = 0
color["$pp_colour_brightness"] = -0.01
color["$pp_colour_contrast"] = 0.90
color["$pp_colour_colour"] = 0.75
color["$pp_colour_mulr"] = 0
color["$pp_colour_mulg"] = 0
color["$pp_colour_mulb"] = 0

function PLUGIN:RenderScreenspaceEffects()
	DrawColorModify(color)
end

local function cursorDraw()
	if ix.option.Get("cursor", false) then
	    local x, y = gui.MousePos()
		local material = Material("stalker/cursor.vmt") 
	    if (x != 0 && y != 0) then 
	        surface.SetDrawColor( 255, 255, 255, 255 );
	        surface.SetMaterial(material)
	        surface.DrawTexturedRect( x, y, 60, 60 )
	    end
    end
end

local function cursorThink() 
	if ix.option.Get("cursor", false) then
	    local hover = vgui.GetHoveredPanel()
	    if not IsValid(hover) then 
	        return; 
	    end; 
	    hover:SetCursor('blank')
	end
end; 

hook.Add("PostRenderVGUI", "Draw_Cursor_Function_FGSHAR", cursorDraw) -- PostRenderVGUI makes our custom cursor be drawn after the UI elements, this will make it work properly.
hook.Add("Think", "Cursor_Think_Function_FGSHAR", cursorThink)

function PLUGIN:HUDPaint()
	--// HUD Code exported by verne using Exho's HUD Designer //--
	--// STALKER Hud Exported on 03/13/16 11:46:26 //--
	
	local lp = LocalPlayer()
	local wep = LocalPlayer():GetActiveWeapon()
	local char = lp:GetCharacter()
	if (!lp:GetCharacter() or !lp:Alive() or ix.gui.characterMenu:IsVisible()) then return end

	surface.SetMaterial(Texture1)
	surface.SetDrawColor(Color(255, 255, 255, 255))
	surface.DrawTexturedRect(ScrW()-280, ScrH()-195, 250, 90, Color(41, 128, 185, 255))

	surface.SetMaterial(Ammo)
	surface.SetDrawColor(Color(255, 255, 255, 255))
	surface.DrawTexturedRect(ScrW()-250, ScrH()-115, 210, 90, Color(41, 128, 185, 255))

	surface.SetMaterial(Texture2)
	surface.SetDrawColor(Color(255, 255, 255, 255))
	surface.DrawTexturedRect(ScrW()-233, ScrH()-136, (1.72*math.Clamp( LocalPlayer():Health()/LocalPlayer():GetMaxHealth()*100, 0, 100 )), 17)
	
/*
	surface.SetMaterial(Texture7)

	if LocalPlayer():getHungerPercent()*100 <= 25 then
		surface.SetDrawColor(Color(0, 0, 0, 0))
	elseif LocalPlayer():getHungerPercent()*100 > 25 and LocalPlayer():getHungerPercent()*100 <= 50 then
		surface.SetDrawColor(Color(116, 195, 101, 255))
	elseif LocalPlayer():getHungerPercent()*100 > 50 and LocalPlayer():getHungerPercent()*100 <= 90 then
		surface.SetDrawColor(Color(255, 255, 102, 255))
	elseif LocalPlayer():getHungerPercent()*100 > 90 and LocalPlayer():getHungerPercent()*100 <= 100 then
		surface.SetDrawColor(Color(255, 36, 0, 255))
	end

	surface.DrawTexturedRect(ScrW()-260, ScrH()-149, 32, 32, Color(0, 255, 0, 255))
*/
	surface.SetMaterial(gun)
	if IsValid( wep ) then
		if string.sub(wep:GetClass(),1,3) == "cw_" then
			if LocalPlayer():GetActiveWeapon():GetWeaponWear() > 80 then
				surface.SetDrawColor(Color(0, 0, 0, 0))
			elseif LocalPlayer():GetActiveWeapon():GetWeaponWear() > 60 and LocalPlayer():GetActiveWeapon():GetWeaponWear() <= 80 then
				surface.SetMaterial(gun)
				surface.SetDrawColor(Color(255, 255, 255, 255))
			elseif LocalPlayer():GetActiveWeapon():GetWeaponWear() > 40 and LocalPlayer():GetActiveWeapon():GetWeaponWear() <= 60 then
				surface.SetMaterial(gun2)
				surface.SetDrawColor(Color(255, 255, 255, 255))
			elseif LocalPlayer():GetActiveWeapon():GetWeaponWear() > 20 and LocalPlayer():GetActiveWeapon():GetWeaponWear() <= 40 then
				surface.SetMaterial(gun3)
				surface.SetDrawColor(Color(255, 255, 255, 255))
			elseif LocalPlayer():GetActiveWeapon():GetWeaponWear() > 0 and LocalPlayer():GetActiveWeapon():GetWeaponWear() <= 20 then
				surface.SetMaterial(gun4)
				surface.SetDrawColor(Color(255, 255, 255, 255))
			end
		else
			surface.SetDrawColor(Color(0, 0, 0, 0))
		end
	end
	surface.DrawTexturedRect(ScrW()-80, ScrH()-350, 33, 35, Color(0, 255, 0, 255))
	
--AMMO
	if IsValid( wep ) then
		if wep:GetMaxClip1() > 0 then
			draw.DrawText( tostring(wep:Clip1()) .. " / " .. tostring(lp:GetAmmoCount( wep:GetPrimaryAmmoType() )), "stalkermainmenufont", ScrW() -120, ScrH() -75, Color( 193, 136, 21, 255 ), TEXT_ALIGN_CENTER )
			if wep:GetPrimaryAmmoType() then
				if string.sub(game.GetAmmoName(wep:GetPrimaryAmmoType()) or "no", -1) == "-" then
					draw.DrawText( string.sub(game.GetAmmoName(wep:GetPrimaryAmmoType()), -3, -2) , "stalkermainmenufont", ScrW() -210, ScrH() -75, Color( 193, 136, 21, 255 ), TEXT_ALIGN_CENTER )
				else
					draw.DrawText( "--" , "stalkermainmenufont", ScrW() -210, ScrH() -75, Color( 193, 136, 21, 255 ), TEXT_ALIGN_CENTER )
				end
			end
		end
	end
--// End HUD Code //--
end



function ix.hud.DrawDeath()
	local owner, w, h, ceil, ft, clmp
	owner = LocalPlayer()
	ft = FrameTime()
	w, h = ScrW(), ScrH()

	if (owner:GetCharacter()) then
		if !(owner:Alive()) then
			if (IsValid(ix.gui.characterMenu) and ix.gui.characterMenu:IsVisible() or !owner:GetCharacter()) then
				return
			end

			surface.SetDrawColor(0, 0, 0, 255)
			surface.DrawRect(-1, -1, w+2, h+2)

			ix.util.DrawText(
				string.upper("Lost to the Zone"), w/2, h/2, Color(255, 0, 0), 1, 1, "stalkerregularbigfont", 255
			)
		end
	end	
end