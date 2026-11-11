local DEPLOY_FORWARD_DISTANCE = ix.jobs.field.runtimeSettings.deployForwardDistance

function ix.jobs.field.ActiveJob(client, npc, claim)
	if not ix.jobs.field.enabled then return end
	if not IsValid(client) or not client:Alive() then return end
	if client:IsRestricted() or IsValid(client.ixRagdoll) then return end
	local character = client:GetCharacter()
	local job = character and character:GetJobs()[npc]
	if not job or not job.fieldTask or (claim and job.rewardKey ~= claim) then return end

	return character, job
end

local function marker(client, position, label, radius)
	net.Start("cotz/jobsystem/field-marker")
	net.WriteVector(position)
	net.WriteString(label)
	net.WriteUInt(radius or 0, 16)
	net.Send(client)
end

function ix.jobs.field.Status(client, npc, job)
	local state = job.fieldTask
	if state.kind == "courier" and state.stage == "issue" then
		client:Notify("Collect the parcel from " .. npc .. " using Collect parcel from issuer in your task list.")
		return
	end
	if state.stage == "delivered" then
		client:Notify("Parcel delivered. Return to " .. npc .. " for payment.")
		return
	end
	if state.stage == "carrying" and state.recipient then
		local recipientMap = ix.jobs.field.GetRecipientMap(state)
		client:Notify("Deliver the cargo to " .. state.recipient .. " in " .. ix.jobs.GetMapName(recipientMap)
			.. ", then return to " .. npc .. ".")
		if recipientMap == game.GetMap() then
			local recipient = ix.progression.GetNPCFromName(state.recipient)
			if IsValid(recipient) then marker(client, recipient:GetPos(), "Deliver to " .. state.recipient) end
		end
		return
	end
	if state.stage == "carrying" and state.kind ~= "deadDrop" then
		client:Notify("Return the recovered cargo to " .. npc .. ".")
		return
	end
	if state.kind == "recovery" then
		if ix.jobs.field.EnsureRecoveryClue(state) then
			ix.jobs.field.SaveJob(client:GetCharacter(), npc, job)
		end
		client:Notify(ix.jobs.field.DescribeAssignment(job) .. " Region: " .. ix.jobs.GetMapName(state.map) .. ".")
		if ix.jobs.field.GetRecoverySearchArea(state, client:GetPos()) then
			net.Start("cotz/jobsystem/recovery-marker")
			net.WriteString(npc)
			net.WriteString(job.rewardKey)
			net.Send(client)
		end
		return
	end
	local activeMap = state.kind == "deadDrop" and state.stage == "carrying"
		and (state.destinationMap or state.map) or state.map
	if activeMap ~= game.GetMap() then
		client:Notify("This assignment is in " .. ix.jobs.GetMapName(activeMap) .. ". Your progress is saved.")
		return
	end
	if state.kind == "triangulation" and #state.readings < state.readingCount then
		client:Notify("Take signal readings from " .. state.readingCount
			.. " separated positions. Readings saved: " .. #state.readings .. ".")
		return
	end
	local position = ix.jobs.field.Unpack(state.point)
	local label = "Search area"
	if state.kind == "deadDrop" then
		local carrying = state.stage == "carrying"
		position = ix.jobs.field.Unpack(carrying and state.destination or state.point)
		label = carrying and "Dead-drop destination" or "Parcel pickup"
	elseif state.kind == "defence" then
		label = "Research sampler site"
		local defence = state.defence
		client:Notify(string.format("Sampler: %d/%d health. Waves cleared: %d/%d. Recording: %d/%d seconds.",
			defence.health, defence.maxHealth, defence.completedWaves, #defence.waves,
			math.floor(defence.guardedSeconds), defence.duration))
	end
	if state.kind == "sensor" then
		label = state.stage == "deploy" and "Sensor deployment site" or "Deployed sensor"
		if state.stage == "recording" then
			client:Notify("Recording: " .. math.max(0, state.readyAt - os.time()) .. " seconds remaining. "
				.. (state.departed and "Site departure recorded." or "Leave the site before retrieving the sensor."))
		end
	end
	local radius = state.kind == "sensor" and state.stage == "deploy" and state.deployDistance or state.searchRadius
	marker(client, position, label, radius)
end

function ix.jobs.field.DeliverToContact(client, target, npc, claim)
	if type(npc) ~= "string" or type(claim) ~= "string" then return false end
	local character, job = ix.jobs.field.ActiveJob(client, npc, claim)
	if not character or not ix.townNPCs:CanInteract(client, target) then return false end
	local state = job.fieldTask
	if state.stage ~= "carrying" or state.recipient ~= target:GetDisplayName()
		or ix.jobs.field.GetRecipientMap(state) ~= game.GetMap() then return false end
	local cargo = ix.jobs.field.FindCargo(character, job)
	if not cargo or cargo:Remove() == false then return false end
	state.stage, job.progress, job.isCompleted = "delivered", job.numberRec, true
	ix.jobs.field.SaveJob(character, npc, job)
	client:Notify("Delivery accepted by " .. state.recipient .. ". Return to " .. npc .. ".")

	return true
end

function ix.jobs.field.BuryDrop(client, character, npc, job)
	local state = job.fieldTask
	if state.stage ~= "carrying" then return end
	if (state.destinationMap or state.map) ~= game.GetMap() then return end
	if client:GetPos():DistToSqr(ix.jobs.field.Unpack(state.destination)) > ix.jobs.field.useDistance ^ 2 then
		client:Notify("Move closer to the assigned dead-drop destination.")
		return
	end
	local cargo = ix.jobs.field.FindCargo(character, job)
	if not cargo then client:Notify("You need the assigned parcel to make this delivery.") return end
	if not ix.jobs.field.RequireDiggingTool(client, character) then return end
	if cargo:Remove() == false then return end
	state.stage, job.progress, job.isCompleted = "delivered", job.numberRec, true
	ix.jobs.field.SaveJob(character, npc, job)
	client:Notify("Parcel delivered. Return to " .. npc .. " for payment.")
end

function ix.jobs.field.Action(client, npc, action)
	local character, job = ix.jobs.field.ActiveJob(client, npc)
	if not character then return end
	if CurTime() < (client.cotzFieldNext or 0) then return end
	client.cotzFieldNext = CurTime() + ix.jobs.field.actionInterval
	local state = job.fieldTask
	if action == "status" then ix.jobs.field.Status(client, npc, job) return end
	if state.stage == "delivered" then return end
	if action == "issue" and state.kind == "courier" then
		ix.jobs.regional.IssueCourier(client, npc, job)
		return
	end
	if action == "deliver" and state.kind == "deadDrop" then
		ix.jobs.field.DigDeadDrop(client, nil, npc)
		return
	end
	if state.map ~= game.GetMap() then return end
	if action == "start" and state.kind == "defence" then
		ix.jobs.field.StartDefence(client, character, npc, job)
		return
	end
	if state.stage == "carrying" then return end
	local position = client:GetPos()
	if action == "deploy" and state.kind == "sensor" and state.stage == "deploy" then
		if position:DistToSqr(ix.jobs.field.Unpack(state.point)) > state.deployDistance ^ 2 then
			client:Notify("Move closer to the assigned deployment site.")
			return
		end
		local deployed = ix.jobs.field.GroundPoint(
			position + client:GetForward() * DEPLOY_FORWARD_DISTANCE, state.cargo, client,
			ix.jobs.field.GetObjectModel(state)
		)
		if not deployed then
			client:Notify("The deployment site is obstructed. Clear the obstruction and try again.")
			return
		end
		state.point = ix.jobs.field.Pack(deployed)
		state.stage, state.readyAt, state.departed = "recording", os.time() + state.recordSeconds, false
		ix.jobs.field.SaveJob(character, npc, job)
		ix.jobs.field.SpawnObject(character, npc, job)
		client:Notify("Sensor deployed. Leave the site while it records, then return to collect it.")
	elseif action == "read" and ix.jobs.field.CanRead(state, position, state) then
		local reading = ix.jobs.field.Pack(position)
		reading.bearing = ix.jobs.field.ReadingBearing(state, reading)
		state.readings[#state.readings + 1] = reading
		ix.jobs.field.SaveJob(character, npc, job)
		local delta = ix.jobs.field.Unpack(state.point) - position
		local bearing = reading.bearing
		client:Notify(string.format("Reading %d/%d: compass bearing %.0f degrees. Signal %s.",
			#state.readings, state.readingCount, bearing, delta:LengthSqr() <= ix.jobs.field.spawnDistance ^ 2
				and "strong" or "weak"))
		if #state.readings == state.readingCount then ix.jobs.field.Status(client, npc, job) end
	elseif action == "read" then
		client:Notify("Move farther from previous readings and approach from a different bearing, or check task status.")
	end
end

net.Receive("cotz/jobsystem/field-action", function(_, client)
	ix.jobs.field.Action(client, net.ReadString(), net.ReadString())
end)

