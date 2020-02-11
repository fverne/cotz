local background = Material("stalker/ui.png")
local background2 = Material("stalker/backgroundempty.png", "noclamp")
local qboard = Material("stalker/questboard.png", "noclamp")


local PANEL = {}

function PANEL:Init()
	self:SetTitle("stalkertest")
end

function PANEL:Paint(width, height)
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawRect(2, 2, width-4, height-4)
	

	surface.SetMaterial(background)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(2, 2, width-4, height-4)
end

vgui.Register("ixStalkerFrame", PANEL, "DFrame")

local PANEL = {}

function PANEL:Init()
	--self:SetImage("stalker/backgroundempty.png")
end

function PANEL:Paint(width, height)
	surface.SetMaterial(qboard)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(0, 0, width, height)

	surface.SetMaterial(background2)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(5, 5, width-10, height-10)

	--local texW = 490
	--local texH = 338
	--surface.SetMaterial(background2)
	--surface.SetDrawColor(255, 255, 255, 255)
	--surface.DrawTexturedRectUV(2, 2, width-4, height-4, 0, 0, width/texW, height/texH)
end

vgui.Register("ixStalkerButton", PANEL, "DImageButton")