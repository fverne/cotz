local PLUGIN = PLUGIN

local MIMIC_CLASS = "npc_mutant_mimic"
-- The storage helper checks its search action every 0.1 seconds, so confirm slightly after it ends.
local SEARCH_GRACE = 0.25
local ANCHOR_RANGE_SQR = 512 ^ 2
local ANCHOR_HEIGHT = 128
local SPAWN_RADII = {512, 1024}
local OPENER_CLEARANCE_SQR = 200 ^ 2
local SIGHT_HEIGHT = Vector(0, 0, 40)

-- The nodegraph component of the node closest to the container, preferring nodes the container can see so a
-- node behind a wall does not choose the neighbouring room.
function PLUGIN:GetMimicSpawnComponent(container)
	local nodes, components = ix.eventController:GetSpawnNodes()
	if not nodes then return end

	local origin = container:WorldSpaceCenter()
	local nearby = {}
	for _, node in ipairs(nodes) do
		local distance = origin:DistToSqr(node)
		if distance <= ANCHOR_RANGE_SQR and math.abs(node.z - origin.z) <= ANCHOR_HEIGHT then
			nearby[#nearby + 1] = {node = node, distance = distance}
		end
	end
	table.sort(nearby, function(first, second) return first.distance < second.distance end)

	for _, candidate in ipairs(nearby) do
		local trace = util.TraceLine({
			start = origin, endpos = candidate.node + SIGHT_HEIGHT, mask = MASK_SOLID, filter = container,
		})
		if not trace.Hit then return components[candidate.node] end
	end

	return nearby[1] and components[nearby[1].node]
end

function PLUGIN:FindMimicSpawn(container, client)
	local origin = container:GetPos()
	local opener = client:GetPos()
	local function awayFromOpener(position)
		return position:DistToSqr(opener) >= OPENER_CLEARANCE_SQR
	end

	local component = self:GetMimicSpawnComponent(container)
	if component then
		for _, radius in ipairs(SPAWN_RADII) do
			local position = ix.eventController:GetSpawnLocation(origin, radius, container, awayFromOpener, component)
			if position then return position end
		end
	end

	-- No connected node is usable: fall back to any validated ground nearby.
	return ix.eventController:GetSpawnLocation(origin, SPAWN_RADII[1], container, awayFromOpener)
end

function PLUGIN:SpawnMimicAmbush(container, client)
	if not ix.eventController then return end
	local position = self:FindMimicSpawn(container, client)
	if not position or not ix.eventController:CanSpawnMutant(position, true) then return end

	local mimic = ents.Create(MIMIC_CLASS)
	if not IsValid(mimic) then return end
	mimic:SetPos(position)
	mimic:SetAngles(Angle(0, (client:GetPos() - position):Angle().y, 0))
	mimic:Spawn()
	mimic:DropToFloor()
	ix.eventController:RegisterMutant(mimic, true)
	if not IsValid(mimic) or mimic.cotzPopulationRejected then return end
	mimic:MimicAmbush(client)

	return mimic
end

-- Each appearance gets one roll, spent by the first completed search, however many players open it.
function PLUGIN:RollMimicAmbush(container, client)
	if container.cotzMimicRolled or container:GetNoDraw() or container:GetCyclicalCategory() == "" then return end
	if not client:Alive() or client:GetMoveType() == MOVETYPE_NOCLIP then return end

	container.cotzMimicRolled = true
	if math.Rand(0, 100) >= ix.config.Get("mimicAmbushChance", 8) then return end

	return self:SpawnMimicAmbush(container, client)
end

hook.Add("cotz/containers/open-started", "cotz/cycliccontainer/mimic-ambush", function(container, client, inventory)
	if container.cotzMimicRolled or container:GetCyclicalCategory() == "" then return end

	local character = client:GetCharacter()
	timer.Simple(ix.config.Get("containerOpenTime", 0.7) + SEARCH_GRACE, function()
		-- A cancelled search clears ixOpenStorage and leaves the roll for the next opener.
		if not IsValid(container) or not IsValid(client) or client:GetCharacter() ~= character
			or client.ixOpenStorage ~= inventory then return end

		PLUGIN:RollMimicAmbush(container, client)
	end)
end)
