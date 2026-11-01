PLUGIN:Register("spicy-lemon", {
	name = "'Spicy Lemon'",
	template = "cooknpc",
	map = "rp_marsh_cs",
	access = {contact = "old-timer", step = "OT06"},
	job = {
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		category = "Meal deliveries",
		description = "Meal deliveries",
		pools = {"common_meals", "predator_meals"},
		deliveryTiers = {
			easy = {
				pools = {
					"valuables_provisions",
				},
				quantity = 1,
			},
			medium = {
				pools = {
					"valuables_provisions",
				},
				quantity = 1,
			},
			hard = {
				pools = {
					"valuables_provisions",
				},
				quantity = 2,
			},
		},
		quantities = {2, 4, 7},
	},
	supplies = {"drink_bottlewater", "food_bread", "food_can_tushonka", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Packed lunch",
				items = {"food_can_tushonka", "food_can_beans", "food_bread"}},
			{label = "Drinks",
				items = {"drink_bottlewater", "drink_bottletea", "drink_energydrink_2"}},
			{label = "Camp cooking",
				items = {"lowtiercookerfuel", "food_can_corn"}},
		},
	},
	dialogue = {
		completedGreeting = (
			"Back again? Good. Tell me what you need before everyone else discovers I'm taking a moment "
			.. "to talk."
		),
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Cooked meals. Bring me the dish on the order. Raw meat can wait until I've got a clean pot. Bring "
			.. "the meals the order asks for. Feeding people is enough work without finding out halfway through "
			.. "that somebody counted a snack as dinner."
		),
		progressionPrompt = "What else needs doing?",
		progression = (
			"I've got a kitchen to supply and a few missing recipes to track down. Have a look. People think a "
			.. "kitchen begins and ends with a pot. There's fetching, keeping things usable, working out what we "
			.. "can spare. Help with that and I'll have more time to do the part I'm good at."
		),
	},
	catalogue = {
		["drink_bottlebeer_6"] = {step = "SL05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_canwater"] = {step = "SL05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_energydrink_2"] = {step = "SL11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_energydrink_4"] = {step = "SL11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_spirit_1"] = {step = "SL19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_spirit_2"] = {step = "SL19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_spirit_3"] = {step = "SL19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_vodka_4"] = {step = "SL13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_vodka_5"] = {step = "SL15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_vodka_6"] = {step = "SL15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_wine"] = {step = "SL17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drug_adrenaline"] = {step = "SL11",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["drug_caffeine"] = {step = "SL03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["drug_mints"] = {step = "SL01",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["drug_morphine"] = {step = "SL13",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["drug_painkillers"] = {step = "SL09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["food_can_tomato"] = {step = "SL09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_can_tushonka"] = {step = "SL09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_cheese_2"] = {step = "SL07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_nuts_2"] = {step = "SL07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_antipsychotic_1"] = {step = "SL07",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["medic_psyheal_1"] = {step = "SL05",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["miscaid_swampbrew"] = {step = "SL21",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "SL01",
			completionCash = 275,
			name = "Pots Before Plates",
			kind = "delivery",
			requires = {},
			briefing = (
				"I need what's on this list before I can get on with the kitchen work. Bring it over "
				.. "when you've got it. I can make a meal of what's available, but available is the "
				.. "important word. Start by bringing what I've asked for."
			),
			completion = (
				"Good, I can use that. Lovely. Now I can spend less time chasing supplies and more time "
				.. "making sure somebody enjoys them."
			),
			requirements = {
				{
					pool = "common_meals",
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
			id = "SL02",
			completionCash = 450,
			name = "The Cold Kitchen",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SL01"},
			briefing = "Recover the kitchen's missing recipe notebook in Marsh.",
			completion = "Let me wash my hands before I open that.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "The Cold Kitchen - Tied Leather Journal",
			},
			benefits = {},
		},
		{
			id = "SL03",
			completionCash = 0,
			name = "A Steady Table",
			kind = "tracker",
			requires = {"SL02"},
			briefing = "Cooked meals. Bring me the dish on the order. Raw meat can wait until I've got a clean pot.",
			completion = "You've kept the meals coming. I can plan a little further ahead now.",
			target = 2,
			benefits = {},
		},
		{
			id = "SL04",
			completionCash = 650,
			name = "Spoor's Contribution",
			kind = "field",
			objective = "Recover Scientist's Field Diary from the assigned search area in Marsh. Deliver it to"
				.. " 'Spoor' in Garbage, then return here to finish the assignment.",
			requires = {"SL02"},
			briefing = "Recover a meat-handling ledger at a deserted hunting camp.",
			completion = "They got it? Good. That should settle the paperwork. Now, have you eaten?",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_diary",
				label = "Spoor's Contribution - Scientist's Field Diary",
				recipient = "spoor",
			},
			benefits = {},
		},
		{
			id = "SL05",
			completionCash = 575,
			name = "Clean Enough",
			kind = "delivery",
			requires = {"SL03"},
			briefing = (
				"I need what's on this list before I can get on with the kitchen work. Bring it over when "
				.. "you've got it."
			),
			completion = "Over here, away from the dirty plates.",
			requirements = {
				{
					pool = "canned_food",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "SL06",
			completionCash = 850,
			name = "The Spoiled Shipment",
			kind = "field",
			objective = "Recover Warehouse Packing List A from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SL04"},
			briefing = "Retrieve shipment evidence from a Marsh supply cache.",
			completion = "You carried that all the way back? Come and sit by the stove.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_manifest",
				label = "The Spoiled Shipment - Warehouse Packing List A",
			},
			benefits = {
				items = {
					{
						item = "food_bread",
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
			id = "SL07",
			completionCash = 0,
			name = "Same Dish Twice",
			kind = "tracker",
			requires = {"SL05"},
			briefing = "Cooked meals. Bring me the dish on the order. Raw meat can wait until I've got a clean pot.",
			completion = "You've kept the meals coming. I can plan a little further ahead now.",
			target = 5,
			benefits = {},
		},
		{
			id = "SL08",
			completionCash = 1050,
			name = "The Missing Crate",
			kind = "field",
			objective = "Recover Small Yellow Transit Case from the assigned search area in Garbage. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"SL06"},
			briefing = "Recover a cookware case along the Garbage route.",
			completion = "Let me wash my hands before I open that.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_case",
				label = "The Missing Crate - Small Yellow Transit Case",
			},
			benefits = {},
		},
		{
			id = "SL09",
			completionCash = 875,
			name = "A Proper Pantry",
			kind = "delivery",
			requires = {"SL07"},
			briefing = (
				"I need what's on this list before I can get on with the kitchen work. Bring it over when "
				.. "you've got it."
			),
			completion = "Now I can get on with the cooking.",
			requirements = {
				{
					pool = "common_meals",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "SL10",
			completionCash = 1250,
			name = "The Supplier's Ledger",
			kind = "field",
			objective = "Recover Warehouse Packing List B from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SL08"},
			briefing = "Retrieve a supplier record in Garbage.",
			completion = "Set it here. I want to see what survived.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_receipt",
				label = "The Supplier's Ledger - Warehouse Packing List B",
			},
			benefits = {},
		},
		{
			id = "SL11",
			completionCash = 0,
			name = "Feeding Travellers",
			kind = "tracker",
			requires = {"SL09"},
			briefing = "Cooked meals. Bring me the dish on the order. Raw meat can wait until I've got a clean pot.",
			completion = "You've kept the meals coming. I can plan a little further ahead now.",
			target = 9,
			benefits = {},
		},
		{
			id = "SL12",
			completionCash = 1450,
			name = "Smoke Without Supper",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SL10"},
			briefing = "Recover a cooking log from an abandoned camp.",
			completion = "You carried that all the way back? Come and sit by the stove.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_notebook",
				label = "Smoke Without Supper - Tied Leather Journal",
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
			id = "SL13",
			completionCash = 1175,
			name = "Something With Flavour",
			kind = "delivery",
			requires = {"SL11"},
			briefing = (
				"I need what's on this list before I can get on with the kitchen work. Bring it over when "
				.. "you've got it."
			),
			completion = "Good, I can use that.",
			requirements = {
				{
					pool = "predator_meals",
					quantity = 4,
				},
			},
			benefits = {},
		},
		{
			id = "SL14",
			completionCash = 1650,
			name = "Jitters' Complaint",
			kind = "field",
			objective = "Recover Clinical Records Folder I from the assigned search area in Marsh. Deliver it to"
				.. " 'Jitters' in Marsh, then return here to finish the assignment.",
			requires = {"SL12"},
			briefing = (
				"Recover clinic ration observations from a field shelter. I'd like to get ahead of the "
				.. "next shortage for once. Check the order rather than deciding for yourself what the "
				.. "kitchen ought to need."
			),
			completion = (
				"They got it? Good. That should settle the paperwork. Now, have you eaten? Put it where "
				.. "I can reach it. You've caught me at the useful part of the day, before everyone starts "
				.. "asking when it'll be ready."
			),
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_clinic",
				label = "Jitters' Complaint - Clinical Records Folder I",
				recipient = "jitters",
			},
			benefits = {},
		},
		{
			id = "SL15",
			completionCash = 0,
			name = "The Lunch Rush",
			kind = "tracker",
			requires = {"SL13"},
			briefing = "Cooked meals. Bring me the dish on the order. Raw meat can wait until I've got a clean pot.",
			completion = "You've kept the meals coming. I can plan a little further ahead now.",
			target = 14,
			benefits = {},
		},
		{
			id = "SL16",
			completionCash = 1850,
			name = "An Unfinished Menu",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Waystation. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SL14"},
			briefing = "Recover a traveller's annotated menu in Waystation territory.",
			completion = "Set it here. I want to see what survived.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_notebook",
				label = "An Unfinished Menu - Tied Leather Journal",
			},
			benefits = {},
		},
		{
			id = "SL17",
			completionCash = 1475,
			name = "Food That Travels",
			kind = "delivery",
			requires = {"SL15"},
			briefing = (
				"I need what's on this list before I can get on with the kitchen work. Bring it over when "
				.. "you've got it."
			),
			completion = "Over here, away from the dirty plates.",
			requirements = {
				{
					pool = "common_meals",
					quantity = 5,
				},
			},
			benefits = {},
		},
		{
			id = "SL18",
			completionCash = 2050,
			name = "The Long Walk",
			kind = "field",
			objective = "Recover Numbered Data Module 0013 from the assigned search area in Marsh. Deliver it to"
				.. " 'Gasket' in Marsh, then return here to finish the assignment.",
			requires = {"SL16"},
			briefing = "Collect a ration-test recorder along a regional route.",
			completion = "They got it? Good. That should settle the paperwork. Now, have you eaten?",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_module",
				label = "The Long Walk - Numbered Data Module 0013",
				recipient = "gasket",
			},
			benefits = {
				items = {
					{
						item = "food_bread",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "SL19",
			completionCash = 0,
			name = "A Place at the Fire",
			kind = "tracker",
			requires = {"SL17"},
			briefing = "Cooked meals. Bring me the dish on the order. Raw meat can wait until I've got a clean pot.",
			completion = "You've kept the meals coming. I can plan a little further ahead now.",
			target = 20,
			benefits = {},
		},
		{
			id = "SL20",
			completionCash = 2250,
			name = "The Last Cookfire",
			kind = "field",
			objective = "Recover Scientist's Field Diary from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SL18"},
			briefing = "Recover a missing cook's journal from a remote camp.",
			completion = "Let me wash my hands before I open that.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_diary",
				label = "The Last Cookfire - Scientist's Field Diary",
			},
			benefits = {},
		},
		{
			id = "SL21",
			completionCash = 1775,
			name = "Enough for Everyone",
			kind = "delivery",
			requires = {"SL19"},
			briefing = (
				"I need what's on this list before I can get on with the kitchen work. Bring it over when "
				.. "you've got it."
			),
			completion = "Now I can get on with the cooking.",
			requirements = {
				{
					pool = "predator_meals",
					quantity = 6,
				},
			},
			benefits = {},
		},
		{
			id = "SL22",
			completionCash = 2450,
			name = "The Cook's Detour",
			kind = "field",
			objective = "Recover Personnel File Folder from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SL20"},
			briefing = "Recover the cook's personal case beyond the usual supply route.",
			completion = "Set it here. I want to see what survived.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_personnel",
				label = "The Cook's Detour - Personnel File Folder",
			},
			benefits = {},
		},
		{
			id = "SL23",
			completionCash = 0,
			name = "Reliable Hands",
			kind = "tracker",
			requires = {"SL21", "SL22"},
			briefing = "Cooked meals. Bring me the dish on the order. Raw meat can wait until I've got a clean pot.",
			completion = "You've kept the meals coming. I can plan a little further ahead now.",
			target = 27,
			benefits = {},
		},
		{
			id = "SL24",
			completionCash = 2650,
			name = "The Recipe He Kept",
			kind = "field",
			objective = "Recover Scientist's Field Diary from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SL23"},
			briefing = "Recover the journal's missing page from the cook's last cache.",
			completion = "You carried that all the way back? Come and sit by the stove.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_diary",
				label = "The Recipe He Kept - Scientist's Field Diary",
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
			id = "SL25",
			completionCash = 2000,
			name = "The Feast",
			kind = "delivery",
			requires = {"SL24"},
			briefing = (
				"I need what's on this list before I can get on with the kitchen work. Bring it over when "
				.. "you've got it."
			),
			completion = "Good, I can use that.",
			requirements = {
				{
					pool = "canned_food",
					quantity = 7,
				},
			},
			benefits = {},
		},
		{
			id = "SL26",
			completionCash = 2850,
			name = "Room at the Table",
			kind = "field",
			objective = "Recover Old Photograph Album from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SL25"},
			briefing = (
				"Recover the cook's keepsake and return for the meal's conclusion. It's an album, so keep it away "
				.. "from anything leaking in your pack. I can wipe a table clean. Photographs are less forgiving."
			),
			completion = (
				"Let me wash my hands before I open that. Look at that. Everyone sitting still long enough for a "
				.. "picture. Don't get used to me being quiet; I'm just having a look. You did well bringing this "
				.. "back."
			),
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_photo",
				label = "Room at the Table - Old Photograph Album",
			},
			benefits = {},
			recognition = "Spicy Lemon's trusted contact",
		},
	},
})
