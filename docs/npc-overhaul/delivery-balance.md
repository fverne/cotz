# FTS item availability and delivery balance

Generated from the checked-in FTS presets and active loot definitions. No FTS command is run.

The source estimates below remain useful. The November 8 [progression policy](progression-overhaul.md)
and [current reward ledger](unlock-ledger.md) supersede the historical delivery tuning, counts and
requirement table below. Generate/check the current 639 stages with `tools/expand_progression.py`;
the legacy FTS writer cannot overwrite authored branches.

## Spawnpoint inventory

| Map | Loose regular / rare | Small / big boxes | Cycling containers | Hidden locations | Anomaly points |
| --- | ---: | ---: | ---: | ---: | ---: |
| Swamps | 525 / 82 | 238 / 244 | 138 | 74 | 78 |
| Garbage | 55 / 6 | 94 / 105 | 0 | 15 | 0 |
| Waystation | 139 / 20 | 108 / 140 | 158 | 34 | 31 |
| Pripyat | 486 / 39 | 264 / 439 | 219 | 52 | 59 |

Garbage has 61 loose-item points and 199 box points. Box custom pools are included in its supply.
Contacts use local thematic sources where configured; themes without local sources use Swamps for introductory acquisition.
Live saved map data can differ from FTS and overrides these estimates.

## Estimation method

For each item and pool: P(item) = summed positive item weights / summed positive pool weights.
An item's loose-point exposure is the sum of point count × P(item), not its raw row weight.
Rows with comments are not executed. Duplicate item rows and quantity variants are summed.

The supply index adds three modeled source rates (item entities, not pickup units):

- Loose items: 25/101 chance per eligible point every 300 seconds; a cleared-map refill is capped at 76 items.
  Approximate uniform point sampling gives 12 × min(points × 25/101, 76) selections per modeled hour.
- Boxes: 51-box cap, uniformly sampled FTS points, all boxes broken each five-minute refill.
  Small metal and paper boxes average 4/6 items; wood averages 4/4; big points choose wood/paper equally.
  Custom point pools override the material's default pool.
- Cycling containers: each appearance chooses a stash type uniformly, then rolls each listed pool once.
  The installed scheduler advances the appearance by disappearTime, so its mean period is disappearTime
  (not appearTime + disappearTime). Every appearance is assumed collected.

These are comparative full-collection opportunities, **not predicted player earnings or guaranteed drops/hour**.
World/box clearance radii, shared temporary items, map caps, blocked sites, competition and missed cache windows
reduce real supply. Combining isolated caps is an optimistic comparison, not a simultaneous throughput simulation.
Passive containers are counted separately but omitted from rates: their chance depends on player count and occupancy.
Hidden-stash locations are destinations, not independent loot rolls. They have no location-based spawn rate.
Human drops, harvests, event rewards and anomaly artifacts are not assigned invented encounter rates.
New finite hand-in pools use only items with positive quantified world/box/cycling exposure.

Hand-in units use row quantity overrides, configured OnInstanced yield bounds, then item quantity/ammoAmount.
The index counts entities for search rarity; batch size is considered separately when setting quantities.

Missing referenced pool names use the installed randomitem default fallback; these are reported rather than fixed:
`cache_ammo_pistol_tier3`, `cache_weapon_pistol_tier1`, `worldspawn_`.

### FTS pool point counts

| Map | Pool | Points |
| --- | --- | ---: |
| Swamps | `worldspawn_1` | 525 |
| Swamps | `worldspawn_2` | 82 |
| Garbage | `worldspawn_garbage_rare` | 6 |
| Garbage | `worldspawn_garbage_regular` | 55 |
| Waystation | `worldspawn_3` | 139 |
| Waystation | `worldspawn_4` | 20 |
| Pripyat | `worldspawn_5` | 486 |
| Pripyat | `worldspawn_6` | 39 |

### Cycling categories

| Map | Category | Locations | Mean appearance interval (seconds) |
| --- | --- | ---: | ---: |
| Swamps | `barrel_easy` | 16 | 10800 |
| Swamps | `barrel_hard` | 4 | 16200 |
| Swamps | `cache_cbt` | 1 | 25000 |
| Swamps | `cache_easy` | 10 | 15600 |
| Swamps | `cache_hard` | 4 | 21500 |
| Swamps | `stash_map1` | 103 | 3600 |
| Waystation | `barrel_easy` | 21 | 10800 |
| Waystation | `barrel_hard` | 1 | 16200 |
| Waystation | `cache_cbt` | 3 | 25000 |
| Waystation | `cache_easy` | 1 | 15600 |
| Waystation | `cache_hard` | 9 | 21500 |
| Waystation | `stash_map2` | 123 | 3600 |
| Pripyat | `cache_hard` | 46 | 21500 |
| Pripyat | `stash_map3` | 173 | 3600 |

## Relative rarity examples

Rates below sum the configured map presets at equal full-collection effort.
Ratios are item-entity frequency ratios; a loose ammo box and one round are not treated as the same unit.

| Item | Entity supply index | Relative to bolts | Source maps |
| --- | ---: | ---: | --- |
| `value_bolts` | 41.808 | 1.0× rarer | Swamps, Waystation, Pripyat |
| `value_battery` | 43.219 | 1.0× rarer | Swamps, Waystation |
| `value_wire_copper` | 24.364 | 1.7× rarer | Swamps, Pripyat |
| `medic_bandage_1` | 20.502 | 2.0× rarer | Swamps |
| `value_airfilter` | 12.147 | 3.4× rarer | Swamps, Waystation |
| `food_can_beans` | 6.492 | 6.4× rarer | Swamps, Waystation, Pripyat |
| `value_sensor_a` | 10.629 | 3.9× rarer | Swamps, Waystation |
| `value_controller` | 3.194 | 13.1× rarer | Pripyat |
| `value_pcpart_laptop` | 1.759 | 23.8× rarer | Pripyat |
| `value_med_surgicaltools` | 0.895 | 46.7× rarer | Waystation |
| `value_goldchain` | 0.796 | 52.5× rarer | Swamps, Waystation, Pripyat |

The full per-item/per-map/source estimates and quantities are in [fts-item-availability.json](fts-item-availability.json).

## Delivery difficulty

All 327 finite delivery milestones are retuned; repeatable jobs, field commissions and arena bouts keep their mechanics.
Local prerequisite depth / deepest storyline node determines the phase, so optional sibling branches are not assumed complete.
Cross-contact gates remain unchanged; depth measures only the contact's own prerequisite graph.

| Storyline depth | Distinct requested items | Common → specialist batch multiples |
| --- | ---: | --- |
| First 20% | 1 | 1 |
| 20–45% | 2 | 2 + 1 |
| 45–75% | 3 | 3 + 2 + 1 |
| Final 25% | 4 | 4 + 3 + 2 + 1 |

Every theme/home-map pair has four disjoint pools. Availability score weights the home region 1.0,
the other early region 0.3, and Pripyat 0.1 to account for travel. These planning factors are explicit design choices,
not measured travel times. Candidates are sorted by that score and divided into four bands.
A maximum of three candidates from each source category preserves thematic variety. Categories can overlap; IDs are deduplicated.
Candidates with less than 0.1 aggregate entity opportunities per modeled hour are excluded from mandatory requests.
Every introductory candidate has a source in its starting region. Themes without local sources use Swamps as a proxy.
Later pools extend to less available and more distant material; rare bands are added at low quantity while common stock grows.
Each band quantity is its batch multiple times the smallest mean natural unit batch among that band's candidates, rounded down
with a one-unit minimum. This preserves meaningful ammunition counts without demanding full-capacity salvage stacks.

Progression IDs, prerequisites, payouts, benefits and accepted requirement rolls are preserved. Existing saved requirements
are not rerolled; the retuning applies when an unassigned milestone first receives its saved item selections.

## Availability bands

| Theme / starting region | Band | Candidates (item IDs) |
| --- | ---: | --- |
| collectibles / Swamps | 1 | `value_flyer_01`, `value_flyer_03`, `value_gamemagazine_01`, `value_crow_beak` |
| collectibles / Swamps | 2 | `value_bear_souvenir`, `value_info_moleskine`, `value_statue_cat`, `value_maps` |
| collectibles / Swamps | 3 | `value_lightkeeper_amulet`, `value_thick_diary`, `value_statue_lion`, `value_statue_horse` |
| collectibles / Swamps | 4 | `value_skullring`, `value_lighter_gold`, `value_watch`, `value_goldchain` |
| electronics / Swamps | 1 | `value_battery`, `value_9vbattery`, `value_wire_copper`, `value_capacitors`, `value_tape_electric`, `value_sparkplug`, `value_wire_light` |
| electronics / Swamps | 2 | `value_receiver1`, `value_battery_d_0`, `value_ir_ms2000`, `value_radio`, `value_flash_card_slider`, `value_circuitboard`, `value_flash_card_ironkey` |
| electronics / Swamps | 3 | `value_flash_card_ironkey_slider`, `value_electr_components`, `value_electr_card_programmer`, `value_pcpart_cpufan`, `value_pcpart_discdrive`, `value_pcpart_ram`, `value_ipcamera` |
| electronics / Swamps | 4 | `value_pda2`, `value_pda3`, `value_phaserelay`, `value_controller`, `value_electr_adv_converter`, `value_electr_adv_controller`, `value_electr_adv_ultralink`, `value_pcpart_laptop` |
| electronics / Waystation | 1 | `value_battery`, `value_9vbattery`, `value_tape_electric`, `value_wire_light`, `value_sparkplug`, `value_capacitors`, `value_receiver1` |
| electronics / Waystation | 2 | `value_battery_d_0`, `value_ir_ms2000`, `value_radio`, `value_wire_copper`, `value_flash_card_slider`, `value_circuitboard`, `value_flash_card_ironkey` |
| electronics / Waystation | 3 | `value_flash_card_ironkey_slider`, `value_electr_components`, `value_electr_card_programmer`, `value_pcpart_cpufan`, `value_pcpart_discdrive`, `value_pcpart_ram`, `value_ipcamera` |
| electronics / Waystation | 4 | `value_pda2`, `value_pda3`, `value_phaserelay`, `value_controller`, `value_electr_adv_converter`, `value_electr_adv_controller`, `value_electr_adv_ultralink`, `value_pcpart_laptop` |
| kitchen / Swamps | 1 | `value_detergent`, `value_bleach`, `value_other_lupo`, `value_coffee`, `value_other_grechka` |
| kitchen / Swamps | 2 | `value_soap`, `food_bread`, `food_raisins`, `food_sausage_1`, `food_sausage_2` |
| kitchen / Swamps | 3 | `drink_orangejuice`, `drink_canwater`, `food_can_beans`, `food_can_sprats`, `food_can_tuna` |
| kitchen / Swamps | 4 | `food_can_tushonka`, `drink_bottlewater`, `food_mre_ukraine`, `food_mre_russia`, `food_mre_usa` |
| medical / Swamps | 1 | `medic_bandage_1`, `medic_medkit_1`, `value_med_petroleumjelly`, `value_med_peroxide` |
| medical / Swamps | 2 | `value_med_vitamins`, `value_other_hosemilitary`, `value_airfilter`, `value_other_filter` |
| medical / Swamps | 3 | `value_med_haemostatic`, `value_med_tourniquet`, `value_med_thermometer`, `value_injector_obdolbos` |
| medical / Swamps | 4 | `value_med_bloodset`, `value_injector_2a2`, `value_injector_3btg`, `value_med_surgicalpouch`, `value_med_surgicaltools` |
| military / Garbage | 1 | `value_ballistic4`, `value_container_lopouch` |
| military / Garbage | 2 | `9x18`, `545x39`, `value_container_injectorcase`, `556x45`, `value_ballistic11`, `value_ballistic6` |
| military / Garbage | 3 | `value_docbag`, `value_retardant3`, `value_retardant4`, `value_retardant9`, `value_flammable_trotil` |
| military / Garbage | 4 | `value_balloon_poison_gas`, `value_other_uzrgm_fuse`, `value_container_ammo`, `value_container_weaponcase`, `value_safe_container`, `value_container_parls` |
| military / Waystation | 1 | `762x39`, `12gauge`, `9x19`, `9x18`, `545x39` |
| military / Waystation | 2 | `value_retardant3`, `value_retardant4`, `value_retardant9`, `value_flammable_trotil`, `value_balloon_poison_gas`, `value_other_uzrgm_fuse` |
| military / Waystation | 3 | `value_container_ammo`, `value_ballistic4`, `value_container_lopouch`, `556x45`, `value_container_injectorcase` |
| military / Waystation | 4 | `value_ballistic11`, `value_container_weaponcase`, `value_safe_container`, `value_ballistic6`, `value_container_parls`, `value_docbag` |
| records / Waystation | 1 | `value_documents_5`, `value_documents_6`, `value_documents_7`, `value_documents_4`, `value_documents_12`, `value_documents_3` |
| records / Waystation | 2 | `value_maps`, `value_officepaper`, `value_thick_diary`, `value_note_book_coming_closed`, `value_archive_cassette`, `value_documents_1`, `value_milimap` |
| records / Waystation | 3 | `value_cassette_black90`, `value_cassette_fiolet`, `value_manual_lada`, `value_flyer_01`, `value_flyer_03`, `value_note_folder_closed_cardboard` |
| records / Waystation | 4 | `value_notepad_a6_closed_01`, `value_guide`, `value_clothbook1`, `value_documents_2`, `value_info_securedtape`, `value_documents_10`, `value_documents_11` |
| research / Swamps | 1 | `value_battery`, `value_9vbattery`, `value_wire_copper`, `value_capacitors`, `value_wire_light`, `value_other_hosemilitary` |
| research / Swamps | 2 | `value_airfilter`, `value_other_filter`, `value_sensor_a`, `value_battery_d_0`, `value_portable_container_opened`, `value_chemcontainer`, `value_injector_obdolbos` |
| research / Swamps | 3 | `value_injector_p22`, `value_portable_container_closed`, `value_injector_2a2`, `value_injector_3btg`, `value_injector_perfotoran`, `value_injector_trimadol`, `value_pressuregauge` |
| research / Swamps | 4 | `value_chemicalsample`, `value_anomaly_plant`, `value_sensor_d`, `value_med_bloodsample`, `value_casezerogeo`, `value_detector`, `value_geigercounter` |
| research / Waystation | 1 | `value_battery`, `value_9vbattery`, `value_other_hosemilitary`, `value_airfilter`, `value_other_filter`, `value_wire_light` |
| research / Waystation | 2 | `value_sensor_a`, `value_capacitors`, `value_battery_d_0`, `value_portable_container_opened`, `value_chemcontainer`, `value_portable_container_closed`, `value_wire_copper` |
| research / Waystation | 3 | `value_pressuregauge`, `value_injector_obdolbos`, `value_injector_p22`, `value_injector_2a2`, `value_injector_3btg`, `value_injector_perfotoran`, `value_injector_trimadol` |
| research / Waystation | 4 | `value_sensor_d`, `value_casezerogeo`, `value_detector`, `value_geigercounter`, `value_chemicalsample`, `value_anomaly_plant`, `value_med_bloodsample` |
| textiles / Swamps | 1 | `value_paracord`, `value_tape_duct`, `value_bedspread`, `value_rope` |
| textiles / Swamps | 2 | `value_fabrics2`, `value_ballistic4`, `value_container_lopouch`, `value_parcel`, `value_container_junkbox` |
| textiles / Swamps | 3 | `value_retardant3`, `value_retardant4`, `value_retardant9`, `value_large_case`, `value_container_injectorcase` |
| textiles / Swamps | 4 | `value_carbon_case`, `value_knife_box_low`, `value_ballistic11`, `value_ballistic6`, `value_docbag` |
| textiles / Waystation | 1 | `value_paracord`, `value_retardant3`, `value_retardant4`, `value_retardant9`, `value_tape_duct` |
| textiles / Waystation | 2 | `value_ballistic4`, `value_container_lopouch`, `value_fabric_fleece`, `value_parcel`, `value_container_junkbox` |
| textiles / Waystation | 3 | `value_fabric_aramid`, `value_bedspread`, `value_rope`, `value_large_case`, `value_container_injectorcase` |
| textiles / Waystation | 4 | `value_carbon_case`, `value_knife_box_low`, `value_ballistic11`, `value_ballistic6`, `value_docbag` |
| trade / Swamps | 1 | `value_other_lupo`, `value_coffee`, `value_other_grechka`, `value_crow_beak` |
| trade / Swamps | 2 | `value_bear_souvenir`, `value_lightkeeper_amulet`, `value_container_lopouch`, `drink_orangejuice`, `value_skullring` |
| trade / Swamps | 3 | `drink_canwater`, `food_can_beans`, `food_can_sprats`, `food_can_tuna`, `value_lighter_gold` |
| trade / Swamps | 4 | `value_container_injectorcase`, `drink_bottlewater`, `value_docbag`, `value_watch`, `value_goldchain` |
| trail / Garbage | 1 | `value_gunoil`, `value_container_lopouch`, `value_bleach`, `value_glasscleaner`, `value_parcel` |
| trail / Garbage | 2 | `value_shampoo`, `value_wire_light`, `value_container_injectorcase`, `value_carbon_case`, `value_knife_box_low`, `value_gasoline` |
| trail / Garbage | 3 | `value_kerosene`, `value_propanetank`, `value_docbag`, `value_retardant3`, `value_retardant4`, `value_retardant9` |
| trail / Garbage | 4 | `food_can_beans`, `food_can_sprats`, `food_can_tuna`, `value_casezerogeo`, `value_detector`, `value_geigercounter` |
| trail / Swamps | 1 | `value_detergent`, `value_gunoil`, `value_tape_electric`, `value_wire_light`, `value_toiletpaper`, `value_toothpaste` |
| trail / Swamps | 2 | `value_kerosene`, `value_gasoline`, `value_propanetank`, `value_container_lopouch`, `value_parcel`, `food_can_beans` |
| trail / Swamps | 3 | `food_can_sprats`, `food_can_tuna`, `value_retardant3`, `value_retardant4`, `value_retardant9`, `value_container_injectorcase` |
| trail / Swamps | 4 | `value_carbon_case`, `value_knife_box_low`, `value_docbag`, `value_casezerogeo`, `value_detector`, `value_geigercounter` |
| utilities / Swamps | 1 | `value_bolts`, `value_nuts`, `value_wire_copper`, `value_detergent` |
| utilities / Swamps | 2 | `value_tape_electric`, `value_sparkplug`, `value_toiletpaper`, `value_toothpaste`, `value_metalparts`, `value_waste_heavy` |
| utilities / Swamps | 3 | `value_kerosene`, `value_gasoline`, `value_propanetank`, `value_other_hosemilitary`, `value_powercable`, `value_airfilter` |
| utilities / Swamps | 4 | `value_other_filter`, `value_battery_d_0`, `value_lamp_efficient`, `value_magnet`, `value_energy_cyclon`, `value_energy_accum` |
| workshop / Garbage | 1 | `value_screws`, `value_metalparts`, `value_tools_advwrench`, `value_waste_heavy`, `value_tools_metalscissors`, `value_tapemeasure` |
| workshop / Garbage | 2 | `value_tools_ratchetwrench`, `value_mining_kit`, `value_wrench`, `value_hultafors_db5000`, `value_bolts`, `value_nuts`, `value_pliers` |
| workshop / Garbage | 3 | `value_tools_pliers_round`, `value_tape_electric`, `value_glue_3`, `value_glue_4`, `value_glue_2`, `value_wire_light`, `value_sparkplug` |
| workshop / Garbage | 4 | `value_siliconetube`, `value_hose`, `value_lightbulb`, `value_sensor_a`, `value_pressuregauge`, `value_techtool_1`, `value_sensor_d` |
| workshop / Swamps | 1 | `value_bolts`, `value_nuts`, `value_glue_3`, `value_glue_2`, `value_glue_4` |
| workshop / Swamps | 2 | `value_wire_copper`, `value_tape_electric`, `value_sparkplug`, `value_hose`, `value_lightbulb`, `value_siliconetube`, `value_metalparts` |
| workshop / Swamps | 3 | `value_tools_advwrench`, `value_waste_heavy`, `value_tools_metalscissors`, `value_tapemeasure`, `value_tools_ratchetwrench`, `value_mining_kit`, `value_wrench` |
| workshop / Swamps | 4 | `value_hultafors_db5000`, `value_sensor_a`, `value_pliers`, `value_techtool_1`, `value_tools_pliers_round`, `value_pressuregauge`, `value_sensor_d` |

## Current finite delivery requirements

| Contact | Milestone | Phase | Pool × required units |
| --- | --- | ---: | --- |
| arena-master | AR01 | 1 | `town_delivery_medical_marsh_1` × 1 |
| arena-master | AR05 | 2 | `town_delivery_medical_marsh_1` × 2; `town_delivery_medical_marsh_2` × 1 |
| arena-master | AR09 | 2 | `town_delivery_medical_marsh_1` × 2; `town_delivery_medical_marsh_2` × 1 |
| arena-master | AR10 | 2 | `town_delivery_medical_marsh_1` × 2; `town_delivery_medical_marsh_2` × 1 |
| arena-master | AR13 | 3 | `town_delivery_medical_marsh_1` × 3; `town_delivery_medical_marsh_2` × 2; `town_delivery_medical_marsh_3` × 1 |
| arena-master | AR17 | 3 | `town_delivery_medical_marsh_1` × 3; `town_delivery_medical_marsh_2` × 2; `town_delivery_medical_marsh_3` × 1 |
| arena-master | AR21 | 4 | `town_delivery_medical_marsh_1` × 4; `town_delivery_medical_marsh_2` × 3; `town_delivery_medical_marsh_3` × 2; `town_delivery_medical_marsh_4` × 1 |
| arena-master | AR22 | 4 | `town_delivery_medical_marsh_1` × 4; `town_delivery_medical_marsh_2` × 3; `town_delivery_medical_marsh_3` × 2; `town_delivery_medical_marsh_4` × 1 |
| atlas | AT01 | 1 | `town_delivery_research_marsh_1` × 1 |
| atlas | AT04 | 1 | `town_delivery_research_marsh_1` × 1 |
| atlas | AT05 | 2 | `town_delivery_research_marsh_1` × 2; `town_delivery_research_marsh_2` × 1 |
| atlas | AT08 | 2 | `town_delivery_research_marsh_1` × 2; `town_delivery_research_marsh_2` × 1 |
| atlas | AT09 | 2 | `town_delivery_research_marsh_1` × 2; `town_delivery_research_marsh_2` × 1 |
| atlas | AT12 | 3 | `town_delivery_research_marsh_1` × 3; `town_delivery_research_marsh_2` × 2; `town_delivery_research_marsh_3` × 1 |
| atlas | AT13 | 3 | `town_delivery_research_marsh_1` × 3; `town_delivery_research_marsh_2` × 2; `town_delivery_research_marsh_3` × 1 |
| atlas | AT16 | 3 | `town_delivery_research_marsh_1` × 3; `town_delivery_research_marsh_2` × 2; `town_delivery_research_marsh_3` × 1 |
| atlas | AT17 | 3 | `town_delivery_research_marsh_1` × 3; `town_delivery_research_marsh_2` × 2; `town_delivery_research_marsh_3` × 1 |
| atlas | AT20 | 4 | `town_delivery_research_marsh_1` × 4; `town_delivery_research_marsh_2` × 3; `town_delivery_research_marsh_3` × 2; `town_delivery_research_marsh_4` × 1 |
| atlas | AT21 | 4 | `town_delivery_research_marsh_1` × 4; `town_delivery_research_marsh_2` × 3; `town_delivery_research_marsh_3` × 2; `town_delivery_research_marsh_4` × 1 |
| atlas | AT22 | 4 | `town_delivery_research_marsh_1` × 4; `town_delivery_research_marsh_2` × 3; `town_delivery_research_marsh_3` × 2; `town_delivery_research_marsh_4` × 1 |
| ballast | BA01 | 1 | `town_delivery_textiles_marsh_1` × 1 |
| ballast | BA04 | 1 | `town_delivery_textiles_marsh_1` × 1 |
| ballast | BA05 | 2 | `town_delivery_textiles_marsh_1` × 2; `town_delivery_textiles_marsh_2` × 1 |
| ballast | BA08 | 2 | `town_delivery_textiles_marsh_1` × 2; `town_delivery_textiles_marsh_2` × 1 |
| ballast | BA09 | 2 | `town_delivery_textiles_marsh_1` × 2; `town_delivery_textiles_marsh_2` × 1 |
| ballast | BA12 | 3 | `town_delivery_textiles_marsh_1` × 3; `town_delivery_textiles_marsh_2` × 2; `town_delivery_textiles_marsh_3` × 1 |
| ballast | BA13 | 3 | `town_delivery_textiles_marsh_1` × 3; `town_delivery_textiles_marsh_2` × 2; `town_delivery_textiles_marsh_3` × 1 |
| ballast | BA16 | 3 | `town_delivery_textiles_marsh_1` × 3; `town_delivery_textiles_marsh_2` × 2; `town_delivery_textiles_marsh_3` × 1 |
| ballast | BA17 | 3 | `town_delivery_textiles_marsh_1` × 3; `town_delivery_textiles_marsh_2` × 2; `town_delivery_textiles_marsh_3` × 1 |
| ballast | BA20 | 4 | `town_delivery_textiles_marsh_1` × 4; `town_delivery_textiles_marsh_2` × 3; `town_delivery_textiles_marsh_3` × 2; `town_delivery_textiles_marsh_4` × 1 |
| ballast | BA21 | 4 | `town_delivery_textiles_marsh_1` × 4; `town_delivery_textiles_marsh_2` × 3; `town_delivery_textiles_marsh_3` × 2; `town_delivery_textiles_marsh_4` × 1 |
| ballast | BA22 | 4 | `town_delivery_textiles_marsh_1` × 4; `town_delivery_textiles_marsh_2` × 3; `town_delivery_textiles_marsh_3` × 2; `town_delivery_textiles_marsh_4` × 1 |
| beanstalk | BN01 | 1 | `town_delivery_research_marsh_1` × 1 |
| beanstalk | BN04 | 1 | `town_delivery_research_marsh_1` × 1 |
| beanstalk | BN05 | 1 | `town_delivery_research_marsh_1` × 1 |
| beanstalk | BN08 | 2 | `town_delivery_research_marsh_1` × 2; `town_delivery_research_marsh_2` × 1 |
| beanstalk | BN09 | 2 | `town_delivery_research_marsh_1` × 2; `town_delivery_research_marsh_2` × 1 |
| beanstalk | BN12 | 2 | `town_delivery_research_marsh_1` × 2; `town_delivery_research_marsh_2` × 1 |
| beanstalk | BN13 | 2 | `town_delivery_research_marsh_1` × 2; `town_delivery_research_marsh_2` × 1 |
| beanstalk | BN16 | 3 | `town_delivery_research_marsh_1` × 3; `town_delivery_research_marsh_2` × 2; `town_delivery_research_marsh_3` × 1 |
| beanstalk | BN17 | 3 | `town_delivery_research_marsh_1` × 3; `town_delivery_research_marsh_2` × 2; `town_delivery_research_marsh_3` × 1 |
| beanstalk | BN20 | 4 | `town_delivery_research_marsh_1` × 4; `town_delivery_research_marsh_2` × 3; `town_delivery_research_marsh_3` × 2; `town_delivery_research_marsh_4` × 1 |
| beanstalk | BN21 | 4 | `town_delivery_research_marsh_1` × 4; `town_delivery_research_marsh_2` × 3; `town_delivery_research_marsh_3` × 2; `town_delivery_research_marsh_4` × 1 |
| beanstalk | BN24 | 4 | `town_delivery_research_marsh_1` × 4; `town_delivery_research_marsh_2` × 3; `town_delivery_research_marsh_3` × 2; `town_delivery_research_marsh_4` × 1 |
| boss | BO01 | 1 | `town_delivery_military_waystation_1` × 9 |
| boss | BO04 | 2 | `town_delivery_military_waystation_1` × 18; `town_delivery_military_waystation_2` × 1 |
| boss | BO05 | 2 | `town_delivery_military_waystation_1` × 18; `town_delivery_military_waystation_2` × 1 |
| boss | BO08 | 2 | `town_delivery_military_waystation_1` × 18; `town_delivery_military_waystation_2` × 1 |
| boss | BO09 | 2 | `town_delivery_military_waystation_1` × 18; `town_delivery_military_waystation_2` × 1 |
| boss | BO12 | 3 | `town_delivery_military_waystation_1` × 27; `town_delivery_military_waystation_2` × 2; `town_delivery_military_waystation_3` × 1 |
| boss | BO13 | 3 | `town_delivery_military_waystation_1` × 27; `town_delivery_military_waystation_2` × 2; `town_delivery_military_waystation_3` × 1 |
| boss | BO16 | 3 | `town_delivery_military_waystation_1` × 27; `town_delivery_military_waystation_2` × 2; `town_delivery_military_waystation_3` × 1 |
| boss | BO17 | 3 | `town_delivery_military_waystation_1` × 27; `town_delivery_military_waystation_2` × 2; `town_delivery_military_waystation_3` × 1 |
| boss | BO20 | 4 | `town_delivery_military_waystation_1` × 36; `town_delivery_military_waystation_2` × 3; `town_delivery_military_waystation_3` × 2; `town_delivery_military_waystation_4` × 1 |
| boss | BO21 | 4 | `town_delivery_military_waystation_1` × 36; `town_delivery_military_waystation_2` × 3; `town_delivery_military_waystation_3` × 2; `town_delivery_military_waystation_4` × 1 |
| boss | BO22 | 4 | `town_delivery_military_waystation_1` × 36; `town_delivery_military_waystation_2` × 3; `town_delivery_military_waystation_3` × 2; `town_delivery_military_waystation_4` × 1 |
| brass | BR01 | 1 | `town_delivery_military_garbage_1` × 1 |
| brass | BR04 | 2 | `town_delivery_military_garbage_1` × 2; `town_delivery_military_garbage_2` × 1 |
| brass | BR05 | 2 | `town_delivery_military_garbage_1` × 2; `town_delivery_military_garbage_2` × 1 |
| brass | BR08 | 2 | `town_delivery_military_garbage_1` × 2; `town_delivery_military_garbage_2` × 1 |
| brass | BR09 | 2 | `town_delivery_military_garbage_1` × 2; `town_delivery_military_garbage_2` × 1 |
| brass | BR12 | 3 | `town_delivery_military_garbage_1` × 3; `town_delivery_military_garbage_2` × 2; `town_delivery_military_garbage_3` × 1 |
| brass | BR13 | 3 | `town_delivery_military_garbage_1` × 3; `town_delivery_military_garbage_2` × 2; `town_delivery_military_garbage_3` × 1 |
| brass | BR16 | 3 | `town_delivery_military_garbage_1` × 3; `town_delivery_military_garbage_2` × 2; `town_delivery_military_garbage_3` × 1 |
| brass | BR17 | 3 | `town_delivery_military_garbage_1` × 3; `town_delivery_military_garbage_2` × 2; `town_delivery_military_garbage_3` × 1 |
| brass | BR20 | 3 | `town_delivery_military_garbage_1` × 3; `town_delivery_military_garbage_2` × 2; `town_delivery_military_garbage_3` × 1 |
| brass | BR21 | 4 | `town_delivery_military_garbage_1` × 4; `town_delivery_military_garbage_2` × 3; `town_delivery_military_garbage_3` × 2; `town_delivery_military_garbage_4` × 1 |
| brass | BR24 | 4 | `town_delivery_military_garbage_1` × 4; `town_delivery_military_garbage_2` × 3; `town_delivery_military_garbage_3` × 2; `town_delivery_military_garbage_4` × 1 |
| carbon | CA01 | 1 | `town_delivery_records_waystation_1` × 1 |
| carbon | CA04 | 1 | `town_delivery_records_waystation_1` × 1 |
| carbon | CA05 | 2 | `town_delivery_records_waystation_1` × 2; `town_delivery_records_waystation_2` × 1 |
| carbon | CA08 | 2 | `town_delivery_records_waystation_1` × 2; `town_delivery_records_waystation_2` × 1 |
| carbon | CA09 | 2 | `town_delivery_records_waystation_1` × 2; `town_delivery_records_waystation_2` × 1 |
| carbon | CA12 | 2 | `town_delivery_records_waystation_1` × 2; `town_delivery_records_waystation_2` × 1 |
| carbon | CA13 | 3 | `town_delivery_records_waystation_1` × 3; `town_delivery_records_waystation_2` × 2; `town_delivery_records_waystation_3` × 1 |
| carbon | CA16 | 3 | `town_delivery_records_waystation_1` × 3; `town_delivery_records_waystation_2` × 2; `town_delivery_records_waystation_3` × 1 |
| carbon | CA17 | 3 | `town_delivery_records_waystation_1` × 3; `town_delivery_records_waystation_2` × 2; `town_delivery_records_waystation_3` × 1 |
| carbon | CA20 | 4 | `town_delivery_records_waystation_1` × 4; `town_delivery_records_waystation_2` × 3; `town_delivery_records_waystation_3` × 2; `town_delivery_records_waystation_4` × 1 |
| carbon | CA21 | 4 | `town_delivery_records_waystation_1` × 4; `town_delivery_records_waystation_2` × 3; `town_delivery_records_waystation_3` × 2; `town_delivery_records_waystation_4` × 1 |
| carbon | CA22 | 4 | `town_delivery_records_waystation_1` × 4; `town_delivery_records_waystation_2` × 3; `town_delivery_records_waystation_3` × 2; `town_delivery_records_waystation_4` × 1 |
| cleaner | CL01 | 1 | `town_delivery_trail_garbage_1` × 1 |
| cleaner | CL04 | 1 | `town_delivery_trail_garbage_1` × 1 |
| cleaner | CL05 | 2 | `town_delivery_trail_garbage_1` × 2; `town_delivery_trail_garbage_2` × 1 |
| cleaner | CL08 | 2 | `town_delivery_trail_garbage_1` × 2; `town_delivery_trail_garbage_2` × 1 |
| cleaner | CL09 | 2 | `town_delivery_trail_garbage_1` × 2; `town_delivery_trail_garbage_2` × 1 |
| cleaner | CL12 | 2 | `town_delivery_trail_garbage_1` × 2; `town_delivery_trail_garbage_2` × 1 |
| cleaner | CL13 | 3 | `town_delivery_trail_garbage_1` × 3; `town_delivery_trail_garbage_2` × 2; `town_delivery_trail_garbage_3` × 1 |
| cleaner | CL16 | 3 | `town_delivery_trail_garbage_1` × 3; `town_delivery_trail_garbage_2` × 2; `town_delivery_trail_garbage_3` × 1 |
| cleaner | CL17 | 3 | `town_delivery_trail_garbage_1` × 3; `town_delivery_trail_garbage_2` × 2; `town_delivery_trail_garbage_3` × 1 |
| cleaner | CL20 | 3 | `town_delivery_trail_garbage_1` × 3; `town_delivery_trail_garbage_2` × 2; `town_delivery_trail_garbage_3` × 1 |
| cleaner | CL21 | 3 | `town_delivery_trail_garbage_1` × 3; `town_delivery_trail_garbage_2` × 2; `town_delivery_trail_garbage_3` × 1 |
| cleaner | CL24 | 4 | `town_delivery_trail_garbage_1` × 4; `town_delivery_trail_garbage_2` × 3; `town_delivery_trail_garbage_3` × 2; `town_delivery_trail_garbage_4` × 1 |
| cleaner | CL25 | 4 | `town_delivery_trail_garbage_1` × 4; `town_delivery_trail_garbage_2` × 3; `town_delivery_trail_garbage_3` × 2; `town_delivery_trail_garbage_4` × 1 |
| cleaner | CL28 | 4 | `town_delivery_trail_garbage_1` × 4; `town_delivery_trail_garbage_2` × 3; `town_delivery_trail_garbage_3` × 2; `town_delivery_trail_garbage_4` × 1 |
| egghead | EG01 | 1 | `town_delivery_research_waystation_1` × 1 |
| egghead | EG04 | 1 | `town_delivery_research_waystation_1` × 1 |
| egghead | EG05 | 2 | `town_delivery_research_waystation_1` × 2; `town_delivery_research_waystation_2` × 1 |
| egghead | EG08 | 2 | `town_delivery_research_waystation_1` × 2; `town_delivery_research_waystation_2` × 1 |
| egghead | EG09 | 2 | `town_delivery_research_waystation_1` × 2; `town_delivery_research_waystation_2` × 1 |
| egghead | EG12 | 2 | `town_delivery_research_waystation_1` × 2; `town_delivery_research_waystation_2` × 1 |
| egghead | EG13 | 3 | `town_delivery_research_waystation_1` × 3; `town_delivery_research_waystation_2` × 2; `town_delivery_research_waystation_3` × 1 |
| egghead | EG16 | 3 | `town_delivery_research_waystation_1` × 3; `town_delivery_research_waystation_2` × 2; `town_delivery_research_waystation_3` × 1 |
| egghead | EG17 | 3 | `town_delivery_research_waystation_1` × 3; `town_delivery_research_waystation_2` × 2; `town_delivery_research_waystation_3` × 1 |
| egghead | EG20 | 3 | `town_delivery_research_waystation_1` × 3; `town_delivery_research_waystation_2` × 2; `town_delivery_research_waystation_3` × 1 |
| egghead | EG21 | 3 | `town_delivery_research_waystation_1` × 3; `town_delivery_research_waystation_2` × 2; `town_delivery_research_waystation_3` × 1 |
| egghead | EG24 | 4 | `town_delivery_research_waystation_1` × 4; `town_delivery_research_waystation_2` × 3; `town_delivery_research_waystation_3` × 2; `town_delivery_research_waystation_4` × 1 |
| egghead | EG25 | 4 | `town_delivery_research_waystation_1` × 4; `town_delivery_research_waystation_2` × 3; `town_delivery_research_waystation_3` × 2; `town_delivery_research_waystation_4` × 1 |
| egghead | EG26 | 4 | `town_delivery_research_waystation_1` × 4; `town_delivery_research_waystation_2` × 3; `town_delivery_research_waystation_3` × 2; `town_delivery_research_waystation_4` × 1 |
| gasket | GK01 | 1 | `town_delivery_utilities_marsh_1` × 1 |
| gasket | GK04 | 2 | `town_delivery_utilities_marsh_1` × 2; `town_delivery_utilities_marsh_2` × 1 |
| gasket | GK05 | 2 | `town_delivery_utilities_marsh_1` × 2; `town_delivery_utilities_marsh_2` × 1 |
| gasket | GK08 | 2 | `town_delivery_utilities_marsh_1` × 2; `town_delivery_utilities_marsh_2` × 1 |
| gasket | GK09 | 2 | `town_delivery_utilities_marsh_1` × 2; `town_delivery_utilities_marsh_2` × 1 |
| gasket | GK12 | 3 | `town_delivery_utilities_marsh_1` × 3; `town_delivery_utilities_marsh_2` × 2; `town_delivery_utilities_marsh_3` × 1 |
| gasket | GK13 | 3 | `town_delivery_utilities_marsh_1` × 3; `town_delivery_utilities_marsh_2` × 2; `town_delivery_utilities_marsh_3` × 1 |
| gasket | GK16 | 3 | `town_delivery_utilities_marsh_1` × 3; `town_delivery_utilities_marsh_2` × 2; `town_delivery_utilities_marsh_3` × 1 |
| gasket | GK17 | 3 | `town_delivery_utilities_marsh_1` × 3; `town_delivery_utilities_marsh_2` × 2; `town_delivery_utilities_marsh_3` × 1 |
| gasket | GK20 | 4 | `town_delivery_utilities_marsh_1` × 4; `town_delivery_utilities_marsh_2` × 3; `town_delivery_utilities_marsh_3` × 2; `town_delivery_utilities_marsh_4` × 1 |
| gasket | GK21 | 4 | `town_delivery_utilities_marsh_1` × 4; `town_delivery_utilities_marsh_2` × 3; `town_delivery_utilities_marsh_3` × 2; `town_delivery_utilities_marsh_4` × 1 |
| gasket | GK22 | 4 | `town_delivery_utilities_marsh_1` × 4; `town_delivery_utilities_marsh_2` × 3; `town_delivery_utilities_marsh_3` × 2; `town_delivery_utilities_marsh_4` × 1 |
| haggler | HG01 | 1 | `town_delivery_trade_marsh_1` × 1 |
| haggler | HG04 | 1 | `town_delivery_trade_marsh_1` × 1 |
| haggler | HG05 | 2 | `town_delivery_trade_marsh_1` × 2; `town_delivery_trade_marsh_2` × 1 |
| haggler | HG08 | 2 | `town_delivery_trade_marsh_1` × 2; `town_delivery_trade_marsh_2` × 1 |
| haggler | HG09 | 2 | `town_delivery_trade_marsh_1` × 2; `town_delivery_trade_marsh_2` × 1 |
| haggler | HG12 | 2 | `town_delivery_trade_marsh_1` × 2; `town_delivery_trade_marsh_2` × 1 |
| haggler | HG13 | 3 | `town_delivery_trade_marsh_1` × 3; `town_delivery_trade_marsh_2` × 2; `town_delivery_trade_marsh_3` × 1 |
| haggler | HG16 | 3 | `town_delivery_trade_marsh_1` × 3; `town_delivery_trade_marsh_2` × 2; `town_delivery_trade_marsh_3` × 1 |
| haggler | HG17 | 3 | `town_delivery_trade_marsh_1` × 3; `town_delivery_trade_marsh_2` × 2; `town_delivery_trade_marsh_3` × 1 |
| haggler | HG20 | 3 | `town_delivery_trade_marsh_1` × 3; `town_delivery_trade_marsh_2` × 2; `town_delivery_trade_marsh_3` × 1 |
| haggler | HG21 | 3 | `town_delivery_trade_marsh_1` × 3; `town_delivery_trade_marsh_2` × 2; `town_delivery_trade_marsh_3` × 1 |
| haggler | HG24 | 4 | `town_delivery_trade_marsh_1` × 4; `town_delivery_trade_marsh_2` × 3; `town_delivery_trade_marsh_3` × 2; `town_delivery_trade_marsh_4` × 1 |
| haggler | HG25 | 4 | `town_delivery_trade_marsh_1` × 4; `town_delivery_trade_marsh_2` × 3; `town_delivery_trade_marsh_3` × 2; `town_delivery_trade_marsh_4` × 1 |
| haggler | HG26 | 4 | `town_delivery_trade_marsh_1` × 4; `town_delivery_trade_marsh_2` × 3; `town_delivery_trade_marsh_3` × 2; `town_delivery_trade_marsh_4` × 1 |
| intern | IN01 | 1 | `town_delivery_research_waystation_1` × 1 |
| intern | IN04 | 1 | `town_delivery_research_waystation_1` × 1 |
| intern | IN05 | 2 | `town_delivery_research_waystation_1` × 2; `town_delivery_research_waystation_2` × 1 |
| intern | IN08 | 2 | `town_delivery_research_waystation_1` × 2; `town_delivery_research_waystation_2` × 1 |
| intern | IN09 | 2 | `town_delivery_research_waystation_1` × 2; `town_delivery_research_waystation_2` × 1 |
| intern | IN12 | 2 | `town_delivery_research_waystation_1` × 2; `town_delivery_research_waystation_2` × 1 |
| intern | IN13 | 3 | `town_delivery_research_waystation_1` × 3; `town_delivery_research_waystation_2` × 2; `town_delivery_research_waystation_3` × 1 |
| intern | IN16 | 3 | `town_delivery_research_waystation_1` × 3; `town_delivery_research_waystation_2` × 2; `town_delivery_research_waystation_3` × 1 |
| intern | IN17 | 3 | `town_delivery_research_waystation_1` × 3; `town_delivery_research_waystation_2` × 2; `town_delivery_research_waystation_3` × 1 |
| intern | IN20 | 3 | `town_delivery_research_waystation_1` × 3; `town_delivery_research_waystation_2` × 2; `town_delivery_research_waystation_3` × 1 |
| intern | IN21 | 4 | `town_delivery_research_waystation_1` × 4; `town_delivery_research_waystation_2` × 3; `town_delivery_research_waystation_3` × 2; `town_delivery_research_waystation_4` × 1 |
| intern | IN24 | 4 | `town_delivery_research_waystation_1` × 4; `town_delivery_research_waystation_2` × 3; `town_delivery_research_waystation_3` × 2; `town_delivery_research_waystation_4` × 1 |
| jitters | JT01 | 1 | `town_delivery_medical_marsh_1` × 1 |
| jitters | JT04 | 1 | `town_delivery_medical_marsh_1` × 1 |
| jitters | JT05 | 1 | `town_delivery_medical_marsh_1` × 1 |
| jitters | JT08 | 2 | `town_delivery_medical_marsh_1` × 2; `town_delivery_medical_marsh_2` × 1 |
| jitters | JT09 | 2 | `town_delivery_medical_marsh_1` × 2; `town_delivery_medical_marsh_2` × 1 |
| jitters | JT12 | 2 | `town_delivery_medical_marsh_1` × 2; `town_delivery_medical_marsh_2` × 1 |
| jitters | JT13 | 2 | `town_delivery_medical_marsh_1` × 2; `town_delivery_medical_marsh_2` × 1 |
| jitters | JT16 | 3 | `town_delivery_medical_marsh_1` × 3; `town_delivery_medical_marsh_2` × 2; `town_delivery_medical_marsh_3` × 1 |
| jitters | JT17 | 3 | `town_delivery_medical_marsh_1` × 3; `town_delivery_medical_marsh_2` × 2; `town_delivery_medical_marsh_3` × 1 |
| jitters | JT20 | 3 | `town_delivery_medical_marsh_1` × 3; `town_delivery_medical_marsh_2` × 2; `town_delivery_medical_marsh_3` × 1 |
| jitters | JT21 | 3 | `town_delivery_medical_marsh_1` × 3; `town_delivery_medical_marsh_2` × 2; `town_delivery_medical_marsh_3` × 1 |
| jitters | JT24 | 4 | `town_delivery_medical_marsh_1` × 4; `town_delivery_medical_marsh_2` × 3; `town_delivery_medical_marsh_3` × 2; `town_delivery_medical_marsh_4` × 1 |
| jitters | JT25 | 4 | `town_delivery_medical_marsh_1` × 4; `town_delivery_medical_marsh_2` × 3; `town_delivery_medical_marsh_3` × 2; `town_delivery_medical_marsh_4` × 1 |
| latch | LA01 | 1 | `town_delivery_workshop_garbage_1` × 1 |
| latch | LA04 | 2 | `town_delivery_workshop_garbage_1` × 2; `town_delivery_workshop_garbage_2` × 1 |
| latch | LA05 | 2 | `town_delivery_workshop_garbage_1` × 2; `town_delivery_workshop_garbage_2` × 1 |
| latch | LA08 | 2 | `town_delivery_workshop_garbage_1` × 2; `town_delivery_workshop_garbage_2` × 1 |
| latch | LA09 | 2 | `town_delivery_workshop_garbage_1` × 2; `town_delivery_workshop_garbage_2` × 1 |
| latch | LA12 | 3 | `town_delivery_workshop_garbage_1` × 3; `town_delivery_workshop_garbage_2` × 2; `town_delivery_workshop_garbage_3` × 1 |
| latch | LA13 | 3 | `town_delivery_workshop_garbage_1` × 3; `town_delivery_workshop_garbage_2` × 2; `town_delivery_workshop_garbage_3` × 1 |
| latch | LA16 | 3 | `town_delivery_workshop_garbage_1` × 3; `town_delivery_workshop_garbage_2` × 2; `town_delivery_workshop_garbage_3` × 1 |
| latch | LA17 | 3 | `town_delivery_workshop_garbage_1` × 3; `town_delivery_workshop_garbage_2` × 2; `town_delivery_workshop_garbage_3` × 1 |
| latch | LA20 | 4 | `town_delivery_workshop_garbage_1` × 4; `town_delivery_workshop_garbage_2` × 3; `town_delivery_workshop_garbage_3` × 2; `town_delivery_workshop_garbage_4` × 1 |
| latch | LA21 | 4 | `town_delivery_workshop_garbage_1` × 4; `town_delivery_workshop_garbage_2` × 3; `town_delivery_workshop_garbage_3` × 2; `town_delivery_workshop_garbage_4` × 1 |
| ledger | LE01 | 1 | `town_delivery_records_waystation_1` × 1 |
| ledger | LE04 | 1 | `town_delivery_records_waystation_1` × 1 |
| ledger | LE05 | 2 | `town_delivery_records_waystation_1` × 2; `town_delivery_records_waystation_2` × 1 |
| ledger | LE08 | 2 | `town_delivery_records_waystation_1` × 2; `town_delivery_records_waystation_2` × 1 |
| ledger | LE09 | 2 | `town_delivery_records_waystation_1` × 2; `town_delivery_records_waystation_2` × 1 |
| ledger | LE12 | 3 | `town_delivery_records_waystation_1` × 3; `town_delivery_records_waystation_2` × 2; `town_delivery_records_waystation_3` × 1 |
| ledger | LE13 | 3 | `town_delivery_records_waystation_1` × 3; `town_delivery_records_waystation_2` × 2; `town_delivery_records_waystation_3` × 1 |
| ledger | LE16 | 3 | `town_delivery_records_waystation_1` × 3; `town_delivery_records_waystation_2` × 2; `town_delivery_records_waystation_3` × 1 |
| ledger | LE17 | 3 | `town_delivery_records_waystation_1` × 3; `town_delivery_records_waystation_2` × 2; `town_delivery_records_waystation_3` × 1 |
| ledger | LE20 | 4 | `town_delivery_records_waystation_1` × 4; `town_delivery_records_waystation_2` × 3; `town_delivery_records_waystation_3` × 2; `town_delivery_records_waystation_4` × 1 |
| ledger | LE21 | 4 | `town_delivery_records_waystation_1` × 4; `town_delivery_records_waystation_2` × 3; `town_delivery_records_waystation_3` × 2; `town_delivery_records_waystation_4` × 1 |
| mute | MU01 | 1 | `town_delivery_electronics_marsh_1` × 1 |
| mute | MU04 | 1 | `town_delivery_electronics_marsh_1` × 1 |
| mute | MU05 | 2 | `town_delivery_electronics_marsh_1` × 2; `town_delivery_electronics_marsh_2` × 1 |
| mute | MU08 | 2 | `town_delivery_electronics_marsh_1` × 2; `town_delivery_electronics_marsh_2` × 1 |
| mute | MU09 | 2 | `town_delivery_electronics_marsh_1` × 2; `town_delivery_electronics_marsh_2` × 1 |
| mute | MU12 | 2 | `town_delivery_electronics_marsh_1` × 2; `town_delivery_electronics_marsh_2` × 1 |
| mute | MU13 | 3 | `town_delivery_electronics_marsh_1` × 3; `town_delivery_electronics_marsh_2` × 2; `town_delivery_electronics_marsh_3` × 1 |
| mute | MU16 | 3 | `town_delivery_electronics_marsh_1` × 3; `town_delivery_electronics_marsh_2` × 2; `town_delivery_electronics_marsh_3` × 1 |
| mute | MU17 | 3 | `town_delivery_electronics_marsh_1` × 3; `town_delivery_electronics_marsh_2` × 2; `town_delivery_electronics_marsh_3` × 1 |
| mute | MU20 | 3 | `town_delivery_electronics_marsh_1` × 3; `town_delivery_electronics_marsh_2` × 2; `town_delivery_electronics_marsh_3` × 1 |
| mute | MU21 | 4 | `town_delivery_electronics_marsh_1` × 4; `town_delivery_electronics_marsh_2` × 3; `town_delivery_electronics_marsh_3` × 2; `town_delivery_electronics_marsh_4` × 1 |
| mute | MU24 | 4 | `town_delivery_electronics_marsh_1` × 4; `town_delivery_electronics_marsh_2` × 3; `town_delivery_electronics_marsh_3` × 2; `town_delivery_electronics_marsh_4` × 1 |
| old-timer | OT01 | 1 | `town_delivery_trail_marsh_1` × 1 |
| old-timer | OT04 | 1 | `town_delivery_trail_marsh_1` × 1 |
| old-timer | OT05 | 2 | `town_delivery_trail_marsh_1` × 2; `town_delivery_trail_marsh_2` × 1 |
| old-timer | OT08 | 2 | `town_delivery_trail_marsh_1` × 2; `town_delivery_trail_marsh_2` × 1 |
| old-timer | OT09 | 2 | `town_delivery_trail_marsh_1` × 2; `town_delivery_trail_marsh_2` × 1 |
| old-timer | OT12 | 2 | `town_delivery_trail_marsh_1` × 2; `town_delivery_trail_marsh_2` × 1 |
| old-timer | OT13 | 3 | `town_delivery_trail_marsh_1` × 3; `town_delivery_trail_marsh_2` × 2; `town_delivery_trail_marsh_3` × 1 |
| old-timer | OT16 | 3 | `town_delivery_trail_marsh_1` × 3; `town_delivery_trail_marsh_2` × 2; `town_delivery_trail_marsh_3` × 1 |
| old-timer | OT17 | 3 | `town_delivery_trail_marsh_1` × 3; `town_delivery_trail_marsh_2` × 2; `town_delivery_trail_marsh_3` × 1 |
| old-timer | OT20 | 3 | `town_delivery_trail_marsh_1` × 3; `town_delivery_trail_marsh_2` × 2; `town_delivery_trail_marsh_3` × 1 |
| old-timer | OT21 | 3 | `town_delivery_trail_marsh_1` × 3; `town_delivery_trail_marsh_2` × 2; `town_delivery_trail_marsh_3` × 1 |
| old-timer | OT24 | 4 | `town_delivery_trail_marsh_1` × 4; `town_delivery_trail_marsh_2` × 3; `town_delivery_trail_marsh_3` × 2; `town_delivery_trail_marsh_4` × 1 |
| old-timer | OT25 | 4 | `town_delivery_trail_marsh_1` × 4; `town_delivery_trail_marsh_2` × 3; `town_delivery_trail_marsh_3` × 2; `town_delivery_trail_marsh_4` × 1 |
| old-timer | OT28 | 4 | `town_delivery_trail_marsh_1` × 4; `town_delivery_trail_marsh_2` × 3; `town_delivery_trail_marsh_3` × 2; `town_delivery_trail_marsh_4` × 1 |
| quartermaster | QM01 | 1 | `town_delivery_military_waystation_1` × 9 |
| quartermaster | QM04 | 2 | `town_delivery_military_waystation_1` × 18; `town_delivery_military_waystation_2` × 1 |
| quartermaster | QM05 | 2 | `town_delivery_military_waystation_1` × 18; `town_delivery_military_waystation_2` × 1 |
| quartermaster | QM08 | 2 | `town_delivery_military_waystation_1` × 18; `town_delivery_military_waystation_2` × 1 |
| quartermaster | QM09 | 2 | `town_delivery_military_waystation_1` × 18; `town_delivery_military_waystation_2` × 1 |
| quartermaster | QM12 | 3 | `town_delivery_military_waystation_1` × 27; `town_delivery_military_waystation_2` × 2; `town_delivery_military_waystation_3` × 1 |
| quartermaster | QM13 | 3 | `town_delivery_military_waystation_1` × 27; `town_delivery_military_waystation_2` × 2; `town_delivery_military_waystation_3` × 1 |
| quartermaster | QM16 | 3 | `town_delivery_military_waystation_1` × 27; `town_delivery_military_waystation_2` × 2; `town_delivery_military_waystation_3` × 1 |
| quartermaster | QM17 | 3 | `town_delivery_military_waystation_1` × 27; `town_delivery_military_waystation_2` × 2; `town_delivery_military_waystation_3` × 1 |
| quartermaster | QM20 | 3 | `town_delivery_military_waystation_1` × 27; `town_delivery_military_waystation_2` × 2; `town_delivery_military_waystation_3` × 1 |
| quartermaster | QM21 | 4 | `town_delivery_military_waystation_1` × 36; `town_delivery_military_waystation_2` × 3; `town_delivery_military_waystation_3` × 2; `town_delivery_military_waystation_4` × 1 |
| quartermaster | QM24 | 4 | `town_delivery_military_waystation_1` × 36; `town_delivery_military_waystation_2` × 3; `town_delivery_military_waystation_3` × 2; `town_delivery_military_waystation_4` × 1 |
| smartass | SM01 | 1 | `town_delivery_electronics_waystation_1` × 1 |
| smartass | SM04 | 1 | `town_delivery_electronics_waystation_1` × 1 |
| smartass | SM05 | 2 | `town_delivery_electronics_waystation_1` × 2; `town_delivery_electronics_waystation_2` × 1 |
| smartass | SM08 | 2 | `town_delivery_electronics_waystation_1` × 2; `town_delivery_electronics_waystation_2` × 1 |
| smartass | SM09 | 2 | `town_delivery_electronics_waystation_1` × 2; `town_delivery_electronics_waystation_2` × 1 |
| smartass | SM12 | 2 | `town_delivery_electronics_waystation_1` × 2; `town_delivery_electronics_waystation_2` × 1 |
| smartass | SM13 | 3 | `town_delivery_electronics_waystation_1` × 3; `town_delivery_electronics_waystation_2` × 2; `town_delivery_electronics_waystation_3` × 1 |
| smartass | SM16 | 3 | `town_delivery_electronics_waystation_1` × 3; `town_delivery_electronics_waystation_2` × 2; `town_delivery_electronics_waystation_3` × 1 |
| smartass | SM17 | 3 | `town_delivery_electronics_waystation_1` × 3; `town_delivery_electronics_waystation_2` × 2; `town_delivery_electronics_waystation_3` × 1 |
| smartass | SM20 | 3 | `town_delivery_electronics_waystation_1` × 3; `town_delivery_electronics_waystation_2` × 2; `town_delivery_electronics_waystation_3` × 1 |
| smartass | SM21 | 4 | `town_delivery_electronics_waystation_1` × 4; `town_delivery_electronics_waystation_2` × 3; `town_delivery_electronics_waystation_3` × 2; `town_delivery_electronics_waystation_4` × 1 |
| smartass | SM24 | 4 | `town_delivery_electronics_waystation_1` × 4; `town_delivery_electronics_waystation_2` × 3; `town_delivery_electronics_waystation_3` × 2; `town_delivery_electronics_waystation_4` × 1 |
| spicy-lemon | SL01 | 1 | `town_delivery_kitchen_marsh_1` × 1 |
| spicy-lemon | SL04 | 1 | `town_delivery_kitchen_marsh_1` × 1 |
| spicy-lemon | SL05 | 2 | `town_delivery_kitchen_marsh_1` × 2; `town_delivery_kitchen_marsh_2` × 1 |
| spicy-lemon | SL08 | 2 | `town_delivery_kitchen_marsh_1` × 2; `town_delivery_kitchen_marsh_2` × 1 |
| spicy-lemon | SL09 | 2 | `town_delivery_kitchen_marsh_1` × 2; `town_delivery_kitchen_marsh_2` × 1 |
| spicy-lemon | SL12 | 2 | `town_delivery_kitchen_marsh_1` × 2; `town_delivery_kitchen_marsh_2` × 1 |
| spicy-lemon | SL13 | 3 | `town_delivery_kitchen_marsh_1` × 3; `town_delivery_kitchen_marsh_2` × 2; `town_delivery_kitchen_marsh_3` × 1 |
| spicy-lemon | SL16 | 3 | `town_delivery_kitchen_marsh_1` × 3; `town_delivery_kitchen_marsh_2` × 2; `town_delivery_kitchen_marsh_3` × 1 |
| spicy-lemon | SL17 | 3 | `town_delivery_kitchen_marsh_1` × 3; `town_delivery_kitchen_marsh_2` × 2; `town_delivery_kitchen_marsh_3` × 1 |
| spicy-lemon | SL20 | 3 | `town_delivery_kitchen_marsh_1` × 3; `town_delivery_kitchen_marsh_2` × 2; `town_delivery_kitchen_marsh_3` × 1 |
| spicy-lemon | SL21 | 3 | `town_delivery_kitchen_marsh_1` × 3; `town_delivery_kitchen_marsh_2` × 2; `town_delivery_kitchen_marsh_3` × 1 |
| spicy-lemon | SL24 | 4 | `town_delivery_kitchen_marsh_1` × 4; `town_delivery_kitchen_marsh_2` × 3; `town_delivery_kitchen_marsh_3` × 2; `town_delivery_kitchen_marsh_4` × 2 |
| spicy-lemon | SL25 | 4 | `town_delivery_kitchen_marsh_1` × 4; `town_delivery_kitchen_marsh_2` × 3; `town_delivery_kitchen_marsh_3` × 2; `town_delivery_kitchen_marsh_4` × 2 |
| spool | SO01 | 1 | `town_delivery_electronics_marsh_1` × 1 |
| spool | SO04 | 1 | `town_delivery_electronics_marsh_1` × 1 |
| spool | SO05 | 2 | `town_delivery_electronics_marsh_1` × 2; `town_delivery_electronics_marsh_2` × 1 |
| spool | SO08 | 2 | `town_delivery_electronics_marsh_1` × 2; `town_delivery_electronics_marsh_2` × 1 |
| spool | SO09 | 2 | `town_delivery_electronics_marsh_1` × 2; `town_delivery_electronics_marsh_2` × 1 |
| spool | SO12 | 3 | `town_delivery_electronics_marsh_1` × 3; `town_delivery_electronics_marsh_2` × 2; `town_delivery_electronics_marsh_3` × 1 |
| spool | SO13 | 3 | `town_delivery_electronics_marsh_1` × 3; `town_delivery_electronics_marsh_2` × 2; `town_delivery_electronics_marsh_3` × 1 |
| spool | SO16 | 3 | `town_delivery_electronics_marsh_1` × 3; `town_delivery_electronics_marsh_2` × 2; `town_delivery_electronics_marsh_3` × 1 |
| spool | SO17 | 3 | `town_delivery_electronics_marsh_1` × 3; `town_delivery_electronics_marsh_2` × 2; `town_delivery_electronics_marsh_3` × 1 |
| spool | SO20 | 4 | `town_delivery_electronics_marsh_1` × 4; `town_delivery_electronics_marsh_2` × 3; `town_delivery_electronics_marsh_3` × 2; `town_delivery_electronics_marsh_4` × 1 |
| spool | SO21 | 4 | `town_delivery_electronics_marsh_1` × 4; `town_delivery_electronics_marsh_2` × 3; `town_delivery_electronics_marsh_3` × 2; `town_delivery_electronics_marsh_4` × 1 |
| spoor | SP01 | 1 | `town_delivery_trail_garbage_1` × 1 |
| spoor | SP04 | 1 | `town_delivery_trail_garbage_1` × 1 |
| spoor | SP05 | 2 | `town_delivery_trail_garbage_1` × 2; `town_delivery_trail_garbage_2` × 1 |
| spoor | SP08 | 2 | `town_delivery_trail_garbage_1` × 2; `town_delivery_trail_garbage_2` × 1 |
| spoor | SP09 | 2 | `town_delivery_trail_garbage_1` × 2; `town_delivery_trail_garbage_2` × 1 |
| spoor | SP12 | 3 | `town_delivery_trail_garbage_1` × 3; `town_delivery_trail_garbage_2` × 2; `town_delivery_trail_garbage_3` × 1 |
| spoor | SP13 | 3 | `town_delivery_trail_garbage_1` × 3; `town_delivery_trail_garbage_2` × 2; `town_delivery_trail_garbage_3` × 1 |
| spoor | SP16 | 3 | `town_delivery_trail_garbage_1` × 3; `town_delivery_trail_garbage_2` × 2; `town_delivery_trail_garbage_3` × 1 |
| spoor | SP17 | 3 | `town_delivery_trail_garbage_1` × 3; `town_delivery_trail_garbage_2` × 2; `town_delivery_trail_garbage_3` × 1 |
| spoor | SP20 | 4 | `town_delivery_trail_garbage_1` × 4; `town_delivery_trail_garbage_2` × 3; `town_delivery_trail_garbage_3` × 2; `town_delivery_trail_garbage_4` × 1 |
| spoor | SP21 | 4 | `town_delivery_trail_garbage_1` × 4; `town_delivery_trail_garbage_2` × 3; `town_delivery_trail_garbage_3` × 2; `town_delivery_trail_garbage_4` × 1 |
| suture | SU01 | 1 | `town_delivery_textiles_waystation_1` × 1 |
| suture | SU04 | 2 | `town_delivery_textiles_waystation_1` × 2; `town_delivery_textiles_waystation_2` × 1 |
| suture | SU05 | 2 | `town_delivery_textiles_waystation_1` × 2; `town_delivery_textiles_waystation_2` × 1 |
| suture | SU08 | 2 | `town_delivery_textiles_waystation_1` × 2; `town_delivery_textiles_waystation_2` × 1 |
| suture | SU09 | 2 | `town_delivery_textiles_waystation_1` × 2; `town_delivery_textiles_waystation_2` × 1 |
| suture | SU12 | 3 | `town_delivery_textiles_waystation_1` × 3; `town_delivery_textiles_waystation_2` × 2; `town_delivery_textiles_waystation_3` × 1 |
| suture | SU13 | 3 | `town_delivery_textiles_waystation_1` × 3; `town_delivery_textiles_waystation_2` × 2; `town_delivery_textiles_waystation_3` × 1 |
| suture | SU16 | 3 | `town_delivery_textiles_waystation_1` × 3; `town_delivery_textiles_waystation_2` × 2; `town_delivery_textiles_waystation_3` × 1 |
| suture | SU17 | 3 | `town_delivery_textiles_waystation_1` × 3; `town_delivery_textiles_waystation_2` × 2; `town_delivery_textiles_waystation_3` × 1 |
| suture | SU20 | 3 | `town_delivery_textiles_waystation_1` × 3; `town_delivery_textiles_waystation_2` × 2; `town_delivery_textiles_waystation_3` × 1 |
| suture | SU21 | 4 | `town_delivery_textiles_waystation_1` × 4; `town_delivery_textiles_waystation_2` × 3; `town_delivery_textiles_waystation_3` × 2; `town_delivery_textiles_waystation_4` × 1 |
| suture | SU24 | 4 | `town_delivery_textiles_waystation_1` × 4; `town_delivery_textiles_waystation_2` × 3; `town_delivery_textiles_waystation_3` × 2; `town_delivery_textiles_waystation_4` × 1 |
| technut | TN01 | 1 | `town_delivery_workshop_marsh_1` × 1 |
| technut | TN04 | 1 | `town_delivery_workshop_marsh_1` × 1 |
| technut | TN05 | 2 | `town_delivery_workshop_marsh_1` × 2; `town_delivery_workshop_marsh_2` × 1 |
| technut | TN08 | 2 | `town_delivery_workshop_marsh_1` × 2; `town_delivery_workshop_marsh_2` × 1 |
| technut | TN09 | 2 | `town_delivery_workshop_marsh_1` × 2; `town_delivery_workshop_marsh_2` × 1 |
| technut | TN12 | 2 | `town_delivery_workshop_marsh_1` × 2; `town_delivery_workshop_marsh_2` × 1 |
| technut | TN13 | 2 | `town_delivery_workshop_marsh_1` × 2; `town_delivery_workshop_marsh_2` × 1 |
| technut | TN16 | 3 | `town_delivery_workshop_marsh_1` × 3; `town_delivery_workshop_marsh_2` × 2; `town_delivery_workshop_marsh_3` × 1 |
| technut | TN17 | 3 | `town_delivery_workshop_marsh_1` × 3; `town_delivery_workshop_marsh_2` × 2; `town_delivery_workshop_marsh_3` × 1 |
| technut | TN20 | 3 | `town_delivery_workshop_marsh_1` × 3; `town_delivery_workshop_marsh_2` × 2; `town_delivery_workshop_marsh_3` × 1 |
| technut | TN21 | 3 | `town_delivery_workshop_marsh_1` × 3; `town_delivery_workshop_marsh_2` × 2; `town_delivery_workshop_marsh_3` × 1 |
| technut | TN24 | 4 | `town_delivery_workshop_marsh_1` × 4; `town_delivery_workshop_marsh_2` × 3; `town_delivery_workshop_marsh_3` × 2; `town_delivery_workshop_marsh_4` × 1 |
| technut | TN25 | 4 | `town_delivery_workshop_marsh_1` × 4; `town_delivery_workshop_marsh_2` × 3; `town_delivery_workshop_marsh_3` × 2; `town_delivery_workshop_marsh_4` × 1 |
| technut | TN28 | 4 | `town_delivery_workshop_marsh_1` × 4; `town_delivery_workshop_marsh_2` × 3; `town_delivery_workshop_marsh_3` × 2; `town_delivery_workshop_marsh_4` × 1 |
| the-original | OR01 | 1 | `town_delivery_collectibles_marsh_1` × 1 |
| the-original | OR04 | 2 | `town_delivery_collectibles_marsh_1` × 2; `town_delivery_collectibles_marsh_2` × 1 |
| the-original | OR05 | 2 | `town_delivery_collectibles_marsh_1` × 2; `town_delivery_collectibles_marsh_2` × 1 |
| the-original | OR08 | 2 | `town_delivery_collectibles_marsh_1` × 2; `town_delivery_collectibles_marsh_2` × 1 |
| the-original | OR09 | 2 | `town_delivery_collectibles_marsh_1` × 2; `town_delivery_collectibles_marsh_2` × 1 |
| the-original | OR12 | 3 | `town_delivery_collectibles_marsh_1` × 3; `town_delivery_collectibles_marsh_2` × 2; `town_delivery_collectibles_marsh_3` × 1 |
| the-original | OR13 | 3 | `town_delivery_collectibles_marsh_1` × 3; `town_delivery_collectibles_marsh_2` × 2; `town_delivery_collectibles_marsh_3` × 1 |
| the-original | OR16 | 3 | `town_delivery_collectibles_marsh_1` × 3; `town_delivery_collectibles_marsh_2` × 2; `town_delivery_collectibles_marsh_3` × 1 |
| the-original | OR17 | 3 | `town_delivery_collectibles_marsh_1` × 3; `town_delivery_collectibles_marsh_2` × 2; `town_delivery_collectibles_marsh_3` × 1 |
| the-original | OR20 | 3 | `town_delivery_collectibles_marsh_1` × 3; `town_delivery_collectibles_marsh_2` × 2; `town_delivery_collectibles_marsh_3` × 1 |
| the-original | OR21 | 4 | `town_delivery_collectibles_marsh_1` × 4; `town_delivery_collectibles_marsh_2` × 3; `town_delivery_collectibles_marsh_3` × 2; `town_delivery_collectibles_marsh_4` × 1 |
| the-original | OR24 | 4 | `town_delivery_collectibles_marsh_1` × 4; `town_delivery_collectibles_marsh_2` × 3; `town_delivery_collectibles_marsh_3` × 2; `town_delivery_collectibles_marsh_4` × 1 |
| vesper | VE01 | 1 | `town_delivery_research_marsh_1` × 1 |
| vesper | VE04 | 1 | `town_delivery_research_marsh_1` × 1 |
| vesper | VE05 | 2 | `town_delivery_research_marsh_1` × 2; `town_delivery_research_marsh_2` × 1 |
| vesper | VE08 | 2 | `town_delivery_research_marsh_1` × 2; `town_delivery_research_marsh_2` × 1 |
| vesper | VE09 | 2 | `town_delivery_research_marsh_1` × 2; `town_delivery_research_marsh_2` × 1 |
| vesper | VE12 | 2 | `town_delivery_research_marsh_1` × 2; `town_delivery_research_marsh_2` × 1 |
| vesper | VE13 | 3 | `town_delivery_research_marsh_1` × 3; `town_delivery_research_marsh_2` × 2; `town_delivery_research_marsh_3` × 1 |
| vesper | VE16 | 3 | `town_delivery_research_marsh_1` × 3; `town_delivery_research_marsh_2` × 2; `town_delivery_research_marsh_3` × 1 |
| vesper | VE17 | 3 | `town_delivery_research_marsh_1` × 3; `town_delivery_research_marsh_2` × 2; `town_delivery_research_marsh_3` × 1 |
| vesper | VE20 | 3 | `town_delivery_research_marsh_1` × 3; `town_delivery_research_marsh_2` × 2; `town_delivery_research_marsh_3` × 1 |
| vesper | VE21 | 4 | `town_delivery_research_marsh_1` × 4; `town_delivery_research_marsh_2` × 3; `town_delivery_research_marsh_3` × 2; `town_delivery_research_marsh_4` × 1 |
| vesper | VE24 | 4 | `town_delivery_research_marsh_1` × 4; `town_delivery_research_marsh_2` × 3; `town_delivery_research_marsh_3` × 2; `town_delivery_research_marsh_4` × 1 |
| wake | WA01 | 1 | `town_delivery_medical_marsh_1` × 1 |
| wake | WA04 | 2 | `town_delivery_medical_marsh_1` × 2; `town_delivery_medical_marsh_2` × 1 |
| wake | WA05 | 2 | `town_delivery_medical_marsh_1` × 2; `town_delivery_medical_marsh_2` × 1 |
| wake | WA08 | 2 | `town_delivery_medical_marsh_1` × 2; `town_delivery_medical_marsh_2` × 1 |
| wake | WA09 | 2 | `town_delivery_medical_marsh_1` × 2; `town_delivery_medical_marsh_2` × 1 |
| wake | WA12 | 3 | `town_delivery_medical_marsh_1` × 3; `town_delivery_medical_marsh_2` × 2; `town_delivery_medical_marsh_3` × 1 |
| wake | WA13 | 3 | `town_delivery_medical_marsh_1` × 3; `town_delivery_medical_marsh_2` × 2; `town_delivery_medical_marsh_3` × 1 |
| wake | WA16 | 3 | `town_delivery_medical_marsh_1` × 3; `town_delivery_medical_marsh_2` × 2; `town_delivery_medical_marsh_3` × 1 |
| wake | WA17 | 3 | `town_delivery_medical_marsh_1` × 3; `town_delivery_medical_marsh_2` × 2; `town_delivery_medical_marsh_3` × 1 |
| wake | WA20 | 4 | `town_delivery_medical_marsh_1` × 4; `town_delivery_medical_marsh_2` × 3; `town_delivery_medical_marsh_3` × 2; `town_delivery_medical_marsh_4` × 1 |
| wake | WA21 | 4 | `town_delivery_medical_marsh_1` × 4; `town_delivery_medical_marsh_2` × 3; `town_delivery_medical_marsh_3` × 2; `town_delivery_medical_marsh_4` × 1 |

Rebuild with `python3 docs/npc-overhaul/tools/fts_delivery_balance.py --write`.
Inspect candidates without changing files using `--inspect`. Multiplayer acquisition and economy testing remain required.
