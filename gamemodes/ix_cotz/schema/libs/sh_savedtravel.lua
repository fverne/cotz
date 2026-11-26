function ix.util.CaptureSavedLocation(client)
	local hideouts = ix.plugin.Get("hideouts")
	if hideouts and hideouts.CaptureDestination then return hideouts:CaptureDestination(client) end

	return {client:GetPos(), client:EyeAngles(), game.GetMap()}
end

local function IsClearFor(client, position)
	return not util.TraceEntity({start = position, endpos = position, filter = client}, client).StartSolid
end

-- Saved spots are recorded at the player's feet and can be occupied by the bedroll itself, another player,
-- or a gap that was only passable crouched. Returns the saved spot when it is clear, otherwise the nearest
-- empty space around it, or nil when nothing nearby fits.
function ix.util.FindClearSpawnPosition(client, position)
	if IsClearFor(client, position) then return position end

	-- FindEmptySpace searches around the entity's current position, so measure from the saved spot.
	local original = client:GetPos()
	client:SetPos(position)
	local candidates = ix.util.FindEmptySpace(client, {client})
	client:SetPos(original)

	for _, candidate in ipairs(candidates) do
		if IsClearFor(client, candidate) then return candidate end
	end
end

function ix.util.TravelToSavedLocation(client, destination, callback, artifact)
	callback = callback or function(ok, reason) if not ok then client:Notify(reason) end end
	local hideouts = ix.plugin.Get("hideouts")
	if hideouts and hideouts:IsHideoutDestination(destination) then
		hideouts:BeginArtifactTravel(client, destination, artifact, callback)
		return
	end
	if not istable(destination) or not isvector(destination[1]) or not isstring(destination[3]) then
		callback(false, "No valid destination is recorded.")
		return
	end
	local character = client:GetCharacter()
	local travel = ix.plugin.Get("simplecrossserver")
	if destination[3] ~= game.GetMap() then
		if not travel or not travel.mapdata[destination[3]] then callback(false, "That map is unavailable.") return end
		character:SetData("newpos", destination)
		if hideouts and hideouts.members[client] then hideouts:LeaveHideout(client, false, true) end
		travel:RedirectPlayerNoLoadZone(client, destination[3], callback)
		return
	end
	if hideouts then
		for _, area in pairs(hideouts.state and hideouts.state.areas or {}) do
			if hideouts:Contains(destination[1], area.mins, area.maxs) then
				callback(false, "This old interior bookmark must be recorded again inside the hideout.")
				return
			end
		end
	end
	local position = util.IsInWorld(destination[1]) and ix.util.FindClearSpawnPosition(client, destination[1])
	if not position then
		callback(false, "The recorded destination is blocked.")
		return
	end
	if hideouts and hideouts.members[client] then hideouts:LeaveHideout(client, false) end
	client:SetPos(position)
	client:SetEyeAngles(isangle(destination[2]) and destination[2] or angle_zero)
	-- A mid-air jump mark from before the teleport no longer describes where the player is.
	character:SetData("jumppos", nil)
	character:SetData("markedexploiter", nil)
	callback(true)
end

function ix.util.UseTravelArtifact(item, destination, text)
	local client = item.player
	local character = client:GetCharacter()
	if client.cotzArtifactTravel or client.cotzHideoutOperation or character:GetData("pendingHideoutArrival")
		or not destination
		or item.invID ~= character:GetInventory():GetID() or item:GetData("cooldown", 0) >= os.time() then return end
	client.cotzArtifactTravel = item:GetID()
	ix.util.PlayerPerformBlackScreenAction(client, text, 30, function(player)
		if not IsValid(player) or player:GetCharacter() ~= character
			or not player:Alive() or player:InVehicle() or player:GetLocalVar("inArena")
			or ix.item.instances[item:GetID()] ~= item or item.invID ~= character:GetInventory():GetID()
			or item:GetData("cooldown", 0) >= os.time() then
			if IsValid(player) then player.cotzArtifactTravel = nil end
			return
		end
		ix.util.TravelToSavedLocation(player, destination, function(ok, reason)
			player.cotzArtifactTravel = nil
			if ok and reason ~= "handoff" then item:SetData("cooldown", os.time() + 15 * 60) end
			if not ok and IsValid(player) then player:Notify(reason) end
		end, item)
	end)
	timer.Simple(35, function()
		if IsValid(client) and client.cotzArtifactTravel == item:GetID() and not client.ixHideoutPending then
			client.cotzArtifactTravel = nil
		end
	end)
end
