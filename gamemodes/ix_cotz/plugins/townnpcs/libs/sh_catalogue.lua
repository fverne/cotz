local PLUGIN = PLUGIN

local function requireGate(lower, higher)
	if not lower or not higher or lower.ungated or higher.ungated or lower.id == higher.id then return end
	local definition = ix.progression.definitions[higher.id]
	for _, id in ipairs(definition.prerequisites) do if id == lower.id then return end end
	definition.prerequisites[#definition.prerequisites + 1] = lower.id
end

function PLUGIN:BuildCatalogue()
	self.itemGates = {}
	self.catalogues = {}
	for itemID, allocation in pairs(self.variantUnlocks or {}) do
		local id = self:StepID(allocation.contact, allocation.step)
		local definition = assert(ix.progression.definitions[id], "Unknown variant milestone: " .. id)
		definition.variantUnlocks = definition.variantUnlocks or {}
		definition.variantUnlocks[#definition.variantUnlocks + 1] = itemID
	end
	for _, contact in pairs(self.contacts) do
		for item, allocation in pairs(contact.catalogue or {}) do
			assert(not (contact.disabledItems and contact.disabledItems[item]), "Disabled town item: " .. item)
			assert(ix.item.list[item], "Unknown town catalogue item: " .. item)
			local id = self:StepID(contact.id, allocation.step)
			local definition = assert(ix.progression.definitions[id], "Unknown town catalogue step: " .. id)
			local args = {item}
			for index = 1, 6 do args[index + 1] = allocation.terms[index] end
			definition.vendorUnlocks[#definition.vendorUnlocks + 1] = {npc = contact.name, args = args}
			local gate = self.itemGates[item] or {sellers = {}}
			gate.sellers[contact.name] = {id = id, npc = contact.name}
			self.itemGates[item] = gate
		end
	end
	for item, gate in pairs(self.itemGates) do
		local owner = (self.canonicalSellers or {})[item]
		if owner then
			local contact = assert(self.contacts[owner], "Unknown canonical contact: " .. owner)
			local canonical = assert(gate.sellers[contact.name], "Missing canonical purchase: " .. item)
			gate.id, gate.npc = canonical.id, canonical.npc
		else
			local count = 0
			for npc, seller in pairs(gate.sellers) do
				count = count + 1
				if not gate.id or seller.id < gate.id then gate.id, gate.npc = seller.id, npc end
			end
			assert(count == 1 or item:sub(1, 6) == "medic_", "Missing canonical seller: " .. item)
		end
	end
	-- A new specialist route must not lock an existing contact's ordinary supply of that item.
	for _, contact in pairs(self.contacts) do
		for _, item in ipairs(contact.supplies) do
			local gate = self.itemGates[item]
			if gate and not contact.catalogue[item] then
				gate.sellers[contact.name] = {ungated = true, npc = contact.name}
			end
		end
	end
	for _, chain in ipairs(self.upgradeChains) do
		for index = 2, #chain do
			local lower, higher = self.itemGates[chain[index - 1]], self.itemGates[chain[index]]
			for npc, gate in pairs(higher and higher.sellers or {}) do
				-- Medicine keeps local tier prerequisites; equipment uses the explicit canonical predecessor.
				local previous = lower
				if chain[index]:sub(1, 6) == "medic_" then previous = lower and lower.sellers[npc] end
				requireGate(previous, gate)
			end
		end
	end
	-- Ammunition follows each seller's authored price bands, independently of another shop.
	for slug, steps in pairs(self.ammoUnlockOrder or {}) do
		for index = 2, #steps do
			requireGate({id = self:StepID(slug, steps[index - 1])}, {id = self:StepID(slug, steps[index])})
		end
	end
	for variant, regular in pairs(self.ammoVariants or {}) do
		local lower, higher = self.itemGates[regular], self.itemGates[variant]
		for npc, gate in pairs(higher and higher.sellers or {}) do
			requireGate(lower and lower.sellers[npc], gate)
		end
	end
	-- Catalogue gates can cross NPCs; connect every prerequisite after all sellers are compiled.
	for id in pairs(self.steps) do
		local definition = ix.progression.definitions[id]
		for _, unlock in ipairs(definition.vendorUnlocks) do
			self.catalogues[unlock.npc] = self.catalogues[unlock.npc] or {}
			table.insert(self.catalogues[unlock.npc], unlock)
		end
		for _, required in ipairs(definition.prerequisites) do
			local parent = ix.progression.definitions[required]
			local exists = false
			for _, nextID in ipairs(parent.nextProgressions) do if nextID == id then exists = true end end
			if not exists then parent.nextProgressions[#parent.nextProgressions + 1] = id end
		end
	end
end
