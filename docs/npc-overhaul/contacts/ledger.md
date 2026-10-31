# Ledger: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Progression review draft; no runtime progression implementation.** Read the contact index's shared authoring rules first.
Exact item quantities, job totals, coordinates, prices, and unresolved reward IDs are not assigned.

## Contact brief

- **Home and return point:** Waystation. Every hand-in and reward claim occurs here.
- **Identity:** New: methodical freight dispatcher who remembers every overdue parcel.
- **Model:** Provisional Half-Life 2 human model in the appearance scaffold; final model still open.
- **Only repeatable category:** Dead-drop circuits.
- **Finite plan:** 22 steps; **6 hand-ins, 5 job checkpoints, 11 authored objectives**.
- **Design labels:** LE01 onward, used only in these documents; final runtime IDs need a compatibility review.

## Chapter and dependency structure

This first draft is sequential within and between chapters. A later branch split must retain every
equipment-tier dependency. C1 onward are cumulative, contact-specific job checkpoints, not one-job
requirements or lifetime totals. Numerical thresholds and counting baselines require balancing.
Cross-contact upgrade gates are additional requirements on the same player character.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | LE01–LE04 | Local distribution |
| 2 | LE05–LE08 | Settlement connections |
| 3 | LE09–LE14 | Disrupted freight |
| 4 | LE15–LE18 | Remote caches |
| 5 | LE19–LE22 | Expedition network |

## Objectives and small rewards

Rewards below supplement the ordinary finite progression payout where applicable. Purchase access
does not grant the item. A clue must identify a real authored destination. A capacity increase does
not fill shelves. Each generic equipment slot remains unassigned until its item and upgrade gates
pass the catalogue audit; it must not be implemented as a convenient arbitrary item.

### Chapter 1: Local distribution

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| LE01 | Labels That Last | Hand-in | Deliver packaging and administrative supplies. | Basic freight-preparation barter. |
| LE02 | The First Route | Authored | Complete a finite regional dead-drop circuit. | Route information. |
| LE03 | Delivered Intact | Tracker | Cumulative checkpoint C1: complete initial dead-drop checkpoint. | First courier-supply purchase. |
| LE04 | The Missing Receipt | Authored | Recover a receipt from a Waystation freight cache. | Haggler dispute introduced. |

### Chapter 2: Settlement connections

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| LE05 | Stock for the Road | Hand-in | Supply accessible travel provisions. | Selected courier-supply reserve. |
| LE06 | Ballast's Landing Copy | Authored | Recover a landing manifest in Marsh. | Waterside route information. |
| LE07 | On Both Sides | Tracker | Cumulative checkpoint C2: reach the next dead-drop checkpoint. | One travel-supply sidegrade. |
| LE08 | The Interrupted Connection | Authored | Recover a freight case on the Garbage route. | Cleaner referral. |

### Chapter 3: Disrupted freight

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| LE09 | Paperwork That Matches | Hand-in | Deliver ordinary administrative records. | Second freight-supply barter. |
| LE10 | The Duplicate Destination | Authored | Recover paired route records from regional caches. | Misrouting evidence. |
| LE11 | More Than Local | Tracker | Cumulative checkpoint C3: maintain regional dead-drop circuits. | Selected preparation-stock increase. |
| LE12 | The Missing Dispatcher | Authored | Retrieve a dispatcher recorder in regional ruins. | Personal freight-network lead. |
| LE13 | For the Remote Cache | Hand-in | Supply existing durable field provisions. | One recovery-preparation supply purchase. |
| LE14 | The Last Scheduled Drop | Authored | Complete a finite remote cache delivery. | Pripyat supply-route lead. |

### Chapter 4: Remote caches

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| LE15 | A Dependable Circuit | Tracker | Cumulative checkpoint C4: reach the next dead-drop checkpoint. | Expedition provision package. |
| LE16 | The Unmanned Pripyat Cache | Authored | Complete a finite delivery to a Pripyat cache. | No receiver NPC; next route information. |
| LE17 | Proof on Paper | Hand-in | Supply existing documents needed to reconcile shipments. | Final selected courier-supply reserve. |
| LE18 | The Dispatcher's Detour | Authored | Recover the missing dispatcher's recorder in Pripyat. | Diversion explanation. |

### Chapter 5: Expedition network

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| LE19 | The Route Holds | Tracker | Cumulative checkpoint C5: reach the final dead-drop checkpoint. | Final practical courier supply unlock. |
| LE20 | The Return Consignment | Authored | Complete the finite return leg from a Pripyat cache. | Network restoration evidence. |
| LE21 | The Next Shipment | Hand-in | Deliver ordinary freight preparation reserves. | Permanent expedition provision barter. |
| LE22 | The Last Receipt | Authored | Recover the route's final receipt and return to Waystation. | Recognition and reliable-courier greeting. |

## Upgrade gates and allocation

Courier equipment cannot bypass Suture's carrying tiers or Cleaner's storage upgrades. Any stronger item requires its previous-tier milestone.

An unresolved lower-tier prerequisite is an implementation blocker for that reward, not permission
to leave it ungated. Preserve earned permissions through the migration ledger. Check alternate
authored shops, barters, and fixed rewards for shortcuts; do not restrict ordinary player trading
or reset existing characters as a side effect of this plan.

## Relationships and editable dialogue

Depends on Ballast, Cleaner, and Spool; documents disputes with Haggler; appreciates intact cargo.

| Moment | Draft response |
| --- | --- |
| Greeting | If it's arrived, I need the receipt. If it hasn't, I need a reason. |
| About repeatable work | Sealed freight circuits. Collect at one point, deliver at the other. Pickup alone isn't delivery. |
| Story conclusion | Outbound, inbound, accounted for. That's a route we can keep. |

These samples propose tone, not final dialogue. Preserve existing voice where applicable.
Author editable briefings, partial-progress replies, checkpoint announcements, locked responses,
completion lines, pending-claim messages, referrals, and before/after relationship topics.
A final greeting or recognition is personal unless an explicitly global event is designed.

## Implementation and availability notes

Pripyat endpoints are unmanned caches. Preserve cargo ownership through transfer, death and restart. Old Timer's records commission is available without completing this whole line.

- Sites and story evidence above are proposed map content, not asserted existing spawns.
- Use existing item/job primitives where suitable; finite story integration, evidence items, and
  multi-stage completion still need authoritative events and saved-state design.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Current-source reference and unlock audit

This new contact now has a conversation-only scaffold:
[appearance definition](../../../gamemodes/ix_cotz/plugins/vendor_adv/definitions/sh_ledger.lua) and
[basic dialogue](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_ledgernpc.lua).
See the [setup guide](../../../gamemodes/ix_cotz/plugins/vendor_adv/README.md).
Models are provisional; no progression, repeatable work, trade, or services are registered yet.

This is not the complete effective catalogue or the old-to-new unlock ledger. Some old items move
to other contacts; all must retain reachable progression access somewhere. Capture other shared
definitions, dynamic rewards, stock benefits, and excluded-contact allocations in the full audit.
