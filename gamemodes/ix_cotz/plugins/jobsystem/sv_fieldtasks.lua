local PLUGIN = PLUGIN
local field = ix.jobs.field
local entities, pending = {}, {}
local nextUpdate = 0
local GROUND_OFFSETS = {Vector(0, 0, 0), Vector(32, 0, 0), Vector(-32, 0, 0),
	Vector(0, 32, 0), Vector(0, -32, 0)}
local GROUND_UP, GROUND_DOWN = Vector(0, 0, 32), Vector(0, 0, 96)
local GROUND_CLEARANCE = Vector(0, 0, 2)
local DEPLOY_FORWARD_DISTANCE = 48
local BLOCKED_NOTIFY_INTERVAL = 30
local PICKUP_TIMEOUT = 30
local modelBounds = {}
field.enabled = true

util.AddNetworkString("cotz/jobsystem/field-action")
util.AddNetworkString("cotz/jobsystem/field-marker")

local function keyFor(character, job)
	return character:GetID() .. ":" .. job.rewardKey
end

function field.SaveJob(character, npc, job)
	local jobs = character:GetJobs()
	jobs[npc] = job
	character:SetJobs(jobs)
	character:Save()
end

local function groundPoint(position, cargo, filter)
	local model = ix.item.list[cargo].model
	if not modelBounds[model] then modelBounds[model] = {util.GetModelBounds(model)} end
	local bounds = modelBounds[model]
	for _, offset in ipairs(GROUND_OFFSETS) do
		local trace = util.TraceHull({start = position + offset + GROUND_UP,
			endpos = position + offset - GROUND_DOWN, mins = bounds[1], maxs = bounds[2],
			mask = MASK_SOLID, filter = filter})
		if trace.Hit and not trace.StartSolid and trace.HitNormal.z >= 0.5 then
			local point = trace.HitPos + GROUND_CLEARANCE
			if util.IsInWorld(point) then return point end
		end
	end
end

function field.Assign(character, npc, job)
	local definition = ix.jobs.list[job.identifier]
	local settings = field.settings[definition.fieldType]
	if not settings then return false end
	local map = definition.fieldMap or game.GetMap()
	local points = field.CollectPoints(settings.sources, map)
	if #points == 0 then return false end
	table.Shuffle(points)
	local function usable(candidate)
		return map ~= game.GetMap() or groundPoint(candidate, settings.cargo) ~= nil
	end
	local point, destination, approaches
	if definition.fieldType == "deadDrop" then
		point, destination = field.SelectRoute(settings, map, usable)
	elseif definition.fieldType == "defence" then
		point, approaches = field.SelectDefenceSite(settings, map, usable)
	else
		for _, candidate in ipairs(points) do
			if definition.fieldType == "sensor" or usable(candidate) then point = candidate break end
		end
	end
	if not point then return false end
	local searchRadius = settings.searchRadius or 0
	local search = point + Vector(math.Rand(-searchRadius / 2, searchRadius / 2),
		math.Rand(-searchRadius / 2, searchRadius / 2), 0)
	job.fieldTask = {
		kind = definition.fieldType, map = map, point = field.Pack(point), search = field.Pack(search),
		stage = (definition.fieldType == "sensor" or definition.fieldType == "defence") and "deploy" or "search",
		readings = {}, destination = destination and field.Pack(destination),
		readingCount = settings.readingCount, readingDistance = settings.readingDistance,
		bearingAngle = settings.bearingAngle,
		recordSeconds = settings.recordSeconds, leaveDistance = settings.leaveDistance,
		deployDistance = settings.deployDistance,
		cargo = settings.cargo, searchRadius = searchRadius,
	}
	if definition.fieldType == "defence" then
		field.AssignDefence(job.fieldTask, settings, definition.tier, approaches)
	end

	return true
end

function field.Cleanup(character, job)
	local key = keyFor(character, job)
	if IsValid(entities[key]) then entities[key]:Remove() end
	entities[key] = nil
	pending[key] = nil
	if job.fieldTask.kind == "defence" then field.StopDefence(character, job) end
	-- In-flight item callbacks validate the active claim before transferring their result.
	local cargo = field.FindCargo(character, job)
	while cargo do
		cargo:Remove()
		cargo = field.FindCargo(character, job)
	end
end

local function activeJob(client, npc, claim)
	if not field.enabled then return end
	if not IsValid(client) or not client:Alive() then return end
	if client:IsRestricted() or IsValid(client.ixRagdoll) then return end
	local character = client:GetCharacter()
	local job = character and character:GetJobs()[npc]
	if not job or not job.fieldTask or (claim and job.rewardKey ~= claim) then return end

	return character, job
end

function field.Collect(client, entity)
	if not IsValid(entity) then return end
	local npc, claim = entity.fieldNPC, entity.fieldClaim
	local character, job = activeJob(client, npc, claim)
	if not character or character:GetID() ~= entity.fieldOwner then return end
	local state = job.fieldTask
	if state.map ~= game.GetMap() or client:GetPos():DistToSqr(entity:GetPos()) > field.useDistance ^ 2 then return end
	if CurTime() < (client.cotzFieldNext or 0) then return end
	client.cotzFieldNext = CurTime() + field.actionInterval
	if state.stage == "carrying" or state.stage == "delivered" or field.FindCargo(character, job) then return end
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
	local request = {expires = CurTime() + PICKUP_TIMEOUT, client = client}
	pending[key] = request
	-- Instance first, then transfer the existing item synchronously. Inventory:Add(string)
	-- returns reserved coordinates before its database callback has created the item.
	ix.item.Instance(0, state.cargo, {fieldOwner = character:GetID(), fieldClaim = job.rewardKey},
		0, 0, function(item)
			if pending[key] ~= request then item:Remove() return end
			pending[key] = nil
			local current, active = activeJob(client, npc, claim)
			if current ~= character or not IsValid(entity) or active.fieldTask.map ~= game.GetMap()
				or active.fieldTask.stage == "carrying" or field.FindCargo(character, active)
				or client:GetPos():DistToSqr(entity:GetPos()) > field.useDistance ^ 2 then
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
			active.isCompleted = active.fieldTask.kind ~= "deadDrop"
			active.progress = active.isCompleted and active.numberRec or 0
			field.SaveJob(character, npc, active)
			entity:Remove()
			entities[key] = nil
			if active.fieldTask.kind == "deadDrop" then
				client:Notify("Parcel collected. Use Field work to locate the destination and deliver it.")
			else
				client:Notify("Cargo recovered. Return it to " .. npc .. " for payment.")
			end
		end, character:GetID(), client:SteamID64())
end

function field.SpawnObject(character, npc, job)
	local client = character:GetPlayer()
	local point = groundPoint(field.Unpack(job.fieldTask.point), job.fieldTask.cargo, client)
	if not point then
		if IsValid(client) and CurTime() >= (client.cotzFieldBlockedNext or 0) then
			client.cotzFieldBlockedNext = CurTime() + BLOCKED_NOTIFY_INTERVAL
			client:Notify("The equipment site is obstructed. Clear movable objects nearby and try again.")
		end
		return
	end
	local entity = ents.Create("ix_job_field_object")
	if not IsValid(entity) then return end
	entity.fieldOwner, entity.fieldNPC, entity.fieldClaim = character:GetID(), npc, job.rewardKey
	entity:SetModel(ix.item.list[job.fieldTask.cargo].model)
	entity:SetPos(point)
	entity:Spawn()
	if job.fieldTask.kind == "defence" then entity:SetHealth(job.fieldTask.defence.health) end
	entities[keyFor(character, job)] = entity

	return entity
end

function field.GetObject(character, job)
	return entities[keyFor(character, job)]
end

local function marker(client, position, label, radius)
	net.Start("cotz/jobsystem/field-marker")
	net.WriteVector(position)
	net.WriteString(label)
	net.WriteUInt(radius or 0, 16)
	net.Send(client)
end

function field.Status(client, npc, job)
	local state = job.fieldTask
	if state.stage == "delivered" then
		client:Notify("Parcel delivered. Return to " .. npc .. " for payment.")
		return
	end
	if state.stage == "carrying" and state.kind ~= "deadDrop" then
		client:Notify("Return the recovered cargo to " .. npc .. ".")
		return
	end
	if state.map ~= game.GetMap() then
		client:Notify("This assignment is in " .. state.map .. ". Your progress is saved.")
		return
	end
	if state.kind == "triangulation" and #state.readings < state.readingCount then
		client:Notify("Take signal readings from " .. state.readingCount
			.. " separated positions. Readings saved: " .. #state.readings .. ".")
		return
	end
	local position = field.Unpack(state.kind == "recovery" and state.search or state.point)
	local label = "Search area"
	if state.kind == "deadDrop" then
		local carrying = state.stage == "carrying"
		position = field.Unpack(carrying and state.destination or state.point)
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

local function deliverDrop(client, character, npc, job)
	local state = job.fieldTask
	if state.stage ~= "carrying" then return end
	if client:GetPos():DistToSqr(field.Unpack(state.destination)) > field.useDistance ^ 2 then
		client:Notify("Move closer to the assigned dead-drop destination.")
		return
	end
	local cargo = field.FindCargo(character, job)
	if not cargo then client:Notify("You need the assigned parcel to make this delivery.") return end
	if cargo:Remove() == false then return end
	state.stage, job.progress, job.isCompleted = "delivered", job.numberRec, true
	field.SaveJob(character, npc, job)
	client:Notify("Parcel delivered. Return to " .. npc .. " for payment.")
end

function field.Action(client, npc, action)
	local character, job = activeJob(client, npc)
	if not character then return end
	if CurTime() < (client.cotzFieldNext or 0) then return end
	client.cotzFieldNext = CurTime() + field.actionInterval
	local state = job.fieldTask
	if action == "status" then field.Status(client, npc, job) return end
	if state.map ~= game.GetMap() or state.stage == "delivered" then return end
	if action == "deliver" and state.kind == "deadDrop" then
		deliverDrop(client, character, npc, job)
		return
	end
	if action == "start" and state.kind == "defence" then
		field.StartDefence(client, character, npc, job)
		return
	end
	if state.stage == "carrying" then return end
	local position = client:GetPos()
	if action == "deploy" and state.kind == "sensor" and state.stage == "deploy" then
		if position:DistToSqr(field.Unpack(state.point)) > state.deployDistance ^ 2 then
			client:Notify("Move closer to the assigned deployment site.")
			return
		end
		local deployed = groundPoint(position + client:GetForward() * DEPLOY_FORWARD_DISTANCE, state.cargo, client)
		if not deployed then
			client:Notify("The deployment site is obstructed. Clear the obstruction and try again.")
			return
		end
		state.point = field.Pack(deployed)
		state.stage, state.readyAt, state.departed = "recording", os.time() + state.recordSeconds, false
		field.SaveJob(character, npc, job)
		field.SpawnObject(character, npc, job)
		client:Notify("Sensor deployed. Leave the site while it records, then return to collect it.")
	elseif action == "read" and field.CanRead(state, position, state) then
		state.readings[#state.readings + 1] = field.Pack(position)
		field.SaveJob(character, npc, job)
		local delta = field.Unpack(state.point) - position
		local bearing = (math.deg(math.atan2(-delta.y, delta.x)) + 360) % 360
		client:Notify(string.format("Reading %d/%d: compass bearing %.0f degrees. Signal %s.",
			#state.readings, state.readingCount, bearing, delta:LengthSqr() <= field.spawnDistance ^ 2
				and "strong" or "weak"))
		if #state.readings == state.readingCount then field.Status(client, npc, job) end
	elseif action == "read" then
		client:Notify("Move farther from previous readings and approach from a different bearing, or check task status.")
	end
end

net.Receive("cotz/jobsystem/field-action", function(_, client)
	field.Action(client, net.ReadString(), net.ReadString())
end)

function PLUGIN:Think()
	if not field.enabled or CurTime() < nextUpdate then return end
	nextUpdate = CurTime() + field.updateInterval
	local keep = {}
	for _, client in player.Iterator() do
		local character = client:Alive() and client:GetCharacter()
		if character then
			field.UpdateCharacter(client, character, keep)
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
	field.PruneDefences(keep)
end

function PLUGIN:OnUnload()
	field.enabled = false
	for key, entity in pairs(entities) do
		if IsValid(entity) then entity:Remove() end
		entities[key] = nil
	end
	for key in pairs(pending) do pending[key] = nil end
	field.PruneDefences({})
end

function field.UpdateCharacter(client, character, keep)
	for npc, job in pairs(character:GetJobs()) do
		if job.fieldTask then field.UpdateJob(client, character, npc, job, keep) end
	end
end

function field.UpdateJob(client, character, npc, job, keep)
	local state = job.fieldTask
	if state.map ~= game.GetMap() then return end
	if state.stage == "delivered" then return end
	local key = keyFor(character, job)
	local position = client:GetPos()
	if field.FindCargo(character, job) then
		local complete = state.kind ~= "deadDrop"
		if state.stage ~= "carrying" or job.isCompleted ~= complete then
			state.stage, job.progress, job.isCompleted = "carrying", complete and job.numberRec or 0, complete
			field.SaveJob(character, npc, job)
		end
		return
	end
	-- Lost cargo can be recovered again at the same saved site; it never rerolls.
	if state.stage == "carrying" then
		state.stage = state.kind == "sensor" and "recording" or "search"
		if state.kind == "defence" then state.stage = "ready" end
		job.progress, job.isCompleted = 0, false
		field.SaveJob(character, npc, job)
	end
	if state.kind == "defence" and state.stage == "defending" then
		field.UpdateDefence(client, character, npc, job, keep)
		return
	end
	if state.kind == "sensor" and state.stage == "recording" and not state.departed
		and position:DistToSqr(field.Unpack(state.point)) >= state.leaveDistance ^ 2 then
		state.departed = true
		field.SaveJob(character, npc, job)
	end
	if IsValid(entities[key]) then
		if position:DistToSqr(field.Unpack(state.point)) <= field.despawnDistance ^ 2 then keep[key] = true end
	elseif field.ShouldSpawn(state, position) then
		keep[key] = field.SpawnObject(character, npc, job) ~= nil
	end
end

function PLUGIN:CanTransferItem(item, oldInventory, inventory)
	if not item.isFieldCargo then return end
	local owner = item:GetData("fieldOwner")
	local character = owner and ix.char.loaded[owner]
	if not character or not inventory or inventory:GetID() ~= character:GetInventory():GetID() then return false end
end

function PLUGIN:CanPlayerTakeItem(client, item)
	if item.isFieldCargo and (not client:GetCharacter()
		or item:GetData("fieldOwner") ~= client:GetCharacter():GetID()) then return false end
end

function PLUGIN:CanPlayerDropItem(client, item)
	if item.isFieldCargo then return false end
end

function PLUGIN:PhysgunPickup(client, entity)
	if entity:GetClass() == "ix_job_field_object" then return false end
end

function PLUGIN:CanPlayerHoldObject(client, entity)
	if entity:GetClass() == "ix_job_field_object" then return false end
end

function PLUGIN:CanTool(client, trace, tool)
	if IsValid(trace.Entity) and trace.Entity:GetClass() == "ix_job_field_object" then return false end
end

function PLUGIN:CanProperty(client, property, entity)
	if entity:GetClass() == "ix_job_field_object" then return false end
end
