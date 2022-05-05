local Texture2 = Material("cotz/panels/hp1.png", "noclamp smooth")
local Ammo = Material("stalker/ui/ammo.png", "noclamp smooth")

surface.CreateFont("stalkermainmenufont", {
	font = "stalker2",
	size = ScreenScale(8),
	extended = true,
	weight = 500,
	antialias = true
})

surface.CreateFont("stalkerregulartipfont", {
	font = "alsina",
	size = ScreenScale(5),
	extended = true,
	weight = 500,
	antialias = true
})

surface.CreateFont("stalkerregularsmallfont", {
	font = "alsina",
	size = ScreenScale(6),
	extended = true,
	weight = 500,
	antialias = true
})

surface.CreateFont("stalkerregularsmallfont2", {
	font = "alsina",
	size = ScreenScale(7),
	extended = true,
	weight = 500,
	antialias = true
})

surface.CreateFont("stalkerregularinvfont", {
	font = "alsina",
	size = 16,
	extended = true,
	weight = 1,
	antialias = true
})

surface.CreateFont("stalkerregularfontcategory", {
	font = "alsina",
	size = ScreenScale(7),
	extended = true,
	weight = 500,
	antialias = true
})

surface.CreateFont("stalkerregularfont", {
	font = "alsina",
	size = ScreenScale(8),
	extended = true,
	weight = 500,
	antialias = true
})

surface.CreateFont("stalkerregularfont2", {
	font = "alsina",
	size = 24,
	extended = true,
	weight = 500,
	antialias = true
})

surface.CreateFont("stalkerregularfont3", {
	font = "alsina",
	size = 18,
	extended = true,
	weight = 500,
	antialias = true
})

surface.CreateFont("stalkerregularchatfont", {
	font = "alsina",
	size = ScreenScale(9),
	extended = true,
	weight = 500,
	antialias = true
})

surface.CreateFont("stalkerregulartitlefont", {
	font = "alsina",
	size = ScreenScale(9),
	extended = true,
	weight = 500,
	antialias = true
})

surface.CreateFont("stalkerregularbigfont", {
	font = "alsina",
	size = ScreenScale(18),
	extended = true,
	weight = 500,
	antialias = true
})

surface.CreateFont("stalkertitlefont", {
	font = "alsina",
	size = ScreenScale(13),
	extended = true,
	weight = 500,
	antialias = true
})

surface.CreateFont("stalkermaintitlefont", {
	font = "stalker2",
	size = ScreenScale(26),
	extended = true,
	weight = 500,
	antialias = true
})

surface.CreateFont("stalkermainsubtitlefont", {
	font = "stalker2",
	size = ScreenScale(20),
	extended = true,
	weight = 500,
	antialias = true
})

local FiremodeTranslationTable = {
	["semi"] = "1",
	["pump"] = "1",
	["bolt"] = "1",
	["break"] = "1",
	["double"] = "1",
	["2burst"] = "2",
	["3burst"] = "3",
	["auto"] = "A",

}

local color = {}
color["$pp_colour_addr"] = 0
color["$pp_colour_addg"] = 0
color["$pp_colour_addb"] = 0
color["$pp_colour_brightness"] = 0
color["$pp_colour_contrast"] = 1
color["$pp_colour_colour"] = 1
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
	local char = lp:GetCharacter()
	local wep = LocalPlayer():GetActiveWeapon()

	if (!lp:GetCharacter() or !lp:Alive() or ix.gui.characterMenu:IsVisible() or ix.option.Get("disablehud", false)) then return end

	local ammoType
	local ammoAmount
	local AmmoImage
	local ammoBox = ""
	local ammoSubClass = ""

	if IsValid(wep) then
		if wep:GetPrimaryAmmoType() then
			ammoType = wep:GetPrimaryAmmoType()
			ammoAmount = wep:Clip1()
		end

		if wep:GetMaxClip1() > 0 then
			if string.sub(wep:GetClass(),1,3) == "cw_" then
				if ((game.GetAmmoName(wep:GetPrimaryAmmoType()) or "") != "") then
					if string.sub(game.GetAmmoName(ammoType), -1) == "-" then
						ammoSubClass = string.lower(string.sub(game.GetAmmoName(ammoType), -3, -2))
						ammoBox = ix.weapontables.ammotypes[string.sub(game.GetAmmoName(ammoType), 1, -6)].uID
						ammoBox = ammoBox..ammoSubClass
					else
						ammoBox = ix.weapontables.ammotypes[game.GetAmmoName(ammoType)].uID
					end

					if ammoBox then
						if ix.item.list[ammoBox] then
							AmmoImage = ix.item.list[ammoBox].img

							surface.SetMaterial(AmmoImage)
							surface.SetDrawColor(Color(255, 255, 255, 255))

							if ix.item.list[ammoBox].width == 1 then
								surface.DrawTexturedRect(ScrW()*0.89, ScrH()*0.87, ScrW()*0.0366, ScrH()*0.0652)
							else
								surface.DrawTexturedRect(ScrW()*0.87, ScrH()*0.87, ScrW()*0.073, ScrH()*0.0652)
							end
						end
					end
				end
			end
			surface.SetMaterial(Ammo)
			surface.SetDrawColor(Color(255, 255, 255, 200))
			surface.DrawTexturedRect(ScrW()*0.81, ScrH()*0.835, ScrW()*0.1518, ScrH()*0.1172)
		end
	end

	if IsValid( wep ) then
		if wep:GetMaxClip1() > 0 then
			draw.DrawText(tostring(wep:Clip1()), "stalkerregularfont", ScrW()*0.865, ScrH()*0.875, Color( 193, 136, 21, 255 ), TEXT_ALIGN_CENTER )
			draw.DrawText(tostring(lp:GetAmmoCount( wep:GetPrimaryAmmoType() )), "stalkerregularfont", ScrW()*0.865, ScrH()*0.905, Color( 193, 136, 21, 255 ), TEXT_ALIGN_CENTER )

			if string.sub(wep:GetClass(),1,3) == "cw_" then
				if wep:GetPrimaryAmmoType() then
					draw.DrawText( language.GetPhrase(game.GetAmmoName(wep:GetPrimaryAmmoType()).."_ammo"), "stalkerregularsmallfont2", ScrW()*0.83, ScrH()*0.838, Color( 193, 136, 21, 255 ), TEXT_ALIGN_LEFT )
				end

				if (wep.FireMode) then
					draw.DrawText( FiremodeTranslationTable[wep.FireMode] or "-", "stalkerregularsmallfont2", ScrW()*0.835, ScrH()*0.875, Color( 193, 193, 136, 255 ), TEXT_ALIGN_LEFT )
				end
			end
		end
	end

	surface.SetMaterial(Texture2)
	surface.SetDrawColor(Color(255, 120, 120, 255))
	surface.DrawTexturedRectUV(ScrW()*0.05, ScrH()*0.905, math.Clamp(LocalPlayer():Health()/LocalPlayer():GetMaxHealth(), 0, 1)*ScrW()*0.15, ScrH()*0.008, 0, 0, math.Clamp(LocalPlayer():Health()/LocalPlayer():GetMaxHealth(), 0, 1), 1)

	if IsValid( wep ) && string.sub(wep:GetClass(),1,3) == "cw_" then
		ix.util.DrawStatusIcon("stalker/ui/pistol.png", LocalPlayer():GetActiveWeapon():GetWeaponWear(), ScrW()*0.9, ScrH()*0.79)
	end
end



function ix.hud.DrawDeath()
	local owner, w, h, ceil, ft, clmp
	owner = LocalPlayer()
	w, h = ScrW(), ScrH()

	if (owner:GetCharacter()) then
		if (!owner:Alive()) then
	      if (IsValid(ix.gui.menu)) then
	            ix.gui.menu:Remove()
            end
			if (IsValid(ix.gui.characterMenu) and ix.gui.characterMenu:IsVisible() or !owner:GetCharacter()) then
				return
			end

			--disabled blackscreen for now
			--surface.SetDrawColor(0, 0, 0, 255)
			--surface.DrawRect(-1, -1, w+2, h+2)

			ix.util.DrawText(
				string.upper("Lost to the Zone"), w/2, h/2, Color(255, 0, 0), 1, 1, "stalkerregularbigfont", 255
			)

			ix.util.DrawText(
				"Hold [E] to bleed out and respawn", w/2, (h/5) * 4, Color(220, 220, 220), 1, 1, "stalkerregularfont", 255
			)
		end
	end
end
