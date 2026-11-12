local PLUGIN = PLUGIN

function PLUGIN:CanBuildInHideout(client)
	if CLIENT then return client:GetLocalVar("hideoutBuilder", false) end
	local instance = self.instances[self.members[client]]
	local record = instance and self:GetHideout(instance.id)

	return instance and instance.state == "active" and not instance.saving
		and self:Contains(client:GetPos(), instance.mins, instance.maxs)
		and (record.ownerType == "squad" or record.furnishingLevel == 1)
		and self:CanManageHideout(client, record) or false
end

function PLUGIN:GetHideoutEntityPermission(client, entity, property)
	if entity:GetClass() == "ix_hideout_vendor" then
		if property == "vendor_edit" then return client:IsAdmin() end
		if client:IsAdmin() and (property == "skin" or property == "bodygroups") then return true end
	end
	local id = SERVER and entity.ixHideout or entity:GetNetVar("cotzHideoutID")
	local memberID = SERVER and self.members[client] or client:GetLocalVar("hideout")
	if not id then
		if entity:GetClass() == "ix_hideout_marker" then
			return client:IsAdmin()
		end
		if entity:GetClass():find("^ix_hideout_") then return false end
		if self:CanBuildInHideout(client) then return false end
		return
	end
	if SERVER then
		local instance = self.instances[id]
		if not instance or instance.state ~= "active" or instance.saving or memberID ~= id then return false end
		if not self:CanBuildInHideout(client) then return false end
		if property == "remover" then return self:CanRemoveHideoutProp(client, entity) end
		if entity.ixHideoutSlot and (instance.containers or {})[entity.ixHideoutSlot] == entity then
			if (instance.operations or 0) > 0 then return false end
			if entity.cotzContainerHeld and entity.cotzContainerHeld ~= client then return false end
			return self:CanManageContainer(client, self:GetHideout(id), entity.ixHideoutSlot)
		end

		return instance.props[entity] == true or instance.vendor == entity
	end
	if property == "remover" then
		return memberID == id and self:CanBuildInHideout(client) and self:CanRemoveHideoutProp(client, entity)
	end

	return memberID == id and self:CanBuildInHideout(client) and entity:GetNetVar("hideoutEditable", false)
end

function PLUGIN:CanRemoveHideoutProp(client, entity)
	local character = client:GetCharacter()
	if not character then return false end
	if CLIENT then return entity:GetNetVar("hideoutPlacedBy") == character:GetID() end
	local instance = self.instances[entity.ixHideout]

	return instance ~= nil and instance.props[entity] == true and entity.cotzPlacedBy == character:GetID()
end

function PLUGIN:CharacterHasFlags(character, flags)
	local client = character:GetPlayer()
	if IsValid(client) and self:CanBuildInHideout(client) and flags:find("[pet]") then return true end
end

local previousPickup = PLUGIN.PhysgunPickup
function PLUGIN:PhysgunPickup(client, entity)
	local allowed = self:GetHideoutEntityPermission(client, entity)
	if allowed == false then return false end
	if allowed == true then
		if SERVER and entity.ixHideout then
			local instance = self.instances[entity.ixHideout]
			if instance.vendor == entity then
				entity.cotzVendorHeld = true
				self:CloseShop(instance)
			end
		end
		return
	end
	if previousPickup then return previousPickup(self, client, entity) end
end

function PLUGIN:CanTool(client, trace, tool)
	if not IsValid(trace.Entity) then
		if self:CanBuildInHideout(client) then return false end
		return
	end
	local allowed = self:GetHideoutEntityPermission(client, trace.Entity, tool)
	if allowed == false then return false end
	if allowed == true then
		if trace.Entity:GetClass() == "ix_hideout_marker" then return end
		if not self.furnishingTools[tool] then return false end
		if (tool == "stacker" or tool == "stacker_improved")
			and trace.Entity:GetClass() == "ix_hideout_vendor" then return false end
		if trace.Entity:GetClass() == "ix_hideout_vendor" and tool == "remover" then return false end
		if trace.Entity:GetClass() == "ix_hideout_storage" then return false end
		if SERVER then
			if tool == "remover" then
				for _, entity in pairs(constraint.GetAllConstrainedEntities(trace.Entity)) do
					if not self:GetHideoutEntityPermission(client, entity, "remover") then return false end
				end
			end
			local instance = self.instances[trace.Entity.ixHideout]
			if instance.vendor == trace.Entity then self:CloseShop(instance) end
		end
	end
end

function PLUGIN:CanProperty(client, property, entity)
	if property == "vendor_edit" and entity:GetClass() == "ix_hideout_vendor" then
		return client:IsAdmin()
	end
	local allowed = self:GetHideoutEntityPermission(client, entity, property)
	if allowed == false then return false end
	if allowed == true then
		if entity:GetClass() == "ix_hideout_marker" then return end
		-- Helix's final gamemode handler denies these for non-admins. This narrow override is intentional.
		if property == "remover" then return true end
		return self.furnishingProperties[property] == true
	end
end

if SERVER then
	PLUGIN.temporaryTools = PLUGIN.temporaryTools or {}
	local previousLeave = PLUGIN.LeaveHideout
	function PLUGIN:LeaveHideout(client, teleport, preserveReturn)
		local ok, reason = previousLeave(self, client, teleport, preserveReturn)
		self:AuditBuildingTools()

		return ok, reason
	end
	local previousSpawn = PLUGIN.PlayerSpawnProp
	function PLUGIN:PlayerSpawnProp(client, model)
		local instance = self.instances[self.members[client]]
		local record = instance and self:GetHideout(instance.id)
		if record and not self:CanBuildInHideout(client) then return false end

		return previousSpawn(self, client, model)
	end

	function PLUGIN:AuditBuildingTools()
		for _, client in ipairs(player.GetHumans()) do
			local allowed = self:CanBuildInHideout(client)
			if client:GetLocalVar("hideoutBuilder", false) ~= allowed then
				client:SetLocalVar("hideoutBuilder", allowed)
			end
			local granted = self.temporaryTools[client]
			if allowed and not granted then
				granted = {}
				for _, class in ipairs({"weapon_physgun", "gmod_tool"}) do
					if not client:HasWeapon(class) then client:Give(class) granted[class] = true end
				end
				self.temporaryTools[client] = granted
			elseif not allowed and granted then
				local character = client:GetCharacter()
				local flags = character and character:GetFlags() or ""
				if granted.weapon_physgun and not flags:find("p", 1, true) then client:StripWeapon("weapon_physgun") end
				if granted.gmod_tool and not flags:find("t", 1, true) then client:StripWeapon("gmod_tool") end
				self.temporaryTools[client] = nil
			end
		end
		for client in pairs(self.temporaryTools) do
			if not IsValid(client) then self.temporaryTools[client] = nil end
		end
	end

	function PLUGIN:OnPhysgunReload(weapon, client)
		if self.members[client] then return false end
	end

	function PLUGIN:OnPhysgunFreeze(weapon, physics, entity, client)
		if self:GetHideoutEntityPermission(client, entity) == false then return false end
	end

	function PLUGIN:OnPhysgunPickup(client, entity)
		local instance = entity.ixHideout and self.instances[entity.ixHideout]
		if instance and entity.ixHideoutSlot and (instance.containers or {})[entity.ixHideoutSlot] == entity then
			entity.cotzContainerHeld = client
			self:CloseStorage(instance)
		end
	end

	function PLUGIN:PhysgunDrop(client, entity)
		local instance = entity.ixHideout and self.instances[entity.ixHideout]
		if instance and instance.vendor == entity then
			entity.cotzVendorHeld = nil
			self:AuditVendor(instance)
			self:Persist()
		end
		if instance and entity.ixHideoutSlot then
			entity.cotzContainerHeld = nil
			self:AuditContainers(instance)
			if not self:Persist() then
				client:Notify("Could not save the container position. The next hideout checkpoint will retry.")
			end
		end
	end

	function PLUGIN:CanPlayerHoldObject(client, entity)
		if entity:GetClass() == "ix_hideout_storage" then return false end
		if self:GetHideoutEntityPermission(client, entity) == false then return false end
	end

	PLUGIN.GravGunPickupAllowed = PLUGIN.CanPlayerHoldObject

	function PLUGIN:EntityRemoved(entity)
		local instance = entity.ixHideout and self.instances[entity.ixHideout]
		if not instance then return end
		instance.props[entity] = nil
		instance.entities[entity] = nil
		if instance.vendor == entity then self:CloseShop(instance) end
	end
end
