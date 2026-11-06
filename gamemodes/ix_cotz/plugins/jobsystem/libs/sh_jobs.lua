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
	return (text:gsub("rp_[%w_]+", ix.jobs.GetMapName))
end

function ix.jobs.NotifyCompleted(client, npc, job)
	if not SERVER or not job.isCompleted or job.completionNotified or not IsValid(client) then return end
	job.completionNotified = true
	client:Notify("Task completed: " .. ix.jobs.getFormattedName(job) .. " Return to " .. npc .. ".")
	netstream.Start(client, "ix_COTZPlayPDASound", 2)
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
		text = text .. "\nCurrent issuer: " .. contact.name .. " in " .. contact.map .. "."
		if activejob.fieldTask.recipient then
			text = text .. "\nCurrent delivery region: " .. ix.jobs.field.GetRecipientMap(activejob.fieldTask) .. "."
		end
	end
	if definition.alternateDelivery then
		text = text .. "\nEligible hand-in contacts: "
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
