# Wake: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Design reference with an implemented runtime definition.** See the runtime section below for authoritative requirements and rewards.

## Contact brief

- **Home and return point:** Garbage. Every hand-in and reward claim occurs here.
- **Identity:** New: compassionate but unsentimental recovery coordinator.
- **Model:** Provisional Half-Life 2 human model in the appearance definition; final model still open.
- **Only repeatable category:** Equipment recovery.
- **Finite plan:** 22 steps; **6 hand-ins, 5 job checkpoints, 11 authored objectives**.
- **Step labels:** WA01 onward; runtime IDs prefix these labels with cotz/town/<contact-id>/. Keep deployed IDs stable.

## Chapter and dependency structure

The runtime graph has 4 shared introduction nodes, two narrow branches, then a
4-node conclusion requiring both branch tips. The chapter table groups story themes; it does not
impose a single sequential line. Explicit cross-contact equipment prerequisites remain required.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | WA01–WA04 | Missing scavengers |
| 2 | WA05–WA08 | Personal effects |
| 3 | WA09–WA14 | Failed convoy |
| 4 | WA15–WA18 | Lost expedition |
| 5 | WA19–WA22 | Pripyat resolution |

## Proposed narrative objectives and rewards

The chapter tables below preserve proposed story direction; they do not define runtime rewards.
Use the linked contact definition and unlock ledger for implemented requirements and benefits. Purchase access
does not grant the item. A clue must identify a real authored destination. A capacity increase does
not fill shelves. Each generic equipment slot remains unassigned until its item and upgrade gates
pass the catalogue audit; it must not be implemented as a convenient arbitrary item.

### Chapter 1: Missing scavengers

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| WA01 | Names Before Numbers | Hand-in | Deliver ordinary identification and recordkeeping supplies. | Medical preparation package. |
| WA02 | The Unmarked Camp | Authored | Recover a missing scavenger's personal-effects case in Garbage. | First identity clue. |
| WA03 | Someone Goes Looking | Tracker | Cumulative checkpoint C1: complete initial equipment-recovery checkpoint. | First recovery-supply purchase. |
| WA04 | The Name on the Strap | Authored | Recover identifying evidence at a second camp. | Closure of the first disappearance. |

### Chapter 2: Personal effects

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| WA05 | A Searcher's Kit | Hand-in | Supply existing search and medical provisions. | Recovery preparation barter. |
| WA06 | The Convoy List | Authored | Retrieve a convoy roster near a vehicle graveyard. | Convoy investigation lead. |
| WA07 | Bring Back What You Can | Tracker | Cumulative checkpoint C2: reach the next recovery checkpoint. | Modest Jitters treatment credit. |
| WA08 | The Last Check-in | Authored | Recover a convoy recorder on its abandoned route. | Spool relationship lead. |

### Chapter 3: Failed convoy

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| WA09 | Keeping the Record | Hand-in | Deliver ordinary administrative records. | One selected recovery-supply reserve. |
| WA10 | Atlas' Missing Mark | Authored | Recover a survey note that narrows the convoy route. | Atlas relationship response. |
| WA11 | A Longer Search | Tracker | Cumulative checkpoint C3: maintain regional recoveries. | One practical protective-supply purchase. |
| WA12 | The Diverted Convoy | Authored | Recover personal effects from the convoy's regional destination. | Restricted expedition lead. |
| WA13 | Ready to Follow | Hand-in | Supply accessible expedition provisions. | Field medical package. |
| WA14 | The Withheld Copy | Authored | Recover field evidence corroborating a restricted report. | Boss response; no full Boss line prerequisite. |

### Chapter 4: Lost expedition

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| WA15 | No One Written Off | Tracker | Cumulative checkpoint C4: reach the next recovery checkpoint. | Repair-service credit. |
| WA16 | The Pripyat Camp | Authored | Recover the expedition's camp case in Pripyat. | Next search location clue. |
| WA17 | The Records Agree | Hand-in | Supply existing documents for identity comparison. | Second selected preparation reserve. |
| WA18 | The Last Transmission | Authored | Recover a recorder deeper in Pripyat. | Missing team's final route. |

### Chapter 5: Pripyat resolution

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| WA19 | Still Looking | Tracker | Cumulative checkpoint C5: reach the final recovery checkpoint. | Final recovery-equipment sidegrade. |
| WA20 | Personal Effects | Authored | Recover the missing team's final keepsake case. | Story resolution evidence. |
| WA21 | A Place in the Ledger | Hand-in | Supply practical record preservation materials. | Permanent search preparation barter. |
| WA22 | The Final Name | Authored | Retrieve the final identification record and return the completed account. | Recognition and conditional Boss disclosure dialogue. |

## Upgrade gates and allocation

Recovery rewards cannot bypass lower knife, detector, backpack, or protection milestones. Service credits require access to the named provider. Boss' entire programme is not a prerequisite.

An unresolved lower-tier prerequisite is an implementation blocker for that reward, not permission
to leave it ungated. Current catalogue milestones are the only equipment permissions. Check alternate
authored shops, barters, and fixed rewards for shortcuts; do not restrict ordinary player trading
or reset existing characters as a side effect of this plan.

## Relationships and editable dialogue

Works with Atlas and Spool; challenges Boss when secrecy obstructs recovery; recognises concern beneath Old Timer's sternness.

| Moment | Draft response |
| --- | --- |
| Greeting | A name, a last location, anything they were carrying. Start there. |
| About repeatable work | Personal-effects cases. Bring them back intact. Someone is waiting for an answer. |
| Story conclusion | We can stop writing missing beside that name. |

These samples propose tone, not final dialogue. Preserve existing voice where applicable.
Author editable briefings, partial-progress replies, checkpoint announcements, locked responses,
completion lines, pending-claim messages, referrals, and before/after relationship topics.
A final greeting or recognition is personal unless an explicitly global event is designed.

## Implementation and availability notes

Resolve expeditions through evidence, with no live missing-person NPC in Pripyat. Shared Wake/Boss reactions require independently earned personal evidence.

- Sites and story evidence above are proposed map content, not asserted existing spawns.
- Use existing item/job primitives where suitable; finite commissions are implemented with the existing field primitives. Bespoke evidence items and
  multi-stage investigations still need separate mechanics.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Definition files

- [Jobs, catalogue, task dialogue and progression](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_wake.lua).
- [Appearance and base stock](../../../gamemodes/ix_cotz/plugins/vendor_adv/definitions/sh_wake.lua).
- [Conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_wakenpc.lua).

The [equipment index](../unlock-ledger.md) and loaded catalogue tables define current allocations.
Only current milestone IDs grant access; old completions and stock are not migrated.

## Runtime definition and sparse tree

[Editable contact definition](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_wake.lua) · [Runtime setup](../../../gamemodes/ix_cotz/plugins/townnpcs/README.md) · [Unlock ledger](../unlock-ledger.md)

| Part | Nodes in order |
| --- | --- |
| Shared introduction | WA01 → WA02 → WA03 → WA04 |
| Supplies and work | WA05 → WA07 → WA09 → WA11 → WA13 → WA15 → WA17 |
| Field work and story | WA06 → WA08 → WA10 → WA12 → WA14 → WA16 → WA18 |
| Conclusion after both branches | WA19 → WA20 → WA21 → WA22 |

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
