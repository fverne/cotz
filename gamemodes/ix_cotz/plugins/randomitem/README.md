# Regional world loot

Worldspawn pool ownership is Swamps 1/2, Garbage regular/rare, Waystation 3/4, and Pripyat 5/6.
The randomitem library explicitly includes all eight pools on both realms. Map spawn definitions
must select these pool IDs; registering a pool does not place loot spawners or change map presets.

All 378 `valuables_test` items have a worldspawn, human-corpse or hidden-cache acquisition route. Household cleaning stock
and dry provisions appear in every region. Swamps favours everyday supplies, field records and
personal effects; Garbage favours scrap, hand tools, repair stock and worn equipment cases;
Waystation favours industrial, military and clinical equipment; Pripyat favours computers,
control electronics, recorded data and research material. Themes are preferences, not exclusions.

Existing item prices are unchanged. Regional placement uses both purpose and price: more expensive
items move to later regions rather than become early-map jackpots. New regular entries have price
ceilings of 450/700/1,200/2,200 for Swamps/Garbage/Waystation/Pripyat; higher-value finds use rare
pools. Early-region rare ceilings are 1,800/2,600/4,500; Pripyat has the remaining high-value finds.
These are authoring choices reflected in explicit Lua rows, not runtime sorting rules.

All active old and new rows are weighted together. Every pool totals **10,000 weight**, so
100 weight is a 1% chance per selection. There is no separate old/new allowance. Existing quantities, loaded ammunition and durability are unchanged; disabled rows stay disabled.
Twenty personal/identity/data valuables are moved from worldspawn to human pocket loot below.

Regular pools budget about 70% salvage, 17% consumables, 8% ammunition, 3% weapons and 2% utility.
Rare pools budget about 74% salvage, 14% consumables, 7% ammunition, 3% weapons and 2% utility.
Missing families redistribute their budget among present families: Swamps rare has no loose ammo;
Garbage currently contains salvage only. Garbage does not acquire weapons or medicine merely to
fill an empty budget. Multiple quantity variants of one item share its family selection weight.

Within families, weights favour regional themes and a regional value band. Garbage boosts tools,
scrap and repair stock; Waystation boosts power, filtration and industrial equipment; Pripyat boosts
computer parts, control electronics, data and research stock. Cheap household entries remain present
but no longer dominate later maps simply because they are cheap. High-value early legacy items remain
possible with low weight. Every active row has a positive integer weight.

Balance estimates below use the full pool, not just the new valuables. Ammunition is priced by the
spawned round count; consumables by spawned uses; per-unit valuables by explicit or mean rolled
quantity; fuel by its partial-container price; weapons by configured durability. These are nominal
item-value estimates, not trader sale quotes or earnings per hour. Loaded rounds in weapons are not
added to the weapon estimate. Rounding and random instance variation can change individual results.

| Pool | All active rows | Estimated mean item value | New valuables chance |
| --- | ---: | ---: | ---: |
| `worldspawn_1` | 160 | 354 | 48.52% |
| `worldspawn_2` | 68 | 1007 | 62.33% |
| `worldspawn_garbage_regular` | 70 | 549 | 97.89% |
| `worldspawn_garbage_rare` | 33 | 1499 | 99.14% |
| `worldspawn_3` | 155 | 856 | 47.70% |
| `worldspawn_4` | 121 | 2303 | 43.51% |
| `worldspawn_5` | 170 | 1253 | 53.41% |
| `worldspawn_6` | 91 | 3507 | 39.57% |

The hand-in catalogue remains separate: these loot entries do not automatically enable the new
`valuables_*` pools in NPC jobs or progression. Selected pools are now assigned by difficulty in town delivery jobs; see the townnpcs README.
Review their acquisition frequency in multiplayer. No world reset, save migration or first-time setup is required.

Checks: `luatex --luaonly tests/valuable_loot_spec.lua`,
`luatex --luaonly tests/valuable_pools_spec.lua`, and `luatex --luaonly tests/valuable_items_spec.lua`.
Standalone tests verify coverage, shared include declarations, total weight, equipment chance caps, whole-item data, household
availability and increasing new-item average values. Actual Garbage spawner selection, loot frequency,
model placement, inventory size/weight and pickup/save behaviour still need multiplayer playtesting.

## Human corpse loot

`pools/human_npc_drops.lua` defines 20 faction/role pools, selected by `ENT.lootGroup` on the
20 installed human NPC classes. Existing bandit pistol/rifle/shotgun IDs remain; snipers,
mercenaries, military and zombified rookie/mercenary/military variants use dedicated IDs.
The existing corpse-looting action makes one selection. NPC weapon drops remain independent.
Existing corpses retain their saved pool ID; newly killed NPCs use the new mapping.

All pools total 10,000 weight. Bandits allocate 35% ammunition, 40% pocket valuables, 15% medical,
5% water and 5% cigarettes/beer. Mercenaries allocate 40% ammunition, 35% field kit, 20% medical
and 5% water. Military allocate 45% ammunition, 30% field kit, 20% medical and 5% water.
Zombified variants allocate 40% smaller ammunition bundles, 55% kit remnants and 5% basic medical;
they carry no drink or vice entries. Ammunition families follow faction/role loadouts, not the
exact randomly selected weapon. Snipers get rifle cartridges rather than pistol ammunition.

Pocket valuables are portable: bandits carry wallets, cheap lighters, stolen effects and tools;
mercenaries carry radio/data equipment and field supplies; military carry identity tags, maps,
service kit and occasional records. Zombified variants carry remnants of those inventories.
Filling food is removed, including the old nuts entries. Medical supplies, water, cigarettes and
beer use explicit small quantities. Large industrial cases, laboratory machines and weapon items
are excluded. No new loot rolls or changes to corpse interaction or weapon condition are added.

Weights share each category budget across its candidates, favouring cheaper nominal items;
military records and wallet kits receive an additional rarity reduction. A wallet kit's opened
contents are random, so nominal selection weights do not establish a fixed corpse cash payout.
Test with `luatex --luaonly tests/human_loot_spec.lua`. Multiplayer checks still required: kill and
loot each faction/role, verify the corpse pool and independent weapon drop, full-inventory pickup,
and ensure one corpse grants only one pocket selection through the existing interaction.

### Expanded pocket valuables and source split

Human pools now include more portable valuables from the regional pools: keepsakes and stolen
electronics for bandits; flash drives, radio accessories, compact tools and trauma supplies for
mercenaries; military records, maps, data cartridges and service tools for soldiers. Zombified
variants retain remnants appropriate to their former group. Each role has at least 20 distinct
valuable candidates. Existing category budgets, ammunition bundles and total 10,000 weights remain;
new valuables share the pocket-kit budget rather than adding more corpse rewards.

The following 20 items are removed from all eight worldspawn tables and remain in human loot.
Other portable finds overlap both sources; household and industrial exploration loot remains.
This source split concerns worldspawn versus human pools, not vendor inventories or story rewards.

| NPC pocket valuables moved out of worldspawn |
| --- |
| `value_badge_bandit` |
| `value_badge_merc` |
| `value_badge_military` |
| `value_badge_renegade` |
| `value_barter_walletwz` |
| `value_bogatir_moreman_tag` |
| `value_chevron_bear` |
| `value_info_militaryflash` |
| `value_intelligence` |
| `value_key_danexert` |
| `value_letter` |
| `value_military_secret_documents_1` |
| `value_military_secret_documents_2` |
| `value_military_secret_documents_3` |
| `value_other_bage_ng` |
| `value_photograph_album` |
| `value_spec_tgflashkey` |
| `value_strelets_amulet` |
| `value_thin_diary` |
| `value_wallet` |

World pools are reweighted after removal, retaining their category budgets and regional value
progression. The combined acquisition test checks all 378 valuables remain obtainable and that
the listed NPC-only pocket items cannot reappear in worldspawn unnoticed. Existing saved NPCs
and corpses use their saved pool IDs; pool membership changes take effect on new loot rolls.

## Hidden cache documents and valuables

Hidden stash notes select `kit_hidestash_1` through `kit_hidestash_4` using the existing
`hidestash_tier_*` distributions. Each kit retains seven loot selections. Its first five
(consumables, ammunition/weapons, aid, money and backpacks) are unchanged. Selection six now
chooses the matching `cache_valuables_tierN` at weight 6 or the existing artifact pool at weight 1:
an 85.7% chance of a rare valuable, not a worldspawn filler item. Selection seven always chooses
`cache_documents_tierN`. These eight new tables live in the already-loaded `cache_misc.lua`.

Rookie documents are clinical/field journals; higher tiers add specialist references, research
dossiers and the valuable legacy research/manual documents. The following eleven IDs are removed
from all eight worldspawn pools, with their acquisition routed through cache documents:

- `value_documents_10`
- `value_documents_11`
- `value_documents_13`
- `value_documents_14`
- `value_documents_9`
- `value_handbook_circuits`
- `value_info_tgdocs`
- `value_lab_journal`
- `value_med_journal_1`
- `value_med_journal_2`
- `value_scientistdiary`

The cache valuable pools make otherwise rare items ordinary cache results. Early kits include
precision tools, sensors and collectible salvage; middle kits include military batteries, radio
modules and instruments; high-end kits include processors, flight recorders and surgical kit;
top kits include thermal modules, military boards, SSDs, laptops, survey stations and diagnostic
instruments. Each tier has eight valuable candidates. Document and valuable weights are proportional to
`1 / ITEM.price`, normalized to 10,000 with integer rounding: an item costing twice as much has
roughly half the selection chance within the same pool. Equal-priced items have equal odds
within one weight point. Weights are authored values; retuning prices requires updating weights.
Both document and valuable average nominal values rise by kit tier. These rare valuables remain
possible in worldspawn; only the eleven listed documents are removed from worldspawn here.

No extra loot rolls, resets, new item IDs or changes to stash-note tier chances are introduced.
Existing kit items use these definitions when opened. Regression checks:
`luatex --luaonly tests/cache_loot_spec.lua` and `luatex --luaonly tests/valuable_loot_spec.lua`.
The tests follow notes to kits to pools, verify the seven selections and the rare-valuable chance,
validate item references and increasing cache value, and protect cache documents from returning
to worldspawn. Opening/pickup, inventory overflow and live cache frequency still need multiplayer QA.
