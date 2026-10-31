# Smartass: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Review draft; no runtime implementation.** Read the contact index's shared authoring rules first.
Exact item quantities, job totals, coordinates, prices, and unresolved reward IDs are not assigned.

## Contact brief

- **Home and return point:** Garbage. Every hand-in and reward claim occurs here.
- **Identity:** Existing smirking, irreverent specialist.
- **Model:** Preserve the installed template's model, skin, and presentation.
- **Only repeatable category:** Radio triangulation.
- **Finite plan:** 24 steps; **6 hand-ins, 6 job checkpoints, 12 authored objectives**.
- **Design labels:** SM01 onward, used only in these documents; final runtime IDs need a compatibility review.

## Chapter and dependency structure

This first draft is sequential within and between chapters. A later branch split must retain every
equipment-tier dependency. C1 onward are cumulative, contact-specific job checkpoints, not one-job
requirements or lifetime totals. Numerical thresholds and counting baselines require balancing.
Cross-contact upgrade gates are additional requirements on the same player character.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | SM01–SM04 | Missing beacons |
| 2 | SM05–SM10 | Interference |
| 3 | SM11–SM14 | False signals |
| 4 | SM15–SM20 | Organised operation |
| 5 | SM21–SM24 | Pripyat endpoint |

## Objectives and small rewards

Rewards below supplement the ordinary finite progression payout where applicable. Purchase access
does not grant the item. A clue must identify a real authored destination. A capacity increase does
not fill shelves. Each generic equipment slot remains unassigned until its item and upgrade gates
pass the catalogue audit; it must not be implemented as a convenient arbitrary item.

### Chapter 1: Missing beacons

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| SM01 | Something to Listen With | Hand-in | Deliver ordinary radio service components. | First reconnaissance supply purchase. |
| SM02 | The Lost Beacon | Authored | Triangulate and recover a finite source in Garbage. | First signal lead. |
| SM03 | Three Bearings | Tracker | Cumulative checkpoint C1: complete initial triangulation checkpoint. | First optic sidegrade purchase. |
| SM04 | The Wrong Frequency | Authored | Recover a beacon calibration record. | Technical supplies. |

### Chapter 2: Interference

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| SM05 | Mounts and Glass | Hand-in | Deliver existing optical service materials. | Next optic sidegrade, not assumed an upgrade. |
| SM06 | The Interference Site | Authored | Take bearings and recover a jammer's field record. | Interference evidence. |
| SM07 | Less Guesswork | Tracker | Cumulative checkpoint C2: reach the next triangulation checkpoint. | Selected reconnaissance-supply reserve. |
| SM08 | Spool's Correction | Authored | Recover a disputed signal recorder along a freight route. | Spool relationship response. |
| SM09 | An Honest Test | Hand-in | Supply existing electronic diagnostic goods. | First compatible suppressor purchase. |
| SM10 | The False Beacon | Authored | Triangulate and recover a deliberately misleading source. | Operation lead. |

### Chapter 3: False signals

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| SM11 | Still on Bearing | Tracker | Cumulative checkpoint C3: maintain regional triangulation work. | Next compatible attachment sidegrade. |
| SM12 | The Receiver List | Authored | Recover a receiver register in Waystation territory. | Network context. |
| SM13 | Quiet Equipment | Hand-in | Deliver attachment-maintenance supplies. | Second compatible suppressor purchase. |
| SM14 | Mute's Missing Packet | Authored | Recover a diagnostic recording at a remote relay. | Guarded Mute response. |

### Chapter 4: Organised operation

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| SM15 | Better Than Luck | Tracker | Cumulative checkpoint C4: reach the next triangulation checkpoint. | Later optic tier after verified predecessor. |
| SM16 | A Signal Across Maps | Authored | Take finite bearings at a regional transmitter site. | Pripyat operation clue. |
| SM17 | Packed for the Roofs | Hand-in | Deliver ordinary late-expedition service supplies. | Another compatible attachment sidegrade. |
| SM18 | The Rooftop Source | Authored | Locate and recover a transmitter at a Pripyat signal site. | Technical preparation package. |
| SM19 | No More False Positives | Tracker | Cumulative checkpoint C5: maintain advanced triangulation work. | Next audited optic unlock. |
| SM20 | The Handler's Record | Authored | Recover the operation's command recording in Pripyat. | Boss-sensitive evidence. |

### Chapter 5: Pripyat endpoint

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| SM21 | The Last Calibration | Hand-in | Supply accessible precision electronic goods. | Final reconnaissance reserve. |
| SM22 | Two Signals One Source | Authored | Resolve a finite paired-source search in Pripyat. | Final operation lead. |
| SM23 | Found You | Tracker | Cumulative checkpoint C6: reach the final triangulation checkpoint. | Final compatible attachment unlock. |
| SM24 | The Silent Frequency | Authored | Recover the operation's last transmitter and return its records. | Recognition and changed technical banter. |

## Upgrade gates and allocation

Optics and suppressors vary by role and compatibility. Direct replacements at SM15/SM19 need their actual earlier-tier milestone, including at Quartermaster. Do not order magnified optics by price alone.

An unresolved lower-tier prerequisite is an implementation blocker for that reward, not permission
to leave it ungated. Preserve earned permissions through the migration ledger. Check alternate
authored shops, barters, and fixed rewards for shortcuts; do not restrict ordinary player trading
or reset existing characters as a side effect of this plan.

## Relationships and editable dialogue

Trades technical jabs with Spool, questions Mute's secrecy, needles Quartermaster, becomes careful when discussing Boss.

| Moment | Draft response |
| --- | --- |
| Greeting | Three bearings. You'd be surprised how often people stop at two. |
| About repeatable work | Find the signal, find the source, bring it back. Guessing pays badly. |
| Story conclusion | There. Silence. Almost makes you miss the interference. |

These samples propose tone, not final dialogue. Preserve existing voice where applicable.
Author editable briefings, partial-progress replies, checkpoint announcements, locked responses,
completion lines, pending-claim messages, referrals, and before/after relationship topics.
A final greeting or recognition is personal unless an explicitly global event is designed.

## Implementation and availability notes

Retain existing personality and allegiance. False beacons are authored finite objectives; ordinary repeatable triangulation stays reliable.

- Sites and story evidence above are proposed map content, not asserted existing spawns.
- Use existing item/job primitives where suitable; finite story integration, evidence items, and
  multi-stage completion still need authoritative events and saved-state design.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Current-source reference and unlock audit

- [Current progression source](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_smartassprog.lua).
- [Current conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_unisgnpc3.lua).
- [Current templates and models](../../../gamemodes/ix_cotz/plugins/vendor_adv/libs/sh_npctemplates.lua).

Literal vendor item entries found in this source, retained here as an audit starting list:

`pso1`, `cmore`, `acog`, `shortdot`, `nightforce`, `pbssuppressor`, `sakersuppressor`, `tundrasuppressor`, `cobrasuppressor`.

This is not the complete effective catalogue or the old-to-new unlock ledger. Some old items move
to other contacts; all must retain reachable progression access somewhere. Capture other shared
definitions, dynamic rewards, stock benefits, and excluded-contact allocations in the full audit.
