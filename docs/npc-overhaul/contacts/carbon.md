# Carbon: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Design reference with an implemented runtime definition.** See the runtime section below for authoritative requirements and rewards.

## Contact brief

- **Home and return point:** Waystation. Every hand-in and reward claim occurs here.
- **Identity:** New: persistent historian who values maintenance ledgers over heroic tales.
- **Model:** Replaceable Half-Life 2 placeholder in the appearance definition; choose the final mounted model in-game.
- **Only repeatable category:** Document deliveries.
- **Finite plan:** 22 steps; **6 hand-ins, 5 job checkpoints, 11 authored objectives**.
- **Step labels:** CA01 onward; runtime IDs prefix these labels with cotz/town/<contact-id>/. Keep deployed IDs stable.

## Chapter and dependency structure

The runtime graph has 2 shared introduction nodes, two narrow branches, then a
6-node conclusion requiring both branch tips. The chapter table groups story themes; it does not
impose a single sequential line. Explicit cross-contact equipment prerequisites remain required.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | CA01–CA04 | Local records |
| 2 | CA05–CA08 | Facility histories |
| 3 | CA09–CA14 | Dispersed archives |
| 4 | CA15–CA18 | Concealed operation |
| 5 | CA19–CA22 | Pripyat archive |

## Proposed narrative objectives and rewards

The chapter tables below preserve proposed story direction; they do not define runtime rewards.
Use the linked contact definition and unlock ledger for implemented requirements and benefits. Purchase access
does not grant the item. A clue must identify a real authored destination. A capacity increase does
not fill shelves. Each generic equipment slot remains unassigned until its item and upgrade gates
pass the catalogue audit; it must not be implemented as a convenient arbitrary item.

### Chapter 1: Local records

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| CA01 | Somewhere to File It | Hand-in | Deliver ordinary archival supplies. | Document-preservation barter. |
| CA02 | The Maintenance Office | Authored | Recover a facility index in regional ruins. | First facility-history topic. |
| CA03 | A Useful Record | Tracker | Cumulative checkpoint C1: complete initial document-delivery checkpoint. | One practical exploration supply purchase. |
| CA04 | A Date That Does Not Fit | Authored | Retrieve a second dated record in Garbage. | Historical contradiction lead. |

### Chapter 2: Facility histories

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| CA05 | An Ordered Shelf | Hand-in | Deliver ordinary administrative records. | Selected exploration-supply reserve. |
| CA06 | The Original's Account | Authored | Recover a contemporaneous expedition note for comparison. | The Original dialogue response. |
| CA07 | Facts With Sources | Tracker | Cumulative checkpoint C2: reach the next document checkpoint. | Second practical preparation-supply purchase. |
| CA08 | The Missing Annex | Authored | Recover a facility annex from a regional office site. | Concealed-operation lead. |

### Chapter 3: Dispersed archives

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| CA09 | Names and Numbers | Hand-in | Deliver source-verified scientific documents. | One scientific-supply barter. |
| CA10 | Egghead's Citation | Authored | Recover a referenced research record. | Egghead comparison topic. |
| CA11 | A History That Agrees | Tracker | Cumulative checkpoint C3: maintain regional document work. | One protective-equipment sidegrade purchase. |
| CA12 | The Restricted Copy | Authored | Recover field evidence of an operation omitted from official records. | Boss dispute introduced. |
| CA13 | Ready for the Archive | Hand-in | Supply accessible expedition and preservation materials. | Archival expedition provisions. |
| CA14 | The Pripyat Index | Authored | Recover an archive index in Pripyat. | Archive route information. |

### Chapter 4: Concealed operation

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| CA15 | Every Page Accounted For | Tracker | Cumulative checkpoint C4: reach the next document checkpoint. | Selected preparation-stock increase. |
| CA16 | The Administrative Trail | Authored | Retrieve a surviving operations log at a second Pripyat site. | Operation history evidence. |
| CA17 | The Missing Context | Hand-in | Deliver existing late-region scientific and administrative documents. | Final document-supply reserve. |
| CA18 | The False Summary | Authored | Recover the original record behind an altered report. | Historical correction lead. |

### Chapter 5: Pripyat archive

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| CA19 | A Complete Dossier | Tracker | Cumulative checkpoint C5: reach the final document checkpoint. | One final audited exploration-equipment unlock. |
| CA20 | The Surviving Archive | Authored | Recover the central archive record in Pripyat. | Final history chapter evidence. |
| CA21 | Preserve the Originals | Hand-in | Supply ordinary archival support goods. | Permanent document preparation barter. |
| CA22 | The Last Witness on Paper | Authored | Retrieve the final dated field record and return the complete dossier. | Recognition and completed history topic. |

## Upgrade gates and allocation

Equipment slots need the lower-tier milestone at the assigned owner. Archive progress cannot give a superior detector, optic or backpack early. Excluded NPC item allocation remains an audit task.

An unresolved lower-tier prerequisite is an implementation blocker for that reward, not permission
to leave it ungated. Current catalogue milestones are the only equipment permissions. Check alternate
authored shops, barters, and fixed rewards for shortcuts; do not restrict ordinary player trading
or reset existing characters as a side effect of this plan.

## Relationships and editable dialogue

Cross-checks The Original, exchanges records with Egghead, clashes with Boss over restricted documents.

| Moment | Draft response |
| --- | --- |
| Greeting | A date and a signature tell me more than another heroic story. |
| About repeatable work | Documents. Existing records with something to say. Keep the pages intact. |
| Story conclusion | Now the dates agree. Whether anyone likes the answer is another matter. |

These samples propose tone, not final dialogue. Preserve existing voice where applicable.
Author editable briefings, partial-progress replies, checkpoint announcements, locked responses,
completion lines, pending-claim messages, referrals, and before/after relationship topics.
A final greeting or recognition is personal unless an explicitly global event is designed.

## Implementation and availability notes

Ordinary document hand-ins use obtainable loot; unique archive evidence is authored field work. Dates, restricted operations and locations remain draft fiction.

- Sites and story evidence above are proposed map content, not asserted existing spawns.
- Use existing item/job primitives where suitable; finite commissions are implemented with the existing field primitives. Bespoke evidence items and
  multi-stage investigations still need separate mechanics.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Definition files

- [Jobs, catalogue, task dialogue and progression](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_carbon.lua).
- [Appearance and base stock](../../../gamemodes/ix_cotz/plugins/vendor_adv/definitions/sh_carbon.lua).
- [Conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_carbonnpc.lua).

The [equipment index](../unlock-ledger.md) and loaded catalogue tables define current allocations.
Only current milestone IDs grant access; old completions and stock are not migrated.

## Runtime definition and sparse tree

[Editable contact definition](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_carbon.lua) · [Runtime setup](../../../gamemodes/ix_cotz/plugins/townnpcs/README.md) · [Unlock ledger](../unlock-ledger.md)

| Part | Nodes in order |
| --- | --- |
| Shared introduction | CA01 → CA02 |
| Supplies and work | CA03 → CA05 → CA07 → CA09 → CA11 → CA13 → CA15 |
| Field work and story | CA04 → CA06 → CA08 → CA10 → CA12 → CA14 → CA16 |
| Conclusion after both branches | CA17 → CA18 → CA19 → CA20 → CA21 → CA22 |

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
