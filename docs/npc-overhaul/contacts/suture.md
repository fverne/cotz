# Suture: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Progression review draft; no runtime progression implementation.** Read the contact index's shared authoring rules first.
Exact item quantities, job totals, coordinates, prices, and unresolved reward IDs are not assigned.

## Contact brief

- **Home and return point:** Waystation. Every hand-in and reward claim occurs here.
- **Identity:** New: fussy, observant outfitter who judges expeditions by their straps.
- **Model:** Provisional Half-Life 2 human model in the appearance scaffold; final model still open.
- **Only repeatable category:** Textile supply deliveries.
- **Finite plan:** 24 steps; **6 hand-ins, 6 job checkpoints, 12 authored objectives**.
- **Design labels:** SU01 onward, used only in these documents; final runtime IDs need a compatibility review.

## Chapter and dependency structure

This first draft is sequential within and between chapters. A later branch split must retain every
equipment-tier dependency. C1 onward are cumulative, contact-specific job checkpoints, not one-job
requirements or lifetime totals. Numerical thresholds and counting baselines require balancing.
Cross-contact upgrade gates are additional requirements on the same player character.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | SU01–SU04 | Workshop |
| 2 | SU05–SU10 | Basic field gear |
| 3 | SU11–SU14 | Carrying equipment |
| 4 | SU15–SU20 | Protective configurations |
| 5 | SU21–SU24 | Expedition outfit |

## Objectives and small rewards

Rewards below supplement the ordinary finite progression payout where applicable. Purchase access
does not grant the item. A clue must identify a real authored destination. A capacity increase does
not fill shelves. Each generic equipment slot remains unassigned until its item and upgrade gates
pass the catalogue audit; it must not be implemented as a convenient arbitrary item.

### Chapter 1: Workshop

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| SU01 | A Bench and a Needle | Hand-in | Deliver ordinary textile workshop supplies. | First basic equipment accessory purchase. |
| SU02 | The Missing Pattern | Authored | Recover a workshop pattern case in Waystation territory. | Material-source clue. |
| SU03 | Seams That Hold | Tracker | Cumulative checkpoint C1: complete initial textile-delivery checkpoint. | First basic carrying-equipment purchase. |
| SU04 | A Broken Strap | Authored | Recover a freight worker's equipment case. | Ledger relationship response. |

### Chapter 2: Basic field gear

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| SU05 | Cloth for the Weather | Hand-in | Supply existing protective textiles. | First clothing sidegrade purchase. |
| SU06 | The Forgotten Measurements | Authored | Retrieve a fitting record at a regional workshop. | Fit-specific equipment lead. |
| SU07 | A Proper Fit | Tracker | Cumulative checkpoint C2: reach the next textile checkpoint. | First fabric-reinforcement purchase. |
| SU08 | The Workshop Scrapbook | Authored | Recover materials notes in Garbage. | Latch relationship response. |
| SU09 | Load Before Luxury | Hand-in | Deliver accessible webbing and fittings. | Next carrying tier after its lower-tier milestone. |
| SU10 | The Loaded Pack | Authored | Retrieve a field-test recorder along a freight route. | Carrying-support evidence. |

### Chapter 3: Carrying equipment

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| SU11 | Built to Last | Tracker | Cumulative checkpoint C3: maintain regional textile orders. | Next reinforcement tier after its predecessor. |
| SU12 | The Quartermaster's Specification | Authored | Recover an equipment specification at a remote supply site. | Quartermaster relationship response. |
| SU13 | More Than Canvas | Hand-in | Supply source-verified protective materials. | First specialised protection sidegrade. |
| SU14 | The Failed Seam | Authored | Recover a damaged trial case in regional ruins. | Protection test clue. |

### Chapter 4: Protective configurations

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| SU15 | Work Under Weight | Tracker | Cumulative checkpoint C4: reach the next textile checkpoint. | Next verified carrying-frame tier. |
| SU16 | The Long Expedition's Kit | Authored | Recover an expedition equipment record in Waystation territory. | Pripyat equipment lead. |
| SU17 | Weather and Fallout | Hand-in | Deliver late-expedition textile service goods. | Next protection tier after its owner's earlier milestone. |
| SU18 | The Pripyat Trial | Authored | Retrieve an outfitting test recorder in Pripyat. | Deep-field material results. |
| SU19 | No Loose Ends | Tracker | Cumulative checkpoint C5: maintain advanced textile orders. | Next carrying tier after every earlier direct upgrade. |
| SU20 | The Missing Outfitter | Authored | Recover a field fitter's personal case in Pripyat. | Personal equipment-project evidence. |

### Chapter 5: Expedition outfit

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| SU21 | Final Fittings | Hand-in | Supply existing fitting and reinforcement materials. | Final verified reinforcement tier. |
| SU22 | The Return Journey Test | Authored | Deploy and retrieve a finite equipment recorder along an expedition route. | Final equipment design lead. |
| SU23 | Fit for the Journey | Tracker | Cumulative checkpoint C6: reach the final textile checkpoint. | Final audited protective accessory purchase. |
| SU24 | The Outfitter's Pattern | Authored | Recover the final expedition pattern and finish the project. | Recognition and permanent equipment-material barter. |

## Upgrade gates and allocation

Carrying sequence SU03 → SU09 → SU15 → SU19. Reinforcement SU07 → SU11 → SU21, with Technut TN13 additionally required at SU07 if replacing his starter reinforcement. SU17 protection needs the relevant earlier tier at Technut/Egghead. Check capacity, weight, slots and drawbacks before ranking; colour variants can share a small unlock.

An unresolved lower-tier prerequisite is an implementation blocker for that reward, not permission
to leave it ungated. Preserve earned permissions through the migration ledger. Check alternate
authored shops, barters, and fixed rewards for shortcuts; do not restrict ordinary player trading
or reset existing characters as a side effect of this plan.

## Relationships and editable dialogue

Respects Quartermaster's specifications, complains about arena equipment damage, exchanges materials with Latch.

| Moment | Draft response |
| --- | --- |
| Greeting | Turn around. That strap is doing half the work of the whole pack. |
| About repeatable work | Fabric, webbing, protective materials. Bring the material on the list and I'll make it useful. |
| Story conclusion | It fits. It holds. Now try bringing it back that way. |

These samples propose tone, not final dialogue. Preserve existing voice where applicable.
Author editable briefings, partial-progress replies, checkpoint announcements, locked responses,
completion lines, pending-claim messages, referrals, and before/after relationship topics.
A final greeting or recognition is personal unless an explicitly global event is designed.

## Implementation and availability notes

Bag acquisition changes only after assigning existing IDs and proving sources. Workshop flavour does not implement crafting, fitting, or new equipment stats.

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
[appearance definition](../../../gamemodes/ix_cotz/plugins/vendor_adv/definitions/sh_suture.lua) and
[basic dialogue](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_suturenpc.lua).
See the [setup guide](../../../gamemodes/ix_cotz/plugins/vendor_adv/README.md).
Models are provisional; no progression, repeatable work, trade, or services are registered yet.

This is not the complete effective catalogue or the old-to-new unlock ledger. Some old items move
to other contacts; all must retain reachable progression access somewhere. Capture other shared
definitions, dynamic rewards, stock benefits, and excluded-contact allocations in the full audit.
