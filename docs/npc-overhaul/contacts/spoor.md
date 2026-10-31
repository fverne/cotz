# Spoor: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Design reference with an implemented runtime definition.** See the runtime section below for authoritative requirements and rewards.

## Contact brief

- **Home and return point:** Garbage. Every hand-in and reward claim occurs here.
- **Identity:** New: quiet tracker interested in feeding patterns, dislikes trophy hunting.
- **Model:** Provisional Half-Life 2 human model in the appearance definition; final model still open.
- **Only repeatable category:** Mutant hunting.
- **Finite plan:** 22 steps; **6 hand-ins, 5 job checkpoints, 11 authored objectives**.
- **Step labels:** SP01 onward; runtime IDs prefix these labels with cotz/town/<contact-id>/. Keep deployed IDs stable.

## Chapter and dependency structure

The runtime graph has 2 shared introduction nodes, two narrow branches, then a
4-node conclusion requiring both branch tips. The chapter table groups story themes; it does not
impose a single sequential line. Explicit cross-contact equipment prerequisites remain required.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | SP01–SP04 | Scavenging grounds |
| 2 | SP05–SP08 | Feeding patterns |
| 3 | SP09–SP14 | Displaced packs |
| 4 | SP15–SP18 | Unusual predators |
| 5 | SP19–SP22 | Pripyat hunts |

## Proposed narrative objectives and rewards

The chapter tables below preserve proposed story direction; they do not define runtime rewards.
Use the linked contact definition and unlock ledger for implemented requirements and benefits. Purchase access
does not grant the item. A clue must identify a real authored destination. A capacity increase does
not fill shelves. Each generic equipment slot remains unassigned until its item and upgrade gates
pass the catalogue audit; it must not be implemented as a convenient arbitrary item.

### Chapter 1: Scavenging grounds

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| SP01 | Reading the Remains | Hand-in | Deliver common harvested specimens. | Basic hunting-supply barter. |
| SP02 | The Scavenger's Camp | Authored | Recover observations beside a Garbage hunting ground. | Hunting-route information. |
| SP03 | Clear the Approach | Tracker | Cumulative checkpoint C1: complete initial mutant-hunting checkpoint. | First hunting ammunition purchase. |
| SP04 | Where They Feed | Authored | Retrieve a recorder from a feeding site. | Species preparation advice. |

### Chapter 2: Feeding patterns

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| SP05 | Tools for the Field | Hand-in | Supply ordinary field-maintenance materials. | Machete purchase after any verified lower blade milestone. |
| SP06 | Lemon's Complaint | Authored | Recover meat-handling notes from an abandoned camp. | Cooking preparation supplies. |
| SP07 | A Safer Yard | Tracker | Cumulative checkpoint C2: reach the next hunting checkpoint. | Selected ammunition-stock increase. |
| SP08 | The Displaced Pack | Authored | Recover observations from a second hunting ground. | Migration-pattern lead. |

### Chapter 3: Displaced packs

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| SP09 | Different Quarry | Hand-in | Deliver specimens from accessible predator families. | One protective consumable purchase. |
| SP10 | Tracks in the Wrong Place | Authored | Collect a recorder along a disturbed regional route. | The Original relationship topic. |
| SP11 | Patient Work | Tracker | Cumulative checkpoint C3: maintain regional mutant hunts. | Next hunting-supply sidegrade. |
| SP12 | The Empty Hide | Authored | Recover a hunter's case at a remote observation site. | Field supplies. |
| SP13 | Proof of Change | Hand-in | Supply uncommon existing specimens. | One protective equipment sidegrade. |
| SP14 | The Pattern Breaks | Authored | Retrieve a survey recorder in Waystation territory. | Pripyat predator clue. |

### Chapter 4: Unusual predators

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| SP15 | No Easy Quarry | Tracker | Cumulative checkpoint C4: reach the next hunting checkpoint. | Next ammunition purchase with calibre support. |
| SP16 | The First Pripyat Trail | Authored | Recover an observer's notebook at a Pripyat hunting site. | Expedition supplies. |
| SP17 | Preparing for the Worst | Hand-in | Deliver late hunting preparation goods. | Final selected hunting-supply reserve. |
| SP18 | The Survivor's Cache | Authored | Recover a hunter's abandoned case deeper in Pripyat. | Final hunt directions. |

### Chapter 5: Pripyat hunts

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| SP19 | The Dangerous Ones | Tracker | Cumulative checkpoint C5: reach the final hunting checkpoint. | Final audited hunting-equipment unlock. |
| SP20 | The Last Observation | Authored | Retrieve the target species' observation recorder in Pripyat. | Pattern explained. |
| SP21 | What the Records Missed | Hand-in | Deliver source-verified late specimens. | Permanent specialist hunting barter. |
| SP22 | The Hunter's Proof | Authored | Complete the authored final NPC-mutant hunt and return its evidence. | Recognition and revised field advice. |

## Upgrade gates and allocation

SP05 Machete requires the verified earlier tool/blade milestone if a direct upgrade. Old Timer step 8 is a candidate only after comparing Hatchet and Machete. Stronger ammunition requires its Brass base-load milestone.

An unresolved lower-tier prerequisite is an implementation blocker for that reward, not permission
to leave it ungated. Current catalogue milestones are the only equipment permissions. Check alternate
authored shops, barters, and fixed rewards for shortcuts; do not restrict ordinary player trading
or reset existing characters as a side effect of this plan.

## Relationships and editable dialogue

Respects Old Timer, disputes The Original's mutant accounts, argues with Spicy Lemon over carcasses.

| Moment | Draft response |
| --- | --- |
| Greeting | Tell me where you saw it. Then tell me what it was eating. |
| About repeatable work | Mutants threatening the routes. I'll name the quarry. Don't bring me stories about something else. |
| Story conclusion | Now we know why they moved. Better than another tall tale. |

These samples propose tone, not final dialogue. Preserve existing voice where applicable.
Author editable briefings, partial-progress replies, checkpoint announcements, locked responses,
completion lines, pending-claim messages, referrals, and before/after relationship topics.
A final greeting or recognition is personal unless an explicitly global event is designed.

## Implementation and availability notes

Use existing species and classes unless a new encounter is scoped. Recorded observations do not imply footprint tracking or new AI.

- Sites and story evidence above are proposed map content, not asserted existing spawns.
- Use existing item/job primitives where suitable; finite commissions are implemented with the existing field primitives. Bespoke evidence items and
  multi-stage investigations still need separate mechanics.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Definition files

- [Jobs, catalogue, task dialogue and progression](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_spoor.lua).
- [Appearance and base stock](../../../gamemodes/ix_cotz/plugins/vendor_adv/definitions/sh_spoor.lua).
- [Conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_spoornpc.lua).

The [equipment index](../unlock-ledger.md) and loaded catalogue tables define current allocations.
Only current milestone IDs grant access; old completions and stock are not migrated.

## Runtime definition and sparse tree

[Editable contact definition](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_spoor.lua) · [Runtime setup](../../../gamemodes/ix_cotz/plugins/townnpcs/README.md) · [Unlock ledger](../unlock-ledger.md)

| Part | Nodes in order |
| --- | --- |
| Shared introduction | SP01 → SP02 |
| Supplies and work | SP03 → SP05 → SP07 → SP09 → SP11 → SP13 → SP15 → SP17 |
| Field work and story | SP04 → SP06 → SP08 → SP10 → SP12 → SP14 → SP16 → SP18 |
| Conclusion after both branches | SP19 → SP20 → SP21 → SP22 |

Equipment gates can add prerequisites across these branches or contacts. The requires and
crossRequires fields plus the shared catalogue upgrade chains are authoritative.
Edit job.kind, job.pools, job.quantities, job.minimumValue and job.maps to tune repeatable work.
Edit dialogue prompts and progression briefings/completion text in the contact definition;
background and gossip remain in the existing conversation file.

The tables above retain the original story/reward direction. Actual item IDs, quantities, cumulative
targets, stock benefits, discounts and catalogue access are now specified by the runtime definitions
and unlock ledger. Field commissions use configured point pools; physical locations still need map
authoring and multiplayer verification. No live rescue or bespoke multi-site investigation mechanic
is implied by the narrative. Arena objectives count completed eligible bouts, not an unreported win.
