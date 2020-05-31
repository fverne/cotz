local background = Material("cotz/panels/loot_interface.png")
local background2 = Material("stalker/backgroundempty.png", "noclamp")
local btn1 = Material("cotz/panels/button1_1.png", "noclamp smooth")
local btn1hover = Material("cotz/panels/button1_2.png", "noclamp smooth")
local btn1press = Material("cotz/panels/button1_4.png", "noclamp smooth")
local btn1pressed = Material("cotz/panels/button1_3.png", "noclamp smooth")
local btnclose = Material("stalker/btnclose.png", "noclamp smooth")

local PANEL = {}

function PANEL:Init()
	self:SetTitle("stalkertest")
	self:ShowCloseButton(false)

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
	surface.SetMaterial(btn1)

	if self:IsHovered() then
		surface.SetMaterial(btn1hover)
	end

	if self:IsDown() then
		surface.SetMaterial(btn1press)
	end

	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(0, 0, width, height)
end

vgui.Register("ixStalkerButton", PANEL, "DImageButton")