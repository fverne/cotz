local DIG_SECONDS = 8

local function ownsTool(character, tool)
	for _, item in pairs(character:GetInventory():GetItems()) do
		if item == tool and item.base == "base_hidestashers"
			and item:GetData("quantity", item.quantity or 0) > 0 then return true end
	end

	return false
end

function ix.jobs.field.DigDeadDrop(client, tool, issuer)
	local character = client:GetCharacter()
	if not character then return false end
	for npc, job in SortedPairs(character:GetJobs()) do
		local state = job.fieldTask
		if state and state.kind == "deadDrop" and state.stage ~= "delivered" and (not issuer or issuer == npc) then
			local burying = state.stage == "carrying"
			local map = burying and (state.destinationMap or state.map) or state.map
			local point = ix.jobs.field.Unpack(burying and state.destination or state.point)
			local nearby = client:GetPos():DistToSqr(point) <= ix.jobs.field.useDistance ^ 2
			if map == game.GetMap() and nearby then
				return ix.jobs.field.StartDig(client, character, npc, job, tool, burying)
			end
		end
	end
	if issuer then client:Notify("Move closer to the assigned cache before digging.") end

	return false
end

function ix.jobs.field.StartDig(client, character, npc, job, tool, burying)
	if not ix.jobs.field.ActiveJob(client, npc, job.rewardKey) then return true end
	if not tool then
		for _, item in pairs(character:GetInventory():GetItems()) do
			if ownsTool(character, item) then tool = item break end
		end
	end
	if not tool or not ownsTool(character, tool) then
		client:Notify("You need a usable stash digging tool to dig up or bury the parcel.")
		return true
	end
	if client:GetNetVar("ix_noMenuAllowed") then return true end
	local claim, stage = job.rewardKey, job.fieldTask.stage
	ix.util.PlayerPerformItemAction(client, tool, burying and "Burying the parcel..." or "Digging up the parcel...",
		DIG_SECONDS, function()
			local current, active = ix.jobs.field.ActiveJob(client, npc, claim)
			if current ~= character or active.fieldTask.stage ~= stage or not ownsTool(character, tool) then return end
			if burying then
				ix.jobs.field.BuryDrop(client, character, npc, active)
			else
				local entity = ix.jobs.field.GetObject(character, active)
				if not IsValid(entity) then entity = ix.jobs.field.SpawnObject(character, npc, active) end
				ix.jobs.field.Collect(client, entity, true)
			end
		end)

	return true
end
