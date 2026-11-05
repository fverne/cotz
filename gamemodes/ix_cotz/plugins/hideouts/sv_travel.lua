local PLUGIN = PLUGIN
local previousLoaded = PLUGIN.PlayerLoadedCharacter
local previousRestore = PLUGIN.GetCharacterRestorePosition

function PLUGIN:CaptureDestination(client)
	local instance = self:FindInstance(client:GetPos())
	if not instance then return {client:GetPos(), client:EyeAngles(), game.GetMap()} end
	if self.members[client] ~= instance.id or not self:CanAccess(client, self:GetHideout(instance.id)) then return end

	return {
		kind = "cotzHideout", version = 1, schema = Schema.folder, map = game.GetMap(),
		id = instance.id, pos = client:GetPos() - instance.origin, angles = client:EyeAngles(),
	}
end

function PLUGIN:RequestTeleportEntry(client, destination, callback, arrival)
	local character = client:GetCharacter()
	local record = istable(destination) and self:GetHideout(destination.id)
	if not self:IsHideoutDestination(destination) or destination.schema ~= Schema.folder
		or destination.map ~= game.GetMap() or not isvector(destination.pos)
		or not character or not self:CanAccess(client, record) or client.ixHideoutPending
		or not self.operationsReady or client.cotzHideoutOperation or not client:Alive() or client:InVehicle()
		or client:GetLocalVar("inArena") then
		callback(false, "That hideout is unavailable or you no longer have access.")
		return
	end
	local request = {character = character:GetID(), destination = destination}
	local previousReturn = character:GetData("hideoutReturn")
	client.ixHideoutPending = request
	local function fail(reason, instance)
		if IsValid(client) and client.ixHideoutPending == request then client.ixHideoutPending = nil end
		if request.returnPoint and character:GetData("hideoutReturn") == request.returnPoint then
			character:SetData("hideoutReturn", previousReturn)
			if IsValid(client) and client:GetCharacter() == character then character:Save() end
		end
		if instance then instance.pending[client] = nil self:UnloadInstance(instance) end
		callback(false, reason)
	end
	local function ready(ok, instance)
		if not ok then fail(instance) return end
		if not IsValid(client) or client:GetCharacter() ~= character or client.ixHideoutPending ~= request
			or not self:CanAccess(client, record) or instance.state ~= "active" or instance.saving then
			fail("Teleport was cancelled.", instance)
			return
		end
		local candidates = {}
		local bookmarked = instance.origin + destination.pos
		if self:Contains(bookmarked, instance.mins, instance.maxs) then candidates[1] = bookmarked end
		for _, offset in ipairs(self:GetTemplate(record).spawns) do candidates[#candidates + 1] = instance.origin + offset end
		local point = self:FindSafePosition(client, candidates)
		if not point or not self:Contains(point, instance.mins, instance.maxs) then
			fail("No safe arrival position is available.", instance)
			return
		end
		local source = self.instances[self.members[client]]
		local occupant = source and source.occupants[client]
		local outside = arrival and self:GetOutsidePosition(client, nil, record)
		local returnPoint = outside and {outside, angle_zero, game.GetMap()}
			or occupant and occupant.returnPoint or {client:GetPos(), client:EyeAngles(), game.GetMap()}
		if arrival and not outside then fail("The outside recovery position is blocked.", instance) return end
		instance.pending[client] = {request = request, time = CurTime()}
		request.returnPoint = returnPoint
		character:SetData("hideoutReturn", returnPoint)
		character:Save(function()
			local pending = instance.pending[client]
			if not pending or not IsValid(client) or client:GetCharacter() ~= character
				or client.ixHideoutPending ~= request or self.instances[instance.id] ~= instance
				or instance.state ~= "active" or instance.saving or not client:Alive()
				or not self:CanAccess(client, record) then
				fail("Teleport was cancelled.", instance)
				return
			end
			local safe = self:FindSafePosition(client, candidates)
			if not safe or not self:Contains(safe, instance.mins, instance.maxs) then
				fail("The arrival point became blocked.", instance)
				return
			end
			if source and source ~= instance then self:LeaveHideout(client, false, true) end
			instance.pending[client] = nil
			instance.occupants[client] = {character = character:GetID(), returnPoint = returnPoint}
			self.members[client] = instance.id
			client.ixHideoutPending = nil
			client:SetLocalVar("hideout", instance.id)
			client:SetPos(safe)
			client:SetEyeAngles(isangle(destination.angles) and destination.angles or angle_zero)
			character:SetData("jumppos", nil)
			character:SetData("markedexploiter", nil)
			if self.AuditBuildingTools then self:AuditBuildingTools() end
			callback(true)
		end)
	end
	local instance = self.instances[record.id]
	if not instance then
		self:SpawnInstance(record, ready)
	elseif instance.state == "loading" then
		instance.callbacks[#instance.callbacks + 1] = ready
	elseif instance.state == "active" and not instance.saving then
		ready(true, instance)
	else
		fail("The hideout is busy saving.")
	end
end

function PLUGIN:BeginArtifactTravel(client, destination, item, callback)
	if destination.map == game.GetMap() then
		self:RequestTeleportEntry(client, destination, callback)
		return
	end
	local travel = ix.plugin.Get("simplecrossserver")
	if destination.schema ~= Schema.folder or not travel or not travel.mapdata[destination.map] then
		callback(false, "That map is unavailable.")
		return
	end
	local character = client:GetCharacter()
	if character:GetData("pendingHideoutArrival") or client.cotzHideoutOperation then
		callback(false, "Another operation is pending.")
		return
	end
	local pending = {
		token = util.SHA256(SysTime() .. math.random()), destination = destination,
		character = character:GetID(), artifact = item and item:GetID(), expires = os.time() + 180,
	}
	character:SetData("pendingHideoutArrival", pending)
	-- Keep the original outside return point for the source server's Spawn Saver.
	if self.members[client] then self:LeaveHideout(client, false, true) end
	travel:RedirectPlayerNoLoadZone(client, destination.map, function(ok)
		if not ok then
			character:SetData("pendingHideoutArrival", nil)
			character:Save()
		end
		callback(ok, ok and "handoff" or "Cross-map transfer failed.")
	end)
end

function PLUGIN:GetCharacterRestorePosition(client, character, saved)
	local pending = character:GetData("pendingHideoutArrival")
	if pending and pending.destination and pending.destination.map == game.GetMap() then return false end

	return previousRestore(self, client, character, saved)
end

function PLUGIN:PlayerLoadedCharacter(client, character)
	previousLoaded(self, client, character)
	local pending = character:GetData("pendingHideoutArrival")
	if not pending or not pending.destination or pending.destination.map ~= game.GetMap() then return end
	timer.Simple(0.1, function()
		if not IsValid(client) or client:GetCharacter() ~= character then return end
		local record = self:GetHideout(pending.destination.id)
		local function complete(ok, reason)
			character:SetData("pendingHideoutArrival", nil)
			if ok and pending.artifact then
				local item = ix.item.instances[pending.artifact]
				if item then item:SetData("cooldown", os.time() + 15 * 60) end
			elseif not ok then
				local position = self:GetOutsidePosition(client, nil, record)
				if position then client:SetPos(position) end
				client:Notify(reason or "Hideout arrival expired; you were returned outside.")
			end
			character:Save()
		end
		local artifact = pending.artifact and ix.item.instances[pending.artifact]
		if pending.character ~= character:GetID() or pending.expires < os.time()
			or pending.artifact and (not artifact or artifact.invID ~= character:GetInventory():GetID()) then
			complete(false)
			return
		end
		self:RequestTeleportEntry(client, pending.destination, complete, true)
	end)
end
