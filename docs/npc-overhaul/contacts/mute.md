# Mute: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Design reference with an implemented runtime definition.** See the runtime section below for authoritative requirements and rewards.

## Contact brief

- **Home and return point:** Marsh. Every hand-in and reward claim occurs here.
- **Identity:** Existing withdrawn, near-silent Stalkernet operator.
- **Model:** Preserve the installed template's model, skin, and presentation.
- **Only repeatable category:** Electronics deliveries.
- **Finite plan:** 24 steps; **6 hand-ins, 6 job checkpoints, 12 authored objectives**.
- **Step labels:** MU01 onward; runtime IDs prefix these labels with cotz/town/<contact-id>/. Keep deployed IDs stable.

## Chapter and dependency structure

The runtime graph has 2 shared introduction nodes, two narrow branches, then a
4-node conclusion requiring both branch tips. The chapter table groups story themes; it does not
impose a single sequential line. Explicit cross-contact equipment prerequisites remain required.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | MU01–MU04 | Network hardware |
| 2 | MU05–MU10 | Lost records |
| 3 | MU11–MU14 | Regional equipment |
| 4 | MU15–MU20 | Unknown connection |
| 5 | MU21–MU24 | Intrusion resolution |

## Proposed narrative objectives and rewards

The chapter tables below preserve proposed story direction; they do not define runtime rewards.
Use the linked contact definition and unlock ledger for implemented requirements and benefits. Purchase access
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
to leave it ungated. Current catalogue milestones are the only equipment permissions. Check alternate
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
- Use existing item/job primitives where suitable; finite commissions are implemented with the existing field primitives. Bespoke evidence items and
  multi-stage investigations still need separate mechanics.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Definition files

- [Jobs, catalogue, task dialogue and progression](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_mute.lua).
- [Appearance and base stock](../../../gamemodes/ix_cotz/plugins/vendor_adv/definitions/sh_mute.lua).
- [Conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_stalkernetadmin.lua).

The [equipment index](../unlock-ledger.md) and loaded catalogue tables define current allocations.
Only current milestone IDs grant access; old completions and stock are not migrated.

## Runtime definition and sparse tree

[Editable contact definition](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_mute.lua) · [Runtime setup](../../../gamemodes/ix_cotz/plugins/townnpcs/README.md) · [Unlock ledger](../unlock-ledger.md)

| Part | Nodes in order |
| --- | --- |
| Shared introduction | MU01 → MU02 |
| Supplies and work | MU03 → MU05 → MU07 → MU09 → MU11 → MU13 → MU15 → MU17 → MU19 |
| Field work and story | MU04 → MU06 → MU08 → MU10 → MU12 → MU14 → MU16 → MU18 → MU20 |
| Conclusion after both branches | MU21 → MU22 → MU23 → MU24 |

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
