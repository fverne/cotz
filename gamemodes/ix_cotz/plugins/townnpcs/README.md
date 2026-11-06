# Town NPCs

## Repeatable roster, 6 November 2026

The [implemented job revision](../../../../docs/npc-overhaul/repeatable-jobs.md) supersedes earlier
repeatable categories, reward defaults and scientist homes below. Mute additionally offers triangulation
in Swamps / Waystation / Pripyat (3 / 4 / 5 readings). Twenty workbook rows use nineteen
issuers because Atlas alternates mutant/anomaly photography. Beanstalk, Egghead and Intern remain
in the gated Swamps Eco Bunker (`rp_marsh_cs`). New reference cash is 1,000/2,000/3,000
and reputation 15/25/35. Shops, services, purchase restrictions and themed rewards remain.
Jitters owns the Swamps specimen requests; The Original is unused and has no new offers.
His superseded regional definitions remain completion-only without restoring his world placement.

Concrete contacts declare current `job` and completion-only `legacyJob` data. The regional job library
builds new `cotz/town/v2/` offers and rejects new acceptance of old identities. The retained old delivery
pools also preserve thematic incoming receivers and starting buy assortments. Finite progression is
not remapped: inactive issuers' cumulative job checkpoints can stall until the separately deferred
progression rework. The guide identifies those contacts and the resulting fresh-character limitation.

Update every map server together and restart. Retain all three scientists' existing bunker placements;
do not rerun first-time setup. Missing scientists can be placed inside the Swamps bunker with
`/TownNPCPlace <slug>`. Offline tests do not verify navigation, placement or live persistence.
Beanstalk retains research defence; Egghead retains Garbage/Waystation/Pripyat specimen requests.
All three declare `bunker = true`, excluding them from Brass's easy couriers and including them in hard
couriers. Saved incoming deliveries resolve their current Swamps home without rerolling assignments.

## Completion-time repeatable rewards

Reward candidates are defined in each contact's `rewards` table, independently of shop stock.
Regular choices are revealed at completed hand-in; bonus choices are revealed once earned.
New town rewards contain consumables or limited-use items, stash spawners, euros and dollars.
Reusable equipment, attachments, service credit and other valuables are excluded.
Every ammunition reward is half its normal pack. Old Timer offers .410 rather than 12g or .22;
Cleaner keeps cutlery and cleaning kits as regular choices and stash spawners as bonus choices.
Spicy Lemon also offers cutlery. Mute, Spool and Ballast offer 200/400/600 rubles as their regular
reward and euros/dollars as their bonus. Normal job payment remains separate.
See the [jobsystem reward guide](../jobsystem/README.md#task-rewards-and-existing-kits) for the full
policy, profile fields, bonus accounting, saved-offer migration and regression checks.

## Approved workbook plan, 4 November 2026

The [vendor plan](../../../../docs/npc-overhaul/vendor-plan.md) supersedes the earlier seller,
starting-supply and reward-allocation descriptions below. The optional workbook unlock ideas are not enabled.
There are 25 finite contact trees and 600 active milestones. The Original and Arena Master remain
contacts with ordinary work, but neither has finite progression or progression purchase routes.

Concrete contacts declare `difficultyMultiplier`. Compilation multiplies delivery quantities and
cumulative job targets, rounding up to whole units. Field milestones require that many separate trips.
Repeatable job quantities, combat strength, recording duration, cash and item prices are unchanged.
Existing assigned requirements and partial contributions keep their saved values. Completed milestones
remain completed. Commission counts and pending completion values are saved with the existing claim journal.

The 25 planned contacts have empty `supplies`. Their current delivery candidates become starting
BUYONLY rows. A requested catalogue item is BUYONLY until its seller-specific milestone is earned;
other earned catalogue items are SELLONLY. The server enforces both purchase and sale assortments,
including stale vendor rows. Template assembly and saved-vendor refresh apply the approved catalogue.
Character-owned stock histories are retained and clamped by the existing stock policy, not reset.

Carbon sells `accesscard_bunker`; Intern sells `accesscard_laboratory`. Their existing physical-door
actions are retained. Beanstalk, Egghead and Intern now have Marsh as their home, at the Eco Bunker.
Place them there with `/TownNPCPlace <slug>` after removing and saving their old placements.
NPC conversation access remains independent, so existing courier work does not acquire circular gates.
Accepted deliveries resolve a named contact's current home while retaining their saved assignment.

Ballast BA12 opens the existing character bank as hideout storage, retaining its inventory and paid size.
Vesper owns suit conversion milestones and the paid conversion menu. Conversions require an owned,
unequipped suit without attachments and temporary inventory room. The input, condition and money remain
safe while item insertion is pending; failures permit a retry without consuming the suit or fee.

Mute unlocks existing STALKERnet tools at MU01 (search), MU03 (squad filter), MU07 (ranking), MU11
(basic activity), MU15 (locations), MU19 (remote roster) and MU23 (full dossier). Existing emission
warnings and broadcasts retain MU09/MU15. Remote roster payloads are filtered for the receiving
character on the server; the local roster and UI use the same gates. Voice mute remains available.

Deploy all map servers together and restart. Do not rerun first-time setup or reset saves.
Run the existing progression/vendor suites and `luatex --luaonly tests/vendor_plan_spec.lua`.
Verify scientist placement, both access-card doors, all three trade modes, repeated commissions,
conversion retries, personal storage and STALKERnet unlocks with fresh and existing characters in multiplayer.

The town plugin owns 27 contacts and 624 active finite objectives. Arena Master lives in Marsh
(rp_marsh_cs), Garbage uses rp_garbage_cotz, and Waystation uses rp_waystation. Pripyat
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

## Catalogue spacing

The first milestone at each active trader unlocks one or two purchases. The 131 formerly crowded
introductory purchases are spread through later milestones at the same seller, including provisions,
weapons, tools and equipment. Starter water remains ungated. Ammunition keeps its generated price-band
schedule, introductory regional medicine remains early, and author-disabled suggestions remain excluded.

Existing stock rewards keep their items and amounts. Catalogue compilation makes each stock milestone
require its own seller's purchase milestone when needed, including across sibling story branches.
This prevents an early stock improvement from awarding unusable capacity after a purchase is moved.
The authored objective requirements are retained; compiled purchase prerequisites may connect branches.
Run `luatex --luaonly tests/catalogue_stock_order_spec.lua` for the sibling-branch stock gate regression.
The unlock ledger lists the resulting purchase positions.

## No progression item gifts

Completion and checkpoint gifts are removed from all town and standalone progression, including
inactive Arena Master references. Progression definitions cannot declare item gifts, and benefit
handlers no longer queue them. Old saved progression gift queues and offers cannot be claimed or
shown in progression menus; their stored history and already received inventory items are retained.
Repeatable job packages, their pending claims and task bonuses are unchanged. Cash, service credits,
discounts, purchase/conversion unlocks, stock and capacity upgrades remain.

Restart servers to apply this policy. Validate gift suppression, service credits and repeatable job
claims with `tests/progression_spec.lua`, `tests/progression_services_spec.lua` and
`tests/task_rewards_spec.lua`. Multiplayer verification of old saves and UI remains required.

## Author-disabled suggestions

Commented-out catalogue suggestions are deliberate exclusions. Each affected contact's `disabledItems`
records the same item IDs so runtime code can enforce that intent. Do not uncomment, redistribute or
restore them through ordinary supplies, stock bonuses or generated catalogues. The offline audit checks
that the exclusions match the comments and that no active catalogue, supply or stock entry restores them.
Update both the comment and exclusion only when explicitly authorised to restore that suggestion.

The 61 current exclusions include mission/access equipment, human meat and The Original's proposed
specimen/hide shop. Twelve remaining stock references to excluded equipment have been removed without
replacement rewards. Accepted jobs, progression IDs and TODO plans are preserved.
Template assembly and saved-vendor refresh remove excluded rows, and purchase checks also reject stale
rows. Personal stock history and owned items are retained; no character data reset is performed.

Run `luatex --luaonly tests/disabled_town_items_spec.lua` for exclusion enforcement and refresh checks.
NBC is the introductory suit at Beanstalk BN01, with no suit prerequisites. It precedes the other
suits in the upgrade chain, resolving the former Beanstalk/Boss/Vesper cycle. The current ledger reports actual coverage after the author's exclusions; 31 active milestones
currently have no implemented unlock. These are review findings, not permission to restore
excluded suggestions or automatically add filler stock.

## Starting water and later provisions

Every town contact starts with clean and dirty bottled water available without progression. Clean
water has one bottle of initial stock and a base maximum of one under the vendor stock policy;
dirty water replaces bread in ordinary starting supplies and keeps the existing drink policy.
Earlier bread-capacity milestones now increase dirty-water capacity. Clean-water capacity milestones
remain useful: earned bonuses can increase the personal maximum above one without an immediate refill.
Water purchase gates are removed because both kinds are starting supplies. Existing bread purchase
routes remain earned provisions, with former first-step routes moved to the third local milestone.
Repeatable reward packages and future TODO terms are unchanged; progression gifts are removed.

The vendor policy applies to newly populated templates and saved vendor catalogues on load. Existing
personal stock is clamped to the new base plus earned capacity through the existing stock system;
no character or world data reset is required. Restart map servers to refresh the changed stock and
starting supply rows. Verify fresh and progressed characters, depleted stock and refill in multiplayer.

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

All town contacts are accessible without completing another contact's progression. They can be placed
on their home maps immediately; task prerequisites, catalogue unlocks and service benefits still apply.

Each contact has an explicit sparse tree: a short introduction, two narrow branches and a joined
conclusion. The requires and crossRequires fields describe local and cross-contact prerequisites;
equipment families can add further dependencies. Stable IDs look like cotz/town/quartermaster/QM11.
The active trees include 156 field commissions after converting half of the original 316 to ordinary deliveries.
Each contact converts half its field commissions, rounded where needed. Arena bouts are unchanged.
Of the remaining field commissions, 152 declare custom bound quest cargo: 112 return it to the issuer,
37 deliver it to another contact, and three use field caches. Four retain research-defence cargo.
See the [commission and delivery inventory](../../../../docs/npc-overhaul/quest-commissions.md)
for every assignment and the converted steps' pools and quantities. Converted steps preserve their
IDs, prerequisites, cash and benefits, and use the normal saved specific-item hand-in requirements.
Completion-only registrations allow already accepted field assignments and pending completions to
settle their original milestone once; new players receive the delivery request instead.
The other objectives are item hand-ins, cumulative job checkpoints and arena bouts. Checkpoints
usually require 2/5/9/14/20/27/35 completed jobs with that contact. Finite commissions do not count
as ordinary repeatable work and do not award an extra repeatable cash/reward/restock payout.

job.kind selects one repeatable specialty. Its category must be unique on the home map. Delivery
pools, quantities and minimumValue tune hand-ins. job.maps selects field destinations per difficulty.
job.rewards can override money/reputation per difficulty; defaults live in sh_config.lua.
contact.supplyStock can override initial, maximum, interval and amount for that NPC.
Only delivery jobs declare pools and delivery tiers. Quantities apply to deliveries, eliminations and
computer extraction; destination maps apply to field jobs. Omit settings ignored by the selected kind.
The `supplies` list configures ordinary vendor stock and legacy kit redemption. Repeatable task
rewards are separate: `rewards.packages` contains up to three `{label, items}` families. Each saved
offer selects one affordable eligible candidate per family, with explicit quantities and a two-item
limit. `rewards.bonusItems` lists optional equipment for larger five-task bonuses; existing purchase
gates still apply. `rewards.bonusService = "repair"` gives Technut and Boss provider-bound repair
credit choices. Thematic reward lists never add vendor stock or purchase unlocks.
See the jobsystem README for budgets, bonus banking, gate rules and claim recovery.

Spoken task text stays in the contact's dialogue and progression fields. step.objective separately
explains the actual field interaction. Mute communicates through written lists and gestures.
Flavour stays under **Can I ask you something?**; actions and services stay at the root.

### FTS delivery balance

The [FTS availability report](../../../../docs/npc-overhaul/delivery-balance.md) inventories item
points, boxes and cycling containers, combines their weights, and documents modeled rarity ratios.
Garbage now has 61 loose-item and 199 box points; custom box pools contribute to its availability.
Contacts without a local source for their theme use Marsh as the introductory acquisition region.
The model does not invent local Garbage loot or infer encounter rates from hidden-stash destinations.

All 327 finite delivery milestones now have 849 item slots across four phases of local prerequisite
depth: one common item type early, then two, three and four types. Common-stock batch multiples grow
from 1 to 4, while later requests add lower-availability bands at smaller quantities. Seventy-two
explicit thematic/home-region pools live in progression's shared requirement registry. Pools used
in the same delivery are disjoint, so every requested type rolls a distinct item. Exact selected
items and quantities remain visible in the existing requirement list; briefings ask for the full list.

Candidates have positive modeled world/box/cycling exposure. Introductory candidates have a source
in the contact's starting region (local where the theme has sources; otherwise Marsh); later bands allow more travel and rarer finds.
The report explains the population caps, pickup units, batch sizing, planning factors and exclusions.
Repeatable specialties, milestone IDs, prerequisites, cash, benefits and field mechanics are unchanged.
Existing saved item selections and partial contributions are retained rather than rerolled.

Rebuild the static pools, requirements and report with:

    python3 docs/npc-overhaul/tools/fts_delivery_balance.py --write

Use `--inspect` to review candidate availability without edits. The tool only reads FTS preset data;
it never deploys map presets or changes live saves. Checks:

    python3 tests/fts_delivery_balance_spec.py
    luatex --luaonly tests/town_delivery_sources_spec.lua

The acquisition audit still checks every candidate against active sources. Live spawn density,
competition, pickup rates, travel and economy need multiplayer playtesting; modeled full-collection
supply is a comparative index rather than guaranteed player drops per hour.

## Persistence

Only current progression IDs grant progression unlocks. There is no import of old completion IDs, numeric effort,
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

Startup checks commission destinations on every map, including maps other than the current server's.
Missing sites produce a setup warning and leave the affected commissions unavailable.
All five job types reuse existing event points, with stash or hazard pools also used where configured.
Authored field points are optional additions. Missing destination-map provider entries fall back to
the destination's FTS preset coordinates without running setup. Saved entries override presets,
including empty tables. Custom maps without presets still need saved or authored points.
For triangulation, the check needs at least one point from event/stash data or an authored triangulation
point for that map.
On each destination map, use `/TownNPCAddFieldPoint triangulation` at a playtested transmitter location.
Export the points and merge the map entries into `definitions/sh_sites.lua` on every server, then restart.
Adding a point on Garbage does not configure Waystation or Pripyat. These checks do not establish that
the configured positions are reachable or safe in-game.

Field stories use existing configured point pools and bound cargo. Each converted commission declares
`field.cargo` and `field.label`; optional `field.recipient` names a receiving contact ID.
Optional `field.description` overrides the cargo description for that commission. Its label and description
are saved on acceptance and applied to recovered cargo, while delivery instructions remain appended.
Concrete cargo in `items/jobcargo/` inherits jobsystem's `base_jobcargo` and uses selected quest-asset
models with zero price. Item labels and destinations are saved when the commission is accepted.
NPC deliveries use **I have a delivery for you** at the receiving contact, followed by a return to
the issuer. Existing accepted jobs retain their saved cargo/destination; no save reset is required.
Multi-site investigations, rescue actors and visible town upgrades are not implemented by their prose.
New NPC models remain replaceable placeholders. Place and playtest sites before deployment.

## Verification

Run from the repository root:

    luatex --luaonly tests/townnpcs_spec.lua
    luatex --luaonly tests/town_delivery_sources_spec.lua
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
Repeatable delivery contacts enable selected pools by difficulty. Finite progression slots also reuse
selected thematic pools; see the commission and delivery inventory.
Run `luatex --luaonly tests/valuable_pools_spec.lua` to check full item coverage and valid candidates.

## Regional valuable deliveries

All twelve item-delivery contacts retain their existing requests and add `job.deliveryTiers`.
Each difficulty lists additional pools and a whole-item quantity: one for easy/medium, two for hard.
These additions bypass the legacy minimum-value floor, which would inflate cheap whole-item requests.
Repeatable job IDs and accepted assignments stay unchanged. Quantity-bearing items instead
use acquisition batch bounds: easy = smallest batch, medium = largest batch, hard = largest batch + 1.
These bounds override quantity/value floors. World, breakable-box, human-pocket and cache loot data overrides are
combined across regions; `settings.spawnBatches` records random `OnInstanced` yields where capacity
differs from the initial amount. Update that table when those item callbacks change. Ammunition
without `ITEM.quantity` retains its existing whole-box counting and request amounts.
Easy deliveries accept any item in their configured pool, including mixed members across hand-ins.
Their titles and descriptions name the category. Medium/hard deliveries retain specific item requests.
The candidate item in each stable job ID remains the quantity/payment reference; accepted counts,
progress and reward choices are preserved. Each catalogued valuable declares a readable
`valuableCategory` property displayed in its inventory tooltip. See the hand-in catalogue for labels.
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
| Egghead / Marsh Eco Bunker | Sample carriers, survey gear | Research samples/records | Instruments, research injectors |

Easy additions favour home-region themes. Pools contain alternatives with different acquisition routes,
so a particular request can still require travel. Medium workshop requests favour Garbage/Waystation;
hard electronics and research requests favour Pripyat. Pocket effects, insignia and military records
can require human corpse loot; some technical/research records require hidden caches. Recovered
medical stock, provisions and ordnance remain valuable objects with no implied consumable functionality.
Acquisition frequency and the smaller payouts on cheap additions still need multiplayer playtesting.

## Reward overhaul (November 2026)

The [unlock ledger](../../../../docs/npc-overhaul/unlock-ledger.md) records current sellers,
earned gates, conversion unlocks, cash, capacity awards and future TODO allocations.
Concrete contact files remain authoritative. All catalogue purchase gates are local to the seller,
including ammunition. `canonicalSellers` in sh_equipment.lua identifies equipment-tier owners independently
of seller iteration; it does not unlock other shops. Medicine retains local earlier-tier prerequisites.
A contact's ordinary `supplies` remain ungated when that contact has no catalogue allocation for the item.

All 130 gun definitions are accounted for: 122 purchase routes and eight reserved guns.
Radsuits, Exoskeleton suits, Nosorog, the exoskeleton frame and the top three helmets are also
excluded from progression purchases. The four most expensive backpacks on master are also
reserved: backpack_4 and backpack_5 (20,000 each), backpack_4_large (32,500), and
backpack_5_large (34,500). Themed and looted suits are excluded even if a saved vendor
still lists them. Existing stock rows are retained; authoritative purchase checks enforce exclusion.
Suit and gear chains follow master prices. Equal-price backpack alternatives use carrying capacity.
Trenchcoat colours remain equivalent equipment with separate local purchase milestones. Variants require both base and exact variant conversion
milestones; variants in the same family have separate milestones; existing conversion conversations enforce those checks on the server as well as previews.

Medicine has independent local progressions at Jitters, Wake, Quartermaster and appropriate
scientists, including local earlier-tier prerequisites. Ammunition and its variants have local purchase
milestones at each seller. Ammunition no longer uses Brass's cross-contact tier dependencies.
All 66 loads are ranked from concrete `price / ammoAmount` values into twelve global price bands,
with regular and upgraded stages in each band. This avoids comparing whole-box prices or starting
every calibre at the first milestone. AP and HP at equal prices are parallel upgrades after the
regular load; special shotgun loads are upgrades to buckshot. Variant-counterpart ordering takes
precedence where existing box sizes/prices make the variant cheaper per round (14.5 mm and special
12-gauge loads). `45acp41` is .410 bore, not a .45 ACP upgrade. No prices or ammunition effects change.
Each seller's successive ammo stages are explicit local prerequisites, so sibling branches cannot
skip cheaper stages. Ammo stock improvements apply to loads available at that milestone.
See the [price-per-round report](../../../../docs/npc-overhaul/ammo-progression.md) for all loads and
exact seller milestones. Regenerate/check with
`python3 docs/npc-overhaul/tools/ammo_progression.py --write` or `--check`, then regenerate/check
the main reward ledger. Ordinary weapon, medicine and non-ammunition upgrade chains are unchanged. Old Timer, Brass and Quartermaster provide ungated
12 gauge, .22 LR and 9x18 on Marsh, Garbage and Waystation respectively. Jitters, Wake and Quartermaster
provide ungated basic bandages and introductory local medkit, antirad and painkiller unlocks.
Basic regional supplies require no external NPC progression. Other themed sellers retain useful overlap.

Each step declares completionCash. Delivery payments range from 275 to 2,000 rubles; field payments
from 450 to 3,000. Trackers and arena milestones pay zero extra cash. No progression steps award item gifts; stock rewards include further branch-specific improvements. Only Jitters and
Technut retain permanent service discounts (5%, replaced by 10%). These are initial tuning values,
not measured effort equivalence; acquisition and economy playtesting remain necessary.

Old Timer OT08/OT16 and Latch LA08/LA14/LA22 award +1 kg each (five total). Cleaner CL14 and
Suture SU24 award one carried-inventory row each (two total). Capacity derives from current earned
milestones, independently of equipment. Existing characters with those milestones receive capacity;
no counter increments or inventory-item movement are required. Equipment slots resolve expanded
public grid dimensions through character progression while keeping their reserved region intact.

### Existing saves

InitializeTownCharacter applies rewardVersion 2 once. Previously completed town nodes without an
accrued cash ledger are marked paid so they do not retroactively mint new cash. Existing accrued
hand-in credit, paid flags, assignments and pending item claims are preserved. Newly completed nodes
use the new payments. Conversion and purchase gates use current earned milestones; existing owned
items are not removed. No database reset or first-time setup is required.

### Reward redistribution and TODO metadata

All 646 milestones have an assigned functional unlock, stock tier or unimplemented unlock.
The initial redistribution covered 624 milestones; the later author-disabled suggestions above
supersede that coverage snapshot.
Arena Master remains in Marsh as an arena organiser, with no active catalogue or finite progression.
His 22 former milestones, including eight TODO entries, remain in `retiredProgression` as inactive
reference data; none are registered, offered or counted. His former purchases now belong to
Haggler, Brass and Jitters as appropriate.

The personality-based redistribution assigns lighting to Gasket (flashlight GK06, headlamp GK16),
mechanical upgrades to Technut, protective materials and clothing to Suture, steel plates and heavy
tools to Latch, and specialist weapon families to their matching contacts. Atlas retains navigation
and binoculars. Vesper supplies detectors and anomaly equipment; Egghead supplies artifacts. Existing
food, meat, specimens and hides now have explicit thematic purchase routes. Bound mission cargo is
not added to shops. Existing valuables routes are unchanged. Small regional provision catalogues
support capped stock improvements on milestones without a new equipment purchase.

All progression provision gifts have been removed. Cash and paid benefit tokens remain unchanged.
Old gift claim queues are inactive history; already owned items are not confiscated. Existing earned milestone IDs
now determine the redistributed purchase permissions. Removed seller rows in saved vendors remain
subject to authoritative seller checks; restart all map servers to refresh new catalogue rows.
No first-time setup or database reset is required. Acquisition and economy tuning need playtesting.
The [unlock ledger](../../../../docs/npc-overhaul/unlock-ledger.md) gives the exact order at each contact.
The character-theme audit moves civilian carbines and the makeshift Mosin from Quartermaster to
Haggler, and the SKS to Old Timer. Quartermaster owns basic tactical sights; Smartass keeps precision
optics and gains the computer-access component formerly sold by Egghead. Cleaner has overlapping
compact pistol/SMG routes, while Spool sells existing music cassettes alongside his receiver/player.
Cooking-fuel purchases, ordinary supplies and stock rewards are removed from the clinic, archive,
research/communications desks and outfitter. Their affected rewards now improve medical, measuring,
computing, recording or textile equipment and appropriate working provisions. Field/camp contacts
retain fuel where it supports expeditions or utilities. All stock increases remain capped at +4 and
are usable at the earning milestone. TODO plans and progression IDs are unchanged; progression gifts are removed.

There are 234 active planned entries plus eight retained in Arena Master's inactive reference tree.
Each `plannedUnlocks` entry has its own adjacent `-- TODO:` comment, stable ID, provider, kind,
status and specific intended effect. This authoring metadata never enters compiled progression reward
fields, claim queues, dialogue menus or entitlement checks. It is not an implemented service.
The seven planned kinds are passage, cosmetic, storage, barter, supplyExchange, information and recipe.
Proposed terms require implementation, acquisition and economy review before enabling consumers.
Existing conversion rewards retain their gameplay distinctions; future painting is cosmetic only.

Binoculars are removed from Mute, including future bonus offers, his base template and purchase checks
against stale saved vendors. Atlas owns binoculars_2/1/4/3 at AT01/AT05/AT13/AT17; Spoor has alternate
local routes. The canonical predecessor chain remains enforced.

Stock bonuses are highest-earned **total bonuses**, capped by authoring policy at +4 per item/provider.
Do not repeat an equal tier after its prerequisite: it grants no improvement. Existing quantities,
refill intervals, refill amounts and prices are not retuned here. Default assortment/stock rework is separate.

Generate or verify the full ledger from Lua definitions and their compiled gates:

    python3 docs/npc-overhaul/tools/progression_rewards.py --write
    python3 docs/npc-overhaul/tools/progression_rewards.py --check
    python3 tests/progression_rewards_spec.py

Reassigned permanent permissions derive from completed IDs. Owned items, cash ledgers, assignments,
pending claims and paid benefits remain intact; gifts are not replayed and old shop access is not grandfathered.
No save reset or first-time setup is needed. Restart map servers together and verify regional vendors,
independent sellers, conversions, stock synchronization, pending claims and existing characters in multiplayer.
Standalone specs cannot establish those runtime behaviours.

## Alternate spawn positions

Aim at an advanced vendor or town NPC and run `/TownNPCGetSpawnPoint` as an administrator.
It prints a copyable Lua record containing that entity's current `position`, `angles` and `idleanim`
to your client console. The animation is the sequence currently visible on your client, including
animation-group gestures, rather than the vendor's configured idle. Position and facing come from
the NPC. The command takes no arguments and does not save points or change the world.
It replaces the former player-position `/TownNPCAddSpawnPoint` command.

Capture each desired NPC placement and paste the records into the matching contact's table in
the map preset described below. Include the original position explicitly if it should remain a choice.
Any advanced vendor can be captured; automatic restart selection applies to registered town contacts
on their home maps. Existing saved choices continue working.
`/TownNPCClearSpawnPoints <slug>` remains admin-only and removes the saved choices while leaving
the current NPC in place.

Each selected animation override loops for the session and takes priority over random vendor gestures.
It does not overwrite the vendor's ordinary saved animation settings. Set `idleanim = ""` or omit it
to use normal vendor animation. A sequence missing after a model change produces a server warning
and falls back to normal vendor animation for that session.

After saved vendors load on each map restart, configured contacts choose a random saved point,
excluding the previous restart's position when another distinct point exists. The previous selection
is saved separately so a crash or stale vendor placement does not reroll the same position.
NPCs stay at that point for the whole session. Contacts without points keep their saved placement.
Repeated PostLoadData calls do not move them again, and newly placed contacts wait until restart.
Points recorded with the earlier patrol tool are retained as spawn positions on the next save.
There is no walking, patrol timer, or walking-animation override.

### First Time Setup presets

`/TownNPCExportSpawnPoints` prints the current map's `plugindata["townnpcs"]` entry to the client
console. `/FTSDumpPluginData` also writes these records to the server's `data/FTSDump/townnpcs.txt`;
remove its heading and put the records inside the preset's `plugindata["townnpcs"]` table.
All bundled map presets include an empty table ready for authored points. Example structure:

```lua
plugindata = {
	["townnpcs"] = {
		["mute"] = {
			{position = Vector(100, 200, 300), angles = Angle(0, 90, 0), idleanim = "idle"},
			{position = Vector(140, 200, 300), angles = Angle(0, 180, 0), idleanim = ""},
		},
	},
	-- Other controller data remains here.
},
```

Use captured coordinates and sequences from the actual map/model. The preset still needs a matching
`vendors` entry to create the contact; these records only configure its potential placements.
FTS copies and saves the current map's points and clears that map's selection history. Other maps
are retained. Omitted town data leaves existing points alone; an explicit empty table clears them.
Imported placements first take effect on the next restart, after vendors load. Capturing a record or
editing a preset does not change an initialized world's saved choices; applying those edits to an
existing world needs a deliberate data migration. Rerunning full FTS also duplicates its world entities.

Check `luatex --luaonly tests/bug_testing_spec.lua` for save/reload, restart selection and no-repeat coverage.
Run `luatex --luaonly tests/town_spawnpoints_spec.lua` for admin-only capture, console output, current client
animation, client looping, legacy defaults and FTS import/export. Verify actual placement, facing, animation,
late-joining clients and ordinary dialogue/trade after two map restarts in multiplayer.

Progression notices use local named NPC chat within chatRange of the NPC. An absent NPC uses a
private character notification. Mute's locked introduction uses gestures in his own conversation.

## November 2026 dialogue pass

The 27 town contacts now have expanded personal conversations, contact-specific work offers, and
revised finite briefings and completion replies. Atlas retains his developed voice; Mute continues
through gestures and written orders. Existing contact profiles record the accepted voice directions.
All 158 remaining field commissions have narrative cargo labels and descriptions, using the existing models.
These are per-assignment overrides, not renamed item definitions. Jobs already accepted keep their
saved identity; new labels and descriptions apply to new assignments without resetting progress.

The dialogue pass preserves IDs, task kinds, locations, recipients, requirements, rewards, and access
conditions. Briefings describe assigned sites rather than promising fixed structures or new actors.
Verify text wrapping, long replies, incoming deliveries, work offers, and final greetings in multiplayer.

The subsequent personality expansion adds everyday Zone conversations and relationship topics to all
27 bound conversation files, with corresponding notes in the existing contact profiles. It changes no
contact definition, work prompt, finite briefing, completion reply, or finished-story greeting. Personal
subjects remain under the questions menu, with no additional progression requirements.

### Regenerating a ledger while definitions have validation errors

`python3 docs/npc-overhaul/tools/progression_rewards.py --write --allow-invalid` writes a current
definition snapshot with validation findings and actual coverage counts. It does not change runtime
definitions, restore disabled items or add rewards. Plain `--write` and `--check` remain strict.
The current snapshot includes the suit dependency cycle at Beanstalk BN01; 593 milestones have
implemented unlocks, 25 have only TODO plans, and six have neither. A reported cycle stops the
remaining graph-dependent validation, so a refreshed snapshot is not a successful runtime audit.
