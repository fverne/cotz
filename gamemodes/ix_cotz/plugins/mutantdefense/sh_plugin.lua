local PLUGIN = PLUGIN

PLUGIN.name = "Mutant Defense"
PLUGIN.author = "verne"
PLUGIN.description = "Scheduled Supply-truck mutant defenses with personal vendor trader supplys."

ix.mutantDefense = PLUGIN

PLUGIN.settings = {
	automationEnabled = true,
	intervalMinimum = 1800,
	intervalMaximum = 3600,
	warning = 600,
	retry = 60,
	dupeName = "event_mutantdefense_supplyvan",
	dupeOffset = Vector(0, 0, 0),
	waveBreak = 10,
	defendRadius = 1500,
	timeout = 600,
	abandonGrace = 30,
	scalingCap = 8,
	playerSafeDistance = 256,
	spawnBudget = 2,
	updateInterval = 1,
	voucherReward = 1000,
	actionInterval = 1,
	useDistance = 192,
	waves = {
		{{class = "npc_mutant_dog", base = 2, perDefender = 1}},
		{{class = "npc_mutant_boar", base = 1, perDefender = 1}},
		{{class = "npc_mutant_dog", base = 2, perDefender = 1},
			{class = "npc_mutant_pseudodog", base = 0, perDefender = 0.5}},
	},
}

ix.util.Include("sh_announcement.lua")
ix.util.Include("sv_automation.lua")
ix.util.Include("sv_event.lua")
ix.util.Include("sv_rewards.lua")

ix.command.Add("MutantDefenseStart", {
	description = "Place a supply truck at a research-defense site and begin its warning countdown.",
	adminOnly = true,
	arguments = {},
	OnRun = function()
		local message = PLUGIN:StartDefense()

		return message
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
		if not event then
			if not PLUGIN.enabled or not PLUGIN.settings.automationEnabled then
				return "No mutant defense is active. Automatic scheduling is disabled."
			end

			return string.format("No mutant defense is active. Next attempt in %d seconds. Last start blocked: %s.",
				math.max(0, math.ceil((PLUGIN.nextDefense or CurTime()) - CurTime())),
				PLUGIN.lastStartError or "none")
		end
		local pending = 0
		for _, slot in ipairs(event.slots) do
			if not slot.killed and not IsValid(slot.entity) then pending = pending + 1 end
		end
		local _, living = PLUGIN:GetDefenders()

		local countdown = event.phase == "deploying" and event.deployDeadline or event.nextWave

		return string.format("Mutant defense at %s: %s, countdown %d seconds, dupe %s, wave %d/%d, %d attackers remaining (%d awaiting spawn), %d living defenders, center %s, radius %d. Spawn blocked: %s.",
			event.location, event.phase, math.max(0, math.ceil((countdown or CurTime()) - CurTime())),
			event.dupeID, event.wave, #PLUGIN.settings.waves, PLUGIN:RemainingAttackers(), pending, #living,
			tostring(event.center), PLUGIN.settings.defendRadius, event.spawnBlocked or "none")
	end,
})
