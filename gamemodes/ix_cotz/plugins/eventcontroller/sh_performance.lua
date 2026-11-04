ix.config.Add("mutantSpawnBudget", 2, "Queued mutant spawns per tick.", nil, {
	category = "Performance",
	data = {min = 1, max = 32, decimals = 0},
})

ix.config.Add("mutantSleep", true, "Sleep inactive distant STALKER mutants.", nil, {
	category = "Performance",
})

ix.config.Add("mutantWakeRange", 5000, "Mutant wake distance.", nil, {
	category = "Performance",
	data = {min = 1500, max = 20000, decimals = 0},
})

ix.config.Add("mutantSleepRange", 6000, "Mutant sleep distance.", nil, {
	category = "Performance",
	data = {min = 1500, max = 24000, decimals = 0},
})

ix.config.Add("mutantIdleInterval", 0.1, "Idle Lua Think interval.", nil, {
	category = "Performance",
	data = {min = 0, max = 1, decimals = 2},
})

ix.config.Add("mutantSearchBudget", 4, "Enemy searches per server tick.", nil, {
	category = "Performance",
	data = {min = 1, max = 128, decimals = 0},
})

ix.config.Add("mutantCorpseLimit", 64, "Distant corpse soft cap; 0 disables.", nil, {
	category = "Performance",
	data = {min = 0, max = 512, decimals = 0},
})

ix.config.Add("mutantCorpseLifetime", 180, "Mutant corpse lifetime in seconds.", nil, {
	category = "Performance",
	data = {min = 30, max = 1800, decimals = 0},
})

ix.util.Include("sv_performance.lua")
