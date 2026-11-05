function ix.jobs.getNPCJobs(npc, categories, amount)
	amount = math.Clamp(math.floor(tonumber(amount) or 0), 0, ix.jobs.settings.maxNPCOffers)
	local previous = ix.jobs.activejobs[npc] or {}
	local offers = {}
	for _, offer in pairs(previous) do
		if #offers < amount and ix.jobs.list[offer.identifier] and (offer.expiration or 0) > os.time() then
			offers[#offers + 1] = offer
		end
	end
	for _ = #offers + 1, amount do
		local identifier = ix.jobs.getJobFromCategory(categories)
		if not identifier then break end
		offers[#offers + 1] = {identifier = identifier, expiration = os.time() + ix.jobs.settings.npcOfferLifetime}
	end
	ix.jobs.activejobs[npc] = offers
	local identifiers = {}
	for index, offer in ipairs(offers) do identifiers[index] = offer.identifier end

	return identifiers
end

function ix.jobs.NPCHasJob(npc, identifier)
	for _, offer in pairs(ix.jobs.activejobs[npc] or {}) do
		if offer.identifier == identifier and (offer.expiration or 0) > os.time() then return true end
	end

	return false
end

function ix.jobs.setNPCJobTaken(npc, identifier)
	local offers = ix.jobs.activejobs[npc] or {}
	for index, offer in pairs(offers) do
		if offer.identifier == identifier then
			offers[index] = nil
			return
		end
	end
end

local function canRequest(client)
	if not client:GetCharacter() then return false end
	if CurTime() < (client.cotzJobNext or 0) then return false end
	client.cotzJobNext = CurTime() + ix.jobs.settings.actionInterval

	return true
end

local function canUseContact(client, target, npc)
	return IsValid(target) and target:GetClass() == "ix_vendor_adv" and target:GetDisplayName() == npc
		and target:CanAccess(client)
		and client:GetPos():DistToSqr(target:GetPos()) <= ix.jobs.settings.interactionDistance ^ 2
		and ix.progression.CanUseNPC(client:GetCharacter(), npc)
end

netstream.Hook("job_updatenpcjobs", function(client, target, npc)
	if not canRequest(client) or type(npc) ~= "string" or not canUseContact(client, target, npc) then return end
	local definition = ix.jobs.settings.legacyOffers[npc]
	if not definition then return end
	-- Legacy clients still send categories/count; the server owns both values.
	target:SetNetVar("jobs", ix.jobs.getNPCJobs(npc, definition.categories, definition.amount))
end)

netstream.Hook("job_deliveritem", function(client, npc)
	if not canRequest(client) or type(npc) ~= "string" then return end
	local target = ix.progression.GetNPCFromName(npc)
	if not canUseContact(client, target, npc) then return end
	if ix.taskRewards.DeliverJobItem(client, npc) then
		client:Notify("Item delivered!")
	else
		client:Notify("No matching item delivery is available.")
	end
end)

netstream.Hook("job_removeplayerjob", function(client, npc)
	if canRequest(client) and type(npc) == "string" then client:ixJobRemove(npc) end
end)

ix.command.Add("CharResetJobs", {
	adminOnly = true,
	arguments = {ix.type.character},
	OnRun = function(self, client, character)
		for _, job in pairs(character:GetJobs()) do
			ix.taskRewards.RemoveJobOffer(character, job)
			if job.fieldTask then ix.jobs.field.Cleanup(character, job) end
		end
		character:SetJobs({})
		character:Save()
		client:Notify("Reset the jobs of " .. character:GetName())
		local target = character:GetPlayer()
		if IsValid(target) then target:Notify("Jobs have been reset") end
	end,
})
