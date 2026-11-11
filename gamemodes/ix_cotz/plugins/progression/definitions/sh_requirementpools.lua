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

ix.progression.requirementBatchSizes = {
	value_propanetank = 2,
	value_bolts = 4,
	value_nuts = 3,
	value_gasoline = 2,
	value_9vbattery = 2,
	value_kerosene = 2,
	value_capacitors = 2,
}

ix.progression.itemPools.town_expansion_2c39104686e8 = {
	name = "Survey notes and measuring instruments: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_guide"},
		{item = "value_info_moleskine"},
		{item = "value_maps"},
		{item = "value_thick_diary"},
	},
}

ix.progression.itemPools.town_expansion_9541551e9e93 = {
	name = "Survey notes and measuring instruments: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_guide"},
		{item = "value_handbook_materials"},
		{item = "value_info_maps"},
		{item = "value_info_moleskine"},
		{item = "value_manual_lada"},
		{item = "value_maps"},
		{item = "value_milimap"},
		{item = "value_pressuregauge"},
		{item = "value_sensor_a"},
		{item = "value_thick_diary"},
	},
}

ix.progression.itemPools.town_expansion_760a26e25631 = {
	name = "Survey notes and measuring instruments: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_clothbook2"},
		{item = "value_info_maps"},
		{item = "value_info_moleskine"},
		{item = "value_manual_lada"},
		{item = "value_maps"},
		{item = "value_milimap"},
		{item = "value_thick_diary"},
	},
}

ix.progression.itemPools.town_expansion_d1ac14ec4037 = {
	name = "Survey notes and measuring instruments: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_guide"},
		{item = "value_handbook_materials"},
		{item = "value_info_maps"},
		{item = "value_info_moleskine"},
		{item = "value_manual_lada"},
		{item = "value_maps"},
		{item = "value_milimap"},
		{item = "value_pressuregauge"},
		{item = "value_sensor_a"},
		{item = "value_thick_diary"},
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

ix.progression.itemPools.town_expansion_f992b065f19b = {
	name = "Survey notes and measuring instruments: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_electro_gyroscope"},
		{item = "value_guide"},
		{item = "value_handbook_materials"},
		{item = "value_info_maps"},
		{item = "value_info_moleskine"},
		{item = "value_manual_lada"},
		{item = "value_maps"},
		{item = "value_milimap"},
		{item = "value_optical_lens"},
		{item = "value_pressuregauge"},
		{item = "value_sensor_a"},
		{item = "value_sensor_d"},
		{item = "value_thermalmodule"},
		{item = "value_thick_diary"},
	},
}

ix.progression.itemPools.town_expansion_9c6bee1426dc = {
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
		{item = "value_scanner_anomaly"},
		{item = "value_scanner_artefact"},
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

ix.progression.itemPools.town_expansion_ec6a9a5eae75 = {
	name = "Survey notes and measuring instruments: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_guide"},
		{item = "value_handbook_materials"},
		{item = "value_info_maps"},
		{item = "value_info_moleskine"},
		{item = "value_manual_lada"},
		{item = "value_maps"},
		{item = "value_milimap"},
		{item = "value_pressuregauge"},
		{item = "value_sensor_a"},
		{item = "value_thick_diary"},
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

ix.progression.itemPools.town_expansion_a436288caee5 = {
	name = "Freight cases and cargo packing: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_paracord"},
		{item = "value_rope"},
		{item = "value_ropes"},
		{item = "value_tape_duct"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
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

ix.progression.itemPools.town_expansion_4efa86832367 = {
	name = "Freight cases and cargo packing: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_paracord"},
		{item = "value_rope"},
		{item = "value_ropes"},
		{item = "value_sewingkit"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_8313ff40d2d3 = {
	name = "Freight cases and cargo packing: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_carbon_case"},
		{item = "value_knife_box_low"},
		{item = "value_large_case"},
		{item = "value_rope"},
		{item = "value_ropes"},
		{item = "value_sewingkit"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_3389c064b502 = {
	name = "Freight cases and cargo packing: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_carbon_case"},
		{item = "value_knife_box_low"},
		{item = "value_large_case"},
		{item = "value_ropes"},
		{item = "value_security_box"},
		{item = "value_sewingkit"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_03a67c43cf19 = {
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

ix.progression.itemPools.town_expansion_742385b91f8d = {
	name = "Freight cases and cargo packing: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_flammable_huntermatches"},
		{item = "value_flammable_klean"},
		{item = "value_gascan"},
		{item = "value_ropes"},
		{item = "value_sewingkit"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
		{item = "value_valuable_kresalo"},
	},
}

ix.progression.itemPools.town_expansion_2847198e6a81 = {
	name = "Freight cases and cargo packing: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_carbon_case"},
		{item = "value_container_junkbox"},
		{item = "value_knife_box_low"},
		{item = "value_large_case"},
		{item = "value_paracord"},
		{item = "value_parcel"},
		{item = "value_pukt90"},
		{item = "value_rope"},
		{item = "value_ropes"},
		{item = "value_security_box"},
		{item = "value_sewingkit"},
		{item = "value_small_case"},
		{item = "value_tape_duct"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_58819248abd4 = {
	name = "Freight cases and cargo packing: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_fabric_fleece"},
		{item = "value_flammable_huntermatches"},
		{item = "value_flammable_klean"},
		{item = "value_gascan"},
		{item = "value_sewingkit"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
		{item = "value_valuable_kresalo"},
	},
}

ix.progression.itemPools.town_expansion_c706432f6e12 = {
	name = "Freight cases and cargo packing: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_crikent_0"},
		{item = "value_fabric_fleece"},
		{item = "value_fabric_ripstop"},
		{item = "value_flammable_huntermatches"},
		{item = "value_flammable_klean"},
		{item = "value_gascan"},
		{item = "value_sewingkit"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_6a51d7730e3e = {
	name = "Freight cases and cargo packing: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_carbon_case"},
		{item = "value_container_junkbox"},
		{item = "value_knife_box_low"},
		{item = "value_large_case"},
		{item = "value_paracord"},
		{item = "value_parcel"},
		{item = "value_pukt90"},
		{item = "value_rope"},
		{item = "value_ropes"},
		{item = "value_security_box"},
		{item = "value_sewingkit"},
		{item = "value_small_case"},
		{item = "value_tape_duct"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_7ac8639f4591 = {
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
		{item = "value_sewingkit"},
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

ix.progression.itemPools.town_expansion_de7b35dd9b7f = {
	name = "Field samples and laboratory containment: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_chemcontainer"},
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_event_labyrinth_chem_container"},
		{item = "value_guide"},
		{item = "value_handbook_materials"},
		{item = "value_manual_lada"},
		{item = "value_portable_container_closed"},
		{item = "value_portable_container_opened"},
		{item = "value_thermobag"},
	},
}

ix.progression.itemPools.town_expansion_2543f03b06bc = {
	name = "Field samples and laboratory containment: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_chemcontainer"},
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_event_labyrinth_chem_container"},
		{item = "value_guide"},
		{item = "value_handbook_materials"},
		{item = "value_manual_lada"},
		{item = "value_portable_container_closed"},
		{item = "value_portable_container_opened"},
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

ix.progression.itemPools.town_expansion_1537e0c06e89 = {
	name = "Field samples and laboratory containment: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_anomaly_plant"},
		{item = "value_chemcontainer"},
		{item = "value_chemicalsample"},
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_event_labyrinth_chem_container"},
		{item = "value_guide"},
		{item = "value_handbook_materials"},
		{item = "value_manual_lada"},
		{item = "value_med_bloodsample"},
		{item = "value_plasticbag_labyrinth"},
		{item = "value_portable_container_closed"},
		{item = "value_portable_container_opened"},
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

ix.progression.itemPools.town_expansion_c81d136325a3 = {
	name = "Field samples and laboratory containment: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_guide"},
		{item = "value_handbook_materials"},
		{item = "value_manual_lada"},
		{item = "value_portable_container_opened"},
	},
}

ix.progression.itemPools.town_expansion_a93997bc4506 = {
	name = "Field samples and laboratory containment: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_chemcontainer"},
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_event_labyrinth_chem_container"},
		{item = "value_guide"},
		{item = "value_handbook_materials"},
		{item = "value_manual_lada"},
		{item = "value_portable_container_closed"},
		{item = "value_portable_container_opened"},
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

ix.progression.itemPools.town_expansion_c0bcbab54219 = {
	name = "Field samples and laboratory containment: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_anomaly_plant"},
		{item = "value_chemcontainer"},
		{item = "value_chemicalsample"},
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_event_labyrinth_chem_container"},
		{item = "value_guide"},
		{item = "value_handbook_materials"},
		{item = "value_manual_lada"},
		{item = "value_med_bloodsample"},
		{item = "value_plasticbag_labyrinth"},
		{item = "value_portable_container_closed"},
		{item = "value_portable_container_opened"},
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

ix.progression.itemPools.town_expansion_42254f70f06f = {
	name = "Ordnance and protective equipment: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_balloon_poison_gas"},
		{item = "value_c4"},
		{item = "value_explosive_charge"},
		{item = "value_flammable_thermite"},
		{item = "value_flammable_trotil"},
		{item = "value_other_uzrgm_fuse"},
	},
}

ix.progression.itemPools.town_expansion_301902d9f818 = {
	name = "Ordnance and protective equipment: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_ballistic11"},
		{item = "value_ballistic4"},
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

ix.progression.itemPools.town_expansion_ce9765fb7cf7 = {
	name = "Ordnance and protective equipment: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic3"},
		{item = "value_ballistic4"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
		{item = "value_balloon_poison_gas"},
		{item = "value_c4"},
		{item = "value_dynamite"},
		{item = "value_explosive_charge"},
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

ix.progression.itemPools.town_expansion_c1cbada5e01f = {
	name = "Ordnance and protective equipment: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic3"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
		{item = "value_flammable_thermite"},
	},
}

ix.progression.itemPools.town_expansion_59255152cb9b = {
	name = "Ordnance and protective equipment: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic3"},
		{item = "value_ballistic4"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
		{item = "value_balloon_poison_gas"},
		{item = "value_c4"},
		{item = "value_dynamite"},
		{item = "value_explosive_charge"},
		{item = "value_flammable_thermite"},
		{item = "value_flammable_trotil"},
		{item = "value_other_uzrgm_fuse"},
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

ix.progression.itemPools.town_expansion_bbed61122071 = {
	name = "Ordnance and protective equipment: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic3"},
		{item = "value_ballistic4"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
		{item = "value_balloon_poison_gas"},
		{item = "value_c4"},
		{item = "value_dynamite"},
		{item = "value_explosive_charge"},
		{item = "value_flammable_thermite"},
		{item = "value_flammable_trotil"},
		{item = "value_other_uzrgm_fuse"},
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

ix.progression.itemPools.town_expansion_1d12d1615a01 = {
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

ix.progression.itemPools.town_expansion_9e28abde391d = {
	name = "Ordnance and protective equipment: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic3"},
		{item = "value_ballistic4"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
		{item = "value_balloon_poison_gas"},
		{item = "value_c4"},
		{item = "value_dynamite"},
		{item = "value_explosive_charge"},
		{item = "value_flammable_thermite"},
		{item = "value_flammable_trotil"},
		{item = "value_other_uzrgm_fuse"},
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

ix.progression.itemPools.town_expansion_11432963f8ae = {
	name = "Reloading components and ammunition storage: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_guncleaner"},
		{item = "value_gunoil"},
		{item = "value_gunpowder_blue"},
		{item = "value_gunpowder_green"},
		{item = "value_gunpowder_red"},
		{item = "value_gunspray"},
	},
}

ix.progression.itemPools.town_expansion_64a8e2e09127 = {
	name = "Reloading components and ammunition storage: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_guncleaner"},
		{item = "value_gunoil"},
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

ix.progression.itemPools.town_expansion_85f15f41a5ef = {
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

ix.progression.itemPools.town_expansion_7be8fdb53f87 = {
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

ix.progression.itemPools.town_expansion_b831b88bf8a7 = {
	name = "Reloading components and ammunition storage: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_container_parls"},
		{item = "value_container_weaponcase"},
		{item = "value_guncleaner"},
		{item = "value_gunoil"},
		{item = "value_gunpowder_blue"},
		{item = "value_gunpowder_green"},
		{item = "value_gunpowder_red"},
		{item = "value_gunspray"},
		{item = "value_lubricant"},
	},
}

ix.progression.itemPools.town_expansion_90de7166a430 = {
	name = "Reloading components and ammunition storage: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_guncleaner"},
		{item = "value_gunpowder_blue"},
		{item = "value_gunpowder_green"},
		{item = "value_gunpowder_red"},
		{item = "value_lubricant"},
	},
}

ix.progression.itemPools.town_expansion_c49ce575cf50 = {
	name = "Reloading components and ammunition storage: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_gunpowder_blue"},
		{item = "value_gunpowder_green"},
		{item = "value_gunpowder_red"},
		{item = "value_lubricant"},
	},
}

ix.progression.itemPools.town_expansion_dd5ba6faf7e5 = {
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

ix.progression.itemPools.town_expansion_60d977cc67e0 = {
	name = "Reloading components and ammunition storage: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_cardholder"},
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
		{item = "value_pipewrench"},
		{item = "value_precisiontools"},
		{item = "value_screwdriver"},
		{item = "value_tools_advwrench"},
		{item = "value_tools_ratchetwrench"},
		{item = "value_tools_screwdriver_flat"},
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

ix.progression.itemPools.town_expansion_df7b8b770885 = {
	name = "Reloading components and ammunition storage: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_container_parls"},
		{item = "value_container_weapon_thicc"},
		{item = "value_container_weaponcase"},
		{item = "value_guncleaner"},
		{item = "value_gunoil"},
		{item = "value_gunpowder_blue"},
		{item = "value_gunpowder_green"},
		{item = "value_gunpowder_red"},
		{item = "value_gunspray"},
		{item = "value_lubricant"},
	},
}

ix.progression.itemPools.town_expansion_2bcd5ac29800 = {
	name = "Reloading components and ammunition storage: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_container_cardholder"},
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
		{item = "value_pipewrench"},
		{item = "value_precisiontools"},
		{item = "value_screwdriver"},
		{item = "value_tools_advwrench"},
		{item = "value_tools_ratchetwrench"},
		{item = "value_tools_screwdriver_flat"},
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

ix.progression.itemPools.town_expansion_2ef4539083ea = {
	name = "Reloading components and ammunition storage: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_container_parls"},
		{item = "value_container_weapon_thicc"},
		{item = "value_container_weaponcase"},
		{item = "value_guncleaner"},
		{item = "value_gunoil"},
		{item = "value_gunpowder_blue"},
		{item = "value_gunpowder_green"},
		{item = "value_gunpowder_red"},
		{item = "value_gunspray"},
		{item = "value_lubricant"},
	},
}

ix.progression.itemPools.town_expansion_aea4e8575719 = {
	name = "Reloading components and ammunition storage: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_container_cardholder"},
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
		{item = "value_pipewrench"},
		{item = "value_precisiontools"},
		{item = "value_screwdriver"},
		{item = "value_tools_advwrench"},
		{item = "value_tools_ratchetwrench"},
		{item = "value_tools_screwdriver_flat"},
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

ix.progression.itemPools.town_expansion_486c5fd6b835 = {
	name = "Historical documents and technical records: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_documents_12"},
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

ix.progression.itemPools.town_expansion_5eeeea7bc9ae = {
	name = "Historical documents and technical records: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_documents_10"},
		{item = "value_documents_11"},
		{item = "value_documents_12"},
		{item = "value_documents_14"},
		{item = "value_documents_3"},
		{item = "value_documents_4"},
		{item = "value_documents_5"},
		{item = "value_documents_6"},
		{item = "value_documents_7"},
		{item = "value_documents_9"},
		{item = "value_handbook_materials"},
		{item = "value_manual_lada"},
	},
}

ix.progression.itemPools.town_expansion_4bff88ee59a9 = {
	name = "Historical documents and technical records: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_documents_12"},
		{item = "value_documents_3"},
		{item = "value_documents_4"},
		{item = "value_documents_8"},
		{item = "value_guide"},
		{item = "value_manual_lada"},
	},
}

ix.progression.itemPools.town_expansion_51d6dd480c10 = {
	name = "Historical documents and technical records: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_documents_12"},
		{item = "value_documents_3"},
		{item = "value_documents_8"},
		{item = "value_guide"},
		{item = "value_manual_lada"},
	},
}

ix.progression.itemPools.town_expansion_27ac5d00881a = {
	name = "Historical documents and technical records: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_documents_3"},
		{item = "value_documents_8"},
		{item = "value_guide"},
		{item = "value_manual_lada"},
	},
}

ix.progression.itemPools.town_expansion_09610a098c14 = {
	name = "Historical documents and technical records: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_documents_10"},
		{item = "value_documents_11"},
		{item = "value_documents_12"},
		{item = "value_documents_14"},
		{item = "value_documents_3"},
		{item = "value_documents_4"},
		{item = "value_documents_5"},
		{item = "value_documents_6"},
		{item = "value_documents_7"},
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

ix.progression.itemPools.town_expansion_7ab712313d3a = {
	name = "Historical documents and technical records: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_documents_10"},
		{item = "value_documents_11"},
		{item = "value_documents_12"},
		{item = "value_documents_14"},
		{item = "value_documents_3"},
		{item = "value_documents_4"},
		{item = "value_documents_5"},
		{item = "value_documents_6"},
		{item = "value_documents_7"},
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

ix.progression.itemPools.town_expansion_c368aedd068c = {
	name = "Historical documents and technical records: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_documents_10"},
		{item = "value_documents_11"},
		{item = "value_documents_12"},
		{item = "value_documents_14"},
		{item = "value_documents_3"},
		{item = "value_documents_4"},
		{item = "value_documents_5"},
		{item = "value_documents_6"},
		{item = "value_documents_7"},
		{item = "value_documents_8"},
		{item = "value_documents_9"},
		{item = "value_guide"},
		{item = "value_handbook_materials"},
		{item = "value_manual_lada"},
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

ix.progression.itemPools.town_expansion_c1f3ccbfe4fc = {
	name = "Storage upkeep and discreet containers: general supplies (Marsh, Garbage)",
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

ix.progression.itemPools.town_expansion_f7aa2d4db5d3 = {
	name = "Storage upkeep and discreet containers: general supplies (Garbage)",
	tier = "common",
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
}

ix.progression.itemPools.town_expansion_5508561e2495 = {
	name = "Storage upkeep and discreet containers: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_antiinsect"},
		{item = "value_chlorine"},
		{item = "value_glasscleaner"},
		{item = "value_household_repellent"},
		{item = "value_household_tree_life_extender"},
		{item = "value_ratpoison"},
		{item = "value_shampoo"},
		{item = "value_soap"},
	},
}

ix.progression.itemPools.town_expansion_fc9193c43ae1 = {
	name = "Storage upkeep and discreet containers: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_antiinsect"},
		{item = "value_glasscleaner"},
		{item = "value_household_repellent"},
		{item = "value_household_toothpaste1"},
		{item = "value_household_tree_life_extender"},
		{item = "value_ratpoison"},
		{item = "value_shampoo"},
		{item = "value_soap"},
	},
}

ix.progression.itemPools.town_expansion_609694bab68e = {
	name = "Storage upkeep and discreet containers: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_antiinsect"},
		{item = "value_household_repellent"},
		{item = "value_household_toothpaste1"},
		{item = "value_household_tree_life_extender"},
		{item = "value_ratpoison"},
		{item = "value_shampoo"},
		{item = "value_soap"},
		{item = "value_soda"},
	},
}

ix.progression.itemPools.town_expansion_c140ec1b36ff = {
	name = "Storage upkeep and discreet containers: general supplies (Garbage)",
	tier = "common",
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

ix.progression.itemPools.town_expansion_8280e5acf226 = {
	name = "Storage upkeep and discreet containers: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
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
		{item = "value_safe_container"},
		{item = "value_shampoo"},
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

ix.progression.itemPools.town_expansion_cc5babbdb781 = {
	name = "Storage upkeep and discreet containers: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
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
		{item = "value_safe_container"},
		{item = "value_shampoo"},
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

ix.progression.itemPools.town_expansion_745c62856683 = {
	name = "Laboratory containment and research reagents: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_airfilter"},
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_guide"},
		{item = "value_handbook_materials"},
		{item = "value_labyrinth_valve"},
		{item = "value_manual_lada"},
		{item = "value_med_thermometer"},
		{item = "value_other_filter"},
		{item = "value_other_hosemilitary"},
	},
}

ix.progression.itemPools.town_expansion_8b83c0d2cc3a = {
	name = "Laboratory containment and research reagents: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_airfilter"},
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_guide"},
		{item = "value_handbook_materials"},
		{item = "value_labyrinth_valve"},
		{item = "value_manual_lada"},
		{item = "value_med_thermometer"},
		{item = "value_other_filter"},
		{item = "value_other_hosemilitary"},
	},
}

ix.progression.itemPools.town_expansion_c4322c51582c = {
	name = "Laboratory containment and research reagents: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_airfilter"},
		{item = "value_injector_2a2"},
		{item = "value_injector_3btg"},
		{item = "value_injector_ahf1m"},
		{item = "value_injector_l1"},
		{item = "value_injector_mildronate"},
		{item = "value_injector_mule"},
		{item = "value_injector_obdolbos"},
		{item = "value_injector_obdolbos_2"},
		{item = "value_injector_p22"},
		{item = "value_injector_perfotoran"},
		{item = "value_injector_sj12"},
		{item = "value_injector_sj9"},
		{item = "value_injector_trimadol"},
		{item = "value_injector_xtg12"},
		{item = "value_other_hosemilitary"},
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

ix.progression.itemPools.town_expansion_e19a010d3045 = {
	name = "Generator parts and camp electrics: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_carbattery"},
		{item = "value_electr_tplug"},
		{item = "value_engine"},
		{item = "value_helix"},
		{item = "value_kanifol"},
		{item = "value_lamp_efficient"},
		{item = "value_lamp_uv"},
		{item = "value_magnet"},
		{item = "value_motorclean"},
		{item = "value_powercable"},
		{item = "value_usb_adapter"},
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

ix.progression.itemPools.town_expansion_31db5e234de1 = {
	name = "Generator parts and camp electrics: general supplies (Marsh)",
	tier = "uncommon",
	candidates = {
		{item = "value_carbattery"},
		{item = "value_engine"},
	},
}

ix.progression.itemPools.town_expansion_370444fd22ff = {
	name = "Generator parts and camp electrics: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_carbattery"},
		{item = "value_electr_tplug"},
		{item = "value_engine"},
		{item = "value_helix"},
		{item = "value_kanifol"},
		{item = "value_lamp_efficient"},
		{item = "value_lamp_uv"},
		{item = "value_magnet"},
		{item = "value_motorclean"},
		{item = "value_powercable"},
		{item = "value_usb_adapter"},
		{item = "value_wire_heavy"},
	},
}

ix.progression.itemPools.town_expansion_15c973ec8c45 = {
	name = "Generator parts and camp electrics: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_carbattery"},
		{item = "value_electr_tplug"},
		{item = "value_engine"},
		{item = "value_helix"},
		{item = "value_kanifol"},
		{item = "value_lamp_efficient"},
		{item = "value_lamp_uv"},
		{item = "value_magnet"},
		{item = "value_motorclean"},
		{item = "value_powercable"},
		{item = "value_powerfilter"},
		{item = "value_usb_adapter"},
		{item = "value_wd40_100ml"},
		{item = "value_wire_heavy"},
	},
}

ix.progression.itemPools.town_expansion_192256dbd2c6 = {
	name = "Generator parts and camp electrics: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_carbattery"},
		{item = "value_engine"},
		{item = "value_helix"},
		{item = "value_kanifol"},
		{item = "value_lamp_efficient"},
		{item = "value_lamp_uv"},
		{item = "value_magnet"},
		{item = "value_usb_adapter"},
	},
}

ix.progression.itemPools.town_expansion_4a275fcf876d = {
	name = "Generator parts and camp electrics: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_carbattery"},
		{item = "value_electr_tplug"},
		{item = "value_engine"},
		{item = "value_helix"},
		{item = "value_kanifol"},
		{item = "value_lamp_uv"},
		{item = "value_magnet"},
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

ix.progression.itemPools.town_expansion_c58a767bfe4b = {
	name = "Generator parts and camp electrics: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_gasoline"},
		{item = "value_kerosene"},
		{item = "value_propanetank"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_95320215b0ba = {
	name = "Generator parts and camp electrics: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_carbattery"},
		{item = "value_electr_tplug"},
		{item = "value_engine"},
		{item = "value_helix"},
		{item = "value_kanifol"},
		{item = "value_lamp_efficient"},
		{item = "value_lamp_uv"},
		{item = "value_magnet"},
		{item = "value_motorclean"},
		{item = "value_powercable"},
		{item = "value_powerfilter"},
		{item = "value_usb_adapter"},
		{item = "value_wd40_100ml"},
		{item = "value_wire_heavy"},
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

ix.progression.itemPools.town_expansion_2c1252e65ba4 = {
	name = "Generator parts and camp electrics: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_gasoline"},
		{item = "value_kerosene"},
		{item = "value_propanetank"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_0a417ddc981b = {
	name = "Generator parts and camp electrics: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_gasoline"},
		{item = "value_kerosene"},
		{item = "value_propanetank"},
		{item = "value_wire_copper"},
	},
}

ix.progression.itemPools.town_expansion_72aa1a2f1e76 = {
	name = "Generator parts and camp electrics: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_carbattery"},
		{item = "value_electr_tplug"},
		{item = "value_engine"},
		{item = "value_helix"},
		{item = "value_kanifol"},
		{item = "value_lamp_efficient"},
		{item = "value_lamp_uv"},
		{item = "value_magnet"},
		{item = "value_motorclean"},
		{item = "value_powercable"},
		{item = "value_powerfilter"},
		{item = "value_usb_adapter"},
		{item = "value_wd40_100ml"},
		{item = "value_wire_heavy"},
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

ix.progression.itemPools.town_expansion_ed0ffb379f26 = {
	name = "Generator parts and camp electrics: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_gasoline"},
		{item = "value_kerosene"},
		{item = "value_propanetank"},
		{item = "value_wire_copper"},
	},
}

ix.progression.itemPools.town_expansion_2345f7264026 = {
	name = "Resale curios and small valuables: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_antique_vase"},
		{item = "value_bear_souvenir"},
		{item = "value_skullring"},
		{item = "value_statue_cat"},
		{item = "value_statue_lion"},
		{item = "value_statue_raven"},
	},
}

ix.progression.itemPools.town_expansion_8b4b54445113 = {
	name = "Resale curios and small valuables: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_antique_teapot"},
		{item = "value_antique_vase"},
		{item = "value_bear_souvenir"},
		{item = "value_goldchain"},
		{item = "value_skullring"},
		{item = "value_statue_cat"},
		{item = "value_statue_horse"},
		{item = "value_statue_lion"},
		{item = "value_statue_raven"},
		{item = "value_watch"},
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

ix.progression.itemPools.town_expansion_6c290a02e2a4 = {
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

ix.progression.itemPools.town_expansion_aee789b711ad = {
	name = "Resale curios and small valuables: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_antique_teapot"},
		{item = "value_antique_vase"},
		{item = "value_bear_souvenir"},
		{item = "value_goldchain"},
		{item = "value_skullring"},
		{item = "value_statue_cat"},
		{item = "value_statue_horse"},
		{item = "value_statue_lion"},
		{item = "value_statue_raven"},
		{item = "value_watch"},
	},
}

ix.progression.itemPools.town_expansion_9165c882cc6d = {
	name = "Resale curios and small valuables: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_antique_teapot"},
		{item = "value_antique_vase"},
		{item = "value_statue_cat"},
		{item = "value_statue_horse"},
		{item = "value_statue_lion"},
		{item = "value_statue_raven"},
	},
}

ix.progression.itemPools.town_expansion_e28cbf1cd692 = {
	name = "Resale curios and small valuables: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_antique_teapot"},
		{item = "value_antique_vase"},
		{item = "value_bear_souvenir"},
		{item = "value_goldchain"},
		{item = "value_lighter_gold"},
		{item = "value_pocketwatch"},
		{item = "value_skullring"},
		{item = "value_statue_cat"},
		{item = "value_statue_horse"},
		{item = "value_statue_lion"},
		{item = "value_statue_raven"},
		{item = "value_watch"},
		{item = "value_woodclock"},
	},
}

ix.progression.itemPools.town_expansion_00a9f98fb179 = {
	name = "Resale curios and small valuables: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_antique_vase"},
		{item = "value_bear_souvenir"},
		{item = "value_skullring"},
		{item = "value_statue_horse"},
		{item = "value_woodclock"},
	},
}

ix.progression.itemPools.town_expansion_a16c78633f5e = {
	name = "Resale curios and small valuables: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_antique_vase"},
		{item = "value_bear_souvenir"},
		{item = "value_skullring"},
		{item = "value_statue_horse"},
		{item = "value_statue_raven"},
	},
}

ix.progression.itemPools.town_expansion_6611c76f562e = {
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
		{item = "value_small_case"},
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

ix.progression.itemPools.town_expansion_5881eaf81d7e = {
	name = "Resale curios and small valuables: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_antique_teapot"},
		{item = "value_antique_vase"},
		{item = "value_bear_souvenir"},
		{item = "value_goldchain"},
		{item = "value_lighter_gold"},
		{item = "value_pocketwatch"},
		{item = "value_skullring"},
		{item = "value_statue_cat"},
		{item = "value_statue_horse"},
		{item = "value_statue_lion"},
		{item = "value_statue_raven"},
		{item = "value_watch"},
		{item = "value_woodclock"},
	},
}

ix.progression.itemPools.town_expansion_9f80b188c008 = {
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
		{item = "value_small_case"},
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

ix.progression.itemPools.town_expansion_bf10bed3cc79 = {
	name = "Resale curios and small valuables: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_antique_teapot"},
		{item = "value_antique_vase"},
		{item = "value_bear_souvenir"},
		{item = "value_goldchain"},
		{item = "value_lighter_gold"},
		{item = "value_pocketwatch"},
		{item = "value_skullring"},
		{item = "value_statue_cat"},
		{item = "value_statue_horse"},
		{item = "value_statue_lion"},
		{item = "value_statue_raven"},
		{item = "value_watch"},
		{item = "value_woodclock"},
	},
}

ix.progression.itemPools.town_expansion_4f2d5163d707 = {
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
		{item = "value_small_case"},
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

ix.progression.itemPools.town_expansion_43d693fb144f = {
	name = "Detector calibration and survey equipment: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_chemcontainer"},
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_event_labyrinth_chem_container"},
		{item = "value_guide"},
		{item = "value_handbook_materials"},
		{item = "value_manual_lada"},
		{item = "value_pcpart_fpga"},
		{item = "value_pcpart_lcd"},
		{item = "value_portable_container_closed"},
		{item = "value_portable_container_opened"},
		{item = "value_thermobag"},
	},
}

ix.progression.itemPools.town_expansion_c268760d508e = {
	name = "Detector calibration and survey equipment: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_chemcontainer"},
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_event_labyrinth_chem_container"},
		{item = "value_guide"},
		{item = "value_handbook_materials"},
		{item = "value_manual_lada"},
		{item = "value_pcpart_fpga"},
		{item = "value_pcpart_lcd"},
		{item = "value_portable_container_closed"},
		{item = "value_portable_container_opened"},
		{item = "value_thermobag"},
	},
}

ix.progression.itemPools.town_expansion_a5a382cf5db3 = {
	name = "Detector calibration and survey equipment: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_casezerogeo"},
		{item = "value_chemcontainer"},
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_detector"},
		{item = "value_event_labyrinth_chem_container"},
		{item = "value_geigercounter"},
		{item = "value_guide"},
		{item = "value_handbook_materials"},
		{item = "value_manual_lada"},
		{item = "value_pcpart_fpga"},
		{item = "value_pcpart_lcd"},
		{item = "value_portable_container_closed"},
		{item = "value_portable_container_opened"},
		{item = "value_powerbank"},
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

ix.progression.itemPools.town_expansion_31c8ee1ee48f = {
	name = "Clinical supplies and trauma equipment: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_med_aquatabs"},
		{item = "value_med_ibuprofen"},
		{item = "value_med_peroxide"},
		{item = "value_med_petroleumjelly"},
		{item = "value_med_saline"},
		{item = "value_med_vitamins"},
	},
}

ix.progression.itemPools.town_expansion_e9bc2b73f8b0 = {
	name = "Clinical supplies and trauma equipment: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_med_aquatabs"},
		{item = "value_med_bloodset"},
		{item = "value_med_haemostatic"},
		{item = "value_med_ibuprofen"},
		{item = "value_med_medicalstock"},
		{item = "value_med_peroxide"},
		{item = "value_med_petroleumjelly"},
		{item = "value_med_saline"},
		{item = "value_med_splint"},
		{item = "value_med_syringe"},
		{item = "value_med_thermometer"},
		{item = "value_med_tourniquet"},
		{item = "value_med_tourniquet_rubber"},
		{item = "value_med_vitamins"},
	},
}

ix.progression.itemPools.town_expansion_3154c30ff6bf = {
	name = "Clinical supplies and trauma equipment: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_med_aquatabs"},
		{item = "value_med_ibuprofen"},
		{item = "value_med_medicalstock"},
		{item = "value_med_saline"},
	},
}

ix.progression.itemPools.town_expansion_7be59808c150 = {
	name = "Clinical supplies and trauma equipment: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_med_aquatabs"},
		{item = "value_med_bloodset"},
		{item = "value_med_haemostatic"},
		{item = "value_med_ibuprofen"},
		{item = "value_med_medicalstock"},
		{item = "value_med_peroxide"},
		{item = "value_med_petroleumjelly"},
		{item = "value_med_saline"},
		{item = "value_med_splint"},
		{item = "value_med_syringe"},
		{item = "value_med_thermometer"},
		{item = "value_med_tourniquet"},
		{item = "value_med_tourniquet_rubber"},
		{item = "value_med_vitamins"},
	},
}

ix.progression.itemPools.town_expansion_92f41ad4323a = {
	name = "Clinical supplies and trauma equipment: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_med_aquatabs"},
		{item = "value_med_bloodset"},
		{item = "value_med_haemostatic"},
		{item = "value_med_ibuprofen"},
		{item = "value_med_medicalstock"},
		{item = "value_med_peroxide"},
		{item = "value_med_petroleumjelly"},
		{item = "value_med_saline"},
		{item = "value_med_splint"},
		{item = "value_med_surgicalpouch"},
		{item = "value_med_surgicaltools"},
		{item = "value_med_syringe"},
		{item = "value_med_thermometer"},
		{item = "value_med_tourniquet"},
		{item = "value_med_tourniquet_rubber"},
		{item = "value_med_vitamins"},
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

ix.progression.itemPools.town_expansion_7c1b1e2e5b90 = {
	name = "Clinical supplies and trauma equipment: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_med_aquatabs"},
		{item = "value_med_bloodset"},
		{item = "value_med_haemostatic"},
		{item = "value_med_ibuprofen"},
		{item = "value_med_medicalstock"},
		{item = "value_med_peroxide"},
		{item = "value_med_petroleumjelly"},
		{item = "value_med_saline"},
		{item = "value_med_splint"},
		{item = "value_med_syringe"},
		{item = "value_med_thermometer"},
		{item = "value_med_tourniquet"},
		{item = "value_med_tourniquet_rubber"},
		{item = "value_med_vitamins"},
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

ix.progression.itemPools.town_expansion_0ac1ddad8ea9 = {
	name = "Clinical supplies and trauma equipment: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_med_aquatabs"},
		{item = "value_med_bloodset"},
		{item = "value_med_haemostatic"},
		{item = "value_med_ibuprofen"},
		{item = "value_med_medicalstock"},
		{item = "value_med_peroxide"},
		{item = "value_med_petroleumjelly"},
		{item = "value_med_saline"},
		{item = "value_med_splint"},
		{item = "value_med_surgicalpouch"},
		{item = "value_med_surgicaltools"},
		{item = "value_med_syringe"},
		{item = "value_med_thermometer"},
		{item = "value_med_tourniquet"},
		{item = "value_med_tourniquet_rubber"},
		{item = "value_med_vitamins"},
	},
}

ix.progression.itemPools.town_expansion_1344ee972c6f = {
	name = "Clinical supplies and trauma equipment: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_med_aquatabs"},
		{item = "value_med_bloodset"},
		{item = "value_med_medicalstock"},
		{item = "value_med_saline"},
		{item = "value_med_splint"},
		{item = "value_med_syringe"},
		{item = "value_med_thermometer"},
		{item = "value_med_tourniquet_rubber"},
	},
}

ix.progression.itemPools.town_expansion_4f3b0e281ad9 = {
	name = "Clinical supplies and trauma equipment: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_med_aquatabs"},
		{item = "value_med_bloodset"},
		{item = "value_med_haemostatic"},
		{item = "value_med_ibuprofen"},
		{item = "value_med_medicalstock"},
		{item = "value_med_peroxide"},
		{item = "value_med_petroleumjelly"},
		{item = "value_med_saline"},
		{item = "value_med_splint"},
		{item = "value_med_surgicalpouch"},
		{item = "value_med_surgicaltools"},
		{item = "value_med_syringe"},
		{item = "value_med_thermometer"},
		{item = "value_med_tourniquet"},
		{item = "value_med_tourniquet_rubber"},
		{item = "value_med_vitamins"},
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

ix.progression.itemPools.town_expansion_a115cb177717 = {
	name = "Workshop tools and fabrication materials: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_hultafors_db5000"},
		{item = "value_key_labyrinth_torch"},
		{item = "value_mining_kit"},
		{item = "value_plexiglass"},
		{item = "value_tapemeasure"},
		{item = "value_tools_metalscissors"},
	},
}

ix.progression.itemPools.town_expansion_f007cba67161 = {
	name = "Workshop tools and fabrication materials: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_hultafors_db5000"},
		{item = "value_key_labyrinth_torch"},
		{item = "value_mining_kit"},
		{item = "value_plexiglass"},
		{item = "value_tapemeasure"},
		{item = "value_tools_metalscissors"},
	},
}

ix.progression.itemPools.town_expansion_93048bf51946 = {
	name = "Workshop tools and fabrication materials: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_building_kektape"},
		{item = "value_crowbar"},
		{item = "value_electricdrill"},
		{item = "value_expandingfoam"},
		{item = "value_hultafors_db5000"},
		{item = "value_key_labyrinth_torch"},
		{item = "value_mining_kit"},
		{item = "value_multitul_0"},
		{item = "value_plexiglass"},
		{item = "value_pliers"},
		{item = "value_tapemeasure"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
		{item = "value_toolset"},
		{item = "value_wd40_400ml"},
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

ix.progression.itemPools.town_expansion_2b4d34254e73 = {
	name = "Workshop tools and fabrication materials: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_building_kektape"},
		{item = "value_crowbar"},
		{item = "value_electricdrill"},
		{item = "value_expandingfoam"},
		{item = "value_hultafors_db5000"},
		{item = "value_key_labyrinth_torch"},
		{item = "value_mining_kit"},
		{item = "value_multitul_0"},
		{item = "value_plexiglass"},
		{item = "value_pliers"},
		{item = "value_tapemeasure"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
		{item = "value_toolset"},
		{item = "value_wd40_400ml"},
	},
}

ix.progression.itemPools.town_expansion_86908d7e5831 = {
	name = "Workshop tools and fabrication materials: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_building_kektape"},
		{item = "value_expandingfoam"},
		{item = "value_key_labyrinth_torch"},
		{item = "value_multitul_0"},
		{item = "value_plexiglass"},
		{item = "value_pliers"},
		{item = "value_tools_pliers_round"},
		{item = "value_toolset"},
	},
}

ix.progression.itemPools.town_expansion_2b209bd707b0 = {
	name = "Workshop tools and fabrication materials: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_building_kektape"},
		{item = "value_expandingfoam"},
		{item = "value_multitul_0"},
		{item = "value_plexiglass"},
		{item = "value_pliers"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
		{item = "value_toolset"},
	},
}

ix.progression.itemPools.town_expansion_a07b5a6724e3 = {
	name = "Workshop tools and fabrication materials: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_building_kektape"},
		{item = "value_crowbar"},
		{item = "value_electricdrill"},
		{item = "value_expandingfoam"},
		{item = "value_hultafors_db5000"},
		{item = "value_key_labyrinth_torch"},
		{item = "value_mining_kit"},
		{item = "value_multitul_0"},
		{item = "value_plexiglass"},
		{item = "value_pliers"},
		{item = "value_tapemeasure"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
		{item = "value_toolset"},
		{item = "value_wd40_400ml"},
	},
}

ix.progression.itemPools.town_expansion_b7200a7f95bb = {
	name = "Workshop tools and fabrication materials: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_building_kektape"},
		{item = "value_expandingfoam"},
		{item = "value_multitul_0"},
		{item = "value_pliers"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
		{item = "value_toolset"},
		{item = "value_wd40_400ml"},
	},
}

ix.progression.itemPools.town_expansion_fd4b6b99785e = {
	name = "Workshop tools and fabrication materials: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_building_kektape"},
		{item = "value_crowbar"},
		{item = "value_expandingfoam"},
		{item = "value_pliers"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
		{item = "value_toolset"},
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

ix.progression.itemPools.town_expansion_d1da9c5aae2f = {
	name = "Workshop tools and fabrication materials: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_building_kektape"},
		{item = "value_crowbar"},
		{item = "value_electricdrill"},
		{item = "value_expandingfoam"},
		{item = "value_hultafors_db5000"},
		{item = "value_key_labyrinth_torch"},
		{item = "value_mining_kit"},
		{item = "value_multitul_0"},
		{item = "value_plexiglass"},
		{item = "value_pliers"},
		{item = "value_tapemeasure"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
		{item = "value_toolset"},
		{item = "value_wd40_400ml"},
	},
}

ix.progression.itemPools.town_expansion_81061404cde0 = {
	name = "Workshop tools and fabrication materials: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic3"},
		{item = "value_ballistic4"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
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

ix.progression.itemPools.town_expansion_63a28dad3590 = {
	name = "Workshop tools and fabrication materials: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_building_kektape"},
		{item = "value_crowbar"},
		{item = "value_electricdrill"},
		{item = "value_expandingfoam"},
		{item = "value_hultafors_db5000"},
		{item = "value_key_labyrinth_torch"},
		{item = "value_mining_kit"},
		{item = "value_multitul_0"},
		{item = "value_plexiglass"},
		{item = "value_pliers"},
		{item = "value_tapemeasure"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
		{item = "value_toolset"},
		{item = "value_wd40_400ml"},
	},
}

ix.progression.itemPools.town_expansion_5ef434e7a351 = {
	name = "Workshop tools and fabrication materials: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic3"},
		{item = "value_ballistic4"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
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

ix.progression.itemPools.town_expansion_cd001154e395 = {
	name = "Workshop tools and fabrication materials: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_building_kektape"},
		{item = "value_crowbar"},
		{item = "value_electricdrill"},
		{item = "value_expandingfoam"},
		{item = "value_hultafors_db5000"},
		{item = "value_key_labyrinth_torch"},
		{item = "value_mining_kit"},
		{item = "value_multitul_0"},
		{item = "value_plexiglass"},
		{item = "value_pliers"},
		{item = "value_tapemeasure"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
		{item = "value_toolset"},
		{item = "value_wd40_400ml"},
	},
}

ix.progression.itemPools.town_expansion_c342ce00082c = {
	name = "Workshop tools and fabrication materials: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic3"},
		{item = "value_ballistic4"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
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

ix.progression.itemPools.town_expansion_14d1beef665c = {
	name = "Consignment paperwork and secure dispatches: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_info_maps"},
		{item = "value_maps"},
		{item = "value_milimap"},
		{item = "value_note_book_coming_closed"},
		{item = "value_officepaper"},
		{item = "value_thick_diary"},
	},
}

ix.progression.itemPools.town_expansion_ced8d202eaf4 = {
	name = "Consignment paperwork and secure dispatches: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_documents_1"},
		{item = "value_flyer_01"},
		{item = "value_flyer_03"},
		{item = "value_gamemagazine_01"},
		{item = "value_note_folder_closed_cardboard"},
		{item = "value_notepad_a6_closed_01"},
	},
}

ix.progression.itemPools.town_expansion_ca46416ba805 = {
	name = "Consignment paperwork and secure dispatches: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_envelope"},
		{item = "value_flyer_02"},
		{item = "value_flyers"},
		{item = "value_gamemagazine_01"},
		{item = "value_info_labrys"},
		{item = "value_note_folder_closed_cardboard"},
		{item = "value_notepad_a5_closed_01"},
		{item = "value_notepad_a6_closed_01"},
	},
}

ix.progression.itemPools.town_expansion_ba8ac3af2b83 = {
	name = "Consignment paperwork and secure dispatches: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_info_maps"},
		{item = "value_maps"},
		{item = "value_milimap"},
		{item = "value_note_book_coming_closed"},
		{item = "value_officepaper"},
		{item = "value_safe_container"},
		{item = "value_thick_diary"},
	},
}

ix.progression.itemPools.town_expansion_d5aa4471b8c2 = {
	name = "Consignment paperwork and secure dispatches: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_envelope"},
		{item = "value_flyer_02"},
		{item = "value_flyers"},
		{item = "value_info_labrys"},
		{item = "value_info_moleskine"},
		{item = "value_note_folder_closed_cardboard"},
		{item = "value_notepad_a5_closed_01"},
		{item = "value_notepad_a6_closed_01"},
	},
}

ix.progression.itemPools.town_expansion_1692368e6fcf = {
	name = "Consignment paperwork and secure dispatches: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_envelope"},
		{item = "value_flyer_02"},
		{item = "value_flyers"},
		{item = "value_info_labrys"},
		{item = "value_info_moleskine"},
		{item = "value_maps"},
		{item = "value_notepad_a5_closed_01"},
		{item = "value_notepad_a6_closed_01"},
	},
}

ix.progression.itemPools.town_expansion_15c57727a4de = {
	name = "Consignment paperwork and secure dispatches: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_envelope"},
		{item = "value_flyer_02"},
		{item = "value_flyers"},
		{item = "value_info_labrys"},
		{item = "value_info_moleskine"},
		{item = "value_maps"},
		{item = "value_notepad_a5_closed_01"},
		{item = "value_officepaper"},
	},
}

ix.progression.itemPools.town_expansion_4d44f19494ce = {
	name = "Consignment paperwork and secure dispatches: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_envelope"},
		{item = "value_info_labrys"},
		{item = "value_info_moleskine"},
		{item = "value_maps"},
		{item = "value_note_newspaper_folded_01"},
		{item = "value_note_newspaper_folded_02"},
		{item = "value_notepad_a5_closed_01"},
		{item = "value_officepaper"},
	},
}

ix.progression.itemPools.town_expansion_25e538b843ac = {
	name = "Consignment paperwork and secure dispatches: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_info_maps"},
		{item = "value_maps"},
		{item = "value_milimap"},
		{item = "value_note_book_coming_closed"},
		{item = "value_officepaper"},
		{item = "value_safe_container"},
		{item = "value_thick_diary"},
	},
}

ix.progression.itemPools.town_expansion_eef3b6f2ad7a = {
	name = "Consignment paperwork and secure dispatches: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_carbon_case"},
		{item = "value_handbook_materials"},
		{item = "value_knife_box_low"},
		{item = "value_manual_lada"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
		{item = "value_small_case"},
	},
}

ix.progression.itemPools.town_expansion_f42a3238f802 = {
	name = "Consignment paperwork and secure dispatches: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_documents_1"},
		{item = "value_envelope"},
		{item = "value_flyer_01"},
		{item = "value_flyer_02"},
		{item = "value_flyer_03"},
		{item = "value_flyers"},
		{item = "value_gamemagazine_01"},
		{item = "value_info_labrys"},
		{item = "value_info_moleskine"},
		{item = "value_maps"},
		{item = "value_note_folder_closed_cardboard"},
		{item = "value_note_newspaper_folded_01"},
		{item = "value_note_newspaper_folded_02"},
		{item = "value_notepad_a5_closed_01"},
		{item = "value_notepad_a6_closed_01"},
		{item = "value_officepaper"},
	},
}

ix.progression.itemPools.town_expansion_e6e419511987 = {
	name = "Consignment paperwork and secure dispatches: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_handbook_materials"},
		{item = "value_knife_box_low"},
		{item = "value_manual_lada"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
		{item = "value_small_case"},
	},
}

ix.progression.itemPools.town_expansion_4d2788de1f2d = {
	name = "Consignment paperwork and secure dispatches: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_handbook_materials"},
		{item = "value_knife_box_low"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
		{item = "value_small_case"},
	},
}

ix.progression.itemPools.town_expansion_2ba084e72d2d = {
	name = "Consignment paperwork and secure dispatches: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_documents_1"},
		{item = "value_envelope"},
		{item = "value_flyer_01"},
		{item = "value_flyer_02"},
		{item = "value_flyer_03"},
		{item = "value_flyers"},
		{item = "value_gamemagazine_01"},
		{item = "value_info_labrys"},
		{item = "value_info_moleskine"},
		{item = "value_maps"},
		{item = "value_note_folder_closed_cardboard"},
		{item = "value_note_newspaper_folded_01"},
		{item = "value_note_newspaper_folded_02"},
		{item = "value_notepad_a5_closed_01"},
		{item = "value_notepad_a6_closed_01"},
		{item = "value_officepaper"},
	},
}

ix.progression.itemPools.town_expansion_2824dbcfe6d8 = {
	name = "Consignment paperwork and secure dispatches: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_handbook_materials"},
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

ix.progression.itemPools.town_expansion_7689c41134ff = {
	name = "Radio infrastructure and network components: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_capacitors"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_c48a3ba1fe73 = {
	name = "Radio infrastructure and network components: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_receiver1"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_7f868b76a42a = {
	name = "Radio infrastructure and network components: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_ais_sart"},
		{item = "value_capacitors"},
		{item = "value_electr_gary_zont"},
		{item = "value_electr_signal_jammer"},
		{item = "value_ir_ms2000"},
		{item = "value_jamming"},
		{item = "value_radio"},
		{item = "value_radio_repeater"},
		{item = "value_receiver1"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_60379d0b699a = {
	name = "Radio infrastructure and network components: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_ais_sart"},
		{item = "value_electr_gary_zont"},
		{item = "value_electr_signal_jammer"},
		{item = "value_jamming"},
		{item = "value_radio_repeater"},
	},
}

ix.progression.itemPools.town_expansion_0a6bb9f5510f = {
	name = "Trail repairs and camp supplies: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_dryfuel"},
		{item = "value_flammable_survlighter"},
		{item = "value_gunoil"},
		{item = "value_paracord"},
		{item = "value_tape_electric"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_e2ad6f9bab62 = {
	name = "Trail repairs and camp supplies: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_crikent_0"},
		{item = "value_dryfuel"},
		{item = "value_flammable_huntermatches"},
		{item = "value_flammable_klean"},
		{item = "value_flammable_survlighter"},
		{item = "value_gascan"},
		{item = "value_gunoil"},
		{item = "value_kerosene_container"},
		{item = "value_lubricant"},
		{item = "value_match"},
		{item = "value_matches"},
		{item = "value_paracord"},
		{item = "value_tape_electric"},
		{item = "value_valuable_kresalo"},
		{item = "value_wire_light"},
		{item = "value_zibbo_0"},
	},
}

ix.progression.itemPools.town_expansion_b5c2fbdb1c86 = {
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

ix.progression.itemPools.town_expansion_2b72ea4f43f9 = {
	name = "Trail repairs and camp supplies: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_crikent_0"},
		{item = "value_dryfuel"},
		{item = "value_flammable_huntermatches"},
		{item = "value_flammable_klean"},
		{item = "value_flammable_survlighter"},
		{item = "value_gascan"},
		{item = "value_gunoil"},
		{item = "value_kerosene_container"},
		{item = "value_lubricant"},
		{item = "value_match"},
		{item = "value_matches"},
		{item = "value_paracord"},
		{item = "value_tape_electric"},
		{item = "value_valuable_kresalo"},
		{item = "value_wire_light"},
		{item = "value_zibbo_0"},
	},
}

ix.progression.itemPools.town_expansion_380290c507fe = {
	name = "Trail repairs and camp supplies: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_crikent_0"},
		{item = "value_dryfuel"},
		{item = "value_flammable_huntermatches"},
		{item = "value_flammable_klean"},
		{item = "value_flammable_survlighter"},
		{item = "value_gascan"},
		{item = "value_gunoil"},
		{item = "value_kerosene_container"},
		{item = "value_lubricant"},
		{item = "value_match"},
		{item = "value_matches"},
		{item = "value_paracord"},
		{item = "value_tape_electric"},
		{item = "value_valuable_kresalo"},
		{item = "value_wire_light"},
		{item = "value_zibbo_0"},
	},
}

ix.progression.itemPools.town_expansion_11d21ef20779 = {
	name = "Trail repairs and camp supplies: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_bedspread"},
		{item = "value_fabric_aramid"},
		{item = "value_fabric_fleece"},
		{item = "value_fabric_ripstop"},
		{item = "value_fabrics1"},
		{item = "value_fabrics2"},
		{item = "value_pliers"},
		{item = "value_rope"},
		{item = "value_ropes"},
		{item = "value_sewingkit"},
		{item = "value_swiss"},
		{item = "value_tarp"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
		{item = "value_tools_sewing"},
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

ix.progression.itemPools.town_expansion_9c0cc96e9858 = {
	name = "Trail repairs and camp supplies: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_crikent_0"},
		{item = "value_dryfuel"},
		{item = "value_flammable_huntermatches"},
		{item = "value_flammable_klean"},
		{item = "value_flammable_survlighter"},
		{item = "value_gascan"},
		{item = "value_gunoil"},
		{item = "value_kerosene_container"},
		{item = "value_lubricant"},
		{item = "value_match"},
		{item = "value_matches"},
		{item = "value_paracord"},
		{item = "value_tape_electric"},
		{item = "value_valuable_kresalo"},
		{item = "value_wire_light"},
		{item = "value_zibbo_0"},
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

ix.progression.itemPools.town_expansion_0a560e2a0220 = {
	name = "Field issue kits and military packing: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_lopouch"},
		{item = "value_retardant1"},
		{item = "value_retardant10"},
		{item = "value_retardant3"},
		{item = "value_retardant4"},
		{item = "value_retardant9"},
	},
}

ix.progression.itemPools.town_expansion_d3529072739c = {
	name = "Field issue kits and military packing: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_container_cardholder"},
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_container_weaponcase"},
		{item = "value_docbag"},
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

ix.progression.itemPools.town_expansion_cdb68b829caa = {
	name = "Field issue kits and military packing: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_container_parls"},
		{item = "value_container_weaponcase"},
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
}

ix.progression.itemPools.town_expansion_0b6d8b4fbf6f = {
	name = "Field issue kits and military packing: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_retardant1"},
		{item = "value_retardant10"},
		{item = "value_retardant11"},
		{item = "value_retardant12"},
		{item = "value_retardant2"},
		{item = "value_retardant6"},
		{item = "value_retardant9"},
	},
}

ix.progression.itemPools.town_expansion_a9671194f353 = {
	name = "Field issue kits and military packing: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_container_cardholder"},
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_container_weaponcase"},
		{item = "value_docbag"},
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
}

ix.progression.itemPools.town_expansion_b80413944f08 = {
	name = "Field issue kits and military packing: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_container_injectorcase"},
		{item = "value_retardant1"},
		{item = "value_retardant10"},
		{item = "value_retardant11"},
		{item = "value_retardant12"},
		{item = "value_retardant2"},
		{item = "value_retardant6"},
	},
}

ix.progression.itemPools.town_expansion_bb6f868952ef = {
	name = "Field issue kits and military packing: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_container_injectorcase"},
		{item = "value_docbag"},
		{item = "value_retardant10"},
		{item = "value_retardant11"},
		{item = "value_retardant12"},
		{item = "value_retardant2"},
		{item = "value_retardant6"},
	},
}

ix.progression.itemPools.town_expansion_867a15727340 = {
	name = "Field issue kits and military packing: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_ammo"},
		{item = "value_container_parls"},
		{item = "value_container_weaponcase"},
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

ix.progression.itemPools.town_expansion_2be74abb2113 = {
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

ix.progression.itemPools.town_expansion_bc2fa5cf5724 = {
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

ix.progression.itemPools.town_expansion_bf3277df53ee = {
	name = "Computer hardware and data media: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_9vbattery"},
		{item = "value_battery"},
		{item = "value_battery_d_0"},
		{item = "value_capacitors"},
		{item = "value_manual_lada"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_99e7f327cb08 = {
	name = "Computer hardware and data media: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_9vbattery"},
		{item = "value_battery"},
		{item = "value_battery_d_0"},
		{item = "value_capacitors"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_b57268c761ed = {
	name = "Computer hardware and data media: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_9vbattery"},
		{item = "value_battery"},
		{item = "value_battery_d_0"},
		{item = "value_capacitors"},
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_guide"},
		{item = "value_handbook_materials"},
		{item = "value_manual_lada"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_7a85b50fb433 = {
	name = "Computer hardware and data media: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_9vbattery"},
		{item = "value_capacitors"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_3a3ab44e09e5 = {
	name = "Computer hardware and data media: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_9vbattery"},
		{item = "value_battery"},
		{item = "value_battery_d_0"},
		{item = "value_capacitors"},
		{item = "value_handbook_materials"},
		{item = "value_manual_lada"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_b92bc1e23d60 = {
	name = "Computer hardware and data media: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_battery_d_0"},
		{item = "value_capacitors"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_8c8654a6c624 = {
	name = "Computer hardware and data media: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_9vbattery"},
		{item = "value_battery"},
		{item = "value_battery_d_0"},
		{item = "value_capacitors"},
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_guide"},
		{item = "value_handbook_materials"},
		{item = "value_manual_lada"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_af44d6118fd8 = {
	name = "Computer hardware and data media: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_battery_d_0"},
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_guide"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_39e0202598f4 = {
	name = "Computer hardware and data media: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_9vbattery"},
		{item = "value_battery"},
		{item = "value_battery_d_0"},
		{item = "value_capacitors"},
		{item = "value_handbook_materials"},
		{item = "value_manual_lada"},
		{item = "value_wire_light"},
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

ix.progression.itemPools.town_expansion_80c787521d7d = {
	name = "Computer hardware and data media: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_9vbattery"},
		{item = "value_battery"},
		{item = "value_battery_d_0"},
		{item = "value_capacitors"},
		{item = "value_electr_card_programmer"},
		{item = "value_flash_card_ironkey"},
		{item = "value_flash_card_ironkey_slider"},
		{item = "value_flash_card_slider"},
		{item = "value_guide"},
		{item = "value_pcpart_cpufan"},
		{item = "value_pcpart_discdrive"},
		{item = "value_pcpart_ram"},
		{item = "value_pda2"},
		{item = "value_pda3"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_15df9e09224f = {
	name = "Computer hardware and data media: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_circuitboard"},
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_electr_components"},
		{item = "value_guide"},
		{item = "value_handbook_materials"},
		{item = "value_ipcamera"},
		{item = "value_lcddirty"},
		{item = "value_manual_lada"},
		{item = "value_militaryboard"},
		{item = "value_sz_1"},
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

ix.progression.itemPools.town_expansion_079f578a1435 = {
	name = "Computer hardware and data media: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_9vbattery"},
		{item = "value_battery"},
		{item = "value_battery_d_0"},
		{item = "value_capacitors"},
		{item = "value_electr_card_programmer"},
		{item = "value_flash_card_ironkey"},
		{item = "value_flash_card_ironkey_slider"},
		{item = "value_flash_card_slider"},
		{item = "value_guide"},
		{item = "value_pcpart_cpufan"},
		{item = "value_pcpart_discdrive"},
		{item = "value_pcpart_ram"},
		{item = "value_pda2"},
		{item = "value_pda3"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_a3d6e7732b73 = {
	name = "Computer hardware and data media: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_circuitboard"},
		{item = "value_clothbook1"},
		{item = "value_clothbook2"},
		{item = "value_electr_components"},
		{item = "value_guide"},
		{item = "value_handbook_materials"},
		{item = "value_ipcamera"},
		{item = "value_lcddirty"},
		{item = "value_manual_lada"},
		{item = "value_militaryboard"},
		{item = "value_sz_1"},
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

ix.progression.itemPools.town_expansion_078508e6263c = {
	name = "Kitchen stores and cooking fuel: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_coffee"},
		{item = "value_household_salt"},
		{item = "value_other_grechka"},
		{item = "value_other_lupo"},
		{item = "value_other_tea"},
		{item = "value_sugar"},
	},
}

ix.progression.itemPools.town_expansion_9852e3d24390 = {
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
		{item = "value_propanetank"},
		{item = "value_sugar"},
	},
}

ix.progression.itemPools.town_expansion_450be1b77576 = {
	name = "Kitchen stores and cooking fuel: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_coffee"},
		{item = "value_gasoline"},
		{item = "value_household_salt"},
		{item = "value_kerosene"},
		{item = "value_other_grechka"},
		{item = "value_other_tea"},
		{item = "value_propanetank"},
		{item = "value_sugar"},
	},
}

ix.progression.itemPools.town_expansion_6a839f7482c6 = {
	name = "Kitchen stores and cooking fuel: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_coffee"},
		{item = "value_gasoline"},
		{item = "value_household_salt"},
		{item = "value_kerosene"},
		{item = "value_other_grechka"},
		{item = "value_other_tea"},
		{item = "value_propanetank"},
		{item = "value_sugar"},
	},
}

ix.progression.itemPools.town_expansion_00b90348348f = {
	name = "Kitchen stores and cooking fuel: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_coffee"},
		{item = "value_gasoline"},
		{item = "value_household_salt"},
		{item = "value_kerosene"},
		{item = "value_other_grechka"},
		{item = "value_other_lupo"},
		{item = "value_other_tea"},
		{item = "value_propanetank"},
		{item = "value_sugar"},
	},
}

ix.progression.itemPools.town_expansion_ddafdcda66bb = {
	name = "Kitchen stores and cooking fuel: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_gasoline"},
		{item = "value_household_salt"},
		{item = "value_kerosene"},
		{item = "value_other_grechka"},
		{item = "value_other_tea"},
		{item = "value_propanetank"},
		{item = "value_sugar"},
	},
}

ix.progression.itemPools.town_expansion_776be98bb3cb = {
	name = "Kitchen stores and cooking fuel: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_gasoline"},
		{item = "value_household_salt"},
		{item = "value_kerosene"},
		{item = "value_other_tea"},
		{item = "value_propanetank"},
		{item = "value_sugar"},
	},
}

ix.progression.itemPools.town_expansion_1e700080e18f = {
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
		{item = "value_propanetank"},
		{item = "value_sugar"},
	},
}

ix.progression.itemPools.town_expansion_62689732dc60 = {
	name = "Kitchen stores and cooking fuel: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_bleach"},
		{item = "value_detergent"},
		{item = "value_dryfuel"},
		{item = "value_flammable_huntermatches"},
		{item = "value_flammable_klean"},
		{item = "value_flammable_survlighter"},
		{item = "value_gascan"},
		{item = "value_glasscleaner"},
		{item = "value_household_toothpaste1"},
		{item = "value_kerosene_container"},
		{item = "value_shampoo"},
		{item = "value_soap"},
		{item = "value_toiletpaper"},
		{item = "value_toothpaste"},
		{item = "value_valuable_kresalo"},
		{item = "value_zibbo_0"},
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

ix.progression.itemPools.town_expansion_dca324fec478 = {
	name = "Kitchen stores and cooking fuel: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_coffee"},
		{item = "value_gasoline"},
		{item = "value_household_salt"},
		{item = "value_kerosene"},
		{item = "value_other_grechka"},
		{item = "value_other_lupo"},
		{item = "value_other_tea"},
		{item = "value_propanetank"},
		{item = "value_sugar"},
	},
}

ix.progression.itemPools.town_expansion_27eb27285361 = {
	name = "Kitchen stores and cooking fuel: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_bleach"},
		{item = "value_detergent"},
		{item = "value_dryfuel"},
		{item = "value_flammable_huntermatches"},
		{item = "value_flammable_klean"},
		{item = "value_flammable_survlighter"},
		{item = "value_gascan"},
		{item = "value_glasscleaner"},
		{item = "value_household_toothpaste1"},
		{item = "value_kerosene_container"},
		{item = "value_shampoo"},
		{item = "value_soap"},
		{item = "value_toiletpaper"},
		{item = "value_toothpaste"},
		{item = "value_valuable_kresalo"},
		{item = "value_zibbo_0"},
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

ix.progression.itemPools.town_expansion_af7d21ff2670 = {
	name = "Kitchen stores and cooking fuel: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_coffee"},
		{item = "value_gasoline"},
		{item = "value_household_salt"},
		{item = "value_kerosene"},
		{item = "value_other_grechka"},
		{item = "value_other_lupo"},
		{item = "value_other_tea"},
		{item = "value_propanetank"},
		{item = "value_sugar"},
	},
}

ix.progression.itemPools.town_expansion_fdac49383f8f = {
	name = "Kitchen stores and cooking fuel: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_bleach"},
		{item = "value_detergent"},
		{item = "value_dryfuel"},
		{item = "value_flammable_huntermatches"},
		{item = "value_flammable_klean"},
		{item = "value_flammable_survlighter"},
		{item = "value_gascan"},
		{item = "value_glasscleaner"},
		{item = "value_household_toothpaste1"},
		{item = "value_kerosene_container"},
		{item = "value_shampoo"},
		{item = "value_soap"},
		{item = "value_toiletpaper"},
		{item = "value_toothpaste"},
		{item = "value_valuable_kresalo"},
		{item = "value_zibbo_0"},
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

ix.progression.itemPools.town_expansion_f9997206707b = {
	name = "Receivers, communications parts and recordings: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_metalparts"},
		{item = "value_parts"},
		{item = "value_screws"},
		{item = "value_upgro1"},
		{item = "value_upgro2"},
		{item = "value_waste_heavy"},
	},
}

ix.progression.itemPools.town_expansion_d3ad5e933a17 = {
	name = "Receivers, communications parts and recordings: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_frequencymodulator"},
		{item = "value_large_parts"},
		{item = "value_metalparts"},
		{item = "value_parts"},
		{item = "value_phone_new"},
		{item = "value_phone_old"},
		{item = "value_screws"},
		{item = "value_upgro1"},
		{item = "value_upgro2"},
		{item = "value_upgro3"},
		{item = "value_upgrw2"},
		{item = "value_upgrw3"},
		{item = "value_waste_heavy"},
		{item = "value_waste_light"},
		{item = "value_weaponparts"},
		{item = "value_wirelesstrans"},
	},
}

ix.progression.itemPools.town_expansion_7cceb0a03856 = {
	name = "Receivers, communications parts and recordings: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_cassette_black90"},
		{item = "value_nails"},
		{item = "value_upgro1"},
		{item = "value_upgro2"},
		{item = "value_upgro3"},
		{item = "value_weaponparts"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_70664e46c8a5 = {
	name = "Receivers, communications parts and recordings: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_archive_cassette"},
		{item = "value_bolts"},
		{item = "value_metalparts"},
		{item = "value_nails"},
		{item = "value_nuts"},
		{item = "value_parts"},
		{item = "value_screws"},
		{item = "value_sparkplug"},
		{item = "value_spec_recorder"},
		{item = "value_tape_electric"},
		{item = "value_upgro1"},
		{item = "value_upgro2"},
		{item = "value_upgro3"},
		{item = "value_waste_heavy"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_f4db51faa1c0 = {
	name = "Receivers, communications parts and recordings: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_battery_d_0"},
		{item = "value_electr_tplug"},
		{item = "value_energy_accum"},
		{item = "value_energy_cyclon"},
		{item = "value_energy_greenbat"},
		{item = "value_helix"},
		{item = "value_kanifol"},
		{item = "value_lamp_efficient"},
		{item = "value_lamp_uv"},
		{item = "value_magnet"},
		{item = "value_militarybattery"},
		{item = "value_powercable"},
		{item = "value_powerfilter"},
		{item = "value_usb_adapter"},
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

ix.progression.itemPools.town_expansion_06c7e7b45627 = {
	name = "Receivers, communications parts and recordings: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_frequencymodulator"},
		{item = "value_large_parts"},
		{item = "value_metalparts"},
		{item = "value_parts"},
		{item = "value_phone_new"},
		{item = "value_phone_old"},
		{item = "value_screws"},
		{item = "value_upgro1"},
		{item = "value_upgro2"},
		{item = "value_upgro3"},
		{item = "value_upgrw2"},
		{item = "value_upgrw3"},
		{item = "value_waste_heavy"},
		{item = "value_waste_light"},
		{item = "value_weaponparts"},
		{item = "value_wirelesstrans"},
	},
}

ix.progression.itemPools.town_expansion_f3a7e106ec1c = {
	name = "Receivers, communications parts and recordings: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_archive_cassette"},
		{item = "value_bolts"},
		{item = "value_metalparts"},
		{item = "value_nails"},
		{item = "value_nuts"},
		{item = "value_parts"},
		{item = "value_screws"},
		{item = "value_sparkplug"},
		{item = "value_spec_recorder"},
		{item = "value_tape_electric"},
		{item = "value_upgro1"},
		{item = "value_upgro2"},
		{item = "value_upgro3"},
		{item = "value_waste_heavy"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_d1a020209080 = {
	name = "Receivers, communications parts and recordings: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_battery_d_0"},
		{item = "value_electr_tplug"},
		{item = "value_energy_accum"},
		{item = "value_energy_cyclon"},
		{item = "value_energy_greenbat"},
		{item = "value_helix"},
		{item = "value_kanifol"},
		{item = "value_lamp_efficient"},
		{item = "value_lamp_uv"},
		{item = "value_magnet"},
		{item = "value_militarybattery"},
		{item = "value_powercable"},
		{item = "value_powerfilter"},
		{item = "value_usb_adapter"},
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

ix.progression.itemPools.town_expansion_4a19ca0768f1 = {
	name = "Receivers, communications parts and recordings: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_bolts"},
		{item = "value_metalparts"},
		{item = "value_nuts"},
		{item = "value_parts"},
		{item = "value_screws"},
		{item = "value_waste_heavy"},
	},
}

ix.progression.itemPools.town_expansion_a3f70d1ba27f = {
	name = "Receivers, communications parts and recordings: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_nails"},
		{item = "value_sparkplug"},
		{item = "value_tape_electric"},
		{item = "value_upgro1"},
		{item = "value_upgro2"},
		{item = "value_upgro3"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_0864622558f9 = {
	name = "Receivers, communications parts and recordings: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_bolts"},
		{item = "value_cassette_black90"},
		{item = "value_metalparts"},
		{item = "value_nails"},
		{item = "value_nuts"},
		{item = "value_parts"},
		{item = "value_screws"},
		{item = "value_sparkplug"},
		{item = "value_tape_electric"},
		{item = "value_upgro1"},
		{item = "value_upgro2"},
		{item = "value_upgro3"},
		{item = "value_waste_heavy"},
		{item = "value_weaponparts"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_377d8f1db330 = {
	name = "Receivers, communications parts and recordings: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_archive_cassette"},
		{item = "value_cassette_black90"},
		{item = "value_cassette_fiolet"},
		{item = "value_nails"},
		{item = "value_upgro1"},
		{item = "value_upgro2"},
		{item = "value_upgro3"},
		{item = "value_weaponparts"},
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

ix.progression.itemPools.town_expansion_81da17cceb15 = {
	name = "Hunting equipment care and field observations: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_gunoil"},
		{item = "value_pliers"},
		{item = "value_swiss"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_4b2888b79c97 = {
	name = "Hunting equipment care and field observations: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_gunoil"},
		{item = "value_info_moleskine"},
		{item = "value_pliers"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_46860f28a864 = {
	name = "Hunting equipment care and field observations: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_awl"},
		{item = "value_guncleaner"},
		{item = "value_gunoil"},
		{item = "value_gunspray"},
		{item = "value_info_maps"},
		{item = "value_info_moleskine"},
		{item = "value_lubricant"},
		{item = "value_maps"},
		{item = "value_milimap"},
		{item = "value_pliers"},
		{item = "value_swiss"},
		{item = "value_thick_diary"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_9d7bd0fa3203 = {
	name = "Hunting equipment care and field observations: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_info_moleskine"},
		{item = "value_maps"},
		{item = "value_milimap"},
		{item = "value_pliers"},
		{item = "value_swiss"},
		{item = "value_thick_diary"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_2453b1622777 = {
	name = "Hunting equipment care and field observations: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_awl"},
		{item = "value_guncleaner"},
		{item = "value_gunoil"},
		{item = "value_gunspray"},
		{item = "value_lubricant"},
		{item = "value_pliers"},
		{item = "value_swiss"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_79c06143a76d = {
	name = "Hunting equipment care and field observations: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_gunspray"},
		{item = "value_info_moleskine"},
		{item = "value_maps"},
		{item = "value_milimap"},
		{item = "value_swiss"},
		{item = "value_thick_diary"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_707d65dea71d = {
	name = "Hunting equipment care and field observations: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_awl"},
		{item = "value_guncleaner"},
		{item = "value_gunoil"},
		{item = "value_gunspray"},
		{item = "value_info_maps"},
		{item = "value_info_moleskine"},
		{item = "value_lubricant"},
		{item = "value_maps"},
		{item = "value_milimap"},
		{item = "value_pliers"},
		{item = "value_swiss"},
		{item = "value_thick_diary"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_a64750b77a87 = {
	name = "Hunting equipment care and field observations: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_guncleaner"},
		{item = "value_info_moleskine"},
		{item = "value_lubricant"},
		{item = "value_maps"},
		{item = "value_pliers"},
		{item = "value_thick_diary"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_67b16c2b8dd0 = {
	name = "Hunting equipment care and field observations: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_info_moleskine"},
		{item = "value_lubricant"},
		{item = "value_maps"},
		{item = "value_milimap"},
		{item = "value_pliers"},
		{item = "value_thick_diary"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_17388ddfb4af = {
	name = "Hunting equipment care and field observations: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_info_maps"},
		{item = "value_info_moleskine"},
		{item = "value_lubricant"},
		{item = "value_maps"},
		{item = "value_milimap"},
		{item = "value_thick_diary"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_f90cbd1a38e0 = {
	name = "Hunting equipment care and field observations: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_awl"},
		{item = "value_guncleaner"},
		{item = "value_gunoil"},
		{item = "value_gunspray"},
		{item = "value_lubricant"},
		{item = "value_pliers"},
		{item = "value_swiss"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_d3512ab9afe7 = {
	name = "Hunting equipment care and field observations: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_awl"},
		{item = "value_electro_gyroscope"},
		{item = "value_gyrotachometer"},
		{item = "value_optical_lens"},
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

ix.progression.itemPools.town_expansion_26dee0f0dae1 = {
	name = "Hunting equipment care and field observations: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_awl"},
		{item = "value_guncleaner"},
		{item = "value_gunoil"},
		{item = "value_gunspray"},
		{item = "value_info_maps"},
		{item = "value_info_moleskine"},
		{item = "value_lubricant"},
		{item = "value_maps"},
		{item = "value_milimap"},
		{item = "value_pliers"},
		{item = "value_swiss"},
		{item = "value_thick_diary"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_a01798fd35ac = {
	name = "Hunting equipment care and field observations: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_awl"},
		{item = "value_electro_gyroscope"},
		{item = "value_gyroscope"},
		{item = "value_gyrotachometer"},
		{item = "value_optical_lens"},
		{item = "value_pliers"},
		{item = "value_pressuregauge"},
		{item = "value_sensor_a"},
		{item = "value_sensor_d"},
		{item = "value_swiss"},
		{item = "value_thermalmodule"},
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

ix.progression.itemPools.town_expansion_7eaf2f13e938 = {
	name = "Hunting equipment care and field observations: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_awl"},
		{item = "value_guncleaner"},
		{item = "value_gunoil"},
		{item = "value_gunspray"},
		{item = "value_info_maps"},
		{item = "value_info_moleskine"},
		{item = "value_lubricant"},
		{item = "value_maps"},
		{item = "value_milimap"},
		{item = "value_pliers"},
		{item = "value_swiss"},
		{item = "value_thick_diary"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_299bbe142b4b = {
	name = "Hunting equipment care and field observations: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_awl"},
		{item = "value_electro_gyroscope"},
		{item = "value_gyroscope"},
		{item = "value_gyrotachometer"},
		{item = "value_optical_lens"},
		{item = "value_pliers"},
		{item = "value_pressuregauge"},
		{item = "value_sensor_a"},
		{item = "value_sensor_d"},
		{item = "value_swiss"},
		{item = "value_thermalmodule"},
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

ix.progression.itemPools.town_expansion_4f326e70072d = {
	name = "Cloth, protective layers and sewing supplies: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_bedspread"},
		{item = "value_fabric_aramid"},
		{item = "value_fabrics1"},
		{item = "value_fabrics2"},
		{item = "value_rope"},
		{item = "value_ropes"},
	},
}

ix.progression.itemPools.town_expansion_92fb932ff1c5 = {
	name = "Cloth, protective layers and sewing supplies: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_bedspread"},
		{item = "value_fabric_aramid"},
		{item = "value_fabrics1"},
		{item = "value_fabrics2"},
		{item = "value_retardant1"},
		{item = "value_retardant10"},
		{item = "value_retardant11"},
		{item = "value_retardant12"},
		{item = "value_retardant3"},
		{item = "value_retardant4"},
		{item = "value_retardant9"},
		{item = "value_rope"},
		{item = "value_ropes"},
		{item = "value_sewingkit"},
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

ix.progression.itemPools.town_expansion_6ffc7ac7f5d1 = {
	name = "Cloth, protective layers and sewing supplies: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_fabric_cordura"},
		{item = "value_fabric_fleece"},
		{item = "value_fabric_ripstop"},
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
}

ix.progression.itemPools.town_expansion_3acf0f035059 = {
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

ix.progression.itemPools.town_expansion_0b1245b6e79e = {
	name = "Cloth, protective layers and sewing supplies: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_bedspread"},
		{item = "value_fabric_aramid"},
		{item = "value_fabrics1"},
		{item = "value_fabrics2"},
		{item = "value_retardant1"},
		{item = "value_retardant10"},
		{item = "value_retardant11"},
		{item = "value_retardant12"},
		{item = "value_retardant3"},
		{item = "value_retardant4"},
		{item = "value_retardant9"},
		{item = "value_rope"},
		{item = "value_ropes"},
		{item = "value_sewingkit"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_d941dc81b901 = {
	name = "Cloth, protective layers and sewing supplies: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_retardant1"},
		{item = "value_retardant3"},
		{item = "value_retardant4"},
		{item = "value_retardant9"},
		{item = "value_ropes"},
		{item = "value_sewingkit"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_2b18fb90c7bf = {
	name = "Cloth, protective layers and sewing supplies: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_retardant1"},
		{item = "value_retardant10"},
		{item = "value_retardant3"},
		{item = "value_retardant4"},
		{item = "value_retardant9"},
		{item = "value_sewingkit"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_222a2f2dcf66 = {
	name = "Cloth, protective layers and sewing supplies: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_retardant1"},
		{item = "value_retardant10"},
		{item = "value_retardant11"},
		{item = "value_retardant3"},
		{item = "value_retardant4"},
		{item = "value_retardant9"},
		{item = "value_sewingkit"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_6f85ea5be266 = {
	name = "Cloth, protective layers and sewing supplies: general supplies (Waystation)",
	tier = "common",
	candidates = {
		{item = "value_fabric_cordura"},
		{item = "value_fabric_fleece"},
		{item = "value_fabric_ripstop"},
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
}

ix.progression.itemPools.town_expansion_77bed644606f = {
	name = "Cloth, protective layers and sewing supplies: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_awl"},
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic3"},
		{item = "value_ballistic4"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
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

ix.progression.itemPools.town_expansion_02c827324460 = {
	name = "Cloth, protective layers and sewing supplies: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_bedspread"},
		{item = "value_fabric_aramid"},
		{item = "value_fabrics1"},
		{item = "value_fabrics2"},
		{item = "value_retardant1"},
		{item = "value_retardant10"},
		{item = "value_retardant11"},
		{item = "value_retardant12"},
		{item = "value_retardant3"},
		{item = "value_retardant4"},
		{item = "value_retardant9"},
		{item = "value_rope"},
		{item = "value_ropes"},
		{item = "value_sewingkit"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_708945232835 = {
	name = "Cloth, protective layers and sewing supplies: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_awl"},
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic3"},
		{item = "value_ballistic4"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
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

ix.progression.itemPools.town_expansion_10904788249e = {
	name = "Cloth, protective layers and sewing supplies: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_bedspread"},
		{item = "value_fabric_aramid"},
		{item = "value_fabrics1"},
		{item = "value_fabrics2"},
		{item = "value_retardant1"},
		{item = "value_retardant10"},
		{item = "value_retardant11"},
		{item = "value_retardant12"},
		{item = "value_retardant3"},
		{item = "value_retardant4"},
		{item = "value_retardant9"},
		{item = "value_rope"},
		{item = "value_ropes"},
		{item = "value_sewingkit"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_aeaa200e6d7f = {
	name = "Cloth, protective layers and sewing supplies: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_awl"},
		{item = "value_ballistic1"},
		{item = "value_ballistic11"},
		{item = "value_ballistic3"},
		{item = "value_ballistic4"},
		{item = "value_ballistic6"},
		{item = "value_ballistic7"},
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

ix.progression.itemPools.town_expansion_2f020af62913 = {
	name = "Cloth, protective layers and sewing supplies: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_fabrics1"},
		{item = "value_retardant3"},
		{item = "value_retardant4"},
		{item = "value_retardant9"},
		{item = "value_ropes"},
		{item = "value_sewingkit"},
		{item = "value_tarp"},
		{item = "value_tools_sewing"},
	},
}

ix.progression.itemPools.town_expansion_c7169f14696b = {
	name = "Precision tools and mechanical repair parts: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_bolts"},
		{item = "value_glue_1"},
		{item = "value_glue_2"},
		{item = "value_glue_3"},
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

ix.progression.itemPools.town_expansion_3d13120ddff7 = {
	name = "Precision tools and mechanical repair parts: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_bolts"},
		{item = "value_glue_1"},
		{item = "value_glue_2"},
		{item = "value_glue_3"},
		{item = "value_glue_4"},
		{item = "value_hose"},
		{item = "value_lightbulb"},
		{item = "value_nails"},
		{item = "value_nuts"},
		{item = "value_paracord"},
		{item = "value_siliconetube"},
		{item = "value_sparkplug"},
		{item = "value_tape_duct"},
		{item = "value_tape_electric"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_a7b9149f8af2 = {
	name = "Precision tools and mechanical repair parts: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_glue_1"},
		{item = "value_glue_3"},
		{item = "value_glue_4"},
		{item = "value_hose"},
		{item = "value_lightbulb"},
		{item = "value_nails"},
		{item = "value_tape_duct"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_dad62e7585ad = {
	name = "Precision tools and mechanical repair parts: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_paracord"},
		{item = "value_siliconetube"},
		{item = "value_tape_electric"},
		{item = "value_tools_ratchetwrench"},
		{item = "value_upgro1"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
		{item = "value_wrench"},
	},
}

ix.progression.itemPools.town_expansion_6439a6f8a7e9 = {
	name = "Precision tools and mechanical repair parts: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_hose"},
		{item = "value_paracord"},
		{item = "value_siliconetube"},
		{item = "value_tools_ratchetwrench"},
		{item = "value_upgro1"},
		{item = "value_upgro2"},
		{item = "value_wire_copper"},
		{item = "value_wrench"},
	},
}

ix.progression.itemPools.town_expansion_13f1649aba56 = {
	name = "Precision tools and mechanical repair parts: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_hose"},
		{item = "value_lightbulb"},
		{item = "value_paracord"},
		{item = "value_tools_ratchetwrench"},
		{item = "value_upgro1"},
		{item = "value_upgro2"},
		{item = "value_upgro3"},
		{item = "value_wrench"},
	},
}

ix.progression.itemPools.town_expansion_4673dd0551bc = {
	name = "Precision tools and mechanical repair parts: general supplies (Marsh)",
	tier = "common",
	candidates = {
		{item = "value_bolts"},
		{item = "value_glue_1"},
		{item = "value_glue_2"},
		{item = "value_glue_3"},
		{item = "value_glue_4"},
		{item = "value_hose"},
		{item = "value_lightbulb"},
		{item = "value_nails"},
		{item = "value_nuts"},
		{item = "value_paracord"},
		{item = "value_siliconetube"},
		{item = "value_sparkplug"},
		{item = "value_tape_duct"},
		{item = "value_tape_electric"},
		{item = "value_wire_copper"},
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

ix.progression.itemPools.town_expansion_92bc90ddebaf = {
	name = "Precision tools and mechanical repair parts: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_bolts"},
		{item = "value_glue_1"},
		{item = "value_glue_2"},
		{item = "value_glue_3"},
		{item = "value_glue_4"},
		{item = "value_metalparts"},
		{item = "value_nuts"},
		{item = "value_paracord"},
		{item = "value_screws"},
		{item = "value_siliconetube"},
		{item = "value_sparkplug"},
		{item = "value_tape_electric"},
		{item = "value_tools_advwrench"},
		{item = "value_waste_heavy"},
		{item = "value_wire_copper"},
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

ix.progression.itemPools.town_expansion_26499ce470b2 = {
	name = "Precision tools and mechanical repair parts: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_bolts"},
		{item = "value_glue_1"},
		{item = "value_glue_2"},
		{item = "value_glue_3"},
		{item = "value_glue_4"},
		{item = "value_metalparts"},
		{item = "value_nuts"},
		{item = "value_paracord"},
		{item = "value_screws"},
		{item = "value_siliconetube"},
		{item = "value_sparkplug"},
		{item = "value_tape_electric"},
		{item = "value_tools_advwrench"},
		{item = "value_waste_heavy"},
		{item = "value_wire_copper"},
		{item = "value_wire_light"},
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

ix.progression.itemPools.town_expansion_409e675b1118 = {
	name = "Expedition instruments and field preparation: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_container_lopouch"},
		{item = "value_gunoil"},
		{item = "value_pliers"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_f4d04381205b = {
	name = "Expedition instruments and field preparation: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_container_lopouch"},
		{item = "value_gunoil"},
		{item = "value_paracord"},
		{item = "value_tape_electric"},
		{item = "value_tools_metalscissors"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_a823fcf29a01 = {
	name = "Expedition instruments and field preparation: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_awl"},
		{item = "value_container_cardholder"},
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
		{item = "value_gunoil"},
		{item = "value_lubricant"},
		{item = "value_paracord"},
		{item = "value_pliers"},
		{item = "value_swiss"},
		{item = "value_tape_electric"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_97ae0fe853de = {
	name = "Expedition instruments and field preparation: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_paracord"},
		{item = "value_pliers"},
		{item = "value_tape_electric"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_df78f75b1497 = {
	name = "Expedition instruments and field preparation: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_paracord"},
		{item = "value_pliers"},
		{item = "value_swiss"},
		{item = "value_tape_electric"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_43b520596561 = {
	name = "Expedition instruments and field preparation: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_awl"},
		{item = "value_container_cardholder"},
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
		{item = "value_gunoil"},
		{item = "value_lubricant"},
		{item = "value_pliers"},
		{item = "value_swiss"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_72c916d0abcb = {
	name = "Expedition instruments and field preparation: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_paracord"},
		{item = "value_pliers"},
		{item = "value_swiss"},
		{item = "value_tape_electric"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_05132b8d0238 = {
	name = "Expedition instruments and field preparation: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_awl"},
		{item = "value_container_cardholder"},
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
		{item = "value_gunoil"},
		{item = "value_lubricant"},
		{item = "value_paracord"},
		{item = "value_pliers"},
		{item = "value_swiss"},
		{item = "value_tape_electric"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_e8bd5202b929 = {
	name = "Expedition instruments and field preparation: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_paracord"},
		{item = "value_pliers"},
		{item = "value_swiss"},
		{item = "value_tape_electric"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_51ebdbd40920 = {
	name = "Expedition instruments and field preparation: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
		{item = "value_gunoil"},
		{item = "value_lubricant"},
		{item = "value_paracord"},
		{item = "value_pliers"},
		{item = "value_pressuregauge"},
		{item = "value_sensor_a"},
		{item = "value_swiss"},
		{item = "value_tape_electric"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_54371b32c140 = {
	name = "Expedition instruments and field preparation: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_lubricant"},
		{item = "value_pliers"},
		{item = "value_pressuregauge"},
		{item = "value_swiss"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_a3908ffe8d9d = {
	name = "Expedition instruments and field preparation: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_lubricant"},
		{item = "value_pressuregauge"},
		{item = "value_swiss"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_a44245ac02ff = {
	name = "Expedition instruments and field preparation: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_pressuregauge"},
		{item = "value_swiss"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_53f9dde5b77b = {
	name = "Expedition instruments and field preparation: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_awl"},
		{item = "value_container_cardholder"},
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
		{item = "value_gunoil"},
		{item = "value_lubricant"},
		{item = "value_pliers"},
		{item = "value_swiss"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
	},
}

ix.progression.itemPools.town_expansion_04ec9aa9092f = {
	name = "Expedition instruments and field preparation: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_chemcontainer"},
		{item = "value_container_cardholder"},
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
		{item = "value_event_labyrinth_chem_container"},
		{item = "value_portable_container_closed"},
		{item = "value_portable_container_opened"},
		{item = "value_quest_biohazard_case"},
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

ix.progression.itemPools.town_expansion_9b08d7a6b279 = {
	name = "Expedition instruments and field preparation: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
		{item = "value_gunoil"},
		{item = "value_lubricant"},
		{item = "value_paracord"},
		{item = "value_pliers"},
		{item = "value_pressuregauge"},
		{item = "value_sensor_a"},
		{item = "value_swiss"},
		{item = "value_tape_electric"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_431c32d21d4a = {
	name = "Expedition instruments and field preparation: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_chemcontainer"},
		{item = "value_container_cardholder"},
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
		{item = "value_event_labyrinth_chem_container"},
		{item = "value_portable_container_closed"},
		{item = "value_portable_container_opened"},
		{item = "value_quest_biohazard_case"},
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

ix.progression.itemPools.town_expansion_06860f39be0d = {
	name = "Expedition instruments and field preparation: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
		{item = "value_gunoil"},
		{item = "value_lubricant"},
		{item = "value_paracord"},
		{item = "value_pliers"},
		{item = "value_pressuregauge"},
		{item = "value_sensor_a"},
		{item = "value_swiss"},
		{item = "value_tape_electric"},
		{item = "value_tools_metalscissors"},
		{item = "value_tools_nippers"},
		{item = "value_tools_pliers_round"},
		{item = "value_wire_light"},
	},
}

ix.progression.itemPools.town_expansion_76588b984896 = {
	name = "Expedition instruments and field preparation: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_chemcontainer"},
		{item = "value_container_cardholder"},
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
		{item = "value_event_labyrinth_chem_container"},
		{item = "value_portable_container_closed"},
		{item = "value_portable_container_opened"},
		{item = "value_quest_biohazard_case"},
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

ix.progression.itemPools.town_expansion_8e7f590bf612 = {
	name = "Personal effects and recovered belongings: general supplies (Garbage)",
	tier = "common",
	candidates = {
		{item = "value_container_cardholder"},
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
		{item = "value_watch"},
	},
}

ix.progression.itemPools.town_expansion_ef16b6d5da9d = {
	name = "Personal effects and recovered belongings: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_crow_beak"},
		{item = "value_docbag"},
		{item = "value_lightkeeper_amulet"},
	},
}

ix.progression.itemPools.town_expansion_3a98413f7be1 = {
	name = "Personal effects and recovered belongings: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_container_cardholder"},
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_crow_beak"},
		{item = "value_docbag"},
		{item = "value_goldchain"},
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

ix.progression.itemPools.town_expansion_30b09f9b3823 = {
	name = "Personal effects and recovered belongings: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_crow_beak"},
		{item = "value_docbag"},
		{item = "value_lightkeeper_amulet"},
	},
}

ix.progression.itemPools.town_expansion_03a9328806d6 = {
	name = "Personal effects and recovered belongings: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_container_cardholder"},
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_crow_beak"},
		{item = "value_docbag"},
		{item = "value_goldchain"},
		{item = "value_lightkeeper_amulet"},
		{item = "value_watch"},
	},
}

ix.progression.itemPools.town_expansion_d050133279ce = {
	name = "Personal effects and recovered belongings: general supplies (Marsh, Garbage)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
		{item = "value_lightkeeper_amulet"},
	},
}

ix.progression.itemPools.town_expansion_80b756dba629 = {
	name = "Personal effects and recovered belongings: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_cardholder"},
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_crow_beak"},
		{item = "value_docbag"},
		{item = "value_goldchain"},
		{item = "value_lightkeeper_amulet"},
		{item = "value_watch"},
	},
}

ix.progression.itemPools.town_expansion_703d74c6da26 = {
	name = "Personal effects and recovered belongings: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_injectorcase"},
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
		{item = "value_lightkeeper_amulet"},
	},
}

ix.progression.itemPools.town_expansion_85979a57a122 = {
	name = "Personal effects and recovered belongings: general supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_container_smallitems"},
		{item = "value_docbag"},
		{item = "value_lightkeeper_amulet"},
	},
}

ix.progression.itemPools.town_expansion_3501889212d9 = {
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

ix.progression.itemPools.town_expansion_8f40472ef8f5 = {
	name = "Personal effects and recovered belongings: supporting supplies (Marsh, Garbage, Waystation)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_carbon_case"},
		{item = "value_envelope"},
		{item = "value_knife_box_low"},
		{item = "value_note_folder_closed_cardboard"},
		{item = "value_notepad_a5_closed_01"},
		{item = "value_notepad_a6_closed_01"},
		{item = "value_officepaper"},
		{item = "value_parcel"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
		{item = "value_small_case"},
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

ix.progression.itemPools.town_expansion_383d0ddf3e93 = {
	name = "Personal effects and recovered belongings: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_container_cardholder"},
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_crow_beak"},
		{item = "value_docbag"},
		{item = "value_goldchain"},
		{item = "value_lightkeeper_amulet"},
		{item = "value_watch"},
	},
}

ix.progression.itemPools.town_expansion_243a967d3c85 = {
	name = "Personal effects and recovered belongings: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_carbon_case"},
		{item = "value_envelope"},
		{item = "value_knife_box_low"},
		{item = "value_note_folder_closed_cardboard"},
		{item = "value_notepad_a5_closed_01"},
		{item = "value_notepad_a6_closed_01"},
		{item = "value_officepaper"},
		{item = "value_parcel"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
		{item = "value_small_case"},
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

ix.progression.itemPools.town_expansion_66622a11fcf6 = {
	name = "Personal effects and recovered belongings: general supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_container_cardholder"},
		{item = "value_container_injectorcase"},
		{item = "value_container_lopouch"},
		{item = "value_container_smallitems"},
		{item = "value_crow_beak"},
		{item = "value_docbag"},
		{item = "value_goldchain"},
		{item = "value_lightkeeper_amulet"},
		{item = "value_watch"},
	},
}

ix.progression.itemPools.town_expansion_2ba4a2b2e5b5 = {
	name = "Personal effects and recovered belongings: supporting supplies (Marsh, Garbage, Waystation, Pripyat)",
	tier = "common",
	candidates = {
		{item = "value_briefcase"},
		{item = "value_carbon_case"},
		{item = "value_envelope"},
		{item = "value_knife_box_low"},
		{item = "value_note_folder_closed_cardboard"},
		{item = "value_notepad_a5_closed_01"},
		{item = "value_notepad_a6_closed_01"},
		{item = "value_officepaper"},
		{item = "value_parcel"},
		{item = "value_pukt90"},
		{item = "value_security_box"},
		{item = "value_small_case"},
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
