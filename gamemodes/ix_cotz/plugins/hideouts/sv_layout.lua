local PLUGIN = PLUGIN
local RESET_COOLDOWN = 5

function PLUGIN:RememberContainerPosition(instance, slotID, entity)
	instance.containerValid = instance.containerValid or {}
	instance.containerValid[slotID] = {
		pos = entity:GetPos() - instance.origin,
		angles = entity:GetAngles(),
	}
end

function PLUGIN:AuditContainers(instance)
	local record = self:GetHideout(instance.id)
	for slotID, entity in pairs(instance.containers or {}) do
		if not IsValid(entity) then continue end
		if entity.cotzContainerHeld and not entity:IsPlayerHolding() then entity.cotzContainerHeld = nil end
		local slot, definition = self:GetContainer(record, slotID)
		if not slot then continue end
		local mins, maxs = entity:WorldSpaceAABB()
		if not self:Contains(mins, instance.mins, instance.maxs)
			or not self:Contains(maxs, instance.mins, instance.maxs) then
			local previous = (instance.containerValid or {})[slotID] or definition
			entity:SetPos(instance.origin + previous.pos)
			entity:SetAngles(previous.angles or angle_zero)
			local physics = entity:GetPhysicsObject()
			if IsValid(physics) then physics:EnableMotion(false) end
			self:CloseStorage(instance)
		else
			self:RememberContainerPosition(instance, slotID, entity)
		end
		local position = (instance.containerValid or {})[slotID]
		if position then slot.transform = table.Copy(position) end
	end
end

function PLUGIN:ResetHideoutLayout(client, record)
	if not record or not self:CanManageHideout(client, record) then
		return false, "Only the owner or squad officers can reset this hideout."
	end
	if self.members[client] ~= record.id and not self:IsNearEntrance(client, record.entrance) then
		return false, "Stand inside the hideout or near its entrance."
	end
	if (client.cotzLayoutReset or 0) > CurTime() then return false, "Please wait before resetting again." end
	client.cotzLayoutReset = CurTime() + RESET_COOLDOWN
	local instance = self.instances[record.id]
	if record.deleting or record.frozen or (self.personalPurchases or {})[record.id] or instance
		and (instance.state ~= "active" or instance.saving or (instance.operations or 0) > 0) then
		return false, "The hideout is busy."
	end
	local previousFurnishings = record.furnishings
	local furnishings, removed, positions = {}, {}, {}
	local characterID = client:GetCharacter():GetID()
	if instance then
		for entity in pairs(instance.props) do
			if not IsValid(entity) then continue end
			if self:CanRemoveHideoutProp(client, entity) then
				removed[#removed + 1] = entity
			else
				furnishings[#furnishings + 1] = self:SerializeProp(entity, instance.origin)
			end
		end
	else
		for _, data in ipairs(record.furnishings or {}) do
			if (data.placedBy or record.owner) ~= characterID then furnishings[#furnishings + 1] = data end
		end
	end
	for slotID, slot in pairs(record.containers or {}) do
		local _, definition = self:GetContainer(record, slotID)
		if definition and self:CanManageContainer(client, record, slotID) then
			local entity = instance and (instance.containers or {})[slotID]
			if IsValid(entity) and entity.cotzContainerHeld then
				return false, "Put down the containers before resetting the layout."
			end
			positions[#positions + 1] = {id = slotID, slot = slot, previous = slot.transform, default = definition}
		end
	end
	for _, position in ipairs(positions) do position.slot.transform = nil end
	record.furnishings = furnishings
	if not self:Persist() then
		record.furnishings = previousFurnishings
		for _, position in ipairs(positions) do position.slot.transform = position.previous end

		return false, "Could not save the hideout layout."
	end
	if instance then
		self:CloseStorage(instance)
		for _, entity in ipairs(removed) do
			instance.props[entity] = nil
			entity:Remove()
		end
		for _, position in ipairs(positions) do
			local entity = (instance.containers or {})[position.id]
			if not IsValid(entity) then continue end
			entity.cotzContainerHeld = nil
			entity:SetPos(instance.origin + position.default.pos)
			entity:SetAngles(position.default.angles or angle_zero)
			local physics = entity:GetPhysicsObject()
			if IsValid(physics) then physics:EnableMotion(false) end
			self:RememberContainerPosition(instance, position.id, entity)
		end
	end

	return true, "Hideout layout reset. Stored items and purchased upgrades retained."
end
