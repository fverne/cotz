ix.crossserver = ix.crossserver or {}
local cross = ix.crossserver

function cross.GetPresenceText(info, fresh, localPlayer)
	if (fresh and info.state == "travelling") then return "TRAVELLING · " .. (info.destination or "") end
	if (localPlayer) then return "ON THIS SERVER" end
	if (not fresh or info.state == "unknown") then return "STATUS UNAVAILABLE" end
	if (info.state == "online") then return "ONLINE · " .. (info.map or "") end
	if (info.state == "offline") then return "OFFLINE" end

	return "STATUS UNAVAILABLE"
end

if (CLIENT) then
	local pending
	net.Receive("cotz/crossserver/roster", function()
		local changed = net.ReadBool()
		if (not changed) then cross.rosterFresh = CurTime() return end
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
			record.squadColor = Color(net.ReadUInt(8), net.ReadUInt(8), net.ReadUInt(8))
			if (pending) then pending[record.characterID] = record end
		end
		if (finished and pending) then
			cross.roster = pending
			cross.rosterFresh = CurTime()
			pending = nil
		end
	end)

	function cross.GetScoreboardRoster(localOnly)
		local records = {}
		local fresh = cross.rosterFresh ~= nil and CurTime() - cross.rosterFresh < 15
		for id, info in pairs(cross.roster or {}) do
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
				if (hook.Run("ShouldShowPlayerOnScoreboard", client) ~= false) then
					local squadID, squadName, squadColor
					if (ix.squad and ix.squad.GetScoreboardGroup) then
						squadID, squadName, squadColor = ix.squad.GetScoreboardGroup(client)
					end
					records[id] = {
						profile = {reputation = client:getReputation(),
							leaderboardStats = character:GetData("leaderboardStats", {})},
						characterID = id, player = client, name = character:GetName(),
						pdaavatar = character:GetPdaavatar(), map = game.GetMap(), fresh = true,
						state = previous and fresh and previous.state == "travelling" and "travelling" or "online",
						destination = previous and previous.destination or "",
						squadID = squadID, squadName = squadName, squadColor = squadColor,
					}
				end
			end
		end

		return records
	end
end
