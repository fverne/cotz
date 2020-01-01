PLUGIN.name = "Temporary Blowout Control"
PLUGIN.author = "some faggot"
PLUGIN.desc = "Lets you control the blowout addon from helix."

ix.command.Add("blowouttriggerinstant", {
	adminOnly = true,
	OnRun = function(client, arguments)
		RunConsoleCommand( "blowout_trigger_instant" )
	end
})

ix.command.Add("blowouttriggerdelayed", {
	adminOnly = true,
	arguments = ix.type.number,
	OnRun = function(self, client, delay)
		RunConsoleCommand( "blowout_trigger_delayed", delay )
	end
})