local background = Material("stalker/ui.png")
local background2 = Material("stalker/backgroundempty.png", "noclamp")
local qboard = Material("stalker/btn1.png", "noclamp smooth")
local btnclose = Material("stalker/btnclose.png", "noclamp smooth")

local PANEL = {}

function PANEL:Init()
	self:SetTitle("stalkertest")

	local closebtn = self:Add("DImageButton")
	closebtn:SetSize(ScrW()*0.0183, ScrH()*0.03255)
	closebtn:SetMaterial(btnclose)
	closebtn:SetPos(15, 15)

	function closebtn.DoClick()
		self:Close()
	end
end

function PANEL:Paint(width, height)
	surface.SetMaterial(background)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(2, 2, width-4, height-4)
end

vgui.Register("ixStalkerFrame", PANEL, "DFrame")

local PANEL = {}

function PANEL:Init()
	
end

function PANEL:Paint(width, height)
	surface.SetMaterial(qboard)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(0, 0, width, height)
end

vgui.Register("ixStalkerButton", PANEL, "DImageButton")