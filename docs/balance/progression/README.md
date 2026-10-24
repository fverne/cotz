# Personal progression balance rationale

The runtime source of truth is `gamemodes/ix_cotz/plugins/progression/`: delivery
slots are declared on each step and candidate pools in `sh_requirementpools.lua`.
The workbook regenerates its views from those files. No game Lua is executed by
the documentation exporter.

`original-requirements.json` is a frozen documentation snapshot of the 134 delivery
requirements before this rebalance, taken from commit `3dde6864`. It is used only
for the workbook's before/after comparison. The game never reads it, and it is not
a save-migration mechanism.

## Quantity decisions

The original requirements were shared by 16 players. For each delivery, the new
personal raw-unit budget is `ceil(sum(original requirements) / 16)`. Split that
budget evenly across its current category slots: use integer division, then give
one extra unit to the first slots until the remainder is exhausted. Every candidate
in a slot uses the slot's quantity; pool membership changes item identity, not the
budget. Do not multiply the quantity by a candidate's spawn stack size.

A category must request at least one item. The effective total is therefore
`max(number of slots, ceil(original total / 16))`. This preserves the broader
categories without fractional items or empty requirements. The rebalance tab
explicitly shows both the rounded one-player target and any extra units needed
for this minimum. Story keys remain one item.

For example, 200 original units become 13 units across three categories: 5 + 4 + 4.
Haggler's original 105 units become 7: 3 fasteners, 2 household supplies and 2
workshop supplies. Quartermaster's original 300 flesh meat becomes 19 units:
7 of one common meat, 6 ungulate specimens and 6 small-predator specimens.

The catalog contains 405 personal slots across 85 pools with 223 distinct candidate
item IDs. Most deliveries have three categories; fifteen have four, Detector3 has
six, six have one, and three have two. The original catalog's 8,690 raw units now
become 698 units across all 134 definitions. That catalog sum includes alternative
branches, not a mandatory playthrough cost. Fifty-seven deliveries need the
one-item-per-category minimum; every delivery remains below or equal to its
original total.

Task-completion thresholds use `max(1, ceil(original threshold / 16))`:

| Progression | Original shared tasks | Personal tasks |
| --- | ---: | ---: |
| Old Timer introduction | 15 | 1 |
| Boss data tasks | 50 | 4 |
| Smartass RF tasks | 60 | 4 |
| Intern gas-analyzer readings | 90 | 6 |
| Computer artifact tasks | 100 | 7 |

`original-task-requirements.json` records the original task thresholds for the
read-only comparison and regression checks. Like the original item snapshot, it
is documentation data and is never loaded by the game.

## Category breadth and overlap

Delivery steps combine more categories instead of restoring the former bulk counts.
For example, a hardware request can include fasteners, household supplies and workshop
parts; a cooked-meat request can also include drinks or preserved food. Later tasks
combine additional research, repair, trophy or artifact categories.

Related pools deliberately share candidates: computer and field-instrument hardware
share FPGA boards and LCD panels; electrical salvage and instrument hardware share
powerbanks; industrial repair and electrical salvage share military tape and heavy
wiring. Field repair overlaps weapon maintenance and electrical repair. Pools used
together in one step remain disjoint, so no roll can consume another slot's only
candidate or collapse two required categories into one item type.

All nine requested additions are eligible in active progression: documents 1, 2, 3,
6 and 8, FPGA boards, LCD panels, powerbanks and military tape. `value_personal`
remains excluded. Candidates retain their source-based rarity grouping. Quantities
follow the divided raw-unit budget, so alternatives within a slot have equal counts;
spawn stacks and acquisition weights remain evidence for playtesting effort.

`eggheadItemDelivery_Detector3` requires six one-unit selections: one exceptional
specimen plus dedicated Bubble, Burner, Electro, Fruitpunch and Whirlgig categories.
These are based on the anomaly definitions, so a different family cannot replace
the dedicated specimen. Rare thermal and gravitational pools keep their identities;
the Bubble pool no longer accepts the electrical Halo artifact. This encourages
exploration across families, though caches, trading and shared drops in Karusel
can still provide alternative acquisition routes; it does not track visited fields.

The rarity labels are balancing categories for these pools, not a replacement for
item `rarity` values or an assertion about overall encounter rates.

## Map availability

Worldspawn tables are map pairs, not six interchangeable rarity samples:

| Map tier | Map | Ordinary world loot | Hard-to-find world loot |
| --- | --- | --- | --- |
| 1 | Marsh | `worldspawn_1` | `worldspawn_2` |
| 2 | Waystation | `worldspawn_3` | `worldspawn_4` |
| 3 | Pripyat | `worldspawn_5` | `worldspawn_6` |

Delivery definitions declare `lootMapTier`, shown as `Loot map ceiling` in the
step and hand-in tabs. For Old Timer, Haggler, Technut, Mute, Jitters and Spicy
Lemon, opening branches through two successor edges use ceiling 1. Mid branches
at three or four edges use ceiling 2; later branches can use ceiling 3. The Marsh
story deliveries for meat, Technut's main repairs, statues and the radio tower
also use ceiling 1 regardless of their chain depth, so they do not require later
map world loot to advance the early story. Egghead and Beanstalk unlock after
Waystation work and use ceiling 2; map location alone does not make their advanced
research early progression. Boss and Quartermaster use ceiling 2, Computer uses 3.

Every candidate with an active worldspawn entry must have an entry at or below
its delivery's ceiling. A global reward/cache route does not exempt an otherwise
later-map world item. Both ordinary and hard-to-find tables on the permitted map
count; `worldspawn_2` is valid early Marsh loot. Commented entries do not count.

Twenty deliveries were localized without changing their quantities or slot counts.
Early heavy-electrical pools exclude the Waystation powerbank. Early computer and
instrument requirements use local electrical or industrial salvage instead; early
advanced equipment keeps the advanced toolbox that actually spawns in the Marsh.
Mute's early warnings no longer require Pripyat radio modules. Spicy Lemon's early
drinks use ordinary refreshments and beer through `reward_consumable`, which is
included by map-1 assorted caches 1/4/5/6,
excluding candidates whose world spawns start in Pripyat. The late pools retain
powerbanks, FPGA/LCD parts and advanced modules for appropriate progression.

`Acquisition audit` now includes world map tier, map name and normal/hard-to-find
classification. Non-world reward, harvest, cooking, artifact and story-vendor
routes stay explicit. A missing worldspawn entry does not prove availability on
any map: server/vendor/job setup still determines access to those routes. Mutant
and anomaly placement cannot be inferred from their generic harvest/field tables.
The tests enforce map ceilings for every candidate with a known worldspawn route.

## Rarity and availability evidence

Pools are curated by acquisition route and theme, then checked against source data:

- Loot weights are normalized within each source table, including entries for items
  outside the progression. Duplicate weighted entries remain visible separately.
- Explicit spawn quantities override item instance defaults. Simple literal
  `OnInstanced` random quantity ranges are reported separately from stack capacity.
- Poaching records guaranteed meat and the actual `random(0, 100) < threshold`
  trophy probability. Quarry difficulty and encounter frequency are not inferred.
- Cooked requests are traced to their raw meat and quarry. Cooking fuel and time
  remain part of their acquisition cost.
- Artifacts are grouped using common, rare, or very-rare anomaly-field membership
  and cache evidence. Exceptional artifacts never substitute for ordinary scrap.
- Weapon attachments and military suits use matched reward/special-sale weights;
  specialist tool tiers remain distinct where an equivalent replacement is unjustified.

`Acquisition audit` includes original items that were removed as well as current
pool candidates. Missing direct routes are flagged for manual review, such as story
keys obtained through gated vendors. The audit is source evidence, not a live loot
simulation: server spawn-point distributions, vendor access, anomaly activity, and
mutant encounter frequency must be checked on the actual maps after setup.

## Review and playtest

Use `Progression rebalance` for old totals versus the range of personal assignments,
`Progression pools` for pool membership and rationale, and `Acquisition audit` for
source-specific chances and quantity rules. Hand-in and demand rows represent
possible selections, not a combined shopping list or mandatory playthrough cost.

Run early, middle, and late branches with several characters at the same steps.
Measure acquisition time and difficult rolls, especially rare trophies and specialist
sources. Adjust slot quantities or pool membership when evidence
shows unequal effort. Existing saved assignments remain fixed when definitions
change; fresh characters are needed to test newly tuned selections.
