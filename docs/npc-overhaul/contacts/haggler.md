# Haggler: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Design reference with an implemented runtime definition.** See the runtime section below for authoritative requirements and rewards.

## Contact brief

- **Home and return point:** Marsh. Every hand-in and reward claim occurs here.
- **Identity:** Existing trader; retain his personality.
- **Model:** Preserve the installed template's model, skin, and presentation.
- **Only repeatable category:** Hostile human elimination.
- **Finite plan:** 26 steps; **7 hand-ins, 6 job checkpoints, 13 authored objectives**.
- **Step labels:** HG01 onward; runtime IDs prefix these labels with cotz/town/<contact-id>/. Keep deployed IDs stable.

## Chapter and dependency structure

The runtime graph has 4 shared introduction nodes, two narrow branches, then a
6-node conclusion requiring both branch tips. The chapter table groups story themes; it does not
impose a single sequential line. Explicit cross-contact equipment prerequisites remain required.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | HG01–HG04 | Trading trust |
| 2 | HG05–HG10 | Supplier intimidation |
| 3 | HG11–HG16 | Trading connections |
| 4 | HG17–HG22 | Protection racket |
| 5 | HG23–HG26 | Broader catalogue |

## Proposed narrative objectives and rewards

The chapter tables below preserve proposed story direction; they do not define runtime rewards.
Use the linked contact definition and unlock ledger for implemented requirements and benefits. Purchase access
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
to leave it ungated. Current catalogue milestones are the only equipment permissions. Check alternate
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
- Use existing item/job primitives where suitable; finite commissions are implemented with the existing field primitives. Bespoke evidence items and
  multi-stage investigations still need separate mechanics.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Definition files

- [Jobs, catalogue, task dialogue and progression](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_haggler.lua).
- [Appearance and base stock](../../../gamemodes/ix_cotz/plugins/vendor_adv/definitions/sh_haggler.lua).
- [Conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_tradernpc.lua).

The [equipment index](../unlock-ledger.md) and loaded catalogue tables define current allocations.
Only current milestone IDs grant access; old completions and stock are not migrated.

## Runtime definition and sparse tree

[Editable contact definition](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_haggler.lua) · [Runtime setup](../../../gamemodes/ix_cotz/plugins/townnpcs/README.md) · [Unlock ledger](../unlock-ledger.md)

| Part | Nodes in order |
| --- | --- |
| Shared introduction | HG01 → HG02 → HG03 → HG04 |
| Supplies and work | HG05 → HG07 → HG09 → HG11 → HG13 → HG15 → HG17 → HG19 |
| Field work and story | HG06 → HG08 → HG10 → HG12 → HG14 → HG16 → HG18 → HG20 |
| Conclusion after both branches | HG21 → HG22 → HG23 → HG24 → HG25 → HG26 |

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
