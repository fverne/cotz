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


local PANEL = {}

function PANEL:Init()
	self:SetSize(400, 400)
	self:Dock(FILL)



	ix.gui.menuInventoryContainer = self

	local panel = self:Add("ixInventory")
	panel:SetPos(0, 0)
	panel:SetDraggable(false)
	panel:SetSizable(false)
	panel:SetTitle(nil)
	panel.bNoBackgroundBlur = true
	panel.childPanels = {}

	local inventory = LocalPlayer():GetCharacter():GetInventory()

	if (inventory) then
		panel:SetInventory(inventory)
	end

	ix.gui.inv1 = panel

	if (ix.option.Get("openBags", true)) then
		for _, v in pairs(inventory:GetItems()) do
			if (v.isBag) and v:GetData("equip") == true then
				v.functions.View.OnClick(v)
			end					
		end
	end

	self:SetWide(panel:GetWide() + 28)

end

vgui.Register("ixStalkerInventory", PANEL, "DScrollPanel")



local PANEL = {}

function PANEL:Init()
	self:ShowCloseButton(false)
	self:ShowCloseButton(true)
	self:SetDraggable(true)
	self:SetSizable(true)
	self:SetTitle("lutz")

	local container = self:Add("ixStalkerInventory")

	self:SetSize(container:GetWide(), container:GetTall())
end

vgui.Register("ixStalkerInventoryPanel", PANEL, "DFrame")

