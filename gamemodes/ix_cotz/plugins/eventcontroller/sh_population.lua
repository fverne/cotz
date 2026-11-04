ix.config.Add("eventControllerThreshold", 70, "Default routine live-plus-queued mutant target.", nil, {
	data = {min = 0, max = 2048, decimals = 0},
	category = "Spawning",
})

ix.config.Add("mutantLimit", 128, "Default live mutant cap for maps without an override; 0 disables.", nil, {
	category = "Spawning",
	data = {min = 0, max = 2048, decimals = 0},
})

ix.config.Add("mutantRegionLimit", 32, "Default regional mutant cap for maps without an override; 0 disables.", nil, {
	category = "Spawning",
	data = {min = 0, max = 512, decimals = 0},
})

ix.config.Add("mutantRegionRange", 4096, "Radius for the regional cap.", nil, {
	category = "Spawning",
	data = {min = 512, max = 20000, decimals = 0},
})

local MAPS = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"}

-- Register the same map keys on every server because Helix config is shared.
for _, mapName in ipairs(MAPS) do
	ix.config.Add("mutantLimit_" .. mapName, -1, "Map mutant cap: -1 inherits the default; 0 disables the cap.", nil, {
		category = "Spawning: " .. mapName,
		data = {min = -1, max = 2048, decimals = 0},
	})

	ix.config.Add("mutantRegionLimit_" .. mapName, -1,
		"Map regional mutant cap: -1 inherits the default; 0 disables the cap.", nil, {
			category = "Spawning: " .. mapName,
			data = {min = -1, max = 512, decimals = 0},
		})

	ix.config.Add("eventControllerThreshold_" .. mapName, -1,
		"Map routine mutant target: -1 inherits the shared event controller target; 0 stops routine mutants.", nil, {
			category = "Spawning: " .. mapName,
			data = {min = -1, max = 2048, decimals = 0},
		})
end

ix.command.Add("PopulationStatus", {
	description = "Show current map population policy, live/sleeping mutants and queued requests.",
	adminOnly = true,
	OnRun = function(self, client)
		if not ix.eventController then return "Event controller population policy is unavailable." end

		return ix.eventController:GetPopulationStatus()
	end,
})

ix.util.Include("sh_performance.lua")
ix.util.Include("sv_population.lua")
