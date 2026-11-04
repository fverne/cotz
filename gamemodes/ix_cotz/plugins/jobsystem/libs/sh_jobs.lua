ix.jobs = ix.jobs or {}
ix.jobs.list = ix.jobs.list or {}
ix.jobs.jobsbycategory = ix.jobs.jobsbycategory or {}
ix.jobs.activejobs = ix.jobs.activejobs or {}

local jobs = ix.jobs

function jobs.isStructValid(definition)
	if type(definition) ~= "table" or type(definition.name) ~= "string" then return false end
	local count = definition.numberRec
	if type(count) == "table" then
		if type(count[1]) ~= "number" or type(count[2]) ~= "number" then return false end
		return count[1] > 0 and count[2] >= count[1]
	end

	return type(count) == "number" and count > 0
end

function jobs.register(definition, identifier)
	assert(type(identifier) == "string" and jobs.isStructValid(definition),
		"Invalid job definition: " .. tostring(identifier))
	-- Re-registering an ID must not leave stale or duplicate category entries.
	if jobs.list[identifier] then
		for _, category in pairs(jobs.jobsbycategory) do
			for index = #category, 1, -1 do
				if category[index] == identifier then table.remove(category, index) end
			end
		end
	end
	jobs.list[identifier] = definition
	local categories = definition.categories
	if not categories or #categories == 0 then categories = {"miscjobs"} end
	for _, category in ipairs(categories) do
		jobs.jobsbycategory[category] = jobs.jobsbycategory[category] or {}
		table.insert(jobs.jobsbycategory[category], identifier)
	end
end

local function initialCount(identifier)
	local count = jobs.list[identifier].numberRec

	return type(count) == "table" and count[1] or count
end

function jobs.getFormattedName(job)
	return string.format(jobs.list[job.identifier].name, job.numberRec)
end

function ix.jobs.getFormattedDesc(activejob)
	local description = activejob.fieldTask and ix.jobs.field.DescribeAssignment(activejob)
		or ix.jobs.list[activejob.identifier].desc
	local text = string.format(description, activejob.numberRec)
	if activejob.rewardChoices then
		local selected = activejob.rewardChoices[activejob.supplyChoice or 0]
		local supplies = selected and selected.label or ix.taskRewards.Summary({choices = activejob.rewardChoices})
		text = text .. "\n\nReward: " .. supplies
			.. "\n\nPayment: " .. activejob.moneyReward .. " rubles."
		if ix.jobs.list[activejob.identifier].requiredItem then
			text = text .. " Better-quality hand-ins can increase this payment."
		end
	end

	return text
end

function jobs.getFormattedNameInactive(identifier)
	return string.format(jobs.list[identifier].name, initialCount(identifier))
end

function jobs.getFormattedDescInactive(identifier)
	return string.format(jobs.list[identifier].desc, initialCount(identifier))
end

function jobs.isItemJob(identifier)
	local definition = jobs.list[identifier]

	return definition and definition.requiredItem or false
end

function jobs.getJobFromTier(tier)
	local available = {}
	for identifier, definition in pairs(jobs.list) do
		if definition.tier == tier then available[#available + 1] = identifier end
	end
	if #available > 0 then return available[math.random(#available)] end
end

function ix.jobs.getJobFromCategory(categories)
	if not istable(categories) then categories = {categories} end
	local pools = {}
	for _, category in ipairs(categories) do
		local available = {}
		for _, id in ipairs(ix.jobs.jobsbycategory[category] or {}) do
			local definition = ix.jobs.list[id]
			if definition and (not definition.fieldType or ix.jobs.field.IsAvailable(definition)) then
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
