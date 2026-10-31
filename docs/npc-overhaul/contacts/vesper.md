# Vesper: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Design reference with an implemented runtime definition.** See the runtime section below for authoritative requirements and rewards.

## Contact brief

- **Home and return point:** Garbage. Every hand-in and reward claim occurs here.
- **Identity:** New: practical anomaly prospector who values bringing the team home.
- **Model:** Provisional Half-Life 2 human model in the appearance definition; final model still open.
- **Only repeatable category:** Sensor deployment and retrieval.
- **Finite plan:** 24 steps; **6 hand-ins, 6 job checkpoints, 12 authored objectives**.
- **Step labels:** VE01 onward; runtime IDs prefix these labels with cotz/town/<contact-id>/. Keep deployed IDs stable.

## Chapter and dependency structure

The runtime graph has 2 shared introduction nodes, two narrow branches, then a
4-node conclusion requiring both branch tips. The chapter table groups story themes; it does not
impose a single sequential line. Explicit cross-contact equipment prerequisites remain required.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | VE01–VE04 | Local fields |
| 2 | VE05–VE10 | Comparative conditions |
| 3 | VE11–VE14 | Changing activity |
| 4 | VE15–VE20 | Deep expeditions |
| 5 | VE21–VE24 | Pripyat fields |

## Proposed narrative objectives and rewards

The chapter tables below preserve proposed story direction; they do not define runtime rewards.
Use the linked contact definition and unlock ledger for implemented requirements and benefits. Purchase access
does not grant the item. A clue must identify a real authored destination. A capacity increase does
not fill shelves. Each generic equipment slot remains unassigned until its item and upgrade gates
pass the catalogue audit; it must not be implemented as a convenient arbitrary item.

### Chapter 1: Local fields

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| VE01 | Before the Field | Hand-in | Deliver basic field protection consumables. | Basic prospecting-supply barter. |
| VE02 | The Quiet Edge | Authored | Deploy and retrieve a sensor at a Garbage anomaly approach. | Local field information. |
| VE03 | Readings Worth Keeping | Tracker | Cumulative checkpoint C1: complete initial sensor-work checkpoint. | First protection consumable purchase. |
| VE04 | Beanstalk's Baseline | Authored | Recover a control recorder away from the field. | Scientific disagreement introduced. |

### Chapter 2: Comparative conditions

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| VE05 | Reliable Instruments | Hand-in | Supply existing recording and maintenance materials. | One prospecting accessory purchase. |
| VE06 | The Second Field | Authored | Record conditions at a different Garbage field. | Comparison lead. |
| VE07 | Same Method Twice | Tracker | Cumulative checkpoint C2: reach the next sensor checkpoint. | Selected protection-supply reserve. |
| VE08 | The Abandoned Detector | Authored | Recover a prospector's field case. | Egghead referral; no free higher detector. |
| VE09 | Keep It Sealed | Hand-in | Deliver exposure-preparation supplies. | Next protection tier after its owner's earlier milestone. |
| VE10 | The Unstable Reading | Authored | Retrieve a recorder from a disputed field site. | Changed research discussion. |

### Chapter 3: Changing activity

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| VE11 | Outside Familiar Ground | Tracker | Cumulative checkpoint C3: maintain regional sensor work. | One preparation-supply sidegrade. |
| VE12 | The Control Run | Authored | Record at a regional control site. | Intern relationship response. |
| VE13 | Supplies for Distance | Hand-in | Deliver accessible expedition consumables. | Long-expedition barter. |
| VE14 | The Lost Team's Notes | Authored | Recover a prospecting log in Waystation territory. | Pripyat expedition lead. |

### Chapter 4: Deep expeditions

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| VE15 | Know When to Leave | Tracker | Cumulative checkpoint C4: reach the next sensor checkpoint. | Selected field-supply stock increase. |
| VE16 | The First Pripyat Field | Authored | Deploy and retrieve a recorder at a Pripyat field. | Deep-field information. |
| VE17 | No Borrowed Luck | Hand-in | Supply source-verified advanced protective goods. | Another protective sidegrade purchase. |
| VE18 | The Team's Cache | Authored | Recover a lost prospecting team's equipment case. | Personal expedition evidence. |
| VE19 | A Measured Risk | Tracker | Cumulative checkpoint C5: maintain advanced sensor work. | Next audited protection unlock. |
| VE20 | The Field They Chose | Authored | Record the team's last known anomaly site. | Expedition outcome clue. |

### Chapter 5: Pripyat fields

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| VE21 | Enough to Compare | Hand-in | Deliver ordinary research records and service materials. | Final prospecting-supply reserve. |
| VE22 | A Different Explanation | Authored | Recover a missing control recorder in Pripyat. | Beanstalk reconciliation evidence. |
| VE23 | Everyone Comes Back | Tracker | Cumulative checkpoint C6: reach the final sensor checkpoint. | Permanent specialist preparation barter. |
| VE24 | The Last Recorder | Authored | Retrieve the expedition's final recorder and return its account. | Recognition and conditional scientific reconciliation. |

## Upgrade gates and allocation

VE03 basic protection → VE09 next tier → VE19 later tier, plus the actual lower-tier owner's milestone. No better artifact detector before Egghead's relevant tier.

An unresolved lower-tier prerequisite is an implementation blocker for that reward, not permission
to leave it ungated. Current catalogue milestones are the only equipment permissions. Check alternate
authored shops, barters, and fixed rewards for shortcuts; do not restrict ordinary player trading
or reset existing characters as a side effect of this plan.

## Relationships and editable dialogue

Respects Egghead's knowledge, challenges laboratory assumptions, finds Beanstalk overcautious, checks Intern's field equipment.

| Moment | Draft response |
| --- | --- |
| Greeting | You can admire the field from here. Closer costs preparation. |
| About repeatable work | Deploy the sensor, let it record, collect it. Getting yourself killed doesn't improve the reading. |
| Story conclusion | We brought the results home. That's what makes it a successful expedition. |

These samples propose tone, not final dialogue. Preserve existing voice where applicable.
Author editable briefings, partial-progress replies, checkpoint announcements, locked responses,
completion lines, pending-claim messages, referrals, and before/after relationship topics.
A final greeting or recognition is personal unless an explicitly global event is designed.

## Implementation and availability notes

Sensor sites must be reachable without unavoidable lethal exposure. Comparison work must not require finishing Beanstalk's full line.

- Sites and story evidence above are proposed map content, not asserted existing spawns.
- Use existing item/job primitives where suitable; finite commissions are implemented with the existing field primitives. Bespoke evidence items and
  multi-stage investigations still need separate mechanics.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Definition files

- [Jobs, catalogue, task dialogue and progression](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_vesper.lua).
- [Appearance and base stock](../../../gamemodes/ix_cotz/plugins/vendor_adv/definitions/sh_vesper.lua).
- [Conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_vespernpc.lua).

The [equipment index](../unlock-ledger.md) and loaded catalogue tables define current allocations.
Only current milestone IDs grant access; old completions and stock are not migrated.

## Runtime definition and sparse tree

[Editable contact definition](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_vesper.lua) · [Runtime setup](../../../gamemodes/ix_cotz/plugins/townnpcs/README.md) · [Unlock ledger](../unlock-ledger.md)

| Part | Nodes in order |
| --- | --- |
| Shared introduction | VE01 → VE02 |
| Supplies and work | VE03 → VE05 → VE07 → VE09 → VE11 → VE13 → VE15 → VE17 → VE19 |
| Field work and story | VE04 → VE06 → VE08 → VE10 → VE12 → VE14 → VE16 → VE18 → VE20 |
| Conclusion after both branches | VE21 → VE22 → VE23 → VE24 |

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
