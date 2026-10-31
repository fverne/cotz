# Gasket: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Design reference with an implemented runtime definition.** See the runtime section below for authoritative requirements and rewards.

## Contact brief

- **Home and return point:** Marsh. Every hand-in and reward claim occurs here.
- **Identity:** New: gruff utilities caretaker who treats the generator like an unreliable relative.
- **Model:** Provisional Half-Life 2 human model in the appearance definition; final model still open.
- **Only repeatable category:** Utility supply deliveries.
- **Finite plan:** 22 steps; **6 hand-ins, 5 job checkpoints, 11 authored objectives**.
- **Step labels:** GK01 onward; runtime IDs prefix these labels with cotz/town/<contact-id>/. Keep deployed IDs stable.

## Chapter and dependency structure

The runtime graph has 3 shared introduction nodes, two narrow branches, then a
4-node conclusion requiring both branch tips. The chapter table groups story themes; it does not
impose a single sequential line. Explicit cross-contact equipment prerequisites remain required.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | GK01–GK04 | Generator |
| 2 | GK05–GK08 | Water infrastructure |
| 3 | GK09–GK14 | Spare supplies |
| 4 | GK15–GK18 | Emergency reserves |
| 5 | GK19–GK22 | Long-term provision |

## Proposed narrative objectives and rewards

The chapter tables below preserve proposed story direction; they do not define runtime rewards.
Use the linked contact definition and unlock ledger for implemented requirements and benefits. Purchase access
does not grant the item. A clue must identify a real authored destination. A capacity increase does
not fill shelves. Each generic equipment slot remains unassigned until its item and upgrade gates
pass the catalogue audit; it must not be implemented as a convenient arbitrary item.

### Chapter 1: Generator

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| GK01 | Keep It Turning | Hand-in | Deliver operating fuel and utility consumables. | First fuel purchase. |
| GK02 | The Empty Service Shed | Authored | Recover generator service notes in Marsh. | Fuel preparation supplies. |
| GK03 | The First Reserve | Tracker | Cumulative checkpoint C1: maintain utility-supply deliveries. | Selected fuel-stock increase. |
| GK04 | Technut's Regulator | Authored | Recover a utility component case from a Marsh service site. | Technut referral. |

### Chapter 2: Water infrastructure

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| GK05 | Water Before Comfort | Hand-in | Deliver filters and water-service consumables. | Water utility barter. |
| GK06 | The Pump Log | Authored | Retrieve the last maintenance record at a waterside facility. | Water-source information. |
| GK07 | A Steady Supply | Tracker | Cumulative checkpoint C2: reach the next utility checkpoint. | One filter/provision purchase. |
| GK08 | The Bad Intake | Authored | Deploy and recover a recorder near an intake site. | Jitters relationship response. |

### Chapter 3: Spare supplies

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| GK09 | Backup Power | Hand-in | Supply generator operating consumables. | Second existing fuel sidegrade purchase. |
| GK10 | The Scrap Specification | Authored | Recover a part specification in Garbage for Latch. | Spare-parts lead. |
| GK11 | More Than One Tank | Tracker | Cumulative checkpoint C3: maintain reserve supplies. | Selected utility stock improvement. |
| GK12 | The Forgotten Store | Authored | Recover a reserve supply case near industrial wreckage. | Emergency provisions. |
| GK13 | Before the Blowout | Hand-in | Deliver emergency operating supplies. | Emergency supply barter. |
| GK14 | The Shelter Circuit | Authored | Recover a service recorder at a remote shelter. | Shelter preparation information. |

### Chapter 4: Emergency reserves

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| GK15 | Nothing Left Dry | Tracker | Cumulative checkpoint C4: reach the next utility checkpoint. | Useful maintenance package. |
| GK16 | The Long Supply Line | Authored | Retrieve freight evidence on a regional utility route. | Ledger relationship response. |
| GK17 | A Season of Spares | Hand-in | Supply accessible long-term utility consumables. | Selected water/provision reserve. |
| GK18 | The Original Manual | Authored | Recover old utility documentation at a remote facility. | Final utility-project instructions. |

### Chapter 5: Long-term provision

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| GK19 | A Town That Runs | Tracker | Cumulative checkpoint C5: reach the final utility checkpoint. | Final utility consumable purchase. |
| GK20 | The Emergency Test | Authored | Deploy and recover a recorder at a service site. | Readiness report and supplies. |
| GK21 | Enough in Reserve | Hand-in | Deliver final modest reserve supplies. | Permanent emergency supply barter. |
| GK22 | A Light Left On | Authored | Recover the last service record and conclude the utilities project. | Recognition; physical town changes remain separate work. |

## Upgrade gates and allocation

Fuels must match existing consumers. Consumable strength, rather than price, determines any actual tier. Stronger direct replacements need the lower milestone.

An unresolved lower-tier prerequisite is an implementation blocker for that reward, not permission
to leave it ungated. Current catalogue milestones are the only equipment permissions. Check alternate
authored shops, barters, and fixed rewards for shortcuts; do not restrict ordinary player trading
or reset existing characters as a side effect of this plan.

## Relationships and editable dialogue

Complains about Technut borrowing parts and Haggler's fuel prices. Gives the clinic's water needs priority.

| Moment | Draft response |
| --- | --- |
| Greeting | If you've come to complain about the lights, bring fuel next time. |
| About repeatable work | Fuel, filters, things we actually use up. Technut takes the machinery. |
| Story conclusion | Full tanks, clean filters. Now let's see how long people leave it alone. |

These samples propose tone, not final dialogue. Preserve existing voice where applicable.
Author editable briefings, partial-progress replies, checkpoint announcements, locked responses,
completion lines, pending-claim messages, referrals, and before/after relationship topics.
A final greeting or recognition is personal unless an explicitly global event is designed.

## Implementation and availability notes

Personal supply progress does not automatically change shared utilities. Visible town repairs need separate global-state design and must not invalidate another character's tasks.

- Sites and story evidence above are proposed map content, not asserted existing spawns.
- Use existing item/job primitives where suitable; finite commissions are implemented with the existing field primitives. Bespoke evidence items and
  multi-stage investigations still need separate mechanics.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Definition files

- [Jobs, catalogue, task dialogue and progression](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_gasket.lua).
- [Appearance and base stock](../../../gamemodes/ix_cotz/plugins/vendor_adv/definitions/sh_gasket.lua).
- [Conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_gasketnpc.lua).

The [equipment index](../unlock-ledger.md) and loaded catalogue tables define current allocations.
Only current milestone IDs grant access; old completions and stock are not migrated.

## Runtime definition and sparse tree

[Editable contact definition](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_gasket.lua) · [Runtime setup](../../../gamemodes/ix_cotz/plugins/townnpcs/README.md) · [Unlock ledger](../unlock-ledger.md)

| Part | Nodes in order |
| --- | --- |
| Shared introduction | GK01 → GK02 → GK03 |
| Supplies and work | GK05 → GK07 → GK09 → GK11 → GK13 → GK15 → GK17 |
| Field work and story | GK04 → GK06 → GK08 → GK10 → GK12 → GK14 → GK16 → GK18 |
| Conclusion after both branches | GK19 → GK20 → GK21 → GK22 |

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
