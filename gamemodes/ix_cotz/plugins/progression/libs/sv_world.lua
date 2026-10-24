local progressionPlugin = PLUGIN

function ix.progression.UnlockWorldNPC(progid)
	local definition = ix.progression.definitions[progid]
	if not definition or not definition.worldNPC then return end
	progressionPlugin.worldUnlocks = progressionPlugin.worldUnlocks or {}
	if progressionPlugin.worldUnlocks[progid] then return end
	progressionPlugin.worldUnlocks[progid] = true
	progressionPlugin:SaveData()
	if progressionPlugin.worldDataLoaded then progressionPlugin:SetupProgressionWorld() end
end

-- World arrivals persist globally; service access remains character-owned.
function PLUGIN:SetupProgressionWorld()
	for progid, definition in pairs(ix.progression.definitions) do
		local spawn = definition.worldNPC
		local unlocked = self.worldUnlocks and self.worldUnlocks[progid]
		if (spawn and unlocked and definition.progMap == game.GetMap()) then
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
		-- Grants restore access and NPC arrivals without replaying personal rewards.
		ix.progression.SetCompleted(character, progid)
		character:Save()
		return "Progression milestone granted."
	end
})
