# Jitters: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Design reference with an implemented runtime definition.** See the runtime section below for authoritative requirements and rewards.

## Contact brief

- **Home and return point:** Marsh. Every hand-in and reward claim occurs here.
- **Identity:** Existing jittery medic.
- **Model:** Preserve the installed template's model, skin, and presentation.
- **Only repeatable category:** Medical supply deliveries.
- **Finite plan:** 26 steps; **7 hand-ins, 6 job checkpoints, 13 authored objectives**.
- **Step labels:** JT01 onward; runtime IDs prefix these labels with cotz/town/<contact-id>/. Keep deployed IDs stable.

## Chapter and dependency structure

The runtime graph has 3 shared introduction nodes, two narrow branches, then a
4-node conclusion requiring both branch tips. The chapter table groups story themes; it does not
impose a single sequential line. Explicit cross-contact equipment prerequisites remain required.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | JT01–JT04 | Clinic supplies |
| 2 | JT05–JT10 | Diagnostic equipment |
| 3 | JT11–JT16 | Exposure cases |
| 4 | JT17–JT22 | Expedition support |
| 5 | JT23–JT26 | Treatment dossier |

## Proposed narrative objectives and rewards

The chapter tables below preserve proposed story direction; they do not define runtime rewards.
Use the linked contact definition and unlock ledger for implemented requirements and benefits. Purchase access
does not grant the item. A clue must identify a real authored destination. A capacity increase does
not fill shelves. Each generic equipment slot remains unassigned until its item and upgrade gates
pass the catalogue audit; it must not be implemented as a convenient arbitrary item.

### Chapter 1: Clinic supplies

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| JT01 | Clean Hands | Hand-in | Deliver basic clinical supplies. | First bandage purchase improvement. |
| JT02 | The Empty Cabinet | Authored | Recover a clinic inventory from a Marsh aid station. | Basic treatment supplies. |
| JT03 | Keep the Shelves Filled | Tracker | Cumulative checkpoint C1: maintain medical-supply deliveries. | First bandage capacity increase. |
| JT04 | A Missing Bag | Authored | Recover a medic's abandoned case in Marsh. | Treatment credit. |

### Chapter 2: Diagnostic equipment

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| JT05 | A Proper Dressing | Hand-in | Supply existing dressing materials. | Next bandage tier purchase after its predecessor. |
| JT06 | The Exposure Log | Authored | Retrieve patient observations from a field shelter. | Exposure-preparation information. |
| JT07 | A Steady Clinic | Tracker | Cumulative checkpoint C2: reach the next medical-delivery checkpoint. | First medkit purchase. |
| JT08 | The Broken Instrument | Authored | Recover diagnostic equipment from a local supply site. | A small treatment discount. |
| JT09 | Fever and Fallout | Hand-in | Deliver radiation-treatment supplies obtainable at this stage. | Basic anti-radiation purchase. |
| JT10 | The Contaminated Batch | Authored | Collect sealed batch evidence from Garbage. | Fixed anti-radiation supplies. |

### Chapter 3: Exposure cases

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| JT11 | The Long Queue | Tracker | Cumulative checkpoint C3: sustain regional clinical supplies. | Next medkit tier purchase after its predecessor. |
| JT12 | Where the Water Came From | Authored | Retrieve a recorder near a suspect water source. | Gasket relationship reaction. |
| JT13 | Better Instruments | Hand-in | Deliver existing precision medical goods. | medic_medkit_2 purchase after medic_medkit_1. |
| JT14 | A Second Opinion | Authored | Recover a research note needed to compare exposure cases. | Treatment credit. |
| JT15 | Cases From Outside | Tracker | Cumulative checkpoint C4: complete the next supply checkpoint. | Next bandage tier purchase after its predecessor. |
| JT16 | The Missing Volunteer | Authored | Recover a volunteer medic's case in Garbage. | A medical preparation package. |

### Chapter 4: Expedition support

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| JT17 | For the Journey | Hand-in | Deliver expedition medical provisions. | Next medkit tier purchase after its predecessor. |
| JT18 | The Field Ward | Authored | Retrieve a treatment log at an abandoned regional aid post. | Medical-stock improvement. |
| JT19 | Ready for Returns | Tracker | Cumulative checkpoint C5: maintain supplies for injured expeditions. | Next medkit tier purchase after its predecessor. |
| JT20 | No One Came Back | Authored | Recover a clinic recorder from a Pripyat expedition site. | Pripyat exposure clue. |
| JT21 | Comparing the Cases | Hand-in | Supply existing research documents and clinical materials. | Advanced anti-radiation purchase after basic access. |
| JT22 | The Patient's Route | Authored | Retrieve the expedition's last exposure readings in Pripyat. | Treatment credit. |

### Chapter 5: Treatment dossier

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| JT23 | Still Taking Patients | Tracker | Cumulative checkpoint C6: reach the final medical-delivery checkpoint. | Final medkit tier purchase after all preceding tiers. |
| JT24 | An Answer on Tape | Authored | Recover the final medical recorder in Pripyat. | Final small treatment discount. |
| JT25 | A Clinic That Holds | Hand-in | Deliver reserve medical supplies. | Final selected clinical stock improvement. |
| JT26 | The Case Closed | Authored | Recover identifying evidence at the last exposure site and return to the clinic. | Recognition and a changed greeting. |

## Upgrade gates and allocation

Proposed medkits: JT07 medic_medkit_1 → JT11 medic_medkit_2 → JT15 medic_medkit_3 → JT17 medic_medkit_4 → JT19 medic_medkit_5 → JT23 medic_medkit_6. Verify actual effects but never bypass the established upgrade order. Bandages: baseline medic_bandage_1 → JT05 medic_bandage_2 → JT13 medic_bandage_3. Anti-radiation: JT09 medic_antirad_1 → JT21 medic_antirad_2. Imported clinical items need their own gates.

An unresolved lower-tier prerequisite is an implementation blocker for that reward, not permission
to leave it ungated. Current catalogue milestones are the only equipment permissions. Check alternate
authored shops, barters, and fixed rewards for shortcuts; do not restrict ordinary player trading
or reset existing characters as a side effect of this plan.

## Relationships and editable dialogue

Depends on Spicy Lemon's food and Gasket's clean water. Dislikes Arena Master's attitude to injury; values Wake's recovery information.

| Moment | Draft response |
| --- | --- |
| Greeting | Come in. Bleeding first, shopping second. Preferably neither on the floor. |
| About repeatable work | Medical supplies. Tell me what you've brought and I'll tell you what we're still short of. |
| Story conclusion | A full cabinet. I might actually sleep tonight. |

These samples propose tone, not final dialogue. Preserve existing voice where applicable.
Author editable briefings, partial-progress replies, checkpoint announcements, locked responses,
completion lines, pending-claim messages, referrals, and before/after relationship topics.
A final greeting or recognition is personal unless an explicitly global event is designed.

## Implementation and availability notes

Keep basic treatment available. Incorporate Old Timer's bandage capacity benefit with explicit caps. Credits and permanent discounts are distinct rewards.

- Sites and story evidence above are proposed map content, not asserted existing spawns.
- Use existing item/job primitives where suitable; finite commissions are implemented with the existing field primitives. Bespoke evidence items and
  multi-stage investigations still need separate mechanics.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Definition files

- [Jobs, catalogue, task dialogue and progression](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_jitters.lua).
- [Appearance and base stock](../../../gamemodes/ix_cotz/plugins/vendor_adv/definitions/sh_jitters.lua).
- [Conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_medicnpc.lua).

The [equipment index](../unlock-ledger.md) and loaded catalogue tables define current allocations.
Only current milestone IDs grant access; old completions and stock are not migrated.

## Runtime definition and sparse tree

[Editable contact definition](../../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_jitters.lua) · [Runtime setup](../../../gamemodes/ix_cotz/plugins/townnpcs/README.md) · [Unlock ledger](../unlock-ledger.md)

| Part | Nodes in order |
| --- | --- |
| Shared introduction | JT01 → JT02 → JT03 |
| Supplies and work | JT05 → JT07 → JT09 → JT11 → JT13 → JT15 → JT17 → JT19 → JT21 |
| Field work and story | JT04 → JT06 → JT08 → JT10 → JT12 → JT14 → JT16 → JT18 → JT20 → JT22 |
| Conclusion after both branches | JT23 → JT24 → JT25 → JT26 |

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
