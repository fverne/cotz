# The Original: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Review draft; no runtime implementation.** Read the contact index's shared authoring rules first.
Exact item quantities, job totals, coordinates, prices, and unresolved reward IDs are not assigned.

## Contact brief

- **Home and return point:** Marsh. Every hand-in and reward claim occurs here.
- **Identity:** Existing self-proclaimed first stalker; retain his established voice.
- **Model:** Preserve the installed template's model, skin, and presentation.
- **Only repeatable category:** Mutant specimen deliveries.
- **Finite plan:** 24 steps; **6 hand-ins, 6 job checkpoints, 12 authored objectives**.
- **Design labels:** OR01 onward, used only in these documents; final runtime IDs need a compatibility review.

## Chapter and dependency structure

This first draft is sequential within and between chapters. A later branch split must retain every
equipment-tier dependency. C1 onward are cumulative, contact-specific job checkpoints, not one-job
requirements or lifetime totals. Numerical thresholds and counting baselines require balancing.
Cross-contact upgrade gates are additional requirements on the same player character.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | OR01–OR04 | Common specimens |
| 2 | OR05–OR10 | Predator adaptations |
| 3 | OR11–OR14 | Unusual mutations |
| 4 | OR15–OR20 | Early expedition evidence |
| 5 | OR21–OR24 | Old encounter |

## Objectives and small rewards

Rewards below supplement the ordinary finite progression payout where applicable. Purchase access
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
to leave it ungated. Preserve earned permissions through the migration ledger. Check alternate
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
- Use existing item/job primitives where suitable; finite story integration, evidence items, and
  multi-stage completion still need authoritative events and saved-state design.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Current-source reference and unlock audit

- [Current progression source](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_originalprog.lua).
- [Current conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_firststalkernpc.lua).
- [Current templates and models](../../../gamemodes/ix_cotz/plugins/vendor_adv/libs/sh_npctemplates.lua).

No literal vendor item entries were found by the preliminary source scan. Check callbacks,
shared definitions, service rewards, and the live catalogue before concluding there are none.

This is not the complete effective catalogue or the old-to-new unlock ledger. Some old items move
to other contacts; all must retain reachable progression access somewhere. Capture other shared
definitions, dynamic rewards, stock benefits, and excluded-contact allocations in the full audit.
