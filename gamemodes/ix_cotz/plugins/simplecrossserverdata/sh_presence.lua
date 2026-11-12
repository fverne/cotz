ix.crossserver = ix.crossserver or {}

local PRESENCE_COLORS = {
	localMap = Color(105, 139, 87), remote = Color(73, 140, 143),
	travelling = Color(167, 143, 81), unavailable = Color(116, 119, 107),
}

function ix.crossserver.GetMapLabel(map)
	local plugin = ix.plugin.Get("simplecrossserver")
	local definition = plugin and plugin.mapdata and plugin.mapdata[map]

	return string.upper(definition and definition.name or map or "UNKNOWN")
end

function ix.crossserver.GetPresenceColor(info, fresh, localPlayer)
	if fresh and info.state == "travelling" then return PRESENCE_COLORS.travelling end
	if localPlayer then return PRESENCE_COLORS.localMap end
	if fresh and info.state == "online" then return PRESENCE_COLORS.remote end

	return PRESENCE_COLORS.unavailable
end

function ix.crossserver.GetPresenceText(info, fresh, localPlayer)
	if (fresh and info.state == "travelling") then
		return "TRAVELLING: " .. ix.crossserver.GetMapLabel(info.destination)
	end
	if (localPlayer) then return "ONLINE: " .. ix.crossserver.GetMapLabel(game.GetMap()) end
	if (not fresh or info.state == "unknown") then return "STATUS UNAVAILABLE" end
	if (info.state == "online") then return "ONLINE: " .. ix.crossserver.GetMapLabel(info.map) end
	if (info.state == "offline") then return "OFFLINE" end

	return "STATUS UNAVAILABLE"
end

if (CLIENT) then
	local pending
	net.Receive("cotz/crossserver/roster", function()
		local changed = net.ReadBool()
		if (not changed) then ix.crossserver.rosterFresh = CurTime() return end
		if (net.ReadBool()) then pending = {} end
		local finished = net.ReadBool()
		local count = net.ReadUInt(6)
		for _ = 1, count do
			local record = {characterID = net.ReadUInt(32)}
			record.profile = util.JSONToTable(net.ReadString()) or {}
			record.name = net.ReadString()
			record.pdaavatar = net.ReadString()
			record.state = net.ReadString()
			record.map = net.ReadString()
			record.destination = net.ReadString()
			record.squadID = net.ReadString()
			record.squadName = net.ReadString()
			record.steamID64 = net.ReadString()
			record.squadColor = Color(net.ReadUInt(8), net.ReadUInt(8), net.ReadUInt(8))
			if record.squadID == "" or record.squadID == "NULL" then
				record.squadColor = PRESENCE_COLORS.unavailable
			end
			if (pending) then pending[record.characterID] = record end
		end
		if (finished and pending) then
			ix.crossserver.roster = pending
			ix.crossserver.rosterFresh = CurTime()
			pending = nil
		end
	end)

	function ix.crossserver.GetScoreboardRoster(localOnly)
		local records = {}
		local fresh = ix.crossserver.rosterFresh ~= nil and CurTime() - ix.crossserver.rosterFresh < 15
		for id, info in pairs(ix.crossserver.roster or {}) do
			if (not localOnly or (fresh and info.map == game.GetMap())) then
				local record = table.Copy(info)
				record.fresh = fresh
				records[id] = record
			end
		end
		-- Local entities give immediate character/visibility changes and deduplicate the shared snapshot.
		for _, client in ipairs(player.GetAll()) do
			local character = client:GetCharacter()
			if (character) then
				local id = character:GetID()
				local previous = records[id]
				records[id] = nil
				if (client == LocalPlayer() or hook.Run("ShouldShowPlayerOnScoreboard", client) ~= false) then
					local squadID, squadName, squadColor
					if (ix.squad and ix.squad.GetScoreboardGroup) then
						squadID, squadName, squadColor = ix.squad.GetScoreboardGroup(client)
					end
					-- Helix character data and progression are only replicated to their owner.
					local stats = previous and previous.profile and previous.profile.leaderboardStats or {}
					if client == LocalPlayer() then
						stats = ix.jobs.GetLeaderboardStats(character:GetData(),
							character.GetProgression and character:GetProgression())
					end
					records[id] = {
						profile = {reputation = client:getReputation(),
							leaderboardStats = stats},
						characterID = id, player = client, name = character:GetName(), steamID64 = client:SteamID64(),
						pdaavatar = character:GetPdaavatar(), map = game.GetMap(), fresh = true,
						state = previous and fresh and previous.state == "travelling" and "travelling" or "online",
						destination = previous and previous.destination or "",
						squadID = squadID, squadName = squadName, squadColor = squadColor,
					}
				end
			else
				local steamID64 = client:SteamID64()
				-- Replace any character snapshot for this account while it is in the character menu.
				for id, record in pairs(records) do
					if steamID64 ~= "0" and record.steamID64 == steamID64 then records[id] = nil end
				end
				if hook.Run("ShouldShowPlayerOnScoreboard", client) ~= false then
					local id = -client:EntIndex()
					records[id] = {
						characterID = id, player = client, name = client:Nick(), steamID64 = steamID64,
						profile = {}, awaitingCharacter = true, map = game.GetMap(), fresh = true,
						state = "travelling", destination = game.GetMap(),
					}
				end
			end
		end

		if ix.townNPCs then
			local character = LocalPlayer():GetCharacter()
			local access = ix.townNPCs:GetNetworkAccess(character)
			for id, record in pairs(records) do
				records[id] = ix.townNPCs:FilterNetworkRecord(character, record, access)
			end
		end

		return records
	end
end
