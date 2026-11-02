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

local spawnBatches = {}

local function collectSpawnBatches()
	spawnBatches = {}
	for poolID, rows in pairs(ix.randomitems.tables) do
		local acquisition = poolID:find("worldspawn_", 1, true) == 1 or poolID:match("_loot$")
			or poolID:match("_entbox_drops$") or poolID:match("^cache_documents_") or poolID:match("^cache_valuables_")
		if acquisition then
			for _, row in ipairs(rows) do
				local itemID, data = row[2][1], row[2][2]
				local item = ix.item.list[itemID]
				if item and item.quantity and item.quantity > 0 then
					local defaults = PLUGIN.settings.spawnBatches[itemID] or {item.quantity, item.quantity}
					local quantity = data and data.quantity
					local low = type(quantity) == "table" and quantity[1] or quantity or defaults[1]
					local high = type(quantity) == "table" and quantity[2] or quantity or defaults[2]
					local bounds = spawnBatches[itemID] or {low, high}
					spawnBatches[itemID] = {math.min(bounds[1], low), math.max(bounds[2], high)}
				end
			end
		end
	end
end

local function deliveryQuantity(itemID, tier, fallback)
	local bounds = spawnBatches[itemID]
	if not bounds then return fallback end
	if tier == 1 then return bounds[1] end
	if tier == 2 then return bounds[2] end

	return bounds[2] + 1
end

local function registerDeliveries(contact, base, category, tier, pools, quantity, minimum)
	for _, poolID in ipairs(pools) do
		local pool = assert(ix.progression.itemPools[poolID], "Unknown town job pool: " .. poolID)
		for _, candidate in ipairs(pool.candidates) do
			local item = assert(ix.item.list[candidate.item], "Missing town delivery item: " .. candidate.item)
			local unit = math.max(1, ix.taskRewards.HandInUnitValue(candidate.item))
			local job = table.Copy(base)
			job.requiredItem = candidate.item
			job.requiredPool = tier == 1 and poolID or nil
			local fallback = math.max(quantity, math.ceil(minimum / unit))
			job.numberRec = deliveryQuantity(candidate.item, tier, fallback)
			job.name = "Deliver %d " .. item.name .. "."
			job.desc = contact.job.description .. " Deliver %d required units."
			if job.requiredPool then
				local label = poolID:match("^valuables_(.+)$")
				label = label and label:gsub("_", " ") or pool.name
				job.name = "Deliver %d units of " .. label .. "."
				job.desc = contact.job.description .. " Deliver %d units of " .. label
					.. ". Any item in this category counts; different items can be combined."
			end
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
		registerDeliveries(contact, job, category, tier, contact.job.pools,
			contact.job.quantities[tier], (contact.job.minimumValue or {})[tier] or 0)
		local deliveryTier = (contact.job.deliveryTiers or {})[difficulty]
		if deliveryTier then
			registerDeliveries(contact, job, category, tier, deliveryTier.pools, deliveryTier.quantity, 0)
		end
		return
	end
	if kind == "dataExtract" then
		local identifier = category .. "/dataExtract"
		job.name = "Extract data from %d computer types."
		job.desc = contact.job.description
		job.listenTrigger = identifier
		job.toolItem = "dataextractor"
		job.toolData = {ntypes = contact.job.quantities[tier], finishedtrigger = identifier}
		job.toolCompletionKeys = {"ntypes", "finishedtrigger"}
		job.removeToolOnComplete = true
		job.townContact = contact.id
		job.icon = "propic/event/area"
		job.reward = {}
		job.rewardCount = 0
		-- One completion trigger covers all requested computer types.
		job.name = string.format(job.name, job.toolData.ntypes)
		job.desc = string.format(job.desc, job.toolData.ntypes)
		ix.jobs.RegisterToolJob(job, identifier)
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
		fieldCargo = step.field.cargo,
		fieldCargoName = step.field.label,
		fieldCargoDescription = step.field.description,
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
	if step.field.recipient then
		local recipient = PLUGIN.contacts[step.field.recipient]
		definition.fieldRecipient = recipient.name
		definition.fieldRecipientMap = recipient.map
	end
	registerJob(contact, "cotz/town/commission/" .. contact.id .. "/" .. step.id, definition)
end

function PLUGIN:BuildJobs()
	collectSpawnBatches()
	for _, contact in pairs(self.contacts) do
		contact.categories = {}
		ix.taskRewards.SetProfile(contact.name, contact.supplies)
		ix.taskRewards.SetTownProfile(contact.name, contact.rewards)
		for tier, difficulty in ipairs(DIFFICULTIES) do registerRepeatable(contact, difficulty, tier) end
		for _, step in ipairs(contact.progression) do
			if step.kind == "field" then
				registerCommission(contact, step)
			elseif step.retiredCommission then
				-- Saved assignments own their field state; retain only their completion identity.
				registerJob(contact, "cotz/town/commission/" .. contact.id .. "/" .. step.id, {
					name = step.name,
					desc = step.briefing,
					categories = {},
					townProgression = self:StepID(contact.id, step.id),
					CanAcceptTask = function() return false end,
				})
			end
		end
	end
end
