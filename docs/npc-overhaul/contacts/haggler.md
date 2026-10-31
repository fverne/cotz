# Haggler: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Review draft; no runtime implementation.** Read the contact index's shared authoring rules first.
Exact item quantities, job totals, coordinates, prices, and unresolved reward IDs are not assigned.

## Contact brief

- **Home and return point:** Marsh. Every hand-in and reward claim occurs here.
- **Identity:** Existing trader; retain his personality.
- **Model:** Preserve the installed template's model, skin, and presentation.
- **Only repeatable category:** Hostile human elimination.
- **Finite plan:** 26 steps; **7 hand-ins, 6 job checkpoints, 13 authored objectives**.
- **Design labels:** HG01 onward, used only in these documents; final runtime IDs need a compatibility review.

## Chapter and dependency structure

This first draft is sequential within and between chapters. A later branch split must retain every
equipment-tier dependency. C1 onward are cumulative, contact-specific job checkpoints, not one-job
requirements or lifetime totals. Numerical thresholds and counting baselines require balancing.
Cross-contact upgrade gates are additional requirements on the same player character.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | HG01–HG04 | Trading trust |
| 2 | HG05–HG10 | Supplier intimidation |
| 3 | HG11–HG16 | Trading connections |
| 4 | HG17–HG22 | Protection racket |
| 5 | HG23–HG26 | Broader catalogue |

## Objectives and small rewards

Rewards below supplement the ordinary finite progression payout where applicable. Purchase access
does not grant the item. A clue must identify a real authored destination. A capacity increase does
not fill shelves. Each generic equipment slot remains unassigned until its item and upgrade gates
pass the catalogue audit; it must not be implemented as a convenient arbitrary item.

### Chapter 1: Trading trust

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| HG01 | Opening the Shutters | Hand-in | Deliver shop essentials and accounting supplies. | Bat purchase. |
| HG02 | The Missing Invoice | Authored | Recover an invoice from a Marsh trading stop. | First supplier clue. |
| HG03 | A Small Problem | Tracker | Cumulative checkpoint C1: complete early hostile-human elimination work. | One entry pistol purchase. |
| HG04 | Who Pays Twice | Authored | Recover an extortion receipt from a hostile NPC camp. | Common ammunition package. |

### Chapter 2: Supplier intimidation

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| HG05 | Working Capital | Hand-in | Supply ordinary trade goods from a curated pool. | Second entry weapon sidegrade. |
| HG06 | The Wrong Seal | Authored | Retrieve a consignment seal record along a Marsh route. | General-supply barter. |
| HG07 | Safer Roads | Tracker | Cumulative checkpoint C2: disrupt threats to local suppliers. | First compact-weapon purchase. |
| HG08 | The Abandoned Stall | Authored | Recover a trader's account book in Garbage. | New supplier directions. |
| HG09 | Stock Worth Carrying | Hand-in | Deliver regional provisions and saleable supplies. | One practical consumable purchase. |
| HG10 | Two Sets of Books | Authored | Retrieve a second ledger from a freight cache. | Evidence of the protection racket. |

### Chapter 3: Trading connections

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| HG11 | Paying Customers | Tracker | Cumulative checkpoint C3: complete the next elimination checkpoint. | First basic shotgun purchase. |
| HG12 | The Collector's Route | Authored | Recover route notes at a hostile NPC staging site. | Field medical supplies. |
| HG13 | An Honest Sample | Hand-in | Deliver ordinary weapon-maintenance goods. | One maintenance stock increase. |
| HG14 | A Broken Agreement | Authored | Retrieve a supplier contract in Garbage. | Another weapon sidegrade purchase. |
| HG15 | No More Tolls | Tracker | Cumulative checkpoint C4: eliminate the NPC threats tied to regional trade. | Next compact-weapon sidegrade. |
| HG16 | The Broker's Copy | Authored | Recover a duplicate contract in Waystation territory. | Practical travel supplies. |

### Chapter 4: Protection racket

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| HG17 | Shelf Space | Hand-in | Deliver goods requested for a new catalogue section. | First rifle-family entry purchase. |
| HG18 | The Shipment List | Authored | Recover a manifest identifying the racket's distributor. | Regional objective clue. |
| HG19 | A Wider Market | Tracker | Cumulative checkpoint C5: reach the next regional elimination checkpoint. | Next weapon-family entry purchase. |
| HG20 | The Empty Depot | Authored | Retrieve shipment records from an abandoned depot. | Selected ammunition stock increase. |
| HG21 | Proof of Delivery | Hand-in | Supply existing administrative records and trade samples. | One additional weapon sidegrade. |
| HG22 | The Unpaid Supplier | Authored | Recover a supplier's personal evidence at a remote cache. | A useful provision package. |

### Chapter 5: Broader catalogue

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| HG23 | Closing the Account | Tracker | Cumulative checkpoint C6: reach the final elimination checkpoint. | Later weapon-family unlock, with verified tier prerequisites. |
| HG24 | The Last Ledger | Authored | Recover the racket's central ledger at its final NPC outpost. | Final catalogue branch lead. |
| HG25 | A Shop That Lasts | Hand-in | Deliver supplies for the restored trading connection. | One final audited weapon unlock. |
| HG26 | Nobody Collects Here | Authored | Recover the final contract evidence and report the racket's end. | Recognition and a permanent general-supply barter. |

## Upgrade gates and allocation

Bat is the known Old Timer transfer. Weapon entries are allocation slots until the full current catalogue is classified by actual role and strength. Every direct upgrade requires its prior milestone, including an earlier tier at Quartermaster. Price alone does not establish a tier.

An unresolved lower-tier prerequisite is an implementation blocker for that reward, not permission
to leave it ungated. Preserve earned permissions through the migration ledger. Check alternate
authored shops, barters, and fixed rewards for shortcuts; do not restrict ordinary player trading
or reset existing characters as a side effect of this plan.

## Relationships and editable dialogue

Calls Brass inflexible and Ledger obsessed with paperwork. Respects Cleaner's discretion; complains about competitors' prices.

| Moment | Draft response |
| --- | --- |
| Greeting | Welcome. If you're here about my prices, take a number. |
| About repeatable work | People interfering with trade. Hostile armed NPCs, to be precise. I pay you to remove the problem. |
| Story conclusion | An uninterrupted supply line. You have no idea what a beautiful thing that is. |

These samples propose tone, not final dialogue. Preserve existing voice where applicable.
Author editable briefings, partial-progress replies, checkpoint announcements, locked responses,
completion lines, pending-claim messages, referrals, and before/after relationship topics.
A final greeting or recognition is personal unless an explicitly global event is designed.

## Implementation and availability notes

Elimination targets are authorised hostile NPCs, never arbitrary players. The protection racket needs authored sites and completion events.

- Sites and story evidence above are proposed map content, not asserted existing spawns.
- Use existing item/job primitives where suitable; finite story integration, evidence items, and
  multi-stage completion still need authoritative events and saved-state design.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Current-source reference and unlock audit

- [Current progression source](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_hagglerprog.lua).
- [Current conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_tradernpc.lua).
- [Current templates and models](../../../gamemodes/ix_cotz/plugins/vendor_adv/libs/sh_npctemplates.lua).

Literal vendor item entries found in this source, retained here as an audit starting list:

`fort12`, `m1911`, `brhp`, `lax410s`, `sten`, `lax410`, `swmodel29`, `44magnum`, `sterling`, `toz66`, `toz66short`, `sks`, `rugermini14`, `saigasemi`, `w9422357`, `357magnum`, `g2contender500`, `500magnum`, `kiparis`, `kp31`, `mac11`, `m1911chic`, `toz34`, `toz34short`, `sako85nato`, `c96carbine`, `ppsh`, `toz194`, `m1887`, `ithaca37`, `mp34`, `saigasemi545`, `w1895`, `sako85`, `mosin`, `svt40`, `mp40`, `aks74u`, `akm`.

This is not the complete effective catalogue or the old-to-new unlock ledger. Some old items move
to other contacts; all must retain reachable progression access somewhere. Capture other shared
definitions, dynamic rewards, stock benefits, and excluded-contact allocations in the full audit.
