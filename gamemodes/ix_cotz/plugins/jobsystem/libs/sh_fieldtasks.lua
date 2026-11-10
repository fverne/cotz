ix.jobs = ix.jobs or {}
ix.jobs.field = ix.jobs.field or {}

function ix.jobs.field.GetRecipientMap(state)
	local contact = ix.townNPCs and ix.townNPCs.byName and ix.townNPCs.byName[state.recipient]

	return contact and contact.map or state.recipientMap
end

function ix.jobs.field.Pack(position)
	return {position.x, position.y, position.z}
end

function ix.jobs.field.Unpack(position)
	return Vector(position[1], position[2], position[3])
end

function ix.jobs.field.CollectPoints(names, map)
	local points, visited, positions, pointNames = {}, {}, {}, {}
	local function collect(name)
		if visited[name] then return end
		visited[name] = true
		local source = ix.jobs.field.sources[name]
		if not source then
			for _, child in ipairs(ix.jobs.field.pools[name] or {}) do collect(child) end
			return
		end
		local plugin = ix.plugin.list[source.plugin]
		local maps = plugin and plugin[source.key]
		local rows = maps and maps[map]
		-- Read preset coordinates without deploying setup or replacing saved map edits.
		if rows == nil then
			local setup = ix.plugin.list.firsttimesetup
			local preset = setup and setup.map_presets and setup.map_presets[map]
			rows = preset and preset.plugindata and preset.plugindata[source.plugin]
		end
		for _, row in pairs(rows or {}) do
			local point = row[1]
			if isvector(point) and type(row[2]) == "string" and row[2]:find("%S") then
				pointNames[tostring(point)] = row[2]
			end
			if isvector(point) and not positions[tostring(point)] then
				positions[tostring(point)] = true
				points[#points + 1] = Vector(point.x, point.y, point.z)
			end
		end
	end
	for _, name in ipairs(names) do collect(name) end

	return points, pointNames
end

local COMPASS_DIRECTIONS = {"north", "northeast", "east", "southeast", "south", "southwest", "west", "northwest"}
local METRES_PER_UNIT = 0.01905

function ix.jobs.field.RecoveryClue(point, map, radius)
	local points, names = ix.jobs.field.CollectPoints({"event"}, map)
	local nearest, nearestDistance
	for _, candidate in ipairs(points) do
		local distance = point:DistToSqr(candidate)
		if names[tostring(candidate)] and (not nearestDistance or distance < nearestDistance) then
			nearest, nearestDistance = candidate, distance
		end
	end
	if not nearest then return end
	local name = names[tostring(nearest)]
	if nearestDistance <= (radius or 384) ^ 2 then return "Search " .. name .. "." end
	local offset = point - nearest
	local bearing = math.deg(math.atan2(-offset.y, offset.x))
	local direction = COMPASS_DIRECTIONS[math.floor((bearing + 22.5) / 45) % 8 + 1]
	local metres = math.max(10, math.floor(math.sqrt(nearestDistance) * METRES_PER_UNIT / 10 + 0.5) * 10)

	return "Search about " .. metres .. " metres " .. direction .. " of " .. name .. "."
end

function ix.jobs.field.EnsureRecoveryClue(state)
	if state.kind ~= "recovery" or state.whereabouts then return false end
	state.whereabouts = ix.jobs.field.RecoveryClue(ix.jobs.field.Unpack(state.point), state.map, state.searchRadius)

	return state.whereabouts ~= nil
end

function ix.jobs.field.GetRecoverySearchArea(state, position)
	if state.kind ~= "recovery" or state.stage ~= "search" or state.map ~= game.GetMap() then return end
	local point = ix.jobs.field.Unpack(state.point)
	local distanceSquared = position:DistToSqr(point)
	local markerDistance = ix.jobs.field.runtimeSettings.recoveryMarkerDistance
	if distanceSquared > markerDistance ^ 2 then return end
	local baseRadius = math.max(ix.jobs.field.runtimeSettings.recoveryMarkerMinRadius,
		state.searchRadius or ix.jobs.field.settings.recovery.searchRadius)
	local radius = math.max(ix.jobs.field.runtimeSettings.recoveryMarkerMinRadius,
		baseRadius * math.sqrt(distanceSquared) / markerDistance)
	local search = state.search and ix.jobs.field.Unpack(state.search) or point + Vector(baseRadius / 2, 0, 0)
	local offset = search - point
	-- Keep the object inside the approximate area, including older saved search centres.
	local offsetLength = math.sqrt(offset:LengthSqr())
	local scale = radius / math.max(baseRadius, offsetLength)

	return point + offset * scale, radius
end

function ix.jobs.field.SelectRoute(settings, map, usable, destinationMap)
	local sources = ix.jobs.field.CollectPoints(settings.sources, map)
	destinationMap = destinationMap or map
	local destinations = ix.jobs.field.CollectPoints(settings.destinationSources, destinationMap)
	table.Shuffle(sources)
	table.Shuffle(destinations)
	for _, source in ipairs(sources) do
		for _, destination in ipairs(destinations) do
			local separated = destinationMap ~= map
				or source:DistToSqr(destination) >= settings.minRouteDistance ^ 2
			if separated and (not usable or usable(source)) then
				return source, destination
			end
		end
	end
end

function ix.jobs.field.SelectDefenceSite(settings, map, usable)
	local sites = ix.jobs.field.CollectPoints(settings.sources, map)
	local approaches = ix.jobs.field.CollectPoints(settings.attackSources, map)
	table.Shuffle(sites)
	table.Shuffle(approaches)
	for _, site in ipairs(sites) do
		local nearby = {}
		for _, approach in ipairs(approaches) do
			local distance = site:DistToSqr(approach)
			if distance >= settings.minAttackDistance ^ 2 and distance <= settings.maxAttackDistance ^ 2
				and math.abs(site.z - approach.z) <= settings.maxHeightDifference then
				nearby[#nearby + 1] = ix.jobs.field.Pack(approach)
				if #nearby >= settings.maxSpawnPoints then break end
			end
		end
		if #nearby > 0 and (not usable or usable(site)) then return site, nearby end
	end
end

function ix.jobs.field.IsAvailable(definition)
	if definition.fieldMaps then return ix.jobs.regional.SelectMap(definition) ~= nil end
	local settings = ix.jobs.field.settings[definition.fieldType]
	if not settings then return false end
	if definition.fieldType == "courier" then return true end
	local map = definition.fieldMap or game.GetMap()
	if definition.fieldType == "recovery" then
		local _, names = ix.jobs.field.CollectPoints({"event"}, map)

		return next(names) ~= nil and #ix.jobs.field.CollectPoints(settings.sources, map) > 0
	end
	if definition.fieldType == "deadDrop" then
		return ix.jobs.field.SelectRoute(settings, map, nil, definition.destinationMap) ~= nil
	end
	if definition.fieldType == "defence" then
		return ix.eventController ~= nil and ix.eventController.CanSpawnMutant ~= nil
			and ix.eventController.RegisterMutant ~= nil
			and ix.jobs.field.SelectDefenceSite(settings, map) ~= nil
	end

	return #ix.jobs.field.CollectPoints(settings.sources, map) > 0
end

function ix.jobs.field.FindCargo(character, job)
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

function ix.jobs.field.GetObjectModel(state)
	local cargo = state.kind == "sensor" and "job_sensor_recorder" or state.cargo

	return ix.item.list[cargo].model
end

function ix.jobs.field.HasDiggingTool(character)
	for _, item in pairs(character:GetInventory():GetItems()) do
		if item.base == "base_hidestashers" and item:GetData("quantity", item.quantity or 0) > 0 then
			return true
		end
	end

	return false
end

function ix.jobs.field.RequireDiggingTool(client, character)
	if ix.jobs.field.HasDiggingTool(character) then return true end
	client:Notify("You need a usable stash digging tool to dig up or bury the parcel.")

	return false
end

function ix.jobs.field.ReadingBearing(state, reading)
	if reading.bearing ~= nil then return reading.bearing end
	-- Accepted assignments used bare coordinate arrays before bearings were saved explicitly.
	local delta = ix.jobs.field.Unpack(state.point) - ix.jobs.field.Unpack(reading)

	return (math.deg(math.atan2(-delta.y, delta.x)) + 360) % 360
end

function ix.jobs.field.CanComplete(character, job)
	if job.fieldTask and ix.jobs.field.NeedsDelivery(job.fieldTask) then return job.fieldTask.stage == "delivered" end
	if job.fieldTask and job.fieldTask.kind == "defence" then
		local defence = job.fieldTask.defence
		if defence.completedWaves ~= #defence.waves or defence.guardedSeconds < defence.duration
			or defence.health <= 0 then return false end
	end

	return job.fieldTask and job.fieldTask.stage == "carrying" and ix.jobs.field.FindCargo(character, job) ~= nil
end

function ix.jobs.field.NeedsDelivery(state)
	return state.kind == "deadDrop" or state.recipient ~= nil
end

function ix.jobs.field.DescribeAssignment(job)
	local state = job.fieldTask
	if state.kind == "recovery" then
		local clue = state.whereabouts or "The directions are missing. Check your notes again later."
		local item = ix.item.list[state.cargo]
		local target = state.recipient or "the issuing contact"
		local description = state.description
			or "Recover " .. (state.cargoName or item.name) .. ". Return the cargo to " .. target .. "."
		if state.description then description = string.format(description, job.numberRec) end

		return description .. " " .. clue
	end
	if state.description then return state.description end
	-- Older accepted commissions have no description snapshot. Derive their instructions
	-- from the saved assignment rather than a newly authored recipient or cargo definition.
	local item = ix.item.list[state.cargo]
	local text = "Follow the directions to find and pick up " .. (state.cargoName or item.name) .. "."
	if state.kind == "sensor" then
		text = "Set up the sensor at the marked site. Leave it to record, then pick it up."
	elseif state.kind == "triangulation" then
		text = "Take the required bearings, then find and pick up the source."
	elseif state.kind == "defence" then
		text = "Start the sampler at the marked site. Defend it until recording finishes, then pick up the results."
	end
	if state.recipient then
		text = text .. " Deliver it to " .. state.recipient .. "."
	elseif state.kind == "deadDrop" then
		text = text .. " Bury it at the marked cache."
	end

	return text .. " Return to the issuing contact to finish the assignment."
end

function ix.jobs.field.CanRead(state, position, settings)
	if state.kind ~= "triangulation" or state.stage ~= "search" then return false end
	if #state.readings >= settings.readingCount then return false end
	local target = ix.jobs.field.Unpack(state.point)
	local a = target - position
	if a.x == 0 and a.y == 0 then return false end
	for _, reading in ipairs(state.readings) do
		local previous = ix.jobs.field.Unpack(reading)
		if position:DistToSqr(previous) < settings.readingDistance ^ 2 then return false end
		local b = target - previous
		local length = math.sqrt((a.x ^ 2 + a.y ^ 2) * (b.x ^ 2 + b.y ^ 2))
		if length == 0 then return false end
		local cosine = math.Clamp((a.x * b.x + a.y * b.y) / length, -1, 1)
		if math.deg(math.acos(cosine)) < settings.bearingAngle then return false end
	end

	return true
end

function ix.jobs.field.ShouldSpawn(state, position)
	if state.kind == "courier" then return false end
	if state.map ~= game.GetMap() or state.stage == "carrying" or state.stage == "delivered" then return false end
	if state.kind == "sensor" and state.stage ~= "recording" then return false end
	if state.kind == "defence" and state.stage ~= "defending" and state.stage ~= "ready" then return false end
	if state.kind == "triangulation" and #state.readings < state.readingCount then return false end

	return position:DistToSqr(ix.jobs.field.Unpack(state.point)) <= ix.jobs.field.spawnDistance ^ 2
end
