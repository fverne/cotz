# Ballast: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Design reference with an implemented runtime definition.** See the runtime section below for authoritative requirements and rewards.

## Contact brief

- **Home and return point:** Marsh. Every hand-in and reward claim occurs here.
- **Identity:** New: dry-humoured ferryman, patient and respectful of dangerous water.
- **Model:** Provisional Half-Life 2 human model in the appearance definition; final model still open.
- **Only repeatable category:** Equipment recovery.
- **Finite plan:** 22 steps; **6 hand-ins, 5 job checkpoints, 11 authored objectives**.
- **Step labels:** BA01 onward; runtime IDs prefix these labels with cotz/town/<contact-id>/. Keep deployed IDs stable.

## Chapter and dependency structure

The runtime graph has 2 shared introduction nodes, two narrow branches, then a
4-node conclusion requiring both branch tips. The chapter table groups story themes; it does not
impose a single sequential line. Explicit cross-contact equipment prerequisites remain required.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | BA01–BA04 | Stranded shipments |
| 2 | BA05–BA08 | Abandoned landings |
| 3 | BA09–BA14 | Missing boat crew |
| 4 | BA15–BA18 | Disputed freight |
| 5 | BA19–BA22 | Waterside supply route |

## Proposed narrative objectives and rewards

The chapter tables below preserve proposed story direction; they do not define runtime rewards.
Use the linked contact definition and unlock ledger for implemented requirements and benefits. Purchase access
does not grant the item. A clue must identify a real authored destination. A capacity increase does
not fill shelves. Each generic equipment slot remains unassigned until its item and upgrade gates
pass the catalogue audit; it must not be implemented as a convenient arbitrary item.

### Chapter 1: Stranded shipments

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| BA01 | A Dry Package | Hand-in | Deliver rope, packaging, and ordinary transport supplies. | Cargo-preparation barter. |
| BA02 | The First Stranding | Authored | Recover a shipment case on a Marsh shore. | Waterside route clue. |
| BA03 | Nothing Left Behind | Tracker | Cumulative checkpoint C1: complete initial equipment-recovery checkpoint. | One existing recovery supply purchase. |
| BA04 | The Rotten Landing | Authored | Retrieve a landing inspection record. | First waterside stash clue. |

### Chapter 2: Abandoned landings

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| BA05 | Fuel for the Return | Hand-in | Deliver accessible boat operating consumables. | Fuel purchase access. |
| BA06 | A Missing Mooring | Authored | Recover a landing maintenance case. | Travel provisions. |
| BA07 | A Reliable Pair of Hands | Tracker | Cumulative checkpoint C2: reach the next recovery checkpoint. | Selected fuel-stock improvement. |
| BA08 | The Crew List | Authored | Recover a missing crew's roster from a shore cache. | Personal investigation lead. |

### Chapter 3: Missing boat crew

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| BA09 | Names on the Manifest | Hand-in | Supply existing freight and administrative documents. | Transport-supply barter. |
| BA10 | The Floating Trail | Authored | Recover the crew's recorder near a remote Marsh water route. | Crew route information. |
| BA11 | Recover What Matters | Tracker | Cumulative checkpoint C3: maintain recovery work. | Medical preparation supplies. |
| BA12 | The Disputed Cargo | Authored | Retrieve shipment evidence at a Garbage freight site. | Ledger relationship response. |
| BA13 | Patch and Pack | Hand-in | Deliver cargo protection and utility supplies. | One recovery-tool sidegrade purchase. |
| BA14 | The Other Landing | Authored | Recover a landing record at a regional supply stop. | Alternate supply lead. |

### Chapter 4: Disputed freight

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| BA15 | The Long Haul Back | Tracker | Cumulative checkpoint C4: reach the next recovery checkpoint. | Selected transport-supply reserve. |
| BA16 | A Voice From Shore | Authored | Retrieve the crew's recorded message at an abandoned camp. | Final search directions. |
| BA17 | A Boat in Reserve | Hand-in | Deliver existing service consumables. | Modest maintenance credit. |
| BA18 | The Last Mooring | Authored | Recover the crew's final personal case. | Personal story evidence. |

### Chapter 5: Waterside supply route

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| BA19 | Safe to Bring Home | Tracker | Cumulative checkpoint C5: reach the final recovery checkpoint. | Final recovery preparation package. |
| BA20 | The Missing Logbook | Authored | Recover a regional landing log proving what happened. | Crew story resolved. |
| BA21 | A Working Landing | Hand-in | Supply the final transport reserve. | Permanent waterside supply barter. |
| BA22 | The First Return Cargo | Authored | Complete one finite recovery along the restored supply route. | Recognition; ferry travel is not implemented by this quest. |

## Upgrade gates and allocation

Recovery tools cannot shortcut Old Timer's blades or Cleaner's stash tools. Assign tool sidegrades only after checking their consumers.

An unresolved lower-tier prerequisite is an implementation blocker for that reward, not permission
to leave it ungated. Current catalogue milestones are the only equipment permissions. Check alternate
authored shops, barters, and fixed rewards for shortcuts; do not restrict ordinary player trading
or reset existing characters as a side effect of this plan.

## Relationships and editable dialogue

Mocks Atlas for mapping changing ground. Respects Ledger's packing; distrusts Haggler's shipment weights.

| Moment | Draft response |
| --- | --- |
| Greeting | Water's patient. Be a shame to let it outlast you over a parcel. |
| About repeatable work | Stranded cases. Find them, keep them dry, bring them back. |
| Story conclusion | A route with cargo coming both ways. That's a living. |

These samples propose tone, not final dialogue. Preserve existing voice where applicable.
Author editable briefings, partial-progress replies, checkpoint announcements, locked responses,
completion lines, pending-claim messages, referrals, and before/after relationship topics.
A final greeting or recognition is personal unless an explicitly global event is designed.

## Implementation and availability notes

Cases use ground-accessible shore sites. No boats, underwater breathing, ferry teleport, or live rescue AI is assumed.

- Sites and story evidence above are proposed map content, not asserted existing spawns.
- Use existing item/job primitives where suitable; finite commissions are implemented with the existing field primitives. Bespoke evidence items and
  multi-stage investigations still need separate mechanics.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Definition files

- [Jobs, catalogue, task dialogue and progression](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_ballast.lua).
- [Appearance and base stock](../../../gamemodes/ix_cotz/plugins/vendor_adv/definitions/sh_ballast.lua).
- [Conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_ballastnpc.lua).

The [equipment index](../unlock-ledger.md) and loaded catalogue tables define current allocations.
Only current milestone IDs grant access; old completions and stock are not migrated.

## Runtime definition and sparse tree

[Editable contact definition](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_ballast.lua) · [Runtime setup](../../../gamemodes/ix_cotz/plugins/townnpcs/README.md) · [Unlock ledger](../unlock-ledger.md)

| Part | Nodes in order |
| --- | --- |
| Shared introduction | BA01 → BA02 |
| Supplies and work | BA03 → BA05 → BA07 → BA09 → BA11 → BA13 → BA15 → BA17 |
| Field work and story | BA04 → BA06 → BA08 → BA10 → BA12 → BA14 → BA16 → BA18 |
| Conclusion after both branches | BA19 → BA20 → BA21 → BA22 |

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
