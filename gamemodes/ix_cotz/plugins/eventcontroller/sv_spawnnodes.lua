local PLUGIN = PLUGIN

local AIN_VERSION = 37
local HEADER_BYTES, NODE_BYTES, LINK_BYTES = 12, 61, 14
local NODE_TYPE_OFFSET = 56
local NODE_GROUND = 2
local MAX_NODES = 32768
local BSP_REVISION_OFFSET = 1032
local cachedMap, cachedNodes

local function readSpawnNodes(graph)
	local size = graph:Size()
	if size < HEADER_BYTES then return nil, "truncated nodegraph header" end
	if graph:ReadLong() ~= AIN_VERSION then return nil, "unsupported nodegraph version" end
	local revision, count = graph:ReadLong(), graph:ReadLong()
	if count < 0 or count > MAX_NODES then return nil, "invalid node count" end
	local linksOffset = HEADER_BYTES + count * NODE_BYTES
	if size < linksOffset + 4 then return nil, "truncated node records" end
	if ai.GetNodeCount and ai.GetNodeCount() ~= count then return nil, "node count differs from the engine" end

	local revisionNotice
	local bsp = file.Open("maps/" .. game.GetMap() .. ".bsp", "rb", "GAME")
	if bsp then
		local mapRevision
		if bsp:Size() >= BSP_REVISION_OFFSET + 4 then
			bsp:Seek(BSP_REVISION_OFFSET)
			mapRevision = bsp:ReadLong()
		end
		bsp:Close()
		if not mapRevision then return nil, "truncated BSP header" end
		-- Manually authored graphs can work with a different BSP revision; validate their contents below.
		if mapRevision ~= revision then
			revisionNotice = string.format("nodegraph revision %d differs from BSP revision %d", revision, mapRevision)
		end
	end

	-- Layout follows Valve's version 37 SaveNetworkGraph (ai_networkmanager.cpp), not a Lua navmesh.
	local nodes = {}
	for index = 1, count do
		local offset = HEADER_BYTES + (index - 1) * NODE_BYTES
		graph:Seek(offset)
		local x, y, z = graph:ReadFloat(), graph:ReadFloat(), graph:ReadFloat()
		graph:ReadFloat() -- Yaw precedes the ten hull-specific vertical offsets.
		local humanOffset = graph:ReadFloat()
		graph:Seek(offset + NODE_TYPE_OFFSET)
		local nodeType = graph:ReadByte()
		if math.abs(x) == math.huge or math.abs(y) == math.huge or math.abs(z) == math.huge
			or x ~= x or y ~= y or z ~= z or humanOffset ~= humanOffset
			or math.abs(humanOffset) == math.huge then
			return nil, "non-finite node position"
		end
		if nodeType == NODE_GROUND then
			nodes[index] = {position = Vector(x, y, z + humanOffset)}
		end
	end

	graph:Seek(linksOffset)
	local linkCount = graph:ReadLong()
	if linkCount < 0 or size < linksOffset + 4 + linkCount * LINK_BYTES + count * 4 then
		return nil, "truncated or invalid node links"
	end
	for index = 1, linkCount do
		local source, destination = graph:ReadShort() + 1, graph:ReadShort() + 1
		local humanMovement = graph:ReadByte()
		graph:Seek(linksOffset + 4 + index * LINK_BYTES)
		if source < 1 or source > count or destination < 1 or destination > count then
			return nil, "invalid node link endpoint"
		end
		if source ~= destination and nodes[source] and nodes[destination]
			and bit.band(humanMovement, CAP_MOVE_GROUND) ~= 0 then
			nodes[source].connected, nodes[destination].connected = true, true
		end
	end

	local positions = {}
	for index = 1, count do
		local node = nodes[index]
		if node and node.connected then positions[#positions + 1] = node.position end
	end

	return positions, revisionNotice
end

function PLUGIN:GetSpawnNodes()
	local mapName = game.GetMap()
	if cachedMap == mapName then return cachedNodes end
	cachedMap, cachedNodes = mapName, nil
	local graph = file.Open("maps/graphs/" .. mapName .. ".ain", "rb", "GAME")
	local reason = "nodegraph file unavailable"
	if graph then
		cachedNodes, reason = readSpawnNodes(graph)
		graph:Close()
	end
	if not cachedNodes then
		ErrorNoHalt("[COTZ eventcontroller] " .. reason .. "; using validated floor sampling.\n")
	elseif reason then
		print("[COTZ eventcontroller] " .. reason .. "; using validated nodegraph positions.")
	end

	return cachedNodes
end
