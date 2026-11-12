local PLUGIN = PLUGIN

local function buildResponse(self, npc, status, character)
	local text = ix.progression.BuildDeliveryResponse(self, npc, status, character)
	local label = self.townKind == "field" and "Field commission completed:" or "Qualifying jobs completed:"
	if self.townKind == "arena" then label = "Eligible bouts completed:" end

	return text:gsub("Qualified matches completed:", label)
end

local function addDependency(definition, id)
	definition.prerequisites = definition.prerequisites or {}
	for _, existing in ipairs(definition.prerequisites) do
		if existing == id then return end
	end
	definition.prerequisites[#definition.prerequisites + 1] = id
end

local function buildAllowedRequirements(maps)
	local regions, allowed = {}, {}
	for _, region in ipairs(maps) do regions[region] = true end
	for itemID, source in pairs(ix.progression.townRequirementSources or {}) do
		for _, region in ipairs(source.maps) do
			if regions[region] then allowed[itemID] = true break end
		end
	end

	return allowed
end

function PLUGIN:BuildProgressions()
	self.capacityMilestones = {}
	self.serviceGates = {}
	self.ammoExchanges = {}
	self.variantBaseGates = {}
	local allowedByMaps = {}
	for slug, contact in pairs(self.contacts) do
		for _, service in ipairs(contact.startingServices or {}) do
			self.serviceGates[service.id] = {ungated = true, npc = contact.name}
		end
		if contact.access then
			ix.progression.npcRequirements[contact.name] = self:StepID(contact.access.contact, contact.access.step)
		end
		for _, step in ipairs(contact.progression) do
			local id = self:StepID(slug, step.id)
			local definition = {
				name = step.name,
				description = step.briefing,
				briefing = step.briefing,
				townObjective = step.objective,
				keyNpc = contact.name,
				progMap = contact.map,
				townContact = slug,
				townKind = step.kind,
				townBranch = step.branch,
				categoryOnly = step.categoryOnly,
				-- Entry steps still open when their newly linked parent was completed before this update.
				defaultActive = step.defaultActive == true or step.branchIndex == 1
					or (#step.requires == 0 and #(step.crossRequires or {}) == 0),
				nextProgressions = {},
				prerequisites = {},
				BuildResponse = buildResponse,
				completionMessage = step.completion,
				completionBenefits = step.benefits,
				acquisitionMaps = step.acquisitionMaps,
				requirementPolicy = step.requirementPolicy,
				requirementModesVersion = step.requirementModesVersion or 2,
				requirementAlternatives = step.requirementAlternatives,
				intermissionFor = step.intermissionFor,
				capacityReward = step.capacity,
				vendorUnlocks = {},
				recognition = step.recognition,
				serviceDiscounts = step.discounts,
				townServices = step.services,
				ammoExchange = step.ammoExchange,
			}
			if step.id ~= "v3/hideout/access" then
				definition.categoryChoiceRange = self.settings.progressionCategoryChoices
				definition.batchSizedRequirements = true
			end
			if step.acquisitionMaps then
				local key = table.concat(step.acquisitionMaps, "/")
				if not allowedByMaps[key] then
					allowedByMaps[key] = buildAllowedRequirements(step.acquisitionMaps)
				end
				definition.allowedRequirements = allowedByMaps[key]
			end
			if step.ammoExchange then
				self.ammoExchanges[step.ammoExchange.output] = {
					id = id, npc = contact.name, input = step.ammoExchange.input,
					output = step.ammoExchange.output, boxes = step.ammoExchange.boxes,
				}
			end
			if step.variantBase then self.variantBaseGates[step.variantBase] = id end
			for _, service in ipairs(step.services or {}) do
				assert(not self.serviceGates[service.id], "Duplicate town service: " .. service.id)
				self.serviceGates[service.id] = {id = id, npc = contact.name}
			end
			if step.stock then
				definition.stockUnlocks = {{npc = contact.name,
					items = step.stock.items or {step.stock.item}, bonus = step.stock.bonus}}
			end
			for _, required in ipairs(step.requires) do addDependency(definition, self:StepID(slug, required)) end
			for _, required in ipairs(step.crossRequires or {}) do
				addDependency(definition, self:StepID(required.contact, required.step))
			end
			if step.kind == "delivery" then
				definition.requirementSlots = {}
				for _, slot in ipairs(step.requirements) do
					-- Initial access takes one tool regardless of the contact's delivery difficulty.
					local quantity = step.id == "v3/hideout/access" and slot.quantity
						or self:ScaleProgressionEffort(contact, slot.quantity)
					definition.requirementSlots[#definition.requirementSlots + 1] = {
						pool = slot.pool, quantity = quantity, mode = slot.mode,
					}
				end
			else
				definition.progressthresholds = {self:ScaleProgressionEffort(contact, step.target or 1)}
				definition.progressfunctions = {}
			end
			if step.kind == "field" then definition.townCommission = "cotz/town/commission/" .. slug .. "/" .. step.id end
			ix.progression.Register(id, definition)
			self.steps[id] = step
			if step.capacity then self.capacityMilestones[id] = step.capacity end
		end
	end
	for id in pairs(self.steps) do
		for _, required in ipairs(ix.progression.definitions[id].prerequisites) do
			local parent = ix.progression.definitions[required]
			assert(parent, "Unknown town prerequisite: " .. required)
			parent.nextProgressions[#parent.nextProgressions + 1] = id
		end
	end
	self:BuildCatalogue()
end

function PLUGIN:OnCompleted(character, id)
	local step = self.steps[id]
	if not step then return end
	if SERVER then
		ix.progression.PayCompletionRewards(character, id)
		self:AdvanceCounters(character)
	end
end
