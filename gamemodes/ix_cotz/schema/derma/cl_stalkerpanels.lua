local background = Material("cotz/panels/loot_interface.png")
local background2 = Material("stalker/backgroundempty.png", "noclamp")
local btn1 = Material("cotz/panels/button1_1.png", "noclamp smooth")
local btn1hover = Material("cotz/panels/button1_2.png", "noclamp smooth")
local btn1press = Material("cotz/panels/button1_4.png", "noclamp smooth")
local btn1pressed = Material("cotz/panels/button1_3.png", "noclamp smooth")
local btnclose = Material("stalker/btnclose.png", "noclamp smooth")

local PANEL = {}

function PANEL:Init()
	self.frame = self
	self.frame:SetTitle("stalkertest")
	self.frame:ShowCloseButton(false)
	self.frame:DockPadding(self.frame:GetWide() * 0.1, self.frame:GetTall() * 0.05, self.frame:GetWide() * 0.1, self.frame:GetTall() * 0.05)


	self.closebtn = self.frame:Add("DImageButton")
	self.closebtn:SetSize(ScrW()*0.0123, ScrH()*0.02155)
	self.closebtn:SetMaterial(btnclose)
	self.closebtn:SetPos(self.frame:GetWide() - self.frame:GetWide() * 0.08, self.frame:GetTall() - self.frame:GetTall() * 0.96)

	function self.closebtn.DoClick()
		self:Close()
	end
end

function PANEL:PostLayoutUpdate()
	self.frame:DockPadding(self.frame:GetWide() * 0.075, self.frame:GetTall() * 0.05, self.frame:GetWide() * 0.075, self.frame:GetTall() * 0.05)
	self.frame:SetSize(self.frame:GetWide() * 1.15, self.frame:GetTall() * 1.1)
	self.closebtn:SetPos(self.frame:GetWide() - self.frame:GetWide() * 0.04 - self.closebtn:GetWide(), self.frame:GetTall() - self.frame:GetTall() * 0.96)
	self.frame:Center()
end
	

function PANEL:Paint(width, height)
	surface.SetMaterial(background)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(2, 2, width-4, height-4)
end

vgui.Register("ixStalkerFrame", PANEL, "DFrame")

local PANEL = {}

function PANEL:Init()
	self:SetText(" -- ")
	self:DockMargin(self:GetParent():GetWide()*0.3, 20, self:GetParent():GetWide()*0.3, 0)
	self:SetTall(ScrH()*0.05)
	self:SetFont("stalkerregularfont")
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
	self:SetSize(ScrW()*0.2604, ScrH() * 0.66)
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

	self:SetWide(panel:GetWide() - (ScrW()*0.022 * ix.option.Get("inventoryScale", 1)))
end

vgui.Register("ixStalkerInventory", PANEL, "DScrollPanel")



local PANEL = {}

function PANEL:Init()
	self:ShowCloseButton(false)
	self:SetDraggable(false)
	self:SetSizable(false)
	self:SetTitle("")
	self.thinkdelay = 0

	ix.gui.menuInventoryFrame = self

	local container = self:Add("ixStalkerInventory")
	self:SetSize(container:GetWide() * 1.25, container:GetTall() * 1.0785)
	self:DockPadding(container:GetWide()*0.030, container:GetTall() * 0.173, container:GetWide()*0.030, container:GetTall() * 0.082)

	self.charbackground = self:Add("DImage")
	self.charbackground:SetSize(container:GetWide() * 1.25, container:GetTall() * 1.0785)
	self.charbackground:SetImage( "cotz/panels/menuplayers.png" )
	self.charbackground:SetPos(0, 0)
	self.charbackground:SetZPos(-1)


	self.name = self:Add("DLabel")
	self.name:SetFont("stalkerregularfont2")
	self.name:SetTextColor(color_white)
	self.name:SetPos(container:GetWide() * 0.06, container:GetTall() * 0.023)
	self.name:SetContentAlignment(7)
	self.name:SetWide(container:GetWide() * 0.54)
	self.name:SetTall(self:GetTall()*0.1)
	self.name:SetText(LocalPlayer():GetName())

	self.rep = self:Add("DLabel")
	self.rep:SetFont("stalkerregularfont3")
	self.rep:SetTextColor(color_white)
	self.rep:SetText("Rank: "..LocalPlayer():getCurrentRankName())
	self.rep:SetPos(container:GetWide() * 0.06, container:GetTall() * 0.069)
	self.rep:SetWide(container:GetWide() * 0.54)
	self.rep:SetContentAlignment(7)

	self.money = self:Add("DLabel")
	self.money:SetFont("stalkerregularfont3")
	self.money:SetPos(container:GetWide() * 0.06, container:GetTall() * 0.11)
	self.money:SetWide(container:GetWide() * 0.625)
	self.money:SetContentAlignment(6)
	self.money:SetText(ix.currency.Get(LocalPlayer():GetCharacter():GetMoney()))


	local carry = LocalPlayer():GetCharacter():GetData("carry", 0)
	local maxWeight = ix.config.Get("maxWeight", 30)
	self.weight = self:Add("DLabel")
	self.weight:SetFont("stalkerregularfont3")
	self.weight:SetPos(container:GetWide()*0.4, container:GetTall()*1.038)
	self.weight:SetWide(container:GetWide()*0.8)
	self.weight:SetContentAlignment(6)
	if (ix.option.Get("imperial", false)) then
		self.weight:SetText(math.Round(carry * 2.20462, 2).." lbs / "..math.Round(maxWeight * 2.20462, 2).." lbs")
	else
		self.weight:SetText(math.Round(carry, 2).." kg / "..maxWeight.." kg")
	end
	
	self.charbackgroundicon = self:Add("DImage")
	self.charbackgroundicon:SetSize(container:GetWide()*0.46, container:GetTall()*0.126)
	self.charbackgroundicon:SetPos(container:GetWide()*0.755, container:GetTall()*0.023)
	self.charbackgroundicon:SetZPos(-1)

	if LocalPlayer():GetCharacter():GetPdaavatar() then 
		self.charbackgroundicon:SetImage( LocalPlayer():GetCharacter():GetPdaavatar() )
	else
		self.charbackgroundicon:SetImage( "vgui/icons/face_31.png" )
	end

	self:IsVisible()
end

function PANEL:Update()
	-- money update
	self.money:SetText(ix.currency.Get(LocalPlayer():GetCharacter():GetMoney()))

	-- weight update
	local carry = LocalPlayer():GetCharacter():GetData("carry", 0)
	local maxWeight = ix.weight.BaseWeight(LocalPlayer():GetCharacter())
	if (ix.option.Get("imperial", false)) then
		self.weight:SetText(math.Round(carry * 2.20462, 2).." lbs / "..math.Round(maxWeight * 2.20462, 2).." lbs")
	else
		self.weight:SetText(math.Round(carry, 2).." kg / "..maxWeight.." kg")
	end

	-- avatar update
	if LocalPlayer():GetCharacter():GetPdaavatar() then 
		self.charbackgroundicon:SetImage( LocalPlayer():GetCharacter():GetPdaavatar() )
	else
		self.charbackgroundicon:SetImage( "vgui/icons/face_31.png" )
	end
end

function PANEL:Think()
	if self.thinkdelay < CurTime() then
		self:Update()
		self.thinkdelay = CurTime() + 0.1
	end
end

function PANEL:Paint(w, h)
	return
end

vgui.Register("ixStalkerInventoryPanel", PANEL, "DFrame")

