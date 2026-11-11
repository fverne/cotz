# Town NPCs

## Current progression, 9 November 2026

The [progression overhaul](../../../../docs/npc-overhaul/progression-overhaul.md) is authoritative over
the earlier progression, catalogue and service descriptions below. There are 631 hand-in milestones
in 52 branches, retaining current `v3/` IDs and adding 212 `/stock` intermissions.
Technut's initial anorak stock delivery and eleven intermediate stock-preparation deliveries are retired.
Anoraks remain starting stock; suit progression starts with the Mail Jacket and follows each preceding suit
directly. The independent painting branch remains. Existing regional ranks are retained for later suits.
Retained milestone IDs, request quantities and saved contributions are unchanged. Retired stock-step
records remain saved history and no longer gate unfinished suits.
On character load, an active retired Technut stock step is marked skipped and activates its following
suit request. Discussed stock steps also reveal that request in the progression tab. The migration
preserves partial deliveries, pays no completion reward and never reopens a completed suit.
Town delivery slots now declare `mode = "any"` (one shared category total) or `mode = "random"`
(one saved item selection per character). The first `ceil(actualUnlockCount / 5)` milestones of every
connected chain are category-only; shared labels do not join independent capacity purchases. Intermissions
inherit the following unlock's position and always use category
totals. Later ordinary requests use a specific-item final slot with category totals in earlier slots.
One-step branches stay category-only. See the [mode and migration policy](../../../../docs/npc-overhaul/progression-overhaul.md#category-totals-and-specific-requests).
Category requests now save 3–4 accepted item types per character, allowing any mixture. New totals
require at least 3–4 supply batches. Three nuts or four bolts count as one batch; category offers
always contain both fasteners or neither. Other quantity-bearing valuables use their natural spawn
minimum. Specific requests display raw quantities after batch scaling. Catalogue pools may overlap;
the saved accepted subsets do not. `settings.progressionCategoryChoices` configures the subset range.
Mode version 2 replaces old full-category lists once and raises outstanding category totals below three.
Canonical keys, delivered credit and money remain; fulfilled categories, completed milestones and old
specific targets are retained. Choices and batch costs are unaffected by subsequent definition edits. Dialogue, journal search and
inventory highlights use the saved choices. Restart map servers together; do not reset saves or run FTS.
Run `luatex --luaonly tests/progression_subsets_spec.lua` for randomized subsets and batch hand-ins.
Run `luatex --luaonly tests/town_requirement_modes_spec.lua` for all compiled town boundaries.
Run `luatex --luaonly tests/progression_requirement_modes_spec.lua` and
`python3 tests/progression_expansion_spec.py`; multiplayer replication and hand-in QA remain required.
Each contact declares core and related support request pools in `progressionIdentity`. At least 75%
of requested units stay with the contact's specialty; there is no all-theme rotation. Each branch starts
locally; later low-quantity slots gradually allow Marsh/Garbage, Waystation and finally Pripyat sources.
Marsh branches keep their first two original milestones and all work below 45% fully Marsh-obtainable,
including stock preparation. Valid saved requests are not rerolled to impose the new specialties. Requests use valuables and artifacts, except for the initial hideout tool hand-ins. Completion pays accumulated hand-in
value at 60%, with no flat cash. Stock bonuses increase personal capacity without refilling it.
Ledger uses 3× difficulty. Policy 4 converts outstanding invalid or out-of-region saved inputs while preserving credited
contributions and completed unlocks. Inserted stages gate unfinished unlocks; Mute's redundant directory
maintenance is removed. See the authoritative guide for regional thresholds and save handling.
Old Timer now unlocks Cutlery before Cleaning kit, followed by Shovel. Existing completed unlocks remain saved.
Jitters' stimpaks follow medkit 6,
antirads follow medkit 2, and Asenapine/Modafines follow medkit 4. Atlas' anomaly detector follows his Geiger counter.
Initial hideout access consumes one unequipped tool before new local room claims and unfinished improvements:
one crowbar or bat for Ballast, one sledgehammer for Cleaner, and one FUBar for Ledger. These hand-ins ignore
contact difficulty multipliers. Existing rooms/upgrades remain saved and usable. Haggler's gunpowder barters are removed.
All progression briefings in the dialogue menu include assigned item names and remaining quantities.
Stock-capacity milestones use "<item> stock increase" as their title in dialogue and the progression menu.

All 631 active milestones have individual authored `briefing` and `completion` replies in their
contact definitions, including the 212 stock-preparation deliveries. Read each contact's existing
profile and bound conversation before editing its voice. The current requirements, catalogue and
benefits determine what a reply can promise; the older story tables and retired commissions do not.
Requests leave assigned item names/counts to the existing objective display so valid saved deliveries
remain accurately described. Mute's five requests and completions use gestures and written orders.
Town completion messages render the authored text without adding the player's name.

`expand_progression.py` preserves existing stock-step briefings and completions by step ID when
rebuilding their requirements. A newly generated stock step initially copies the following unlock's
text and needs its own authored replies before delivery; do not reuse the unlock's purchase wording
for a stock-capacity benefit. Check coverage with `luatex --luaonly tests/progression_dialogue_spec.lua`
and preservation with `python3 tests/progression_expansion_spec.py`.

Scoreboard tools and dossier data are immediately available. Mute instead unlocks mutant PDA reports for
Swamps, Garbage, Waystation, then Pripyat, retaining emission warnings before Pripyat. Retained milestone IDs
and delivery terms preserve existing completions and assignments; redundant activity/location/dossier stages
remain saved history. See the overhaul guide for the exact compatibility mapping.

Wake owns backpacks and +5 kg/+2 rows. Capacity upgrades are optional one-depth side branches revealed at
the existing backpack milestones; each requires only its assigned backpack. Players can finish the backpack
route and return for any capacity upgrades later.
Spool's Russian tank helmet and Latch's cloth mask start in vendor stock; their old purchase steps are retired.
Spool owns strong drugs. Quartermaster retains six regular ammunition barters; his two main-menu kit exchanges
are removed. Suture's conversion milestones explicitly say "variants". Old Timer/Spool/Latch/Wake declare
`preserveProgression = true` so the authoring tool retains their ordering, quantities and stock stages.
Mode and candidate-pool authoring still applies to these contacts.
Technut also declares it to preserve the suit route without regenerating stock intermissions.
Technut keeps painting and all ordinary suits; Egghead owns science suits. All trenchcoat colours share a step. Suture owns the starting
conversion menu and per-suit non-looted finishes. Intern owns artifact detectors. Brass/Carbon provide
HP/AP barter only, gated by regular/HP completions respectively. Starter stock is explicitly declared.
Ballast, Cleaner and Ledger buy all at 0.3 and provide twelve local hideout improvement stages.

Bank/Computer progression access, town discounts and credit are removed; ordinary paid repair/treatment
remain. Tools remain job rewards, music and three unassigned guns are deferred. Spicy Lemon's jobs
cover all canned foods; meals/meat have no NPC sale routes. Existing inventories and paid hideout assets
remain saved. Old commission journals are inactive history and cannot grant new progression.

The ammo generator now writes reports only; the legacy FTS writer rejects these branches before writing.
Regenerate reports with `progression_rewards.py --write` and `ammo_progression.py --write` under
`docs/npc-overhaul/tools/`. Both support `--check`.

    luatex --luaonly tests/contact_stock_and_capacity_spec.lua
    luatex --luaonly tests/contact_progression_changes_spec.lua
    luatex --luaonly tests/technut_stock_skip_spec.lua
    luatex --luaonly tests/townnpcs_spec.lua
    luatex --luaonly tests/town_ammo_exchange_spec.lua
    luatex --luaonly tests/vendor_plan_spec.lua
    luatex --luaonly tests/regional_jobs_spec.lua
    python3 tests/progression_expansion_spec.py
    luatex --luaonly tests/progression_expansion_spec.lua
    python3 tests/progression_rewards_spec.py
    python3 tests/fts_delivery_balance_spec.py

Deploy all map servers together and restart without resetting saves or running first-time setup.
The linked overhaul guide records default quantities, current allocations, compatibility and live checks.

## Gasmask filter purchases

Every current seller of filter-dependent headgear unlocks the matching cartridge before the first
mask requiring it. Latch supplies civilian filters before Halfmask, military before EO-20, and
scientific before M40. Boss supplies military filters before CS-4 and scientific before Screen.
The other masks at those sellers follow these milestones through their existing prerequisite chains.
Exempt equipment adds no filter delivery. Cleaner and Beanstalk's old template mask entries remain
outside the authoritative town catalogue and do not create additional sale routes.

These five delivery stages grant purchase access only. Each inherits the following mask's existing
prerequisites and sits after any stock preparation, immediately before that mask's purchase delivery.
Each seller stocks four cartridges initially, with a maximum of four and one cartridge refilled every 12 hours;
prices come from the concrete filter items. Normal vendor refresh adds the catalogue rows on restart.
Latch remains the canonical supplier; Boss grants independent local military/scientific purchase access.
Boss now joins the contacts marked `preserveProgression`, so authoring regeneration retains this ordering.

New filter stages declare `defaultActive = true` while retaining their prerequisites, so they become
offerable when their parents were completed before the update. Completed mask purchases, saved
requirements, partial deliveries and accrued hand-in value remain intact. Unfinished mask deliveries
wait for the matching filter unlock. Talk to the contact to discover the newly available request.
The affected branches retain delivery quantities and acquisition regions; their generated candidate
pools and category-only opening boundaries follow the updated chain positions. Saved selections stay fixed.
Deploy matching code to all map servers and restart; no save reset or first-time setup is needed.

Run `luatex --luaonly tests/gasmask_filter_progression_spec.lua` for all fourteen mask sale routes,
five filter unlocks, seller-local permissions, saved-progress handling and vendor-template refresh.
Also run `tests/town_requirement_modes_spec.lua` and `tests/progression_dialogue_spec.lua` with `luatex --luaonly`,
and `python3 tests/progression_expansion_spec.py` plus `python3 tests/progression_rewards_spec.py`.
In multiplayer, check topic discovery, real deliveries, filter purchases, restocking and returning
characters with completed or partially delivered mask requests.

## Earlier implementation notes

These dated notes retain historical context and are superseded by the current guide where they differ.

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

Contacts buy their delivery candidates, catalogue goods and ordinary supplies independently of purchase
unlocks. Extra buying IDs (`buyItems`) and category lookups (`buyCategories`) live in contact definitions:
Haggler accepts ammunition and weapons, and Spicy Lemon accepts every strong alcohol item, raw meat and
cooked meal (the `Cookable Meat` and `Cooked Meat` categories).
These additions do not change progression requirements or courier candidates. Buying-only goods use
BUYONLY rows; catalogue goods remain BUYONLY in the menu until their seller-specific purchase milestone
is earned, then become SELLANDBUY. The server enforces both purchase and sale assortments, including
stale vendor rows. Template assembly and saved-vendor refresh apply the current buying lists and catalogue.
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
| Equipment and regular-ammo upgrade chains | townnpcs/definitions/sh_equipment.lua |
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

### Suit attachment chain

The non-hide suit attachments in `definitions/sh_equipment.lua` follow the families unlocked by
Technut on local `master` at `6b8d23e4`. Master has parallel plate, fabric, Kevlar, frame and carbon
branches; this single chain retains each family's tier order and uses current prices and catalogue
milestones to place the branches relative to one another:

```text
Old Ceramic Plate → Well Worn Steel Plate → Insulating Fabrics → Steel Plate → Ceramic Plate →
Thick Insulating Fabrics → Kevlar K119 Plates → Aluminium Frame → Galvanized Steel Plate →
Carbon Fibre Layers → Steel Frame → Modern Ceramic Plate → Kevlar K29 Plates
```

All 13 standard attachments keep their current sellers: Latch, Suture and Carbon. Each purchase
milestone requires its predecessor's canonical milestone, including across sellers. Completing
an attachment's existing milestone still grants its purchase; installation and owned suits are
unchanged. Hides and the anomalous `attachment_steelplate_4`/`attachment_ceramicplate_4` plates
are excluded. The latter were not part of master's vendor unlocks and have no current town purchase.

Run `luatex --luaonly tests/suit_attachment_chain_spec.lua` for coverage, family-tier order and
cross-seller purchase gates. Verify milestone availability and purchases with fresh and existing
characters at Latch, Suture and Carbon in multiplayer.

### Gun upgrade chains

Five gun routes in `definitions/sh_equipment.lua` cover all 122 purchasable guns, including
all 37 guns in Haggler's current catalogue. They add purchase-milestone prerequisites through the
existing catalogue compiler. The eight reserved guns remain outside these five chains.

| Route | Guns | Coverage |
| --- | ---: | --- |
| Sidearm | 30 | Every gun configured for the secondary slot, including the short .410 Henry |
| Eastern close-range | 21 | Eastern SMGs, PDWs, shotguns and Obrez variants |
| Eastern rifles | 21 | Eastern-pattern carbines, rifles, machine guns and precision rifles |
| Western close-range | 27 | Western SMGs, PDWs, shotguns and pistol-calibre carbines |
| Western rifles | 23 | Western sporting rifles, military rifles and precision rifles |

Sidearm order (item IDs):

```text
nagantrev → g2contender → tokarev → m1917 → makarov → brhp →
cz52 → fort12 → beretta92 → rugermk3 → c96 → lugerp08 →
p99 → glock17 → m1911 → glock18 → taurusjudge → g2contender500 →
stechaps → mr96 → lax410s → swr8 → swmodel29 → deagle →
taurusragingbull → deagle44 → mateba → fiveseven → sw500 → m1911chic
```

Eastern close-range order (item IDs):

```text
toz106 → toz34short → ppsh → toz66short → mp27 → skorpion →
kiparis → obrez → obrezmalfunction → toz34 → toz66 → toz194 →
mp153 → pp2000 → gepardpdw → pp19 → pp1901vityaz → sr2 →
saiga12 → saiga410 → toz34special
```

Eastern rifles order (item IDs):

```text
aks74u → sks → ak74 → saigasemi545 → akm → saigasemi →
aek971 → rk95 → mosin → an94k → ak12 → svt40 →
9a91 → rpk → dp28 → sv98 → asval → svd →
sr3m → vss → pkm
```

Western close-range order (item IDs):

```text
sten → ij600 → mac11 → mp34 → c96carbine → mp40 →
m3supershort → uzi → mp18 → mp5k → m1887 → stoegerddshort →
mossberg500 → kp31 → sterling → lax410 → mp9a1 → m3super90 →
stoegerdd → mp5 → ithaca37 → rem870ae → ump45 → ar159mm →
m1928 → p90 → striker
```

Western rifles order (item IDs):

```text
sako85varmint → w9422 → ruger1022 → rugermini14 → sako85nato → w1895 →
w9422357 → m16a4 → lr300 → famas → sg552 → l85 →
g36c → aug → lax44 → sako85 → f2000 → hk416 →
trg42 → g3a3 → fnfal → m14 → l115
```

Close-range groups shotguns, SMGs and PDWs with the pistol-calibre AR15 9mm/C96 carbine and
the shortened Obrez rifles. The rifle chains retain rifle-calibre carbines such as AKS-74U and
G36C, the 9x39mm assault rifles, precision rifles and machine guns. The short .410 Henry remains
in the sidearm chain because its item definition uses the secondary slot. Within each regional
pair, the split preserves relative order from the former combined chain.

The reference is local `master` at `6b8d23e4`: Haggler's complete surplus/workshop progression
and Quartermaster's military imports. Master's obsolete `g2500mag` and `rem870` references use the
current `g2contender500` and `rem870ae` IDs. The weapon kits select `task_reward_weapon_*` pools;
those weighted gun entries match master. Their overlapping bands inform the broad progression,
but exact ordering must respect current authored milestone dependencies. Lower prices are preferred
when both milestones are otherwise available; this is not a strict ranking of combat effectiveness.
The Eastern route includes the Finnish RK 95 as an AK-pattern weapon, following master's AK branch.
Other Finnish guns, including KP-31 and the Sako precision rifles, use the Western route.

Each listed weapon requires the preceding weapon's canonical purchase milestone, followed by its
own milestone. Weapons sharing a milestone unlock together. Owning, buying or handing in the
preceding gun is not required. Reserved weapons remain excluded. Crate contents, prices,
stock and saved progression records are unchanged.

All five chains cross the existing contact story branches, so they are connected rather than
independent specialisations. For example, the Western rifle route requires Haggler's Marlin (HG24)
before Quartermaster's M16A4 (QM01); the Eastern rifle route requires Cleaner's AKM (CL27) before
Quartermaster's semi-automatic Saiga (QM02). The former direct Saiga-410 (SP20) → semi-automatic
Saiga (QM02) chain edge is removed by the close-range/rifle split. Shared milestones can still gate
other equipment and services at those steps. Completed milestones keep their purchase permissions;
new prerequisites govern unfinished milestones. Fully independent paths would also require changes
to shared contact progression branches.

Run `luatex --luaonly tests/townnpcs_spec.lua` for exhaustive gun/slot coverage, graph-cycle checks,
canonical predecessors and cross-contact purchase transitions. In multiplayer, check fresh-character
milestone access across Haggler, Cleaner, Spoor and Quartermaster, plus an existing character with
completed purchase milestones.

### Regular ammunition chain

`definitions/sh_equipment.lua` also declares `regularAmmoChain`, generated from the five gun chains.
For parallel chains, a calibre's first default SWEP use is ranked by chain position, then gun price,
chain order and item ID. This compares authored positions rather than completion time through the
shared prerequisite graph. SWEP ammo names are resolved through `schema/libs/sh_weapontables.lua`;
descriptive text is not used to infer a gun's cartridge.

The chain covers all 24 regular loads. AP, HP and special 12-gauge loads are excluded. Standard
12-gauge buckshot and .410 bore (`45acp41`) are included as separate regular cartridges. The four
loads without a default user in these gun chains are appended alphabetically: `127x55`, `145x114`,
`700nitro` and `93x64`. Appending an unstocked load does not create a new vendor purchase route.

Each seller follows the regular chain through the calibres it actually stocks; missing calibres are
skipped. Purchase permissions remain local to that seller. Generated catalogue allocations replace
the former price-band schedule, and local HP/AP/special-load upgrades retain their counterpart gates.
Several regular loads can share a milestone when the tree has fewer steps than the full sequence.
This orders ammo unlocks; it does not require completing the corresponding gun's purchase milestone.
Ammo prices, quantities, stock terms and effects are unchanged. Existing saved milestone records are
preserved, but ammo purchase permissions now derive from their new local allocations.

Regenerate/check with `python3 docs/npc-overhaul/tools/ammo_progression.py --write` or `--check`.
The [ammo report](../../../../docs/npc-overhaul/ammo-progression.md) lists the full chain, first guns
and seller milestones. Run `luatex --luaonly tests/regular_ammo_spec.lua` and the ammunition tests
in `tests/progression_rewards_spec.py`. The focused Lua fixture covers missing seller calibres,
local purchase gates, variant prerequisites and already-completed milestones without loading saves.
Verify fresh and existing characters' local ammo purchases in multiplayer.

## Catalogue spacing

The first milestone at each active trader unlocks one or two purchases. The 131 formerly crowded
introductory purchases are spread through later milestones at the same seller, including provisions,
weapons, tools and equipment. Starter water remains ungated. Ammunition uses its generated gun-order
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

The 59 current exclusions include mission/access equipment and The Original's proposed specimen/hide
shop. Spicy Lemon's former human meat exclusions are removed so he buys every raw meat and cooked meal.
Twelve remaining stock references to excluded equipment have been removed without
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
The `supplies` list configures ordinary vendor stock. Repeatable task
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
    luatex --luaonly tests/town_vendor_buying_spec.lua
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
milestones at each seller. The regular-ammo chain above replaces the former price bands. AP and HP
remain local upgrades after regular ammunition, with AP also requiring local HP where available;
special shotgun loads follow buckshot. `45acp41` is .410 bore, not a .45 ACP upgrade.
Each seller's successive ammo stages are explicit local prerequisites, so sibling branches cannot
skip earlier stages. The [ammo report](../../../../docs/npc-overhaul/ammo-progression.md) lists all
66 loads, prices, quantities and exact seller milestones. Ordinary weapon, medicine and other
equipment chains are unchanged by ammo generation. Current catalogue gates remain authoritative
for regional medicine and ammunition; the approved plan has no starting sale supplies.

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
The current snapshot records a dependency cycle at Spoor SP07 and reports current coverage counts
in its heading. A reported cycle stops the remaining graph-dependent validation, so a refreshed
snapshot is not a successful runtime audit.

## Disposable posing previews

Administrators can use `/TownNPCPreview <contact-slug-or-vendor-template> [sequence]`, for example
`/TownNPCPreview jitters`, then press **E** on the preview to browse the model's available animations.
The searchable list includes sequence index zero and lets you play an entry with one click. Previous
and next buttons cycle through the filtered list, wrapping at either end. The current animation is
shown above the list; the window sits to the right so the preview remains visible. Closing the window
keeps the selected pose. Press E to reopen it. Only the administrator who created the preview can edit
it, while nearby and still an administrator; the server validates and rate-limits every change.
Selections send sequence names for server lookup. Rejected access or unavailable server sequences
produce a notification; a rejected selection leaves the current animation unchanged.
The session animation uses a separate NWString because the vendor already occupies all four string
datatable slots. Restart the map after updating this registration; existing entities keep old accessors.
Run `luatex --luaonly tests/town_animation_network_spec.lua` for slot limits, identity isolation,
networked pose switching and the actual vendor animation consumer.

The optional sequence argument still works, for example `/TownNPCPreview jitters idle_all_01`.
Without it, the preview uses the configured idle or the model's first sequence if that idle is missing.
The preview appears at the crosshair, faces your yaw and loops the selected sequence. Sequence index zero
is valid. Use `/TownNPCGetSpawnPoint` on it to print the visible position, facing and animation for
an alternate restart point. Existing point export/import behavior remains unchanged.

Each administrator has at most one preview. Another valid invocation replaces it; invalid templates
or sequences leave the previous preview intact. Undo, disconnect or plugin unload removes it.
`ix_townnpc_preview` inherits advanced-vendor appearance/animation but cannot trade or talk. Its
separate class excludes it from vendor saves, contact lookup and restart placement.

Town commands now register on both realms in `libs/sh_commands.lua`; handlers, saved data and
network registration remain server-side. Check permissions and chat completion with an admin and
ordinary player. Run `tests/town_preview_spec.lua`, `tests/town_spawnpoints_spec.lua` and
`tests/shared_commands_spec.lua` with `luatex --luaonly`. Picker controls, filtering, sequence zero,
navigation, lifecycle and resizing also have mock coverage in `tests/town_preview_ui_spec.lua`.
In multiplayer, check E interaction, model sequence availability, visible looping, capture after
switching, ownership/distance restrictions, and the picker at narrow, 1080p, ultrawide and 4K sizes.

Concrete contacts declare `courierPools` using existing `valuables_` requirement categories, reflecting
their established profiles. These interests broaden incoming valuable-courier deliveries without
changing their repeatable specialty or ordinary shop stock. Jitters accepts cleaning/sanitation,
clinical, medical equipment and trauma categories. All active contacts have four themed categories;
The Original remains inactive. Regional sources and disabled-item exclusions still apply.

STALKERnet opens on the current character. Personal statistics and location bypass Mute's dossier,
activity, rank and location gates in both data filtering and display. Other characters and global
search/remote tools keep their existing unlocks. List filters cannot clear the personal dossier.

## Conversation and discovery

Repeatable spoken briefings/reminders are separate from formal journal descriptions. Each contact
owns `dialogue.jobBriefing`, `jobReminder` and `jobFinished`; `{details}` inserts the actual goods,
region and recipient instructions. Optional `jobTerms` replaces the spoken payment paragraph
(with `{money}`), preserving Mute's written presentation. Progression conversations discover the
contact's currently active topics for the character's separate Progression tab.
Wake owns new information couriers; Brass has no new ordinary work and retains accepted assignments.
See `tests/contact_job_flow_spec.lua`, `tests/task_rewards_spec.lua` and `tests/progression_spec.lua`.

## Dialogue navigation and roster visibility

Dialogue uses explicit action colors, with jobs/progression matching inventory yellow/purple.
All 27 contacts keep flavour under questions, appearance services under customization, and ammunition
exchanges under barter. Incoming deliveries remain on both root variants. Task rewards stay under
About work → Task rewards; new tasks and field commissions from that contact require collecting earned rewards first, including
items waiting for inventory space. Technut's existing gear
window now also paints unlocked suits; Suture retains conversions and Mute retains PDA appearance work.
Escape returns through menus, and a one-second hold closes the interaction.

The scoreboard defaults to all servers and its local-area toggle is always available. Remote roster
identities bypass the former networkRemote gate; search, squad, rank, activity, location and dossier
gates remain independent. The saved networkRemote milestone ID and its cash reward remain, now titled
directory maintenance, without advertising an already available directory as an unlock.
Run `tests/town_dialogue_menus_spec.lua`, `tests/dialogue_order_spec.lua`,
`tests/gear_customization_spec.lua` and `tests/squads_menu_scoreboard_spec.lua` with `luatex --luaonly`.
Verify Escape presses/holds, modal focus, suit previews and confirmation, trade returns and fresh-character
cross-server roster visibility in multiplayer after deploying matching server/client code.

## Bunker courier discovery

Beanstalk, Egghead and Intern become eligible delivery recipients individually after the character
first talks to them. Their validated greeting saves `townKnownContacts` by contact ID on that
character; repeated greetings do not save again. Existing `knownProgressionTopics` entries for a
scientist also count as prior discovery. Earlier ordinary conversations were not recorded, so a
character with no saved evidence must greet that scientist again. No saves are reset.

Valuable-courier offers, previews, task journals and server hand-ins use the same discovery filter.
Wake's information-parcel assignments also exclude undiscovered bunker scientists, retaining their
existing regional and bunker-card gates. Accepted parcel destinations remain saved without rerolling.
Verify greeting each scientist, switching characters, reconnecting, previews and deliveries in multiplayer.
Run `luatex --luaonly tests/regional_jobs_spec.lua` for standalone regression coverage.
