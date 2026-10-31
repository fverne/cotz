# Old Timer: runtime progression reference

[Design index](README.md) · [Runtime/editing guide](../../gamemodes/ix_cotz/plugins/townnpcs/README.md)

Home: Marsh. Existing name, model and personality remain. Only repeatable work: mutant hunting.
Edit [sh_old_timer.lua](../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_old_timer.lua)
for requirements, targets, prerequisites, work prompts, briefings, benefits and finished-story greeting.
Background dialogue remains in sh_tutorialnpc.lua.

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

Field sites are assigned from configured point pools. Unique notebooks and keepsakes use the
existing bound commission cargo; physical locations require authoring and multiplayer testing.
Quantities below are initial tuning, not measured completion times.

| ID | Objective | Kind | Requirement/target/region | Reward |
| --- | --- | --- | --- | --- |
| OT01 | Before You Leave | delivery | canned_food x2 | medic_bandage_1 (1 unit) |
| OT02 | Know Your Ground | field | rp_marsh_cs | 12gauge (1 unit) |
| OT03 | Something With Teeth | tracker | 2 cumulative jobs | 22lr (1 unit); Buy knife2 |
| OT04 | Bring Something Back | field | rp_marsh_cs | food_bread (1 unit) |
| OT05 | A Place to Hide | delivery | field_maintenance x3 | medic_bandage_1 (1 unit) |
| OT06 | Ready Enough | field | rp_marsh_cs | 12gauge (1 unit); +1 personal medic_bandage_1 capacity |
| OT07 | Look After Your Kit | tracker | 5 cumulative jobs | 22lr (1 unit); Buy sharpening_stone |
| OT08 | Travel Light | field | rp_marsh_cs | food_bread (1 unit); Buy hatchet |
| OT09 | Bad Water | delivery | field_maintenance x3 | medic_bandage_1 (1 unit) |
| OT10 | Enough for the Walk Home | field | rp_marsh_cs | 12gauge (1 unit) |
| OT11 | Old Habits | tracker | 9 cumulative jobs | 22lr (1 unit) |
| OT12 | Keep Yourself Alive | field | rp_marsh_cs | food_bread (1 unit); Buy knife3 |
| OT13 | Tracks at the Fence | delivery | common_parts x2 | medic_bandage_1 (1 unit) |
| OT14 | Thin the Pack | field | rp_marsh_cs | 12gauge (1 unit) |
| OT15 | What They Leave Behind | tracker | 14 cumulative jobs | 22lr (1 unit) |
| OT16 | Not Normal Behaviour | field | rp_marsh_cs | food_bread (1 unit) |
| OT17 | The Empty Camp | delivery | common_parts x2 | medic_bandage_1 (1 unit) |
| OT18 | Leave a Way Out | field | rp_marsh_cs | 12gauge (1 unit) |
| OT19 | An Old Name | tracker | 20 cumulative jobs | 22lr (1 unit); Buy sharpening_stone_fine |
| OT20 | The Convoy That Never Arrived | field | mz_garbage | food_bread (1 unit) |
| OT21 | Someone Kept Records | delivery | administrative_documents x2 | medic_bandage_1 (1 unit) |
| OT22 | A Voice on Tape | field | rp_waystation | 12gauge (1 unit) |
| OT23 | What He Was Carrying | tracker | 27 cumulative jobs | 22lr (1 unit) |
| OT24 | The Last Address | field | rp_pripyat_remaster | food_bread (1 unit) |
| OT25 | Past the Turn Back Point | delivery | field_maintenance x7 | medic_bandage_1 (1 unit) |
| OT26 | He Made It This Far | field | rp_pripyat_remaster | 12gauge (1 unit); +2 personal medic_bandage_1 capacity |
| OT27 | Bring Him Home | tracker | 35 cumulative jobs | 22lr (1 unit) |
| OT28 | Nothing Left Unsaid | field | rp_pripyat_remaster | food_bread (1 unit) |

All relocated item access is recorded in the [unlock ledger](unlock-ledger.md).
