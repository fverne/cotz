
DEFINE_BASECLASS("DPanel")
local PANEL = {}

function PANEL:Init()
	self:SetTitle("stalkertest")

end

function PANEL:PaintOver(width, height)
	surface.DrawRect(0, 0, width, height)
	surface.SetDrawColor(0, 255, 0, 150)
	surface.DrawOutlinedRect(0, 0, width, height)
end

vgui.Register("ixStalkerFrame", PANEL, "DPanel")