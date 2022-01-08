local rad = Material("daui/rad_icon_v6.png")

function PLUGIN:HUDPaint()
	local lp = LocalPlayer()
	local wep = LocalPlayer():GetActiveWeapon()
	local char = lp:GetCharacter()
	if (!lp:GetCharacter() or !lp:Alive() or ix.gui.characterMenu:IsVisible() or ix.option.Get("disablehud", false)) then return end
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
		surface.SetDrawColor(Color(200, 200, 200, 255))
	elseif LocalPlayer():getRadiation() > 25 and LocalPlayer():getRadiation() <= 45 then
		surface.SetMaterial(rad2)
		surface.SetDrawColor(Color(200, 200, 200, 255))
	elseif LocalPlayer():getRadiation() > 45 and LocalPlayer():getRadiation() <= 75 then
		surface.SetMaterial(rad3)
		surface.SetDrawColor(Color(200, 200, 200, 255))
	elseif LocalPlayer():getRadiation() > 75 and LocalPlayer():getRadiation() <= 100 then
		surface.SetMaterial(rad4)
		surface.SetDrawColor(Color(200, 200, 200, 255))
	end

	surface.DrawTexturedRect(ScrW()*0.86, ScrH()*0.79, ScrW()*0.018, ScrH()*0.032)
end
