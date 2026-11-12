# Spool: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Design reference with an implemented runtime definition.** See the runtime section below for authoritative requirements and rewards.

## Current repeatable work — 6 November 2026

Home/claim region: **Garbage**. Current specialty: **Radio triangulation**.
New work uses 1,000/2,000/3,000-ruble reference budgets and 15/25/35 reputation, with existing themed packages and five-job bonuses.
See the [current job implementation](../repeatable-jobs.md) for quantities, routes, rewards, compatibility and multiplayer checks. Earlier chapter tables below remain finite-progression design references.


## Implemented voice direction — November 2026

Sociable, exhausted radio operator who enjoys ordinary callers and remembers how they sound. Missing voices bring concern and careful checking rather than instant conclusions about death or disappearance.

Personal conversations, work explanations, and commission text live in the linked runtime definitions.
Cargo names and descriptions are per assignment; these additions do not change jobs, rewards,
prerequisites, or field-site placement. Earlier story tables and draft samples remain design references.

## Personality and personal conversation — November 2026

New everyday characterization authored for this expansion; established history and progression disclosures remain unchanged.

**Motivation and contradiction:** Likes the familiar sound of people carrying on with ordinary life in the Zone. His appetite for company competes with a tired operator's need for a break and a quiet channel.

**Voice and boundaries:** Sociable and slightly rambling, capable of impatience without withdrawing all warmth. Use remembered speech habits and specific interruptions rather than repeated warnings about silence. No anecdote establishes an actual broadcast feature.

**Relationships:** Mute's economy of expression gives him relief from explaining a technical problem and very little conversational company afterwards. Respect and mild disappointment can occupy the same account.

**Personal subjects:** Do people argue about artifacts over the radio? / What is talking to Mute like for you?

These conversations and their follow-up live in [sh_spoolnpc.lua](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_spoolnpc.lua), under the existing questions menu.

## Contact brief

- **Home and return point:** Garbage. Every hand-in and reward claim occurs here.
- **Identity:** New: exhausted, sociable radio operator who remembers voices.
- **Model:** Provisional Half-Life 2 human model in the appearance definition; final model still open.
- **Only repeatable category:** Radio triangulation.
- **Finite plan:** 22 steps; **6 hand-ins, 5 job checkpoints, 11 authored objectives**.
- **Step labels:** SO01 onward; runtime IDs prefix these labels with cotz/town/<contact-id>/. Keep deployed IDs stable.

## Chapter and dependency structure

The runtime graph has 2 shared introduction nodes, two narrow branches, then a
4-node conclusion requiring both branch tips. The chapter table groups story themes; it does not
impose a single sequential line. Explicit cross-contact equipment prerequisites remain required.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | SO01–SO04 | Local communications |
| 2 | SO05–SO08 | Failed stations |
| 3 | SO09–SO14 | Regional contacts |
| 4 | SO15–SO18 | Missing transmissions |
| 5 | SO19–SO22 | Pripyat expedition |

## Proposed narrative objectives and rewards

The chapter tables below preserve proposed story direction; they do not define runtime rewards.
Use the linked contact definition and unlock ledger for implemented requirements and benefits. Purchase access
does not grant the item. A clue must identify a real authored destination. A capacity increase does
not fill shelves. Each generic equipment slot remains unassigned until its item and upgrade gates
pass the catalogue audit; it must not be implemented as a convenient arbitrary item.

### Chapter 1: Local communications

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| SO01 | Something on the Air | Hand-in | Deliver ordinary radio maintenance goods. | First communications-supply purchase. |
| SO02 | The Local Silence | Authored | Triangulate and recover a finite transmitter near Waystation. | Local reception clue. |
| SO03 | Clear Enough to Hear | Tracker | Cumulative checkpoint C1: complete initial triangulation checkpoint. | Selected electronic-supply reserve. |
| SO04 | The Station Log | Authored | Recover a failed station's recorder. | Regional station lead. |

### Chapter 2: Failed stations

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| SO05 | Ground and Power | Hand-in | Deliver accessible electronic service supplies. | Communications preparation barter. |
| SO06 | The Crossed Bearings | Authored | Recover a calibration record disputed by Smartass. | Technical banter unlocked. |
| SO07 | A Voice Worth Finding | Tracker | Cumulative checkpoint C2: reach the next triangulation checkpoint. | One instrument sidegrade purchase. |
| SO08 | The Absent Operator | Authored | Locate a source and retrieve its recorded message. | Missing expedition lead. |

### Chapter 3: Regional contacts

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| SO09 | A Longer Cable | Hand-in | Supply existing communications components. | Next electronic-supply purchase. |
| SO10 | Mute's Header | Authored | Recover a damaged network record in Swamps. | Mute relationship response. |
| SO11 | Across the Static | Tracker | Cumulative checkpoint C3: maintain regional triangulation work. | One selected supply-stock increase. |
| SO12 | The Garbage Relay | Authored | Locate and retrieve a source near a freight route. | Wake investigation connection. |
| SO13 | Packed to Listen | Hand-in | Deliver expedition radio provisions. | Fixed technical preparation supplies. |
| SO14 | The Unsent Call | Authored | Recover an expedition check-in recording in regional ruins. | Pripyat frequency clue. |

### Chapter 4: Missing transmissions

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| SO15 | Still on Frequency | Tracker | Cumulative checkpoint C4: reach the next triangulation checkpoint. | Next verified instrument tier or distinct sidegrade. |
| SO16 | The First Pripyat Call | Authored | Triangulate and collect a transmitter in Pripyat. | Expedition route information. |
| SO17 | Enough Power to Return | Hand-in | Supply source-verified late radio service materials. | Final selected communications reserve. |
| SO18 | The Last Check-in | Authored | Recover a second expedition recorder deeper in Pripyat. | Missing team's outcome evidence. |

### Chapter 5: Pripyat expedition

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| SO19 | Nobody Left Calling | Tracker | Cumulative checkpoint C5: reach the final triangulation checkpoint. | Final audited communications equipment unlock. |
| SO20 | The Receiver That Stayed On | Authored | Locate and retrieve the expedition's final source. | Final missing-call evidence. |
| SO21 | Keep the Channel Open | Hand-in | Deliver ordinary station reserve supplies. | Permanent radio preparation barter. |
| SO22 | The Message Home | Authored | Recover the last unsent recording and return it to the station. | Recognition and conditional Wake reaction. |

## Upgrade gates and allocation

SO07 instrument sidegrade → SO15 next verified tier → SO19 final instrument slot. Direct upgrades require the real lower milestone at Mute/Smartass if those contacts sell it. No bypass of Mute's binocular chain.

An unresolved lower-tier prerequisite is an implementation blocker for that reward, not permission
to leave it ungated. Current catalogue milestones are the only equipment permissions. Check alternate
authored shops, barters, and fixed rewards for shortcuts; do not restrict ordinary player trading
or reset existing characters as a side effect of this plan.

## Relationships and editable dialogue

Helps Wake recognise missing callers, respects Mute's ability, argues technically with Smartass.

| Moment | Draft response |
| --- | --- |
| Greeting | Hold on. That's a voice I haven't heard in a while. |
| About repeatable work | Triangulate the source and bring the transmitter back. I'll deal with what's on the recording. |
| Story conclusion | They left a message. Someone should hear it. |

These samples propose tone, not final dialogue. Preserve existing voice where applicable.
Author editable briefings, partial-progress replies, checkpoint announcements, locked responses,
completion lines, pending-claim messages, referrals, and before/after relationship topics.
A final greeting or recognition is personal unless an explicitly global event is designed.

## Implementation and availability notes

Triangulation supersedes the old deployment proposal. Fictional recordings do not imply live voice capture, interception, or new radio-chat functionality.

- Sites and story evidence above are proposed map content, not asserted existing spawns.
- Use existing item/job primitives where suitable; finite commissions are implemented with the existing field primitives. Bespoke evidence items and
  multi-stage investigations still need separate mechanics.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Definition files

- [Jobs, catalogue, task dialogue and progression](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_spool.lua).
- [Appearance and base stock](../../../gamemodes/ix_cotz/plugins/vendor_adv/definitions/sh_spool.lua).
- [Conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_spoolnpc.lua).

The [equipment index](../unlock-ledger.md) and loaded catalogue tables define current allocations.
Only current milestone IDs grant access; old completions and stock are not migrated.

## Runtime definition and sparse tree

[Editable contact definition](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_spool.lua) · [Runtime setup](../../../gamemodes/ix_cotz/plugins/townnpcs/README.md) · [Unlock ledger](../unlock-ledger.md)

| Part | Nodes in order |
| --- | --- |
| Shared introduction | SO01 → SO02 |
| Supplies and work | SO03 → SO05 → SO07 → SO09 → SO11 → SO13 → SO15 → SO17 |
| Field work and story | SO04 → SO06 → SO08 → SO10 → SO12 → SO14 → SO16 → SO18 |
| Conclusion after both branches | SO19 → SO20 → SO21 → SO22 |

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

## Current reward allocation

Purchase routes are local to this seller; equipment tier dependencies retain explicit canonical owners.
The [generated unlock ledger](../unlock-ledger.md#every-progression-step) lists this contact's current
purchases, conversions, stock tiers and supplementary rewards. Historical chapter tables above are story
references, not the reward authority. 14 steps carry future `plannedUnlocks` metadata with adjacent TODO comments;
these entries do not grant working benefits or appear as functional rewards in game. Current default
stock quantities and refill settings are outside this redistribution pass.
