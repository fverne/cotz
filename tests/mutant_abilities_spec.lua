-- Run from the addon root: luatex --luaonly tests/mutant_abilities_spec.lua
local fixture = dofile("tests/helpers/mutant_base.lua")
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local base = fixture.LoadBase("sv_abilities")
local calls = {}
function base:RecordImpact(enemy, state)
	calls[#calls + 1] = {name = "impact", enemy = enemy, phase = state.phase}
end
function base:RecordRecovery(_, state)
	calls[#calls + 1] = {name = "recovery", phase = state.phase}
end
function base:OnlyPlayers(enemy) return enemy:IsPlayer() end

local ABILITIES = {
	{
		name = "slam",
		meleeRange = "inside",
		cooldown = 4,
		recovery = 1,
		phases = {
			{duration = 0.5, animation = "S_Slam"},
			{duration = 0.2, method = "RecordImpact"},
			{duration = 0.3, method = "RecordRecovery"},
		},
	},
	{
		name = "spit",
		meleeRange = "outside",
		minRange = 200,
		maxRange = 1000,
		canUse = "OnlyPlayers",
		chance = 0.5,
		cooldown = 6,
		initialCooldown = 2,
		phases = {{duration = 1, animation = "S_Spit"}, {duration = 1, method = "RecordImpact"}},
	},
	{
		name = "leap",
		cooldown = 3,
		triggerOnly = true,
		phases = {{duration = 0.1}, {duration = 0.2, untilGrounded = true, maxDuration = 2}},
	},
	{
		name = "guard",
		triggerOnly = true,
		interrupts = true,
		cancelOnTargetLoss = false,
		cooldown = 10,
		phases = {{duration = 1, animation = "S_Guard"}},
	},
}

local function newActor(abilities)
	local actor = fixture.Actor(base, {Abilities = abilities or ABILITIES})
	actor:STALKERNPCInitAbilities()

	return actor
end

local player = fixture.Target(Vector(500), {player = true})
local npc = fixture.Target(Vector(500))
local close = fixture.Target(Vector(40), {player = true})

do
	local broken = fixture.Actor(base, {Abilities = {{name = "a", phases = {}}}})
	broken:STALKERNPCInitAbilities()
	check(broken.Abilities == nil and #fixture.errors == 1, "invalid definitions disable abilities with one report")
	local duplicate = fixture.Actor(base, {Abilities = {
		{name = "a", phases = {{duration = 1}}}, {name = "a", phases = {{duration = 1}}},
	}})
	duplicate:STALKERNPCInitAbilities()
	check(duplicate.Abilities == nil and #fixture.errors == 2, "duplicate names are rejected")
end

do
	fixture.now = 100
	local actor = newActor()
	local originalRandom = math.random
	math.random = function() return 0 end
	check(not actor:STALKERNPCTryAbilities(player, 0), "initial cooldown holds ranged abilities after spawn")
	fixture.now = 102.1
	check(not actor:STALKERNPCTryAbilities(npc, 0), "canUse rejects ineligible targets")
	fixture.now = 102.2
	check(not actor:STALKERNPCTryAbilities(player, 0), "the selection check interval throttles retries")
	fixture.now = 102.4
	check(not actor:STALKERNPCTryAbilities(close, 0), "range limits reject targets that are too close")
	fixture.now = 102.7
	check(actor:STALKERNPCTryAbilities(player, 0) and actor.cotzAbility.definition.name == "spit",
		"an eligible ranged ability starts outside melee range")
	check(actor.Animation == "S_Spit" and actor.cotzAbilityReady.spit == 108.7, "start plays and sets the cooldown")
	math.random = function() return 0.9 end
	actor.cotzAbility, actor.PlayingAnimation = nil, false
	fixture.now = 110
	check(not actor:STALKERNPCTryAbilities(player, 0), "failed chance rolls start nothing")
	math.random = originalRandom
	actor.NextAbilityTime = 200
	fixture.now = 111
	check(not actor:STALKERNPCTryAbilities(close, 2), "shared recovery blocks every ability")
end

do
	fixture.now = 100
	calls = {}
	local actor = newActor()
	actor.enemy = close
	check(actor:STALKERNPCTryAbilities(close, 2) and actor.cotzAbility.definition.name == "slam",
		"melee-range abilities start inside melee range")
	fixture.now = 101.5
	actor:STALKERNPCUpdateAbility()
	check(#calls == 2 and calls[1].name == "impact" and calls[2].name == "recovery" and calls[1].enemy == close,
		"a late update runs every skipped phase in order")
	check(actor.cotzAbility == nil and actor.cleared == 1 and actor.stopped == 1,
		"finishing an animated ability clears the animation")
	check(actor.NextAbilityTime == 102.5, "recovery delays the next ability")
end

do
	fixture.now = 100
	local actor = newActor()
	actor.enemy = close
	actor:STALKERNPCTryAbilities(close, 2)
	actor.enemy = nil
	actor:STALKERNPCCancelAbilityWindup()
	check(actor.cotzAbility == nil and actor.cleared == 1, "target loss cancels an ability during its windup")
	calls = {}
	fixture.now = 110
	actor.enemy = close
	actor:STALKERNPCTryAbilities(close, 2)
	fixture.now = 110.6
	actor:STALKERNPCUpdateAbility()
	actor.enemy = nil
	actor:STALKERNPCCancelAbilityWindup()
	check(actor.cotzAbility ~= nil and #calls == 1, "target loss after the impact keeps the recovery")
	fixture.now = 111
	actor:STALKERNPCUpdateAbility()
	check(actor.cotzAbility == nil and calls[2].name == "recovery" and calls[1].enemy == close,
		"recovery still runs once the target is gone")
end

do
	fixture.now = 100
	local actor = newActor()
	check(actor:STALKERNPCTriggerAbility("leap"), "trigger-only abilities start on request")
	check(not actor:STALKERNPCTriggerAbility("leap"), "a running ability blocks a non-interrupting trigger")
	actor.grounded = false
	fixture.now = 100.5
	actor:STALKERNPCUpdateAbility()
	check(actor.cotzAbility and actor.cotzAbility.phase == 2, "landing phases wait while airborne")
	actor.grounded = true
	fixture.now = 100.6
	actor:STALKERNPCUpdateAbility()
	check(actor.cotzAbility == nil and not actor.cleared, "landing ends the phase; unanimated abilities skip clearing")
	actor:STALKERNPCTriggerAbility("leap")
	check(actor.cotzAbility == nil, "trigger-only abilities respect their cooldown")
	fixture.now = 104
	actor:STALKERNPCTriggerAbility("leap")
	actor.grounded = false
	fixture.now = 106.2
	actor:STALKERNPCUpdateAbility()
	check(actor.cotzAbility == nil, "a landing timeout ends phases for mutants that never touch down")
end

do
	fixture.now = 100
	local actor = newActor()
	actor.enemy = close
	actor:STALKERNPCTryAbilities(close, 2)
	actor.meleeAttackTimers = {{false, 0, function() end}}
	check(actor:STALKERNPCTriggerAbility("guard") and actor.cotzAbility.definition.name == "guard",
		"interrupting abilities replace the running ability")
	check(#actor.meleeAttackTimers == 0 and actor.Animation == "S_Guard", "interruptions drop pending melee hits")
	actor.enemy = nil
	actor:STALKERNPCCancelAbilityWindup()
	check(actor.cotzAbility ~= nil, "defensive abilities can opt out of target-loss cancellation")
	actor.IsAlive = false
	local cleared = actor.cleared
	actor:STALKERNPCFinishAbility(true)
	check(actor.cleared == cleared, "dead mutants do not replay animation cleanup")
	check(not actor:STALKERNPCTriggerAbility("guard"), "dead mutants cannot trigger abilities")
end

do
	local actor = newActor()
	local hidden = fixture.Target(Vector(100), {player = true, hidden = true})
	local dead = fixture.Target(Vector(100), {health = 0})
	local friend = fixture.Target(Vector(100), {friendly = true})
	local prop = fixture.Target(Vector(100), {IsPlayer = function() return false end, IsNPC = function() return false end})
	local visibleTarget = fixture.Target(Vector(100), {player = true})
	local found = {actor, hidden, dead, friend, prop, visibleTarget}
	ents = {FindInSphere = function() return found end}
	actor.STALKERNPCCanAttackThis = function(_, target) return not target.friendly end
	actor.Visible = function(_, target) return not target.hidden end
	check(actor:STALKERNPCAbilityPulse(300, 25, DMG_SONIC, true) == 1, "pulses use one query and skip invalid targets")
	check(visibleTarget.damage[1].Damage == 25 and visibleTarget.damage[1].Attacker == actor,
		"pulse damage is attributed to the mutant")
	check(actor:STALKERNPCAbilityPulse(300, 25, DMG_SONIC, false) == 2, "pulses can ignore line of sight")
end

do
	fixture.now = 100
	local actor = newActor({
		{
			name = "pounce", navigationLeap = "short", cooldown = 2, linkedCooldowns = {roar = 5},
			phases = {
				{duration = 0.1},
				{duration = 0, leap = "short", melee = 4, sound = "Pounce", untilAnimationDone = true, maxDuration = 2},
			},
		},
		{name = "roar", navigationLeap = "long", phases = {{duration = 1, animation = "S_Roar", attackIndex = 0}}},
	})
	actor.MeleeAttackSequence = {[4] = "S_Pounce"}
	actor.enemy = close
	check(actor:STALKERNPCNavigationLeapAbility(true).name == "pounce"
		and actor:STALKERNPCNavigationLeapAbility(false).name == "roar", "navigation finds short and long leaps")
	actor.cotzUnreachableRecovery = {}
	check(not actor:STALKERNPCTryAbilities(close, 0), "leaps wait for navigation during unreachable recovery")
	actor.cotzUnreachableRecovery = nil
	actor.cotzNextAbilityCheck = 0
	check(actor:STALKERNPCTryAbilities(close, 0), "leaps start normally outside recovery")
	check(actor.cotzAbilityReady.roar == 105, "linked cooldowns delay related abilities")
	fixture.now = 100.2
	actor:STALKERNPCUpdateAbility()
	check(actor.velocities[1].x == 1 and actor.Animation == "S_Pounce" and actor.AttackIndex == 4
		and actor.meleeAttacks[1] == 4 and actor.sounds[1] == "Pounce", "leap phases jump, swing and sound together")
	fixture.now = 101
	actor:STALKERNPCUpdateAbility()
	check(actor.cotzAbility ~= nil, "the phase waits for the melee animation to finish")
	actor.PlayingAnimation = false
	fixture.now = 101.1
	actor:STALKERNPCUpdateAbility()
	check(actor.cotzAbility == nil, "the phase ends once the animation finishes")
	actor.enemy = nil
	fixture.now = 110
	actor:STALKERNPCTriggerAbility("roar")
	check(actor.AttackIndex == 0, "phases can play animations without turning towards the target")
	actor.cotzAbility, actor.PlayingAnimation = nil, false
	actor:STALKERNPCStartAbility(actor.cotzAbilityByName.pounce, nil)
	fixture.now = 110.2
	actor:STALKERNPCUpdateAbility()
	check(#actor.velocities == 1, "leaps without a target do not launch")
end

do
	fixture.now = 100
	local finished = {}
	base.Hold = function(_, state) return state.holding end
	base.Release = function(_, state, cancelled) finished[#finished + 1] = cancelled end
	local actor = newActor({
		{
			name = "grab", triggerOnly = true, uninterruptible = true, validate = "Hold", onFinish = "Release",
			phases = {{duration = 5, animation = "S_Grab"}},
		},
		{name = "flinch", triggerOnly = true, interrupts = true, phases = {{duration = 1}}},
	})
	actor:STALKERNPCTriggerAbility("grab")
	actor.cotzAbility.holding = true
	check(not actor:STALKERNPCTriggerAbility("flinch"), "uninterruptible abilities block interruptions")
	actor:STALKERNPCUpdateAbility()
	check(actor.cotzAbility ~= nil, "a passing validation keeps the ability")
	actor.cotzAbility.holding = false
	actor:STALKERNPCUpdateAbility()
	check(actor.cotzAbility == nil and finished[1] == true and actor.cleared == 1,
		"failed validation cancels and cleans up")
	fixture.now = 200
	actor:STALKERNPCTriggerAbility("grab")
	local cleared = actor.cleared
	actor:STALKERNPCAbandonAbility()
	check(actor.cotzAbility == nil and finished[2] == true and actor.cleared == cleared,
		"abandoning releases held state without animation work")
	actor:STALKERNPCAbandonAbility()
	check(#finished == 2, "abandoning twice is harmless")

	local broken = fixture.Actor(base, {Abilities = {
		{name = "a", linkedCooldowns = {missing = 1}, phases = {{duration = 1}}},
	}})
	local errors = #fixture.errors
	broken:STALKERNPCInitAbilities()
	check(broken.Abilities == nil and #fixture.errors == errors + 1, "unknown linked cooldowns are rejected")
end

do
	local effects = 0
	EffectData = function() return setmetatable({}, {__index = function() return function() end end}) end
	util = {Effect = function() effects = effects + 1 end}
	local actor = newActor()
	local near = fixture.Target(Vector(128), {NearestPoint = function(self) return self.position end})
	local edge = fixture.Target(Vector(600), {NearestPoint = function(self) return self.position end})
	ents = {FindInSphere = function() return {actor, near, edge} end}
	actor:STALKERNPCAbilityGroundSlam(512, 40, 1)
	check(effects == 1 and near.damage[1].Damage == 30 and #edge.damage == 0,
		"ground slams fall off with distance and skip entities beyond the radius")
end

print("mutant ability checks passed: " .. checks)
