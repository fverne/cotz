local encounters, attackers = {}, {}
local spawnBudget = ix.jobs.field.defenceSpawnBudget
local LEGACY_DEFEND_DISTANCE = 768
local APPROACH_TRACE_HEIGHT = Vector(0, 0, 36)

local function samplerComponent(sampler)
	local nodes, components = ix.eventController:GetSpawnNodes()
	if not nodes then return end
	local center = sampler:GetPos()
	local settings = ix.jobs.field.settings.defence
	local routes = {}
	for _, node in ipairs(nodes) do
		local distance = center:DistToSqr(node)
		if distance >= settings.minAttackDistance ^ 2 and distance <= settings.maxAttackDistance ^ 2
			and math.abs(center.z - node.z) <= settings.maxHeightDifference then
			routes[components[node]] = true
		end
	end
	local bestDistance = settings.nodeLinkRadius ^ 2
	local component, anchor
	for _, node in ipairs(nodes) do
		local distance = center:DistToSqr(node)
		if distance <= bestDistance and routes[components[node]] then
			local trace = util.TraceLine({
				start = center + APPROACH_TRACE_HEIGHT, endpos = node + APPROACH_TRACE_HEIGHT,
				filter = sampler, mask = MASK_PLAYERSOLID_BRUSHONLY,
			})
			if not trace.Hit and not trace.StartSolid and not trace.AllSolid then
				bestDistance, component, anchor = distance, components[node], node
			end
		end
	end

	return component, anchor
end

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

local function waveSlots(defence)
	local slots = {}
	for index, class in ipairs(defence.waves[defence.completedWaves + 1] or {}) do
		slots[index] = {class = class, killed = defence.waveKills and defence.waveKills[index] == true}
	end

	return slots
end

local function createEncounter(character, npc, job, sampler, component, anchor)
	local defence = job.fieldTask.defence
	local encounter = {character = character, npc = npc, claim = job.rewardKey, sampler = sampler,
		component = component, anchor = anchor, health = defence.health, wave = defence.completedWaves + 1,
		slots = waveSlots(defence), lastTick = CurTime()}
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
	defence.waveKills = nil
	local sampler = ix.jobs.field.SpawnObject(character, npc, job)
	if not IsValid(sampler) then return end
	local component, anchor = samplerComponent(sampler)
	if not component then
		ix.jobs.field.Cleanup(character, job)
		client:Notify("Research cannot start here. The sampler has no connected mutant approach.")
		return
	end
	state.stage = "defending"
	createEncounter(character, npc, job, sampler, component, anchor)
	ix.jobs.field.SaveJob(character, npc, job)
	client:Notify("Research started. Stay near the sampler, clear the waves and keep mutants away from it.")
end

local function findResearchSpawn(defence, encounter, recovering)
	local sampler, component = encounter.sampler, encounter.component
	local center = sampler:GetPos()
	local settings = ix.jobs.field.settings.defence
	local radius = recovering and math.min(settings.localSpawnRadius, defence.defendDistance)
		or settings.maxAttackDistance
	local minimum = recovering and math.min(defence.playerSafeDistance, radius / 2) or settings.minAttackDistance
	local function usable(position)
		local distance = center:DistToSqr(position)
		return distance <= radius ^ 2 and distance >= minimum ^ 2
			and math.abs(center.z - position.z) <= settings.maxHeightDifference
			and not ix.eventController:HasPlayerNear(position, defence.playerSafeDistance)
			and (recovering or ix.eventController:CanSpawnMutant(position, true))
	end

	if not recovering then
		local points = table.Copy(defence.spawnPoints)
		table.Shuffle(points)
		if points[1] then
			local approach = ix.jobs.field.Unpack(points[1])
			local position = ix.eventController:GetSpawnLocation(approach, nil, nil, usable, component)
			if position then return position end
		end
	end

	return ix.eventController:GetSpawnLocation(center, radius, nil, usable, component)
end

function ix.jobs.field.FindDefenceSpawn(defence)
	local points = table.Copy(defence.spawnPoints)
	local reason = "no safe spawn position near the approaches"
	table.Shuffle(points)
	for _, packed in ipairs(points) do
		local point = ix.eventController:GetSpawnLocation(ix.jobs.field.Unpack(packed))
		if point and ix.eventController:HasPlayerNear(point, defence.playerSafeDistance) then
			reason = "players too close to spawn positions"
		elseif point and not ix.eventController:CanSpawnMutant(point, true) then
			reason = "mutant population limit"
		elseif point then
			return point
		end
	end

	return nil, reason
end

local function spawnAttacker(defence, encounter, slot)
	local now = CurTime()
	if spawnBudget <= 0 or now < (encounter.nextSpawn or 0) then return end
	local position = findResearchSpawn(defence, encounter)
	if not position then
		encounter.nextSpawn = now + ix.jobs.field.updateInterval
		return
	end
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
	npc.cotzCombatObjectiveApproach = encounter.anchor
	npc.cotzCombatLeash = defence.defendDistance
	ix.eventController:UpdateCombatSchedule(npc)
	slot.entity = npc
	slot.lastPosition, slot.lastProgress, slot.nextRecovery = position, now, nil
	slot.engaged = nil
	attackers[npc] = {encounter = encounter, slot = slot}
end

function ix.jobs.field.DefenceKilled(entity)
	local record = attackers[entity]
	if not record then return end
	record.slot.killed = true
	attackers[entity] = nil
	local encounter = record.encounter
	local job = encounter.character:GetJobs()[encounter.npc]
	if not job or job.rewardKey ~= encounter.claim or not job.fieldTask
		or job.fieldTask.stage ~= "defending" then return end
	local defence = job.fieldTask.defence
	if defence.completedWaves + 1 ~= encounter.wave then return end
	-- Save each kill before the next update can pause or recreate this encounter.
	defence.waveKills = {}
	for index, slot in ipairs(encounter.slots) do defence.waveKills[index] = slot.killed == true end
	ix.jobs.field.SaveJob(encounter.character, encounter.npc, job)
end

function ix.jobs.field.DefenceDamage(entity, damage)
	if not entity.fieldOwner or not entity.fieldClaim then return end
	local encounter = encounters[entity.fieldOwner .. ":" .. entity.fieldClaim]
	local record = attackers[damage:GetAttacker()]
	if not encounter or encounter.sampler ~= entity or not record or record.encounter ~= encounter then return end
	encounter.health = math.max(0, encounter.health - math.max(0, damage:GetDamage()))
	entity:SetHealth(encounter.health)
end

local function recoverAttacker(defence, encounter, slot, disrupting)
	local actor = slot.entity
	local now, position = CurTime(), actor:GetPos()
	if GetConVar("ai_disabled"):GetInt() ~= 0 then
		slot.lastPosition, slot.lastProgress = position, now
		return
	end

	local settings = ix.jobs.field.settings.defence
	local enemy = actor:GetEnemy()
	local beyondRadius = position:DistToSqr(encounter.sampler:GetPos()) > defence.defendDistance ^ 2
	if not beyondRadius and (disrupting or IsValid(enemy)) then slot.engaged = true end
	local canMelee = IsValid(enemy) and actor:Visible(enemy)
		and actor:STALKERNPCEnemyInMeleeRange(enemy, actor.MeleeAttackDistanceMin, actor.MeleeAttackDistance) ~= 0
	local outside = slot.engaged and beyondRadius
	if (not outside and (disrupting or canMelee))
		or position:DistToSqr(slot.lastPosition) >= settings.stallProgress ^ 2 then
		slot.lastPosition, slot.lastProgress = position, now
	end

	local stalled = now - slot.lastProgress >= settings.stallSeconds
	if spawnBudget <= 0 or now < (slot.nextRecovery or 0) or actor:STALKERNPCNavigationBusy()
		or (not stalled and not (outside and actor:IsOnGround())) then return end

	slot.nextRecovery = now + settings.recoveryInterval
	local destination = findResearchSpawn(defence, encounter, true)
	if not destination then return end
	spawnBudget = spawnBudget - 1
	actor:StopMoving()
	actor:SetLocalVelocity(vector_origin)
	actor:SetPos(destination)
	actor.cotzNavigationRecovery, actor.cotzNavigationRetreat, actor.cotzUnreachableRecovery = nil, nil, nil
	actor.cotzNavigationSafePosition = nil
	actor.cotzCombatObjectiveApproach = encounter.anchor
	ix.eventController:ClearCombatEnemy(actor)
	ix.eventController:UpdateCombatSchedule(actor)
	slot.lastPosition, slot.lastProgress = destination, now
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
				local disrupting = not IsValid(slot.entity:GetEnemy())
					and slot.entity:GetPos():DistToSqr(encounter.sampler:GetPos()) <= defence.threatRadius ^ 2
					and slot.entity:Visible(encounter.sampler)
				if disrupting then pressure = pressure + 1 end
				recoverAttacker(defence, encounter, slot, disrupting)
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
	-- Accepted assignments retain their tuning; upgrade only the former default radius.
	if defence.defendDistance == LEGACY_DEFEND_DISTANCE then
		defence.defendDistance = ix.jobs.field.settings.defence.defendDistance
	end
	local key = claimKey(character, job)
	if client:IsRestricted() or IsValid(client.ixRagdoll)
		or client:GetPos():DistToSqr(ix.jobs.field.Unpack(state.point)) > defence.defendDistance ^ 2 then return end
	local encounter = encounters[key]
	if not encounter then
		if not ix.eventController or encounterCount() >= ix.jobs.field.maxDefences then return end
		local sampler = ix.jobs.field.GetObject(character, job)
		if not IsValid(sampler) then sampler = ix.jobs.field.SpawnObject(character, npc, job) end
		if not IsValid(sampler) then return end
		local component, anchor = samplerComponent(sampler)
		if not component then return end
		encounter = createEncounter(character, npc, job, sampler, component, anchor)
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
			defence.waveKills = nil
			encounter.wave = defence.completedWaves + 1
			encounter.slots = waveSlots(defence)
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
				client:Notify("Research paused. Return to resume; defeated attackers stay cleared.")
			end
		end
	end
	spawnBudget = ix.jobs.field.defenceSpawnBudget
end
