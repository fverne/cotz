local PANEL = {}

function PANEL:SendAction(action, itemID, amount, revision)
	if (self.nextRequest or 0) > CurTime() then return end
	self.nextRequest = CurTime() + 0.5
	net.Start("cotz/sherpas/action")
	net.WriteEntity(self.entity)
	net.WriteUInt(self.session, 32)
	net.WriteUInt(action, 3)
	net.WriteUInt(itemID or 0, 32)
	net.WriteUInt(amount or 0, 32)
	net.WriteUInt(revision or 0, 32)
	net.SendToServer()
end

function PANEL:AddStockRow(parent, itemID, uniqueID, name, description, price, revision, personal)
	local definition = ix.item.list[uniqueID]
	if not definition then return end
	local item = personal and ix.item.instances[itemID] or definition
	local row = self:AddTradeRow(parent, {key = itemID, uniqueID = uniqueID, item = item,
		name = name, description = description, price = price, revision = revision, personal = personal})
	local list = personal and self.buyingList or self.sellingList
	list[itemID] = row

	return row
end

function PANEL:TradeSelected(personal)
	local row = self.selected
	if not IsValid(row) or row.isLocal ~= personal then return end
	local data = row.data
	local itemID, price, revision = data.key, data.price, data.revision
	if personal then
		if self.rank < 0 then return end
		ix.cotzUI.Query("This item becomes vendor stock. No payment is made.", "Donate item", "Donate", function()
			if IsValid(self) then self:SendAction(2, itemID) end
		end, "Cancel")
	elseif price > 0 then
		ix.cotzUI.Query(data.description .. "\n\nTotal: " .. ix.currency.Get(price), "Purchase item",
			"Purchase", function()
				if IsValid(self) then self:SendAction(1, itemID, price, revision) end
			end, "Cancel")
	end
end

function PANEL:EditSelectedPrice(unlist)
	local row = self.selected
	if self.rank < 1 or not IsValid(row) or row.isLocal then return end
	local itemID, revision, price = row.data.key, row.data.revision, row.data.price
	if unlist then self:SendAction(3, itemID, 0, revision) return end
	ix.cotzUI.StringRequest("Listing", "Whole item price in roubles (0 removes listing)", tostring(price), function(value)
		if not IsValid(self) then return end
		local amount = tonumber(value)
		if not amount or amount ~= amount or amount < 0 or amount > 2147483647 then return end
		self:SendAction(3, itemID, math.floor(amount), revision)
	end)
end

function PANEL:RecoverSelected()
	local row = self.selected
	if self.rank < 1 or not IsValid(row) or row.isLocal then return end
	self:SendAction(4, row.data.key)
end

function PANEL:RefreshInspector()
	-- Use the registered base explicitly: BaseClass points at this table for derived panels.
	vgui.GetControlTable("ixVendorAdv").RefreshInspector(self)
	if not IsValid(self.priceAction) then return end
	local row = self.selected
	local manage = self.rank and self.rank >= 1 and self.tab == "selling"
	for _, button in ipairs({self.priceAction, self.unlistAction, self.recoverAction}) do
		button:SetVisible(manage == true)
		button:SetEnabled(IsValid(row))
	end
	self.unlistAction:SetEnabled(IsValid(row) and row.data.price > 0)
	self.vendorBuy:SetEnabled(IsValid(row) and self.tab == "buying" and self.rank >= 0)
	self.vendorBuy:SetText("Donate")
	self.inspectorActions:InvalidateLayout(true)
end

function PANEL:SetupStock(entity, session, id, name, rank, balance, commission, page, pages, rows)
	local stockKey = IsValid(self.activeSell) and self.activeSell.data.key
	local personalKey = IsValid(self.activeBuy) and self.activeBuy.data.key
	local tab = self.tab
	self.session, self.entity, self.rank = session, entity, rank
	self.isInstanceVendor = true
	self.page = page
	self.vendorName:SetText(name)
	self.stockTab:SetText("Stock")
	self.personalTab:SetText("Donate")
	self.personalTab:SetVisible(rank >= 0)
	self.summary:SetText("Page " .. page .. "/" .. pages .. (rank >= 0
		and " · Earnings: " .. ix.currency.Get(balance) .. " · Sale commission: " .. commission .. "%" or ""))
	self.sellingItems:Clear()
	self.buyingItems:Clear()
	self.sellingList, self.buyingList = {}, {}
	for _, item in ipairs(rows) do
		self:AddStockRow(self.sellingItems, item.id, item.uniqueID, item.name, item.description,
			item.price, item.revision, false)
	end
	self:SyncPersonalItems()
	self.activeSell, self.activeBuy = self.sellingList[stockKey], self.buyingList[personalKey]

	if not IsValid(self.priceAction) then
		self.priceAction = self:AddInspectorTool("Set price", function() self:EditSelectedPrice(false) end)
		self.unlistAction = self:AddInspectorTool("Unlist", function() self:EditSelectedPrice(true) end)
		self.recoverAction = self:AddInspectorTool("Recover", function() self:RecoverSelected() end)
	end
	self.pageTools:Clear()
	local previous = self:AddPageTool("Previous", function() self:SendAction(7, 0, self.page - 1) end)
	previous:SetEnabled(page > 1)
	local following = self:AddPageTool("Next", function() self:SendAction(7, 0, self.page + 1) end)
	following:SetEnabled(page < pages)
	self:AddPageTool("Refresh stock", function() self:SendAction(7, 0, self.page) end)
	self.managementTools:Clear()
	local squad = entity:GetClass() == "ix_hideout_vendor"
	if rank >= 1 and squad then
		self:AddManagementTool("Manage hideout", function()
			ix.plugin.Get("hideouts"):RequestManagement(id, "vendor")
		end)
	end
	if rank >= 0 and squad then
		self:AddManagementTool("Recent transactions", function() self:SendAction(6) end)
	end
	if rank == 2 then
		self:AddManagementTool("Withdraw earnings", function()
			ix.cotzUI.StringRequest("Vendor earnings", "Amount in roubles", "", function(value)
				if not IsValid(self) then return end
				local amount = tonumber(value)
				if not amount or amount ~= amount or amount < 1 or amount > 2147483647 then return end
				self:SendAction(5, 0, math.floor(amount))
			end)
		end)
	end
	self:SetTab(tab)
	self:InvalidateChildren(true)
end

function PANEL:SyncPersonalItems()
	local items = self.character:GetInventory():GetItems(true)
	for id, row in pairs(self.buyingList) do
		local item = items[id]
		if self.rank < 0 or not item or item.noDrop or item:GetData("equip", false) or item.isFieldCargo then
			row:Remove()
			self.buyingList[id] = nil
		end
	end
	if self.rank < 0 then return end
	for _, item in SortedPairs(items) do
		if not item.noDrop and not item:GetData("equip", false) and not item.isFieldCargo then
			local row = self.buyingList[item:GetID()]
			if not IsValid(row) then
				row = self:AddStockRow(self.buyingItems, item:GetID(), item.uniqueID, item:GetName(),
					item:GetDescription(), 0, 0, true)
			end
			if IsValid(row) then
				row.data.name, row.data.description = item:GetName(), item:GetDescription()
				row:RefreshData()
			end
		end
	end
end

function PANEL:Think()
	if IsValid(self.entity) and LocalPlayer():GetPos():DistToSqr(self.entity:GetPos()) > 128 * 128 then
		self:Remove()
		return
	end
	if not self:UpdateTrade() then return end
	self:SyncPersonalItems()
	self:RefreshInspector()
end

function PANEL:OnRemove()
	net.Start("cotz/sherpas/close")
	net.WriteUInt(self.session or 0, 32)
	net.SendToServer()
	if ix.gui.vendor == self then ix.gui.vendor = nil end
	if IsValid(ix.gui.dialogue) and not ix.gui.dialogue.exiting then ix.gui.dialogue:RequestFocus() end
end

net.Receive("cotz/sherpas/stock", function()
	local entity, session = net.ReadEntity(), net.ReadUInt(32)
	local id, name = net.ReadString(), net.ReadString()
	local rank, balance, commission = net.ReadInt(3), net.ReadUInt(32), net.ReadUInt(7)
	local page, pages, rows = net.ReadUInt(16), net.ReadUInt(16), {}
	for _ = 1, net.ReadUInt(5) do
		rows[#rows + 1] = {id = net.ReadUInt(32), uniqueID = net.ReadString(), name = net.ReadString(),
			description = net.ReadString(), price = net.ReadUInt(32), revision = net.ReadUInt(32)}
	end
	if not IsValid(entity) or not LocalPlayer():GetCharacter() then return end
	local panel = ix.gui.vendor
	if not IsValid(panel) or panel.ClassName ~= "ixSherpaTrade" or panel.entity ~= entity
		or panel.character ~= LocalPlayer():GetCharacter() then
		if IsValid(panel) then panel:Remove() end
		-- Sherpas loads before vendor_adv; resolve the base once all plugins have registered their panels.
		vgui.Register("ixSherpaTrade", PANEL, "ixVendorAdv")
		panel = vgui.Create("ixSherpaTrade")
		ix.gui.vendor = panel
	end
	panel:SetupStock(entity, session, id, name, rank, balance, commission, page, pages, rows)
end)

net.Receive("cotz/sherpas/close", function()
	local entity = net.ReadEntity()
	if IsValid(ix.gui.vendor) and ix.gui.vendor.entity == entity then ix.gui.vendor:Remove() end
end)
