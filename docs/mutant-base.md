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
  Adding `animation` plays that sequence instead, keeping the table's hits. Without `melee`, `animation`
  plays a sequence. `attackIndex = 0` stops the mutant from turning towards its
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

- `self:STALKERNPCAbilityPlaySequence(state, sequence, duration)` plays a sequence chosen at runtime and
  sets how long the current phase lasts. Call it from a `duration = 0` phase method, as the fake deaths and
  the spider's burrow do. The mutant does not turn during it.
- `self:STALKERNPCAbilityLaunchProjectile(class, enemy, speed, offset)` spawns an owned projectile
  aimed ahead of the enemy (see [leading shots](#leading-shots)). `offset` is local to the mutant
  (forward, right, up).
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
| Chimeras (all three) | Long leap. |
| Classic zombies (all four) | Damage-triggered fake death. |
| Dog, pseudodog | Pounce. |
| Hellhound | Flame spew. |
| Bear, cat, rodent, tark, sprig | Short leap. |
| Skeleton | Damage-triggered fake death; draining grab. |
| Izlom | Pull; grab and throw. |
| Spider | Leap while healthy, web spit while wounded; damage-triggered burrow teleport. |

Boar and flesh have no special attacks and need no abilities. The sprig's ambush pose is an idle state
outside the runner. Continuous effects such as auras, self-ignition and the electric chimera's blast also
stay in their own methods, because they run alongside attacks.

Navigation, combat targeting and sleep read only `PlayingAnimation` and `cotzAbility` to decide whether a
mutant is busy, so write any new special attack as an ability. Navigation recovery leaps only with a
`navigationLeap` ability.

Migrated mutants keep their original timings, damage and cooldowns, with these deliberate differences:

- Random rolls run per ability check (every 0.2 seconds) instead of every tick, so chances were raised
  to keep attacks prompt.
- Short leaps (snork, vareshka, psydog, phantom) end when their swing finishes. They previously kept the
  mutant busy for five seconds, which stopped it from re-pathing.
- The chimera, bear, cat, rodent, pseudodog, sprig and spider leaps end once the mutant has landed and its
  swing has finished. Their old hold times (three seconds for the sprig, five for the rest) are now the
  upper limit, so the three-second cooldown decides when they can leap again.
- Dog and tark leaps still last at least a second and wait for landing. The wait is now capped, five
  seconds after the launch, instead of unlimited.
- Leap, slow pseudogiant kick, burer blast, hellhound spew and izlom pull windups are cancelled when the
  target is lost, as the base did for older leaps. Throws, controller psy attacks, the karlik knockback and
  teleport, feeding, summons, grabs, spits, fake deaths and the spider teleport keep running, as before.
- Fake deaths and the spider teleport wait for any running ability, not only a running animation. For
  example, a skeleton finishes its grab before collapsing. The izlom cannot start a grab during its pull
  windup, and waits out the pull's half-second recovery first.
- Fake deaths play each sequence once. Zombies and skeletons previously restarted the lying-still sequence
  every tick.
- Sleep abandons a fake death or burrow and restores collision and sounds, so the mutant does not resume
  it on waking. Sleep also ends a grab and releases its player.
- The psydog waits for its current attack to end before summoning, instead of overriding it.
- A player the bloodsucker is feeding on, or a skeleton or izlom is grabbing, is released when the mutant
  dies. Previously the player stayed frozen until the corpse entity was removed: the base never called
  the skeleton's and izlom's `STALKERNPCOnKilled`.
- An izlom grab ends as soon as its victim disappears, instead of at the throw.

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

## Poltergeists

`lua/entities/stalker_ai_poltergeist/` is the shared base of the three `npc_mutant_poltergeist_*` classes.
It is an invisible flyer: the client draws only the element's orb (a looping `wick_*` particle, glow and light)
and briefly shows the body as a distortion when it takes damage. The corpse is visible and falls on death.
It senses in every direction, never melees, laughs while alive and circles a visible enemy at 300-560 units by
overriding `STALKERNPCFlightCombatGoal(enemy, now)`, which any flyer may do to choose its own combat
position. Each element is immune to its own damage type.

Concrete classes inherit `stalker_ai_poltergeist` and must not include `STALKERNPCBaseVars.lua`, which would
reset the shared tuning. Inherit from `stalker_ai` directly for any other variant of an existing mutant:
GMod merges parent and child tables key by key, so a shorter child `ENT.Abilities` keeps the parent's extra
abilities.

| Class | Attacks |
| --- | --- |
| Fire | Three flames in turn where the enemy is heading. `ent_poltergeist_flame` smoulders, then burns a column. |
| Electric | A volley of three slow, straight `ent_poltergeist_spark`, and a close-range discharge. |
| Telekinetic | Lifts and throws three objects, and shoves nearby players away. |

The telekinetic poltergeist borrows nearby loose `prop_physics` (unfrozen, unconstrained, not persisted, up to
80 mass) and conjures temporary debris for the rest. Each object belongs to one `ent_poltergeist_grip`, which
deals the hit itself, keeps the object from colliding with players, and restores a borrowed prop's gravity and
collision group after a throw, death, sleep or removal. Borrowed props stay where they land.

The electric orb is an anomaly-sized `wick_*` system. Fire and telekinetic use `cotz_orb_fire` and
`cotz_orb_gravity` from `particles/cotz_poltergeist_orbs.pcf`, copies of artefact effects enlarged 3.5 times
to match it. Change `SCALE` in `tools/poltergeist_orbs_pcf.py` and rebuild to resize them; do not edit the
binary. The server registers the file with `resource.AddFile`; servers that distribute content only through
a Workshop pack must add it to that pack.

## Mimic

`npc_mutant_mimic` runs and claws on the ground. Every 6-9 seconds, while it can see its enemy and finds room,
its `aerial` ability vanishes, takes a perch in the air with a clear line to the enemy, fires an
`ent_mimic_ball`, takes a second perch, fires again and lands near the enemy. The orb deals separate impact
(`DMG_CLUB`) and PsyHealth (`DMG_SONIC`) damage. `sv_perches.lua` owns the position searches, which run only
when an aerial attack is considered or performed. If no landing spot passes, it returns to its takeoff point.

Mimics also ambush players at cyclical containers (`cycliccontainer/sv_mimicambush.lua`). The first completed
search of each appearance rolls the `mimicAmbushChance` config (8 percent; 0 disables); an interrupted search
does not spend the roll, and later openers never reroll it. The mimic spawns on a nodegraph node in the same
connected component as the node beside the container, falling back to other validated ground nearby, and obeys
the mutant population limit. It calls out, then hunts the opener for 30 seconds, even around corners.

`ent_cotz_orb` is the shared mutant projectile: straight Lua movement with one hull trace per tick and an
`Impact(trace)` override.

## Leading shots

Mutants aim where a moving target will be, not where it is. `self:STALKERNPCPredictAim(enemy, origin, speed)`
returns the point where a projectile from `origin` meets the enemy if it keeps its current velocity, leading
by at most three seconds. It stops at walls and ignores vertical speed for jumping or falling players.
`STALKERNPCAbilityLaunchProjectile` uses it, with the engine's physics speed cap for physics projectiles;
this covers the burer, karlik, fast and swamp controllers, mimic and electric poltergeist. The spider's spit
leads before adding its arc, and the telekinetic grip leads each throw. New ranged attacks must use the helper
or this method. Shots do not steer after launch, so changing direction dodges them. The fire poltergeist's
flames keep their own short ground lead.

## New mutant checklist

1. Entity folder inheriting `stalker_ai` (or a shared base), with `PrintName` and `Information`.
2. `lua/autorun/snpcmutants.lua`: spawn menu entry, death-notice name, sounds and any particles.
3. Items, using placeholders where unfinished: part, hide, raw meat and meal (variants may share their
   family's meat). Hides need an `ix.armortables.attachments` entry; placeholder entries have no resistances.
4. Poaching: a `MutantParts` entry, reached through `MutantTable` when the corpse model is unique or through
   `ENT.PoachingType` when it is shared.
5. Vendor `BUYONLY` rows for parts and hides, and the matching `disabledItems` entries in
   `townnpcs/definitions/sh_the_original.lua`.
6. Kill credit, reputation, and a `SPECIES_ALIASES` entry in `eventcontroller/sv_combat.lua` for variants.

Natural spawns (`eventcontroller/sh_eventdefs.lua`), hunting jobs and requirement pools are balance decisions;
add them only when asked. `tests/mutant_harvest_spec.lua` checks steps 3 and 4 for every mutant.

The swamp bloodsucker, mimic and poltergeists are only admin-spawnable (apart from mimic ambushes). Their
health and damage values are first-pass tuning.

## Checks

`tests/mutant_abilities_spec.lua`, `tests/mutant_flight_spec.lua`, `tests/burer_stamina_spec.lua` and
`tests/mutant_complex_abilities_spec.lua` cover the runner, steering and the migrated mutants;
`tests/mutant_navigation_spec.lua` covers navigation-started leaps, and
`tests/mutant_target_safety_spec.lua` covers grabs and spits whose targets disappear.
`tests/elemental_mutants_spec.lua`, `tests/mimic_ambush_spec.lua` and `tests/mutant_harvest_spec.lua` cover
the mimic, mutant orbs, poltergeist helpers, container ambushes and harvest coverage. They use mocks; verify
in a multiplayer session:

1. Burer: stamina drain, blast and shield play their animations, and the shield absorbs damage. A
   lost target cancels the blast windup.
2. Each migrated mutant: leaps land and swing, shockwaves hit nearby players, feeding freezes and
   releases (including when the bloodsucker is killed mid-feed), the karlik teleports and knocks back,
   controller psy attacks hit visible targets, and psydogs replace lost phantoms. Strand a leaping mutant
   below a ledge to check navigation-started leaps.
3. Zombies and skeletons collapse, lie still without restarting or sliding, stand about fifteen seconds
   after the hit and are solid again. Skeleton and izlom grabs freeze, then release or throw players,
   including when the mutant dies mid-grab. Izlom pulls drag players in. Hellhound flames show and stop.
   Spiders spit when wounded, and burrow and resurface. Chimeras and the small leapers swing mid-leap,
   and the rodent uses its `attack3` animation.
4. A test flyer (any mutant with `MovementMode = "fly"`) takes off, pursues around corners and over
   walls, holds for melee, follows a hidden player to the last seen position, sleeps and wakes.
5. Swamp bloodsucker: wears skin 2 or 5, cloaks until its enemy is within 225 units or it lunges, lunges, never freezes players, and its
   corpse yields the swamp harvest.
6. Mimic: arrives from a searched cyclical container with its call and goes for the opener; stays put in the
   air while perched, indoors and out; orbs lower health and PsyHealth; it lands and runs again; a mimic shot
   in the air falls as a poachable corpse.
7. Poltergeists (the first mutants to use flight in game): the body is invisible and hittable, each orb and
   attack effect appears without missing textures, and looping effects stop with their entity. Flames, ball
   lightning and thrown objects damage players; borrowed props regain collision. Killed poltergeists fall as
   visible corpses that yield their element's harvest.
8. Mutants with translucent effects draw correctly: the bloodsucker's cloak, the burer's shield and
   controller psy images. Compare client frame time near a mutant group with the previous version.
