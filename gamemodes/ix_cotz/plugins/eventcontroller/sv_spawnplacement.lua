local PLUGIN = PLUGIN

local MAX_SPAWN_ATTEMPTS = 24
local MIN_GROUND_NORMAL = 0.7
-- Covers current encounter actors, including the bear's width and scaled hellhound's height.
local NPC_MINS, NPC_MAXS = Vector(-56, -56, 0), Vector(56, 56, 112)
local GROUND_UP, GROUND_DOWN = Vector(0, 0, 32), Vector(0, 0, 128)
local CLEARANCE = Vector(0, 0, 2)
local SEARCH_OFFSET = Vector(0, 0, 16)
local NODE_HEIGHT_RANGE = 128
local NODE_FLOOR_TOLERANCE = 18

function PLUGIN:IsSpawnLocationClear(position)
	if not util.IsInWorld(position) then return false end
	local trace = util.TraceHull({
		start = position,
		endpos = position,
		mins = NPC_MINS,
		maxs = NPC_MAXS,
		mask = MASK_SOLID,
	})

	return not trace.Hit and not trace.StartSolid and not trace.AllSolid
end

function PLUGIN:GetGroundedSpawnLocation(position, onNodegraph)
	if not util.IsInWorld(position) then return end
	-- Keep the search near the authored floor instead of dropping through an entire building.
	local trace = util.TraceLine({
		start = position + GROUND_UP,
		endpos = position - GROUND_DOWN,
		mask = MASK_SOLID,
	})
	if not trace.Hit or trace.StartSolid or trace.AllSolid or trace.HitSky then return end
	if not trace.HitWorld or trace.HitNormal.z < MIN_GROUND_NORMAL then return end
	-- Static props can report worldspawn as their entity; Entity/HitWorld alone cannot identify them.
	local onProp = trace.HitTexture == "**studio**" or (trace.HitBox or 0) ~= 0
	if onProp and not onNodegraph then return end
	local grounded = trace.HitPos + CLEARANCE
	if onNodegraph and math.abs(grounded.z - position.z) > NODE_FLOOR_TOLERANCE then return end
	if not self:IsSpawnLocationClear(grounded) then return end

	return grounded
end

function PLUGIN:GetSpawnLocation(position, radius, sweepFilter)
	radius = radius or self.spawnradius
	local nodes = self:GetSpawnNodes()
	if nodes then
		local candidates = {}
		local radiusSquared = radius * radius
		for _, node in ipairs(nodes) do
			if node:DistToSqr(position) <= radiusSquared and math.abs(node.z - position.z) <= NODE_HEIGHT_RANGE then
				candidates[#candidates + 1] = node
			end
		end
		for _ = 1, math.min(MAX_SPAWN_ATTEMPTS, #candidates) do
			local index = math.random(#candidates)
			local candidate = candidates[index]
			candidates[index] = candidates[#candidates]
			candidates[#candidates] = nil
			local grounded = self:GetGroundedSpawnLocation(candidate, true)
			if grounded then return grounded end
		end
	end

	for _ = 1, MAX_SPAWN_ATTEMPTS do
		local candidate = position + Vector(
			math.random(-radius, radius),
			math.random(-radius, radius),
			0
		)
		local trace = util.TraceHull({
			start = position + SEARCH_OFFSET,
			endpos = candidate + SEARCH_OFFSET,
			mins = NPC_MINS,
			maxs = NPC_MAXS,
			mask = MASK_SOLID,
			-- A summoner occupies the sweep's origin; final floor and clearance checks still include it.
			filter = sweepFilter,
		})
		if not trace.Hit and not trace.StartSolid and not trace.AllSolid then
			local grounded = self:GetGroundedSpawnLocation(candidate)
			if grounded then return grounded end
		end
	end

	-- The center is only a fallback if it passes the same floor and clearance checks.
	return self:GetGroundedSpawnLocation(position)
end
