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

Runtime trackers count cumulative successful jobs with that exact town contact, starting with the current system. There is no import of previous numeric counters. Thresholds are 2, 5, 9, 14, 20, 27, and 35 where the contact has those checkpoints. Work between
checkpoints remains credited. Field commissions do not increment repeatable-job counters.
Trees share a short trunk, split into two narrow branches, then join before the finale. Item-family
prerequisites can add cross-branch or cross-contact links; the loaded graph defines actual availability.

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
and player trading remain separate acquisition paths.

The requirement concerns distribution across NPCs, not account-wide access. Progression and purchase
access remain personal to each player character unless the user explicitly changes that policy.

The [equipment index](unlock-ledger.md) lists all 210 current gated items and their sellers/milestones.
Each contact's catalogue table is authoritative for trade terms and placement. Current definitions
retain the item routes assembled for the overhaul, including equipment formerly sold by excluded contacts.
Secret Hoarder spawning and separate wish services remain outside the town roster.

Only current milestones grant access. There are no old-ID aliases, earned-permission imports, stock
identity conversions or grandfathered prerequisites. Obsolete saved data is not reset or interpreted
as new progress. Tests cover reachable nodes, configured tier prerequisites and current permissions.
Live acquisition pacing and economy still need playtesting.

## Dependency and availability review

For each step prove that its requested items, required equipment, destinations, and service provider
are accessible before completion. Check every candidate in random requirement pools. Do not gate a
detector behind work that needs that detector, or gate Pripyat behind its own exclusive materials.
Keep physical NPC arrival, personal access, and travel permissions separate.

Calibrate effort using actual supply, quantities, travel, hazard preparation, and competition.
Adding Garbage requires re-evaluating the current Marsh/Waystation/Pripyat tier assumptions;
do not insert a numeric tier and silently change existing assignments.
