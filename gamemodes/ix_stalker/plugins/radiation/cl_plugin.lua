local rad = Material("daui/rad_icon_v6.png") 

function PLUGIN:HUDPaint()
	local lp = LocalPlayer()
	local wep = LocalPlayer():GetActiveWeapon()
	local char = lp:GetCharacter()
	if (!lp:GetCharacter() or !lp:Alive() or ix.gui.characterMenu:IsVisible()) then return end
	local rad = Material("vgui/hud/rad.png", "noclamp smooth") 
	local rad2 = Material("vgui/hud/rad2.png", "noclamp smooth") 
	local rad3 = Material("vgui/hud/rad3.png", "noclamp smooth") 
	local rad4 = Material("vgui/hud/rad4.png", "noclamp smooth")

	surface.SetMaterial(rad)
	if LocalPlayer():getRadiation() == 0 then
		surface.SetMaterial(rad)
		surface.SetDrawColor(Color(0, 0, 0, 0))
	elseif LocalPlayer():getRadiation() > 0 and LocalPlayer():getRadiation() <= 25 then
		surface.SetMaterial(rad)
		surface.SetDrawColor(Color(255, 255, 255, 255))
	elseif LocalPlayer():getRadiation() > 25 and LocalPlayer():getRadiation() <= 45 then
		surface.SetMaterial(rad2)
		surface.SetDrawColor(Color(255, 255, 255, 255))
	elseif LocalPlayer():getRadiation() > 45 and LocalPlayer():getRadiation() <= 75 then
		surface.SetMaterial(rad3)
		surface.SetDrawColor(Color(255, 255, 255, 255))
	elseif LocalPlayer():getRadiation() > 75 and LocalPlayer():getRadiation() <= 100 then
		surface.SetMaterial(rad4)
		surface.SetDrawColor(Color(255, 255, 255, 255))
	end

	surface.DrawTexturedRect(ScrW()-80, ScrH()-300, 33, 35, Color(0, 255, 0, 255))
end