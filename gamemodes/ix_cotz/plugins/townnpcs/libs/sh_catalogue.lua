local PLUGIN = PLUGIN

function PLUGIN:BuildCatalogue()
	for itemID, allocation in pairs(self.variantUnlocks or {}) do
		local id = self:StepID(allocation.contact, allocation.step)
		local definition = assert(ix.progression.definitions[id], "Unknown variant milestone: " .. id)
		definition.variantUnlocks = definition.variantUnlocks or {}
		definition.variantUnlocks[#definition.variantUnlocks + 1] = itemID
	end
	for _, contact in pairs(self.contacts) do
		for item, allocation in pairs(contact.catalogue or {}) do
			assert(ix.item.list[item], "Unknown town catalogue item: " .. item)
			local id = self:StepID(allocation.unlockContact or contact.id, allocation.step)
			local definition = assert(ix.progression.definitions[id], "Unknown town catalogue step: " .. id)
			local args = {item}
			for index = 1, 6 do args[index + 1] = allocation.terms[index] end
			definition.vendorUnlocks[#definition.vendorUnlocks + 1] = {npc = contact.name, args = args}
			local existing = self.itemGates[item]
			if item:sub(1, 6) == "medic_" then
				local gate = existing or {id = id, npc = contact.name, sellers = {}}
				gate.sellers[contact.name] = {id = id, npc = contact.name}
				-- Keep the representative stable; medicine eligibility always uses the actual seller.
				if id < gate.id then gate.id, gate.npc = id, contact.name end
				self.itemGates[item] = gate
			else
				assert(not existing or existing.id == id, "Conflicting shared item gate: " .. item)
				self.itemGates[item] = {id = id, npc = contact.name}
			end
		end
	end
	local function requireGate(lower, higher)
		if not lower or not higher or lower.id == higher.id then return end
		local definition = ix.progression.definitions[higher.id]
		for _, id in ipairs(definition.prerequisites) do if id == lower.id then return end end
		definition.prerequisites[#definition.prerequisites + 1] = lower.id
	end
	for _, chain in ipairs(self.upgradeChains) do
		for index = 2, #chain do
			local lower, higher = self.itemGates[chain[index - 1]], self.itemGates[chain[index]]
			if higher and higher.sellers then
				for npc, gate in pairs(higher.sellers) do
					-- Missing earlier medicine tiers are stocked locally instead of requiring another medic.
					requireGate(lower and lower.sellers and lower.sellers[npc], gate)
				end
			else
				requireGate(lower, higher)
			end
		end
	end
	-- Catalogue gates can cross NPCs; all new nodes remain activatable once their prerequisites are met.
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
