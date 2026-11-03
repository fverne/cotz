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
Garbage currently inherits the shared population target and caps.

This defines an intended progression, not a measured difficulty score: NPC statistics and map geometry
still determine actual combat difficulty. Chimeras, pseudogiants, burers, psy-dogs, hellhounds and
controllers have not been added to Garbage.
