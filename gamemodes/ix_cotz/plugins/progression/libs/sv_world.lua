-- Catalog/placement setup is idempotent and independent of player completion.
function PLUGIN:SetupProgressionWorld()
	for _, definition in pairs(ix.progression.definitions) do
		local spawn = definition.worldNPC
		if (spawn and definition.progMap == game.GetMap()) then
			local template = ix.npctemplates.templates[spawn.template]
			if (template and not ix.progression.GetNPCFromName(template.name)) then
				ix.util.SpawnAdvVendor(spawn.template, spawn.pos, spawn.ang)
			end
		end
	end

	for _, vendor in ipairs(ents.FindByClass("ix_vendor_adv")) do
		for _, definition in pairs(ix.progression.definitions) do
			for _, unlock in ipairs(definition.vendorUnlocks or {}) do
				if (vendor:GetDisplayName() == unlock.npc and ix.item.list[unlock.args[1]]) then
					vendor:AddItemToList(unpack(unlock.args, 1, 7))
				end
			end
		end
	end
end

ix.command.Add("ProgressionGrant", {
	adminOnly = true,
	arguments = {ix.type.character, ix.type.string},
	OnRun = function(self, client, character, progid)
		if (not ix.progression.definitions[progid]) then return "Unknown progression." end
		-- Administrative grants restore access without replaying world effects or rewards.
		ix.progression.SetCompleted(character, progid)
		character:Save()
		return "Progression milestone granted."
	end
})
