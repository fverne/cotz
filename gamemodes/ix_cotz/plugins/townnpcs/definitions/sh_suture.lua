PLUGIN:Register("suture", {
	name = "'Suture'",
	template = "suturenpc",
	map = "rp_waystation",
	job = {
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		category = "Textile supply deliveries",
		description = "Textile supply deliveries",
		pools = {"town_textiles"},
		deliveryTiers = {
			easy = {
				pools = {
					"valuables_textile_supplies",
					"valuables_equipment_pouches",
				},
				quantity = 1,
			},
			medium = {
				pools = {
					"valuables_protective_textiles",
				},
				quantity = 1,
			},
			hard = {
				pools = {
					"valuables_armour_panels",
				},
				quantity = 2,
			},
		},
		quantities = {2, 4, 7},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Sewing stock (trade goods)",
				items = {"value_sewingkit", "value_tools_sewing"}},
			{label = "Reinforcement stock (trade goods)",
				items = {"value_tape_duct", "value_tape_heavy"}},
			{label = "Expedition provisions",
				items = {"food_raisins", "drink_bottlewater"}},
		},
		bonusItems = {
			"attachment_fabric_1",
			"attachment_fabric_2",
		},
	},
	dialogue = {
		delivery = "Set it down carefully. I want to see what condition it arrived in.",
		completedGreeting = (
			"Come in. Put your pack down carefully; I'd like to hear how the equipment has been treating "
			.. "you."
		),
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Repair and carrying supplies. Bring what's on the list; I'll check what is fit to use. Keep the "
			.. "textiles out of the wet and away from sharp salvage. I'd prefer to judge the material before your "
			.. "packing gives it a second career as rags."
		),
		progressionPrompt = "What else needs doing?",
		progression = (
			"There are materials to collect and fitting records to recover. Show me which job you're "
			.. "considering. I need sound material and patterns I can actually examine. A little care before the "
			.. "work reaches the bench saves a surprising amount afterwards."
		),
	},
	catalogue = {
		["backpack_sling"] = {step = "SU01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_duffle"] = {step = "SU03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_sanitar"] = {step = "SU03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_tbag"] = {step = "SU05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_tourist"] = {step = "SU05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_takedown_1"] = {step = "SU07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_takedown_2"] = {step = "SU07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_mbss"] = {step = "SU09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_vkbo"] = {step = "SU09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_pilgrim"] = {step = "SU11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_scavbackpack"] = {step = "SU11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_1"] = {step = "SU13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_3"] = {step = "SU15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_2"] = {step = "SU17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_1_large"] = {step = "SU19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_3_large"] = {step = "SU21",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_2_large"] = {step = "SU23",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_trenchcoat_black"] = {step = "SU05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_trenchcoat_brown"] = {step = "SU05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_trenchcoat_green"] = {step = "SU05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_trenchcoat_tan"] = {step = "SU05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "SU01",
			completionCash = 275,
			name = "A Bench and a Needle",
			kind = "delivery",
			requires = {},
			briefing = (
				"I need the textiles on this list. Bring them here and let me see what condition they're in. "
				.. "There is a difference between material that's worn and material that has already given up; "
				.. "I'd like to decide which before cutting anything."
			),
			completion = (
				"Good. Put them on the bench. I'll sort them before I start. And thank you for bringing the "
				.. "material in a state where I can actually see what I have to work with."
			),
			requirements = {
				{
					pool = "town_textiles",
					quantity = 2,
				},
			},
			benefits = {
				items = {
					{
						item = "drink_bottlewater",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "SU02",
			completionCash = 450,
			name = "The Missing Pattern",
			kind = "field",
			objective = "Recover Official File Folder from the assigned search area in Waystation. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SU01"},
			briefing = "Recover a workshop pattern case in Waystation territory.",
			completion = "Keep it together. I want to see how it was packed.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_official",
				label = "The Missing Pattern - Official File Folder",
			},
			benefits = {},
		},
		{
			id = "SU03",
			completionCash = 0,
			name = "Seams That Hold",
			kind = "tracker",
			requires = {"SU02"},
			briefing = "Repair and carrying supplies. Bring what's on the list; I'll check what is fit to use.",
			completion = "You've kept the materials coming. I have something worth working with now.",
			target = 2,
			benefits = {},
		},
		{
			id = "SU04",
			completionCash = 650,
			name = "A Broken Strap",
			kind = "field",
			objective = "Recover Striped Equipment Case from the assigned search area in Waystation. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"SU03"},
			briefing = "Recover a freight worker's equipment case.",
			completion = "Let me look at the measurements.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_equipment",
				label = "A Broken Strap - Striped Equipment Case",
			},
			benefits = {},
		},
		{
			id = "SU05",
			completionCash = 575,
			name = "Cloth for the Weather",
			kind = "delivery",
			requires = {"SU04"},
			briefing = "Bring the supplies listed here. Let me check the condition before putting them to use.",
			completion = "Yes, I can use this.",
			requirements = {
				{
					pool = "town_textiles",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "SU06",
			completionCash = 850,
			name = "The Forgotten Measurements",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Waystation. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SU04"},
			briefing = "Retrieve a fitting record at a regional workshop.",
			completion = "Thank you. I'll examine it at the bench.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "The Forgotten Measurements - Tied Leather Journal",
			},
			benefits = {
				items = {
					{
						item = "medic_bandage_1",
						data = {
							quantity = 1,
						},
					},
				},
			},
			stock = {
				item = "drink_bottlewater",
				bonus = 1,
			},
		},
		{
			id = "SU07",
			completionCash = 0,
			name = "A Proper Fit",
			kind = "tracker",
			requires = {"SU05"},
			briefing = "Repair and carrying supplies. Bring what's on the list; I'll check what is fit to use.",
			completion = "You've kept the materials coming. I have something worth working with now.",
			target = 5,
			benefits = {},
		},
		{
			id = "SU08",
			completionCash = 1050,
			name = "The Workshop Scrapbook",
			kind = "field",
			objective = "Recover Scientist's Field Diary from the assigned search area in Garbage. Deliver it to"
				.. " 'Latch' in Garbage, then return here to finish the assignment.",
			requires = {"SU06"},
			briefing = "Recover materials notes in Garbage.",
			completion = "In their hands, then. Good. A specification is no use folded up in your pocket.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_diary",
				label = "The Workshop Scrapbook - Scientist's Field Diary",
				recipient = "latch",
			},
			benefits = {},
		},
		{
			id = "SU09",
			completionCash = 875,
			name = "Load Before Luxury",
			kind = "delivery",
			requires = {"SU07"},
			briefing = "Bring the supplies listed here. Let me check the condition before putting them to use.",
			completion = "Good. Set it on the clean side of the table.",
			requirements = {
				{
					pool = "town_textiles",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "SU10",
			completionCash = 1250,
			name = "The Loaded Pack",
			kind = "field",
			objective = "Recover Numbered Data Module 0013 from the assigned search area in Waystation. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"SU08"},
			briefing = "Retrieve a field-test recorder along a freight route.",
			completion = "Let me look at the measurements.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_module",
				label = "The Loaded Pack - Numbered Data Module 0013",
			},
			benefits = {},
		},
		{
			id = "SU11",
			completionCash = 0,
			name = "Built to Last",
			kind = "tracker",
			requires = {"SU09"},
			briefing = "Repair and carrying supplies. Bring what's on the list; I'll check what is fit to use.",
			completion = "You've kept the materials coming. I have something worth working with now.",
			target = 9,
			benefits = {},
		},
		{
			id = "SU12",
			completionCash = 1450,
			name = "The Quartermaster's Specification",
			kind = "field",
			objective = "Recover Official File Folder from the assigned search area in Waystation. Deliver it to"
				.. " 'Quartermaster' in Waystation, then return here to finish the assignment.",
			requires = {"SU10"},
			briefing = "Recover an equipment specification at a remote supply site.",
			completion = "In their hands, then. Good. A specification is no use folded up in your pocket.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_official",
				label = "The Quartermaster's Specification - Official File Folder",
				recipient = "quartermaster",
			},
			benefits = {
				items = {
					{
						item = "lowtiercookerfuel",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "SU13",
			completionCash = 1175,
			name = "More Than Canvas",
			kind = "delivery",
			requires = {"SU11"},
			briefing = (
				"Bring the supplies listed here. Let me check the condition before putting them to use. "
				.. "Check the packing before you set out. I'd rather spend the afternoon working with what "
				.. "arrives than undoing damage from the journey."
			),
			completion = (
				"Let me check it for damage first. Thank you. I'll look at it in good light. You may sit "
				.. "down, provided you move that folded material first."
			),
			requirements = {
				{
					pool = "town_textiles",
					quantity = 4,
				},
			},
			benefits = {},
		},
		{
			id = "SU14",
			completionCash = 1650,
			name = "The Failed Seam",
			kind = "field",
			objective = "Recover Worn Striped Equipment Case from the assigned search area in Waystation. Return it"
				.. " to this contact to finish the assignment.",
			requires = {"SU12"},
			briefing = "Recover a damaged trial case in regional ruins.",
			completion = "Keep it together. I want to see how it was packed.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_worncase",
				label = "The Failed Seam - Worn Striped Equipment Case",
			},
			benefits = {},
		},
		{
			id = "SU15",
			completionCash = 0,
			name = "Work Under Weight",
			kind = "tracker",
			requires = {"SU13"},
			briefing = "Repair and carrying supplies. Bring what's on the list; I'll check what is fit to use.",
			completion = "You've kept the materials coming. I have something worth working with now.",
			target = 14,
			benefits = {},
		},
		{
			id = "SU16",
			completionCash = 1850,
			name = "The Long Expedition's Kit",
			kind = "field",
			objective = "Recover Personnel File Folder from the assigned search area in Waystation. Deliver it to"
				.. " 'Ledger' in Waystation, then return here to finish the assignment.",
			requires = {"SU14"},
			briefing = "Recover an expedition equipment record in Waystation territory.",
			completion = "In their hands, then. Good. A specification is no use folded up in your pocket.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_personnel",
				label = "The Long Expedition's Kit - Personnel File Folder",
				recipient = "ledger",
			},
			benefits = {},
		},
		{
			id = "SU17",
			completionCash = 1475,
			name = "Weather and Fallout",
			kind = "delivery",
			requires = {"SU15"},
			briefing = "Bring the supplies listed here. Let me check the condition before putting them to use.",
			completion = "Yes, I can use this.",
			requirements = {
				{
					pool = "town_textiles",
					quantity = 5,
				},
			},
			benefits = {},
		},
		{
			id = "SU18",
			completionCash = 2050,
			name = "The Pripyat Trial",
			kind = "field",
			objective = "Recover Numbered Data Module 0022 from the assigned search area in Pripyat. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"SU16"},
			briefing = "Retrieve an outfitting test recorder in Pripyat.",
			completion = "Thank you. I'll examine it at the bench.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module2",
				label = "The Pripyat Trial - Numbered Data Module 0022",
			},
			benefits = {
				items = {
					{
						item = "medic_bandage_1",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "SU19",
			completionCash = 0,
			name = "No Loose Ends",
			kind = "tracker",
			requires = {"SU17"},
			briefing = "Repair and carrying supplies. Bring what's on the list; I'll check what is fit to use.",
			completion = "You've kept the materials coming. I have something worth working with now.",
			target = 20,
			benefits = {},
		},
		{
			id = "SU20",
			completionCash = 2250,
			name = "The Missing Outfitter",
			kind = "field",
			objective = "Recover Personnel File Folder from the assigned search area in Pripyat. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SU18"},
			briefing = "Recover a field fitter's personal case in Pripyat.",
			completion = "Keep it together. I want to see how it was packed.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_personnel",
				label = "The Missing Outfitter - Personnel File Folder",
			},
			benefits = {},
		},
		{
			id = "SU21",
			completionCash = 1775,
			name = "Final Fittings",
			kind = "delivery",
			requires = {"SU19", "SU20"},
			briefing = "Bring the supplies listed here. Let me check the condition before putting them to use.",
			completion = "Good. Set it on the clean side of the table.",
			requirements = {
				{
					pool = "town_textiles",
					quantity = 6,
				},
			},
			benefits = {},
		},
		{
			id = "SU22",
			completionCash = 2450,
			name = "The Return Journey Test",
			kind = "field",
			objective = "Deploy the recorder in Waystation, leave it to record, then retrieve Numbered Data Module"
				.. " 0013. Return it to this contact to finish the assignment.",
			requires = {"SU21"},
			briefing = "Deploy and retrieve a equipment recorder along an expedition route.",
			completion = "Let me look at the measurements.",
			field = {
				kind = "sensor",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_module",
				label = "The Return Journey Test - Numbered Data Module 0013",
			},
			benefits = {},
		},
		{
			id = "SU23",
			completionCash = 0,
			name = "Fit for the Journey",
			kind = "tracker",
			requires = {"SU22"},
			briefing = "Repair and carrying supplies. Bring what's on the list; I'll check what is fit to use.",
			completion = "You've kept the materials coming. I have something worth working with now.",
			target = 27,
			benefits = {},
		},
		{
			id = "SU24",
			capacity = {kind = "rows", amount = 1},
			completionCash = 2650,
			name = "The Outfitter's Pattern",
			kind = "field",
			objective = "Recover Official File Folder from the assigned search area in Waystation. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SU23"},
			briefing = (
				"Recover the final expedition pattern and finish the project. Keep the pattern papers flat if you "
				.. "can. The small measurements matter rather more than an impressive crease through the middle."
			),
			completion = (
				"Thank you. I'll examine it at the bench. Thank you. I'll lay this out properly. You've been "
				.. "patient about the little details. People tend to appreciate them only halfway through a long "
				.. "walk, when something hasn't come apart."
			),
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_official",
				label = "The Outfitter's Pattern - Official File Folder",
			},
			benefits = {
				items = {
					{
						item = "lowtiercookerfuel",
						data = {
							quantity = 1,
						},
					},
				},
			},
			recognition = "Suture's trusted contact",
		},
	},
	unlocks = {
		{
			step = "SU03",
			item = "backpack_sling",
			previous = "",
		},
		{
			step = "SU09",
			item = "backpack_tourist",
			previous = "backpack_sling",
		},
		{
			step = "SU15",
			item = "backpack_vkbo",
			previous = "backpack_tourist",
		},
		{
			step = "SU19",
			item = "backpack_1_large",
			previous = "backpack_vkbo",
		},
	},
})
