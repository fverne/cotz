local PLUGIN = PLUGIN
local STATE_KEY = "townNPCProgression"

function PLUGIN:InitializeTownCharacter(character)
	if not character:GetData(STATE_KEY) then
		character:SetData(STATE_KEY, {counts = {}, claims = {}, opponents = {}, pending = {}})
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
		assert(id and self.steps[id], "Unknown saved town commission: " .. event.identifier)
		if ix.progression.IsActive(character, id) then ix.progression.SetProgressionValue(character, id, 1) end
		if ix.progression.IsCompleted(character, id) then
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
		state.pending[npc] = {serial = claim, identifier = identifier}
	else
		state.counts[npc] = (state.counts[npc] or 0) + 1
	end
	character:SetData(STATE_KEY, state)
	character:Save()
	self:RecoverCompletions(character)
	self:AdvanceCounters(character)
end

function PLUGIN:ArenaCompleted(client, opponent)
	if game.GetMap() ~= self.contacts["arena-master"].map then return end
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
