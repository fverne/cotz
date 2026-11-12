# First Time Setup

Map presets in `presets/` are explicitly included by `sh_plugin.lua`. Each preset supplies
`containers`, `entities`, `vendors`, and `plugindata`. The server implementation of generic
entity export and spawning lives in `sv_entities.lua`.

## Town vendor placements

The Swamps preset lists all nine contacts with authored alternate positions in `vendors` as well as
`plugindata["townnpcs"]`. Alternate positions alone do not create NPCs. FTS saves its vendor snapshot
before returning, so a restart before the normal autosave does not lose newly spawned vendors.

Preset edits do not update an initialized server. To restore missing preset vendors on an existing
Swamps server after deploying these files, run this once in its server console:

```lua
lua_run local f = ix.plugin.Get("firsttimesetup") for _, v in ipairs(f.map_presets[game.GetMap()].vendors) do if not ix.progression.GetNPCFromName(ix.npctemplates.templates[v.template].name) then f:SpawnVendor(v) end end 
lua_run local f = ix.plugin.Get("firsttimesetup") f.PluginDataDeployFunctions.townnpcs(f.map_presets[game.GetMap()].plugindata.townnpcs, game.GetMap())
ix.plugin.Get("vendor_adv"):SaveData()
```

This creates only absent preset vendors at their authored starting positions and saves the result.
Existing vendors, field sites, containers and progression remain in place. Recovered vendors use their
current template appearance and stock. Existing saved alternate choices apply on the next restart;
the command does not import newer point definitions from the preset. Do not rerun full FTS to recover NPCs.

## Hideout setup

`/FTSDumpPluginData` includes reusable hideout setup in the server's
`garrysmod/data/FTSDump/hideouts.txt`. Remove the `hideouts` heading and paste the remaining
fields inside the map preset's `plugindata["hideouts"]` table. All four bundled presets provide
an empty table for this data; no hideout coordinates or shells are shipped by this integration.

The export includes allocation areas, template definitions and manual points/container recipes,
fixed exterior entrances, personal trader locations, and the outside recovery position. It excludes
owned rooms, inventories, guests, purchases, furnishings, squad-placed entrances, and allocation history.
Template markers remain in the AdvDupe2 shell. Copy every referenced shell file separately to the
destination server's `AdvDupe2.DataFolder/STALKERDupes/` directory.

FTS imports only the current map's setup. Existing definition IDs and an existing recovery point win;
missing IDs are added. This preserves bindings for owned rooms and saved storage slots. Omitted or
empty hideout data changes nothing. To revise an existing definition, use the hideout setup commands.

Nonempty imports require loaded hideout data and no loaded/loading/saving hideout instances. New
definitions, references and shell files are validated before saving or populating FTS world entities.
A failed save restores the previous in-memory setup and stops FTS. Successful imports immediately
refresh exterior keypads. Refer to the [hideout setup guide](../hideouts/README.md) for placement and
geometry checks. Do not rerun full FTS on an initialized map merely to update hideout setup.

## Export persistent map entities

Run `/FTSDumpPersistentEntities` as an administrator. The command writes
`garrysmod/data/ftsdump/<map>_persistent_entities.txt` **on the server** and reports the count
and path. Each run replaces that map's previous dump. There is a five-second server cooldown.

The file contains a complete `entities = { ... },` field. Replace the corresponding field
inside `PLUGIN.map_presets["<map>"]` with it, or merge its records into the existing field.
Do not add a second `entities` field to the same preset. New preset files also need an explicit
include in `sh_plugin.lua`.

The dump reads current live entities registered with Helix's **Make Persistent** property.
Removed entities, entities whose persistence was stopped, and duplicate registrations are
excluded. It captures current edits without saving, spawning, removing, or otherwise changing
the map. Plugin-owned containers, vendors, spawn points, and other independently saved data
still use their existing FTS sections and export commands.

Exported records preserve class (including `ClassOverride`), position, angles, model, skin,
RGBA color, render mode/effects, material, submaterials, bodygroups, model scale, collision
group, and physics movement state. A `prop_physics` colored with the Color tool therefore
restores its tint and transparency, including the render mode required for transparency.
For `prop_effect`, appearance is read from/restored to its attached visual entity when present.
This is a snapshot of entity placement and appearance; it does not copy arbitrary Lua state,
inventories, constraints, parenting, or individual ragdoll bone poses.

FTS registers exported records (`persistent = true`) with Helix persistence when spawning them.
Legacy records containing only `class`, `position`, and `angles` still work and retain their
original frozen default. New records can explicitly set `movable = true` or `false`.
After spawning, later restart behavior follows the bundled Helix persistence implementation;
it does not save render mode/effects or model scale, although these are restored by FTS.

## Verification

Run from the repository root:

```sh
luatex --luaonly tests/fts_entities_spec.lua
luatex --luaonly tests/fts_hideouts_spec.lua
luatex --luaonly tests/fts_vendors_spec.lua
```

The standalone spec checks generated Lua round trips, Color tool appearance, zero-indexed
bodygroups/submaterials, movement, persistence registration/filtering, legacy presets,
command registration, cooldowns, and failed writes/creation. It uses mocks.

The hideout spec checks setup export/import and Lua round trips, ownership/inventory isolation,
existing-ID preservation, unloaded-instance checks, malformed definitions, missing/rejected shell files,
failed-save rollback, and stopping FTS before world population on invalid hideout data.

The vendor spec checks that every Swamps contact with alternate positions has a unique vendor placement,
that its template exists, that its starting transform matches the authored point, and that FTS saves
all spawned vendors before returning. Verify recovery and an immediate restart in multiplayer as well.

In a multiplayer development session, mark a colored/translucent `prop_physics` persistent,
dump it, and inspect the server-side file. On a disposable test map, restore an exported
record with `SpawnEntity` and compare appearance, collision, movement, and its persistence
property. Check a legacy entity and `prop_effect` too. Do not rerun first-time world setup
or reset persistence as a routine validation step.
