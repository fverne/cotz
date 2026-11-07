local PLUGIN = PLUGIN
local STATE_KEY = "townNPCProgression"

function PLUGIN:InitializeTownCharacter(character)
	if not character:GetData(STATE_KEY) then
		character:SetData(STATE_KEY, {counts = {}, claims = {}, opponents = {}, pending = {}, rewardVersion = 2})
		character:Save()
	end
	local state = table.Copy(character:GetData(STATE_KEY))
	if state.rewardVersion ~= 2 then
		-- Existing field/checkpoint completions must not mint the new cash payouts on upgrade.
		-- Preserve accrued delivery credit and all pending item claims.
		local record = ix.progression.GetCharacterProgression(character)
		for id, line in pairs(record.lines) do
			if self.steps[id] and line.completed and not line.rewardCredit then
				line.completionRewardsPaid = true
			end
		end
		ix.progression.SetCharacterProgression(character, record)
		state.rewardVersion = 2
		character:SetData(STATE_KEY, state)
		character:Save()
	end
	self:RecoverCompletions(character)
	self:AdvanceCounters(character)
	ix.progression.AssignActiveRequirements(character)
end

function PLUGIN:AdvanceCounters(character)
	local state = character:GetData(STATE_KEY)
	if not state then return end
	-- Iterate a snapshot: completing a node can activate another cumulative checkpoint.
	local pending = {}
	for id, step in pairs(self.steps) do
		local definition = ix.progression.definitions[id]
		if step.kind == "tracker" and ix.progression.IsActive(character, id) then
			pending[#pending + 1] = {id = id, value = state.counts[definition.keyNpc] or 0}
		end
	end
	table.sort(pending, function(first, second) return first.id < second.id end)
	for _, checkpoint in ipairs(pending) do
		ix.progression.SetProgressionValue(character, checkpoint.id, checkpoint.value)
	end
end

function PLUGIN:RecoverCompletions(character)
	local state = table.Copy(character:GetData(STATE_KEY))
	local changed = false
	for npc, event in pairs(state.pending or {}) do
		local definition = ix.jobs.list[event.identifier]
		local id = definition and definition.townProgression
		local contact = self.byName[npc]
		local retired = (contact and #contact.progression == 0) or (definition and definition.retiredTownProgression)
		assert(retired or (id and self.steps[id]), "Unknown saved town commission: " .. event.identifier)
		if not retired and ix.progression.IsActive(character, id) then
			if self.steps[id].retiredCommission then
				-- An already accepted field assignment can still settle the same milestone once.
				ix.progression.SetCompleted(character, id)
			else
				ix.progression.SetProgressionValue(character, id, event.value or 1)
			end
			state.pending[npc] = nil
			changed = true
		end
		if not retired and ix.progression.IsCompleted(character, id) then
			state.pending[npc] = nil
			changed = true
		end
	end
	if changed then character:SetData(STATE_KEY, state) end
	-- Completion and benefit queuing are separate operations in the owning progression API.
	-- Its completion token makes this recovery safe when a stop occurred between those operations.
	local record = ix.progression.GetCharacterProgression(character)
	for id, line in pairs(record.lines) do
		local definition = self.steps[id] and ix.progression.definitions[id]
		if definition and line.completed then ix.progression.PayCompletionRewards(character, id) end
		if definition and line.completed and definition.completionBenefits
			and not (line.benefitsClaimed or {}).completion then
			ix.progression.GrantBenefits(character, id, definition.completionBenefits, "completion")
		end
	end
	if changed then character:Save() end
end

function PLUGIN:JobCompleted(client, npc, identifier)
	local character = client:GetCharacter()
	local contact = self.byName[npc]
	local definition = ix.jobs.list[identifier]
	if not character or not contact or not definition then return end
	if definition.townContact ~= contact.id then return end

	self:InitializeTownCharacter(character)
	local state = table.Copy(character:GetData(STATE_KEY))
	local claim = (character:GetData("jobClaimsPaid", {}) or {})[npc]
	if not claim or (state.claims[npc] or 0) >= claim then return end
	state.claims[npc] = claim
	if definition.townProgression then
		local id = definition.townProgression
		if definition.retiredTownProgression then
			character:SetData(STATE_KEY, state)
			character:Save()
			return
		end
		state.commissions = state.commissions or {}
		local count = math.max(state.commissions[id] or 0, ix.progression.GetProgressionValue(character, id) or 0)
		state.commissions[id] = count + 1
		state.pending[npc] = {serial = claim, identifier = identifier, value = count + 1}
	else
		state.counts[npc] = (state.counts[npc] or 0) + 1
	end
	character:SetData(STATE_KEY, state)
	character:Save()
	self:RecoverCompletions(character)
	self:AdvanceCounters(character)
end

function PLUGIN:ArenaCompleted(client, opponent)
	local contact = self.contacts["arena-master"]
	if #contact.progression == 0 or game.GetMap() ~= contact.map then return end
	local character = client:GetCharacter()
	if not character or not IsValid(opponent) or client:IsBot() or opponent:IsBot() then return end
	if client:SteamID64() == opponent:SteamID64() then return end
	self:InitializeTownCharacter(character)
	local state = table.Copy(character:GetData(STATE_KEY))
	local identity = opponent:SteamID64()
	if state.opponents[identity] then return end
	local active = {}
	for id, step in pairs(self.steps) do
		if step.kind == "arena" and ix.progression.IsActive(character, id) then active[#active + 1] = id end
	end
	if (state.counts["'Arena Master'"] or 0) >= self.settings.arenaOpponentLimit and #active == 0 then return end
	state.opponents[identity] = true
	state.counts["'Arena Master'"] = (state.counts["'Arena Master'"] or 0) + 1
	character:SetData(STATE_KEY, state)
	character:Save()
	table.sort(active)
	-- One match advances at most one authored bout; ordinary checkpoints use the cumulative total.
	if active[1] then ix.progression.AddProgressionValue(character, active[1], 1) end
	self:AdvanceCounters(character)
end
