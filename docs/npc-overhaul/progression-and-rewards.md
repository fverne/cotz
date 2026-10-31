# Progression and reward rules

[Design index](README.md) · [Roster](roster.md) · [Old Timer example](old-timer.md)

## Long-term pacing

User intent: completing all NPC progressions should take a long time, with many small unlocks.
The working budget is 646 steps across 27 contacts. Counts measure authored content, not hours.
No completion-time promise is justified until sources, travel, competition, and live pacing are measured.

Suggested ranges: core service contacts 24–30 steps; equipment/research specialists 20–26;
exploration/logistics contacts 18–24; arena 20–24. These total 544–704 for the current roster.
Use five broad chapters per contact: establish trust, build the operation, develop a specialty,
support expeditions, and resolve a personal project. Parallel branches create choice.

Give useful rewards early. Later effort should come from preparation, travel, varied acquisition,
and harder objectives, not only larger stacks. Avoid daily streaks, forced resets, or arbitrary waiting.
Preserve basic repairs, treatment, food, and practical starting equipment before specialist completion.

## Objective mix

Roughly every second finite step should use an ordinary item hand-in or repeatable-job tracker.
A working split is 25% hand-ins, 25% trackers, and 50% authored field/story objectives.
Allow local variation and irregular ordering; the user requested "2nd-ish", not rigid alternation.

| Kind | Definition | Authoring rule |
| --- | --- | --- |
| Item hand-in | Ordinary existing items submitted through persistent requirements. | Specify accessible sources, units, partial-stack handling, and candidate pools. |
| Job tracker | Count successful completions of the issuing contact's one repeatable category. | Use persistent cumulative checkpoints within a programme; do not count previews, acceptance, abandonment, or another NPC's work. |
| Authored field/story | A location-specific recovery, investigation, survey, defence, or finite expedition event. | Define an authoritative completion event and saved state; a description alone is not a mechanic. |

Returning a story-specific case is still an authored recovery, not the regular hand-in slot.
Conversation can finish a completed field step; avoid padding the count with a separate "say thanks" objective.
Arena milestones count distinct qualifying bouts/opponents under the existing anti-farming rules;
its exact mix of hand-ins and authored competitive objectives needs a bespoke review.

For trackers, choose and display the counting baseline before authoring thresholds. Proposed policy:
start when that programme becomes available, save its baseline, and retain cumulative credit for all
its checkpoints. Work between checkpoints should not disappear. Back-credit for earlier lifetime jobs
is an open decision. Do not silently use lifetime counts or reset counts between stages.
A single valid completion may earn ordinary job payment and advance its intended finite tracker;
it must not create duplicate job payments or advance unrelated NPC programmes.

## Reward granularity

A completion should visibly provide an item, credit, purchase option, stock improvement, useful
information, new authored activity, or personal recognition. Major equipment may require several steps.
Bundle splitting should produce meaningful choices, not dozens of empty prerequisites.

| Reward | Intended use | Constraint |
| --- | --- | --- |
| Purchase access | Unlock one item or a tightly related small set. | An unlock is permission to buy, not a free item. Catalogue, price, stock, and preparation support must exist. |
| Personal stock capacity | Improve selected supplies a little at a time. | Capacity does not automatically fill shelves; inspect cumulative caps and competing branches. |
| Fixed supplies | Help finance the next expedition. | Specify quantity/uses; retain pending claims when inventory is full. |
| Service credit | Occasional treatment, repair, or storage benefit. | Name provider, respect access and balance caps; never cash out credit. |
| Service discount | Small permanent relationship benefit. | Respect current service caps; do not stack all chapter discounts additively. |
| Clue or recognition | Reward exploration or a personal story. | Supply useful authored information and visible feedback, not vague "trust" with no effect. |

Use current cash, reputation, reward, and restock behaviour as the starting point. A new step is not
permission to mint an additional ordinary job payout. Repeated milestone restocking across hundreds
of stages needs an economy review before implementation.

## Preserve all existing vendor item unlocks

### Equipment upgrade order

Redistributing sellers must preserve the usefulness of earlier equipment. Keep direct upgrades on
one NPC's ordered progression branch where practical. If an upgrade belongs with another seller,
its unlock must require both that seller's local milestone and the previous tier's progression
milestone on the same player character. A later home map, higher price, reputation threshold, or
longer-looking quest is not a substitute for an explicit dependency.

For knives, preserve knife2 → knife3 → knife4: Old Timer step 3 unlocks knife2, step 12 unlocks
knife3, and Quartermaster's knife4 milestone additionally requires completion of Old Timer step 12.
The dependency is on earned progression, not merely owning or buying the earlier knife.
Do not require a purchase or consume the earlier equipment unless the objective explicitly calls for it.

Audit other genuine upgrade families, including detectors and sharpening stones, using their actual
effects and consumers. Do not assume every weapon, tool, or armour option forms one linear hierarchy;
sidegrades can have parallel branches. Record each classification and prerequisite in the unlock ledger.
Check alternate authored purchases, barters, and fixed rewards for accidental shortcuts. Existing loot,
player trading, and earned permissions need explicit review rather than an unrequested blanket restriction.

The requirement concerns distribution across NPCs, not account-wide access. Progression and purchase
access remain personal to each player character unless the user explicitly changes that policy.

Before replacing any progression, make a complete ledger from the live definitions, not old planning
spreadsheets. Cover all current contacts, including excluded ???, Computer, community NPC, and Hoarder.
For each old vendor unlock record:

| Required ledger field | Purpose |
| --- | --- |
| Old progression ID, seller, item ID | Trace every source and distinguish duplicate unlocks. |
| New seller, home map, and step ID | Establish an actual destination and loaded catalogue entry. |
| Access prerequisites and acquisition sources | Prevent cyclic locks and accidentally earlier availability. |
| Upgrade family, previous tier, and required milestone | Preserve lower-tier relevance across sellers and parallel branches. |
| Trade mode, pricing, stock/refill policy | Preserve item availability without silently promising identical balance. |
| Existing-completion migration | Preserve earned access when its old source moves. |
| Coverage status and reason | Every entry must be retained, merged with an equivalent route, or explicitly unresolved. |

Every currently unlocked item must retain a progression acquisition route somewhere in the roster.
Duplicate old routes can map to one documented route, provided earned permissions are preserved.
Removed NPCs are not permission to delete their item unlocks. Hoarder's secret periodic lifecycle stays
outside the overhaul; review overlaps without exposing his identity or stripping secret content by accident.
Wish mechanics and other unique non-vendor services are not automatically promised replacements.

Old Timer's verified starting allocation is in the worked example. The whole-roster ledger is still
outstanding; these documents do not claim that full coverage has been audited.

## Dependency and availability review

For each step prove that its requested items, required equipment, destinations, and service provider
are accessible before completion. Check every candidate in random requirement pools. Do not gate a
detector behind work that needs that detector, or gate Pripyat behind its own exclusive materials.
Keep physical NPC arrival, personal access, and travel permissions separate.

Calibrate effort using actual supply, quantities, travel, hazard preparation, and competition.
Adding Garbage requires re-evaluating the current Marsh/Waystation/Pripyat tier assumptions;
do not insert a numeric tier and silently change existing assignments.
