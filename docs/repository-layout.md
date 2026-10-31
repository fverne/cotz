# Repository layout

The repository contains the CotZ schema, a bundled Helix framework, shared Garry's Mod resources,
developer tools, and inactive reference code. The October 2026 organization pass inventoried all
2,432 files outside Git metadata and relocated 252 files: 67 active files and 185 inactive files.
Moved Lua files retain their original contents; loaders, documentation, and tooling use the new paths.

| Location | Contents and placement rules |
| --- | --- |
| `gamemodes/helix/` | Bundled framework. Keep its upstream structure and loader conventions. |
| `gamemodes/ix_cotz/gamemode/` | Gamemode entry points. |
| `gamemodes/ix_cotz/entities/` | Schema overrides of Helix entities and weapons. Names are registered class IDs. |
| `gamemodes/ix_cotz/schema/` | Schema hooks, metadata, factions, language, interfaces, and shared libraries. |
| `gamemodes/ix_cotz/schema/items/` | Active item definitions and bases. Immediate folder names select `base_<folder>`. |
| `gamemodes/ix_cotz/plugins/` | Gameplay systems. Folder names and standalone filenames are persistent plugin IDs. |
| `lua/autorun/` | Automatically loaded entry points for bundled resources. |
| `lua/cw/`, `lua/ecw/`, `lua/tfa/` | Weapon framework support at paths expected by those frameworks. |
| `lua/entities/`, `lua/weapons/`, `lua/effects/` | Registered entities, SWEPs, and effects; paths determine class names. |
| `lua/stalkernpcbasevars.lua` | Shared NPC definitions included by the NPC autorun files. |
| `docs/` | Project guides and balance tooling, inputs, historical baselines, and tests. |
| `tests/` | Standalone Lua regression checks. |
| `.github/workflows/` | Balance export, import, and validation automation. |
| `archive/` | Inactive source retained for reference, outside runtime discovery directories. |

## Gameplay supporting files

Paths below are relative to `gamemodes/ix_cotz/plugins/`.

| Location | Purpose |
| --- | --- |
| `jobsystem/definitions/` | Repeatable item, kill, and special job definitions. |
| `jobsystem/libs/` | Job API and shared/server task reward implementation. |
| `jobsystem/integrations/sh_dialogue.lua` | Task offers, reward choices, and their dialogue networking. Formerly `dialogue/libs/sh_taskrewards.lua`. |
| `townnpcs/definitions/` | Editable town contact jobs, sparse progression trees, dialogue prompts, pools and field sites. Installed after existing registries load; see the plugin README. |
| `progression/definitions/` | NPC milestones, shared definitions, and requirement pool data. |
| `progression/libs/` | Progression state, requirements, rewards, services, and world unlock APIs. |
| `randomitem/pools/` | Weighted loot tables for world spawns, caches, rewards, vendors, and events. |
| `randomitem/libs/sh_randomitems.lua` | Random item selection API and explicit pool loading. |
| `firsttimesetup/presets/` | Map-specific setup data, loaded explicitly by `sh_plugin.lua`. |
| `dialogue/libs/` | Dialogue registration, option ordering, and conversation APIs. |
| `vendor_adv/definitions/` | Individual vendor appearances, identities, base items and dialogue bindings; explicit includes in libs/sh_npctemplates.lua. |
| `dialogue/libs/sh_towncontacts.lua` | Shared current town work/progression actions; NPC root actions are declared in conversation files. |
| `dialogue/dialogue/` | NPC conversation definitions, discovered by the custom dialogue loader. |
| Other plugin `items/`, `entities/`, `derma/`, `libs/` | Files owned by the corresponding gameplay feature. |

Schema libraries formerly named after their authors now have functional names:
`schema/libs/sh_gameplay.lua` contains general gameplay helpers and commands, and
`schema/libs/sh_util.lua` contains shared utility overrides and turn-in valuation.

## Loading constraints

Helix includes a plugin's `libs/` and `derma/` files and discovers its items and entities before
running `DoPluginIncludes` and then its `sh_plugin.lua`. Definitions and presets have explicit
includes in their owner's entry point, in the original order. Loot pools have explicit shared
includes in `sh_randomitems.lua`; files without realm prefixes need the explicit `"shared"` argument.

The dialogue library explicitly loads the job reward integration before registering its
`DoPluginIncludes` callback. That order lets NPC conversations receive reward topics during their
initial registration, even though the job system plugin loads later. Loading the integration only
from `jobsystem/sh_plugin.lua` would miss those conversations.

Standalone plugins remain at the plugin root. Helix loads folders before standalone files, so
converting every standalone plugin to a directory would change initialization order. Plugin IDs
also select persisted data and enabled/disabled settings.

Item folders such as `newammo`, `newbags`, and `newweapons` retain their names because those names
select `base_newammo`, `base_newbags`, and `base_newweapons`. Item files retain their names and
base relationships. Entity and weapon framework paths likewise remain stable. New organizational
folders inside `items/` cannot be assumed to load recursively.

`schema/items/valuables_test/` contains the 378 implemented items listed in the combined valuables
and supply/job workbook. The `recovery_` and `supply_` filename segments have been removed,
which also changes their filename-derived item IDs. The kerosene container uses
`value_kerosene_container` to avoid the existing `value_kerosene` ID. Its `base_valuables_test` base
inherits `base_valuable`, so Helix discovers the folder normally and retains the shared valuable
mechanics. The workbook's existing-item comparator tab is reference data, not part of this group.

## Archive

- `archive/plugins/`: the former `!unused plugins/` tree (90 files).
- `archive/effects/`: the former `lua/effects_backup/` tree (6 files).
- `archive/items/`: former `old/` and `oldv2/` subfolders under kits, suits, and artifacts (89 files).

Those nested item versions were already outside Helix's item discovery depth. They remain inactive.
Do not restore archived code by copying the entire archive into a live item or plugin directory;
review its identifiers and dependencies first.
