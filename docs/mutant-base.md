# Mutant base

`lua/entities/stalker_ai/` is the shared base for every `npc_mutant_*` entity. Concrete mutants keep
their models, melee tables, sounds and tuning in their own `init.lua`. The base supplies combat, the
COTZ population and sleep integration, navigation recovery, and two opt-in systems: declarative
abilities and flight. `cotz_human_base` reuses only `sv_performance.lua`.

| File | Realm | Owns |
| --- | --- | --- |
| `init.lua` | server | Initialisation, Think, melee, damage, death. Includes the other server files. |
| `sv_abilities.lua` | server | The `ENT.Abilities` runner and shared ability effects. |
| `sv_flight.lua` | server | `ENT.MovementMode = "fly"` steering. |
| `sv_navigation.lua`, `schedules.lua` | server | Ground navigation, stranded recovery, schedules. |
| `sv_performance.lua` | server | Sleep, think intervals and enemy-search budgets. |
| `cl_init.lua` | client | Drawing. Mutants draw once, in the translucent pass. |

## Abilities

List special attacks in `ENT.Abilities` instead of writing a state machine in `STALKERNPCThink`.
The base selects one while the enemy is visible and the mutant is free, and advances its phases from Think
by timestamp comparison. Abilities create no timers, and selection runs at most every
`ENT.AbilityCheckInterval` seconds (0.2 by default), using one squared distance check.

```lua
ENT.Abilities = {
	{
		name = "blast",              -- unique per class; also the cooldown key
		meleeRange = "outside",      -- "outside", "inside" or nil for either
		minRange = 200,              -- optional distance limits to the enemy, in units
		maxRange = 1500,
		chance = 0.5,                -- optional roll per selection check
		canUse = "BurerCanBlast",    -- optional method(enemy, ability) returning true to allow
		cooldown = 5,                -- seconds before this ability can start again
		initialCooldown = 1,         -- seconds after spawn
		recovery = 0.5,              -- delay before any ability, via ENT.NextAbilityTime
		phases = {
			{duration = 0.9, animation = "S_Power_Attack"},
			{duration = 1.3, method = "BurerBlast"},
		},
	},
}
```

Each phase lasts `duration` seconds, or a random duration within `{min, max}`. When it starts, it does
the following, in order, each step optional:

- `leap = "long"` or `"short"` launches the mutant at its enemy with the navigation leap ballistics
  (`navigationLeapAimHeight`/`Speed`, or their `Short` variants). Without an enemy it does not launch.
- `melee = index` plays that melee table's sequence and schedules its hits, like a normal melee attack.
  Otherwise `animation` plays a sequence. `attackIndex = 0` stops the mutant from turning towards its
  target during the animation, matching attacks that originally passed no index.
- `sound` is emitted from the mutant.
- `method(enemy, state)` is called. The enemy is the current valid enemy or `nil`, so methods must
  handle a lost target. `state` is per-use scratch space, for example a held victim.

When the last phase ends the base clears any animation the ability played and applies `recovery`.
A late Think runs every skipped phase in order.

Other fields:

- `cancelOnTargetLoss = false` keeps the first phase running when the enemy is lost. By default the
  first phase is a cancellable windup. Put the impact in the second phase or later.
- `triggerOnly = true` excludes the ability from automatic selection. Start it with
  `self:STALKERNPCTriggerAbility(name)`, for example from `STALKERNPCDamageTake`. Cooldowns still apply.
- `interrupts = true` lets a triggered ability replace a running ability or animation, including pending
  melee hits.
- `ownsMovement = true` stops flight steering from overriding velocity the ability sets itself.
- `uninterruptible = true` stops interrupting abilities from replacing this one.
- `linkedCooldowns = {other = seconds}` delays other named abilities when this one starts, for attacks
  that originally shared a cooldown.
- `navigationLeap = "long"` or `"short"` marks the leap navigation recovery may start after checking the
  arc. Automatic selection skips these leaps during unreachable-target recovery, which starts them itself.
- `validate = "Method"` receives `(state)` on each update. Returning false cancels the ability.
- A phase with `untilGrounded = true` waits for landing after its duration, and one with
  `untilAnimationDone = true` waits for the current animation to finish. Either wait is capped at
  `maxDuration` from the phase start (3 seconds by default).
- `onFinish = "Method"` receives `(state, cancelled)`. It also runs when death, removal or sleep abandon
  the ability, so release anything the ability holds, such as a frozen player, there.

Shared effects for ability methods:

- `self:STALKERNPCAbilityLaunchProjectile(class, enemy, speed, offset)` spawns an owned projectile
  aimed at the enemy's center. `offset` is local to the mutant (forward, right, up).
- `self:STALKERNPCAbilityPulse(radius, damage, damageType, requireVisible)` damages living players and
  NPCs this mutant may attack, using one sphere query.
- `self:STALKERNPCAbilityGroundSlam(radius, damage, damageType)` raises dust and damages every entity in
  range with linear falloff, like the original landing shockwaves.
- `self:STALKERNPCAbilityDust()` plays the landing dust effect alone.
- `self:STALKERNPCAbilityLeap(enemy, aimHeight, speedScale)` leaps with explicit ballistics, for mutants
  without navigation leap fields. Pair it with an `untilGrounded` phase.
- `self:STALKERNPCSpawnSummon(class, offset)` (`sv_summoning.lua`) respects the COTZ spawn budget.

Invalid definitions are reported once per class and disable abilities for those mutants instead of
erroring every tick. While an ability runs, the mutant counts as busy for navigation, combat scheduling
and sleep. Death, removal and sleep abandon it.

These mutants use the system:

| Mutant | Abilities |
| --- | --- |
| Burer | Stamina drain, gravity blast, damage-triggered shield. |
| Snork, vareshka | Long and short leaps; the vareshka's long leap lands with a shockwave. |
| Bloodsucker | Lunge; feeding that freezes players, heals and then flees. |
| Pseudogiant (fast) | Short leap; big jump with a landing shockwave. |
| Pseudogiant (slow) | Ground kick that throws nearby entities. |
| Karlik | Damage-triggered teleport, queued knockback, single and double throws. |
| Controllers (all four) | Psy attack: damage, lightning or a projectile, by variant. |
| Psydog, phantom | Pounce; the psydog also summons phantoms into empty slots. |

Other mutants still use their original state machines and the fields listed in `BUSY_FIELDS` and the
event controller's `TARGET_ABILITIES`. Keep those lists until no mutant uses a field. Migrate mutants
one at a time, alongside a spec.

Migrated mutants keep their original timings, damage and cooldowns, with these deliberate differences:

- Random rolls run per ability check (every 0.2 seconds) instead of every tick, so chances were raised
  to keep attacks prompt.
- Short leaps (snork, vareshka, psydog, phantom) end when their swing finishes. They previously kept the
  mutant busy for five seconds, which stopped it from re-pathing.
- Leap, slow pseudogiant kick and burer blast windups are cancelled when the target is lost, as the
  base did for older leaps. Throws, controller psy attacks, the karlik knockback and teleport, feeding
  and summons keep running, as before.
- The psydog waits for its current attack to end before summoning, instead of overriding it.
- A player the bloodsucker is feeding on is released when it dies. Previously the player stayed frozen
  until the corpse entity was removed.

## Flight

Set `ENT.MovementMode = "fly"` before the class initialises. COTZ maps have no air nodegraph, so
flyers do not run engine schedules or ground navigation. Instead, Think steers them with one hull trace per
update, every 0.15 seconds in combat and 0.5 seconds otherwise. They slide along obstacles, climb over
blocking walls when there is space above, and stop when fully blocked.

| Field | Default | Meaning |
| --- | --- | --- |
| `FlightSpeed` | 250 | Maximum speed in units per second. |
| `FlightCruiseHeight` | 96 | Height kept above distant targets. |
| `FlightCruiseRange` | 400 | Distance at which the flyer descends to the target's height. |
| `FlightHoldDistance` | melee reach | Center distance at which it stops closing in. Raise it for ranged flyers. |
| `FlightWanderRadius`, `FlightWanderHeight`, `FlightWanderInterval` | 256, {16, 96}, 4 | Idle wandering around the spawn point. |
| `FlightMoveSequence`, `FlightIdleSequence` | `IdleSequence` | Sequences while moving and hovering. |

Flyers pursue a visible enemy, then COTZ's last observed player position, the engine's last known
position, a combat approach point or objective, and otherwise wander. They stop moving during attack
animations and abilities. They sleep in the air under the normal population manager. Melee requires the
target's height to overlap the flyer's hull, so melee flyers descend to the target's center.

## Checks

`tests/mutant_abilities_spec.lua`, `tests/mutant_flight_spec.lua`, `tests/burer_stamina_spec.lua` and
`tests/mutant_complex_abilities_spec.lua` cover the runner, steering and the migrated mutants;
`tests/mutant_navigation_spec.lua` covers navigation-started leaps. They use mocks; verify in a
multiplayer session:

1. Burer: stamina drain, blast and shield play their animations, and the shield absorbs damage. A
   lost target cancels the blast windup.
2. Each migrated mutant: leaps land and swing, shockwaves hit nearby players, feeding freezes and
   releases (including when the bloodsucker is killed mid-feed), the karlik teleports and knocks back,
   controller psy attacks hit visible targets, and psydogs replace lost phantoms. Strand a leaping mutant
   below a ledge to check navigation-started leaps.
3. A test flyer (any mutant with `MovementMode = "fly"`) takes off, pursues around corners and over
   walls, holds for melee, follows a hidden player to the last seen position, sleeps and wakes.
4. Mutants with translucent effects draw correctly: the bloodsucker's cloak, the burer's shield and
   controller psy images. Compare client frame time near a mutant group with the previous version.
