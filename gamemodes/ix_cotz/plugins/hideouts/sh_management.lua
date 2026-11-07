local PLUGIN = PLUGIN

ix.command.Add("HideoutRecoveryOpen", {
	adminOnly = true,
	arguments = {ix.type.string, ix.type.string},
	OnRun = function(self, client, id, slotID)
		local _, reason = PLUGIN:OpenRecoveryInventory(client, id, slotID)
		return reason
	end,
})

ix.command.Add("HideoutSquadGrant", {
	adminOnly = true,
	arguments = {ix.type.player, ix.type.string, ix.type.text},
	OnRun = function(self, client, target, template, name)
		local _, reason = PLUGIN:GrantSquadHideout(target, template, name, function(ok, result)
			if IsValid(client) then
				client:Notify(ok and "Created squad hideout #" .. result .. ". Officers can place its entrance." or result)
			end
		end)
		return reason
	end,
})

ix.command.Add("HideoutEntrancePlace", {
	adminOnly = true,
	arguments = ix.type.string,
	OnRun = function(self, client, id)
		local _, reason = PLUGIN:PlaceSquadEntrance(client, PLUGIN:GetHideout(id))
		return reason
	end,
})

ix.command.Add("HideoutVendorReset", {
	adminOnly = true,
	arguments = ix.type.string,
	OnRun = function(self, client, id)
		local _, reason = PLUGIN:ResetVendor(client, PLUGIN:GetHideout(id))
		return reason
	end,
})

ix.command.Add("HideoutContainerUpgrade", {
	adminOnly = true,
	arguments = {ix.type.string, ix.type.string},
	OnRun = function(self, client, id, slotID)
		local _, reason = PLUGIN:UpgradeContainer(client, PLUGIN:GetHideout(id), slotID)
		return reason
	end,
})

ix.command.Add("HideoutContainerPublic", {
	adminOnly = true,
	arguments = {ix.type.string, ix.type.string, ix.type.bool},
	OnRun = function(self, client, id, slotID, public)
		local _, reason = PLUGIN:SetContainerPublic(client, PLUGIN:GetHideout(id), slotID, public)
		return reason
	end,
})

ix.command.Add("HideoutManage", {
	adminOnly = true,
	arguments = bit.bor(ix.type.string, ix.type.optional),
	OnRun = function(self, client, id)
		PLUGIN:ShowManagement(client, id)
	end,
})

ix.command.Add("HideoutAccess", {
	adminOnly = true,
	arguments = {ix.type.string, ix.type.string},
	OnRun = function(self, client, id, mode)
		local _, reason = PLUGIN:SetAccessMode(client, PLUGIN:GetHideout(id), mode)
		return reason
	end,
})

ix.command.Add("HideoutTemplateContainer", {
	adminOnly = true,
	arguments = {ix.type.string, ix.type.string, ix.type.string},
	OnRun = function(self, client, templateID, slotID, recipeID)
		local template = PLUGIN.state.templates[templateID]
		local instance = PLUGIN:FindInstance(client:GetPos())
		local record = instance and PLUGIN:GetHideout(instance.id)
		if not template or not record or record.template ~= templateID then
			return "Stand inside a loaded hideout using that template."
		end
		if not slotID:match("^[%w_%-]+$") or #slotID > 32 or not PLUGIN.containerRecipes[recipeID] then
			return "Use a stable slot ID (up to 32 letters/digits/_/-) and general, ammo, medical, or weapon."
		end
		for _, other in pairs(PLUGIN.instances) do
			local markerRoles = other.template and other.template.dupeMarkerRoles
			if PLUGIN:GetHideout(other.id).template == templateID and markerRoles and markerRoles.container then
				return "This template uses container markers. Edit the build markers, save the dupe and reload it."
			end
			if PLUGIN:GetHideout(other.id).template == templateID
				and (other.state ~= "active" or other.saving or (other.operations or 0) > 0) then
				return "Wait for this template's hideouts to finish loading or saving."
			end
		end
		template.containers = template.containers or {}
		if not template.containers[slotID] and table.Count(template.containers) >= 32 then
			return "This template already has 32 storage spots."
		end
		local previous = template.containers[slotID]
		if previous and previous.recipe ~= recipeID then return "A slot's recipe ID cannot be changed in place." end
		template.containers[slotID] = {
			pos = client:GetPos() - instance.origin + Vector(0, 0, 16),
			angles = Angle(0, client:EyeAngles().y, 0), recipe = recipeID,
		}
		if not PLUGIN:Persist() then template.containers[slotID] = previous return "Could not save the slot." end
		for _, other in pairs(PLUGIN.instances) do
			local otherRecord = PLUGIN:GetHideout(other.id)
			-- Personal slots are resolved on entry and only instantiate after their trader purchase.
			if otherRecord.ownerType ~= "squad" then continue end
			if otherRecord.template == templateID then
				other.containers = other.containers or {}
				local definition = template.containers[slotID]
				local entity = other.containers[slotID]
				if not IsValid(entity) then
					entity = PLUGIN:CreateUtility(other, "ix_hideout_storage", definition.pos,
						"models/props_junk/wood_crate001a.mdl")
					entity.ixHideoutSlot = slotID
					other.containers[slotID] = entity
				end
				entity:SetPos(other.origin + definition.pos)
				entity:SetAngles(definition.angles)
			end
		end
		return "Storage spot saved. Reload personal rooms to update trader offers; squad officers can install it inside."
	end,
})

if SERVER then
	function PLUGIN:SetAccessMode(client, record, mode)
		if not self:CanManageHideout(client, record) or record.ownerType ~= "squad" then
			return false, "Only this squad's leader or officers can change access."
		end
		if mode ~= "public" and mode ~= "invite" and mode ~= "squad" then return false, "Invalid access mode." end
		local previous = record.access
		record.access = mode
		if not self:Persist() then record.access = previous return false, "Could not save access." end
		local instance = self.instances[record.id]
		if instance then self:CloseStorage(instance) self:EnforceAccess(instance) end

		return true, "Hideout access updated."
	end
end
