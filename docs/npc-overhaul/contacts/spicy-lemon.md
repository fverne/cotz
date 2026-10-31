# Spicy Lemon: progression design

[Contact index](README.md) · [Design overview](../README.md) · [Progression rules](../progression-and-rewards.md)

**Review draft; no runtime implementation.** Read the contact index's shared authoring rules first.
Exact item quantities, job totals, coordinates, prices, and unresolved reward IDs are not assigned.

## Contact brief

- **Home and return point:** Marsh. Every hand-in and reward claim occurs here.
- **Identity:** Existing confident cook; retain his voice.
- **Model:** Preserve the installed template's model, skin, and presentation.
- **Only repeatable category:** Meal deliveries.
- **Finite plan:** 26 steps; **7 hand-ins, 6 job checkpoints, 13 authored objectives**.
- **Design labels:** SL01 onward, used only in these documents; final runtime IDs need a compatibility review.

## Chapter and dependency structure

This first draft is sequential within and between chapters. A later branch split must retain every
equipment-tier dependency. C1 onward are cumulative, contact-specific job checkpoints, not one-job
requirements or lifetime totals. Numerical thresholds and counting baselines require balancing.
Cross-contact upgrade gates are additional requirements on the same player character.

| Chapter | Design steps | Story direction |
| --- | --- | --- |
| 1 | SL01–SL04 | Kitchen equipment |
| 2 | SL05–SL10 | Dependable recipes |
| 3 | SL11–SL16 | Regional ingredients |
| 4 | SL17–SL22 | Expedition menus |
| 5 | SL23–SL26 | Communal feast |

## Objectives and small rewards

Rewards below supplement the ordinary finite progression payout where applicable. Purchase access
does not grant the item. A clue must identify a real authored destination. A capacity increase does
not fill shelves. Each generic equipment slot remains unassigned until its item and upgrade gates
pass the catalogue audit; it must not be implemented as a convenient arbitrary item.

### Chapter 1: Kitchen equipment

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| SL01 | Pots Before Plates | Hand-in | Deliver ordinary cookware and kitchen supplies. | First cooked-meal purchase. |
| SL02 | The Cold Kitchen | Authored | Recover the kitchen's missing recipe notebook in Marsh. | Basic cooking-fuel package. |
| SL03 | A Steady Table | Tracker | Cumulative checkpoint C1: establish reliable meal deliveries. | One common meal's stock increase. |
| SL04 | Spoor's Contribution | Authored | Recover a meat-handling ledger at a deserted hunting camp. | Meat preparation information. |

### Chapter 2: Dependable recipes

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| SL05 | Clean Enough | Hand-in | Deliver water and cleaning supplies for food preparation. | Water-and-food barter. |
| SL06 | The Spoiled Shipment | Authored | Retrieve shipment evidence from a Marsh supply cache. | Directions to an alternate food source. |
| SL07 | Same Dish Twice | Tracker | Cumulative checkpoint C2: demonstrate consistent meal deliveries. | Second meal purchase. |
| SL08 | The Missing Crate | Authored | Recover a cookware case along the Garbage route. | Cooking consumables. |
| SL09 | A Proper Pantry | Hand-in | Supply durable ingredients available before this step. | First preserved-food purchase. |
| SL10 | The Supplier's Ledger | Authored | Retrieve a supplier record in Garbage. | Ingredient-source information. |

### Chapter 3: Regional ingredients

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| SL11 | Feeding Travellers | Tracker | Cumulative checkpoint C3: maintain his expedition meal orders. | Second preserved-food purchase. |
| SL12 | Smoke Without Supper | Authored | Recover a cooking log from an abandoned camp. | Food-and-fuel package. |
| SL13 | Something With Flavour | Hand-in | Deliver existing spices and compatible cooking ingredients. | First drink sidegrade purchase. |
| SL14 | Jitters' Complaint | Authored | Recover clinic ration observations from a field shelter. | A balanced ration barter. |
| SL15 | The Lunch Rush | Tracker | Cumulative checkpoint C4: complete the next meal-delivery checkpoint. | One selected drink's stock increase. |
| SL16 | An Unfinished Menu | Authored | Recover a traveller's annotated menu in Waystation territory. | New expedition recipe lead. |

### Chapter 4: Expedition menus

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| SL17 | Food That Travels | Hand-in | Deliver durable meals and packaging supplies. | First expedition-meal purchase. |
| SL18 | The Long Walk | Authored | Collect a ration-test recorder along a regional route. | One existing meal as a sample. |
| SL19 | A Place at the Fire | Tracker | Cumulative checkpoint C5: sustain orders for regional expeditions. | Second expedition-meal purchase. |
| SL20 | The Last Cookfire | Authored | Recover a missing cook's journal from a remote camp. | A named dish's story and location clue. |
| SL21 | Enough for Everyone | Hand-in | Deliver ingredients for a finite communal meal. | Selected meal stock increase. |
| SL22 | The Cook's Detour | Authored | Recover the cook's personal case beyond the usual supply route. | Preparation supplies. |

### Chapter 5: Communal feast

| ID | Objective | Kind | Requirement or field action | Benefit |
| --- | --- | --- | --- | --- |
| SL23 | Reliable Hands | Tracker | Cumulative checkpoint C6: reach the final meal-delivery checkpoint. | A useful food supply package. |
| SL24 | The Recipe He Kept | Authored | Recover the journal's missing page from the cook's last cache. | Final meal purchase. |
| SL25 | The Feast | Hand-in | Deliver the final affordable feast ingredients. | Permanent feast-supply barter. |
| SL26 | Room at the Table | Authored | Recover the cook's keepsake and return for the meal's conclusion. | Recognition and a warmer greeting. |

## Upgrade gates and allocation

Strictly better rations require their lower-tier recipe milestone. Meals with different effects may be sidegrades. Clinical drugs from his current progression are redistribution candidates for Jitters or scientific contacts, not removed unlocks.

An unresolved lower-tier prerequisite is an implementation blocker for that reward, not permission
to leave it ungated. Preserve earned permissions through the migration ledger. Check alternate
authored shops, barters, and fixed rewards for shortcuts; do not restrict ordinary player trading
or reset existing characters as a side effect of this plan.

## Relationships and editable dialogue

Argues with Spoor about usable meat versus specimens and with Jitters about healthy food. Quietly makes sure Old Timer eats.

| Moment | Draft response |
| --- | --- |
| Greeting | You look hungry. Or you've brought me more work. Usually both. |
| About repeatable work | Cooked meals. That's what I need. Bring the dish I ask for and we both eat better. |
| Story conclusion | Enough to go around. Been a while since I could say that. |

These samples propose tone, not final dialogue. Preserve existing voice where applicable.
Author editable briefings, partial-progress replies, checkpoint announcements, locked responses,
completion lines, pending-claim messages, referrals, and before/after relationship topics.
A final greeting or recognition is personal unless an explicitly global event is designed.

## Implementation and availability notes

The feast concludes in Marsh. Ordinary food remains available before this line. Remote evidence retrieval does not imply a new cooking minigame.

- Sites and story evidence above are proposed map content, not asserted existing spawns.
- Use existing item/job primitives where suitable; finite story integration, evidence items, and
  multi-stage completion still need authoritative events and saved-state design.
- Prove every hand-in source and all required preparation are accessible before its unlock.
- No NPC, reward terminal, or hand-in service is placed in Pripyat. Travel there only after
  ordinary access is earned; return to this contact's home to conclude and claim.
- Keep task cargo character-bound and recoverable after inventory failure, restart, or transfer.
- Validate distinct field objectives rather than counting ordinary job completion twice.

## Current-source reference and unlock audit

- [Current progression source](../../../gamemodes/ix_cotz/plugins/progression/definitions/sh_spicylemonprog.lua).
- [Current conversation](../../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_cooknpc.lua).
- [Current templates and models](../../../gamemodes/ix_cotz/plugins/vendor_adv/libs/sh_npctemplates.lua).

Literal vendor item entries found in this source, retained here as an audit starting list:

`drug_mints`, `drug_caffeine`, `medic_psyheal_1`, `medic_antipsychotic_1`, `drug_painkillers`, `drug_adrenaline`, `drug_morphine`, `drink_canwater`, `drink_bottlebeer_6`, `food_nuts_2`, `food_cheese_2`, `food_can_tomato`, `food_can_tushonka`, `drink_energydrink_4`, `drink_energydrink_2`, `drink_vodka_4`, `drink_vodka_5`, `drink_vodka_6`, `drink_wine`, `drink_spirit_1`, `drink_spirit_2`, `drink_spirit_3`, `miscaid_swampbrew`.

This is not the complete effective catalogue or the old-to-new unlock ledger. Some old items move
to other contacts; all must retain reachable progression access somewhere. Capture other shared
definitions, dynamic rewards, stock benefits, and excluded-contact allocations in the full audit.
