local PLUGIN = PLUGIN
local playerMeta = FindMetaTable("Player")

function PLUGIN:HUDPaint()
	local Texture1 = Material("vgui/hud/healpro.png", "noclamp smooth") 
	local Texture2 = Material("vgui/hud/staminapro.png", "noclamp smooth") 
	local Texture3 = Material("vgui/hud/radmin.png", "noclamp smooth") 
	local Texture4 = Material("vgui/hud/radpro.png", "noclamp smooth") 
	local Texture5 = Material("vgui/hud/radmin.png", "noclamp smooth") 
	local Texture6 = Material("vgui/hud/psypro.png", "noclamp smooth") 
	

	if LocalPlayer():HasBuff("buff_slowheal") then
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(Texture1)
		surface.DrawTexturedRect(ScrW()*0.82, ScrH()*0.75, ScrW()*0.016, ScrH()*0.032)
	end

	if LocalPlayer():HasBuff("buff_staminarestore") then
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(Texture2)
		surface.DrawTexturedRect(ScrW()*0.84, ScrH()*0.75, ScrW()*0.016, ScrH()*0.032)
	end
	
	if LocalPlayer():HasBuff("buff_radiationremoval") then
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(Texture3)
		surface.DrawTexturedRect(ScrW()*0.86, ScrH()*0.75, ScrW()*0.016, ScrH()*0.032)
	end

	if LocalPlayer():HasBuff("buff_radprotect") then
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(Texture4)
		surface.DrawTexturedRect(ScrW()*0.88, ScrH()*0.75, ScrW()*0.016, ScrH()*0.032)
	end

	if LocalPlayer():HasBuff("debuff_radiation") then
		surface.SetDrawColor(Color(255, 0, 0, 255))
		surface.SetMaterial(Texture5)
		surface.DrawTexturedRect(ScrW()*0.92, ScrH()*0.75, ScrW()*0.016, ScrH()*0.032)
	end

	if LocalPlayer():HasBuff("buff_psysuppress") then
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(Texture6)
		surface.DrawTexturedRect(ScrW()*0.9, ScrH()*0.75, ScrW()*0.016, ScrH()*0.032)
	end


end