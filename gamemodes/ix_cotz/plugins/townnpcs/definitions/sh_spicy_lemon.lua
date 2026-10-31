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
		quantities = {2, 4, 7},
		maps = {
			easy = "rp_marsh_cs",
			medium = "mz_garbage",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "food_bread", "food_can_tushonka", "lowtiercookerfuel"},
	dialogue = {
		completedGreeting = "Enough to go around. Been a while since I could say that.",
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = "Cooked meals. Bring me the dish on the order. Raw meat can wait until I've got a clean pot.",
		progressionPrompt = "What else needs doing?",
		progression = "I've got a kitchen to supply and a few missing recipes to track down. Have a look.",
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
			name = "Pots Before Plates",
			kind = "delivery",
			requires = {},
			briefing = (
				"I need what's on this list before I can get on with the kitchen work. Bring it over when "
				.. "you've got it."
			),
			completion = "Good, I can use that.",
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
			name = "The Cold Kitchen",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"SL01"},
			briefing = "Recover the kitchen's missing recipe notebook in Marsh.",
			completion = "Let me wash my hands before I open that.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
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
			id = "SL03",
			name = "A Steady Table",
			kind = "tracker",
			requires = {"SL02"},
			briefing = "Cooked meals. Bring me the dish on the order. Raw meat can wait until I've got a clean pot.",
			completion = "You've kept the meals coming. I can plan a little further ahead now.",
			target = 2,
			benefits = {
				items = {
					{
						item = "food_can_tushonka",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "SL04",
			name = "Spoor's Contribution",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"SL02"},
			briefing = "Recover a meat-handling ledger at a deserted hunting camp.",
			completion = "Set it here. I want to see what survived.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
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
			id = "SL05",
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
			id = "SL06",
			name = "The Spoiled Shipment",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"SL04"},
			briefing = "Retrieve shipment evidence from a Marsh supply cache.",
			completion = "You carried that all the way back? Come and sit by the stove.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
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
			name = "Same Dish Twice",
			kind = "tracker",
			requires = {"SL05"},
			briefing = "Cooked meals. Bring me the dish on the order. Raw meat can wait until I've got a clean pot.",
			completion = "You've kept the meals coming. I can plan a little further ahead now.",
			target = 5,
			benefits = {
				items = {
					{
						item = "food_can_tushonka",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "SL08",
			name = "The Missing Crate",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"SL06"},
			briefing = "Recover a cookware case along the Garbage route.",
			completion = "Let me wash my hands before I open that.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
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
			id = "SL09",
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
			id = "SL10",
			name = "The Supplier's Ledger",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"SL08"},
			briefing = "Retrieve a supplier record in Garbage.",
			completion = "Set it here. I want to see what survived.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
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
			id = "SL11",
			name = "Feeding Travellers",
			kind = "tracker",
			requires = {"SL09"},
			briefing = "Cooked meals. Bring me the dish on the order. Raw meat can wait until I've got a clean pot.",
			completion = "You've kept the meals coming. I can plan a little further ahead now.",
			target = 9,
			benefits = {
				items = {
					{
						item = "food_can_tushonka",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "SL12",
			name = "Smoke Without Supper",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"SL10"},
			briefing = "Recover a cooking log from an abandoned camp.",
			completion = "You carried that all the way back? Come and sit by the stove.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
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
			id = "SL14",
			name = "Jitters' Complaint",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"SL12"},
			briefing = "Recover clinic ration observations from a field shelter.",
			completion = "Let me wash my hands before I open that.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
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
			id = "SL15",
			name = "The Lunch Rush",
			kind = "tracker",
			requires = {"SL13"},
			briefing = "Cooked meals. Bring me the dish on the order. Raw meat can wait until I've got a clean pot.",
			completion = "You've kept the meals coming. I can plan a little further ahead now.",
			target = 14,
			benefits = {
				items = {
					{
						item = "food_can_tushonka",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "SL16",
			name = "An Unfinished Menu",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"SL14"},
			briefing = "Recover a traveller's annotated menu in Waystation territory.",
			completion = "Set it here. I want to see what survived.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
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
			id = "SL17",
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
			id = "SL18",
			name = "The Long Walk",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"SL16"},
			briefing = "Collect a ration-test recorder along a regional route.",
			completion = "You carried that all the way back? Come and sit by the stove.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
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
			name = "A Place at the Fire",
			kind = "tracker",
			requires = {"SL17"},
			briefing = "Cooked meals. Bring me the dish on the order. Raw meat can wait until I've got a clean pot.",
			completion = "You've kept the meals coming. I can plan a little further ahead now.",
			target = 20,
			benefits = {
				items = {
					{
						item = "food_can_tushonka",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "SL20",
			name = "The Last Cookfire",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"SL18"},
			briefing = "Recover a missing cook's journal from a remote camp.",
			completion = "Let me wash my hands before I open that.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
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
			id = "SL21",
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
			id = "SL22",
			name = "The Cook's Detour",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"SL20"},
			briefing = "Recover the cook's personal case beyond the usual supply route.",
			completion = "Set it here. I want to see what survived.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
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
			id = "SL23",
			name = "Reliable Hands",
			kind = "tracker",
			requires = {"SL21", "SL22"},
			briefing = "Cooked meals. Bring me the dish on the order. Raw meat can wait until I've got a clean pot.",
			completion = "You've kept the meals coming. I can plan a little further ahead now.",
			target = 27,
			benefits = {
				items = {
					{
						item = "food_can_tushonka",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "SL24",
			name = "The Recipe He Kept",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"SL23"},
			briefing = "Recover the journal's missing page from the cook's last cache.",
			completion = "You carried that all the way back? Come and sit by the stove.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
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
			stock = {
				item = "drink_bottlewater",
				bonus = 2,
			},
		},
		{
			id = "SL25",
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
			id = "SL26",
			name = "Room at the Table",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"SL25"},
			briefing = "Recover the cook's keepsake and return for the meal's conclusion.",
			completion = "Let me wash my hands before I open that.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
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
			recognition = "Spicy Lemon's trusted contact",
		},
	},
})
