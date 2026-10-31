# Technut: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Design reference with an implemented runtime definition.** See the runtime section below for authoritative requirements and rewards.

## Contact brief

- **Home and return point:** Marsh. Every hand-in and reward claim occurs here.
- **Identity:** Existing enthusiastic technician.
- **Model:** Preserve the installed template's model, skin, and presentation.
- **Only repeatable category:** Industrial salvage deliveries.
- **Finite plan:** 28 steps; **7 hand-ins, 7 job checkpoints, 14 authored objectives**.
- **Step labels:** TN01 onward; runtime IDs prefix these labels with cotz/town/<contact-id>/. Keep deployed IDs stable.

## Chapter and dependency structure

The runtime graph has 4 shared introduction nodes, two narrow branches, then a
6-node conclusion requiring both branch tips. The chapter table groups story themes; it does not
impose a single sequential line. Explicit cross-contact equipment prerequisites remain required.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | TN01–TN06 | Workshop capacity |
| 2 | TN07–TN12 | Precision tools |
| 3 | TN13–TN18 | Equipment support |
| 4 | TN19–TN24 | Specialist machinery |
| 5 | TN25–TN28 | Major restoration |

## Proposed narrative objectives and rewards

The chapter tables below preserve proposed story direction; they do not define runtime rewards.
Use the linked contact definition and unlock ledger for implemented requirements and benefits. Purchase access
does not grant the item. A clue must identify a real authored destination. A capacity increase does
not fill shelves. Each generic equipment slot remains unassigned until its item and upgrade gates
pass the catalogue audit; it must not be implemented as a convenient arbitrary item.

### Chapter 1: Workshop capacity

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| TN01 | A Bench to Work On | Hand-in | Deliver mechanical tools and workshop parts. | First maintenance-product purchase. |
| TN02 | The Missing Toolbox | Authored | Recover a Marsh workshop case. | Repair credit. |
| TN03 | Keeping Busy | Tracker | Cumulative checkpoint C1: maintain industrial-salvage deliveries. | First light-equipment purchase. |
| TN04 | A Regulator for Gasket | Authored | Recover a regulator from a utility service cache. | Utility consumables. |
| TN05 | Something Accurate | Hand-in | Deliver precision measuring tools. | First protective accessory purchase. |
| TN06 | The Misaligned Jig | Authored | Retrieve a workshop calibration record. | Repair-stock clue. |

### Chapter 2: Precision tools

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| TN07 | Reliable Parts | Tracker | Cumulative checkpoint C2: complete the next salvage checkpoint. | First protective-clothing entry purchase. |
| TN08 | An Engineer's Notes | Authored | Recover machinery notes in Garbage. | Repair credit. |
| TN09 | Steel and Seals | Hand-in | Supply mechanical fittings and seals. | One basic protective plate purchase. |
| TN10 | Latch's Find | Authored | Recover an identification plate from industrial wreckage. | Restoration-project lead. |
| TN11 | Proper Workshop | Tracker | Cumulative checkpoint C3: support the next workshop supply checkpoint. | One clothing sidegrade purchase. |
| TN12 | The Precision Crate | Authored | Recover a tool case in Garbage. | Small repair discount. |

### Chapter 3: Equipment support

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| TN13 | A Better Fit | Hand-in | Supply existing fabric-repair and fitting materials. | Basic reinforcement purchase. |
| TN14 | Patterns in Metal | Authored | Retrieve an assembly drawing at a regional workshop. | Suture referral. |
| TN15 | More Than a Patch | Tracker | Cumulative checkpoint C4: complete advanced salvage orders. | Next protective plate tier after its predecessor. |
| TN16 | The Missing Technician | Authored | Recover a technician's recorder near an abandoned workshop. | Repair credit. |
| TN17 | Instrument Grade | Hand-in | Deliver calibrated components from accessible sources. | First technical headwear entry purchase. |
| TN18 | The Test Assembly | Authored | Recover a test assembly case in Waystation territory. | Advanced tool lead. |

### Chapter 4: Specialist machinery

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| TN19 | Holding Together | Tracker | Cumulative checkpoint C5: reach the next salvage checkpoint. | Next reinforcement tier after its predecessor. |
| TN20 | The Damaged Register | Authored | Recover equipment-service records from a remote facility. | Selected maintenance stock increase. |
| TN21 | A Workshop in Reserve | Hand-in | Deliver spare workshop components. | A protection sidegrade purchase. |
| TN22 | The Machine's Origin | Authored | Retrieve a manufacturing record at a Pripyat industrial site. | Restoration instructions. |
| TN23 | Precision Work | Tracker | Cumulative checkpoint C6: complete the next high-effort salvage checkpoint. | Next technical headwear tier after its predecessor. |
| TN24 | The Last Component | Authored | Recover the restoration machine's final case in Pripyat. | Repair credit. |

### Chapter 5: Major restoration

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| TN25 | Ready to Rebuild | Hand-in | Deliver fitting and calibration materials. | Final small repair discount. |
| TN26 | A Test Under Load | Authored | Deploy and retrieve a test recorder at the restored machine's source site. | Final equipment-branch lead. |
| TN27 | It Runs Again | Tracker | Cumulative checkpoint C7: reach the final salvage checkpoint. | One final audited equipment unlock after its lower tiers. |
| TN28 | The Engineer's Signature | Authored | Recover the machine's commissioning record and finish the restoration. | Recognition and permanent maintenance barter. |

## Upgrade gates and allocation

Proposed plates TN09 → TN15; headwear TN17 → TN23; exact item IDs require stat review. Reinforcement starts TN13; stronger variants moved to Suture require TN13 as well. Clothing colour and role variants are not automatically direct upgrades.

An unresolved lower-tier prerequisite is an implementation blocker for that reward, not permission
to leave it ungated. Current catalogue milestones are the only equipment permissions. Check alternate
authored shops, barters, and fixed rewards for shortcuts; do not restrict ordinary player trading
or reset existing characters as a side effect of this plan.

## Relationships and editable dialogue

Enthusiastic about Latch's machinery. Argues with Mute over modifications and wants to improve Gasket's improvised repairs.

| Moment | Draft response |
| --- | --- |
| Greeting | Hello, buddy! Tell me you've brought something with all its screws still in it. |
| About repeatable work | Mechanical parts and workshop tools. Mute can have the loose circuit boards. |
| Story conclusion | Listen to that! That's what it's supposed to sound like! |

These samples propose tone, not final dialogue. Preserve existing voice where applicable.
Author editable briefings, partial-progress replies, checkpoint announcements, locked responses,
completion lines, pending-claim messages, referrals, and before/after relationship topics.
A final greeting or recognition is personal unless an explicitly global event is designed.

## Implementation and availability notes

Basic repairs remain available. Latch's restoration crossover uses shallow evidence flags, never completion of his entire line. Operational machinery is separate mechanic work.

- Sites and story evidence above are proposed map content, not asserted existing spawns.
- Use existing item/job primitives where suitable; finite commissions are implemented with the existing field primitives. Bespoke evidence items and
  multi-stage investigations still need separate mechanics.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Definition files

- [Jobs, catalogue, task dialogue and progression](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_technut.lua).
- [Appearance and base stock](../../../gamemodes/ix_cotz/plugins/vendor_adv/definitions/sh_technut.lua).
- [Conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_technpc.lua).

The [equipment index](../unlock-ledger.md) and loaded catalogue tables define current allocations.
Only current milestone IDs grant access; old completions and stock are not migrated.

## Runtime definition and sparse tree

[Editable contact definition](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_technut.lua) · [Runtime setup](../../../gamemodes/ix_cotz/plugins/townnpcs/README.md) · [Unlock ledger](../unlock-ledger.md)

| Part | Nodes in order |
| --- | --- |
| Shared introduction | TN01 → TN02 → TN03 → TN04 |
| Supplies and work | TN05 → TN07 → TN09 → TN11 → TN13 → TN15 → TN17 → TN19 → TN21 |
| Field work and story | TN06 → TN08 → TN10 → TN12 → TN14 → TN16 → TN18 → TN20 → TN22 |
| Conclusion after both branches | TN23 → TN24 → TN25 → TN26 → TN27 → TN28 |

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
