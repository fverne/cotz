function ix.jobs.field.Assign(character, npc, job)
	local definition = ix.jobs.list[job.identifier]
	if definition.fieldType == "courier" then return ix.jobs.regional.AssignCourier(character, npc, job) end
	if not ix.jobs.field.settings[definition.fieldType] then return false end
	local settings = table.Copy(ix.jobs.field.settings[definition.fieldType])
	for key, value in pairs(definition.fieldSettings or {}) do settings[key] = value end
	local cargo = definition.fieldCargo or settings.cargo
	if definition.fieldCargoChoices then
		cargo = definition.fieldCargoChoices[math.random(#definition.fieldCargoChoices)]
	end
	local map = definition.fieldMap or game.GetMap()
	if definition.fieldMaps then map = ix.jobs.regional.SelectMap(definition) end
	if not map then return false end
	local points = ix.jobs.field.CollectPoints(settings.sources, map)
	if #points == 0 then return false end
	table.Shuffle(points)
	local function usable(candidate)
		return map ~= game.GetMap() or ix.jobs.field.GroundPoint(candidate, cargo) ~= nil
	end
	local point, destination, approaches
	if definition.fieldType == "deadDrop" then
		point, destination = ix.jobs.field.SelectRoute(settings, map, usable, definition.destinationMap)
	elseif definition.fieldType == "defence" then
		point, approaches = ix.jobs.field.SelectDefenceSite(settings, map, usable)
	else
		for _, candidate in ipairs(points) do
			local hasClue = definition.fieldType ~= "recovery"
				or ix.jobs.field.RecoveryClue(candidate, map, settings.searchRadius) ~= nil
			if hasClue and (definition.fieldType == "sensor" or usable(candidate)) then point = candidate break end
		end
	end
	if not point then return false end
	local searchRadius = settings.searchRadius or 0
	local search = point + Vector(math.Rand(-searchRadius / 2, searchRadius / 2),
		math.Rand(-searchRadius / 2, searchRadius / 2), 0)
	job.fieldTask = {
		kind = definition.fieldType, map = map, point = ix.jobs.field.Pack(point), search = ix.jobs.field.Pack(search),
		stage = (definition.fieldType == "sensor" or definition.fieldType == "defence") and "deploy" or "search",
		readings = {}, destination = destination and ix.jobs.field.Pack(destination),
		destinationMap = definition.destinationMap or map,
		readingCount = settings.readingCount, readingDistance = settings.readingDistance,
		bearingAngle = settings.bearingAngle,
		recordSeconds = settings.recordSeconds, leaveDistance = settings.leaveDistance,
		deployDistance = settings.deployDistance,
		cargo = cargo, cargoName = definition.fieldCargoName, cargoDescription = definition.fieldCargoDescription,
		description = definition.desc, searchRadius = searchRadius,
		recipient = definition.fieldRecipient, recipientMap = definition.fieldRecipientMap,
	}
	if definition.fieldCargoChoices then
		job.fieldTask.cargoName = ix.item.list[cargo].name
		job.fieldTask.cargoDescription = ix.item.list[cargo].description
	end
	ix.jobs.field.EnsureRecoveryClue(job.fieldTask)
	if definition.fieldType == "defence" then
		ix.jobs.field.AssignDefence(job.fieldTask, settings, definition.tier, approaches)
		if definition.regionalWaves then
			job.fieldTask.defence.waves = ix.jobs.regional.DefenceWaves(map, definition.tier)
		end
	end

	return true
end

