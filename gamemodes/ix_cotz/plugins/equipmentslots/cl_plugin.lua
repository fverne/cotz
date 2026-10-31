local PLUGIN = PLUGIN
local PANEL = {}
PLUGIN.equipmentViews = setmetatable({}, {__mode = "k"})

function PLUGIN:SendEquipmentAction(item, index, equipping, x, y)
	if (self.nextAction or 0) > RealTime() then return end
	self.nextAction = RealTime() + 0.25
	net.Start("cotz/equipment/action")
		net.WriteUInt(item.id, 32)
		net.WriteUInt(index, 4)
		net.WriteBool(equipping)
		net.WriteBool(x ~= nil and y ~= nil)
		if x and y then
			net.WriteUInt(x, 6)
			net.WriteUInt(y, 6)
		end
	net.SendToServer()
end

local COLORS = {
	background = Color(19, 18, 20, 235),
	card = Color(12, 13, 12, 215),
	border = Color(93, 94, 86, 180),
	hover = Color(169, 171, 149),
	text = Color(216, 215, 201),
	muted = Color(116, 119, 107),
	teal = Color(73, 140, 143),
	green = Color(105, 139, 87),
	amber = Color(167, 143, 81),
	red = Color(154, 84, 70),
	track = Color(41, 43, 38),
}
local PROTECTION = {
	{name = "Ballistic", multiplier = "ixperbulletres", flat = "ixflatbulletres"},
	{name = "Rupture", multiplier = "ixperslashres", flat = "ixflatslashres"},
	{name = "Radiation", radiation = true},
	{name = "Anomaly", multiplier = "ixperanomres", flat = "ixflatanomres"},
	{name = "Psy", multiplier = "ixperpsyres", flat = "ixflatpsyres"},
}

local function drawSegments(x, y, width, height, fraction, fillColor)
	local segments = 12
	local gap = 2
	local segmentWidth = (width - gap * (segments - 1)) / segments
	local color = fillColor or (fraction > 0.8 and COLORS.green or (fraction > 0.4 and COLORS.amber or COLORS.red))

	for index = 1, segments do
		surface.SetDrawColor(index / segments <= fraction and color or COLORS.track)
		surface.DrawRect(x + (index - 1) * (segmentWidth + gap), y, segmentWidth, height)
	end
end

local function itemConditions(item)
	if not item then return end
	if item.isPoachKnife and ix.poaching then return ix.poaching.GetSharpness(item) end
	local durability = item:GetData("durability")
	local wear = item:GetData("wear")
	if item.isWeapon and item.class then
		local weapon = LocalPlayer():GetWeapon(item.class)
		if IsValid(weapon) then
			if weapon.GetWeaponDurability then durability = weapon:GetWeaponDurability() end
			if wear ~= nil and weapon.GetWeaponWear then wear = weapon:GetWeaponWear() end
		end
	end

	return durability or wear, durability ~= nil and wear or nil
end

local function paintCard(card, width, height)
	surface.SetDrawColor(COLORS.card)
	surface.DrawRect(0, 0, width, height)
	local hovered = card:IsHovered() or (IsValid(card.icon) and card.icon:IsHovered())
	surface.SetDrawColor(hovered and COLORS.hover or COLORS.border)
	surface.DrawOutlinedRect(0, 0, width, height)
	local item = card.item
	if item and (item.isGeiger or item.isAnomalydetector) then
		local size = math.max(5, math.floor((card.scale or 1) * 7))
		local padding = card.padding or 6
		surface.SetDrawColor(item:GetData("powered", true) and COLORS.green or COLORS.red)
		surface.DrawRect(width - padding - size, height - padding - size, size, size)
	end
	local condition, wear = itemConditions(card.item)
	if not condition then return end
	local padding = card.padding or 6
	local barHeight = math.max(3, math.floor(card.scale * 4))
	local barY = height - padding - barHeight
	local conditionColor
	if card.item.isPoachKnife and ix.poaching and condition > ix.poaching.Sharpness.default then
		conditionColor = COLORS.teal
	end
	drawSegments(padding, barY, width - padding * 2, barHeight,
		math.Clamp(condition / 100, 0, 1), conditionColor)
	if wear ~= nil then
		barY = barY - barHeight - math.max(2, math.floor(card.scale * 3))
		drawSegments(padding, barY, width - padding * 2, barHeight, math.Clamp(wear / 100, 0, 1))
	end
end

local function paintHeader(_, width)
	surface.SetDrawColor(COLORS.border)
	surface.DrawLine(0, 0, width, 0)
end

local function setBounds(panel, bounds)
	panel:SetPos(math.floor(bounds.x), math.floor(bounds.y))
	panel:SetSize(math.floor(bounds.w), math.floor(bounds.h))
end

function PLUGIN:CreateEquipmentFonts()
	local scale = math.Clamp(math.min(ScrW() / 1920, ScrH() / 1080), 0.75, 2)
	self.uiScale = scale
	if self.fontScale == scale then return end
	self.fontScale = scale

	for name, size in pairs({Title = 25, Label = 19, Small = 17}) do
		surface.CreateFont("cotzEquipment" .. name, {
			font = "alsina", size = math.floor(size * scale), weight = 500, extended = true,
		})
	end
end

PLUGIN:CreateEquipmentFonts()

function PANEL:Init()
	self.cards = {}
	self.headers = {}
	self.statistics = {}
	self.title = self:Add("DButton")
	self.title.DoClick = function() self:OpenHotkeys() end
	self.title:SetTooltip("Configure item hotkeys")
	self.title:Dock(TOP)
	self.title:SetText("EQUIPMENT  /  HOTKEYS")
	self.title:SetTextColor(COLORS.text)
	self.footer = self:Add("DPanel")
	self.footer:Dock(BOTTOM)
	self.footerTitle = self.footer:Add("DLabel")
	self.footerTitle:SetText("PROTECTION")
	self.footerTitle:SetTextColor(COLORS.text)
	self.footer.Paint = paintHeader

	for index, definition in ipairs(PROTECTION) do
		local statistic = self.footer:Add("DPanel")
		statistic.name = definition.name
		statistic.fraction = 0
		statistic.Paint = function(this, width, height)
			draw.SimpleText(this.name, "cotzEquipmentSmall", 0, 0, COLORS.text)
			draw.SimpleText(this.value or "--", "cotzEquipmentSmall", width, 0, COLORS.text, TEXT_ALIGN_RIGHT)
			drawSegments(0, height - math.max(4, PLUGIN.uiScale * 5), width,
				math.max(4, PLUGIN.uiScale * 5), this.fraction)
		end
		self.statistics[index] = statistic
	end

	self.scroll = self:Add("DScrollPanel")
	self.scroll:Dock(FILL)
	self.content = self.scroll:Add("DPanel")
	self.content:Dock(TOP)
	self.content.Paint = function() end
end

function PANEL:Paint(width, height)
	surface.SetDrawColor(COLORS.background)
	surface.DrawRect(0, 0, width, height)
end

function PANEL:AddEquipmentIcon(card, item, index)
	local button = card:Add("DButton")
	button:SetText("×")
	button:SetTooltip("Unequip (requires backpack space)")
	button.DoClick = function() PLUGIN:SendEquipmentAction(item, index, false) end
	card.unequip = button
	local icon = card:Add("ixItemIcon")
	icon.Icon:SetVisible(false)
	-- Slot cards own the condition bars and already identify equipped items.
	icon.PaintOver = function() end
	icon.ExtraPaint = function(_, width, height)
		local inventoryGrid = self.inventoryPanel.cotzEquipmentInventoryGrid
		if not IsValid(inventoryGrid) then return end
		local material = ix.util.GetItemIcon(item)
		if not material then return end
		local scale = math.min(inventoryGrid:GetIconSize(), width / item.width, height / item.height)
		local iconWidth, iconHeight = item.width * scale, item.height * scale
		surface.SetMaterial(material)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect((width - iconWidth) / 2, (height - iconHeight) / 2, iconWidth, iconHeight)
	end
	icon:SetInventoryID(self.inventoryID)
	icon:SetItemTable(item)
	icon.gridW = item.width
	icon.gridH = item.height
	icon:SetHelixTooltip(function(tooltip) ix.hud.PopulateItemTooltip(tooltip, item) end)
	-- Keep the draggable image compact while allowing presses anywhere on its owning card.
	icon.Paint = icon.ExtraPaint
	local onMouseReleased = icon.OnMouseReleased
	icon.OnMouseReleased = function(this, code)
		local dragging = dragndrop.IsDragging()
		onMouseReleased(this, code)
		if code == MOUSE_LEFT and not dragging then self:ChooseSlotItem(index) end
	end
	card.OnMousePressed = function(_, code) icon:OnMousePressed(code) end
	card.OnMouseReleased = function(_, code) icon:OnMouseReleased(code) end
	icon.OnDrop = function(_, dropped, target, inventory, x, y)
		if dropped and inventory and inventory:GetID() == self.inventoryID and x and y then
			PLUGIN:SendEquipmentAction(item, index, false, x, y)
		end
	end
	card.icon = icon
end

function PANEL:ChooseSlotItem(index)
	local character = LocalPlayer():GetCharacter()
	local inventory = character and character:GetInventory()
	if not inventory then return end
	local menu = DermaMenu()
	local count = 0
	for _, item in pairs(inventory:GetItems(true)) do
		if not item:GetData("equip") and not PLUGIN:IsEquipmentCell(item.gridX) then
			for _, slotIndex in ipairs(PLUGIN:GetItemSlots(item)) do
				if slotIndex == index and item.functions.Equip then
					local candidate = item
					menu:AddOption(item:GetName(), function()
						PLUGIN:SendEquipmentAction(candidate, index, true)
					end)
					count = count + 1
				end
			end
		end
	end
	if count == 0 then menu:AddOption("No matching items in your backpack"):SetEnabled(false) end
	menu:Open()
end

function PANEL:OpenHotkeys()
	local hotkeys = ix.plugin.Get("itemhotkeys")
	local character = LocalPlayer():GetCharacter()
	if not hotkeys or not character then return end
	local bindings = {"gm_showhelp", "gm_showteam", "gm_showspare1", "gm_showspare2"}
	local menu = DermaMenu()
	for index, binding in ipairs(bindings) do
		local hotkeyIndex = index
		local key = string.upper(input.LookupBinding(binding, true) or "Unbound")
		local selected = character:GetHotkeyItemName(index)
		local choices = menu:AddSubMenu("Hotkey " .. index .. " (" .. key .. ")")
		choices:AddOption("None", function()
			ix.option.Set("Hotkey" .. hotkeyIndex, "nil")
		end):SetChecked(not selected or selected == "nil")
		for uniqueID in SortedPairs(hotkeys.hotkeyitems) do
			local item = character:GetInventory():HasItem(uniqueID)
			if item then
				local itemID = uniqueID
				choices:AddOption(item:GetName(), function()
					ix.option.Set("Hotkey" .. hotkeyIndex, itemID)
				end):SetChecked(selected == itemID)
			end
		end
	end
	menu:Open()
end

function PANEL:Rebuild(inventory)
	self.inventoryID = inventory:GetID()
	self.content:Clear()
	self.headers = {}
	self.cards = {}
	local occupied = PLUGIN:GetSlotItems(inventory)

	for index, group in ipairs(PLUGIN.uiGroups) do
		local header = self.content:Add("DLabel")
		header:SetText(group.name)
		header:SetTextColor(COLORS.text)
		header.Paint = paintHeader
		self.headers[index] = header
	end

	for index, slot in ipairs(PLUGIN.slots) do
		local card = self.content:Add("DButton")
		card:SetText("")
		card.DoClick = function() self:ChooseSlotItem(index) end
		card.item = occupied[index]
		card.Paint = paintCard
		card:Receiver("ixInventoryItem", function(_, panels, dropped)
			local icon = panels[1]
			if not dropped or not IsValid(icon) then return end
			local item = icon:GetItemTable()
			if item then PLUGIN:SendEquipmentAction(item, index, true) end
		end)
		card.label = card:Add("DLabel")
		card.label:SetText(card.item and card.item.isPDA and "PDA - RETURN TO BACKPACK" or string.upper(slot.name))
		card.label:SetTextColor(COLORS.text)
		card.label:SetWrap(true)
		card.label:SetMouseInputEnabled(false)
		if card.item then
			self:AddEquipmentIcon(card, card.item, index)
		end
		self.cards[index] = card
	end

	self:UpdateProtection()
	self:InvalidateLayout(true)
end

function PANEL:PerformLayout(width, height)
	local scale = PLUGIN.uiScale
	local padding = math.max(4, math.floor(8 * scale))
	self:DockPadding(padding, padding, padding, padding)
	self.title:SetFont("cotzEquipmentTitle")
	self.title:SetTall(math.floor(34 * scale))
	local innerWidth = math.max(1, width - padding * 2 - self.scroll:GetVBar():GetWide())
	local layout = PLUGIN:GetEquipmentLayout(innerWidth, height - padding * 2 - self.title:GetTall(), scale)
	self.footer:SetTall(layout.footerHeight)
	self.footerTitle:SetPos(0, 0)
	self.footerTitle:SetSize(innerWidth, math.floor(24 * scale))
	self.footerTitle:SetFont("cotzEquipmentLabel")
	self.content:SetTall(layout.contentHeight)

	for index, bounds in ipairs(layout.groups) do
		local header = self.headers[index]
		if IsValid(header) then setBounds(header, bounds) header:SetFont("cotzEquipmentLabel") end
	end
	for index, bounds in pairs(layout.cards) do
		if IsValid(self.cards[index]) then self:LayoutCard(self.cards[index], bounds, scale, padding) end
	end
	for index, bounds in ipairs(layout.footer) do setBounds(self.statistics[index], bounds) end
end

function PANEL:LayoutCard(card, bounds, scale, padding)
	setBounds(card, bounds)
	card.padding = padding
	card.scale = scale
	local headerHeight = math.floor(34 * scale)
	local buttonSize = math.floor(20 * scale)
	card.label:SetFont("cotzEquipmentSmall")
	card.label:SetPos(padding, padding)
	card.label:SetSize(bounds.w - padding * 2 - (card.item and buttonSize or 0), headerHeight)
	local iconHeight = math.max(1, bounds.h - headerHeight - padding * 3)

	if IsValid(card.icon) then
		local item = card.item
		local grid = self.inventoryPanel.cotzEquipmentInventoryGrid
		local size = math.min(grid:GetIconSize(), (bounds.w - padding * 2) / item.width, iconHeight / item.height)
		local iconWidth, iconHeight = item.width * size, item.height * size
		card.icon:SetPos((bounds.w - iconWidth) / 2, headerHeight)
		card.icon:SetSize(iconWidth, iconHeight)
		card.unequip:SetFont("cotzEquipmentSmall")
		card.unequip:SetPos(bounds.w - buttonSize - padding, padding)
		card.unequip:SetSize(buttonSize, buttonSize)
	end
end

function PANEL:UpdateProtection()
	local client = LocalPlayer()

	for index, definition in ipairs(PROTECTION) do
		local multiplier, flat
		if definition.radiation then
			if client.getPercentageRadResist then multiplier = client:getPercentageRadResist() end
			if client.getFlatRadResist then flat = client:getFlatRadResist() end
		else
			multiplier = client:GetNWFloat(definition.multiplier, 1)
			flat = client:GetNWInt(definition.flat, 0)
		end
		local statistic = self.statistics[index]
		statistic.fraction = multiplier and math.Clamp(1 - multiplier, 0, 1) or 0
		statistic.value = multiplier and math.Round((1 - multiplier) * 100) .. "%" or "--"
		statistic:SetTooltip(definition.name .. ": " .. statistic.value .. " reduction after "
			.. tostring(math.Round(flat or 0, 2)) .. " flat protection. Percentage and flat absorption are separate.")
	end
end

function PANEL:Think()
	if not IsValid(self.inventoryPanel) then self:Remove() return end
	local character = LocalPlayer():GetCharacter()
	local inventory = character and character:GetInventory()
	if not inventory or inventory:GetID() ~= self.inventoryID then self:Remove() return end
	if not self:IsVisible() then return end
	local parent = self:GetParent()
	local x, y = self.inventoryPanel:GetPos()
	if self.pageWidth ~= parent:GetWide() or self.pageHeight ~= parent:GetTall()
		or self.backpackWidth ~= self.inventoryPanel:GetWide()
		or (self.companion and (self.backpackX ~= x or self.backpackY ~= y)) then
		self:UpdatePageLayout()
	end
	if (self.nextProtectionUpdate or 0) > RealTime() then return end
	self.nextProtectionUpdate = RealTime() + 0.25
	self:UpdateProtection()
end

function PANEL:UpdatePageLayout()
	local page = self:GetParent()
	local inventoryPanel = self.inventoryPanel
	if not IsValid(page) or not IsValid(inventoryPanel) then return end
	self.pageWidth = page:GetWide()
	self.pageHeight = page:GetTall()
	self.backpackWidth = inventoryPanel:GetWide()
	if self.companion then
		self:LayoutCompanion()
		self.backpackX, self.backpackY = inventoryPanel:GetPos()
		return
	end
	local gap = math.floor(ScrW() * 0.008)
	local availableWidth = math.max(0, page:GetWide() - inventoryPanel:GetWide() - gap * 2)
	local equipmentWidth = self.hasJournal and availableWidth * 0.72 or availableWidth
	self:SetWide(math.floor(equipmentWidth))
	self:DockMargin(gap, 0, gap, 0)
end

function PANEL:LayoutCompanion()
	local parent = self:GetParent()
	local inventory = self.inventoryPanel
	local storage = parent.storageInventory
	local gap = math.max(4, math.floor(parent:GetWide() * 0.008))
	if IsValid(storage) and storage.gridW and storage.gridH then
		local originalSize = storage.cotzEquipmentIconSize or storage:GetIconSize()
		storage.cotzEquipmentIconSize = originalSize
		local availableHeight = parent:GetTall() - gap * 2 - storage:GetPadding(2) - storage:GetPadding(4)
		local iconSize = math.max(1, math.min(originalSize,
			(parent:GetWide() * 0.30 - 8) / storage.gridW, availableHeight / storage.gridH))
		if math.abs(iconSize - storage:GetIconSize()) > 0.01 then
			storage:SetIconSize(iconSize)
			PLUGIN:RefreshInventoryPanel(storage, ix.item.inventories[storage.invID])
		end
		local bounds = PLUGIN:GetStorageEquipmentBounds(parent:GetWide(), parent:GetTall(),
			inventory:GetWide(), inventory:GetTall(), storage:GetWide(), storage:GetTall())
		inventory:SetPos(bounds.inventory.x, bounds.inventory.y)
		storage:SetPos(bounds.storage.x, bounds.storage.y)
		setBounds(self, bounds.equipment)
		return
	end
	local x, y = inventory:GetPos()
	local rightSpace = parent:GetWide() - x - inventory:GetWide() - gap * 2
	local leftSpace = x - gap * 2
	local width = math.min(parent:GetWide() * 0.48, math.max(leftSpace, rightSpace))
	local height = math.min(inventory:GetTall(), parent:GetTall() - gap * 2)
	local equipmentX = rightSpace > leftSpace and x + inventory:GetWide() + gap or x - width - gap
	self:SetPos(math.max(gap, equipmentX), math.max(gap, math.min(y, parent:GetTall() - height - gap)))
	self:SetSize(math.max(1, width), math.max(1, height))
end

vgui.Register("ixEquipmentSlots", PANEL, "EditablePanel")

function PLUGIN:InstallInventoryPanels()
	if self.panelOriginals then return end
	local panel = vgui.GetControlTable("ixInventory")
	local originals = {AddIcon = panel.AddIcon}
	self.panelOriginals = originals

	function panel:AddIcon(model, x, y, width, height, skin)
		local inventory = ix.item.inventories[self.invID]
		if inventory and inventory.vars.cotzEquipmentWidth and PLUGIN:IsEquipmentCell(x) then return end

		return originals.AddIcon(self, model, x, y, width, height, skin)
	end
	local inventoryPanel = vgui.GetControlTable("ixStalkerInventoryPanel")
	originals.InventoryInit = inventoryPanel.Init
	originals.InventoryOnRemove = inventoryPanel.OnRemove
	function inventoryPanel:Init()
		originals.InventoryInit(self)
		self.cotzEquipmentInventoryGrid = ix.gui.inv1
		-- Wait until the caller has assigned docking, popup state, and storage contents.
		timer.Simple(0, function()
			if IsValid(self) then PLUGIN:AttachInventoryEquipment(self) end
		end)
	end
	function inventoryPanel:OnRemove()
		if IsValid(self.cotzEquipmentPanel) then self.cotzEquipmentPanel:Remove() end
		if originals.InventoryOnRemove then originals.InventoryOnRemove(self) end
	end
	local storage = vgui.GetControlTable("ixStorageView")
	originals.StorageOnRemove = storage.OnRemove
	function storage:OnRemove()
		local host = self.cotzEquipmentHost
		self.cotzEquipmentHost = nil
		if originals.StorageOnRemove then originals.StorageOnRemove(self) end
		if IsValid(host) then host:Remove() end
	end
end

function PLUGIN:RefreshInventoryPanel(panel, inventory)
	for _, icon in pairs(panel.panels or {}) do
		if IsValid(icon) then icon:Remove() end
	end
	panel.panels = {}
	panel:SetInventory(inventory)
end

function PLUGIN:MenuSubpanelCreated(name, page)
	if name ~= "you" then return end
	local inventoryPanel = ix.gui.menuInventoryFrame
	if not IsValid(inventoryPanel) or inventoryPanel:GetParent() ~= page then return end
	self:AttachInventoryEquipment(inventoryPanel)
end

function PLUGIN:AttachInventoryEquipment(inventoryPanel)
	if IsValid(inventoryPanel.cotzEquipmentPanel) then return inventoryPanel.cotzEquipmentPanel end
	local page = inventoryPanel:GetParent()
	if not IsValid(page) then return end
	local character = LocalPlayer():GetCharacter()
	local inventory = character and character:GetInventory()
	if not inventory or not inventory.vars.cotzEquipmentWidth then return end
	local inMenu = page.subpanelName == "you"
	if not inMenu then return end
	-- Dock the inventory first, equipment second, and the existing journal into the remaining space.
	local journalPanel
	for _, child in ipairs(page:GetChildren()) do
		-- On initial menu creation the removed subpanel title can still be in this child list.
		if IsValid(child) and child:GetName() == "ixCharacterJournalPanel" then journalPanel = child end
	end
	if inMenu then
		inventoryPanel:SetZPos(0)
		if IsValid(journalPanel) then journalPanel:SetZPos(2) end
	end
	local equipment = page:Add("ixEquipmentSlots")
	equipment.inventoryPanel = inventoryPanel
	equipment.hasJournal = IsValid(journalPanel)
	equipment.companion = not inMenu
	if inMenu then equipment:SetZPos(1) equipment:Dock(RIGHT) end
	equipment:UpdatePageLayout()
	equipment:Rebuild(inventory)
	inventoryPanel.cotzEquipmentPanel = equipment
	self.equipmentViews[equipment] = true
	self.equipmentPanel = equipment
	if not inMenu then self:RaiseInventoryEquipment(inventoryPanel, equipment) end

	return equipment
end

function PLUGIN:RaiseInventoryEquipment(inventoryPanel, equipment)
	local parent = inventoryPanel:GetParent()
	if IsValid(parent.storageInventory) then
		local host = parent.cotzEquipmentHost
		if not IsValid(host) then
			-- ixStorageView derives from Panel and paints children manually. Give it an EditablePanel popup host.
			host = vgui.Create("EditablePanel")
			host:SetSize(ScrW(), ScrH())
			host:SetPos(0, 0)
			parent:SetParent(host)
			parent:SetPos(0, 0)
			parent.cotzEquipmentHost = host
		end
		host:MakePopup()
		host:MoveToFront()
		equipment:SetPaintedManually(true)
	else
		equipment:MakePopup()
		equipment:SetKeyboardInputEnabled(false)
		inventoryPanel:MoveToFront()
	end
end

function PLUGIN:OnScreenSizeChanged()
	self:CreateEquipmentFonts()
	local character = LocalPlayer():GetCharacter()
	local inventory = character and character:GetInventory()
	if not inventory then return end
	for panel in pairs(self.equipmentViews) do
		if IsValid(panel) then
			local parent = panel:GetParent()
			if IsValid(parent.cotzEquipmentHost) then
				parent.cotzEquipmentHost:SetSize(ScrW(), ScrH())
				parent:SetSize(ScrW(), ScrH())
			end
			panel:UpdatePageLayout()
			panel:Rebuild(inventory)
			parent:InvalidateLayout(true)
		end
	end
end

net.Receive("cotz/equipment/refresh", function()
	local id = net.ReadUInt(32)
	local inventory = ix.item.inventories[id]
	local character = LocalPlayer():GetCharacter()
	local backpack = character and character:GetInventory()
	if not inventory or not backpack then return end
	local panel = id == backpack:GetID() and ix.gui.inv1 or ix.gui["inv" .. id]
	if IsValid(panel) then PLUGIN:RefreshInventoryPanel(panel, inventory) end
	for equipment in pairs(PLUGIN.equipmentViews) do
		if IsValid(equipment) and equipment.inventoryID == id then
			local grid = equipment.inventoryPanel.cotzEquipmentInventoryGrid
			if IsValid(grid) and grid ~= panel then PLUGIN:RefreshInventoryPanel(grid, inventory) end
			equipment:Rebuild(inventory)
		end
	end
end)
