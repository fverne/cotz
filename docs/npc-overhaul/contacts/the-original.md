# The Original: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Design reference with an implemented runtime definition.** See the runtime section below for authoritative requirements and rewards.

## Contact brief

- **Home and return point:** Marsh. Every hand-in and reward claim occurs here.
- **Identity:** Existing self-proclaimed first stalker; retain his established voice.
- **Model:** Preserve the installed template's model, skin, and presentation.
- **Only repeatable category:** Mutant specimen deliveries.
- **Finite plan:** 24 steps; **6 hand-ins, 6 job checkpoints, 12 authored objectives**.
- **Step labels:** OR01 onward; runtime IDs prefix these labels with cotz/town/<contact-id>/. Keep deployed IDs stable.

## Chapter and dependency structure

The runtime graph has 4 shared introduction nodes, two narrow branches, then a
4-node conclusion requiring both branch tips. The chapter table groups story themes; it does not
impose a single sequential line. Explicit cross-contact equipment prerequisites remain required.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | OR01–OR04 | Common specimens |
| 2 | OR05–OR10 | Predator adaptations |
| 3 | OR11–OR14 | Unusual mutations |
| 4 | OR15–OR20 | Early expedition evidence |
| 5 | OR21–OR24 | Old encounter |

## Proposed narrative objectives and rewards

The chapter tables below preserve proposed story direction; they do not define runtime rewards.
Use the linked contact definition and unlock ledger for implemented requirements and benefits. Purchase access
does not grant the item. A clue must identify a real authored destination. A capacity increase does
not fill shelves. Each generic equipment slot remains unassigned until its item and upgrade gates
pass the catalogue audit; it must not be implemented as a convenient arbitrary item.

### Chapter 1: Common specimens

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| OR01 | A Familiar Beast | Hand-in | Deliver common harvested specimens. | Basic specimen-supply barter. |
| OR02 | Where It Fed | Authored | Retrieve observations from a Marsh feeding site. | Field preparation supplies. |
| OR03 | Proof in the Bag | Tracker | Cumulative checkpoint C1: maintain mutant-specimen deliveries. | First survival-supply purchase. |
| OR04 | The First Account | Authored | Recover an early expedition note near a local landmark. | An old encounter clue. |

### Chapter 2: Predator adaptations

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| OR05 | Teeth and Hide | Hand-in | Deliver predator hides and parts from accessible species. | One hunting-supply stock increase. |
| OR06 | The Wrong Tracks | Authored | Collect a recorder from a disputed hunting site. | Spoor relationship response. |
| OR07 | Different Quarry | Tracker | Cumulative checkpoint C2: reach the next specimen checkpoint. | One protective-consumable purchase. |
| OR08 | The Scarred Tree | Authored | Recover a field sketch in Garbage. | Regional encounter directions. |
| OR09 | What Changed | Hand-in | Supply specimens from distinct existing mutant families. | Next specimen-supply barter. |
| OR10 | A Story With Dates | Authored | Recover a dated expedition log for Carbon to compare. | Historical comparison clue. |

### Chapter 3: Unusual mutations

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| OR11 | Enough to Compare | Tracker | Cumulative checkpoint C3: complete the next specimen checkpoint. | Fixed medical supplies. |
| OR12 | The Second Witness | Authored | Recover a recorded eyewitness account at an abandoned camp. | New story perspective. |
| OR13 | Old Wounds | Hand-in | Deliver uncommon specimens after source verification. | A survival-equipment sidegrade purchase. |
| OR14 | The Camp Before This One | Authored | Retrieve the original expedition's camp record in Waystation territory. | Personal expedition lead. |

### Chapter 4: Early expedition evidence

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| OR15 | A Hunter's Patience | Tracker | Cumulative checkpoint C4: maintain advanced specimen work. | Selected hunting-supply reserve. |
| OR16 | The Name He Forgot | Authored | Recover a missing page from a remote field cache. | Preparation supplies. |
| OR17 | A Different Kind of Proof | Hand-in | Deliver existing research and administrative documents. | One specialist protective-supply purchase. |
| OR18 | The Route He Remembers | Authored | Recover a survey record on the old Pripyat approach. | Route information. |
| OR19 | The Worst of It | Tracker | Cumulative checkpoint C5: reach the next specimen checkpoint. | Specialist specimen barter. |
| OR20 | Under the Old Mark | Authored | Retrieve expedition evidence from a Pripyat landmark. | Advanced field supplies. |

### Chapter 5: Old encounter

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| OR21 | No Two Alike | Hand-in | Deliver late-game specimens with accessible acquisition routes. | Final selected supply-stock improvement. |
| OR22 | The Place in the Story | Authored | Recover the encounter's final recorder in Pripyat. | Old account corrected in dialogue. |
| OR23 | First Does Not Mean Last | Tracker | Cumulative checkpoint C6: reach the final specimen checkpoint. | One final audited survival unlock. |
| OR24 | What Actually Happened | Authored | Recover the last expedition evidence and confront the complete account. | Recognition and final story response. |

## Upgrade gates and allocation

No new knife tier is assigned here. Stronger survival/protection slots require their lower-tier owner's milestone. Specimen requirements cannot rely on the equipment they unlock.

An unresolved lower-tier prerequisite is an implementation blocker for that reward, not permission
to leave it ungated. Current catalogue milestones are the only equipment permissions. Check alternate
authored shops, barters, and fixed rewards for shortcuts; do not restrict ordinary player trading
or reset existing characters as a side effect of this plan.

## Relationships and editable dialogue

Corrects Old Timer's accounts; claims memories Carbon cannot verify. Respects Spoor's field knowledge more than modern instruments.

| Moment | Draft response |
| --- | --- |
| Greeting | First stalker in the Zone. Still here. What do you need? |
| About repeatable work | Mutant parts. You can learn plenty from what survives the animal. |
| Story conclusion | Paper remembers one thing. People remember another. Keep both. |

These samples propose tone, not final dialogue. Preserve existing voice where applicable.
Author editable briefings, partial-progress replies, checkpoint announcements, locked responses,
completion lines, pending-claim messages, referrals, and before/after relationship topics.
A final greeting or recognition is personal unless an explicitly global event is designed.

## Implementation and availability notes

The final evidence can complicate his account without changing his established personality. Historical claims remain draft fiction. No new mutation mechanics are implied.

- Sites and story evidence above are proposed map content, not asserted existing spawns.
- Use existing item/job primitives where suitable; finite commissions are implemented with the existing field primitives. Bespoke evidence items and
  multi-stage investigations still need separate mechanics.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Definition files

- [Jobs, catalogue, task dialogue and progression](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_the_original.lua).
- [Appearance and base stock](../../../gamemodes/ix_cotz/plugins/vendor_adv/definitions/sh_the_original.lua).
- [Conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_firststalkernpc.lua).

The [equipment index](../unlock-ledger.md) and loaded catalogue tables define current allocations.
Only current milestone IDs grant access; old completions and stock are not migrated.

## Runtime definition and sparse tree

[Editable contact definition](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_the_original.lua) · [Runtime setup](../../../gamemodes/ix_cotz/plugins/townnpcs/README.md) · [Unlock ledger](../unlock-ledger.md)

| Part | Nodes in order |
| --- | --- |
| Shared introduction | OR01 → OR02 → OR03 → OR04 |
| Supplies and work | OR05 → OR07 → OR09 → OR11 → OR13 → OR15 → OR17 → OR19 |
| Field work and story | OR06 → OR08 → OR10 → OR12 → OR14 → OR16 → OR18 → OR20 |
| Conclusion after both branches | OR21 → OR22 → OR23 → OR24 |

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
