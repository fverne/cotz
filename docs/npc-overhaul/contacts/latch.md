# Latch: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Design reference with an implemented runtime definition.** See the runtime section below for authoritative requirements and rewards.

## Contact brief

- **Home and return point:** Garbage. Every hand-in and reward claim occurs here.
- **Identity:** New: blunt former industrial worker who sees useful machinery beneath rust.
- **Model:** Provisional Half-Life 2 human model in the appearance definition; final model still open.
- **Only repeatable category:** Industrial salvage deliveries.
- **Finite plan:** 22 steps; **6 hand-ins, 5 job checkpoints, 11 authored objectives**.
- **Step labels:** LA01 onward; runtime IDs prefix these labels with cotz/town/<contact-id>/. Keep deployed IDs stable.

## Chapter and dependency structure

The runtime graph has 4 shared introduction nodes, two narrow branches, then a
4-node conclusion requiring both branch tips. The chapter table groups story themes; it does not
impose a single sequential line. Explicit cross-contact equipment prerequisites remain required.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | LA01–LA04 | Sorting yard |
| 2 | LA05–LA08 | Workshop tools |
| 3 | LA09–LA14 | Machinery |
| 4 | LA15–LA18 | Industrial sites |
| 5 | LA19–LA22 | Pripyat components |

## Proposed narrative objectives and rewards

The chapter tables below preserve proposed story direction; they do not define runtime rewards.
Use the linked contact definition and unlock ledger for implemented requirements and benefits. Purchase access
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
to leave it ungated. Current catalogue milestones are the only equipment permissions. Check alternate
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
- Use existing item/job primitives where suitable; finite commissions are implemented with the existing field primitives. Bespoke evidence items and
  multi-stage investigations still need separate mechanics.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Definition files

- [Jobs, catalogue, task dialogue and progression](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_latch.lua).
- [Appearance and base stock](../../../gamemodes/ix_cotz/plugins/vendor_adv/definitions/sh_latch.lua).
- [Conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_latchnpc.lua).

The [equipment index](../unlock-ledger.md) and loaded catalogue tables define current allocations.
Only current milestone IDs grant access; old completions and stock are not migrated.

## Runtime definition and sparse tree

[Editable contact definition](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_latch.lua) · [Runtime setup](../../../gamemodes/ix_cotz/plugins/townnpcs/README.md) · [Unlock ledger](../unlock-ledger.md)

| Part | Nodes in order |
| --- | --- |
| Shared introduction | LA01 → LA02 → LA03 → LA04 |
| Supplies and work | LA05 → LA07 → LA09 → LA11 → LA13 → LA15 → LA17 |
| Field work and story | LA06 → LA08 → LA10 → LA12 → LA14 → LA16 → LA18 |
| Conclusion after both branches | LA19 → LA20 → LA21 → LA22 |

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
