local PLUGIN = PLUGIN

PLUGIN.name = "Mutant Defense"
PLUGIN.author = "verne"
PLUGIN.description = "Admin-started mutant waves with personal vendor restock vouchers."

ix.mutantDefense = PLUGIN

PLUGIN.settings = {
	preparation = 30,
	waveBreak = 10,
	defendRadius = 1500,
	timeout = 600,
	abandonGrace = 30,
	scalingCap = 8,
	spawnMinimum = 1000,
	spawnMaximum = 2000,
	playerSafeDistance = 256,
	spawnBudget = 2,
	placementAttempts = 8,
	updateInterval = 1,
	actionInterval = 1,
	useDistance = 192,
	waves = {
		{{class = "npc_mutant_dog", base = 2, perDefender = 1}},
		{{class = "npc_mutant_boar", base = 1, perDefender = 1}},
		{{class = "npc_mutant_dog", base = 2, perDefender = 1},
			{class = "npc_mutant_pseudodog", base = 0, perDefender = 0.5}},
	},
}

ix.util.Include("sv_event.lua")
ix.util.Include("sv_rewards.lua")

ix.command.Add("MutantDefenseStart", {
	description = "Start mutant defense at your crosshair.",
	adminOnly = true,
	arguments = {},
	OnRun = function(_, client)
		local trace = client:GetEyeTraceNoCursor()
		if not trace.Hit or trace.HitSky then return "Aim at clear ground to place the defense." end

		return PLUGIN:StartDefense(trace.HitPos)
	end,
})

ix.command.Add("MutantDefenseCancel", {
	description = "Cancel the active mutant defense without rewards.",
	adminOnly = true,
	arguments = {},
	OnRun = function()
		if not PLUGIN.event then return "No mutant defense is active." end
		PLUGIN:EndDefense("Mutant defense cancelled. No vouchers awarded.")

		return "Mutant defense cancelled."
	end,
})

ix.command.Add("MutantDefenseStatus", {
	description = "Show the active mutant defense location and attackers remaining.",
	adminOnly = true,
	arguments = {},
	OnRun = function()
		local event = PLUGIN.event
		if not event then return "No mutant defense is active." end

		return string.format("Mutant defense: %s, wave %d/%d, %d attackers remaining, center %s, radius %d.",
			event.phase, event.wave, #PLUGIN.settings.waves, PLUGIN:RemainingAttackers(),
			tostring(event.center), PLUGIN.settings.defendRadius)
	end,
})
