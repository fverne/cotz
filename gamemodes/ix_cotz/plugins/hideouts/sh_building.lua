local PLUGIN = PLUGIN

function PLUGIN:CanBuildInHideout(client)
	if CLIENT then return client:GetLocalVar("hideoutBuilder", false) end
	local instance = self.instances[self.members[client]]
	local record = instance and self:GetHideout(instance.id)

	return instance and instance.state == "active" and not instance.saving
		and self:Contains(client:GetPos(), instance.mins, instance.maxs)
		and record.ownerType == "squad" and self:CanManageHideout(client, record) or false
end

function PLUGIN:GetHideoutEntityPermission(client, entity)
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
		local record = self:GetHideout(id)
		if record.ownerType ~= "squad" then
			if instance.props[entity] then return nil end
			return false
		end
		return self:CanBuildInHideout(client) and (instance.props[entity] == true or instance.vendor == entity)
	end

	return memberID == id and self:CanBuildInHideout(client) and entity:GetNetVar("hideoutEditable", false)
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
	local allowed = self:GetHideoutEntityPermission(client, trace.Entity)
	if allowed == false then return false end
	if allowed == true then
		if trace.Entity:GetClass() == "ix_hideout_marker" then return end
		if not self.furnishingTools[tool] then return false end
		if trace.Entity:GetClass() == "ix_hideout_vendor" and tool == "remover" then return false end
		if SERVER then
			local instance = self.instances[trace.Entity.ixHideout]
			if instance.vendor == trace.Entity then self:CloseShop(instance) end
		end
	end
end

function PLUGIN:CanProperty(client, property, entity)
	local allowed = self:GetHideoutEntityPermission(client, entity)
	if allowed == false then return false end
	if allowed == true then
		if entity:GetClass() == "ix_hideout_marker" then return end
		-- Helix's final gamemode handler denies these for non-admins. This narrow override is intentional.
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
		if record and record.ownerType == "squad" and not self:CanBuildInHideout(client) then return false end

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

	function PLUGIN:PhysgunDrop(client, entity)
		local instance = entity.ixHideout and self.instances[entity.ixHideout]
		if instance and instance.vendor == entity then
			entity.cotzVendorHeld = nil
			self:AuditVendor(instance)
			self:Persist()
		end
	end

	function PLUGIN:CanPlayerHoldObject(client, entity)
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
