# Regional world loot

Worldspawn pool ownership is Swamps 1/2, Garbage regular/rare, Waystation 3/4, and Pripyat 5/6.
The randomitem library explicitly includes all eight pools on both realms. Map spawn definitions
must select these pool IDs; registering a pool does not place loot spawners or change map presets.

All 378 `valuables_test` items now have at least one worldspawn entry. Household cleaning stock
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
100 weight is a 1% chance per selection. There is no separate old/new allowance. Existing item
membership, quantities, loaded ammunition and durability are unchanged; disabled rows stay disabled.

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
| `worldspawn_1` | 169 | 355 | 50.09% |
| `worldspawn_2` | 73 | 1009 | 62.38% |
| `worldspawn_garbage_regular` | 75 | 549 | 97.90% |
| `worldspawn_garbage_rare` | 34 | 1499 | 99.12% |
| `worldspawn_3` | 160 | 860 | 47.30% |
| `worldspawn_4` | 130 | 2302 | 43.59% |
| `worldspawn_5` | 180 | 1251 | 53.46% |
| `worldspawn_6` | 96 | 3506 | 39.30% |

The hand-in catalogue remains separate: these loot entries do not automatically enable the new
`valuables_*` pools in NPC jobs or progression. Review acquisition frequency in multiplayer before
assigning those pools. No world reset, save migration or first-time setup is required.

Checks: `luatex --luaonly tests/valuable_loot_spec.lua`,
`luatex --luaonly tests/valuable_pools_spec.lua`, and `luatex --luaonly tests/valuable_items_spec.lua`.
Standalone tests verify coverage, shared include declarations, total weight, equipment chance caps, whole-item data, household
availability and increasing new-item average values. Actual Garbage spawner selection, loot frequency,
model placement, inventory size/weight and pickup/save behaviour still need multiplayer playtesting.
