# Routine encounter location tags

`difficulty` remains the encounter field name, but its entries are now string location tags.
An event point stores `{position, name, locationTag}`. Matching and encounter quantities are unchanged.

| Map prefix | Map |
| --- | --- |
| `swamps` | `rp_marsh_cs` |
| `garbage` | `rp_garbage_cotz` |
| `waystation` | `rp_waystation` |
| `pripyat` | `rp_pripyat_remaster` |

Append one of `_outside_easy`, `_outside_hard`, `_building`, `_sniperspot`, or `_underground`.
For example, `difficulty = {"swamps_outside_hard", "waystation_building"}`.
Outside easy/hard retain the previous nearby/distant wilderness assignments.

Use `/eventadd "Area name" swamps_outside_easy` to add a point at your crosshair.
FTS presets and exports use the same strings. The separate `eventcontrolleradv` plugin is unchanged.

Existing saved numeric event-point codes (11–15, 21–25, 31–35) are converted on load and written
as strings on the next normal save. Positions, names, and unknown/custom codes are preserved.
Do not rerun first-time setup to migrate an existing world.

Run the tag/migration/export regression checks from the repository root:

```sh
luatex --luaonly gamemodes/ix_cotz/plugins/eventcontroller/tests/location_tags_spec.lua
luatex --luaonly tests/population_performance_spec.lua
```

## NPC spawn placement

Routine encounters prefer nearby ground nodes from `maps/graphs/<map>.ain`. The server reads and
caches the graph once per map/plugin load; it never writes or rebuilds it. `sv_spawnnodes.lua` reads
the version 37 format described by Valve's
[network graph serialization](https://github.com/ValveSoftware/source-sdk-2013/blob/master/src/game/server/ai_networkmanager.cpp).
It checks record bounds, link endpoints, finite coordinates and the engine's node count where available.
A different BSP revision produces one ordinary console notice, but the graph remains in use after
validation; manually authored graphs need not share the BSP's revision number. Unsupported, missing
or invalid graphs produce one console warning and use ordinary validated floor sampling. Reload the
map or plugin after replacing a graph.

Eligible nodes must have a ground-movement link to another ground node for `HULL_HUMAN`, the navigation
hull used by the current encounter actors. Hull-specific vertical offsets place candidates at the node's
actual floor height. Candidates stay within the encounter's 750-unit radius and 128 units vertically
of its authored point. Up to 24 nodes are tried randomly without replacement. A candidate needs a floor
within 18 units of its saved height, a ground normal of at least 0.7, and clear space for the encounter
actors. The shared clearance box is 112 units wide and 112 units high, covering current mutant collision
bounds (including the scaled hellhound) and human NPCs without requiring the old 256-unit headroom.

If the graph has no safe nearby candidate, spawning continues with up to 24 ordinary positions around
the event point, followed by a validated center position. The fallback retains the unobstructed sweep
from the center, checks for a floor from 32 units above to 128 units below the candidate, and rejects
prop-supported floors, steep slopes, solid starts, sky, blocked hulls and out-of-world positions.
Connected graph nodes may use authored static-prop walkways; arbitrary prop tops are excluded from
the fallback. There is no unchecked center fallback. An individual spawn is skipped only when both
the node candidates and ordinary floor checks fail. Fully rejected encounters do not issue PDA reports.

Routine queued mutants recheck clearance immediately before creation, so another queued NPC or a
new blocker cannot occupy the same placement unnoticed. Population limits, player exclusion and pack
ownership remain in effect. Existing event points and saves need no migration. Advanced event dupes
and scripted advanced-event spawns retain their own behavior. Research-defence attackers use
this placement service around their saved approaches, retaining task-owned spawning and population checks.

Psydog phantoms and controller zombies use the same placement service through the NPC base's
server-only `sv_summoning.lua`. Each owner declares a 256-unit `summonSpawnRadius`; node selection
and ordinary floor sampling center on the owner. Only the outward fallback sweep ignores the owner,
so the sweep can leave its occupied origin while final floor/clearance checks still reject overlaps
with it and earlier summons. Exhausted graph candidates still fall back to ordinary ground positions.
Summons register immediately against the hard population caps and retain their owner's pack,
including research-pack isolation. They remain immediate ability spawns with their existing slot
references, replacement rules, cooldowns and cleanup, rather than queued routine encounters with
player-exclusion checks. Outside COTZ, the NPC base retains the original summon offsets.

Run `luatex --luaonly tests/event_spawnplacement_spec.lua`, the population suite and the tag suite above.
For summoning, also run `luatex --luaonly tests/mutant_summoning_spec.lua` and the combat suite below.
The placement spec also accepts optional `.ain` paths to check installed graphs. In multiplayer, test
events near crates and rooftops, connected static-prop walkways, indoor ceilings, slopes, blocked node
positions and points without nearby nodes. Check fallback spawning and queued group separation too.
Check psydog and controller summons near props, in narrow spaces, without nearby nodes and at population
caps; kill/remove their owners and confirm summon cleanup and ordinary replacement timing.
Saved links improve placement but cannot guarantee a live route through dynamic doors, blocked links
or disconnected regions. These tests do not replace in-game movement checks.

## Garbage encounter tier

Garbage sits between Swamps and Waystation. Its shared encounters and 11 explicit `garbage_*` definitions use:

| Location | Encounters |
| --- | --- |
| Outside easy | 2–4 dogs; 2 boars; 3 flesh with 1 boar; 5 rodents; 1 cat; 1 izlom; zombies; 1–2 tarks; 1 spider; 1 sprig |
| Outside hard | 3 dogs with 1 pseudodog; 3 boars; 3 flesh with 1 boar; 1 izlom; 1 bloodsucker; 1 spider; 2 sprigs; radioactive zombies |
| Buildings | 5 rodents; 1 izlom; 1 bloodsucker; 1 snork; 1 spider; ordinary or radioactive zombies |
| Underground | 5 rodents; 1 bloodsucker; 1 snork; 1 spider; ordinary or radioactive zombies |

Ordinary zombies are 3 classic zombies and 1 babka. Radioactive packs are 3 classic zombies and
1 radioactive zombie. No Garbage mutant encounter uses `garbage_sniperspot`; that tag is reserved
for future sniper encounters.

Swamps no longer selects lone bloodsuckers, lone snorks, two-sprig encounters, radioactive zombie
packs, swamp-controller encounters, pseudodog-led dog packs, 3–4 boar packs, or the 4-flesh/1-boar
encounter. Other existing Swamps encounters remain. Controllers stay at Waystation and above.
The two-boar and smaller rodent encounters are removed from Waystation entirely. All 12 mutant
encounters that previously bridged Swamps hard and Waystation easy now bridge Swamps hard and
Garbage easy instead: `Dog1`, `Dog2`, `Dog4`, `rodent2`, `cat1`, `cat2`, `izlom1`, `zombies1`,
`tark1`, `tark2`, `spider1`, and `sprig1`. Their Waystation hard tags are also removed where present,
so those modest packs do not remain in the harder outside pool. Other location and map assignments
are retained, except `rodent2` moves its Waystation building assignment to Garbage and also covers
Garbage underground. Duplicate Garbage-only dog, cat and rodent definitions have been removed.
Human encounters are unchanged. The intended map progression is Swamps < Garbage < Waystation.

**FTS deployment:** `rp_garbage_cotz` still has no authored routine event points. Registering tags and
encounters alone does not populate the map. Place points with `/eventadd` in a multiplayer map
session, verify navigation and safe placement, then export the eventcontroller data into the Garbage
preset. Existing live worlds need those points added; do not rerun full FTS just for encounters.
Garbage has independent population target/cap overrides; unset overrides inherit shared values.

This defines an intended progression, not a measured difficulty score: NPC statistics and map geometry
still determine actual combat difficulty. Chimeras, pseudogiants, burers, psy-dogs, hellhounds and
controllers have not been added to Garbage.

## Aim and regional PDA reports

Living and zombified `npc_human_*` gunmen aim at their enemy's chest bone, with alternate chest and spine
names supported for different skeletons. This applies to players, humans and mutants. If no preferred
bone has a usable position, each shot chooses a random bone and tries the remaining bones if necessary.
Targets without usable bone positions fall back to their world collision center. Positions are read
for each shot; weapon spread, pellet count and damage remain unchanged. The server `EntityFireBullets`
plugin hook returns `true` to apply the direction, following the engine hook contract.

Routine encounter PDA chatter checks Mute's permission for the current map through
`CanReceiveMutantReports`: Swamps, Garbage, Waystation, then Pripyat. Delivery remains private to each
eligible character. Existing spawn frequency and chatter chance are unchanged.

Run `luatex --luaonly tests/contact_progression_changes_spec.lua` and the combat suite below. Live checks
need living and zombified gunmen against players and NPCs with different skeletons, low mutants at
different elevations, moving targets and cover, plus fresh/completed Mute characters on each map.
Standalone bone, vector and permission mocks cannot prove model hitboxes or multiplayer delivery.

## Proximity combat and squads

The activity manager tracks live `npc_mutant_*` and `npc_human_*` actors in spatial buckets.
Human actors do not count toward mutant population caps. Town vendors and unrelated NPC classes
remain outside this policy. `/PopulationStatus` reports awake/sleeping humans, mutant population,
queued spawns, active pack conflicts, regroup schedules issued in the latest update and searches
consumed in the latest search-budget tick.

Both participants in an NPC fight must be awake and hostile. Sleeping rivals become neutral to
engine targeting; target selection, retaliation, schedules and damage use the same server policy.
Allied NPC damage is suppressed. Player damage wakes its victim. The existing wake/sleep distances
are 5,000/6,000 units, with 15 seconds of grace after player proximity or external damage. NPC damage
cannot extend that grace. Once players leave, grounded actors forget their targets, cancel offensive
work and sleep even if they were fighting. Airborne actors finish their movement before sleeping.

Bandits, mercenaries and military are internally allied and mutually hostile. Zombified humans ally
with undead mutants. Spawned human squads share threats with nearby awake faction allies. Idle
followers regroup beyond 512 units and stop within 256; the living member with the lowest entity
index leads. Members outside 2,048 units return toward their encounter origin. Regrouping never
teleports or follows a sleeping leader; blocked attempts retry after ten seconds. Actual movement
requires the map's NPC navigation nodes.

Routine encounters and advanced events share one session-only pack identity per spawn group,
including queued mutants. Summoned creatures inherit their summoner's pack. Manual spawns get
singleton packs. Each research-defence wave has an isolated pack and retains its task-owned lifecycle.
Pack identities and feuds are not persisted or added to character data.

Research attackers carry their sampler as `cotzCombatObjective`, with `cotzCombatObjectiveRadius`
set to the task's disruption radius. When idle they run toward it and hold within visible disruption
range. This uses the same schedule handling as remembered pursuit, so normal mutant schedule selection
does not replace the approach with wandering. Visible or remembered enemies take priority; player
acquisition and retaliation remain unchanged. Target loss resumes the objective. Cleanup clears the
objective reference along with ordinary pursuit state.

For research defence, verify attacks on the sampler before player contact, interruption by sight or
incoming fire, and return to the device after player contact expires. Check near-wall approaches and
that fighting a player pauses proximity disruption. Run the field-task suite alongside the combat suite.

Mutant packmates and separate packs of the same species stay friendly. Every 30 seconds, staggered
by pack, awake predators can hunt nearby visible herbivores/rodents with a 50% chance; otherwise
eligible different-species packs can feud with a 10% chance. One opponent pairing lasts 90 seconds,
followed by a 120-second cooldown. Range is 1,500 units. Research waves cannot join ambient conflicts.
The policy and tuning constants live in `sv_combat.lua`. `ai_disabled` stops ambient decisions and
regrouping; existing `ai_ignoreplayers` behavior remains supported.

Mutants and human NPCs keep their engaged player target instead of switching to a closer NPC,
retaliating against an NPC, or accepting a competing squad alert. Ambient mutant conflicts start only
when their leader is idle. Idle target acquisition still selects the nearest visible hostile inside the
existing detection range and forward cone (1,500 units/90-degree half-angle for mutants and
7,000 units/45-degree half-angle for humans).

Each actor remembers one player and their last observed position for ten seconds after contact.
Seeing that player or receiving damage from them refreshes contact. A remembered player can be
recognized from behind; after expiry, ordinary detection rules apply again. During occlusion actors
move toward the recorded position and wait there, rather than tracking the player's hidden movement.
Squad alerts share the observed position and original contact time; repeated alerts do not extend it.
Regular visibility checks run at most once per quarter-second for the remembered player; target
assignments and damage also evaluate contact when they occur.

Target loss clears stale enemy memory and requests another search through the existing cooldown and
shared budget. Target acquisition and changes between visible combat and remembered pursuit clear
Lua/engine schedule bookkeeping once, without recursively selecting schedules. Mutant attacks, jumps
and grabs finish recovery before voluntary target switches or schedule refreshes. Player focus is
discarded on expiry, death, disconnect, observer/noclip mode, `ai_ignoreplayers`, actor sleep/removal,
and plugin unload. Player memory is session-only and does not change saves or population limits.

Player positions are cached, spatial cells update during the existing half-second maintenance pass,
and enemy searches/ambient decisions share the configured per-tick budget. There are no per-actor
maintenance timers or routine all-world/all-pairs relationship scans. Relationship caches and empty
packs/cells are cleaned through actor removal. Plugin unload wakes actors and restores recorded
pre-policy dispositions.

Run `luatex --luaonly tests/npc_combat_spec.lua` and the population/tag suites above. Multiplayer
checks still need mixed factions and mutant packs, sleep boundaries during melee/projectiles,
leader death and blocked navigation, task waves, and server frame cost at the configured caps.
Also check both NPC families while circling behind them, breaking sight around cover, introducing
closer rivals, and removing targets during attacks. Confirm that occluded pursuit stops at the last
known position and expires after ten seconds. A valid target with no usable navigation path remains
a map/navigation issue; the standalone suites cannot establish in-game movement correctness.

Visible unreachable targets receive a one-second grace period, then two position-based chase retries
two seconds apart. Recovery is per mutant and target, and applies to player and NPC enemies.
Engine unreachable-memory expiry alone does not replenish retries. Advancing
64 units toward the target while that memory is clear restores normal combat. Target movement of 64 units
in any direction resets recovery; returning within the mutant's existing melee range cancels it even while
engine memory is stale. Target loss, occluded pursuit and sleep discard recovery. Attack animations retain
their schedule protection, including jump windups before an animation begins.

Mutants with ranged or leap attacks hold a suitable attack position while their existing Think callbacks
continue to handle cooldowns, random rolls and attacks. Jump-capable mutants approach until they enter
their existing leap range. Short/long leap windows, the spider's health-dependent leap/spit switch, and
species-specific ranges are declared in the concrete mutant definitions. Existing leap conditions use
the same fields; their distances and cooldowns are unchanged.

After direct retries fail, mutants sample up to four alternate grounded approaches, two seconds apart.
Approaches use their attack range and hull size to find footing around the target, below elevated perches.
Successful walking progress keeps an active route running, including routes that initially move sideways.
If approaches fail, mutants run to a validated ground node at least 3000 units from their current position,
preferring the closest suitable node that increases distance from the target. Up to four nearby candidates
at that distance are checked against the mutant's full hull using the shared search budget. If no suitable
graph node exists, they hold position. They retry in bounded batches after ten seconds of withdrawal.

`lua/entities/stalker_ai/sv_navigation.lua` is included server-side by the NPC base before schedules.
Its movement monitor checks active paths or validated ground destinations every half-second. A failed
chase to an elevated target alone does not diagnose a stranded mutant. Six seconds without
32 units of progress starts physical recovery: up to four local walk/descent attempts, three seconds apart.
Idle actors, intentional attack holds, attack windups, grabs, airborne actors, sleeping actors and disabled
AI do not trigger recovery. Combat-manager pursuit yields while physical recovery owns movement, and
arrival at a remembered player position or task device clears stale movement intent. Successful escape
walking preserves the target-approach budget so it cannot indefinitely restart the same failed chase.

Relocation is a last resort after failed walk attempts, retried at most once every ten seconds. It stays
within 512 units of the mutant and 128 units vertically. Destinations must have world support
under all hull corners, a walkable slope, a clear full hull, and no water/slime at the feet. Recovery uses
a previously traversed safe position or a lower local surface; it does not relocate onto an untested perch
at the same height. The current mutant and destination hull must be outside every player's and view
entity's PVS, and no player may be within 512 units of either position. Failed checks leave the mutant
in place. These conservative visibility checks may defer relocation even behind nearby cover.
Health, combat targets, pack identity, task ownership and rewards remain intact. All recovery state is
session-only; sleep clears movement recovery. Geometry scans share the existing search budget.
Timing and safety constants live in the navigation module and `schedules.lua`.

Run `luatex --luaonly tests/mutant_navigation_spec.lua` alongside the combat and population suites.
In multiplayer, check climbing onto and off static props, stationary perched players and mutants, repeated
small movements, target switching, short/long jumps and injured spiders. Also check mutants stranded on
static props, blocked or narrow descent routes, full-size pseudogiant hulls, water, players entering view
during recovery, observers, task-device arrival and server frame cost at population caps. Standalone mocks
cannot establish nodegraph route connectivity, model collision or multiplayer visibility.
This change does not repair map navigation.
