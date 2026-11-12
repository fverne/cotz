local PLUGIN = PLUGIN
local MAX_PRICE = 2147483647
local USE_DISTANCE_SQUARED = 128 * 128
util.AddNetworkString("cotz/sherpas/stock")
util.AddNetworkString("cotz/sherpas/action")
util.AddNetworkString("cotz/sherpas/close")

function ix.sherpa.EnsureIdentity(entity)
	if not entity.sherpaID then
		entity.sherpaID = util.SHA256(Schema.folder .. game.GetMap() .. SysTime() .. math.random()):sub(1, 12)
	end
	entity:SetNetVar("sherpaID", entity.sherpaID)

	return entity.sherpaID
end

function ix.sherpa.CanUse(client, entity)
	return ix.sherpa.IsVendor(entity) and client:GetCharacter() ~= nil and entity:CanAccess(client)
		and client:GetPos():DistToSqr(entity:GetPos()) <= USE_DISTANCE_SQUARED
end

function ix.sherpa.CanManage(client, entity)
	return ix.sherpa.CanUse(client, entity) and client:GetCharacter():HasSherpaVendor(entity)
end

function ix.sherpa.Close(entity)
	for client in pairs(entity.sherpaClients or {}) do
		if IsValid(client) then
			net.Start("cotz/sherpas/close")
			net.WriteEntity(entity)
			net.Send(client)
		end
	end
	entity.sherpaClients = {}
end

function ix.sherpa.SendStock(client, entity, id, name, rank, balance, commission, page, pages, rows)
	client.cotzSherpaSession = (client.cotzSherpaSession or 0) % 4294967295 + 1
	client.cotzSherpaVendor = entity
	net.Start("cotz/sherpas/stock")
	net.WriteEntity(entity)
	net.WriteUInt(client.cotzSherpaSession, 32)
	net.WriteString(id)
	net.WriteString(name:sub(1, 256))
	net.WriteInt(rank or -1, 3)
	net.WriteUInt(balance or 0, 32)
	net.WriteUInt(commission, 7)
	net.WriteUInt(page, 16)
	net.WriteUInt(pages, 16)
	net.WriteUInt(#rows, 5)
	for _, item in ipairs(rows) do
		local listing = item:GetData("cotzHideoutStock", {})
		net.WriteUInt(item:GetID(), 32)
		net.WriteString(item.uniqueID)
		net.WriteString(item:GetName():sub(1, 128))
		net.WriteString(ix.plugin.Get("hideouts"):DescribeStockItem(item):sub(1, 2048))
		net.WriteUInt(listing.price or 0, 32)
		net.WriteUInt(listing.revision or 0, 32)
	end
	net.Send(client)
end

function PLUGIN:LoadData()
	self.records = {}
	local saved = self:GetData({})
	self.stockRevision = saved.revision or 0
	for id, record in pairs(saved.records or saved) do
		if istable(record) and record.shop then self.records[tostring(id)] = record end
	end
end

function PLUGIN:PersistStock()
	self.stockRevision = (self.stockRevision or 0) + 1
	self:SetData({revision = self.stockRevision, records = self.records or {}})
	local saved = self:GetData(nil, false, false, true)

	return istable(saved) and saved.revision == self.stockRevision
end

function ix.sherpa.GetRecord(entity)
	local id = ix.sherpa.EnsureIdentity(entity)
	PLUGIN.records = PLUGIN.records or {}
	local record = PLUGIN.records[id] or entity.sherpaRecord or {
		id = "sherpa:" .. id, squadID = "sherpa:" .. id, ownerType = "character", shop = {},
	}
	record.name = entity:GetDisplayName()
	PLUGIN.records[id], entity.sherpaRecord = record, record

	return record
end

function ix.sherpa.LoadStock(entity, callback)
	local record = ix.sherpa.GetRecord(entity)
	local hideouts = ix.plugin.Get("hideouts")
	if not hideouts or not hideouts.operationsReady then return end
	hideouts:LoadOwnedInventory(record, "sherpa", record.shop, "cotzSherpaStock", 10, 8, function(inventory)
		if not inventory then return end
		if not IsValid(entity) then return end
		-- Generic inventory/storage requests cannot bypass the vendor transaction path.
		inventory.vars.hideout, inventory.vars.hideoutSlot = nil, nil
		inventory.vars.sherpa = entity
		record.shop.inventoryID = inventory:GetID()
		ix.plugin.Get("vendor_adv"):SaveData()
		callback(inventory, record)
	end, function() return PLUGIN:PersistStock() end)
end

function ix.sherpa.Open(client, entity, requestedPage)
	if not ix.sherpa.CanUse(client, entity) then return end
	local hideouts = ix.plugin.Get("hideouts")
	if not hideouts or not hideouts.operationsReady then
		client:Notify("Vendor storage is still initializing.")
		return
	end
	if entity.ixHideout then
		return ix.plugin.Get("hideouts"):OpenShop(client, entity, requestedPage)
	end
	if (client.cotzSherpaOpen or 0) > CurTime() then return end
	client.cotzSherpaOpen = CurTime() + 0.5
	local character = client:GetCharacter()
	ix.sherpa.LoadStock(entity, function(stock, record)
		ix.plugin.Get("hideouts"):GetTreasury(record, function(balance)
			if balance == nil or not IsValid(client) or client:GetCharacter() ~= character
				or not ix.sherpa.CanUse(client, entity) then return end
			local manage = ix.sherpa.CanManage(client, entity)
			local rows = {}
			for _, item in pairs(stock:GetItems(true)) do
				if manage or (item:GetData("cotzHideoutStock", {}).price or 0) > 0 then rows[#rows + 1] = item end
			end
			table.sort(rows, function(a, b) return a:GetID() < b:GetID() end)
			local pages = math.max(1, math.ceil(#rows / ix.sherpa.PAGE_SIZE))
			local page = math.Clamp(requestedPage or 1, 1, pages)
			local visible = {}
			for index = (page - 1) * ix.sherpa.PAGE_SIZE + 1, math.min(page * ix.sherpa.PAGE_SIZE, #rows) do
				visible[#visible + 1] = rows[index]
			end
			local previous = client.cotzSherpaVendor
			if IsValid(previous) and previous ~= entity and previous.sherpaClients then
				previous.sherpaClients[client] = nil
			end
			entity.sherpaClients = entity.sherpaClients or {}
			entity.sherpaClients[client] = character
			client.cotzSherpaVendor = entity
			ix.sherpa.SendStock(client, entity, record.id, entity:GetDisplayName(), manage and 2 or -1,
				manage and balance or 0, ix.plugin.Get("hideouts"):GetSaleCommission(), page, pages, visible)
		end)
	end)
end

function ix.sherpa.Action(client, entity, action, itemID, amount, revision)
	if not ix.sherpa.CanUse(client, entity) then return end
	local hideouts = ix.plugin.Get("hideouts")
	if entity.ixHideout then
		return hideouts:ShopAction(client, hideouts:GetHideout(entity.ixHideout), action, itemID, amount, revision)
	end
	local character = client:GetCharacter()
	if not entity.sherpaClients or entity.sherpaClients[client] ~= character then return end
	if action == "page" then ix.sherpa.Open(client, entity, amount) return end
	local record = ix.sherpa.GetRecord(entity)
	local stock = record.shop.inventoryID and ix.inventory.Get(record.shop.inventoryID)
	if not stock then return end
	local manage = ix.sherpa.CanManage(client, entity)
	if action ~= "buy" and not manage then return end
	local function authorized()
		return IsValid(client) and client:GetCharacter() == character and ix.sherpa.CanUse(client, entity)
			and entity.sherpaClients and entity.sherpaClients[client] == character
			and (action == "buy" or ix.sherpa.CanManage(client, entity))
	end
	local spec = {
		resolve = function() return IsValid(entity) and entity.sherpaRecord end,
		authorize = authorized,
	}
	local item = ix.item.instances[itemID]
	if action == "withdraw" then
		if amount < 1 or amount > MAX_PRICE then return end
		spec.moneyDelta, spec.treasuryDelta = amount, -amount
		spec.payload = {kind = "withdraw", amount = amount}
	elseif item and not hideouts:IsOperationLocked(item, stock, character:GetInventory()) then
		local listing = item:GetData("cotzHideoutStock", {})
		local ownedStock = item.invID == stock:GetID()
		if action == "price" then
			if not ownedStock or amount > MAX_PRICE or (listing.revision or 0) ~= revision then return end
			item:SetData("cotzHideoutStock", {price = amount, revision = (listing.revision or 0) + 1})
			ix.sherpa.Close(entity)
			return
		end
		if not hideouts:CanStockItem(client, item) then return end
		if action == "donate" then
			if item.invID ~= character:GetInventory():GetID() then return end
			spec.from, spec.to = character:GetInventory(), stock
		elseif action == "recover" or action == "buy" then
			if not ownedStock then return end
			if action == "buy" and ((listing.price or 0) < 1 or listing.price ~= amount
				or (listing.revision or 0) ~= revision) then return end
			spec.from, spec.to = stock, character:GetInventory()
		else
			return
		end
		if item.CanTransfer and item:CanTransfer(spec.from, spec.to) == false
			or hook.Run("CanTransferItem", item, spec.from, spec.to) == false then return end
		spec.x, spec.y = spec.to:FindEmptySlot(item.width, item.height, true)
		if not spec.x then client:Notify("The destination inventory is full.") return end
		spec.item, spec.data = item, table.Copy(item.data)
		spec.data.cotzHideoutStock = action == "donate" and {price = 0, revision = 1} or nil
		spec.moneyDelta = action == "buy" and -amount or 0
		spec.treasuryDelta = action == "buy" and amount - math.floor(amount * hideouts:GetSaleCommission() / 100) or 0
		spec.payload = {kind = action == "buy" and "sale" or action, item = itemID}
	else
		return
	end
	hideouts:CommitOperation(client, record, spec, function(ok, reason)
		ix.sherpa.Close(entity)
		if IsValid(client) then client:Notify(ok and "Vendor transaction complete." or reason) end
	end)
end

function PLUGIN:CanTransferHideoutItem(item, current, target)
	if current and current.vars and current.vars.sherpa or target and target.vars and target.vars.sherpa then
		local hideouts = ix.plugin.Get("hideouts")
		if hideouts and hideouts.applyingOperation then return end
		return false
	end
end

function PLUGIN:CanPlayerInteractItem(client, action, item)
	item = isnumber(item) and ix.item.instances[item] or item
	local inventory = istable(item) and ix.inventory.Get(item.invID)
	if inventory and inventory.vars and inventory.vars.sherpa then return false end
end

local ACTIONS = {
	[1] = "buy", [2] = "donate", [3] = "price", [4] = "recover", [5] = "withdraw", [6] = "history", [7] = "page",
}
net.Receive("cotz/sherpas/action", function(_, client)
	if not client:GetCharacter() or (client.cotzSherpaAction or 0) > CurTime() then return end
	client.cotzSherpaAction = CurTime() + 0.5
	local entity, session = net.ReadEntity(), net.ReadUInt(32)
	local action = ACTIONS[net.ReadUInt(3)]
	if session ~= client.cotzSherpaSession or client.cotzSherpaVendor ~= entity then return end
	local itemID, amount, revision = net.ReadUInt(32), net.ReadUInt(32), net.ReadUInt(32)
	if action then ix.sherpa.Action(client, entity, action, itemID, amount, revision) end
end)

net.Receive("cotz/sherpas/close", function(_, client)
	local session = net.ReadUInt(32)
	if session ~= client.cotzSherpaSession or (client.cotzSherpaClose or 0) > CurTime() then return end
	client.cotzSherpaClose = CurTime() + 0.1
	local entity = client.cotzSherpaVendor
	if IsValid(entity) then
		if entity.sherpaClients then entity.sherpaClients[client] = nil end
		local hideouts = ix.plugin.Get("hideouts")
		local instance = entity.ixHideout and hideouts.instances[entity.ixHideout]
		if instance and instance.shopClients then instance.shopClients[client] = nil end
	end
	client.cotzSherpaVendor = nil
end)

function ix.sherpa.CaptureAppearance(entity)
	return {
		model = entity:GetModel(), name = entity:GetDisplayName(), description = entity:GetDescription(),
		idleanim = entity:GetIdleAnim(), animgroup = entity:GetAnimGroupId(), soundgroup = entity:GetSoundGroup(),
		bubble = entity:GetNoBubble(),
	}
end

function ix.sherpa.ApplyAppearance(entity, appearance)
	appearance = appearance or {}
	entity:SetModel(appearance.model or "models/mossman.mdl")
	entity:InitPhysObj()
	entity:SetDisplayName(appearance.name or "Squad Vendor")
	entity:SetDescription(appearance.description or "")
	entity:SetIdleAnim(appearance.idleanim or "")
	entity:SetAnimGroupId(appearance.animgroup or 0)
	entity:SetSoundGroup(appearance.soundgroup or "nosound")
	entity:SetNoBubble(appearance.bubble == true)
	entity:SetSherpa(true)
	entity:SetAnim()
end

function ix.sherpa.SaveAppearance(entity)
	if not entity.ixHideout then return end
	local hideouts = ix.plugin.Get("hideouts")
	local record = hideouts:GetHideout(entity.ixHideout)
	if not record then return end
	record.vendorAppearance = ix.sherpa.CaptureAppearance(entity)
	hideouts:AuditVendor(hideouts.instances[record.id])
	hideouts:Persist()
end

function ix.sherpa.ValidateAppearanceEdit(client, entity, key, value)
	if not ix.sherpa.IsVendor(entity) or not client:GetCharacter()
		or client:GetPos():DistToSqr(entity:GetPos()) > USE_DISTANCE_SQUARED
		or (client.cotzSherpaEdit or 0) > CurTime() then return false end
	if entity.ixHideout then
		local hideouts = ix.plugin.Get("hideouts")
		local instance = hideouts and hideouts.instances[entity.ixHideout]
		if not instance or instance.state ~= "active" or instance.saving
			or (instance.operations or 0) > 0 or entity.cotzVendorHeld then return false end
	end
	client.cotzSherpaEdit = CurTime() + 0.1
	if key == "bubble" then return isbool(value) end
	if not isstring(value) or #value > 2048 then return false end
	if key == "name" or key == "description" then return true end
	if key == "model" then return #value <= 256 and util.IsValidModel(value) end
	if key == "soundgroup" then return ix.npctemplates.soundtemplates[value] ~= nil end
	if key == "animgroup" then return ix.npctemplates.animtemplates[value] ~= nil end
	if key == "idleanim" then return value == "" or entity:LookupSequence(value) >= 0 end

	return false
end

function PLUGIN:PlayerDisconnected(client)
	local entity = client.cotzSherpaVendor
	if IsValid(entity) and entity.sherpaClients then entity.sherpaClients[client] = nil end
end

function PLUGIN:EntityRemoved(entity)
	if entity.sherpaClients then ix.sherpa.Close(entity) end
end

function ix.sherpa.OpenPersonalStorage(client, entity)
	if not ix.sherpa.CanUse(client, entity) or (client.cotzSherpaStorage or 0) > CurTime() then return end
	client.cotzSherpaStorage = CurTime() + 0.5
	local character = client:GetCharacter()
	local personal = ix.plugin.Get("personalstorage")
	if not personal then return end
	personal:GetPersonalInventory(character, function(inventory)
		if IsValid(client) and client:GetCharacter() == character and ix.sherpa.CanUse(client, entity) then
			personal:OpenPersonalInventory(client, inventory, entity)
		end
	end)
end
