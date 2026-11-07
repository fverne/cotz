local PLUGIN = PLUGIN
local MAX_PRICE = 2147483647
local VENDOR_MODEL = "models/mossman.mdl"
local SHOP_PAGE_SIZE = 20
util.AddNetworkString("cotz/hideouts/shop")
util.AddNetworkString("cotz/hideouts/shop-action")
util.AddNetworkString("cotz/hideouts/shop-close")
util.AddNetworkString("cotz/hideouts/history")

function PLUGIN:CanStockItem(client, item)
	if not item or item:GetData("equip") or item:GetData("id") or item.isBag
		or item.noDrop or item.noTrade or item.isQuestItem or item.isFieldCargo or item:GetData("bound")
		or item:GetData("cotzJobCargo") or item:GetData("townQuest") then return false end
	local character = client:GetCharacter()
	if not item.bAllowMultiCharacterInteraction and item:GetPlayerID() == client:SteamID64()
		and item:GetCharacterID() ~= character:GetID() then return false end

	return true
end

function PLUGIN:RestoreShop(instance, callback)
	local record = self:GetHideout(instance.id)
	record.shop = record.shop or {
		width = ix.config.Get("hideoutStockWidth", 10), height = ix.config.Get("hideoutStockHeight", 8),
	}
	self:LoadOwnedInventory(record, "shop", record.shop, "cotzHideoutStock",
		record.shop.width, record.shop.height, function(inventory)
			if not inventory then callback(false, "Could not persist squad inventory assignment.") return end
			if self.instances[instance.id] ~= instance or instance.state ~= "loading" then return end
			instance.stock = inventory
			self:CreateVendor(instance)
			callback(IsValid(instance.vendor), "Could not create the squad vendor.")
		end)
end

function PLUGIN:GetVendorDefault(record)
	local template = self:GetTemplate(record)

	return {pos = template.vendor or template.storage, angles = template.vendorAngles or angle_zero,
		model = VENDOR_MODEL, class = "ix_hideout_vendor", movable = false}
end

function PLUGIN:CreateVendor(instance)
	local record = self:GetHideout(instance.id)
	local state = record.vendor or self:GetVendorDefault(record)
	local entity = self:CreateUtility(instance, "ix_hideout_vendor", state.pos, VENDOR_MODEL)
	if not IsValid(entity) then return end
	ix.sherpa.ApplyAppearance(entity, record.vendorAppearance)
	self:ApplyPropData(entity, state, instance.origin)
	instance.vendor = entity
	instance.vendorValid = self:SerializeProp(entity, instance.origin)

	return entity
end

function PLUGIN:CloseShop(instance, onlyClient)
	for client in pairs(instance.shopClients or {}) do
		if not onlyClient or onlyClient == client then
			instance.shopClients[client] = nil
			if IsValid(client) then net.Start("cotz/hideouts/shop-close") net.Send(client) end
		end
	end
end

function PLUGIN:AuditVendor(instance)
	if not IsValid(instance.vendor) then return end
	local entity = instance.vendor
	local mins, maxs = entity:WorldSpaceAABB()
	if not self:Contains(mins, instance.mins, instance.maxs)
		or not self:Contains(maxs, instance.mins, instance.maxs) then
		self:CloseShop(instance)
		self:ApplyPropData(entity, instance.vendorValid, instance.origin)
		return
	end
	local record = self:GetHideout(instance.id)
	record.vendorAppearance = ix.sherpa.CaptureAppearance(entity)
	local state = self:SerializeProp(entity, instance.origin)
	local previous = instance.vendorValid
	if previous and (previous.pos ~= state.pos or previous.angles ~= state.angles) then self:CloseShop(instance) end
	instance.vendorValid = state
	self:GetHideout(instance.id).vendor = table.Copy(instance.vendorValid)
end

function PLUGIN:ResetVendor(client, record)
	if not self:CanManageHideout(client, record) or record.ownerType ~= "squad" then
		return false, "Only this squad's leader or officers can reset the vendor."
	end
	if self.members[client] ~= record.id and not self:IsNearEntrance(client, record.entrance) then
		return false, "Stand inside the hideout or near its entrance."
	end
	if (client.cotzVendorReset or 0) > CurTime() then return false, "Please wait before resetting again." end
	client.cotzVendorReset = CurTime() + 5
	local instance = self.instances[record.id]
	if instance and (instance.saving or instance.state ~= "active" or (instance.operations or 0) > 0) then
		return false, "The hideout is busy."
	end
	local defaults = self:GetVendorDefault(record)
	local state = table.Copy(record.vendor or defaults)
	state.pos, state.angles, state.movable = defaults.pos, defaults.angles, false
	if instance then
		local point = instance.origin + state.pos
		local trace = util.TraceHull({start = point, endpos = point,
			mins = Vector(-16, -16, 0), maxs = Vector(16, 16, 72), filter = instance.vendor})
		if trace.Hit or trace.StartSolid then return false, "The vendor's default position is obstructed." end
	end
	state.model = record.vendorAppearance and record.vendorAppearance.model or state.model
	local previous = record.vendor
	record.vendor = state
	if not self:Persist() then record.vendor = previous return false, "Could not save vendor position." end
	if instance then
		self:CloseShop(instance)
		if IsValid(instance.vendor) then
			self:ApplyPropData(instance.vendor, state, instance.origin)
			instance.vendorValid = table.Copy(state)
		else
			self:CreateVendor(instance)
		end
	end

	return true, "Vendor reset. Stock and treasury retained."
end

function PLUGIN:OpenShop(client, entity, requestedPage)
	if not self:IsNearUtility(client, entity) or entity.cotzVendorHeld then return end
	if (client.cotzShopOpen or 0) > CurTime() then return end
	client.cotzShopOpen = CurTime() + 0.5
	local instance = self.instances[entity.ixHideout]
	local record = self:GetHideout(instance.id)
	local character = client:GetCharacter()
	self:GetTreasury(record, function(balance)
		if not balance or not IsValid(client) or client:GetCharacter() ~= character
			or not self:IsNearUtility(client, entity) then return end
		local rank = self:GetSquadRank(client, record)
		local rows = {}
		for _, item in pairs(instance.stock:GetItems(true)) do
			local listing = item:GetData("cotzHideoutStock", {})
			if rank ~= nil or (listing.price or 0) > 0 then rows[#rows + 1] = item end
		end
		table.sort(rows, function(a, b) return a:GetID() < b:GetID() end)
		local pages = math.max(1, math.ceil(#rows / SHOP_PAGE_SIZE))
		local page = math.Clamp(requestedPage or 1, 1, pages)
		local first = (page - 1) * SHOP_PAGE_SIZE + 1
		local last = math.min(first + SHOP_PAGE_SIZE - 1, #rows)
		instance.shopClients = instance.shopClients or {}
		instance.shopClients[client] = {character = character:GetID(), vendor = entity}
		local visible = {}
		for index = first, last do visible[#visible + 1] = rows[index] end
		ix.sherpa.SendStock(client, entity, record.id, record.name, rank,
			rank ~= nil and balance or 0, self:GetSaleCommission(), page, pages, visible)
	end)
end

function PLUGIN:DescribeStockItem(item)
	local description = item:GetDescription()
	for _, key in ipairs({"quantity", "durability", "condition"}) do
		local value = item:GetData(key)
		if isnumber(value) then description = description .. "\n" .. key .. ": " .. value end
	end

	return description
end

function PLUGIN:ShopAction(client, record, action, itemID, amount, revision)
	local instance = record and self.instances[record.id]
	local session = instance and instance.shopClients and instance.shopClients[client]
	if not session or session.character ~= client:GetCharacter():GetID()
		or not self:IsNearUtility(client, instance.vendor) or instance.vendor.cotzVendorHeld then return end
	local item = ix.item.instances[itemID]
	local inventory = client:GetCharacter():GetInventory()
	if action == "page" then self:OpenShop(client, instance.vendor, math.Clamp(amount, 1, 65535)) return end
	if action == "history" then self:ShowShopHistory(client, record) return end
	if action == "withdraw" then
		self:CheckSquadRole(client, record, 2, function(allowed)
			if not allowed or not self:IsNearUtility(client, instance.vendor) then return end
			if amount < 1 or amount > MAX_PRICE then return end
			self:CommitOperation(client, record, {rank = 2, moneyDelta = amount, treasuryDelta = -amount,
				payload = {kind = "withdraw", amount = amount},
				authorize = function()
					return self:IsNearUtility(client, instance.vendor) and self:GetSquadRank(client, record) == 2
				end,
			}, function(ok, reason)
				if IsValid(client) then client:Notify(ok and "Treasury withdrawal complete." or reason) end
			end)
		end)
		return
	end
	if not item or self:IsOperationLocked(item, inventory, instance.stock) then return end
	local listing = item:GetData("cotzHideoutStock", {})
	local minimum = action == "donate" and 0 or 1
	if action == "buy" then
		if item.invID ~= instance.stock:GetID() or (listing.price or 0) < 1
			or listing.price ~= amount or (listing.revision or 0) ~= revision then
			client:Notify("That listing changed. Reopen the vendor.")
			return
		end
		self:TransferShopItem(client, record, instance, item, inventory, nil, -amount,
			amount - math.floor(amount * self:GetSaleCommission() / 100))
		return
	end
	self:CheckSquadRole(client, record, minimum, function(allowed)
		if not allowed or not self:IsNearUtility(client, instance.vendor)
			or not instance.shopClients or instance.shopClients[client] ~= session then return end
		if action == "donate" and item.invID == inventory:GetID() and self:CanStockItem(client, item) then
			self:TransferShopItem(client, record, instance, item, instance.stock, 0, 0, 0, 0)
		elseif action == "recover" and item.invID == instance.stock:GetID() then
			self:TransferShopItem(client, record, instance, item, inventory, nil, 0, 0, 1)
		elseif action == "price" and item.invID == instance.stock:GetID() then
			listing = item:GetData("cotzHideoutStock", {})
			if amount < 0 or amount > MAX_PRICE or self:IsOperationLocked(item, instance.stock)
				or (listing.revision or 0) ~= revision then return end
			item:SetData("cotzHideoutStock", {
				price = amount, revision = (listing.revision or 0) + 1,
				donor = listing.donor, hideout = record.id, map = game.GetMap(),
			})
			self:CloseShop(instance)
		end
	end)
end

function PLUGIN:ShowShopHistory(client, record)
	self:CheckSquadRole(client, record, 0, function(allowed)
		if not allowed then return end
		local query = mysql:Select("ix_hideout_operations")
		query:Where("scope", Schema.folder)
		query:Where("squad", record.squadID)
		query:OrderByDesc("created")
		query:OrderByDesc("token")
		query:Limit(30)
		ix.crossserver.Query(query, function(rows, failure)
			if failure or not IsValid(client) or not self:CanAccess(client, record)
				or self:GetSquadRank(client, record) == nil then return end
			net.Start("cotz/hideouts/history")
			net.WriteUInt(#rows, 6)
			for _, row in ipairs(rows) do
				local payload = util.JSONToTable(row.payload) or {}
				net.WriteUInt(tonumber(row.created), 32)
				net.WriteString(payload.actorName or "Former member")
				net.WriteString(row.kind)
				net.WriteInt(payload.treasury or -(payload.amount or 0), 32)
			end
			net.Send(client)
		end)
	end)
end

function PLUGIN:TransferShopItem(client, record, instance, item, target, price, moneyDelta, treasuryDelta, rank)
	if not self:CanStockItem(client, item) then client:Notify("This item cannot be traded.") return end
	local current = ix.inventory.Get(item.invID)
	if item.CanTransfer and item:CanTransfer(current, target) == false
		or hook.Run("CanTransferItem", item, current, target) == false then return end
	local x, y = target:FindEmptySlot(item.width, item.height, true)
	if not x then client:Notify("The destination inventory is full.") return end
	local data = table.Copy(item.data)
	data.cotzHideout, data.cotzHideoutStock = nil, nil
	if price ~= nil then
		data.cotzHideoutStock = {price = price, revision = 1, donor = client:GetCharacter():GetID(),
			hideout = record.id, map = game.GetMap()}
	end
	self:CommitOperation(client, record, {
		item = item, from = current, to = target, x = x, y = y, data = data, rank = rank,
		moneyDelta = moneyDelta, treasuryDelta = treasuryDelta,
		authorize = function()
			local session = instance.shopClients and instance.shopClients[client]
			local currentRank = self:GetSquadRank(client, record)
			return session ~= nil and self:IsNearUtility(client, instance.vendor) and not instance.vendor.cotzVendorHeld
				and (rank == nil or currentRank ~= nil and currentRank >= rank)
		end,
		payload = {kind = price ~= nil and "donate" or (moneyDelta < 0 and "sale" or "recover"),
			item = item:GetID(), paid = -moneyDelta, treasury = treasuryDelta},
	}, function(ok, reason)
		self:CloseShop(instance)
		if IsValid(client) then client:Notify(ok and "Stock transfer complete." or reason) end
	end)
end

local ACTIONS = {
	[1] = "buy", [2] = "donate", [3] = "price", [4] = "recover", [5] = "withdraw", [6] = "history", [7] = "page",
}
net.Receive("cotz/hideouts/shop-action", function(_, client)
	if not client:GetCharacter() or (client.cotzShopAction or 0) > CurTime() then return end
	client.cotzShopAction = CurTime() + 0.5
	local id = net.ReadString()
	if #id > 20 then return end
	local record = PLUGIN:GetHideout(id)
	local action = ACTIONS[net.ReadUInt(3)]
	local itemID, amount, revision = net.ReadUInt(32), net.ReadUInt(32), net.ReadUInt(32)
	if action then PLUGIN:ShopAction(client, record, action, itemID, amount, revision) end
end)
