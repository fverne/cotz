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

The client schema library `schema/libs/cl_cotzui.lua` owns shared COTZ UI styling. It loads before
gameplay plugins through the existing library loader. See [UI and HUD style](ui-style.md).

`schema/meta/sv_character.lua` is explicitly included by `sh_schema.lua`. Its owner-sync override
keeps legacy personal vendor stock/history keys out of the initial character network payload;
other recipients retain Helix's normal visibility rules.

Progression and personal vendor stock now use separate large character vars. Their owning plugin
libraries register them; `schema/sv_schema.lua` supplies the SQL type before plugins load.
See [character storage](database/README.md) for the fresh-database deployment requirement.

The schema character loader in `schema/derma/cl_charload.lua` disables character actions for an empty
selection and revalidates selection after its slide animation. Deletion acknowledgements refresh the
list and return an empty loader to the main menu. Run `luatex --luaonly tests/character_menu_spec.lua`;
also verify last-character deletion, creation and deletion during selection transitions in multiplayer.

For item descriptions and NPC prose, read the [writing guide](writing-guide.md) and its
[curated references](writing-references/README.md). Detailed examples live in the repository;
NPC-specific voice notes remain in the existing [contact profiles](npc-overhaul/contacts/README.md).

## Gameplay supporting files

Paths below are relative to `gamemodes/ix_cotz/plugins/`.

| Location | Purpose |
| --- | --- |
| `jobsystem/definitions/` | Editable job definitions, field point pools/mechanics, reward settings and kill-credit rules. |
| `jobsystem/libs/` | Early definition bootstrap, shared registry/field APIs, tool-job callbacks and task rewards. |
| `jobsystem/sv_*.lua` | Explicitly loaded character jobs, NPC offers, field assignment/actions/runtime and cargo protection. |
| `jobsystem/integrations/sh_dialogue.lua` | Task offers, reward choices, and their dialogue networking. Formerly `dialogue/libs/sh_taskrewards.lua`. |
| `townnpcs/definitions/` | Editable town contact jobs, sparse progression trees, dialogue prompts, pools and field sites. Installed after existing registries load; see the plugin README. |
| `progression/definitions/` | NPC milestones, shared definitions, and requirement pool data. |
| `progression/libs/` | Progression state, requirements, rewards, services, and world unlock APIs. |
| `randomitem/pools/` | Weighted loot tables for world spawns, caches, rewards, vendors, and events. |
| `randomitem/libs/sh_randomitems.lua` | Random item selection API and explicit pool loading. |
| `firsttimesetup/presets/` | Map-specific setup data, loaded explicitly by `sh_plugin.lua`. |
| `dialogue/libs/` | Dialogue registration, option ordering, and conversation APIs. |
| `vendor_adv/definitions/` | Individual vendor appearances, identities, base items and dialogue bindings; explicit includes in libs/sh_npctemplates.lua. |
| `mutantdefense/` | Admin-started wave defense, character reward delivery and the restock voucher item; dialogue integration lives in `dialogue/integrations/sh_mutantdefense.lua`. |
| `dialogue/libs/sh_towncontacts.lua` | Shared current town work/progression actions; NPC root actions are declared in conversation files. |
| `dialogue/dialogue/` | NPC conversation definitions, discovered by the custom dialogue loader. |
| `hideouts/sv_*.lua` and `sh_*.lua` | Personal/squad interiors, trader location claims and progression purchases, specialized containers, floor allowances, rank access, squad shop, economic adapter and saved travel. |
| `sherpas/` | Reusable player/squad quartermasters, instance trading panel, stock persistence and dialogue; retains plugin ID `sherpas`. |
| Other plugin `items/`, `entities/`, `derma/`, `libs/` | Files owned by the corresponding gameplay feature. |

`gearcustomization/` owns the vendor appearance service, shared appearance API, menu
and icon rendering. Concrete `gear` and `newbags` items declare approved variants.
The standalone schema PAC integration carries equipped instance descriptors; see the
[gear customization guide](../gamemodes/ix_cotz/plugins/gearcustomization/README.md).

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

Each concrete item declares `ITEM.longdesc` beside its regular description. The regular description
identifies the item; the long description adds background, sensory detail, or context without copying
that identification. Keep item-specific prose in the definition, and preserve live readings, saved
descriptions, and instructions when extending a custom `GetDescription()`. Inventory descriptions
include the extra prose; world descriptions retain their existing shorter presentation.
Check coverage and custom description rendering with `luatex --luaonly tests/item_descriptions_spec.lua`.

Cooked meal definitions declare prices at 120% of their corresponding raw meat's current `ITEM.price`,
using the raw item's `ITEM.meal` mapping. Both bases price by weight, and cooking preserves that weight.
Keep these prices explicit in each concrete definition when retuning the meat and meal families.

The 378 implemented items listed in the combined valuables and supply/job workbook are split across
`schema/items/valuables_test/`, `schema/items/valuable/`, and `schema/items/quests/`.
The `recovery_` and `supply_` filename segments have been removed, which also changes their
filename-derived item IDs. The kerosene container uses `value_kerosene_container` to avoid the
existing `value_kerosene` ID. `base_valuables_test` and `base_quests` inherit `base_valuable`,
so Helix discovers both folders normally and retains the shared valuable mechanics.
The 36 related boxes, bags, carriers, and smaller containers moved to `valuable/`; 82 selected
quest candidates moved to `quests/`. See [quest item candidates](quest-items.md) for their inventory
and selection criteria. These moves preserve filenames and item IDs. Quest IDs are excluded from ordinary loot and job hand-in pools. Bound town commission variants now reuse selected quest assets with separate `town_quest_*` IDs;
see [quest commissions](npc-overhaul/quest-commissions.md). Original valuable IDs are unchanged.
The workbook's existing-item comparator tab is reference data, not part of this group.

## Archive

- `archive/plugins/`: the former `!unused plugins/` tree (90 files).
- `archive/effects/`: the former `lua/effects_backup/` tree (6 files).
- `archive/items/`: former `old/` and `oldv2/` subfolders under kits, suits, and artifacts (89 files).

Those nested item versions were already outside Helix's item discovery depth. They remain inactive.
Do not restore archived code by copying the entire archive into a live item or plugin directory;
review its identifiers and dependencies first.

Sherpas moved from `plugins/sherpas.lua` into `plugins/sherpas/` under the same plugin ID. Folder loading
now registers its derived entities/dialogue before standalone plugins; runtime access to hideouts and
advanced vendors is resolved after all plugins load. Its client trading panel resolves `ixVendorAdv`
when opening a window, after advanced vendor panels exist. See the [Sherpa guide](../gamemodes/ix_cotz/plugins/sherpas/README.md).

Command registration metadata belongs in shared loading so Helix chat completion can discover it.
Equipment, progression, job-reset and town command handlers remain server-side. `corechanges` owns
shared deployment defaults; schema `libs/sh_spawnpolicy.lua` provides map-threshold registration and
lookup. `eventcontroller/sv_combat.lua` owns encounter packs, combat eligibility and human regrouping;
`sv_performance.lua` retains mutant population accounting, spawn queues and maintenance scheduling.

Mutant attacks in `lua/entities/npc_mutant_*/` must support NPC enemies and target loss during windup.
Camera, stamina and freeze effects require player targets; grabs retain their own victim reference and
validate it before delayed effects or release. Controllers and spiders finish recovery after target loss;
Karlik projectiles use a local forward aim point when their target disappears.
Run `luatex --luaonly tests/mutant_target_safety_spec.lua`,
`luatex --luaonly tests/burer_stamina_spec.lua`, `luatex --luaonly tests/karlik_teleport_spec.lua` and
`luatex --luaonly tests/npc_combat_spec.lua`. Also verify mutant-versus-NPC fights, target removal during
windup, and player release after grabs or mutant death in multiplayer.

`lua/entities/stalker_ai/schedules.lua` owns mutant unreachable-target grace, bounded position retries,
and recovery when targets move or return to melee range. Run `luatex --luaonly tests/mutant_navigation_spec.lua`
alongside the combat and population suites; verify static-prop encounters in multiplayer.
