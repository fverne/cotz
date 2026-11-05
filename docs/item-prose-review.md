# Item prose catalogue review

The November 2026 pass follows the [writing guide](writing-guide.md) and the
[four approved examples](writing-references/items.md#approved-cotz-item-drafts).
It covers all 1,216 concrete item files plus the generated playing-card and deck definitions.
Historical eligibility uses the fixed `origin/master` snapshot `1aa477d9` (22 October 2026);
preservation was checked against the actual pre-edit runtime sources at `0ed38b9e`, not by restoring master text.

## Outcome and checks

- Rewrote 595 eligible longdescs and applied the four approved newer regular descriptions.
- Preserved all 798 older regular descriptions and 621 substantive pre-cutoff longdescs exactly.
- Preserved both generated card/deck descriptions and longdescs; they already existed at the cutoff.
- Audited every item for changes outside the two prose fields: names, IDs, configuration, callbacks,
  saved-instance handling, dynamic descriptions and usage instructions are unchanged.
- Retained the four weapon ammunition/capacity footers exactly when replacing placeholder-origin prose.
- Confirmed each rewritten longdesc is one Lua string literal on one source line.
- Thirty-three mission-cargo variants intentionally share physical prose with their matching quest assets.
  Their models match; saved assignment names, descriptions and delivery instructions remain separate.
  No other rewritten longdescs are identical, and no complete sentence occurs in more than those pairs.

The compass required direct-path matching: its `compass` ID also appears in an inactive historical
artifact file. Its active inworldtasks definition had no longdesc at the cutoff and is eligible.
Other item identity matches use the historical IDs and paths; no runtime identifiers were renamed.

Verification completed from the repository root:

- `luatex --luaonly tests/item_descriptions_spec.lua`: 4,838 checks passed across 1,216 items.
- `luatex --luaonly tests/valuable_items_spec.lua`: 679 checks passed.
- `luatex --luaonly tests/disabled_town_items_spec.lua`: 13 checks passed.
- A pre-edit snapshot audit passed for protected text, prose-only changes, weapon footers and the
  intentionally shared asset descriptions. Local documentation links and anchors also resolved.
- `git diff --check` passed.

No running Garry's Mod or dedicated-server development session was available. Actual inventory and
world tooltip wrapping, generated card display and dynamic assignment presentation remain unverified
in multiplayer. The standalone description checks exercise the existing description methods with mocks.

## Protected text flagged for later review

These observations do not authorise edits to the protected fields:

- `value_currency_rubles_coins`: its name says rubles while the regular description identifies Ukrainian
  currency. The regular description remains unchanged; the new longdesc avoids choosing a denomination.
- `attachment_steelplate_3`: the name says galvanised while the regular description says nickel-plated.
  Both remain unchanged; the new longdesc describes the pale metallic finish without selecting a process.
- `value_powerbank`: the regular description describes charging electronics, while its valuable base
  provides no charging action. The established text remains unchanged; this pass adds no charging feature.

## Coverage checklist

Each checked row records a completed eligibility/preservation review. “Protected” means the original
source expression was retained exactly. “Retained” means an eligible regular description already
identified the object adequately. “Rewritten” identifies prose changed in this pass.

### aid

| Reviewed item / source | Regular description | Longdesc |
| --- | --- | --- |
| [x] [`drug_adrenaline`](../gamemodes/ix_cotz/schema/items/aid/sh_drug_adrenaline.lua) | protected | protected |
| [x] [`drug_caffeine`](../gamemodes/ix_cotz/schema/items/aid/sh_drug_caffeine.lua) | protected | protected |
| [x] [`drug_cigar`](../gamemodes/ix_cotz/schema/items/aid/sh_drug_cigar.lua) | protected | protected |
| [x] [`drug_cigarette_1`](../gamemodes/ix_cotz/schema/items/aid/sh_drug_cigarette_1.lua) | protected | protected |
| [x] [`drug_cigarette_2`](../gamemodes/ix_cotz/schema/items/aid/sh_drug_cigarette_2.lua) | protected | protected |
| [x] [`drug_cigarette_3`](../gamemodes/ix_cotz/schema/items/aid/sh_drug_cigarette_3.lua) | protected | protected |
| [x] [`drug_cigarette_4`](../gamemodes/ix_cotz/schema/items/aid/sh_drug_cigarette_4.lua) | protected | protected |
| [x] [`drug_cigarette_5`](../gamemodes/ix_cotz/schema/items/aid/sh_drug_cigarette_5.lua) | protected | protected |
| [x] [`drug_cigarette_6`](../gamemodes/ix_cotz/schema/items/aid/sh_drug_cigarette_6.lua) | protected | protected |
| [x] [`drug_cocaine`](../gamemodes/ix_cotz/schema/items/aid/sh_drug_cocaine.lua) | protected | protected |
| [x] [`drug_glucose`](../gamemodes/ix_cotz/schema/items/aid/sh_drug_glucose.lua) | protected | protected |
| [x] [`drug_marijuana`](../gamemodes/ix_cotz/schema/items/aid/sh_drug_marijuana.lua) | protected | protected |
| [x] [`drug_mints`](../gamemodes/ix_cotz/schema/items/aid/sh_drug_mints.lua) | protected | protected |
| [x] [`drug_morphine`](../gamemodes/ix_cotz/schema/items/aid/sh_drug_morphine.lua) | protected | protected |
| [x] [`drug_painkillers`](../gamemodes/ix_cotz/schema/items/aid/sh_drug_painkillers.lua) | protected | protected |
| [x] [`drug_tobacco_1`](../gamemodes/ix_cotz/schema/items/aid/sh_drug_tobacco_1.lua) | protected | protected |
| [x] [`drug_tobacco_2`](../gamemodes/ix_cotz/schema/items/aid/sh_drug_tobacco_2.lua) | protected | protected |
| [x] [`medic_antipsychotic_1`](../gamemodes/ix_cotz/schema/items/aid/sh_medic_antipsychotic_1.lua) | protected | protected |
| [x] [`medic_antipsychotic_2`](../gamemodes/ix_cotz/schema/items/aid/sh_medic_antipsychotic_2.lua) | protected | protected |
| [x] [`medic_antipsychotic_3`](../gamemodes/ix_cotz/schema/items/aid/sh_medic_antipsychotic_3.lua) | protected | protected |
| [x] [`medic_antirad_1`](../gamemodes/ix_cotz/schema/items/aid/sh_medic_antirad_1.lua) | protected | protected |
| [x] [`medic_antirad_2`](../gamemodes/ix_cotz/schema/items/aid/sh_medic_antirad_2.lua) | protected | protected |
| [x] [`medic_bandage_1`](../gamemodes/ix_cotz/schema/items/aid/sh_medic_bandage_1.lua) | protected | protected |
| [x] [`medic_bandage_2`](../gamemodes/ix_cotz/schema/items/aid/sh_medic_bandage_2.lua) | protected | protected |
| [x] [`medic_bandage_3`](../gamemodes/ix_cotz/schema/items/aid/sh_medic_bandage_3.lua) | protected | protected |
| [x] [`medic_medkit_1`](../gamemodes/ix_cotz/schema/items/aid/sh_medic_medkit_1.lua) | protected | protected |
| [x] [`medic_medkit_2`](../gamemodes/ix_cotz/schema/items/aid/sh_medic_medkit_2.lua) | protected | protected |
| [x] [`medic_medkit_3`](../gamemodes/ix_cotz/schema/items/aid/sh_medic_medkit_3.lua) | protected | protected |
| [x] [`medic_medkit_4`](../gamemodes/ix_cotz/schema/items/aid/sh_medic_medkit_4.lua) | protected | protected |
| [x] [`medic_medkit_5`](../gamemodes/ix_cotz/schema/items/aid/sh_medic_medkit_5.lua) | protected | protected |
| [x] [`medic_medkit_6`](../gamemodes/ix_cotz/schema/items/aid/sh_medic_medkit_6.lua) | protected | protected |
| [x] [`medic_psyheal_1`](../gamemodes/ix_cotz/schema/items/aid/sh_medic_psyheal_1.lua) | protected | protected |
| [x] [`medic_psyheal_2`](../gamemodes/ix_cotz/schema/items/aid/sh_medic_psyheal_2.lua) | protected | protected |
| [x] [`medic_stimpak_1`](../gamemodes/ix_cotz/schema/items/aid/sh_medic_stimpak_1.lua) | protected | protected |
| [x] [`medic_stimpak_2`](../gamemodes/ix_cotz/schema/items/aid/sh_medic_stimpak_2.lua) | protected | protected |
| [x] [`medic_stimpak_3`](../gamemodes/ix_cotz/schema/items/aid/sh_medic_stimpak_3.lua) | protected | protected |
| [x] [`miscaid_swampbrew`](../gamemodes/ix_cotz/schema/items/aid/sh_miscaid_swampbrew.lua) | protected | protected |

### artifacts

| Reviewed item / source | Regular description | Longdesc |
| --- | --- | --- |
| [x] [`artifact_arachno`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_arachno.lua) | protected | protected |
| [x] [`artifact_battery`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_battery.lua) | protected | protected |
| [x] [`artifact_blowncap`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_blowncap.lua) | protected | protected |
| [x] [`artifact_bolt`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_bolt.lua) | protected | protected |
| [x] [`artifact_bonecluster`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_bonecluster.lua) | protected | protected |
| [x] [`artifact_capacitor`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_capacitor.lua) | protected | protected |
| [x] [`artifact_cell`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_cell.lua) | protected | protected |
| [x] [`artifact_compass`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_compass.lua) | protected | protected |
| [x] [`artifact_crystal`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_crystal.lua) | protected | protected |
| [x] [`artifact_droplet`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_droplet.lua) | protected | protected |
| [x] [`artifact_dwarfgalaxy`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_dwarfgalaxy.lua) | protected | protected |
| [x] [`artifact_eye`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_eye.lua) | protected | protected |
| [x] [`artifact_flame`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_flame.lua) | protected | protected |
| [x] [`artifact_flash`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_flash.lua) | protected | protected |
| [x] [`artifact_gaia`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_gaia.lua) | protected | protected |
| [x] [`artifact_galaxy`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_galaxy.lua) | protected | protected |
| [x] [`artifact_gmamasbeads`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_gmamasbeads.lua) | protected | protected |
| [x] [`artifact_grapes`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_grapes.lua) | protected | protected |
| [x] [`artifact_halo`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_halo.lua) | protected | protected |
| [x] [`artifact_kolobok`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_kolobok.lua) | protected | protected |
| [x] [`artifact_mamasbeads`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_mamasbeads.lua) | protected | protected |
| [x] [`artifact_mementomori`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_mementomori.lua) | protected | protected |
| [x] [`artifact_mica`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_mica.lua) | protected | protected |
| [x] [`artifact_midas`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_midas.lua) | protected | protected |
| [x] [`artifact_moon`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_moon.lua) | protected | protected |
| [x] [`artifact_moonlight`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_moonlight.lua) | protected | protected |
| [x] [`artifact_mycelia`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_mycelia.lua) | protected | protected |
| [x] [`artifact_panacea`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_panacea.lua) | protected | protected |
| [x] [`artifact_photo`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_photo.lua) | protected | protected |
| [x] [`artifact_slime`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_slime.lua) | protected | protected |
| [x] [`artifact_slug`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_slug.lua) | protected | protected |
| [x] [`artifact_sparkler`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_sparkler.lua) | protected | protected |
| [x] [`artifact_storm`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_storm.lua) | protected | protected |
| [x] [`artifact_thorn`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_thorn.lua) | protected | protected |
| [x] [`artifact_urchin`](../gamemodes/ix_cotz/schema/items/artifacts/sh_artifact_urchin.lua) | protected | protected |

### attachments

| Reviewed item / source | Regular description | Longdesc |
| --- | --- | --- |
| [x] [`acog`](../gamemodes/ix_cotz/schema/items/attachments/sh_acog.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`aimpoint`](../gamemodes/ix_cotz/schema/items/attachments/sh_aimpoint.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`cmore`](../gamemodes/ix_cotz/schema/items/attachments/sh_cmore.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`cobrasuppressor`](../gamemodes/ix_cotz/schema/items/attachments/sh_cobrasuppressor.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`eotech`](../gamemodes/ix_cotz/schema/items/attachments/sh_eotech.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`foregrip`](../gamemodes/ix_cotz/schema/items/attachments/sh_foregrip.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kingarmsmr`](../gamemodes/ix_cotz/schema/items/attachments/sh_kingarmsmr.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kobra`](../gamemodes/ix_cotz/schema/items/attachments/sh_kobra.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`microt1`](../gamemodes/ix_cotz/schema/items/attachments/sh_microt1.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`nightforce`](../gamemodes/ix_cotz/schema/items/attachments/sh_nightforce.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`pbssuppressor`](../gamemodes/ix_cotz/schema/items/attachments/sh_pbssuppressor.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`pso1`](../gamemodes/ix_cotz/schema/items/attachments/sh_pso1.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`sakersuppressor`](../gamemodes/ix_cotz/schema/items/attachments/sh_sakersuppressor.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`shortdot`](../gamemodes/ix_cotz/schema/items/attachments/sh_shortdot.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`trijiconrmr`](../gamemodes/ix_cotz/schema/items/attachments/sh_trijiconrmr.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`tundrasuppressor`](../gamemodes/ix_cotz/schema/items/attachments/sh_tundrasuppressor.lua) | protected | rewritten — missing/placeholder at cutoff |

### cassette

| Reviewed item / source | Regular description | Longdesc |
| --- | --- | --- |
| [x] [`cassette_bandits`](../gamemodes/ix_cotz/plugins/cassette_player/items/cassette/sh_cassette_bandits.lua) | protected | protected |
| [x] [`cassette_barman`](../gamemodes/ix_cotz/plugins/cassette_player/items/cassette/sh_cassette_barman.lua) | protected | protected |
| [x] [`cassette_firelake`](../gamemodes/ix_cotz/plugins/cassette_player/items/cassette/sh_cassette_firelake.lua) | protected | protected |
| [x] [`cassette_freedom`](../gamemodes/ix_cotz/plugins/cassette_player/items/cassette/sh_cassette_freedom.lua) | protected | protected |
| [x] [`cassette_merc`](../gamemodes/ix_cotz/plugins/cassette_player/items/cassette/sh_cassette_merc.lua) | protected | protected |
| [x] [`cassette_standart`](../gamemodes/ix_cotz/plugins/cassette_player/items/cassette/sh_cassette_standart.lua) | protected | protected |
| [x] [`cassette_true`](../gamemodes/ix_cotz/plugins/cassette_player/items/cassette/sh_cassette_true.lua) | protected | protected |
| [x] [`cassette_wickedrabbit`](../gamemodes/ix_cotz/plugins/cassette_player/items/cassette/sh_cassette_wickedrabbit.lua) | protected | protected |

### consumables

| Reviewed item / source | Regular description | Longdesc |
| --- | --- | --- |
| [x] [`drink_bottlebeer_1`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_bottlebeer_1.lua) | protected | protected |
| [x] [`drink_bottlebeer_2`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_bottlebeer_2.lua) | protected | protected |
| [x] [`drink_bottlebeer_3`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_bottlebeer_3.lua) | protected | protected |
| [x] [`drink_bottlebeer_4`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_bottlebeer_4.lua) | protected | protected |
| [x] [`drink_bottlebeer_5`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_bottlebeer_5.lua) | protected | protected |
| [x] [`drink_bottlebeer_6`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_bottlebeer_6.lua) | protected | protected |
| [x] [`drink_bottletea`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_bottletea.lua) | protected | protected |
| [x] [`drink_bottlewater`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_bottlewater.lua) | protected | protected |
| [x] [`drink_bottlewaterdirty`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_bottlewaterdirty.lua) | protected | protected |
| [x] [`drink_canbeer_1`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_canbeer_1.lua) | protected | protected |
| [x] [`drink_canbeer_2`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_canbeer_2.lua) | protected | protected |
| [x] [`drink_canbeer_3`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_canbeer_3.lua) | protected | protected |
| [x] [`drink_canbeer_4`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_canbeer_4.lua) | protected | protected |
| [x] [`drink_canbeer_5`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_canbeer_5.lua) | protected | protected |
| [x] [`drink_canbeer_6`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_canbeer_6.lua) | protected | protected |
| [x] [`drink_canwater`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_canwater.lua) | protected | protected |
| [x] [`drink_energydrink_1`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_energydrink_1.lua) | protected | protected |
| [x] [`drink_energydrink_2`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_energydrink_2.lua) | protected | protected |
| [x] [`drink_energydrink_3`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_energydrink_3.lua) | protected | protected |
| [x] [`drink_energydrink_4`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_energydrink_4.lua) | protected | protected |
| [x] [`drink_energydrink_5`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_energydrink_5.lua) | protected | protected |
| [x] [`drink_energydrink_6`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_energydrink_6.lua) | protected | protected |
| [x] [`drink_milk`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_milk.lua) | protected | protected |
| [x] [`drink_milkold`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_milkold.lua) | protected | protected |
| [x] [`drink_moonshine`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_moonshine.lua) | protected | protected |
| [x] [`drink_orangejuice`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_orangejuice.lua) | protected | protected |
| [x] [`drink_spirit_1`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_spirit_1.lua) | protected | protected |
| [x] [`drink_spirit_2`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_spirit_2.lua) | protected | protected |
| [x] [`drink_spirit_3`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_spirit_3.lua) | protected | protected |
| [x] [`drink_vodka_1`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_vodka_1.lua) | protected | protected |
| [x] [`drink_vodka_2`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_vodka_2.lua) | protected | protected |
| [x] [`drink_vodka_3`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_vodka_3.lua) | protected | protected |
| [x] [`drink_vodka_4`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_vodka_4.lua) | protected | protected |
| [x] [`drink_vodka_5`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_vodka_5.lua) | protected | protected |
| [x] [`drink_vodka_6`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_vodka_6.lua) | protected | protected |
| [x] [`drink_wine`](../gamemodes/ix_cotz/schema/items/consumables/sh_drink_wine.lua) | protected | protected |
| [x] [`food_bread`](../gamemodes/ix_cotz/schema/items/consumables/sh_food_bread.lua) | protected | protected |
| [x] [`food_burger`](../gamemodes/ix_cotz/schema/items/consumables/sh_food_burger.lua) | protected | protected |
| [x] [`food_can_beans`](../gamemodes/ix_cotz/schema/items/consumables/sh_food_can_beans.lua) | protected | protected |
| [x] [`food_can_chilibeans`](../gamemodes/ix_cotz/schema/items/consumables/sh_food_can_chilibeans.lua) | protected | protected |
| [x] [`food_can_corn`](../gamemodes/ix_cotz/schema/items/consumables/sh_food_can_corn.lua) | protected | protected |
| [x] [`food_can_olive`](../gamemodes/ix_cotz/schema/items/consumables/sh_food_can_olive.lua) | protected | protected |
| [x] [`food_can_sprats`](../gamemodes/ix_cotz/schema/items/consumables/sh_food_can_sprats.lua) | protected | protected |
| [x] [`food_can_tomato`](../gamemodes/ix_cotz/schema/items/consumables/sh_food_can_tomato.lua) | protected | protected |
| [x] [`food_can_tuna`](../gamemodes/ix_cotz/schema/items/consumables/sh_food_can_tuna.lua) | protected | protected |
| [x] [`food_can_tushonka`](../gamemodes/ix_cotz/schema/items/consumables/sh_food_can_tushonka.lua) | protected | protected |
| [x] [`food_cheese_1`](../gamemodes/ix_cotz/schema/items/consumables/sh_food_cheese_1.lua) | protected | protected |
| [x] [`food_cheese_2`](../gamemodes/ix_cotz/schema/items/consumables/sh_food_cheese_2.lua) | protected | protected |
| [x] [`food_cheese_3`](../gamemodes/ix_cotz/schema/items/consumables/sh_food_cheese_3.lua) | protected | protected |
| [x] [`food_chocolate`](../gamemodes/ix_cotz/schema/items/consumables/sh_food_chocolate.lua) | protected | protected |
| [x] [`food_mre_russia`](../gamemodes/ix_cotz/schema/items/consumables/sh_food_mre_russia.lua) | protected | protected |
| [x] [`food_mre_ukraine`](../gamemodes/ix_cotz/schema/items/consumables/sh_food_mre_ukraine.lua) | protected | protected |
| [x] [`food_mre_usa`](../gamemodes/ix_cotz/schema/items/consumables/sh_food_mre_usa.lua) | protected | protected |
| [x] [`food_nuts_1`](../gamemodes/ix_cotz/schema/items/consumables/sh_food_nuts_1.lua) | protected | protected |
| [x] [`food_nuts_2`](../gamemodes/ix_cotz/schema/items/consumables/sh_food_nuts_2.lua) | protected | protected |
| [x] [`food_oldmeat`](../gamemodes/ix_cotz/schema/items/consumables/sh_food_oldmeat.lua) | protected | protected |
| [x] [`food_raisins`](../gamemodes/ix_cotz/schema/items/consumables/sh_food_raisins.lua) | protected | protected |
| [x] [`food_sausage_1`](../gamemodes/ix_cotz/schema/items/consumables/sh_food_sausage_1.lua) | protected | protected |
| [x] [`food_sausage_2`](../gamemodes/ix_cotz/schema/items/consumables/sh_food_sausage_2.lua) | protected | protected |

### cookable

| Reviewed item / source | Regular description | Longdesc |
| --- | --- | --- |
| [x] [`meat_bear`](../gamemodes/ix_cotz/schema/items/cookable/sh_meat_bear.lua) | protected | protected |
| [x] [`meat_blinddog`](../gamemodes/ix_cotz/schema/items/cookable/sh_meat_blinddog.lua) | protected | protected |
| [x] [`meat_bloodsucker`](../gamemodes/ix_cotz/schema/items/cookable/sh_meat_bloodsucker.lua) | protected | protected |
| [x] [`meat_boar`](../gamemodes/ix_cotz/schema/items/cookable/sh_meat_boar.lua) | protected | protected |
| [x] [`meat_burer`](../gamemodes/ix_cotz/schema/items/cookable/sh_meat_burer.lua) | protected | protected |
| [x] [`meat_cat`](../gamemodes/ix_cotz/schema/items/cookable/sh_meat_cat.lua) | protected | protected |
| [x] [`meat_chimera`](../gamemodes/ix_cotz/schema/items/cookable/sh_meat_chimera.lua) | protected | protected |
| [x] [`meat_controller`](../gamemodes/ix_cotz/schema/items/cookable/sh_meat_controller.lua) | protected | protected |
| [x] [`meat_flesh`](../gamemodes/ix_cotz/schema/items/cookable/sh_meat_flesh.lua) | protected | protected |
| [x] [`meat_hellhound`](../gamemodes/ix_cotz/schema/items/cookable/sh_meat_hellhound.lua) | protected | protected |
| [x] [`meat_human`](../gamemodes/ix_cotz/schema/items/cookable/sh_meat_human.lua) | protected | protected |
| [x] [`meat_karlik`](../gamemodes/ix_cotz/schema/items/cookable/sh_meat_karlik.lua) | protected | protected |
| [x] [`meat_pseudodog`](../gamemodes/ix_cotz/schema/items/cookable/sh_meat_pseudodog.lua) | protected | protected |
| [x] [`meat_pseudogiant`](../gamemodes/ix_cotz/schema/items/cookable/sh_meat_pseudogiant.lua) | protected | protected |
| [x] [`meat_snork`](../gamemodes/ix_cotz/schema/items/cookable/sh_meat_snork.lua) | protected | protected |
| [x] [`meat_spider`](../gamemodes/ix_cotz/schema/items/cookable/sh_meat_spider.lua) | protected | protected |
| [x] [`meat_sprig`](../gamemodes/ix_cotz/schema/items/cookable/sh_meat_sprig.lua) | protected | protected |
| [x] [`meat_tark`](../gamemodes/ix_cotz/schema/items/cookable/sh_meat_tark.lua) | protected | protected |
| [x] [`meat_tushkano`](../gamemodes/ix_cotz/schema/items/cookable/sh_meat_tushkano.lua) | protected | protected |
| [x] [`meat_vareshka`](../gamemodes/ix_cotz/schema/items/cookable/sh_meat_vareshka.lua) | protected | protected |

### cooked

| Reviewed item / source | Regular description | Longdesc |
| --- | --- | --- |
| [x] [`meal_bear`](../gamemodes/ix_cotz/schema/items/cooked/sh_meal_bear.lua) | protected | protected |
| [x] [`meal_blinddog`](../gamemodes/ix_cotz/schema/items/cooked/sh_meal_blinddog.lua) | protected | protected |
| [x] [`meal_bloodsucker`](../gamemodes/ix_cotz/schema/items/cooked/sh_meal_bloodsucker.lua) | protected | protected |
| [x] [`meal_boar`](../gamemodes/ix_cotz/schema/items/cooked/sh_meal_boar.lua) | protected | protected |
| [x] [`meal_burer`](../gamemodes/ix_cotz/schema/items/cooked/sh_meal_burer.lua) | protected | protected |
| [x] [`meal_cat`](../gamemodes/ix_cotz/schema/items/cooked/sh_meal_cat.lua) | protected | protected |
| [x] [`meal_chimera`](../gamemodes/ix_cotz/schema/items/cooked/sh_meal_chimera.lua) | protected | protected |
| [x] [`meal_controller`](../gamemodes/ix_cotz/schema/items/cooked/sh_meal_controller.lua) | protected | protected |
| [x] [`meal_flesh`](../gamemodes/ix_cotz/schema/items/cooked/sh_meal_flesh.lua) | protected | protected |
| [x] [`meal_hellhound`](../gamemodes/ix_cotz/schema/items/cooked/sh_meal_hellhound.lua) | protected | protected |
| [x] [`meal_human`](../gamemodes/ix_cotz/schema/items/cooked/sh_meal_human.lua) | protected | protected |
| [x] [`meal_karlik`](../gamemodes/ix_cotz/schema/items/cooked/sh_meal_karlik.lua) | protected | protected |
| [x] [`meal_pseudodog`](../gamemodes/ix_cotz/schema/items/cooked/sh_meal_pseudodog.lua) | protected | protected |
| [x] [`meal_pseudogiant`](../gamemodes/ix_cotz/schema/items/cooked/sh_meal_pseudogiant.lua) | protected | protected |
| [x] [`meal_snork`](../gamemodes/ix_cotz/schema/items/cooked/sh_meal_snork.lua) | protected | protected |
| [x] [`meal_spider`](../gamemodes/ix_cotz/schema/items/cooked/sh_meal_spider.lua) | protected | protected |
| [x] [`meal_sprig`](../gamemodes/ix_cotz/schema/items/cooked/sh_meal_sprig.lua) | protected | protected |
| [x] [`meal_tark`](../gamemodes/ix_cotz/schema/items/cooked/sh_meal_tark.lua) | protected | protected |
| [x] [`meal_tushkano`](../gamemodes/ix_cotz/schema/items/cooked/sh_meal_tushkano.lua) | protected | protected |
| [x] [`meal_vareshka`](../gamemodes/ix_cotz/schema/items/cooked/sh_meal_vareshka.lua) | protected | protected |

### gear

| Reviewed item / source | Regular description | Longdesc |
| --- | --- | --- |
| [x] [`headwear_altyn`](../gamemodes/ix_cotz/schema/items/gear/sh_headwear_altyn.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`headwear_cs1`](../gamemodes/ix_cotz/schema/items/gear/sh_headwear_cs1.lua) | protected | protected |
| [x] [`headwear_cs2`](../gamemodes/ix_cotz/schema/items/gear/sh_headwear_cs2.lua) | protected | protected |
| [x] [`headwear_cs4`](../gamemodes/ix_cotz/schema/items/gear/sh_headwear_cs4.lua) | protected | protected |
| [x] [`headwear_pracs`](../gamemodes/ix_cotz/schema/items/gear/sh_headwear_pracs.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`headwear_psz12`](../gamemodes/ix_cotz/schema/items/gear/sh_headwear_psz12.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`headwear_rad`](../gamemodes/ix_cotz/schema/items/gear/sh_headwear_rad.lua) | protected | protected |
| [x] [`headwear_riot`](../gamemodes/ix_cotz/schema/items/gear/sh_headwear_riot.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`headwear_screen`](../gamemodes/ix_cotz/schema/items/gear/sh_headwear_screen.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`headwear_screen_anarchist`](../gamemodes/ix_cotz/schema/items/gear/sh_headwear_screen_anarchist.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`headwear_screen_authority`](../gamemodes/ix_cotz/schema/items/gear/sh_headwear_screen_authority.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`headwear_screen_ecologist`](../gamemodes/ix_cotz/schema/items/gear/sh_headwear_screen_ecologist.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`headwear_screen_scavenger`](../gamemodes/ix_cotz/schema/items/gear/sh_headwear_screen_scavenger.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`headwear_spartan`](../gamemodes/ix_cotz/schema/items/gear/sh_headwear_spartan.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`helm_operator_nato`](../gamemodes/ix_cotz/schema/items/gear/sh_helm_operator_nato.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`helm_operator_rus_1`](../gamemodes/ix_cotz/schema/items/gear/sh_helm_operator_rus_1.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`helm_operator_rus_2`](../gamemodes/ix_cotz/schema/items/gear/sh_helm_operator_rus_2.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`helm_sphere08`](../gamemodes/ix_cotz/schema/items/gear/sh_helm_sphere08.lua) | protected | protected |
| [x] [`helm_sphere12`](../gamemodes/ix_cotz/schema/items/gear/sh_helm_sphere12.lua) | protected | protected |
| [x] [`helm_steel_arab`](../gamemodes/ix_cotz/schema/items/gear/sh_helm_steel_arab.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`helm_steel_ger`](../gamemodes/ix_cotz/schema/items/gear/sh_helm_steel_ger.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`helm_steel_rus`](../gamemodes/ix_cotz/schema/items/gear/sh_helm_steel_rus.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`helm_tanker`](../gamemodes/ix_cotz/schema/items/gear/sh_helm_tanker.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`mask_cloth`](../gamemodes/ix_cotz/schema/items/gear/sh_mask_cloth.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`mask_eo20`](../gamemodes/ix_cotz/schema/items/gear/sh_mask_eo20.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`mask_gp5`](../gamemodes/ix_cotz/schema/items/gear/sh_mask_gp5.lua) | protected | protected |
| [x] [`mask_halfmask`](../gamemodes/ix_cotz/schema/items/gear/sh_mask_halfmask.lua) | protected | protected |
| [x] [`mask_m40`](../gamemodes/ix_cotz/schema/items/gear/sh_mask_m40.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`mask_m50`](../gamemodes/ix_cotz/schema/items/gear/sh_mask_m50.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`mask_pmk3`](../gamemodes/ix_cotz/schema/items/gear/sh_mask_pmk3.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`mask_respirator`](../gamemodes/ix_cotz/schema/items/gear/sh_mask_respirator.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`mask_xm40`](../gamemodes/ix_cotz/schema/items/gear/sh_mask_xm40.lua) | protected | protected |

### hidestashers

| Reviewed item / source | Regular description | Longdesc |
| --- | --- | --- |
| [x] [`hidestasher_cleaningkit`](../gamemodes/ix_cotz/schema/items/hidestashers/sh_hidestasher_cleaningkit.lua) | protected | protected |
| [x] [`hidestasher_cutlery`](../gamemodes/ix_cotz/schema/items/hidestashers/sh_hidestasher_cutlery.lua) | protected | protected |
| [x] [`hidestasher_shovel`](../gamemodes/ix_cotz/schema/items/hidestashers/sh_hidestasher_shovel.lua) | protected | protected |

### items

| Reviewed item / source | Regular description | Longdesc |
| --- | --- | --- |
| [x] [`accesscard_bunker`](../gamemodes/ix_cotz/plugins/accesscards/items/sh_accesscard_bunker.lua) | protected | protected |
| [x] [`accesscard_laboratory`](../gamemodes/ix_cotz/plugins/accesscards/items/sh_accesscard_laboratory.lua) | protected | protected |
| [x] [`walkman`](../gamemodes/ix_cotz/plugins/cassette_player/items/sh_walkman.lua) | protected | protected |
| [x] [`headlamp`](../gamemodes/ix_cotz/plugins/flashlightitem/items/sh_headlamp.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`revivesyringe`](../gamemodes/ix_cotz/plugins/revive/items/sh_revivesyringe.lua) | protected | rewritten — missing/placeholder at cutoff |

### jobcargo

| Reviewed item / source | Regular description | Longdesc |
| --- | --- | --- |
| [x] [`job_dead_drop_parcel`](../gamemodes/ix_cotz/plugins/jobsystem/items/jobcargo/sh_job_dead_drop_parcel.lua) | retained | rewritten — new item |
| [x] [`job_recovery_case`](../gamemodes/ix_cotz/plugins/jobsystem/items/jobcargo/sh_job_recovery_case.lua) | retained | rewritten — new item |
| [x] [`job_research_results`](../gamemodes/ix_cotz/plugins/jobsystem/items/jobcargo/sh_job_research_results.lua) | retained | rewritten — new item |
| [x] [`job_sensor_recorder`](../gamemodes/ix_cotz/plugins/jobsystem/items/jobcargo/sh_job_sensor_recorder.lua) | retained | rewritten — new item |
| [x] [`job_signal_transmitter`](../gamemodes/ix_cotz/plugins/jobsystem/items/jobcargo/sh_job_signal_transmitter.lua) | retained | rewritten — new item |
| [x] [`town_quest_archive`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_archive.lua) | retained | rewritten — new item |
| [x] [`town_quest_armour`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_armour.lua) | retained | rewritten — new item |
| [x] [`town_quest_case`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_case.lua) | retained | rewritten — new item |
| [x] [`town_quest_clinic`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_clinic.lua) | retained | rewritten — new item |
| [x] [`town_quest_clinic2`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_clinic2.lua) | retained | rewritten — new item |
| [x] [`town_quest_contract`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_contract.lua) | retained | rewritten — new item |
| [x] [`town_quest_control`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_control.lua) | retained | rewritten — new item |
| [x] [`town_quest_diary`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_diary.lua) | retained | rewritten — new item |
| [x] [`town_quest_disc`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_disc.lua) | retained | rewritten — new item |
| [x] [`town_quest_dossier`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_dossier.lua) | retained | rewritten — new item |
| [x] [`town_quest_drive`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_drive.lua) | retained | rewritten — new item |
| [x] [`town_quest_equipment`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_equipment.lua) | retained | rewritten — new item |
| [x] [`town_quest_evidence`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_evidence.lua) | retained | rewritten — new item |
| [x] [`town_quest_intel`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_intel.lua) | retained | rewritten — new item |
| [x] [`town_quest_lab`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_lab.lua) | retained | rewritten — new item |
| [x] [`town_quest_manifest`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_manifest.lua) | retained | rewritten — new item |
| [x] [`town_quest_medical`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_medical.lua) | retained | rewritten — new item |
| [x] [`town_quest_military`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_military.lua) | retained | rewritten — new item |
| [x] [`town_quest_module`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_module.lua) | retained | rewritten — new item |
| [x] [`town_quest_module2`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_module2.lua) | retained | rewritten — new item |
| [x] [`town_quest_notebook`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_notebook.lua) | retained | rewritten — new item |
| [x] [`town_quest_official`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_official.lua) | retained | rewritten — new item |
| [x] [`town_quest_orders`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_orders.lua) | retained | rewritten — new item |
| [x] [`town_quest_personnel`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_personnel.lua) | retained | rewritten — new item |
| [x] [`town_quest_photo`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_photo.lua) | retained | rewritten — new item |
| [x] [`town_quest_receipt`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_receipt.lua) | retained | rewritten — new item |
| [x] [`town_quest_research`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_research.lua) | retained | rewritten — new item |
| [x] [`town_quest_security`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_security.lua) | retained | rewritten — new item |
| [x] [`town_quest_tape`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_tape.lua) | retained | rewritten — new item |
| [x] [`town_quest_tape2`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_tape2.lua) | retained | rewritten — new item |
| [x] [`town_quest_tools`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_tools.lua) | retained | rewritten — new item |
| [x] [`town_quest_tube`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_tube.lua) | retained | rewritten — new item |
| [x] [`town_quest_worncase`](../gamemodes/ix_cotz/plugins/townnpcs/items/jobcargo/sh_town_quest_worncase.lua) | retained | rewritten — new item |

### kits

| Reviewed item / source | Regular description | Longdesc |
| --- | --- | --- |
| [x] [`kit_aid_high`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_aid_high.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_aid_large`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_aid_large.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_aid_low`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_aid_low.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_ammo_high`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_ammo_high.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_ammo_low`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_ammo_low.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_ammo_m_low`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_ammo_m_low.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_ammo_m_rare`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_ammo_m_rare.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_ammo_med`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_ammo_med.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_ammo_rare`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_ammo_rare.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_hidestash_1`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_hidestash_1.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_hidestash_2`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_hidestash_2.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_hidestash_3`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_hidestash_3.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_hidestash_4`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_hidestash_4.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_medical_car`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_medical_car.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_medical_defib`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_medical_defib.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_medical_grizzly`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_medical_grizzly.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_medical_ifak`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_medical_ifak.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_medical_salewa`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_medical_salewa.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_mixed_high`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_mixed_high.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_mixed_low`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_mixed_low.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_mixed_m_low`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_mixed_m_low.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_mixed_med`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_mixed_med.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_newchar`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_newchar.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_ammo_tier01`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_ammo_tier01.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_ammo_tier02`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_ammo_tier02.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_ammo_tier03`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_ammo_tier03.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_ammo_tier04`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_ammo_tier04.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_medical_tier01`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_medical_tier01.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_medical_tier02`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_medical_tier02.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_medical_tier03`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_medical_tier03.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_medical_tier04`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_medical_tier04.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_tier00_large`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_tier00_large.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_tier00_small`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_tier00_small.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_tier01_large`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_tier01_large.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_tier01_small`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_tier01_small.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_tier02_large`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_tier02_large.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_tier02_small`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_tier02_small.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_tier03_large`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_tier03_large.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_tier03_small`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_tier03_small.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_tier04_large`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_tier04_large.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_tier04_small`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_tier04_small.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_tier05_large`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_tier05_large.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_tier05_small`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_tier05_small.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_tier06_large`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_tier06_large.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_tier06_small`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_tier06_small.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_tier07_large`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_tier07_large.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_tier07_small`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_tier07_small.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_tier08_large`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_tier08_large.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_tier08_small`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_tier08_small.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_weapon_tier00`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_weapon_tier00.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_weapon_tier01`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_weapon_tier01.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_weapon_tier02`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_weapon_tier02.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_weapon_tier03`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_weapon_tier03.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_weapon_tier04`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_weapon_tier04.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_weapon_tier05`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_weapon_tier05.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_weapon_tier06`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_weapon_tier06.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_weapon_tier07`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_weapon_tier07.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_reward_weapon_tier08`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_reward_weapon_tier08.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`kit_wallet`](../gamemodes/ix_cotz/schema/items/kits/sh_kit_wallet.lua) | protected | rewritten — missing/placeholder at cutoff |

### miscellaneous

| Reviewed item / source | Regular description | Longdesc |
| --- | --- | --- |
| [x] [`anomalydetector`](../gamemodes/ix_cotz/plugins/anomalydetector/items/miscellaneous/sh_anomalydetector.lua) | protected | protected |
| [x] [`hidestash_1`](../gamemodes/ix_cotz/plugins/hidestashspawner/items/miscellaneous/sh_hidestash_1.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`hidestash_2`](../gamemodes/ix_cotz/plugins/hidestashspawner/items/miscellaneous/sh_hidestash_2.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`hidestash_3`](../gamemodes/ix_cotz/plugins/hidestashspawner/items/miscellaneous/sh_hidestash_3.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`compass`](../gamemodes/ix_cotz/plugins/inworldtasks/items/miscellaneous/sh_compass.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`dataextractor`](../gamemodes/ix_cotz/plugins/inworldtasks/items/miscellaneous/sh_dataextractor.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`gasanalyzer`](../gamemodes/ix_cotz/plugins/inworldtasks/items/miscellaneous/sh_gasanalyzer.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`gpstracker`](../gamemodes/ix_cotz/plugins/inworldtasks/items/miscellaneous/sh_gpstracker.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`rfreceiver`](../gamemodes/ix_cotz/plugins/inworldtasks/items/miscellaneous/sh_rfreceiver.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`stashpackage`](../gamemodes/ix_cotz/plugins/inworldtasks/items/miscellaneous/sh_stashpackage.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`stashpackage_heavy`](../gamemodes/ix_cotz/plugins/inworldtasks/items/miscellaneous/sh_stashpackage_heavy.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`stashpackage_veryheavy`](../gamemodes/ix_cotz/plugins/inworldtasks/items/miscellaneous/sh_stashpackage_veryheavy.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`geigercounter`](../gamemodes/ix_cotz/plugins/radiation/items/miscellaneous/sh_geigercounter.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`bagrubles`](../gamemodes/ix_cotz/schema/items/miscellaneous/sh_bagrubles.lua) | protected | protected |
| [x] [`diecup`](../gamemodes/ix_cotz/schema/items/miscellaneous/sh_diecup.lua) | protected | protected |
| [x] [`harmonica`](../gamemodes/ix_cotz/schema/items/miscellaneous/sh_harmonica.lua) | protected | protected |
| [x] [`hightiercooker`](../gamemodes/ix_cotz/schema/items/miscellaneous/sh_hightiercooker.lua) | protected | protected |
| [x] [`identitycard`](../gamemodes/ix_cotz/schema/items/miscellaneous/sh_identitycard.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`lowtiercooker`](../gamemodes/ix_cotz/schema/items/miscellaneous/sh_lowtiercooker.lua) | protected | protected |
| [x] [`lowtiercookerfuel`](../gamemodes/ix_cotz/schema/items/miscellaneous/sh_lowtiercookerfuel.lua) | protected | protected |
| [x] [`quest_computeraccess`](../gamemodes/ix_cotz/schema/items/miscellaneous/sh_quest_computeraccess.lua) | protected | protected |
| [x] [`quest_flashdrive`](../gamemodes/ix_cotz/schema/items/miscellaneous/sh_quest_flashdrive.lua) | protected | protected |
| [x] [`sattelitephone`](../gamemodes/ix_cotz/schema/items/miscellaneous/sh_sattelitephone.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`waterflask`](../gamemodes/ix_cotz/schema/items/miscellaneous/sh_waterflask.lua) | protected | protected |

### miscweapons

| Reviewed item / source | Regular description | Longdesc |
| --- | --- | --- |
| [x] [`binoculars_1`](../gamemodes/ix_cotz/plugins/binoculars/items/miscweapons/sh_binoculars_1.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`binoculars_2`](../gamemodes/ix_cotz/plugins/binoculars/items/miscweapons/sh_binoculars_2.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`binoculars_3`](../gamemodes/ix_cotz/plugins/binoculars/items/miscweapons/sh_binoculars_3.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`binoculars_4`](../gamemodes/ix_cotz/plugins/binoculars/items/miscweapons/sh_binoculars_4.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`binoculars_5`](../gamemodes/ix_cotz/plugins/binoculars/items/miscweapons/sh_binoculars_5.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`flashlight`](../gamemodes/ix_cotz/plugins/flashlightitem/items/miscweapons/sh_flashlight.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`bat`](../gamemodes/ix_cotz/schema/items/miscweapons/sh_bat.lua) | protected | protected |
| [x] [`crowbar`](../gamemodes/ix_cotz/schema/items/miscweapons/sh_crowbar.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`detectorbear`](../gamemodes/ix_cotz/schema/items/miscweapons/sh_detectorbear.lua) | protected | protected |
| [x] [`detectorecho`](../gamemodes/ix_cotz/schema/items/miscweapons/sh_detectorecho.lua) | protected | protected |
| [x] [`detectorveles`](../gamemodes/ix_cotz/schema/items/miscweapons/sh_detectorveles.lua) | protected | protected |
| [x] [`fireaxe`](../gamemodes/ix_cotz/schema/items/miscweapons/sh_fireaxe.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`fubar`](../gamemodes/ix_cotz/schema/items/miscweapons/sh_fubar.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`guitar`](../gamemodes/ix_cotz/schema/items/miscweapons/sh_guitar.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`hatchet`](../gamemodes/ix_cotz/schema/items/miscweapons/sh_hatchet.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`knife1`](../gamemodes/ix_cotz/schema/items/miscweapons/sh_knife1.lua) | protected | protected |
| [x] [`knife2`](../gamemodes/ix_cotz/schema/items/miscweapons/sh_knife2.lua) | protected | protected |
| [x] [`knife3`](../gamemodes/ix_cotz/schema/items/miscweapons/sh_knife3.lua) | protected | protected |
| [x] [`knife4`](../gamemodes/ix_cotz/schema/items/miscweapons/sh_knife4.lua) | protected | protected |
| [x] [`leadpipe`](../gamemodes/ix_cotz/schema/items/miscweapons/sh_leadpipe.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`machete`](../gamemodes/ix_cotz/schema/items/miscweapons/sh_machete.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`sledgehammer`](../gamemodes/ix_cotz/schema/items/miscweapons/sh_sledgehammer.lua) | protected | rewritten — missing/placeholder at cutoff |

### mutantparts

| Reviewed item / source | Regular description | Longdesc |
| --- | --- | --- |
| [x] [`part_bear`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_bear.lua) | protected | protected |
| [x] [`part_blinddog`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_blinddog.lua) | protected | protected |
| [x] [`part_bloodsucker`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_bloodsucker.lua) | protected | protected |
| [x] [`part_boar`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_boar.lua) | protected | protected |
| [x] [`part_burer_1`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_burer_1.lua) | protected | protected |
| [x] [`part_burer_2`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_burer_2.lua) | protected | protected |
| [x] [`part_cat`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_cat.lua) | protected | protected |
| [x] [`part_chimera`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_chimera.lua) | protected | protected |
| [x] [`part_controller_1`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_controller_1.lua) | protected | protected |
| [x] [`part_controller_2`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_controller_2.lua) | protected | protected |
| [x] [`part_electrocontroller_1`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_electrocontroller_1.lua) | protected | protected |
| [x] [`part_electrocontroller_2`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_electrocontroller_2.lua) | protected | protected |
| [x] [`part_flesh`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_flesh.lua) | protected | protected |
| [x] [`part_hellhound`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_hellhound.lua) | protected | protected |
| [x] [`part_izlom`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_izlom.lua) | protected | protected |
| [x] [`part_karlik_1`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_karlik_1.lua) | protected | protected |
| [x] [`part_karlik_2`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_karlik_2.lua) | protected | protected |
| [x] [`part_pseudodog`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_pseudodog.lua) | protected | protected |
| [x] [`part_pseudogiant`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_pseudogiant.lua) | protected | protected |
| [x] [`part_psydog`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_psydog.lua) | protected | protected |
| [x] [`part_skeleton`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_skeleton.lua) | protected | protected |
| [x] [`part_snork_1`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_snork_1.lua) | protected | protected |
| [x] [`part_snork_2`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_snork_2.lua) | protected | protected |
| [x] [`part_spider`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_spider.lua) | protected | protected |
| [x] [`part_sprig`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_sprig.lua) | protected | protected |
| [x] [`part_swampcontroller_1`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_swampcontroller_1.lua) | protected | protected |
| [x] [`part_swampcontroller_2`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_swampcontroller_2.lua) | protected | protected |
| [x] [`part_tark`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_tark.lua) | protected | protected |
| [x] [`part_tushkano`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_tushkano.lua) | protected | protected |
| [x] [`part_vareshka`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_vareshka.lua) | protected | protected |
| [x] [`part_zombie_1`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_zombie_1.lua) | protected | protected |
| [x] [`part_zombie_2`](../gamemodes/ix_cotz/schema/items/mutantparts/sh_part_zombie_2.lua) | protected | protected |

### newammo

| Reviewed item / source | Regular description | Longdesc |
| --- | --- | --- |
| [x] [`127x55`](../gamemodes/ix_cotz/schema/items/newammo/sh_127x55.lua) | protected | protected |
| [x] [`12gauge`](../gamemodes/ix_cotz/schema/items/newammo/sh_12gauge.lua) | protected | protected |
| [x] [`12gaugedt`](../gamemodes/ix_cotz/schema/items/newammo/sh_12gaugedt.lua) | protected | protected |
| [x] [`12gaugemg`](../gamemodes/ix_cotz/schema/items/newammo/sh_12gaugemg.lua) | protected | protected |
| [x] [`12gaugesg`](../gamemodes/ix_cotz/schema/items/newammo/sh_12gaugesg.lua) | protected | protected |
| [x] [`12gaugetr`](../gamemodes/ix_cotz/schema/items/newammo/sh_12gaugetr.lua) | protected | protected |
| [x] [`145x114`](../gamemodes/ix_cotz/schema/items/newammo/sh_145x114.lua) | protected | protected |
| [x] [`145x114ap`](../gamemodes/ix_cotz/schema/items/newammo/sh_145x114ap.lua) | protected | protected |
| [x] [`145x114hp`](../gamemodes/ix_cotz/schema/items/newammo/sh_145x114hp.lua) | protected | protected |
| [x] [`22lr`](../gamemodes/ix_cotz/schema/items/newammo/sh_22lr.lua) | protected | protected |
| [x] [`22lrap`](../gamemodes/ix_cotz/schema/items/newammo/sh_22lrap.lua) | protected | protected |
| [x] [`22lrhp`](../gamemodes/ix_cotz/schema/items/newammo/sh_22lrhp.lua) | protected | protected |
| [x] [`338lapua`](../gamemodes/ix_cotz/schema/items/newammo/sh_338lapua.lua) | protected | protected |
| [x] [`338lapuaap`](../gamemodes/ix_cotz/schema/items/newammo/sh_338lapuaap.lua) | protected | protected |
| [x] [`338lapuahp`](../gamemodes/ix_cotz/schema/items/newammo/sh_338lapuahp.lua) | protected | protected |
| [x] [`357magnum`](../gamemodes/ix_cotz/schema/items/newammo/sh_357magnum.lua) | protected | protected |
| [x] [`357magnumap`](../gamemodes/ix_cotz/schema/items/newammo/sh_357magnumap.lua) | protected | protected |
| [x] [`357magnumhp`](../gamemodes/ix_cotz/schema/items/newammo/sh_357magnumhp.lua) | protected | protected |
| [x] [`44magnum`](../gamemodes/ix_cotz/schema/items/newammo/sh_44magnum.lua) | protected | protected |
| [x] [`44magnumap`](../gamemodes/ix_cotz/schema/items/newammo/sh_44magnumap.lua) | protected | protected |
| [x] [`44magnumhp`](../gamemodes/ix_cotz/schema/items/newammo/sh_44magnumhp.lua) | protected | protected |
| [x] [`45acp`](../gamemodes/ix_cotz/schema/items/newammo/sh_45acp.lua) | protected | protected |
| [x] [`45acp41`](../gamemodes/ix_cotz/schema/items/newammo/sh_45acp41.lua) | protected | protected |
| [x] [`45acpap`](../gamemodes/ix_cotz/schema/items/newammo/sh_45acpap.lua) | protected | protected |
| [x] [`45acphp`](../gamemodes/ix_cotz/schema/items/newammo/sh_45acphp.lua) | protected | protected |
| [x] [`500magnum`](../gamemodes/ix_cotz/schema/items/newammo/sh_500magnum.lua) | protected | protected |
| [x] [`500magnumap`](../gamemodes/ix_cotz/schema/items/newammo/sh_500magnumap.lua) | protected | protected |
| [x] [`500magnumhp`](../gamemodes/ix_cotz/schema/items/newammo/sh_500magnumhp.lua) | protected | protected |
| [x] [`50ae`](../gamemodes/ix_cotz/schema/items/newammo/sh_50ae.lua) | protected | protected |
| [x] [`50aeap`](../gamemodes/ix_cotz/schema/items/newammo/sh_50aeap.lua) | protected | protected |
| [x] [`50aehp`](../gamemodes/ix_cotz/schema/items/newammo/sh_50aehp.lua) | protected | protected |
| [x] [`545x39`](../gamemodes/ix_cotz/schema/items/newammo/sh_545x39.lua) | protected | protected |
| [x] [`545x39ap`](../gamemodes/ix_cotz/schema/items/newammo/sh_545x39ap.lua) | protected | protected |
| [x] [`545x39hp`](../gamemodes/ix_cotz/schema/items/newammo/sh_545x39hp.lua) | protected | protected |
| [x] [`556x45`](../gamemodes/ix_cotz/schema/items/newammo/sh_556x45.lua) | protected | protected |
| [x] [`556x45ap`](../gamemodes/ix_cotz/schema/items/newammo/sh_556x45ap.lua) | protected | protected |
| [x] [`556x45hp`](../gamemodes/ix_cotz/schema/items/newammo/sh_556x45hp.lua) | protected | protected |
| [x] [`57x28`](../gamemodes/ix_cotz/schema/items/newammo/sh_57x28.lua) | protected | protected |
| [x] [`57x28ap`](../gamemodes/ix_cotz/schema/items/newammo/sh_57x28ap.lua) | protected | protected |
| [x] [`57x28hp`](../gamemodes/ix_cotz/schema/items/newammo/sh_57x28hp.lua) | protected | protected |
| [x] [`700nitro`](../gamemodes/ix_cotz/schema/items/newammo/sh_700nitro.lua) | protected | protected |
| [x] [`762x25`](../gamemodes/ix_cotz/schema/items/newammo/sh_762x25.lua) | protected | protected |
| [x] [`762x25ap`](../gamemodes/ix_cotz/schema/items/newammo/sh_762x25ap.lua) | protected | protected |
| [x] [`762x25hp`](../gamemodes/ix_cotz/schema/items/newammo/sh_762x25hp.lua) | protected | protected |
| [x] [`762x39`](../gamemodes/ix_cotz/schema/items/newammo/sh_762x39.lua) | protected | protected |
| [x] [`762x39ap`](../gamemodes/ix_cotz/schema/items/newammo/sh_762x39ap.lua) | protected | protected |
| [x] [`762x39hp`](../gamemodes/ix_cotz/schema/items/newammo/sh_762x39hp.lua) | protected | protected |
| [x] [`762x51`](../gamemodes/ix_cotz/schema/items/newammo/sh_762x51.lua) | protected | protected |
| [x] [`762x51ap`](../gamemodes/ix_cotz/schema/items/newammo/sh_762x51ap.lua) | protected | protected |
| [x] [`762x51hp`](../gamemodes/ix_cotz/schema/items/newammo/sh_762x51hp.lua) | protected | protected |
| [x] [`762x54`](../gamemodes/ix_cotz/schema/items/newammo/sh_762x54.lua) | protected | protected |
| [x] [`762x54ap`](../gamemodes/ix_cotz/schema/items/newammo/sh_762x54ap.lua) | protected | protected |
| [x] [`762x54hp`](../gamemodes/ix_cotz/schema/items/newammo/sh_762x54hp.lua) | protected | protected |
| [x] [`93x64`](../gamemodes/ix_cotz/schema/items/newammo/sh_93x64.lua) | protected | protected |
| [x] [`9x18`](../gamemodes/ix_cotz/schema/items/newammo/sh_9x18.lua) | protected | protected |
| [x] [`9x18ap`](../gamemodes/ix_cotz/schema/items/newammo/sh_9x18ap.lua) | protected | protected |
| [x] [`9x18hp`](../gamemodes/ix_cotz/schema/items/newammo/sh_9x18hp.lua) | protected | protected |
| [x] [`9x19`](../gamemodes/ix_cotz/schema/items/newammo/sh_9x19.lua) | protected | protected |
| [x] [`9x19ap`](../gamemodes/ix_cotz/schema/items/newammo/sh_9x19ap.lua) | protected | protected |
| [x] [`9x19hp`](../gamemodes/ix_cotz/schema/items/newammo/sh_9x19hp.lua) | protected | protected |
| [x] [`9x21`](../gamemodes/ix_cotz/schema/items/newammo/sh_9x21.lua) | protected | protected |
| [x] [`9x21ap`](../gamemodes/ix_cotz/schema/items/newammo/sh_9x21ap.lua) | protected | protected |
| [x] [`9x21hp`](../gamemodes/ix_cotz/schema/items/newammo/sh_9x21hp.lua) | protected | protected |
| [x] [`9x39`](../gamemodes/ix_cotz/schema/items/newammo/sh_9x39.lua) | protected | protected |
| [x] [`9x39ap`](../gamemodes/ix_cotz/schema/items/newammo/sh_9x39ap.lua) | protected | protected |
| [x] [`9x39hp`](../gamemodes/ix_cotz/schema/items/newammo/sh_9x39hp.lua) | protected | protected |

### newbags

| Reviewed item / source | Regular description | Longdesc |
| --- | --- | --- |
| [x] [`backpack_1`](../gamemodes/ix_cotz/schema/items/newbags/sh_backpack_1.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`backpack_1_large`](../gamemodes/ix_cotz/schema/items/newbags/sh_backpack_1_large.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`backpack_2`](../gamemodes/ix_cotz/schema/items/newbags/sh_backpack_2.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`backpack_2_large`](../gamemodes/ix_cotz/schema/items/newbags/sh_backpack_2_large.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`backpack_3`](../gamemodes/ix_cotz/schema/items/newbags/sh_backpack_3.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`backpack_3_large`](../gamemodes/ix_cotz/schema/items/newbags/sh_backpack_3_large.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`backpack_4`](../gamemodes/ix_cotz/schema/items/newbags/sh_backpack_4.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`backpack_4_large`](../gamemodes/ix_cotz/schema/items/newbags/sh_backpack_4_large.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`backpack_5`](../gamemodes/ix_cotz/schema/items/newbags/sh_backpack_5.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`backpack_5_large`](../gamemodes/ix_cotz/schema/items/newbags/sh_backpack_5_large.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`backpack_duffle`](../gamemodes/ix_cotz/schema/items/newbags/sh_backpack_duffle.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`backpack_mbss`](../gamemodes/ix_cotz/schema/items/newbags/sh_backpack_mbss.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`backpack_pilgrim`](../gamemodes/ix_cotz/schema/items/newbags/sh_backpack_pilgrim.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`backpack_sanitar`](../gamemodes/ix_cotz/schema/items/newbags/sh_backpack_sanitar.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`backpack_scavbackpack`](../gamemodes/ix_cotz/schema/items/newbags/sh_backpack_scavbackpack.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`backpack_sling`](../gamemodes/ix_cotz/schema/items/newbags/sh_backpack_sling.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`backpack_takedown_1`](../gamemodes/ix_cotz/schema/items/newbags/sh_backpack_takedown_1.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`backpack_takedown_2`](../gamemodes/ix_cotz/schema/items/newbags/sh_backpack_takedown_2.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`backpack_tbag`](../gamemodes/ix_cotz/schema/items/newbags/sh_backpack_tbag.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`backpack_tourist`](../gamemodes/ix_cotz/schema/items/newbags/sh_backpack_tourist.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`backpack_vkbo`](../gamemodes/ix_cotz/schema/items/newbags/sh_backpack_vkbo.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`gear_exoskeletonframe`](../gamemodes/ix_cotz/schema/items/newbags/sh_gear_exoskeletonframe.lua) | protected | protected |

### newweapons

| Reviewed item / source | Regular description | Longdesc |
| --- | --- | --- |
| [x] [`9a91`](../gamemodes/ix_cotz/schema/items/newweapons/sh_9a91.lua) | protected | protected |
| [x] [`aek971`](../gamemodes/ix_cotz/schema/items/newweapons/sh_aek971.lua) | protected | protected |
| [x] [`ak12`](../gamemodes/ix_cotz/schema/items/newweapons/sh_ak12.lua) | protected | protected |
| [x] [`ak74`](../gamemodes/ix_cotz/schema/items/newweapons/sh_ak74.lua) | protected | protected |
| [x] [`akm`](../gamemodes/ix_cotz/schema/items/newweapons/sh_akm.lua) | protected | protected |
| [x] [`aks74u`](../gamemodes/ix_cotz/schema/items/newweapons/sh_aks74u.lua) | protected | protected |
| [x] [`an94k`](../gamemodes/ix_cotz/schema/items/newweapons/sh_an94k.lua) | protected | protected |
| [x] [`ar159mm`](../gamemodes/ix_cotz/schema/items/newweapons/sh_ar159mm.lua) | protected | protected |
| [x] [`asval`](../gamemodes/ix_cotz/schema/items/newweapons/sh_asval.lua) | protected | protected |
| [x] [`aug`](../gamemodes/ix_cotz/schema/items/newweapons/sh_aug.lua) | protected | protected |
| [x] [`barrettm98b`](../gamemodes/ix_cotz/schema/items/newweapons/sh_barrettm98b.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`beretta92`](../gamemodes/ix_cotz/schema/items/newweapons/sh_beretta92.lua) | protected | protected |
| [x] [`brhp`](../gamemodes/ix_cotz/schema/items/newweapons/sh_brhp.lua) | protected | protected |
| [x] [`c96`](../gamemodes/ix_cotz/schema/items/newweapons/sh_c96.lua) | protected | protected |
| [x] [`c96carbine`](../gamemodes/ix_cotz/schema/items/newweapons/sh_c96carbine.lua) | protected | protected |
| [x] [`cz52`](../gamemodes/ix_cotz/schema/items/newweapons/sh_cz52.lua) | protected | protected |
| [x] [`deagle`](../gamemodes/ix_cotz/schema/items/newweapons/sh_deagle.lua) | protected | protected |
| [x] [`deagle44`](../gamemodes/ix_cotz/schema/items/newweapons/sh_deagle44.lua) | protected | protected |
| [x] [`dp28`](../gamemodes/ix_cotz/schema/items/newweapons/sh_dp28.lua) | protected | protected |
| [x] [`f2000`](../gamemodes/ix_cotz/schema/items/newweapons/sh_f2000.lua) | protected | protected |
| [x] [`famas`](../gamemodes/ix_cotz/schema/items/newweapons/sh_famas.lua) | protected | protected |
| [x] [`fiveseven`](../gamemodes/ix_cotz/schema/items/newweapons/sh_fiveseven.lua) | protected | protected |
| [x] [`fnfal`](../gamemodes/ix_cotz/schema/items/newweapons/sh_fnfal.lua) | protected | protected |
| [x] [`fort12`](../gamemodes/ix_cotz/schema/items/newweapons/sh_fort12.lua) | protected | protected |
| [x] [`g2contender`](../gamemodes/ix_cotz/schema/items/newweapons/sh_g2contender.lua) | protected | protected |
| [x] [`g2contender500`](../gamemodes/ix_cotz/schema/items/newweapons/sh_g2contender500.lua) | protected | protected |
| [x] [`g36c`](../gamemodes/ix_cotz/schema/items/newweapons/sh_g36c.lua) | protected | protected |
| [x] [`g3a3`](../gamemodes/ix_cotz/schema/items/newweapons/sh_g3a3.lua) | protected | protected |
| [x] [`gepardpdw`](../gamemodes/ix_cotz/schema/items/newweapons/sh_gepardpdw.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`glock17`](../gamemodes/ix_cotz/schema/items/newweapons/sh_glock17.lua) | protected | protected |
| [x] [`glock18`](../gamemodes/ix_cotz/schema/items/newweapons/sh_glock18.lua) | protected | protected |
| [x] [`hk416`](../gamemodes/ix_cotz/schema/items/newweapons/sh_hk416.lua) | protected | protected |
| [x] [`ij600`](../gamemodes/ix_cotz/schema/items/newweapons/sh_ij600.lua) | protected | protected |
| [x] [`ithaca37`](../gamemodes/ix_cotz/schema/items/newweapons/sh_ithaca37.lua) | protected | protected |
| [x] [`kiparis`](../gamemodes/ix_cotz/schema/items/newweapons/sh_kiparis.lua) | protected | protected |
| [x] [`kp31`](../gamemodes/ix_cotz/schema/items/newweapons/sh_kp31.lua) | protected | protected |
| [x] [`l115`](../gamemodes/ix_cotz/schema/items/newweapons/sh_l115.lua) | protected | protected |
| [x] [`l85`](../gamemodes/ix_cotz/schema/items/newweapons/sh_l85.lua) | protected | protected |
| [x] [`lax410`](../gamemodes/ix_cotz/schema/items/newweapons/sh_lax410.lua) | protected | protected |
| [x] [`lax410s`](../gamemodes/ix_cotz/schema/items/newweapons/sh_lax410s.lua) | protected | protected |
| [x] [`lax44`](../gamemodes/ix_cotz/schema/items/newweapons/sh_lax44.lua) | protected | protected |
| [x] [`lr300`](../gamemodes/ix_cotz/schema/items/newweapons/sh_lr300.lua) | protected | protected |
| [x] [`lugerp08`](../gamemodes/ix_cotz/schema/items/newweapons/sh_lugerp08.lua) | protected | protected |
| [x] [`m14`](../gamemodes/ix_cotz/schema/items/newweapons/sh_m14.lua) | protected | protected |
| [x] [`m16a4`](../gamemodes/ix_cotz/schema/items/newweapons/sh_m16a4.lua) | protected | protected |
| [x] [`m1887`](../gamemodes/ix_cotz/schema/items/newweapons/sh_m1887.lua) | protected | protected |
| [x] [`m1911`](../gamemodes/ix_cotz/schema/items/newweapons/sh_m1911.lua) | protected | protected |
| [x] [`m1911chic`](../gamemodes/ix_cotz/schema/items/newweapons/sh_m1911chic.lua) | protected | protected |
| [x] [`m1917`](../gamemodes/ix_cotz/schema/items/newweapons/sh_m1917.lua) | protected | protected |
| [x] [`m1928`](../gamemodes/ix_cotz/schema/items/newweapons/sh_m1928.lua) | protected | protected |
| [x] [`m3super90`](../gamemodes/ix_cotz/schema/items/newweapons/sh_m3super90.lua) | protected | protected |
| [x] [`m3supershort`](../gamemodes/ix_cotz/schema/items/newweapons/sh_m3supershort.lua) | protected | protected |
| [x] [`mac11`](../gamemodes/ix_cotz/schema/items/newweapons/sh_mac11.lua) | protected | protected |
| [x] [`makarov`](../gamemodes/ix_cotz/schema/items/newweapons/sh_makarov.lua) | protected | protected |
| [x] [`mateba`](../gamemodes/ix_cotz/schema/items/newweapons/sh_mateba.lua) | protected | protected |
| [x] [`mosin`](../gamemodes/ix_cotz/schema/items/newweapons/sh_mosin.lua) | protected | protected |
| [x] [`mossberg500`](../gamemodes/ix_cotz/schema/items/newweapons/sh_mossberg500.lua) | protected | protected |
| [x] [`mp153`](../gamemodes/ix_cotz/schema/items/newweapons/sh_mp153.lua) | protected | protected |
| [x] [`mp18`](../gamemodes/ix_cotz/schema/items/newweapons/sh_mp18.lua) | protected | protected |
| [x] [`mp27`](../gamemodes/ix_cotz/schema/items/newweapons/sh_mp27.lua) | protected | protected |
| [x] [`mp34`](../gamemodes/ix_cotz/schema/items/newweapons/sh_mp34.lua) | protected | protected |
| [x] [`mp40`](../gamemodes/ix_cotz/schema/items/newweapons/sh_mp40.lua) | protected | protected |
| [x] [`mp5`](../gamemodes/ix_cotz/schema/items/newweapons/sh_mp5.lua) | protected | protected |
| [x] [`mp5k`](../gamemodes/ix_cotz/schema/items/newweapons/sh_mp5k.lua) | protected | protected |
| [x] [`mp9a1`](../gamemodes/ix_cotz/schema/items/newweapons/sh_mp9a1.lua) | protected | protected |
| [x] [`mr96`](../gamemodes/ix_cotz/schema/items/newweapons/sh_mr96.lua) | protected | protected |
| [x] [`nagantrev`](../gamemodes/ix_cotz/schema/items/newweapons/sh_nagantrev.lua) | protected | protected |
| [x] [`nitro`](../gamemodes/ix_cotz/schema/items/newweapons/sh_nitro.lua) | protected | protected |
| [x] [`obrez`](../gamemodes/ix_cotz/schema/items/newweapons/sh_obrez.lua) | protected | protected |
| [x] [`obrezmalfunction`](../gamemodes/ix_cotz/schema/items/newweapons/sh_obrezmalfunction.lua) | protected | protected |
| [x] [`p90`](../gamemodes/ix_cotz/schema/items/newweapons/sh_p90.lua) | protected | protected |
| [x] [`p99`](../gamemodes/ix_cotz/schema/items/newweapons/sh_p99.lua) | protected | protected |
| [x] [`pkm`](../gamemodes/ix_cotz/schema/items/newweapons/sh_pkm.lua) | protected | protected |
| [x] [`pp19`](../gamemodes/ix_cotz/schema/items/newweapons/sh_pp19.lua) | protected | protected |
| [x] [`pp1901vityaz`](../gamemodes/ix_cotz/schema/items/newweapons/sh_pp1901vityaz.lua) | protected | protected |
| [x] [`pp2000`](../gamemodes/ix_cotz/schema/items/newweapons/sh_pp2000.lua) | protected | protected |
| [x] [`ppsh`](../gamemodes/ix_cotz/schema/items/newweapons/sh_ppsh.lua) | protected | protected |
| [x] [`ptrs`](../gamemodes/ix_cotz/schema/items/newweapons/sh_ptrs.lua) | protected | protected |
| [x] [`rem870ae`](../gamemodes/ix_cotz/schema/items/newweapons/sh_rem870ae.lua) | protected | protected |
| [x] [`remmsr`](../gamemodes/ix_cotz/schema/items/newweapons/sh_remmsr.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`rk95`](../gamemodes/ix_cotz/schema/items/newweapons/sh_rk95.lua) | protected | protected |
| [x] [`rpk`](../gamemodes/ix_cotz/schema/items/newweapons/sh_rpk.lua) | protected | protected |
| [x] [`ruger1022`](../gamemodes/ix_cotz/schema/items/newweapons/sh_ruger1022.lua) | protected | protected |
| [x] [`rugermini14`](../gamemodes/ix_cotz/schema/items/newweapons/sh_rugermini14.lua) | protected | protected |
| [x] [`rugermk3`](../gamemodes/ix_cotz/schema/items/newweapons/sh_rugermk3.lua) | protected | protected |
| [x] [`saiga12`](../gamemodes/ix_cotz/schema/items/newweapons/sh_saiga12.lua) | protected | protected |
| [x] [`saiga410`](../gamemodes/ix_cotz/schema/items/newweapons/sh_saiga410.lua) | protected | protected |
| [x] [`saigasemi`](../gamemodes/ix_cotz/schema/items/newweapons/sh_saigasemi.lua) | protected | protected |
| [x] [`saigasemi545`](../gamemodes/ix_cotz/schema/items/newweapons/sh_saigasemi545.lua) | protected | protected |
| [x] [`sako85`](../gamemodes/ix_cotz/schema/items/newweapons/sh_sako85.lua) | protected | protected |
| [x] [`sako85nato`](../gamemodes/ix_cotz/schema/items/newweapons/sh_sako85nato.lua) | protected | protected |
| [x] [`sako85varmint`](../gamemodes/ix_cotz/schema/items/newweapons/sh_sako85varmint.lua) | protected | protected |
| [x] [`sg552`](../gamemodes/ix_cotz/schema/items/newweapons/sh_sg552.lua) | protected | protected |
| [x] [`skorpion`](../gamemodes/ix_cotz/schema/items/newweapons/sh_skorpion.lua) | protected | protected |
| [x] [`sks`](../gamemodes/ix_cotz/schema/items/newweapons/sh_sks.lua) | protected | protected |
| [x] [`sr2`](../gamemodes/ix_cotz/schema/items/newweapons/sh_sr2.lua) | protected | protected |
| [x] [`sr3m`](../gamemodes/ix_cotz/schema/items/newweapons/sh_sr3m.lua) | protected | protected |
| [x] [`stechaps`](../gamemodes/ix_cotz/schema/items/newweapons/sh_stechaps.lua) | protected | protected |
| [x] [`sten`](../gamemodes/ix_cotz/schema/items/newweapons/sh_sten.lua) | protected | protected |
| [x] [`sterling`](../gamemodes/ix_cotz/schema/items/newweapons/sh_sterling.lua) | protected | protected |
| [x] [`stoegerdd`](../gamemodes/ix_cotz/schema/items/newweapons/sh_stoegerdd.lua) | protected | protected |
| [x] [`stoegerddshort`](../gamemodes/ix_cotz/schema/items/newweapons/sh_stoegerddshort.lua) | protected | protected |
| [x] [`striker`](../gamemodes/ix_cotz/schema/items/newweapons/sh_striker.lua) | protected | protected |
| [x] [`sv98`](../gamemodes/ix_cotz/schema/items/newweapons/sh_sv98.lua) | protected | protected |
| [x] [`svd`](../gamemodes/ix_cotz/schema/items/newweapons/sh_svd.lua) | protected | protected |
| [x] [`svt40`](../gamemodes/ix_cotz/schema/items/newweapons/sh_svt40.lua) | protected | protected |
| [x] [`svu`](../gamemodes/ix_cotz/schema/items/newweapons/sh_svu.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`sw500`](../gamemodes/ix_cotz/schema/items/newweapons/sh_sw500.lua) | protected | protected |
| [x] [`swmodel29`](../gamemodes/ix_cotz/schema/items/newweapons/sh_swmodel29.lua) | protected | protected |
| [x] [`swr8`](../gamemodes/ix_cotz/schema/items/newweapons/sh_swr8.lua) | protected | protected |
| [x] [`taurusjudge`](../gamemodes/ix_cotz/schema/items/newweapons/sh_taurusjudge.lua) | protected | protected |
| [x] [`taurusragingbull`](../gamemodes/ix_cotz/schema/items/newweapons/sh_taurusragingbull.lua) | protected | protected |
| [x] [`tkpd`](../gamemodes/ix_cotz/schema/items/newweapons/sh_tkpd.lua) | protected | protected |
| [x] [`tokarev`](../gamemodes/ix_cotz/schema/items/newweapons/sh_tokarev.lua) | protected | protected |
| [x] [`toz106`](../gamemodes/ix_cotz/schema/items/newweapons/sh_toz106.lua) | protected | protected |
| [x] [`toz194`](../gamemodes/ix_cotz/schema/items/newweapons/sh_toz194.lua) | protected | protected |
| [x] [`toz34`](../gamemodes/ix_cotz/schema/items/newweapons/sh_toz34.lua) | protected | protected |
| [x] [`toz34short`](../gamemodes/ix_cotz/schema/items/newweapons/sh_toz34short.lua) | protected | protected |
| [x] [`toz34special`](../gamemodes/ix_cotz/schema/items/newweapons/sh_toz34special.lua) | protected | protected |
| [x] [`toz66`](../gamemodes/ix_cotz/schema/items/newweapons/sh_toz66.lua) | protected | protected |
| [x] [`toz66short`](../gamemodes/ix_cotz/schema/items/newweapons/sh_toz66short.lua) | protected | protected |
| [x] [`trg42`](../gamemodes/ix_cotz/schema/items/newweapons/sh_trg42.lua) | protected | protected |
| [x] [`ump45`](../gamemodes/ix_cotz/schema/items/newweapons/sh_ump45.lua) | protected | protected |
| [x] [`uzi`](../gamemodes/ix_cotz/schema/items/newweapons/sh_uzi.lua) | protected | protected |
| [x] [`uzi50ae`](../gamemodes/ix_cotz/schema/items/newweapons/sh_uzi50ae.lua) | protected | protected |
| [x] [`vss`](../gamemodes/ix_cotz/schema/items/newweapons/sh_vss.lua) | protected | protected |
| [x] [`vssk`](../gamemodes/ix_cotz/schema/items/newweapons/sh_vssk.lua) | protected | protected |
| [x] [`w1895`](../gamemodes/ix_cotz/schema/items/newweapons/sh_w1895.lua) | protected | protected |
| [x] [`w9422`](../gamemodes/ix_cotz/schema/items/newweapons/sh_w9422.lua) | protected | protected |
| [x] [`w9422357`](../gamemodes/ix_cotz/schema/items/newweapons/sh_w9422357.lua) | protected | protected |

### pda

| Reviewed item / source | Regular description | Longdesc |
| --- | --- | --- |
| [x] [`pda`](../gamemodes/ix_cotz/plugins/pda/items/pda/sh_pda.lua) | protected | rewritten — missing/placeholder at cutoff |

### quests

| Reviewed item / source | Regular description | Longdesc |
| --- | --- | --- |
| [x] [`value_air_journal`](../gamemodes/ix_cotz/schema/items/quests/sh_value_air_journal.lua) | rewritten | rewritten — new item |
| [x] [`value_badge_bandit`](../gamemodes/ix_cotz/schema/items/quests/sh_value_badge_bandit.lua) | retained | rewritten — new item |
| [x] [`value_badge_csky`](../gamemodes/ix_cotz/schema/items/quests/sh_value_badge_csky.lua) | retained | rewritten — new item |
| [x] [`value_badge_defiance`](../gamemodes/ix_cotz/schema/items/quests/sh_value_badge_defiance.lua) | retained | rewritten — new item |
| [x] [`value_badge_dolg`](../gamemodes/ix_cotz/schema/items/quests/sh_value_badge_dolg.lua) | retained | rewritten — new item |
| [x] [`value_badge_ecolog`](../gamemodes/ix_cotz/schema/items/quests/sh_value_badge_ecolog.lua) | retained | rewritten — new item |
| [x] [`value_badge_freedom`](../gamemodes/ix_cotz/schema/items/quests/sh_value_badge_freedom.lua) | retained | rewritten — new item |
| [x] [`value_badge_greh`](../gamemodes/ix_cotz/schema/items/quests/sh_value_badge_greh.lua) | retained | rewritten — new item |
| [x] [`value_badge_isg`](../gamemodes/ix_cotz/schema/items/quests/sh_value_badge_isg.lua) | retained | rewritten — new item |
| [x] [`value_badge_merc`](../gamemodes/ix_cotz/schema/items/quests/sh_value_badge_merc.lua) | retained | rewritten — new item |
| [x] [`value_badge_military`](../gamemodes/ix_cotz/schema/items/quests/sh_value_badge_military.lua) | retained | rewritten — new item |
| [x] [`value_badge_monolith`](../gamemodes/ix_cotz/schema/items/quests/sh_value_badge_monolith.lua) | retained | rewritten — new item |
| [x] [`value_badge_renegade`](../gamemodes/ix_cotz/schema/items/quests/sh_value_badge_renegade.lua) | retained | rewritten — new item |
| [x] [`value_container_arena_battlepass_s1`](../gamemodes/ix_cotz/schema/items/quests/sh_value_container_arena_battlepass_s1.lua) | retained | rewritten — new item |
| [x] [`value_container_arena_battlepass_s2`](../gamemodes/ix_cotz/schema/items/quests/sh_value_container_arena_battlepass_s2.lua) | retained | rewritten — new item |
| [x] [`value_container_case_kompromat`](../gamemodes/ix_cotz/schema/items/quests/sh_value_container_case_kompromat.lua) | retained | rewritten — new item |
| [x] [`value_container_cultic_kappa`](../gamemodes/ix_cotz/schema/items/quests/sh_value_container_cultic_kappa.lua) | retained | rewritten — new item |
| [x] [`value_container_gamma`](../gamemodes/ix_cotz/schema/items/quests/sh_value_container_gamma.lua) | retained | rewritten — new item |
| [x] [`value_container_gamma_damaged`](../gamemodes/ix_cotz/schema/items/quests/sh_value_container_gamma_damaged.lua) | retained | rewritten — new item |
| [x] [`value_container_gamma_prestige`](../gamemodes/ix_cotz/schema/items/quests/sh_value_container_gamma_prestige.lua) | retained | rewritten — new item |
| [x] [`value_container_gamma_tue`](../gamemodes/ix_cotz/schema/items/quests/sh_value_container_gamma_tue.lua) | retained | rewritten — new item |
| [x] [`value_container_grenadebox`](../gamemodes/ix_cotz/schema/items/quests/sh_value_container_grenadebox.lua) | retained | rewritten — new item |
| [x] [`value_container_items_thicc`](../gamemodes/ix_cotz/schema/items/quests/sh_value_container_items_thicc.lua) | retained | rewritten — new item |
| [x] [`value_container_keys_case`](../gamemodes/ix_cotz/schema/items/quests/sh_value_container_keys_case.lua) | retained | rewritten — new item |
| [x] [`value_container_meds`](../gamemodes/ix_cotz/schema/items/quests/sh_value_container_meds.lua) | retained | rewritten — new item |
| [x] [`value_container_moderator_toolbox`](../gamemodes/ix_cotz/schema/items/quests/sh_value_container_moderator_toolbox.lua) | retained | rewritten — new item |
| [x] [`value_container_money`](../gamemodes/ix_cotz/schema/items/quests/sh_value_container_money.lua) | retained | rewritten — new item |
| [x] [`value_container_pistolcase`](../gamemodes/ix_cotz/schema/items/quests/sh_value_container_pistolcase.lua) | retained | rewritten — new item |
| [x] [`value_container_plates_case`](../gamemodes/ix_cotz/schema/items/quests/sh_value_container_plates_case.lua) | retained | rewritten — new item |
| [x] [`value_container_secured_alpha`](../gamemodes/ix_cotz/schema/items/quests/sh_value_container_secured_alpha.lua) | retained | rewritten — new item |
| [x] [`value_container_secured_beta`](../gamemodes/ix_cotz/schema/items/quests/sh_value_container_secured_beta.lua) | retained | rewritten — new item |
| [x] [`value_container_secured_epsilon`](../gamemodes/ix_cotz/schema/items/quests/sh_value_container_secured_epsilon.lua) | retained | rewritten — new item |
| [x] [`value_container_secured_kappa`](../gamemodes/ix_cotz/schema/items/quests/sh_value_container_secured_kappa.lua) | retained | rewritten — new item |
| [x] [`value_container_secured_theta`](../gamemodes/ix_cotz/schema/items/quests/sh_value_container_secured_theta.lua) | retained | rewritten — new item |
| [x] [`value_electr_controller_quest`](../gamemodes/ix_cotz/schema/items/quests/sh_value_electr_controller_quest.lua) | retained | rewritten — new item |
| [x] [`value_electroniccase_0013`](../gamemodes/ix_cotz/schema/items/quests/sh_value_electroniccase_0013.lua) | retained | rewritten — new item |
| [x] [`value_electroniccase_0022`](../gamemodes/ix_cotz/schema/items/quests/sh_value_electroniccase_0022.lua) | retained | rewritten — new item |
| [x] [`value_electroniccase_0031`](../gamemodes/ix_cotz/schema/items/quests/sh_value_electroniccase_0031.lua) | retained | rewritten — new item |
| [x] [`value_electroniccase_0048`](../gamemodes/ix_cotz/schema/items/quests/sh_value_electroniccase_0048.lua) | retained | rewritten — new item |
| [x] [`value_electroniccase_0052`](../gamemodes/ix_cotz/schema/items/quests/sh_value_electroniccase_0052.lua) | retained | rewritten — new item |
| [x] [`value_event_labyrinth_videocassette`](../gamemodes/ix_cotz/schema/items/quests/sh_value_event_labyrinth_videocassette.lua) | retained | rewritten — new item |
| [x] [`value_flash_card_slider_kerman`](../gamemodes/ix_cotz/schema/items/quests/sh_value_flash_card_slider_kerman.lua) | retained | rewritten — new item |
| [x] [`value_flash_card_slider_sanitar`](../gamemodes/ix_cotz/schema/items/quests/sh_value_flash_card_slider_sanitar.lua) | retained | rewritten — new item |
| [x] [`value_hacktool_mechanic`](../gamemodes/ix_cotz/schema/items/quests/sh_value_hacktool_mechanic.lua) | retained | rewritten — new item |
| [x] [`value_info_cd_disk_i`](../gamemodes/ix_cotz/schema/items/quests/sh_value_info_cd_disk_i.lua) | retained | rewritten — new item |
| [x] [`value_info_cd_disk_ii`](../gamemodes/ix_cotz/schema/items/quests/sh_value_info_cd_disk_ii.lua) | retained | rewritten — new item |
| [x] [`value_info_diary_friend_mechanic`](../gamemodes/ix_cotz/schema/items/quests/sh_value_info_diary_friend_mechanic.lua) | retained | rewritten — new item |
| [x] [`value_info_tgdocs`](../gamemodes/ix_cotz/schema/items/quests/sh_value_info_tgdocs.lua) | retained | rewritten — new item |
| [x] [`value_info_videocassette_cyborg`](../gamemodes/ix_cotz/schema/items/quests/sh_value_info_videocassette_cyborg.lua) | retained | rewritten — new item |
| [x] [`value_intelligence`](../gamemodes/ix_cotz/schema/items/quests/sh_value_intelligence.lua) | retained | rewritten — new item |
| [x] [`value_lab_journal`](../gamemodes/ix_cotz/schema/items/quests/sh_value_lab_journal.lua) | retained | rewritten — new item |
| [x] [`value_letter_tg`](../gamemodes/ix_cotz/schema/items/quests/sh_value_letter_tg.lua) | retained | rewritten — new item |
| [x] [`value_med_journal_1`](../gamemodes/ix_cotz/schema/items/quests/sh_value_med_journal_1.lua) | retained | rewritten — new item |
| [x] [`value_med_journal_2`](../gamemodes/ix_cotz/schema/items/quests/sh_value_med_journal_2.lua) | retained | rewritten — new item |
| [x] [`value_military_secret_documents_1`](../gamemodes/ix_cotz/schema/items/quests/sh_value_military_secret_documents_1.lua) | retained | rewritten — new item |
| [x] [`value_military_secret_documents_2`](../gamemodes/ix_cotz/schema/items/quests/sh_value_military_secret_documents_2.lua) | retained | rewritten — new item |
| [x] [`value_military_secret_documents_3`](../gamemodes/ix_cotz/schema/items/quests/sh_value_military_secret_documents_3.lua) | retained | rewritten — new item |
| [x] [`value_mysterious_device`](../gamemodes/ix_cotz/schema/items/quests/sh_value_mysterious_device.lua) | retained | rewritten — new item |
| [x] [`value_note_folder_closed_cardboard_personal`](../gamemodes/ix_cotz/schema/items/quests/sh_value_note_folder_closed_cardboard_personal.lua) | retained | rewritten — new item |
| [x] [`value_note_folder_closed_cardboard_state`](../gamemodes/ix_cotz/schema/items/quests/sh_value_note_folder_closed_cardboard_state.lua) | retained | rewritten — new item |
| [x] [`value_note_folder_closed_terragroup`](../gamemodes/ix_cotz/schema/items/quests/sh_value_note_folder_closed_terragroup.lua) | retained | rewritten — new item |
| [x] [`value_packinglist_goshan`](../gamemodes/ix_cotz/schema/items/quests/sh_value_packinglist_goshan.lua) | retained | rewritten — new item |
| [x] [`value_packinglist_idea`](../gamemodes/ix_cotz/schema/items/quests/sh_value_packinglist_idea.lua) | retained | rewritten — new item |
| [x] [`value_packinglist_oli`](../gamemodes/ix_cotz/schema/items/quests/sh_value_packinglist_oli.lua) | retained | rewritten — new item |
| [x] [`value_photograph_album`](../gamemodes/ix_cotz/schema/items/quests/sh_value_photograph_album.lua) | retained | rewritten — new item |
| [x] [`value_psi_helmet`](../gamemodes/ix_cotz/schema/items/quests/sh_value_psi_helmet.lua) | retained | rewritten — new item |
| [x] [`value_quest_flight_recorder`](../gamemodes/ix_cotz/schema/items/quests/sh_value_quest_flight_recorder.lua) | retained | rewritten — new item |
| [x] [`value_recorder_tape_02`](../gamemodes/ix_cotz/schema/items/quests/sh_value_recorder_tape_02.lua) | retained | rewritten — new item |
| [x] [`value_recorder_tape_03`](../gamemodes/ix_cotz/schema/items/quests/sh_value_recorder_tape_03.lua) | retained | rewritten — new item |
| [x] [`value_recorder_tape_04`](../gamemodes/ix_cotz/schema/items/quests/sh_value_recorder_tape_04.lua) | retained | rewritten — new item |
| [x] [`value_recorder_tape_05`](../gamemodes/ix_cotz/schema/items/quests/sh_value_recorder_tape_05.lua) | retained | rewritten — new item |
| [x] [`value_recorder_tape_06`](../gamemodes/ix_cotz/schema/items/quests/sh_value_recorder_tape_06.lua) | retained | rewritten — new item |
| [x] [`value_recorder_tape_08`](../gamemodes/ix_cotz/schema/items/quests/sh_value_recorder_tape_08.lua) | retained | rewritten — new item |
| [x] [`value_recorder_tape_09`](../gamemodes/ix_cotz/schema/items/quests/sh_value_recorder_tape_09.lua) | retained | rewritten — new item |
| [x] [`value_recorder_tape_10`](../gamemodes/ix_cotz/schema/items/quests/sh_value_recorder_tape_10.lua) | retained | rewritten — new item |
| [x] [`value_recorder_tape_11`](../gamemodes/ix_cotz/schema/items/quests/sh_value_recorder_tape_11.lua) | retained | rewritten — new item |
| [x] [`value_recorder_tape_12`](../gamemodes/ix_cotz/schema/items/quests/sh_value_recorder_tape_12.lua) | retained | rewritten — new item |
| [x] [`value_scientistdiary`](../gamemodes/ix_cotz/schema/items/quests/sh_value_scientistdiary.lua) | retained | rewritten — new item |
| [x] [`value_spec_tgflashkey`](../gamemodes/ix_cotz/schema/items/quests/sh_value_spec_tgflashkey.lua) | retained | rewritten — new item |
| [x] [`value_spherical_recorder`](../gamemodes/ix_cotz/schema/items/quests/sh_value_spherical_recorder.lua) | retained | rewritten — new item |
| [x] [`value_tg_vi_24`](../gamemodes/ix_cotz/schema/items/quests/sh_value_tg_vi_24.lua) | retained | rewritten — new item |
| [x] [`value_tg_vi_24_antivirus`](../gamemodes/ix_cotz/schema/items/quests/sh_value_tg_vi_24_antivirus.lua) | retained | rewritten — new item |

### sharpeningstones

| Reviewed item / source | Regular description | Longdesc |
| --- | --- | --- |
| [x] [`sharpening_stone`](../gamemodes/ix_cotz/schema/items/sharpeningstones/sh_sharpening_stone.lua) | retained | rewritten — new item |
| [x] [`sharpening_stone_fine`](../gamemodes/ix_cotz/schema/items/sharpeningstones/sh_sharpening_stone_fine.lua) | retained | rewritten — new item |

### suit

| Reviewed item / source | Regular description | Longdesc |
| --- | --- | --- |
| [x] [`suit_anorak`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_anorak.lua) | protected | protected |
| [x] [`suit_anorak_anarchist`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_anorak_anarchist.lua) | protected | protected |
| [x] [`suit_anorak_authority`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_anorak_authority.lua) | protected | protected |
| [x] [`suit_anorak_ecologist`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_anorak_ecologist.lua) | protected | protected |
| [x] [`suit_anorak_mercenary`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_anorak_mercenary.lua) | protected | protected |
| [x] [`suit_anorak_scavenger`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_anorak_scavenger.lua) | protected | protected |
| [x] [`suit_berill`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_berill.lua) | protected | protected |
| [x] [`suit_berill_anarchist`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_berill_anarchist.lua) | protected | protected |
| [x] [`suit_berill_authority`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_berill_authority.lua) | protected | protected |
| [x] [`suit_berill_ecologist`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_berill_ecologist.lua) | protected | protected |
| [x] [`suit_berill_looted`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_berill_looted.lua) | protected | protected |
| [x] [`suit_berill_mercenary`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_berill_mercenary.lua) | protected | protected |
| [x] [`suit_berill_scavenger`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_berill_scavenger.lua) | protected | protected |
| [x] [`suit_cs1`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_cs1.lua) | protected | protected |
| [x] [`suit_cs1_ecologist`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_cs1_ecologist.lua) | protected | protected |
| [x] [`suit_cs1_scavenger`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_cs1_scavenger.lua) | protected | protected |
| [x] [`suit_cs2`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_cs2.lua) | protected | protected |
| [x] [`suit_cs2_ecologist`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_cs2_ecologist.lua) | protected | protected |
| [x] [`suit_cs2_scavenger`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_cs2_scavenger.lua) | protected | protected |
| [x] [`suit_cs3`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_cs3.lua) | protected | protected |
| [x] [`suit_cs3_ecologist`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_cs3_ecologist.lua) | protected | protected |
| [x] [`suit_exoskeleton`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_exoskeleton.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`suit_exoskeleton_anarchist`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_exoskeleton_anarchist.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`suit_exoskeleton_authority`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_exoskeleton_authority.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`suit_exoskeleton_ecologist`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_exoskeleton_ecologist.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`suit_exoskeleton_fanatic`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_exoskeleton_fanatic.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`suit_exoskeleton_mercenary`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_exoskeleton_mercenary.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`suit_io7a`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_io7a.lua) | protected | protected |
| [x] [`suit_io7a_anarchist`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_io7a_anarchist.lua) | protected | protected |
| [x] [`suit_io7a_authority`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_io7a_authority.lua) | protected | protected |
| [x] [`suit_io7a_ecologist`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_io7a_ecologist.lua) | protected | protected |
| [x] [`suit_io7a_fanatic`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_io7a_fanatic.lua) | protected | protected |
| [x] [`suit_io7a_looted`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_io7a_looted.lua) | protected | protected |
| [x] [`suit_io7a_mercenary`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_io7a_mercenary.lua) | protected | protected |
| [x] [`suit_io7a_scavenger`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_io7a_scavenger.lua) | protected | protected |
| [x] [`suit_mailjacket`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_mailjacket.lua) | protected | protected |
| [x] [`suit_mailjacket_anarchist`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_mailjacket_anarchist.lua) | protected | protected |
| [x] [`suit_mailjacket_authority`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_mailjacket_authority.lua) | protected | protected |
| [x] [`suit_mailjacket_ecologist`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_mailjacket_ecologist.lua) | protected | protected |
| [x] [`suit_mailjacket_mercenary`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_mailjacket_mercenary.lua) | protected | protected |
| [x] [`suit_mailjacket_scavenger`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_mailjacket_scavenger.lua) | protected | protected |
| [x] [`suit_nbc`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_nbc.lua) | protected | protected |
| [x] [`suit_nbc_anarchist`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_nbc_anarchist.lua) | protected | protected |
| [x] [`suit_nbc_authority`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_nbc_authority.lua) | protected | protected |
| [x] [`suit_nbc_fanatic`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_nbc_fanatic.lua) | protected | protected |
| [x] [`suit_nosorog`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_nosorog.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`suit_ps5m`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_ps5m.lua) | protected | protected |
| [x] [`suit_ps5m_anarchist`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_ps5m_anarchist.lua) | protected | protected |
| [x] [`suit_ps5m_authority`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_ps5m_authority.lua) | protected | protected |
| [x] [`suit_ps5m_ecologist`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_ps5m_ecologist.lua) | protected | protected |
| [x] [`suit_ps5m_fanatic`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_ps5m_fanatic.lua) | protected | protected |
| [x] [`suit_ps5m_mercenary`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_ps5m_mercenary.lua) | protected | protected |
| [x] [`suit_radsuit`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_radsuit.lua) | protected | protected |
| [x] [`suit_radsuit_anarchist`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_radsuit_anarchist.lua) | protected | protected |
| [x] [`suit_radsuit_authority`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_radsuit_authority.lua) | protected | protected |
| [x] [`suit_radsuit_ecologist`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_radsuit_ecologist.lua) | protected | protected |
| [x] [`suit_radsuit_fanatic`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_radsuit_fanatic.lua) | protected | protected |
| [x] [`suit_radsuit_mercenary`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_radsuit_mercenary.lua) | protected | protected |
| [x] [`suit_seva`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_seva.lua) | protected | protected |
| [x] [`suit_seva_anarchist`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_seva_anarchist.lua) | protected | protected |
| [x] [`suit_seva_authority`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_seva_authority.lua) | protected | protected |
| [x] [`suit_seva_ecologist`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_seva_ecologist.lua) | protected | protected |
| [x] [`suit_seva_fanatic`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_seva_fanatic.lua) | protected | protected |
| [x] [`suit_seva_mercenary`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_seva_mercenary.lua) | protected | protected |
| [x] [`suit_skat10`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_skat10.lua) | protected | protected |
| [x] [`suit_skat10_anarchist`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_skat10_anarchist.lua) | protected | protected |
| [x] [`suit_skat10_authority`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_skat10_authority.lua) | protected | protected |
| [x] [`suit_skat10_ecologist`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_skat10_ecologist.lua) | protected | protected |
| [x] [`suit_skat10_looted`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_skat10_looted.lua) | protected | protected |
| [x] [`suit_skat10_mercenary`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_skat10_mercenary.lua) | protected | protected |
| [x] [`suit_skat9`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_skat9.lua) | protected | protected |
| [x] [`suit_skat9_anarchist`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_skat9_anarchist.lua) | protected | protected |
| [x] [`suit_skat9_authority`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_skat9_authority.lua) | protected | protected |
| [x] [`suit_skat9_ecologist`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_skat9_ecologist.lua) | protected | protected |
| [x] [`suit_skat9_fanatic`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_skat9_fanatic.lua) | protected | protected |
| [x] [`suit_skat9_looted`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_skat9_looted.lua) | protected | protected |
| [x] [`suit_skat9_scavenger`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_skat9_scavenger.lua) | protected | protected |
| [x] [`suit_ssp99`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_ssp99.lua) | protected | protected |
| [x] [`suit_ssp99m`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_ssp99m.lua) | protected | protected |
| [x] [`suit_sunrise`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_sunrise.lua) | protected | protected |
| [x] [`suit_sunrise_anarchist`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_sunrise_anarchist.lua) | protected | protected |
| [x] [`suit_sunrise_authority`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_sunrise_authority.lua) | protected | protected |
| [x] [`suit_sunrise_fanatic`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_sunrise_fanatic.lua) | protected | protected |
| [x] [`suit_sunrise_looted`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_sunrise_looted.lua) | protected | protected |
| [x] [`suit_sunrise_mercenary`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_sunrise_mercenary.lua) | protected | protected |
| [x] [`suit_sunrise_scavenger`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_sunrise_scavenger.lua) | protected | protected |
| [x] [`suit_trenchcoat_black`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_trenchcoat_black.lua) | protected | protected |
| [x] [`suit_trenchcoat_brown`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_trenchcoat_brown.lua) | protected | protected |
| [x] [`suit_trenchcoat_green`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_trenchcoat_green.lua) | protected | protected |
| [x] [`suit_trenchcoat_tan`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_trenchcoat_tan.lua) | protected | protected |
| [x] [`suit_wind`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_wind.lua) | protected | protected |
| [x] [`suit_wind_anarchist`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_wind_anarchist.lua) | protected | protected |
| [x] [`suit_wind_authority`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_wind_authority.lua) | protected | protected |
| [x] [`suit_wind_fanatic`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_wind_fanatic.lua) | protected | protected |
| [x] [`suit_wind_looted`](../gamemodes/ix_cotz/schema/items/suit/sh_suit_wind_looted.lua) | protected | protected |

### suitattachments

| Reviewed item / source | Regular description | Longdesc |
| --- | --- | --- |
| [x] [`attachment_aluframe`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_attachment_aluframe.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`attachment_carbonfibre`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_attachment_carbonfibre.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`attachment_ceramicplate_1`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_attachment_ceramicplate_1.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`attachment_ceramicplate_2`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_attachment_ceramicplate_2.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`attachment_ceramicplate_3`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_attachment_ceramicplate_3.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`attachment_ceramicplate_4`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_attachment_ceramicplate_4.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`attachment_fabric_1`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_attachment_fabric_1.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`attachment_fabric_2`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_attachment_fabric_2.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`attachment_kevlar_1`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_attachment_kevlar_1.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`attachment_kevlar_2`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_attachment_kevlar_2.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`attachment_steelframe`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_attachment_steelframe.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`attachment_steelplate_1`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_attachment_steelplate_1.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`attachment_steelplate_2`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_attachment_steelplate_2.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`attachment_steelplate_3`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_attachment_steelplate_3.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`attachment_steelplate_4`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_attachment_steelplate_4.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`hide_bear`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_hide_bear.lua) | protected | protected |
| [x] [`hide_blinddog`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_hide_blinddog.lua) | protected | protected |
| [x] [`hide_bloodsucker`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_hide_bloodsucker.lua) | protected | protected |
| [x] [`hide_boar`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_hide_boar.lua) | protected | protected |
| [x] [`hide_burer`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_hide_burer.lua) | protected | protected |
| [x] [`hide_cat`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_hide_cat.lua) | protected | protected |
| [x] [`hide_chimera`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_hide_chimera.lua) | protected | protected |
| [x] [`hide_controller`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_hide_controller.lua) | protected | protected |
| [x] [`hide_electrocontroller`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_hide_electrocontroller.lua) | protected | protected |
| [x] [`hide_flesh`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_hide_flesh.lua) | protected | protected |
| [x] [`hide_karlik`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_hide_karlik.lua) | protected | protected |
| [x] [`hide_pseudodog`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_hide_pseudodog.lua) | protected | protected |
| [x] [`hide_pseudogiant`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_hide_pseudogiant.lua) | protected | protected |
| [x] [`hide_spider`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_hide_spider.lua) | protected | protected |
| [x] [`hide_sprig`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_hide_sprig.lua) | protected | protected |
| [x] [`hide_swampcontroller`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_hide_swampcontroller.lua) | protected | protected |
| [x] [`hide_tark`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_hide_tark.lua) | protected | protected |
| [x] [`hide_tushkano`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_hide_tushkano.lua) | protected | protected |
| [x] [`hide_vareshka`](../gamemodes/ix_cotz/schema/items/suitattachments/sh_hide_vareshka.lua) | protected | protected |

### valuable

| Reviewed item / source | Regular description | Longdesc |
| --- | --- | --- |
| [x] [`value_9vbattery`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_9vbattery.lua) | protected | protected |
| [x] [`value_barter_walletwz`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_barter_walletwz.lua) | retained | rewritten — new item |
| [x] [`value_battery`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_battery.lua) | protected | protected |
| [x] [`value_bolts`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_bolts.lua) | protected | protected |
| [x] [`value_calculationunit`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_calculationunit.lua) | protected | protected |
| [x] [`value_capacitors`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_capacitors.lua) | protected | protected |
| [x] [`value_carbattery`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_carbattery.lua) | protected | protected |
| [x] [`value_chemcontainer`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_chemcontainer.lua) | retained | rewritten — new item |
| [x] [`value_container_ammo`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_container_ammo.lua) | retained | rewritten — new item |
| [x] [`value_container_cardholder`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_container_cardholder.lua) | retained | rewritten — new item |
| [x] [`value_container_injectorcase`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_container_injectorcase.lua) | retained | rewritten — new item |
| [x] [`value_container_junkbox`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_container_junkbox.lua) | retained | rewritten — new item |
| [x] [`value_container_lopouch`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_container_lopouch.lua) | retained | rewritten — new item |
| [x] [`value_container_parls`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_container_parls.lua) | retained | rewritten — new item |
| [x] [`value_container_smallitems`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_container_smallitems.lua) | retained | rewritten — new item |
| [x] [`value_currency_dollar`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_currency_dollar.lua) | protected | protected |
| [x] [`value_currency_euro`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_currency_euro.lua) | protected | protected |
| [x] [`value_currency_rubles_coins`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_currency_rubles_coins.lua) | protected | rewritten — missing/placeholder at cutoff |
| [x] [`value_detergent`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_detergent.lua) | protected | protected |
| [x] [`value_docbag`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_docbag.lua) | retained | rewritten — new item |
| [x] [`value_documents_1`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_documents_1.lua) | protected | protected |
| [x] [`value_documents_10`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_documents_10.lua) | protected | protected |
| [x] [`value_documents_11`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_documents_11.lua) | protected | protected |
| [x] [`value_documents_12`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_documents_12.lua) | protected | protected |
| [x] [`value_documents_13`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_documents_13.lua) | protected | protected |
| [x] [`value_documents_14`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_documents_14.lua) | protected | protected |
| [x] [`value_documents_2`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_documents_2.lua) | protected | protected |
| [x] [`value_documents_3`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_documents_3.lua) | protected | protected |
| [x] [`value_documents_4`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_documents_4.lua) | protected | protected |
| [x] [`value_documents_5`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_documents_5.lua) | protected | protected |
| [x] [`value_documents_6`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_documents_6.lua) | protected | protected |
| [x] [`value_documents_7`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_documents_7.lua) | protected | protected |
| [x] [`value_documents_8`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_documents_8.lua) | protected | protected |
| [x] [`value_documents_9`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_documents_9.lua) | protected | protected |
| [x] [`value_dynamite`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_dynamite.lua) | retained | rewritten — new item |
| [x] [`value_engine`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_engine.lua) | protected | protected |
| [x] [`value_event_labyrinth_chem_container`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_event_labyrinth_chem_container.lua) | retained | rewritten — new item |
| [x] [`value_frequencymodulator`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_frequencymodulator.lua) | protected | protected |
| [x] [`value_gascan`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_gascan.lua) | retained | rewritten — new item |
| [x] [`value_gasoline`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_gasoline.lua) | protected | protected |
| [x] [`value_glue_1`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_glue_1.lua) | protected | protected |
| [x] [`value_glue_2`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_glue_2.lua) | protected | protected |
| [x] [`value_glue_3`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_glue_3.lua) | protected | protected |
| [x] [`value_glue_4`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_glue_4.lua) | protected | protected |
| [x] [`value_goldchain`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_goldchain.lua) | protected | protected |
| [x] [`value_guncleaner`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_guncleaner.lua) | protected | protected |
| [x] [`value_gunoil`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_gunoil.lua) | protected | protected |
| [x] [`value_gunpowder_blue`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_gunpowder_blue.lua) | protected | protected |
| [x] [`value_gunpowder_green`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_gunpowder_green.lua) | protected | protected |
| [x] [`value_gunpowder_red`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_gunpowder_red.lua) | protected | protected |
| [x] [`value_gunspray`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_gunspray.lua) | protected | protected |
| [x] [`value_hose`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_hose.lua) | protected | protected |
| [x] [`value_kerosene`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_kerosene.lua) | protected | protected |
| [x] [`value_kerosene_container`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_kerosene_container.lua) | retained | rewritten — new item |
| [x] [`value_knife_box_low`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_knife_box_low.lua) | retained | rewritten — new item |
| [x] [`value_lightbulb`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_lightbulb.lua) | protected | protected |
| [x] [`value_lubricant`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_lubricant.lua) | protected | protected |
| [x] [`value_med_surgicalpouch`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_med_surgicalpouch.lua) | retained | rewritten — new item |
| [x] [`value_med_surgicalpouch_worn`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_med_surgicalpouch_worn.lua) | retained | rewritten — new item |
| [x] [`value_med_surgicalroll`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_med_surgicalroll.lua) | retained | rewritten — new item |
| [x] [`value_memorymodule`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_memorymodule.lua) | protected | protected |
| [x] [`value_monitoringunit`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_monitoringunit.lua) | protected | protected |
| [x] [`value_motorclean`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_motorclean.lua) | protected | protected |
| [x] [`value_nails`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_nails.lua) | protected | protected |
| [x] [`value_nuts`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_nuts.lua) | protected | protected |
| [x] [`value_paracord`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_paracord.lua) | protected | protected |
| [x] [`value_parcel`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_parcel.lua) | retained | rewritten — new item |
| [x] [`value_parts`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_parts.lua) | retained | rewritten — new item |
| [x] [`value_pcpart_fpga`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_pcpart_fpga.lua) | protected | protected |
| [x] [`value_pcpart_gpu`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_pcpart_gpu.lua) | protected | protected |
| [x] [`value_pcpart_hdd`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_pcpart_hdd.lua) | protected | protected |
| [x] [`value_pcpart_lcd`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_pcpart_lcd.lua) | protected | protected |
| [x] [`value_pcpart_psu`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_pcpart_psu.lua) | protected | protected |
| [x] [`value_pcpart_ssd`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_pcpart_ssd.lua) | protected | protected |
| [x] [`value_personal`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_personal.lua) | protected | protected |
| [x] [`value_phone_new`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_phone_new.lua) | protected | protected |
| [x] [`value_phone_old`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_phone_old.lua) | protected | protected |
| [x] [`value_plasticbag_labyrinth`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_plasticbag_labyrinth.lua) | retained | rewritten — new item |
| [x] [`value_portable_container_closed`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_portable_container_closed.lua) | retained | rewritten — new item |
| [x] [`value_portable_container_opened`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_portable_container_opened.lua) | retained | rewritten — new item |
| [x] [`value_powerbank`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_powerbank.lua) | protected | protected |
| [x] [`value_precisiontools`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_precisiontools.lua) | retained | rewritten — new item |
| [x] [`value_propanetank`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_propanetank.lua) | protected | protected |
| [x] [`value_pukt90`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_pukt90.lua) | retained | rewritten — new item |
| [x] [`value_security_box`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_security_box.lua) | retained | rewritten — new item |
| [x] [`value_sewingkit`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_sewingkit.lua) | retained | rewritten — new item |
| [x] [`value_siliconetube`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_siliconetube.lua) | protected | protected |
| [x] [`value_sparkplug`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_sparkplug.lua) | protected | protected |
| [x] [`value_statue_cat`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_statue_cat.lua) | protected | protected |
| [x] [`value_statue_horse`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_statue_horse.lua) | protected | protected |
| [x] [`value_statue_lion`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_statue_lion.lua) | protected | protected |
| [x] [`value_tape_duct`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_tape_duct.lua) | protected | protected |
| [x] [`value_tape_electric`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_tape_electric.lua) | protected | protected |
| [x] [`value_tape_heavy`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_tape_heavy.lua) | protected | protected |
| [x] [`value_techtool_1`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_techtool_1.lua) | protected | protected |
| [x] [`value_techtool_2`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_techtool_2.lua) | protected | protected |
| [x] [`value_techtool_3`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_techtool_3.lua) | protected | protected |
| [x] [`value_thermobag`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_thermobag.lua) | retained | rewritten — new item |
| [x] [`value_toiletpaper`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_toiletpaper.lua) | protected | protected |
| [x] [`value_tools_sewing`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_tools_sewing.lua) | retained | rewritten — new item |
| [x] [`value_toothpaste`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_toothpaste.lua) | protected | protected |
| [x] [`value_transistors`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_transistors.lua) | retained | rewritten — new item |
| [x] [`value_upgro1`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_upgro1.lua) | retained | rewritten — new item |
| [x] [`value_upgro2`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_upgro2.lua) | retained | rewritten — new item |
| [x] [`value_upgro3`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_upgro3.lua) | retained | rewritten — new item |
| [x] [`value_wallet`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_wallet.lua) | retained | rewritten — new item |
| [x] [`value_watch`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_watch.lua) | protected | protected |
| [x] [`value_waterfilter`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_waterfilter.lua) | protected | protected |
| [x] [`value_wire_copper`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_wire_copper.lua) | protected | protected |
| [x] [`value_wire_heavy`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_wire_heavy.lua) | protected | protected |
| [x] [`value_wire_light`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_wire_light.lua) | protected | protected |
| [x] [`value_wirelesstrans`](../gamemodes/ix_cotz/schema/items/valuable/sh_value_wirelesstrans.lua) | protected | protected |

### valuables_test

| Reviewed item / source | Regular description | Longdesc |
| --- | --- | --- |
| [x] [`value_airfilter`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_airfilter.lua) | retained | rewritten — new item |
| [x] [`value_ais_sart`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_ais_sart.lua) | retained | rewritten — new item |
| [x] [`value_anomaly_plant`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_anomaly_plant.lua) | retained | rewritten — new item |
| [x] [`value_antiinsect`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_antiinsect.lua) | retained | rewritten — new item |
| [x] [`value_antique_teapot`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_antique_teapot.lua) | retained | rewritten — new item |
| [x] [`value_antique_vase`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_antique_vase.lua) | retained | rewritten — new item |
| [x] [`value_archive_cassette`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_archive_cassette.lua) | retained | rewritten — new item |
| [x] [`value_awl`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_awl.lua) | rewritten | rewritten — new item |
| [x] [`value_ballistic1`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_ballistic1.lua) | retained | rewritten — new item |
| [x] [`value_ballistic11`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_ballistic11.lua) | retained | rewritten — new item |
| [x] [`value_ballistic3`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_ballistic3.lua) | retained | rewritten — new item |
| [x] [`value_ballistic4`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_ballistic4.lua) | retained | rewritten — new item |
| [x] [`value_ballistic6`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_ballistic6.lua) | retained | rewritten — new item |
| [x] [`value_ballistic7`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_ballistic7.lua) | retained | rewritten — new item |
| [x] [`value_balloon_poison_gas`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_balloon_poison_gas.lua) | retained | rewritten — new item |
| [x] [`value_battery_d_0`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_battery_d_0.lua) | retained | rewritten — new item |
| [x] [`value_bear_souvenir`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_bear_souvenir.lua) | retained | rewritten — new item |
| [x] [`value_bedspread`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_bedspread.lua) | retained | rewritten — new item |
| [x] [`value_bleach`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_bleach.lua) | retained | rewritten — new item |
| [x] [`value_bogatir_moreman_tag`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_bogatir_moreman_tag.lua) | retained | rewritten — new item |
| [x] [`value_briefcase`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_briefcase.lua) | retained | rewritten — new item |
| [x] [`value_building_kektape`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_building_kektape.lua) | retained | rewritten — new item |
| [x] [`value_building_plexiglass`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_building_plexiglass.lua) | retained | rewritten — new item |
| [x] [`value_building_poxeram`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_building_poxeram.lua) | retained | rewritten — new item |
| [x] [`value_c4`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_c4.lua) | retained | rewritten — new item |
| [x] [`value_carbon_case`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_carbon_case.lua) | retained | rewritten — new item |
| [x] [`value_casezerogeo`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_casezerogeo.lua) | retained | rewritten — new item |
| [x] [`value_cassette_black90`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_cassette_black90.lua) | retained | rewritten — new item |
| [x] [`value_cassette_fiolet`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_cassette_fiolet.lua) | retained | rewritten — new item |
| [x] [`value_chemicalsample`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_chemicalsample.lua) | retained | rewritten — new item |
| [x] [`value_chevron_bear`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_chevron_bear.lua) | retained | rewritten — new item |
| [x] [`value_chlorine`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_chlorine.lua) | retained | rewritten — new item |
| [x] [`value_circuitboard`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_circuitboard.lua) | retained | rewritten — new item |
| [x] [`value_clothbook1`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_clothbook1.lua) | retained | rewritten — new item |
| [x] [`value_clothbook2`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_clothbook2.lua) | retained | rewritten — new item |
| [x] [`value_coffee`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_coffee.lua) | retained | rewritten — new item |
| [x] [`value_container_trackcase`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_container_trackcase.lua) | retained | rewritten — new item |
| [x] [`value_container_weapon_thicc`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_container_weapon_thicc.lua) | retained | rewritten — new item |
| [x] [`value_container_weaponcase`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_container_weaponcase.lua) | retained | rewritten — new item |
| [x] [`value_controller`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_controller.lua) | retained | rewritten — new item |
| [x] [`value_crikent_0`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_crikent_0.lua) | retained | rewritten — new item |
| [x] [`value_crow_beak`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_crow_beak.lua) | retained | rewritten — new item |
| [x] [`value_crowbar`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_crowbar.lua) | retained | rewritten — new item |
| [x] [`value_detector`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_detector.lua) | retained | rewritten — new item |
| [x] [`value_draincleaner`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_draincleaner.lua) | retained | rewritten — new item |
| [x] [`value_drugskit`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_drugskit.lua) | retained | rewritten — new item |
| [x] [`value_dryfuel`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_dryfuel.lua) | retained | rewritten — new item |
| [x] [`value_electr_adv_amplifier`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_electr_adv_amplifier.lua) | retained | rewritten — new item |
| [x] [`value_electr_adv_controller`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_electr_adv_controller.lua) | retained | rewritten — new item |
| [x] [`value_electr_adv_converter`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_electr_adv_converter.lua) | retained | rewritten — new item |
| [x] [`value_electr_adv_ultralink`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_electr_adv_ultralink.lua) | retained | rewritten — new item |
| [x] [`value_electr_card_programmer`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_electr_card_programmer.lua) | retained | rewritten — new item |
| [x] [`value_electr_components`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_electr_components.lua) | retained | rewritten — new item |
| [x] [`value_electr_countermeasure`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_electr_countermeasure.lua) | retained | rewritten — new item |
| [x] [`value_electr_gary_zont`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_electr_gary_zont.lua) | retained | rewritten — new item |
| [x] [`value_electr_hdd_quest`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_electr_hdd_quest.lua) | retained | rewritten — new item |
| [x] [`value_electr_signal_jammer`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_electr_signal_jammer.lua) | retained | rewritten — new item |
| [x] [`value_electr_ssd`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_electr_ssd.lua) | retained | rewritten — new item |
| [x] [`value_electr_tplug`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_electr_tplug.lua) | retained | rewritten — new item |
| [x] [`value_electricdrill`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_electricdrill.lua) | retained | rewritten — new item |
| [x] [`value_electro_gyroscope`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_electro_gyroscope.lua) | retained | rewritten — new item |
| [x] [`value_energy_accum`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_energy_accum.lua) | retained | rewritten — new item |
| [x] [`value_energy_cyclon`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_energy_cyclon.lua) | retained | rewritten — new item |
| [x] [`value_energy_greenbat`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_energy_greenbat.lua) | retained | rewritten — new item |
| [x] [`value_envelope`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_envelope.lua) | retained | rewritten — new item |
| [x] [`value_expandingfoam`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_expandingfoam.lua) | retained | rewritten — new item |
| [x] [`value_explosive_charge`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_explosive_charge.lua) | retained | rewritten — new item |
| [x] [`value_fabric_aramid`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_fabric_aramid.lua) | rewritten | rewritten — new item |
| [x] [`value_fabric_cordura`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_fabric_cordura.lua) | retained | rewritten — new item |
| [x] [`value_fabric_fleece`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_fabric_fleece.lua) | retained | rewritten — new item |
| [x] [`value_fabric_ripstop`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_fabric_ripstop.lua) | retained | rewritten — new item |
| [x] [`value_fabrics1`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_fabrics1.lua) | retained | rewritten — new item |
| [x] [`value_fabrics2`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_fabrics2.lua) | retained | rewritten — new item |
| [x] [`value_field_laptop`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_field_laptop.lua) | retained | rewritten — new item |
| [x] [`value_flammable_huntermatches`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_flammable_huntermatches.lua) | retained | rewritten — new item |
| [x] [`value_flammable_klean`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_flammable_klean.lua) | retained | rewritten — new item |
| [x] [`value_flammable_survlighter`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_flammable_survlighter.lua) | retained | rewritten — new item |
| [x] [`value_flammable_thermite`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_flammable_thermite.lua) | retained | rewritten — new item |
| [x] [`value_flammable_trotil`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_flammable_trotil.lua) | retained | rewritten — new item |
| [x] [`value_flash_card_ironkey`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_flash_card_ironkey.lua) | retained | rewritten — new item |
| [x] [`value_flash_card_ironkey_slider`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_flash_card_ironkey_slider.lua) | retained | rewritten — new item |
| [x] [`value_flash_card_slider`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_flash_card_slider.lua) | retained | rewritten — new item |
| [x] [`value_flyer_01`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_flyer_01.lua) | retained | rewritten — new item |
| [x] [`value_flyer_02`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_flyer_02.lua) | retained | rewritten — new item |
| [x] [`value_flyer_03`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_flyer_03.lua) | retained | rewritten — new item |
| [x] [`value_flyers`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_flyers.lua) | retained | rewritten — new item |
| [x] [`value_gamemagazine_01`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_gamemagazine_01.lua) | retained | rewritten — new item |
| [x] [`value_geigercounter`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_geigercounter.lua) | retained | rewritten — new item |
| [x] [`value_glasscleaner`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_glasscleaner.lua) | retained | rewritten — new item |
| [x] [`value_guide`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_guide.lua) | retained | rewritten — new item |
| [x] [`value_gyroscope`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_gyroscope.lua) | retained | rewritten — new item |
| [x] [`value_gyrotachometer`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_gyrotachometer.lua) | retained | rewritten — new item |
| [x] [`value_hammer`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_hammer.lua) | retained | rewritten — new item |
| [x] [`value_handbook_circuits`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_handbook_circuits.lua) | retained | rewritten — new item |
| [x] [`value_handbook_materials`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_handbook_materials.lua) | retained | rewritten — new item |
| [x] [`value_handdrill`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_handdrill.lua) | retained | rewritten — new item |
| [x] [`value_helix`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_helix.lua) | retained | rewritten — new item |
| [x] [`value_household_repellent`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_household_repellent.lua) | retained | rewritten — new item |
| [x] [`value_household_salt`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_household_salt.lua) | retained | rewritten — new item |
| [x] [`value_household_toothpaste1`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_household_toothpaste1.lua) | retained | rewritten — new item |
| [x] [`value_household_tree_life_extender`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_household_tree_life_extender.lua) | retained | rewritten — new item |
| [x] [`value_hultafors_db5000`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_hultafors_db5000.lua) | retained | rewritten — new item |
| [x] [`value_info_labrys`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_info_labrys.lua) | retained | rewritten — new item |
| [x] [`value_info_maps`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_info_maps.lua) | retained | rewritten — new item |
| [x] [`value_info_militaryflash`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_info_militaryflash.lua) | retained | rewritten — new item |
| [x] [`value_info_moleskine`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_info_moleskine.lua) | retained | rewritten — new item |
| [x] [`value_info_securedtape`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_info_securedtape.lua) | retained | rewritten — new item |
| [x] [`value_injector_2a2`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_injector_2a2.lua) | retained | rewritten — new item |
| [x] [`value_injector_3btg`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_injector_3btg.lua) | retained | rewritten — new item |
| [x] [`value_injector_ahf1m`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_injector_ahf1m.lua) | retained | rewritten — new item |
| [x] [`value_injector_l1`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_injector_l1.lua) | retained | rewritten — new item |
| [x] [`value_injector_mildronate`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_injector_mildronate.lua) | retained | rewritten — new item |
| [x] [`value_injector_mule`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_injector_mule.lua) | retained | rewritten — new item |
| [x] [`value_injector_obdolbos`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_injector_obdolbos.lua) | retained | rewritten — new item |
| [x] [`value_injector_obdolbos_2`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_injector_obdolbos_2.lua) | retained | rewritten — new item |
| [x] [`value_injector_p22`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_injector_p22.lua) | retained | rewritten — new item |
| [x] [`value_injector_perfotoran`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_injector_perfotoran.lua) | retained | rewritten — new item |
| [x] [`value_injector_sj12`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_injector_sj12.lua) | retained | rewritten — new item |
| [x] [`value_injector_sj9`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_injector_sj9.lua) | retained | rewritten — new item |
| [x] [`value_injector_trimadol`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_injector_trimadol.lua) | retained | rewritten — new item |
| [x] [`value_injector_xtg12`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_injector_xtg12.lua) | retained | rewritten — new item |
| [x] [`value_ipcamera`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_ipcamera.lua) | retained | rewritten — new item |
| [x] [`value_ir_ms2000`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_ir_ms2000.lua) | retained | rewritten — new item |
| [x] [`value_jamming`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_jamming.lua) | retained | rewritten — new item |
| [x] [`value_kanifol`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_kanifol.lua) | retained | rewritten — new item |
| [x] [`value_key_danexert`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_key_danexert.lua) | retained | rewritten — new item |
| [x] [`value_key_labyrinth_torch`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_key_labyrinth_torch.lua) | retained | rewritten — new item |
| [x] [`value_labyrinth_valve`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_labyrinth_valve.lua) | retained | rewritten — new item |
| [x] [`value_lamp_efficient`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_lamp_efficient.lua) | retained | rewritten — new item |
| [x] [`value_lamp_uv`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_lamp_uv.lua) | retained | rewritten — new item |
| [x] [`value_large_case`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_large_case.lua) | retained | rewritten — new item |
| [x] [`value_large_parts`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_large_parts.lua) | retained | rewritten — new item |
| [x] [`value_lcddirty`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_lcddirty.lua) | retained | rewritten — new item |
| [x] [`value_letter`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_letter.lua) | retained | rewritten — new item |
| [x] [`value_lighter_gold`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_lighter_gold.lua) | retained | rewritten — new item |
| [x] [`value_lightkeeper_amulet`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_lightkeeper_amulet.lua) | retained | rewritten — new item |
| [x] [`value_magnet`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_magnet.lua) | retained | rewritten — new item |
| [x] [`value_manual_lada`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_manual_lada.lua) | retained | rewritten — new item |
| [x] [`value_maps`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_maps.lua) | retained | rewritten — new item |
| [x] [`value_match`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_match.lua) | retained | rewritten — new item |
| [x] [`value_matches`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_matches.lua) | retained | rewritten — new item |
| [x] [`value_med_aquatabs`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_med_aquatabs.lua) | retained | rewritten — new item |
| [x] [`value_med_bloodsample`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_med_bloodsample.lua) | retained | rewritten — new item |
| [x] [`value_med_bloodset`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_med_bloodset.lua) | retained | rewritten — new item |
| [x] [`value_med_haemostatic`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_med_haemostatic.lua) | retained | rewritten — new item |
| [x] [`value_med_ibuprofen`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_med_ibuprofen.lua) | retained | rewritten — new item |
| [x] [`value_med_injectiondevice`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_med_injectiondevice.lua) | retained | rewritten — new item |
| [x] [`value_med_ledx`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_med_ledx.lua) | retained | rewritten — new item |
| [x] [`value_med_ledx_red`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_med_ledx_red.lua) | retained | rewritten — new item |
| [x] [`value_med_medicalstock`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_med_medicalstock.lua) | retained | rewritten — new item |
| [x] [`value_med_ophthalmoscope`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_med_ophthalmoscope.lua) | retained | rewritten — new item |
| [x] [`value_med_peroxide`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_med_peroxide.lua) | retained | rewritten — new item |
| [x] [`value_med_petroleumjelly`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_med_petroleumjelly.lua) | retained | rewritten — new item |
| [x] [`value_med_saline`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_med_saline.lua) | retained | rewritten — new item |
| [x] [`value_med_splint`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_med_splint.lua) | retained | rewritten — new item |
| [x] [`value_med_surgicaltools`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_med_surgicaltools.lua) | retained | rewritten — new item |
| [x] [`value_med_syringe`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_med_syringe.lua) | retained | rewritten — new item |
| [x] [`value_med_thermometer`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_med_thermometer.lua) | retained | rewritten — new item |
| [x] [`value_med_tourniquet`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_med_tourniquet.lua) | retained | rewritten — new item |
| [x] [`value_med_tourniquet_rubber`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_med_tourniquet_rubber.lua) | retained | rewritten — new item |
| [x] [`value_med_vitamins`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_med_vitamins.lua) | retained | rewritten — new item |
| [x] [`value_metalparts`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_metalparts.lua) | retained | rewritten — new item |
| [x] [`value_milimap`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_milimap.lua) | retained | rewritten — new item |
| [x] [`value_militarybattery`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_militarybattery.lua) | retained | rewritten — new item |
| [x] [`value_militaryboard`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_militaryboard.lua) | retained | rewritten — new item |
| [x] [`value_minedetector`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_minedetector.lua) | retained | rewritten — new item |
| [x] [`value_mining_kit`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_mining_kit.lua) | retained | rewritten — new item |
| [x] [`value_multitul_0`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_multitul_0.lua) | retained | rewritten — new item |
| [x] [`value_note_book_coming_closed`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_note_book_coming_closed.lua) | retained | rewritten — new item |
| [x] [`value_note_folder_closed_cardboard`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_note_folder_closed_cardboard.lua) | retained | rewritten — new item |
| [x] [`value_note_newspaper_folded_01`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_note_newspaper_folded_01.lua) | retained | rewritten — new item |
| [x] [`value_note_newspaper_folded_02`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_note_newspaper_folded_02.lua) | retained | rewritten — new item |
| [x] [`value_notepad_a5_closed_01`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_notepad_a5_closed_01.lua) | retained | rewritten — new item |
| [x] [`value_notepad_a6_closed_01`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_notepad_a6_closed_01.lua) | retained | rewritten — new item |
| [x] [`value_officepaper`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_officepaper.lua) | retained | rewritten — new item |
| [x] [`value_optical_lens`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_optical_lens.lua) | retained | rewritten — new item |
| [x] [`value_other_bage_ng`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_other_bage_ng.lua) | retained | rewritten — new item |
| [x] [`value_other_filter`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_other_filter.lua) | retained | rewritten — new item |
| [x] [`value_other_grechka`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_other_grechka.lua) | retained | rewritten — new item |
| [x] [`value_other_hosemilitary`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_other_hosemilitary.lua) | retained | rewritten — new item |
| [x] [`value_other_lupo`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_other_lupo.lua) | retained | rewritten — new item |
| [x] [`value_other_tea`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_other_tea.lua) | retained | rewritten — new item |
| [x] [`value_other_uzrgm_fuse`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_other_uzrgm_fuse.lua) | retained | rewritten — new item |
| [x] [`value_pcpart_cpu`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_pcpart_cpu.lua) | retained | rewritten — new item |
| [x] [`value_pcpart_cpufan`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_pcpart_cpufan.lua) | rewritten | rewritten — new item |
| [x] [`value_pcpart_discdrive`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_pcpart_discdrive.lua) | retained | rewritten — new item |
| [x] [`value_pcpart_laptop`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_pcpart_laptop.lua) | retained | rewritten — new item |
| [x] [`value_pcpart_ram`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_pcpart_ram.lua) | retained | rewritten — new item |
| [x] [`value_pda2`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_pda2.lua) | retained | rewritten — new item |
| [x] [`value_pda3`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_pda3.lua) | retained | rewritten — new item |
| [x] [`value_phaseantenna`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_phaseantenna.lua) | retained | rewritten — new item |
| [x] [`value_phaserelay`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_phaserelay.lua) | retained | rewritten — new item |
| [x] [`value_pipewrench`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_pipewrench.lua) | retained | rewritten — new item |
| [x] [`value_plastic`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_plastic.lua) | retained | rewritten — new item |
| [x] [`value_plexiglass`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_plexiglass.lua) | retained | rewritten — new item |
| [x] [`value_pliers`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_pliers.lua) | retained | rewritten — new item |
| [x] [`value_pocketwatch`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_pocketwatch.lua) | retained | rewritten — new item |
| [x] [`value_powercable`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_powercable.lua) | retained | rewritten — new item |
| [x] [`value_powerfilter`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_powerfilter.lua) | retained | rewritten — new item |
| [x] [`value_pressuregauge`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_pressuregauge.lua) | retained | rewritten — new item |
| [x] [`value_quest_biohazard_case`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_quest_biohazard_case.lua) | retained | rewritten — new item |
| [x] [`value_radio`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_radio.lua) | retained | rewritten — new item |
| [x] [`value_radio_repeater`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_radio_repeater.lua) | retained | rewritten — new item |
| [x] [`value_ratpoison`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_ratpoison.lua) | retained | rewritten — new item |
| [x] [`value_receiver1`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_receiver1.lua) | retained | rewritten — new item |
| [x] [`value_retardant1`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_retardant1.lua) | retained | rewritten — new item |
| [x] [`value_retardant10`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_retardant10.lua) | retained | rewritten — new item |
| [x] [`value_retardant11`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_retardant11.lua) | retained | rewritten — new item |
| [x] [`value_retardant12`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_retardant12.lua) | retained | rewritten — new item |
| [x] [`value_retardant2`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_retardant2.lua) | retained | rewritten — new item |
| [x] [`value_retardant3`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_retardant3.lua) | retained | rewritten — new item |
| [x] [`value_retardant4`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_retardant4.lua) | retained | rewritten — new item |
| [x] [`value_retardant6`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_retardant6.lua) | retained | rewritten — new item |
| [x] [`value_retardant9`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_retardant9.lua) | retained | rewritten — new item |
| [x] [`value_rfidreader`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_rfidreader.lua) | retained | rewritten — new item |
| [x] [`value_rope`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_rope.lua) | retained | rewritten — new item |
| [x] [`value_ropes`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_ropes.lua) | retained | rewritten — new item |
| [x] [`value_safe_container`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_safe_container.lua) | retained | rewritten — new item |
| [x] [`value_sas`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_sas.lua) | retained | rewritten — new item |
| [x] [`value_scanner_anomaly`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_scanner_anomaly.lua) | retained | rewritten — new item |
| [x] [`value_scanner_artefact`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_scanner_artefact.lua) | retained | rewritten — new item |
| [x] [`value_screwdriver`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_screwdriver.lua) | retained | rewritten — new item |
| [x] [`value_screws`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_screws.lua) | retained | rewritten — new item |
| [x] [`value_sensor_a`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_sensor_a.lua) | retained | rewritten — new item |
| [x] [`value_sensor_d`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_sensor_d.lua) | retained | rewritten — new item |
| [x] [`value_shampoo`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_shampoo.lua) | retained | rewritten — new item |
| [x] [`value_skullring`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_skullring.lua) | retained | rewritten — new item |
| [x] [`value_small_case`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_small_case.lua) | retained | rewritten — new item |
| [x] [`value_soap`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_soap.lua) | retained | rewritten — new item |
| [x] [`value_soda`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_soda.lua) | retained | rewritten — new item |
| [x] [`value_spec_recorder`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_spec_recorder.lua) | retained | rewritten — new item |
| [x] [`value_statue_raven`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_statue_raven.lua) | retained | rewritten — new item |
| [x] [`value_strelets_amulet`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_strelets_amulet.lua) | retained | rewritten — new item |
| [x] [`value_sugar`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_sugar.lua) | retained | rewritten — new item |
| [x] [`value_swiss`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_swiss.lua) | retained | rewritten — new item |
| [x] [`value_sz_1`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_sz_1.lua) | retained | rewritten — new item |
| [x] [`value_tapemeasure`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_tapemeasure.lua) | retained | rewritten — new item |
| [x] [`value_tarp`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_tarp.lua) | retained | rewritten — new item |
| [x] [`value_textolite`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_textolite.lua) | retained | rewritten — new item |
| [x] [`value_thermalmodule`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_thermalmodule.lua) | retained | rewritten — new item |
| [x] [`value_thick_diary`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_thick_diary.lua) | retained | rewritten — new item |
| [x] [`value_thin_diary`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_thin_diary.lua) | retained | rewritten — new item |
| [x] [`value_tools_advwrench`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_tools_advwrench.lua) | retained | rewritten — new item |
| [x] [`value_tools_metalscissors`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_tools_metalscissors.lua) | retained | rewritten — new item |
| [x] [`value_tools_nippers`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_tools_nippers.lua) | retained | rewritten — new item |
| [x] [`value_tools_pliers_round`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_tools_pliers_round.lua) | retained | rewritten — new item |
| [x] [`value_tools_ratchetwrench`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_tools_ratchetwrench.lua) | retained | rewritten — new item |
| [x] [`value_tools_screwdriver_flat`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_tools_screwdriver_flat.lua) | retained | rewritten — new item |
| [x] [`value_tools_screwdriver_flat_long`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_tools_screwdriver_flat_long.lua) | retained | rewritten — new item |
| [x] [`value_toolset`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_toolset.lua) | retained | rewritten — new item |
| [x] [`value_upgrw2`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_upgrw2.lua) | retained | rewritten — new item |
| [x] [`value_upgrw3`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_upgrw3.lua) | retained | rewritten — new item |
| [x] [`value_usb_adapter`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_usb_adapter.lua) | retained | rewritten — new item |
| [x] [`value_valuable_kresalo`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_valuable_kresalo.lua) | retained | rewritten — new item |
| [x] [`value_waste_heavy`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_waste_heavy.lua) | retained | rewritten — new item |
| [x] [`value_waste_light`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_waste_light.lua) | retained | rewritten — new item |
| [x] [`value_wd40_100ml`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_wd40_100ml.lua) | retained | rewritten — new item |
| [x] [`value_wd40_400ml`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_wd40_400ml.lua) | retained | rewritten — new item |
| [x] [`value_weaponparts`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_weaponparts.lua) | retained | rewritten — new item |
| [x] [`value_woodclock`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_woodclock.lua) | retained | rewritten — new item |
| [x] [`value_wrench`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_wrench.lua) | retained | rewritten — new item |
| [x] [`value_zibbo_0`](../gamemodes/ix_cotz/schema/items/valuables_test/sh_value_zibbo_0.lua) | retained | rewritten — new item |

### Generated playing cards

- [x] Individual cards and French Playing Cards deck: both prose fields protected and unchanged in
  [playingcards/sh_plugin.lua](../gamemodes/ix_cotz/plugins/playingcards/sh_plugin.lua).
