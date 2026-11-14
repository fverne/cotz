local PANEL = {}

AccessorFunc(PANEL, "bReadOnly", "ReadOnly", FORCE_BOOL)

local function addToolbar(parent, dock)
	local toolbar = parent:Add("DPanel")
	toolbar:Dock(dock)
	toolbar:SetPaintBackground(false)
	toolbar.PerformLayout = function(control, width)
		local gap, height = ix.cotzUI.Scale(6), ix.cotzUI.Scale(34)
		local x, y = 0, 0
		surface.SetFont("cotzUISmall")
		for _, child in ipairs(control:GetChildren()) do
			if child:IsVisible() then
				local textWidth = surface.GetTextSize(child:GetText())
				local childWidth = math.min(width, textWidth + ix.cotzUI.Scale(24))
				if x > 0 and x + childWidth > width then x, y = 0, y + height + gap end
				child:SetFont("cotzUISmall")
				child:SetPos(x, y)
				child:SetSize(childWidth, height)
				x = x + childWidth + gap
			end
		end
		local tall = x > 0 and y + height + gap or 0
		if control:GetTall() ~= tall then control:SetTall(tall) end
	end

	return toolbar
end

local function addTool(parent, text, callback)
	local button = ix.cotzUI.StyleButton(parent:Add("DButton"))
	button:SetText(text)
	button.DoClick = callback
	local paint = button.Paint
	button.Paint = function(control, width, height)
		paint(control, width, height)
		if control.tradeActive then
			surface.SetDrawColor(ix.cotzUI.colors.teal)
			surface.DrawOutlinedRect(0, 0, width, height)
		end
	end

	return button
end

local function describeItem(item)
	local description = item:GetDescription()
	if item.id then
		for _, key in ipairs({"quantity", "durability", "condition"}) do
			local value = item:GetData(key)
			if isnumber(value) then description = description .. "\n" .. key .. ": " .. value end
		end
	end

	return description
end

function PANEL:Init()
	ix.cotzUI.StyleFrame(self)
	self:SetTitle("Trade")
	self:SetSizable(false)
	self:MakePopup()
	self.sellingList, self.buyingList = {}, {}
	self.tab = "selling"
	self.character = LocalPlayer():GetCharacter()

	self.header = self:Add("DPanel")
	self.header:Dock(TOP)
	self.header:SetPaintBackground(false)
	self.vendorName = ix.cotzUI.Label(self.header, "Vendor", true)
	self.vendorName:SetTextColor(ix.cotzUI.colors.text)
	self.ourName = ix.cotzUI.Label(self.header, "")

	self.footer = self:Add("DPanel")
	self.footer:Dock(BOTTOM)
	self.footer:SetPaintBackground(false)
	self.summary = ix.cotzUI.Label(self.footer, "")
	self.summary:SetTextColor(ix.cotzUI.colors.text)
	self.footer.PerformLayout = function(control)
		control:SizeToChildren(false, true)
	end
	self.pageTools = addToolbar(self.footer, TOP)
	self.managementTools = addToolbar(self.footer, TOP)

	self.tabs = addToolbar(self, TOP)
	self.stockTab = addTool(self.tabs, "Buy", function() self:SetTab("selling") end)
	self.personalTab = addTool(self.tabs, "Sell", function() self:SetTab("buying") end)

	self.body = self:Add("DPanel")
	self.body:Dock(FILL)
	self.body:SetPaintBackground(false)
	self.listPane = self.body:Add("DPanel")
	self.listPane:SetPaintBackground(false)
	self.selling = self.listPane:Add("DScrollPanel")
	self.selling:Dock(FILL)
	ix.cotzUI.StyleScroll(self.selling)
	self.buying = self.listPane:Add("DScrollPanel")
	self.buying:Dock(FILL)
	ix.cotzUI.StyleScroll(self.buying)
	self.sellingItems = self.selling:Add("DListLayout")
	self.sellingItems:Dock(TOP)
	self.buyingItems = self.buying:Add("DListLayout")
	self.buyingItems:Dock(TOP)
	self.empty = ix.cotzUI.Label(self.listPane, "No items available.")
	self.empty:SetZPos(0)
	self.selling:SetZPos(1)
	self.buying:SetZPos(2)

	self.inspector = self.body:Add("DPanel")
	self.inspector.Paint = ix.cotzUI.PaintCard
	self.inspectorActions = addToolbar(self.inspector, BOTTOM)
	self.vendorSell = addTool(self.inspectorActions, "Purchase", function() self:TradeSelected(false) end)
	self.vendorBuy = addTool(self.inspectorActions, "Sell", function() self:TradeSelected(true) end)
	self.detailScroll = self.inspector:Add("DScrollPanel")
	self.detailScroll:Dock(FILL)
	ix.cotzUI.StyleScroll(self.detailScroll)
	self.preview = self.detailScroll:Add("DImage")
	self.preview:Dock(TOP)
	self.preview:SetKeepAspect(true)
	self.detailName = ix.cotzUI.Label(self.detailScroll, "Select an item", true)
	self.detailName:SetTextColor(ix.cotzUI.colors.text)
	self.detailPrice = ix.cotzUI.Label(self.detailScroll, "")
	self.detailStock = ix.cotzUI.Label(self.detailScroll, "")
	self.detailDescription = ix.cotzUI.Label(self.detailScroll, "")
	self.detailDescription:SetTextColor(ix.cotzUI.colors.text)

	self.body.PerformLayout = function(_, width, height)
		local gap = ix.cotzUI.Scale(12)
		local stacked = width < ix.cotzUI.Scale(420)
		local listWidth = stacked and width or math.floor((width - gap) * 0.53)
		local listHeight = stacked and math.floor((height - gap) * 0.42) or height
		self.listPane:SetPos(0, 0)
		self.listPane:SetSize(listWidth, listHeight)
		self.inspector:SetPos(stacked and 0 or listWidth + gap, stacked and listHeight + gap or 0)
		self.inspector:SetSize(stacked and width or width - listWidth - gap,
			stacked and height - listHeight - gap or height)
		self.inspector:DockPadding(gap, gap, gap, gap)
		self.preview:SetTall(math.min(ix.cotzUI.Scale(100), height * 0.2))
	end
	self.header.PerformLayout = function(control) control:SizeToChildren(false, true) end
	self:PostLayoutUpdate()
	self:SetTab("selling")
	if ix.dialogue and ix.dialogue.TrackRelatedPanel and IsValid(ix.gui.dialogue) then
		ix.dialogue.TrackRelatedPanel(self)
	end
end

function PANEL:PostLayoutUpdate()
	self.screenWidth, self.screenHeight = ScrW(), ScrH()
	self.uiScale = ix.cotzUI.GetScale()
	self:SetSize(math.min(ScrW() * 0.88, ix.cotzUI.Scale(1180)), ScrH() * 0.88)
	self.preview:SetTall(ix.cotzUI.Scale(100))
	self:Center()
	self:InvalidateLayout(true)
	self:InvalidateChildren(true)
end

function PANEL:SetTab(tab)
	if tab == "buying" and not self.personalTab:IsVisible() then tab = "selling" end
	self.tab = tab
	self.selling:SetVisible(tab == "selling")
	self.buying:SetVisible(tab == "buying")
	self.stockTab:SetTextColor(tab == "selling" and ix.cotzUI.colors.teal or ix.cotzUI.colors.text)
	self.personalTab:SetTextColor(tab == "buying" and ix.cotzUI.colors.teal or ix.cotzUI.colors.text)
	self.stockTab.tradeActive, self.personalTab.tradeActive = tab == "selling", tab == "buying"
	if tab == "selling" then self.selected = self.activeSell else self.selected = self.activeBuy end
	self:RefreshInspector()
end

function PANEL:AddInspectorTool(text, callback)
	return addTool(self.inspectorActions, text, callback)
end

function PANEL:AddPageTool(text, callback)
	return addTool(self.pageTools, text, callback)
end

function PANEL:AddManagementTool(text, callback)
	return addTool(self.managementTools, text, callback)
end

function PANEL:AddTradeRow(parent, data)
	local row = parent:Add("ixVendorAdvItem")
	row:SetupData(self, data)

	return row
end

function PANEL:addItem(uniqueID, listID, iteminstanceID)
	local definition = ix.item.list[uniqueID]
	if not definition or not IsValid(self.entity) then return end
	local data = self.entity.items[uniqueID]
	if not listID or listID == "selling" then
		local allowed = data and data[VENDOR_MODE] and data[VENDOR_MODE] ~= VENDOR_BUYONLY
		if allowed and not IsValid(self.sellingList[uniqueID]) then
			self.sellingList[uniqueID] = self:AddTradeRow(self.sellingItems,
				{key = uniqueID, uniqueID = uniqueID, item = definition, personal = false})
		end
	end
	if not listID or listID == "buying" then
		-- Editor callbacks may only supply an item definition; discover the actual owned instances.
		if not iteminstanceID or iteminstanceID == 0 then
			self:SyncPersonalItems()
			return
		end
		local item = ix.item.instances[iteminstanceID]
		local allowed = data and data[VENDOR_MODE] and data[VENDOR_MODE] ~= VENDOR_SELLONLY
		if item and not item.noDrop and not item.isFieldCargo and not item:GetData("equip", false)
			and (allowed or self.entity:GetBuyAll()) and not IsValid(self.buyingList[iteminstanceID]) then
			self.buyingList[iteminstanceID] = self:AddTradeRow(self.buyingItems,
				{key = iteminstanceID, uniqueID = uniqueID, item = item, personal = true})
		end
	end
end

function PANEL:removeItem(uniqueID, listID, iteminstanceID)
	if not listID or listID == "selling" then
		if IsValid(self.sellingList[uniqueID]) then self.sellingList[uniqueID]:Remove() end
		self.sellingList[uniqueID] = nil
	end
	if not listID or listID == "buying" then
		for id, row in pairs(self.buyingList) do
			if id == iteminstanceID or (not iteminstanceID and row.item == uniqueID) then
				if IsValid(row) then row:Remove() end
				self.buyingList[id] = nil
			end
		end
	end
	self:RefreshInspector()
end

function PANEL:SyncPersonalItems()
	local items = self.character:GetInventory():GetItems()
	for id, row in pairs(self.buyingList) do
		local item = items[id]
		local data = item and self.entity.items[item.uniqueID]
		local allowed = data and data[VENDOR_MODE] and data[VENDOR_MODE] ~= VENDOR_SELLONLY
		if not item or item.noDrop or item.isFieldCargo or item:GetData("equip", false)
			or not (allowed or self.entity:GetBuyAll()) then
			row:Remove()
			self.buyingList[id] = nil
		end
	end
	for _, item in pairs(items) do self:addItem(item.uniqueID, "buying", item:GetID()) end
	for _, row in pairs(self.buyingList) do row:RefreshData() end
end

function PANEL:Setup(entity)
	if not self.character then self:Remove() return end
	self.entity = entity
	self.vendorName:SetText(entity:GetDisplayName())
	for uniqueID in SortedPairs(entity.items) do self:addItem(uniqueID, "selling") end
	self:SyncPersonalItems()
	self.summary:SetText(self:GetReadOnly() and "Vendor editor preview · Trading disabled" or "NPC catalogue")
	self:RefreshInspector()
end

function PANEL:OnItemSelected(row)
	self.selected = row
	if row.isLocal then self.activeBuy = row else self.activeSell = row end
	self:RefreshInspector()
end

function PANEL:RefreshInspector()
	local row = self.selected
	if not IsValid(row) then
		self.selected = nil
		self.preview:SetVisible(false)
		self.detailName:SetText("Select an item")
		self.detailDescription:SetText("")
		self.detailPrice:SetText("")
		self.detailStock:SetText("")
	else
		row:RefreshData()
		self.preview:SetVisible(true)
		self.preview:SetMaterial(row.iconMaterial)
		self.detailName:SetText(row.data.name)
		self.detailDescription:SetText(row.data.description)
		self.detailPrice:SetText((row.isLocal and (self.isInstanceVendor and "Donation: no payment" or "Sale price: ")
			or "Purchase price: ") .. (row.isLocal and self.isInstanceVendor and "" or ix.currency.Get(row.data.price)))
		self.detailStock:SetText(row.stock:GetText())
	end
	local personal = self.tab == "buying"
	self.vendorSell:SetVisible(not personal)
	self.vendorBuy:SetVisible(personal)
	local ready = IsValid(row) and not self:GetReadOnly()
	local price = ready and row.data.price or 0
	self.vendorSell:SetEnabled(ready and not personal and (not self.isInstanceVendor or price > 0)
		and self.character:HasMoney(price) and (not row.data.stock or row.data.stock > 0))
	self.vendorBuy:SetEnabled(ready and personal)
	self.empty:SetVisible(not next(personal and self.buyingList or self.sellingList))
	self.inspectorActions:InvalidateLayout(true)
end

function PANEL:TradeSelected(personal)
	local row = self.selected
	if not IsValid(row) or row.isLocal ~= personal or self:GetReadOnly() then return end
	if (self.nextRequest or 0) > CurTime() then return end
	self.nextRequest = CurTime() + 0.5
	net.Start("ixVendorAdvTrade")
	net.WriteString(row.item)
	net.WriteUInt(personal and row.iteminstanceID or 0, 32)
	net.WriteBool(personal)
	net.SendToServer()
	-- Stock broadcasts and inventory synchronization confirm changes, including rejected trades.
end

function PANEL:UpdateTrade()
	if not self.character or not IsValid(self.entity) or LocalPlayer():GetCharacter() ~= self.character then
		self:Remove()
		return false
	end
	vgui.GetControlTable("DFrame").Think(self)
	if self.screenWidth ~= ScrW() or self.screenHeight ~= ScrH() or self.uiScale ~= ix.cotzUI.GetScale() then
		self:PostLayoutUpdate()
	end
	if (self.nextUpdate or 0) > CurTime() then return false end
	self.nextUpdate = CurTime() + 0.25
	self.vendorName:SetText(self.entity:GetDisplayName())
	self.ourName:SetText("Your wallet: " .. ix.currency.Get(self.character:GetMoney()))

	return true
end

function PANEL:OnRemove()
	net.Start("ixVendorAdvClose")
	net.SendToServer()
	if IsValid(ix.gui.vendorEditor) then ix.gui.vendorEditor:Remove() end
	if ix.gui.vendor == self then
		ix.gui.vendor = nil
		if IsValid(ix.gui.dialogue) and not ix.gui.dialogue.exiting then ix.gui.dialogue:RequestFocus() end
	end
end

function PANEL:Think()
	if not self:UpdateTrade() then return end
	self:SyncPersonalItems()
	for uniqueID in SortedPairs(self.entity.items) do self:addItem(uniqueID, "selling") end
	for uniqueID, row in pairs(self.sellingList) do
		local data = self.entity.items[uniqueID]
		if not IsValid(row) or not data or not data[VENDOR_MODE] or data[VENDOR_MODE] == VENDOR_BUYONLY then
			if IsValid(row) then row:Remove() end
			self.sellingList[uniqueID] = nil
		else
			row:RefreshData()
		end
	end
	self:RefreshInspector()
end

vgui.Register("ixVendorAdv", PANEL, "DFrame")

PANEL = {}

function PANEL:Init()
	self:SetText("")
	self:DockMargin(0, 0, ix.cotzUI.Scale(6), ix.cotzUI.Scale(6))
	self.icon = self:Add("DImage")
	self.icon:SetKeepAspect(true)
	self.name = ix.cotzUI.Label(self, "", true)
	self.name:Dock(NODOCK)
	self.name:SetTextColor(ix.cotzUI.colors.text)
	self.stock = ix.cotzUI.Label(self, "")
	self.stock:Dock(NODOCK)
	self.price = ix.cotzUI.Label(self, "")
	self.price:Dock(NODOCK)
	for _, label in ipairs({self.name, self.stock, self.price}) do label:SetMouseInputEnabled(false) end
	self.icon:SetMouseInputEnabled(false)
	self.DoClick = function() self.owner:OnItemSelected(self) end
	self.click = self
end

function PANEL:SetupData(owner, data)
	self.owner, self.data = owner, data
	self.item, self.iteminstanceID, self.isLocal = data.uniqueID, data.personal and data.key or 0, data.personal
	self.iconMaterial = ix.util.GetItemIcon(data.item)
	self.icon:SetMaterial(self.iconMaterial)
	self:RefreshData()
	self:SetHelixTooltip(function(tooltip)
		if owner.isInstanceVendor and not self.isLocal then
			local name = tooltip:AddRow("name")
			name:SetText(self.data.name)
			name:SizeToContents()
			local description = tooltip:AddRow("description")
			description:SetText(self.data.description)
			description:SizeToContents()
		else
			ix.hud.PopulateItemTooltip(tooltip, self.data.item)
		end
	end)
end

function PANEL:RefreshData()
	local data = self.data
	if not self.owner.isInstanceVendor then
		data.name = data.item:GetName()
		data.description = describeItem(data.item)
		data.price = self.owner.entity:GetPrice(self.item, self.isLocal, self.iteminstanceID)
		local info = self.owner.entity.items[self.item]
		data.stock = not self.isLocal and info and info[VENDOR_MAXSTOCK] and info[VENDOR_STOCK] or nil
		self.stock.curstock = data.stock
		self.stock:SetText(self.isLocal and "Your inventory" or data.stock and
			ix.vendorStock.FormatStock(data.stock, info[VENDOR_MAXSTOCK], info[VENDOR_TASK_PROGRESS]) or "Stock: Unlimited")
	else
		if self.isLocal then
			data.name, data.description = data.item:GetName(), describeItem(data.item)
		end
		self.stock:SetText(self.isLocal and "Your inventory" or data.price > 0 and "Listed" or "Unlisted")
	end
	self.name:SetText(data.name)
	self.price:SetText(self.isLocal and self.owner.isInstanceVendor and "Donate" or ix.currency.Get(data.price))
end

function PANEL:PerformLayout(width)
	local gap, iconSize = ix.cotzUI.Scale(8), ix.cotzUI.Scale(44)
	local textX, textWidth = iconSize + gap * 2, math.max(1, width - iconSize - gap * 3)
	self.icon:SetPos(gap, gap)
	self.icon:SetSize(iconSize, iconSize)
	local y = gap
	for _, label in ipairs({self.name, self.stock, self.price}) do
		label:SetFont(label == self.name and "cotzUILabel" or "cotzUISmall")
		label:SetPos(textX, y)
		label:SetWide(textWidth)
		label:SizeToContentsY()
		y = y + label:GetTall()
	end
	local height = math.max(iconSize + gap * 2, y + gap)
	if self:GetTall() ~= height then self:SetTall(height) end
end

function PANEL:SetCallback(callback)
	self.DoClick = function() callback() end
end

function PANEL:Paint(width, height)
	surface.SetDrawColor(self.owner.selected == self and ix.cotzUI.colors.track or ix.cotzUI.colors.card)
	surface.DrawRect(0, 0, width, height)
	surface.SetDrawColor(self.owner.selected == self and ix.cotzUI.colors.teal or ix.cotzUI.colors.border)
	surface.DrawOutlinedRect(0, 0, width, height)
end

vgui.Register("ixVendorAdvItem", PANEL, "DButton")
