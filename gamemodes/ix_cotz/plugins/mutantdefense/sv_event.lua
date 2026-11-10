local PLUGIN = PLUGIN

local attackers = {}
local nextUpdate = 0

function PLUGIN:GetDefenderPosition(client)
	local character = client:GetCharacter()
	if not character then return end
	local corpse = ix.temp and ix.temp.Corpses and ix.temp.Corpses[client]
	if IsValid(corpse) then return corpse:GetPos() end
	if IsValid(client.ixRagdoll) then return client.ixRagdoll:GetPos() end
	if not client:Alive() then
		local death = self.event and self.event.deaths[client]
		if death and death.character == character then return death.position end
		return
	end
	if client:GetMoveType() == MOVETYPE_NOCLIP or client:GetObserverMode() ~= OBS_MODE_NONE then return end

	return client:GetPos()
end

function PLUGIN:IsLivingDefender(client)
	return client:Alive() and not client:IsRestricted() and not IsValid(client.ixRagdoll)
		and not IsValid(ix.temp and ix.temp.Corpses and ix.temp.Corpses[client])
		and client:GetMoveType() ~= MOVETYPE_NOCLIP and client:GetObserverMode() == OBS_MODE_NONE
end

function PLUGIN:GetDefenders()
	local present, living = {}, {}
	for _, client in player.Iterator() do
		local position = self:GetDefenderPosition(client)
		if position and position:DistToSqr(self.event.center) <= self.settings.defendRadius ^ 2 then
			present[client:GetCharacter():GetID()] = client
			if self:IsLivingDefender(client) then living[#living + 1] = client end
		end
	end

	return present, living
end

function PLUGIN:NotifyDefense(message)
	local present = self:GetDefenders()
	for _, client in pairs(present) do client:Notify(message) end
end

function PLUGIN:StartDefense(position)
	if self.event then return "A mutant defense is already active." end
	if not ix.eventController or not ix.vendorStock then return "Defense requires the encounter and vendor plugins." end
	local center = ix.eventController:GetGroundedSpawnLocation(position)
	if not center then return "That location has no clear, safe ground for a defense." end
	self.event = {
		center = center, started = CurTime(), nextWave = CurTime() + self.settings.preparation,
		phase = "preparing", wave = 0, slots = {}, candidates = {}, credited = {}, deaths = {},
	}
	self:NotifyDefense(
		"Mutant defense begins in " .. self.settings.preparation
		.. " seconds. Hold the area for a full wave and remain until the defense ends to earn a restock voucher."
	)

	return "Defense placed at " .. tostring(center) .. ". Radius: " .. self.settings.defendRadius .. " units."
end

function PLUGIN:RemainingAttackers()
	local remaining = 0
	for _, slot in ipairs(self.event.slots) do
		if not slot.killed then remaining = remaining + 1 end
	end

	return remaining
end

function PLUGIN:BeginDefenseWave(living)
	local event = self.event
	event.wave = event.wave + 1
	event.phase, event.slots, event.candidates = "fighting", {}, {}
	event.pack = ix.eventController:CreateCombatPack(event.center, true)
	local count = math.min(#living, self.settings.scalingCap)
	for _, group in ipairs(self.settings.waves[event.wave]) do
		for _ = 1, group.base + math.ceil(group.perDefender * count) do
			event.slots[#event.slots + 1] = {class = group.class}
		end
	end
	for _, client in ipairs(living) do
		event.candidates[client:GetCharacter():GetID()] = client:GetCharacter()
	end
	self:NotifyDefense(
		"Mutant defense wave " .. event.wave .. "/" .. #self.settings.waves .. ": " .. #event.slots .. " attackers."
	)
end

function PLUGIN:FindDefenseSpawn()
	for _ = 1, self.settings.placementAttempts do
		local position = ix.eventController:GetSpawnLocation(self.event.center, self.settings.spawnMaximum)
		if position and position:DistToSqr(self.event.center) >= self.settings.spawnMinimum ^ 2
			and position:DistToSqr(self.event.center) <= self.settings.spawnMaximum ^ 2
			and not ix.eventController:HasPlayerNear(position, self.settings.playerSafeDistance)
			and ix.eventController:CanSpawnMutant(position, true) then
			return position
		end
	end
end

function PLUGIN:SpawnDefenseAttackers(living)
	local budget = self.settings.spawnBudget
	for _, slot in ipairs(self.event.slots) do
		if not slot.killed and not IsValid(slot.entity) then
			if budget <= 0 then break end
			budget = budget - 1
			local position = self:FindDefenseSpawn()
			if not position then break end
			local entity = ents.Create(slot.class)
			if not IsValid(entity) then
				ErrorNoHalt("[COTZ mutantdefense] Cannot create " .. slot.class .. "\n")
				break
			end
			entity.cotzCombatPack, entity.cotzNoSleep = self.event.pack, true
			entity:SetPos(position)
			slot.entity, attackers[entity] = entity, slot
			entity:Spawn()
			if IsValid(entity) then ix.eventController:RegisterMutant(entity, true, self.event.pack) end
			if not IsValid(entity) or entity.cotzPopulationRejected then
				slot.entity, attackers[entity] = nil, nil
			elseif not slot.killed and IsValid(living[1]) then
				local target = living[1]
				ix.eventController:SetCombatTarget(entity, target, target:GetPos(), CurTime())
			end
		end
	end
end

function PLUGIN:OnNPCKilled(entity)
	local slot = attackers[entity]
	if not slot then return end
	slot.killed = true
	attackers[entity] = nil
end

function PLUGIN:EntityRemoved(entity)
	local slot = attackers[entity]
	if not slot then return end
	slot.entity, attackers[entity] = nil, nil
end

function PLUGIN:EndDefense(message, success)
	local event = self.event
	if not event then return end
	local present = self:GetDefenders()
	self:NotifyDefense(message)
	-- Detach before removing actors or granting items: callbacks cannot finish this event twice.
	self.event = nil
	for _, slot in ipairs(event.slots) do
		if slot.entity then attackers[slot.entity] = nil end
		if not slot.killed and IsValid(slot.entity) then slot.entity:Remove() end
	end
	if not success then return end
	for id, character in pairs(event.credited) do
		local client = present[id]
		if IsValid(client) and client:GetCharacter() == character then self:AwardVoucher(character) end
	end
end

function PLUGIN:UpdateDefense()
	local event = self.event
	if not event then return end
	if not ix.eventController or CurTime() - event.started >= self.settings.timeout then
		self:EndDefense("Mutant defense failed: the encounter timed out or its spawning service stopped.")
		return
	end
	local present, living = self:GetDefenders()
	for id, character in pairs(event.candidates) do
		if not present[id] or present[id]:GetCharacter() ~= character then event.candidates[id] = nil end
	end
	if #living == 0 then
		if not event.emptySince then
			event.emptySince = CurTime()
			self:NotifyDefense(
				"No living defenders remain. Return within " .. self.settings.abandonGrace
				.. " seconds or the defense fails."
			)
		end
		if CurTime() - event.emptySince >= self.settings.abandonGrace then
			self:EndDefense("Mutant defense failed: the area was abandoned.")
			return
		end
		-- A final mutual kill still completes the defense before abandonment expires.
		if event.phase ~= "fighting" or self:RemainingAttackers() > 0 then return end
	else
		event.emptySince = nil
	end
	if event.phase ~= "fighting" then
		if CurTime() >= event.nextWave then self:BeginDefenseWave(living) end
		return
	end
	self:SpawnDefenseAttackers(living)
	if self:RemainingAttackers() > 0 then return end
	for id, character in pairs(event.candidates) do event.credited[id] = character end
	if event.wave == #self.settings.waves then
		self:EndDefense("Mutant defense complete. Defenders who held a full wave earn a restock voucher.", true)
		return
	end
	event.phase, event.nextWave = "break", CurTime() + self.settings.waveBreak
	self:NotifyDefense("Wave cleared. The next wave begins in " .. self.settings.waveBreak .. " seconds.")
end

function PLUGIN:Think()
	if not self.event or CurTime() < nextUpdate then return end
	nextUpdate = CurTime() + self.settings.updateInterval
	self:UpdateDefense()
end

function PLUGIN:PlayerDeath(client)
	if not self.event then return end
	self.event.deaths[client] = {character = client:GetCharacter(), position = client:GetPos()}
end

function PLUGIN:PlayerSpawn(client)
	if self.event then self.event.deaths[client] = nil end
end

function PLUGIN:PrePlayerLoadedCharacter(client, character, previous)
	if not self.event then return end
	self.event.deaths[client] = nil
	if previous then self.event.candidates[previous:GetID()] = nil end
end

function PLUGIN:PlayerDisconnected(client)
	if not self.event then return end
	local character = client:GetCharacter()
	if character then self.event.candidates[character:GetID()] = nil end
	self.event.deaths[client] = nil
end

function PLUGIN:PreCleanupMap()
	self:EndDefense("Mutant defense cancelled for map cleanup.")
end

function PLUGIN:OnUnload()
	self:EndDefense("Mutant defense cancelled because its plugin stopped.")
	ix.mutantDefense = nil
end

function PLUGIN:OnLoaded()
	ix.mutantDefense = self
	-- Discard a running session when Helix reloads this existing plugin table.
	if self.event then self:EndDefense("Mutant defense cancelled because its plugin reloaded.") end
end

function PLUGIN:PluginUnloaded(uniqueID)
	if uniqueID ~= self.uniqueID and uniqueID ~= "eventcontroller" then return end
	self:EndDefense("Mutant defense cancelled because a required plugin stopped.")
	if uniqueID == self.uniqueID then ix.mutantDefense = nil end
end
