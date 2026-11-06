local PLUGIN = PLUGIN
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
	local row = parent:Add("DButton")
	row:Dock(TOP)
	row:SetTall(ix.cotzUI.Scale(48))
	row:DockMargin(4, 4, 4, 0)
	row:SetFont("stalkerregularfont")
	row:SetTextInset(ix.cotzUI.Scale(48), 0)
	row:SetContentAlignment(4)
	row:SetText(name .. "\n" .. (personal and "Donate" or price > 0 and ix.currency.Get(price) or "Unlisted"))
	row:SetTooltip(description)
	local icon = row:Add("DImage")
	icon:Dock(LEFT)
	icon:SetWide(ix.cotzUI.Scale(40))
	icon:SetMaterial(ix.util.GetItemIcon(definition))
	row.DoClick = function()
		if personal then
			self.activeDonation = itemID
			self.vendorBuy:SetEnabled(self.rank >= 0)
		else
			self.activeListing = {id = itemID, price = price, revision = revision, description = description}
			self.vendorSell:SetEnabled(price > 0)
			self.vendorSell:SetText(price > 0 and "Purchase (" .. ix.currency.Get(price) .. ")" or "Unlisted")
		end
	end
	if not personal and self.rank >= 1 then
		row.DoRightClick = function()
			local menu = ix.cotzUI.Menu()
			menu:AddOption("Set price (0 removes listing)", function()
				ix.cotzUI.StringRequest("Listing", "Whole item price in roubles", tostring(price), function(value)
					self:SendAction(3, itemID, math.Clamp(math.floor(tonumber(value) or 0), 0, 2147483647), revision)
				end)
			end)
			menu:AddOption("Recover item", function() self:SendAction(4, itemID) end)
			menu:Open()
		end
	end
end

function PANEL:SetupStock(entity, session, id, name, rank, balance, commission, page, pages, rows)
	self.session = session
	self.entity, self.rank = entity, rank
	self.vendorName:SetText(name)
	self.vendorBuy:SetText("Donate selected item")
	self.vendorBuy:SetEnabled(false)
	self.vendorSell:SetText("Purchase selected item")
	self.vendorSell:SetEnabled(false)
	self.vendorBuy.DoClick = function()
		if not self.activeDonation then return end
		ix.cotzUI.Query("This item becomes vendor stock. No payment is made.", "Donate item", "Donate", function()
			if IsValid(self) then self:SendAction(2, self.activeDonation) end
		end, "Cancel")
	end
	self.vendorSell.DoClick = function()
		local listing = self.activeListing
		if not listing or listing.price < 1 then return end
		ix.cotzUI.Query(listing.description .. "\n\nTotal: " .. ix.currency.Get(listing.price), "Purchase item",
			"Purchase", function()
				if IsValid(self) then self:SendAction(1, listing.id, listing.price, listing.revision) end
			end, "Cancel")
	end
	for _, item in ipairs(rows) do
		self:AddStockRow(self.sellingItems, item.id, item.uniqueID, item.name, item.description,
			item.price, item.revision, false)
	end
	if rank >= 0 then
		for _, item in pairs(LocalPlayer():GetCharacter():GetInventory():GetItems(true)) do
			if not item.noDrop and not item:GetData("equip") then
				self:AddStockRow(self.buyingItems, item:GetID(), item.uniqueID, item:GetName(),
					item:GetDescription(), 0, 0, true)
			end
		end
	end
	local options = self:Add("DButton")
	options:Dock(TOP)
	options:SetTall(ix.cotzUI.Scale(34))
	options:SetText("Page " .. page .. "/" .. pages .. (rank >= 0 and " — Earnings: " .. ix.currency.Get(balance) or "")
		.. " — Options")
	options.DoClick = function()
		local menu = ix.cotzUI.Menu()
		if page > 1 then menu:AddOption("Previous page", function() self:SendAction(7, 0, page - 1) end) end
		if page < pages then menu:AddOption("Next page", function() self:SendAction(7, 0, page + 1) end) end
		menu:AddOption("Refresh stock", function() self:SendAction(7, 0, page) end)
		if rank >= 1 then
			menu:AddOption("Right-click stock to set prices or recover items")
			if entity:GetClass() == "ix_hideout_vendor" then
				menu:AddOption("Manage squad hideout", function() ix.plugin.Get("hideouts"):RequestManagement(id, "vendor") end)
			end
		end
		if rank >= 0 and entity:GetClass() == "ix_hideout_vendor" then
			menu:AddOption("Recent transactions", function() self:SendAction(6) end)
		end
		if rank == 2 then
			menu:AddOption("Withdraw earnings (sale commission " .. commission .. "%)", function()
				ix.cotzUI.StringRequest("Vendor earnings", "Amount in roubles", "", function(value)
					self:SendAction(5, 0, math.Clamp(math.floor(tonumber(value) or 0), 0, 2147483647))
				end)
			end)
		end
		menu:Open()
	end
	self:PostLayoutUpdate()
end

function PANEL:Think()
	if not IsValid(self.entity) or not LocalPlayer():GetCharacter()
		or LocalPlayer():GetPos():DistToSqr(self.entity:GetPos()) > 128 * 128 then self:Remove() return end
	if (self.nextUpdate or 0) > CurTime() then return end
	self.nextUpdate = CurTime() + 0.25
	self.ourName:SetText("You (" .. ix.currency.Get(LocalPlayer():GetCharacter():GetMoney()) .. ")")
end

function PANEL:OnRemove()
	if not self.replacing then
		net.Start("cotz/sherpas/close")
		net.WriteUInt(self.session or 0, 32)
		net.SendToServer()
	end
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
	if not IsValid(entity) then return end
	if IsValid(ix.gui.vendor) then
		ix.gui.vendor.replacing = true
		ix.gui.vendor:Remove()
	end
	-- Sherpas loads before vendor_adv; resolve the base after every plugin has registered its panels.
	vgui.Register("ixSherpaTrade", PANEL, "ixVendorAdv")
	local panel = vgui.Create("ixSherpaTrade")
	ix.gui.vendor = panel
	panel:SetupStock(entity, session, id, name, rank, balance, commission, page, pages, rows)
end)

net.Receive("cotz/sherpas/close", function()
	local entity = net.ReadEntity()
	if IsValid(ix.gui.vendor) and ix.gui.vendor.entity == entity then ix.gui.vendor:Remove() end
end)

function PLUGIN:OnScreenSizeChanged()
	if IsValid(ix.gui.vendor) and ix.gui.vendor.ClassName == "ixSherpaTrade" then ix.gui.vendor:Remove() end
end
