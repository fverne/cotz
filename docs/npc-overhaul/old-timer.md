# Old Timer: runtime progression reference

[Design index](README.md) · [Runtime/editing guide](../../gamemodes/ix_cotz/plugins/townnpcs/README.md)

Home: Marsh. Existing name, model and personality remain. Only repeatable work: mutant hunting.
Edit [sh_old_timer.lua](../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_old_timer.lua)
for requirements, targets, prerequisites, work prompts, briefings, benefits and finished-story greeting.
Background dialogue remains in sh_tutorialnpc.lua.

## Implemented voice direction — November 2026

Stern, practical mentor with dry humour and faults he can acknowledge. Concern is expressed through preparation and attention to the return journey; familiarity and the companion story develop through the existing progression.

Personal conversations, work explanations, and commission text live in the linked runtime definitions.
Cargo names and descriptions are per assignment; these additions do not change jobs, rewards,
prerequisites, or field-site placement. Earlier story tables and draft samples remain design references.

## Personality and personal conversation — November 2026

New everyday characterization authored for this expansion; established history and progression disclosures remain unchanged.

**Motivation and contradiction:** Wants a place in camp without having to be useful every moment. He enjoys the company of returning stalkers, yet his habit of checking their preparations can turn a welcome into an inspection.

**Voice and boundaries:** Unhurried, specific, occasionally amused at himself. Let him discuss familiar ground, wet clothing, or a poor night's sleep without converting every observation into a lesson. Keep his companion's history behind its existing progression disclosures.

**Relationships:** Lemon can interrupt his self-sufficiency through familiar domestic complaints. Their long acquaintance permits irritation and small concessions, without giving either man authority to reveal the other's private history.

**Personal subjects:** What do you do when you aren't hunting? / Does Lemon ever let you cook?

These conversations and their follow-up live in [sh_tutorialnpc.lua](../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_tutorialnpc.lua), under the existing questions menu.

## Sparse tree

| Part | Nodes in order |
| --- | --- |
| Shared introduction | OT01 → OT02 → OT03 → OT04 |
| Supplies and work | OT05 → OT07 → OT09 → OT11 → OT13 → OT15 → OT17 → OT19 → OT21 → OT23 |
| Field work and story | OT06 → OT08 → OT10 → OT12 → OT14 → OT16 → OT18 → OT20 → OT22 → OT24 |
| Conclusion after both branches | OT25 → OT26 → OT27 → OT28 |

Both branches begin after OT04. Direct equipment prerequisites still apply.
Kitchen Knife at OT03 precedes Survival Knife at OT12; Quartermaster QM11 additionally requires OT12.
Sharpening Stone at OT07 precedes Fine Sharpening Stone at OT19.
The final keepsake story rewards supplies/recognition rather than an obsolete stronger-knife claim.

## Implemented objectives

Field sites are assigned from configured point pools. Notebooks and keepsakes now use named bound quest cargo.
OT22 delivers the recording to Spool before returning to Old Timer for completion.
Seven former field steps now request ordinary supplies. All deliveries scale with FTS availability;
see the [delivery balance report](delivery-balance.md). Current pools and quantities are listed below.
See the [commission inventory](quest-commissions.md). Physical locations still require multiplayer testing.
Quantities below are initial tuning, not measured completion times.

| ID | Objective | Kind | Requirement/target/region | Reward |
| --- | --- | --- | --- | --- |
| OT01 | Before You Leave | delivery | town_delivery_trail_marsh_1 x1 | medic_bandage_1 (1 unit) |
| OT02 | Know Your Ground | field | rp_marsh_cs | 12gauge (1 unit) |
| OT03 | Something With Teeth | tracker | 2 cumulative jobs | 22lr (1 unit); Buy knife2 |
| OT04 | A small delivery | delivery | town_delivery_trail_marsh_1 x1 | food_bread (1 unit) |
| OT05 | A Place to Hide | delivery | town_delivery_trail_marsh_1 x2; town_delivery_trail_marsh_2 x1 | medic_bandage_1 (1 unit) |
| OT06 | Ready Enough | field | rp_marsh_cs | 12gauge (1 unit); +1 personal medic_bandage_1 capacity |
| OT07 | Look After Your Kit | tracker | 5 cumulative jobs | 22lr (1 unit); Buy sharpening_stone |
| OT08 | Restocking | delivery | town_delivery_trail_marsh_1 x2; town_delivery_trail_marsh_2 x1 | food_bread (1 unit); Buy hatchet |
| OT09 | Bad Water | delivery | town_delivery_trail_marsh_1 x2; town_delivery_trail_marsh_2 x1 | medic_bandage_1 (1 unit) |
| OT10 | Enough for the Walk Home | field | rp_marsh_cs | 12gauge (1 unit) |
| OT11 | Old Habits | tracker | 9 cumulative jobs | 22lr (1 unit) |
| OT12 | Restocking | delivery | town_delivery_trail_marsh_1 x2; town_delivery_trail_marsh_2 x1 | food_bread (1 unit); Buy knife3 |
| OT13 | Tracks at the Fence | delivery | town_delivery_trail_marsh_1 x3; town_delivery_trail_marsh_2 x2; town_delivery_trail_marsh_3 x1 | medic_bandage_1 (1 unit) |
| OT14 | Thin the Pack | field | rp_marsh_cs | 12gauge (1 unit) |
| OT15 | What They Leave Behind | tracker | 14 cumulative jobs | 22lr (1 unit) |
| OT16 | Building the reserve | delivery | town_delivery_trail_marsh_1 x3; town_delivery_trail_marsh_2 x2; town_delivery_trail_marsh_3 x1 | food_bread (1 unit) |
| OT17 | The Empty Camp | delivery | town_delivery_trail_marsh_1 x3; town_delivery_trail_marsh_2 x2; town_delivery_trail_marsh_3 x1 | medic_bandage_1 (1 unit) |
| OT18 | Leave a Way Out | field | rp_marsh_cs | 12gauge (1 unit) |
| OT19 | An Old Name | tracker | 20 cumulative jobs | 22lr (1 unit); Buy sharpening_stone_fine |
| OT20 | Building the reserve | delivery | town_delivery_trail_marsh_1 x3; town_delivery_trail_marsh_2 x2; town_delivery_trail_marsh_3 x1 | food_bread (1 unit) |
| OT21 | Someone Kept Records | delivery | town_delivery_trail_marsh_1 x3; town_delivery_trail_marsh_2 x2; town_delivery_trail_marsh_3 x1 | medic_bandage_1 (1 unit) |
| OT22 | A Voice on Tape | field | rp_waystation | 12gauge (1 unit) |
| OT23 | What He Was Carrying | tracker | 27 cumulative jobs | 22lr (1 unit) |
| OT24 | A full supply order | delivery | town_delivery_trail_marsh_1 x4; town_delivery_trail_marsh_2 x3; town_delivery_trail_marsh_3 x2; town_delivery_trail_marsh_4 x1 | food_bread (1 unit) |
| OT25 | Past the Turn Back Point | delivery | town_delivery_trail_marsh_1 x4; town_delivery_trail_marsh_2 x3; town_delivery_trail_marsh_3 x2; town_delivery_trail_marsh_4 x1 | medic_bandage_1 (1 unit) |
| OT26 | He Made It This Far | field | rp_pripyat_remaster | 12gauge (1 unit); +2 personal medic_bandage_1 capacity |
| OT27 | Bring Him Home | tracker | 35 cumulative jobs | 22lr (1 unit) |
| OT28 | A full supply order | delivery | town_delivery_trail_marsh_1 x4; town_delivery_trail_marsh_2 x3; town_delivery_trail_marsh_3 x2; town_delivery_trail_marsh_4 x1 | food_bread (1 unit) |

All relocated item access is recorded in the [unlock ledger](unlock-ledger.md).
