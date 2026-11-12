local PLUGIN = PLUGIN
local posH = ScrH() * 0.75
local posW = ScrW() * 0.82
local incH = ScrH() * -0.035
local incW = ScrW() * 0.02

local bleedingColor = Color(255, 220, 0)
local sprintColor = Color(255, 255, 150, 255)

function PLUGIN:OnScreenSizeChanged()
	posH = ScrH() * 0.75
	posW = ScrW() * 0.82
	incH = ScrH() * -0.035
	incW = ScrW() * 0.02
end

function PLUGIN:HUDPaint()
	local severity = LocalPlayer():GetLocalVar("bleedingSeverity", 0)
	if LocalPlayer():Alive() and LocalPlayer():GetCharacter() and severity > 0 then
		local fraction = math.Clamp(severity / ix.config.Get("bleedingMaximum", 100), 0, 1)
		bleedingColor.r = 255
		bleedingColor.g = math.Round(Lerp(fraction, 220, 0))

		ix.util.DrawBuffIcon("stalker/ui/heart.png", posW, posH, ScrW() * 0.016, ScrH() * 0.032,
			bleedingColor, tostring(severity))
	end

	if LocalPlayer():HasBuff("buff_slowheal") then
		ix.util.DrawBuffIcon("stalker/ui/heart.png", posW, posH+incH, ScrW()*0.016, ScrH()*0.032, Color(0, 190, 255), math.Round(LocalPlayer():HasBuff("buff_slowheal")[1]-CurTime()+0.5))
	end

	if LocalPlayer():HasBuff("buff_rapidheal") then
		ix.util.DrawBuffIcon("stalker/ui/heart.png", posW, posH+incH*2, ScrW()*0.016, ScrH()*0.032, Color(0, 255, 190), math.Round(LocalPlayer():HasBuff("buff_rapidheal")[1]-CurTime()+0.5))
	end

	if LocalPlayer():HasBuff("buff_staminarestore") then
		ix.util.DrawBuffIcon("stalker/ui/stamina.png", posW+incW, posH+incH, ScrW()*0.016, ScrH()*0.032, nil, math.Round(LocalPlayer():HasBuff("buff_staminarestore")[1]-CurTime()+0.5))
	end

	if LocalPlayer():HasBuff("buff_radprotect") then
		ix.util.DrawBuffIcon("stalker/ui/art.png", posW+incW*2, posH+incH*2, ScrW()*0.016, ScrH()*0.032, Color(0, 255, 190), nil, math.Round(LocalPlayer():HasBuff("buff_radprotect")[1]-CurTime()+0.5))
	end

	if LocalPlayer():HasBuff("buff_radiationremoval") then
		ix.util.DrawBuffIcon("stalker/ui/art.png", posW+incW*2, posH+incH, ScrW()*0.016, ScrH()*0.032,nil,math.Round(LocalPlayer():HasBuff("buff_radiationremoval")[1]-CurTime()+0.5))
	end

	if LocalPlayer():HasBuff("debuff_radiation") then
		ix.util.DrawBuffIcon("stalker/ui/art.png", posW+incW*2, posH, ScrW()*0.016, ScrH()*0.032, Color(255, 0, 0, 255), math.Round(LocalPlayer():HasBuff("debuff_radiation")[1]-CurTime()+0.5))
	end

	if LocalPlayer():HasBuff("buff_hijump") then
		ix.util.DrawBuffIcon("gui/arrow", posW+incW*3, posH+incH, ScrW()*0.016, ScrH()*0.032, Color(255, 255, 150, 255), math.Round(LocalPlayer():HasBuff("buff_hijump")[1]-CurTime()+0.5))
	end

	if LocalPlayer():HasBuff("buff_lightningsprint") then
		ix.util.DrawBuffIcon("stalker/ui/stamina.png", posW+incW*3, posH+incH*2, ScrW()*0.016, ScrH()*0.032, Color(255, 255, 150, 255))
	end

	if LocalPlayer():HasBuff("buff_sprintboost") then
		if LocalPlayer():HasBuff("buff_lightningsprint") then
			sprintColor = Color(150, 150, 150, 70)
		else
			sprintColor = Color(255, 255, 150, 255)
		end
		ix.util.DrawBuffIcon("stalker/ui/stamina.png", posW+incW, posH+incH*2, ScrW()*0.016, ScrH()*0.032, sprintColor,  math.Round(LocalPlayer():HasBuff("buff_sprintboost")[1]-CurTime()+0.5))
	end

	if LocalPlayer():HasBuff("buff_psysuppress") then
		ix.util.DrawBuffIcon("stalker/ui/psy.png", posW+incW*6, posH+incH*3, ScrW()*0.016, ScrH()*0.032, Color(0, 255, 0), math.Round(LocalPlayer():HasBuff("buff_psysuppress")[1]-CurTime()+0.5))
	end

	if LocalPlayer():HasBuff("buff_psyblock") then
		ix.util.DrawBuffIcon("stalker/ui/psy.png", posW+incW*6, posH+incH*2, ScrW()*0.016, ScrH()*0.032, Color(0, 255, 190), math.Round(LocalPlayer():HasBuff("buff_psyblock")[1]-CurTime()+0.5))
	end

	if LocalPlayer():HasBuff("buff_psyheal") then
		ix.util.DrawBuffIcon("stalker/ui/psy.png", posW+incW*6, posH+incH, ScrW()*0.016, ScrH()*0.032,nil , math.Round(LocalPlayer():HasBuff("buff_psyheal")[1]-CurTime()+0.5))
	end

	if LocalPlayer():HasBuff("debuff_psy") then
		ix.util.DrawBuffIcon("stalker/ui/psy.png", posW+incW*6, posH, ScrW()*0.016, ScrH()*0.032, Color(255, 0, 0, 255), math.Round(LocalPlayer():HasBuff("debuff_psy")[1]-CurTime()+0.5))
	end

	if LocalPlayer():HasBuff("buff_passivehealthregen") then
		ix.util.DrawBuffIcon("stalker/ui/heart.png", posW-incW, posH+incH, ScrW()*0.016, ScrH()*0.032, Color(130, 200, 130, 150))
	end
	if LocalPlayer():HasBuff("buff_townradprotect") then
		ix.util.DrawBuffIcon("stalker/ui/art.png", posW-incW, posH+incH*2, ScrW()*0.016, ScrH()*0.032, Color(130, 200, 130, 150))
	end
end
