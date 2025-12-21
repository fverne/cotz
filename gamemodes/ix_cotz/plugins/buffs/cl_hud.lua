local PLUGIN = PLUGIN
local posH = ScrH() * 0.75
local posW = ScrW() * 0.82
local incH = ScrH() * -0.035
local incW = ScrW() * 0.02

function PLUGIN:HUDPaint()
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
end
