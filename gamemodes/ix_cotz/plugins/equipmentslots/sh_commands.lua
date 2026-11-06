local PLUGIN = PLUGIN

ix.command.Add("CharTakeInventory", {
	description = "View a character's inventory and take items into your own backpack.",
	adminOnly = true,
	arguments = {ix.type.character},
	OnRun = function(self, client, character)
		return PLUGIN:RunCommandCharTakeInventory(client, character)
	end,
})
