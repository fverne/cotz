local background = Material("stalker/ui.png")
local background2 = Material("stalker/backgroundempty.png", "noclamp")
local qboard = Material("stalker/btn1.png", "noclamp smooth")
local btnclose = Material("stalker/btnclose.png", "noclamp smooth")

local PANEL = {}

function PANEL:Init()
	self:SetTitle("stalkertest")

	local closebtn = self:Add("DImageButton")
	closebtn:SetWidth(ScrW()*0.02)
	closebtn:SetMaterial(btnclose)
	closebtn:SetPos(10, 10)

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

	--local texW = 490
	--local texH = 338
	--surface.SetMaterial(background2)
	--surface.SetDrawColor(255, 255, 255, 255)
	--surface.DrawTexturedRectUV(2, 2, width-4, height-4, 0, 0, width/texW, height/texH)
end

vgui.Register("ixStalkerButton", PANEL, "DImageButton")