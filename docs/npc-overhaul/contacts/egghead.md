# Egghead: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Review draft; no runtime implementation.** Read the contact index's shared authoring rules first.
Exact item quantities, job totals, coordinates, prices, and unresolved reward IDs are not assigned.

## Contact brief

- **Home and return point:** Waystation. Every hand-in and reward claim occurs here.
- **Identity:** Existing relaxed scientist.
- **Model:** Preserve the installed template's model, skin, and presentation.
- **Only repeatable category:** Artifact deliveries.
- **Finite plan:** 26 steps; **7 hand-ins, 6 job checkpoints, 13 authored objectives**.
- **Design labels:** EG01 onward, used only in these documents; final runtime IDs need a compatibility review.

## Chapter and dependency structure

This first draft is sequential within and between chapters. A later branch split must retain every
equipment-tier dependency. C1 onward are cumulative, contact-specific job checkpoints, not one-job
requirements or lifetime totals. Numerical thresholds and counting baselines require balancing.
Cross-contact upgrade gates are additional requirements on the same player character.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | EG01–EG04 | Reference collection |
| 2 | EG05–EG10 | Artifact families |
| 3 | EG11–EG16 | Research equipment |
| 4 | EG17–EG22 | Anomalous relationships |
| 5 | EG23–EG26 | Pripyat programme |

## Objectives and small rewards

Rewards below supplement the ordinary finite progression payout where applicable. Purchase access
does not grant the item. A clue must identify a real authored destination. A capacity increase does
not fill shelves. Each generic equipment slot remains unassigned until its item and upgrade gates
pass the catalogue audit; it must not be implemented as a convenient arbitrary item.

### Chapter 1: Reference collection

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| EG01 | A First Reference | Hand-in | Deliver accessible common artifacts with a proven pre-detector source. | Basic scientific-supply purchase. |
| EG02 | The Control Notebook | Authored | Recover a reference notebook near a regional field site. | Artifact preparation advice. |
| EG03 | A Useful Assistant | Tracker | Cumulative checkpoint C1: complete initial artifact-delivery checkpoint. | detectorecho purchase. |
| EG04 | The Old Field Station | Authored | Recover a calibration case in accessible regional territory. | Calibration lead. |

### Chapter 2: Artifact families

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| EG05 | Different Origins | Hand-in | Deliver artifacts from accessible distinct source categories. | One scientific consumable purchase. |
| EG06 | The Comparison Site | Authored | Deploy and retrieve a finite recorder near an anomaly field. | Artifact-family information. |
| EG07 | An Orderly Collection | Tracker | Cumulative checkpoint C2: reach the next artifact checkpoint. | Selected science-supply reserve. |
| EG08 | The Missing Calibration | Authored | Recover a detector test record in Garbage. | Next detector research lead. |
| EG09 | A Reliable Reading | Hand-in | Supply existing service components and accessible artifacts. | Basic science-suit entry purchase. |
| EG10 | The Failed Trial | Authored | Retrieve a test recorder at a remote research site. | Scientific equipment lead. |

### Chapter 3: Research equipment

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| EG11 | A Better Instrument | Tracker | Cumulative checkpoint C3: reach the intermediate artifact checkpoint. | detectorbear purchase after Echo milestone. |
| EG12 | The Paired Samples | Authored | Recover a comparison record at two regional field sites. | Advanced artifact study lead. |
| EG13 | Protection for the Work | Hand-in | Deliver accessible research consumables. | Next science-suit tier after the lower tier. |
| EG14 | Beanstalk's Objection | Authored | Recover environmental control evidence in Garbage. | Scientific debate response. |
| EG15 | A Collection With Context | Tracker | Cumulative checkpoint C4: maintain regional artifact deliveries. | One specialist research medicine after its lower-tier owner milestone. |
| EG16 | The Archived Finding | Authored | Recover a research record for comparison with Carbon. | Archive investigation lead. |

### Chapter 4: Anomalous relationships

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| EG17 | Before Pripyat | Hand-in | Deliver expedition protection and recording supplies. | Science expedition preparation barter. |
| EG18 | The Pripyat Baseline | Authored | Recover an earlier research team's recorder in Pripyat. | Deep-field research lead. |
| EG19 | Results That Repeat | Tracker | Cumulative checkpoint C5: maintain advanced artifact research orders. | Next verified science-protection tier. |
| EG20 | The Unfinished Experiment | Authored | Retrieve a calibration case at a second Pripyat site. | Final detector evidence. |
| EG21 | Precision at Last | Hand-in | Supply source-verified rare artifacts and calibration materials. | detectorveles purchase after Bear milestone. |
| EG22 | The Family Resemblance | Authored | Recover the final comparison recorder in Pripyat. | Artifact relationships explained. |

### Chapter 5: Pripyat programme

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| EG23 | A Complete Reference | Tracker | Cumulative checkpoint C6: reach the final artifact-delivery checkpoint. | Final selected science-supply reserve. |
| EG24 | The Programme's Missing Page | Authored | Recover a final archived research record. | Programme conclusion evidence. |
| EG25 | Preserve the Findings | Hand-in | Deliver ordinary archival and laboratory support goods. | Final audited science equipment sidegrade. |
| EG26 | The Last Control Record | Authored | Recover the final field control and return the complete programme. | Recognition and final research dialogue. |

## Upgrade gates and allocation

EG03 detectorecho → EG11 detectorbear → EG21 detectorveles. All alternate authored detector routes obey this order. Science protection begins EG09 → EG13 → EG19 after actual suit comparison. EG15 research medicine requires Jitters' matching lower-tier milestone.

An unresolved lower-tier prerequisite is an implementation blocker for that reward, not permission
to leave it ungated. Preserve earned permissions through the migration ledger. Check alternate
authored shops, barters, and fixed rewards for shortcuts; do not restrict ordinary player trading
or reset existing characters as a side effect of this plan.

## Relationships and editable dialogue

Debates Beanstalk, relies on Intern, exchanges records with Carbon, values Vesper's field observations.

| Moment | Draft response |
| --- | --- |
| Greeting | Hello. Have you brought something we can actually compare? |
| About repeatable work | Artifacts. The requested specimens, not whichever ones you happen to dislike carrying. |
| Story conclusion | A reference collection with context. That's considerably more useful than a shelf of curiosities. |

These samples propose tone, not final dialogue. Preserve existing voice where applicable.
Author editable briefings, partial-progress replies, checkpoint announcements, locked responses,
completion lines, pending-claim messages, referrals, and before/after relationship topics.
A final greeting or recognition is personal unless an explicitly global event is designed.

## Implementation and availability notes

Prove a pre-detector artifact source for EG01; do not assume Echo ownership. Sensor work uses task-issued gear, not the detector it unlocks.

- Sites and story evidence above are proposed map content, not asserted existing spawns.
- Use existing item/job primitives where suitable; finite story integration, evidence items, and
  multi-stage completion still need authoritative events and saved-state design.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Current-source reference and unlock audit

- [Current progression source](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_eggheadprog.lua).
- [Current conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_ecologistnpc.lua).
- [Current templates and models](../../../gamemodes/ix_cotz/plugins/vendor_adv/libs/sh_npctemplates.lua).

Literal vendor item entries found in this source, retained here as an audit starting list:

`detectorecho`, `detectorbear`, `detectorveles`, `suit_ssp99`, `suit_ssp99m`, `suit_seva`, `medic_psyheal_2`, `medic_antirad_2`, `medic_stimpak_1`, `medic_antipsychotic_2`, `medic_stimpak_2`, `medic_antipsychotic_3`, `medic_stimpak_3`.

This is not the complete effective catalogue or the old-to-new unlock ledger. Some old items move
to other contacts; all must retain reachable progression access somewhere. Capture other shared
definitions, dynamic rewards, stock benefits, and excluded-contact allocations in the full audit.
