ix.jobs = ix.jobs or {}
ix.jobs.list = ix.jobs.list or {}
ix.jobs.jobsbycategory = ix.jobs.jobsbycategory or {}
ix.jobs.activejobs = ix.jobs.activejobs or {}

function ix.jobs.isStructValid(definition)
	if type(definition) ~= "table" or type(definition.name) ~= "string" then return false end
	local count = definition.numberRec
	if type(count) == "table" then
		if type(count[1]) ~= "number" or type(count[2]) ~= "number" then return false end
		return count[1] > 0 and count[2] >= count[1]
	end

	return type(count) == "number" and count > 0
end

function ix.jobs.register(definition, identifier)
	assert(type(identifier) == "string" and ix.jobs.isStructValid(definition),
		"Invalid job definition: " .. tostring(identifier))
	-- Re-registering an ID must not leave stale or duplicate category entries.
	if ix.jobs.list[identifier] then
		for _, category in pairs(ix.jobs.jobsbycategory) do
			for index = #category, 1, -1 do
				if category[index] == identifier then table.remove(category, index) end
			end
		end
	end
	ix.jobs.list[identifier] = definition
	local categories = definition.categories
	if not categories or #categories == 0 then categories = {"miscjobs"} end
	for _, category in ipairs(categories) do
		ix.jobs.jobsbycategory[category] = ix.jobs.jobsbycategory[category] or {}
		table.insert(ix.jobs.jobsbycategory[category], identifier)
	end
end

function ix.jobs.GetMapName(map)
	local travel = ix.plugin.Get("simplecrossserver")
	local region = travel and travel.mapdata and travel.mapdata[map]

	return region and region.name or ix.jobs.settings.mapNames[map] or "Unknown region"
end

function ix.jobs.FormatMapNames(text)
	text = text:gsub("(rp_[%w_]+)%.bsp", ix.jobs.GetMapName)

	return (text:gsub("rp_[%w_]+", ix.jobs.GetMapName))
end

function ix.jobs.NotifyCompleted(client, npc, job)
	if not SERVER or not job.isCompleted or job.completionNotified or not IsValid(client) then return end
	job.completionNotified = true
	client:Notify("Task completed: " .. ix.jobs.getFormattedName(job) .. " Return to " .. npc .. ".")
	netstream.Start(client, "ix_COTZPlayPDASound", 2)
	local character, claim = client:GetCharacter(), job.rewardKey
	timer.Simple(0, function()
		if not IsValid(client) or client:GetCharacter() ~= character then return end
		local current = character:GetJobs()[npc]
		if current and current.rewardKey == claim then ix.taskRewards.RevealJobOffer(client, npc) end
	end)
end

local function initialCount(identifier)
	local count = ix.jobs.list[identifier].numberRec

	return type(count) == "table" and count[1] or count
end

function ix.jobs.getFormattedName(job)
	return ix.jobs.FormatMapNames(string.format(ix.jobs.list[job.identifier].name, job.numberRec))
end

function ix.jobs.getFormattedDesc(activejob, hideRewards)
	local description = activejob.fieldTask and ix.jobs.field.DescribeAssignment(activejob)
		or ix.jobs.list[activejob.identifier].desc
	local text = description
	if not activejob.fieldTask or activejob.fieldTask.kind ~= "recovery" then
		text = string.format(description, activejob.numberRec)
	end
	local definition = ix.jobs.list[activejob.identifier]
	local contact = ix.townNPCs and ix.townNPCs.contacts and ix.townNPCs.contacts[definition.townContact]
	local assignmentMap = activejob.fieldTask and activejob.fieldTask.map or definition.fieldMap
	if assignmentMap then text = text .. "\nAssignment region: " .. ix.jobs.GetMapName(assignmentMap) .. "." end
	if activejob.fieldTask and contact then
		text = text .. "\nReturn to " .. contact.name .. " in " .. contact.map .. "."
		if activejob.fieldTask.recipient then
			text = text .. "\nDeliver to " .. ix.jobs.field.GetRecipientMap(activejob.fieldTask) .. "."
		end
	end
	if definition.alternateDelivery then
		text = text .. "\nDeliver to "
			.. table.concat(ix.jobs.regional.EligibleReceivers(definition), ", ") .. "."
	end
	if activejob.photoKind then text = text .. "\n" .. ix.jobs.regional.PhotoSummary(activejob) end
	local fieldType = activejob.fieldTask and activejob.fieldTask.kind or definition.fieldType
	if fieldType == "deadDrop" then
		text = text .. "\nA usable stash digging tool is required for pickup and burial."
	end
	if activejob.moneyReward and not hideRewards then
		text = text .. "\n\nPayment: " .. activejob.moneyReward .. " rubles."
		if definition.requiredItem then text = text .. " Better-quality hand-ins can increase this payment." end
		text = text .. "\nChoose your reward when handing in the completed assignment."
	end

	return ix.jobs.FormatMapNames(text)
end

local function spokenJobDetails(job, contact)
	local definition = ix.jobs.list[job.identifier]
	local state = job.fieldTask
	local count = job.numberRec - (job.progress or 0)
	local map = state and state.map or definition.targetMap or definition.fieldMap
		or (contact.job.maps or {})[({"easy", "medium", "hard"})[definition.tier or 1]] or contact.map
	local region = ix.jobs.GetMapName(map)
	if definition.requiredItem then
		local item = ix.item.list[definition.requiredItem]
		local label = item and item.name or "the requested material"
		if definition.requiredPool then label = ix.progression.itemPools[definition.requiredPool].name end
		local items = (count == 1 and "" or count .. " ") .. label
		if definition.alternateDelivery then
			local receivers = ix.jobs.regional.EligibleReceivers(definition)
			return "Take " .. items .. " to " .. table.concat(receivers, " or ") .. " in " .. region
				.. ". Come back here once you've handed it over."
		end

		return "Bring me " .. items .. "."
	end
	if job.photoKind or definition.photoKind then
		return "Bring me photographs of " .. job.numberRec .. " different " .. (job.photoKind or definition.photoKind)
			.. " types. I need the real thing in view; another picture of the same kind won't help."
	end
	if definition.targetSpecies or definition.targetWeights then
		local target = definition.targetSpecies or definition.name:match("of (.-)%.?$") or "those mutants"
		local amount = definition.targetWeights and job.numberRec .. " packs' worth" or job.numberRec

		return "Deal with " .. amount .. " of the " .. target .. " in " .. region .. ", then come back here."
	end
	local kind = state and state.kind or definition.fieldType
	if kind == "courier" then
		if state and state.recipient then
			return "Take the parcel to " .. state.recipient .. " in "
				.. ix.jobs.GetMapName(ix.jobs.field.GetRecipientMap(state)) .. ", then come back here."
		end

		return "I'll give you a sealed parcel and the recipient's name. Hand it to them yourself, then come back here."
	elseif kind == "deadDrop" then
		if state and state.stage == "carrying" then
			return "Bury the parcel at the place I marked in "
				.. ix.jobs.GetMapName(state.destinationMap or state.map) .. ". Bring a digging tool, then come back here."
		end

		return "Dig up the parcel at the place I marked in " .. region
			.. ", then bury it at the other cache. You'll need a digging tool for both ends. Come back when it's done."
	elseif kind == "sensor" then
		return "Set the recorder down at the place I marked in " .. region
			.. ". Leave it alone while it records, then go back and collect it. Bring it here afterwards."
	elseif kind == "triangulation" then
		return "Follow the signal in " .. region .. ". Take readings from "
			.. (state and state.readingCount or definition.fieldSettings and definition.fieldSettings.readingCount or 3)
			.. " separated positions, then find the transmitter and bring it here."
	elseif kind == "defence" then
		return "Start the sampler at the marked site in " .. region
			.. " and stay close enough to protect it while it records. Bring the recorder back when it's finished."
	elseif kind == "recovery" then
		return "Look for " .. (state and state.cargoName or "the equipment") .. " in " .. region
			.. ". I've left the directions in your PDA. Bring it back here when you find it."
	end

	return contact.dialogue.work
end

function ix.jobs.GetDialogueDescription(job, npc, preview)
	local definition = ix.jobs.list[job.identifier]
	local contact = ix.townNPCs and ix.townNPCs.byName[npc]
	if not contact then return ix.jobs.getFormattedDesc(job, true) end
	if definition.townProgression then
		local progression = ix.progression.definitions[definition.townProgression]
		if progression then
			return job.isCompleted and progression.completionMessage or progression.briefing
		end
	end
	if job.isCompleted then return contact.dialogue.jobFinished end
	local template = preview and contact.dialogue.jobBriefing or contact.dialogue.jobReminder
	local details = spokenJobDetails(job, contact)

	return (template:gsub("{details}", function() return details end))
end

function ix.jobs.getFormattedNameInactive(identifier)
	return string.format(ix.jobs.list[identifier].name, initialCount(identifier))
end

function ix.jobs.getFormattedDescInactive(identifier)
	return ix.jobs.getFormattedDesc({identifier = identifier, numberRec = initialCount(identifier)})
end

function ix.jobs.isItemJob(identifier)
	local definition = ix.jobs.list[identifier]

	return definition and definition.requiredItem or false
end

function ix.jobs.getJobFromTier(tier)
	local available = {}
	for identifier, definition in pairs(ix.jobs.list) do
		if definition.tier == tier and not definition.completionOnly then available[#available + 1] = identifier end
	end
	if #available > 0 then return available[math.random(#available)] end
end

function ix.jobs.getJobFromCategory(categories, character)
	if not istable(categories) then categories = {categories} end
	local pools = {}
	for _, category in ipairs(categories) do
		local available = {}
		for _, id in ipairs(ix.jobs.jobsbycategory[category] or {}) do
			local definition = ix.jobs.list[id]
			local allowed = definition and not definition.completionOnly
			if allowed and character and ix.jobs.regional then
				allowed = ix.jobs.regional.CanOffer(character, definition)
			end
			if allowed and (not definition.fieldType or ix.jobs.field.IsAvailable(definition)) then
				available[#available + 1] = id
			end
		end
		if #available > 0 then pools[#pools + 1] = available end
	end
	if #pools == 0 then return end
	local pool = pools[math.random(#pools)]

	return pool[math.random(#pool)]
end

local playerMeta = FindMetaTable("Player")

function playerMeta:ixHasJobFromNPC(npc)
	local character = self:GetCharacter()

	return character ~= nil and character:GetJobs()[npc] ~= nil
end
