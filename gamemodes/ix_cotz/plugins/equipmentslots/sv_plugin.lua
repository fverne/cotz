local PLUGIN = PLUGIN

util.AddNetworkString("cotz/equipment/refresh")
util.AddNetworkString("cotz/equipment/action")

PLUGIN.restoring = {}
PLUGIN.pending = setmetatable({}, {__mode = "k"})
PLUGIN.refreshing = {}

function PLUGIN:ShouldRestoreInventory(characterID, inventoryID, inventoryType)
	if not inventoryType then self.restoring[tonumber(inventoryID)] = true end
end

function PLUGIN:OnCharacterCreated(client, character)
	self:ConfigureInventory(character:GetInventory())
end

function PLUGIN:CharacterLoaded(character)
	self:ConfigureInventory(character:GetInventory())
end

function PLUGIN:QueueRefresh(inventory)
	local id = inventory:GetID()
	if self.refreshing[id] then return end
	self.refreshing[id] = true
	timer.Simple(0, function()
		self.refreshing[id] = nil
		if ix.item.inventories[id] ~= inventory then return end
		local receivers = inventory:GetReceivers()
		if #receivers == 0 then return end
		inventory:Sync(receivers)
		net.Start("cotz/equipment/refresh")
			net.WriteUInt(id, 32)
		net.Send(receivers)
	end)
end

function PLUGIN:RelocateItem(item, inventory, x, y)
	inventory:Remove(item.id, true, true, true)
	item.gridX = x
	item.gridY = y

	for column = x, x + item.width - 1 do
		inventory.slots[column] = inventory.slots[column] or {}

		for row = y, y + item.height - 1 do
			inventory.slots[column][row] = item
		end
	end

	self:QueueRefresh(inventory)
end

function PLUGIN:GetPending(client)
	local pending = self.pending[client]
	if pending and (pending.expires < CurTime()
		or (pending.delayed and not client:GetNetVar("ix_hasBlackScreen"))) then
		self.pending[client] = nil
		return
	end

	return pending
end

function PLUGIN:RunWithContext(context, callback)
	local previous = self.actionContext
	local oldPlayer = context.item.player
	self.actionContext = context
	context.item.player = context.client
	-- Item callbacks are foreign code. Always release our context if one raises an error, then report it.
	local success, result = xpcall(callback, debug.traceback)
	context.item.player = oldPlayer
	self.actionContext = previous
	if not success then
		self.pending[context.client] = nil
		error(result, 0)
	end

	return result
end

function PLUGIN:ValidateContext(context)
	local client = context.client
	if not IsValid(client) or client:GetCharacter() ~= context.character then return false end
	if ix.item.instances[context.item.id] ~= context.item then return false end
	if (context.item:GetData("equip") == true) ~= context.wasEquipped then return false end
	local allowed, reason = self:CheckEquipmentAction(context.item, client, context.equipping)
	if not allowed then client:Notify(reason) return false end
	local callback = context.item.functions[context.action]

	return not callback.OnCanRun or callback.OnCanRun(context.item) ~= false
end

function PLUGIN:InstallServerCompatibility()
	if self.serverOriginals then return end
	local originals = {
		Restore = ix.inventory.Restore,
		SetData = ix.meta.item.SetData,
		PerformInventoryAction = ix.item.PerformInventoryAction,
		BlackScreenAction = ix.util.PlayerPerformBlackScreenAction,
	}
	self.serverOriginals = originals

	function ix.inventory.Restore(ids, width, height, callback)
		if not istable(ids) then return originals.Restore(ids, width, height, callback) end
		local dimensions = {}
		local expanded = {}

		for id, info in pairs(ids) do
			expanded[id] = info
			if PLUGIN.restoring[id] then
				PLUGIN.restoring[id] = nil
				dimensions[id] = {info[1], info[2]}
				expanded[id] = {PLUGIN.storageWidth, math.max(info[2], PLUGIN.storageHeight), info[3]}
			end
		end

		return originals.Restore(expanded, width, height, function(inventory)
			local size = dimensions[inventory:GetID()]
			if size then PLUGIN:ConfigureInventory(inventory, size[1], size[2]) end
			if callback then callback(inventory) end
		end)
	end

	function ix.meta.item:SetData(key, value, receivers, noSave, noCheckEntity)
		local inventory = ix.item.inventories[self.invID]
		local slots = key == "equip" and PLUGIN:GetItemSlots(self) or {}
		if #slots == 0 or not inventory or not inventory.vars.cotzEquipmentWidth
			or (self:GetData("equip") == true) == (value == true) then
			return originals.SetData(self, key, value, receivers, noSave, noCheckEntity)
		end
		local x, y

		if value == true then
			x, y = PLUGIN:GetStoragePosition(slots[1])
			local fits = PLUGIN.inventoryOriginals.CanItemFit(inventory, x, y, self.width, self.height, self)
			if not fits then error("The equipment storage region is already occupied", 2) end
		elseif PLUGIN:IsEquipmentCell(self.gridX) then
			local context = PLUGIN.actionContext
			if not (context and context.item == self and context.dropping) then
				x, y = inventory:FindEmptySlot(self.width, self.height, true)
				if not x then error("Equipment must have backpack space before unequipping", 2) end
			end
		end

		if x then PLUGIN:RelocateItem(self, inventory, x, y) end
		PLUGIN:QueueRefresh(inventory)
		originals.SetData(self, key, value, receivers, true, noCheckEntity)
		if not noSave and not inventory.noSave then
			local query = mysql:Update("ix_items")
				query:Update("data", util.TableToJSON(self.data))
				query:Update("x", self.gridX)
				query:Update("y", self.gridY)
				query:Where("item_id", self.id)
			query:Execute()
		end
	end

	function ix.item.PerformInventoryAction(client, action, target, inventoryID, data)
		local item = isnumber(target) and ix.item.instances[target] or target
		if not istable(item) or #PLUGIN:GetItemSlots(item) == 0 then
			return originals.PerformInventoryAction(client, action, target, inventoryID, data)
		end
		if PLUGIN:GetPending(client) then return end
		if (client.cotzEquipmentNextAction or 0) > CurTime() then return end
		client.cotzEquipmentNextAction = CurTime() + 0.25
		local equipping = action == "Equip"
		local changing = equipping or action == "EquipUn"
		if not changing then
			-- A drop goes straight to the world; it must not require a temporary backpack position.
			if (action == "drop" or action == "throwaway") and PLUGIN:IsEquipmentCell(item.gridX) then
				local allowed, reason = PLUGIN:CheckEquipmentAction(item, client, false, true)
				if not allowed then client:Notify(reason) return end
				local context = {item = item, client = client, character = client:GetCharacter(), dropping = true}

				return PLUGIN:RunWithContext(context, function()
					return originals.PerformInventoryAction(client, action, target, inventoryID, data)
				end)
			end

			return originals.PerformInventoryAction(client, action, target, inventoryID, data)
		end
		if not item.functions[action] then return end
		local allowed, reason = PLUGIN:CheckEquipmentAction(item, client, equipping)
		if not allowed then client:Notify(reason) return end
		local context = {
			item = item, client = client, character = client:GetCharacter(), action = action,
			equipping = equipping, wasEquipped = item:GetData("equip") == true, expires = CurTime() + 1,
		}
		PLUGIN.pending[client] = context
		local result = PLUGIN:RunWithContext(context, function()
			return originals.PerformInventoryAction(client, action, target, inventoryID, data)
		end)
		if not context.delayed then PLUGIN.pending[client] = nil end

		return result
	end

	function ix.util.PlayerPerformBlackScreenAction(client, text, duration, callback)
		local context = PLUGIN.actionContext
		if not context or context.client ~= client or context.dropping then
			return originals.BlackScreenAction(client, text, duration, callback)
		end
		context.delayed = true
		context.expires = CurTime() + duration + 1
		timer.Simple(duration + 1, function()
			if PLUGIN.pending[client] == context then PLUGIN.pending[client] = nil end
		end)

		return originals.BlackScreenAction(client, text, duration, function(player)
			if PLUGIN.pending[player] ~= context then return end
			PLUGIN:RunWithContext(context, function()
				if PLUGIN:ValidateContext(context) and callback then callback(player) end
			end)
			PLUGIN.pending[player] = nil
		end)
	end
end

net.Receive("cotz/equipment/action", function(_, client)
	if (client.cotzEquipmentNextRequest or 0) > CurTime() then return end
	client.cotzEquipmentNextRequest = CurTime() + 0.25
	local item = ix.item.instances[net.ReadUInt(32)]
	local index = net.ReadUInt(4)
	local equipping = net.ReadBool()
	if not item or not PLUGIN.slots[index] then return end
	local matches = false

	for _, slotIndex in ipairs(PLUGIN:GetItemSlots(item)) do
		if slotIndex == index then matches = true break end
	end

	if not matches then return end
	-- A third-party drop veto can leave an already unequipped item in its reserved cells.
	if not equipping and not item:GetData("equip") and PLUGIN:IsEquipmentCell(item.gridX) then
		if PLUGIN:GetPending(client) then return end
		local allowed, reason = PLUGIN:CheckEquipmentAction(item, client, false)
		if not allowed then client:Notify(reason) return end
		local inventory = client:GetCharacter():GetInventory()
		local x, y = inventory:FindEmptySlot(item.width, item.height, true)
		PLUGIN:RelocateItem(item, inventory, x, y)
		if not inventory.noSave then
			local query = mysql:Update("ix_items")
				query:Update("x", x)
				query:Update("y", y)
				query:Where("item_id", item.id)
			query:Execute()
		end
		return
	end

	ix.item.PerformInventoryAction(client, equipping and "Equip" or "EquipUn", item, item.invID)
end)
