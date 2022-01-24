function PLUGIN:HUDPaint()
	local lp = LocalPlayer()
	if (!lp:GetCharacter() or !lp:Alive() or ix.gui.characterMenu:IsVisible() or ix.option.Get("disablehud", false)) then return end
	local value = 100 - lp:getRadiation()

	ix.util.DrawStatusIcon("stalker/ui/art.png", value, ScrW()*0.86, ScrH()*0.79)
end
