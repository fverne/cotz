local PLUGIN = PLUGIN
local DIFFICULTIES = {"easy", "medium", "hard"}
local KINDS = {delivery = true, tracker = true, field = true, arena = true}
local PLANNED_KINDS = {
	passage = true, cosmetic = true, storage = true, barter = true,
	supplyExchange = true, information = true, recipe = true,
}

local function validatePlannedUnlock(reward, contact, ids, report)
	if not PLANNED_KINDS[reward.kind] or reward.status ~= "unimplemented" or reward.provider ~= contact.id then
		report("invalid planned unlock kind, status or provider")
	end
	if type(reward.id) ~= "string" or reward.id == "" or ids[reward.id] then
		report("invalid or duplicate planned unlock ID")
	end
	if reward.id then ids[reward.id] = true end
	if type(reward.name) ~= "string" or reward.name == ""
		or type(reward.effect) ~= "string" or reward.effect == "" then
		report("planned unlock needs a name and intended effect")
	end
	local function validateItem(term)
		if not ix.item.list[term.item] or type(term.quantity) ~= "number"
			or term.quantity <= 0 or term.quantity % 1 ~= 0 then
			report("invalid planned item or quantity")
		end
	end
	for _, term in ipairs(reward.inputs or {}) do validateItem(term) end
	for _, term in ipairs(reward.outputs or {}) do validateItem(term) end
	if reward.output then validateItem(reward.output) end
	if reward.fuel then validateItem(reward.fuel) end
	if reward.baseSuit and not ix.item.list[reward.baseSuit] then report("invalid planned cosmetic suit") end
end

function PLUGIN:ValidateContacts()
	local errors = {}
	local plannedIDs = {}
	local serviceIDs = {}
	for slug, contact in pairs(self.contacts) do
		local function report(message)
			errors[#errors + 1] = slug .. ": " .. message
		end
		local function isDisabled(item)
			return contact.disabledItems and contact.disabledItems[item]
		end
		local multiplier = contact.difficultyMultiplier or 1
		if type(multiplier) ~= "number" or multiplier ~= multiplier or multiplier <= 0
			or multiplier == math.huge then report("invalid progression effort multiplier") end
		for _, item in ipairs(contact.supplies) do
			if isDisabled(item) then report("disabled item in supplies: " .. item) end
		end
		local ids = {}
		for _, service in ipairs(contact.startingServices or {}) do
			if type(service.id) ~= "string" or service.id == "" or serviceIDs[service.id]
				or type(service.name) ~= "string" or service.name == "" then
				report("invalid or duplicate starting service")
			else
				serviceIDs[service.id] = true
			end
		end
		for _, step in ipairs(contact.progression) do
			if step.ammoExchange then
				local exchange = step.ammoExchange
				local input, output = ix.item.list[exchange.input], ix.item.list[exchange.output]
				if not input or not output or (exchange.boxes ~= 2 and exchange.boxes ~= 3)
					or not isnumber(input.ammoAmount) or not isnumber(output.ammoAmount)
					or input.ammoAmount <= 0 or output.ammoAmount <= 0
					or (self.ammoVariants or {})[exchange.output] ~= exchange.input then
					report("invalid ammunition exchange on " .. step.id)
				end
			end
			if ids[step.id] then report("duplicate step " .. step.id) end
			ids[step.id] = true
			if not KINDS[step.kind] then report("unknown objective kind on " .. step.id) end
		end
		for item, allocation in pairs(contact.catalogue or {}) do
			if isDisabled(item) then report("disabled item in catalogue: " .. item) end
			if not ix.item.list[item] or not ids[allocation.step] or allocation.unlockContact then
				report("invalid local catalogue route for " .. item)
			end
			local terms = allocation.terms
			if not terms or not terms[2] or not terms[3] or not terms[4] or not terms[5] or not terms[6] then
				report("incomplete vendor terms for " .. item)
			end
		end
		for _, step in ipairs(contact.progression) do
			for _, service in ipairs(step.services or {}) do
				if type(service.id) ~= "string" or service.id == "" or serviceIDs[service.id]
					or type(service.name) ~= "string" or service.name == "" then
					report("invalid or duplicate service unlock on " .. step.id)
				else
					serviceIDs[service.id] = true
				end
			end
			for _, reward in ipairs(step.plannedUnlocks or {}) do
				validatePlannedUnlock(reward, contact, plannedIDs, report)
			end
			if step.stock then
				local bonus = step.stock.bonus
				local items = step.stock.items or {step.stock.item}
				if #items == 0 or type(bonus) ~= "number"
					or bonus < 1 or bonus > 4 or bonus % 1 ~= 0 then
					report("invalid stock tier on " .. step.id)
				end
				for _, itemID in ipairs(items) do
					if isDisabled(itemID) then report("disabled stock item on " .. step.id) end
					if not ix.item.list[itemID] then report("invalid stock item on " .. step.id) end
				end
			end
			for _, required in ipairs(step.requires) do
				if not ids[required] then report(step.id .. " requires missing step " .. required) end
			end
			for _, slot in ipairs(step.requirements or {}) do
				local pool = ix.progression.itemPools[slot.pool]
				if not pool then report(step.id .. " uses unknown pool " .. slot.pool) end
			end
			if step.kind == "field" and not ix.jobs.field.settings[step.field.kind] then
				report(step.id .. " uses unknown field mechanic " .. step.field.kind)
			end
			if step.kind == "field" and step.field.cargo then
				local cargo = ix.item.list[step.field.cargo]
				if not cargo or not cargo.isFieldCargo then
					report(step.id .. " uses invalid bound cargo " .. step.field.cargo)
				end
			end
			if step.kind == "field" and step.field.recipient then
				local recipient = self.contacts[step.field.recipient]
				if not recipient or recipient == contact or recipient.map == "rp_pripyat_remaster"
					or step.field.kind == "deadDrop" or step.field.kind == "defence" then
					report(step.id .. " uses invalid delivery recipient " .. step.field.recipient)
				end
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
