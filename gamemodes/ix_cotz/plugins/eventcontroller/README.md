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

Human `npc_human_*` shots against living hostile `npc_mutant_*` targets aim at the target's world collision
center from the bullet source, correcting engine aim above low creatures. Weapon spread, pellet count and
damage remain unchanged. The server `EntityFireBullets` plugin hook returns `true` to apply the direction,
following the engine hook contract. Shots at players, humans and unrelated targets retain ordinary aim.

Routine encounter PDA chatter checks Mute's permission for the current map through
`CanReceiveMutantReports`: Swamps, Garbage, Waystation, then Pripyat. Delivery remains private to each
eligible character. Existing spawn frequency and chatter chance are unchanged.

Run `luatex --luaonly tests/contact_progression_changes_spec.lua` and the combat suite below. Live checks
need low mutants at different elevations, moving targets and cover, plus fresh/completed Mute characters
on each map. Standalone vector and permission mocks cannot prove model hitboxes or multiplayer delivery.

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
