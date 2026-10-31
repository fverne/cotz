# Intern: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Design reference with an implemented runtime definition.** See the runtime section below for authoritative requirements and rewards.

## Contact brief

- **Home and return point:** Waystation. Every hand-in and reward claim occurs here.
- **Identity:** Existing junior scientist; retain current voice.
- **Model:** Preserve the installed template's model, skin, and presentation.
- **Only repeatable category:** Sensor deployment and retrieval.
- **Finite plan:** 24 steps; **6 hand-ins, 6 job checkpoints, 12 authored objectives**.
- **Step labels:** IN01 onward; runtime IDs prefix these labels with cotz/town/<contact-id>/. Keep deployed IDs stable.

## Chapter and dependency structure

The runtime graph has 2 shared introduction nodes, two narrow branches, then a
4-node conclusion requiring both branch tips. The chapter table groups story themes; it does not
impose a single sequential line. Explicit cross-contact equipment prerequisites remain required.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | IN01–IN04 | Calibration |
| 2 | IN05–IN10 | Baseline readings |
| 3 | IN11–IN14 | Regional comparison |
| 4 | IN15–IN20 | Contradictory results |
| 5 | IN21–IN24 | Pripyat survey |

## Proposed narrative objectives and rewards

The chapter tables below preserve proposed story direction; they do not define runtime rewards.
Use the linked contact definition and unlock ledger for implemented requirements and benefits. Purchase access
does not grant the item. A clue must identify a real authored destination. A capacity increase does
not fill shelves. Each generic equipment slot remains unassigned until its item and upgrade gates
pass the catalogue audit; it must not be implemented as a convenient arbitrary item.

### Chapter 1: Calibration

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| IN01 | An Instrument of My Own | Hand-in | Deliver accessible recording supplies. | Basic field-science consumable purchase. |
| IN02 | The Calibration Point | Authored | Deploy and retrieve a finite sensor near Waystation. | Baseline results. |
| IN03 | Readings on Time | Tracker | Cumulative checkpoint C1: complete initial sensor-work checkpoint. | Selected science-supply reserve. |
| IN04 | The Mislabelled Sample | Authored | Recover a field label register. | First research discrepancy. |

### Chapter 2: Baseline readings

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| IN05 | Clean Containers | Hand-in | Supply ordinary lab consumables. | One preparation-supply barter. |
| IN06 | Beanstalk's Control | Authored | Record at an accessible Garbage control site. | Beanstalk relationship response. |
| IN07 | Same Place Same Method | Tracker | Cumulative checkpoint C2: reach the next sensor checkpoint. | One scientific instrument sidegrade purchase. |
| IN08 | The Missing Interval | Authored | Recover an interrupted recording at a regional site. | Timing-discrepancy clue. |
| IN09 | Something to Compare | Hand-in | Deliver existing research documents. | One protection consumable purchase. |
| IN10 | The Senior's Notebook | Authored | Recover an abandoned research note. | Egghead workload response. |

### Chapter 3: Regional comparison

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| IN11 | A Wider Baseline | Tracker | Cumulative checkpoint C3: maintain regional sensor assignments. | Next science-supply reserve. |
| IN12 | The Field Vesper Chose | Authored | Deploy and retrieve a recorder near an anomaly approach. | Vesper preparation advice. |
| IN13 | Ready for the Distance | Hand-in | Supply accessible expedition provisions. | One protective-equipment sidegrade. |
| IN14 | The Lost Calibration Case | Authored | Recover an instrument case in remote regional territory. | Pripyat survey lead. |

### Chapter 4: Contradictory results

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| IN15 | My Own Figures | Tracker | Cumulative checkpoint C4: reach the next sensor checkpoint. | One specialist clinical supply after Jitters' relevant lower tier. |
| IN16 | The First Pripyat Series | Authored | Complete paired finite sensor recordings in Pripyat. | Regional comparison results. |
| IN17 | Without Missing Pages | Hand-in | Deliver existing administrative and scientific records. | Fixed medical supplies. |
| IN18 | The Contradictory Site | Authored | Record at a second Pripyat research location. | Contradiction isolated. |
| IN19 | Enough to Stand Behind | Tracker | Cumulative checkpoint C5: maintain advanced sensor work. | Next audited field-instrument unlock. |
| IN20 | The Earlier Team | Authored | Recover an earlier survey recorder in Pripyat. | Historical comparison evidence. |

### Chapter 5: Pripyat survey

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| IN21 | The Last Calibration | Hand-in | Supply source-verified field service materials. | Final selected research-supply reserve. |
| IN22 | The Independent Control | Authored | Deploy and retrieve the final independent Pripyat recorder. | Validated findings. |
| IN23 | Put My Name on It | Tracker | Cumulative checkpoint C6: reach the final sensor checkpoint. | Permanent science preparation barter. |
| IN24 | The Missing Observation | Authored | Recover the last field record and present a complete independent survey. | Recognition and more confident dialogue within existing personality. |

## Upgrade gates and allocation

IN15 clinical supply requires Jitters' matching lower tier if an upgrade. IN19 instruments cannot bypass Egghead's detector chain. Verify IN13's protective equipment really is a sidegrade.

An unresolved lower-tier prerequisite is an implementation blocker for that reward, not permission
to leave it ungated. Current catalogue milestones are the only equipment permissions. Check alternate
authored shops, barters, and fixed rewards for shortcuts; do not restrict ordinary player trading
or reset existing characters as a side effect of this plan.

## Relationships and editable dialogue

Seeks Egghead's approval, appreciates Beanstalk's concern, trusts Vesper's advice; occasionally reveals an unfair workload.

| Moment | Draft response |
| --- | --- |
| Greeting | Hello. If you're here for readings, I've actually got the equipment ready this time. |
| About repeatable work | Sensor surveys. Set it up properly, give it time, bring the recorder back. |
| Story conclusion | Those are my figures. You can put my name on the report. |

These samples propose tone, not final dialogue. Preserve existing voice where applicable.
Author editable briefings, partial-progress replies, checkpoint announcements, locked responses,
completion lines, pending-claim messages, referrals, and before/after relationship topics.
A final greeting or recognition is personal unless an explicitly global event is designed.

## Implementation and availability notes

Retain the existing junior-scientist voice. Survey tools are issued task gear; improved detectors are not quietly granted as mission equipment.

- Sites and story evidence above are proposed map content, not asserted existing spawns.
- Use existing item/job primitives where suitable; finite commissions are implemented with the existing field primitives. Bespoke evidence items and
  multi-stage investigations still need separate mechanics.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Definition files

- [Jobs, catalogue, task dialogue and progression](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_intern.lua).
- [Appearance and base stock](../../../gamemodes/ix_cotz/plugins/vendor_adv/definitions/sh_intern.lua).
- [Conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_ecologistnpc3.lua).

The [equipment index](../unlock-ledger.md) and loaded catalogue tables define current allocations.
Only current milestone IDs grant access; old completions and stock are not migrated.

## Runtime definition and sparse tree

[Editable contact definition](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_intern.lua) · [Runtime setup](../../../gamemodes/ix_cotz/plugins/townnpcs/README.md) · [Unlock ledger](../unlock-ledger.md)

| Part | Nodes in order |
| --- | --- |
| Shared introduction | IN01 → IN02 |
| Supplies and work | IN03 → IN05 → IN07 → IN09 → IN11 → IN13 → IN15 → IN17 → IN19 |
| Field work and story | IN04 → IN06 → IN08 → IN10 → IN12 → IN14 → IN16 → IN18 → IN20 |
| Conclusion after both branches | IN21 → IN22 → IN23 → IN24 |

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
