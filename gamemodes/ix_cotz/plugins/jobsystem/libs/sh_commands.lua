local PLUGIN = PLUGIN

ix.command.Add("CharResetJobs", {
	adminOnly = true,
	arguments = {ix.type.character},
	OnRun = function(self, client, character)
		return PLUGIN:RunCommandCharResetJobs(client, character)
	end,
})
