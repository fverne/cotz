PLUGIN.name = "Spawn Point ESP"
PLUGIN.author = "COTZ"
PLUGIN.description = "Admin-only observer overlays for configured spawn points."

PLUGIN.spawnCategories = {
	{key = "anomalies", name = "Anomalies", plugin = "anomalycontroller", field = "anomalypoints", mapIndexed = true},
	{key = "boxes", name = "Loot Boxes", plugin = "boxspawner", field = "boxpoints"},
	{key = "mutants", name = "Mutants", plugin = "eventcontroller", field = "eventpoints", mapIndexed = true},
	{key = "events", name = "Advanced Events", plugin = "eventcontrolleradv", field = "eventpoints"},
	{key = "stashes", name = "Hidden Stashes", plugin = "hidestashspawner", field = "stashspawnpoints", mapIndexed = true},
	{key = "radiation", name = "Radiation", plugin = "radiationcontroller", field = "radiationpoints"},
	{key = "travel", name = "Travel Exits", plugin = "simplecrossserver", field = "loadpoints"},
	{key = "items", name = "World Items", plugin = "worlditemspawner", field = "itempoints"},
	{key = "players", name = "Faction/Class Spawns"},
	{key = "arrivals", name = "Travel Arrivals"},
	{key = "containers", name = "Loot Containers"},
	{key = "cyclic", name = "Cyclic Containers"},
	{key = "checkpoints", name = "Spawn Checkpoints"},
}

ix.util.Include("sv_plugin.lua")
ix.util.Include("cl_plugin.lua")
