local field = ix.jobs.field
local encounters, attackers = {}, {}
local spawnBudget = field.defenceSpawnBudget
local NPC_MIN, NPC_MAX = Vector(-32, -32, 0), Vector(32, 32, 96)
local TRACE_UP, TRACE_DOWN, CLEARANCE = Vector(0, 0, 32), Vector(0, 0, 128), Vector(0, 0, 2)

local function claimKey(character, job)
	return character:GetID() .. ":" .. job.rewardKey
end

local function encounterCount()
	local count = 0
	for _ in pairs(encounters) do count = count + 1 end

	return count
end

function field.AssignDefence(state, settings, tier, approaches)
	local defence = {
		spawnPoints = approaches, waves = {}, health = settings.samplerHealth, maxHealth = settings.samplerHealth,
		guardedSeconds = 0, completedWaves = 0, attemptSeconds = 0,
	}
	for _, name in ipairs({"defendDistance", "duration", "threatRadius", "threatDamage", "waveInterval",
		"attemptTimeout", "retryDelay", "playerSafeDistance"}) do defence[name] = settings[name] end
	for index, wave in ipairs(settings.waves[tier]) do
		local classes = {}
		for _ = 1, wave.count do classes[#classes + 1] = wave.classes[math.random(#wave.classes)] end
		defence.waves[index] = classes
	end
	state.defence = defence
end

function field.StopDefence(character, job)
	local key = claimKey(character, job)
	local encounter = encounters[key]
	if not encounter then return end
	encounters[key] = nil
	local active = character:GetJobs()[encounter.npc]
	if active and active.rewardKey == encounter.claim and active.fieldTask.stage == "defending" then
		active.fieldTask.defence.health = encounter.health
		field.SaveJob(character, encounter.npc, active)
	end
	for _, slot in ipairs(encounter.slots) do
		if slot.entity then attackers[slot.entity] = nil end
		if IsValid(slot.entity) then slot.entity:Remove() end
	end
end

local function createEncounter(character, npc, job, sampler)
	local encounter = {character = character, npc = npc, claim = job.rewardKey, sampler = sampler,
		health = job.fieldTask.defence.health, slots = {}, lastTick = CurTime()}
	for _, class in ipairs(job.fieldTask.defence.waves[job.fieldTask.defence.completedWaves + 1] or {}) do
		encounter.slots[#encounter.slots + 1] = {class = class}
	end
	encounters[claimKey(character, job)] = encounter

	return encounter
end

local function failEncounter(client, character, npc, job, reason)
	field.Cleanup(character, job)
	local state = job.fieldTask
	state.stage = "deploy"
	state.defence.retryAt = os.time() + state.defence.retryDelay
	field.SaveJob(character, npc, job)
	client:Notify(reason .. " Restart the sampler at the same site after the retry delay.")
end

function field.StartDefence(client, character, npc, job)
	local state, defence = job.fieldTask, job.fieldTask.defence
	if state.stage ~= "deploy" then return end
	if os.time() < (defence.retryAt or 0) then
		client:Notify("The replacement sampler will be ready in " .. (defence.retryAt - os.time()) .. " seconds.")
		return
	end
	if client:GetPos():DistToSqr(field.Unpack(state.point)) > field.useDistance ^ 2 then
		client:Notify("Move closer to the research sampler site.")
		return
	end
	local manager = ix.eventController
	if not manager or not manager:CanSpawnMutant(field.Unpack(state.point), true)
		or encounterCount() >= field.maxDefences then
		client:Notify("Research cannot start while the area is at its encounter or mutant limit. Try again shortly.")
		return
	end
	defence.health, defence.completedWaves, defence.guardedSeconds = defence.maxHealth, 0, 0
	defence.attemptSeconds, defence.nextWaveAt = 0, nil
	local sampler = field.SpawnObject(character, npc, job)
	if not IsValid(sampler) then return end
	state.stage = "defending"
	createEncounter(character, npc, job, sampler)
	field.SaveJob(character, npc, job)
	client:Notify("Research started. Stay near the sampler, clear the waves and keep mutants away from it.")
end

local function spawnPosition(defence)
	local manager = ix.eventController
	local points = table.Copy(defence.spawnPoints)
	table.Shuffle(points)
	for _, packed in ipairs(points) do
		local position = field.Unpack(packed)
		local trace = util.TraceHull({start = position + TRACE_UP, endpos = position - TRACE_DOWN,
			mins = NPC_MIN, maxs = NPC_MAX, mask = MASK_SOLID})
		local point = trace.HitPos + CLEARANCE
		if trace.Hit and not trace.StartSolid and trace.HitNormal.z >= 0.5 and util.IsInWorld(point)
			and not manager:HasPlayerNear(point, defence.playerSafeDistance)
			and manager:CanSpawnMutant(point, true) then
			return point
		end
	end
end

local function spawnAttacker(client, defence, encounter, slot)
	if spawnBudget <= 0 then return end
	local position = spawnPosition(defence)
	if not position then return end
	spawnBudget = spawnBudget - 1
	local npc = ents.Create(slot.class)
	if not IsValid(npc) then
		ErrorNoHalt("[COTZ jobsystem] Failed to create research attacker " .. slot.class .. "\n")
		return
	end
	npc:SetPos(position)
	npc:Spawn()
	npc:DropToFloor()
	ix.eventController:RegisterMutant(npc, true)
	if not IsValid(npc) or npc.cotzPopulationRejected then return end
	npc.cotzNoSleep = true
	npc:SetEnemy(client)
	npc:UpdateEnemyMemory(client, client:GetPos())
	slot.entity = npc
	attackers[npc] = {encounter = encounter, slot = slot}
end

function field.DefenceKilled(entity)
	local record = attackers[entity]
	if not record then return end
	record.slot.killed = true
	attackers[entity] = nil
end

function field.DefenceDamage(entity, damage)
	if not entity.fieldOwner or not entity.fieldClaim then return end
	local encounter = encounters[entity.fieldOwner .. ":" .. entity.fieldClaim]
	local record = attackers[damage:GetAttacker()]
	if not encounter or encounter.sampler ~= entity or not record or record.encounter ~= encounter then return end
	encounter.health = math.max(0, encounter.health - math.max(0, damage:GetDamage()))
	entity:SetHealth(encounter.health)
end

-- Bundled stalker_ai fights players/NPCs rather than sampler props. Visible nearby
-- mutants disrupt the equipment while engaging defenders, without detouring their AI.
local function updateWave(client, defence, encounter, elapsed)
	local cleared, pressure = true, 0
	for _, slot in ipairs(encounter.slots) do
		if not slot.killed then
			cleared = false
			if not IsValid(slot.entity) or slot.entity:Health() <= 0 or slot.entity.IsAlive == false then
				if slot.entity then attackers[slot.entity] = nil end
				if IsValid(slot.entity) then slot.entity:Remove() end
				slot.entity = nil
				spawnAttacker(client, defence, encounter, slot)
			end
			if IsValid(slot.entity) and slot.entity:Health() > 0 then
				if not IsValid(slot.entity:GetEnemy()) then
					slot.entity:SetEnemy(client)
					slot.entity:UpdateEnemyMemory(client, client:GetPos())
				end
				if slot.entity:GetPos():DistToSqr(encounter.sampler:GetPos()) <= defence.threatRadius ^ 2
					and slot.entity:Visible(encounter.sampler) then pressure = pressure + 1 end
			end
		end
	end
	encounter.health = math.max(0, encounter.health - pressure * defence.threatDamage * elapsed)
	defence.health = encounter.health
	encounter.sampler:SetHealth(defence.health)

	return cleared
end

function field.UpdateDefence(client, character, npc, job, keep)
	if not ix.eventController then return end
	local state, defence = job.fieldTask, job.fieldTask.defence
	local key = claimKey(character, job)
	if client:IsRestricted() or IsValid(client.ixRagdoll)
		or client:GetPos():DistToSqr(field.Unpack(state.point)) > defence.defendDistance ^ 2 then return end
	local encounter = encounters[key]
	if not encounter then
		if not ix.eventController or encounterCount() >= field.maxDefences then return end
		local sampler = field.GetObject(character, job)
		if not IsValid(sampler) then sampler = field.SpawnObject(character, npc, job) end
		if not IsValid(sampler) then return end
		encounter = createEncounter(character, npc, job, sampler)
	end
	if not IsValid(encounter.sampler) then field.StopDefence(character, job) return end
	keep[key] = true
	local elapsed = math.Clamp(CurTime() - encounter.lastTick, 0, field.updateInterval * 2)
	encounter.lastTick = CurTime()
	defence.guardedSeconds = math.min(defence.duration, defence.guardedSeconds + elapsed)
	defence.attemptSeconds = defence.attemptSeconds + elapsed
	if os.time() >= (defence.nextWaveAt or 0) and defence.completedWaves < #defence.waves then
		if updateWave(client, defence, encounter, elapsed) then
			for _, slot in ipairs(encounter.slots) do
				if slot.entity then attackers[slot.entity] = nil end
			end
			defence.completedWaves = defence.completedWaves + 1
			defence.nextWaveAt = os.time() + defence.waveInterval
			encounter.slots = {}
			for _, class in ipairs(defence.waves[defence.completedWaves + 1] or {}) do
				encounter.slots[#encounter.slots + 1] = {class = class}
			end
			client:Notify("Research wave cleared: " .. defence.completedWaves .. "/" .. #defence.waves .. ".")
		end
	end
	defence.health = encounter.health
	if defence.health <= 0 or defence.attemptSeconds >= defence.attemptTimeout then
		failEncounter(client, character, npc, job, "The research attempt failed.")
		keep[key] = nil
		return
	end
	if defence.completedWaves == #defence.waves and defence.guardedSeconds >= defence.duration then
		state.stage = "ready"
		field.StopDefence(character, job)
		client:Notify("Research complete. Collect the recorder and return it to your contact.")
	end
	field.SaveJob(character, npc, job)
end

function field.PruneDefences(keep)
	for key, encounter in pairs(encounters) do
		if not keep[key] then
			field.StopDefence(encounter.character, {rewardKey = encounter.claim})
			local client = encounter.character:GetPlayer()
			if IsValid(client) and client:Alive() and client:GetCharacter() == encounter.character then
				client:Notify("Research paused. Return to resume; the unfinished wave restarts.")
			end
		end
	end
	spawnBudget = field.defenceSpawnBudget
end
