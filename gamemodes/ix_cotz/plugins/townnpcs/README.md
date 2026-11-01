# Town NPCs

The town plugin owns 27 contacts and 646 finite objectives. Arena Master lives in Marsh
(rp_marsh_cs), Garbage uses mz_garbage, and Waystation uses rp_waystation. Pripyat
(rp_pripyat_remaster) is a task destination without permanent town NPCs.

## Definition ownership

| Edit | Source |
| --- | --- |
| Home map, contact access, jobs, reward items, catalogue, task dialogue and progression | definitions/sh_<contact>.lua in townnpcs |
| Default payouts, stock and interaction limits | townnpcs/definitions/sh_config.lua |
| Equipment upgrade families | townnpcs/definitions/sh_equipment.lua |
| Field-site defaults | townnpcs/definitions/sh_sites.lua |
| Shared requirement pools | progression/definitions/sh_requirementpools.lua |
| Introduction, background, advice, gossip, ordinary trade/service responses | dialogue/dialogue/sh_<dialogueid>.lua |
| Shared town action callbacks | dialogue/libs/sh_towncontacts.lua |
| Shared trade callback | dialogue/integrations/sh_trade.lua |
| Appearance, identity, base items and dialogue binding | vendor_adv/definitions/sh_<contact>.lua |
| Template stock assembly and placed-vendor stock handling | vendor_adv/libs/sh_towncontacts.lua |
| Progression state, requirements, rewards and service mechanics | progression/libs/ |

The [contact directory](../../../../docs/npc-overhaul/contacts/README.md) links the contact definitions.
Contact IDs use hyphens, filenames use underscores. Keep template IDs, dialogue IDs, item IDs and
progression IDs stable after deployment.

Each contact file has one authoritative catalogue table. Item keys name a local progression step
and six vendor terms: price, initial stock, trade mode, maximum stock, refill interval, refill amount.
Purchase permission is distinct from a free item. Shared upgrade families enforce earlier-tier
milestones even when sellers differ, including Old Timer OT12 before Quartermaster's knife4.
The [equipment index](../../../../docs/npc-overhaul/unlock-ledger.md) lists current allocations.

## Loading and plugin structure

Plugin methods use PLUGIN:MethodName and self. Libraries capture the owning PLUGIN for callbacks.
ix.townNPCs is a reference to that same plugin for cross-plugin integrations. Private helpers are local.
InitializeTownCharacter intentionally does not use the engine Initialize hook name.

Contact/configuration files have explicit shared includes. At InitializedPlugins, the town plugin
registers progression and jobs, configures field sources, then binds contacts to dialogue and vendor
registries. Dialogue owns action handlers; vendor_adv owns template and stock handling. NPC root
menus are declared directly in conversation files. There is no obsolete-topic filtering or fallback
copy of another NPC's conversation.

## Progression and work

Each contact has an explicit sparse tree: a short introduction, two narrow branches and a joined
conclusion. The requires and crossRequires fields describe local and cross-contact prerequisites;
equipment families can add further dependencies. Stable IDs look like cotz/town/quartermaster/QM11.
Approximately half the objectives are item hand-ins or cumulative job checkpoints. Checkpoints
usually require 2/5/9/14/20/27/35 completed jobs with that contact. Finite commissions do not count
as ordinary repeatable work and do not award an extra repeatable cash/reward/restock payout.

job.kind selects one repeatable specialty. Its category must be unique on the home map. Delivery
pools, quantities and minimumValue tune hand-ins. job.maps selects field destinations per difficulty.
job.rewards can override money/reputation per difficulty; defaults live in sh_config.lua.
contact.supplyStock can override initial, maximum, interval and amount for that NPC.
Only delivery jobs declare pools and delivery tiers. Quantities apply to deliveries, eliminations and
computer extraction; destination maps apply to field jobs. Omit settings ignored by the selected kind.
The supplies list serves both the task reward profile and ordinary vendor stock.

Spoken task text stays in the contact's dialogue and progression fields. step.objective separately
explains the actual field interaction. Mute communicates through written lists and gestures.
Flavour stays under **Can I ask you something?**; actions and services stay at the root.

## Persistence

Only current progression IDs grant access. There is no import of old completion IDs, numeric effort,
stock identities, old arena opponents or saved assignments from removed definitions. There are no
version converters, grandfathered prerequisites or compatibility completion aliases. Removing these
paths does not erase database rows; obsolete saved data is not interpreted as current progression.

Current counters, paid claim serials, distinct arena opponents and pending commission completions
remain character-owned under townNPCProgression. Pending completions resume after interruption;
progression benefit tokens prevent duplicate benefits. Full-inventory rewards stay pending through
the existing progression claim system. This is current runtime recovery, not a migration service.
Independent database writes are not transactional; multiplayer stop/reconnect checks are required.

Secret periodic Hoarder and other standalone non-town content retain their own definitions in the
progression plugin. Superseded town progression files and job/progression conversation topics are deleted.

## In-game setup

Restart after updating the files. Existing entity positions are not guessed or automatically moved.

- /TownNPCPlace <contact-id> places and saves a contact on its home map, avoiding duplicate identities.
- /TownNPCAddFieldPoint <kind> records your position; /TownNPCRemoveFieldPoint <kind> removes the
  nearest matching point within 128 units. Kinds: recovery, sensor, triangulation, deadDrop, defence.
- /TownNPCExportFieldPoints prints shared Lua definitions for definitions/sh_sites.lua. Deploy those
  definitions to every map server; local saved points override their corresponding map.
- Dead drops need two endpoints at least 2,048 units apart. Defence needs a site and usable approaches
  512–4,096 units away with navigation and safe clearance. Author Pripyat sites without town contacts.
- Existing saved Pripyat vendors require manual removal and saving. Do not rerun first-time setup.

Field stories use existing configured point pools and bound cargo. Multi-site investigations,
individual evidence items, rescue actors and visible town upgrades are not implemented by their prose.
New NPC models remain replaceable placeholders. Place and playtest sites before deployment.

## Verification

Run from the repository root:

    luatex --luaonly tests/townnpcs_spec.lua
    luatex --luaonly tests/progression_spec.lua
    luatex --luaonly tests/dialogue_order_spec.lua
    luatex --luaonly tests/task_rewards_spec.lua
    luatex --luaonly tests/vendor_stock_spec.lua
    luatex --luaonly tests/progression_services_spec.lua
    luatex --luaonly tests/field_tasks_spec.lua

The suites cover current graph/catalogue references, distinct specialties, contact access, actual
conversation/template registration, inventory/reward edge cases, replay protection and interruption
recovery. Removed town definitions are not loaded as test fixtures. Mocks do not establish GMod
loading, networking, VGUI, navigation or database correctness. Verify these with multiplayer clients,
four-map travel, placement/save/restart, every job family and representative current character saves.

Smartass lives in Waystation and offers computer data extraction with an issued flash drive
(1/2/5 distinct computer types for easy/medium/hard). Spool lives in Garbage and retains radio
triangulation. Existing placed vendors must be manually relocated and saved after this change.
Finite commissions and progression IDs remain unchanged.

The [valuables hand-in catalogue](../../../../docs/valuable-hand-in-pools.md) reviews every
`valuables_test` item and defines 50 reusable `valuables_*` pools in progression’s `definitions/sh_requirementpools.lua`.
Repeatable delivery contacts enable selected pools by difficulty; finite progression slots retain their existing pools.
Run `luatex --luaonly tests/valuable_pools_spec.lua` to check full item coverage and valid candidates.

## Regional valuable deliveries

All twelve item-delivery contacts retain their existing requests and add `job.deliveryTiers`.
Each difficulty lists additional pools and a whole-item quantity: one for easy/medium, two for hard.
These additions bypass the legacy minimum-value floor, which would inflate cheap whole-item requests.
Job IDs, accepted assignments and finite progression stay unchanged. Quantity-bearing items instead
use acquisition batch bounds: easy = smallest batch, medium = largest batch, hard = largest batch + 1.
These bounds override quantity/value floors. World, breakable-box, human-pocket and cache loot data overrides are
combined across regions; `settings.spawnBatches` records random `OnInstanced` yields where capacity
differs from the initial amount. Update that table when those item callbacks change. Ammunition
without `ITEM.quantity` retains its existing whole-box counting and request amounts.
Delivery maps are acquisition guidance, not a restriction on where an item must be found.

| Contact / home | Easy additions | Medium additions | Hard additions |
| --- | --- | --- | --- |
| Gasket / Marsh | Cleaning, fuel | Filtration, electrical stock | Portable power, reinforced cases |
| Jitters / Marsh | Clinical stock | Trauma stock, medical equipment | Research injectors |
| Technut / Marsh | Workshop consumables, drivers/wrenches | Tools, cutting tools, repair parts | Instruments, control electronics |
| Mute / Marsh | Components, power | Radios, radio parts, flash media | Computers, controls, archives, recording equipment |
| Spicy Lemon / Marsh | Provisions | Provisions | Provisions |
| The Original / Marsh | Personal effects, music cassettes | Collectibles, faction patches | Irregular patches, specialist cases |
| Latch / Garbage | Tools, drivers/wrenches, repair parts | Consumables, transit cases, electrical stock | Reinforced/secured cases, instruments |
| Brass / Garbage | Equipment pouches | Military cases | Ordnance salvage |
| Suture / Waystation | Textiles, pouches | Protective textiles | Armour panels |
| Carbon / Waystation | Office/field records, printed material | Official/technical records | Research records, data archives |
| Quartermaster / Waystation | Military cases, pouches | Ordnance salvage, official records | Secured cases, control electronics |
| Egghead / Waystation | Sample carriers, survey gear | Research samples/records | Instruments, research injectors |

Easy additions favour home-region themes. Pools contain alternatives with different acquisition routes,
so a particular request can still require travel. Medium workshop requests favour Garbage/Waystation;
hard electronics and research requests favour Pripyat. Pocket effects, insignia and military records
can require human corpse loot; some technical/research records require hidden caches. Recovered
medical stock, provisions and ordnance remain valuable objects with no implied consumable functionality.
Acquisition frequency and the smaller payouts on cheap additions still need multiplayer playtesting.
