local PLUGIN = PLUGIN

local attackers = {}
local nextUpdate = 0

function PLUGIN:GetDefenderPosition(client)
	local character = client:GetCharacter()
	if not character then return end
	local corpse = ix.temp and ix.temp.Corpses and ix.temp.Corpses[client]
	if not client:Alive() and IsValid(corpse) then return corpse:GetPos() end
	if IsValid(client.ixRagdoll) then return client.ixRagdoll:GetPos() end
	if not client:Alive() then
		local death = self.event and self.event.deaths[client]
		if death and death.character == character then return death.position end
		return
	end
	if client:GetMoveType() == MOVETYPE_NOCLIP or client:GetMoveType() == MOVETYPE_OBSERVER then return end

	return client:GetPos()
end

function PLUGIN:IsLivingDefender(client)
	-- A revive can leave a valid corpse until the next tick; use the player's actual life/movement state.
	return client:Alive() and not client:IsRestricted() and not IsValid(client.ixRagdoll)
		and client:GetMoveType() ~= MOVETYPE_NOCLIP and client:GetMoveType() ~= MOVETYPE_OBSERVER
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

function PLUGIN:DriverDefense(message)
	local receivers = {}
	for _, client in pairs(self:GetDefenders()) do receivers[#receivers + 1] = client end
	if #receivers == 0 then return end
	ix.chat.Send(nil, "cotz/mutantdefense/driver", message, true, receivers)
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
	event.nextWave = nil
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
	print("[COTZ mutantdefense] Wave", event.wave, "attackers:", #event.slots)
	self:DriverDefense(event.wave == 1 and "Here they come! Keep them away from the truck!"
		or "More mutants coming in! Watch the approaches!")
end

function PLUGIN:FindDefenseSpawn()
	local position, reason = ix.jobs.field.FindDefenceSpawn(self.event)
	self.event.spawnBlocked = reason

	return position
end

function PLUGIN:SpawnDefenseAttackers(living)
	self.event.spawnBlocked = nil
	local budget = self.settings.spawnBudget
	for _, slot in ipairs(self.event.slots) do
		if not slot.killed and not IsValid(slot.entity) then
			if budget <= 0 then break end
			budget = budget - 1
			local position = self:FindDefenseSpawn()
			if not position then break end
			local entity = ents.Create(slot.class)
			if not IsValid(entity) then
				self.event.spawnBlocked = "attacker creation failed"
				ErrorNoHalt("[COTZ mutantdefense] Cannot create " .. slot.class .. "\n")
				break
			end
			entity.cotzCombatPack, entity.cotzNoSleep = self.event.pack, true
			entity:SetPos(position)
			slot.entity, attackers[entity] = entity, slot
			entity:Spawn()
			if IsValid(entity) then ix.eventController:RegisterMutant(entity, true, self.event.pack) end
			if not IsValid(entity) or entity.cotzPopulationRejected then
				self.event.spawnBlocked = "attacker removed or rejected during creation"
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

function PLUGIN:EndDefense(message, success, immediateCleanup)
	local event = self.event
	if not event then return end
	local present = self:GetDefenders()
	print("[COTZ mutantdefense]", message)
	if event.phase ~= "deploying" then
		self:DriverDefense(success
			and "That was the last of them. Thanks for covering me! I've got trader supplies for those who held them off."
			or "I can't hold out here any longer! Get clear of the truck!")
	end
	-- Detach before removing actors or granting items: callbacks cannot finish this event twice.
	self.event = nil
	-- A pre-automation session may still be active when this plugin is reloaded.
	if event.dupePlugin then
		if immediateCleanup or event.phase == "deploying" then
			event.dupePlugin:DespawnDupe(event.dupeID)
		else
			timer.Simple(self.settings.sceneCleanupDelay, function()
				event.dupePlugin:DespawnDupe(event.dupeID)
			end)
		end
	end
	self:ScheduleDefense()
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
	local dependencyError = self:GetDefenseDependencyError()
	if dependencyError then
		self:EndDefense(dependencyError)
		return
	end
	if event.phase == "deploying" then
		if CurTime() >= event.deployDeadline then
			self:EndDefense("Supply-truck deployment timed out.")
			self:DefenseStartFailed("Supply-truck deployment timed out.")
		end
		return
	end
	if event.phase == "warning" then
		if CurTime() < event.nextWave then return end
		event.phase, event.started = "preparing", CurTime()
	end
	if CurTime() - event.started >= self.settings.timeout then
		self:EndDefense("Mutant defense failed: the encounter timed out or its spawning service stopped.")
		return
	end
	local present, living = self:GetDefenders()
	for id, character in pairs(event.candidates) do
		if not present[id] or present[id]:GetCharacter() ~= character then event.candidates[id] = nil end
	end
	if #living == 0 then
		event.spawnBlocked = "no living defenders in the area"
		if not event.emptySince then
			event.emptySince = CurTime()
			print("[COTZ mutantdefense] No living defenders; abandonment grace:", self.settings.abandonGrace)
			self:DriverDefense("Is anyone still out there? I need someone covering this truck!")
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
		self:EndDefense("Mutant defense complete. Defenders who held a full wave earn a trader supply.", true)
		return
	end
	event.phase, event.nextWave = "break", CurTime() + self.settings.waveBreak
	print("[COTZ mutantdefense] Wave cleared; next wave in seconds:", self.settings.waveBreak)
	self:DriverDefense("Good job clearing those mutants, but I see more coming! Catch your breath and reload!")
end

function PLUGIN:Think()
	if self.enabled == false or CurTime() < nextUpdate then return end
	nextUpdate = CurTime() + self.settings.updateInterval
	if self.event then
		self:UpdateDefense()
	else
		self:UpdateDefenseSchedule()
	end
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
	self:EndDefense("Mutant defense cancelled for map cleanup.", false, true)
end

function PLUGIN:OnUnload()
	self.enabled = false
	self:EndDefense("Mutant defense cancelled because its plugin stopped.", false, true)
	self.nextDefense = nil
	ix.mutantDefense = nil
end

function PLUGIN:OnLoaded()
	ix.mutantDefense = self
	-- Discard a running session when Helix reloads this existing plugin table.
	if self.event then self:EndDefense("Mutant defense cancelled because its plugin reloaded.", false, true) end
	self.enabled = true
	nextUpdate = 0
	self:ScheduleDefense()
end

function PLUGIN:PluginUnloaded(uniqueID)
	if uniqueID == self.uniqueID then
		self:OnUnload()
		return
	end
	if not self:IsDefenseDependency(uniqueID) then return end
	self:EndDefense("Mutant defense cancelled because a required plugin stopped.", false, true)
end

function PLUGIN:PluginLoaded(uniqueID)
	if self:IsDefenseDependency(uniqueID) then
		self:EndDefense("Mutant defense cancelled because a required plugin reloaded.", false, true)
	end
end
