local PLUGIN = PLUGIN
local town = PLUGIN
local REGIONAL_KINDS = {none = true, valuableCourier = true, photography = true, courier = true,
	regionalHunting = true, regionalHumans = true, regionalMeals = true, regionalSpecimens = true,
	categoryHunting = true}
ix.townNPCs = PLUGIN

town.contacts = {}
town.byName = {}
town.steps = {}
town.itemGates = {}
town.catalogues = {}
town.installed = false

function PLUGIN:Register(id, contact)
	contact.id = id
	self.contacts[id] = contact
	self.byName[contact.name] = contact
end

function PLUGIN:StepID(contact, step)
	return "cotz/town/" .. contact .. "/" .. step
end

function PLUGIN:ScaleProgressionEffort(contact, amount)
	return math.ceil(amount * (contact.difficultyMultiplier or 1))
end

function PLUGIN:HasService(character, service, npc)
	local gate = (self.serviceGates or {})[service]

	return character ~= nil and gate ~= nil and (not npc or gate.npc == npc)
		and ix.progression.IsCompleted(character, gate.id)
end

function PLUGIN:BuildWantedItems(contact)
	local wanted = {}
	local function addPool(poolID)
		local pool = assert(ix.progression.itemPools[poolID], "Unknown wanted-item pool: " .. poolID)
		for _, candidate in ipairs(pool.candidates) do wanted[candidate.item] = true end
	end
	local delivery = contact.legacyJob or contact.job
	if delivery.kind == "delivery" then
		for _, poolID in ipairs(delivery.pools or {}) do addPool(poolID) end
		for _, tier in pairs(delivery.deliveryTiers or {}) do
			for _, poolID in ipairs(tier.pools) do addPool(poolID) end
		end
	end
	for _, step in ipairs(contact.progression) do
		for _, slot in ipairs(step.requirements or {}) do addPool(slot.pool) end
	end
	contact.wantedItems = wanted

	return wanted
end

function PLUGIN:BuildCourierItems(contact)
	local wanted = {}
	for _, poolID in ipairs(contact.courierPools or {}) do
		local pool = assert(ix.progression.itemPools[poolID], "Unknown courier pool: " .. poolID)
		for _, candidate in ipairs(pool.candidates) do wanted[candidate.item] = true end
	end
	contact.courierItems = wanted
end

function PLUGIN:WantsCourierItem(contact, item, includeLegacy)
	if contact.disabledItems and contact.disabledItems[item] then return false end
	local legacy = (contact.wantedItems or {})[item] == true
	if contact.id == "the-original" then return includeLegacy == true and legacy end

	return (contact.courierItems or {})[item] == true or legacy
end

function PLUGIN:CanBuyItem(character, item, npcName)
	local contact = self.byName[npcName]
	if contact and contact.disabledItems and contact.disabledItems[item] then return false end
	if self:IsPurchaseExcluded(item) then return false end
	if contact and contact.enforceCatalogue and not contact.catalogue[item] then
		local supplied = false
		for _, itemID in ipairs(contact.supplies) do supplied = supplied or itemID == item end
		if not supplied then return false end
	end
	if npcName == "'Mute'" and item:match("^binoculars_") then return false end
	local gate = self.itemGates[item]
	if not gate then return end
	if gate.sellers then
		gate = gate.sellers[npcName]
		if not gate then return false end
	end

	return character ~= nil and (gate.ungated == true or ix.progression.IsCompleted(character, gate.id))
end

function PLUGIN:CanSellItem(item, npcName)
	local contact = self.byName[npcName]
	if contact and contact.enforceCatalogue then return (contact.wantedItems or {})[item] == true end
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
	if definition.completionOnly or contact.job.kind == "none" then return false end
	if ix.jobs.regional and not ix.jobs.regional.CanOffer(character, definition) then return false end
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
		if contact.job.kind == "none" then key = key .. "/" .. contact.id end
		assert(not categories[key], "Duplicate town job category: " .. key)
		categories[key] = true
		local template = assert(ix.npctemplates.templates[contact.template], "Missing template: " .. contact.template)
		assert(template.name == contact.name, "Town contact name differs from its saved vendor identity")
		assert(REGIONAL_KINDS[contact.job.kind] or contact.job.kind == "delivery"
			or contact.job.kind == "hunting" or contact.job.kind == "humans"
			or contact.job.kind == "arena" or contact.job.kind == "dataExtract"
			or ix.jobs.field.settings[contact.job.kind], "Unknown town job kind")
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

-- Derived from earned milestones, so reconnects and repeated callbacks cannot duplicate capacity.
function PLUGIN:GetCapacityBonus(character, kind)
	if not character then return 0 end
	local total = 0
	for id, reward in pairs(self.capacityMilestones or {}) do
		if reward.kind == kind and ix.progression.IsCompleted(character, id) then
			total = total + reward.amount
		end
	end

	return math.min(total, kind == "weight" and 5 or 2)
end

function PLUGIN:IsPurchaseExcluded(itemID)
	local item = ix.item.list[itemID]
	if item and item.baseSuit and item.baseSuit ~= itemID then return true end
	for _, reserved in ipairs(self.reservedEquipment or {}) do
		if itemID == reserved or (item and item.baseSuit == reserved) then return true end
	end

	return false
end

function PLUGIN:CanChangeSuitVariant(character, itemID, npc)
	if npc and not self:HasService(character, "suitVariants", npc) then return false end
	local item = ix.item.list[itemID]
	if not item or not item.baseSuit then return false end
	for _, reserved in ipairs(self.reservedEquipment or {}) do
		if item.baseSuit == reserved then return false end
	end
	local gate = self.itemGates[item.baseSuit]

	local variant = self.variantUnlocks[itemID]
	local unlocked = itemID == item.baseSuit or (variant
		and ix.progression.IsCompleted(character, self:StepID(variant.contact, variant.step)))

	return gate ~= nil and unlocked and ix.progression.IsCompleted(character, gate.id)
end
