local PLUGIN = PLUGIN
local previousRestore = PLUGIN.RestoreStorage
local previousClose = PLUGIN.CloseStorage
local previousTransfer = PLUGIN.CanTransferHideoutItem
local previousInteract = PLUGIN.CanPlayerInteractItem
local USE_DISTANCE_SQUARED = 128 * 128
PLUGIN.inventoryLoads = PLUGIN.inventoryLoads or {}
PLUGIN.recoverySessions = PLUGIN.recoverySessions or {}

function PLUGIN:GetContainer(record, slotID)
	if not record then return end
	slotID = tostring(slotID)
	local template = self:GetTemplate(record)
	local savedLayout = record.personalLayout and next(record.personalLayout) and record.personalLayout
	local definitions = not self.instances[record.id] and savedLayout or template and template.containers
	local definition = definitions and definitions[slotID]
	if not definition then return end
	record.containers = record.containers or {}
	record.containers[slotID] = record.containers[slotID] or {tier = 0, public = false}
	local slot = record.containers[slotID]
	if slot.recipe and slot.recipe ~= definition.recipe then return end
	slot.recipe = definition.recipe

	return slot, definition
end

function PLUGIN:CanUseContainer(client, record, slotID)
	local slot = self:GetContainer(record, slotID)
	local character = IsValid(client) and client:GetCharacter()
	if not slot or not character or not self:CanAccess(client, record) then return false end

	if record.ownerType == "squad" then
		local rank = self:GetSquadRank(client, record)

		return rank ~= nil and rank >= (slot.minimumRank or 0)
	end

	return record.owner == character:GetID() or slot.public == true
		or (slot.guests or {})[tostring(character:GetID())] == true
end

function PLUGIN:SetContainerGuest(client, record, slotID, characterID, allowed)
	local slot = record and self:GetContainer(record, slotID)
	local key = tostring(characterID)
	if not slot or record.ownerType == "squad" or not self:CanManageContainer(client, record, slotID)
		or not (record.guests or {})[key] then return false, "Choose an invited character." end
	slot.guests = slot.guests or {}
	local previous = slot.guests[key]
	slot.guests[key] = allowed == true or nil
	if not self:Persist() then slot.guests[key] = previous return false, "Could not save container access." end
	local inventory = slot.inventoryID and ix.inventory.Get(slot.inventoryID)
	if inventory then self:CloseInventoryStorage(inventory) end

	return true, "Container access updated."
end

function PLUGIN:CanManageContainer(client, record, slotID)
	return self:CanManageHideout(client, record) and self:CanUseContainer(client, record, slotID)
end

function PLUGIN:SetContainerRank(client, record, slotID, minimum)
	if minimum ~= 0 and minimum ~= 1 and minimum ~= 2 then return false, "Invalid storage access." end
	local slot = record and self:GetContainer(record, slotID)
	if not slot or record.ownerType ~= "squad" or not self:CanManageContainer(client, record, slotID) then
		return false, "Only authorized officers or leaders can change storage access."
	end
	if minimum > self:GetSquadRank(client, record) then return false, "That access requires the leader." end
	local previous = slot.minimumRank
	slot.minimumRank = minimum
	if not self:Persist() then slot.minimumRank = previous return false, "Could not save storage access." end
	local inventory = slot.inventoryID and ix.inventory.Get(slot.inventoryID)
	if inventory then self:CloseInventoryStorage(inventory) end

	return true, "Storage access updated."
end

function PLUGIN:IsNearUtility(client, entity)
	local instance = IsValid(entity) and self.instances[entity.ixHideout]
	if not instance or instance.state ~= "active" or instance.saving then return false end
	local record = self:GetHideout(instance.id)

	return self.members[client] == instance.id and self:CanAccess(client, record)
		and client:GetPos():DistToSqr(entity:GetPos()) <= USE_DISTANCE_SQUARED
end

function PLUGIN:LoadOwnedInventory(record, key, state, inventoryType, width, height, callback, saveAssignment)
	local loadKey = record.id .. ":" .. key
	if state.assignmentPending then
		state.assignmentPending = nil
		local saved = saveAssignment and saveAssignment() or not saveAssignment and self:Persist()
		if not saved then state.assignmentPending = true callback(nil) return end
	end
	if self.inventoryLoads[loadKey] then
		if #self.inventoryLoads[loadKey] >= 64 then callback(nil) return end
		table.insert(self.inventoryLoads[loadKey], callback)
		return
	end
	local inventory = state.inventoryID and ix.inventory.Get(state.inventoryID)
	if inventory and inventory.w == width and inventory.h == height then
		inventory.vars.hideout, inventory.vars.hideoutSlot = record.id, key
		callback(inventory)
		return
	end
	if inventory then self:CloseInventoryStorage(inventory) end
	self.inventoryLoads[loadKey] = {callback}
	local function finish(loaded)
		loaded:SetSize(width, height)
		loaded.vars.hideout = record.id
		loaded.vars.hideoutSlot = key
		if not state.inventoryID then
			state.inventoryID = loaded:GetID()
			local saved = saveAssignment and saveAssignment() or not saveAssignment and self:Persist()
			if not saved then
				ErrorNoHalt("[Hideouts] Could not persist inventory assignment " .. loadKey .. "\n")
				-- Keep the assignment for retry; never allocate another inventory over this one.
				state.assignmentPending = true
				local callbacks = self.inventoryLoads[loadKey]
				self.inventoryLoads[loadKey] = nil
				for _, complete in ipairs(callbacks) do complete(nil) end
				return
			end
		end
		local callbacks = self.inventoryLoads[loadKey]
		self.inventoryLoads[loadKey] = nil
		for _, complete in ipairs(callbacks) do complete(loaded) end
	end
	if state.inventoryID then
		ix.inventory.Restore(state.inventoryID, width, height, finish)
	else
		ix.inventory.New(0, inventoryType, finish)
	end
end

function PLUGIN:RestoreStorage(instance, callback)
	previousRestore(self, instance, function(ok, reason)
		if not ok then callback(false, reason) return end
		local record = self:GetHideout(instance.id)
		local template = self:GetTemplate(record)
		instance.containers = {}
		for slotID, definition in pairs(template.containers or {}) do
			local slot = self:GetContainer(record, slotID)
			if not slot then callback(false, "A saved container's recipe changed: " .. slotID) return end
			local recipe = self:GetContainerRecipe(record, definition)
			local tier = recipe and recipe.tiers[slot.tier or 0]
			if record.ownerType ~= "squad" and not tier then continue end
			local model = slot.model or tier and (tier.model or ix.item.list[tier.item] and ix.item.list[tier.item].model)
			local entity = self:CreateUtility(instance, "ix_hideout_storage", definition.pos,
				model or "models/z-o-m-b-i-e/st/equipment_cache/st_equipment_box_01.mdl")
			if not IsValid(entity) then callback(false, "Could not create a storage spot.") return end
			entity.ixHideoutSlot = slotID
			entity:SetAngles(definition.angles or angle_zero)
			instance.containers[slotID] = entity
		end
		if record.ownerType == "squad" then
			self:RestoreShop(instance, callback)
		else
			callback(true)
		end
	end)
end

function PLUGIN:OpenContainerInventory(client, entity)
	if not self:IsNearUtility(client, entity) then return end
	if (client.ixNextHideoutStorage or 0) > CurTime() then return end
	client.ixNextHideoutStorage = CurTime() + 0.5
	if not self.operationsReady then client:Notify("Storage recovery is still initializing.") return end
	local record = self:GetHideout(entity.ixHideout)
	local slotID = entity.ixHideoutSlot
	if not slotID then
		client:Notify("This is a legacy recovery point. Use the installed storage containers.")
		return
	end
	local slot = self:GetContainer(record, slotID)
	if not self:CanUseContainer(client, record, slotID) then
		client:Notify("This container is private.")
		return
	end
	if (slot.tier or 0) == 0 then
		client:Notify("This container has not been installed yet.")
		return
	end
	local character = client:GetCharacter()
	self:LoadOwnedInventory(record, slotID, slot, "cotzHideoutContainer", slot.width, slot.height,
		function(inventory)
			if not inventory then return end
			if not IsValid(client) or client:GetCharacter() ~= character
				or not self:IsNearUtility(client, entity) or not self:CanUseContainer(client, record, slotID) then return end
			ix.storage.Open(client, inventory, {
				entity = entity, name = record.name .. " / " .. slotID, searchTime = 0,
			})
		end)
end

function PLUGIN:OpenStorage(client, entity)
	if not self:IsNearUtility(client, entity) then return end
	local record = self:GetHideout(entity.ixHideout)
	if entity.ixHideoutSlot and self:CanManageContainer(client, record, entity.ixHideoutSlot) then
		if (client.cotzHideoutMenuOpen or 0) > CurTime() then return end
		client.cotzHideoutMenuOpen = CurTime() + 0.5
		self:ShowContainerMenu(client, entity)
	else
		self:OpenContainerInventory(client, entity)
	end
end

function PLUGIN:SetContainerPublic(client, record, slotID, public)
	local slot = self:GetContainer(record, slotID)
	if not slot or record.ownerType == "squad" or not self:CanManageContainer(client, record, slotID) then
		return false, "Only the owner can change this."
	end
	local previous = slot.public
	slot.public = public == true
	if not self:Persist() then slot.public = previous return false, "Could not save access." end
	local inventory = slot.inventoryID and ix.inventory.Get(slot.inventoryID)
	if inventory then self:CloseInventoryStorage(inventory) end

	return true, slot.public and "Container public to invited guests." or "Container private."
end

function PLUGIN:UpgradeContainer(client, record, slotID, expectedTier)
	if record and record.ownerType ~= "squad" then
		return false, "Purchase personal storage upgrades through the local hideout contact's barter menu."
	end
	local slot, definition = self:GetContainer(record, slotID)
	local instance = record and self.instances[record.id]
	local entity = instance and instance.containers and instance.containers[slotID]
	if not slot or not self:CanManageContainer(client, record, slotID) or not self:IsNearUtility(client, entity) then
		return false, "An authorized owner or squad officer must stand near that container."
	end
	if expectedTier ~= nil and expectedTier ~= (slot.tier or 0) then
		return false, "That container has already changed. Reopen management."
	end
	local recipe = self.containerRecipes[definition.recipe]
	local tierNumber = (slot.tier or 0) + 1
	local tier = recipe and recipe.tiers[tierNumber]
	if not tier then return false, "No further upgrade is configured." end
	if not ix.item.list[tier.item] then return false, "The configured container item is unavailable." end
	if tier.width < (slot.width or 1) or tier.height < (slot.height or 1) then
		return false, "This recipe would shrink saved storage; an administrator must correct it."
	end
	local inventory = client:GetCharacter():GetInventory()
	local input = inventory:HasItem(tier.item)
	if not input or not self:CanStockItem(client, input) then return false, "You need the required container item." end
	local character = client:GetCharacter()
	self:LoadOwnedInventory(record, slotID, slot, "cotzHideoutContainer", slot.width or 1, slot.height or 1,
		function(storage)
			if not storage then return end
			if not IsValid(client) or client:GetCharacter() ~= character or not self:IsNearUtility(client, entity)
				or not self:CanManageContainer(client, record, slotID)
				or (slot.tier or 0) + 1 ~= tierNumber or input.invID ~= inventory:GetID() then return end
			self:CloseInventoryStorage(storage)
			self:CommitOperation(client, record, {
				item = input, from = inventory, consume = true,
				rank = record.ownerType == "squad" and math.max(1, slot.minimumRank or 0) or nil,
				authorize = function()
					return self:IsNearUtility(client, entity) and self:CanManageContainer(client, record, slotID)
				end,
				payload = {kind = "upgrade", slot = slotID, tier = tierNumber, width = tier.width, height = tier.height},
			}, function(ok, reason)
				if ok then
					slot.tier, slot.width, slot.height = tierNumber, tier.width, tier.height
					storage:SetSize(tier.width, tier.height)
					if IsValid(entity) then
						entity:SetModel(tier.model or ix.item.list[tier.item].model)
						entity:PhysicsInit(SOLID_VPHYSICS)
						local physics = entity:GetPhysicsObject()
						if IsValid(physics) then physics:EnableMotion(false) end
					end
					if not self:Persist() then
						self.operationsReady = false
						ErrorNoHalt("[Hideouts] Upgrade committed; restart to replay its entitlement.\n")
					end
				end
				if IsValid(client) then
					client:Notify(ok and "Container upgraded." or reason)
					if self.RefreshManagementMenu then self:RefreshManagementMenu(client) end
				end
			end)
		end)

	return true
end

function PLUGIN:ContainerAccepts(record, slotID, item)
	local _, definition = self:GetContainer(record, slotID)
	local recipe = definition and self:GetContainerRecipe(record, definition)
	if not recipe or item.isBag or item:GetData("id") then return false end
	if recipe.filter == "ammo" then return item.isAmmo == true end
	if recipe.filter == "medical" then return item.base == "base_aid" end
	if recipe.filter == "weapon" then return item.isWeapon == true end

	return recipe.filter == "general"
end

function PLUGIN:CanTransferHideoutItem(item, current, target, client)
	if self.applyingOperation then return end
	if self:IsOperationLocked(item, current, target) then return false end
	client = client or item.player or current and current.GetOwner and current:GetOwner()
	local dropping = target and target == ix.item.inventories[0]
	if dropping and IsValid(client) and self.CanDropPersonalItem
		and self:CanDropPersonalItem(client, item) == false then return false end
	if current and current.vars and current.vars.hideoutRecovery
		or target and target.vars and target.vars.hideoutRecovery then
		local session = self.recoverySessions[client]
		if session and IsValid(client) and client:IsAdmin() and client:GetCharacter() == session.character
			and client:GetPos():DistToSqr(session.position) <= USE_DISTANCE_SQUARED
			and current == session.inventory and target == session.character:GetInventory() then return end
		return false
	end
	local floor = self:GetItemLocation(item)
	local currentID, targetID = self:GetStorageHideout(current), self:GetStorageHideout(target)
	if currentID and targetID and currentID ~= targetID then return false end
	if floor and item.invID == 0 then
		local id = tostring(floor.id)
		if not IsValid(client) or self.members[client] ~= id or targetID and targetID ~= id then return false end
	end
	for _, inventory in pairs({current = current, target = target}) do
		local id = inventory.vars and inventory.vars.hideout
		local slotID = inventory.vars and inventory.vars.hideoutSlot
		if id and slotID then
			if slotID == "shop" then return false end
			local record = self:GetHideout(id)
			local instance = self.instances[id]
			local entity = instance and instance.containers and instance.containers[slotID]
			if not IsValid(client) or not self:IsNearUtility(client, entity)
				or not self:CanUseContainer(client, record, slotID) then return false end
			if inventory == target and not self:ContainerAccepts(record, slotID, item) then return false end
		end
	end
	local id = self:GetStorageHideout(current) or self:GetStorageHideout(target)
	if id and ((current and current.vars and current.vars.hideoutSlot)
		or (target and target.vars and target.vars.hideoutSlot)) then return end
	local location = self:GetItemLocation(item)
	local record = location and self:GetHideout(location.id)
	if record and record.ownerType == "squad" and self:GetSquadRank(client, record) == nil then return false end

	return previousTransfer(self, item, current, target, client)
end

function PLUGIN:OpenRecoveryInventory(client, id, slotID)
	if not client:IsAdmin() then return false, "Administrator access required." end
	local record = self:GetHideout(id) or self.state.retired and self.state.retired[id]
	local slot = record and (slotID == "shop" and record.shop or (record.containers or {})[slotID])
	if not slot or not slot.inventoryID then return false, "No saved inventory for that hideout and spot." end
	local character = client:GetCharacter()
	local position = client:GetPos()
	self:LoadOwnedInventory(record, slotID, slot, "cotzHideoutContainer", slot.width or 1, slot.height or 1,
		function(inventory)
			if not inventory then return end
			if not IsValid(client) or client:GetCharacter() ~= character then return end
			self:CloseInventoryStorage(inventory)
			inventory.vars.hideoutRecovery = true
			self.recoverySessions[client] = {inventory = inventory, character = character, position = position}
			ix.storage.Open(client, inventory, {entity = client, name = "Hideout recovery: " .. id .. "/" .. slotID,
				searchTime = 0})
		end)

	return true, "Recovery opened; withdraw items into your main inventory."
end

function PLUGIN:AuditRecoverySessions()
	for client, session in pairs(self.recoverySessions) do
		if not IsValid(client) or client:GetCharacter() ~= session.character
			or client:GetPos():DistToSqr(session.position) > USE_DISTANCE_SQUARED
			or not table.HasValue(session.inventory:GetReceivers(), client) then
			self:CloseInventoryStorage(session.inventory, IsValid(client) and client or nil)
			session.inventory.vars.hideoutRecovery = nil
			self.recoverySessions[client] = nil
		end
	end
end

function PLUGIN:CanPlayerInteractItem(client, action, value)
	local item = isentity(value) and self:GetEntityItem(value)
		or isnumber(value) and ix.item.instances[value] or value
	if istable(item) and item.GetID then
		local inventory = ix.inventory.Get(item.invID)
		if self:IsOperationLocked(item, inventory) then return false end
		if inventory and inventory.vars and inventory.vars.hideoutSlot then
			if self:CanTransferHideoutItem(item, inventory, nil, client) == false then return false end
		end
		local location = self:GetItemLocation(item)
		local record = location and self:GetHideout(location.id)
		if record and record.ownerType == "squad" and self:GetSquadRank(client, record) == nil then return false end
	end

	return previousInteract(self, client, action, value)
end

function PLUGIN:CloseStorage(instance, onlyClient)
	previousClose(self, instance, onlyClient)
	local record = self:GetHideout(instance.id)
	for _, slot in pairs(record and record.containers or {}) do
		local inventory = slot.inventoryID and ix.inventory.Get(slot.inventoryID)
		if inventory then self:CloseInventoryStorage(inventory, onlyClient) end
	end
	if self.CloseShop then self:CloseShop(instance, onlyClient) end
end

function PLUGIN:AuditContainerAccess(instance)
	local record = self:GetHideout(instance.id)
	for slotID, slot in pairs(record and record.containers or {}) do
		local inventory = slot.inventoryID and ix.inventory.Get(slot.inventoryID)
		if inventory then
			for _, client in ipairs(table.Copy(inventory:GetReceivers())) do
				if not IsValid(client) or not self:CanUseContainer(client, record, slotID) then
					self:CloseInventoryStorage(inventory, client)
				end
			end
		end
	end
end
