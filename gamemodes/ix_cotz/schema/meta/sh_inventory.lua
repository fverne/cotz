local inventoryMeta = ix.meta.inventory or {}

function inventoryMeta:GetItemCountNonSpecific(onlyMain)
	local count = 0

	for _ in pairs(self:GetItems(onlyMain)) do
		count = count + 1
	end

	return count
end

-- These overrides place hideout hooks inside the authoritative inventory update.
if SERVER then
	local function fillSlots(inventory, item, x, y, value)
		for offsetX = 0, item.width - 1 do
			local column = x + offsetX
			inventory.slots[column] = inventory.slots[column] or {}

			for offsetY = 0, item.height - 1 do
				inventory.slots[column][y + offsetY] = value
			end
		end
	end

	local function addExistingItem(inventory, targetInventory, item, client, x, y, noReplication)
		local oldInventoryID = item.invID
		local oldInventory = ix.item.inventories[oldInventoryID or 0]
		local character = IsValid(client) and client:GetCharacter()

		if
			not item.bAllowMultiCharacterInteraction
			and character
			and item:GetPlayerID() == client:SteamID64()
			and item:GetCharacterID() ~= character:GetID()
		then
			return false, "itemOwned"
		end
		if hook.Run("CanTransferHideoutItem", item, oldInventory, targetInventory, client) == false then
			return false, "notAllowed"
		end
		if hook.Run("CanTransferItem", item, ix.item.inventories[0], targetInventory) == false then
			return false, "notAllowed"
		end
		if not x or not y then
			return false, "noFit"
		end

		targetInventory.slots[x] = targetInventory.slots[x] or {}
		targetInventory.slots[x][y] = true
		item.gridX = x
		item.gridY = y
		item.invID = targetInventory:GetID()
		fillSlots(targetInventory, item, x, y, item)

		if not noReplication then
			targetInventory:SendSlot(x, y, item)
		end
		if not inventory.noSave then
			local hideoutData = hook.Run("PrepareHideoutItemTransfer", item, oldInventory, targetInventory)
			local query = mysql:Update("ix_items")
			query:Update("inventory_id", targetInventory:GetID())

			if hideoutData then
				query:Update("data", util.TableToJSON(item.data))
			end

			query:Update("x", x)
			query:Update("y", y)
			query:Where("item_id", item.id)
			query:Execute()
		end

		hook.Run("InventoryItemAdded", ix.item.inventories[oldInventoryID], targetInventory, item)

		return x, y, targetInventory:GetID()
	end

	local function addNewItem(inventory, targetInventory, item, uniqueID, data, x, y, noReplication)
		if hook.Run("CanTransferItem", item, ix.item.inventories[0], targetInventory) == false then
			return false, "notAllowed"
		end
		if not x or not y then
			return false, "noFit"
		end

		fillSlots(targetInventory, item, x, y, true)
		local character = inventory.owner and ix.char.loaded[inventory.owner]
		local characterID = character and character.id
		local playerID = character and character.steamID

		ix.item.Instance(targetInventory:GetID(), uniqueID, data, x, y, function(newItem)
			newItem.gridX = x
			newItem.gridY = y
			fillSlots(targetInventory, newItem, x, y, newItem)

			if not noReplication then
				targetInventory:SendSlot(x, y, newItem)
			end

			hook.Run("InventoryItemAdded", nil, targetInventory, newItem)
		end, characterID, playerID)

		return x, y, targetInventory:GetID()
	end

	function inventoryMeta:Add(uniqueID, quantity, data, x, y, noReplication)
		quantity = quantity or 1

		if quantity < 1 then
			return false, "noOwner"
		end
		if not isnumber(uniqueID) and quantity > 1 then
			for _ = 1, quantity do
				local success, err = self:Add(uniqueID, 1, data)

				if not success then
					return false, err
				end
			end

			return true
		end

		local client = self.GetOwner and self:GetOwner() or nil
		local item = isnumber(uniqueID) and ix.item.instances[uniqueID] or ix.item.list[uniqueID]
		if not item then
			return false, "invalidItem"
		end

		local targetInventory = self
		local bagInventory
		if not x and not y then
			x, y, bagInventory = self:FindEmptySlot(item.width, item.height)
		end
		if bagInventory then
			targetInventory = bagInventory
		end
		if isnumber(uniqueID) then
			return addExistingItem(self, targetInventory, item, client, x, y, noReplication)
		end

		return addNewItem(self, targetInventory, item, uniqueID, data, x, y, noReplication)
	end
end
