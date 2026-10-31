# Brass: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Design reference with an implemented runtime definition.** See the runtime section below for authoritative requirements and rewards.

## Contact brief

- **Home and return point:** Garbage. Every hand-in and reward claim occurs here.
- **Identity:** New: meticulous depot veteran who counts everything and distrusts extravagant claims.
- **Model:** Provisional Half-Life 2 human model in the appearance definition; final model still open.
- **Only repeatable category:** Ammunition deliveries.
- **Finite plan:** 24 steps; **6 hand-ins, 6 job checkpoints, 12 authored objectives**.
- **Step labels:** BR01 onward; runtime IDs prefix these labels with cotz/town/<contact-id>/. Keep deployed IDs stable.

## Chapter and dependency structure

The runtime graph has 3 shared introduction nodes, two narrow branches, then a
4-node conclusion requiring both branch tips. The chapter table groups story themes; it does not
impose a single sequential line. Explicit cross-contact equipment prerequisites remain required.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | BR01–BR04 | Recovered stock |
| 2 | BR05–BR10 | Common calibres |
| 3 | BR11–BR14 | Missing consignments |
| 4 | BR15–BR20 | Specialist supply |
| 5 | BR21–BR24 | Reliable reserves |

## Proposed narrative objectives and rewards

The chapter tables below preserve proposed story direction; they do not define runtime rewards.
Use the linked contact definition and unlock ledger for implemented requirements and benefits. Purchase access
does not grant the item. A clue must identify a real authored destination. A capacity increase does
not fill shelves. Each generic equipment slot remains unassigned until its item and upgrade gates
pass the catalogue audit; it must not be implemented as a convenient arbitrary item.

### Chapter 1: Recovered stock

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| BR01 | Count It Twice | Hand-in | Deliver a common ammunition family in explicit round units. | First common-calibre purchase. |
| BR02 | The Broken Seal | Authored | Recover depot packing records in Garbage. | Supply-source clue. |
| BR03 | Reliable Quantities | Tracker | Cumulative checkpoint C1: complete initial ammunition-delivery checkpoint. | First calibre's personal stock increase. |
| BR04 | The Missing Boxes | Authored | Recover a sealed freight case near a vehicle graveyard. | Ammunition preparation package. |

### Chapter 2: Common calibres

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| BR05 | Another Chamber | Hand-in | Supply a second common calibre. | Second calibre purchase. |
| BR06 | The Depot Register | Authored | Retrieve a recovered depot inventory. | Quartermaster referral. |
| BR07 | Not One Round Short | Tracker | Cumulative checkpoint C2: reach the next ammunition checkpoint. | Second calibre's reserve increase. |
| BR08 | The Mixed Shipment | Authored | Recover evidence identifying a wrongly labelled consignment. | Shipment investigation lead. |
| BR09 | Shot and Shell | Hand-in | Deliver accessible shotgun ammunition. | First shotgun ammunition purchase. |
| BR10 | The Supplier's Stamp | Authored | Retrieve supplier paperwork in regional ruins. | Freight-route clue. |

### Chapter 3: Missing consignments

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| BR11 | Enough for the Shift | Tracker | Cumulative checkpoint C3: maintain regional ammunition orders. | Selected shotgun-ammunition reserve. |
| BR12 | Ledger's Missing Receipt | Authored | Recover a freight receipt on a regional route. | Ledger relationship response. |
| BR13 | Rifle Stock | Hand-in | Deliver accessible ordinary rifle ammunition. | First rifle-calibre purchase. |
| BR14 | The Military Manifest | Authored | Recover a military supply record in Waystation territory. | Specialist supply lead. |

### Chapter 4: Specialist supply

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| BR15 | A Working Depot | Tracker | Cumulative checkpoint C4: reach the next ammunition checkpoint. | Selected rifle-ammunition reserve. |
| BR16 | The Empty Truck | Authored | Recover a driver recorder at a remote supply site. | Pripyat consignment clue. |
| BR17 | Specialist Loads | Hand-in | Supply source-verified specialist ammunition. | One specialist load after its ordinary-load milestone. |
| BR18 | The Pripyat Consignment | Authored | Recover a sealed case in Pripyat. | Expedition ammunition package. |
| BR19 | Supply Under Pressure | Tracker | Cumulative checkpoint C5: maintain advanced ammunition orders. | Next specialist load after its base ammunition unlock. |
| BR20 | The Wrong Recipient | Authored | Recover a destination record in Pripyat. | Diversion evidence. |

### Chapter 5: Reliable reserves

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| BR21 | Rounds in Reserve | Hand-in | Deliver a late reserve of accessible calibres. | One selected specialist stock increase. |
| BR22 | The Final Receipt | Authored | Recover the shipment's final freight record. | Final agreement evidence. |
| BR23 | Every Box Accounted For | Tracker | Cumulative checkpoint C6: reach the final ammunition checkpoint. | Final audited ammunition purchase. |
| BR24 | The Depot's Copy | Authored | Recover a supplier's surviving agreement and return it. | Recognition and permanent ammunition-support barter. |

## Upgrade gates and allocation

BR01/BR05/BR09/BR13 introduce distinct ordinary ammunition families. Specialist loads BR17/BR19 require their matching base-family milestone, even if that access is at Quartermaster. Final IDs need weapon compatibility and performance review.

An unresolved lower-tier prerequisite is an implementation blocker for that reward, not permission
to leave it ungated. Current catalogue milestones are the only equipment permissions. Check alternate
authored shops, barters, and fixed rewards for shortcuts; do not restrict ordinary player trading
or reset existing characters as a side effect of this plan.

## Relationships and editable dialogue

Trusts Quartermaster's discipline, dislikes Haggler's bargaining, demands accurate ammunition accounts from Arena Master.

| Moment | Draft response |
| --- | --- |
| Greeting | Put the boxes down. We'll count them before we discuss payment. |
| About repeatable work | Ammunition. The calibre on the order, the quantity on the order. |
| Story conclusion | Every consignment accounted for. Let's keep it that way. |

These samples propose tone, not final dialogue. Preserve existing voice where applicable.
Author editable briefings, partial-progress replies, checkpoint announcements, locked responses,
completion lines, pending-claim messages, referrals, and before/after relationship topics.
A final greeting or recognition is personal unless an explicitly global event is designed.

## Implementation and availability notes

Specify rounds versus boxes and instance quantity. Do not require buying the ammunition that this same task unlocks. Keep source-based valuation.

- Sites and story evidence above are proposed map content, not asserted existing spawns.
- Use existing item/job primitives where suitable; finite commissions are implemented with the existing field primitives. Bespoke evidence items and
  multi-stage investigations still need separate mechanics.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Definition files

- [Jobs, catalogue, task dialogue and progression](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_brass.lua).
- [Appearance and base stock](../../../gamemodes/ix_cotz/plugins/vendor_adv/definitions/sh_brass.lua).
- [Conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_brassnpc.lua).

The [equipment index](../unlock-ledger.md) and loaded catalogue tables define current allocations.
Only current milestone IDs grant access; old completions and stock are not migrated.

## Runtime definition and sparse tree

[Editable contact definition](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_brass.lua) · [Runtime setup](../../../gamemodes/ix_cotz/plugins/townnpcs/README.md) · [Unlock ledger](../unlock-ledger.md)

| Part | Nodes in order |
| --- | --- |
| Shared introduction | BR01 → BR02 → BR03 |
| Supplies and work | BR05 → BR07 → BR09 → BR11 → BR13 → BR15 → BR17 → BR19 |
| Field work and story | BR04 → BR06 → BR08 → BR10 → BR12 → BR14 → BR16 → BR18 → BR20 |
| Conclusion after both branches | BR21 → BR22 → BR23 → BR24 |

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
