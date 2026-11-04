local PLUGIN = PLUGIN

local function buildResponse(self, npc, status, character)
	local text = ix.progression.BuildDeliveryResponse(self, npc, status, character)
	if self.townObjective then text = text .. "\n\nObjective: " .. self.townObjective end
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

function PLUGIN:BuildProgressions()
	self.capacityMilestones = {}
	self.serviceGates = {}
	for slug, contact in pairs(self.contacts) do
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
				defaultActive = #step.requires == 0 and #(step.crossRequires or {}) == 0,
				nextProgressions = {},
				prerequisites = {},
				BuildResponse = buildResponse,
				completionMessage = step.completion,
				completionBenefits = step.benefits,
				completionCash = step.completionCash,
				capacityReward = step.capacity,
				vendorUnlocks = {},
				recognition = step.recognition,
				serviceDiscounts = step.discounts,
				townServices = step.services,
			}
			for _, service in ipairs(step.services or {}) do
				assert(not self.serviceGates[service.id], "Duplicate town service: " .. service.id)
				self.serviceGates[service.id] = {id = id, npc = contact.name}
			end
			if step.stock then
				definition.stockUnlocks = {{npc = contact.name, items = {step.stock.item}, bonus = step.stock.bonus}}
			end
			for _, required in ipairs(step.requires) do addDependency(definition, self:StepID(slug, required)) end
			for _, required in ipairs(step.crossRequires or {}) do
				addDependency(definition, self:StepID(required.contact, required.step))
			end
			if step.kind == "delivery" then
				definition.requirementSlots = {}
				for _, slot in ipairs(step.requirements) do
					definition.requirementSlots[#definition.requirementSlots + 1] = {
						pool = slot.pool, quantity = self:ScaleProgressionEffort(contact, slot.quantity),
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
