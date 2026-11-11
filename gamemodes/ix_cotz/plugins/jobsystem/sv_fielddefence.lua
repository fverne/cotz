local encounters, attackers = {}, {}
local spawnBudget = ix.jobs.field.defenceSpawnBudget

local function claimKey(character, job)
	return character:GetID() .. ":" .. job.rewardKey
end

local function encounterCount()
	local count = 0
	for _ in pairs(encounters) do count = count + 1 end

	return count
end

function ix.jobs.field.AssignDefence(state, settings, tier, approaches)
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

function ix.jobs.field.StopDefence(character, job)
	local key = claimKey(character, job)
	local encounter = encounters[key]
	if not encounter then return end
	encounters[key] = nil
	local active = character:GetJobs()[encounter.npc]
	if active and active.rewardKey == encounter.claim and active.fieldTask.stage == "defending" then
		active.fieldTask.defence.health = encounter.health
		ix.jobs.field.SaveJob(character, encounter.npc, active)
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
	ix.jobs.field.Cleanup(character, job)
	local state = job.fieldTask
	state.stage = "deploy"
	state.defence.retryAt = os.time() + state.defence.retryDelay
	ix.jobs.field.SaveJob(character, npc, job)
	client:Notify(reason .. " Restart the sampler at the same site after the retry delay.")
end

function ix.jobs.field.StartDefence(client, character, npc, job)
	local state, defence = job.fieldTask, job.fieldTask.defence
	if state.stage ~= "deploy" then return end
	if os.time() < (defence.retryAt or 0) then
		client:Notify("The replacement sampler will be ready in " .. (defence.retryAt - os.time()) .. " seconds.")
		return
	end
	if client:GetPos():DistToSqr(ix.jobs.field.Unpack(state.point)) > ix.jobs.field.useDistance ^ 2 then
		client:Notify("Move closer to the research sampler site.")
		return
	end
	if not ix.eventController or not ix.eventController:CanSpawnMutant(ix.jobs.field.Unpack(state.point), true)
		or encounterCount() >= ix.jobs.field.maxDefences then
		client:Notify("Research cannot start while the area is at its encounter or mutant limit. Try again shortly.")
		return
	end
	defence.health, defence.completedWaves, defence.guardedSeconds = defence.maxHealth, 0, 0
	defence.attemptSeconds, defence.nextWaveAt = 0, nil
	local sampler = ix.jobs.field.SpawnObject(character, npc, job)
	if not IsValid(sampler) then return end
	state.stage = "defending"
	createEncounter(character, npc, job, sampler)
	ix.jobs.field.SaveJob(character, npc, job)
	client:Notify("Research started. Stay near the sampler, clear the waves and keep mutants away from it.")
end

local function spawnPosition(defence)
	local points = table.Copy(defence.spawnPoints)
	table.Shuffle(points)
	for _, packed in ipairs(points) do
		local point = ix.eventController:GetSpawnLocation(ix.jobs.field.Unpack(packed))
		if point
			and not ix.eventController:HasPlayerNear(point, defence.playerSafeDistance)
			and ix.eventController:CanSpawnMutant(point, true) then
			return point
		end
	end
end

local function spawnAttacker(defence, encounter, slot)
	if spawnBudget <= 0 then return end
	local position = spawnPosition(defence)
	if not position then return end
	spawnBudget = spawnBudget - 1
	local npc = ents.Create(slot.class)
	if not IsValid(npc) then
		ErrorNoHalt("[COTZ jobsystem] Failed to create research attacker " .. slot.class .. "\n")
		return
	end
	encounter.combatPack = encounter.combatPack or ix.eventController:CreateCombatPack(position, true)
	npc.cotzCombatPack, npc.cotzNoSleep = encounter.combatPack, true
	npc:SetPos(position)
	npc:Spawn()
	ix.eventController:RegisterMutant(npc, true)
	if not IsValid(npc) or npc.cotzPopulationRejected then return end
	npc.cotzCombatObjective, npc.cotzCombatObjectiveRadius = encounter.sampler, defence.threatRadius
	ix.eventController:UpdateCombatSchedule(npc)
	slot.entity = npc
	attackers[npc] = {encounter = encounter, slot = slot}
end

function ix.jobs.field.DefenceKilled(entity)
	local record = attackers[entity]
	if not record then return end
	record.slot.killed = true
	attackers[entity] = nil
end

function ix.jobs.field.DefenceDamage(entity, damage)
	if not entity.fieldOwner or not entity.fieldClaim then return end
	local encounter = encounters[entity.fieldOwner .. ":" .. entity.fieldClaim]
	local record = attackers[damage:GetAttacker()]
	if not encounter or encounter.sampler ~= entity or not record or record.encounter ~= encounter then return end
	encounter.health = math.max(0, encounter.health - math.max(0, damage:GetDamage()))
	entity:SetHealth(encounter.health)
end

-- Bundled stalker_ai cannot melee sampler props. Idle attackers disrupt the device
-- on arrival; seeing or being damaged by a player gives ordinary combat priority.
local function updateWave(defence, encounter, elapsed)
	local cleared, pressure = true, 0
	for _, slot in ipairs(encounter.slots) do
		if not slot.killed then
			cleared = false
			if not IsValid(slot.entity) or slot.entity:Health() <= 0 or slot.entity.IsAlive == false then
				if slot.entity then attackers[slot.entity] = nil end
				if IsValid(slot.entity) then slot.entity:Remove() end
				slot.entity = nil
				spawnAttacker(defence, encounter, slot)
			end
			if IsValid(slot.entity) and slot.entity:Health() > 0 then
				if not IsValid(slot.entity:GetEnemy())
					and slot.entity:GetPos():DistToSqr(encounter.sampler:GetPos()) <= defence.threatRadius ^ 2
					and slot.entity:Visible(encounter.sampler) then pressure = pressure + 1 end
			end
		end
	end
	encounter.health = math.max(0, encounter.health - pressure * defence.threatDamage * elapsed)
	defence.health = encounter.health
	encounter.sampler:SetHealth(defence.health)

	return cleared
end

function ix.jobs.field.UpdateDefence(client, character, npc, job, keep)
	if not ix.eventController then return end
	local state, defence = job.fieldTask, job.fieldTask.defence
	local key = claimKey(character, job)
	if client:IsRestricted() or IsValid(client.ixRagdoll)
		or client:GetPos():DistToSqr(ix.jobs.field.Unpack(state.point)) > defence.defendDistance ^ 2 then return end
	local encounter = encounters[key]
	if not encounter then
		if not ix.eventController or encounterCount() >= ix.jobs.field.maxDefences then return end
		local sampler = ix.jobs.field.GetObject(character, job)
		if not IsValid(sampler) then sampler = ix.jobs.field.SpawnObject(character, npc, job) end
		if not IsValid(sampler) then return end
		encounter = createEncounter(character, npc, job, sampler)
	end
	if not IsValid(encounter.sampler) then ix.jobs.field.StopDefence(character, job) return end
	keep[key] = true
	local elapsed = math.Clamp(CurTime() - encounter.lastTick, 0, ix.jobs.field.updateInterval * 2)
	encounter.lastTick = CurTime()
	defence.guardedSeconds = math.min(defence.duration, defence.guardedSeconds + elapsed)
	defence.attemptSeconds = defence.attemptSeconds + elapsed
	if os.time() >= (defence.nextWaveAt or 0) and defence.completedWaves < #defence.waves then
		if updateWave(defence, encounter, elapsed) then
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
		ix.jobs.field.StopDefence(character, job)
		client:Notify("Research complete. Collect the recorder and return it to your contact.")
	end
	ix.jobs.field.SaveJob(character, npc, job)
end

function ix.jobs.field.PruneDefences(keep)
	for key, encounter in pairs(encounters) do
		if not keep[key] then
			ix.jobs.field.StopDefence(encounter.character, {rewardKey = encounter.claim})
			local client = encounter.character:GetPlayer()
			if IsValid(client) and client:Alive() and client:GetCharacter() == encounter.character then
				client:Notify("Research paused. Return to resume; the unfinished wave restarts.")
			end
		end
	end
	spawnBudget = ix.jobs.field.defenceSpawnBudget
end
