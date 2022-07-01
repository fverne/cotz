
local PANEL = {}

AccessorFunc(PANEL, "bReadOnly", "ReadOnly", FORCE_BOOL)

function PANEL:Init()
	self:SetSize(ScrW() * 0.45, ScrH() * 0.65)
	self:SetTitle("")
	self:MakePopup()
	self:Center()

	local header = self:Add("DPanel")
	header:SetTall(34)
	header:Dock(TOP)

	self.vendorName = header:Add("DLabel")
	self.vendorName:Dock(LEFT)
	self.vendorName:SetWide(self:GetWide() * 0.5 - 7)
	self.vendorName:SetText("John Doe")
	self.vendorName:SetTextInset(4, 0)
	self.vendorName:SetTextColor(color_white)
	self.vendorName:SetFont("stalkerregularfont")

	self.ourName = header:Add("DLabel")
	self.ourName:Dock(RIGHT)
	self.ourName:SetWide(self:GetWide() * 0.5 - 7)
	self.ourName:SetText(L"you".." ("..ix.currency.Get(LocalPlayer():GetCharacter():GetMoney())..")")
	self.ourName:SetTextInset(0, 0)
	self.ourName:SetTextColor(color_white)
	self.ourName:SetFont("stalkerregularfont")

	local footer = self:Add("DPanel")
	footer:SetTall(34)
	footer:Dock(BOTTOM)
	footer:SetPaintBackground(false)

	self.vendorSell = footer:Add("DButton")
	self.vendorSell:SetFont("stalkerregularfont")
	self.vendorSell:SetWide(self.vendorName:GetWide())
	self.vendorSell:Dock(LEFT)
	self.vendorSell:SetContentAlignment(5)
	-- The text says purchase but the vendor is selling it to us.
	self.vendorSell:SetText(L"purchase")
	self.vendorSell:SetTextColor(color_white)

	self.vendorSell.DoClick = function(this)
		if (IsValid(self.activeSell)) then
			net.Start("ixVendorAdvTrade")
				net.WriteString(self.activeSell.item)
				net.WriteUInt(0, 32) -- Not an existing item
				net.WriteBool(false)
			net.SendToServer()

			self:removeItem(self.activeSell.item, "selling", 0) -- We assume everything goes well - not always the case!!
		end
	end

	self.vendorBuy = footer:Add("DButton")
	self.vendorBuy:SetFont("stalkerregularfont")
	self.vendorBuy:SetWide(self.ourName:GetWide())
	self.vendorBuy:Dock(RIGHT)
	self.vendorBuy:SetContentAlignment(5)
	self.vendorBuy:SetText(L"sell")
	self.vendorBuy:SetTextColor(color_white)
	self.vendorBuy.DoClick = function(this)
		if (IsValid(self.activeBuy)) then
			net.Start("ixVendorAdvTrade")
				net.WriteString(self.activeBuy.item)
				net.WriteUInt(self.activeBuy.iteminstanceID, 32)
				net.WriteBool(true)
			net.SendToServer()

			self:removeItem(self.activeBuy.item, "buying", self.activeBuy.iteminstanceID) -- We assume everything goes well - not always the case!!
		end
	end

	self.selling = self:Add("DScrollPanel")
	self.selling:SetWide(self:GetWide() * 0.5 - 7)
	self.selling:Dock(LEFT)
	self.selling:DockMargin(0, 4, 0, 4)
	self.selling:SetPaintBackground(true)

	self.sellingItems = self.selling:Add("DListLayout")
	self.sellingItems:SetSize(self.selling:GetSize())
	self.sellingItems:DockPadding(0, 0, 0, 4)
	self.sellingItems:SetTall(ScrH())

	self.buying = self:Add("DScrollPanel")
	self.buying:SetWide(self:GetWide() * 0.5 - 7)
	self.buying:Dock(RIGHT)
	self.buying:DockMargin(0, 4, 0, 4)
	self.buying:SetPaintBackground(true)

	self.buyingItems = self.buying:Add("DListLayout")
	self.buyingItems:SetSize(self.buying:GetSize())
	self.buyingItems:DockPadding(0, 0, 0, 4)

	self.sellingList = {}
	self.buyingList = {}
end

function PANEL:addItem(uniqueID, listID, iteminstanceID)
	local entity = self.entity
	local items = entity.items
	local data = items[uniqueID]

	if ((!listID or listID == "selling") and !IsValid(self.sellingList[uniqueID])
	and ix.item.list[uniqueID]) then
		if (data and data[VENDOR_MODE] and data[VENDOR_MODE] != VENDOR_BUYONLY) then
			local item = self.sellingItems:Add("ixVendorAdvItem")
			item:Setup(uniqueID)

			self.sellingList[uniqueID] = item
			self.sellingItems:InvalidateLayout()
		end
	end

	if ((!listID or listID == "buying") and !IsValid(self.buyingList[iteminstanceID]) and iteminstanceID) then
		if (data and data[VENDOR_MODE] and data[VENDOR_MODE] != VENDOR_SELLONLY) or entity:GetBuyAll() then
			if (iteminstanceID and ix.item.instances[iteminstanceID] and !ix.item.instances[iteminstanceID]:GetData("equip",false)) then
				local item = self.buyingItems:Add("ixVendorAdvItem")
				item.isLocal = true
				item:Setup(uniqueID, iteminstanceID)

				self.buyingList[iteminstanceID] = item
				self.buyingItems:InvalidateLayout()
			end
		end
	end
end

function PANEL:removeItem(uniqueID, listID, iteminstanceID)
	if (!listID or listID == "selling") then
		if (IsValid(self.sellingList[uniqueID])) then
			self.sellingList[uniqueID].stock.curstock = math.max(self.sellingList[uniqueID].stock.curstock - 1,0)
			self.sellingList[uniqueID].stock:SetText(string.format("Stock: %d/%d", self.sellingList[uniqueID].stock.curstock, ix.gui.vendor.entity.items[uniqueID][VENDOR_MAXSTOCK]))
			--self.sellingList[uniqueID]:Remove()
			self.sellingItems:InvalidateLayout()
		end
	end

	if (!listID or listID == "buying") then
		if (IsValid(self.buyingList[iteminstanceID])) then
			self.buyingList[iteminstanceID]:Remove()
			self.buyingItems:InvalidateLayout()
		end
	end
end

function PANEL:Setup(entity)
	self.entity = entity
	self:SetTitle("")
	self.vendorName:SetText(entity:GetDisplayName()..(entity.money and " ("..entity.money..")" or ""))

	self.vendorBuy:SetEnabled(!self:GetReadOnly())
	self.vendorSell:SetEnabled(!self:GetReadOnly())

	for k, _ in SortedPairs(entity.items) do
		self:addItem(k, "selling")
	end

	for _, v in SortedPairs(LocalPlayer():GetCharacter():GetInventory():GetItems()) do
		if !v.noDrop then
			self:addItem(v.uniqueID, "buying", v:GetID())
		end
	end

	self:PostLayoutUpdate()
end

function PANEL:OnRemove()
	net.Start("ixVendorAdvClose")
	net.SendToServer()

	if (IsValid(ix.gui.vendorEditor)) then
		ix.gui.vendorEditor:Remove()
	end
end

function PANEL:Think()
	local entity = self.entity

	if (!IsValid(entity)) then
		self:Remove()

		return
	end

	if ((self.nextUpdate or 0) < CurTime()) then
		self:SetTitle("")
		self.vendorName:SetText(entity:GetDisplayName()..(entity.money and " ("..ix.currency.Get(entity.money)..")" or ""))
		self.ourName:SetText(L"you".." ("..ix.currency.Get(LocalPlayer():GetCharacter():GetMoney())..")")

		self.nextUpdate = CurTime() + 0.25
	end
end

function PANEL:OnItemSelected(panel)
	local price = self.entity:GetPrice(panel.item, panel.isLocal, panel.iteminstanceID)

	if (panel.isLocal) then
		self.vendorBuy:SetText(L"sell".." ("..ix.currency.Get(price)..")")
	else
		self.vendorSell:SetText(L"purchase".." ("..ix.currency.Get(price)..")")
	end
end

vgui.Register("ixVendorAdv", PANEL, "ixStalkerFrame")

PANEL = {}

function PANEL:Init()
	self:SetTall(36)
	self:DockMargin(4, 4, 4, 0)

	self.name = self:Add("DLabel")
	self.name:Dock(FILL)
	self.name:DockMargin(48, 0, 0, 0)
	self.name:SetFont("stalkerregularfont")
	self.name:SetTextColor(color_white)
	self.name:SetExpensiveShadow(1, Color(0, 0, 0, 200))

	self.infocontainer = self.name:Add("DPanel")
	self.infocontainer:Dock(RIGHT)
	self.infocontainer:DockPadding(0, 0, 6, 0)
	self.infocontainer:DockMargin(0, 0, 12, 0)
	self.infocontainer:SetWide(self:GetWide() * 1.5)
	self.infocontainer.Paint = function() end

	self.stock = self.infocontainer:Add("DLabel")
	self.stock:Dock(TOP)
	self.stock:SetContentAlignment(6)
	self.stock:SetFont("stalkerregularsmallfont")
	self.stock:SetText("")

	self.price = self.infocontainer:Add("DLabel")
	self.price:SetContentAlignment(6)
	self.price:Dock(FILL)
	self.price:SetFont("stalkerregularsmallfont")

	self.click = self:Add("DButton")
	self.click:Dock(FILL)
	self.click:SetText("")
	self.click.Paint = function() end
	self.click.DoClick = function(this)
		if (self.isLocal) then
			ix.gui.vendor.activeBuy = self
		else
			ix.gui.vendor.activeSell = self
		end

		ix.gui.vendor:OnItemSelected(self)
	end
end

function PANEL:SetCallback(callback)
	self.click.DoClick = function(this)
		callback()
		self.selected = true
	end
end

function PANEL:Setup(uniqueID, iteminstanceID)
	local item = ix.item.instances[iteminstanceID] or ix.item.list[uniqueID]
	local invicon = item.img
	local exIcon = ikon:GetIcon(item.uniqueID)
	local wmax = 32
	local hmax = 32
	local whratio = 1

	if item.width > item.height then
		whratio = item.height / item.width
		wmax = 32
		hmax = 32 * whratio
	elseif item.height > item.width then
		whratio = item.width / item.height
		wmax = 32 * whratio
		hmax = 32
	end

	if (item) then
		self.item = uniqueID

		self.iteminstanceID = iteminstanceID or 0

		if !(item.img or item.exRender) then
			self.icon = self:Add("SpawnIcon")
			self.icon:SetPos(2, 2)
			self.icon:SetSize(32, 32)
			self.icon:SetModel(item:GetModel(), item:GetSkin())
		elseif item.img then
			self.icon = self:Add("DImage")
			if (invicon) then
				self.icon:SetMaterial(invicon)
				self.icon:SetSize(wmax, hmax)

				if hmax == 32 then
					self.icon:SetPos(18 - (16 * whratio), 2)
				else
					self.icon:SetPos(2, 18 - (16 * whratio))
				end
			end
		elseif item.exRender then
			self.icon = self:Add("DImage")			
			if (exIcon) then
				self.icon:SetMaterial(exIcon)
				self.icon:SetSize(wmax, hmax)
				if hmax == 32 then
					self.icon:SetPos(18 - (16 * whratio), 2)
				else
					self.icon:SetPos(2, 18 - (16 * whratio))
				end
			else
				ikon:renderIcon(
					item.uniqueID,
					item.width,
					item.height,
					item:GetModel(),
					item.material,
					item.iconCam
				)
			end
		end

		self.name:SetText(item:GetName())
		self.itemName = item:GetName()

		local entity = ix.gui.vendor.entity
		if (!self.isLocal) then
			self.stock:SetText("Stock: Unlimited")
			if (entity and entity.items[self.item] and entity.items[self.item][VENDOR_MAXSTOCK]) then
				local info = entity.items[self.item]
			
				self.stock.curstock = info[VENDOR_STOCK]
				self.stock:SetText(string.format("Stock: %d/%d ", self.stock.curstock, info[VENDOR_MAXSTOCK]))
			end
		end

		self.price:SetText(ix.currency.Get(entity:GetPrice(self.item, self.isLocal, self.iteminstanceID)).." ")
		
		self.stock:SizeToContents()
		self.price:SizeToContents()
		self.infocontainer:SizeToChildren()

		self.click:SetHelixTooltip(function(tooltip)
			ix.hud.PopulateItemTooltip(tooltip, item)

			local entity = ix.gui.vendor.entity
			if (entity and entity.items[self.item] and entity.items[self.item][VENDOR_MAXSTOCK]) then
				local info = entity.items[self.item]
				local stock = tooltip:AddRowAfter("name", "stock")
				stock:SetText(string.format("Stock: %d/%d ", info[VENDOR_STOCK], info[VENDOR_MAXSTOCK]))
				stock:SetBackgroundColor(derma.GetColor("Info", self))
				stock:SizeToContents()
			end
		end)
	end
end

function PANEL:Think()
	if ((self.nextUpdate or 0) < CurTime()) then
		local entity = ix.gui.vendor.entity

		if (entity and self.isLocal) then
			local count = LocalPlayer():GetCharacter():GetInventory():GetItemCount(self.item)

			if (count == 0) then
				self:Remove()
			end
		end

		self.nextUpdate = CurTime() + 0.1
	end
end

function PANEL:Paint(w, h)
	if (ix.gui.vendor.activeBuy == self or ix.gui.vendor.activeSell == self) then
		surface.SetDrawColor(ix.config.Get("color"))
	else
		surface.SetDrawColor(0, 0, 0, 100)
	end

	surface.DrawRect(0, 0, w, h)
end

vgui.Register("ixVendorAdvItem", PANEL, "DPanel")
