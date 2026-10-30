ix.jobs = ix.jobs or {}
ix.jobs.field = ix.jobs.field or {}

local field = ix.jobs.field

-- Sources read existing plugin data. Pools can include sources and other pools.
field.sources = {
	stash = {plugin = "hidestashspawner", key = "stashspawnpoints"},
	event = {plugin = "eventcontroller", key = "eventpoints"},
	anomaly = {plugin = "anomalycontroller", key = "anomalypoints"},
	radiation = {plugin = "radiationcontroller", key = "radiationpoints"},
}

field.pools = {
	gas = {"anomaly", "radiation"},
	rf = {"event"},
	packages = {"stash"},
}

field.settings = {
	recovery = {sources = {"packages", "rf"}, cargo = "job_recovery_case", searchRadius = 384},
	sensor = {sources = {"gas"}, cargo = "job_sensor_recorder", recordSeconds = 120,
		leaveDistance = 512, deployDistance = 512},
	triangulation = {sources = {"rf", "packages"}, cargo = "job_signal_transmitter",
		readingCount = 3, readingDistance = 512, bearingAngle = 15},
	deadDrop = {sources = {"packages"}, destinationSources = {"packages", "rf"},
		cargo = "job_dead_drop_parcel", minRouteDistance = 2048},
	defence = {
		sources = {"rf"}, attackSources = {"rf"}, cargo = "job_research_results",
		minAttackDistance = 512, maxAttackDistance = 4096, maxHeightDifference = 256, maxSpawnPoints = 8,
		defendDistance = 768, duration = 90, samplerHealth = 250, threatRadius = 160, threatDamage = 8,
		waveInterval = 10, attemptTimeout = 300, retryDelay = 30, playerSafeDistance = 256,
		waves = {
			{{classes = {"npc_mutant_dog"}, count = 2},
				{classes = {"npc_mutant_dog", "npc_mutant_pseudodog"}, count = 2}},
			{{classes = {"npc_mutant_dog", "npc_mutant_pseudodog"}, count = 3},
				{classes = {"npc_mutant_snork"}, count = 2},
				{classes = {"npc_mutant_pseudodog", "npc_mutant_snork"}, count = 3}},
			{{classes = {"npc_mutant_snork"}, count = 3},
				{classes = {"npc_mutant_bloodsucker"}, count = 2},
				{classes = {"npc_mutant_snork", "npc_mutant_bloodsucker"}, count = 3}},
		},
	},
}

field.spawnDistance = 1024
field.despawnDistance = 1536
field.useDistance = 128
field.actionInterval = 1
field.updateInterval = 1
field.maxDefences = 3
field.defenceSpawnBudget = 2

function field.Pack(position)
	return {position.x, position.y, position.z}
end

function field.Unpack(position)
	return Vector(position[1], position[2], position[3])
end

function field.CollectPoints(names, map)
	local points, visited, positions = {}, {}, {}
	local function collect(name)
		if visited[name] then return end
		visited[name] = true
		local source = field.sources[name]
		if not source then
			for _, child in ipairs(field.pools[name] or {}) do collect(child) end
			return
		end
		local plugin = ix.plugin.list[source.plugin]
		local maps = plugin and plugin[source.key]
		for _, row in pairs(maps and maps[map] or {}) do
			local point = row[1]
			if isvector(point) and not positions[tostring(point)] then
				positions[tostring(point)] = true
				points[#points + 1] = Vector(point.x, point.y, point.z)
			end
		end
	end
	for _, name in ipairs(names) do collect(name) end

	return points
end

function field.SelectRoute(settings, map, usable)
	local sources = field.CollectPoints(settings.sources, map)
	local destinations = field.CollectPoints(settings.destinationSources, map)
	table.Shuffle(sources)
	table.Shuffle(destinations)
	for _, source in ipairs(sources) do
		for _, destination in ipairs(destinations) do
			if source:DistToSqr(destination) >= settings.minRouteDistance ^ 2
				and source:DistToSqr(destination) > 0 and (not usable or usable(source)) then
				return source, destination
			end
		end
	end
end

function field.SelectDefenceSite(settings, map, usable)
	local sites = field.CollectPoints(settings.sources, map)
	local approaches = field.CollectPoints(settings.attackSources, map)
	table.Shuffle(sites)
	table.Shuffle(approaches)
	for _, site in ipairs(sites) do
		local nearby = {}
		for _, approach in ipairs(approaches) do
			local distance = site:DistToSqr(approach)
			if distance >= settings.minAttackDistance ^ 2 and distance <= settings.maxAttackDistance ^ 2
				and math.abs(site.z - approach.z) <= settings.maxHeightDifference then
				nearby[#nearby + 1] = field.Pack(approach)
				if #nearby >= settings.maxSpawnPoints then break end
			end
		end
		if #nearby > 0 and (not usable or usable(site)) then return site, nearby end
	end
end

function field.IsAvailable(definition)
	local settings = field.settings[definition.fieldType]
	if not settings then return false end
	local map = definition.fieldMap or game.GetMap()
	if definition.fieldType == "deadDrop" then return field.SelectRoute(settings, map) ~= nil end
	if definition.fieldType == "defence" then
		local manager = ix.eventController
		return manager ~= nil and manager.CanSpawnMutant ~= nil and manager.RegisterMutant ~= nil
			and field.SelectDefenceSite(settings, map) ~= nil
	end

	return #field.CollectPoints(settings.sources, map) > 0
end

function field.FindCargo(character, job)
	if not job.fieldTask then return end
	local inventory = character:GetInventory()
	if not inventory then return end
	for _, item in pairs(inventory:GetItems()) do
		if item.isFieldCargo and item:GetData("fieldOwner") == character:GetID()
			and item.uniqueID == job.fieldTask.cargo and item:GetData("fieldClaim") == job.rewardKey then
			return item
		end
	end
end

function field.CanComplete(character, job)
	if job.fieldTask and job.fieldTask.kind == "deadDrop" then return job.fieldTask.stage == "delivered" end
	if job.fieldTask and job.fieldTask.kind == "defence" then
		local defence = job.fieldTask.defence
		if defence.completedWaves ~= #defence.waves or defence.guardedSeconds < defence.duration
			or defence.health <= 0 then return false end
	end

	return job.fieldTask and job.fieldTask.stage == "carrying" and field.FindCargo(character, job) ~= nil
end

function field.CanRead(state, position, settings)
	if state.kind ~= "triangulation" or state.stage ~= "search" then return false end
	if #state.readings >= settings.readingCount then return false end
	local target = field.Unpack(state.point)
	local a = target - position
	if a.x == 0 and a.y == 0 then return false end
	for _, reading in ipairs(state.readings) do
		local previous = field.Unpack(reading)
		if position:DistToSqr(previous) < settings.readingDistance ^ 2 then return false end
		local b = target - previous
		local length = math.sqrt((a.x ^ 2 + a.y ^ 2) * (b.x ^ 2 + b.y ^ 2))
		if length == 0 then return false end
		local cosine = math.Clamp((a.x * b.x + a.y * b.y) / length, -1, 1)
		if math.deg(math.acos(cosine)) < settings.bearingAngle then return false end
	end

	return true
end

function field.ShouldSpawn(state, position)
	if state.map ~= game.GetMap() or state.stage == "carrying" or state.stage == "delivered" then return false end
	if state.kind == "sensor" and state.stage ~= "recording" then return false end
	if state.kind == "defence" and state.stage ~= "defending" and state.stage ~= "ready" then return false end
	if state.kind == "triangulation" and #state.readings < state.readingCount then return false end

	return position:DistToSqr(field.Unpack(state.point)) <= field.spawnDistance ^ 2
end
