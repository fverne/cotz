local PLUGIN = PLUGIN
local MENU_DISTANCE_SQUARED = 128 * 128
local MAX_MANAGEMENT_GUESTS = 65535
local SCOPES = {[1] = "entrance", [2] = "exit", [3] = "vendor", [4] = "squad"}
util.AddNetworkString("cotz/hideouts/manage")
util.AddNetworkString("cotz/hideouts/manage-open")
util.AddNetworkString("cotz/hideouts/manage-action")
util.AddNetworkString("cotz/hideouts/container")

local function guestName(characterID)
	local character = ix.char.loaded[tonumber(characterID)]
	local name = character and character:GetName()
	if not name or not name:find("%S") then
		return "Character #" .. characterID
	end

	return name
end

function PLUGIN:IsManagementLocation(client, record, scope, slotID)
	if not record then return false end
	if scope == "admin" then return client:IsAdmin() end
	if scope == "squad" then return record.ownerType == "squad" and self:CanManageHideout(client, record) end
	if scope == "entrance" then return self:FindHideoutEntrance(client, record) ~= nil end
	local instance = self.instances[record.id]
	if not instance or self.members[client] ~= record.id then return false end
	if scope == "exit" then
		return IsValid(instance.exit) and client:GetPos():DistToSqr(instance.exit:GetPos()) <= MENU_DISTANCE_SQUARED
	end
	if scope == "vendor" then return self:IsNearUtility(client, instance.vendor) end
	if scope == "container" then
		local entity = instance.containers and instance.containers[slotID]
		return self:IsNearUtility(client, entity) and self:CanManageContainer(client, record, slotID)
	end

	return false
end

function PLUGIN:CanUseManagementMenu(client, id)
	local session = client.cotzHideoutMenu
	if not session or session.character ~= client:GetCharacter() or not session.ids[id] then return false end

	return self:IsManagementLocation(client, self:GetHideout(id), session.scope, session.slot)
end

function PLUGIN:OpenManagementMenu(client, id, scope)
	if not client:GetCharacter() or (client.cotzHideoutMenuOpen or 0) > CurTime() then return end
	client.cotzHideoutMenuOpen = CurTime() + 0.5
	self:ShowManagement(client, id, scope)
end

function PLUGIN:ShowManagement(client, id, scope)
	scope = scope or "admin"
	local records = {}
	local session = {character = client:GetCharacter(), scope = scope, ids = {}}
	for _, record in pairs(self.state.hideouts) do
		local allowed = self:CanManageHideout(client, record) or scope == "exit"
		if (not id or id == "" or record.id == id) and allowed
			and self:IsManagementLocation(client, record, scope) then
			records[#records + 1] = record
			session.ids[record.id] = true
			if #records == 8 then break end
		end
	end
	client.cotzHideoutMenu = session
	session.migrations = {}
	net.Start("cotz/hideouts/manage")
	net.WriteString(scope)
	net.WriteUInt(#records, 4)
	for _, record in ipairs(records) do
		net.WriteString(record.id)
		net.WriteString(self:GetHideoutName(record):sub(1, 256))
		net.WriteBool(record.ownerType == "squad")
		net.WriteString(record.access or "squad")
		net.WriteBool(self:CanManageHideout(client, record))
		net.WriteBool(self.members[client] == record.id or self:FindHideoutEntrance(client, record) ~= nil)
		net.WriteUInt(self:GetHideoutPropLimit(record), 7)
		net.WriteBool(self:GetSquadRank(client, record) == 2)
		net.WriteBool(record.fundUpgrades == true)
		local guests = {}
		if self:CanManageHideout(client, record) then
			for guestID, invited in SortedPairs(record.guests or {}) do
				if invited == true then
					guests[#guests + 1] = {
						id = tonumber(guestID), name = guestName(guestID),
					}
					if #guests == MAX_MANAGEMENT_GUESTS then break end
				end
			end
		end
		net.WriteUInt(#guests, 16)
		for _, guest in ipairs(guests) do
			net.WriteUInt(guest.id, 32)
			net.WriteString(guest.name:sub(1, 256))
		end
		local migration = scope == "entrance" and self:CanManageHideout(client, record)
			and self:GetPersonalMigrationOffer(record)
		if migration then session.migrations[record.id] = table.Copy(migration) end
		net.WriteString(migration and migration.target or "")
	end
	net.Send(client)
end

function PLUGIN:ShowContainerMenu(client, entity)
	if not self:IsNearUtility(client, entity) then return end
	local record = self:GetHideout(entity.ixHideout)
	if not self:CanManageContainer(client, record, entity.ixHideoutSlot) then return end
	local slot, definition = self:GetContainer(record, entity.ixHideoutSlot)
	if not slot then return end
	local recipe = self:GetContainerRecipe(record, definition)
	local contact = self.personalContacts[game.GetMap()]
	client.cotzHideoutMenu = {
		character = client:GetCharacter(), scope = "container", ids = {[record.id] = true},
		slot = entity.ixHideoutSlot,
	}
	net.Start("cotz/hideouts/container")
	net.WriteString(record.id)
	net.WriteString(entity.ixHideoutSlot)
	net.WriteString((recipe and recipe.name or "Storage container"):sub(1, 128))
	net.WriteUInt(slot.tier or 0, 8)
	net.WriteBool(slot.public == true)
	net.WriteBool(record.ownerType == "squad")
	net.WriteUInt(slot.minimumRank or 0, 2)
	net.WriteUInt(self:GetSquadRank(client, record) or 0, 2)
	net.WriteUInt(slot.width or 0, 6)
	net.WriteUInt(slot.height or 0, 6)
	net.WriteString(contact and contact.name or "")
	local guests = {}
	if record.ownerType ~= "squad" then
		for id, invited in SortedPairs(record.guests or {}) do
			if invited ~= true then continue end
			guests[#guests + 1] = {id = tonumber(id), name = guestName(id)}
			if #guests >= 64 then break end
		end
	end
	net.WriteUInt(#guests, 7)
	for _, guest in ipairs(guests) do
		net.WriteUInt(guest.id, 32)
		net.WriteString(guest.name:sub(1, 128))
		net.WriteBool((slot.guests or {})[tostring(guest.id)] == true)
	end
	net.Send(client)
end

function PLUGIN:RefreshManagementMenu(client)
	local session = client.cotzHideoutMenu
	if not session then return end
	for id in pairs(session.ids) do
		if self:CanUseManagementMenu(client, id) then
			if session.scope == "container" then
				local instance = self.instances[id]
				self:ShowContainerMenu(client, instance.containers[session.slot])
			else
				self:ShowManagement(client, id, session.scope)
			end
			return
		end
	end
end

function PLUGIN:HandleManagementAction(client, id, action, value, expectedTier, guestID)
	if not self:CanUseManagementMenu(client, id) then return false end
	local record = self:GetHideout(id)
	local scope = client.cotzHideoutMenu.scope
	if action == 9 then
		if scope ~= "exit" then return false end
		local ok, reason = self:LeaveHideout(client, true)
		if not ok then client:Notify(reason) end
		if ok then client.cotzHideoutMenu = nil end
		return ok
	end
	if not self:CanManageHideout(client, record) then return false end
	local containerAction = action == 5 or action == 8 or action >= 10 and action <= 14
	if containerAction then
		if scope ~= "container" or client.cotzHideoutMenu.slot ~= value then return false end
	elseif scope == "container" then return false end
	if action == 17 then
		if record.ownerType == "squad" or (scope ~= "entrance" and scope ~= "exit") then return false end
		if not self.operationsReady or record.frozen then
			client:Notify("This hideout is unavailable.")
			return false
		end
		local instance = self.instances[id]
		if instance and (instance.state ~= "active" or instance.saving) then
			client:Notify("Wait for the hideout to finish loading or saving.")
			return false
		end
		local character, session = client:GetCharacter(), client.cotzHideoutMenu
		self:DeleteHideout(id, function(deleted, message)
			if not IsValid(client) or client:GetCharacter() ~= character then return end
			if deleted and client.cotzHideoutMenu == session then client.cotzHideoutMenu = nil end
			client:Notify(message)
		end)
		return true
	end
	local ok, reason
	if action == 18 then ok, reason = self:MigratePersonalHideout(client, record)
	elseif action == 1 then ok, reason = self:PlaceSquadEntrance(client, record)
	elseif action == 2 then ok, reason = self:ResetVendor(client, record)
	elseif action == 16 then ok, reason = self:SetUpgradeFunding(client, record, value == "1")
	elseif action == 15 then ok, reason = self:ResetHideoutLayout(client, record)
	elseif action == 3 then ok, reason = self:SetAccessMode(client, record, value)
	elseif action == 5 then
		local slot = self:GetContainer(record, value)
		if slot then ok, reason = self:SetContainerPublic(client, record, value, not slot.public) end
	elseif action >= 10 and action <= 12 then
		ok, reason = self:SetContainerRank(client, record, value, action - 10)
	elseif action == 13 or action == 14 then
		ok, reason = self:SetContainerGuest(client, record, value, guestID, action == 13)
	elseif action == 8 then
		local instance = self.instances[id]
		self:OpenContainerInventory(client, instance.containers[value])
		return true
	elseif action == 6 or action == 7 then
		local characterID = tonumber(value)
		if not characterID or characterID < 1 or characterID % 1 ~= 0 then return false end
		if action == 6 and not ix.char.loaded[characterID] then return false end
		if action == 7 and record.guests[tostring(characterID)] ~= true then return false end
		local key = tostring(characterID)
		local previous = record.guests[key]
		record.guests[key] = action == 6 or nil
		ok = self:Persist()
		if not ok then record.guests[key] = previous end
		reason = ok and "Invitation access updated." or "Could not save invitation access."
		local instance = self.instances[id]
		if ok and instance then self:CloseStorage(instance) self:EnforceAccess(instance) end
	end
	if reason then client:Notify(reason) end
	if ok and action ~= 18 then self:RefreshManagementMenu(client) end

	return ok
end

net.Receive("cotz/hideouts/manage-open", function(_, client)
	local scope = SCOPES[net.ReadUInt(3)]
	local id = net.ReadString()
	if scope and #id <= 20 then PLUGIN:OpenManagementMenu(client, id, scope) end
end)

net.Receive("cotz/hideouts/manage-action", function(_, client)
	if not client:GetCharacter() or (client.cotzManageAction or 0) > CurTime() then return end
	client.cotzManageAction = CurTime() + 0.5
	local id, action, value = net.ReadString(), net.ReadUInt(5), net.ReadString()
	local expectedTier = net.ReadUInt(8)
	local guestID = net.ReadUInt(32)
	if #id <= 20 and #value <= 32 then
		PLUGIN:HandleManagementAction(client, id, action, value, expectedTier, guestID)
	end
end)
