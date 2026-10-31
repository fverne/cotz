local PLUGIN = PLUGIN
local town = PLUGIN
ix.townNPCs = PLUGIN

town.contacts = {}
town.byName = {}
town.steps = {}
town.itemGates = {}
town.catalogues = {}
town.requirementPools = {}
town.installed = false

function PLUGIN:Register(id, contact)
	contact.id = id
	self.contacts[id] = contact
	self.byName[contact.name] = contact
end

function PLUGIN:StepID(contact, step)
	return "cotz/town/" .. contact .. "/" .. step
end

function PLUGIN:CanBuyItem(character, item)
	local gate = self.itemGates[item]
	if not gate then return end

	return ix.progression.IsCompleted(character, gate.id)
end

function PLUGIN:CanInteract(client, target)
	local character = client:GetCharacter()

	return character and IsValid(target) and target:GetClass() == "ix_vendor_adv"
		and target:CanAccess(client) and self.byName[target:GetDisplayName()] ~= nil
		and client:GetPos():DistToSqr(target:GetPos()) <= self.settings.interactionDistance ^ 2
end

function PLUGIN:CanAcceptJob(character, npc, definition)
	local contact = self.byName[npc]
	if not contact then return true end
	if definition.townContact ~= contact.id then return false end
	if definition.townProgression then
		return ix.progression.IsActive(character, definition.townProgression)
	end
	local difficulty = ({"easy", "medium", "hard"})[definition.tier]

	return difficulty ~= nil and ix.taskRewards.CanTakeDifficulty(character, difficulty)
end

function PLUGIN:Install()
	assert(ix.progression and ix.jobs and ix.dialogue and ix.npctemplates, "Town NPC dependencies are missing")
	if self.installed then return end
	local errors = self:ValidateContacts()
	assert(#errors == 0, "Invalid town NPC definitions:\n" .. table.concat(errors, "\n"))
	local categories = {}
	for _, contact in pairs(self.contacts) do
		assert(contact.map ~= "rp_pripyat_remaster", "Pripyat must not contain town contacts")
		local key = contact.map .. "/" .. contact.job.category
		assert(not categories[key], "Duplicate town job category: " .. key)
		categories[key] = true
		local template = assert(ix.npctemplates.templates[contact.template], "Missing template: " .. contact.template)
		assert(template.name == contact.name, "Town contact name differs from its saved vendor identity")
		assert(contact.job.kind == "delivery" or contact.job.kind == "hunting" or contact.job.kind == "humans"
			or contact.job.kind == "arena" or ix.jobs.field.settings[contact.job.kind], "Unknown town job kind")
	end
	self:BuildProgressions()
	self:BuildJobs()
	self:ConfigureSources()
	self:InstallContacts()
	self.installed = true
end

function PLUGIN:InstallContacts()
	local vendors = ix.plugin.Get("vendor_adv")
	for _, contact in pairs(self.contacts) do
		vendors:ConfigureTownTemplate(contact, self.catalogues[contact.name] or {},
			contact.supplyStock or self.settings.supplyStock)
		local template = ix.npctemplates.templates[contact.template]
		local dialogue = assert(ix.dialogue.list[template.dialogueid], "Missing town conversation")
		ix.dialogue.ConfigureTownContact(dialogue, contact)
	end
end
