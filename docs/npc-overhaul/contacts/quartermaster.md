# Quartermaster: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Review draft; no runtime implementation.** Read the contact index's shared authoring rules first.
Exact item quantities, job totals, coordinates, prices, and unresolved reward IDs are not assigned.

## Contact brief

- **Home and return point:** Waystation. Every hand-in and reward claim occurs here.
- **Identity:** Existing stern procurement contact.
- **Model:** Preserve the installed template's model, skin, and presentation.
- **Only repeatable category:** Ammunition deliveries.
- **Finite plan:** 24 steps; **6 hand-ins, 6 job checkpoints, 12 authored objectives**.
- **Design labels:** QM01 onward, used only in these documents; final runtime IDs need a compatibility review.

## Chapter and dependency structure

This first draft is sequential within and between chapters. A later branch split must retain every
equipment-tier dependency. C1 onward are cumulative, contact-specific job checkpoints, not one-job
requirements or lifetime totals. Numerical thresholds and counting baselines require balancing.
Cross-contact upgrade gates are additional requirements on the same player character.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | QM01–QM04 | Supply credibility |
| 2 | QM05–QM10 | Procurement records |
| 3 | QM11–QM14 | Equipment branches |
| 4 | QM15–QM20 | Expedition outfitting |
| 5 | QM21–QM24 | Supply agreement |

## Objectives and small rewards

Rewards below supplement the ordinary finite progression payout where applicable. Purchase access
does not grant the item. A clue must identify a real authored destination. A capacity increase does
not fill shelves. Each generic equipment slot remains unassigned until its item and upgrade gates
pass the catalogue audit; it must not be implemented as a convenient arbitrary item.

### Chapter 1: Supply credibility

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| QM01 | A Supplier's Credentials | Hand-in | Deliver accessible ammunition and supply documents. | First entry military weapon purchase. |
| QM02 | The Missing Requisition | Authored | Recover a procurement record in Waystation territory. | Supply-branch information. |
| QM03 | On the Register | Tracker | Cumulative checkpoint C1: complete initial ammunition-delivery checkpoint. | One compatible ammunition purchase. |
| QM04 | The Misrouted Crate | Authored | Recover a sealed equipment case on a regional route. | Field preparation supplies. |

### Chapter 2: Procurement records

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| QM05 | Standard Issue | Hand-in | Supply ordinary operational ammunition. | First military weapon sidegrade. |
| QM06 | The Depot Copy | Authored | Retrieve a depot register in Garbage. | Brass relationship response. |
| QM07 | Enough for the Patrol | Tracker | Cumulative checkpoint C2: reach the next ammunition checkpoint. | First armour-family entry unlock after its verified predecessor. |
| QM08 | The Supplier's Mark | Authored | Recover supplier evidence from an abandoned freight site. | Equipment procurement lead. |
| QM09 | Fittings and Mounts | Hand-in | Deliver existing weapon-fitting supplies. | First compatible attachment purchase. |
| QM10 | The Returned Equipment | Authored | Recover a field inspection record in Waystation territory. | Suture relationship response. |

### Chapter 3: Equipment branches

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| QM11 | Steel Earned | Tracker | Cumulative checkpoint C3: reach the blade-procurement ammunition checkpoint. | knife4 purchase; also requires Old Timer step 12. |
| QM12 | The Lost Agreement | Authored | Recover the old procurement contract. | Regional expedition lead. |
| QM13 | More Than One Role | Hand-in | Supply a second operational ammunition family. | Next weapon role sidegrade. |
| QM14 | The Wrong Model | Authored | Recover a serial-number record for a diverted shipment. | Equipment investigation clue. |

### Chapter 4: Expedition outfitting

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| QM15 | A Dependable Reserve | Tracker | Cumulative checkpoint C4: maintain regional ammunition orders. | Selected operational ammunition reserve. |
| QM16 | The Field Test | Authored | Retrieve an equipment-trial recorder from a remote site. | Later procurement lead. |
| QM17 | Ready for Deployment | Hand-in | Deliver source-verified expedition ammunition. | Next verified weapon tier after its lower-tier milestone. |
| QM18 | The Pripyat Manifest | Authored | Recover expedition supply records in Pripyat. | Pripyat equipment lead. |
| QM19 | Kept Supplied | Tracker | Cumulative checkpoint C5: reach the next ammunition checkpoint. | Next compatible attachment sidegrade. |
| QM20 | The Abandoned Stores | Authored | Recover an equipment case at a Pripyat supply site. | Expedition provisions. |

### Chapter 5: Supply agreement

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| QM21 | Procurement Evidence | Hand-in | Deliver existing administrative records and supplies. | Final military equipment unlock after all relevant lower tiers. |
| QM22 | The Contractor's Copy | Authored | Recover the supply agreement's surviving annex. | Final contract evidence. |
| QM23 | A Standing Agreement | Tracker | Cumulative checkpoint C6: reach the final ammunition checkpoint. | Final selected supply reserve. |
| QM24 | The Signed Requisition | Authored | Retrieve the agreement's last field record and return. | Recognition and permanent procurement barter. |

## Upgrade gates and allocation

QM11 knife4 requires both Old Timer step 12 and his local predecessor QM10. Old Timer step 12 transitively follows knife2 at step 3. Other weapon and armour tiers need actual prior-item milestones at Haggler, Technut, or Boss where appropriate.

An unresolved lower-tier prerequisite is an implementation blocker for that reward, not permission
to leave it ungated. Preserve earned permissions through the migration ledger. Check alternate
authored shops, barters, and fixed rewards for shortcuts; do not restrict ordinary player trading
or reset existing characters as a side effect of this plan.

QM11's locked response must explain: “Old Timer needs to finish your survival-blade training first.”
Required cross-contact milestone: [Old Timer step 12](../old-timer.md), not ownership of knife3.

## Relationships and editable dialogue

Values Brass, Ledger, and Suture as suppliers. Has little patience for Smartass; reports professionally to Boss.

| Moment | Draft response |
| --- | --- |
| Greeting | Supplies or requisitions? Make it clear which. |
| About repeatable work | Operational ammunition. Correct calibre, correct quantity. I have no use for excuses. |
| Story conclusion | The agreement stands. Keep your end of it and we'll keep ours. |

These samples propose tone, not final dialogue. Preserve existing voice where applicable.
Author editable briefings, partial-progress replies, checkpoint announcements, locked responses,
completion lines, pending-claim messages, referrals, and before/after relationship topics.
A final greeting or recognition is personal unless an explicitly global event is designed.

## Implementation and availability notes

No arena gate for essential procurement. Locked blade access must be visible in dialogue and enforced before any alternate reward or barter grants that upgrade.

- Sites and story evidence above are proposed map content, not asserted existing spawns.
- Use existing item/job primitives where suitable; finite story integration, evidence items, and
  multi-stage completion still need authoritative events and saved-state design.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Current-source reference and unlock audit

- [Current progression source](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_quarterprog.lua).
- [Current conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_unisgnpc.lua).
- [Current templates and models](../../../gamemodes/ix_cotz/plugins/vendor_adv/libs/sh_npctemplates.lua).

Literal vendor item entries found in this source, retained here as an audit starting list:

`mp5`, `mossberg500`, `mateba`, `ak74`, `l85`, `lax44`, `g36c`, `sg552`, `aek971`, `an94k`, `rk95`, `ak12`, `m3super90`, `fiveseven`, `ump45`, `p90`, `lr300`, `m16a4`, `fnfal`, `swr8`, `taurusragingbull`, `mp9a1`, `uzi`, `pp1901vityaz`, `famas`, `aug`, `rem870ae`, `mr96`, `mp153`, `sv98`, `svd`, `kobra`, `foregrip`, `eotech`, `aimpoint`, `microt1`.

This is not the complete effective catalogue or the old-to-new unlock ledger. Some old items move
to other contacts; all must retain reachable progression access somewhere. Capture other shared
definitions, dynamic rewards, stock benefits, and excluded-contact allocations in the full audit.
