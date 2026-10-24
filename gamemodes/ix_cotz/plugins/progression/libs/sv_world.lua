local PLUGIN = PLUGIN
local VENDOR_ARGUMENT_COUNT = 7

local function stockProgressionItems(vendor)
	for _, definition in pairs(ix.progression.definitions) do
		for _, unlock in ipairs(definition.vendorUnlocks or {}) do
			if vendor:GetDisplayName() == unlock.npc and ix.item.list[unlock.args[1]] then
				vendor:AddItemToList(unpack(unlock.args, 1, VENDOR_ARGUMENT_COUNT))
			end
		end
	end
end

function ix.progression.UnlockWorldNPC(progressionID)
	local definition = ix.progression.definitions[progressionID]
	if not definition or not definition.worldNPC then
		return
	end
	PLUGIN.worldUnlocks = PLUGIN.worldUnlocks or {}
	if PLUGIN.worldUnlocks[progressionID] then
		return
	end
	PLUGIN.worldUnlocks[progressionID] = true
	PLUGIN:SaveData()
	if PLUGIN.worldDataLoaded then
		PLUGIN:SetupProgressionWorld()
	end
end

-- World arrivals persist globally; service access remains character-owned.
function PLUGIN:SetupProgressionWorld()
	for progressionID, definition in pairs(ix.progression.definitions) do
		local spawn = definition.worldNPC
		local unlocked = self.worldUnlocks and self.worldUnlocks[progressionID]
		if spawn and unlocked and definition.progMap == game.GetMap() then
			local template = ix.npctemplates.templates[spawn.template]
			if template and not ix.progression.GetNPCFromName(template.name) then
				ix.util.SpawnAdvVendor(spawn.template, spawn.pos, spawn.ang)
			end
		end
	end

	for _, vendor in ipairs(ents.FindByClass("ix_vendor_adv")) do
		stockProgressionItems(vendor)
	end
end

ix.command.Add("ProgressionGrant", {
	adminOnly = true,
	arguments = { ix.type.character, ix.type.string },
	OnRun = function(self, client, character, progressionID)
		if not ix.progression.definitions[progressionID] then
			return "Unknown progression."
		end
		-- Grants restore access and NPC arrivals without replaying personal rewards.
		ix.progression.SetCompleted(character, progressionID)
		character:Save()

		return "Progression milestone granted."
	end,
})
