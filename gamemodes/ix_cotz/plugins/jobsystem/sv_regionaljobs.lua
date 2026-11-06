local PLUGIN = PLUGIN
local pending = {}
local CAMERA_ITEM = "job_camera"

local function cameraFor(character)
	for _, item in pairs(character:GetInventory():GetItems()) do
		if item.uniqueID == CAMERA_ITEM and item:GetData("fieldOwner") == character:GetID() then return item end
	end
end

local function hasPhotography(character, ignoredClaim)
	for _, job in pairs(character:GetJobs()) do
		if job.photoKind and job.rewardKey ~= ignoredClaim then return true end
	end

	return false
end

local function canInsert(character, itemID)
	local item = ix.item.list[itemID]
	local x = character:GetInventory():FindEmptySlot(item.width, item.height, true)

	return x ~= nil and character:CanCarry(item)
end

local function insertBound(client, character, itemID, key, data, valid, done)
	if pending[key] then return end
	if not canInsert(character, itemID) then
		client:Notify("Make room in your main inventory and check your carrying weight, then try again.")
		return
	end
	local request = {client = client}
	pending[key] = request
	timer.Simple(30, function() if pending[key] == request then pending[key] = nil end end)
	ix.item.Instance(0, itemID, data, 0, 0, function(item)
		if pending[key] ~= request then item:Remove() return end
		pending[key] = nil
		if not IsValid(client) or client:GetCharacter() ~= character or not client:Alive() or not valid() then
			item:Remove()
			return
		end
		if not character:CanCarry(item) then item:Remove() return end
		local success, reason = item:Transfer(character:GetInventory():GetID(), nil, nil, client)
		if not success then
			item:Remove()
			client:NotifyLocalized(reason or "unknownError")
			return
		end
		done(item)
	end, character:GetID(), client:SteamID64())
end

function ix.jobs.regional.CanStart(character, definition)
	if definition.photoKind then return cameraFor(character) ~= nil or canInsert(character, CAMERA_ITEM) end
	if definition.fieldType == "courier" then
		for _, itemID in ipairs({"town_quest_drive", "town_quest_contract", "town_quest_lab"}) do
			if not canInsert(character, itemID) then return false end
		end
	end

	return true
end

function ix.jobs.regional.ReconcileCamera(client, ignoredClaim)
	local character = client:GetCharacter()
	if not character then return end
	local item = cameraFor(character)
	if not hasPhotography(character, ignoredClaim) then
		if item then item:Remove() end
		return
	end
	if item then
		if client:Alive() and not client:HasWeapon("ix_camera") then item:Equip(client, true, true) end
		return
	end
	local key = character:GetID() .. ":camera"
	insertBound(client, character, CAMERA_ITEM, key, {fieldOwner = character:GetID(), fieldClaim = "camera"},
		function() return hasPhotography(character) and not cameraFor(character) end,
		function(camera) camera:Equip(client, true, true) character:Save() end)
end

function ix.jobs.regional.AssignCourier(character, npc, job)
	local definition = ix.jobs.list[job.identifier]
	local recipients = {}
	for slug, contact in pairs(ix.townNPCs.contacts) do
		local allowed = definition.tier == 1 and contact.map == "rp_marsh_cs" and slug ~= "intern"
			or definition.tier == 2 and contact.map == "rp_waystation"
			or definition.tier == 3 and (slug == "intern" or contact.map == "rp_waystation")
		if allowed then recipients[#recipients + 1] = contact.name end
	end
	if #recipients == 0 then return false end
	table.sort(recipients)
	local recipient = recipients[math.random(#recipients)]
	local cargoChoices = {"town_quest_drive", "town_quest_contract", "town_quest_lab"}
	local cargo = cargoChoices[math.random(#cargoChoices)]
	job.fieldTask = {kind = "courier", stage = "issue", map = ix.townNPCs.byName[npc].map,
		cargo = cargo, cargoName = "Information parcel for " .. recipient,
		cargoDescription = "Information entrusted to " .. character:GetName() .. " for delivery to " .. recipient .. ".",
		recipient = recipient, recipientMap = ix.townNPCs.byName[recipient].map,
		description = "Collect the information parcel from " .. npc .. ", deliver it to " .. recipient .. " in " .. ix.townNPCs.byName[recipient].map .. ", then return to " .. npc .. ". Use Field work near the issuer to collect a replacement if it is lost."}

	return true
end

function ix.jobs.regional.IssueCourier(client, npc, job)
	local character = client:GetCharacter()
	local issuer = ix.progression.GetNPCFromName(npc)
	if not character or not ix.townNPCs:CanInteract(client, issuer) then return end
	local active = character:GetJobs()[npc]
	if not active or active.rewardKey ~= job.rewardKey or active.fieldTask.stage ~= "issue" then return end
	if ix.jobs.field.FindCargo(character, active) then return end
	local state = active.fieldTask
	local key = character:GetID() .. ":courier:" .. job.rewardKey
	insertBound(client, character, state.cargo, key, ix.jobs.regional.CargoData(character, active, state),
		function()
			local current = character:GetJobs()[npc]
			return current and current.rewardKey == job.rewardKey and current.fieldTask.stage == "issue"
				and ix.townNPCs:CanInteract(client, issuer) and not ix.jobs.field.FindCargo(character, current)
		end,
		function()
			local current = character:GetJobs()[npc]
			current.fieldTask.stage = "carrying"
			ix.jobs.field.SaveJob(character, npc, current)
			client:Notify("Parcel collected. Deliver it to " .. state.recipient .. ", then return to " .. npc .. ".")
		end)
end

function ix.jobs.regional.RecordKill(client, class, map)
	local character = client:GetCharacter()
	local species = ix.jobs.regional.Species(class)
	if not character or not species then return end
	local jobs, changed = character:GetJobs(), false
	for _, job in pairs(jobs) do
		if not job.isCompleted and job.targetMap == map then
			local credit = job.targetWeights and job.targetWeights[species]
			if job.targetSpecies == species then credit = 1 end
			if credit then
				job.progress = math.min(job.numberRec, (job.progress or 0) + credit)
				job.isCompleted = job.progress + 0.000000001 >= job.numberRec
				if job.isCompleted then job.progress = job.numberRec end
				changed = true
			end
		end
	end
	if changed then character:SetJobs(jobs) character:Save() end
end

PLUGIN["cotz/camera/photo-taken"] = function(self, photo)
	local client = photo.client
	local character = IsValid(client) and client:GetCharacter()
	if not character or character:GetID() ~= photo.characterID or photo.map ~= game.GetMap() then return end
	local supported = false
	for _, region in ipairs(ix.jobs.regionalCatalogue.maps) do if region == photo.map then supported = true end end
	if not supported or not IsValid(photo.weapon) then return end
	local camera = cameraFor(character)
	if not camera or photo.weapon.ixItem ~= camera then return end
	local jobs, changed = character:GetJobs(), false
	local anomalies = ix.plugin.Get("anomalycontroller")
	local anomalyClasses = {}
	for _, definition in ipairs(anomalies and anomalies.anomalydefs or {}) do
		anomalyClasses[definition.entityname] = true
	end
	for _, job in pairs(jobs) do
		if job.photoKind and not job.isCompleted then
			job.photoTypes = job.photoTypes or {}
			for _, subject in ipairs(photo.subjects) do
				local entity = subject.entity
				local key
				if subject.kind == "entity" and IsValid(entity) then
					if job.photoKind == "mutant" and subject.class:sub(1, 11) == "npc_mutant_"
						and entity:Health() > 0 then key = ix.jobs.regional.Species(subject.class) end
					if job.photoKind == "anomaly" and anomalyClasses[subject.class] then key = subject.class end
				end
				if key and not job.photoTypes[key] and (job.progress or 0) < job.numberRec then
					job.photoTypes[key] = true
					job.progress = (job.progress or 0) + 1
					job.isCompleted = job.progress >= job.numberRec
					changed = true
				end
			end
		end
	end
	if changed then character:SetJobs(jobs) character:Save() end
end

function PLUGIN:PlayerLoadedCharacter(client)
	timer.Simple(0, function() if IsValid(client) then ix.jobs.regional.ReconcileCamera(client) end end)
end

function PLUGIN:PlayerLoadout(client)
	timer.Simple(0, function() if IsValid(client) then ix.jobs.regional.ReconcileCamera(client) end end)
end

function PLUGIN:PlayerDisconnected(client)
	for key, request in pairs(pending) do if request.client == client then pending[key] = nil end end
end
