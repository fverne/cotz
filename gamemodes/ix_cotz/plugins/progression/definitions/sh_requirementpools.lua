ix.progression = ix.progression or {}

ix.progression.itemPools = {
	hideout_access_tool = {
		name = "Hideout access tool",
		tier = "common",
		evidence = "Crowbar or bat; existing melee items obtainable in Marsh.",
		candidates = {{item = "crowbar"}},
	},
	hideout_access_sledgehammer = {
		name = "Cleaner hideout access tool",
		tier = "common",
		candidates = {{item = "sledgehammer"}},
	},
	hideout_access_fubar = {
		name = "Ledger hideout access tool",
		tier = "common",
		candidates = {{item = "fubar"}},
	},
	fasteners = {
		name = "Common fasteners",
		tier = "common",
		evidence = (
			"worldspawn_1: nuts/bolts/nails weights 77/84/57. Screws use Garbage regular (1189); "
			.. "stack yields are nuts 3-8, bolts 4-8, screws 1-2. Screws are a later-region alternative."
		),
		candidates = {
			{ item = "value_nuts" },
			{ item = "value_bolts" },
			{ item = "value_nails" },
			{ item = "value_screws" },
		},
	},
	batteries = {
		name = "Portable power",
		tier = "common",
		evidence = (
			"worldspawn_3: 1.5V/9V/D-cell weights 105/122/96. D-cells are whole items; "
			.. "the older batteries yield multiple units. D-cells begin in Waystation."
		),
		candidates = {
			{ item = "value_battery" },
			{ item = "value_9vbattery" },
			{ item = "value_battery_d_0" },
		},
	},
	small_electronics = {
		name = "Common electrical components",
		tier = "common",
		evidence = (
			"worldspawn_1: capacitors/copper wire/light wire weights 42/59/73. "
			.. "Light wire also serves electrical repairs and field maintenance."
		),
		candidates = {
			{ item = "value_capacitors" },
			{ item = "value_wire_copper" },
			{ item = "value_wire_light" },
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
			"worldspawn_1: electrical tape/light wire/spark plugs/copper wire weights 64/73/70/59. "
			.. "Paracord belongs to field repair and textiles, rather than electrical insulation."
		),
		candidates = {
			{ item = "value_tape_electric" },
			{ item = "value_wire_light" },
			{ item = "value_sparkplug" },
			{ item = "value_wire_copper" },
		},
	},
	cleaning = {
		name = "Household cleaning supplies",
		tier = "uncommon",
		evidence = (
			"worldspawn_1: paper/toothpaste/detergent weights 85/85/68; shampoo/soap/ "
			.. "recovered toothpaste/bleach/glass cleaner 84/79/72/74/80. All share Marsh regular loot."
		),
		candidates = {
			{ item = "value_toiletpaper" },
			{ item = "value_toothpaste" },
			{ item = "value_detergent" },
			{ item = "value_shampoo" },
			{ item = "value_soap" },
			{ item = "value_household_toothpaste1" },
			{ item = "value_bleach" },
			{ item = "value_glasscleaner" },
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
			"worldspawn_3: gun oil/paracord/light wire/electrical tape weights 72/65/72/72; "
			.. "lubricant 57. Lubricant also belongs to weapon maintenance."
		),
		candidates = {
			{ item = "value_gunoil" },
			{ item = "value_paracord" },
			{ item = "value_wire_light" },
			{ item = "value_tape_electric" },
			{ item = "value_lubricant" },
		},
	},
	statues = {
		name = "Decorative statuettes",
		tier = "uncommon",
		evidence = (
			"worldspawn_2: cat/lion/horse/raven weights 182/116/81/134. "
			.. "The raven shares the Marsh rare source; other statuettes also appear in later regions."
		),
		candidates = {
			{ item = "value_statue_cat" },
			{ item = "value_statue_lion" },
			{ item = "value_statue_horse" },
			{ item = "value_statue_raven" },
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
			"Motor conditioner weights 21/42/47 in worldspawn_1/3/5; small lubricant aerosol "
			.. "weight 20 in Garbage regular. Large aerosol (105) is excluded as substantially more common."
		),
		candidates = {
			{ item = "value_motorclean" },
			{ item = "value_wd40_100ml" },
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
		evidence = (
			"worldspawn_1: paracord/duct tape weights 48/57; rope/grey rope/sewing kit/ "
			.. "sewing pouch/tarpaulin 85/83/77/80/80. Whole items complement quantity-bearing tape."
		),
		candidates = {
			{item = "value_paracord"},
			{item = "value_tape_duct"},
			{ item = "value_rope" },
			{ item = "value_ropes" },
			{ item = "value_sewingkit" },
			{ item = "value_tools_sewing" },
			{ item = "value_tarp" },
		},
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

	-- FTS delivery availability bands. Rebuild with docs/npc-overhaul/tools/fts_delivery_balance.py.
	town_delivery_collectibles_marsh_1 = {
		name = "Collectible finds (Marsh, band 1)",
		tier = "common",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_flyer_01"},
			{item = "value_flyer_03"},
			{item = "value_gamemagazine_01"},
			{item = "value_crow_beak"},
		},
	},
	town_delivery_collectibles_marsh_2 = {
		name = "Collectible finds (Marsh, band 2)",
		tier = "uncommon",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_bear_souvenir"},
			{item = "value_info_moleskine"},
			{item = "value_statue_cat"},
			{item = "value_maps"},
		},
	},
	town_delivery_collectibles_marsh_3 = {
		name = "Collectible finds (Marsh, band 3)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_lightkeeper_amulet"},
			{item = "value_thick_diary"},
			{item = "value_statue_lion"},
			{item = "value_statue_horse"},
		},
	},
	town_delivery_collectibles_marsh_4 = {
		name = "Collectible finds (Marsh, band 4)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_skullring"},
			{item = "value_lighter_gold"},
			{item = "value_watch"},
			{item = "value_goldchain"},
		},
	},
	town_delivery_electronics_marsh_1 = {
		name = "Electronic supplies (Marsh, band 1)",
		tier = "common",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_battery"},
			{item = "value_9vbattery"},
			{item = "value_wire_copper"},
			{item = "value_capacitors"},
			{item = "value_tape_electric"},
			{item = "value_sparkplug"},
			{item = "value_wire_light"},
		},
	},
	town_delivery_electronics_marsh_2 = {
		name = "Electronic supplies (Marsh, band 2)",
		tier = "uncommon",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_receiver1"},
			{item = "value_battery_d_0"},
			{item = "value_ir_ms2000"},
			{item = "value_radio"},
			{item = "value_flash_card_slider"},
			{item = "value_circuitboard"},
			{item = "value_flash_card_ironkey"},
		},
	},
	town_delivery_electronics_marsh_3 = {
		name = "Electronic supplies (Marsh, band 3)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_flash_card_ironkey_slider"},
			{item = "value_electr_components"},
			{item = "value_electr_card_programmer"},
			{item = "value_pcpart_cpufan"},
			{item = "value_pcpart_discdrive"},
			{item = "value_pcpart_ram"},
			{item = "value_ipcamera"},
		},
	},
	town_delivery_electronics_marsh_4 = {
		name = "Electronic supplies (Marsh, band 4)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_pda2"},
			{item = "value_pda3"},
			{item = "value_phaserelay"},
			{item = "value_controller"},
			{item = "value_electr_adv_converter"},
			{item = "value_electr_adv_controller"},
			{item = "value_electr_adv_ultralink"},
			{item = "value_pcpart_laptop"},
		},
	},
	town_delivery_electronics_waystation_1 = {
		name = "Electronic supplies (Waystation, band 1)",
		tier = "common",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_battery"},
			{item = "value_9vbattery"},
			{item = "value_tape_electric"},
			{item = "value_wire_light"},
			{item = "value_sparkplug"},
			{item = "value_capacitors"},
			{item = "value_receiver1"},
		},
	},
	town_delivery_electronics_waystation_2 = {
		name = "Electronic supplies (Waystation, band 2)",
		tier = "uncommon",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_battery_d_0"},
			{item = "value_ir_ms2000"},
			{item = "value_radio"},
			{item = "value_wire_copper"},
			{item = "value_flash_card_slider"},
			{item = "value_circuitboard"},
			{item = "value_flash_card_ironkey"},
		},
	},
	town_delivery_electronics_waystation_3 = {
		name = "Electronic supplies (Waystation, band 3)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_flash_card_ironkey_slider"},
			{item = "value_electr_components"},
			{item = "value_electr_card_programmer"},
			{item = "value_pcpart_cpufan"},
			{item = "value_pcpart_discdrive"},
			{item = "value_pcpart_ram"},
			{item = "value_ipcamera"},
		},
	},
	town_delivery_electronics_waystation_4 = {
		name = "Electronic supplies (Waystation, band 4)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_pda2"},
			{item = "value_pda3"},
			{item = "value_phaserelay"},
			{item = "value_controller"},
			{item = "value_electr_adv_converter"},
			{item = "value_electr_adv_controller"},
			{item = "value_electr_adv_ultralink"},
			{item = "value_pcpart_laptop"},
		},
	},
	town_delivery_kitchen_marsh_1 = {
		name = "Kitchen supplies (Marsh, band 1)",
		tier = "common",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_detergent"},
			{item = "value_bleach"},
			{item = "value_other_lupo"},
			{item = "value_coffee"},
			{item = "value_other_grechka"},
		},
	},
	town_delivery_kitchen_marsh_2 = {
		name = "Kitchen supplies (Marsh, band 2)",
		tier = "uncommon",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_soap"},
			{item = "food_bread"},
			{item = "food_raisins"},
			{item = "food_sausage_1"},
			{item = "food_sausage_2"},
		},
	},
	town_delivery_kitchen_marsh_3 = {
		name = "Kitchen supplies (Marsh, band 3)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "drink_orangejuice"},
			{item = "drink_canwater"},
			{item = "food_can_beans"},
			{item = "food_can_sprats"},
			{item = "food_can_tuna"},
		},
	},
	town_delivery_kitchen_marsh_4 = {
		name = "Kitchen supplies (Marsh, band 4)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "food_can_tushonka"},
			{item = "drink_bottlewater"},
			{item = "food_mre_ukraine"},
			{item = "food_mre_russia"},
			{item = "food_mre_usa"},
		},
	},
	town_delivery_medical_marsh_1 = {
		name = "Medical supplies (Marsh, band 1)",
		tier = "common",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "medic_bandage_1"},
			{item = "medic_medkit_1"},
			{item = "value_med_petroleumjelly"},
			{item = "value_med_peroxide"},
		},
	},
	town_delivery_medical_marsh_2 = {
		name = "Medical supplies (Marsh, band 2)",
		tier = "uncommon",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_med_vitamins"},
			{item = "value_other_hosemilitary"},
			{item = "value_airfilter"},
			{item = "value_other_filter"},
		},
	},
	town_delivery_medical_marsh_3 = {
		name = "Medical supplies (Marsh, band 3)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_med_haemostatic"},
			{item = "value_med_tourniquet"},
			{item = "value_med_thermometer"},
			{item = "value_injector_obdolbos"},
		},
	},
	town_delivery_medical_marsh_4 = {
		name = "Medical supplies (Marsh, band 4)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_med_bloodset"},
			{item = "value_injector_2a2"},
			{item = "value_injector_3btg"},
			{item = "value_med_surgicalpouch"},
			{item = "value_med_surgicaltools"},
		},
	},
	town_delivery_military_garbage_1 = {
		name = "Military supplies (Garbage, band 1)",
		tier = "common",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_ballistic4"},
			{item = "value_container_lopouch"},
		},
	},
	town_delivery_military_garbage_2 = {
		name = "Military supplies (Garbage, band 2)",
		tier = "uncommon",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "9x18"},
			{item = "545x39"},
			{item = "value_container_injectorcase"},
			{item = "556x45"},
			{item = "value_ballistic11"},
			{item = "value_ballistic6"},
		},
	},
	town_delivery_military_garbage_3 = {
		name = "Military supplies (Garbage, band 3)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_docbag"},
			{item = "value_retardant3"},
			{item = "value_retardant4"},
			{item = "value_retardant9"},
			{item = "value_flammable_trotil"},
		},
	},
	town_delivery_military_garbage_4 = {
		name = "Military supplies (Garbage, band 4)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_balloon_poison_gas"},
			{item = "value_other_uzrgm_fuse"},
			{item = "value_container_ammo"},
			{item = "value_container_weaponcase"},
			{item = "value_safe_container"},
			{item = "value_container_parls"},
		},
	},
	town_delivery_military_waystation_1 = {
		name = "Military supplies (Waystation, band 1)",
		tier = "common",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "762x39"},
			{item = "12gauge"},
			{item = "9x19"},
			{item = "9x18"},
			{item = "545x39"},
		},
	},
	town_delivery_military_waystation_2 = {
		name = "Military supplies (Waystation, band 2)",
		tier = "uncommon",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_retardant3"},
			{item = "value_retardant4"},
			{item = "value_retardant9"},
			{item = "value_flammable_trotil"},
			{item = "value_balloon_poison_gas"},
			{item = "value_other_uzrgm_fuse"},
		},
	},
	town_delivery_military_waystation_3 = {
		name = "Military supplies (Waystation, band 3)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_container_ammo"},
			{item = "value_ballistic4"},
			{item = "value_container_lopouch"},
			{item = "556x45"},
			{item = "value_container_injectorcase"},
		},
	},
	town_delivery_military_waystation_4 = {
		name = "Military supplies (Waystation, band 4)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_ballistic11"},
			{item = "value_container_weaponcase"},
			{item = "value_safe_container"},
			{item = "value_ballistic6"},
			{item = "value_container_parls"},
			{item = "value_docbag"},
		},
	},
	town_delivery_records_waystation_1 = {
		name = "Records and recording equipment (Waystation, band 1)",
		tier = "common",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_documents_5"},
			{item = "value_documents_6"},
			{item = "value_documents_7"},
			{item = "value_documents_4"},
			{item = "value_documents_12"},
			{item = "value_documents_3"},
		},
	},
	town_delivery_records_waystation_2 = {
		name = "Records and recording equipment (Waystation, band 2)",
		tier = "uncommon",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_maps"},
			{item = "value_officepaper"},
			{item = "value_thick_diary"},
			{item = "value_note_book_coming_closed"},
			{item = "value_archive_cassette"},
			{item = "value_documents_1"},
			{item = "value_milimap"},
		},
	},
	town_delivery_records_waystation_3 = {
		name = "Records and recording equipment (Waystation, band 3)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_cassette_black90"},
			{item = "value_cassette_fiolet"},
			{item = "value_manual_lada"},
			{item = "value_flyer_01"},
			{item = "value_flyer_03"},
			{item = "value_note_folder_closed_cardboard"},
		},
	},
	town_delivery_records_waystation_4 = {
		name = "Records and recording equipment (Waystation, band 4)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_notepad_a6_closed_01"},
			{item = "value_guide"},
			{item = "value_clothbook1"},
			{item = "value_documents_2"},
			{item = "value_info_securedtape"},
			{item = "value_documents_10"},
			{item = "value_documents_11"},
		},
	},
	town_delivery_research_marsh_1 = {
		name = "Research supplies (Marsh, band 1)",
		tier = "common",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_battery"},
			{item = "value_9vbattery"},
			{item = "value_wire_copper"},
			{item = "value_capacitors"},
			{item = "value_wire_light"},
			{item = "value_other_hosemilitary"},
		},
	},
	town_delivery_research_marsh_2 = {
		name = "Research supplies (Marsh, band 2)",
		tier = "uncommon",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_airfilter"},
			{item = "value_other_filter"},
			{item = "value_sensor_a"},
			{item = "value_battery_d_0"},
			{item = "value_portable_container_opened"},
			{item = "value_chemcontainer"},
			{item = "value_injector_obdolbos"},
		},
	},
	town_delivery_research_marsh_3 = {
		name = "Research supplies (Marsh, band 3)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_injector_p22"},
			{item = "value_portable_container_closed"},
			{item = "value_injector_2a2"},
			{item = "value_injector_3btg"},
			{item = "value_injector_perfotoran"},
			{item = "value_injector_trimadol"},
			{item = "value_pressuregauge"},
		},
	},
	town_delivery_research_marsh_4 = {
		name = "Research supplies (Marsh, band 4)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_chemicalsample"},
			{item = "value_anomaly_plant"},
			{item = "value_sensor_d"},
			{item = "value_med_bloodsample"},
			{item = "value_casezerogeo"},
			{item = "value_detector"},
			{item = "value_geigercounter"},
		},
	},
	town_delivery_research_waystation_1 = {
		name = "Research supplies (Waystation, band 1)",
		tier = "common",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_battery"},
			{item = "value_9vbattery"},
			{item = "value_other_hosemilitary"},
			{item = "value_airfilter"},
			{item = "value_other_filter"},
			{item = "value_wire_light"},
		},
	},
	town_delivery_research_waystation_2 = {
		name = "Research supplies (Waystation, band 2)",
		tier = "uncommon",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_sensor_a"},
			{item = "value_capacitors"},
			{item = "value_battery_d_0"},
			{item = "value_portable_container_opened"},
			{item = "value_chemcontainer"},
			{item = "value_portable_container_closed"},
			{item = "value_wire_copper"},
		},
	},
	town_delivery_research_waystation_3 = {
		name = "Research supplies (Waystation, band 3)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_pressuregauge"},
			{item = "value_injector_obdolbos"},
			{item = "value_injector_p22"},
			{item = "value_injector_2a2"},
			{item = "value_injector_3btg"},
			{item = "value_injector_perfotoran"},
			{item = "value_injector_trimadol"},
		},
	},
	town_delivery_research_waystation_4 = {
		name = "Research supplies (Waystation, band 4)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_sensor_d"},
			{item = "value_casezerogeo"},
			{item = "value_detector"},
			{item = "value_geigercounter"},
			{item = "value_chemicalsample"},
			{item = "value_anomaly_plant"},
			{item = "value_med_bloodsample"},
		},
	},
	town_delivery_textiles_marsh_1 = {
		name = "Textiles and protective materials (Marsh, band 1)",
		tier = "common",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_paracord"},
			{item = "value_tape_duct"},
			{item = "value_bedspread"},
			{item = "value_rope"},
		},
	},
	town_delivery_textiles_marsh_2 = {
		name = "Textiles and protective materials (Marsh, band 2)",
		tier = "uncommon",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_fabrics2"},
			{item = "value_ballistic4"},
			{item = "value_container_lopouch"},
			{item = "value_parcel"},
			{item = "value_container_junkbox"},
		},
	},
	town_delivery_textiles_marsh_3 = {
		name = "Textiles and protective materials (Marsh, band 3)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_retardant3"},
			{item = "value_retardant4"},
			{item = "value_retardant9"},
			{item = "value_large_case"},
			{item = "value_container_injectorcase"},
		},
	},
	town_delivery_textiles_marsh_4 = {
		name = "Textiles and protective materials (Marsh, band 4)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_carbon_case"},
			{item = "value_knife_box_low"},
			{item = "value_ballistic11"},
			{item = "value_ballistic6"},
			{item = "value_docbag"},
		},
	},
	town_delivery_textiles_waystation_1 = {
		name = "Textiles and protective materials (Waystation, band 1)",
		tier = "common",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_paracord"},
			{item = "value_retardant3"},
			{item = "value_retardant4"},
			{item = "value_retardant9"},
			{item = "value_tape_duct"},
		},
	},
	town_delivery_textiles_waystation_2 = {
		name = "Textiles and protective materials (Waystation, band 2)",
		tier = "uncommon",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_ballistic4"},
			{item = "value_container_lopouch"},
			{item = "value_fabric_fleece"},
			{item = "value_parcel"},
			{item = "value_container_junkbox"},
		},
	},
	town_delivery_textiles_waystation_3 = {
		name = "Textiles and protective materials (Waystation, band 3)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_fabric_aramid"},
			{item = "value_bedspread"},
			{item = "value_rope"},
			{item = "value_large_case"},
			{item = "value_container_injectorcase"},
		},
	},
	town_delivery_textiles_waystation_4 = {
		name = "Textiles and protective materials (Waystation, band 4)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_carbon_case"},
			{item = "value_knife_box_low"},
			{item = "value_ballistic11"},
			{item = "value_ballistic6"},
			{item = "value_docbag"},
		},
	},
	town_delivery_trade_marsh_1 = {
		name = "Trading stock (Marsh, band 1)",
		tier = "common",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_other_lupo"},
			{item = "value_coffee"},
			{item = "value_other_grechka"},
			{item = "value_crow_beak"},
		},
	},
	town_delivery_trade_marsh_2 = {
		name = "Trading stock (Marsh, band 2)",
		tier = "uncommon",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_bear_souvenir"},
			{item = "value_lightkeeper_amulet"},
			{item = "value_container_lopouch"},
			{item = "drink_orangejuice"},
			{item = "value_skullring"},
		},
	},
	town_delivery_trade_marsh_3 = {
		name = "Trading stock (Marsh, band 3)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "drink_canwater"},
			{item = "food_can_beans"},
			{item = "food_can_sprats"},
			{item = "food_can_tuna"},
			{item = "value_lighter_gold"},
		},
	},
	town_delivery_trade_marsh_4 = {
		name = "Trading stock (Marsh, band 4)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_container_injectorcase"},
			{item = "drink_bottlewater"},
			{item = "value_docbag"},
			{item = "value_watch"},
			{item = "value_goldchain"},
		},
	},
	town_delivery_trail_garbage_1 = {
		name = "Trail supplies (Garbage, band 1)",
		tier = "common",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_gunoil"},
			{item = "value_container_lopouch"},
			{item = "value_bleach"},
			{item = "value_glasscleaner"},
			{item = "value_parcel"},
		},
	},
	town_delivery_trail_garbage_2 = {
		name = "Trail supplies (Garbage, band 2)",
		tier = "uncommon",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_shampoo"},
			{item = "value_wire_light"},
			{item = "value_container_injectorcase"},
			{item = "value_carbon_case"},
			{item = "value_knife_box_low"},
			{item = "value_gasoline"},
		},
	},
	town_delivery_trail_garbage_3 = {
		name = "Trail supplies (Garbage, band 3)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_kerosene"},
			{item = "value_propanetank"},
			{item = "value_docbag"},
			{item = "value_retardant3"},
			{item = "value_retardant4"},
			{item = "value_retardant9"},
		},
	},
	town_delivery_trail_garbage_4 = {
		name = "Trail supplies (Garbage, band 4)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "food_can_beans"},
			{item = "food_can_sprats"},
			{item = "food_can_tuna"},
			{item = "value_casezerogeo"},
			{item = "value_detector"},
			{item = "value_geigercounter"},
		},
	},
	town_delivery_trail_marsh_1 = {
		name = "Trail supplies (Marsh, band 1)",
		tier = "common",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_detergent"},
			{item = "value_gunoil"},
			{item = "value_tape_electric"},
			{item = "value_wire_light"},
			{item = "value_toiletpaper"},
			{item = "value_toothpaste"},
		},
	},
	town_delivery_trail_marsh_2 = {
		name = "Trail supplies (Marsh, band 2)",
		tier = "uncommon",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_kerosene"},
			{item = "value_gasoline"},
			{item = "value_propanetank"},
			{item = "value_container_lopouch"},
			{item = "value_parcel"},
			{item = "food_can_beans"},
		},
	},
	town_delivery_trail_marsh_3 = {
		name = "Trail supplies (Marsh, band 3)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "food_can_sprats"},
			{item = "food_can_tuna"},
			{item = "value_retardant3"},
			{item = "value_retardant4"},
			{item = "value_retardant9"},
			{item = "value_container_injectorcase"},
		},
	},
	town_delivery_trail_marsh_4 = {
		name = "Trail supplies (Marsh, band 4)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_carbon_case"},
			{item = "value_knife_box_low"},
			{item = "value_docbag"},
			{item = "value_casezerogeo"},
			{item = "value_detector"},
			{item = "value_geigercounter"},
		},
	},
	town_delivery_utilities_marsh_1 = {
		name = "Utility supplies (Marsh, band 1)",
		tier = "common",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_bolts"},
			{item = "value_nuts"},
			{item = "value_wire_copper"},
			{item = "value_detergent"},
		},
	},
	town_delivery_utilities_marsh_2 = {
		name = "Utility supplies (Marsh, band 2)",
		tier = "uncommon",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_tape_electric"},
			{item = "value_sparkplug"},
			{item = "value_toiletpaper"},
			{item = "value_toothpaste"},
			{item = "value_metalparts"},
			{item = "value_waste_heavy"},
		},
	},
	town_delivery_utilities_marsh_3 = {
		name = "Utility supplies (Marsh, band 3)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_kerosene"},
			{item = "value_gasoline"},
			{item = "value_propanetank"},
			{item = "value_other_hosemilitary"},
			{item = "value_powercable"},
			{item = "value_airfilter"},
		},
	},
	town_delivery_utilities_marsh_4 = {
		name = "Utility supplies (Marsh, band 4)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_other_filter"},
			{item = "value_battery_d_0"},
			{item = "value_lamp_efficient"},
			{item = "value_magnet"},
			{item = "value_energy_cyclon"},
			{item = "value_energy_accum"},
		},
	},
	town_delivery_workshop_garbage_1 = {
		name = "Workshop supplies (Garbage, band 1)",
		tier = "common",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_screws"},
			{item = "value_metalparts"},
			{item = "value_tools_advwrench"},
			{item = "value_waste_heavy"},
			{item = "value_tools_metalscissors"},
			{item = "value_tapemeasure"},
		},
	},
	town_delivery_workshop_garbage_2 = {
		name = "Workshop supplies (Garbage, band 2)",
		tier = "uncommon",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_tools_ratchetwrench"},
			{item = "value_mining_kit"},
			{item = "value_wrench"},
			{item = "value_hultafors_db5000"},
			{item = "value_bolts"},
			{item = "value_nuts"},
			{item = "value_pliers"},
		},
	},
	town_delivery_workshop_garbage_3 = {
		name = "Workshop supplies (Garbage, band 3)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_tools_pliers_round"},
			{item = "value_tape_electric"},
			{item = "value_glue_3"},
			{item = "value_glue_4"},
			{item = "value_glue_2"},
			{item = "value_wire_light"},
			{item = "value_sparkplug"},
		},
	},
	town_delivery_workshop_garbage_4 = {
		name = "Workshop supplies (Garbage, band 4)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_siliconetube"},
			{item = "value_hose"},
			{item = "value_lightbulb"},
			{item = "value_sensor_a"},
			{item = "value_pressuregauge"},
			{item = "value_techtool_1"},
			{item = "value_sensor_d"},
		},
	},
	town_delivery_workshop_marsh_1 = {
		name = "Workshop supplies (Marsh, band 1)",
		tier = "common",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_bolts"},
			{item = "value_nuts"},
			{item = "value_glue_3"},
			{item = "value_glue_2"},
			{item = "value_glue_4"},
		},
	},
	town_delivery_workshop_marsh_2 = {
		name = "Workshop supplies (Marsh, band 2)",
		tier = "uncommon",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_wire_copper"},
			{item = "value_tape_electric"},
			{item = "value_sparkplug"},
			{item = "value_hose"},
			{item = "value_lightbulb"},
			{item = "value_siliconetube"},
			{item = "value_metalparts"},
		},
	},
	town_delivery_workshop_marsh_3 = {
		name = "Workshop supplies (Marsh, band 3)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_tools_advwrench"},
			{item = "value_waste_heavy"},
			{item = "value_tools_metalscissors"},
			{item = "value_tapemeasure"},
			{item = "value_tools_ratchetwrench"},
			{item = "value_mining_kit"},
			{item = "value_wrench"},
		},
	},
	town_delivery_workshop_marsh_4 = {
		name = "Workshop supplies (Marsh, band 4)",
		tier = "rare",
		evidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",
		candidates = {
			{item = "value_hultafors_db5000"},
			{item = "value_sensor_a"},
			{item = "value_pliers"},
			{item = "value_techtool_1"},
			{item = "value_tools_pliers_round"},
			{item = "value_pressuregauge"},
			{item = "value_sensor_d"},
		},
	},
}

-- Generated town expansion pools; see docs/npc-overhaul/tools/expand_progression.py.

ix.progression.townRequirementSources = {
	artifact_arachno = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_battery = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_blowncap = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_bolt = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_bonecluster = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_capacitor = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_cell = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_compass = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_crystal = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_droplet = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_eye = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_flame = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_flash = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_gaia = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_galaxy = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_gmamasbeads = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_grapes = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_halo = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_kolobok = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_mamasbeads = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_mementomori = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_mica = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_midas = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_moon = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_moonlight = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_mycelia = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_panacea = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_photo = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_slime = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_slug = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_sparkler = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_storm = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_thorn = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	artifact_urchin = {
		kind = "artifact",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_9vbattery = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_airfilter = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_ais_sart = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_anomaly_plant = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_antiinsect = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_antique_teapot = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_antique_vase = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_archive_cassette = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_pripyat_remaster"},
	},
	value_awl = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_ballistic1 = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_ballistic11 = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_ballistic3 = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_ballistic4 = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_ballistic6 = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_ballistic7 = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_balloon_poison_gas = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_battery = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_battery_d_0 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_bear_souvenir = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_bedspread = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_bleach = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_bolts = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_briefcase = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_building_kektape = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_building_plexiglass = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_building_poxeram = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_c4 = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_calculationunit = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_capacitors = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_carbattery = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_carbon_case = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_casezerogeo = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_cassette_black90 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_pripyat_remaster"},
	},
	value_cassette_fiolet = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_pripyat_remaster"},
	},
	value_chemcontainer = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_chemicalsample = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_chlorine = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_circuitboard = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_clothbook1 = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_clothbook2 = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_coffee = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_container_ammo = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_container_cardholder = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_container_injectorcase = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_container_junkbox = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_container_lopouch = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_container_parls = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_container_smallitems = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_container_trackcase = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_container_weapon_thicc = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_container_weaponcase = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_controller = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_crikent_0 = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_crow_beak = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_crowbar = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_detector = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_detergent = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_docbag = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_documents_1 = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_documents_10 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_documents_11 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_documents_12 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_documents_13 = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_documents_14 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_documents_2 = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_documents_3 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_documents_4 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_documents_5 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_documents_6 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_documents_7 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_documents_8 = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_documents_9 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_draincleaner = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_drugskit = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_dryfuel = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_dynamite = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_electr_adv_amplifier = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_electr_adv_controller = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_electr_adv_converter = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_electr_adv_ultralink = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_electr_card_programmer = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_electr_components = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_electr_countermeasure = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_electr_gary_zont = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_electr_hdd_quest = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_electr_signal_jammer = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_electr_ssd = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_electr_tplug = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_electricdrill = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_electro_gyroscope = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_energy_accum = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_energy_cyclon = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_energy_greenbat = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_engine = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_envelope = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_event_labyrinth_chem_container = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_expandingfoam = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_explosive_charge = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_fabric_aramid = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_fabric_cordura = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_fabric_fleece = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_fabric_ripstop = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_fabrics1 = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_fabrics2 = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_field_laptop = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_flammable_huntermatches = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_flammable_klean = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_flammable_survlighter = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_flammable_thermite = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_flammable_trotil = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_flash_card_ironkey = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_flash_card_ironkey_slider = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_flash_card_slider = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_flyer_01 = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_flyer_02 = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_flyer_03 = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_flyers = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_frequencymodulator = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_gamemagazine_01 = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_gascan = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_gasoline = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_geigercounter = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_glasscleaner = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_glue_1 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_glue_2 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_glue_3 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_glue_4 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_goldchain = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_guide = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_guncleaner = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_gunoil = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_gunpowder_blue = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_gunpowder_green = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_gunpowder_red = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_gunspray = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_gyroscope = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_gyrotachometer = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_hammer = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_handbook_materials = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_handdrill = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_helix = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_hose = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_household_repellent = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_household_salt = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_household_toothpaste1 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_household_tree_life_extender = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_hultafors_db5000 = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_info_labrys = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_info_maps = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_info_moleskine = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_info_securedtape = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_injector_2a2 = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_injector_3btg = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_injector_ahf1m = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_injector_l1 = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_injector_mildronate = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_injector_mule = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_injector_obdolbos = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_injector_obdolbos_2 = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_injector_p22 = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_injector_perfotoran = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_injector_sj12 = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_injector_sj9 = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_injector_trimadol = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_injector_xtg12 = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_ipcamera = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_ir_ms2000 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_jamming = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_kanifol = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_kerosene = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_kerosene_container = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_key_labyrinth_torch = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_knife_box_low = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_labyrinth_valve = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_lamp_efficient = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_lamp_uv = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_large_case = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_large_parts = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_lcddirty = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_lightbulb = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_lighter_gold = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_lightkeeper_amulet = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_lubricant = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_magnet = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_manual_lada = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_maps = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_match = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_matches = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_med_aquatabs = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_med_bloodsample = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_med_bloodset = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_med_haemostatic = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_med_ibuprofen = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_med_injectiondevice = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_med_ledx = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_med_ledx_red = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_med_medicalstock = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_med_ophthalmoscope = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_med_peroxide = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_med_petroleumjelly = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_med_saline = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_med_splint = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_med_surgicalpouch = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_med_surgicalpouch_worn = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_med_surgicalroll = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_med_surgicaltools = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_med_syringe = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_med_thermometer = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_med_tourniquet = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_med_tourniquet_rubber = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_med_vitamins = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_memorymodule = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_metalparts = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_milimap = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_militarybattery = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_militaryboard = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_minedetector = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_mining_kit = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_monitoringunit = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_motorclean = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_multitul_0 = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_nails = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_note_book_coming_closed = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_note_folder_closed_cardboard = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_note_newspaper_folded_01 = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_note_newspaper_folded_02 = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_notepad_a5_closed_01 = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_notepad_a6_closed_01 = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_nuts = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_officepaper = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_optical_lens = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_other_filter = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_other_grechka = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_other_hosemilitary = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_other_lupo = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_other_tea = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_other_uzrgm_fuse = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_paracord = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_parcel = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_parts = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_pcpart_cpu = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_pcpart_cpufan = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_pcpart_discdrive = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_pcpart_fpga = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_pcpart_gpu = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_pcpart_hdd = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_pcpart_laptop = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_pcpart_lcd = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_pcpart_psu = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_pcpart_ram = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_pcpart_ssd = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_pda2 = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_pda3 = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_phaseantenna = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_phaserelay = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_phone_new = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_phone_old = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_pipewrench = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_plastic = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_plasticbag_labyrinth = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_plexiglass = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_pliers = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_pocketwatch = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_portable_container_closed = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_portable_container_opened = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_powerbank = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_powercable = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_powerfilter = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_precisiontools = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_pressuregauge = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_propanetank = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_pukt90 = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_quest_biohazard_case = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_radio = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_radio_repeater = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_ratpoison = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_receiver1 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_retardant1 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_retardant10 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_retardant11 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_retardant12 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_retardant2 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_retardant3 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_retardant4 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_retardant6 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_retardant9 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_rfidreader = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_rope = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_ropes = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_safe_container = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_sas = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_scanner_anomaly = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_scanner_artefact = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_screwdriver = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_screws = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_security_box = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_sensor_a = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_sensor_d = {
		kind = "valuable",
		maps = {"rp_waystation"},
	},
	value_sewingkit = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_shampoo = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_siliconetube = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_skullring = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_small_case = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_soap = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_soda = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_sparkplug = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_spec_recorder = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_statue_cat = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_statue_horse = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_statue_lion = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_statue_raven = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_sugar = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_swiss = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_sz_1 = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_tape_duct = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_tape_electric = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_tape_heavy = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_tapemeasure = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_tarp = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_techtool_1 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_techtool_2 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_techtool_3 = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_textolite = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_thermalmodule = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_thermobag = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_thick_diary = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_toiletpaper = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_tools_advwrench = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_tools_metalscissors = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_tools_nippers = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_tools_pliers_round = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_tools_ratchetwrench = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_tools_screwdriver_flat = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_tools_screwdriver_flat_long = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_tools_sewing = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_toolset = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_toothpaste = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_transistors = {
		kind = "valuable",
		maps = {"rp_pripyat_remaster"},
	},
	value_upgro1 = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_upgro2 = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_upgro3 = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_upgrw2 = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_upgrw3 = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_usb_adapter = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation"},
	},
	value_valuable_kresalo = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
	value_waste_heavy = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_waste_light = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_watch = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_waterfilter = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_wd40_100ml = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_wd40_400ml = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_weaponparts = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_wire_copper = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_pripyat_remaster"},
	},
	value_wire_heavy = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_wire_light = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_wirelesstrans = {
		kind = "valuable",
		maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"},
	},
	value_woodclock = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_wrench = {
		kind = "valuable",
		maps = {"rp_garbage_cotz"},
	},
	value_zibbo_0 = {
		kind = "valuable",
		maps = {"rp_marsh_cs"},
	},
}

ix.progression.itemPools.town_expansion_fd0c7c0e30f3 = {
	name = "Survey notes and measuring instruments: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_info_maps"},
		{item = "value_info_moleskine"},
		{item = "value_maps"},
		{item = "value_milimap"},
		{item = "value_pressuregauge"},
		{item = "value_sensor_a"},
		{item = "value_thick_diary"},
	},
}

ix.progression.itemPools.town_expansion_921ffa4bb7c2 = {
	name = "Survey notes and measuring instruments: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_info_moleskine"},
		{item = "value_maps"},
		{item = "value_thick_diary"},
	},
}

ix.progression.itemPools.town_expansion_394faf3b2bc1 = {
	name = "Survey notes and measuring instruments: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_info_maps"},
		{item = "value_milimap"},
	},
}

ix.progression.itemPools.town_expansion_cb717f902d7e = {
	name = "Survey notes and measuring instruments: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_info_maps"},
		{item = "value_milimap"},
		{item = "value_pressuregauge"},
		{item = "value_sensor_a"},
	},
}

ix.progression.itemPools.town_expansion_16ea1d93ed79 = {
	name = "Survey notes and measuring instruments: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_archive_cassette"},
		{item = "value_casezerogeo"},
		{item = "value_cassette_black90"},
		{item = "value_cassette_fiolet"},
		{item = "value_detector"},
		{item = "value_geigercounter"},
		{item = "value_minedetector"},
	},
}

ix.progression.itemPools.town_expansion_9986d3394105 = {
	name = "Survey notes and measuring instruments: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_archive_cassette"},
	},
}

ix.progression.itemPools.town_expansion_6a7a13e88edb = {
	name = "Survey notes and measuring instruments: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_info_moleskine"},
		{item = "value_maps"},
	},
}

ix.progression.itemPools.town_expansion_805df9d0e31f = {
	name = "Survey notes and measuring instruments: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_milimap"},
		{item = "value_thick_diary"},
	},
}

ix.progression.itemPools.town_expansion_7bd9b9f6b468 = {
	name = "Survey notes and measuring instruments: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_electro_gyroscope"},
		{item = "value_gyroscope"},
		{item = "value_info_maps"},
		{item = "value_optical_lens"},
		{item = "value_pressuregauge"},
		{item = "value_sensor_a"},
		{item = "value_sensor_d"},
		{item = "value_thermalmodule"},
	},
}

ix.progression.itemPools.town_expansion_e7e0de73f92a = {
	name = "Survey notes and measuring instruments: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_archive_cassette"},
		{item = "value_casezerogeo"},
		{item = "value_cassette_black90"},
		{item = "value_cassette_fiolet"},
		{item = "value_detector"},
		{item = "value_geigercounter"},
		{item = "value_minedetector"},
		{item = "value_spec_recorder"},
	},
}

ix.progression.itemPools.town_expansion_08367600e48c = {
	name = "Survey notes and measuring instruments: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_detector"},
		{item = "value_geigercounter"},
		{item = "value_minedetector"},
		{item = "value_scanner_anomaly"},
		{item = "value_scanner_artefact"},
	},
}

ix.progression.itemPools.town_expansion_a17426b40822 = {
	name = "Survey notes and measuring instruments: general supplies (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_info_maps"},
		{item = "value_pressuregauge"},
		{item = "value_sensor_a"},
	},
}

ix.progression.itemPools.town_expansion_2c4f96357444 = {
	name = "Survey notes and measuring instruments: supporting supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_archive_cassette"},
		{item = "value_cassette_fiolet"},
	},
}

ix.progression.itemPools.town_expansion_ef56d98e1e68 = {
	name = "Freight cases and cargo packing: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_paracord"},
		{item = "value_rope"},
		{item = "value_ropes"},
		{item = "value_sewingkit"},
		{item = "value_tape_duct"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_ab70754481f9 = {
	name = "Freight cases and cargo packing: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_paracord"},
		{item = "value_rope"},
		{item = "value_tape_duct"},
	},
}

ix.progression.itemPools.town_expansion_691dc581bc8a = {
	name = "Freight cases and cargo packing: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_ropes"},
		{item = "value_sewingkit"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_adef4be4b1a2 = {
	name = "Freight cases and cargo packing: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_carbon_case"},
		{item = "value_knife_box_low"},
		{item = "value_large_case"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
		{item = "value_sewingkit"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_810ca9732e11 = {
	name = "Freight cases and cargo packing: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_carbon_case"},
		{item = "value_knife_box_low"},
		{item = "value_large_case"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
		{item = "value_sewingkit"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_b4bf24ab68ea = {
	name = "Freight cases and cargo packing: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_crikent_0"},
		{item = "value_fabric_fleece"},
		{item = "value_fabric_ripstop"},
		{item = "value_fabrics1"},
		{item = "value_flammable_huntermatches"},
		{item = "value_flammable_klean"},
		{item = "value_gascan"},
		{item = "value_valuable_kresalo"},
	},
}

ix.progression.itemPools.town_expansion_9c040898845b = {
	name = "Freight cases and cargo packing: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_carbon_case"},
		{item = "value_container_junkbox"},
		{item = "value_large_case"},
		{item = "value_parcel"},
		{item = "value_ropes"},
		{item = "value_sewingkit"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_01e4dbaff55e = {
	name = "Freight cases and cargo packing: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_crikent_0"},
		{item = "value_fabric_fleece"},
		{item = "value_fabric_ripstop"},
		{item = "value_flammable_huntermatches"},
		{item = "value_flammable_klean"},
		{item = "value_gascan"},
		{item = "value_matches"},
		{item = "value_valuable_kresalo"},
	},
}

ix.progression.itemPools.town_expansion_a66c4903095e = {
	name = "Freight cases and cargo packing: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_crikent_0"},
		{item = "value_fabric_fleece"},
		{item = "value_fabric_ripstop"},
		{item = "value_flammable_huntermatches"},
		{item = "value_flammable_klean"},
		{item = "value_gascan"},
		{item = "value_match"},
		{item = "value_matches"},
	},
}

ix.progression.itemPools.town_expansion_4008e6738732 = {
	name = "Freight cases and cargo packing: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_paracord"},
		{item = "value_tape_duct"},
	},
}

ix.progression.itemPools.town_expansion_785886b6bdc1 = {
	name = "Freight cases and cargo packing: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_rope"},
		{item = "value_ropes"},
	},
}

ix.progression.itemPools.town_expansion_c3736fe6b4e7 = {
	name = "Freight cases and cargo packing: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_carbon_case"},
		{item = "value_container_junkbox"},
		{item = "value_knife_box_low"},
		{item = "value_large_case"},
		{item = "value_parcel"},
		{item = "value_sewingkit"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_e66eadf0eb93 = {
	name = "Freight cases and cargo packing: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_crikent_0"},
		{item = "value_fabric_cordura"},
		{item = "value_fabric_fleece"},
		{item = "value_fabric_ripstop"},
		{item = "value_flammable_klean"},
		{item = "value_gascan"},
		{item = "value_match"},
		{item = "value_matches"},
	},
}

ix.progression.itemPools.town_expansion_c065cd2ebf15 = {
	name = "Common anomalous specimens (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "artifact_bolt"},
		{item = "artifact_bonecluster"},
		{item = "artifact_droplet"},
		{item = "artifact_grapes"},
		{item = "artifact_mementomori"},
		{item = "artifact_mycelia"},
		{item = "artifact_slime"},
		{item = "artifact_thorn"},
	},
}

ix.progression.itemPools.town_expansion_a1ace2f2865e = {
	name = "Field samples and laboratory containment: general supplies (Marsh)",
	tier = "rare",
	candidates = {
		{item = "value_chemcontainer"},
		{item = "value_portable_container_opened"},
	},
}

ix.progression.itemPools.town_expansion_07ac2fbf5de1 = {
	name = "Field samples and laboratory containment: general supplies (Marsh)",
	tier = "rare",
	candidates = {
		{item = "value_event_labyrinth_chem_container"},
		{item = "value_portable_container_closed"},
		{item = "value_thermobag"},
	},
}

ix.progression.itemPools.town_expansion_911d8be41ce3 = {
	name = "Common electrical artifacts (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "artifact_battery"},
		{item = "artifact_blowncap"},
		{item = "artifact_sparkler"},
	},
}

ix.progression.itemPools.town_expansion_25b061f3b22f = {
	name = "Field samples and laboratory containment: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_airfilter"},
		{item = "value_documents_10"},
		{item = "value_documents_11"},
		{item = "value_labyrinth_valve"},
		{item = "value_other_filter"},
		{item = "value_other_hosemilitary"},
	},
}

ix.progression.itemPools.town_expansion_93a96a4765bd = {
	name = "Rare field artifacts (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "artifact_crystal"},
		{item = "artifact_eye"},
		{item = "artifact_gaia"},
		{item = "artifact_mamasbeads"},
		{item = "artifact_panacea"},
	},
}

ix.progression.itemPools.town_expansion_ee0f01e7c6c6 = {
	name = "Field samples and laboratory containment: general supplies (Marsh)",
	tier = "rare",
	candidates = {
		{item = "value_portable_container_opened"},
	},
}

ix.progression.itemPools.town_expansion_ab96359a0c63 = {
	name = "Field samples and laboratory containment: general supplies (Marsh)",
	tier = "rare",
	candidates = {
		{item = "value_chemcontainer"},
		{item = "value_portable_container_closed"},
	},
}

ix.progression.itemPools.town_expansion_e47e1dab9830 = {
	name = "Field samples and laboratory containment: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_anomaly_plant"},
		{item = "value_chemicalsample"},
		{item = "value_event_labyrinth_chem_container"},
		{item = "value_med_bloodsample"},
		{item = "value_plasticbag_labyrinth"},
		{item = "value_quest_biohazard_case"},
		{item = "value_thermobag"},
	},
}

ix.progression.itemPools.town_expansion_daac7c31b7d8 = {
	name = "Field samples and laboratory containment: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_airfilter"},
		{item = "value_documents_10"},
		{item = "value_documents_11"},
		{item = "value_labyrinth_valve"},
		{item = "value_other_filter"},
		{item = "value_other_hosemilitary"},
	},
}

ix.progression.itemPools.town_expansion_9eca93351695 = {
	name = "Rare field artifacts (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "artifact_crystal"},
		{item = "artifact_eye"},
		{item = "artifact_gaia"},
		{item = "artifact_mamasbeads"},
		{item = "artifact_panacea"},
	},
}

ix.progression.itemPools.town_expansion_4191637a3663 = {
	name = "Exceptional field artifacts (Marsh, Garbage, Waystation, Pripyat)",
	tier = "exceptional",
	candidates = {
		{item = "artifact_arachno"},
		{item = "artifact_flame"},
		{item = "artifact_mica"},
		{item = "artifact_storm"},
	},
}

ix.progression.itemPools.town_expansion_d5c230931a12 = {
	name = "Field samples and laboratory containment: general supplies (Marsh)",
	tier = "rare",
	candidates = {
		{item = "value_chemcontainer"},
		{item = "value_event_labyrinth_chem_container"},
		{item = "value_portable_container_closed"},
		{item = "value_portable_container_opened"},
		{item = "value_thermobag"},
	},
}

ix.progression.itemPools.town_expansion_08cb53802f9d = {
	name = "Field samples and laboratory containment: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_event_labyrinth_chem_container"},
		{item = "value_portable_container_closed"},
		{item = "value_quest_biohazard_case"},
		{item = "value_thermobag"},
	},
}

ix.progression.itemPools.town_expansion_8b6f5686711c = {
	name = "Common electrical artifacts (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "artifact_battery"},
		{item = "artifact_blowncap"},
		{item = "artifact_sparkler"},
	},
}

ix.progression.itemPools.town_expansion_eb9a86daf632 = {
	name = "Field samples and laboratory containment: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_anomaly_plant"},
		{item = "value_chemicalsample"},
		{item = "value_event_labyrinth_chem_container"},
		{item = "value_med_bloodsample"},
		{item = "value_plasticbag_labyrinth"},
		{item = "value_portable_container_closed"},
		{item = "value_quest_biohazard_case"},
		{item = "value_thermobag"},
	},
}

ix.progression.itemPools.town_expansion_42f95bf26576 = {
	name = "Field samples and laboratory containment: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_airfilter"},
		{item = "value_documents_10"},
		{item = "value_documents_11"},
		{item = "value_labyrinth_valve"},
		{item = "value_other_filter"},
		{item = "value_other_hosemilitary"},
	},
}

ix.progression.itemPools.town_expansion_651aa3a30eb5 = {
	name = "Common electrical artifacts (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "artifact_battery"},
		{item = "artifact_blowncap"},
		{item = "artifact_sparkler"},
	},
}

ix.progression.itemPools.town_expansion_38773dec85c7 = {
	name = "Ordnance and protective equipment: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_balloon_poison_gas"},
		{item = "value_c4"},
		{item = "value_dynamite"},
		{item = "value_explosive_charge"},
		{item = "value_flammable_thermite"},
		{item = "value_flammable_trotil"},
		{item = "value_other_uzrgm_fuse"},
	},
}

ix.progression.itemPools.town_expansion_b3dfc5681867 = {
	name = "Ordnance and protective equipment: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_ballistic11"},
		{item = "value_ballistic4"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
		{item = "value_balloon_poison_gas"},
		{item = "value_flammable_thermite"},
		{item = "value_flammable_trotil"},
		{item = "value_other_uzrgm_fuse"},
	},
}

ix.progression.itemPools.town_expansion_e495fb79e800 = {
	name = "Ordnance and protective equipment: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
		{item = "value_balloon_poison_gas"},
		{item = "value_flammable_thermite"},
		{item = "value_flammable_trotil"},
		{item = "value_other_uzrgm_fuse"},
	},
}

ix.progression.itemPools.town_expansion_70d1a7e12f99 = {
	name = "Ordnance and protective equipment: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic3"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
		{item = "value_balloon_poison_gas"},
		{item = "value_flammable_thermite"},
		{item = "value_other_uzrgm_fuse"},
	},
}

ix.progression.itemPools.town_expansion_ea19e7f52af0 = {
	name = "Ordnance and protective equipment: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic3"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
		{item = "value_flammable_thermite"},
		{item = "value_other_uzrgm_fuse"},
	},
}

ix.progression.itemPools.town_expansion_f0839ac5ddec = {
	name = "Ordnance and protective equipment: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_balloon_poison_gas"},
		{item = "value_flammable_trotil"},
		{item = "value_other_uzrgm_fuse"},
	},
}

ix.progression.itemPools.town_expansion_03bbb2fdfea5 = {
	name = "Ordnance and protective equipment: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic3"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
	},
}

ix.progression.itemPools.town_expansion_5057b25bebae = {
	name = "Ordnance and protective equipment: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic3"},
		{item = "value_ballistic4"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
		{item = "value_c4"},
		{item = "value_flammable_thermite"},
	},
}

ix.progression.itemPools.town_expansion_3b8591e605b5 = {
	name = "Ordnance and protective equipment: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_container_parls"},
		{item = "value_container_weaponcase"},
		{item = "value_safe_container"},
	},
}

ix.progression.itemPools.town_expansion_42e6fb2eee15 = {
	name = "Ordnance and protective equipment: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_container_parls"},
		{item = "value_container_weaponcase"},
		{item = "value_safe_container"},
	},
}

ix.progression.itemPools.town_expansion_5d53532b81d0 = {
	name = "Ordnance and protective equipment: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic3"},
		{item = "value_ballistic4"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
		{item = "value_c4"},
		{item = "value_flammable_thermite"},
	},
}

ix.progression.itemPools.town_expansion_bd11a578386c = {
	name = "Ordnance and protective equipment: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_container_parls"},
		{item = "value_container_weapon_thicc"},
		{item = "value_container_weaponcase"},
		{item = "value_safe_container"},
	},
}

ix.progression.itemPools.town_expansion_ebe1eeabefee = {
	name = "Ordnance and protective equipment: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_container_parls"},
		{item = "value_container_weaponcase"},
		{item = "value_safe_container"},
	},
}

ix.progression.itemPools.town_expansion_c0fa3fd9aabe = {
	name = "Ordnance and protective equipment: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_balloon_poison_gas"},
		{item = "value_flammable_trotil"},
	},
}

ix.progression.itemPools.town_expansion_39cb7e94440d = {
	name = "Ordnance and protective equipment: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_flammable_thermite"},
		{item = "value_other_uzrgm_fuse"},
	},
}

ix.progression.itemPools.town_expansion_9c9e7fa86560 = {
	name = "Ordnance and protective equipment: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic3"},
		{item = "value_ballistic4"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
		{item = "value_c4"},
		{item = "value_explosive_charge"},
	},
}

ix.progression.itemPools.town_expansion_d4d3a8a90806 = {
	name = "Ordnance and protective equipment: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_container_parls"},
		{item = "value_container_weapon_thicc"},
		{item = "value_container_weaponcase"},
		{item = "value_safe_container"},
	},
}

ix.progression.itemPools.town_expansion_c37f2fe71765 = {
	name = "Ordnance and protective equipment: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_container_parls"},
		{item = "value_container_weaponcase"},
		{item = "value_safe_container"},
	},
}

ix.progression.itemPools.town_expansion_e5d6c53061f3 = {
	name = "Reloading components and ammunition storage: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_guncleaner"},
		{item = "value_gunoil"},
		{item = "value_gunpowder_blue"},
		{item = "value_gunpowder_green"},
		{item = "value_gunpowder_red"},
		{item = "value_gunspray"},
		{item = "value_lubricant"},
	},
}

ix.progression.itemPools.town_expansion_dc0d9e9b2d00 = {
	name = "Reloading components and ammunition storage: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_guncleaner"},
		{item = "value_gunoil"},
		{item = "value_gunpowder_blue"},
		{item = "value_gunpowder_green"},
		{item = "value_gunpowder_red"},
		{item = "value_gunspray"},
		{item = "value_lubricant"},
	},
}

ix.progression.itemPools.town_expansion_280bb8599be5 = {
	name = "Reloading components and ammunition storage: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_gunoil"},
	},
}

ix.progression.itemPools.town_expansion_e00696cd67cf = {
	name = "Reloading components and ammunition storage: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_guncleaner"},
		{item = "value_gunpowder_blue"},
		{item = "value_gunpowder_green"},
		{item = "value_gunpowder_red"},
		{item = "value_gunspray"},
		{item = "value_lubricant"},
	},
}

ix.progression.itemPools.town_expansion_de1f4d5c33d6 = {
	name = "Reloading components and ammunition storage: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_gunoil"},
		{item = "value_gunpowder_blue"},
		{item = "value_gunpowder_green"},
	},
}

ix.progression.itemPools.town_expansion_7da8bdd25de3 = {
	name = "Reloading components and ammunition storage: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_guncleaner"},
		{item = "value_gunpowder_red"},
		{item = "value_gunspray"},
		{item = "value_lubricant"},
	},
}

ix.progression.itemPools.town_expansion_4d5f7e467f0d = {
	name = "Reloading components and ammunition storage: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_guncleaner"},
		{item = "value_gunpowder_red"},
		{item = "value_gunspray"},
		{item = "value_lubricant"},
	},
}

ix.progression.itemPools.town_expansion_023c54df6115 = {
	name = "Reloading components and ammunition storage: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_guncleaner"},
		{item = "value_gunpowder_red"},
		{item = "value_lubricant"},
	},
}

ix.progression.itemPools.town_expansion_224af09f586f = {
	name = "Reloading components and ammunition storage: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_container_parls"},
		{item = "value_container_weaponcase"},
		{item = "value_guncleaner"},
		{item = "value_gunpowder_red"},
		{item = "value_gunspray"},
		{item = "value_lubricant"},
	},
}

ix.progression.itemPools.town_expansion_02feda14ec81 = {
	name = "Reloading components and ammunition storage: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_guncleaner"},
		{item = "value_gunpowder_red"},
		{item = "value_lubricant"},
	},
}

ix.progression.itemPools.town_expansion_ab02577b1443 = {
	name = "Reloading components and ammunition storage: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_gunpowder_red"},
		{item = "value_lubricant"},
	},
}

ix.progression.itemPools.town_expansion_d4ffbb33bee8 = {
	name = "Reloading components and ammunition storage: general supplies (Garbage)",
	tier = "rare",
	candidates = {
		{item = "value_guncleaner"},
		{item = "value_gunpowder_red"},
		{item = "value_gunspray"},
		{item = "value_lubricant"},
	},
}

ix.progression.itemPools.town_expansion_e37e23b7575b = {
	name = "Reloading components and ammunition storage: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_lopouch"},
		{item = "value_pipewrench"},
		{item = "value_precisiontools"},
		{item = "value_screwdriver"},
		{item = "value_tools_advwrench"},
		{item = "value_tools_ratchetwrench"},
		{item = "value_tools_screwdriver_flat_long"},
		{item = "value_wrench"},
	},
}

ix.progression.itemPools.town_expansion_91612d91ad03 = {
	name = "Reloading components and ammunition storage: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_pipewrench"},
		{item = "value_screwdriver"},
		{item = "value_tools_screwdriver_flat"},
		{item = "value_tools_screwdriver_flat_long"},
	},
}

ix.progression.itemPools.town_expansion_a3337a27d974 = {
	name = "Reloading components and ammunition storage: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_container_parls"},
		{item = "value_container_weapon_thicc"},
		{item = "value_container_weaponcase"},
		{item = "value_guncleaner"},
		{item = "value_gunpowder_red"},
		{item = "value_gunspray"},
		{item = "value_lubricant"},
	},
}

ix.progression.itemPools.town_expansion_5286bb89816d = {
	name = "Reloading components and ammunition storage: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_container_lopouch"},
		{item = "value_pipewrench"},
		{item = "value_precisiontools"},
		{item = "value_screwdriver"},
		{item = "value_tools_advwrench"},
		{item = "value_tools_ratchetwrench"},
		{item = "value_tools_screwdriver_flat_long"},
		{item = "value_wrench"},
	},
}

ix.progression.itemPools.town_expansion_5b31b14470db = {
	name = "Reloading components and ammunition storage: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_pipewrench"},
		{item = "value_screwdriver"},
		{item = "value_tools_screwdriver_flat"},
		{item = "value_tools_screwdriver_flat_long"},
	},
}

ix.progression.itemPools.town_expansion_dc7e0ab4a6de = {
	name = "Reloading components and ammunition storage: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_pipewrench"},
		{item = "value_screwdriver"},
		{item = "value_tools_screwdriver_flat"},
	},
}

ix.progression.itemPools.town_expansion_3d986e0d6b1f = {
	name = "Reloading components and ammunition storage: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_gunoil"},
		{item = "value_gunpowder_green"},
	},
}

ix.progression.itemPools.town_expansion_6978872f4202 = {
	name = "Reloading components and ammunition storage: general supplies (Garbage)",
	tier = "rare",
	candidates = {
		{item = "value_guncleaner"},
		{item = "value_gunpowder_blue"},
	},
}

ix.progression.itemPools.town_expansion_b1010fd3352b = {
	name = "Reloading components and ammunition storage: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_container_parls"},
		{item = "value_container_weapon_thicc"},
		{item = "value_container_weaponcase"},
		{item = "value_gunpowder_red"},
		{item = "value_gunspray"},
		{item = "value_lubricant"},
	},
}

ix.progression.itemPools.town_expansion_a71af4c623cd = {
	name = "Reloading components and ammunition storage: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_container_lopouch"},
		{item = "value_pipewrench"},
		{item = "value_precisiontools"},
		{item = "value_screwdriver"},
		{item = "value_tools_advwrench"},
		{item = "value_tools_ratchetwrench"},
		{item = "value_tools_screwdriver_flat_long"},
		{item = "value_wrench"},
	},
}

ix.progression.itemPools.town_expansion_4edbd45ed05d = {
	name = "Reloading components and ammunition storage: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_docbag"},
		{item = "value_pipewrench"},
		{item = "value_tools_screwdriver_flat"},
	},
}

ix.progression.itemPools.town_expansion_6c1ea6c989dc = {
	name = "Reloading components and ammunition storage: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_pipewrench"},
		{item = "value_precisiontools"},
		{item = "value_screwdriver"},
		{item = "value_tools_screwdriver_flat"},
		{item = "value_tools_screwdriver_flat_long"},
	},
}

ix.progression.itemPools.town_expansion_ebe38fab8b66 = {
	name = "Historical documents and technical records: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_documents_12"},
		{item = "value_documents_3"},
		{item = "value_documents_4"},
		{item = "value_documents_5"},
		{item = "value_documents_6"},
		{item = "value_documents_7"},
		{item = "value_handbook_materials"},
		{item = "value_manual_lada"},
	},
}

ix.progression.itemPools.town_expansion_1cd75d531157 = {
	name = "Historical documents and technical records: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_clothbook1"},
		{item = "value_documents_12"},
		{item = "value_documents_3"},
		{item = "value_documents_4"},
		{item = "value_documents_5"},
		{item = "value_documents_6"},
		{item = "value_documents_7"},
		{item = "value_guide"},
	},
}

ix.progression.itemPools.town_expansion_406f35b6f207 = {
	name = "Historical documents and technical records: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_documents_12"},
		{item = "value_documents_3"},
		{item = "value_documents_4"},
		{item = "value_documents_5"},
		{item = "value_documents_8"},
		{item = "value_guide"},
	},
}

ix.progression.itemPools.town_expansion_65397c5ae9bc = {
	name = "Historical documents and technical records: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_documents_12"},
		{item = "value_documents_3"},
		{item = "value_documents_4"},
		{item = "value_documents_5"},
		{item = "value_documents_6"},
		{item = "value_documents_7"},
	},
}

ix.progression.itemPools.town_expansion_8de7c83b4f1d = {
	name = "Historical documents and technical records: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_documents_8"},
		{item = "value_manual_lada"},
	},
}

ix.progression.itemPools.town_expansion_5b7b7a168af9 = {
	name = "Historical documents and technical records: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_clothbook2"},
		{item = "value_documents_8"},
		{item = "value_manual_lada"},
	},
}

ix.progression.itemPools.town_expansion_8fa2c0559032 = {
	name = "Historical documents and technical records: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_documents_8"},
		{item = "value_handbook_materials"},
		{item = "value_manual_lada"},
	},
}

ix.progression.itemPools.town_expansion_47de1bcad0c2 = {
	name = "Historical documents and technical records: general supplies (Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_documents_10"},
		{item = "value_documents_11"},
		{item = "value_documents_14"},
		{item = "value_documents_9"},
		{item = "value_handbook_materials"},
		{item = "value_manual_lada"},
	},
}

ix.progression.itemPools.town_expansion_24ed82226a6c = {
	name = "Historical documents and technical records: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_archive_cassette"},
		{item = "value_cassette_black90"},
		{item = "value_cassette_fiolet"},
		{item = "value_flyers"},
		{item = "value_info_labrys"},
		{item = "value_note_book_coming_closed"},
		{item = "value_note_newspaper_folded_01"},
		{item = "value_note_newspaper_folded_02"},
	},
}

ix.progression.itemPools.town_expansion_d4101333b518 = {
	name = "Historical documents and technical records: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_documents_10"},
		{item = "value_documents_8"},
		{item = "value_documents_9"},
		{item = "value_guide"},
		{item = "value_handbook_materials"},
		{item = "value_manual_lada"},
	},
}

ix.progression.itemPools.town_expansion_89df7e4e2855 = {
	name = "Historical documents and technical records: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_flyer_02"},
		{item = "value_flyer_03"},
		{item = "value_flyers"},
		{item = "value_gamemagazine_01"},
		{item = "value_info_labrys"},
		{item = "value_note_book_coming_closed"},
		{item = "value_note_newspaper_folded_01"},
		{item = "value_note_newspaper_folded_02"},
	},
}

ix.progression.itemPools.town_expansion_9117b3dcad2a = {
	name = "Historical documents and technical records: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_flyer_02"},
		{item = "value_flyers"},
		{item = "value_gamemagazine_01"},
		{item = "value_info_labrys"},
		{item = "value_note_book_coming_closed"},
		{item = "value_note_newspaper_folded_01"},
		{item = "value_note_newspaper_folded_02"},
	},
}

ix.progression.itemPools.town_expansion_0324962de821 = {
	name = "Historical documents and technical records: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_documents_3"},
		{item = "value_documents_4"},
		{item = "value_documents_5"},
		{item = "value_documents_6"},
	},
}

ix.progression.itemPools.town_expansion_5a7f17628aaf = {
	name = "Historical documents and technical records: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_documents_12"},
		{item = "value_documents_7"},
		{item = "value_handbook_materials"},
		{item = "value_manual_lada"},
	},
}

ix.progression.itemPools.town_expansion_fed462f98a10 = {
	name = "Historical documents and technical records: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_documents_10"},
		{item = "value_documents_11"},
		{item = "value_documents_14"},
		{item = "value_documents_8"},
		{item = "value_documents_9"},
		{item = "value_guide"},
	},
}

ix.progression.itemPools.town_expansion_fc09dd38d32c = {
	name = "Historical documents and technical records: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_flyer_02"},
		{item = "value_flyers"},
		{item = "value_info_labrys"},
		{item = "value_note_book_coming_closed"},
		{item = "value_note_newspaper_folded_01"},
		{item = "value_note_newspaper_folded_02"},
	},
}

ix.progression.itemPools.town_expansion_06f11c6d52b8 = {
	name = "Storage upkeep and discreet containers: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_antiinsect"},
		{item = "value_bleach"},
		{item = "value_chlorine"},
		{item = "value_draincleaner"},
		{item = "value_glasscleaner"},
		{item = "value_household_repellent"},
		{item = "value_ratpoison"},
		{item = "value_shampoo"},
	},
}

ix.progression.itemPools.town_expansion_88b3cadf7aff = {
	name = "Storage upkeep and discreet containers: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_antiinsect"},
		{item = "value_bleach"},
		{item = "value_chlorine"},
		{item = "value_draincleaner"},
		{item = "value_glasscleaner"},
		{item = "value_household_repellent"},
		{item = "value_ratpoison"},
		{item = "value_shampoo"},
	},
}

ix.progression.itemPools.town_expansion_c463135f111b = {
	name = "Storage upkeep and discreet containers: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_antiinsect"},
		{item = "value_chlorine"},
		{item = "value_draincleaner"},
		{item = "value_glasscleaner"},
		{item = "value_household_repellent"},
		{item = "value_ratpoison"},
		{item = "value_shampoo"},
		{item = "value_soap"},
	},
}

ix.progression.itemPools.town_expansion_8000e56a4250 = {
	name = "Storage upkeep and discreet containers: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_bleach"},
		{item = "value_chlorine"},
		{item = "value_draincleaner"},
		{item = "value_glasscleaner"},
		{item = "value_ratpoison"},
		{item = "value_shampoo"},
	},
}

ix.progression.itemPools.town_expansion_e674fb3afa85 = {
	name = "Storage upkeep and discreet containers: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_household_repellent"},
		{item = "value_household_toothpaste1"},
		{item = "value_household_tree_life_extender"},
		{item = "value_soap"},
		{item = "value_soda"},
	},
}

ix.progression.itemPools.town_expansion_f3c6e3787c6c = {
	name = "Storage upkeep and discreet containers: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_household_repellent"},
		{item = "value_household_toothpaste1"},
		{item = "value_household_tree_life_extender"},
		{item = "value_soap"},
		{item = "value_soda"},
	},
}

ix.progression.itemPools.town_expansion_3f71ee5759f7 = {
	name = "Storage upkeep and discreet containers: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_household_toothpaste1"},
		{item = "value_household_tree_life_extender"},
		{item = "value_soap"},
		{item = "value_soda"},
	},
}

ix.progression.itemPools.town_expansion_a80ba31efb59 = {
	name = "Storage upkeep and discreet containers: general supplies (Garbage)",
	tier = "uncommon",
	candidates = {
		{item = "value_antiinsect"},
		{item = "value_household_repellent"},
		{item = "value_household_toothpaste1"},
		{item = "value_household_tree_life_extender"},
		{item = "value_soap"},
		{item = "value_soda"},
	},
}

ix.progression.itemPools.town_expansion_3ee97809ffce = {
	name = "Storage upkeep and discreet containers: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_building_plexiglass"},
		{item = "value_building_poxeram"},
		{item = "value_knife_box_low"},
		{item = "value_plastic"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
		{item = "value_small_case"},
	},
}

ix.progression.itemPools.town_expansion_be50aecc58a5 = {
	name = "Storage upkeep and discreet containers: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_antiinsect"},
		{item = "value_household_repellent"},
		{item = "value_household_toothpaste1"},
		{item = "value_household_tree_life_extender"},
		{item = "value_safe_container"},
		{item = "value_soap"},
		{item = "value_soda"},
	},
}

ix.progression.itemPools.town_expansion_0fb1615accd2 = {
	name = "Storage upkeep and discreet containers: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_building_plexiglass"},
		{item = "value_building_poxeram"},
		{item = "value_knife_box_low"},
		{item = "value_plastic"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
		{item = "value_small_case"},
	},
}

ix.progression.itemPools.town_expansion_afeb42da558e = {
	name = "Storage upkeep and discreet containers: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_building_plexiglass"},
		{item = "value_building_poxeram"},
		{item = "value_plastic"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
		{item = "value_small_case"},
	},
}

ix.progression.itemPools.town_expansion_3bb6cdd22bc3 = {
	name = "Storage upkeep and discreet containers: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_bleach"},
		{item = "value_chlorine"},
		{item = "value_draincleaner"},
		{item = "value_glasscleaner"},
	},
}

ix.progression.itemPools.town_expansion_ebf5705cad72 = {
	name = "Storage upkeep and discreet containers: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_antiinsect"},
		{item = "value_household_repellent"},
		{item = "value_ratpoison"},
		{item = "value_shampoo"},
	},
}

ix.progression.itemPools.town_expansion_4b2fdb8a03ce = {
	name = "Storage upkeep and discreet containers: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_household_toothpaste1"},
		{item = "value_household_tree_life_extender"},
		{item = "value_safe_container"},
		{item = "value_soap"},
		{item = "value_soda"},
	},
}

ix.progression.itemPools.town_expansion_d695ccfe3436 = {
	name = "Storage upkeep and discreet containers: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_building_plexiglass"},
		{item = "value_building_poxeram"},
		{item = "value_plastic"},
		{item = "value_pukt90"},
		{item = "value_small_case"},
	},
}

ix.progression.itemPools.town_expansion_cdf25d73f659 = {
	name = "Laboratory containment and research reagents: general supplies (Marsh)",
	tier = "rare",
	candidates = {
		{item = "value_airfilter"},
		{item = "value_other_hosemilitary"},
	},
}

ix.progression.itemPools.town_expansion_d2609995f8d8 = {
	name = "Laboratory containment and research reagents: general supplies (Marsh)",
	tier = "rare",
	candidates = {
		{item = "value_labyrinth_valve"},
		{item = "value_med_thermometer"},
		{item = "value_other_filter"},
	},
}

ix.progression.itemPools.town_expansion_4fb728e0590f = {
	name = "Laboratory containment and research reagents: general supplies (Marsh)",
	tier = "rare",
	candidates = {
		{item = "value_other_hosemilitary"},
	},
}

ix.progression.itemPools.town_expansion_cd0152fc8308 = {
	name = "Laboratory containment and research reagents: general supplies (Marsh)",
	tier = "rare",
	candidates = {
		{item = "value_airfilter"},
		{item = "value_other_filter"},
	},
}

ix.progression.itemPools.town_expansion_7ab833816100 = {
	name = "Laboratory containment and research reagents: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_injector_2a2"},
		{item = "value_injector_3btg"},
		{item = "value_injector_ahf1m"},
		{item = "value_injector_l1"},
		{item = "value_injector_mildronate"},
		{item = "value_injector_obdolbos"},
		{item = "value_injector_p22"},
		{item = "value_injector_perfotoran"},
	},
}

ix.progression.itemPools.town_expansion_7d43e6ba987e = {
	name = "Laboratory containment and research reagents: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
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
}

ix.progression.itemPools.town_expansion_1093527f1ee9 = {
	name = "Generator parts and camp electrics: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_carbattery"},
		{item = "value_engine"},
		{item = "value_helix"},
		{item = "value_lamp_efficient"},
		{item = "value_magnet"},
		{item = "value_motorclean"},
		{item = "value_powercable"},
		{item = "value_wire_heavy"},
	},
}

ix.progression.itemPools.town_expansion_9f54f7183eca = {
	name = "Generator parts and camp electrics: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_carbattery"},
		{item = "value_motorclean"},
	},
}

ix.progression.itemPools.town_expansion_26c6aac8b583 = {
	name = "Generator parts and camp electrics: general supplies (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_carbattery"},
		{item = "value_engine"},
	},
}

ix.progression.itemPools.town_expansion_2b87f36b3a5c = {
	name = "Generator parts and camp electrics: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_carbattery"},
		{item = "value_engine"},
		{item = "value_lamp_efficient"},
		{item = "value_motorclean"},
		{item = "value_powercable"},
		{item = "value_wire_heavy"},
	},
}

ix.progression.itemPools.town_expansion_3ea3fe5ce3d4 = {
	name = "Generator parts and camp electrics: general supplies (Marsh)",
	tier = "rare",
	candidates = {
		{item = "value_electr_tplug"},
		{item = "value_helix"},
		{item = "value_kanifol"},
		{item = "value_lamp_uv"},
		{item = "value_usb_adapter"},
	},
}

ix.progression.itemPools.town_expansion_a521a3db5b35 = {
	name = "Generator parts and camp electrics: general supplies (Marsh)",
	tier = "rare",
	candidates = {
		{item = "value_electr_tplug"},
		{item = "value_helix"},
		{item = "value_kanifol"},
		{item = "value_lamp_uv"},
		{item = "value_magnet"},
		{item = "value_usb_adapter"},
	},
}

ix.progression.itemPools.town_expansion_a45967d5138a = {
	name = "Generator parts and camp electrics: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_electr_tplug"},
		{item = "value_helix"},
		{item = "value_kanifol"},
		{item = "value_lamp_uv"},
		{item = "value_magnet"},
		{item = "value_powerfilter"},
		{item = "value_usb_adapter"},
		{item = "value_wd40_100ml"},
	},
}

ix.progression.itemPools.town_expansion_5b5d39e3738d = {
	name = "Generator parts and camp electrics: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_electr_tplug"},
		{item = "value_kanifol"},
		{item = "value_lamp_uv"},
		{item = "value_powerfilter"},
		{item = "value_usb_adapter"},
	},
}

ix.progression.itemPools.town_expansion_e210a8bed09e = {
	name = "Generator parts and camp electrics: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_gasoline"},
		{item = "value_kerosene"},
		{item = "value_propanetank"},
		{item = "value_sparkplug"},
		{item = "value_tape_electric"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_6fa4b2017521 = {
	name = "Generator parts and camp electrics: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_kerosene"},
		{item = "value_propanetank"},
		{item = "value_tape_electric"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_293721c53aac = {
	name = "Generator parts and camp electrics: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_electr_tplug"},
		{item = "value_helix"},
		{item = "value_kanifol"},
		{item = "value_lamp_uv"},
		{item = "value_magnet"},
		{item = "value_powerfilter"},
		{item = "value_usb_adapter"},
		{item = "value_wd40_100ml"},
	},
}

ix.progression.itemPools.town_expansion_a5605073b6ac = {
	name = "Generator parts and camp electrics: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_gasoline"},
		{item = "value_kerosene"},
		{item = "value_propanetank"},
		{item = "value_sparkplug"},
		{item = "value_tape_electric"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_4b1d88e67e5c = {
	name = "Generator parts and camp electrics: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_kerosene"},
		{item = "value_propanetank"},
		{item = "value_sparkplug"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_c2f8fdcd7149 = {
	name = "Generator parts and camp electrics: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_kerosene"},
		{item = "value_propanetank"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_b756e66afe8c = {
	name = "Generator parts and camp electrics: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_carbattery"},
		{item = "value_engine"},
		{item = "value_motorclean"},
		{item = "value_wire_heavy"},
	},
}

ix.progression.itemPools.town_expansion_f0815324bc06 = {
	name = "Generator parts and camp electrics: general supplies (Marsh)",
	tier = "rare",
	candidates = {
		{item = "value_helix"},
		{item = "value_lamp_efficient"},
		{item = "value_magnet"},
		{item = "value_powercable"},
	},
}

ix.progression.itemPools.town_expansion_6300c1b64c28 = {
	name = "Generator parts and camp electrics: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_electr_tplug"},
		{item = "value_kanifol"},
		{item = "value_lamp_uv"},
		{item = "value_powerfilter"},
		{item = "value_usb_adapter"},
		{item = "value_wd40_100ml"},
	},
}

ix.progression.itemPools.town_expansion_2c3be06003ee = {
	name = "Generator parts and camp electrics: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_gasoline"},
		{item = "value_kerosene"},
		{item = "value_propanetank"},
		{item = "value_sparkplug"},
		{item = "value_tape_electric"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_7eefff4d1776 = {
	name = "Generator parts and camp electrics: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_kerosene"},
		{item = "value_propanetank"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_dc2eb71761f5 = {
	name = "Resale curios and small valuables: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_antique_teapot"},
		{item = "value_antique_vase"},
		{item = "value_bear_souvenir"},
		{item = "value_skullring"},
		{item = "value_statue_cat"},
		{item = "value_statue_horse"},
		{item = "value_statue_lion"},
		{item = "value_statue_raven"},
	},
}

ix.progression.itemPools.town_expansion_15b692cf7ae6 = {
	name = "Resale curios and small valuables: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_antique_teapot"},
		{item = "value_antique_vase"},
		{item = "value_skullring"},
		{item = "value_statue_cat"},
		{item = "value_statue_horse"},
		{item = "value_statue_lion"},
		{item = "value_statue_raven"},
	},
}

ix.progression.itemPools.town_expansion_052064323b6a = {
	name = "Resale curios and small valuables: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_antique_vase"},
		{item = "value_bear_souvenir"},
		{item = "value_skullring"},
		{item = "value_statue_cat"},
		{item = "value_statue_lion"},
	},
}

ix.progression.itemPools.town_expansion_4ce173e4c3e2 = {
	name = "Resale curios and small valuables: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_antique_teapot"},
		{item = "value_statue_horse"},
		{item = "value_statue_raven"},
	},
}

ix.progression.itemPools.town_expansion_93ec49f5bd34 = {
	name = "Resale curios and small valuables: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_antique_teapot"},
		{item = "value_goldchain"},
		{item = "value_statue_horse"},
		{item = "value_statue_raven"},
		{item = "value_watch"},
	},
}

ix.progression.itemPools.town_expansion_ebd69b9f35a9 = {
	name = "Resale curios and small valuables: general supplies (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_antique_teapot"},
		{item = "value_statue_horse"},
	},
}

ix.progression.itemPools.town_expansion_c06c67504ef8 = {
	name = "Resale curios and small valuables: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_antique_teapot"},
		{item = "value_goldchain"},
		{item = "value_lighter_gold"},
		{item = "value_pocketwatch"},
		{item = "value_statue_horse"},
		{item = "value_statue_raven"},
		{item = "value_watch"},
		{item = "value_woodclock"},
	},
}

ix.progression.itemPools.town_expansion_bb6f2a2518e6 = {
	name = "Resale curios and small valuables: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_statue_horse"},
		{item = "value_statue_raven"},
	},
}

ix.progression.itemPools.town_expansion_d8f8ea477461 = {
	name = "Resale curios and small valuables: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_carbon_case"},
		{item = "value_crow_beak"},
		{item = "value_knife_box_low"},
		{item = "value_lightkeeper_amulet"},
		{item = "value_parcel"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
	},
}

ix.progression.itemPools.town_expansion_ea4a3ff123bc = {
	name = "Resale curios and small valuables: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_carbon_case"},
		{item = "value_knife_box_low"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
		{item = "value_small_case"},
	},
}

ix.progression.itemPools.town_expansion_1806ede61236 = {
	name = "Resale curios and small valuables: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_antique_teapot"},
		{item = "value_goldchain"},
		{item = "value_lighter_gold"},
		{item = "value_pocketwatch"},
		{item = "value_statue_horse"},
		{item = "value_statue_raven"},
		{item = "value_watch"},
		{item = "value_woodclock"},
	},
}

ix.progression.itemPools.town_expansion_9afb06e9bb9c = {
	name = "Resale curios and small valuables: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_carbon_case"},
		{item = "value_crow_beak"},
		{item = "value_knife_box_low"},
		{item = "value_lightkeeper_amulet"},
		{item = "value_parcel"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
	},
}

ix.progression.itemPools.town_expansion_08a8dc156b3a = {
	name = "Resale curios and small valuables: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_carbon_case"},
		{item = "value_knife_box_low"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
		{item = "value_small_case"},
	},
}

ix.progression.itemPools.town_expansion_3d5721363063 = {
	name = "Resale curios and small valuables: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_knife_box_low"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
		{item = "value_small_case"},
	},
}

ix.progression.itemPools.town_expansion_38291627bd4d = {
	name = "Resale curios and small valuables: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_bear_souvenir"},
		{item = "value_skullring"},
		{item = "value_statue_cat"},
	},
}

ix.progression.itemPools.town_expansion_1716f0e04429 = {
	name = "Resale curios and small valuables: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_antique_vase"},
		{item = "value_statue_lion"},
		{item = "value_statue_raven"},
	},
}

ix.progression.itemPools.town_expansion_78dc4256fdef = {
	name = "Resale curios and small valuables: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_antique_teapot"},
		{item = "value_goldchain"},
		{item = "value_lighter_gold"},
		{item = "value_pocketwatch"},
		{item = "value_statue_horse"},
		{item = "value_watch"},
		{item = "value_woodclock"},
	},
}

ix.progression.itemPools.town_expansion_9596b33bb0af = {
	name = "Resale curios and small valuables: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_carbon_case"},
		{item = "value_crow_beak"},
		{item = "value_knife_box_low"},
		{item = "value_lightkeeper_amulet"},
		{item = "value_parcel"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
	},
}

ix.progression.itemPools.town_expansion_53d55c07b383 = {
	name = "Resale curios and small valuables: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_knife_box_low"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
		{item = "value_small_case"},
	},
}

ix.progression.itemPools.town_expansion_9ca634ef473b = {
	name = "Detector calibration and survey equipment: general supplies (Marsh)",
	tier = "rare",
	candidates = {
		{item = "value_chemcontainer"},
		{item = "value_portable_container_closed"},
		{item = "value_portable_container_opened"},
	},
}

ix.progression.itemPools.town_expansion_341f46a2577a = {
	name = "Detector calibration and survey equipment: general supplies (Marsh)",
	tier = "rare",
	candidates = {
		{item = "value_event_labyrinth_chem_container"},
		{item = "value_pcpart_fpga"},
		{item = "value_pcpart_lcd"},
		{item = "value_thermobag"},
	},
}

ix.progression.itemPools.town_expansion_c424b030ac41 = {
	name = "Detector calibration and survey equipment: general supplies (Marsh)",
	tier = "rare",
	candidates = {
		{item = "value_chemcontainer"},
		{item = "value_portable_container_opened"},
	},
}

ix.progression.itemPools.town_expansion_bc0105418f59 = {
	name = "Detector calibration and survey equipment: general supplies (Marsh)",
	tier = "rare",
	candidates = {
		{item = "value_event_labyrinth_chem_container"},
		{item = "value_portable_container_closed"},
	},
}

ix.progression.itemPools.town_expansion_4c2ad9cd5e95 = {
	name = "Detector calibration and survey equipment: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_casezerogeo"},
		{item = "value_detector"},
		{item = "value_geigercounter"},
		{item = "value_pcpart_fpga"},
		{item = "value_pcpart_lcd"},
		{item = "value_powerbank"},
		{item = "value_quest_biohazard_case"},
		{item = "value_thermobag"},
	},
}

ix.progression.itemPools.town_expansion_6be29e7a116d = {
	name = "Detector calibration and survey equipment: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_9vbattery"},
		{item = "value_battery"},
		{item = "value_battery_d_0"},
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_guide"},
		{item = "value_handbook_materials"},
		{item = "value_manual_lada"},
	},
}

ix.progression.itemPools.town_expansion_69a36fd02700 = {
	name = "Clinical supplies and trauma equipment: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_med_aquatabs"},
		{item = "value_med_haemostatic"},
		{item = "value_med_ibuprofen"},
		{item = "value_med_medicalstock"},
		{item = "value_med_peroxide"},
		{item = "value_med_petroleumjelly"},
		{item = "value_med_saline"},
		{item = "value_med_vitamins"},
	},
}

ix.progression.itemPools.town_expansion_2b00b4c4b21c = {
	name = "Clinical supplies and trauma equipment: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_med_aquatabs"},
		{item = "value_med_ibuprofen"},
		{item = "value_med_medicalstock"},
		{item = "value_med_peroxide"},
		{item = "value_med_petroleumjelly"},
		{item = "value_med_saline"},
		{item = "value_med_vitamins"},
	},
}

ix.progression.itemPools.town_expansion_3381dd915629 = {
	name = "Clinical supplies and trauma equipment: general supplies (Marsh)",
	tier = "rare",
	candidates = {
		{item = "value_med_bloodset"},
		{item = "value_med_splint"},
		{item = "value_med_syringe"},
		{item = "value_med_thermometer"},
		{item = "value_med_tourniquet"},
		{item = "value_med_tourniquet_rubber"},
	},
}

ix.progression.itemPools.town_expansion_b4fb665dfaca = {
	name = "Clinical supplies and trauma equipment: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_med_ibuprofen"},
		{item = "value_med_peroxide"},
		{item = "value_med_petroleumjelly"},
		{item = "value_med_vitamins"},
	},
}

ix.progression.itemPools.town_expansion_a1a21eb44a21 = {
	name = "Clinical supplies and trauma equipment: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_med_aquatabs"},
		{item = "value_med_haemostatic"},
		{item = "value_med_medicalstock"},
		{item = "value_med_saline"},
		{item = "value_med_tourniquet"},
	},
}

ix.progression.itemPools.town_expansion_dee44a950fbd = {
	name = "Clinical supplies and trauma equipment: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_med_bloodset"},
		{item = "value_med_injectiondevice"},
		{item = "value_med_splint"},
		{item = "value_med_surgicalpouch"},
		{item = "value_med_surgicaltools"},
		{item = "value_med_syringe"},
		{item = "value_med_thermometer"},
		{item = "value_med_tourniquet_rubber"},
	},
}

ix.progression.itemPools.town_expansion_a89397d5af5e = {
	name = "Clinical supplies and trauma equipment: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_airfilter"},
		{item = "value_anomaly_plant"},
		{item = "value_chemicalsample"},
		{item = "value_labyrinth_valve"},
		{item = "value_med_bloodsample"},
		{item = "value_other_filter"},
		{item = "value_other_hosemilitary"},
		{item = "value_plasticbag_labyrinth"},
	},
}

ix.progression.itemPools.town_expansion_f129053f6d26 = {
	name = "Clinical supplies and trauma equipment: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_anomaly_plant"},
		{item = "value_labyrinth_valve"},
		{item = "value_med_bloodsample"},
		{item = "value_plasticbag_labyrinth"},
	},
}

ix.progression.itemPools.town_expansion_e0ae749d1392 = {
	name = "Clinical supplies and trauma equipment: general supplies (Marsh)",
	tier = "rare",
	candidates = {
		{item = "value_med_bloodset"},
		{item = "value_med_splint"},
		{item = "value_med_syringe"},
		{item = "value_med_thermometer"},
		{item = "value_med_tourniquet_rubber"},
	},
}

ix.progression.itemPools.town_expansion_9bf329b664a1 = {
	name = "Clinical supplies and trauma equipment: supporting supplies (Marsh)",
	tier = "rare",
	candidates = {
		{item = "value_airfilter"},
		{item = "value_labyrinth_valve"},
		{item = "value_other_filter"},
	},
}

ix.progression.itemPools.town_expansion_50f1a6c08b39 = {
	name = "Clinical supplies and trauma equipment: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_med_bloodset"},
		{item = "value_med_haemostatic"},
		{item = "value_med_splint"},
		{item = "value_med_surgicalpouch"},
		{item = "value_med_syringe"},
		{item = "value_med_thermometer"},
		{item = "value_med_tourniquet"},
		{item = "value_med_tourniquet_rubber"},
	},
}

ix.progression.itemPools.town_expansion_fb3bbf7a30aa = {
	name = "Clinical supplies and trauma equipment: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_med_splint"},
		{item = "value_med_syringe"},
		{item = "value_med_tourniquet_rubber"},
	},
}

ix.progression.itemPools.town_expansion_bef1aed7f393 = {
	name = "Clinical supplies and trauma equipment: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_med_bloodset"},
		{item = "value_med_haemostatic"},
		{item = "value_med_splint"},
		{item = "value_med_surgicalpouch"},
		{item = "value_med_syringe"},
		{item = "value_med_thermometer"},
		{item = "value_med_tourniquet"},
		{item = "value_med_tourniquet_rubber"},
	},
}

ix.progression.itemPools.town_expansion_3bf4bb4e77a2 = {
	name = "Clinical supplies and trauma equipment: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_airfilter"},
		{item = "value_anomaly_plant"},
		{item = "value_chemicalsample"},
		{item = "value_labyrinth_valve"},
		{item = "value_med_bloodsample"},
		{item = "value_other_filter"},
		{item = "value_other_hosemilitary"},
		{item = "value_plasticbag_labyrinth"},
	},
}

ix.progression.itemPools.town_expansion_b86ca08c164d = {
	name = "Clinical supplies and trauma equipment: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_anomaly_plant"},
		{item = "value_chemicalsample"},
		{item = "value_labyrinth_valve"},
		{item = "value_med_bloodsample"},
		{item = "value_plasticbag_labyrinth"},
	},
}

ix.progression.itemPools.town_expansion_adb5ba8af817 = {
	name = "Workshop tools and fabrication materials: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_expandingfoam"},
		{item = "value_hultafors_db5000"},
		{item = "value_key_labyrinth_torch"},
		{item = "value_mining_kit"},
		{item = "value_multitul_0"},
		{item = "value_plexiglass"},
		{item = "value_tapemeasure"},
		{item = "value_tools_metalscissors"},
	},
}

ix.progression.itemPools.town_expansion_b96d05056688 = {
	name = "Workshop tools and fabrication materials: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_expandingfoam"},
		{item = "value_hultafors_db5000"},
		{item = "value_key_labyrinth_torch"},
		{item = "value_mining_kit"},
		{item = "value_multitul_0"},
		{item = "value_plexiglass"},
		{item = "value_tapemeasure"},
		{item = "value_tools_metalscissors"},
	},
}

ix.progression.itemPools.town_expansion_f01f02d773ec = {
	name = "Workshop tools and fabrication materials: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_expandingfoam"},
		{item = "value_hultafors_db5000"},
		{item = "value_key_labyrinth_torch"},
		{item = "value_multitul_0"},
		{item = "value_plexiglass"},
		{item = "value_pliers"},
		{item = "value_tools_pliers_round"},
		{item = "value_toolset"},
	},
}

ix.progression.itemPools.town_expansion_4da1807ce39b = {
	name = "Workshop tools and fabrication materials: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_building_kektape"},
		{item = "value_crowbar"},
		{item = "value_electricdrill"},
		{item = "value_handdrill"},
		{item = "value_swiss"},
		{item = "value_tools_nippers"},
		{item = "value_toolset"},
		{item = "value_wd40_400ml"},
	},
}

ix.progression.itemPools.town_expansion_6b08c04b410b = {
	name = "Workshop tools and fabrication materials: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_building_kektape"},
		{item = "value_building_plexiglass"},
		{item = "value_crowbar"},
		{item = "value_electricdrill"},
		{item = "value_handdrill"},
		{item = "value_swiss"},
		{item = "value_tools_nippers"},
		{item = "value_wd40_400ml"},
	},
}

ix.progression.itemPools.town_expansion_1168bc176d8a = {
	name = "Workshop tools and fabrication materials: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_building_kektape"},
		{item = "value_crowbar"},
		{item = "value_electricdrill"},
		{item = "value_pliers"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
		{item = "value_toolset"},
		{item = "value_wd40_400ml"},
	},
}

ix.progression.itemPools.town_expansion_8ccde904a437 = {
	name = "Workshop tools and fabrication materials: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_building_plexiglass"},
		{item = "value_crowbar"},
		{item = "value_electricdrill"},
		{item = "value_hammer"},
		{item = "value_handdrill"},
		{item = "value_swiss"},
		{item = "value_tools_nippers"},
		{item = "value_wd40_400ml"},
	},
}

ix.progression.itemPools.town_expansion_58c67701e851 = {
	name = "Workshop tools and fabrication materials: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_building_plexiglass"},
		{item = "value_building_poxeram"},
		{item = "value_crowbar"},
		{item = "value_electricdrill"},
		{item = "value_hammer"},
		{item = "value_handdrill"},
		{item = "value_swiss"},
		{item = "value_wd40_400ml"},
	},
}

ix.progression.itemPools.town_expansion_e3e4bc290f7c = {
	name = "Workshop tools and fabrication materials: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_building_kektape"},
		{item = "value_crowbar"},
		{item = "value_electricdrill"},
		{item = "value_pliers"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
		{item = "value_toolset"},
		{item = "value_wd40_400ml"},
	},
}

ix.progression.itemPools.town_expansion_de5faa6ef74e = {
	name = "Workshop tools and fabrication materials: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_ballistic4"},
		{item = "value_retardant1"},
		{item = "value_retardant10"},
		{item = "value_retardant11"},
		{item = "value_retardant12"},
		{item = "value_retardant3"},
		{item = "value_retardant4"},
		{item = "value_retardant9"},
	},
}

ix.progression.itemPools.town_expansion_8957d0e845ad = {
	name = "Workshop tools and fabrication materials: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_ballistic11"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
		{item = "value_retardant10"},
		{item = "value_retardant11"},
		{item = "value_retardant12"},
		{item = "value_retardant2"},
		{item = "value_retardant6"},
	},
}

ix.progression.itemPools.town_expansion_7fd0a0ed0759 = {
	name = "Workshop tools and fabrication materials: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_building_kektape"},
		{item = "value_crowbar"},
		{item = "value_electricdrill"},
		{item = "value_pliers"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
		{item = "value_toolset"},
		{item = "value_wd40_400ml"},
	},
}

ix.progression.itemPools.town_expansion_a3cb2e84213f = {
	name = "Workshop tools and fabrication materials: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_ballistic4"},
		{item = "value_retardant1"},
		{item = "value_retardant10"},
		{item = "value_retardant11"},
		{item = "value_retardant12"},
		{item = "value_retardant3"},
		{item = "value_retardant4"},
		{item = "value_retardant9"},
	},
}

ix.progression.itemPools.town_expansion_a5f288f21963 = {
	name = "Workshop tools and fabrication materials: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
		{item = "value_retardant11"},
		{item = "value_retardant12"},
		{item = "value_retardant2"},
		{item = "value_retardant6"},
	},
}

ix.progression.itemPools.town_expansion_7b6bb1241f98 = {
	name = "Workshop tools and fabrication materials: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
		{item = "value_retardant12"},
		{item = "value_retardant2"},
		{item = "value_retardant6"},
	},
}

ix.progression.itemPools.town_expansion_a9f6316d975c = {
	name = "Workshop tools and fabrication materials: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_awl"},
		{item = "value_building_plexiglass"},
		{item = "value_building_poxeram"},
		{item = "value_hammer"},
		{item = "value_handdrill"},
		{item = "value_plastic"},
		{item = "value_swiss"},
		{item = "value_wd40_100ml"},
	},
}

ix.progression.itemPools.town_expansion_8227d69b4065 = {
	name = "Workshop tools and fabrication materials: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_ballistic4"},
		{item = "value_retardant1"},
		{item = "value_retardant10"},
		{item = "value_retardant11"},
		{item = "value_retardant12"},
		{item = "value_retardant3"},
		{item = "value_retardant4"},
		{item = "value_retardant9"},
	},
}

ix.progression.itemPools.town_expansion_3c9a03c85455 = {
	name = "Workshop tools and fabrication materials: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
		{item = "value_retardant2"},
		{item = "value_retardant6"},
	},
}

ix.progression.itemPools.town_expansion_08a5fc882471 = {
	name = "Consignment paperwork and secure dispatches: general supplies (Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_officepaper"},
		{item = "value_safe_container"},
	},
}

ix.progression.itemPools.town_expansion_32bf9455d614 = {
	name = "Consignment paperwork and secure dispatches: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_documents_1"},
		{item = "value_documents_2"},
		{item = "value_envelope"},
		{item = "value_note_folder_closed_cardboard"},
		{item = "value_notepad_a5_closed_01"},
		{item = "value_notepad_a6_closed_01"},
		{item = "value_officepaper"},
		{item = "value_safe_container"},
	},
}

ix.progression.itemPools.town_expansion_bbf56f55989a = {
	name = "Consignment paperwork and secure dispatches: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_documents_2"},
		{item = "value_envelope"},
		{item = "value_note_folder_closed_cardboard"},
		{item = "value_notepad_a5_closed_01"},
		{item = "value_notepad_a6_closed_01"},
		{item = "value_officepaper"},
	},
}

ix.progression.itemPools.town_expansion_6049430add23 = {
	name = "Consignment paperwork and secure dispatches: general supplies (Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_officepaper"},
	},
}

ix.progression.itemPools.town_expansion_e0fb04b1f79d = {
	name = "Consignment paperwork and secure dispatches: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_documents_2"},
		{item = "value_envelope"},
		{item = "value_note_folder_closed_cardboard"},
		{item = "value_notepad_a5_closed_01"},
		{item = "value_notepad_a6_closed_01"},
	},
}

ix.progression.itemPools.town_expansion_b9a6073487e4 = {
	name = "Consignment paperwork and secure dispatches: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_documents_2"},
		{item = "value_envelope"},
		{item = "value_notepad_a5_closed_01"},
		{item = "value_notepad_a6_closed_01"},
	},
}

ix.progression.itemPools.town_expansion_fe8b073bee14 = {
	name = "Consignment paperwork and secure dispatches: general supplies (Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_safe_container"},
	},
}

ix.progression.itemPools.town_expansion_1d8912d7dcc9 = {
	name = "Consignment paperwork and secure dispatches: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_carbon_case"},
		{item = "value_info_maps"},
		{item = "value_knife_box_low"},
		{item = "value_milimap"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
		{item = "value_small_case"},
	},
}

ix.progression.itemPools.town_expansion_a15c9f55de8d = {
	name = "Consignment paperwork and secure dispatches: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_documents_1"},
		{item = "value_documents_2"},
		{item = "value_envelope"},
		{item = "value_note_folder_closed_cardboard"},
		{item = "value_notepad_a5_closed_01"},
		{item = "value_notepad_a6_closed_01"},
		{item = "value_safe_container"},
	},
}

ix.progression.itemPools.town_expansion_5f8c4bfe651e = {
	name = "Consignment paperwork and secure dispatches: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_info_maps"},
		{item = "value_knife_box_low"},
		{item = "value_milimap"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
		{item = "value_small_case"},
	},
}

ix.progression.itemPools.town_expansion_f3e2fe835c22 = {
	name = "Consignment paperwork and secure dispatches: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_info_maps"},
		{item = "value_knife_box_low"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
		{item = "value_small_case"},
	},
}

ix.progression.itemPools.town_expansion_0ad4191601c1 = {
	name = "Consignment paperwork and secure dispatches: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_documents_1"},
		{item = "value_documents_2"},
		{item = "value_envelope"},
		{item = "value_note_folder_closed_cardboard"},
		{item = "value_notepad_a5_closed_01"},
		{item = "value_notepad_a6_closed_01"},
	},
}

ix.progression.itemPools.town_expansion_b22cbcfe962d = {
	name = "Consignment paperwork and secure dispatches: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_info_maps"},
		{item = "value_knife_box_low"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
		{item = "value_small_case"},
	},
}

ix.progression.itemPools.town_expansion_0142dc69300a = {
	name = "Radio infrastructure and network components: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_capacitors"},
		{item = "value_ir_ms2000"},
		{item = "value_radio"},
		{item = "value_receiver1"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_522f1a014836 = {
	name = "Radio infrastructure and network components: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_capacitors"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_0d82996d3674 = {
	name = "Radio infrastructure and network components: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_3cdde43c4da9 = {
	name = "Radio infrastructure and network components: general supplies (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_receiver1"},
	},
}

ix.progression.itemPools.town_expansion_daf27db0d950 = {
	name = "Radio infrastructure and network components: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_capacitors"},
		{item = "value_ir_ms2000"},
		{item = "value_receiver1"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_a4e6394388b2 = {
	name = "Radio infrastructure and network components: general supplies (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_electr_signal_jammer"},
		{item = "value_jamming"},
		{item = "value_radio_repeater"},
	},
}

ix.progression.itemPools.town_expansion_87f2b5d33fe9 = {
	name = "Trail repairs and camp supplies: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_dryfuel"},
		{item = "value_flammable_survlighter"},
		{item = "value_gunoil"},
		{item = "value_kerosene_container"},
		{item = "value_paracord"},
		{item = "value_tape_electric"},
		{item = "value_wire_light"},
		{item = "value_zibbo_0"},
	},
}

ix.progression.itemPools.town_expansion_104aeb78b5d5 = {
	name = "Trail repairs and camp supplies: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_crikent_0"},
		{item = "value_flammable_klean"},
		{item = "value_gascan"},
		{item = "value_lubricant"},
		{item = "value_match"},
		{item = "value_matches"},
	},
}

ix.progression.itemPools.town_expansion_885725dd4862 = {
	name = "Trail repairs and camp supplies: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_dryfuel"},
		{item = "value_gunoil"},
		{item = "value_paracord"},
		{item = "value_tape_electric"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_da07a70522f1 = {
	name = "Trail repairs and camp supplies: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_flammable_huntermatches"},
		{item = "value_flammable_survlighter"},
		{item = "value_kerosene_container"},
		{item = "value_valuable_kresalo"},
		{item = "value_zibbo_0"},
	},
}

ix.progression.itemPools.town_expansion_37b55ef0dcf6 = {
	name = "Trail repairs and camp supplies: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_crikent_0"},
		{item = "value_flammable_klean"},
		{item = "value_gascan"},
		{item = "value_lubricant"},
		{item = "value_match"},
		{item = "value_matches"},
	},
}

ix.progression.itemPools.town_expansion_ce1fe3da240a = {
	name = "Trail repairs and camp supplies: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_bedspread"},
		{item = "value_fabric_aramid"},
		{item = "value_fabrics2"},
		{item = "value_pliers"},
		{item = "value_rope"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_e2b49b37ea94 = {
	name = "Trail repairs and camp supplies: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_fabric_cordura"},
		{item = "value_fabric_fleece"},
		{item = "value_fabric_ripstop"},
		{item = "value_sewingkit"},
		{item = "value_swiss"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_6d4d51331f9d = {
	name = "Trail repairs and camp supplies: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_crikent_0"},
		{item = "value_dryfuel"},
		{item = "value_flammable_huntermatches"},
		{item = "value_flammable_klean"},
		{item = "value_flammable_survlighter"},
		{item = "value_kerosene_container"},
		{item = "value_valuable_kresalo"},
		{item = "value_zibbo_0"},
	},
}

ix.progression.itemPools.town_expansion_69581534d2e6 = {
	name = "Trail repairs and camp supplies: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_crikent_0"},
		{item = "value_flammable_klean"},
		{item = "value_gascan"},
		{item = "value_lubricant"},
		{item = "value_match"},
		{item = "value_matches"},
	},
}

ix.progression.itemPools.town_expansion_40c54698454c = {
	name = "Trail repairs and camp supplies: supporting supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_fabric_cordura"},
		{item = "value_fabric_fleece"},
		{item = "value_fabric_ripstop"},
		{item = "value_sewingkit"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_8bd7dd015011 = {
	name = "Field issue kits and military packing: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_retardant1"},
		{item = "value_retardant10"},
		{item = "value_retardant11"},
		{item = "value_retardant12"},
		{item = "value_retardant2"},
		{item = "value_retardant3"},
		{item = "value_retardant4"},
		{item = "value_retardant9"},
	},
}

ix.progression.itemPools.town_expansion_5cc83a38ada3 = {
	name = "Field issue kits and military packing: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_lopouch"},
		{item = "value_retardant1"},
		{item = "value_retardant10"},
		{item = "value_retardant11"},
		{item = "value_retardant12"},
		{item = "value_retardant3"},
		{item = "value_retardant4"},
		{item = "value_retardant9"},
	},
}

ix.progression.itemPools.town_expansion_429fc498f1b3 = {
	name = "Field issue kits and military packing: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_retardant1"},
		{item = "value_retardant10"},
		{item = "value_retardant11"},
		{item = "value_retardant12"},
		{item = "value_retardant2"},
		{item = "value_retardant4"},
		{item = "value_retardant6"},
		{item = "value_retardant9"},
	},
}

ix.progression.itemPools.town_expansion_61caf3061784 = {
	name = "Field issue kits and military packing: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_retardant1"},
		{item = "value_retardant10"},
		{item = "value_retardant11"},
		{item = "value_retardant3"},
		{item = "value_retardant4"},
		{item = "value_retardant9"},
	},
}

ix.progression.itemPools.town_expansion_9370c4b61e34 = {
	name = "Field issue kits and military packing: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_container_injectorcase"},
		{item = "value_docbag"},
		{item = "value_retardant12"},
		{item = "value_retardant2"},
		{item = "value_retardant6"},
	},
}

ix.progression.itemPools.town_expansion_2ae5db69c5c7 = {
	name = "Field issue kits and military packing: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
		{item = "value_retardant12"},
		{item = "value_retardant2"},
		{item = "value_retardant6"},
	},
}

ix.progression.itemPools.town_expansion_dc820678cc48 = {
	name = "Field issue kits and military packing: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_container_injectorcase"},
		{item = "value_docbag"},
		{item = "value_retardant2"},
		{item = "value_retardant6"},
	},
}

ix.progression.itemPools.town_expansion_b99fd339a771 = {
	name = "Field issue kits and military packing: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_container_injectorcase"},
		{item = "value_docbag"},
		{item = "value_retardant6"},
	},
}

ix.progression.itemPools.town_expansion_2b4fe59ec190 = {
	name = "Field issue kits and military packing: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_container_parls"},
		{item = "value_container_weaponcase"},
		{item = "value_retardant12"},
		{item = "value_retardant2"},
		{item = "value_retardant6"},
	},
}

ix.progression.itemPools.town_expansion_5da355df76fd = {
	name = "Field issue kits and military packing: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic3"},
		{item = "value_ballistic4"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
		{item = "value_documents_1"},
		{item = "value_documents_2"},
	},
}

ix.progression.itemPools.town_expansion_cac9456f2b4b = {
	name = "Field issue kits and military packing: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic3"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
		{item = "value_documents_2"},
	},
}

ix.progression.itemPools.town_expansion_97ec9ad98c1f = {
	name = "Field issue kits and military packing: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
		{item = "value_retardant12"},
		{item = "value_retardant2"},
		{item = "value_retardant6"},
	},
}

ix.progression.itemPools.town_expansion_82f85d31e439 = {
	name = "Field issue kits and military packing: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic3"},
		{item = "value_ballistic4"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
		{item = "value_documents_1"},
		{item = "value_documents_2"},
	},
}

ix.progression.itemPools.town_expansion_f643892847d6 = {
	name = "Field issue kits and military packing: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic3"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
	},
}

ix.progression.itemPools.town_expansion_8095377989f4 = {
	name = "Field issue kits and military packing: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_retardant1"},
		{item = "value_retardant3"},
		{item = "value_retardant4"},
		{item = "value_retardant9"},
	},
}

ix.progression.itemPools.town_expansion_8841f0077ff5 = {
	name = "Field issue kits and military packing: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_retardant10"},
		{item = "value_retardant11"},
		{item = "value_retardant12"},
		{item = "value_retardant2"},
	},
}

ix.progression.itemPools.town_expansion_13aec002f2fd = {
	name = "Field issue kits and military packing: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_container_cardholder"},
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_container_weapon_thicc"},
		{item = "value_docbag"},
		{item = "value_retardant6"},
	},
}

ix.progression.itemPools.town_expansion_8e5e40077d43 = {
	name = "Field issue kits and military packing: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic3"},
		{item = "value_ballistic4"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
		{item = "value_documents_1"},
		{item = "value_documents_2"},
	},
}

ix.progression.itemPools.town_expansion_bbb0f66b23a1 = {
	name = "Field issue kits and military packing: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic3"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
	},
}

ix.progression.itemPools.town_expansion_8bf6b70943be = {
	name = "Computer hardware and data media: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_capacitors"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_681245d7563b = {
	name = "Computer hardware and data media: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_capacitors"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_294f20293f0b = {
	name = "Computer hardware and data media: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_236f10f95cdf = {
	name = "Computer hardware and data media: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_capacitors"},
		{item = "value_wire_copper"},
	},
}

ix.progression.itemPools.town_expansion_4250046093e2 = {
	name = "Computer hardware and data media: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_capacitors"},
	},
}

ix.progression.itemPools.town_expansion_fb1365f60b12 = {
	name = "Computer hardware and data media: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_guide"},
		{item = "value_handbook_materials"},
		{item = "value_manual_lada"},
	},
}

ix.progression.itemPools.town_expansion_2efa4442816e = {
	name = "Computer hardware and data media: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_manual_lada"},
	},
}

ix.progression.itemPools.town_expansion_618611e80a23 = {
	name = "Computer hardware and data media: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_capacitors"},
		{item = "value_electr_card_programmer"},
		{item = "value_flash_card_ironkey"},
		{item = "value_flash_card_ironkey_slider"},
		{item = "value_flash_card_slider"},
		{item = "value_pcpart_cpufan"},
		{item = "value_pcpart_discdrive"},
		{item = "value_wire_copper"},
	},
}

ix.progression.itemPools.town_expansion_79808d7fafd4 = {
	name = "Computer hardware and data media: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_circuitboard"},
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_electr_components"},
		{item = "value_guide"},
		{item = "value_ipcamera"},
		{item = "value_textolite"},
		{item = "value_transistors"},
	},
}

ix.progression.itemPools.town_expansion_9ad3afb71982 = {
	name = "Computer hardware and data media: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_guide"},
		{item = "value_lcddirty"},
		{item = "value_manual_lada"},
	},
}

ix.progression.itemPools.town_expansion_24a35a39e55d = {
	name = "Computer hardware and data media: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_lcddirty"},
		{item = "value_manual_lada"},
	},
}

ix.progression.itemPools.town_expansion_d37d1c34fc08 = {
	name = "Computer hardware and data media: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_electr_card_programmer"},
		{item = "value_flash_card_ironkey"},
		{item = "value_flash_card_ironkey_slider"},
		{item = "value_flash_card_slider"},
		{item = "value_pcpart_cpufan"},
		{item = "value_pcpart_discdrive"},
		{item = "value_pcpart_ram"},
		{item = "value_wire_copper"},
	},
}

ix.progression.itemPools.town_expansion_c881f6d42e13 = {
	name = "Computer hardware and data media: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_circuitboard"},
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_electr_components"},
		{item = "value_guide"},
		{item = "value_ipcamera"},
		{item = "value_textolite"},
		{item = "value_transistors"},
	},
}

ix.progression.itemPools.town_expansion_921e32a51219 = {
	name = "Computer hardware and data media: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_clothbook2"},
		{item = "value_lcddirty"},
		{item = "value_manual_lada"},
	},
}

ix.progression.itemPools.town_expansion_053e066e8c3d = {
	name = "Kitchen stores and cooking fuel: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_coffee"},
		{item = "value_gasoline"},
		{item = "value_household_salt"},
		{item = "value_kerosene"},
		{item = "value_other_grechka"},
		{item = "value_other_lupo"},
		{item = "value_other_tea"},
		{item = "value_sugar"},
	},
}

ix.progression.itemPools.town_expansion_faf015d6ac68 = {
	name = "Kitchen stores and cooking fuel: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_coffee"},
		{item = "value_household_salt"},
		{item = "value_kerosene"},
		{item = "value_other_grechka"},
		{item = "value_other_lupo"},
		{item = "value_other_tea"},
		{item = "value_propanetank"},
		{item = "value_sugar"},
	},
}

ix.progression.itemPools.town_expansion_b0f51f1be48f = {
	name = "Kitchen stores and cooking fuel: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_coffee"},
		{item = "value_other_grechka"},
		{item = "value_other_lupo"},
		{item = "value_other_tea"},
	},
}

ix.progression.itemPools.town_expansion_1d4b55e193f2 = {
	name = "Kitchen stores and cooking fuel: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_gasoline"},
		{item = "value_household_salt"},
		{item = "value_kerosene"},
		{item = "value_propanetank"},
		{item = "value_sugar"},
	},
}

ix.progression.itemPools.town_expansion_81363bbb5ed7 = {
	name = "Kitchen stores and cooking fuel: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_gasoline"},
		{item = "value_household_salt"},
		{item = "value_kerosene"},
		{item = "value_propanetank"},
		{item = "value_sugar"},
	},
}

ix.progression.itemPools.town_expansion_98b12c7cb6da = {
	name = "Kitchen stores and cooking fuel: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_household_salt"},
		{item = "value_kerosene"},
		{item = "value_propanetank"},
		{item = "value_sugar"},
	},
}

ix.progression.itemPools.town_expansion_9a1e4bd69da2 = {
	name = "Kitchen stores and cooking fuel: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_bleach"},
		{item = "value_detergent"},
		{item = "value_glasscleaner"},
		{item = "value_household_toothpaste1"},
		{item = "value_shampoo"},
		{item = "value_soap"},
		{item = "value_toiletpaper"},
		{item = "value_toothpaste"},
	},
}

ix.progression.itemPools.town_expansion_1a2385845422 = {
	name = "Kitchen stores and cooking fuel: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_dryfuel"},
		{item = "value_flammable_huntermatches"},
		{item = "value_flammable_klean"},
		{item = "value_flammable_survlighter"},
		{item = "value_household_toothpaste1"},
		{item = "value_kerosene_container"},
		{item = "value_valuable_kresalo"},
		{item = "value_zibbo_0"},
	},
}

ix.progression.itemPools.town_expansion_73b4332d4f85 = {
	name = "Kitchen stores and cooking fuel: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_gasoline"},
		{item = "value_household_salt"},
		{item = "value_kerosene"},
		{item = "value_propanetank"},
		{item = "value_sugar"},
	},
}

ix.progression.itemPools.town_expansion_9691cc6dbfcc = {
	name = "Kitchen stores and cooking fuel: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_bleach"},
		{item = "value_detergent"},
		{item = "value_glasscleaner"},
		{item = "value_household_toothpaste1"},
		{item = "value_shampoo"},
		{item = "value_soap"},
		{item = "value_toiletpaper"},
		{item = "value_toothpaste"},
	},
}

ix.progression.itemPools.town_expansion_4e90352af9b3 = {
	name = "Kitchen stores and cooking fuel: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_dryfuel"},
		{item = "value_flammable_huntermatches"},
		{item = "value_flammable_klean"},
		{item = "value_flammable_survlighter"},
		{item = "value_gascan"},
		{item = "value_kerosene_container"},
		{item = "value_valuable_kresalo"},
		{item = "value_zibbo_0"},
	},
}

ix.progression.itemPools.town_expansion_93a3504b5346 = {
	name = "Kitchen stores and cooking fuel: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_crikent_0"},
		{item = "value_flammable_huntermatches"},
		{item = "value_flammable_klean"},
		{item = "value_flammable_survlighter"},
		{item = "value_gascan"},
		{item = "value_kerosene_container"},
		{item = "value_valuable_kresalo"},
		{item = "value_zibbo_0"},
	},
}

ix.progression.itemPools.town_expansion_f2fa448016ca = {
	name = "Kitchen stores and cooking fuel: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_coffee"},
		{item = "value_other_grechka"},
		{item = "value_other_lupo"},
	},
}

ix.progression.itemPools.town_expansion_2c47c18fdac3 = {
	name = "Kitchen stores and cooking fuel: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_household_salt"},
		{item = "value_other_tea"},
		{item = "value_sugar"},
	},
}

ix.progression.itemPools.town_expansion_99b5053f4bb9 = {
	name = "Kitchen stores and cooking fuel: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_gasoline"},
		{item = "value_kerosene"},
		{item = "value_propanetank"},
	},
}

ix.progression.itemPools.town_expansion_3708ad79f7ec = {
	name = "Kitchen stores and cooking fuel: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_bleach"},
		{item = "value_detergent"},
		{item = "value_glasscleaner"},
		{item = "value_household_toothpaste1"},
		{item = "value_shampoo"},
		{item = "value_soap"},
		{item = "value_toiletpaper"},
		{item = "value_toothpaste"},
	},
}

ix.progression.itemPools.town_expansion_f1ead98128b3 = {
	name = "Kitchen stores and cooking fuel: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_crikent_0"},
		{item = "value_flammable_huntermatches"},
		{item = "value_flammable_klean"},
		{item = "value_gascan"},
		{item = "value_kerosene_container"},
		{item = "value_matches"},
		{item = "value_valuable_kresalo"},
		{item = "value_zibbo_0"},
	},
}

ix.progression.itemPools.town_expansion_6d2796b9c603 = {
	name = "Receivers, communications parts and recordings: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_calculationunit"},
		{item = "value_frequencymodulator"},
		{item = "value_memorymodule"},
		{item = "value_monitoringunit"},
		{item = "value_phone_new"},
		{item = "value_phone_old"},
		{item = "value_screws"},
		{item = "value_wirelesstrans"},
	},
}

ix.progression.itemPools.town_expansion_1e97742fdab4 = {
	name = "Receivers, communications parts and recordings: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_phone_new"},
		{item = "value_phone_old"},
		{item = "value_screws"},
		{item = "value_wirelesstrans"},
	},
}

ix.progression.itemPools.town_expansion_44f787d6c65b = {
	name = "Receivers, communications parts and recordings: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_archive_cassette"},
		{item = "value_cassette_black90"},
		{item = "value_cassette_fiolet"},
		{item = "value_nails"},
		{item = "value_tape_electric"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_908b33f75597 = {
	name = "Receivers, communications parts and recordings: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_bolts"},
		{item = "value_nails"},
		{item = "value_nuts"},
		{item = "value_sparkplug"},
		{item = "value_spec_recorder"},
		{item = "value_tape_electric"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_3476ed146b98 = {
	name = "Receivers, communications parts and recordings: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_battery_d_0"},
		{item = "value_energy_accum"},
		{item = "value_energy_cyclon"},
		{item = "value_energy_greenbat"},
		{item = "value_helix"},
		{item = "value_lamp_efficient"},
		{item = "value_magnet"},
		{item = "value_powercable"},
	},
}

ix.progression.itemPools.town_expansion_52083f144cae = {
	name = "Receivers, communications parts and recordings: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_electr_tplug"},
		{item = "value_energy_accum"},
		{item = "value_energy_cyclon"},
		{item = "value_energy_greenbat"},
		{item = "value_kanifol"},
		{item = "value_lamp_uv"},
		{item = "value_usb_adapter"},
	},
}

ix.progression.itemPools.town_expansion_4983fe5a1dfc = {
	name = "Receivers, communications parts and recordings: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_screws"},
		{item = "value_wirelesstrans"},
	},
}

ix.progression.itemPools.town_expansion_f376ba7d7c11 = {
	name = "Receivers, communications parts and recordings: general supplies (Garbage)",
	tier = "rare",
	candidates = {
		{item = "value_frequencymodulator"},
		{item = "value_phone_new"},
		{item = "value_phone_old"},
	},
}

ix.progression.itemPools.town_expansion_76f849572a9d = {
	name = "Receivers, communications parts and recordings: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_bolts"},
		{item = "value_nails"},
		{item = "value_nuts"},
		{item = "value_sparkplug"},
		{item = "value_spec_recorder"},
		{item = "value_tape_electric"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_dfe9b6a33027 = {
	name = "Receivers, communications parts and recordings: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_battery_d_0"},
		{item = "value_energy_accum"},
		{item = "value_energy_cyclon"},
		{item = "value_energy_greenbat"},
		{item = "value_helix"},
		{item = "value_lamp_efficient"},
		{item = "value_magnet"},
		{item = "value_powercable"},
	},
}

ix.progression.itemPools.town_expansion_d28603ad751d = {
	name = "Receivers, communications parts and recordings: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_electr_tplug"},
		{item = "value_energy_greenbat"},
		{item = "value_kanifol"},
		{item = "value_lamp_uv"},
		{item = "value_usb_adapter"},
	},
}

ix.progression.itemPools.town_expansion_af20f7801894 = {
	name = "Receivers, communications parts and recordings: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_bolts"},
		{item = "value_nails"},
		{item = "value_nuts"},
		{item = "value_screws"},
		{item = "value_sparkplug"},
		{item = "value_tape_electric"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_694e61e8f85c = {
	name = "Receivers, communications parts and recordings: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_archive_cassette"},
		{item = "value_cassette_black90"},
		{item = "value_cassette_fiolet"},
		{item = "value_nails"},
		{item = "value_sparkplug"},
		{item = "value_tape_electric"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_220487dd9175 = {
	name = "Receivers, communications parts and recordings: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_bolts"},
		{item = "value_cassette_black90"},
		{item = "value_nails"},
		{item = "value_nuts"},
		{item = "value_sparkplug"},
		{item = "value_tape_electric"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_dc5e419e9611 = {
	name = "Receivers, communications parts and recordings: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_archive_cassette"},
		{item = "value_cassette_black90"},
		{item = "value_cassette_fiolet"},
		{item = "value_nails"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_8ea22f53808c = {
	name = "Receivers, communications parts and recordings: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_electr_tplug"},
		{item = "value_energy_accum"},
		{item = "value_energy_greenbat"},
		{item = "value_kanifol"},
		{item = "value_lamp_uv"},
		{item = "value_usb_adapter"},
	},
}

ix.progression.itemPools.town_expansion_c281c09c7712 = {
	name = "Hunting equipment care and field observations: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_guncleaner"},
		{item = "value_gunoil"},
		{item = "value_gunspray"},
		{item = "value_lubricant"},
	},
}

ix.progression.itemPools.town_expansion_d58e029a2c73 = {
	name = "Hunting equipment care and field observations: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_guncleaner"},
		{item = "value_gunoil"},
		{item = "value_gunspray"},
		{item = "value_info_maps"},
		{item = "value_info_moleskine"},
		{item = "value_maps"},
		{item = "value_milimap"},
		{item = "value_thick_diary"},
	},
}

ix.progression.itemPools.town_expansion_81b2bee23ae3 = {
	name = "Hunting equipment care and field observations: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_guncleaner"},
		{item = "value_gunspray"},
		{item = "value_info_maps"},
		{item = "value_info_moleskine"},
		{item = "value_lubricant"},
		{item = "value_maps"},
		{item = "value_milimap"},
		{item = "value_thick_diary"},
	},
}

ix.progression.itemPools.town_expansion_dff12f3a7bfc = {
	name = "Hunting equipment care and field observations: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_guncleaner"},
		{item = "value_gunoil"},
	},
}

ix.progression.itemPools.town_expansion_c0fd82db86e4 = {
	name = "Hunting equipment care and field observations: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_gunspray"},
		{item = "value_info_maps"},
		{item = "value_lubricant"},
		{item = "value_maps"},
		{item = "value_milimap"},
		{item = "value_thick_diary"},
	},
}

ix.progression.itemPools.town_expansion_f9d2f4d1f455 = {
	name = "Hunting equipment care and field observations: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_gunspray"},
		{item = "value_info_maps"},
		{item = "value_info_moleskine"},
		{item = "value_lubricant"},
		{item = "value_maps"},
		{item = "value_milimap"},
		{item = "value_thick_diary"},
	},
}

ix.progression.itemPools.town_expansion_1d794f429f81 = {
	name = "Hunting equipment care and field observations: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_info_maps"},
		{item = "value_info_moleskine"},
		{item = "value_lubricant"},
		{item = "value_maps"},
		{item = "value_milimap"},
		{item = "value_thick_diary"},
	},
}

ix.progression.itemPools.town_expansion_0e0dc6e7b126 = {
	name = "Hunting equipment care and field observations: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_info_maps"},
		{item = "value_info_moleskine"},
		{item = "value_maps"},
		{item = "value_milimap"},
		{item = "value_thick_diary"},
	},
}

ix.progression.itemPools.town_expansion_eed29779a4a3 = {
	name = "Hunting equipment care and field observations: general supplies (Garbage)",
	tier = "rare",
	candidates = {
		{item = "value_gunspray"},
		{item = "value_lubricant"},
	},
}

ix.progression.itemPools.town_expansion_56d648ee3be5 = {
	name = "Hunting equipment care and field observations: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_pliers"},
		{item = "value_pressuregauge"},
		{item = "value_sensor_a"},
		{item = "value_sensor_d"},
		{item = "value_swiss"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_3017dfb6aeed = {
	name = "Hunting equipment care and field observations: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_pressuregauge"},
		{item = "value_swiss"},
		{item = "value_tools_nippers"},
	},
}

ix.progression.itemPools.town_expansion_207b0a33c365 = {
	name = "Hunting equipment care and field observations: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_gunspray"},
		{item = "value_info_maps"},
		{item = "value_info_moleskine"},
		{item = "value_lubricant"},
		{item = "value_maps"},
		{item = "value_milimap"},
		{item = "value_thick_diary"},
	},
}

ix.progression.itemPools.town_expansion_c1a8cc8c75c6 = {
	name = "Hunting equipment care and field observations: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_pliers"},
		{item = "value_pressuregauge"},
		{item = "value_sensor_a"},
		{item = "value_sensor_d"},
		{item = "value_swiss"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_7cbed9a0ebbc = {
	name = "Hunting equipment care and field observations: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_awl"},
		{item = "value_sensor_d"},
		{item = "value_swiss"},
		{item = "value_thermalmodule"},
	},
}

ix.progression.itemPools.town_expansion_4faa8fb764b5 = {
	name = "Hunting equipment care and field observations: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_awl"},
		{item = "value_electro_gyroscope"},
		{item = "value_gyroscope"},
		{item = "value_gyrotachometer"},
		{item = "value_optical_lens"},
		{item = "value_sensor_d"},
		{item = "value_thermalmodule"},
	},
}

ix.progression.itemPools.town_expansion_6744c5d3d5e5 = {
	name = "Hunting equipment care and field observations: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_gunoil"},
	},
}

ix.progression.itemPools.town_expansion_16d5b9b3fa35 = {
	name = "Hunting equipment care and field observations: general supplies (Garbage)",
	tier = "rare",
	candidates = {
		{item = "value_guncleaner"},
	},
}

ix.progression.itemPools.town_expansion_9d57a1f81f49 = {
	name = "Hunting equipment care and field observations: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_gunspray"},
		{item = "value_info_maps"},
		{item = "value_info_moleskine"},
		{item = "value_lubricant"},
		{item = "value_maps"},
		{item = "value_milimap"},
		{item = "value_thick_diary"},
	},
}

ix.progression.itemPools.town_expansion_8d74da7dbff0 = {
	name = "Hunting equipment care and field observations: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_pliers"},
		{item = "value_pressuregauge"},
		{item = "value_sensor_a"},
		{item = "value_sensor_d"},
		{item = "value_swiss"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_3dd770aeba25 = {
	name = "Hunting equipment care and field observations: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_awl"},
		{item = "value_electro_gyroscope"},
		{item = "value_gyroscope"},
		{item = "value_gyrotachometer"},
		{item = "value_optical_lens"},
		{item = "value_sensor_d"},
		{item = "value_thermalmodule"},
	},
}

ix.progression.itemPools.town_expansion_3c5cd8199633 = {
	name = "Cloth, protective layers and sewing supplies: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_retardant1"},
		{item = "value_retardant10"},
		{item = "value_retardant11"},
		{item = "value_retardant12"},
		{item = "value_retardant2"},
		{item = "value_retardant3"},
		{item = "value_retardant4"},
		{item = "value_retardant9"},
	},
}

ix.progression.itemPools.town_expansion_b9ac7abdac90 = {
	name = "Cloth, protective layers and sewing supplies: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_bedspread"},
		{item = "value_fabric_aramid"},
		{item = "value_fabrics1"},
		{item = "value_fabrics2"},
		{item = "value_rope"},
		{item = "value_ropes"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_66b24e939800 = {
	name = "Cloth, protective layers and sewing supplies: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_fabrics1"},
		{item = "value_fabrics2"},
		{item = "value_retardant3"},
		{item = "value_retardant4"},
		{item = "value_retardant9"},
		{item = "value_ropes"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_9441b17bc45e = {
	name = "Cloth, protective layers and sewing supplies: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_retardant1"},
		{item = "value_retardant10"},
		{item = "value_retardant11"},
		{item = "value_retardant3"},
		{item = "value_retardant4"},
		{item = "value_retardant9"},
	},
}

ix.progression.itemPools.town_expansion_4890d067106b = {
	name = "Cloth, protective layers and sewing supplies: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_fabrics1"},
		{item = "value_fabrics2"},
		{item = "value_retardant12"},
		{item = "value_rope"},
		{item = "value_ropes"},
		{item = "value_sewingkit"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_18843025de3c = {
	name = "Cloth, protective layers and sewing supplies: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_bedspread"},
		{item = "value_fabric_aramid"},
		{item = "value_fabrics1"},
		{item = "value_fabrics2"},
		{item = "value_rope"},
		{item = "value_ropes"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_0bf6215d6420 = {
	name = "Cloth, protective layers and sewing supplies: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_fabrics1"},
		{item = "value_fabrics2"},
		{item = "value_retardant12"},
		{item = "value_retardant2"},
		{item = "value_ropes"},
		{item = "value_sewingkit"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_e89248037748 = {
	name = "Cloth, protective layers and sewing supplies: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_fabrics1"},
		{item = "value_retardant12"},
		{item = "value_retardant2"},
		{item = "value_retardant6"},
		{item = "value_ropes"},
		{item = "value_sewingkit"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_3d545324f4f1 = {
	name = "Cloth, protective layers and sewing supplies: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_fabric_cordura"},
		{item = "value_fabric_fleece"},
		{item = "value_fabric_ripstop"},
		{item = "value_retardant12"},
		{item = "value_retardant2"},
		{item = "value_retardant6"},
	},
}

ix.progression.itemPools.town_expansion_2470b2a13707 = {
	name = "Cloth, protective layers and sewing supplies: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_ballistic11"},
		{item = "value_ballistic4"},
		{item = "value_ballistic6"},
		{item = "value_pliers"},
		{item = "value_swiss"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_b4f6e587d11c = {
	name = "Cloth, protective layers and sewing supplies: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
		{item = "value_swiss"},
		{item = "value_tools_nippers"},
	},
}

ix.progression.itemPools.town_expansion_a7a6382a68e7 = {
	name = "Cloth, protective layers and sewing supplies: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_bedspread"},
		{item = "value_fabric_aramid"},
		{item = "value_fabrics1"},
		{item = "value_fabrics2"},
		{item = "value_rope"},
		{item = "value_ropes"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_f71814abbe4a = {
	name = "Cloth, protective layers and sewing supplies: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_ballistic11"},
		{item = "value_ballistic4"},
		{item = "value_ballistic6"},
		{item = "value_pliers"},
		{item = "value_swiss"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_b7928c8a97c3 = {
	name = "Cloth, protective layers and sewing supplies: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
		{item = "value_swiss"},
		{item = "value_tools_nippers"},
	},
}

ix.progression.itemPools.town_expansion_0a2a535093bf = {
	name = "Cloth, protective layers and sewing supplies: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_awl"},
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic3"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
		{item = "value_swiss"},
	},
}

ix.progression.itemPools.town_expansion_e9d564566ea6 = {
	name = "Cloth, protective layers and sewing supplies: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_awl"},
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic3"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
	},
}

ix.progression.itemPools.town_expansion_a91bbf487d15 = {
	name = "Cloth, protective layers and sewing supplies: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_retardant1"},
		{item = "value_retardant3"},
		{item = "value_retardant4"},
		{item = "value_retardant9"},
	},
}

ix.progression.itemPools.town_expansion_4b43b441dd21 = {
	name = "Cloth, protective layers and sewing supplies: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_retardant10"},
		{item = "value_retardant11"},
		{item = "value_retardant12"},
		{item = "value_retardant2"},
	},
}

ix.progression.itemPools.town_expansion_ed39009e757a = {
	name = "Cloth, protective layers and sewing supplies: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_bedspread"},
		{item = "value_fabric_aramid"},
		{item = "value_fabrics1"},
		{item = "value_fabrics2"},
		{item = "value_rope"},
		{item = "value_ropes"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_29ae43e240cf = {
	name = "Cloth, protective layers and sewing supplies: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_ballistic11"},
		{item = "value_ballistic4"},
		{item = "value_ballistic6"},
		{item = "value_pliers"},
		{item = "value_swiss"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_080481dac15f = {
	name = "Cloth, protective layers and sewing supplies: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_awl"},
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic3"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
	},
}

ix.progression.itemPools.town_expansion_89449a5e427f = {
	name = "Cloth, protective layers and sewing supplies: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_fabrics1"},
		{item = "value_fabrics2"},
		{item = "value_retardant3"},
		{item = "value_retardant4"},
		{item = "value_rope"},
		{item = "value_ropes"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_65bb0e75d525 = {
	name = "Cloth, protective layers and sewing supplies: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_fabric_fleece"},
		{item = "value_retardant12"},
		{item = "value_retardant2"},
		{item = "value_retardant6"},
		{item = "value_ropes"},
		{item = "value_sewingkit"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_a4cab97a944e = {
	name = "Precision tools and mechanical repair parts: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_bolts"},
		{item = "value_glue_1"},
		{item = "value_glue_2"},
		{item = "value_glue_3"},
		{item = "value_glue_4"},
		{item = "value_hose"},
		{item = "value_nuts"},
		{item = "value_wire_copper"},
	},
}

ix.progression.itemPools.town_expansion_3698b9592041 = {
	name = "Precision tools and mechanical repair parts: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_glue_1"},
		{item = "value_glue_2"},
		{item = "value_glue_3"},
		{item = "value_glue_4"},
		{item = "value_hose"},
		{item = "value_lightbulb"},
		{item = "value_nails"},
		{item = "value_tape_duct"},
	},
}

ix.progression.itemPools.town_expansion_92b292933cfc = {
	name = "Precision tools and mechanical repair parts: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_paracord"},
		{item = "value_rope"},
		{item = "value_ropes"},
		{item = "value_siliconetube"},
		{item = "value_tape_duct"},
		{item = "value_tape_electric"},
		{item = "value_tarp"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_0482d320b672 = {
	name = "Precision tools and mechanical repair parts: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_lightbulb"},
		{item = "value_nails"},
		{item = "value_paracord"},
		{item = "value_tape_duct"},
		{item = "value_upgro1"},
		{item = "value_upgro2"},
		{item = "value_upgro3"},
		{item = "value_wrench"},
	},
}

ix.progression.itemPools.town_expansion_588269d38f3b = {
	name = "Precision tools and mechanical repair parts: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_lightbulb"},
		{item = "value_nails"},
		{item = "value_paracord"},
		{item = "value_precisiontools"},
		{item = "value_tape_duct"},
		{item = "value_upgro2"},
		{item = "value_upgro3"},
		{item = "value_wrench"},
	},
}

ix.progression.itemPools.town_expansion_6eccbc654c33 = {
	name = "Precision tools and mechanical repair parts: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_lightbulb"},
		{item = "value_nails"},
		{item = "value_precisiontools"},
		{item = "value_screwdriver"},
		{item = "value_tape_duct"},
		{item = "value_tools_screwdriver_flat_long"},
		{item = "value_upgro2"},
		{item = "value_upgro3"},
	},
}

ix.progression.itemPools.town_expansion_fccf7e5c508d = {
	name = "Precision tools and mechanical repair parts: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_lightbulb"},
		{item = "value_nails"},
		{item = "value_paracord"},
		{item = "value_siliconetube"},
		{item = "value_sparkplug"},
		{item = "value_tape_duct"},
		{item = "value_tape_electric"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_5d7a58b28901 = {
	name = "Precision tools and mechanical repair parts: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_building_plexiglass"},
		{item = "value_building_poxeram"},
		{item = "value_electr_tplug"},
		{item = "value_helix"},
		{item = "value_kanifol"},
		{item = "value_lamp_uv"},
		{item = "value_usb_adapter"},
		{item = "value_wd40_400ml"},
	},
}

ix.progression.itemPools.town_expansion_265c3543f984 = {
	name = "Precision tools and mechanical repair parts: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_metalparts"},
		{item = "value_screws"},
		{item = "value_siliconetube"},
		{item = "value_sparkplug"},
		{item = "value_tape_electric"},
		{item = "value_tools_advwrench"},
		{item = "value_waste_heavy"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_21f69e1dd804 = {
	name = "Precision tools and mechanical repair parts: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_building_plexiglass"},
		{item = "value_building_poxeram"},
		{item = "value_electr_tplug"},
		{item = "value_kanifol"},
		{item = "value_lamp_uv"},
		{item = "value_plastic"},
		{item = "value_usb_adapter"},
		{item = "value_wd40_400ml"},
	},
}

ix.progression.itemPools.town_expansion_d051739d24e8 = {
	name = "Precision tools and mechanical repair parts: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_building_plexiglass"},
		{item = "value_building_poxeram"},
		{item = "value_electr_tplug"},
		{item = "value_kanifol"},
		{item = "value_lamp_uv"},
		{item = "value_plastic"},
		{item = "value_powerfilter"},
		{item = "value_usb_adapter"},
	},
}

ix.progression.itemPools.town_expansion_88c326a82942 = {
	name = "Precision tools and mechanical repair parts: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_metalparts"},
		{item = "value_parts"},
		{item = "value_screws"},
		{item = "value_tools_advwrench"},
		{item = "value_tools_ratchetwrench"},
		{item = "value_upgro1"},
		{item = "value_waste_heavy"},
		{item = "value_wrench"},
	},
}

ix.progression.itemPools.town_expansion_064eb1bf0cb5 = {
	name = "Precision tools and mechanical repair parts: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_building_plexiglass"},
		{item = "value_building_poxeram"},
		{item = "value_electr_tplug"},
		{item = "value_kanifol"},
		{item = "value_plastic"},
		{item = "value_powerfilter"},
		{item = "value_usb_adapter"},
	},
}

ix.progression.itemPools.town_expansion_77f938d099ae = {
	name = "Expedition instruments and field preparation: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_gunoil"},
		{item = "value_lubricant"},
	},
}

ix.progression.itemPools.town_expansion_659c6ec753e7 = {
	name = "Expedition instruments and field preparation: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_gunoil"},
		{item = "value_lubricant"},
		{item = "value_paracord"},
		{item = "value_pressuregauge"},
		{item = "value_sensor_a"},
		{item = "value_tape_electric"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_ddeffeb73aaa = {
	name = "Expedition instruments and field preparation: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_gunoil"},
		{item = "value_paracord"},
		{item = "value_tape_electric"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_8822f7a90f08 = {
	name = "Expedition instruments and field preparation: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_paracord"},
		{item = "value_tape_electric"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_cdd204229f48 = {
	name = "Expedition instruments and field preparation: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_gunoil"},
	},
}

ix.progression.itemPools.town_expansion_a36dd2f48f95 = {
	name = "Expedition instruments and field preparation: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_paracord"},
		{item = "value_tape_electric"},
	},
}

ix.progression.itemPools.town_expansion_70501b6c691d = {
	name = "Expedition instruments and field preparation: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_lubricant"},
		{item = "value_paracord"},
		{item = "value_pressuregauge"},
		{item = "value_sensor_a"},
		{item = "value_tape_electric"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_7f149830f8d0 = {
	name = "Expedition instruments and field preparation: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_casezerogeo"},
		{item = "value_lubricant"},
		{item = "value_paracord"},
		{item = "value_pressuregauge"},
		{item = "value_sensor_a"},
		{item = "value_sensor_d"},
		{item = "value_tape_electric"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_9f1deadf7aa2 = {
	name = "Expedition instruments and field preparation: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_lubricant"},
		{item = "value_pressuregauge"},
		{item = "value_sensor_a"},
	},
}

ix.progression.itemPools.town_expansion_efa40da7e4ad = {
	name = "Expedition instruments and field preparation: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_lubricant"},
		{item = "value_pressuregauge"},
	},
}

ix.progression.itemPools.town_expansion_b06ffdd3872e = {
	name = "Expedition instruments and field preparation: general supplies (Garbage)",
	tier = "rare",
	candidates = {
		{item = "value_lubricant"},
	},
}

ix.progression.itemPools.town_expansion_8263cc3b2759 = {
	name = "Expedition instruments and field preparation: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_chemcontainer"},
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_docbag"},
		{item = "value_event_labyrinth_chem_container"},
		{item = "value_portable_container_closed"},
		{item = "value_portable_container_opened"},
		{item = "value_thermobag"},
	},
}

ix.progression.itemPools.town_expansion_ea1d090d14a0 = {
	name = "Expedition instruments and field preparation: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
		{item = "value_event_labyrinth_chem_container"},
		{item = "value_thermobag"},
	},
}

ix.progression.itemPools.town_expansion_c2760e63776a = {
	name = "Expedition instruments and field preparation: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_lubricant"},
		{item = "value_paracord"},
		{item = "value_pressuregauge"},
		{item = "value_sensor_a"},
		{item = "value_sensor_d"},
		{item = "value_tape_electric"},
		{item = "value_thermalmodule"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_78fede4ef488 = {
	name = "Expedition instruments and field preparation: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_chemcontainer"},
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_docbag"},
		{item = "value_event_labyrinth_chem_container"},
		{item = "value_portable_container_closed"},
		{item = "value_portable_container_opened"},
		{item = "value_thermobag"},
	},
}

ix.progression.itemPools.town_expansion_950732f7ecab = {
	name = "Expedition instruments and field preparation: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
		{item = "value_event_labyrinth_chem_container"},
		{item = "value_thermobag"},
	},
}

ix.progression.itemPools.town_expansion_4908b8a6a214 = {
	name = "Expedition instruments and field preparation: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
		{item = "value_thermobag"},
	},
}

ix.progression.itemPools.town_expansion_f4528b8e747d = {
	name = "Expedition instruments and field preparation: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_casezerogeo"},
		{item = "value_paracord"},
		{item = "value_pressuregauge"},
		{item = "value_sensor_a"},
		{item = "value_sensor_d"},
		{item = "value_tape_electric"},
		{item = "value_thermalmodule"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_921ae5a3e892 = {
	name = "Expedition instruments and field preparation: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_chemcontainer"},
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_docbag"},
		{item = "value_event_labyrinth_chem_container"},
		{item = "value_portable_container_closed"},
		{item = "value_portable_container_opened"},
		{item = "value_thermobag"},
	},
}

ix.progression.itemPools.town_expansion_3f51cdb7d8ff = {
	name = "Expedition instruments and field preparation: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
		{item = "value_thermobag"},
	},
}

ix.progression.itemPools.town_expansion_2527acd3d1b4 = {
	name = "Personal effects and recovered belongings: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_container_cardholder"},
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
		{item = "value_goldchain"},
		{item = "value_watch"},
	},
}

ix.progression.itemPools.town_expansion_f145861c27c2 = {
	name = "Personal effects and recovered belongings: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_container_cardholder"},
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_crow_beak"},
		{item = "value_docbag"},
		{item = "value_lightkeeper_amulet"},
		{item = "value_watch"},
	},
}

ix.progression.itemPools.town_expansion_156ee0d5478b = {
	name = "Personal effects and recovered belongings: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_crow_beak"},
		{item = "value_docbag"},
		{item = "value_lightkeeper_amulet"},
	},
}

ix.progression.itemPools.town_expansion_fc81a72067fb = {
	name = "Personal effects and recovered belongings: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_docbag"},
	},
}

ix.progression.itemPools.town_expansion_69eb1c719480 = {
	name = "Personal effects and recovered belongings: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_container_cardholder"},
		{item = "value_container_smallitems"},
		{item = "value_lightkeeper_amulet"},
	},
}

ix.progression.itemPools.town_expansion_23ae21c1f226 = {
	name = "Personal effects and recovered belongings: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_container_cardholder"},
		{item = "value_container_smallitems"},
		{item = "value_crow_beak"},
		{item = "value_goldchain"},
		{item = "value_lightkeeper_amulet"},
		{item = "value_watch"},
	},
}

ix.progression.itemPools.town_expansion_0280c4e0d311 = {
	name = "Personal effects and recovered belongings: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_cardholder"},
		{item = "value_container_smallitems"},
		{item = "value_crow_beak"},
		{item = "value_goldchain"},
		{item = "value_lightkeeper_amulet"},
		{item = "value_watch"},
	},
}

ix.progression.itemPools.town_expansion_c0f4328bbece = {
	name = "Personal effects and recovered belongings: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_smallitems"},
		{item = "value_lightkeeper_amulet"},
	},
}

ix.progression.itemPools.town_expansion_0b064e1c97d2 = {
	name = "Personal effects and recovered belongings: general supplies (Garbage)",
	tier = "uncommon",
	candidates = {
		{item = "value_container_cardholder"},
		{item = "value_container_smallitems"},
		{item = "value_goldchain"},
		{item = "value_watch"},
	},
}

ix.progression.itemPools.town_expansion_589ad0d0339c = {
	name = "Personal effects and recovered belongings: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_carbon_case"},
		{item = "value_envelope"},
		{item = "value_knife_box_low"},
		{item = "value_note_folder_closed_cardboard"},
		{item = "value_notepad_a5_closed_01"},
		{item = "value_notepad_a6_closed_01"},
		{item = "value_officepaper"},
		{item = "value_parcel"},
	},
}

ix.progression.itemPools.town_expansion_8d2894187d3b = {
	name = "Personal effects and recovered belongings: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_carbon_case"},
		{item = "value_envelope"},
		{item = "value_knife_box_low"},
		{item = "value_officepaper"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
	},
}

ix.progression.itemPools.town_expansion_849adebda003 = {
	name = "Personal effects and recovered belongings: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_container_cardholder"},
		{item = "value_container_smallitems"},
		{item = "value_crow_beak"},
		{item = "value_goldchain"},
		{item = "value_lightkeeper_amulet"},
		{item = "value_watch"},
	},
}

ix.progression.itemPools.town_expansion_2399396de269 = {
	name = "Personal effects and recovered belongings: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_carbon_case"},
		{item = "value_envelope"},
		{item = "value_knife_box_low"},
		{item = "value_note_folder_closed_cardboard"},
		{item = "value_notepad_a5_closed_01"},
		{item = "value_notepad_a6_closed_01"},
		{item = "value_officepaper"},
		{item = "value_parcel"},
	},
}

ix.progression.itemPools.town_expansion_7f159eab7029 = {
	name = "Personal effects and recovered belongings: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_carbon_case"},
		{item = "value_envelope"},
		{item = "value_knife_box_low"},
		{item = "value_officepaper"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
	},
}

ix.progression.itemPools.town_expansion_938c8456db0f = {
	name = "Personal effects and recovered belongings: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_carbon_case"},
		{item = "value_knife_box_low"},
		{item = "value_officepaper"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
		{item = "value_small_case"},
	},
}

ix.progression.itemPools.town_expansion_2c2a7090730b = {
	name = "Personal effects and recovered belongings: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
	},
}

ix.progression.itemPools.town_expansion_94565a20fc22 = {
	name = "Personal effects and recovered belongings: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
	},
}

ix.progression.itemPools.town_expansion_9111ce4a36e4 = {
	name = "Personal effects and recovered belongings: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_container_cardholder"},
		{item = "value_crow_beak"},
		{item = "value_goldchain"},
		{item = "value_lightkeeper_amulet"},
		{item = "value_watch"},
	},
}

ix.progression.itemPools.town_expansion_df842199a87e = {
	name = "Personal effects and recovered belongings: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_carbon_case"},
		{item = "value_envelope"},
		{item = "value_knife_box_low"},
		{item = "value_note_folder_closed_cardboard"},
		{item = "value_notepad_a5_closed_01"},
		{item = "value_notepad_a6_closed_01"},
		{item = "value_officepaper"},
		{item = "value_parcel"},
	},
}

ix.progression.itemPools.town_expansion_c087c135e110 = {
	name = "Personal effects and recovered belongings: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_carbon_case"},
		{item = "value_knife_box_low"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
		{item = "value_small_case"},
	},
}

ix.progression.itemPools.town_expansion_a565b0dea0b8 = {
	name = "Personal effects and recovered belongings: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_carbon_case"},
		{item = "value_knife_box_low"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
		{item = "value_small_case"},
	},
}
