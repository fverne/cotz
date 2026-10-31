# Atlas: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Design reference with an implemented runtime definition.** See the runtime section below for authoritative requirements and rewards.

## Contact brief

- **Home and return point:** Marsh. Every hand-in and reward claim occurs here.
- **Identity:** New: patient, meticulous former surveyor, concerned for missing explorers.
- **Model:** Provisional Half-Life 2 human model in the appearance definition; final model still open.
- **Only repeatable category:** Sensor deployment and retrieval.
- **Finite plan:** 22 steps; **6 hand-ins, 5 job checkpoints, 11 authored objectives**.
- **Step labels:** AT01 onward; runtime IDs prefix these labels with cotz/town/<contact-id>/. Keep deployed IDs stable.

## Chapter and dependency structure

The runtime graph has 2 shared introduction nodes, two narrow branches, then a
4-node conclusion requiring both branch tips. The chapter table groups story themes; it does not
impose a single sequential line. Explicit cross-contact equipment prerequisites remain required.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | AT01–AT04 | Marsh landmarks |
| 2 | AT05–AT08 | Unreliable routes |
| 3 | AT09–AT14 | Garbage approaches |
| 4 | AT15–AT18 | Missing survey teams |
| 5 | AT19–AT22 | Pripyat route |

## Proposed narrative objectives and rewards

The chapter tables below preserve proposed story direction; they do not define runtime rewards.
Use the linked contact definition and unlock ledger for implemented requirements and benefits. Purchase access
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
to leave it ungated. Current catalogue milestones are the only equipment permissions. Check alternate
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
- Use existing item/job primitives where suitable; finite commissions are implemented with the existing field primitives. Bespoke evidence items and
  multi-stage investigations still need separate mechanics.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Definition files

- [Jobs, catalogue, task dialogue and progression](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_atlas.lua).
- [Appearance and base stock](../../../gamemodes/ix_cotz/plugins/vendor_adv/definitions/sh_atlas.lua).
- [Conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_atlasnpc.lua).

The [equipment index](../unlock-ledger.md) and loaded catalogue tables define current allocations.
Only current milestone IDs grant access; old completions and stock are not migrated.

## Runtime definition and sparse tree

[Editable contact definition](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_atlas.lua) · [Runtime setup](../../../gamemodes/ix_cotz/plugins/townnpcs/README.md) · [Unlock ledger](../unlock-ledger.md)

| Part | Nodes in order |
| --- | --- |
| Shared introduction | AT01 → AT02 |
| Supplies and work | AT03 → AT05 → AT07 → AT09 → AT11 → AT13 → AT15 → AT17 |
| Field work and story | AT04 → AT06 → AT08 → AT10 → AT12 → AT14 → AT16 → AT18 |
| Conclusion after both branches | AT19 → AT20 → AT21 → AT22 |

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
