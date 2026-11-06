local PLUGIN = PLUGIN

ix.command.Add("ProgressionGrant", {
	adminOnly = true,
	arguments = { ix.type.character, ix.type.string },
	OnRun = function(self, client, character, progressionID)
		return PLUGIN:RunCommandProgressionGrant(client, character, progressionID)
	end,
})

ix.command.Add("ProgressionAudit", {
	adminOnly = true,
	OnRun = function()
		return PLUGIN:RunCommandProgressionAudit()
	end,
})
