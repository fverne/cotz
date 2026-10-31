local PLUGIN = PLUGIN

function PLUGIN:BuildCatalogue()
	for _, contact in pairs(self.contacts) do
		for item, allocation in pairs(contact.catalogue or {}) do
			assert(ix.item.list[item], "Unknown town catalogue item: " .. item)
			local id = self:StepID(contact.id, allocation.step)
			local definition = assert(ix.progression.definitions[id], "Unknown town catalogue step: " .. id)
			local args = {item}
			for index = 1, 6 do args[index + 1] = allocation.terms[index] end
			definition.vendorUnlocks[#definition.vendorUnlocks + 1] = {npc = contact.name, args = args}
			self.itemGates[item] = {id = id, npc = contact.name}
		end
	end
	for _, chain in ipairs(self.upgradeChains) do
		for index = 2, #chain do
			local lower, higher = self.itemGates[chain[index - 1]], self.itemGates[chain[index]]
			if lower and higher and lower.id ~= higher.id then
				local definition = ix.progression.definitions[higher.id]
				local exists = false
				for _, id in ipairs(definition.prerequisites) do if id == lower.id then exists = true end end
				if not exists then definition.prerequisites[#definition.prerequisites + 1] = lower.id end
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
