local PLUGIN = PLUGIN

PLUGIN.mutants = {}
PLUGIN.corpses = {}

local PROXIMITY_INTERVAL = 0.5
local PLAYER_CACHE_INTERVAL = 0.25
local CORPSE_SAFE_RANGE = 1500
local playerPositions, nextPlayerCache = {}, 0
local searchTick, searches = -1, 0
local nextUpdate = 0
local rejected = 0
local spawnQueue, spawnHead, spawnTail = {}, 1, 0
local MAX_QUEUED_SPAWNS = 512
local SPAWN_EXPIRY = 30

function PLUGIN:UpdatePlayerCache()
	local now = CurTime()
	if now < nextPlayerCache then return end
	nextPlayerCache = now + PLAYER_CACHE_INTERVAL
	playerPositions = {}
	for _, client in player.Iterator() do
		playerPositions[#playerPositions + 1] = client:GetPos()
	end
end

function PLUGIN:HasPlayerNear(position, range)
	self:UpdatePlayerCache()
	local distanceSquared = range * range
	for _, playerPosition in ipairs(playerPositions) do
		if position:DistToSqr(playerPosition) <= distanceSquared then
			return true
		end
	end

	return false
end

function PLUGIN:GetPopulation(position, range, includeQueued)
	local total, nearby = 0, 0
	local rangeSquared = range * range
	for entity in pairs(self.mutants) do
		if IsValid(entity) and entity:Health() > 0 and entity.IsAlive ~= false and not entity.cotzPopulationRejected then
			total = total + 1
			if position and entity:GetPos():DistToSqr(position) <= rangeSquared then nearby = nearby + 1 end
		end
	end
	if includeQueued then
		for i = spawnHead, spawnTail do
			local request = spawnQueue[i]
			if request and CurTime() < request.expires then
				total = total + 1
				if position and request.position:DistToSqr(position) <= rangeSquared then nearby = nearby + 1 end
			end
		end
	end

	return total, nearby
end

function PLUGIN:CanQueueMutant(position, includeQueued, targetLimited)
	if ix.eventController ~= self then return false end
	if targetLimited then return self:CanPopulateMutant(position, includeQueued) end

	return self:CanSpawnMutant(position, includeQueued)
end

function PLUGIN:TakeSearchBudget()
	local tick = engine.TickCount()
	if searchTick ~= tick then
		searchTick, searches = tick, 0
	end
	if searches >= ix.config.Get("mutantSearchBudget", 4) then return false end

	searches = searches + 1

	return true
end

function PLUGIN:TrackCorpse(entity)
	self.corpses[#self.corpses + 1] = {
		entity = entity,
		expires = CurTime() + ix.config.Get("mutantCorpseLifetime", 180),
	}
end

function PLUGIN:UpdateMutantCorpses()
	local remaining = {}
	local limit = ix.config.Get("mutantCorpseLimit", 64)
	local count = 0
	for _, record in ipairs(self.corpses) do
		if IsValid(record.entity) then count = count + 1 end
	end
	for _, record in ipairs(self.corpses) do
		local entity = record.entity
		if IsValid(entity) then
			local busy = entity.GetNetVar and (entity:GetNetVar("beingSkinned", false)
				or entity:GetNetVar("beingLooted", false))
			local expired = CurTime() >= record.expires
			local overLimit = limit > 0 and count > limit
			local distant = not self:HasPlayerNear(entity:GetPos(), CORPSE_SAFE_RANGE)
			if not busy and (expired or (overLimit and distant)) then
				SafeRemoveEntity(entity)
				count = count - 1
			else
				remaining[#remaining + 1] = record
			end
		end
	end
	self.corpses = remaining
end

function PLUGIN:RegisterMutant(entity, enforceLimit)
	local class = entity:GetClass()
	if not entity:IsNPC() or class:sub(1, 11) ~= "npc_mutant_" then return end
	if self.mutants[entity] or entity.cotzPopulationRejected then return end

	if enforceLimit and not self:CanQueueMutant(entity:GetPos(), false) then
		entity.cotzPopulationRejected = true
		rejected = rejected + 1
		SafeRemoveEntity(entity)
		return
	end
	self.mutants[entity] = true
	if entity.farttimer ~= nil then
		entity.farttimer = CurTime() + (entity:EntIndex() % 10) * 0.05
	end
end

function PLUGIN:QueueMutant(class, position, safeRange, targetLimited)
	if spawnTail - spawnHead + 1 >= MAX_QUEUED_SPAWNS then return false end
	if not self:CanQueueMutant(position, true, targetLimited) then return false end

	spawnTail = spawnTail + 1
	spawnQueue[spawnTail] = {
		class = class,
		targetLimited = targetLimited,
		position = position,
		safeRange = safeRange,
		expires = CurTime() + SPAWN_EXPIRY,
	}

	return true
end

function PLUGIN:ProcessMutantQueue()
	for _ = 1, ix.config.Get("mutantSpawnBudget", 2) do
		local request = spawnQueue[spawnHead]
		if not request then break end
		spawnQueue[spawnHead] = nil
		spawnHead = spawnHead + 1

		local playerNearby = request.safeRange
			and self:HasPlayerNear(request.position, request.safeRange)
		local hasCapacity = self:CanQueueMutant(request.position, false, request.targetLimited)
		if CurTime() < request.expires and not playerNearby and hasCapacity then
			local entity = ents.Create(request.class)
			if IsValid(entity) then
				entity:SetPos(request.position)
				entity:Spawn()
				entity:DropToFloor()
				self:RegisterMutant(entity, true)
			end
		end
	end
	if spawnHead > spawnTail then spawnQueue, spawnHead, spawnTail = {}, 1, 0 end
end

function PLUGIN:OnEntityCreated(entity)
	if ix.eventController ~= self then return end
	if entity:GetClass():sub(1, 11) ~= "npc_mutant_" then return end

	timer.Simple(0, function()
		if IsValid(entity) and ix.eventController == self then self:RegisterMutant(entity, true) end
	end)
end

function PLUGIN:EntityRemoved(entity)
	if ix.eventController ~= self then return end
	self.mutants[entity] = nil
end

function PLUGIN:EntityTakeDamage(entity, damage)
	if ix.eventController ~= self then return end
	if self.mutants[entity] and entity.STALKERNPCWake then
		entity:STALKERNPCWake()
	end
	local attacker = damage:GetAttacker()
	if self.mutants[attacker] and attacker.STALKERNPCWake then attacker:STALKERNPCWake() end
end

function PLUGIN:UpdateMutantPerformance()
	if ix.eventController ~= self then return end
	self:ProcessMutantQueue()
	if CurTime() < nextUpdate then return end
	nextUpdate = CurTime() + PROXIMITY_INTERVAL
	for entity in pairs(self.mutants) do
		if IsValid(entity) and entity.IsSTALKERNPC and entity.IsAlive == true then
			entity:STALKERNPCUpdateSleep()
		end
	end
	self:UpdateMutantCorpses()
end

function PLUGIN:InitializeMutantPerformance()
	nextPlayerCache = 0
	for _, entity in ents.Iterator() do
		self:RegisterMutant(entity, false)
	end
end

function PLUGIN:InitPostEntity()
	if ix.eventController ~= self then return end
	self:InitializeMutantPerformance()
end

function PLUGIN:OnLoaded()
	timer.Simple(0, function()
		if ix.eventController == self then self:InitializeMutantPerformance() end
	end)
end

function PLUGIN:OnUnload()
	if ix.eventController ~= self then return end
	for entity in pairs(self.mutants) do
		if IsValid(entity) and entity.cotzSleeping and entity.STALKERNPCWake then
			entity:STALKERNPCWake()
		end
	end
	for _, record in ipairs(self.corpses) do
		if IsValid(record.entity) then
			record.entity:Fire("kill", "", math.max(30, record.expires - CurTime()))
		end
	end
	spawnQueue, spawnHead, spawnTail = {}, 1, 0
	ix.eventController = nil
end

function PLUGIN:GetMutantPerformanceStatus()
	local total, sleeping = 0, 0
	for entity in pairs(self.mutants) do
		if IsValid(entity) and entity:Health() > 0 and entity.IsAlive ~= false then
			total = total + 1
			if entity.cotzSleeping then sleeping = sleeping + 1 end
		end
	end

	return string.format("Mutants: %d; sleeping: %d; corpses: %d; rejected: %d; queued: %d",
		total, sleeping, #self.corpses, rejected, spawnTail - spawnHead + 1)
end
