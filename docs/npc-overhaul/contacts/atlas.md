# Atlas: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Progression review draft; no runtime progression implementation.** Read the contact index's shared authoring rules first.
Exact item quantities, job totals, coordinates, prices, and unresolved reward IDs are not assigned.

## Contact brief

- **Home and return point:** Marsh. Every hand-in and reward claim occurs here.
- **Identity:** New: patient, meticulous former surveyor, concerned for missing explorers.
- **Model:** Provisional Half-Life 2 human model in the appearance scaffold; final model still open.
- **Only repeatable category:** Sensor deployment and retrieval.
- **Finite plan:** 22 steps; **6 hand-ins, 5 job checkpoints, 11 authored objectives**.
- **Design labels:** AT01 onward, used only in these documents; final runtime IDs need a compatibility review.

## Chapter and dependency structure

This first draft is sequential within and between chapters. A later branch split must retain every
equipment-tier dependency. C1 onward are cumulative, contact-specific job checkpoints, not one-job
requirements or lifetime totals. Numerical thresholds and counting baselines require balancing.
Cross-contact upgrade gates are additional requirements on the same player character.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | AT01–AT04 | Marsh landmarks |
| 2 | AT05–AT08 | Unreliable routes |
| 3 | AT09–AT14 | Garbage approaches |
| 4 | AT15–AT18 | Missing survey teams |
| 5 | AT19–AT22 | Pripyat route |

## Objectives and small rewards

Rewards below supplement the ordinary finite progression payout where applicable. Purchase access
does not grant the item. A clue must identify a real authored destination. A capacity increase does
not fill shelves. Each generic equipment slot remains unassigned until its item and upgrade gates
pass the catalogue audit; it must not be implemented as a convenient arbitrary item.

### Chapter 1: Marsh landmarks

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| AT01 | Marks on Paper | Hand-in | Deliver ordinary survey and writing supplies. | Survey-supply barter. |
| AT02 | The First Landmark | Authored | Deploy and retrieve a recorder near a Marsh landmark. | Local route note. |
| AT03 | Repeatable Ground | Tracker | Cumulative checkpoint C1: complete initial sensor-work checkpoint. | First survey consumable purchase. |
| AT04 | The Route That Shifted | Authored | Retrieve a recorder near a blocked Marsh approach. | Alternate-route clue. |

### Chapter 2: Unreliable routes

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| AT05 | A Better Baseline | Hand-in | Supply existing measuring tools. | Selected survey-supply stock improvement. |
| AT06 | Ballast's Shortcut | Authored | Survey two points along a waterside route. | Ballast relationship response. |
| AT07 | Measured Twice | Tracker | Cumulative checkpoint C2: reach the next sensor checkpoint. | Fixed expedition provisions. |
| AT08 | The Missing Surveyor | Authored | Recover a surveyor's notebook near the Garbage approach. | Personal investigation lead. |

### Chapter 3: Garbage approaches

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| AT09 | Paper Trail | Hand-in | Deliver existing administrative records and survey materials. | One authored stash clue. |
| AT10 | An Unfinished Map | Authored | Collect the surveyor's recorder in Garbage. | Regional route note. |
| AT11 | Ground Truth | Tracker | Cumulative checkpoint C3: maintain regional sensor surveys. | One practical protection purchase. |
| AT12 | The Freight Route | Authored | Retrieve a survey record along Ledger's recorded route. | Freight-route information. |
| AT13 | Lines That Agree | Hand-in | Deliver advanced measuring components. | Survey preparation barter. |
| AT14 | The Wrong Coordinates | Authored | Take finite recordings at two candidate regional landmarks. | Corrected route lead. |

### Chapter 4: Missing survey teams

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| AT15 | Beyond the Margin | Tracker | Cumulative checkpoint C4: reach the next sensor checkpoint. | A regional stash clue. |
| AT16 | The Lost Team's Cache | Authored | Recover a team case in Waystation territory. | Pripyat route fragment. |
| AT17 | Preparing the Last Sheet | Hand-in | Supply late-expedition recording materials. | Fixed field supplies. |
| AT18 | The First Pripyat Mark | Authored | Deploy and retrieve a recorder at a Pripyat entry landmark. | Safe-return route information. |

### Chapter 5: Pripyat route

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| AT19 | A Map Worth Carrying | Tracker | Cumulative checkpoint C5: reach the final sensor checkpoint. | Final survey-supply reserve. |
| AT20 | The Last Survey Station | Authored | Recover the team's final recorder deeper in Pripyat. | Final route fragment. |
| AT21 | An Atlas With Names | Hand-in | Deliver ordinary records needed to identify survey sites. | Permanent survey preparation barter. |
| AT22 | Finish Their Route | Authored | Record the final Pripyat site and return the completed evidence. | Recognition and named expedition route notes. |

## Upgrade gates and allocation

Any equipment upgrade requires its earlier-tier milestone. Route notes cannot bypass the main physical travel gates.

An unresolved lower-tier prerequisite is an implementation blocker for that reward, not permission
to leave it ungated. Preserve earned permissions through the migration ledger. Check alternate
authored shops, barters, and fixed rewards for shortcuts; do not restrict ordinary player trading
or reset existing characters as a side effect of this plan.

## Relationships and editable dialogue

Trusts Ballast's local knowledge and Ledger's records. Cross-checks The Original's stories; works with Wake on missing routes.

| Moment | Draft response |
| --- | --- |
| Greeting | A route is only useful if it still gets you home. |
| About repeatable work | Set the recorder down, let it finish, bring it back. We need measurements we can trust. |
| Story conclusion | I'll put their names on the finished sheet. They earned that much. |

These samples propose tone, not final dialogue. Preserve existing voice where applicable.
Author editable briefings, partial-progress replies, checkpoint announcements, locked responses,
completion lines, pending-claim messages, referrals, and before/after relationship topics.
A final greeting or recognition is personal unless an explicitly global event is designed.

## Implementation and availability notes

Notes need real tested destinations; no new GPS overlay or navigation system is implied. Survey tasks use issued task equipment rather than a detector they reward.

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
[appearance definition](../../../gamemodes/ix_cotz/plugins/vendor_adv/definitions/sh_atlas.lua) and
[basic dialogue](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_atlasnpc.lua).
See the [setup guide](../../../gamemodes/ix_cotz/plugins/vendor_adv/README.md).
Models are provisional; no progression, repeatable work, trade, or services are registered yet.

This is not the complete effective catalogue or the old-to-new unlock ledger. Some old items move
to other contacts; all must retain reachable progression access somewhere. Capture other shared
definitions, dynamic rewards, stock benefits, and excluded-contact allocations in the full audit.
