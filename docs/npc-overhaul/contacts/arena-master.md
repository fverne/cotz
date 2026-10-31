# Arena Master: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Review draft; no runtime implementation.** Read the contact index's shared authoring rules first.
Exact item quantities, job totals, coordinates, prices, and unresolved reward IDs are not assigned.

## Contact brief

- **Home and return point:** Garbage. Every hand-in and reward claim occurs here.
- **Identity:** Existing relaxed arena organiser.
- **Model:** Preserve the installed template's model, skin, and presentation.
- **Only repeatable category:** Arena bouts.
- **Finite plan:** 22 steps; **6 hand-ins, 5 job checkpoints, 11 authored objectives**.
- **Design labels:** AR01 onward, used only in these documents; final runtime IDs need a compatibility review.

## Chapter and dependency structure

This first draft is sequential within and between chapters. A later branch split must retain every
equipment-tier dependency. C1 onward are cumulative, contact-specific job checkpoints, not one-job
requirements or lifetime totals. Numerical thresholds and counting baselines require balancing.
Cross-contact upgrade gates are additional requirements on the same player character.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | AR01–AR04 | Qualification |
| 2 | AR05–AR08 | Varied opponents |
| 3 | AR09–AR14 | Intermediate competition |
| 4 | AR15–AR18 | Veteran challenges |
| 5 | AR19–AR22 | Championship |

## Objectives and small rewards

Rewards below supplement the ordinary finite progression payout where applicable. Purchase access
does not grant the item. A clue must identify a real authored destination. A capacity increase does
not fill shelves. Each generic equipment slot remains unassigned until its item and upgrade gates
pass the catalogue audit; it must not be implemented as a convenient arbitrary item.

### Chapter 1: Qualification

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| AR01 | Before the Bell | Hand-in | Deliver ordinary arena medical supplies. | Fixed bandages; arena entry remains accessible. |
| AR02 | The Missing Register | Authored | Recover the arena's bout register in Garbage. | Qualification programme revealed. |
| AR03 | First Opponents | Tracker | Cumulative checkpoint C1: complete the first distinct-opponent bout checkpoint. | Combat preparation package. |
| AR04 | A Fair Match | Authored | Win an eligible sanctioned bout against a distinct opponent. | Arena recognition tier. |

### Chapter 2: Varied opponents

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| AR05 | Equipment Inspection | Hand-in | Deliver maintenance supplies for arena equipment. | First arena supply purchase. |
| AR06 | The Damaged Shipment | Authored | Recover a protective-equipment case along the supply route. | Suture relationship response. |
| AR07 | Not the Same Face | Tracker | Cumulative checkpoint C2: reach the next distinct-opponent checkpoint. | Selected arena supply-stock increase. |
| AR08 | The Referee's Record | Authored | Recover a missing match record from a field cache. | Competition history clue. |

### Chapter 3: Intermediate competition

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| AR09 | Patch the Kit | Hand-in | Deliver existing protective materials. | One existing equipment variant unlock. |
| AR10 | The Supplier's Seal | Authored | Recover evidence identifying an interrupted arena shipment. | Brass referral. |
| AR11 | A Broader Field | Tracker | Cumulative checkpoint C3: reach the intermediate distinct-opponent checkpoint. | Treatment-service credit at the existing provider. |
| AR12 | An Honest Result | Authored | Win the next authored eligible bout; no repeated-opponent credit. | Intermediate recognition. |
| AR13 | No Empty Cabinets | Hand-in | Deliver a finite arena medical reserve. | Next arena consumable purchase. |
| AR14 | A Fighter's Effects | Authored | Recover a former competitor's equipment case. | Personal arena-history lead. |

### Chapter 4: Veteran challenges

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| AR15 | Veteran Company | Tracker | Cumulative checkpoint C4: reach the veteran distinct-opponent checkpoint. | Next existing cosmetic/equipment variant. |
| AR16 | The Missing Result | Authored | Recover the former competitor's last match record. | Final competition lead. |
| AR17 | Ready for the Final | Hand-in | Supply ordinary competition preparations. | One selected supply reserve. |
| AR18 | A Place in the Record | Authored | Win a sanctioned authored veteran bout against a distinct opponent. | Veteran recognition. |

### Chapter 5: Championship

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| AR19 | Championship Form | Tracker | Cumulative checkpoint C5: reach the final cumulative distinct-opponent checkpoint. | Championship preparation supplies. |
| AR20 | The Championship Bout | Authored | Win the final eligible championship bout. | Champion recognition and existing variant reward. |
| AR21 | The Next Season | Hand-in | Supply a modest reserve for future competitors. | Permanent arena preparation barter. |
| AR22 | The Name on the Board | Authored | Recover the historic competitor's final evidence and conclude the programme. | Changed greeting; no global ranking mechanic implied. |

## Upgrade gates and allocation

Prefer existing presentation variants and role sidegrades. Any statistically stronger item needs the ordinary seller's lower-tier gate. No travel or essential equipment depends on the championship.

An unresolved lower-tier prerequisite is an implementation blocker for that reward, not permission
to leave it ungated. Preserve earned permissions through the migration ledger. Check alternate
authored shops, barters, and fixed rewards for shortcuts; do not restrict ordinary player trading
or reset existing characters as a side effect of this plan.

## Relationships and editable dialogue

Praises Brass' supply and Suture's workmanship. Deflects Jitters' criticism; considers Boss overly serious.

| Moment | Draft response |
| --- | --- |
| Greeting | A match, some supplies, or a moment to catch your breath? |
| About repeatable work | Sanctioned bouts. Different opponents. Nobody earns a reputation fighting the same friend all afternoon. |
| Story conclusion | You've earned your place. Try not to make the next contender too nervous. |

These samples propose tone, not final dialogue. Preserve existing voice where applicable.
Author editable briefings, partial-progress replies, checkpoint announcements, locked responses,
completion lines, pending-claim messages, referrals, and before/after relationship topics.
A final greeting or recognition is personal unless an explicitly global event is designed.

## Implementation and availability notes

Count sanctioned eligible distinct opponents only; no disconnect, timeout, repeated-opponent, or unsanctioned-kill credit. Each authored bout needs a separate eligible result. Low population must not block the main story.

- Sites and story evidence above are proposed map content, not asserted existing spawns.
- Use existing item/job primitives where suitable; finite story integration, evidence items, and
  multi-stage completion still need authoritative events and saved-state design.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Current-source reference and unlock audit

- [Current progression source](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_arenaprog.lua).
- [Current conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_arenanpc.lua).
- [Current templates and models](../../../gamemodes/ix_cotz/plugins/vendor_adv/libs/sh_npctemplates.lua).

No literal vendor item entries were found by the preliminary source scan. Check callbacks,
shared definitions, service rewards, and the live catalogue before concluding there are none.

This is not the complete effective catalogue or the old-to-new unlock ledger. Some old items move
to other contacts; all must retain reachable progression access somewhere. Capture other shared
definitions, dynamic rewards, stock benefits, and excluded-contact allocations in the full audit.
