# Setting up a new map

This guide covers preparing a map for COTZ's current plugins, capturing its layout
as a First Time Setup (FTS) preset, and deploying that preset. FTS is a one-time
population tool, not a map editor or a migration system.

For deciding which NPCs, items, artifacts, tasks, and encounters the map needs,
use the companion [map content design guide](map-content-design.md).

Paths below are relative to the repository unless they begin with `garrysmod/`.
Commands beginning with `/` are Helix chat commands run by a connected player.
Use a superadmin setup character: FTS commands require admin access, but most
controller point editing commands require superadmin access.

## 1. Prepare a development server

1. Follow the [installation guide](../README.md#installation-and-initial-setup).
   Start the exact BSP name with the `ix_cotz` gamemode in multiplayer.
2. Use a development database and saved-data directory. Back up both the database
   and `garrysmod/data/helix/` before initializing an existing world. Inventories
   live in the database; much of the map layout lives in files. Back up any
   separate persistence/duplication data used by your deployment as well.
3. Install the map's content and the models, NPCs, anomalies, and items you plan
   to use. Check the console for missing classes, models, and plugin load errors.
4. Plan a safe base, character spawns, checkpoint locations, travel entrances,
   trader services, loot routes, anomaly fields, radiation, and mutant areas.
   Walk the routes and check NPC movement and spawn clearance on the actual map.

The bundled FTS presets are `rp_marsh_cs`, `rp_waystation`, and
`rp_pripyat_remaster`. Their coordinates belong to those exact maps. A map listed
in the cross-server definitions does **not** necessarily have an FTS preset.

## 2. Register an empty preset before populating it

Create `gamemodes/ix_cotz/plugins/firsttimesetup/presets/sh_<mapname>.lua`. Replace
`rp_your_map` below with the exact result of `game.GetMap()` (no `.bsp` suffix):

```lua
PLUGIN.map_presets["rp_your_map"] = {
	containers = {},
	entities = {},
	vendors = {},
	plugindata = {
		["anomalycontroller"] = {},
		["boxspawner"] = {},
		["eventcontroller"] = {},
		["eventcontrolleradv"] = {},
		["hidestashspawner"] = {},
		["radiationcontroller"] = {},
		["simplecrossserver"] = {},
		["worlditemspawner"] = {},
	},
}
```

Add an explicit include alongside the other map includes in
[`firsttimesetup/sh_plugin.lua`](../gamemodes/ix_cotz/plugins/firsttimesetup/sh_plugin.lua):

```lua
ix.util.Include("presets/sh_rp_your_map.lua")
```

Keep every top-level table and all eight `plugindata` tables, even for unused
systems. FTS indexes them directly and assumes the participating plugins exist.
It does not validate an unsupported map or a partial preset before starting.
Restart after registering the file. Do not run FTS yet: first build and export
the layout, then test the completed preset on a clean development world.

## 3. Place containers, services, and other entities

### Containers and loot

Spawn a prop whose model is registered in
[`containers/sh_definitions.lua`](../gamemodes/ix_cotz/plugins/containers/sh_definitions.lua).
The containers plugin converts registered props to `ix_container` entities.
A new model needs a container registration, including inventory dimensions,
before it can be used reliably.

Position and freeze each container, then aim at it to configure it:

| Command | Purpose |
| --- | --- |
| `/containerspawnadd <pool>` | Give the container periodic item spawning from a random-item pool. |
| `/containerspawnremove` | Clear periodic item spawning. |
| `/containercyclicaladd <category>` | Make the container appear/disappear and refill according to a cyclic category. |
| `/containercyclicalremove` | Clear its cyclic category. |
| `/containercyclicaldisplay` | Show current cyclic container positions. |
| `/FTSGetContainerVars` | Print a preset record for the aimed-at container to the **client console**. |

Copy the printed record into `containers`. Use `spawnCategory = ""` and
`cyclicalCategory = ""` for ordinary storage. These are separate systems: a random
item pool is not a cyclic category. Check pool IDs in
[`randomitem/libs/sh_randomitems.lua`](../gamemodes/ix_cotz/plugins/randomitem/libs/sh_randomitems.lua)
and cyclic categories (including `stash_map1`, `stash_map2`, and `stash_map3`) in
[`cycliccontainer/sh_definitions.lua`](../gamemodes/ix_cotz/plugins/cycliccontainer/sh_definitions.lua).
Choose rewards for the map's intended progression level rather than copying all
of another map's loot.

FTS creates new inventories; it does not capture a container's contents, password,
custom name, or money. The runtime containers plugin saves more state than the
FTS format. Keep `containerSave` enabled for persistent containers.

### Advanced vendors

Use `/spawnadvvendor <template>` to place a vendor at your crosshair, facing your
character's angles. Template IDs come from
[`vendor_adv/libs/sh_npctemplates.lua`](../gamemodes/ix_cotz/plugins/vendor_adv/libs/sh_npctemplates.lua).
Test dialogue, trade, and any job or repair services before recording it.

Each `vendors` entry needs `template`, `position`, and `angles`. Use
`/FTSGetEntityVars` for the final transform, then replace the printed `class` field
with the template ID you chose. FTS has no vendor dump command, and it recreates
vendors from templates rather than exporting their live edits or stock.

### Generic entities and persistence

Spawn and position the required services, then use `/FTSGetEntityVars` and copy
the client-console record into `entities`. This format contains only `class`,
`position`, and `angles`. It does not preserve a custom model, skin, entity
settings, wiring, or arbitrary prop state.

**FTS does not persist generic entities itself.** Use the owning plugin's save
support. Existing examples include:

| Entity | Plugin that saves it |
| --- | --- |
| `ix_spawnsaver` | `spawnsavercheckpoint` |
| `ix_noticeboard` | `noticeboard` |
| `ix_cassette_player` | `cassette_player` |
| `ix_dataextractpc` | `inworldtasks` |

For scenery or another unsupported entity, inspect its persistence mechanism.
Helix's [`persistence`](../gamemodes/helix/plugins/persistence.lua) plugin provides
a property-menu persistence action, but FTS does not automatically mark entities
for it. Avoid assigning two persistence systems to the same entity. Verify the
result after restarting; a frozen entity alone is not a saved entity.

## 4. Author controller points in game

Most add/remove commands use the surface under your crosshair, not your feet.
Keep points out of walls, give spawns floor space, and keep hazards and loot away
from safe arrivals. Angle brackets below are placeholders; supply the actual
value without brackets. Quote names containing spaces.

| System | Add command | Inspect / remove | FTS record shape |
| --- | --- | --- | --- |
| Anomalies | `/anomalyadd <radius> <mask>` | `/anomalydisplay`, `/anomalyremove <radius>` | `{Vector(...), radius, "mask"}` |
| Breakable loot boxes | `/boxspawnadd <type> [pool]` | `/boxspawndisplay`, `/boxspawnremove [radius]` | `{Vector(...), type}` or `{Vector(...), type, "pool"}` |
| Routine mutants | `/eventadd "Area name" <difficulty>` | `/eventdisplay` | `{Vector(...), "Area name", difficulty}` |
| Advanced events | `/eventadvadd "Area name" <internalID>` | `/eventadvdisplay` | `["internalID"] = {Vector(...), "Area name"}` |
| Hidden stash/task destinations | `/stashspawneradd <description>` | `/stashspawnerdisplay`, `/stashspawnerremove <radius>` | `{Vector(...), "description"}` |
| Radiation | `/radiationadd <mask>` | `/radiationdisplay`, `/radiationremove <radius>` | `{Vector(...), "mask"}` |
| Outgoing travel | `/loadzoneadd <destinationMap> <destinationZone>` | `/loadzoneremove <radius>` | `{Vector(...), "destinationMap", "destinationZone"}` |
| Loose world loot | `/itemspawnadd <pool>` | `/itemspawndisplay`, `/itemspawnremove <radius>` | `{Vector(...), "pool"}` |

The `eventremove` and `eventadvremove` implementations still read legacy
`arguments[1]` without declaring typed arguments. Check their behavior on your
server before relying on them; edit/export the point tables directly if needed.
`loadzoneadd` and `loadzoneremove` are registered only while `DEBUGSETUP` is true
in `simplecrossserver/sh_plugin.lua` (currently true).

### Hazard masks

Masks are **strings of selection flags**, not class names or numeric bitmasks.
Character `i` enables definition `i` when it is `1`; one enabled definition is
chosen randomly for that point/field. Read the ordered definitions in
[`anomalycontroller/sh_anomalydefs.lua`](../gamemodes/ix_cotz/plugins/anomalycontroller/sh_anomalydefs.lua)
and [`radiationcontroller/sh_radiationdefs.lua`](../gamemodes/ix_cotz/plugins/radiationcontroller/sh_radiationdefs.lua).
Keep masks quoted in Lua so leading zeroes survive, and enable at least one valid
entry. Some radiation definitions are deliberately named `Nil`, allowing an
empty result. An anomaly radius controls field placement; a radiation record
has no radius field.

Point editing changes configuration, not necessarily existing spawned hazards.
Anomalies have `/cleananomalies` and `/spawnanomalies`; spawning again without
cleaning can add duplicates. Radiation is cleaned and spawned on `LoadData`, so
save and restart to verify it. Removing a point does not remove its live hazard;
`/anomalyentremove <radius>` and `/radiationentremove <radius>` act on entities.

### Boxes, mutants, and advanced events

For boxes, use type `1` for small boxes and `2` for the large-box selection. The
spawn implementation treats other values as small boxes despite the `boxtypes`
list. An optional custom pool must exist in the random-item definitions.

Routine mutant difficulties must match the values in
[`eventcontroller/sh_eventdefs.lua`](../gamemodes/ix_cotz/plugins/eventcontroller/sh_eventdefs.lua)
(for example `11` or `12`), rather than assuming a generic 1–3 scale.
Spread points across suitable open areas. Nearby players/NPCs, spawn clearance,
the routine target, and global/regional caps can prevent spawning.

Advanced events have a separate scale and require **both**:

- An entry for the new map in `MapToDifficultyMap` in
  [`eventcontrolleradv/sh_plugin.lua`](../gamemodes/ix_cotz/plugins/eventcontrolleradv/sh_plugin.lua).
- Event definitions of that difficulty whose `allowedPoints` include the exact
  internal point IDs you placed, in
  [`eventcontrolleradv/sh_eventdefs.lua`](../gamemodes/ix_cotz/plugins/eventcontrolleradv/sh_eventdefs.lua).

Adding a point alone does not make an advanced event eligible. Reusing an
internal ID replaces that point. Use map-specific IDs to avoid confusion.

Tune `eventControllerThreshold`, `mutantLimit`, `mutantRegionLimit`, and
`mutantRegionRange` using `/PopulationStatus` to inspect live and queued mutants.
To register separate overrides for the new map, add its name to `MAPS` in
[`eventcontroller/sh_population.lua`](../gamemodes/ix_cotz/plugins/eventcontroller/sh_population.lua)
on **every server** sharing configuration. Per-map `-1` inherits the default;
`0` disables a cap, while a routine target of `0` stops routine mutants.
Other useful settings include `worldSpawnerThreshold`, `boxSpawnerThreshold`,
`artifactSpawnerThreshold`, `artifactSpawnerRate`, `artifactSpawnerChance`,
`eventControllerAdvThreshold`, and the `containerSpawn*` settings.

## 5. Configure systems outside the preset

### Character spawns and checkpoints

Stand at each intended character spawn and use `/SpawnAdd <faction> [class]`
from Helix's [`spawns`](../gamemodes/helix/plugins/spawns.lua) plugin. These spawns
are saved separately and are **not** exported by FTS. Record their deployment
steps alongside your preset. Test a fresh character as well as returning ones:
[`spawnsaver.lua`](../gamemodes/ix_cotz/plugins/spawnsaver.lua) restores saved
positions, and death/checkpoint behavior uses `savedspawn` instead.

Place `ix_spawnsaver` checkpoints and test using them and respawning.
[`spawnsavercheckpoint/sh_plugin.lua`](../gamemodes/ix_cotz/plugins/spawnsavercheckpoint/sh_plugin.lua)
hard-codes the initial saved spawn for characters created with `rp_marsh_cs` as
the home map. If replacing the home map, update that initialization as well as
`simplecrossserver.homemap`. Review other home-return mechanics such as
`schema/items/artifacts/sh_artifact_photo.lua` for old-map coordinates.

### Cross-server travel

Review [`simplecrossserver/sh_plugin.lua`](../gamemodes/ix_cotz/plugins/simplecrossserver/sh_plugin.lua)
(`homemap`, `activemaps`) and add the map's display name, real server address, and
arrival zones to
[`simplecrossserver/sh_definitions.lua`](../gamemodes/ix_cotz/plugins/simplecrossserver/sh_definitions.lua).
The committed addresses belong to an earlier deployment and need replacing.
Deploy matching definitions to all participating servers and configure shared
MySQL/character storage as described in the [README](../README.md#multi-server-configuration).

An FTS loadpoint is an **outgoing trigger**. Its map/zone pair names an
**arrival zone on the destination map**, whose `pos`, `ang`, and `desc` are in
`mapdata`. For A → B, define an arrival on B and place a trigger on A that
references it; configure B → A separately. Keep arrivals outside outgoing trigger
radii (128 units) to avoid immediate return trips.

Test `/gotomap <destinationMap> <destinationZone>` and then the actual walking
trigger in both directions. Also test with a non-admin character: admins bypass
the character-map restriction. Even a single-server replacement map needs a
review of home-map and character-location routing.

### Tasks, stashes, and environmental behavior

- Hidden stash descriptions become player-facing location clues. Populate
  reachable destinations and check map-specific stash items under
  `hidestashspawner/items/miscellaneous/` if adding stash rewards for the new map.
- Review [`jobsystem/definitions/sh_specialjobs.lua`](../gamemodes/ix_cotz/plugins/jobsystem/definitions/sh_specialjobs.lua)
  for task item data that explicitly targets existing maps. FTS does not retarget
  those jobs. Gas analyzer, RF, and stash tasks depend on controller points;
  empty point sets cannot provide usable destinations.
- Check [`inworldtasks/sh_plugin.lua`](../gamemodes/ix_cotz/plugins/inworldtasks/sh_plugin.lua)
  for GPS offsets and task point selection. Its gas-analyzer helper indexes
  radiation points by map, whereas the radiation controller stores a flat
  current-map list. This existing mismatch needs checking/fixing before relying
  on gas-analyzer jobs; adding an FTS preset alone does not resolve it.
- Blowout shelter uses geometry traces in
  [`blowout/sh_plugin.lua`](../gamemodes/ix_cotz/plugins/blowout/sh_plugin.lua),
  not an FTS shelter list. Test intended shelters and exposed areas during a
  development blowout. Review map-specific behavior in `mapedits.lua`,
  `radioactivewater.lua`, and your weather/environment plugins as needed.

## 6. Export and assemble the finished preset

Run these on the map you are authoring:

```text
/FTSDumpPluginData
/FTSDumpCyclicContainerData
```

These write to the **server's** `garrysmod/data/FTSDump/` directory, overwriting
previous dumps:

- One `<pluginid>.txt` for each of the eight controller tables.
- `cycliccontainers.txt` for containers with a nonempty cyclic category only.

They are text fragments, not automatically loadable preset files. Remove the
first heading line and paste each controller's records into the matching
`plugindata` table. Preserve advanced event string keys. Copy cyclic container
records into `containers`; export ordinary containers individually with
`/FTSGetContainerVars`. Record vendors and generic entities separately as above.
Avoid adding the same container through both export methods.

Review generated Lua before committing it. The exporters concatenate strings
without escaping embedded quotes/backslashes, so descriptions may need manual
escaping. Dumps do not include faction/class spawns, config settings, vendor
records, generic entities, event definitions, travel arrival definitions, or
inventories. Keep the accompanying configuration changes and manual setup steps
with the preset. Preserve dense numeric arrays when editing points used by
random selection or task generation.

`/FTSShowContainerSpawns` currently always reads **`rp_marsh_cs`**, regardless of
the loaded map. Use `/containercyclicaldisplay` for current cyclic containers;
do not use the FTS display command to validate a new map.

## 7. Deploy once, save, and restart

1. Deploy the completed preset, include, and supporting configuration to a clean
   development world first. Ensure the required plugins loaded successfully.
2. Run `/FTSRunFirstTimeSetup` on that map. It creates the current preset's
   containers, generic entities, and template vendors, then assigns plugin data.
3. Allow container inventory creation to finish. Save through Helix's normal
   save cycle and shut the server down cleanly. The bundled save timer runs every
   600 seconds; an operator with server Lua access can explicitly invoke
   `hook.Run("SaveData")` after initialization completes. Check the console for
   save errors before proceeding.
4. Restart and verify the saved world. Anomalies and radiation spawn during their
   load hooks; FTS assigning their tables does not itself rebuild live hazards.
5. Repeat the same reviewed deployment on the target server with backups in place.
   Apply the separate spawn/configuration steps and repeat the acceptance checks.

FTS's completion flag is saved per map by the plugin, and subsequent ordinary
runs are refused. `/FTSRunFirstTimeSetup true` bypasses that guard: it does **not**
remove old entities, merge changes, or roll back a partial run. A failed run can
already have spawned entities before the flag is set. Restore a clean development
snapshot for another full test; use a deliberate migration for a live world.

The data assignment also has wider scope than the current map:

- `anomalycontroller`, `eventcontroller`, and `hidestashspawner` receive entries
  for **every included preset map** in their in-memory map-indexed tables.
- The other five controllers receive only the current map's flat table.
- Assignments replace the relevant tables; they do not merge existing edits.

These tables are subsequently saved by their owning plugins. Defaults use local
files under `garrysmod/data/helix/<schema>/<map>/`; shared MySQL does not by itself
copy those files between servers. Include all presets consistently wherever
cross-map task/stash lookups depend on them. Editing a preset file after initial
setup does not automatically update an already initialized world.

## Acceptance checklist

- [ ] Clean startup and FTS run, with no missing classes or plugin errors.
- [ ] New and returning non-admin characters load at the intended locations.
- [ ] Checkpoint interaction, death, reconnect, and any home-map return work.
- [ ] Vendors, dialogue, services, and ordinary storage remain usable after restart.
- [ ] Cyclic containers cycle/refill; loose loot and boxes use the intended pools.
- [ ] Anomalies, artifacts, and radiation appear in intended areas after restart.
- [ ] Mutants move through the map, spawn away from players, and respect population settings.
- [ ] Advanced events can select the map's difficulty and registered point IDs.
- [ ] Tasks and stash clues resolve to reachable points on the intended map.
- [ ] Travel works both ways, preserves characters/inventories, and avoids return loops.
- [ ] Blowout shelters protect players and exposed areas remain dangerous.
- [ ] A second ordinary FTS invocation is refused, and no entities duplicate on restart.

Keep the preset and its supporting changes in version control. Keep runtime data
and database backups separately so a map can be restored as well as recreated.
