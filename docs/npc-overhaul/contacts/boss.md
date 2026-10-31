# Boss: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Review draft; no runtime implementation.** Read the contact index's shared authoring rules first.
Exact item quantities, job totals, coordinates, prices, and unresolved reward IDs are not assigned.

## Contact brief

- **Home and return point:** Waystation. Every hand-in and reward claim occurs here.
- **Identity:** Existing authoritative operations contact.
- **Model:** Preserve the installed template's model, skin, and presentation.
- **Only repeatable category:** Hostile human elimination.
- **Finite plan:** 22 steps; **6 hand-ins, 5 job checkpoints, 11 authored objectives**.
- **Design labels:** BO01 onward, used only in these documents; final runtime IDs need a compatibility review.

## Chapter and dependency structure

This first draft is sequential within and between chapters. A later branch split must retain every
equipment-tier dependency. C1 onward are cumulative, contact-specific job checkpoints, not one-job
requirements or lifetime totals. Numerical thresholds and counting baselines require balancing.
Cross-contact upgrade gates are additional requirements on the same player character.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | BO01–BO04 | Reliability |
| 2 | BO05–BO08 | Regional threats |
| 3 | BO09–BO14 | Hostile supply networks |
| 4 | BO15–BO18 | Opposing operation |
| 5 | BO19–BO22 | Pripyat operation |

## Objectives and small rewards

Rewards below supplement the ordinary finite progression payout where applicable. Purchase access
does not grant the item. A clue must identify a real authored destination. A capacity increase does
not fill shelves. Each generic equipment slot remains unassigned until its item and upgrade gates
pass the catalogue audit; it must not be implemented as a convenient arbitrary item.

### Chapter 1: Reliability

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| BO01 | Operational Basics | Hand-in | Deliver accessible field provisions and administrative supplies. | First operational supply purchase. |
| BO02 | The Missing Patrol | Authored | Recover a patrol report in Waystation territory. | Initial threat information. |
| BO03 | Follow Instructions | Tracker | Cumulative checkpoint C1: complete initial hostile-human elimination checkpoint. | First protective-equipment entry unlock. |
| BO04 | The Forward Record | Authored | Recover an NPC outpost's field orders. | Threat-network lead. |

### Chapter 2: Regional threats

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| BO05 | Staying Equipped | Hand-in | Deliver ordinary operational maintenance goods. | Selected field-supply reserve. |
| BO06 | The Interrupted Shipment | Authored | Recover a freight case along a regional route. | Quartermaster referral. |
| BO07 | Pressure on the Route | Tracker | Cumulative checkpoint C2: reach the next elimination checkpoint. | Next protection tier after its lower-tier milestone. |
| BO08 | The Supply Register | Authored | Retrieve hostile supply records in Garbage. | Regional operation clue. |

### Chapter 3: Hostile supply networks

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| BO09 | Orders and Receipts | Hand-in | Deliver existing administrative evidence. | One armour-role sidegrade purchase. |
| BO10 | The Missing Names | Authored | Recover expedition evidence related to Wake's search. | Restricted-records conflict introduced. |
| BO11 | A Smaller Network | Tracker | Cumulative checkpoint C3: maintain regional hostile-NPC elimination work. | Next verified protection tier. |
| BO12 | The Second Command Post | Authored | Recover a field recorder from a hostile NPC position. | Pripyat operation lead. |
| BO13 | Packed for Contact | Hand-in | Supply source-verified expedition materials. | Operational preparation package. |
| BO14 | The Pripyat Outpost | Authored | Recover orders at a Pripyat NPC operation site. | Target-network information. |

### Chapter 4: Opposing operation

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| BO15 | Holding the Initiative | Tracker | Cumulative checkpoint C4: reach the next elimination checkpoint. | Next protective headwear tier after its predecessor. |
| BO16 | The Handler's Orders | Authored | Retrieve a command recording in Pripyat. | Smartass evidence comparison. |
| BO17 | A Report That Holds | Hand-in | Deliver existing records needed to reconcile the operation. | Final audited armour tier after its full prerequisite chain. |
| BO18 | The Withheld Annex | Authored | Recover the missing expedition record in Pripyat. | Conditional disclosure topic for Wake. |

### Chapter 5: Pripyat operation

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| BO19 | End of the Operation | Tracker | Cumulative checkpoint C5: reach the final elimination checkpoint. | Final selected operational reserve. |
| BO20 | The Last Command | Authored | Recover evidence from the final authored hostile NPC objective. | Operation resolved. |
| BO21 | Return to Readiness | Hand-in | Deliver ordinary operational reserves. | Permanent field-supply barter. |
| BO22 | The Missing Patrol's Answer | Authored | Recover the patrol's final record and return the complete report. | Recognition; Wake reaction only when her evidence is also earned. |

## Upgrade gates and allocation

Protection starts BO03, advances BO07/BO11, with headwear BO15 and final armour slot BO17. Actual armour-family predecessors may live with Technut/Suture; require those exact milestones. Headwear is a separate family.

An unresolved lower-tier prerequisite is an implementation blocker for that reward, not permission
to leave it ungated. Preserve earned permissions through the migration ledger. Check alternate
authored shops, barters, and fixed rewards for shortcuts; do not restrict ordinary player trading
or reset existing characters as a side effect of this plan.

## Relationships and editable dialogue

Depends on Quartermaster; finds Smartass useful but irritating. Respects Ledger; regards Wake's justified questions as inconvenient.

| Moment | Draft response |
| --- | --- |
| Greeting | Look what the cat dragged in. Ready to work? |
| About repeatable work | Hostile personnel threatening the operation. Specified targets. No freelancing. |
| Story conclusion | Operation concluded. File the report and get some rest. |

These samples propose tone, not final dialogue. Preserve existing voice where applicable.
Author editable briefings, partial-progress replies, checkpoint announcements, locked responses,
completion lines, pending-claim messages, referrals, and before/after relationship topics.
A final greeting or recognition is personal unless an explicitly global event is designed.

## Implementation and availability notes

Target hostile NPCs only. Disclosing Wake's records is a personal consequence, not a global permission change or an obligation to finish both programmes.

- Sites and story evidence above are proposed map content, not asserted existing spawns.
- Use existing item/job primitives where suitable; finite story integration, evidence items, and
  multi-stage completion still need authoritative events and saved-state design.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Current-source reference and unlock audit

- [Current progression source](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_bossprog.lua).
- [Current conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_unisgnpc2.lua).
- [Current templates and models](../../../gamemodes/ix_cotz/plugins/vendor_adv/libs/sh_npctemplates.lua).

Literal vendor item entries found in this source, retained here as an audit starting list:

`suit_io7a`, `suit_ps5m`, `suit_berill`, `suit_skat10`, `suit_skat9`, `headwear_rad`, `suit_radsuit`, `headwear_spartan`, `suit_exoskeleton`.

This is not the complete effective catalogue or the old-to-new unlock ledger. Some old items move
to other contacts; all must retain reachable progression access somewhere. Capture other shared
definitions, dynamic rewards, stock benefits, and excluded-contact allocations in the full audit.
