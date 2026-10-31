# Beanstalk: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Review draft; no runtime implementation.** Read the contact index's shared authoring rules first.
Exact item quantities, job totals, coordinates, prices, and unresolved reward IDs are not assigned.

## Contact brief

- **Home and return point:** Garbage. Every hand-in and reward claim occurs here.
- **Identity:** Existing concerned scientist.
- **Model:** Preserve the installed template's model, skin, and presentation.
- **Only repeatable category:** Research defence.
- **Finite plan:** 24 steps; **6 hand-ins, 6 job checkpoints, 12 authored objectives**.
- **Design labels:** BN01 onward, used only in these documents; final runtime IDs need a compatibility review.

## Chapter and dependency structure

This first draft is sequential within and between chapters. A later branch split must retain every
equipment-tier dependency. C1 onward are cumulative, contact-specific job checkpoints, not one-job
requirements or lifetime totals. Numerical thresholds and counting baselines require balancing.
Cross-contact upgrade gates are additional requirements on the same player character.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | BN01–BN04 | Field station |
| 2 | BN05–BN10 | Dump contamination |
| 3 | BN11–BN14 | Environmental changes |
| 4 | BN15–BN20 | Remote sampling |
| 5 | BN21–BN24 | Pripyat comparison |

## Objectives and small rewards

Rewards below supplement the ordinary finite progression payout where applicable. Purchase access
does not grant the item. A clue must identify a real authored destination. A capacity increase does
not fill shelves. Each generic equipment slot remains unassigned until its item and upgrade gates
pass the catalogue audit; it must not be implemented as a convenient arbitrary item.

### Chapter 1: Field station

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| BN01 | A Station in the Dust | Hand-in | Deliver field-research supplies. | Basic science-supply purchase. |
| BN02 | The First Baseline | Authored | Defend a finite sampler at a Garbage contamination site. | Baseline results and protection supplies. |
| BN03 | Results That Survive | Tracker | Cumulative checkpoint C1: complete initial research-defence checkpoint. | Selected field-supply reserve. |
| BN04 | The Buried Meter | Authored | Recover a lost instrument case at a dump. | Contamination lead. |

### Chapter 2: Dump contamination

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| BN05 | Keeping It Sealed | Hand-in | Deliver existing filters and protective consumables. | Basic environmental-protection purchase. |
| BN06 | Two Sides of the Heap | Authored | Complete paired recordings at different dump sites. | Comparative research information. |
| BN07 | A Consistent Sample | Tracker | Cumulative checkpoint C2: reach the next defence checkpoint. | One further scientific-supply purchase. |
| BN08 | Vesper's Reading | Authored | Recover a disputed recorder from an anomaly approach. | Vesper disagreement introduced. |
| BN09 | Clean Instruments | Hand-in | Supply accessible cleaning and lab consumables. | Small science preparation barter. |
| BN10 | The Control Site | Authored | Defend a finite sampler away from the contested field. | Control results. |

### Chapter 3: Environmental changes

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| BN11 | Enough to Compare | Tracker | Cumulative checkpoint C3: maintain regional defended research. | Next protection tier only after the lower tier's owner milestone. |
| BN12 | The Dirty Filter | Authored | Retrieve a field station's exposure record. | Intern relationship response. |
| BN13 | A Field Lab in Reserve | Hand-in | Deliver existing laboratory support goods. | Selected environmental-supply stock increase. |
| BN14 | Beyond the Dumps | Authored | Defend a sampler at a regional industrial site. | Regional study lead. |

### Chapter 4: Remote sampling

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| BN15 | Work Under Pressure | Tracker | Cumulative checkpoint C4: reach the next defence checkpoint. | Fixed medical preparation package. |
| BN16 | The Contradictory Result | Authored | Recover a second control recorder in Waystation territory. | Joint Vesper comparison topic. |
| BN17 | Preparing the Comparison | Hand-in | Supply materials for a late research expedition. | Advanced protection sidegrade purchase. |
| BN18 | Pripyat Baseline | Authored | Defend a sampler at a Pripyat contamination site. | Deep-field results. |
| BN19 | Holding the Site | Tracker | Cumulative checkpoint C5: maintain advanced defended research. | Next audited protective-equipment unlock. |
| BN20 | The Abandoned Station | Authored | Recover an earlier team's recorder in Pripyat. | Historical baseline evidence. |

### Chapter 5: Pripyat comparison

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| BN21 | A Clean Comparison | Hand-in | Deliver ordinary research documents and consumables. | Final selected science-supply reserve. |
| BN22 | The Last Control | Authored | Complete the final defended Pripyat recording. | Contamination dossier evidence. |
| BN23 | Findings Worth Keeping | Tracker | Cumulative checkpoint C6: reach the final research-defence checkpoint. | Final science preparation barter. |
| BN24 | A Result They Both Accept | Authored | Recover missing control evidence and return the completed comparison. | Recognition and conditional Vesper reconciliation. |

## Upgrade gates and allocation

BN05 basic environmental protection → BN11 next protection → BN19 later tier. Each also needs the exact lower-tier owner milestone if equipment moves between Suture, Egghead, or Beanstalk. IDs require suit-stat review.

An unresolved lower-tier prerequisite is an implementation blocker for that reward, not permission
to leave it ungated. Preserve earned permissions through the migration ledger. Check alternate
authored shops, barters, and fixed rewards for shortcuts; do not restrict ordinary player trading
or reset existing characters as a side effect of this plan.

## Relationships and editable dialogue

Worries about Vesper's risk-taking; debates Egghead's priorities; checks Intern's preparations.

| Moment | Draft response |
| --- | --- |
| Greeting | Keep it down. And keep your hands away from the samples. |
| About repeatable work | Protect the sampler until it finishes. Then bring back the results, not an explanation. |
| Story conclusion | This agrees with the control. Finally, something we can both stand behind. |

These samples propose tone, not final dialogue. Preserve existing voice where applicable.
Author editable briefings, partial-progress replies, checkpoint announcements, locked responses,
completion lines, pending-claim messages, referrals, and before/after relationship topics.
A final greeting or recognition is personal unless an explicitly global event is designed.

## Implementation and availability notes

Control-site visits do not earn defence credit without completing defence. Scientific reconciliation is personal, not a global dialogue change.

- Sites and story evidence above are proposed map content, not asserted existing spawns.
- Use existing item/job primitives where suitable; finite story integration, evidence items, and
  multi-stage completion still need authoritative events and saved-state design.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Current-source reference and unlock audit

- [Current progression source](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_beanstalkprog.lua).
- [Current conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_ecologistnpc2.lua).
- [Current templates and models](../../../gamemodes/ix_cotz/plugins/vendor_adv/libs/sh_npctemplates.lua).

No literal vendor item entries were found by the preliminary source scan. Check callbacks,
shared definitions, service rewards, and the live catalogue before concluding there are none.

This is not the complete effective catalogue or the old-to-new unlock ledger. Some old items move
to other contacts; all must retain reachable progression access somewhere. Capture other shared
definitions, dynamic rewards, stock benefits, and excluded-contact allocations in the full audit.
