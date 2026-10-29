local PLUGIN = PLUGIN
ix.eventController = PLUGIN

function PLUGIN:GetMapSetting(key, default)
	local value = ix.config.Get(key .. "_" .. game.GetMap(), -1)
	if value < 0 then return ix.config.Get(key, default) end

	return value
end

function PLUGIN:GetMutantLimits()
	return self:GetMapSetting("mutantLimit", 128), self:GetMapSetting("mutantRegionLimit", 32)
end

function PLUGIN:GetMutantTarget()
	local target = self:GetMapSetting("eventControllerThreshold", 70)
	local limit = self:GetMutantLimits()

	return limit > 0 and math.min(target, limit) or target
end

function PLUGIN:GetMutantPopulation(position, includeQueued)
	local range = ix.config.Get("mutantRegionRange", 4096)

	return self:GetPopulation(position, range, includeQueued)
end

function PLUGIN:GetNumMutants(includeQueued)
	local total = self:GetMutantPopulation(nil, includeQueued)

	return total
end

function PLUGIN:CanSpawnMutant(position, includeQueued)
	local total, nearby = self:GetMutantPopulation(position, includeQueued)
	local limit, regionLimit = self:GetMutantLimits()

	return (limit == 0 or total < limit) and (regionLimit == 0 or nearby < regionLimit)
end

function PLUGIN:CanPopulateMutant(position, includeQueued)
	local total, nearby = self:GetMutantPopulation(position, includeQueued)
	local _, regionLimit = self:GetMutantLimits()

	return total < self:GetMutantTarget() and (regionLimit == 0 or nearby < regionLimit)
end

function PLUGIN:GetPopulationStatus()
	local limit, regionLimit = self:GetMutantLimits()
	local prefix = string.format("Map: %s; target: %d; limits: %d global / %d regional; ",
		game.GetMap(), self:GetMutantTarget(), limit, regionLimit)

	return prefix .. self:GetMutantPerformanceStatus()
end

