local PLUGIN = PLUGIN
local DIFFICULTIES = {"easy", "medium", "hard"}
local TRIGGERS = {hunting = "mutantKilled", humans = "banditKilled"}

local function registerJob(contact, id, data)
	data.townContact = contact.id
	data.icon = "propic/event/area"
	data.reward = {}
	data.rewardCount = 0
	ix.jobs.register(data, id)
end

local function registerDeliveries(contact, base, category, tier)
	for _, poolID in ipairs(contact.job.pools) do
		local pool = assert(ix.progression.itemPools[poolID], "Unknown town job pool: " .. poolID)
		for _, candidate in ipairs(pool.candidates) do
			local item = assert(ix.item.list[candidate.item], "Missing town delivery item: " .. candidate.item)
			local unit = math.max(1, ix.taskRewards.HandInUnitValue(candidate.item))
			local minimum = (contact.job.minimumValue or {})[tier] or 0
			local job = table.Copy(base)
			job.requiredItem = candidate.item
			job.numberRec = math.max(contact.job.quantities[tier], math.ceil(minimum / unit))
			job.name = "Deliver %d " .. item.name .. "."
			job.desc = contact.job.description .. " Deliver %d required units."
			registerJob(contact, category .. "/" .. candidate.item, job)
		end
	end
end

local function registerRepeatable(contact, difficulty, tier)
	local category = "cotz/town/" .. contact.id .. "/" .. difficulty
	local rewards = (contact.job.rewards or PLUGIN.settings.jobRewards)[difficulty]
	local kind = contact.job.kind
	local job = {
		tier = tier,
		numberRec = 1,
		moneyReward = rewards.money,
		repReward = rewards.reputation,
		categories = {category},
	}
	contact.categories[difficulty] = {category}
	if kind == "delivery" then
		registerDeliveries(contact, job, category, tier)
		return
	end
	if kind == "arena" then return end
	if TRIGGERS[kind] then
		job.listenTrigger = contact.job.trigger or TRIGGERS[kind]
		job.numberRec = contact.job.quantities[tier]
		job.name = contact.job.description .. " (%d)"
		job.desc = "Complete %d qualifying NPC eliminations. " .. contact.job.description
	else
		job.fieldType = kind
		job.fieldMap = contact.job.maps[difficulty]
		job.name = contact.job.description
		job.desc = contact.job.description .. " Use Field work in your PDA. Region: " .. job.fieldMap .. "."
	end
	registerJob(contact, category, job)
end

local function registerCommission(contact, step)
	local progressionID = PLUGIN:StepID(contact.id, step.id)
	local definition = {
		name = step.name,
		desc = step.briefing .. "\n" .. step.objective,
		fieldType = step.field.kind,
		fieldMap = step.field.map,
		tier = step.field.tier,
		numberRec = 1,
		moneyReward = 0,
		repReward = 0,
		categories = {},
		townProgression = progressionID,
		CanAcceptTask = function(client)
			return ix.progression.IsActive(client:GetCharacter(), progressionID)
		end,
	}
	registerJob(contact, "cotz/town/commission/" .. contact.id .. "/" .. step.id, definition)
end

function PLUGIN:BuildJobs()
	for _, contact in pairs(self.contacts) do
		contact.categories = {}
		ix.taskRewards.SetProfile(contact.name, contact.supplies)
		for tier, difficulty in ipairs(DIFFICULTIES) do registerRepeatable(contact, difficulty, tier) end
		for _, step in ipairs(contact.progression) do
			if step.kind == "field" then registerCommission(contact, step) end
		end
	end
end
