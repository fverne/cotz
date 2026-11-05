AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Hideout Template Marker"
ENT.Category = "Helix"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.bNoPersist = true

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "MarkerRole")
	self:NetworkVar("String", 1, "SlotID")
	self:NetworkVar("String", 2, "RecipeID")
end

if SERVER then
	function ENT:Initialize()
		local plugin = ix.plugin.Get("hideouts")
		local role = self:GetMarkerRole() ~= "" and self:GetMarkerRole() or "container"
		local slotID = self:GetSlotID()
		if slotID == "" then
			slotID = "storage_" .. util.SHA256(SysTime() .. ":" .. self:EntIndex()):sub(1, 12)
		end
		plugin:ApplyMarkerSettings(self, role, slotID, self:GetRecipeID() ~= "" and self:GetRecipeID() or "general")
		self:SetUseType(SIMPLE_USE)
	end

	function ENT:Use(client)
		if IsValid(client) and client:IsPlayer() then
			ix.plugin.Get("hideouts"):OpenMarkerMenu(client, self)
		end
	end

	function ENT:PreEntityCopy()
		duplicator.StoreEntityModifier(self, "cotzHideoutMarker", {
			role = self:GetMarkerRole(), slot = self:GetSlotID(), recipe = self:GetRecipeID(),
		})
	end
else
	function ENT:OnPopulateEntityInfo(tooltip)
		local plugin = ix.plugin.Get("hideouts")
		local role = plugin.markerRoles[self:GetMarkerRole()]
		local row = tooltip:AddRow("hideoutMarker")
		row:SetImportant()
		row:SetText("Hideout marker: " .. (role and role.name or "Invalid role"))
		row:SizeToContents()
		local details = tooltip:AddRow("hideoutMarkerDetails")
		details:SetText(self:GetMarkerRole() == "container"
			and self:GetSlotID() .. " / " .. self:GetRecipeID() .. " — E to configure"
			or "E to configure; save this marker with the shell dupe")
		details:SizeToContents()
	end
end
