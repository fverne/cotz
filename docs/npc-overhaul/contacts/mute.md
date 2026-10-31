# Mute: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Review draft; no runtime implementation.** Read the contact index's shared authoring rules first.
Exact item quantities, job totals, coordinates, prices, and unresolved reward IDs are not assigned.

## Contact brief

- **Home and return point:** Marsh. Every hand-in and reward claim occurs here.
- **Identity:** Existing withdrawn, near-silent Stalkernet operator.
- **Model:** Preserve the installed template's model, skin, and presentation.
- **Only repeatable category:** Electronics deliveries.
- **Finite plan:** 24 steps; **6 hand-ins, 6 job checkpoints, 12 authored objectives**.
- **Design labels:** MU01 onward, used only in these documents; final runtime IDs need a compatibility review.

## Chapter and dependency structure

This first draft is sequential within and between chapters. A later branch split must retain every
equipment-tier dependency. C1 onward are cumulative, contact-specific job checkpoints, not one-job
requirements or lifetime totals. Numerical thresholds and counting baselines require balancing.
Cross-contact upgrade gates are additional requirements on the same player character.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | MU01–MU04 | Network hardware |
| 2 | MU05–MU10 | Lost records |
| 3 | MU11–MU14 | Regional equipment |
| 4 | MU15–MU20 | Unknown connection |
| 5 | MU21–MU24 | Intrusion resolution |

## Objectives and small rewards

Rewards below supplement the ordinary finite progression payout where applicable. Purchase access
does not grant the item. A clue must identify a real authored destination. A capacity increase does
not fill shelves. Each generic equipment slot remains unassigned until its item and upgrade gates
pass the catalogue audit; it must not be implemented as a convenient arbitrary item.

### Chapter 1: Network hardware

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| MU01 | A Loose Connection | Hand-in | Deliver ordinary electronic components. | binoculars_2 purchase. |
| MU02 | The Silent Repeater | Authored | Recover a failed repeater's log in Marsh. | Network preparation supplies. |
| MU03 | Signals Getting Through | Tracker | Cumulative checkpoint C1: maintain electronics deliveries. | Small electronics-stock improvement. |
| MU04 | The Missing Address | Authored | Recover an address register from a local cache. | PDA information topic. |

### Chapter 2: Lost records

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| MU05 | A Clearer Picture | Hand-in | Supply optical and electronic service goods. | binoculars_1 purchase, after binoculars_2. |
| MU06 | A Line Through the Marsh | Authored | Retrieve a recorder along a broken network route. | Regional signal clue. |
| MU07 | Not Just Static | Tracker | Cumulative checkpoint C2: reach the next electronics-delivery checkpoint. | One existing PDA service unlock. |
| MU08 | Spool's Packet | Authored | Recover a sealed communications record in Garbage. | Spool relationship response. |
| MU09 | Noisy Components | Hand-in | Deliver components for interference testing. | Basic anomaly-warning equipment purchase, effects audit required. |
| MU10 | The Duplicate Message | Authored | Retrieve two linked field records from a relay route. | Diagnostic clue. |

### Chapter 3: Regional equipment

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| MU11 | A Stable Link | Tracker | Cumulative checkpoint C3: maintain regional electronics orders. | First small PDA-service benefit. |
| MU12 | The Unlisted Receiver | Authored | Locate and retrieve a source through finite triangulation. | Source-identification evidence. |
| MU13 | Looking Further | Hand-in | Supply advanced optical components. | binoculars_4 purchase, after binoculars_1. |
| MU14 | The Second Copy | Authored | Recover a backup log in Waystation territory. | Network investigation lead. |

### Chapter 4: Unknown connection

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| MU15 | Beyond Local Range | Tracker | Cumulative checkpoint C4: reach the next electronics checkpoint. | Selected electronics-stock increase. |
| MU16 | A Message With No Sender | Authored | Retrieve a source recorder near a remote relay. | Pripyat signal clue. |
| MU17 | The Final Lens | Hand-in | Deliver specialist optical service materials. | binoculars_3 purchase, after binoculars_4. |
| MU18 | The Old Routing Table | Authored | Recover a routing record at a Pripyat communications site. | Technical preparation package. |
| MU19 | No Lost Packets | Tracker | Cumulative checkpoint C5: complete the next electronics checkpoint. | One additional PDA-service benefit. |
| MU20 | Someone on the Line | Authored | Recover the unknown connection's recorder in Pripyat. | Intrusion evidence. |

### Chapter 5: Intrusion resolution

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| MU21 | Parts for a Clean Link | Hand-in | Supply existing isolation and diagnostic components. | Electronics-service barter. |
| MU22 | The Broken Handshake | Authored | Take finite signal bearings and recover its source in Pripyat. | Final network lead. |
| MU23 | Message Received | Tracker | Cumulative checkpoint C6: reach the final electronics checkpoint. | Final selected electronic supply reserve. |
| MU24 | The Last Address | Authored | Recover the intrusion's final field record and return it to Mute. | Recognition and a rare changed response. |

## Upgrade gates and allocation

Preserve current binocular order: MU01 binoculars_2 → MU05 binoculars_1 → MU13 binoculars_4 → MU17 binoculars_3. Numeric suffixes are not tier order. His current detectorecho route is a transfer candidate to Egghead EG03; any alternate route must obey the same detector chain. Check anomalydetector's different function before classifying it.

An unresolved lower-tier prerequisite is an implementation blocker for that reward, not permission
to leave it ungated. Preserve earned permissions through the migration ledger. Check alternate
authored shops, barters, and fixed rewards for shortcuts; do not restrict ordinary player trading
or reset existing characters as a side effect of this plan.

## Relationships and editable dialogue

Rare pointed remarks about Technut; terse, reliable dealings with Spool; guarded professional suspicion of Smartass. Silence and short responses remain important.

| Moment | Draft response |
| --- | --- |
| Greeting | ** He glances at your hands, then at the unfinished circuit on his desk. ** |
| About repeatable work | ** He slides over a list of electronic components. Nothing else is written on it. ** |
| Story conclusion | ** He reads the final address twice, then quietly disconnects the receiver. ** |

These samples propose tone, not final dialogue. Preserve existing voice where applicable.
Author editable briefings, partial-progress replies, checkpoint announcements, locked responses,
completion lines, pending-claim messages, referrals, and before/after relationship topics.
A final greeting or recognition is personal unless an explicitly global event is designed.

## Implementation and availability notes

Sparse speech and gestures remain central. Network fiction does not imply hacking mechanics, actual message interception, or new PDA functionality.

- Sites and story evidence above are proposed map content, not asserted existing spawns.
- Use existing item/job primitives where suitable; finite story integration, evidence items, and
  multi-stage completion still need authoritative events and saved-state design.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Current-source reference and unlock audit

- [Current progression source](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_muteprog.lua).
- [Current conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_stalkernetadmin.lua).
- [Current templates and models](../../../gamemodes/ix_cotz/plugins/vendor_adv/libs/sh_npctemplates.lua).

Literal vendor item entries found in this source, retained here as an audit starting list:

`binoculars_2`, `binoculars_1`, `binoculars_4`, `binoculars_3`, `anomalydetector`, `detectorecho`.

This is not the complete effective catalogue or the old-to-new unlock ledger. Some old items move
to other contacts; all must retain reachable progression access somewhere. Capture other shared
definitions, dynamic rewards, stock benefits, and excluded-contact allocations in the full audit.
