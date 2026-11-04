local PLUGIN = PLUGIN
local REQUEST_COOLDOWN = 1
local POINTS_PER_MESSAGE = 100
local MAX_LABEL_LENGTH = 180

util.AddNetworkString("cotz/spawnpoint-esp/request")
util.AddNetworkString("cotz/spawnpoint-esp/points")

local function addPoint(points, position, label)
	if not isvector(position) then return end

	points[#points + 1] = {position = position, label = string.sub(label, 1, MAX_LABEL_LENGTH)}
end

local function collectPlayerSpawns(points)
	local plugin = ix.plugin.list.spawns

	for faction, classes in pairs(plugin and plugin.spawns or {}) do
		for class, positions in pairs(classes) do
			for _, position in pairs(positions) do
				addPoint(points, position, faction .. " / " .. class)
			end
		end
	end
end

local function collectArrivals(points)
	local plugin = ix.plugin.list.simplecrossserver
	local mapData = plugin and plugin.mapdata and plugin.mapdata[game.GetMap()]

	for name, data in pairs(mapData and mapData.loadzones or {}) do
		addPoint(points, data.pos, name)
	end
end

local function collectContainers(points, cyclic)
	for _, entity in ipairs(ents.FindByClass("ix_container")) do
		local category = cyclic and entity:GetCyclicalCategory() or entity:GetSpawnCategory()

		if category and category ~= "" then
			addPoint(points, entity:GetPos(), category)
		end
	end
end

function PLUGIN:CollectSpawnPoints(category)
	local points = {}

	if category.field then
		local plugin = ix.plugin.list[category.plugin]
		local records = plugin and plugin[category.field] or {}

		if category.mapIndexed then
			records = records[game.GetMap()] or {}
		end

		for id, record in pairs(records) do
			local details = {tostring(id)}

			for index = 2, #record do
				details[#details + 1] = tostring(record[index])
			end

			addPoint(points, record[1], table.concat(details, " / "))
		end
	elseif category.key == "players" then
		collectPlayerSpawns(points)
	elseif category.key == "arrivals" then
		collectArrivals(points)
	elseif category.key == "containers" or category.key == "cyclic" then
		collectContainers(points, category.key == "cyclic")
	elseif category.key == "checkpoints" then
		for id, entity in ipairs(ents.FindByClass("ix_spawnsaver")) do
			addPoint(points, entity:GetPos(), tostring(id))
		end
	end

	return points
end

local function sendPoints(client, categoryID, points)
	-- Chunk the response so large map layouts stay below the net message size limit.
	for first = 1, math.max(#points, 1), POINTS_PER_MESSAGE do
		local last = math.min(first + POINTS_PER_MESSAGE - 1, #points)
		net.Start("cotz/spawnpoint-esp/points")
		net.WriteUInt(categoryID, 4)
		net.WriteBool(first == 1)
		net.WriteUInt(last - first + 1, 8)

		for index = first, last do
			net.WriteVector(points[index].position)
			net.WriteString(points[index].label)
		end

		net.Send(client)
	end
end

net.Receive("cotz/spawnpoint-esp/request", function(_, client)
	if not client:IsAdmin() then return end
	if not CAMI.PlayerHasAccess(client, "Helix - Observer", nil) then return end
	if client:GetMoveType() ~= MOVETYPE_NOCLIP or client:InVehicle() then return end
	if (client.ixNextSpawnESPRequest or 0) > CurTime() then return end

	client.ixNextSpawnESPRequest = CurTime() + REQUEST_COOLDOWN

	for categoryID, category in ipairs(PLUGIN.spawnCategories) do
		if net.ReadBool() then
			sendPoints(client, categoryID, PLUGIN:CollectSpawnPoints(category))
		end
	end
end)
