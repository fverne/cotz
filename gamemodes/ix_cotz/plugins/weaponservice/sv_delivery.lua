local PLUGIN = PLUGIN
local STATE_KEY = "weaponWorkshop"
local DELIVERY_KEY = "weaponWorkshopDelivery"
local deliveries = {}

function PLUGIN:NotifyWorkshop(character, message)
	local client = character:GetPlayer()
	if IsValid(client) and client:GetCharacter() == character then client:Notify(message) end
end

function PLUGIN:RefreshWorkshopWeight(character)
	if not ix.weight then return end
	character:SetData("carry", ix.weight.CalculateWeight(character))
	local client = character:GetPlayer()
	if IsValid(client) and client:GetCharacter() == character then character:UpdateWeight() end
end

function PLUGIN:QueueWorkshopItems(character, rewards)
	local state = table.Copy(character:GetData(STATE_KEY, {}))
	state.pending = state.pending or {}
	assert(#state.pending + #rewards <= self.settings.maxPending, "Workshop delivery queue is full")
	for _, reward in ipairs(rewards) do
		state.serial = (state.serial or 0) + 1
		state.pending[#state.pending + 1] = {
			item = reward.item, data = table.Copy(reward.data or {}),
			token = character:GetID() .. "/" .. state.serial,
		}
	end
	character:SetData(STATE_KEY, state)
end

function PLUGIN:ConfirmWorkshopDelivery(character, item)
	local state = table.Copy(character:GetData(STATE_KEY, {}))
	local reward = state.pending and state.pending[1]
	if not reward or reward.item ~= item.uniqueID or item:GetData(DELIVERY_KEY) ~= reward.token then return end
	local owner = character:GetID()
	deliveries[owner] = {character = character, token = reward.token}
	character.cotzWorkshopBusy = true
	item.cotzWorkshopLocked = true
	table.remove(state.pending, 1)
	character:SetData(STATE_KEY, state)
	self:RefreshWorkshopWeight(character)
	-- Keep the delivered item unusable until the receipt is durable, including across character changes.
	character:Save(function()
		item.cotzWorkshopLocked = nil
		character.cotzWorkshopBusy = nil
		deliveries[owner] = nil
		timer.Simple(0, function()
			if ix.plugin.Get("weaponservice") == PLUGIN then PLUGIN:DeliverWorkshopItem(character) end
		end)
	end)
end

function PLUGIN:DeliverWorkshopItem(character)
	local client = character:GetPlayer()
	if not IsValid(client) or client:GetCharacter() ~= character then return false end
	local reward = self:Pending(character)[1]
	if not reward then return false end
	local inventory = character:GetInventory()
	for _, item in pairs(inventory:GetItems()) do
		if item.uniqueID == reward.item and item:GetData(DELIVERY_KEY) == reward.token then
			self:ConfirmWorkshopDelivery(character, item)

			return true
		end
	end
	local owner = character:GetID()
	if deliveries[owner] or character.cotzWorkshopBusy then return false end
	local active = 0
	for _ in pairs(deliveries) do active = active + 1 end
	if active >= self.settings.maxDeliveries then return false end
	deliveries[owner] = {character = character, token = reward.token}
	character.cotzWorkshopBusy = true
	local data = table.Copy(reward.data)
	data[DELIVERY_KEY] = reward.token
	-- Add returns a reserved slot before the database insert. InventoryItemAdded acknowledges it.
	local result = inventory:Add(reward.item, 1, data)
	if not result then
		deliveries[owner] = nil
		character.cotzWorkshopBusy = nil
		self:NotifyWorkshop(character, "Your workshop items are stored. Make inventory space and collect them at a technician.")
	end

	return result ~= false and result ~= nil
end

function PLUGIN:InventoryItemAdded(_, inventory, item)
	local token = item:GetData(DELIVERY_KEY)
	if not token then return end
	local owner = item:GetCharacterID() or inventory.owner
	local delivery = deliveries[owner]
	local loaded = ix.char.loaded[owner]
	local character = delivery and delivery.character or loaded
	if loaded and loaded ~= character then
		-- A reconnect can restore a new character/inventory object before an older insert callback.
		-- Keep its token in flight until the restored inventory actually contains the inserted row.
		if loaded:GetInventory():GetItems()[item.id] ~= item then return end
		character = loaded
	end
	if character then self:ConfirmWorkshopDelivery(character, item) end
end

function PLUGIN:PlayerLoadedCharacter(client, character)
	timer.Simple(0, function()
		if ix.plugin.Get("weaponservice") == PLUGIN and IsValid(client) and client:GetCharacter() == character then
			PLUGIN:DeliverWorkshopItem(character)
		end
	end)
end

function PLUGIN:CanPlayerInteractItem(_, _, value)
	local item = type(value) == "number" and ix.item.instances[value] or value
	if type(item) == "table" and item.cotzWorkshopLocked then return false end
end

function PLUGIN:CanTransferItem(item)
	if item.cotzWorkshopLocked then return false end
end

function PLUGIN:CanPlayerTradeWithVendor(client, _, uniqueID, selling)
	local item = ix.item.list[uniqueID]
	if not item or not item.isWeaponServiceItem then return end
	if not item.componentKind or not selling then return false end
	for _, instance in pairs(client:GetCharacter():GetInventory():GetItems()) do
		if instance.uniqueID == uniqueID and instance.cotzWorkshopLocked then return false end
	end
end
