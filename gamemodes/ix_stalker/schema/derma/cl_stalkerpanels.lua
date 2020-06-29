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
	self:SetSize(400, 600)
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

	self:SetWide(panel:GetWide() - 64)
	

end

vgui.Register("ixStalkerInventory", PANEL, "DScrollPanel")



local PANEL = {}

function PANEL:Init()
	self:ShowCloseButton(false)
	self:ShowCloseButton(true)
	self:SetDraggable(true)
	self:SetSizable(true)
	self:SetTitle("")

	local container = self:Add("ixStalkerInventory")
	self:SetSize(container:GetWide() + 100, container:GetTall() + 100)
	self:DockPadding(12, 112, 12, 48)

	self.charbackground = self:Add("DImage")
	self.charbackground:SetSize(container:GetWide() + 100, container:GetTall() + 100)
	self.charbackground:SetImage( "cotz/panels/menuplayers.png" )
	self.charbackground:SetPos(0, 0)
	self.charbackground:SetZPos(-1)

	self.name = self:Add("DLabel")
	self.name:SetFont("stalkerregularfont2")
	self.name:SetTextColor(color_white)
	self.name:SetPos(24, 16)
	self.name:SetContentAlignment(7)
	self.name:SetWide(220)
	self.name:SetTall(self:GetTall()*0.1)
	self.name:SetText(LocalPlayer():GetName())

	self.rep = self:Add("DLabel")
	self.rep:SetFont("stalkerregularfont3")
	self.rep:SetTextColor(color_white)
	self.rep:SetText("Rank: "..LocalPlayer():getCurrentRankName())
	self.rep:SetPos(24, 42)
	self.rep:SetWide(220)
	self.rep:SetContentAlignment(7)

	self.money = self:Add("DLabel")
	self.money:SetFont("stalkerregularfont3")
	self.money:SetPos(24, 72)
	self.money:SetWide(210)
	self.money:SetContentAlignment(6)
	self.money:SetText(ix.currency.Get(LocalPlayer():GetCharacter():GetMoney()))
end

vgui.Register("ixStalkerInventoryPanel", PANEL, "DFrame")

