-- Sources read existing plugin data. Pools can include sources and other pools.
ix.jobs.field.sources = {
	stash = {plugin = "hidestashspawner", key = "stashspawnpoints"},
	event = {plugin = "eventcontroller", key = "eventpoints"},
	anomaly = {plugin = "anomalycontroller", key = "anomalypoints"},
	radiation = {plugin = "radiationcontroller", key = "radiationpoints"},
}

ix.jobs.field.pools = {
	gas = {"anomaly", "radiation"},
	rf = {"event"},
	packages = {"stash"},
}

ix.jobs.field.settings = {
	courier = {cargo = "town_quest_drive"},
	recovery = {sources = {"packages", "rf"}, cargo = "job_recovery_case", searchRadius = 384},
	sensor = {sources = {"gas", "rf"}, cargo = "job_sensor_recorder", recordSeconds = 120,
		leaveDistance = 512, deployDistance = 512},
	triangulation = {sources = {"rf", "packages"}, cargo = "job_signal_transmitter",
		readingCount = 3, readingDistance = 512, bearingAngle = 15},
	deadDrop = {sources = {"packages", "rf"}, destinationSources = {"packages", "rf"},
		cargo = "job_dead_drop_parcel", minRouteDistance = 2048},
	defence = {
		sources = {"rf"}, attackSources = {"rf"}, cargo = "job_research_results",
		minAttackDistance = 512, maxAttackDistance = 4096, maxHeightDifference = 256, maxSpawnPoints = 8,
		defendDistance = 768, duration = 90, samplerHealth = 250, threatRadius = 160, threatDamage = 8,
		waveInterval = 10, attemptTimeout = 300, retryDelay = 30, playerSafeDistance = 256,
		waves = {
			{{classes = {"npc_mutant_dog"}, count = 2},
				{classes = {"npc_mutant_dog", "npc_mutant_pseudodog"}, count = 2}},
			{{classes = {"npc_mutant_dog", "npc_mutant_pseudodog"}, count = 3},
				{classes = {"npc_mutant_snork"}, count = 2},
				{classes = {"npc_mutant_pseudodog", "npc_mutant_snork"}, count = 3}},
			{{classes = {"npc_mutant_snork"}, count = 3},
				{classes = {"npc_mutant_bloodsucker"}, count = 2},
				{classes = {"npc_mutant_snork", "npc_mutant_bloodsucker"}, count = 3}},
		},
	},
}

ix.jobs.field.spawnDistance = 1024
ix.jobs.field.despawnDistance = 1536
ix.jobs.field.useDistance = 128
ix.jobs.field.actionInterval = 1
ix.jobs.field.updateInterval = 1
ix.jobs.field.maxDefences = 3
ix.jobs.field.defenceSpawnBudget = 2

ix.jobs.field.runtimeSettings = {
	groundUp = 32,
	groundDown = 96,
	groundClearance = 2,
	groundOffset = 32,
	minimumGroundNormal = 0.5,
	deployForwardDistance = 48,
	blockedNotifyInterval = 30,
	pickupTimeout = 30,
	markerSeconds = 30,
}
