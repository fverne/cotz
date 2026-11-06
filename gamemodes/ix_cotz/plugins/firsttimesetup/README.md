# First Time Setup

Map presets in `presets/` are explicitly included by `sh_plugin.lua`. Each preset supplies
`containers`, `entities`, `vendors`, and `plugindata`. The server implementation of generic
entity export and spawning lives in `sv_entities.lua`.

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
```

The standalone spec checks generated Lua round trips, Color tool appearance, zero-indexed
bodygroups/submaterials, movement, persistence registration/filtering, legacy presets,
command registration, cooldowns, and failed writes/creation. It uses mocks.

In a multiplayer development session, mark a colored/translucent `prop_physics` persistent,
dump it, and inspect the server-side file. On a disposable test map, restore an exported
record with `SpawnEntity` and compare appearance, collision, movement, and its persistence
property. Check a legacy entity and `prop_effect` too. Do not rerun first-time world setup
or reset persistence as a routine validation step.
