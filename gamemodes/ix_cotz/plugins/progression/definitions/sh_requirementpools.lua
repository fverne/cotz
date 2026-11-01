ix.progression = ix.progression or {}

ix.progression.itemPools = {
	fasteners = {
		name = "Common fasteners",
		tier = "common",
		evidence = (
			"worldspawn_1/3/5: nuts and bolts have equal weights; OnInstanced rolls 3-8 and 4-8 "
			.. "units."
		),
		candidates = {
			{ item = "value_nuts" },
			{ item = "value_bolts" },
		},
	},
	batteries = {
		name = "Portable power",
		tier = "common",
		evidence = (
			"worldspawn_1: 1.5V weight 2000, 9V 1000; spawned ranges 1-6 and 2-3. Portable power "
			.. "alternatives; requests use the slot quantity."
		),
		candidates = {
			{ item = "value_battery" },
			{ item = "value_9vbattery" },
		},
	},
	small_electronics = {
		name = "Common electrical components",
		tier = "common",
		evidence = (
			"worldspawn_1: capacitors 700, copper wire 900, household glue 900; use electrical "
			.. "components only. Capacitors spawn 2-3 units."
		),
		candidates = {
			{ item = "value_capacitors" },
			{ item = "value_wire_copper" },
		},
	},
	workshop_supplies = {
		name = "Workshop supplies",
		tier = "common",
		evidence = (
			"worldspawn_1: nails, duct tape, lightbulb, hose and silicone tubing all weight 500."
		),
		candidates = {
			{ item = "value_nails" },
			{ item = "value_tape_duct" },
			{ item = "value_lightbulb" },
			{ item = "value_hose" },
			{ item = "value_siliconetube" },
		},
	},
	repair_electrical = {
		name = "Wiring and electrical insulation",
		tier = "uncommon",
		evidence = (
			"worldspawn_1: electrical tape 400, light wire 350, spark plugs 400 (1-2 units), "
			.. "paracord 400. Electrical and field repair supplies overlap."
		),
		candidates = {
			{ item = "value_tape_electric" },
			{ item = "value_wire_light" },
			{ item = "value_sparkplug" },
			{ item = "value_paracord" },
		},
	},
	cleaning = {
		name = "Household cleaning supplies",
		tier = "uncommon",
		evidence = (
			"worldspawn_1/4: toilet paper and toothpaste have identical weights; detergent is "
			.. "within 1.84x."
		),
		candidates = {
			{ item = "value_toiletpaper" },
			{ item = "value_toothpaste" },
			{ item = "value_detergent" },
		},
	},
	adhesives = {
		name = "Workshop adhesives",
		tier = "common",
		evidence = (
			"worldspawn_1: glue types 1/2/3/4 have weights 900/700/700/700; shared box sources."
		),
		candidates = {
			{ item = "value_glue_1" },
			{ item = "value_glue_2" },
			{ item = "value_glue_3" },
			{ item = "value_glue_4" },
		},
	},
	fuel = {
		name = "Fuel supplies",
		tier = "uncommon",
		evidence = (
			"worldspawn_1: gasoline 180, kerosene 200, propane 150; each yields approximately 2-3 "
			.. "units."
		),
		candidates = {
			{ item = "value_gasoline" },
			{ item = "value_propanetank" },
			{ item = "value_kerosene" },
		},
	},
	heavy_electrical = {
		name = "Heavy electrical salvage",
		tier = "rare",
		evidence = (
			"worldspawn_1/4: car battery 130, heavy wire 150, military tape 100, powerbank 200. "
			.. "Related heavy electrical salvage."
		),
		candidates = {
			{ item = "value_carbattery" },
			{ item = "value_wire_heavy" },
			{ item = "value_tape_heavy" },
			{ item = "value_powerbank" },
		},
	},
	heavy_components = {
		name = "Heavy machinery components",
		tier = "rare",
		evidence = (
			"worldspawn_1/4: engine 75/90, car battery 130, heavy wire 150; machinery-scale "
			.. "salvage."
		),
		candidates = {
			{ item = "value_engine" },
			{ item = "value_carbattery" },
			{ item = "value_wire_heavy" },
		},
	},
	maintenance = {
		name = "Weapon maintenance supplies",
		tier = "uncommon",
		evidence = (
			"worldspawn_2/3/5: cleaner, lubricant and spray share weights; gun oil 300 in "
			.. "worldspawn_3 versus 360 for the others. Overlaps field repair supplies."
		),
		candidates = {
			{ item = "value_guncleaner" },
			{ item = "value_lubricant" },
			{ item = "value_gunspray" },
			{ item = "value_gunoil" },
		},
	},
	field_maintenance = {
		name = "Field repair supplies",
		tier = "uncommon",
		evidence = (
			"worldspawn_1/3: gun oil 300, paracord 400, light wire 350 and electrical tape 400. "
			.. "Overlaps electrical repairs and weapon maintenance at comparable weights."
		),
		candidates = {
			{ item = "value_gunoil" },
			{ item = "value_paracord" },
			{ item = "value_wire_light" },
			{ item = "value_tape_electric" },
		},
	},
	statues = {
		name = "Decorative statuettes",
		tier = "uncommon",
		evidence = (
			"worldspawn_2/3/4/5/6: cat/lion/horse share sources with weights within 2x."
		),
		candidates = {
			{ item = "value_statue_cat" },
			{ item = "value_statue_lion" },
			{ item = "value_statue_horse" },
		},
	},
	powder = {
		name = "Ammunition propellants",
		tier = "uncommon",
		evidence = (
			"worldspawn_2/4: green/blue/red weights within 1.67x; all share valuable reward pool."
		),
		candidates = {
			{ item = "value_gunpowder_green" },
			{ item = "value_gunpowder_blue" },
			{ item = "value_gunpowder_red" },
		},
	},
	radio_components = {
		name = "Scientific radio modules",
		tier = "rare",
		evidence = (
			"worldspawn_5/6 and cache_valuable: memory/calculation/monitoring/frequency modules "
			.. "have identical weights."
		),
		candidates = {
			{ item = "value_memorymodule" },
			{ item = "value_calculationunit" },
			{ item = "value_monitoringunit" },
			{ item = "value_frequencymodulator" },
		},
	},
	consumer_electronics = {
		name = "Communications salvage",
		tier = "uncommon",
		evidence = (
			"worldspawn_2: new phone 125, old phone 250, transmitter 350. Communication salvage "
			.. "from the same loot source."
		),
		candidates = {
			{ item = "value_phone_new" },
			{ item = "value_phone_old" },
			{ item = "value_wirelesstrans" },
		},
	},
	computer_parts = {
		name = "Computer hardware",
		tier = "rare",
		evidence = (
			"worldspawn_3/4/5/6: HDD, PSU and FPGA weights 50/100; LCD 40/80 in shared tables."
		),
		candidates = {
			{ item = "value_pcpart_hdd" },
			{ item = "value_pcpart_psu" },
			{ item = "value_pcpart_fpga" },
			{ item = "value_pcpart_lcd" },
		},
	},
	advanced_parts = {
		name = "Advanced computer equipment",
		tier = "rare",
		evidence = (
			"worldspawn_4/6: GPU and SSD both 50/80; advanced tools 50/80."
		),
		candidates = {
			{ item = "value_pcpart_gpu" },
			{ item = "value_pcpart_ssd" },
			{ item = "value_techtool_2" },
		},
	},
	small_valuables = {
		name = "Personal valuables",
		tier = "rare",
		evidence = (
			"worldspawn_2: gold chain 100 and watch 200; same valuable reward source."
		),
		candidates = {
			{ item = "value_goldchain" },
			{ item = "value_watch" },
		},
	},
	documents_technical = {
		name = "Technical documents",
		tier = "rare",
		evidence = (
			"worldspawn_1/boxes: checklist, torn note, firearm and sewing manuals weight 15. "
			.. "Manufacturing manual shares technical document sources."
		),
		candidates = {
			{ item = "value_documents_7" },
			{ item = "value_documents_12" },
			{ item = "value_documents_13" },
			{ item = "value_documents_14" },
			{ item = "value_documents_6" },
			{ item = "value_documents_8" },
		},
	},
	documents_research = {
		name = "Research documents",
		tier = "rare",
		evidence = (
			"worldspawn_2/4/6: anomalous report and artifact ledger have identical weights."
		),
		candidates = {
			{ item = "value_documents_10" },
			{ item = "value_documents_11" },
		},
	},
	documents_field = {
		name = "Field research notes",
		tier = "uncommon",
		evidence = (
			"worldspawn_2/4: CV 450, scientific notes 400, anomaly map 500 and swamp research 300. "
			.. "Field document alternatives."
		),
		candidates = {
			{ item = "value_documents_4" },
			{ item = "value_documents_5" },
			{ item = "value_documents_9" },
			{ item = "value_documents_3" },
		},
	},
	basic_tools = {
		name = "Basic workshop tools",
		tier = "rare",
		evidence = (
			"Basic tools are a distinct tool tier; no substitution with advanced or specialty "
			.. "tools."
		),
		candidates = {
			{ item = "value_techtool_1" },
		},
	},
	specialty_tools = {
		name = "Specialty workshop tools",
		tier = "exceptional",
		evidence = (
			"Distinct specialty tool tier, weight 1-8 in most world tables. Keep separate from "
			.. "common tools."
		),
		candidates = {
			{ item = "value_techtool_3" },
		},
	},
	filters = {
		name = "Filtration supplies",
		tier = "rare",
		evidence = (
			"Water filters have a distinct industrial loot route; no substitution with medical "
			.. "drugs."
		),
		candidates = {
			{ item = "value_waterfilter" },
		},
	},
	engine_care = {
		name = "Engine care",
		tier = "uncommon",
		evidence = (
			"Motor conditioner is a distinct mechanical consumable."
		),
		candidates = {
			{ item = "value_motorclean" },
		},
	},
	stash_notes = {
		name = "Rookie stash leads",
		tier = "uncommon",
		evidence = (
			"Rookie notes have 2x rookie PDA weights in common world tables and boxes; both provide "
			.. "rookie stash leads."
		),
		candidates = {
			{ item = "hidestash_1" },
			{ item = "hidestash_2" },
		},
	},
	veteran_stash = {
		name = "Veteran stash leads",
		tier = "rare",
		evidence = (
			"Veteran stash PDA has a distinct lower-frequency reward/world source."
		),
		candidates = {
			{ item = "hidestash_3" },
		},
	},
	melee_tools = {
		name = "Melee tools",
		tier = "common",
		evidence = (
			"worldspawn_1 and task_reward_weapon_00: six tools have identical weights."
		),
		candidates = {
			{ item = "crowbar" },
			{ item = "fireaxe" },
			{ item = "hatchet" },
			{ item = "leadpipe" },
			{ item = "machete" },
			{ item = "sledgehammer" },
		},
	},
	rimfire_rifles = {
		name = "Light hunting rifles",
		tier = "uncommon",
		evidence = (
			"task_reward_weapon_01_high/low: rimfire and varmint rifles share reward sources. World "
			.. "weights within 2x."
		),
		candidates = {
			{ item = "ruger1022" },
			{ item = "sako85varmint" },
			{ item = "w9422" },
		},
	},
	common_optics = {
		name = "Common compact optics",
		tier = "uncommon",
		evidence = (
			"reward_generic_valuable: CMore and RMR both weight 2000."
		),
		candidates = {
			{ item = "cmore" },
			{ item = "trijiconrmr" },
		},
	},
	attachments = {
		name = "Weapon attachments",
		tier = "rare",
		evidence = (
			"reward_generic_valuable: foregrip, King Arms and Kobra all weight 500."
		),
		candidates = {
			{ item = "foregrip" },
			{ item = "kingarmsmr" },
			{ item = "kobra" },
		},
	},
	suppressors = {
		name = "Suppressors",
		tier = "rare",
		evidence = (
			"reward_generic_valuable: all four suppressors weight 150."
		),
		candidates = {
			{ item = "cobrasuppressor" },
			{ item = "tundrasuppressor" },
			{ item = "pbssuppressor" },
			{ item = "sakersuppressor" },
		},
	},
	suit_materials = {
		name = "Entry military suit materials",
		tier = "rare",
		evidence = (
			"specialsale_owlnpc_suit: IO7a, NBC and PS5m share weight 75."
		),
		candidates = {
			{ item = "suit_io7a" },
			{ item = "suit_nbc" },
			{ item = "suit_ps5m" },
		},
	},
	canned_food = {
		name = "Canned provisions",
		tier = "uncommon",
		evidence = (
			"reward_consumable: canned provisions share an acquisition route."
		),
		candidates = {
			{ item = "food_can_sprats" },
			{ item = "food_can_beans" },
			{ item = "food_can_tuna" },
		},
	},
	mre = {
		name = "Military rations",
		tier = "rare",
		evidence = (
			"worldspawn_4/6: all three MREs weight 20, default quantity 3."
		),
		candidates = {
			{ item = "food_mre_russia" },
			{ item = "food_mre_ukraine" },
			{ item = "food_mre_usa" },
		},
	},
	energy_drinks = {
		name = "Energy drinks",
		tier = "uncommon",
		evidence = (
			"worldspawn_5: all three energy drinks weight 85; instance quantities differ. Required "
			.. "counts come from the slot."
		),
		candidates = {
			{ item = "drink_energydrink_4" },
			{ item = "drink_energydrink_5" },
			{ item = "drink_energydrink_6" },
		},
	},
	beer = {
		name = "Imported beer",
		tier = "uncommon",
		evidence = (
			"reward_consumable: three imported beers; worldspawn_5 Utenos/Baltika same weight 585."
		),
		candidates = {
			{ item = "drink_canbeer_3" },
			{ item = "drink_canbeer_4" },
			{ item = "drink_canbeer_5" },
		},
	},
	spirits = {
		name = "Premium spirits",
		tier = "uncommon",
		evidence = (
			"worldspawn_2/5: premium vodka and whisky weights within 1.5x."
		),
		candidates = {
			{ item = "drink_spirit_3" },
			{ item = "drink_vodka_5" },
			{ item = "drink_vodka_6" },
		},
	},
	wine = {
		name = "Wine",
		tier = "uncommon",
		evidence = (
			"Wine has a separate consumable reward route."
		),
		candidates = {
			{ item = "drink_wine" },
		},
	},
	cigarettes = {
		name = "Ordinary cigarettes",
		tier = "uncommon",
		evidence = (
			"worldspawn_1 and bandit loot: Star/Spark have equal weights; world quantities 2-4 and "
			.. "4-6."
		),
		candidates = {
			{ item = "drug_cigarette_3" },
			{ item = "drug_cigarette_4" },
		},
	},
	premium_cigarettes = {
		name = "Imported cigarettes",
		tier = "uncommon",
		evidence = (
			"bandit_pistol/rifle/shotgun_loot: Lucky Strike and Marlboro both weight 25, explicit "
			.. "quantity 1."
		),
		candidates = {
			{ item = "drug_cigarette_5" },
			{ item = "drug_cigarette_6" },
		},
	},
	tobacco = {
		name = "Loose tobacco",
		tier = "uncommon",
		evidence = (
			"worldspawn_1/3/5 and boxes: both tobaccos have identical weights, typical quantity "
			.. "5-9."
		),
		candidates = {
			{ item = "drug_tobacco_1" },
			{ item = "drug_tobacco_2" },
		},
	},
	stimulants = {
		name = "Medicinal stimulants",
		tier = "uncommon",
		evidence = (
			"worldspawn_1: caffeine and painkillers both weight 150, quantities 4 and 8."
		),
		candidates = {
			{ item = "drug_caffeine" },
			{ item = "drug_painkillers" },
		},
	},
	rare_drugs = {
		name = "Rare pharmaceuticals",
		tier = "rare",
		evidence = (
			"worldspawn_2: cocaine, morphine and marijuana all weight 100."
		),
		candidates = {
			{ item = "drug_cocaine" },
			{ item = "drug_morphine" },
			{ item = "drug_marijuana" },
		},
	},
	cigar = {
		name = "Premium cigars",
		tier = "rare",
		evidence = (
			"Distinct premium tobacco route."
		),
		candidates = {
			{ item = "drug_cigar" },
		},
	},
	antirad = {
		name = "Radiation treatment",
		tier = "uncommon",
		evidence = (
			"medical_rad_tier01/reward_aid_low: old anti-radiation drug; requests count individual "
			.. "quantity units, not packages."
		),
		candidates = {
			{ item = "medic_antirad_1" },
		},
	},
	common_meat = {
		name = "Common mutant meat",
		tier = "common",
		evidence = (
			"mutantpoaching: blinddog/flesh/tushkano/boar meat is guaranteed per successful "
			.. "harvest."
		),
		candidates = {
			{ item = "meat_blinddog" },
			{ item = "meat_flesh" },
			{ item = "meat_tushkano" },
			{ item = "meat_boar" },
		},
	},
	common_parts = {
		name = "Common ungulate specimens",
		tier = "uncommon",
		evidence = (
			"mutantpoaching: boar hoof and flesh eye each use threshold 75."
		),
		candidates = {
			{ item = "part_boar" },
			{ item = "part_flesh" },
		},
	},
	small_parts = {
		name = "Small predator specimens",
		tier = "uncommon",
		evidence = (
			"mutantpoaching: dog threshold 20, cat 35, tushkano 45; comparable small quarry "
			.. "classes."
		),
		candidates = {
			{ item = "part_blinddog" },
			{ item = "part_cat" },
			{ item = "part_tushkano" },
		},
	},
	humanoid_parts = {
		name = "Humanoid mutant specimens",
		tier = "uncommon",
		evidence = (
			"mutantpoaching: izlom threshold 15, zombie hand 25, snork foot 35."
		),
		candidates = {
			{ item = "part_izlom" },
			{ item = "part_zombie_1" },
			{ item = "part_snork_1" },
		},
	},
	exotic_parts = {
		name = "Exotic mutant specimens",
		tier = "rare",
		evidence = (
			"mutantpoaching: tark/sprig/spider/vareshka each threshold 20."
		),
		candidates = {
			{ item = "part_tark" },
			{ item = "part_sprig" },
			{ item = "part_spider" },
			{ item = "part_vareshka" },
		},
	},
	elite_parts = {
		name = "Elite mutant specimens",
		tier = "rare",
		evidence = (
			"mutantpoaching: controller hand and electrocontroller hand both threshold20; "
			.. "pseudogiant20-25."
		),
		candidates = {
			{ item = "part_controller_1" },
			{ item = "part_electrocontroller_1" },
			{ item = "part_pseudogiant" },
		},
	},
	chimera_part = {
		name = "Chimera specimens",
		tier = "rare",
		evidence = (
			"Chimera claw90 but quarry is exceptionally dangerous; kept separate from 20-percent "
			.. "common boss parts."
		),
		candidates = {
			{ item = "part_chimera" },
		},
	},
	large_parts = {
		name = "Large humanoid specimens",
		tier = "rare",
		evidence = (
			"mutantpoaching: burer hand45 and skeleton spine40; uncommon dangerous quarry."
		),
		candidates = {
			{ item = "part_burer_1" },
			{ item = "part_skeleton" },
		},
	},
	hellhound_part = {
		name = "Hellhound specimens",
		tier = "rare",
		evidence = (
			"Distinct hellhound threshold 50 and quarry."
		),
		candidates = {
			{ item = "part_hellhound" },
		},
	},
	rare_parts = {
		name = "Rare humanoid trophies",
		tier = "rare",
		evidence = (
			"mutantpoaching: snork mask threshold 4 and zombie sternum 5; low-probability trophies."
		),
		candidates = {
			{ item = "part_snork_2" },
			{ item = "part_zombie_2" },
		},
	},
	brains = {
		name = "Psionic research specimens",
		tier = "rare",
		evidence = (
			"mutantpoaching: burer/karlik/swamp/electro brains threshold 5, controller/psydog "
			.. "brains 4."
		),
		candidates = {
			{ item = "part_burer_2" },
			{ item = "part_karlik_2" },
			{ item = "part_swampcontroller_2" },
			{ item = "part_electrocontroller_2" },
			{ item = "part_controller_2" },
			{ item = "part_psydog" },
		},
	},
	common_hides = {
		name = "Ordinary mutant hides",
		tier = "rare",
		evidence = (
			"mutantpoaching: dog3, flesh3, cat4. All rare successful hides from ordinary quarry."
		),
		candidates = {
			{ item = "hide_blinddog" },
			{ item = "hide_flesh" },
			{ item = "hide_cat" },
		},
	},
	predator_hides = {
		name = "Predator hides",
		tier = "rare",
		evidence = (
			"mutantpoaching: pseudodog threshold 2-5 and bloodsucker 2."
		),
		candidates = {
			{ item = "hide_pseudodog" },
			{ item = "hide_bloodsucker" },
		},
	},
	elite_hides = {
		name = "Elite mutant hides",
		tier = "rare",
		evidence = (
			"mutantpoaching: controller3, electrocontroller3, vareshka3, karlik4, chimera2-3, "
			.. "pseudogiant3-5."
		),
		candidates = {
			{ item = "hide_controller" },
			{ item = "hide_electrocontroller" },
			{ item = "hide_vareshka" },
			{ item = "hide_karlik" },
			{ item = "hide_chimera" },
			{ item = "hide_pseudogiant" },
		},
	},
	common_meals = {
		name = "Cooked ordinary mutant meals",
		tier = "common",
		evidence = (
			"Cooked meals from guaranteed blinddog, tushkano, flesh, boar or cat meat harvests. "
			.. "Ordinary quarry followed by cooking."
		),
		candidates = {
			{ item = "meal_tushkano" },
			{ item = "meal_flesh" },
			{ item = "meal_boar" },
			{ item = "meal_cat" },
			{ item = "meal_blinddog" },
		},
	},
	predator_meals = {
		name = "Cooked predator meals",
		tier = "uncommon",
		evidence = (
			"Cooked snork, bloodsucker or pseudodog meals; guaranteed meat from dangerous predator "
			.. "quarry, followed by cooking."
		),
		candidates = {
			{ item = "meal_snork" },
			{ item = "meal_bloodsucker" },
			{ item = "meal_pseudodog" },
		},
	},
	exotic_meals = {
		name = "Cooked exotic meals",
		tier = "rare",
		evidence = (
			"Cooked sprig, spider, karlik, tark or vareshka meals; guaranteed meat from exotic "
			.. "quarry, followed by cooking. Encounter difficulty needs playtesting."
		),
		candidates = {
			{ item = "meal_sprig" },
			{ item = "meal_spider" },
			{ item = "meal_karlik" },
			{ item = "meal_tark" },
			{ item = "meal_vareshka" },
		},
	},
	elite_meals = {
		name = "Cooked apex mutant meals",
		tier = "rare",
		evidence = (
			"Cookable item meal outputs: chimera/pseudogiant meat followed by cooking."
		),
		candidates = {
			{ item = "meal_chimera" },
			{ item = "meal_pseudogiant" },
		},
	},
	common_artifacts = {
		name = "Common anomalous specimens",
		tier = "uncommon",
		evidence = (
			"anomalydefs commonArtifacts: shared field debris plus ordinary thermal, gravitational "
			.. "and chemical specimens; all use the common field tier."
		),
		candidates = {
			{ item = "artifact_bolt" },
			{ item = "artifact_bonecluster" },
			{ item = "artifact_droplet" },
			{ item = "artifact_mementomori" },
			{ item = "artifact_thorn" },
			{ item = "artifact_grapes" },
			{ item = "artifact_mycelia" },
			{ item = "artifact_slime" },
		},
	},
	electrical_artifacts = {
		name = "Common electrical artifacts",
		tier = "uncommon",
		evidence = (
			"Electro commonArtifacts: battery/blowncap/sparkler share field source; cache tier1 "
			.. "weights500-750."
		),
		candidates = {
			{ item = "artifact_battery" },
			{ item = "artifact_blowncap" },
			{ item = "artifact_sparkler" },
		},
	},
	rare_electrical_artifacts = {
		name = "Rare electrical artifacts",
		tier = "rare",
		evidence = (
			"Electro/Electro 2 rareArtifacts: flash, capacitor and moonlight; rare electrical "
			.. "specimens."
		),
		candidates = {
			{ item = "artifact_flash" },
			{ item = "artifact_capacitor" },
			{ item = "artifact_moonlight" },
		},
	},
	rare_field_artifacts = {
		name = "Rare field artifacts",
		tier = "rare",
		evidence = (
			"Burner/Bubble rareArtifacts: crystal, eye, mamasbeads, panacea, gaia and dwarfgalaxy. "
			.. "Separate from common and exceptional field tiers."
		),
		candidates = {
			{ item = "artifact_crystal" },
			{ item = "artifact_eye" },
			{ item = "artifact_mamasbeads" },
			{ item = "artifact_panacea" },
			{ item = "artifact_gaia" },
			{ item = "artifact_dwarfgalaxy" },
		},
	},
	chemical_artifacts = {
		name = "Rare chemical artifacts",
		tier = "rare",
		evidence = (
			"Fruitpunch rareArtifacts: slug/cell; cache tier2 both800-1000."
		),
		candidates = {
			{ item = "artifact_slug" },
			{ item = "artifact_cell" },
		},
	},
	exceptional_artifacts = {
		name = "Exceptional field artifacts",
		tier = "exceptional",
		evidence = (
			"anomalydefs veryRareArtifacts: mica, arachno, flame and storm; exceptional chemical, "
			.. "gravitational, thermal or electrical specimens."
		),
		candidates = {
			{ item = "artifact_mica" },
			{ item = "artifact_arachno" },
			{ item = "artifact_flame" },
			{ item = "artifact_storm" },
		},
	},
	bubble_artifacts = {
		name = "Exceptional Bubble artifacts",
		tier = "exceptional",
		evidence = (
			"Bubble/Bubble 2 veryRareArtifacts: galaxy and gmamasbeads. cache_valuable weights "
			.. "450/900. Electrical artifacts cannot replace the Bubble specimen."
		),
		candidates = {
			{ item = "artifact_galaxy" },
			{ item = "artifact_gmamasbeads" },
		},
	},
	detector = {
		name = "Detector calibration",
		tier = "fixed",
		evidence = (
			"A detector is the actual calibration input; no unrelated substitute."
		),
		candidates = {
			{ item = "detectorecho" },
		},
	},
	flashdrive = {
		name = "Quartermaster story key",
		tier = "fixed",
		evidence = (
			"Quest flash drive sold by Mute after radio tower completion; identity must stay fixed."
		),
		candidates = {
			{ item = "quest_flashdrive" },
		},
	},
	computer_case = {
		name = "Computer story key",
		tier = "fixed",
		evidence = (
			"Armored case sold after Intern milestone; identity must stay fixed."
		),
		candidates = {
			{ item = "quest_computeraccess" },
		},
	},
	administrative_documents = {
		name = "Administrative records",
		tier = "uncommon",
		evidence = (
			"worldspawn_1 and common boxes: empty notebook weight 100, trading ledger 50. "
			.. "Administrative records with comparable source routes."
		),
		candidates = {
			{ item = "value_documents_1" },
			{ item = "value_documents_2" },
		},
	},
	field_instruments = {
		name = "Field instrument hardware",
		tier = "rare",
		evidence = (
			"worldspawn_4/6: FPGA 100, LCD 80 and powerbank 200. Shares candidates with computer "
			.. "and electrical salvage pools."
		),
		candidates = {
			{ item = "value_pcpart_fpga" },
			{ item = "value_pcpart_lcd" },
			{ item = "value_powerbank" },
		},
	},
	industrial_supplies = {
		name = "Industrial repair supplies",
		tier = "rare",
		evidence = (
			"worldspawn_1: military tape 100, heavy wire 150, car battery 130 and engine 75. "
			.. "Overlaps the machinery and electrical categories."
		),
		candidates = {
			{ item = "value_tape_heavy" },
			{ item = "value_wire_heavy" },
			{ item = "value_carbattery" },
			{ item = "value_engine" },
		},
	},
	burner_artifacts = {
		name = "Rare thermal artifacts",
		tier = "rare",
		evidence = (
			"Burner/Burner 2 rareArtifacts: crystal and eye. A dedicated thermal specimen slot "
			.. "prevents another anomaly family replacing it."
		),
		candidates = {
			{ item = "artifact_crystal" },
			{ item = "artifact_eye" },
		},
	},
	gravitational_artifacts = {
		name = "Rare gravitational artifacts",
		tier = "rare",
		evidence = (
			"Whirlgig rareArtifacts: urchin and kolobok. A dedicated gravitational specimen slot."
		),
		candidates = {
			{ item = "artifact_urchin" },
			{ item = "artifact_kolobok" },
		},
	},
	exceptional_electrical_artifacts = {
		name = "Exceptional electrical artifacts",
		tier = "exceptional",
		evidence = (
			"Electro/Electro 2 veryRareArtifacts: halo and storm; same exceptional field tier."
		),
		candidates = {
			{ item = "artifact_halo" },
			{ item = "artifact_storm" },
		},
	},
	advanced_parts_map1 = {
		name = "Advanced workshop tools (Marsh)",
		tier = "rare",
		evidence = (
			"worldspawn_1: advanced toolbox weight 5. GPU and SSD candidates are excluded because "
			.. "their active world spawns begin in Waystation; this rare local tool keeps its tier."
		),
		candidates = {
			{ item = "value_techtool_2" },
		},
	},
	heavy_electrical_map1 = {
		name = "Heavy electrical salvage (Marsh)",
		tier = "rare",
		evidence = (
			"worldspawn_1: car battery 130, heavy wire 150, military tape 100. Powerbanks are "
			.. "excluded because their only active world spawn is worldspawn_4, Waystation hard loot."
		),
		candidates = {
			{ item = "value_carbattery" },
			{ item = "value_wire_heavy" },
			{ item = "value_tape_heavy" },
		},
	},
	local_beer = {
		name = "Ordinary beer",
		tier = "uncommon",
		evidence = (
			"reward_consumable: ordinary beers 1/2/3 all weight 75. Used by map-1 assorted caches "
			.. "1/4/5/6. Excludes Pripyat-only world-spawn beer candidates; this is a cache route."
		),
		candidates = {
			{ item = "drink_canbeer_1" },
			{ item = "drink_canbeer_2" },
			{ item = "drink_canbeer_3" },
		},
	},
	local_refreshments = {
		name = "Ordinary refreshments",
		tier = "uncommon",
		evidence = (
			"reward_consumable: bottled water 100, canned water 150 and orange juice 200. Used by "
			.. "map-1 assorted caches 1/4/5/6. Excludes drinks with Pripyat-only world-spawn entries."
		),
		candidates = {
			{ item = "drink_bottlewater" },
			{ item = "drink_canwater" },
			{ item = "drink_orangejuice" },
		},
	},
	town_medical = {
		name = "Basic clinical supplies",
		tier = "common",
		candidates = {{item = "medic_bandage_1"}, {item = "medic_medkit_1"}},
	},
	town_ammunition = {
		name = "Common ammunition",
		tier = "common",
		candidates = {{item = "12gauge"}, {item = "9x18"}, {item = "9x19"}},
	},
	town_ammunition_military = {
		name = "Operational ammunition",
		tier = "common",
		candidates = {{item = "545x39"}, {item = "556x45"}, {item = "762x39"}},
	},
	town_textiles = {
		name = "Textile repair and carrying supplies",
		tier = "common",
		candidates = {{item = "value_paracord"}, {item = "value_tape_duct"}},
	},
	-- Authoring pools await acquisition playtesting before use in jobs or progression slots.
	valuables_armour_panels = {
		name = "Recovered armour inserts",
		tier = "uncommon",
		candidates = {
			{item = "value_ballistic1"},
			{item = "value_ballistic11"},
			{item = "value_ballistic3"},
			{item = "value_ballistic4"},
			{item = "value_ballistic6"},
			{item = "value_ballistic7"},
		},
	},
	valuables_cleaning_supplies = {
		name = "Cleaning and household chemicals",
		tier = "uncommon",
		candidates = {
			{item = "value_antiinsect"},
			{item = "value_bleach"},
			{item = "value_chlorine"},
			{item = "value_draincleaner"},
			{item = "value_glasscleaner"},
			{item = "value_household_repellent"},
			{item = "value_household_toothpaste1"},
			{item = "value_household_tree_life_extender"},
			{item = "value_ratpoison"},
			{item = "value_shampoo"},
			{item = "value_soap"},
			{item = "value_soda"},
		},
	},
	valuables_clinical_supplies = {
		name = "Clinical fluids and pharmacy stock",
		tier = "uncommon",
		candidates = {
			{item = "value_med_aquatabs"},
			{item = "value_med_ibuprofen"},
			{item = "value_med_medicalstock"},
			{item = "value_med_peroxide"},
			{item = "value_med_petroleumjelly"},
			{item = "value_med_saline"},
			{item = "value_med_vitamins"},
		},
	},
	valuables_computer_parts = {
		name = "Computer components and storage drives",
		tier = "uncommon",
		candidates = {
			{item = "value_electr_hdd_quest"},
			{item = "value_electr_ssd"},
			{item = "value_pcpart_cpu"},
			{item = "value_pcpart_cpufan"},
			{item = "value_pcpart_discdrive"},
			{item = "value_pcpart_ram"},
			{item = "value_sas"},
		},
	},
	valuables_control_electronics = {
		name = "Control and interface electronics",
		tier = "uncommon",
		candidates = {
			{item = "value_controller"},
			{item = "value_electr_adv_controller"},
			{item = "value_electr_card_programmer"},
			{item = "value_electr_countermeasure"},
			{item = "value_rfidreader"},
		},
	},
	valuables_cutting_tools = {
		name = "Cutting and gripping tools",
		tier = "uncommon",
		candidates = {
			{item = "value_awl"},
			{item = "value_pliers"},
			{item = "value_swiss"},
			{item = "value_tools_metalscissors"},
			{item = "value_tools_nippers"},
			{item = "value_tools_pliers_round"},
		},
	},
	valuables_data_archives = {
		name = "Recovered archive media and modules",
		tier = "uncommon",
		candidates = {
			{item = "value_info_securedtape"},
		},
	},
	valuables_decorative_valuables = {
		name = "Decorative and collectible valuables",
		tier = "uncommon",
		candidates = {
			{item = "value_antique_teapot"},
			{item = "value_antique_vase"},
			{item = "value_bear_souvenir"},
			{item = "value_lighter_gold"},
			{item = "value_pocketwatch"},
			{item = "value_skullring"},
			{item = "value_statue_raven"},
			{item = "value_woodclock"},
		},
	},
	valuables_drivers_wrenches = {
		name = "Screwdrivers and wrenches",
		tier = "uncommon",
		candidates = {
			{item = "value_pipewrench"},
			{item = "value_precisiontools"},
			{item = "value_screwdriver"},
			{item = "value_tools_advwrench"},
			{item = "value_tools_ratchetwrench"},
			{item = "value_tools_screwdriver_flat"},
			{item = "value_tools_screwdriver_flat_long"},
			{item = "value_wrench"},
		},
	},
	valuables_electrical_supplies = {
		name = "Electrical installation supplies",
		tier = "uncommon",
		candidates = {
			{item = "value_electr_tplug"},
			{item = "value_helix"},
			{item = "value_kanifol"},
			{item = "value_lamp_efficient"},
			{item = "value_lamp_uv"},
			{item = "value_magnet"},
			{item = "value_powercable"},
			{item = "value_powerfilter"},
			{item = "value_usb_adapter"},
		},
	},
	valuables_electronic_components = {
		name = "Boards, displays and electronic components",
		tier = "uncommon",
		candidates = {
			{item = "value_circuitboard"},
			{item = "value_electr_components"},
			{item = "value_ipcamera"},
			{item = "value_lcddirty"},
			{item = "value_militaryboard"},
			{item = "value_sz_1"},
			{item = "value_textolite"},
			{item = "value_transistors"},
		},
	},
	valuables_equipment_pouches = {
		name = "Small equipment pouches and sleeves",
		tier = "uncommon",
		candidates = {
			{item = "value_container_cardholder"},
			{item = "value_container_injectorcase"},
			{item = "value_container_lopouch"},
			{item = "value_container_smallitems"},
			{item = "value_docbag"},
		},
	},
	valuables_field_records = {
		name = "Maps and personal field journals",
		tier = "uncommon",
		candidates = {
			{item = "value_info_maps"},
			{item = "value_info_moleskine"},
			{item = "value_maps"},
			{item = "value_milimap"},
			{item = "value_thick_diary"},
			{item = "value_thin_diary"},
		},
	},
	valuables_filtration = {
		name = "Filters and flow-control fittings",
		tier = "uncommon",
		candidates = {
			{item = "value_airfilter"},
			{item = "value_labyrinth_valve"},
			{item = "value_other_filter"},
			{item = "value_other_hosemilitary"},
		},
	},
	valuables_flash_media = {
		name = "Recovered flash drives",
		tier = "uncommon",
		candidates = {
			{item = "value_flash_card_ironkey"},
			{item = "value_flash_card_ironkey_slider"},
			{item = "value_flash_card_slider"},
			{item = "value_info_militaryflash"},
		},
	},
	valuables_fuel_supplies = {
		name = "Fuel and firelighting supplies",
		tier = "uncommon",
		candidates = {
			{item = "value_crikent_0"},
			{item = "value_dryfuel"},
			{item = "value_flammable_huntermatches"},
			{item = "value_flammable_klean"},
			{item = "value_flammable_survlighter"},
			{item = "value_gascan"},
			{item = "value_kerosene_container"},
			{item = "value_match"},
			{item = "value_matches"},
			{item = "value_valuable_kresalo"},
			{item = "value_zibbo_0"},
		},
	},
	valuables_instruments = {
		name = "Recovered precision instruments",
		tier = "uncommon",
		candidates = {
			{item = "value_electro_gyroscope"},
			{item = "value_gyroscope"},
			{item = "value_gyrotachometer"},
			{item = "value_optical_lens"},
			{item = "value_pressuregauge"},
			{item = "value_sensor_a"},
			{item = "value_sensor_d"},
			{item = "value_thermalmodule"},
		},
	},
	valuables_irregular_patches = {
		name = "Irregular faction and unit patches",
		tier = "uncommon",
		candidates = {
			{item = "value_chevron_bear"},
		},
	},
	valuables_medical_equipment = {
		name = "Diagnostic and surgical equipment",
		tier = "uncommon",
		candidates = {
			{item = "value_med_ledx"},
			{item = "value_med_ledx_red"},
			{item = "value_med_ophthalmoscope"},
			{item = "value_med_surgicalpouch"},
			{item = "value_med_surgicalpouch_worn"},
			{item = "value_med_surgicalroll"},
			{item = "value_med_surgicaltools"},
			{item = "value_med_thermometer"},
		},
	},
	valuables_military_cases = {
		name = "Military and armament transit cases",
		tier = "uncommon",
		candidates = {
			{item = "value_container_ammo"},
			{item = "value_container_parls"},
			{item = "value_container_weapon_thicc"},
			{item = "value_container_weaponcase"},
		},
	},
	valuables_office_records = {
		name = "Office stationery and shipping records",
		tier = "uncommon",
		candidates = {
			{item = "value_envelope"},
			{item = "value_letter"},
			{item = "value_note_folder_closed_cardboard"},
			{item = "value_notepad_a5_closed_01"},
			{item = "value_notepad_a6_closed_01"},
			{item = "value_officepaper"},
		},
	},
	valuables_ordnance_salvage = {
		name = "Recovered ordnance stock",
		tier = "uncommon",
		candidates = {
			{item = "value_balloon_poison_gas"},
			{item = "value_c4"},
			{item = "value_dynamite"},
			{item = "value_explosive_charge"},
			{item = "value_flammable_thermite"},
			{item = "value_flammable_trotil"},
			{item = "value_other_uzrgm_fuse"},
		},
	},
	valuables_personal_effects = {
		name = "Personal effects and keepsakes",
		tier = "uncommon",
		candidates = {
			{item = "value_barter_walletwz"},
			{item = "value_bogatir_moreman_tag"},
			{item = "value_crow_beak"},
			{item = "value_key_danexert"},
			{item = "value_lightkeeper_amulet"},
			{item = "value_other_bage_ng"},
			{item = "value_strelets_amulet"},
			{item = "value_wallet"},
		},
	},
	valuables_portable_computers = {
		name = "Recovered portable computers",
		tier = "uncommon",
		candidates = {
			{item = "value_field_laptop"},
			{item = "value_pcpart_laptop"},
			{item = "value_pda2"},
			{item = "value_pda3"},
		},
	},
	valuables_portable_power = {
		name = "Recovered battery assemblies",
		tier = "uncommon",
		candidates = {
			{item = "value_battery_d_0"},
			{item = "value_energy_accum"},
			{item = "value_energy_cyclon"},
			{item = "value_energy_greenbat"},
			{item = "value_militarybattery"},
		},
	},
	valuables_printed_material = {
		name = "Magazines, newspapers and books",
		tier = "uncommon",
		candidates = {
			{item = "value_flyer_01"},
			{item = "value_flyer_02"},
			{item = "value_flyer_03"},
			{item = "value_flyers"},
			{item = "value_gamemagazine_01"},
			{item = "value_info_labrys"},
			{item = "value_note_book_coming_closed"},
			{item = "value_note_newspaper_folded_01"},
			{item = "value_note_newspaper_folded_02"},
		},
	},
	valuables_protective_textiles = {
		name = "Protective textile rolls and linings",
		tier = "uncommon",
		candidates = {
			{item = "value_retardant1"},
			{item = "value_retardant10"},
			{item = "value_retardant11"},
			{item = "value_retardant12"},
			{item = "value_retardant2"},
			{item = "value_retardant3"},
			{item = "value_retardant4"},
			{item = "value_retardant6"},
			{item = "value_retardant9"},
		},
	},
	valuables_provisions = {
		name = "Packaged dry provisions",
		tier = "uncommon",
		candidates = {
			{item = "value_coffee"},
			{item = "value_household_salt"},
			{item = "value_other_grechka"},
			{item = "value_other_lupo"},
			{item = "value_other_tea"},
			{item = "value_sugar"},
		},
	},
	valuables_radio_components = {
		name = "Signal processing components",
		tier = "uncommon",
		candidates = {
			{item = "value_electr_adv_amplifier"},
			{item = "value_electr_adv_converter"},
			{item = "value_electr_adv_ultralink"},
			{item = "value_phaseantenna"},
			{item = "value_phaserelay"},
		},
	},
	valuables_radio_equipment = {
		name = "Recovered radio and signalling equipment",
		tier = "uncommon",
		candidates = {
			{item = "value_ais_sart"},
			{item = "value_electr_gary_zont"},
			{item = "value_electr_signal_jammer"},
			{item = "value_ir_ms2000"},
			{item = "value_jamming"},
			{item = "value_radio"},
			{item = "value_radio_repeater"},
			{item = "value_receiver1"},
		},
	},
	valuables_recording_equipment = {
		name = "Recorders and recovered recordings",
		tier = "uncommon",
		candidates = {
			{item = "value_archive_cassette"},
			{item = "value_cassette_black90"},
			{item = "value_cassette_fiolet"},
			{item = "value_spec_recorder"},
		},
	},
	valuables_reinforced_cases = {
		name = "Reinforced equipment cases",
		tier = "uncommon",
		candidates = {
			{item = "value_container_junkbox"},
			{item = "value_large_case"},
		},
	},
	valuables_repair_parts = {
		name = "Mechanical and equipment repair parts",
		tier = "uncommon",
		candidates = {
			{item = "value_large_parts"},
			{item = "value_metalparts"},
			{item = "value_parts"},
			{item = "value_screws"},
			{item = "value_upgro1"},
			{item = "value_upgro2"},
			{item = "value_upgro3"},
			{item = "value_upgrw2"},
			{item = "value_upgrw3"},
			{item = "value_waste_heavy"},
			{item = "value_waste_light"},
			{item = "value_weaponparts"},
		},
	},
	valuables_research_injectors_a = {
		name = "Recovered labelled research injectors",
		tier = "uncommon",
		candidates = {
			{item = "value_injector_2a2"},
			{item = "value_injector_3btg"},
			{item = "value_injector_ahf1m"},
			{item = "value_injector_l1"},
			{item = "value_injector_mildronate"},
			{item = "value_injector_mule"},
			{item = "value_injector_obdolbos"},
		},
	},
	valuables_research_injectors_b = {
		name = "Recovered labelled research injectors II",
		tier = "uncommon",
		candidates = {
			{item = "value_injector_obdolbos_2"},
			{item = "value_injector_p22"},
			{item = "value_injector_perfotoran"},
			{item = "value_injector_sj12"},
			{item = "value_injector_sj9"},
			{item = "value_injector_trimadol"},
			{item = "value_injector_xtg12"},
		},
	},
	valuables_research_samples = {
		name = "Recovered biological and chemical samples",
		tier = "uncommon",
		candidates = {
			{item = "value_anomaly_plant"},
			{item = "value_chemicalsample"},
			{item = "value_med_bloodsample"},
			{item = "value_plasticbag_labyrinth"},
		},
	},
	valuables_sample_carriers = {
		name = "Research sample carriers",
		tier = "uncommon",
		candidates = {
			{item = "value_chemcontainer"},
			{item = "value_event_labyrinth_chem_container"},
			{item = "value_portable_container_closed"},
			{item = "value_portable_container_opened"},
			{item = "value_quest_biohazard_case"},
			{item = "value_thermobag"},
		},
	},
	valuables_secured_cases = {
		name = "Secured transit cases",
		tier = "uncommon",
		candidates = {
			{item = "value_safe_container"},
		},
	},
	valuables_specialist_cases = {
		name = "Specialist equipment cases",
		tier = "uncommon",
		candidates = {
			{item = "value_container_trackcase"},
			{item = "value_drugskit"},
		},
	},
	valuables_survey_equipment = {
		name = "Recovered survey equipment",
		tier = "uncommon",
		candidates = {
			{item = "value_casezerogeo"},
			{item = "value_detector"},
			{item = "value_geigercounter"},
			{item = "value_minedetector"},
			{item = "value_scanner_anomaly"},
			{item = "value_scanner_artefact"},
		},
	},
	valuables_technical_records = {
		name = "Workshop and survival reference books",
		tier = "uncommon",
		candidates = {
			{item = "value_clothbook1"},
			{item = "value_clothbook2"},
			{item = "value_guide"},
			{item = "value_handbook_circuits"},
			{item = "value_handbook_materials"},
			{item = "value_manual_lada"},
		},
	},
	valuables_textile_supplies = {
		name = "Fabric, sewing and carrying supplies",
		tier = "uncommon",
		candidates = {
			{item = "value_bedspread"},
			{item = "value_fabric_aramid"},
			{item = "value_fabric_cordura"},
			{item = "value_fabric_fleece"},
			{item = "value_fabric_ripstop"},
			{item = "value_fabrics1"},
			{item = "value_fabrics2"},
			{item = "value_rope"},
			{item = "value_ropes"},
			{item = "value_sewingkit"},
			{item = "value_tarp"},
			{item = "value_tools_sewing"},
		},
	},
	valuables_transit_cases = {
		name = "General transit cases and consignments",
		tier = "uncommon",
		candidates = {
			{item = "value_briefcase"},
			{item = "value_carbon_case"},
			{item = "value_knife_box_low"},
			{item = "value_parcel"},
			{item = "value_pukt90"},
			{item = "value_security_box"},
			{item = "value_small_case"},
		},
	},
	valuables_trauma_supplies = {
		name = "Trauma and injection supplies",
		tier = "uncommon",
		candidates = {
			{item = "value_med_bloodset"},
			{item = "value_med_haemostatic"},
			{item = "value_med_injectiondevice"},
			{item = "value_med_splint"},
			{item = "value_med_syringe"},
			{item = "value_med_tourniquet"},
			{item = "value_med_tourniquet_rubber"},
		},
	},
	valuables_workshop_consumables = {
		name = "Adhesives, lubricants and repair sheets",
		tier = "uncommon",
		candidates = {
			{item = "value_building_kektape"},
			{item = "value_building_plexiglass"},
			{item = "value_building_poxeram"},
			{item = "value_expandingfoam"},
			{item = "value_plastic"},
			{item = "value_plexiglass"},
			{item = "value_wd40_100ml"},
			{item = "value_wd40_400ml"},
		},
	},
	valuables_workshop_tools = {
		name = "Workshop tools and tool sets",
		tier = "uncommon",
		candidates = {
			{item = "value_crowbar"},
			{item = "value_electricdrill"},
			{item = "value_hammer"},
			{item = "value_handdrill"},
			{item = "value_hultafors_db5000"},
			{item = "value_key_labyrinth_torch"},
			{item = "value_mining_kit"},
			{item = "value_multitul_0"},
			{item = "value_tapemeasure"},
			{item = "value_toolset"},
		},
	},
}
