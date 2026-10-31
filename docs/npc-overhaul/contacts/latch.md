# Latch: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Progression review draft; no runtime progression implementation.** Read the contact index's shared authoring rules first.
Exact item quantities, job totals, coordinates, prices, and unresolved reward IDs are not assigned.

## Contact brief

- **Home and return point:** Garbage. Every hand-in and reward claim occurs here.
- **Identity:** New: blunt former industrial worker who sees useful machinery beneath rust.
- **Model:** Provisional Half-Life 2 human model in the appearance scaffold; final model still open.
- **Only repeatable category:** Industrial salvage deliveries.
- **Finite plan:** 22 steps; **6 hand-ins, 5 job checkpoints, 11 authored objectives**.
- **Design labels:** LA01 onward, used only in these documents; final runtime IDs need a compatibility review.

## Chapter and dependency structure

This first draft is sequential within and between chapters. A later branch split must retain every
equipment-tier dependency. C1 onward are cumulative, contact-specific job checkpoints, not one-job
requirements or lifetime totals. Numerical thresholds and counting baselines require balancing.
Cross-contact upgrade gates are additional requirements on the same player character.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | LA01–LA04 | Sorting yard |
| 2 | LA05–LA08 | Workshop tools |
| 3 | LA09–LA14 | Machinery |
| 4 | LA15–LA18 | Industrial sites |
| 5 | LA19–LA22 | Pripyat components |

## Objectives and small rewards

Rewards below supplement the ordinary finite progression payout where applicable. Purchase access
does not grant the item. A clue must identify a real authored destination. A capacity increase does
not fill shelves. Each generic equipment slot remains unassigned until its item and upgrade gates
pass the catalogue audit; it must not be implemented as a convenient arbitrary item.

### Chapter 1: Sorting yard

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| LA01 | A Place to Sort | Hand-in | Deliver common mechanical salvage. | Basic tool purchase. |
| LA02 | The Missing Inventory | Authored | Recover a sorting-yard inventory in Garbage. | Salvage-source directions. |
| LA03 | Worth Picking Up | Tracker | Cumulative checkpoint C1: complete initial industrial-salvage checkpoint. | First industrial barter. |
| LA04 | The Broken Bench | Authored | Recover a workshop tool case from wreckage. | Repair consumables. |

### Chapter 2: Workshop tools

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| LA05 | Useful Steel | Hand-in | Supply accessible metalworking tools. | Fireaxe purchase, subject to genuine upgrade-family review. |
| LA06 | A Machine With a Number | Authored | Retrieve a machinery identification plate. | Technut restoration lead. |
| LA07 | Sorted Properly | Tracker | Cumulative checkpoint C2: reach the next salvage checkpoint. | One ordinary tool sidegrade. |
| LA08 | The Borrowed Specification | Authored | Recover an assembly drawing near an industrial cache. | Workshop information. |

### Chapter 3: Machinery

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| LA09 | Moving Parts | Hand-in | Deliver fittings and machine components. | Selected tool/service supply reserve. |
| LA10 | The Wrong Replacement | Authored | Recover a failed component case for comparison. | Gasket relationship response. |
| LA11 | More Than Scrap | Tracker | Cumulative checkpoint C3: maintain regional salvage work. | Next heavy-tool unlock after any verified predecessor. |
| LA12 | The Old Workshop | Authored | Retrieve an engineer's repair ledger in regional ruins. | Restoration instructions. |
| LA13 | Heavy Work | Hand-in | Supply high-quality industrial components. | FUBar purchase after verified lower tool milestones. |
| LA14 | The Precision Crate | Authored | Recover a machinery case in Waystation territory. | Technut project response. |

### Chapter 4: Industrial sites

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| LA15 | A Working Yard | Tracker | Cumulative checkpoint C4: reach the next salvage checkpoint. | Industrial protection sidegrade purchase. |
| LA16 | Where It Was Built | Authored | Recover manufacturing records from a Pripyat service site. | Specialist component lead. |
| LA17 | Parts Worth Carrying | Hand-in | Deliver late-stage mechanical salvage. | Final selected industrial-supply reserve. |
| LA18 | The Last Bearing | Authored | Recover a specialist machinery case in Pripyat. | Repair credit. |

### Chapter 5: Pripyat components

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| LA19 | Nothing Wasted | Tracker | Cumulative checkpoint C5: reach the final salvage checkpoint. | Final audited tool purchase. |
| LA20 | The Load Test | Authored | Deploy and retrieve a finite machinery recorder at its source site. | Restoration test results. |
| LA21 | Ready for Assembly | Hand-in | Supply fitting and calibration materials. | Permanent heavy-salvage barter. |
| LA22 | The Commissioning Plate | Authored | Recover the machine's commissioning evidence and return. | Recognition and conditional Technut restoration dialogue. |

## Upgrade gates and allocation

LA05 Fireaxe and LA13 FUBar are allocation proposals. Compare actual tool effects; if they are direct upgrades, require their lower-tool milestone. LA11's additional tool slot must not bypass that chain. An axe is not automatically a harvesting-knife replacement.

An unresolved lower-tier prerequisite is an implementation blocker for that reward, not permission
to leave it ungated. Preserve earned permissions through the migration ledger. Check alternate
authored shops, barters, and fixed rewards for shortcuts; do not restrict ordinary player trading
or reset existing characters as a side effect of this plan.

## Relationships and editable dialogue

Likes Technut's enthusiasm but complains about specifications. Supplies Gasket; exchanges useful material finds with Suture.

| Moment | Draft response |
| --- | --- |
| Greeting | If it still has a serial plate, it isn't just scrap. |
| About repeatable work | Mechanical salvage. Useful tools and parts, not another sack of empty tins. |
| Story conclusion | They wrote that machine off. Listen to it now. |

These samples propose tone, not final dialogue. Preserve existing voice where applicable.
Author editable briefings, partial-progress replies, checkpoint announcements, locked responses,
completion lines, pending-claim messages, referrals, and before/after relationship topics.
A final greeting or recognition is personal unless an explicitly global event is designed.

## Implementation and availability notes

Joint restoration with Technut must not require both full finales. Evidence exchange is planned; functional machinery is separate scope.

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
[appearance definition](../../../gamemodes/ix_cotz/plugins/vendor_adv/definitions/sh_latch.lua) and
[basic dialogue](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_latchnpc.lua).
See the [setup guide](../../../gamemodes/ix_cotz/plugins/vendor_adv/README.md).
Models are provisional; no progression, repeatable work, trade, or services are registered yet.

This is not the complete effective catalogue or the old-to-new unlock ledger. Some old items move
to other contacts; all must retain reachable progression access somewhere. Capture other shared
definitions, dynamic rewards, stock benefits, and excluded-contact allocations in the full audit.
