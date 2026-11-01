PLUGIN.settings = {
	-- OnInstanced yields; quantity is otherwise the item capacity, not its spawned yield.
	spawnBatches = {
		value_nuts = {3, 8},
		value_bolts = {4, 8},
		value_battery = {1, 6},
		value_9vbattery = {2, 3},
		value_capacitors = {2, 3},
		value_sparkplug = {1, 2},
		value_pcpart_cpu = {1, 2},
		value_pcpart_ram = {1, 2},
		value_screws = {1, 2},
		value_gasoline = {2, 3},
		value_propanetank = {2, 3},
	},
	jobRewards = {
		easy = {money = 2500, reputation = 15},
		medium = {money = 5000, reputation = 30},
		hard = {money = 7500, reputation = 45},
	},
	supplyStock = {initial = 2, maximum = 2, interval = 12, amount = 1},
	interactionDistance = 192,
	actionInterval = 0.25,
	arenaOpponentLimit = 60,
}
