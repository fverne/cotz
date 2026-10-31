# Gasket: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Progression review draft; no runtime progression implementation.** Read the contact index's shared authoring rules first.
Exact item quantities, job totals, coordinates, prices, and unresolved reward IDs are not assigned.

## Contact brief

- **Home and return point:** Marsh. Every hand-in and reward claim occurs here.
- **Identity:** New: gruff utilities caretaker who treats the generator like an unreliable relative.
- **Model:** Provisional Half-Life 2 human model in the appearance scaffold; final model still open.
- **Only repeatable category:** Utility supply deliveries.
- **Finite plan:** 22 steps; **6 hand-ins, 5 job checkpoints, 11 authored objectives**.
- **Design labels:** GK01 onward, used only in these documents; final runtime IDs need a compatibility review.

## Chapter and dependency structure

This first draft is sequential within and between chapters. A later branch split must retain every
equipment-tier dependency. C1 onward are cumulative, contact-specific job checkpoints, not one-job
requirements or lifetime totals. Numerical thresholds and counting baselines require balancing.
Cross-contact upgrade gates are additional requirements on the same player character.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | GK01–GK04 | Generator |
| 2 | GK05–GK08 | Water infrastructure |
| 3 | GK09–GK14 | Spare supplies |
| 4 | GK15–GK18 | Emergency reserves |
| 5 | GK19–GK22 | Long-term provision |

## Objectives and small rewards

Rewards below supplement the ordinary finite progression payout where applicable. Purchase access
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
to leave it ungated. Preserve earned permissions through the migration ledger. Check alternate
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
- Use existing item/job primitives where suitable; finite story integration, evidence items, and
  multi-stage completion still need authoritative events and saved-state design.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Current-source reference and unlock audit

This new contact now has a conversation-only scaffold:
[appearance definition](../../../gamemodes/ix_cotz/plugins/vendor_adv/definitions/sh_gasket.lua) and
[basic dialogue](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_gasketnpc.lua).
See the [setup guide](../../../gamemodes/ix_cotz/plugins/vendor_adv/README.md).
Models are provisional; no progression, repeatable work, trade, or services are registered yet.

This is not the complete effective catalogue or the old-to-new unlock ledger. Some old items move
to other contacts; all must retain reachable progression access somewhere. Capture other shared
definitions, dynamic rewards, stock benefits, and excluded-contact allocations in the full audit.
