local PLUGIN = PLUGIN
local KINDS = {"recovery", "sensor", "triangulation", "deadDrop", "defence"}
local ALLOWED = {}
for _, kind in ipairs(KINDS) do ALLOWED[kind] = true end

function PLUGIN:LoadData()
	local data = self:GetData({}, false, true) or {}
	-- Retain points recorded with the superseded patrol tool as alternate spawn locations.
	self.spawnPoints = data.spawnPoints or data.patrolPoints or {}
	self.lastSpawnPositions = data.lastSpawnPositions or {}
	for _, kind in ipairs(KINDS) do
		local maps = table.Copy(self.siteDefinitions[kind] or {})
		for map, points in pairs(data[kind] or {}) do maps[map] = points end
		self[kind .. "Points"] = maps
	end
end

function PLUGIN:SaveData()
	local data = {spawnPoints = self.spawnPoints or {}, lastSpawnPositions = self.lastSpawnPositions or {}}
	for _, kind in ipairs(KINDS) do data[kind] = self[kind .. "Points"] or {} end
	self:SetData(data, false, true)
end

function PLUGIN:RunCommandTownNPCAddFieldPoint(client, kind)
	if not ALLOWED[kind] then return "Use recovery, sensor, triangulation, deadDrop or defence." end
	local maps = PLUGIN[kind .. "Points"] or {}
	PLUGIN[kind .. "Points"] = maps
	local map = game.GetMap()
	maps[map] = maps[map] or {}
	local position = client:GetPos()
	for _, row in ipairs(maps[map]) do
		if row[1]:DistToSqr(position) < 64 ^ 2 then return "A field point already exists nearby." end
	end
	maps[map][#maps[map] + 1] = {position}
	PLUGIN:SaveData()

	return "Saved " .. kind .. " field point on " .. map .. "."
end

function PLUGIN:RunCommandTownNPCRemoveFieldPoint(client, kind)
	if not ALLOWED[kind] then return "Use recovery, sensor, triangulation, deadDrop or defence." end
	local maps = PLUGIN[kind .. "Points"] or {}
	local rows = maps[game.GetMap()] or {}
	local nearest, distance
	for index, row in ipairs(rows) do
		local candidate = row[1]:DistToSqr(client:GetPos())
		if candidate <= 128 ^ 2 and (not distance or candidate < distance) then
			nearest, distance = index, candidate
		end
	end
	if not nearest then return "No matching field point within 128 units." end
	table.remove(rows, nearest)
	PLUGIN:SaveData()

	return "Removed the nearest " .. kind .. " field point."
end

function PLUGIN:RunCommandTownNPCPlace(client, id)
	local contact = PLUGIN.contacts[id]
	if not contact then return "Unknown town contact. Use the slug from its definition filename." end
	if game.GetMap() ~= contact.map then return "This contact belongs on " .. contact.map .. "." end
	if ix.progression.GetNPCFromName(contact.name) then return "This contact is already placed on this map." end
	local trace = client:GetEyeTraceNoCursor()
	ix.util.SpawnAdvVendor(contact.template, trace.HitPos + trace.HitNormal, client:GetAngles())
	ix.plugin.Get("vendor_adv"):RefreshTownVendor(ix.progression.GetNPCFromName(contact.name), contact,
		PLUGIN.catalogues[contact.name] or {}, contact.supplyStock or PLUGIN.settings.supplyStock)
	ix.plugin.Get("vendor_adv"):SaveData()

	return "Placed and saved " .. contact.name .. "."
end

function PLUGIN:RunCommandTownNPCExportFieldPoints(client)
	client:PrintMessage(HUD_PRINTCONSOLE, "PLUGIN.siteDefinitions = {\n")
	for _, kind in ipairs(KINDS) do
		client:PrintMessage(HUD_PRINTCONSOLE, "\t" .. kind .. " = {\n")
		local maps = PLUGIN[kind .. "Points"] or {}
		for map, points in SortedPairs(maps) do
			client:PrintMessage(HUD_PRINTCONSOLE, string.format("\t\t[%q] = {\n", map))
			for _, row in ipairs(points) do
				local point = row[1]
				client:PrintMessage(HUD_PRINTCONSOLE,
					string.format("\t\t\t{Vector(%.3f, %.3f, %.3f)},\n", point.x, point.y, point.z))
			end
			client:PrintMessage(HUD_PRINTCONSOLE, "\t\t},\n")
		end
		client:PrintMessage(HUD_PRINTCONSOLE, "\t},\n")
	end
	client:PrintMessage(HUD_PRINTCONSOLE, "}\n")

	return "Field point definitions printed to your console."
end
