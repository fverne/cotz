local PLUGIN = PLUGIN
local entities, pending = {}, {}
local nextUpdate = 0
ix.jobs.field.enabled = true

util.AddNetworkString("cotz/jobsystem/field-action")
util.AddNetworkString("cotz/jobsystem/field-marker")

local function keyFor(character, job)
	return character:GetID() .. ":" .. job.rewardKey
end

function ix.jobs.field.SaveJob(character, npc, job)
	if not job.isCompleted then job.completionNotified = nil end
	ix.jobs.NotifyCompleted(character:GetPlayer(), npc, job)
	local jobs = character:GetJobs()
	jobs[npc] = job
	character:SetJobs(jobs)
	character:Save()
end

function ix.jobs.field.Cleanup(character, job)
	local key = keyFor(character, job)
	if IsValid(entities[key]) then entities[key]:Remove() end
	entities[key] = nil
	pending[key] = nil
	if job.fieldTask.kind == "defence" then ix.jobs.field.StopDefence(character, job) end
	-- In-flight item callbacks validate the active claim before transferring their result.
	local cargo = ix.jobs.field.FindCargo(character, job)
	while cargo do
		cargo:Remove()
		cargo = ix.jobs.field.FindCargo(character, job)
	end
end

function ix.jobs.field.Collect(client, entity)
	if not IsValid(entity) then return end
	local npc, claim = entity.fieldNPC, entity.fieldClaim
	local character, job = ix.jobs.field.ActiveJob(client, npc, claim)
	if not character or character:GetID() ~= entity.fieldOwner then return end
	local state = job.fieldTask
	if state.map ~= game.GetMap()
		or client:GetPos():DistToSqr(entity:GetPos()) > ix.jobs.field.useDistance ^ 2 then return end
	if CurTime() < (client.cotzFieldNext or 0) then return end
	client.cotzFieldNext = CurTime() + ix.jobs.field.actionInterval
	if state.stage == "carrying" or state.stage == "delivered" or ix.jobs.field.FindCargo(character, job) then
		return
	end
	if state.kind == "deadDrop" and not ix.jobs.field.RequireDiggingTool(client, character) then return end
	if state.kind == "defence" and state.stage ~= "ready" then
		client:Notify("Finish the research operation before collecting the recorder.")
		return
	end
	if state.kind == "sensor" and (state.stage ~= "recording" or not state.departed
		or os.time() < state.readyAt) then
		client:Notify("Leave the site while the sensor records, then return when it is ready.")
		return
	end
	if state.kind == "triangulation" and #state.readings < state.readingCount then return end
	local key = keyFor(character, job)
	if pending[key] then return end
	local inventory = character:GetInventory()
	local template = ix.item.list[state.cargo]
	if not character:CanCarry(template) then
		client:Notify("You are carrying too much weight to recover this equipment.")
		return
	end
	local x, y = inventory:FindEmptySlot(template.width, template.height, true)
	if not x then
		client:Notify("Make room in your main inventory, then collect it again.")
		return
	end
	local request = {expires = CurTime() + ix.jobs.field.runtimeSettings.pickupTimeout, client = client}
	pending[key] = request
	-- Instance first, then transfer the existing item synchronously. Inventory:Add(string)
	-- returns reserved coordinates before its database callback has created the item.
	local recipient = state.recipient or (state.kind == "deadDrop" and "the assigned cache") or npc
	local data = {fieldOwner = character:GetID(), fieldClaim = job.rewardKey,
		fieldName = state.cargoName, fieldDescription = state.cargoDescription, fieldRecipient = recipient}
	ix.item.Instance(0, state.cargo, data,
		0, 0, function(item)
			if pending[key] ~= request then item:Remove() return end
			pending[key] = nil
			local current, active = ix.jobs.field.ActiveJob(client, npc, claim)
			if current ~= character or not IsValid(entity) or active.fieldTask.map ~= game.GetMap()
				or active.fieldTask.stage == "carrying" or ix.jobs.field.FindCargo(character, active)
				or client:GetPos():DistToSqr(entity:GetPos()) > ix.jobs.field.useDistance ^ 2 then
				item:Remove()
				return
			end
			if active.fieldTask.kind == "deadDrop" and not ix.jobs.field.RequireDiggingTool(client, character) then
				item:Remove()
				return
			end
			if not character:CanCarry(item) then
				item:Remove()
				client:Notify("You are carrying too much weight to recover this equipment.")
				return
			end
			local transferred, reason = item:Transfer(inventory:GetID(), nil, nil, client)
			if not transferred then
				item:Remove()
				client:NotifyLocalized(reason or "unknownError")
				return
			end
			active.fieldTask.stage = "carrying"
			active.isCompleted = not ix.jobs.field.NeedsDelivery(active.fieldTask)
			active.progress = active.isCompleted and active.numberRec or 0
			ix.jobs.field.SaveJob(character, npc, active)
			entity:Remove()
			entities[key] = nil
			if active.fieldTask.recipient then
				client:Notify("Cargo recovered. Deliver it to " .. active.fieldTask.recipient
					.. ", then return to " .. npc .. ".")
			elseif active.fieldTask.kind == "deadDrop" then
				client:Notify("Parcel collected. Use Field work to locate the destination and deliver it.")
			else
				client:Notify("Cargo recovered. Return it to " .. npc .. " for payment.")
			end
		end, character:GetID(), client:SteamID64())
end

function ix.jobs.field.SpawnObject(character, npc, job)
	local client = character:GetPlayer()
	local model = ix.jobs.field.GetObjectModel(job.fieldTask)
	local point = ix.jobs.field.GroundPoint(
		ix.jobs.field.Unpack(job.fieldTask.point), job.fieldTask.cargo, client, model
	)
	if not point then
		if IsValid(client) and CurTime() >= (client.cotzFieldBlockedNext or 0) then
			client.cotzFieldBlockedNext = CurTime() + ix.jobs.field.runtimeSettings.blockedNotifyInterval
			client:Notify("The equipment site is obstructed. Clear movable objects nearby and try again.")
		end
		return
	end
	local entity = ents.Create("ix_job_field_object")
	if not IsValid(entity) then return end
	entity.fieldOwner, entity.fieldNPC, entity.fieldClaim = character:GetID(), npc, job.rewardKey
	entity:SetModel(model)
	entity:SetNWString("cotz/jobsystem/cargo-name", job.fieldTask.cargoName or ix.item.list[job.fieldTask.cargo].name)
	entity:SetPos(point)
	entity:Spawn()
	if job.fieldTask.kind == "defence" then entity:SetHealth(job.fieldTask.defence.health) end
	entities[keyFor(character, job)] = entity

	return entity
end

function ix.jobs.field.GetObject(character, job)
	return entities[keyFor(character, job)]
end

function PLUGIN:Think()
	if not ix.jobs.field.enabled or CurTime() < nextUpdate then return end
	nextUpdate = CurTime() + ix.jobs.field.updateInterval
	local keep = {}
	for _, client in player.Iterator() do
		local character = client:Alive() and client:GetCharacter()
		if character then
			ix.jobs.field.UpdateCharacter(client, character, keep)
		end
	end
	for key, entity in pairs(entities) do
		if not keep[key] then
			if IsValid(entity) then entity:Remove() end
			entities[key] = nil
		end
	end
	for key, request in pairs(pending) do
		if not keep[key] or CurTime() >= request.expires then
			pending[key] = nil
			if keep[key] and IsValid(request.client) then
				request.client:Notify("Equipment pickup timed out. Try collecting it again.")
			end
		end
	end
	ix.jobs.field.PruneDefences(keep)
end

function PLUGIN:OnUnload()
	ix.jobs.field.enabled = false
	for key, entity in pairs(entities) do
		if IsValid(entity) then entity:Remove() end
		entities[key] = nil
	end
	for key in pairs(pending) do pending[key] = nil end
	ix.jobs.field.PruneDefences({})
end

function ix.jobs.field.UpdateCharacter(client, character, keep)
	for npc, job in pairs(character:GetJobs()) do
		if job.fieldTask then ix.jobs.field.UpdateJob(client, character, npc, job, keep) end
	end
end

function ix.jobs.field.UpdateJob(client, character, npc, job, keep)
	local state = job.fieldTask
	if state.stage == "delivered" then return end
	local key = keyFor(character, job)
	local position = client:GetPos()
	if ix.jobs.field.FindCargo(character, job) then
		local complete = not ix.jobs.field.NeedsDelivery(state)
		if state.stage ~= "carrying" or job.isCompleted ~= complete then
			state.stage, job.progress, job.isCompleted = "carrying", complete and job.numberRec or 0, complete
			ix.jobs.field.SaveJob(character, npc, job)
		end
		return
	end
	-- Lost cargo can be recovered again at the same saved site; it never rerolls.
	if state.stage == "carrying" then
		state.stage = state.kind == "sensor" and "recording" or "search"
		if state.kind == "defence" then state.stage = "ready" end
		job.progress, job.isCompleted = 0, false
		ix.jobs.field.SaveJob(character, npc, job)
	end
	if state.kind == "courier" then
		if state.stage ~= "issue" then
			state.stage = "issue"
			ix.jobs.field.SaveJob(character, npc, job)
		end
		return
	end
	if state.map ~= game.GetMap() then
		if state.kind == "sensor" and state.stage == "recording" and not state.departed then
			state.departed = true
			ix.jobs.field.SaveJob(character, npc, job)
		end
		return
	end
	if state.kind == "defence" and state.stage == "defending" then
		ix.jobs.field.UpdateDefence(client, character, npc, job, keep)
		return
	end
	if state.kind == "sensor" and state.stage == "recording" and not state.departed
		and position:DistToSqr(ix.jobs.field.Unpack(state.point)) >= state.leaveDistance ^ 2 then
		state.departed = true
		ix.jobs.field.SaveJob(character, npc, job)
	end
	if IsValid(entities[key]) then
		if position:DistToSqr(ix.jobs.field.Unpack(state.point)) <= ix.jobs.field.despawnDistance ^ 2 then
			keep[key] = true
		end
	elseif ix.jobs.field.ShouldSpawn(state, position) then
		keep[key] = ix.jobs.field.SpawnObject(character, npc, job) ~= nil
	end
end
