local PLUGIN = PLUGIN
local playerMeta = FindMetaTable("Player")

function PLUGIN:HUDPaint()
	local Texture1 = Material("vgui/hud/healpro.png", "noclamp smooth") 
	local Texture2 = Material("vgui/hud/staminapro.png", "noclamp smooth") 
	local Texture3 = Material("vgui/hud/radmin.png", "noclamp smooth") 
	local Texture4 = Material("vgui/hud/radpro.png", "noclamp smooth") 
	local Texture5 = Material("vgui/hud/radmin.png", "noclamp smooth") 
	

	if LocalPlayer():HasBuff("buff_slowheal") then
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(Texture1)
		surface.DrawTexturedRect(ScrW()-260, ScrH()-229, 28, 32, Color(255, 255, 255, 255))
	end

	if LocalPlayer():HasBuff("buff_staminarestore") then
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(Texture2)
		surface.DrawTexturedRect(ScrW()-230, ScrH()-229, 28, 32, Color(255, 255, 255, 255))
	end
	
	if LocalPlayer():HasBuff("buff_radiationremoval") then
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(Texture3)
		surface.DrawTexturedRect(ScrW()-200, ScrH()-229, 28, 32, Color(255, 255, 255, 255))
	end

	if LocalPlayer():HasBuff("buff_radprotect") then
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(Texture4)
		surface.DrawTexturedRect(ScrW()-170, ScrH()-229, 28, 32, Color(255, 255, 255, 255))
	end

	if LocalPlayer():HasBuff("debuff_radiation") then
		surface.SetDrawColor(Color(255, 0, 0, 255))
		surface.SetMaterial(Texture5)
		surface.DrawTexturedRect(ScrW()-140, ScrH()-229, 28, 32, Color(255, 0, 0, 255))
	end

end