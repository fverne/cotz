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

ix.progression.itemPools.town_expansion_33c1f20f3df6 = {
	name = "Survey notes and measuring instruments: Maps and personal field journals (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_info_moleskine"},
		{item = "value_maps"},
	},
}

ix.progression.itemPools.town_expansion_cd66b561ad61 = {
	name = "Survey notes and measuring instruments: Recovered precision instruments (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_sensor_a"},
	},
}

ix.progression.itemPools.town_expansion_47693cc98ba9 = {
	name = "Survey notes and measuring instruments: Maps and personal field journals (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_maps"},
		{item = "value_thick_diary"},
	},
}

ix.progression.itemPools.town_expansion_c9f2d2ed09ff = {
	name = "Survey notes and measuring instruments: Recovered precision instruments (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_sensor_a"},
	},
}

ix.progression.itemPools.town_expansion_3aa952bfeba2 = {
	name = "Survey notes and measuring instruments: Recovered survey equipment (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_geigercounter"},
	},
}

ix.progression.itemPools.town_expansion_76d0f103139a = {
	name = "Survey notes and measuring instruments: Recorders and recovered recordings (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_cassette_fiolet"},
	},
}

ix.progression.itemPools.town_expansion_04cdd4b08115 = {
	name = "Survey notes and measuring instruments: Maps and personal field journals (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_milimap"},
	},
}

ix.progression.itemPools.town_expansion_9541798b36fd = {
	name = "Survey notes and measuring instruments: Recorders and recovered recordings (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_cassette_fiolet"},
	},
}

ix.progression.itemPools.town_expansion_611d4cf3cc00 = {
	name = "Survey notes and measuring instruments: Recovered precision instruments (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_electro_gyroscope"},
		{item = "value_optical_lens"},
	},
}

ix.progression.itemPools.town_expansion_28b985046a5a = {
	name = "Survey notes and measuring instruments: Recovered survey equipment (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_scanner_anomaly"},
		{item = "value_scanner_artefact"},
	},
}

ix.progression.itemPools.town_expansion_562e5cf9a414 = {
	name = "Survey notes and measuring instruments: Recovered precision instruments (Marsh)",
	tier = "rare",
	candidates = {
		{item = "value_pressuregauge"},
	},
}

ix.progression.itemPools.town_expansion_ba8f5609d782 = {
	name = "Survey notes and measuring instruments: Recorders and recovered recordings (Marsh)",
	tier = "rare",
	candidates = {
		{item = "value_archive_cassette"},
	},
}

ix.progression.itemPools.town_expansion_3697657ea4c2 = {
	name = "Freight cases and cargo packing: Textile repair and carrying supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_paracord"},
		{item = "value_tape_duct"},
	},
}

ix.progression.itemPools.town_expansion_5678ca47eff1 = {
	name = "Freight cases and cargo packing: Textile repair and carrying supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_paracord"},
		{item = "value_rope"},
	},
}

ix.progression.itemPools.town_expansion_16eadd0282a9 = {
	name = "Freight cases and cargo packing: Textile repair and carrying supplies (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_ropes"},
		{item = "value_tarp"},
	},
}

ix.progression.itemPools.town_expansion_d24f6e6806cb = {
	name = "Freight cases and cargo packing: Textile repair and carrying supplies (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_ropes"},
		{item = "value_tarp"},
	},
}

ix.progression.itemPools.town_expansion_26349e00c296 = {
	name = "Freight cases and cargo packing: General transit cases and consignments (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_carbon_case"},
		{item = "value_knife_box_low"},
	},
}

ix.progression.itemPools.town_expansion_74ccfb2736e2 = {
	name = "Freight cases and cargo packing: Reinforced equipment cases (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_container_junkbox"},
	},
}

ix.progression.itemPools.town_expansion_85356b44df05 = {
	name = "Freight cases and cargo packing: Fabric, sewing and carrying supplies (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_fabric_fleece"},
		{item = "value_sewingkit"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_f5c0a28eb987 = {
	name = "Freight cases and cargo packing: General transit cases and consignments (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_carbon_case"},
		{item = "value_knife_box_low"},
	},
}

ix.progression.itemPools.town_expansion_4f6e339e6499 = {
	name = "Freight cases and cargo packing: Fuel and firelighting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_flammable_huntermatches"},
		{item = "value_flammable_klean"},
		{item = "value_gascan"},
	},
}

ix.progression.itemPools.town_expansion_c37905912f9c = {
	name = "Freight cases and cargo packing: Reinforced equipment cases (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_container_junkbox"},
	},
}

ix.progression.itemPools.town_expansion_cab385be9728 = {
	name = "Freight cases and cargo packing: Fabric, sewing and carrying supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_sewingkit"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_4758fc5afaa5 = {
	name = "Freight cases and cargo packing: General transit cases and consignments (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_pukt90"},
		{item = "value_security_box"},
	},
}

ix.progression.itemPools.town_expansion_5a1a3b84317a = {
	name = "Freight cases and cargo packing: Fabric, sewing and carrying supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_fabric_cordura"},
		{item = "value_fabric_fleece"},
		{item = "value_fabric_ripstop"},
	},
}

ix.progression.itemPools.town_expansion_2f0b6e78417d = {
	name = "Field samples and laboratory containment: Common anomalous specimens (Marsh)",
	tier = "common",
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

ix.progression.itemPools.town_expansion_59c712d7d4fe = {
	name = "Field samples and laboratory containment: Research sample carriers (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_chemcontainer"},
		{item = "value_portable_container_opened"},
	},
}

ix.progression.itemPools.town_expansion_e79ab98b1acd = {
	name = "Field samples and laboratory containment: Research sample carriers (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_portable_container_closed"},
	},
}

ix.progression.itemPools.town_expansion_fef409d4796e = {
	name = "Field samples and laboratory containment: Common electrical artifacts (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "artifact_battery"},
		{item = "artifact_blowncap"},
		{item = "artifact_sparkler"},
	},
}

ix.progression.itemPools.town_expansion_e4f1dcc8ca40 = {
	name = "Field samples and laboratory containment: Research documents (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_documents_11"},
	},
}

ix.progression.itemPools.town_expansion_bb9312c017ca = {
	name = "Field samples and laboratory containment: Rare field artifacts (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "artifact_crystal"},
		{item = "artifact_eye"},
		{item = "artifact_gaia"},
		{item = "artifact_mamasbeads"},
		{item = "artifact_panacea"},
	},
}

ix.progression.itemPools.town_expansion_e7519d375461 = {
	name = "Field samples and laboratory containment: Research sample carriers (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_thermobag"},
	},
}

ix.progression.itemPools.town_expansion_eed76cf208ae = {
	name = "Field samples and laboratory containment: Filters and flow-control fittings (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_labyrinth_valve"},
	},
}

ix.progression.itemPools.town_expansion_12b8f67992a1 = {
	name = "Field samples and laboratory containment: Rare field artifacts (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "artifact_crystal"},
		{item = "artifact_eye"},
		{item = "artifact_gaia"},
		{item = "artifact_mamasbeads"},
		{item = "artifact_panacea"},
	},
}

ix.progression.itemPools.town_expansion_4fde50b2ea01 = {
	name = "Field samples and laboratory containment: Exceptional field artifacts (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "artifact_arachno"},
		{item = "artifact_flame"},
		{item = "artifact_mica"},
		{item = "artifact_storm"},
	},
}

ix.progression.itemPools.town_expansion_0acc14dfa866 = {
	name = "Field samples and laboratory containment: Research sample carriers (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_event_labyrinth_chem_container"},
	},
}

ix.progression.itemPools.town_expansion_f7313298a439 = {
	name = "Field samples and laboratory containment: Common electrical artifacts (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "artifact_battery"},
		{item = "artifact_blowncap"},
		{item = "artifact_sparkler"},
	},
}

ix.progression.itemPools.town_expansion_983c927640d1 = {
	name = "Field samples and laboratory containment: Research sample carriers (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_event_labyrinth_chem_container"},
	},
}

ix.progression.itemPools.town_expansion_293e6c43ac71 = {
	name = "Field samples and laboratory containment: Filters and flow-control fittings (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_other_filter"},
	},
}

ix.progression.itemPools.town_expansion_dc4e5278ad7b = {
	name = "Field samples and laboratory containment: Common electrical artifacts (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "artifact_battery"},
		{item = "artifact_blowncap"},
		{item = "artifact_sparkler"},
	},
}

ix.progression.itemPools.town_expansion_3c54dfc0a0bc = {
	name = "Field samples and laboratory containment: Recovered biological and chemical samples (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_med_bloodsample"},
	},
}

ix.progression.itemPools.town_expansion_95306e3a7624 = {
	name = "Field samples and laboratory containment: Research documents (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_documents_11"},
	},
}

ix.progression.itemPools.town_expansion_fc138e40849a = {
	name = "Field samples and laboratory containment: Recovered biological and chemical samples (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_anomaly_plant"},
	},
}

ix.progression.itemPools.town_expansion_c1b2fc0c25e2 = {
	name = "Field samples and laboratory containment: Research documents (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_documents_11"},
	},
}

ix.progression.itemPools.town_expansion_5f620bc089f7 = {
	name = "Ordnance and protective equipment: Recovered ordnance stock (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_balloon_poison_gas"},
		{item = "value_flammable_trotil"},
	},
}

ix.progression.itemPools.town_expansion_1f9d8bab9a75 = {
	name = "Ordnance and protective equipment: Recovered armour inserts (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_ballistic11"},
		{item = "value_ballistic4"},
	},
}

ix.progression.itemPools.town_expansion_790b007656b6 = {
	name = "Ordnance and protective equipment: Recovered ordnance stock (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_balloon_poison_gas"},
		{item = "value_flammable_trotil"},
	},
}

ix.progression.itemPools.town_expansion_bd81cfe55ca1 = {
	name = "Ordnance and protective equipment: Recovered armour inserts (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_ballistic11"},
		{item = "value_ballistic6"},
	},
}

ix.progression.itemPools.town_expansion_df37ded8c685 = {
	name = "Ordnance and protective equipment: Recovered ordnance stock (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_c4"},
		{item = "value_flammable_thermite"},
	},
}

ix.progression.itemPools.town_expansion_890ed75f7176 = {
	name = "Ordnance and protective equipment: Recovered ordnance stock (Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_c4"},
		{item = "value_flammable_thermite"},
	},
}

ix.progression.itemPools.town_expansion_c0bc28545056 = {
	name = "Ordnance and protective equipment: Military and armament transit cases (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_container_weaponcase"},
	},
}

ix.progression.itemPools.town_expansion_5d857668f5c5 = {
	name = "Ordnance and protective equipment: Secured transit cases (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_safe_container"},
	},
}

ix.progression.itemPools.town_expansion_7d7b39875604 = {
	name = "Ordnance and protective equipment: Recovered ordnance stock (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_c4"},
		{item = "value_flammable_thermite"},
	},
}

ix.progression.itemPools.town_expansion_4ec5cfac4520 = {
	name = "Ordnance and protective equipment: Military and armament transit cases (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_container_weaponcase"},
	},
}

ix.progression.itemPools.town_expansion_4f5c7cc73e80 = {
	name = "Ordnance and protective equipment: Recovered armour inserts (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_ballistic11"},
		{item = "value_ballistic6"},
	},
}

ix.progression.itemPools.town_expansion_903667c30c7a = {
	name = "Ordnance and protective equipment: Secured transit cases (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_safe_container"},
	},
}

ix.progression.itemPools.town_expansion_cf3438a79162 = {
	name = "Ordnance and protective equipment: Recovered armour inserts (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic7"},
	},
}

ix.progression.itemPools.town_expansion_403c750c317a = {
	name = "Ordnance and protective equipment: Secured transit cases (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_safe_container"},
	},
}

ix.progression.itemPools.town_expansion_afa7e8fb8a61 = {
	name = "Ordnance and protective equipment: Recovered ordnance stock (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_explosive_charge"},
	},
}

ix.progression.itemPools.town_expansion_77ca5be069a0 = {
	name = "Ordnance and protective equipment: Military and armament transit cases (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_container_parls"},
	},
}

ix.progression.itemPools.town_expansion_14486da7a41d = {
	name = "Reloading components and ammunition storage: Ammunition propellants (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_gunpowder_green"},
	},
}

ix.progression.itemPools.town_expansion_f85eacc17ffe = {
	name = "Reloading components and ammunition storage: Military and armament transit cases (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
	},
}

ix.progression.itemPools.town_expansion_7f8b02402f29 = {
	name = "Reloading components and ammunition storage: Weapon maintenance supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_gunoil"},
	},
}

ix.progression.itemPools.town_expansion_3cc48f833d47 = {
	name = "Reloading components and ammunition storage: Ammunition propellants (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_gunpowder_red"},
	},
}

ix.progression.itemPools.town_expansion_e03ae53c14f9 = {
	name = "Reloading components and ammunition storage: Weapon maintenance supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_gunoil"},
	},
}

ix.progression.itemPools.town_expansion_5af1c64d6805 = {
	name = "Reloading components and ammunition storage: Ammunition propellants (Marsh, Garbage)",
	tier = "uncommon",
	candidates = {
		{item = "value_gunpowder_red"},
	},
}

ix.progression.itemPools.town_expansion_345e9482a19c = {
	name = "Reloading components and ammunition storage: Military and armament transit cases (Marsh, Garbage)",
	tier = "uncommon",
	candidates = {
		{item = "value_container_ammo"},
	},
}

ix.progression.itemPools.town_expansion_3c9eef7969b7 = {
	name = "Reloading components and ammunition storage: Weapon maintenance supplies (Marsh, Garbage)",
	tier = "uncommon",
	candidates = {
		{item = "value_gunspray"},
	},
}

ix.progression.itemPools.town_expansion_9a1c3a23af99 = {
	name = "Reloading components and ammunition storage: Weapon maintenance supplies (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_gunspray"},
	},
}

ix.progression.itemPools.town_expansion_74c4f70d66c7 = {
	name = "Reloading components and ammunition storage: Ammunition propellants (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_gunpowder_red"},
	},
}

ix.progression.itemPools.town_expansion_fdb6ddf2c7c8 = {
	name = "Reloading components and ammunition storage: Military and armament transit cases (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_container_ammo"},
	},
}

ix.progression.itemPools.town_expansion_06e3662846a9 = {
	name = "Reloading components and ammunition storage: Ammunition propellants (Garbage)",
	tier = "uncommon",
	candidates = {
		{item = "value_gunpowder_green"},
	},
}

ix.progression.itemPools.town_expansion_cf32b67b5763 = {
	name = "Reloading components and ammunition storage: Small equipment pouches and sleeves (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
	},
}

ix.progression.itemPools.town_expansion_dd64d6ff04ac = {
	name = "Reloading components and ammunition storage: Weapon maintenance supplies (Garbage)",
	tier = "uncommon",
	candidates = {
		{item = "value_guncleaner"},
	},
}

ix.progression.itemPools.town_expansion_ebe78cb232b8 = {
	name = "Reloading components and ammunition storage: Screwdrivers and wrenches (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_screwdriver"},
		{item = "value_tools_screwdriver_flat_long"},
	},
}

ix.progression.itemPools.town_expansion_b04346bae92d = {
	name = "Reloading components and ammunition storage: Military and armament transit cases (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_container_weapon_thicc"},
	},
}

ix.progression.itemPools.town_expansion_55404b5c18da = {
	name = "Reloading components and ammunition storage: Small equipment pouches and sleeves (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
	},
}

ix.progression.itemPools.town_expansion_d4935d240567 = {
	name = "Reloading components and ammunition storage: Weapon maintenance supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_gunspray"},
	},
}

ix.progression.itemPools.town_expansion_1d9c2a6cebe2 = {
	name = "Reloading components and ammunition storage: Screwdrivers and wrenches (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_screwdriver"},
		{item = "value_tools_screwdriver_flat_long"},
	},
}

ix.progression.itemPools.town_expansion_0b8f25f6d80e = {
	name = "Reloading components and ammunition storage: Ammunition propellants (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_gunpowder_red"},
	},
}

ix.progression.itemPools.town_expansion_f721acc320b1 = {
	name = "Reloading components and ammunition storage: Ammunition propellants (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_gunpowder_blue"},
	},
}

ix.progression.itemPools.town_expansion_f9b71240e016 = {
	name = "Reloading components and ammunition storage: Screwdrivers and wrenches (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_pipewrench"},
		{item = "value_tools_screwdriver_flat"},
	},
}

ix.progression.itemPools.town_expansion_5f4e0b141b01 = {
	name = "Reloading components and ammunition storage: Military and armament transit cases (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_container_weaponcase"},
	},
}

ix.progression.itemPools.town_expansion_b2bb8a451905 = {
	name = "Reloading components and ammunition storage: Small equipment pouches and sleeves (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_container_cardholder"},
		{item = "value_container_smallitems"},
	},
}

ix.progression.itemPools.town_expansion_480c3fdbad1c = {
	name = "Reloading components and ammunition storage: Weapon maintenance supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_gunspray"},
	},
}

ix.progression.itemPools.town_expansion_e963a40f974b = {
	name = "Historical documents and technical records: Field research notes (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_documents_5"},
	},
}

ix.progression.itemPools.town_expansion_4ca3a06c0c88 = {
	name = "Historical documents and technical records: Technical documents (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_documents_6"},
		{item = "value_documents_7"},
	},
}

ix.progression.itemPools.town_expansion_e6e42a586ebd = {
	name = "Historical documents and technical records: Research documents (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_documents_10"},
	},
}

ix.progression.itemPools.town_expansion_adf78172736d = {
	name = "Historical documents and technical records: Workshop and survival reference books (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_clothbook1"},
		{item = "value_guide"},
	},
}

ix.progression.itemPools.town_expansion_f85ba1658c4c = {
	name = "Historical documents and technical records: Field research notes (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_documents_5"},
	},
}

ix.progression.itemPools.town_expansion_18f9074d4421 = {
	name = "Historical documents and technical records: Research documents (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_documents_10"},
	},
}

ix.progression.itemPools.town_expansion_01c77fe6ad35 = {
	name = "Historical documents and technical records: Workshop and survival reference books (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
	},
}

ix.progression.itemPools.town_expansion_40cd68e349ab = {
	name = "Historical documents and technical records: Workshop and survival reference books (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_manual_lada"},
	},
}

ix.progression.itemPools.town_expansion_51c968d26924 = {
	name = "Historical documents and technical records: Field research notes (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_documents_4"},
	},
}

ix.progression.itemPools.town_expansion_233ece0f22ac = {
	name = "Historical documents and technical records: Technical documents (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_documents_12"},
		{item = "value_documents_7"},
	},
}

ix.progression.itemPools.town_expansion_287ec21107f1 = {
	name = "Historical documents and technical records: Technical documents (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_documents_6"},
	},
}

ix.progression.itemPools.town_expansion_2dafb148e7c9 = {
	name = "Historical documents and technical records: Research documents (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_documents_10"},
	},
}

ix.progression.itemPools.town_expansion_ee30855aef69 = {
	name = "Historical documents and technical records: Technical documents (Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_documents_12"},
	},
}

ix.progression.itemPools.town_expansion_e3c403cc9407 = {
	name = "Historical documents and technical records: Magazines, newspapers and books (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_flyers"},
		{item = "value_info_labrys"},
		{item = "value_note_newspaper_folded_01"},
	},
}

ix.progression.itemPools.town_expansion_ce077e890ab5 = {
	name = "Historical documents and technical records: Research documents (Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_documents_10"},
	},
}

ix.progression.itemPools.town_expansion_8b6d630a63c6 = {
	name = "Historical documents and technical records: Recorders and recovered recordings (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_cassette_fiolet"},
	},
}

ix.progression.itemPools.town_expansion_05e3bd93516f = {
	name = "Historical documents and technical records: Workshop and survival reference books (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
	},
}

ix.progression.itemPools.town_expansion_a8d19c84818b = {
	name = "Historical documents and technical records: Magazines, newspapers and books (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_flyers"},
		{item = "value_info_labrys"},
		{item = "value_note_newspaper_folded_01"},
	},
}

ix.progression.itemPools.town_expansion_ac4d43fe4704 = {
	name = "Historical documents and technical records: Field research notes (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_documents_4"},
	},
}

ix.progression.itemPools.town_expansion_65f83099f4c4 = {
	name = "Historical documents and technical records: Recorders and recovered recordings (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_cassette_black90"},
	},
}

ix.progression.itemPools.town_expansion_613eb467752f = {
	name = "Historical documents and technical records: Technical documents (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_documents_12"},
		{item = "value_documents_6"},
	},
}

ix.progression.itemPools.town_expansion_a9eb0a9115fe = {
	name = "Historical documents and technical records: Research documents (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_documents_10"},
	},
}

ix.progression.itemPools.town_expansion_6d8838d0f3bf = {
	name = "Historical documents and technical records: Workshop and survival reference books (Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_manual_lada"},
	},
}

ix.progression.itemPools.town_expansion_29ca04eb22eb = {
	name = "Historical documents and technical records: Field research notes (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_documents_3"},
	},
}

ix.progression.itemPools.town_expansion_e5cfaf71d572 = {
	name = "Historical documents and technical records: Recorders and recovered recordings (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_cassette_fiolet"},
	},
}

ix.progression.itemPools.town_expansion_221493d7b15f = {
	name = "Storage upkeep and discreet containers: Cleaning and household chemicals (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_bleach"},
		{item = "value_chlorine"},
		{item = "value_draincleaner"},
	},
}

ix.progression.itemPools.town_expansion_a7ec3c9bdcd4 = {
	name = "Storage upkeep and discreet containers: Cleaning and household chemicals (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_bleach"},
		{item = "value_chlorine"},
		{item = "value_draincleaner"},
	},
}

ix.progression.itemPools.town_expansion_7e1f4a0cb741 = {
	name = "Storage upkeep and discreet containers: Cleaning and household chemicals (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_chlorine"},
		{item = "value_draincleaner"},
		{item = "value_glasscleaner"},
	},
}

ix.progression.itemPools.town_expansion_3d49a06eea09 = {
	name = "Storage upkeep and discreet containers: Cleaning and household chemicals (Marsh, Garbage)",
	tier = "uncommon",
	candidates = {
		{item = "value_antiinsect"},
		{item = "value_household_repellent"},
		{item = "value_shampoo"},
	},
}

ix.progression.itemPools.town_expansion_25638ac97f91 = {
	name = "Storage upkeep and discreet containers: Cleaning and household chemicals (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_antiinsect"},
		{item = "value_household_repellent"},
		{item = "value_shampoo"},
	},
}

ix.progression.itemPools.town_expansion_40c144daf329 = {
	name = "Storage upkeep and discreet containers: Secured transit cases (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_safe_container"},
	},
}

ix.progression.itemPools.town_expansion_4e87c268c4ff = {
	name = "Storage upkeep and discreet containers: Cleaning and household chemicals (Garbage)",
	tier = "uncommon",
	candidates = {
		{item = "value_antiinsect"},
		{item = "value_household_repellent"},
		{item = "value_shampoo"},
	},
}

ix.progression.itemPools.town_expansion_179ac8ebe912 = {
	name = "Storage upkeep and discreet containers: General transit cases and consignments (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_pukt90"},
		{item = "value_security_box"},
	},
}

ix.progression.itemPools.town_expansion_ba61520e246c = {
	name = "Storage upkeep and discreet containers: Cleaning and household chemicals (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_antiinsect"},
		{item = "value_household_repellent"},
		{item = "value_shampoo"},
	},
}

ix.progression.itemPools.town_expansion_e01d346b3135 = {
	name = "Storage upkeep and discreet containers: Adhesives, lubricants and repair sheets (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_building_plexiglass"},
		{item = "value_building_poxeram"},
	},
}

ix.progression.itemPools.town_expansion_2199e252fb48 = {
	name = "Storage upkeep and discreet containers: Secured transit cases (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_safe_container"},
	},
}

ix.progression.itemPools.town_expansion_7e6817c3ef2e = {
	name = "Storage upkeep and discreet containers: General transit cases and consignments (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_pukt90"},
		{item = "value_security_box"},
	},
}

ix.progression.itemPools.town_expansion_5ffe9c63cc87 = {
	name = "Storage upkeep and discreet containers: Secured transit cases (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_safe_container"},
	},
}

ix.progression.itemPools.town_expansion_9a544edd6edd = {
	name = "Storage upkeep and discreet containers: General transit cases and consignments (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_small_case"},
	},
}

ix.progression.itemPools.town_expansion_6ab242e44564 = {
	name = "Laboratory containment and research reagents: Common anomalous specimens (Marsh)",
	tier = "common",
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

ix.progression.itemPools.town_expansion_41f7e321426e = {
	name = "Laboratory containment and research reagents: Filters and flow-control fittings (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_other_hosemilitary"},
	},
}

ix.progression.itemPools.town_expansion_c50fe0412bf4 = {
	name = "Laboratory containment and research reagents: Diagnostic and surgical equipment (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_med_thermometer"},
	},
}

ix.progression.itemPools.town_expansion_b42cfd993705 = {
	name = "Laboratory containment and research reagents: Common electrical artifacts (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "artifact_battery"},
		{item = "artifact_blowncap"},
		{item = "artifact_sparkler"},
	},
}

ix.progression.itemPools.town_expansion_651dbe68491b = {
	name = "Laboratory containment and research reagents: Diagnostic and surgical equipment (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_med_thermometer"},
	},
}

ix.progression.itemPools.town_expansion_f23b91a4c88c = {
	name = "Laboratory containment and research reagents: Filters and flow-control fittings (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_airfilter"},
	},
}

ix.progression.itemPools.town_expansion_7a865395e36d = {
	name = "Laboratory containment and research reagents: Diagnostic and surgical equipment (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_med_ophthalmoscope"},
		{item = "value_med_surgicalroll"},
	},
}

ix.progression.itemPools.town_expansion_9580fee61c88 = {
	name = "Laboratory containment and research reagents: Recovered precision instruments (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_gyroscope"},
		{item = "value_gyrotachometer"},
	},
}

ix.progression.itemPools.town_expansion_9e467e82494b = {
	name = "Laboratory containment and research reagents: Rare field artifacts (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "artifact_crystal"},
		{item = "artifact_eye"},
		{item = "artifact_gaia"},
		{item = "artifact_mamasbeads"},
		{item = "artifact_panacea"},
	},
}

ix.progression.itemPools.town_expansion_f2eb34f40bc8 = {
	name = "Laboratory containment and research reagents: Exceptional field artifacts (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "artifact_arachno"},
		{item = "artifact_flame"},
		{item = "artifact_mica"},
		{item = "artifact_storm"},
	},
}

ix.progression.itemPools.town_expansion_8f7eb7df4c4a = {
	name = "Generator parts and camp electrics: Heavy machinery components (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_wire_heavy"},
	},
}

ix.progression.itemPools.town_expansion_2945fb1eda72 = {
	name = "Generator parts and camp electrics: Engine care (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_motorclean"},
	},
}

ix.progression.itemPools.town_expansion_4bfccdaafb2b = {
	name = "Generator parts and camp electrics: Electrical installation supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_lamp_efficient"},
		{item = "value_powercable"},
	},
}

ix.progression.itemPools.town_expansion_d6c5d23e18c2 = {
	name = "Generator parts and camp electrics: Electrical installation supplies (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_helix"},
		{item = "value_magnet"},
	},
}

ix.progression.itemPools.town_expansion_fc74b146585d = {
	name = "Generator parts and camp electrics: Heavy machinery components (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_wire_heavy"},
	},
}

ix.progression.itemPools.town_expansion_788e192251f9 = {
	name = "Generator parts and camp electrics: Engine care (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_motorclean"},
	},
}

ix.progression.itemPools.town_expansion_e16ed7fa1263 = {
	name = "Generator parts and camp electrics: Engine care (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_motorclean"},
	},
}

ix.progression.itemPools.town_expansion_60b912ae02db = {
	name = "Generator parts and camp electrics: Electrical installation supplies (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_helix"},
		{item = "value_lamp_uv"},
		{item = "value_magnet"},
	},
}

ix.progression.itemPools.town_expansion_f50b2e529bc8 = {
	name = "Generator parts and camp electrics: Heavy machinery components (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_wire_heavy"},
	},
}

ix.progression.itemPools.town_expansion_6c9760b93b21 = {
	name = "Generator parts and camp electrics: Wiring and electrical insulation (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_sparkplug"},
	},
}

ix.progression.itemPools.town_expansion_3271fccf8909 = {
	name = "Generator parts and camp electrics: Fuel supplies (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_kerosene"},
	},
}

ix.progression.itemPools.town_expansion_3c5d3a21e4ac = {
	name = "Generator parts and camp electrics: Heavy machinery components (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_wire_heavy"},
	},
}

ix.progression.itemPools.town_expansion_c985d902ec49 = {
	name = "Generator parts and camp electrics: Wiring and electrical insulation (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_sparkplug"},
	},
}

ix.progression.itemPools.town_expansion_f8f7d2716425 = {
	name = "Generator parts and camp electrics: Engine care (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_motorclean"},
	},
}

ix.progression.itemPools.town_expansion_69bc1d002826 = {
	name = "Generator parts and camp electrics: Fuel supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_kerosene"},
	},
}

ix.progression.itemPools.town_expansion_0f35527c9565 = {
	name = "Generator parts and camp electrics: Electrical installation supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_helix"},
		{item = "value_lamp_uv"},
		{item = "value_magnet"},
	},
}

ix.progression.itemPools.town_expansion_82e6ecac5721 = {
	name = "Generator parts and camp electrics: Engine care (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_wd40_100ml"},
	},
}

ix.progression.itemPools.town_expansion_db0030055af8 = {
	name = "Generator parts and camp electrics: Fuel supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_propanetank"},
	},
}

ix.progression.itemPools.town_expansion_0472c56bce94 = {
	name = "Generator parts and camp electrics: Electrical installation supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_kanifol"},
		{item = "value_lamp_uv"},
		{item = "value_usb_adapter"},
	},
}

ix.progression.itemPools.town_expansion_7cff415a04b7 = {
	name = "Generator parts and camp electrics: Wiring and electrical insulation (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_wire_copper"},
	},
}

ix.progression.itemPools.town_expansion_ac72c1e686ce = {
	name = "Generator parts and camp electrics: Heavy machinery components (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_carbattery"},
	},
}

ix.progression.itemPools.town_expansion_056d0b7eb0ef = {
	name = "Resale curios and small valuables: Personal valuables (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_watch"},
	},
}

ix.progression.itemPools.town_expansion_b5741c6c2f68 = {
	name = "Resale curios and small valuables: Decorative and collectible valuables (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_bear_souvenir"},
		{item = "value_skullring"},
	},
}

ix.progression.itemPools.town_expansion_e86e7b663cc7 = {
	name = "Resale curios and small valuables: Decorative statuettes (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_statue_cat"},
	},
}

ix.progression.itemPools.town_expansion_cc3bbd9b289f = {
	name = "Resale curios and small valuables: Decorative statuettes (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_statue_lion"},
	},
}

ix.progression.itemPools.town_expansion_638378a25387 = {
	name = "Resale curios and small valuables: Personal valuables (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_watch"},
	},
}

ix.progression.itemPools.town_expansion_15fff9ec4117 = {
	name = "Resale curios and small valuables: Decorative and collectible valuables (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_antique_vase"},
		{item = "value_skullring"},
	},
}

ix.progression.itemPools.town_expansion_152de158b4a1 = {
	name = "Resale curios and small valuables: Decorative and collectible valuables (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_bear_souvenir"},
		{item = "value_skullring"},
	},
}

ix.progression.itemPools.town_expansion_bdc28c49496b = {
	name = "Resale curios and small valuables: Decorative statuettes (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_statue_lion"},
	},
}

ix.progression.itemPools.town_expansion_f7f42b02f574 = {
	name = "Resale curios and small valuables: Personal valuables (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_watch"},
	},
}

ix.progression.itemPools.town_expansion_b16633a45e5e = {
	name = "Resale curios and small valuables: General transit cases and consignments (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_pukt90"},
		{item = "value_security_box"},
	},
}

ix.progression.itemPools.town_expansion_b87c057c55a9 = {
	name = "Resale curios and small valuables: Personal effects and keepsakes (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_lightkeeper_amulet"},
	},
}

ix.progression.itemPools.town_expansion_2db70b6fbf88 = {
	name = "Resale curios and small valuables: Decorative statuettes (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_statue_lion"},
	},
}

ix.progression.itemPools.town_expansion_9af7d4b50cee = {
	name = "Resale curios and small valuables: General transit cases and consignments (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_pukt90"},
		{item = "value_security_box"},
	},
}

ix.progression.itemPools.town_expansion_d8d65e086eac = {
	name = "Resale curios and small valuables: Personal valuables (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_watch"},
	},
}

ix.progression.itemPools.town_expansion_df5cad80abc3 = {
	name = "Resale curios and small valuables: Personal effects and keepsakes (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_lightkeeper_amulet"},
	},
}

ix.progression.itemPools.town_expansion_cbdcbe001335 = {
	name = "Resale curios and small valuables: Decorative and collectible valuables (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_bear_souvenir"},
		{item = "value_skullring"},
	},
}

ix.progression.itemPools.town_expansion_be2bc316f977 = {
	name = "Resale curios and small valuables: Decorative statuettes (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_statue_horse"},
	},
}

ix.progression.itemPools.town_expansion_ae4f451666e5 = {
	name = "Resale curios and small valuables: Personal effects and keepsakes (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_lightkeeper_amulet"},
	},
}

ix.progression.itemPools.town_expansion_0226ddbdcca9 = {
	name = "Resale curios and small valuables: Personal valuables (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_goldchain"},
	},
}

ix.progression.itemPools.town_expansion_ee70748a5af1 = {
	name = "Resale curios and small valuables: General transit cases and consignments (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_small_case"},
	},
}

ix.progression.itemPools.town_expansion_a9a6a4663f7e = {
	name = "Detector calibration and survey equipment: Common anomalous specimens (Marsh)",
	tier = "common",
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

ix.progression.itemPools.town_expansion_8619904d9216 = {
	name = "Detector calibration and survey equipment: Research sample carriers (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_chemcontainer"},
		{item = "value_portable_container_opened"},
	},
}

ix.progression.itemPools.town_expansion_eb7056313562 = {
	name = "Detector calibration and survey equipment: Research sample carriers (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_portable_container_closed"},
	},
}

ix.progression.itemPools.town_expansion_6af4f494aa60 = {
	name = "Detector calibration and survey equipment: Common electrical artifacts (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "artifact_battery"},
		{item = "artifact_blowncap"},
		{item = "artifact_sparkler"},
	},
}

ix.progression.itemPools.town_expansion_96f10f2d5514 = {
	name = "Detector calibration and survey equipment: Field instrument hardware (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_pcpart_lcd"},
	},
}

ix.progression.itemPools.town_expansion_7056d335ecb3 = {
	name = "Detector calibration and survey equipment: Research sample carriers (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_chemcontainer"},
		{item = "value_portable_container_closed"},
	},
}

ix.progression.itemPools.town_expansion_e010d2b94975 = {
	name = "Detector calibration and survey equipment: Research sample carriers (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_thermobag"},
	},
}

ix.progression.itemPools.town_expansion_52c92cccdf1a = {
	name = "Detector calibration and survey equipment: Portable power (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_battery_d_0"},
	},
}

ix.progression.itemPools.town_expansion_9ee1d71f61fc = {
	name = "Detector calibration and survey equipment: Rare field artifacts (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "artifact_crystal"},
		{item = "artifact_eye"},
		{item = "artifact_gaia"},
		{item = "artifact_mamasbeads"},
		{item = "artifact_panacea"},
	},
}

ix.progression.itemPools.town_expansion_eb5fb8c496fa = {
	name = "Detector calibration and survey equipment: Exceptional field artifacts (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "artifact_arachno"},
		{item = "artifact_flame"},
		{item = "artifact_mica"},
		{item = "artifact_storm"},
	},
}

ix.progression.itemPools.town_expansion_962885d7508c = {
	name = "Clinical supplies and trauma equipment: Clinical fluids and pharmacy stock (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_med_peroxide"},
		{item = "value_med_petroleumjelly"},
	},
}

ix.progression.itemPools.town_expansion_de0cff16cfce = {
	name = "Clinical supplies and trauma equipment: Trauma and injection supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_med_haemostatic"},
		{item = "value_med_tourniquet"},
	},
}

ix.progression.itemPools.town_expansion_0ca50f35fc0e = {
	name = "Clinical supplies and trauma equipment: Diagnostic and surgical equipment (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_med_thermometer"},
	},
}

ix.progression.itemPools.town_expansion_446d408327d4 = {
	name = "Clinical supplies and trauma equipment: Diagnostic and surgical equipment (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_med_thermometer"},
	},
}

ix.progression.itemPools.town_expansion_e46ae3b497e2 = {
	name = "Clinical supplies and trauma equipment: Clinical fluids and pharmacy stock (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_med_peroxide"},
		{item = "value_med_vitamins"},
	},
}

ix.progression.itemPools.town_expansion_a8839d46d4a7 = {
	name = "Clinical supplies and trauma equipment: Trauma and injection supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_med_splint"},
		{item = "value_med_tourniquet_rubber"},
	},
}

ix.progression.itemPools.town_expansion_1142bd85f8b2 = {
	name = "Clinical supplies and trauma equipment: Recovered biological and chemical samples (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_plasticbag_labyrinth"},
	},
}

ix.progression.itemPools.town_expansion_289668a08834 = {
	name = "Clinical supplies and trauma equipment: Trauma and injection supplies (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_med_bloodset"},
		{item = "value_med_tourniquet"},
	},
}

ix.progression.itemPools.town_expansion_bc7c8bfcd339 = {
	name = "Clinical supplies and trauma equipment: Diagnostic and surgical equipment (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_med_ophthalmoscope"},
		{item = "value_med_surgicalroll"},
	},
}

ix.progression.itemPools.town_expansion_ec1b39b339b7 = {
	name = "Clinical supplies and trauma equipment: Filters and flow-control fittings (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_labyrinth_valve"},
	},
}

ix.progression.itemPools.town_expansion_0d3bdbaa7ef5 = {
	name = "Clinical supplies and trauma equipment: Trauma and injection supplies (Marsh)",
	tier = "rare",
	candidates = {
		{item = "value_med_splint"},
		{item = "value_med_tourniquet_rubber"},
	},
}

ix.progression.itemPools.town_expansion_4bb728ab4863 = {
	name = "Clinical supplies and trauma equipment: Filters and flow-control fittings (Marsh)",
	tier = "rare",
	candidates = {
		{item = "value_labyrinth_valve"},
	},
}

ix.progression.itemPools.town_expansion_a7f4b85ac065 = {
	name = "Clinical supplies and trauma equipment: Diagnostic and surgical equipment (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_med_surgicalpouch"},
		{item = "value_med_surgicaltools"},
	},
}

ix.progression.itemPools.town_expansion_8d28eb67c781 = {
	name = "Clinical supplies and trauma equipment: Clinical fluids and pharmacy stock (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_med_peroxide"},
		{item = "value_med_vitamins"},
	},
}

ix.progression.itemPools.town_expansion_fa2daf5d82a7 = {
	name = "Clinical supplies and trauma equipment: Trauma and injection supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_med_bloodset"},
		{item = "value_med_tourniquet"},
	},
}

ix.progression.itemPools.town_expansion_fb3f5bd7e145 = {
	name = "Clinical supplies and trauma equipment: Recovered biological and chemical samples (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_med_bloodsample"},
	},
}

ix.progression.itemPools.town_expansion_8651e97c74b0 = {
	name = "Clinical supplies and trauma equipment: Diagnostic and surgical equipment (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_med_surgicalpouch_worn"},
		{item = "value_med_surgicaltools"},
	},
}

ix.progression.itemPools.town_expansion_7ef092e6cfc5 = {
	name = "Clinical supplies and trauma equipment: Filters and flow-control fittings (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_other_filter"},
	},
}

ix.progression.itemPools.town_expansion_4a896182c775 = {
	name = "Clinical supplies and trauma equipment: Clinical fluids and pharmacy stock (Marsh)",
	tier = "rare",
	candidates = {
		{item = "value_med_aquatabs"},
		{item = "value_med_ibuprofen"},
	},
}

ix.progression.itemPools.town_expansion_41f538caa035 = {
	name = "Workshop tools and fabrication materials: Cutting and gripping tools (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_pliers"},
		{item = "value_tools_metalscissors"},
	},
}

ix.progression.itemPools.town_expansion_e18f75122fe4 = {
	name = "Workshop tools and fabrication materials: Adhesives, lubricants and repair sheets (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_expandingfoam"},
		{item = "value_plexiglass"},
	},
}

ix.progression.itemPools.town_expansion_1471bc11fe57 = {
	name = "Workshop tools and fabrication materials: Workshop tools and tool sets (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_hultafors_db5000"},
		{item = "value_mining_kit"},
		{item = "value_tapemeasure"},
	},
}

ix.progression.itemPools.town_expansion_212709036b69 = {
	name = "Workshop tools and fabrication materials: Workshop tools and tool sets (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_hultafors_db5000"},
		{item = "value_mining_kit"},
		{item = "value_tapemeasure"},
	},
}

ix.progression.itemPools.town_expansion_a21ee578ab49 = {
	name = "Workshop tools and fabrication materials: Cutting and gripping tools (Marsh, Garbage)",
	tier = "uncommon",
	candidates = {
		{item = "value_pliers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_2495e76a77c6 = {
	name = "Workshop tools and fabrication materials: Cutting and gripping tools (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_pliers"},
		{item = "value_tools_metalscissors"},
	},
}

ix.progression.itemPools.town_expansion_9cfb06e3c81a = {
	name = "Workshop tools and fabrication materials: Adhesives, lubricants and repair sheets (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_building_kektape"},
		{item = "value_wd40_400ml"},
	},
}

ix.progression.itemPools.town_expansion_c0cc6dee0372 = {
	name = "Workshop tools and fabrication materials: Adhesives, lubricants and repair sheets (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_expandingfoam"},
		{item = "value_plexiglass"},
	},
}

ix.progression.itemPools.town_expansion_797ca99a5240 = {
	name = "Workshop tools and fabrication materials: Workshop tools and tool sets (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_hultafors_db5000"},
		{item = "value_key_labyrinth_torch"},
		{item = "value_multitul_0"},
	},
}

ix.progression.itemPools.town_expansion_30019582aa26 = {
	name = "Workshop tools and fabrication materials: Cutting and gripping tools (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_pliers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_c6e6ecaa4152 = {
	name = "Workshop tools and fabrication materials: Adhesives, lubricants and repair sheets (Garbage)",
	tier = "uncommon",
	candidates = {
		{item = "value_building_kektape"},
		{item = "value_wd40_400ml"},
	},
}

ix.progression.itemPools.town_expansion_5e784bdc0b14 = {
	name = "Workshop tools and fabrication materials: Protective textile rolls and linings (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_retardant10"},
		{item = "value_retardant11"},
		{item = "value_retardant12"},
	},
}

ix.progression.itemPools.town_expansion_ef58c520937a = {
	name = "Workshop tools and fabrication materials: Workshop tools and tool sets (Garbage)",
	tier = "uncommon",
	candidates = {
		{item = "value_hultafors_db5000"},
		{item = "value_key_labyrinth_torch"},
		{item = "value_multitul_0"},
	},
}

ix.progression.itemPools.town_expansion_c2679bfc6052 = {
	name = "Workshop tools and fabrication materials: Recovered armour inserts (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic7"},
	},
}

ix.progression.itemPools.town_expansion_25cf944befdf = {
	name = "Workshop tools and fabrication materials: Cutting and gripping tools (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_pliers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_5c4d31f42806 = {
	name = "Workshop tools and fabrication materials: Protective textile rolls and linings (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_retardant10"},
		{item = "value_retardant11"},
		{item = "value_retardant12"},
	},
}

ix.progression.itemPools.town_expansion_f48d14c96131 = {
	name = "Workshop tools and fabrication materials: Adhesives, lubricants and repair sheets (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_building_kektape"},
		{item = "value_wd40_400ml"},
	},
}

ix.progression.itemPools.town_expansion_a015f4f15fdf = {
	name = "Workshop tools and fabrication materials: Recovered armour inserts (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic7"},
	},
}

ix.progression.itemPools.town_expansion_36d5d4605fb5 = {
	name = "Workshop tools and fabrication materials: Workshop tools and tool sets (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_hultafors_db5000"},
		{item = "value_key_labyrinth_torch"},
		{item = "value_multitul_0"},
	},
}

ix.progression.itemPools.town_expansion_c3f25b91c64e = {
	name = "Workshop tools and fabrication materials: Workshop tools and tool sets (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_crowbar"},
		{item = "value_electricdrill"},
		{item = "value_toolset"},
	},
}

ix.progression.itemPools.town_expansion_c5ff89355dd8 = {
	name = "Workshop tools and fabrication materials: Recovered armour inserts (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic3"},
	},
}

ix.progression.itemPools.town_expansion_e5b62323f846 = {
	name = "Workshop tools and fabrication materials: Cutting and gripping tools (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_swiss"},
		{item = "value_tools_nippers"},
	},
}

ix.progression.itemPools.town_expansion_d34115d4d8cf = {
	name = "Workshop tools and fabrication materials: Protective textile rolls and linings (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_retardant12"},
		{item = "value_retardant2"},
		{item = "value_retardant6"},
	},
}

ix.progression.itemPools.town_expansion_60ff2d834302 = {
	name = "Consignment paperwork and secure dispatches: Office stationery and shipping records (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_officepaper"},
	},
}

ix.progression.itemPools.town_expansion_f70bc0a9392c = {
	name = "Consignment paperwork and secure dispatches: Administrative records (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_documents_1"},
	},
}

ix.progression.itemPools.town_expansion_8c732b3806f5 = {
	name = "Consignment paperwork and secure dispatches: Secured transit cases (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_safe_container"},
	},
}

ix.progression.itemPools.town_expansion_3fe753055c23 = {
	name = "Consignment paperwork and secure dispatches: Office stationery and shipping records (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_note_folder_closed_cardboard"},
		{item = "value_notepad_a6_closed_01"},
	},
}

ix.progression.itemPools.town_expansion_4ea89303af2d = {
	name = "Consignment paperwork and secure dispatches: Secured transit cases (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_safe_container"},
	},
}

ix.progression.itemPools.town_expansion_6d8810642590 = {
	name = "Consignment paperwork and secure dispatches: Office stationery and shipping records (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_notepad_a5_closed_01"},
		{item = "value_notepad_a6_closed_01"},
	},
}

ix.progression.itemPools.town_expansion_0be7e6713fc9 = {
	name = "Consignment paperwork and secure dispatches: Administrative records (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_documents_1"},
	},
}

ix.progression.itemPools.town_expansion_dfefeedcc8d8 = {
	name = "Consignment paperwork and secure dispatches: Office stationery and shipping records (Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_officepaper"},
	},
}

ix.progression.itemPools.town_expansion_59f84bf18165 = {
	name = "Consignment paperwork and secure dispatches: General transit cases and consignments (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_pukt90"},
		{item = "value_security_box"},
	},
}

ix.progression.itemPools.town_expansion_ede8fdcabd61 = {
	name = "Consignment paperwork and secure dispatches: Administrative records (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_documents_1"},
	},
}

ix.progression.itemPools.town_expansion_32fcf2360a1f = {
	name = "Consignment paperwork and secure dispatches: Maps and personal field journals (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_milimap"},
		{item = "value_thick_diary"},
	},
}

ix.progression.itemPools.town_expansion_8bdebb3d10cc = {
	name = "Consignment paperwork and secure dispatches: Office stationery and shipping records (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_notepad_a5_closed_01"},
		{item = "value_notepad_a6_closed_01"},
	},
}

ix.progression.itemPools.town_expansion_a67473cd9b4d = {
	name = "Consignment paperwork and secure dispatches: General transit cases and consignments (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_pukt90"},
		{item = "value_security_box"},
	},
}

ix.progression.itemPools.town_expansion_eb9dc70d7065 = {
	name = "Consignment paperwork and secure dispatches: Administrative records (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_documents_2"},
	},
}

ix.progression.itemPools.town_expansion_652c6332fff4 = {
	name = "Consignment paperwork and secure dispatches: General transit cases and consignments (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_small_case"},
	},
}

ix.progression.itemPools.town_expansion_799fd6d1e148 = {
	name = "Radio infrastructure and network components: Recovered radio and signalling equipment (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_receiver1"},
	},
}

ix.progression.itemPools.town_expansion_d55bb0def78c = {
	name = "Radio infrastructure and network components: Common electrical components (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_wire_copper"},
	},
}

ix.progression.itemPools.town_expansion_a36be0defe80 = {
	name = "Radio infrastructure and network components: Recovered radio and signalling equipment (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_ir_ms2000"},
	},
}

ix.progression.itemPools.town_expansion_21e05a8284d2 = {
	name = "Radio infrastructure and network components: Recovered radio and signalling equipment (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_ais_sart"},
		{item = "value_radio"},
	},
}

ix.progression.itemPools.town_expansion_96fde52e6417 = {
	name = "Trail repairs and camp supplies: Field repair supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_tape_electric"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_6b5733897b29 = {
	name = "Trail repairs and camp supplies: Fuel and firelighting supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_dryfuel"},
		{item = "value_flammable_survlighter"},
		{item = "value_kerosene_container"},
	},
}

ix.progression.itemPools.town_expansion_ce24dc6d189d = {
	name = "Trail repairs and camp supplies: Field repair supplies (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_gunoil"},
		{item = "value_tape_electric"},
	},
}

ix.progression.itemPools.town_expansion_6813639449a8 = {
	name = "Trail repairs and camp supplies: Fuel and firelighting supplies (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_kerosene_container"},
		{item = "value_valuable_kresalo"},
		{item = "value_zibbo_0"},
	},
}

ix.progression.itemPools.town_expansion_7083f2343a35 = {
	name = "Trail repairs and camp supplies: Field repair supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_paracord"},
	},
}

ix.progression.itemPools.town_expansion_6e40697c9e77 = {
	name = "Trail repairs and camp supplies: Fabric, sewing and carrying supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_fabric_cordura"},
		{item = "value_fabric_fleece"},
		{item = "value_fabric_ripstop"},
	},
}

ix.progression.itemPools.town_expansion_d407699aaaf9 = {
	name = "Trail repairs and camp supplies: Fuel and firelighting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_crikent_0"},
		{item = "value_gascan"},
	},
}

ix.progression.itemPools.town_expansion_e9b2a442661b = {
	name = "Trail repairs and camp supplies: Cutting and gripping tools (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_awl"},
		{item = "value_swiss"},
	},
}

ix.progression.itemPools.town_expansion_339180d0d2ac = {
	name = "Trail repairs and camp supplies: Field repair supplies (Marsh)",
	tier = "rare",
	candidates = {
		{item = "value_paracord"},
	},
}

ix.progression.itemPools.town_expansion_404eec920105 = {
	name = "Trail repairs and camp supplies: Fabric, sewing and carrying supplies (Marsh)",
	tier = "rare",
	candidates = {
		{item = "value_fabric_cordura"},
		{item = "value_fabric_fleece"},
		{item = "value_fabric_ripstop"},
	},
}

ix.progression.itemPools.town_expansion_41e00477b4e5 = {
	name = "Field issue kits and military packing: Protective textile rolls and linings (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_retardant3"},
		{item = "value_retardant4"},
		{item = "value_retardant9"},
	},
}

ix.progression.itemPools.town_expansion_10c474c21e20 = {
	name = "Field issue kits and military packing: Protective textile rolls and linings (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_retardant3"},
		{item = "value_retardant4"},
		{item = "value_retardant9"},
	},
}

ix.progression.itemPools.town_expansion_a3c072e455ad = {
	name = "Field issue kits and military packing: Military and armament transit cases (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
	},
}

ix.progression.itemPools.town_expansion_463c5c67dde4 = {
	name = "Field issue kits and military packing: Small equipment pouches and sleeves (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
	},
}

ix.progression.itemPools.town_expansion_92ac3f54b2b1 = {
	name = "Field issue kits and military packing: Protective textile rolls and linings (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_retardant10"},
		{item = "value_retardant11"},
	},
}

ix.progression.itemPools.town_expansion_50ea2160bbed = {
	name = "Field issue kits and military packing: Military and armament transit cases (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_container_ammo"},
	},
}

ix.progression.itemPools.town_expansion_7087504fe790 = {
	name = "Field issue kits and military packing: Military and armament transit cases (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
	},
}

ix.progression.itemPools.town_expansion_81a46c42fa94 = {
	name = "Field issue kits and military packing: Small equipment pouches and sleeves (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_docbag"},
	},
}

ix.progression.itemPools.town_expansion_5b1ac2e506f4 = {
	name = "Field issue kits and military packing: Military and armament transit cases (Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_container_ammo"},
	},
}

ix.progression.itemPools.town_expansion_962502868086 = {
	name = "Field issue kits and military packing: Recovered armour inserts (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic7"},
	},
}

ix.progression.itemPools.town_expansion_476ccec31a60 = {
	name = "Field issue kits and military packing: Protective textile rolls and linings (Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_retardant1"},
		{item = "value_retardant10"},
		{item = "value_retardant9"},
	},
}

ix.progression.itemPools.town_expansion_f40192100445 = {
	name = "Field issue kits and military packing: Administrative records (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_documents_2"},
	},
}

ix.progression.itemPools.town_expansion_067f2ff858b4 = {
	name = "Field issue kits and military packing: Protective textile rolls and linings (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_retardant10"},
		{item = "value_retardant11"},
	},
}

ix.progression.itemPools.town_expansion_5e7755153dea = {
	name = "Field issue kits and military packing: Recovered armour inserts (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic7"},
	},
}

ix.progression.itemPools.town_expansion_c494fa44da6f = {
	name = "Field issue kits and military packing: Military and armament transit cases (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_container_weapon_thicc"},
	},
}

ix.progression.itemPools.town_expansion_58b845df3a69 = {
	name = "Field issue kits and military packing: Administrative records (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_documents_2"},
	},
}

ix.progression.itemPools.town_expansion_80a92a643d83 = {
	name = "Field issue kits and military packing: Small equipment pouches and sleeves (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_docbag"},
	},
}

ix.progression.itemPools.town_expansion_0a4fdf872aca = {
	name = "Field issue kits and military packing: Protective textile rolls and linings (Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_retardant10"},
		{item = "value_retardant11"},
	},
}

ix.progression.itemPools.town_expansion_71529337098d = {
	name = "Field issue kits and military packing: Military and armament transit cases (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_container_weaponcase"},
	},
}

ix.progression.itemPools.town_expansion_6700ef70fe69 = {
	name = "Field issue kits and military packing: Administrative records (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_documents_2"},
	},
}

ix.progression.itemPools.town_expansion_098b8203558b = {
	name = "Field issue kits and military packing: Small equipment pouches and sleeves (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
	},
}

ix.progression.itemPools.town_expansion_e2d8cb597d6e = {
	name = "Field issue kits and military packing: Recovered armour inserts (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic3"},
	},
}

ix.progression.itemPools.town_expansion_24a8e4e72abc = {
	name = "Computer hardware and data media: Common electrical components (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_2f4f2e976cab = {
	name = "Computer hardware and data media: Common electrical components (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_capacitors"},
	},
}

ix.progression.itemPools.town_expansion_42f407abc18a = {
	name = "Computer hardware and data media: Common electrical components (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_ee6797fbcfef = {
	name = "Computer hardware and data media: Common electrical components (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_capacitors"},
	},
}

ix.progression.itemPools.town_expansion_7506c43b0a0c = {
	name = "Computer hardware and data media: Common electrical components (Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_capacitors"},
	},
}

ix.progression.itemPools.town_expansion_acd5ff8fdb88 = {
	name = "Computer hardware and data media: Workshop and survival reference books (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_clothbook2"},
		{item = "value_manual_lada"},
	},
}

ix.progression.itemPools.town_expansion_9cbace0a2778 = {
	name = "Computer hardware and data media: Recovered flash drives (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_flash_card_slider"},
	},
}

ix.progression.itemPools.town_expansion_ac5afb9a51ec = {
	name = "Computer hardware and data media: Workshop and survival reference books (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_clothbook2"},
		{item = "value_manual_lada"},
	},
}

ix.progression.itemPools.town_expansion_632a89229735 = {
	name = "Computer hardware and data media: Common electrical components (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_capacitors"},
	},
}

ix.progression.itemPools.town_expansion_3dd39b851016 = {
	name = "Computer hardware and data media: Boards, displays and electronic components (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_lcddirty"},
		{item = "value_textolite"},
	},
}

ix.progression.itemPools.town_expansion_1059b60105b8 = {
	name = "Computer hardware and data media: Computer components and storage drives (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_pcpart_discdrive"},
		{item = "value_pcpart_ram"},
	},
}

ix.progression.itemPools.town_expansion_040731918dd5 = {
	name = "Computer hardware and data media: Recovered portable computers (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_pda3"},
	},
}

ix.progression.itemPools.town_expansion_2fca8d096e56 = {
	name = "Computer hardware and data media: Control and interface electronics (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_controller"},
		{item = "value_electr_adv_controller"},
	},
}

ix.progression.itemPools.town_expansion_a86d9c791015 = {
	name = "Computer hardware and data media: Common electrical components (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_wire_copper"},
	},
}

ix.progression.itemPools.town_expansion_b748a2804bf3 = {
	name = "Computer hardware and data media: Boards, displays and electronic components (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_militaryboard"},
		{item = "value_sz_1"},
	},
}

ix.progression.itemPools.town_expansion_a078cf2f4ea8 = {
	name = "Computer hardware and data media: Computer components and storage drives (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_electr_hdd_quest"},
		{item = "value_pcpart_cpu"},
	},
}

ix.progression.itemPools.town_expansion_235965473ee1 = {
	name = "Computer hardware and data media: Workshop and survival reference books (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_handbook_materials"},
		{item = "value_manual_lada"},
	},
}

ix.progression.itemPools.town_expansion_906e9e62e58d = {
	name = "Computer hardware and data media: Control and interface electronics (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_electr_adv_controller"},
		{item = "value_electr_countermeasure"},
	},
}

ix.progression.itemPools.town_expansion_53138dbbce3c = {
	name = "Kitchen stores and cooking fuel: Packaged dry provisions (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_coffee"},
		{item = "value_other_lupo"},
	},
}

ix.progression.itemPools.town_expansion_6ce8f38e0bf1 = {
	name = "Kitchen stores and cooking fuel: Fuel supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_kerosene"},
	},
}

ix.progression.itemPools.town_expansion_ad8a38d74ac4 = {
	name = "Kitchen stores and cooking fuel: Fuel supplies (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_kerosene"},
	},
}

ix.progression.itemPools.town_expansion_c93f929960fd = {
	name = "Kitchen stores and cooking fuel: Packaged dry provisions (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_coffee"},
		{item = "value_other_grechka"},
	},
}

ix.progression.itemPools.town_expansion_74c1a96ad32a = {
	name = "Kitchen stores and cooking fuel: Fuel supplies (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_gasoline"},
	},
}

ix.progression.itemPools.town_expansion_504bedd659bc = {
	name = "Kitchen stores and cooking fuel: Packaged dry provisions (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_coffee"},
		{item = "value_other_grechka"},
	},
}

ix.progression.itemPools.town_expansion_7957e159e3ce = {
	name = "Kitchen stores and cooking fuel: Fuel and firelighting supplies (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_flammable_huntermatches"},
		{item = "value_flammable_klean"},
		{item = "value_gascan"},
	},
}

ix.progression.itemPools.town_expansion_b13ea47418ea = {
	name = "Kitchen stores and cooking fuel: Household cleaning supplies (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_toiletpaper"},
		{item = "value_toothpaste"},
	},
}

ix.progression.itemPools.town_expansion_b7713ce2aa55 = {
	name = "Kitchen stores and cooking fuel: Packaged dry provisions (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_coffee"},
		{item = "value_other_grechka"},
	},
}

ix.progression.itemPools.town_expansion_3e9f1370e922 = {
	name = "Kitchen stores and cooking fuel: Fuel and firelighting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_flammable_huntermatches"},
		{item = "value_flammable_klean"},
		{item = "value_gascan"},
	},
}

ix.progression.itemPools.town_expansion_71271652e722 = {
	name = "Kitchen stores and cooking fuel: Fuel supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_gasoline"},
	},
}

ix.progression.itemPools.town_expansion_c279546a695f = {
	name = "Kitchen stores and cooking fuel: Household cleaning supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_soap"},
		{item = "value_toiletpaper"},
	},
}

ix.progression.itemPools.town_expansion_89ebb7471428 = {
	name = "Kitchen stores and cooking fuel: Fuel supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_propanetank"},
	},
}

ix.progression.itemPools.town_expansion_3b10ddedc65b = {
	name = "Kitchen stores and cooking fuel: Household cleaning supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_household_toothpaste1"},
		{item = "value_toothpaste"},
	},
}

ix.progression.itemPools.town_expansion_4eccdfd3dca1 = {
	name = "Kitchen stores and cooking fuel: Packaged dry provisions (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_sugar"},
	},
}

ix.progression.itemPools.town_expansion_d658a702f753 = {
	name = "Kitchen stores and cooking fuel: Fuel and firelighting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_crikent_0"},
		{item = "value_match"},
		{item = "value_matches"},
	},
}

ix.progression.itemPools.town_expansion_9efea0eef6c6 = {
	name = "Receivers, communications parts and recordings: Scientific radio modules (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_frequencymodulator"},
	},
}

ix.progression.itemPools.town_expansion_db9a2caaa58c = {
	name = "Receivers, communications parts and recordings: Communications salvage (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_wirelesstrans"},
	},
}

ix.progression.itemPools.town_expansion_d437c0469824 = {
	name = "Receivers, communications parts and recordings: Communications salvage (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_phone_old"},
	},
}

ix.progression.itemPools.town_expansion_530dff3d628b = {
	name = "Receivers, communications parts and recordings: Scientific radio modules (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_monitoringunit"},
	},
}

ix.progression.itemPools.town_expansion_0cce463eebee = {
	name = "Receivers, communications parts and recordings: Electrical installation supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_kanifol"},
		{item = "value_lamp_uv"},
		{item = "value_usb_adapter"},
	},
}

ix.progression.itemPools.town_expansion_7914e6c50148 = {
	name = "Receivers, communications parts and recordings: Scientific radio modules (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_frequencymodulator"},
	},
}

ix.progression.itemPools.town_expansion_20f057c98d77 = {
	name = "Receivers, communications parts and recordings: Recorders and recovered recordings (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_archive_cassette"},
	},
}

ix.progression.itemPools.town_expansion_8bf779b73bc7 = {
	name = "Receivers, communications parts and recordings: Recovered battery assemblies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_energy_accum"},
		{item = "value_energy_greenbat"},
	},
}

ix.progression.itemPools.town_expansion_ef8a7d1f4def = {
	name = "Receivers, communications parts and recordings: Communications salvage (Garbage)",
	tier = "uncommon",
	candidates = {
		{item = "value_phone_old"},
	},
}

ix.progression.itemPools.town_expansion_ba0835726338 = {
	name = "Receivers, communications parts and recordings: Scientific radio modules (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_calculationunit"},
	},
}

ix.progression.itemPools.town_expansion_666ff7869369 = {
	name = "Receivers, communications parts and recordings: Recovered battery assemblies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_energy_greenbat"},
		{item = "value_militarybattery"},
	},
}

ix.progression.itemPools.town_expansion_35961f2d890a = {
	name = "Receivers, communications parts and recordings: Scientific radio modules (Garbage)",
	tier = "uncommon",
	candidates = {
		{item = "value_calculationunit"},
	},
}

ix.progression.itemPools.town_expansion_6e035a7a3694 = {
	name = "Receivers, communications parts and recordings: Recorders and recovered recordings (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_cassette_black90"},
	},
}

ix.progression.itemPools.town_expansion_499861fb2c79 = {
	name = "Receivers, communications parts and recordings: Electrical installation supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_electr_tplug"},
		{item = "value_powerfilter"},
		{item = "value_usb_adapter"},
	},
}

ix.progression.itemPools.town_expansion_a190d6ad9305 = {
	name = "Receivers, communications parts and recordings: Recorders and recovered recordings (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_cassette_black90"},
	},
}

ix.progression.itemPools.town_expansion_630c76282136 = {
	name = "Receivers, communications parts and recordings: Scientific radio modules (Marsh, Garbage)",
	tier = "uncommon",
	candidates = {
		{item = "value_calculationunit"},
	},
}

ix.progression.itemPools.town_expansion_8fc53c13e31b = {
	name = "Receivers, communications parts and recordings: Recorders and recovered recordings (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_cassette_black90"},
	},
}

ix.progression.itemPools.town_expansion_5969fddbb2ec = {
	name = "Hunting equipment care and field observations: Weapon maintenance supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_gunoil"},
	},
}

ix.progression.itemPools.town_expansion_8eca1366600b = {
	name = "Hunting equipment care and field observations: Maps and personal field journals (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_info_moleskine"},
		{item = "value_maps"},
	},
}

ix.progression.itemPools.town_expansion_c724ce18a083 = {
	name = "Hunting equipment care and field observations: Weapon maintenance supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_gunoil"},
	},
}

ix.progression.itemPools.town_expansion_a58336d646ec = {
	name = "Hunting equipment care and field observations: Maps and personal field journals (Marsh, Garbage)",
	tier = "uncommon",
	candidates = {
		{item = "value_maps"},
		{item = "value_thick_diary"},
	},
}

ix.progression.itemPools.town_expansion_050652679f9e = {
	name = "Hunting equipment care and field observations: Weapon maintenance supplies (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_gunspray"},
	},
}

ix.progression.itemPools.town_expansion_b1cead5a9f71 = {
	name = "Hunting equipment care and field observations: Maps and personal field journals (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_maps"},
		{item = "value_thick_diary"},
	},
}

ix.progression.itemPools.town_expansion_d1ec24e83ba7 = {
	name = "Hunting equipment care and field observations: Weapon maintenance supplies (Garbage)",
	tier = "uncommon",
	candidates = {
		{item = "value_guncleaner"},
	},
}

ix.progression.itemPools.town_expansion_46a6739fbe52 = {
	name = "Hunting equipment care and field observations: Recovered precision instruments (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_electro_gyroscope"},
		{item = "value_optical_lens"},
	},
}

ix.progression.itemPools.town_expansion_fb1034610700 = {
	name = "Hunting equipment care and field observations: Cutting and gripping tools (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_swiss"},
		{item = "value_tools_nippers"},
	},
}

ix.progression.itemPools.town_expansion_2c143c0d71d7 = {
	name = "Hunting equipment care and field observations: Weapon maintenance supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_gunspray"},
	},
}

ix.progression.itemPools.town_expansion_d274ef0cff31 = {
	name = "Hunting equipment care and field observations: Recovered precision instruments (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_electro_gyroscope"},
		{item = "value_optical_lens"},
	},
}

ix.progression.itemPools.town_expansion_e4d21b743b7b = {
	name = "Hunting equipment care and field observations: Maps and personal field journals (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_maps"},
		{item = "value_thick_diary"},
	},
}

ix.progression.itemPools.town_expansion_3b29bbed01c1 = {
	name = "Hunting equipment care and field observations: Cutting and gripping tools (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_swiss"},
		{item = "value_tools_nippers"},
	},
}

ix.progression.itemPools.town_expansion_8017b623b0fa = {
	name = "Hunting equipment care and field observations: Maps and personal field journals (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_milimap"},
		{item = "value_thick_diary"},
	},
}

ix.progression.itemPools.town_expansion_47c04d62f149 = {
	name = "Hunting equipment care and field observations: Cutting and gripping tools (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_awl"},
		{item = "value_swiss"},
	},
}

ix.progression.itemPools.town_expansion_de712ebb8e1f = {
	name = "Hunting equipment care and field observations: Weapon maintenance supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_lubricant"},
	},
}

ix.progression.itemPools.town_expansion_2587b90a129f = {
	name = "Hunting equipment care and field observations: Recovered precision instruments (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_gyroscope"},
		{item = "value_gyrotachometer"},
	},
}

ix.progression.itemPools.town_expansion_44b54d5a5d6f = {
	name = "Cloth, protective layers and sewing supplies: Fabric, sewing and carrying supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_fabric_fleece"},
	},
}

ix.progression.itemPools.town_expansion_048d305d8d4f = {
	name = "Cloth, protective layers and sewing supplies: Protective textile rolls and linings (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_retardant3"},
		{item = "value_retardant4"},
		{item = "value_retardant9"},
	},
}

ix.progression.itemPools.town_expansion_5679d68e5005 = {
	name = "Cloth, protective layers and sewing supplies: Fabric, sewing and carrying supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_bedspread"},
		{item = "value_fabric_aramid"},
		{item = "value_rope"},
	},
}

ix.progression.itemPools.town_expansion_fab53bd418b1 = {
	name = "Cloth, protective layers and sewing supplies: Protective textile rolls and linings (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_retardant1"},
		{item = "value_retardant10"},
		{item = "value_retardant9"},
	},
}

ix.progression.itemPools.town_expansion_4d315dcc0c03 = {
	name = "Cloth, protective layers and sewing supplies: Protective textile rolls and linings (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_retardant3"},
		{item = "value_retardant4"},
		{item = "value_retardant9"},
	},
}

ix.progression.itemPools.town_expansion_51ee174f50e7 = {
	name = "Cloth, protective layers and sewing supplies: Fabric, sewing and carrying supplies (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_fabrics1"},
		{item = "value_fabrics2"},
		{item = "value_ropes"},
	},
}

ix.progression.itemPools.town_expansion_3fd11750344a = {
	name = "Cloth, protective layers and sewing supplies: Fabric, sewing and carrying supplies (Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_fabric_fleece"},
	},
}

ix.progression.itemPools.town_expansion_14fcc4940e19 = {
	name = "Cloth, protective layers and sewing supplies: Recovered armour inserts (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic7"},
	},
}

ix.progression.itemPools.town_expansion_cff51d14bda1 = {
	name = "Cloth, protective layers and sewing supplies: Protective textile rolls and linings (Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_retardant1"},
		{item = "value_retardant10"},
		{item = "value_retardant9"},
	},
}

ix.progression.itemPools.town_expansion_b8ec7ec2bfb0 = {
	name = "Cloth, protective layers and sewing supplies: Cutting and gripping tools (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_swiss"},
		{item = "value_tools_nippers"},
	},
}

ix.progression.itemPools.town_expansion_36829349e2ed = {
	name = "Cloth, protective layers and sewing supplies: Fabric, sewing and carrying supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_fabrics1"},
		{item = "value_fabrics2"},
		{item = "value_ropes"},
	},
}

ix.progression.itemPools.town_expansion_c83f1ce5faf1 = {
	name = "Cloth, protective layers and sewing supplies: Recovered armour inserts (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic7"},
	},
}

ix.progression.itemPools.town_expansion_aa30d1c57da1 = {
	name = "Cloth, protective layers and sewing supplies: Protective textile rolls and linings (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_retardant1"},
		{item = "value_retardant10"},
		{item = "value_retardant9"},
	},
}

ix.progression.itemPools.town_expansion_93f3224bace7 = {
	name = "Cloth, protective layers and sewing supplies: Cutting and gripping tools (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_swiss"},
		{item = "value_tools_nippers"},
	},
}

ix.progression.itemPools.town_expansion_d9c9cb52db5a = {
	name = "Cloth, protective layers and sewing supplies: Protective textile rolls and linings (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_retardant12"},
		{item = "value_retardant2"},
	},
}

ix.progression.itemPools.town_expansion_6f6747ac6817 = {
	name = "Cloth, protective layers and sewing supplies: Cutting and gripping tools (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_awl"},
		{item = "value_swiss"},
	},
}

ix.progression.itemPools.town_expansion_81231bc1480c = {
	name = "Cloth, protective layers and sewing supplies: Fabric, sewing and carrying supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_ropes"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_343719b6bebf = {
	name = "Cloth, protective layers and sewing supplies: Recovered armour inserts (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic3"},
	},
}

ix.progression.itemPools.town_expansion_74da25801b3a = {
	name = "Precision tools and mechanical repair parts: Basic workshop tools (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_techtool_1"},
	},
}

ix.progression.itemPools.town_expansion_31108a33b52e = {
	name = "Precision tools and mechanical repair parts: Advanced computer equipment (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_techtool_2"},
	},
}

ix.progression.itemPools.town_expansion_5680557761a2 = {
	name = "Precision tools and mechanical repair parts: Specialty workshop tools (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_techtool_3"},
	},
}

ix.progression.itemPools.town_expansion_0edc942bcdb2 = {
	name = "Precision tools and mechanical repair parts: Specialty workshop tools (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_techtool_3"},
	},
}

ix.progression.itemPools.town_expansion_c4ef1c490cad = {
	name = "Precision tools and mechanical repair parts: Mechanical and equipment repair parts (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_parts"},
		{item = "value_upgro1"},
		{item = "value_upgro2"},
	},
}

ix.progression.itemPools.town_expansion_76a98e0d58b3 = {
	name = "Precision tools and mechanical repair parts: Screwdrivers and wrenches (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_precisiontools"},
		{item = "value_wrench"},
	},
}

ix.progression.itemPools.town_expansion_682820bbf4fb = {
	name = "Precision tools and mechanical repair parts: Advanced computer equipment (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_techtool_2"},
	},
}

ix.progression.itemPools.town_expansion_4bfcbfdd8522 = {
	name = "Precision tools and mechanical repair parts: Specialty workshop tools (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_techtool_3"},
	},
}

ix.progression.itemPools.town_expansion_dc8a21b56c89 = {
	name = "Precision tools and mechanical repair parts: Advanced computer equipment (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_techtool_2"},
	},
}

ix.progression.itemPools.town_expansion_667359aa6e51 = {
	name = "Precision tools and mechanical repair parts: Electrical installation supplies (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_kanifol"},
		{item = "value_lamp_uv"},
		{item = "value_usb_adapter"},
	},
}

ix.progression.itemPools.town_expansion_2de85c7b6370 = {
	name = "Precision tools and mechanical repair parts: Adhesives, lubricants and repair sheets (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_building_plexiglass"},
		{item = "value_building_poxeram"},
	},
}

ix.progression.itemPools.town_expansion_61616ce759ce = {
	name = "Precision tools and mechanical repair parts: Advanced computer equipment (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_pcpart_ssd"},
	},
}

ix.progression.itemPools.town_expansion_0f652b49711c = {
	name = "Precision tools and mechanical repair parts: Electrical installation supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_kanifol"},
		{item = "value_lamp_uv"},
		{item = "value_usb_adapter"},
	},
}

ix.progression.itemPools.town_expansion_b17ea956ec2c = {
	name = "Precision tools and mechanical repair parts: Specialty workshop tools (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_techtool_3"},
	},
}

ix.progression.itemPools.town_expansion_02e3f0c99b9e = {
	name = "Precision tools and mechanical repair parts: Adhesives, lubricants and repair sheets (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_building_plexiglass"},
		{item = "value_building_poxeram"},
	},
}

ix.progression.itemPools.town_expansion_051370659b7c = {
	name = "Precision tools and mechanical repair parts: Mechanical and equipment repair parts (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_parts"},
		{item = "value_upgro1"},
		{item = "value_upgro2"},
	},
}

ix.progression.itemPools.town_expansion_89c6fbb6476c = {
	name = "Precision tools and mechanical repair parts: Screwdrivers and wrenches (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_precisiontools"},
		{item = "value_wrench"},
	},
}

ix.progression.itemPools.town_expansion_1e469de7d680 = {
	name = "Precision tools and mechanical repair parts: Mechanical and equipment repair parts (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_large_parts"},
		{item = "value_upgro3"},
		{item = "value_weaponparts"},
	},
}

ix.progression.itemPools.town_expansion_415a473489fd = {
	name = "Precision tools and mechanical repair parts: Adhesives, lubricants and repair sheets (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_plastic"},
		{item = "value_wd40_100ml"},
	},
}

ix.progression.itemPools.town_expansion_6328803b4ceb = {
	name = "Precision tools and mechanical repair parts: Basic workshop tools (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_techtool_1"},
	},
}

ix.progression.itemPools.town_expansion_4246ebd62271 = {
	name = "Precision tools and mechanical repair parts: Screwdrivers and wrenches (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_screwdriver"},
		{item = "value_tools_screwdriver_flat_long"},
	},
}

ix.progression.itemPools.town_expansion_095bf8a6b392 = {
	name = "Precision tools and mechanical repair parts: Electrical installation supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_electr_tplug"},
		{item = "value_powerfilter"},
		{item = "value_usb_adapter"},
	},
}

ix.progression.itemPools.town_expansion_719a84c9c632 = {
	name = "Expedition instruments and field preparation: Field repair supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_gunoil"},
	},
}

ix.progression.itemPools.town_expansion_cd11d535e099 = {
	name = "Expedition instruments and field preparation: Field repair supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_gunoil"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_31aa6af310c4 = {
	name = "Expedition instruments and field preparation: Recovered precision instruments (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_sensor_a"},
	},
}

ix.progression.itemPools.town_expansion_169456c5a6ea = {
	name = "Expedition instruments and field preparation: Field repair supplies (Marsh, Garbage)",
	tier = "uncommon",
	candidates = {
		{item = "value_tape_electric"},
	},
}

ix.progression.itemPools.town_expansion_6c0be0da7f74 = {
	name = "Expedition instruments and field preparation: Recovered precision instruments (Marsh, Garbage)",
	tier = "uncommon",
	candidates = {
		{item = "value_sensor_a"},
	},
}

ix.progression.itemPools.town_expansion_2b040924a19a = {
	name = "Expedition instruments and field preparation: Field repair supplies (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_4777dfe47cd5 = {
	name = "Expedition instruments and field preparation: Recovered precision instruments (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_pressuregauge"},
		{item = "value_sensor_d"},
	},
}

ix.progression.itemPools.town_expansion_458b58ebabd1 = {
	name = "Expedition instruments and field preparation: Recovered survey equipment (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_detector"},
	},
}

ix.progression.itemPools.town_expansion_119ad6a6ed32 = {
	name = "Expedition instruments and field preparation: Field repair supplies (Garbage)",
	tier = "uncommon",
	candidates = {
		{item = "value_lubricant"},
	},
}

ix.progression.itemPools.town_expansion_df3f70017022 = {
	name = "Expedition instruments and field preparation: Small equipment pouches and sleeves (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
	},
}

ix.progression.itemPools.town_expansion_e52e3677bfae = {
	name = "Expedition instruments and field preparation: Research sample carriers (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_event_labyrinth_chem_container"},
		{item = "value_thermobag"},
	},
}

ix.progression.itemPools.town_expansion_b4a04d746ba4 = {
	name = "Expedition instruments and field preparation: Recovered survey equipment (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_detector"},
		{item = "value_geigercounter"},
	},
}

ix.progression.itemPools.town_expansion_4c7e0ea7658e = {
	name = "Expedition instruments and field preparation: Small equipment pouches and sleeves (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
	},
}

ix.progression.itemPools.town_expansion_cbdef0a9717f = {
	name = "Expedition instruments and field preparation: Field repair supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_cc6fce7f3517 = {
	name = "Expedition instruments and field preparation: Research sample carriers (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_event_labyrinth_chem_container"},
		{item = "value_thermobag"},
	},
}

ix.progression.itemPools.town_expansion_7405a88d3f95 = {
	name = "Expedition instruments and field preparation: Recovered precision instruments (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_sensor_d"},
		{item = "value_thermalmodule"},
	},
}

ix.progression.itemPools.town_expansion_300ffedb3793 = {
	name = "Expedition instruments and field preparation: Recovered survey equipment (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_minedetector"},
		{item = "value_scanner_artefact"},
	},
}

ix.progression.itemPools.town_expansion_52c183ffae00 = {
	name = "Expedition instruments and field preparation: Research sample carriers (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_quest_biohazard_case"},
		{item = "value_thermobag"},
	},
}

ix.progression.itemPools.town_expansion_dc34b895ad93 = {
	name = "Expedition instruments and field preparation: Field repair supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_b3c10e8e5eff = {
	name = "Expedition instruments and field preparation: Small equipment pouches and sleeves (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_container_cardholder"},
		{item = "value_container_smallitems"},
	},
}

ix.progression.itemPools.town_expansion_03117c97ec1f = {
	name = "Personal effects and recovered belongings: Small equipment pouches and sleeves (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
	},
}

ix.progression.itemPools.town_expansion_758357f56716 = {
	name = "Personal effects and recovered belongings: Personal effects and keepsakes (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_crow_beak"},
	},
}

ix.progression.itemPools.town_expansion_7cdeea797da2 = {
	name = "Personal effects and recovered belongings: Personal valuables (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_watch"},
	},
}

ix.progression.itemPools.town_expansion_1a2d0c87676d = {
	name = "Personal effects and recovered belongings: Personal valuables (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_watch"},
	},
}

ix.progression.itemPools.town_expansion_696e2dd3f211 = {
	name = "Personal effects and recovered belongings: Small equipment pouches and sleeves (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
	},
}

ix.progression.itemPools.town_expansion_0529adf6c5d2 = {
	name = "Personal effects and recovered belongings: Personal valuables (Marsh, Garbage)",
	tier = "uncommon",
	candidates = {
		{item = "value_goldchain"},
	},
}

ix.progression.itemPools.town_expansion_bd9e589d4158 = {
	name = "Personal effects and recovered belongings: Small equipment pouches and sleeves (Marsh, Garbage)",
	tier = "uncommon",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_docbag"},
	},
}

ix.progression.itemPools.town_expansion_beeb2b5e9d7a = {
	name = "Personal effects and recovered belongings: Personal effects and keepsakes (Marsh, Garbage)",
	tier = "uncommon",
	candidates = {
		{item = "value_crow_beak"},
	},
}

ix.progression.itemPools.town_expansion_d6d65d00aefc = {
	name = "Personal effects and recovered belongings: Personal valuables (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_goldchain"},
	},
}

ix.progression.itemPools.town_expansion_ca75e0783950 = {
	name = "Personal effects and recovered belongings: Small equipment pouches and sleeves (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_docbag"},
	},
}

ix.progression.itemPools.town_expansion_208adaa6e28d = {
	name = "Personal effects and recovered belongings: Personal effects and keepsakes (Marsh, Garbage, Waystation)",
	tier = "uncommon",
	candidates = {
		{item = "value_crow_beak"},
	},
}

ix.progression.itemPools.town_expansion_5efeace8d008 = {
	name = "Personal effects and recovered belongings: Personal valuables (Garbage)",
	tier = "uncommon",
	candidates = {
		{item = "value_goldchain"},
	},
}

ix.progression.itemPools.town_expansion_89d21f3fe241 = {
	name = "Personal effects and recovered belongings: General transit cases and consignments (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_pukt90"},
		{item = "value_security_box"},
	},
}

ix.progression.itemPools.town_expansion_1929f33f5a02 = {
	name = "Personal effects and recovered belongings: Small equipment pouches and sleeves (Garbage)",
	tier = "uncommon",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_docbag"},
	},
}

ix.progression.itemPools.town_expansion_c39f19f09d27 = {
	name = "Personal effects and recovered belongings: Office stationery and shipping records (Marsh, Garbage, Waystation)",
	tier = "rare",
	candidates = {
		{item = "value_envelope"},
		{item = "value_notepad_a5_closed_01"},
	},
}

ix.progression.itemPools.town_expansion_02d5f2de227d = {
	name = "Personal effects and recovered belongings: Personal effects and keepsakes (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_crow_beak"},
	},
}

ix.progression.itemPools.town_expansion_b087f3b2b5c6 = {
	name = "Personal effects and recovered belongings: General transit cases and consignments (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_pukt90"},
		{item = "value_security_box"},
	},
}

ix.progression.itemPools.town_expansion_86feb8fa1ef4 = {
	name = "Personal effects and recovered belongings: Personal valuables (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_goldchain"},
	},
}

ix.progression.itemPools.town_expansion_3c094aff05b6 = {
	name = "Personal effects and recovered belongings: Office stationery and shipping records (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_envelope"},
		{item = "value_notepad_a5_closed_01"},
	},
}

ix.progression.itemPools.town_expansion_3dac069fdbb3 = {
	name = "Personal effects and recovered belongings: Small equipment pouches and sleeves (Marsh, Garbage, Waystation, Pripyat)",
	tier = "uncommon",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_docbag"},
	},
}

ix.progression.itemPools.town_expansion_ea7d5eddcaf8 = {
	name = "Personal effects and recovered belongings: Small equipment pouches and sleeves (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
	},
}

ix.progression.itemPools.town_expansion_5b9bf3ce5bab = {
	name = "Personal effects and recovered belongings: Office stationery and shipping records (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_envelope"},
		{item = "value_officepaper"},
	},
}

ix.progression.itemPools.town_expansion_de6782916b35 = {
	name = "Personal effects and recovered belongings: Personal effects and keepsakes (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_lightkeeper_amulet"},
	},
}

ix.progression.itemPools.town_expansion_b33ad10ab3c4 = {
	name = "Personal effects and recovered belongings: Personal valuables (Garbage)",
	tier = "uncommon",
	candidates = {
		{item = "value_watch"},
	},
}

ix.progression.itemPools.town_expansion_0301e3f19be4 = {
	name = "Personal effects and recovered belongings: Personal valuables (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_goldchain"},
	},
}

ix.progression.itemPools.town_expansion_01ffc26eb395 = {
	name = "Personal effects and recovered belongings: General transit cases and consignments (Marsh, Garbage, Waystation, Pripyat)",
	tier = "rare",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_small_case"},
	},
}
