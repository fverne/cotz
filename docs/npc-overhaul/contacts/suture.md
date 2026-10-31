# Suture: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Design reference with an implemented runtime definition.** See the runtime section below for authoritative requirements and rewards.

## Contact brief

- **Home and return point:** Waystation. Every hand-in and reward claim occurs here.
- **Identity:** New: fussy, observant outfitter who judges expeditions by their straps.
- **Model:** Provisional Half-Life 2 human model in the appearance definition; final model still open.
- **Only repeatable category:** Textile supply deliveries.
- **Finite plan:** 24 steps; **6 hand-ins, 6 job checkpoints, 12 authored objectives**.
- **Step labels:** SU01 onward; runtime IDs prefix these labels with cotz/town/<contact-id>/. Keep deployed IDs stable.

## Chapter and dependency structure

The runtime graph has 4 shared introduction nodes, two narrow branches, then a
4-node conclusion requiring both branch tips. The chapter table groups story themes; it does not
impose a single sequential line. Explicit cross-contact equipment prerequisites remain required.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | SU01–SU04 | Workshop |
| 2 | SU05–SU10 | Basic field gear |
| 3 | SU11–SU14 | Carrying equipment |
| 4 | SU15–SU20 | Protective configurations |
| 5 | SU21–SU24 | Expedition outfit |

## Proposed narrative objectives and rewards

The chapter tables below preserve proposed story direction; they do not define runtime rewards.
Use the linked contact definition and unlock ledger for implemented requirements and benefits. Purchase access
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
to leave it ungated. Current catalogue milestones are the only equipment permissions. Check alternate
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
- Use existing item/job primitives where suitable; finite commissions are implemented with the existing field primitives. Bespoke evidence items and
  multi-stage investigations still need separate mechanics.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Definition files

- [Jobs, catalogue, task dialogue and progression](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_suture.lua).
- [Appearance and base stock](../../../gamemodes/ix_cotz/plugins/vendor_adv/definitions/sh_suture.lua).
- [Conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_suturenpc.lua).

The [equipment index](../unlock-ledger.md) and loaded catalogue tables define current allocations.
Only current milestone IDs grant access; old completions and stock are not migrated.

## Runtime definition and sparse tree

[Editable contact definition](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_suture.lua) · [Runtime setup](../../../gamemodes/ix_cotz/plugins/townnpcs/README.md) · [Unlock ledger](../unlock-ledger.md)

| Part | Nodes in order |
| --- | --- |
| Shared introduction | SU01 → SU02 → SU03 → SU04 |
| Supplies and work | SU05 → SU07 → SU09 → SU11 → SU13 → SU15 → SU17 → SU19 |
| Field work and story | SU06 → SU08 → SU10 → SU12 → SU14 → SU16 → SU18 → SU20 |
| Conclusion after both branches | SU21 → SU22 → SU23 → SU24 |

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
