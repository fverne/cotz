local PLUGIN = PLUGIN
local PAGE_SIZE = 60
local QUOTE_LIFETIME = 120
local previousRestore = PLUGIN.RestoreStorage
local previousSaveFloor = PLUGIN.SaveFloorItem
PLUGIN.personalPurchases = PLUGIN.personalPurchases or {}
util.AddNetworkString("cotz/hideouts/personal-barter")
util.AddNetworkString("cotz/hideouts/personal-buy")

function PLUGIN:AddPersonalLocation(id, template, entrance, name)
	if not self.ready or not self.personalContacts[game.GetMap()] then return "No local hideout contact configured." end
	if not id:match("^[%w_%-]+$") or #id > 32 then return "Use a location ID of 1–32 letters/digits/_/-." end
	if not self.state.templates[template] or not self.state.entrances[entrance]
		or self.state.entrances[entrance].hideout then return "Choose a template and a fixed personal entrance." end
	self.state.locations = self.state.locations or {}
	if not self.state.locations[id] and table.Count(self.state.locations) >= 32 then return "Location limit reached." end
	local previous = self.state.locations[id]
	if previous and (previous.template ~= template or previous.entrance ~= entrance) then
		return "Keep location bindings stable; use a new ID for a different entrance or template."
	end
	self.state.locations[id] = {template = template, entrance = entrance, name = name:sub(1, 128)}
	if not self:Persist() then self.state.locations[id] = previous return "Could not save the location." end

	return "Location registered with " .. self.personalContacts[game.GetMap()].name .. "."
end

function PLUGIN:CanUsePersonalTrader(client, target)
	local contact = self.personalContacts[game.GetMap()]

	return self.ready and self.operationsReady and contact and client:GetCharacter()
		and IsValid(target) and target:GetClass() == "ix_vendor_adv" and target:GetDisplayName() == contact.name
		and target:CanAccess(client) and client:GetPos():DistToSqr(target:GetPos()) <= 192 * 192
end

function PLUGIN:OwnsPersonalLocation(character, id, location)
	for _, record in pairs(self.state.hideouts) do
		if record.ownerType ~= "squad" and record.owner == character:GetID()
			and (record.location == id or record.template == location.template and record.entrance == location.entrance) then
			return true
		end
	end

	return false
end

function PLUGIN:ClaimPersonalLocation(client, target, id)
	if not self:CanUsePersonalTrader(client, target) then return false, "Speak to the local hideout contact." end
	local location = (self.state.locations or {})[id]
	local character = client:GetCharacter()
	if not location or not self:GetPersonalUnlock(character, "claim", 1) then return false, "Location unavailable." end
	if self:OwnsPersonalLocation(character, id, location) then return false, "You already own a room at this location." end
	local ok, result = self:GrantHideout(client, location.template, location.entrance, location.name, id)

	return ok, ok and "Hideout unlocked. Use its entrance to initialize the room." or result
end

function PLUGIN:PreparePersonalStorage(instance)
	local record = self:GetHideout(instance.id)
	if record.ownerType == "squad" then return true end
	local template = self:GetTemplate(record)
	local definitions = table.Copy(template.containers or {})
	local general
	local ids = table.GetKeys(definitions)
	table.sort(ids)
	for _, id in ipairs(ids) do
		if definitions[id].recipe == "general" then general = id break end
	end
	if not general then
		general = "personal_starter"
		if definitions[general] then return false, "Reserve personal_starter for the default general crate." end
		definitions[general] = {recipe = "general", pos = template.storage, angles = template.storageAngles}
	end
	instance.template = setmetatable({containers = definitions}, {__index = template})
	record.containers = record.containers or {}
	if not record.personalVersion then
		-- Preserve installed legacy sizes and appearance. Future purchases may only grow either dimension.
		for id, slot in pairs(record.containers) do
			local recipe = self.containerRecipes[slot.recipe or definitions[id] and definitions[id].recipe]
			local tier = recipe and recipe.tiers[slot.tier or 0]
			local item = tier and ix.item.list[tier.item]
			if item then slot.model = item.model end
			local replacement = self.personalContainerRecipes[slot.recipe or definitions[id] and definitions[id].recipe]
			if replacement and (slot.tier or 0) > 0 then
				slot.tier = #replacement.tiers
				for level, candidate in ipairs(replacement.tiers) do
					if candidate.width >= (slot.width or 1) and candidate.height >= (slot.height or 1) then
						slot.tier = level
						break
					end
				end
			end
		end
		record.personalVersion = 1
	end
	if not record.starterSlot then
		record.starterSlot = general
		local slot = record.containers[general] or {tier = 0, public = false}
		if (slot.tier or 0) == 0 then
			local tier = self.personalContainerRecipes.general.tiers[1]
			slot.tier, slot.width, slot.height, slot.model = 1, tier.width, tier.height, tier.model
		end
		record.containers[general] = slot
	end
	for id, definition in pairs(definitions) do
		local slot = record.containers[id] or {tier = 0, public = false}
		if slot.recipe and slot.recipe ~= definition.recipe then return false, "A saved container recipe changed." end
		slot.recipe = definition.recipe
		record.containers[id] = slot
	end
	-- Remember marker slots so the exterior trader can work while the interior is unloaded.
	record.personalLayout = definitions

	return self:Persist(), "Could not save personal storage configuration."
end

function PLUGIN:RestoreStorage(instance, callback)
	local ok, reason = self:PreparePersonalStorage(instance)
	if not ok then callback(false, reason) return end

	return previousRestore(self, instance, callback)
end

function PLUGIN:RefreshPersonalContainer(record, slotID)
	local instance = self.instances[record.id]
	if not instance or instance.state ~= "active" then return end
	local slot, definition = self:GetContainer(record, slotID)
	if not slot then return end
	instance.containers = instance.containers or {}
	local entity = instance.containers[slotID]
	if not IsValid(entity) then
		local placement = slot.transform or definition
		entity = self:CreateUtility(instance, "ix_hideout_storage", placement.pos, slot.model, placement.angles)
		if not IsValid(entity) then
			ErrorNoHalt("[Hideouts] Purchased storage could not spawn; it will be restored on next entry.\n")
			return
		end
		entity.ixHideoutSlot = slotID
		instance.containers[slotID] = entity
	else
		entity:SetModel(slot.model)
		entity:PhysicsInit(SOLID_VPHYSICS)
		local physics = entity:GetPhysicsObject()
		if IsValid(physics) then physics:EnableMotion(false) end
	end
	self:RememberContainerPosition(instance, slotID, entity)
end

function PLUGIN:BuildPersonalOffer(client, record, feature, slotID)
	local character = client:GetCharacter()
	if not record or record.ownerType == "squad" or not character or record.owner ~= character:GetID()
		or record.deleting or record.frozen then return end
	local instance = self.instances[record.id]
	if instance and (instance.state ~= "active" or instance.saving) then return end
	local offer = {record = record.id, feature = feature, slot = slotID, price = 0}
	if feature == "container" then
		local slot, definition = self:GetContainer(record, slotID)
		if not slot or not record.starterSlot or not (record.personalLayout or {})[slotID] then return end
		local recipe = self:GetContainerRecipe(record, definition)
		offer.level = (slot.tier or 0) + 1
		local tier = recipe and recipe.tiers[offer.level]
		if not tier or tier.width < (slot.width or 1) or tier.height < (slot.height or 1) then return end
		offer.recipe, offer.width, offer.height, offer.model = definition.recipe, tier.width, tier.height, tier.model
		offer.price, offer.item = tier.price, tier.item
		offer.allowed, offer.reason = self:GetPersonalUnlock(character, definition.recipe, offer.level)
		offer.label = slotID .. ": " .. recipe.name .. " level " .. offer.level
		offer.detail = string.format("%d × %d slots; %s items", tier.width, tier.height, recipe.filter)
	elseif feature == "floor" then
		offer.level = (record.floorLevel or 0) + 1
		if offer.level > 12 then return end
		offer.price = math.ceil(self.personalUpgradePrices.floor * self.personalPriceMultiplier ^ (offer.level - 1))
		offer.allowed, offer.reason = self:GetPersonalUnlock(character, "floor", offer.level)
		offer.label = "Loose items: " .. (4 + 2 * offer.level) .. " (+2)"
		offer.detail = "Maximum item entities in this hideout."
	elseif feature == "furnishing" then
		if record.furnishingLevel == 1 then return end
		offer.level, offer.price = 1, self.personalUpgradePrices.furnishing
		offer.allowed, offer.reason = self:GetPersonalUnlock(character, "furnishing", 1)
		offer.label = "Props and PET access"
		offer.detail = "Owner only. Guests cannot move furnishings or use the building tools."
	else
		return
	end
	if offer.item and not ix.item.list[offer.item] then return end

	return offer
end

function PLUGIN:ApplyPersonalEntitlement(record, payload)
	if payload.feature == "container" then
		record.containers = record.containers or {}
		local slot = record.containers[payload.slot] or {tier = 0, public = false}
		if (slot.tier or 0) < payload.level then
			slot.tier, slot.width, slot.height, slot.model = payload.level, payload.width, payload.height, payload.model
			slot.recipe = payload.recipe
			record.containers[payload.slot] = slot
		end
	elseif payload.feature == "floor" then
		record.floorLevel = math.max(record.floorLevel or 0, payload.level)
	elseif payload.feature == "furnishing" then
		record.furnishingLevel = math.max(record.furnishingLevel or 0, payload.level)
	end
end

function PLUGIN:PurchasePersonalOffer(client, target, quote)
	if not self:CanUsePersonalTrader(client, target) then return false, "Speak to the local hideout contact." end
	local record = self:GetHideout(quote.record)
	local offer = self:BuildPersonalOffer(client, record, quote.feature, quote.slot)
	if not offer or not offer.allowed or offer.level ~= quote.level or offer.price ~= quote.price
		or offer.item ~= quote.item or offer.width ~= quote.width or offer.height ~= quote.height
		or offer.model ~= quote.model then return false, "That offer changed or is locked. Reopen barter." end
	if self.personalPurchases[record.id] then return false, "This hideout already has a purchase pending." end
	local character = client:GetCharacter()
	local inventory = character:GetInventory()
	local input = offer.item and inventory:HasItem(offer.item)
	if offer.item and (not input or input.invID ~= inventory:GetID() or not self:CanStockItem(client, input)) then
		return false, "Bring the required container item in your main inventory."
	end
	if not character:HasMoney(offer.price) then return false, "Not enough roubles." end
	self.personalPurchases[record.id] = true
	local instance = self.instances[record.id]
	if instance then instance.operations = (instance.operations or 0) + 1 end
	local function authorize()
		local current = self:BuildPersonalOffer(client, record, quote.feature, quote.slot)

		return client:GetCharacter() == character and self:CanUsePersonalTrader(client, target)
			and current and current.allowed and current.level == offer.level and current.price == offer.price
	end
	local function commit(storage)
		if not IsValid(client) or not authorize() or offer.feature == "container" and not storage then
			self.personalPurchases[record.id] = nil
			if instance then instance.operations = instance.operations - 1 end
			return
		end
		if storage then self:CloseInventoryStorage(storage) end
		local payload = {
			kind = "personal", feature = offer.feature, slot = offer.slot, level = offer.level,
			recipe = offer.recipe, width = offer.width, height = offer.height, model = offer.model,
		}
		self:CommitOperation(client, record, {
			item = input, from = input and inventory, consume = input ~= nil,
			moneyDelta = -offer.price, payload = payload, authorize = authorize,
		}, function(ok, reason)
			if ok then
				self:ApplyPersonalEntitlement(record, payload)
				if storage then
					storage:SetSize(payload.width, payload.height)
					self:RefreshPersonalContainer(record, payload.slot)
				end
				if not self:Persist() then
					self.operationsReady = false
					ErrorNoHalt("[Hideouts] Personal purchase committed; restart to replay its entitlement.\n")
				end
			end
			self.personalPurchases[record.id] = nil
			if instance then instance.operations = instance.operations - 1 end
			if IsValid(client) and client:GetCharacter() == character then
				client:Notify(ok and "Hideout upgrade purchased." or reason)
				if self:CanUsePersonalTrader(client, target) then self:OpenPersonalBarter(client, target, nil, true) end
			end
		end)
	end
	if offer.feature == "container" then
		local slot = self:GetContainer(record, offer.slot)
		self:LoadOwnedInventory(record, offer.slot, slot, "cotzHideoutContainer",
			slot.width or 1, slot.height or 1, commit)
	else
		commit()
	end

	return true
end

function PLUGIN:OpenPersonalBarter(client, target, page, refresh)
	if not self:CanUsePersonalTrader(client, target) then return end
	if not refresh and (client.cotzPersonalOpenAt or 0) > CurTime() then return end
	client.cotzPersonalOpenAt = CurTime() + 0.5
	page = math.max(1, page or client.cotzPersonalPage or 1)
	client.cotzPersonalPage = page
	local offers = {}
	local total, offset = 0, (page - 1) * PAGE_SIZE
	local function appendOffer(offer)
		total = total + 1
		if total > offset and #offers < PAGE_SIZE then offers[#offers + 1] = offer end
	end
	for id, location in SortedPairs(self.state.locations or {}) do
		if not self:OwnsPersonalLocation(client:GetCharacter(), id, location) then
			local allowed, reason = self:GetPersonalUnlock(client:GetCharacter(), "claim", 1)
			appendOffer({feature = "claim", location = id, label = "Unlock: " .. location.name,
				detail = "Free for now. One room per location.", allowed = allowed, reason = reason})
		end
	end
	for _, record in SortedPairs(self.state.hideouts) do
		if record.ownerType ~= "squad" and record.owner == client:GetCharacter():GetID() then
			local function append(feature, slotID)
				local offer = self:BuildPersonalOffer(client, record, feature, slotID)
				if not offer then return end
				offer.label = record.name:sub(1, 128) .. " (#" .. record.id .. ") / " .. offer.label
				appendOffer(offer)
			end
			for slotID in SortedPairs(record.personalLayout or {}) do append("container", slotID) end
			append("floor")
			append("furnishing")
		end
	end
	if page > 1 then
		offers[#offers + 1] = {feature = "page", page = page - 1, label = "Previous page", detail = "", allowed = true}
	end
	if total > offset + PAGE_SIZE then
		offers[#offers + 1] = {feature = "page", page = page + 1, label = "Next page", detail = "", allowed = true}
	end
	client.cotzPersonalRevision = ((client.cotzPersonalRevision or 0) + 1) % 4294967296
	client.cotzPersonalBarter = {
		character = client:GetCharacter(), target = target, expires = CurTime() + QUOTE_LIFETIME,
		offers = offers, revision = client.cotzPersonalRevision,
	}
	net.Start("cotz/hideouts/personal-barter")
	net.WriteUInt(client.cotzPersonalRevision, 32)
	net.WriteUInt(#offers, 9)
	for _, offer in ipairs(offers) do
		net.WriteString(offer.label:sub(1, 256))
		local cost = ix.currency.Get(offer.price or 0)
		if offer.item then cost = cost .. " + " .. ix.item.list[offer.item].name end
		local detail = offer.feature == "page" and "Browse more offers."
			or offer.detail .. "\n" .. cost .. (offer.allowed and "" or "\n" .. offer.reason)
		net.WriteString(detail:sub(1, 512))
		net.WriteBool(offer.allowed == true)
		net.WriteBool(offer.feature == "page")
	end
	net.Send(client)
end

function PLUGIN:HandlePersonalPurchase(client, index, revision)
	if (client.cotzPersonalBuyAt or 0) > CurTime() then return end
	client.cotzPersonalBuyAt = CurTime() + 0.5
	local session = client.cotzPersonalBarter
	if not session or revision ~= session.revision then return false end
	client.cotzPersonalBarter = nil
	if session.character ~= client:GetCharacter() or session.expires < CurTime()
		or not self:CanUsePersonalTrader(client, session.target) then return false end
	local offer = session.offers[index]
	if not offer or not offer.allowed then return end
	local ok, reason
	if offer.feature == "page" then
		self:OpenPersonalBarter(client, session.target, offer.page, true)
		return true
	elseif offer.feature == "claim" then
		ok, reason = self:ClaimPersonalLocation(client, session.target, offer.location)
		if ok then self:OpenPersonalBarter(client, session.target, nil, true) end
	else
		ok, reason = self:PurchasePersonalOffer(client, session.target, offer)
	end
	if reason then client:Notify(reason) end

	return ok
end

net.Receive("cotz/hideouts/personal-buy", function(_, client)
	local revision, index = net.ReadUInt(32), net.ReadUInt(9)
	PLUGIN:HandlePersonalPurchase(client, index, revision)
end)

function PLUGIN:CanDropPersonalItem(client, item)
	local instance = self.instances[self.members[client]] or self:FindInstance(client:GetPos())
	local record = instance and self:GetHideout(instance.id)
	if not record or record.ownerType == "squad" then return end
	if instance.state ~= "active" or instance.saving then return false end
	if self:ShouldQueuePersonalFloorItem(instance, item) then return false end
end

function PLUGIN:ShouldQueuePersonalFloorItem(instance, ignoredItem)
	local record = self:GetHideout(instance.id)
	if not record or record.ownerType == "squad" then return false end
	local count = 0
	for id, entity in pairs(instance.items) do
		if IsValid(entity) and not entity.cotzFloorQueuePending
			and (not ignoredItem or id ~= ignoredItem:GetID()) then count = count + 1 end
	end

	return count >= self:GetPersonalFloorLimit(record)
end

function PLUGIN:QueuePersonalFloorItem(instance, entity, callback)
	if entity.cotzFloorQueuePending then return end
	entity.cotzFloorQueuePending = true
	instance.operations = (instance.operations or 0) + 1
	-- Scripted outputs and old excess items keep their original rows, and reappear as floor space frees up.
	previousSaveFloor(self, instance, entity, function(ok)
		instance.operations = instance.operations - 1
		entity.cotzFloorQueuePending = nil
		local item = self:GetEntityItem(entity)
		if ok and item and item.invID == 0 and self.instances[instance.id] == instance then
			instance.queuedItems = instance.queuedItems or {}
			instance.queuedItems[item:GetID()] = true
			instance.items[item:GetID()] = nil
			entity.ixIsSafe = true
			entity:Remove()
			for client in pairs(instance.occupants) do
				if IsValid(client) and (client.cotzFloorQueueNoticeAt or 0) <= CurTime() then
					client.cotzFloorQueueNoticeAt = CurTime() + 10
					client:Notify("Floor capacity reached. Extra items are saved and will appear when space is free.")
				end
			end
		elseif not ok then
			ErrorNoHalt("[Hideouts] Could not verify overflow floor item; retained its live entity for retry.\n")
		end
		if callback then callback(ok) end
	end)
end

function PLUGIN:SaveFloorItem(instance, entity, callback)
	local item = self:GetEntityItem(entity)
	if item and not instance.items[item:GetID()] and self:ShouldQueuePersonalFloorItem(instance) then
		return self:QueuePersonalFloorItem(instance, entity, callback)
	end

	return previousSaveFloor(self, instance, entity, callback)
end

function PLUGIN:AuditPersonalFloorItems(instance)
	local record = self:GetHideout(instance.id)
	if not record or record.ownerType == "squad" or instance.saving then return end
	local count = 0
	for _, entity in pairs(instance.items) do
		if IsValid(entity) and not entity.cotzFloorQueuePending then
			count = count + 1
			if count > self:GetPersonalFloorLimit(record) then self:QueuePersonalFloorItem(instance, entity) end
		end
	end
	for id in pairs(instance.queuedItems or {}) do
		if self:ShouldQueuePersonalFloorItem(instance) then break end
		local item = ix.item.instances[id]
		local location = item and self:GetItemLocation(item)
		if item and item.invID == 0 and location then
			local entity = item:Spawn(instance.origin + location.pos, location.angles)
			if not IsValid(entity) then
				ErrorNoHalt("[Hideouts] Queued floor item could not spawn; retained for retry.\n")
				break
			end
			entity.bTemporary, entity.ixHideout = true, instance.id
			instance.items[id] = entity
		end
		instance.queuedItems[id] = nil
	end
end

function PLUGIN:CanPlayerDropItem(client, item)
	return self:CanDropPersonalItem(client, item)
end
