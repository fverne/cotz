local field = ix.jobs.field

function field.Assign(character, npc, job)
	local definition = ix.jobs.list[job.identifier]
	local settings = field.settings[definition.fieldType]
	if not settings then return false end
	local map = definition.fieldMap or game.GetMap()
	local points = field.CollectPoints(settings.sources, map)
	if #points == 0 then return false end
	table.Shuffle(points)
	local function usable(candidate)
		return map ~= game.GetMap() or field.GroundPoint(candidate, settings.cargo) ~= nil
	end
	local point, destination, approaches
	if definition.fieldType == "deadDrop" then
		point, destination = field.SelectRoute(settings, map, usable)
	elseif definition.fieldType == "defence" then
		point, approaches = field.SelectDefenceSite(settings, map, usable)
	else
		for _, candidate in ipairs(points) do
			if definition.fieldType == "sensor" or usable(candidate) then point = candidate break end
		end
	end
	if not point then return false end
	local searchRadius = settings.searchRadius or 0
	local search = point + Vector(math.Rand(-searchRadius / 2, searchRadius / 2),
		math.Rand(-searchRadius / 2, searchRadius / 2), 0)
	job.fieldTask = {
		kind = definition.fieldType, map = map, point = field.Pack(point), search = field.Pack(search),
		stage = (definition.fieldType == "sensor" or definition.fieldType == "defence") and "deploy" or "search",
		readings = {}, destination = destination and field.Pack(destination),
		readingCount = settings.readingCount, readingDistance = settings.readingDistance,
		bearingAngle = settings.bearingAngle,
		recordSeconds = settings.recordSeconds, leaveDistance = settings.leaveDistance,
		deployDistance = settings.deployDistance,
		cargo = settings.cargo, searchRadius = searchRadius,
	}
	if definition.fieldType == "defence" then
		field.AssignDefence(job.fieldTask, settings, definition.tier, approaches)
	end

	return true
end

