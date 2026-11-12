local PLUGIN = PLUGIN
local previousThink = PLUGIN.Think
local previousEntry = PLUGIN.RequestEntry

function PLUGIN:RequestEntry(client, id)
	if not self.operationsReady then return false, "Hideout persistence is still initializing." end
	if self.personalPurchases and self.personalPurchases[tostring(id)] then
		return false, "Wait for the hideout purchase to finish."
	end
	if (self.capacityPurchases or {})[tostring(id)] then return false, "Wait for the hideout purchase to finish." end

	return previousEntry(self, client, id)
end

function PLUGIN:GetSquadRank(client, record)
	local character = IsValid(client) and client:GetCharacter()
	local squad = record and ix.squad and ix.squad.list[record.squadID]
	if not character or not squad then return end
	if ix.squad.cross and ix.squad.cross.Enabled()
		and (not squad.hideoutFresh or CurTime() - squad.hideoutFresh > 15) then
		return
	end

	return squad.members[character:GetID()]
end

function PLUGIN:CanManageHideout(client, record)
	local character = IsValid(client) and client:GetCharacter()
	if not character or not record or record.deleting or record.homeConflict or record.homePending then return false end
	if record.ownerType ~= "squad" then return record.owner == character:GetID() end
	local rank = self:GetSquadRank(client, record)

	return rank ~= nil and rank >= 1
end

function PLUGIN:CanAccess(client, record)
	local character = IsValid(client) and client:GetCharacter()
	if not character or not record or record.deleting or record.frozen or record.homeConflict or record.homePending then return false end
	if client:IsAdmin() then return true end
	if record.ownerType == "squad" then
		local squad = ix.squad and ix.squad.list[record.squadID]
		if not squad or ix.squad.cross and ix.squad.cross.Enabled()
			and (not squad.hideoutFresh or CurTime() - squad.hideoutFresh > 15) then return false end
		if self:GetSquadRank(client, record) ~= nil then return true end
		if record.access == "public" then return true end
		if record.access ~= "invite" then return false end
	end

	return record.owner == character:GetID() or (record.guests or {})[tostring(character:GetID())] == true
end

function PLUGIN:CheckSquadRole(client, record, minimum, callback)
	local character = IsValid(client) and client:GetCharacter()
	if not character or not record or record.ownerType ~= "squad" then callback(false) return end
	if not ix.squad or not ix.squad.cross or not ix.squad.cross.Enabled() then
		local rank = self:GetSquadRank(client, record)
		callback(rank ~= nil and rank >= minimum)
		return
	end
	if not ix.squad.cross.ready then callback(false) return end
	local query = mysql:Select("ix_squads_members"):Alias("m")
	query:SelectColumn("m.member_rank", "rank")
	query:Join("ix_squads_state", "s", mysql.All(
		mysql.Compare("s.scope", "=", mysql.Column("m.scope")),
		mysql.Compare("s.squad_id", "=", mysql.Column("m.squad_id"))))
	query:WhereExpr(mysql.Compare("m.scope", "=", ix.crossserver.Scope()))
	query:WhereExpr(mysql.Compare("m.character_id", "=", character:GetID()))
	query:WhereExpr(mysql.Compare("m.squad_id", "=", record.squadID))
	query:WhereExpr(mysql.Compare("s.active", "=", 1))
	ix.squad.cross.Query(query, function(rows, failure)
		local rank = not failure and rows and rows[1] and tonumber(rows[1].rank)
		callback(IsValid(client) and client:GetCharacter() == character and rank ~= nil and rank >= minimum)
	end)
end

function PLUGIN:GrantSquadHideout(client, templateID, name, callback)
	if not self.operationsReady then return false, "Hideout persistence is still initializing." end
	local character = client:GetCharacter()
	local squadID = character and character:GetSquadID()
	if not squadID or squadID == "NULL" or not self.state.templates[templateID] then
		return false, "The target needs a squad and a valid template."
	end
	for _, record in pairs(self.state.hideouts) do
		if record.ownerType == "squad" and record.squadID == squadID then
			return false, "That squad already has a hideout on this map."
		end
	end
	local id = tostring(self.state.nextID)
	self.state.nextID = self.state.nextID + 1
	local record = {
		id = id, ownerType = "squad", squadID = squadID, access = "squad", name = name,
		template = templateID, entrance = "squad:" .. id, guests = {}, containers = {},
		furnishings = {}, shell = {}, seeds = {},
	}
	-- Save an unusable pending record first so a crash cannot orphan a global ownership claim.
	record.homePending = true
	self.state.hideouts[id] = record
	if not self:Persist() then
		self.state.hideouts[id] = nil
		return false, "Could not save the pending hideout."
	end
	self:ClaimSquadHome(record, function(ok, reason)
		if self:GetHideout(id) ~= record or record.deleting then
			if ok then self:ReleaseSquadHome(record, function() end) end
			if callback then callback(false, "Squad hideout provisioning was cancelled.") end
			return
		end
		if ok then
			record.homePending = nil
			ok = self:Persist()
			if not ok then
				self.state.hideouts[id] = nil
				self:ReleaseSquadHome(record, function() end)
				reason = "Could not save hideout."
			end
		else
			self.state.hideouts[id] = nil
			self:Persist()
		end
		if callback then callback(ok, ok and id or reason) end
	end)

	return true, "Reserving the squad hideout."
end

function PLUGIN:PlaceSquadEntrance(client, record)
	if not self:CanManageHideout(client, record) or record.ownerType ~= "squad" then
		return false, "Only this squad's leader or officers can place its entrance."
	end
	if self.members[client] or client.ixHideoutPending or self:FindInstance(client:GetPos()) then
		return false, "Place the entrance outside hideouts."
	end
	local trace = client:GetEyeTrace()
	if not trace.Hit or trace.HitSky or trace.HitPos:DistToSqr(client:GetPos()) > 160 * 160 then
		return false, "Look at a nearby solid surface."
	end
	for _, area in pairs(self.state.areas) do
		if self:Contains(trace.HitPos, area.mins, area.maxs) then
			return false, "An entrance cannot be placed in an interior allocation area."
		end
	end
	if not self:FindSafePosition(client, {client:GetPos()}) then
		return false, "The outside return position is obstructed."
	end
	local previous = self.state.entrances[record.entrance]
	self.state.entrances[record.entrance] = {
		pos = trace.HitPos + trace.HitNormal * 3, angles = trace.HitNormal:Angle(),
		outside = client:GetPos(), invisible = false, hideout = record.id,
	}
	if not self:Persist() then
		self.state.entrances[record.entrance] = previous
		return false, "Could not save entrance."
	end
	self:SpawnEntrances()

	return true, "Squad entrance placed. Everyone uses this point; your access setting controls entry."
end

function PLUGIN:EnforceAccess(instance)
	local record = self:GetHideout(instance.id)
	for client in pairs(instance.occupants) do
		if IsValid(client) and not self:CanAccess(client, record) then self:LeaveHideout(client, true) end
	end
end

function PLUGIN:Think()
	previousThink(self)
	if not self.ready or (self.nextAccessAudit or 0) > CurTime() then return end
	self.nextAccessAudit = CurTime() + 1
	for _, instance in pairs(self.instances) do
		if instance.state == "active" then
			self:EnforceAccess(instance)
			if self.AuditPersonalFloorItems then self:AuditPersonalFloorItems(instance) end
			self:AuditContainerAccess(instance)
			if self.AuditVendor then self:AuditVendor(instance) end
			if self.AuditContainers and not instance.saving then self:AuditContainers(instance) end
		end
	end
	if self.AuditBuildingTools then self:AuditBuildingTools() end
	if self.AuditRecoverySessions then self:AuditRecoverySessions() end
end
