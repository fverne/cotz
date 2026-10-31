local PLUGIN = PLUGIN
local DIFFICULTIES = {"easy", "medium", "hard"}
local KINDS = {delivery = true, tracker = true, field = true, arena = true}

function PLUGIN:ValidateContacts()
	local errors = {}
	for slug, contact in pairs(self.contacts) do
		local function report(message)
			errors[#errors + 1] = slug .. ": " .. message
		end
		local ids = {}
		for _, step in ipairs(contact.progression) do
			if ids[step.id] then report("duplicate step " .. step.id) end
			ids[step.id] = true
			if not KINDS[step.kind] then report("unknown objective kind on " .. step.id) end
		end
		for _, step in ipairs(contact.progression) do
			for _, required in ipairs(step.requires) do
				if not ids[required] then report(step.id .. " requires missing step " .. required) end
			end
			for _, slot in ipairs(step.requirements or {}) do
				local pool = self.requirementPools[slot.pool] or ix.progression.itemPools[slot.pool]
				if not pool then report(step.id .. " uses unknown pool " .. slot.pool) end
			end
			if step.kind == "field" and not ix.jobs.field.settings[step.field.kind] then
				report(step.id .. " uses unknown field mechanic " .. step.field.kind)
			end
		end
		local rewards = contact.job.rewards or self.settings.jobRewards
		for _, difficulty in ipairs(DIFFICULTIES) do
			local reward = rewards[difficulty]
			if not reward or type(reward.money) ~= "number" or type(reward.reputation) ~= "number" then
				report("missing money/reputation reward for " .. difficulty)
			end
		end
	end
	table.sort(errors)

	return errors
end

function PLUGIN:GetMissingFieldSites()
	local missing = {}
	for id, step in pairs(self.steps) do
		if step.kind == "field" then
			local definition = ix.jobs.list[ix.progression.definitions[id].townCommission]
			if not ix.jobs.field.IsAvailable(definition) then
				local key = step.field.kind .. " on " .. step.field.map
				missing[key] = (missing[key] or 0) + 1
			end
		end
	end

	return missing
end
