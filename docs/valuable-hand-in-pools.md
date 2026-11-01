# Valuables hand-in catalogue

All 378 concrete items in `schema/items/valuables_test/` are classified below. The 50 new
`valuables_*` pools live in `progression/definitions/sh_requirementpools.lua` and are loaded directly into the
shared progression pool registry. They remain authoring pools, not enabled NPC offers yet. All items now
have regional worldspawn entries; see the [regional loot guide](../gamemodes/ix_cotz/plugins/randomitem/README.md).
Playtest acquisition rates before enabling contact `job.pools` or progression requirement slots.

Existing hand-in pools remain unchanged so current offers and rarity-constrained progression
requirements do not change before acquisition is playtested. Saved personal assignments are untouched.
The new pools use `uncommon` as a provisional catalogue tier, not a verified world-drop rarity;
review acquisition and split rarity tiers before using them for finite progression requirements.
Repeatable delivery cash uses item value through the existing reward calculation.

Names and descriptions determine these groups. Cases and pouches are requested as recovered
objects, not as their implied contents. Medical stock and research injectors are valuables, not
usable healing items. Ordnance salvage does not gain explosive functionality. Insignia are looted
objects, not proof that the player killed a faction member. Data media do not carry extraction-job
completion credit. Individual tools are separate from the existing tiered toolbox pools.

Suggested contacts when acquisition is ready: Technut/Latch for workshop stock and cases;
Mute for electronics, computers and data; Jitters for clinical equipment; Suture for textiles
and armour materials; Gasket for household, filtration and fuel supplies; Spicy Lemon for dry
provisions; Carbon for records; Quartermaster for military records and ordnance; The Original
for collectibles and insignia. Scientific equipment/samples can use finite ecologist hand-ins
without replacing their current repeatable specialties.

Each authoring pool contains 4–12 candidates. Categories separate armour panels from textiles,
computer parts from portable computers and media, documents by purpose, and transit cases by use.
Filters share a pool with air/fluid fittings. Clinical, trauma and diagnostic stock remain separate.
Research injectors are split by their visible label families without claiming distinct drug effects.
Existing live pools retain their candidates and sizes until acquisition is playtested.

## Pool index

| Pool | Candidates |
| --- | ---: |
| `valuables_armour_panels` | 6 |
| `valuables_audio_cassettes` | 10 |
| `valuables_cleaning_supplies` | 12 |
| `valuables_clinical_supplies` | 7 |
| `valuables_computer_parts` | 7 |
| `valuables_control_electronics` | 7 |
| `valuables_cutting_tools` | 6 |
| `valuables_data_archives` | 8 |
| `valuables_decorative_valuables` | 8 |
| `valuables_drivers_wrenches` | 8 |
| `valuables_electrical_supplies` | 9 |
| `valuables_electronic_components` | 8 |
| `valuables_equipment_pouches` | 6 |
| `valuables_faction_patches` | 7 |
| `valuables_field_records` | 8 |
| `valuables_filtration` | 4 |
| `valuables_flash_media` | 7 |
| `valuables_fuel_supplies` | 11 |
| `valuables_instruments` | 8 |
| `valuables_irregular_patches` | 6 |
| `valuables_medical_equipment` | 8 |
| `valuables_military_cases` | 7 |
| `valuables_office_records` | 9 |
| `valuables_official_records` | 8 |
| `valuables_ordnance_salvage` | 7 |
| `valuables_personal_effects` | 8 |
| `valuables_portable_computers` | 4 |
| `valuables_portable_power` | 5 |
| `valuables_printed_material` | 10 |
| `valuables_protective_textiles` | 9 |
| `valuables_provisions` | 6 |
| `valuables_radio_components` | 5 |
| `valuables_radio_equipment` | 8 |
| `valuables_recording_equipment` | 8 |
| `valuables_reinforced_cases` | 7 |
| `valuables_repair_parts` | 12 |
| `valuables_research_injectors_a` | 7 |
| `valuables_research_injectors_b` | 7 |
| `valuables_research_records` | 5 |
| `valuables_research_samples` | 6 |
| `valuables_sample_carriers` | 6 |
| `valuables_secured_cases` | 6 |
| `valuables_specialist_cases` | 6 |
| `valuables_survey_equipment` | 8 |
| `valuables_technical_records` | 6 |
| `valuables_textile_supplies` | 12 |
| `valuables_transit_cases` | 10 |
| `valuables_trauma_supplies` | 7 |
| `valuables_workshop_consumables` | 8 |
| `valuables_workshop_tools` | 10 |

## Item review

| Item ID | Item name | Pool |
| --- | --- | --- |
| `value_air_journal` | Flight Log Folder | `valuables_field_records` |
| `value_airfilter` | Air Filter Housing | `valuables_filtration` |
| `value_ais_sart` | Emergency Locator Unit | `valuables_radio_equipment` |
| `value_anomaly_plant` | Anomalous Botanical Sample | `valuables_research_samples` |
| `value_antiinsect` | Insecticide Spray | `valuables_cleaning_supplies` |
| `value_antique_teapot` | Antique Teapot | `valuables_decorative_valuables` |
| `value_antique_vase` | Old Ceramic Vase | `valuables_decorative_valuables` |
| `value_archive_cassette` | Archive Cassette | `valuables_recording_equipment` |
| `value_awl` | Awl | `valuables_cutting_tools` |
| `value_badge_bandit` | Bandit Insignia | `valuables_irregular_patches` |
| `value_badge_csky` | Clear Sky Insignia | `valuables_faction_patches` |
| `value_badge_defiance` | Defiance Insignia | `valuables_faction_patches` |
| `value_badge_dolg` | Duty Insignia | `valuables_faction_patches` |
| `value_badge_ecolog` | Ecologist Insignia | `valuables_faction_patches` |
| `value_badge_freedom` | Freedom Insignia | `valuables_faction_patches` |
| `value_badge_greh` | Sin Insignia | `valuables_irregular_patches` |
| `value_badge_isg` | ISG Insignia | `valuables_faction_patches` |
| `value_badge_merc` | Mercenary Insignia | `valuables_irregular_patches` |
| `value_badge_military` | Military Insignia | `valuables_faction_patches` |
| `value_badge_monolith` | Monolith Insignia | `valuables_irregular_patches` |
| `value_badge_renegade` | Renegade Insignia | `valuables_irregular_patches` |
| `value_ballistic1` | Segmented Armour Panel | `valuables_armour_panels` |
| `value_ballistic11` | Dense Armour Insert | `valuables_armour_panels` |
| `value_ballistic3` | Padded Armour Panel | `valuables_armour_panels` |
| `value_ballistic4` | Worn Grey Armour Insert | `valuables_armour_panels` |
| `value_ballistic6` | Brown Labelled Armour Insert | `valuables_armour_panels` |
| `value_ballistic7` | Black Labelled Armour Insert | `valuables_armour_panels` |
| `value_balloon_poison_gas` | Recovered Gas Cylinder | `valuables_ordnance_salvage` |
| `value_barter_walletwz` | Printed Pocket Wallet | `valuables_personal_effects` |
| `value_battery_d_0` | D-Cell Battery | `valuables_portable_power` |
| `value_bear_souvenir` | Bear Souvenir | `valuables_decorative_valuables` |
| `value_bedspread` | Rolled Bedspread | `valuables_textile_supplies` |
| `value_bleach` | Bleach | `valuables_cleaning_supplies` |
| `value_bogatir_moreman_tag` | Oval Identification Tag | `valuables_personal_effects` |
| `value_briefcase` | Weathered Metal Briefcase | `valuables_transit_cases` |
| `value_building_kektape` | Cloth Repair Tape | `valuables_workshop_consumables` |
| `value_building_plexiglass` | Opaque Acrylic Blank | `valuables_workshop_consumables` |
| `value_building_poxeram` | Epoxy Adhesive Tube | `valuables_workshop_consumables` |
| `value_c4` | Recovered Plastic Charge | `valuables_ordnance_salvage` |
| `value_carbon_case` | Slim Composite Briefcase | `valuables_transit_cases` |
| `value_casezerogeo` | Survey Instrument Case | `valuables_survey_equipment` |
| `value_cassette_black90` | Black Ninety-Minute Cassette | `valuables_recording_equipment` |
| `value_cassette_fiolet` | Violet Audio Cassette | `valuables_recording_equipment` |
| `value_chemcontainer` | Cylindrical Chemical Carrier | `valuables_sample_carriers` |
| `value_chemicalsample` | Amber Sample Tube | `valuables_research_samples` |
| `value_chevron_bear` | Bear Emblem Patch | `valuables_irregular_patches` |
| `value_chlorine` | Chlorine Powder | `valuables_cleaning_supplies` |
| `value_circuitboard` | Salvaged Circuit Board | `valuables_electronic_components` |
| `value_clothbook1` | Red Sewing Handbook | `valuables_technical_records` |
| `value_clothbook2` | Orange Sewing Handbook | `valuables_technical_records` |
| `value_coffee` | Ground Coffee Tin | `valuables_provisions` |
| `value_container_ammo` | Ammunition Transit Can | `valuables_military_cases` |
| `value_container_arena_battlepass_s1` | Blue Decorated Transit Box | `valuables_transit_cases` |
| `value_container_arena_battlepass_s2` | Red Decorated Transit Box | `valuables_transit_cases` |
| `value_container_cardholder` | Metal Card Sleeve | `valuables_equipment_pouches` |
| `value_container_case_kompromat` | Orange Evidence Case | `valuables_specialist_cases` |
| `value_container_cultic_kappa` | Marked Research Case | `valuables_specialist_cases` |
| `value_container_gamma` | Striped Equipment Case | `valuables_reinforced_cases` |
| `value_container_gamma_damaged` | Worn Striped Equipment Case | `valuables_reinforced_cases` |
| `value_container_gamma_prestige` | Brown Reinforced Case | `valuables_reinforced_cases` |
| `value_container_gamma_tue` | Pale Reinforced Case | `valuables_reinforced_cases` |
| `value_container_grenadebox` | Grey Ordnance Case | `valuables_military_cases` |
| `value_container_injectorcase` | Injector Transport Pouch | `valuables_equipment_pouches` |
| `value_container_items_thicc` | Large Ribbed Transit Case | `valuables_reinforced_cases` |
| `value_container_junkbox` | Deep Utility Crate | `valuables_reinforced_cases` |
| `value_container_keys_case` | Textured Key Case | `valuables_equipment_pouches` |
| `value_container_lopouch` | Document Delivery Pouch | `valuables_equipment_pouches` |
| `value_container_meds` | Medical Transport Case | `valuables_specialist_cases` |
| `value_container_moderator_toolbox` | Stickered Tool Case | `valuables_specialist_cases` |
| `value_container_money` | Cash Transit Case | `valuables_transit_cases` |
| `value_container_parls` | Military Transit Crate | `valuables_military_cases` |
| `value_container_pistolcase` | Small Padded Equipment Case | `valuables_military_cases` |
| `value_container_plates_case` | Armour Plate Transit Case | `valuables_military_cases` |
| `value_container_secured_alpha` | Small Yellow Transit Case | `valuables_secured_cases` |
| `value_container_secured_beta` | Flat Yellow Transit Case | `valuables_secured_cases` |
| `value_container_secured_epsilon` | Long Yellow Transit Case | `valuables_secured_cases` |
| `value_container_secured_kappa` | Black-and-Orange Transit Case | `valuables_secured_cases` |
| `value_container_secured_theta` | Strapped Transit Case | `valuables_secured_cases` |
| `value_container_smallitems` | Small Utility Pouch | `valuables_equipment_pouches` |
| `value_container_trackcase` | Grey Tracking Case | `valuables_specialist_cases` |
| `value_container_weapon_thicc` | Long Heavy Equipment Case | `valuables_military_cases` |
| `value_container_weaponcase` | Long Weapons Transit Case | `valuables_military_cases` |
| `value_controller` | Industrial Control Unit | `valuables_control_electronics` |
| `value_crikent_0` | Disposable Lighter | `valuables_fuel_supplies` |
| `value_crow_beak` | Recovered Bird Beak | `valuables_personal_effects` |
| `value_crowbar` | Bent Crowbar | `valuables_workshop_tools` |
| `value_detector` | Recovered Survey Transmitter | `valuables_survey_equipment` |
| `value_docbag` | Leather Document Satchel | `valuables_equipment_pouches` |
| `value_draincleaner` | Drain Cleaner | `valuables_cleaning_supplies` |
| `value_drugskit` | Medical Shipment Case | `valuables_specialist_cases` |
| `value_dryfuel` | Solid Fuel Tablets | `valuables_fuel_supplies` |
| `value_dynamite` | Demolition Stock Crate | `valuables_ordnance_salvage` |
| `value_electr_adv_amplifier` | Signal Amplifier | `valuables_radio_components` |
| `value_electr_adv_controller` | Advanced Controller Board | `valuables_control_electronics` |
| `value_electr_adv_converter` | Ribbed Signal Converter | `valuables_radio_components` |
| `value_electr_adv_ultralink` | Data Link Module | `valuables_radio_components` |
| `value_electr_card_programmer` | Recovered Card Programmer | `valuables_control_electronics` |
| `value_electr_components` | Loose Electronic Components | `valuables_electronic_components` |
| `value_electr_controller_quest` | Red-Trimmed Control Unit | `valuables_control_electronics` |
| `value_electr_countermeasure` | Military Electronics Assembly | `valuables_control_electronics` |
| `value_electr_gary_zont` | Compact Radio Assembly | `valuables_radio_equipment` |
| `value_electr_hdd_quest` | Recovered Hard Drive | `valuables_computer_parts` |
| `value_electr_signal_jammer` | Recovered Antenna Unit | `valuables_radio_equipment` |
| `value_electr_ssd` | Compact Solid-State Drive | `valuables_computer_parts` |
| `value_electr_tplug` | Three-Way Socket Adapter | `valuables_electrical_supplies` |
| `value_electricdrill` | Cordless Drill | `valuables_workshop_tools` |
| `value_electro_gyroscope` | Boxed Inertial Sensor | `valuables_instruments` |
| `value_electroniccase_0013` | Numbered Data Module 0013 | `valuables_data_archives` |
| `value_electroniccase_0022` | Numbered Data Module 0022 | `valuables_data_archives` |
| `value_electroniccase_0031` | Numbered Data Module 0031 | `valuables_data_archives` |
| `value_electroniccase_0048` | Numbered Data Module 0048 | `valuables_data_archives` |
| `value_electroniccase_0052` | Numbered Data Module 0052 | `valuables_data_archives` |
| `value_energy_accum` | Camera Battery Pack | `valuables_portable_power` |
| `value_energy_cyclon` | Cylindrical Battery Assembly | `valuables_portable_power` |
| `value_energy_greenbat` | Rechargeable Cell | `valuables_portable_power` |
| `value_envelope` | Plain Envelope | `valuables_office_records` |
| `value_event_labyrinth_chem_container` | Marked Chemical Carrier | `valuables_sample_carriers` |
| `value_event_labyrinth_videocassette` | Stained Video Cassette | `valuables_recording_equipment` |
| `value_expandingfoam` | Expanding Foam | `valuables_workshop_consumables` |
| `value_explosive_charge` | Wired Demolition Assembly | `valuables_ordnance_salvage` |
| `value_fabric_aramid` | Folded Aramid Fabric | `valuables_textile_supplies` |
| `value_fabric_cordura` | Folded Cordura Fabric | `valuables_textile_supplies` |
| `value_fabric_fleece` | Folded Fleece Fabric | `valuables_textile_supplies` |
| `value_fabric_ripstop` | Folded Ripstop Fabric | `valuables_textile_supplies` |
| `value_fabrics1` | Green Fabric Bundle | `valuables_textile_supplies` |
| `value_fabrics2` | Brown Fabric Bundle | `valuables_textile_supplies` |
| `value_field_laptop` | Recovered Field Laptop | `valuables_portable_computers` |
| `value_flammable_huntermatches` | Weatherproof Matches | `valuables_fuel_supplies` |
| `value_flammable_klean` | Lighter Fuel Bottle | `valuables_fuel_supplies` |
| `value_flammable_survlighter` | Storm Lighter | `valuables_fuel_supplies` |
| `value_flammable_thermite` | Thermite Canister | `valuables_ordnance_salvage` |
| `value_flammable_trotil` | TNT Block | `valuables_ordnance_salvage` |
| `value_flash_card_ironkey` | Metal Flash Drive | `valuables_flash_media` |
| `value_flash_card_ironkey_slider` | Metal Slider Flash Drive | `valuables_flash_media` |
| `value_flash_card_slider` | Blue-Loop Flash Drive | `valuables_flash_media` |
| `value_flash_card_slider_kerman` | Tape-Labelled Flash Drive | `valuables_flash_media` |
| `value_flash_card_slider_sanitar` | Blue-Taped Flash Drive | `valuables_flash_media` |
| `value_flyer_01` | Shooting Magazine Bundle | `valuables_printed_material` |
| `value_flyer_02` | Equipment Magazine Bundle | `valuables_printed_material` |
| `value_flyer_03` | Worn Magazine Bundle | `valuables_printed_material` |
| `value_flyers` | Illustrated Magazine Stack | `valuables_printed_material` |
| `value_gamemagazine_01` | Old Games Magazine | `valuables_printed_material` |
| `value_gascan` | Metal Fuel Can | `valuables_fuel_supplies` |
| `value_geigercounter` | Yellow Radiation Meter | `valuables_survey_equipment` |
| `value_glasscleaner` | Glass Cleaner | `valuables_cleaning_supplies` |
| `value_guide` | Pocket Survival Guide | `valuables_technical_records` |
| `value_gyroscope` | Precision Gyroscope | `valuables_instruments` |
| `value_gyrotachometer` | Gyrotachometer Assembly | `valuables_instruments` |
| `value_hacktool_mechanic` | Improvised Electronic Tool | `valuables_control_electronics` |
| `value_hammer` | Workshop Hammer | `valuables_workshop_tools` |
| `value_handbook_circuits` | Circuit Design Handbook | `valuables_technical_records` |
| `value_handbook_materials` | Industrial Materials Handbook | `valuables_technical_records` |
| `value_handdrill` | Hand Drill | `valuables_workshop_tools` |
| `value_helix` | Coiled Flexible Conduit | `valuables_electrical_supplies` |
| `value_household_repellent` | Insect Repellent Bottle | `valuables_cleaning_supplies` |
| `value_household_salt` | Table Salt | `valuables_provisions` |
| `value_household_toothpaste1` | Toothpaste Tube | `valuables_cleaning_supplies` |
| `value_household_tree_life_extender` | Plant Preservative Bottle | `valuables_cleaning_supplies` |
| `value_hultafors_db5000` | Workshop Sledgehammer | `valuables_workshop_tools` |
| `value_info_cd_disk_i` | Marked Data Disc I | `valuables_data_archives` |
| `value_info_cd_disk_ii` | Marked Data Disc II | `valuables_data_archives` |
| `value_info_diary_friend_mechanic` | Tied Leather Journal | `valuables_field_records` |
| `value_info_labrys` | Labrys Booklet | `valuables_printed_material` |
| `value_info_maps` | Survey Map Bundle | `valuables_field_records` |
| `value_info_militaryflash` | Rugged Data Cartridge | `valuables_flash_media` |
| `value_info_moleskine` | Pocket Field Notebook | `valuables_field_records` |
| `value_info_securedtape` | Archive Tape Cartridge | `valuables_data_archives` |
| `value_info_tgdocs` | Blue Research Dossier | `valuables_research_records` |
| `value_info_videocassette_cyborg` | Labelled Video Cassette | `valuables_recording_equipment` |
| `value_injector_2a2` | 2A2 Research Injector | `valuables_research_injectors_a` |
| `value_injector_3btg` | 3-b-TG Research Injector | `valuables_research_injectors_a` |
| `value_injector_ahf1m` | AHF1-M Research Injector | `valuables_research_injectors_a` |
| `value_injector_l1` | L1 Research Injector | `valuables_research_injectors_a` |
| `value_injector_mildronate` | Mildronate Research Injector | `valuables_research_injectors_a` |
| `value_injector_mule` | M.U.L.E. Research Injector | `valuables_research_injectors_a` |
| `value_injector_obdolbos` | Obdolbos Research Injector | `valuables_research_injectors_a` |
| `value_injector_obdolbos_2` | Obdolbos 2 Research Injector | `valuables_research_injectors_b` |
| `value_injector_p22` | P22 Research Injector | `valuables_research_injectors_b` |
| `value_injector_perfotoran` | Perfotoran Research Injector | `valuables_research_injectors_b` |
| `value_injector_sj12` | SJ12 Research Injector | `valuables_research_injectors_b` |
| `value_injector_sj9` | SJ9 Research Injector | `valuables_research_injectors_b` |
| `value_injector_trimadol` | Trimadol Research Injector | `valuables_research_injectors_b` |
| `value_injector_xtg12` | XTG-12 Research Injector | `valuables_research_injectors_b` |
| `value_intelligence` | Loose Intelligence Dossier | `valuables_official_records` |
| `value_ipcamera` | Recovered Wireless Camera | `valuables_electronic_components` |
| `value_ir_ms2000` | Infrared Marker Unit | `valuables_radio_equipment` |
| `value_jamming` | Recovered Interference Unit | `valuables_radio_equipment` |
| `value_kanifol` | Soldering Rosin | `valuables_electrical_supplies` |
| `value_kerosene_container` | Kerosene Container | `valuables_fuel_supplies` |
| `value_key_danexert` | Key with Souvenir Fob | `valuables_personal_effects` |
| `value_key_labyrinth_torch` | Gas Torch Assembly | `valuables_workshop_tools` |
| `value_knife_box_low` | Labelled Parts Box | `valuables_transit_cases` |
| `value_lab_journal` | Laboratory Log Folder | `valuables_research_records` |
| `value_labyrinth_valve` | Salvaged Valve Wheel | `valuables_filtration` |
| `value_lamp_efficient` | Energy-Saving Lamp | `valuables_electrical_supplies` |
| `value_lamp_uv` | Ultraviolet Lamp | `valuables_electrical_supplies` |
| `value_large_case` | Large Olive Transit Case | `valuables_reinforced_cases` |
| `value_large_parts` | Large Mechanical Parts | `valuables_repair_parts` |
| `value_lcddirty` | Cracked Display Panel | `valuables_electronic_components` |
| `value_letter` | Stamped Letter | `valuables_office_records` |
| `value_letter_tg` | Corporate Letter | `valuables_official_records` |
| `value_lighter_gold` | Gold-Plated Lighter | `valuables_decorative_valuables` |
| `value_lightkeeper_amulet` | Tooth Pendant | `valuables_personal_effects` |
| `value_magnet` | Ring Magnet Assembly | `valuables_electrical_supplies` |
| `value_manual_lada` | Vehicle Workshop Manual | `valuables_technical_records` |
| `value_maps` | Weathered Map Roll | `valuables_field_records` |
| `value_match` | Workshop Matchbox | `valuables_fuel_supplies` |
| `value_matches` | Floral Matchbox | `valuables_fuel_supplies` |
| `value_med_aquatabs` | Water-Purification Tablets | `valuables_clinical_supplies` |
| `value_med_bloodsample` | Laboratory Blood Sample | `valuables_research_samples` |
| `value_med_bloodset` | Blood Transfusion Set | `valuables_trauma_supplies` |
| `value_med_haemostatic` | Haemostatic Dressing Packet | `valuables_trauma_supplies` |
| `value_med_ibuprofen` | Ibuprofen Bottle | `valuables_clinical_supplies` |
| `value_med_injectiondevice` | Clinical Injection Device | `valuables_trauma_supplies` |
| `value_med_journal_1` | Clinical Records Folder I | `valuables_research_records` |
| `value_med_journal_2` | Clinical Records Folder II | `valuables_research_records` |
| `value_med_ledx` | Skin Transilluminator | `valuables_medical_equipment` |
| `value_med_ledx_red` | Red Skin Transilluminator | `valuables_medical_equipment` |
| `value_med_medicalstock` | Assorted Medical Stock | `valuables_clinical_supplies` |
| `value_med_ophthalmoscope` | Ophthalmoscope | `valuables_medical_equipment` |
| `value_med_peroxide` | Hydrogen Peroxide Bottle | `valuables_clinical_supplies` |
| `value_med_petroleumjelly` | Petroleum Jelly Tin | `valuables_clinical_supplies` |
| `value_med_saline` | NaCl Saline Bottle | `valuables_clinical_supplies` |
| `value_med_splint` | Rolled Aluminium Splint | `valuables_trauma_supplies` |
| `value_med_surgicalpouch` | Surgical Instrument Pouch | `valuables_medical_equipment` |
| `value_med_surgicalpouch_worn` | Worn Surgical Pouch | `valuables_medical_equipment` |
| `value_med_surgicalroll` | Rolled Surgical Kit | `valuables_medical_equipment` |
| `value_med_surgicaltools` | Surgical Instrument Set | `valuables_medical_equipment` |
| `value_med_syringe` | Packaged Syringe | `valuables_trauma_supplies` |
| `value_med_thermometer` | Dial Probe Thermometer | `valuables_medical_equipment` |
| `value_med_tourniquet` | Windlass Tourniquet | `valuables_trauma_supplies` |
| `value_med_tourniquet_rubber` | Rubber Tourniquet Roll | `valuables_trauma_supplies` |
| `value_med_vitamins` | Vitamin Bottle | `valuables_clinical_supplies` |
| `value_metalparts` | Metal Spare Parts | `valuables_repair_parts` |
| `value_milimap` | Military Map Sheet | `valuables_field_records` |
| `value_military_secret_documents_1` | Military Records Folder I | `valuables_official_records` |
| `value_military_secret_documents_2` | Military Records Folder II | `valuables_official_records` |
| `value_military_secret_documents_3` | Military Records Folder III | `valuables_official_records` |
| `value_militarybattery` | Heavy Military Battery | `valuables_portable_power` |
| `value_militaryboard` | Military Circuit Board | `valuables_electronic_components` |
| `value_minedetector` | Green Survey Equipment Case | `valuables_survey_equipment` |
| `value_mining_kit` | Mining Tool Belt | `valuables_workshop_tools` |
| `value_multitul_0` | Folding Multitool | `valuables_workshop_tools` |
| `value_mysterious_device` | Unidentified Instrument Assembly | `valuables_survey_equipment` |
| `value_note_book_coming_closed` | Embossed Hardback Book | `valuables_printed_material` |
| `value_note_folder_closed_cardboard` | Plain Cardboard Folder | `valuables_office_records` |
| `value_note_folder_closed_cardboard_personal` | Personnel File Folder | `valuables_official_records` |
| `value_note_folder_closed_cardboard_state` | Official File Folder | `valuables_official_records` |
| `value_note_folder_closed_terragroup` | Corporate Records Folder | `valuables_official_records` |
| `value_note_newspaper_folded_01` | Folded Newspaper | `valuables_printed_material` |
| `value_note_newspaper_folded_02` | Illustrated Newspaper | `valuables_printed_material` |
| `value_notepad_a5_closed_01` | Large Spiral Notebook | `valuables_office_records` |
| `value_notepad_a6_closed_01` | Blue Pocket Notepad | `valuables_office_records` |
| `value_officepaper` | Pack of Office Paper | `valuables_office_records` |
| `value_optical_lens` | Optical Lens Assembly | `valuables_instruments` |
| `value_other_bage_ng` | Event Identification Badge | `valuables_personal_effects` |
| `value_other_filter` | Industrial Filter Cartridge | `valuables_filtration` |
| `value_other_grechka` | Buckwheat Packet | `valuables_provisions` |
| `value_other_hosemilitary` | Corrugated Equipment Hose | `valuables_filtration` |
| `value_other_lupo` | Coffee Bean Jar | `valuables_provisions` |
| `value_other_tea` | Boxed Loose Tea | `valuables_provisions` |
| `value_other_uzrgm_fuse` | Recovered Grenade Fuze | `valuables_ordnance_salvage` |
| `value_packinglist_goshan` | Warehouse Packing List A | `valuables_office_records` |
| `value_packinglist_idea` | Warehouse Packing List B | `valuables_office_records` |
| `value_packinglist_oli` | Warehouse Packing List C | `valuables_office_records` |
| `value_parcel` | Addressed Parcel | `valuables_transit_cases` |
| `value_parts` | Small Parts Tin | `valuables_repair_parts` |
| `value_pcpart_cpu` | Desktop Processor | `valuables_computer_parts` |
| `value_pcpart_cpufan` | CPU Cooling Fan | `valuables_computer_parts` |
| `value_pcpart_discdrive` | Optical Disc Drive | `valuables_computer_parts` |
| `value_pcpart_laptop` | Damaged Laptop | `valuables_portable_computers` |
| `value_pcpart_ram` | RAM Stick | `valuables_computer_parts` |
| `value_pda2` | Recovered Grey PDA | `valuables_portable_computers` |
| `value_pda3` | Recovered Blue PDA | `valuables_portable_computers` |
| `value_phaseantenna` | Phased Antenna Array | `valuables_radio_components` |
| `value_phaserelay` | Phase Relay Module | `valuables_radio_components` |
| `value_photograph_album` | Old Photograph Album | `valuables_printed_material` |
| `value_pipewrench` | Pipe Wrench | `valuables_drivers_wrenches` |
| `value_plastic` | Polymer Repair Sheet | `valuables_workshop_consumables` |
| `value_plasticbag_labyrinth` | Stained Sample Bag | `valuables_research_samples` |
| `value_plexiglass` | Plexiglass Sheet | `valuables_workshop_consumables` |
| `value_pliers` | Combination Pliers | `valuables_cutting_tools` |
| `value_pocketwatch` | Pocket Watch | `valuables_decorative_valuables` |
| `value_portable_container_closed` | Closed Metal Sample Carrier | `valuables_sample_carriers` |
| `value_portable_container_opened` | Open Metal Sample Carrier | `valuables_sample_carriers` |
| `value_powercable` | Power Cable | `valuables_electrical_supplies` |
| `value_powerfilter` | Electrical Power Filter | `valuables_electrical_supplies` |
| `value_precisiontools` | Precision Screwdriver Set | `valuables_drivers_wrenches` |
| `value_pressuregauge` | Pressure Gauge | `valuables_instruments` |
| `value_psi_helmet` | Recovered Experimental Headset | `valuables_survey_equipment` |
| `value_pukt90` | Boxed Instrument Consignment | `valuables_transit_cases` |
| `value_quest_biohazard_case` | Biohazard Transport Case | `valuables_sample_carriers` |
| `value_quest_flight_recorder` | Recovered Flight Recorder | `valuables_recording_equipment` |
| `value_radio` | Recovered Handheld Radio | `valuables_radio_equipment` |
| `value_radio_repeater` | Recovered Radio Relay | `valuables_radio_equipment` |
| `value_ratpoison` | Rat Poison | `valuables_cleaning_supplies` |
| `value_receiver1` | Pocket Radio Receiver | `valuables_radio_equipment` |
| `value_recorder_tape_02` | Blue-Label Audio Cassette | `valuables_audio_cassettes` |
| `value_recorder_tape_03` | Yellow-Label Audio Cassette | `valuables_audio_cassettes` |
| `value_recorder_tape_04` | White Audio Cassette | `valuables_audio_cassettes` |
| `value_recorder_tape_05` | Red Audio Cassette | `valuables_audio_cassettes` |
| `value_recorder_tape_06` | Handwritten Audio Cassette | `valuables_audio_cassettes` |
| `value_recorder_tape_08` | Black Audio Cassette | `valuables_audio_cassettes` |
| `value_recorder_tape_09` | Dark Labelled Audio Cassette | `valuables_audio_cassettes` |
| `value_recorder_tape_10` | Blue-Strip Audio Cassette | `valuables_audio_cassettes` |
| `value_recorder_tape_11` | Red Labelled Audio Cassette | `valuables_audio_cassettes` |
| `value_recorder_tape_12` | Green Audio Cassette | `valuables_audio_cassettes` |
| `value_retardant1` | Orange Protective Tape | `valuables_protective_textiles` |
| `value_retardant10` | Grey Protective Tape | `valuables_protective_textiles` |
| `value_retardant11` | Grey Lining Bundle | `valuables_protective_textiles` |
| `value_retardant12` | Green Lining Bundle | `valuables_protective_textiles` |
| `value_retardant2` | Green Protective Tape | `valuables_protective_textiles` |
| `value_retardant3` | Strapped Fabric Roll | `valuables_protective_textiles` |
| `value_retardant4` | Black Labelled Fabric Tape | `valuables_protective_textiles` |
| `value_retardant6` | Reddish Fabric Tape | `valuables_protective_textiles` |
| `value_retardant9` | Patterned Fabric Tape | `valuables_protective_textiles` |
| `value_rfidreader` | RFID Reader Module | `valuables_control_electronics` |
| `value_rope` | Coiled Natural Rope | `valuables_textile_supplies` |
| `value_ropes` | Coiled Grey Rope | `valuables_textile_supplies` |
| `value_safe_container` | Blue Protected Transit Case | `valuables_secured_cases` |
| `value_sas` | Ribbed Storage Drive | `valuables_computer_parts` |
| `value_scanner_anomaly` | Recovered Anomaly Survey Station | `valuables_survey_equipment` |
| `value_scanner_artefact` | Recovered Specimen Survey Station | `valuables_survey_equipment` |
| `value_scientistdiary` | Scientist's Field Diary | `valuables_research_records` |
| `value_screwdriver` | Flathead Screwdriver | `valuables_drivers_wrenches` |
| `value_screws` | Pack of Screws | `valuables_repair_parts` |
| `value_security_box` | Metal Security Drawer | `valuables_transit_cases` |
| `value_sensor_a` | Recovered Analogue Sensor | `valuables_instruments` |
| `value_sensor_d` | Recovered Digital Sensor | `valuables_instruments` |
| `value_sewingkit` | Boxed Sewing Supplies | `valuables_textile_supplies` |
| `value_shampoo` | Shampoo | `valuables_cleaning_supplies` |
| `value_skullring` | Brass Skull Ring | `valuables_decorative_valuables` |
| `value_small_case` | Weathered Courier Case | `valuables_transit_cases` |
| `value_soap` | Bar of Soap | `valuables_cleaning_supplies` |
| `value_soda` | Baking Soda Carton | `valuables_cleaning_supplies` |
| `value_spec_recorder` | Pocket Voice Recorder | `valuables_recording_equipment` |
| `value_spec_tgflashkey` | Tagged Security Flash Drive | `valuables_flash_media` |
| `value_spherical_recorder` | Spherical Flight Recorder | `valuables_recording_equipment` |
| `value_statue_raven` | Raven Statuette | `valuables_decorative_valuables` |
| `value_strelets_amulet` | Tag and Wooden Token | `valuables_personal_effects` |
| `value_sugar` | Sugar Carton | `valuables_provisions` |
| `value_swiss` | Pocket Tool Knife | `valuables_cutting_tools` |
| `value_sz_1` | Recovered Circuit Enclosure | `valuables_electronic_components` |
| `value_tapemeasure` | Tape Measure | `valuables_workshop_tools` |
| `value_tarp` | Folded Tarpaulin | `valuables_textile_supplies` |
| `value_textolite` | Bare Circuit Boards | `valuables_electronic_components` |
| `value_tg_vi_24` | Dark-Capped Research Tube | `valuables_research_samples` |
| `value_tg_vi_24_antivirus` | Green-Capped Research Tube | `valuables_research_samples` |
| `value_thermalmodule` | Thermal Imaging Module | `valuables_instruments` |
| `value_thermobag` | Insulated Sample Carrier | `valuables_sample_carriers` |
| `value_thick_diary` | Thick Pocket Diary | `valuables_field_records` |
| `value_thin_diary` | Slim Green Diary | `valuables_field_records` |
| `value_tools_advwrench` | Adjustable Workshop Wrench | `valuables_drivers_wrenches` |
| `value_tools_metalscissors` | Metal Shears | `valuables_cutting_tools` |
| `value_tools_nippers` | Cutting Nippers | `valuables_cutting_tools` |
| `value_tools_pliers_round` | Round-Nose Pliers | `valuables_cutting_tools` |
| `value_tools_ratchetwrench` | Ratchet Wrench | `valuables_drivers_wrenches` |
| `value_tools_screwdriver_flat` | Insulated Flathead Screwdriver | `valuables_drivers_wrenches` |
| `value_tools_screwdriver_flat_long` | Long Flathead Screwdriver | `valuables_drivers_wrenches` |
| `value_tools_sewing` | Zipped Sewing Pouch | `valuables_textile_supplies` |
| `value_toolset` | Assorted Hand Tools | `valuables_workshop_tools` |
| `value_transistors` | Electronic Parts Box | `valuables_electronic_components` |
| `value_upgro1` | Strapped Parts Parcel | `valuables_repair_parts` |
| `value_upgro2` | Black Equipment Parts Pouch | `valuables_repair_parts` |
| `value_upgro3` | Blue Equipment Parts Pouch | `valuables_repair_parts` |
| `value_upgrw2` | Blue Metal Parts Case | `valuables_repair_parts` |
| `value_upgrw3` | Green Metal Parts Case | `valuables_repair_parts` |
| `value_usb_adapter` | USB Wall Adapter | `valuables_electrical_supplies` |
| `value_valuable_kresalo` | Steel Fire Striker | `valuables_fuel_supplies` |
| `value_wallet` | Worn Leather Wallet | `valuables_personal_effects` |
| `value_waste_heavy` | Heavy Equipment Debris | `valuables_repair_parts` |
| `value_waste_light` | Light Equipment Debris | `valuables_repair_parts` |
| `value_wd40_100ml` | Small Lubricant Aerosol | `valuables_workshop_consumables` |
| `value_wd40_400ml` | Large Lubricant Aerosol | `valuables_workshop_consumables` |
| `value_weaponparts` | Loose Weapon Mechanisms | `valuables_repair_parts` |
| `value_woodclock` | Wooden Mantel Clock | `valuables_decorative_valuables` |
| `value_wrench` | Open-Ended Wrench | `valuables_drivers_wrenches` |
| `value_zibbo_0` | Metal Pocket Lighter | `valuables_fuel_supplies` |
