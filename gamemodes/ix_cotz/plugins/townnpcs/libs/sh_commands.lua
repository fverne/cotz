local PLUGIN = PLUGIN

ix.command.Add("TownNPCPreview", {
	adminOnly = true,
	description = "Preview a town contact or advanced-vendor template playing an animation, without saving it.",
	arguments = {ix.type.string, bit.bor(ix.type.string, ix.type.optional)},
	argumentNames = {"contact or template", "sequence"},
	OnRun = function(_, client, template, sequence)
		return PLUGIN:RunCommandTownNPCPreview(client, template, sequence)
	end,
})

ix.command.Add("TownNPCGetSpawnPoint", {
	adminOnly = true,
	description = "Print the aimed-at advanced vendor's current position, facing and animation to your console.",
	OnRun = function(_, client)
		return PLUGIN:RunCommandTownNPCGetSpawnPoint(client)
	end,
})

ix.command.Add("TownNPCClearSpawnPoints", {
	adminOnly = true,
	arguments = {ix.type.string},
	OnRun = function(_, client, id)
		return PLUGIN:RunCommandTownNPCClearSpawnPoints(client, id)
	end,
})

ix.command.Add("TownNPCExportSpawnPoints", {
	adminOnly = true,
	OnRun = function(_, client)
		return PLUGIN:RunCommandTownNPCExportSpawnPoints(client)
	end,
})

ix.command.Add("TownNPCAddFieldPoint", {
	adminOnly = true,
	arguments = {ix.type.string},
	OnRun = function(self, client, kind)
		return PLUGIN:RunCommandTownNPCAddFieldPoint(client, kind)
	end,
})

ix.command.Add("TownNPCRemoveFieldPoint", {
	adminOnly = true,
	arguments = {ix.type.string},
	OnRun = function(self, client, kind)
		return PLUGIN:RunCommandTownNPCRemoveFieldPoint(client, kind)
	end,
})

ix.command.Add("TownNPCPlace", {
	adminOnly = true,
	arguments = {ix.type.string},
	OnRun = function(self, client, id)
		return PLUGIN:RunCommandTownNPCPlace(client, id)
	end,
})

ix.command.Add("TownNPCExportFieldPoints", {
	adminOnly = true,
	OnRun = function(self, client)
		return PLUGIN:RunCommandTownNPCExportFieldPoints(client)
	end,
})
