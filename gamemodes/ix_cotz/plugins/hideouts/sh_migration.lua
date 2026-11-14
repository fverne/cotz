local PLUGIN = PLUGIN

ix.command.Add("HideoutMigrationOffer", {
	adminOnly = true,
	arguments = {ix.type.string, ix.type.string},
	OnRun = function(self, client, sourceTemplate, pilotID)
		if not SERVER then return end
		local _, message = PLUGIN:ConfigurePersonalMigration(client, sourceTemplate, pilotID)

		return message
	end,
})

ix.command.Add("HideoutMigratePreview", {
	adminOnly = true,
	arguments = {ix.type.string, ix.type.string},
	OnRun = function(self, client, sourceTemplate, pilotID)
		if not SERVER then return end
		local _, message = PLUGIN:PreviewTemplateMigration(client, sourceTemplate, pilotID)

		return message
	end,
})

ix.command.Add("HideoutMigrateApply", {
	adminOnly = true,
	arguments = {ix.type.string},
	OnRun = function(self, client, token)
		if not SERVER then return end
		local _, message = PLUGIN:ApplyTemplateMigration(client, token)

		return message
	end,
})

ix.command.Add("HideoutMigrateRollback", {
	adminOnly = true,
	arguments = {ix.type.string},
	OnRun = function(self, client, token)
		if not SERVER then return end
		local _, message = PLUGIN:RollbackTemplateMigration(client, token)

		return message
	end,
})
