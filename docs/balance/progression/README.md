# Personal progression balance rationale

The runtime source of truth is `gamemodes/ix_cotz/plugins/progression/`: delivery
slots are declared on each step and candidate pools in `sh_requirementpools.lua`.
The workbook regenerates its views from those files. No game Lua is executed by
the documentation exporter.

`original-requirements.json` is a frozen documentation snapshot of the 134 delivery
requirements before this rebalance, taken from commit `3dde6864`. It is used only
for the workbook's before/after comparison. The game never reads it, and it is not
a save-migration mechanism.

## Quantity and effort decisions

Quantities now follow an acquisition-effort curve rather than the old shared total
split evenly and divided by 16. `../progression_pacing.py` reads the live loot,
item instance yields, poaching, anomaly and mutant definitions without executing Lua.
It writes literal quantities back to the progression definitions. The game does not
run this model or change saved assignments. Reproduce the tuning from the addon root:

```bash
/tmp/cotz-balance-venv/bin/python docs/balance/progression_pacing.py --apply
```

[The generated pacing table](pacing.md) lists every step, its estimated effort,
access depth and quantities. These scores are relative tuning units, not minutes
or measured encounter rates. Assumptions are explicit in the script:

- Marsh, Waystation and Pripyat use difficulty multipliers 1, 1.5 and 2.25.
  Loot routes also include the source map multiplier, so later-map salvage carries
  travel risk even when the hand-in NPC lives in the Marsh.
- World loot uses normalized item weight times expected raw-unit yield. Unit effort
  is `sqrt(1 / (4 * chance * yield * pointFrequency))`, at least one.
  Hard-to-find points use assumed half availability. The square root compresses
  extreme rarity so common supplies still matter without treating very rare drops
  as mandatory hundreds-of-hour grinds. Stack yield informs effort, not a direct
  multiplier of hand-in quantity.
- Mutant danger uses `sqrt(health / 100) * (1 + bulletResistance / 50) *
  (1 + maximumMeleeDamage / 100)`, at least one. Explicit ability multipliers account
  for invisibility, psychic attacks, phantoms and chimera leaps. Trophy effort is
  `sqrt(danger / (threshold / 101))`; guaranteed meat uses chance one. Cooking adds
  0.5 effort after the square root. The easiest defined quarry is used when several
  mutants yield the same meat. This estimates combat cost, not encounter frequency.
- Anomaly specimens use effort 4/10/20 for common/rare/very-rare field tiers.
  Where several documented routes exist, use the cheapest modeled route. Conditional
  cache and reward weights cannot establish how often those sources occur; candidates
  without a modeled world/harvest/field route use explicit rarity fallbacks 1/3/8/16.
- Pool effort is the mean of its candidates' unit efforts. Each slot keeps one shared
  quantity for every candidate. Random alternatives can therefore differ in effort;
  the curve guarantees increasing **modeled average** effort, not identical rolls.

The target starts at eight effort units times the hand-in map multiplier and grows
by 25% per depth. A successor must also cost at least 25% more than every prerequisite's
rounded, actual modeled effort. Dependencies include successor links and NPC access
gates; Quartermaster's gear roots continue above Haggler's terminal branches.
This balancing dependency does not add gameplay unlock requirements.

Boss continues Technut's suit curve by equipment tier: the PS5M step costs at
least 25% more modeled effort than Technut's Wind step, and Berill costs at least
25% more than his final CS3 step. Later Boss steps grow from that baseline.
The IO7a remains a cheap introductory unlock: its 0.13 ballistic, 0.19 rupture
and 0.06 anomaly resistance do not justify a late-game requirement. Berill adds
a fourth category before the five-to-eight-category SKAT and endgame requests.
These are pacing dependencies only; players do not need to finish Technut's
quests to activate Boss's existing quest chain. Existing saved requests stay fixed.

Divide the target effort across categories, round quantities down with a minimum
of one, then add units to the least-funded category until the target is reached.
Rare loot and dangerous trophy hunts therefore request fewer units than plentiful
supplies. Integer rounding and mandatory categories can increase effort above target.
Single-item access gates keep quantity one and carry their preceding effort into
successor tuning. Detector calibration inputs also remain one detector, with a
specialist fallback effort of 16; the other categories absorb additional effort. One completed job is estimated at eight units times map difficulty;
job thresholds round the step target up to whole jobs.

The original item and task JSON snapshots remain historical comparison data only.
Workbook columns showing original / 16 and units above that baseline are comparisons,
not the current quantity rule. Current requirements are read directly from Lua.

## Slot progression

Optional quest lines scale from one to eight slots using their depth along
successor links within the NPC's quest file. Counts use
`1 + floor(7 * depth / maximumDepth + 0.5)`; standalone quests use one slot.
Short terminal branches can finish below eight. Story deliveries use explicit
counts reflecting their place in the main story, while the flash drive and
computer access key remain single-item deliveries.

Haggler and Quartermaster form a shared difficulty range. Haggler uses one slot
at depths 0–1, two at depths 2–3, and three from depth 4 onward, including
Kitting Up 1.2.1.1.1. Quartermaster's gear branches start at four slots and add
one per successor edge, reaching eight on Gearing Up 1.1.2.1.1 and 1.2.2.1.1.
This affects requirements; activation links and NPC access gates are unchanged.
Detector3 is the final detector upgrade and explicitly uses eight slots.

The catalog contains 560 personal slots across 85 pools with 223 distinct candidate
item IDs. The distribution by slot count is: 20 one-slot deliveries, 20 two-slot,
22 three-slot, 10 four-slot, 13 five-slot, 27 six-slot, 9 seven-slot, and 13 eight-slot.
Current quantities and task thresholds are listed in [the pacing table](pacing.md).
The catalog includes alternative branches, so its sum is not a mandatory playthrough
cost. Category breadth remains one to eight slots; quantity tuning uses source effort.

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
remains excluded. Candidates retain their source-based rarity grouping. Alternatives within a slot have equal counts;
spawn yields, loot weights, harvesting odds and combat danger now inform quantity tuning.

`eggheadItemDelivery_Detector3` requires eight categories with paced quantities: one exceptional
specimen plus dedicated Bubble, Burner, Electro, Fruitpunch and Whirlgig categories, plus research and technical documents.
The six anomaly categories are based on the anomaly definitions, so a different family cannot replace
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

Twenty deliveries use localized pools; their slot counts remain unchanged.
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
  trophy probability. The audit reports source odds; the pacing model separately estimates quarry danger.
  Encounter frequency remains unknown.
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
