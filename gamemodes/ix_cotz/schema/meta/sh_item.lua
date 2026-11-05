--[[
Interactable entities that can be held in inventories.

Items are objects contained inside an Inventory or dropped into the world. Definitions describe shared
properties and behavior; instances hold unique data such as an item ID or a custom description.
]]
-- @classmod Item

ix.meta.item = ix.meta.item or {}

--- Returns the material of the item.
-- @realm shared
-- @treturn string The material of the item
function ix.meta.item:GetMaterial()
	return self.material or ""
end

function ix.meta.item:GetColor()
	return self.color or Color(255, 255, 255, 255)
end

-- support for vanity/custom items
function ix.meta.item:GetName()
	return self:GetData("name", self.name)
end

function ix.meta.item:GetDescription()
	return self:GetData("description", self.description)
end

-- Schema override of the Helix method: keep hideout persistence hooks
-- here so the upstream framework remains unchanged.
if SERVER then
	function ix.meta.item:Transfer(invID, x, y, client, noReplication, isLogical)
		invID = invID or 0

		if self.invID == invID then
			return false, "same inv"
		end

		local inventory = ix.item.inventories[invID]
		local currentInventory = ix.item.inventories[self.invID or 0]
		if hook.Run("CanTransferHideoutItem", self, currentInventory, inventory, client) == false then
			return false, "notAllowed"
		end

		if currentInventory and not IsValid(client) then
			client = currentInventory.GetOwner and currentInventory:GetOwner() or nil
		end

		-- check if this item doesn't belong to another one of this player's characters
		local itemPlayerID = self:GetPlayerID()
		local itemCharacterID = self:GetCharacterID()

		if not self.bAllowMultiCharacterInteraction and IsValid(client) and client:GetCharacter() then
			local playerID = client:SteamID64()
			local characterID = client:GetCharacter():GetID()

			if itemPlayerID and itemCharacterID then
				if itemPlayerID == playerID and itemCharacterID ~= characterID then
					return false, "itemOwned"
				end
			else
				self.characterID = characterID
				self.playerID = playerID

				local query = mysql:Update("ix_items")
				query:Update("character_id", characterID)
				query:Update("player_id", playerID)
				query:Where("item_id", self:GetID())
				query:Execute()
			end
		end

		if hook.Run("CanTransferItem", self, currentInventory, inventory) == false then
			return false, "notAllowed"
		end

		local authorized = false

		if
			inventory
			and inventory.OnAuthorizeTransfer
			and inventory:OnAuthorizeTransfer(client, currentInventory, self)
		then
			authorized = true
		end

		if not authorized and self.CanTransfer and self:CanTransfer(currentInventory, inventory) == false then
			return false, "notAllowed"
		end

		if not currentInventory then
			return false, "invalidInventory"
		end
		if invID and invID > 0 and inventory then
			local targetInventory = inventory
			local bagInventory
			if not x and not y then
				x, y, bagInventory = inventory:FindEmptySlot(self.width, self.height)
			end
			if bagInventory then
				targetInventory = bagInventory
			end
			if not x or not y then
				return false, "noFit"
			end

			local previousID = self.invID
			local status, result = targetInventory:Add(self.id, nil, nil, x, y, noReplication)
			if not status then
				return false, result
			end
			if self.invID <= 0 then
				return
			end

			if previousID ~= 0 then
				currentInventory:Remove(self.id, false, true, true)
			else
				ix.item.inventories[0][self.id] = nil
			end
			if self.OnTransferred then
				self:OnTransferred(currentInventory, inventory)
			end
			hook.Run("OnItemTransferred", self, currentInventory, inventory)

			return true
		end
		if not IsValid(client) then
			return false, "noOwner"
		end

		self.invID = 0
		currentInventory:Remove(self.id, false, true)
		local query = mysql:Update("ix_items")
		query:Update("inventory_id", 0)
		if hook.Run("PrepareHideoutItemDrop", self, client) then
			query:Update("data", util.TableToJSON(self.data))
		end
		query:Where("item_id", self.id)
		query:Execute()

		inventory = ix.item.inventories[0]
		inventory[self:GetID()] = self
		if self.OnTransferred then
			self:OnTransferred(currentInventory, inventory)
		end
		hook.Run("OnItemTransferred", self, currentInventory, inventory)

		if not isLogical then
			return self:Spawn(client)
		end

		return true
	end
end
