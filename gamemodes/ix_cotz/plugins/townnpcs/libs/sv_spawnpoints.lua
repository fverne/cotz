local PLUGIN = PLUGIN
local SAME_POSITION_SQUARED = 16 ^ 2

util.AddNetworkString("cotz/townnpcs/capture-spawn")

local function getPoints(id)
	local maps = PLUGIN.spawnPoints or {}
	maps[game.GetMap()] = maps[game.GetMap()] or {}
	PLUGIN.spawnPoints = maps

	return maps[game.GetMap()][id], maps[game.GetMap()]
end

ix.command.Add("TownNPCGetSpawnPoint", {
	adminOnly = true,
	description = "Print the aimed-at advanced vendor's current position, facing and animation to your console.",
	OnRun = function(_, client)
		if not IsValid(client) then return "Run this command as a player in game." end
		local npc = client:GetEyeTraceNoCursor().Entity
		if not IsValid(npc) or npc:GetClass() ~= "ix_vendor_adv" then
			return "Look at an advanced vendor or town NPC."
		end
		-- Animation groups run on the client, so capture the sequence visible to the requesting admin there.
		net.Start("cotz/townnpcs/capture-spawn")
		net.WriteEntity(npc)
		net.Send(client)

		return "Spawn point printed to your console."
	end,
})

ix.command.Add("TownNPCClearSpawnPoints", {
	adminOnly = true,
	arguments = {ix.type.string},
	OnRun = function(_, client, id)
		local contact = PLUGIN.contacts[id]
		if not contact or contact.map ~= game.GetMap() then return "Choose a contact on this map." end
		local _, contacts = getPoints(id)
		contacts[id] = nil
		local previous = (PLUGIN.lastSpawnPositions or {})[game.GetMap()]
		if previous then previous[id] = nil end
		PLUGIN:SaveData()

		return "Cleared alternate spawn points for " .. contact.name .. "."
	end,
})

function PLUGIN:FormatTownSpawnPoints(id, points)
	local lines = {string.format("\t[%q] = {\n", id)}
	for _, point in ipairs(points) do
		local position, angles = point.position, point.angles
		lines[#lines + 1] = string.format(
			"\t\t{position = Vector(%.6f, %.6f, %.6f), angles = Angle(%.6f, %.6f, %.6f), idleanim = %q},\n",
			position.x, position.y, position.z, angles.p, angles.y, angles.r, point.idleanim or ""
		)
	end
	lines[#lines + 1] = "\t},\n"

	return table.concat(lines)
end

ix.command.Add("TownNPCExportSpawnPoints", {
	adminOnly = true,
	OnRun = function(_, client)
		client:PrintMessage(HUD_PRINTCONSOLE, "[\"townnpcs\"] = {\n")
		for id, points in SortedPairs((PLUGIN.spawnPoints or {})[game.GetMap()] or {}) do
			for line in PLUGIN:FormatTownSpawnPoints(id, points):gmatch("[^\n]+") do
				client:PrintMessage(HUD_PRINTCONSOLE, line .. "\n")
			end
		end
		client:PrintMessage(HUD_PRINTCONSOLE, "},\n")

		return "Spawn point preset printed to your console. Paste it into this map's plugindata table."
	end,
})

function PLUGIN:ApplyTownSpawnPoints()
	-- PostLoadData may also be called manually; never move contacts again during this session.
	if self.spawnPositionsApplied then return end
	self.spawnPositionsApplied = true
	local map = game.GetMap()
	local contacts = (self.spawnPoints or {})[map]
	if not contacts or not next(contacts) then return end
	self.lastSpawnPositions = self.lastSpawnPositions or {}
	local previous = self.lastSpawnPositions[map] or {}
	self.lastSpawnPositions[map] = previous
	local changed = false
	for _, npc in ipairs(ents.FindByClass("ix_vendor_adv")) do
		local contact = self.byName[npc:GetDisplayName()]
		local points = contact and contact.map == map and contacts[contact.id]
		if points and #points > 0 then
			local lastPosition = previous[contact.id] or npc:GetPos()
			local candidates = {}
			for _, point in ipairs(points) do
				if point.position:DistToSqr(lastPosition) >= SAME_POSITION_SQUARED then
					candidates[#candidates + 1] = point
				end
			end
			local pool = #candidates > 0 and candidates or points
			local point = pool[math.random(#pool)]
			npc:SetPos(point.position)
			npc:SetAngles(point.angles)
			local animation = point.idleanim or ""
			if animation ~= "" and npc:LookupSequence(animation) < 0 then
				ErrorNoHalt("[Town NPCs] Unknown spawn animation " .. animation .. " for " .. contact.id .. ".\n")
				animation = ""
			end
			npc:SetTownSpawnAnim(animation)
			npc:SetAnim()
			previous[contact.id] = point.position
			changed = true
		end
	end
	if changed then self:SaveData() end
end
