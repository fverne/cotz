PLUGIN:Register("spicy-lemon", {
	name = "'Spicy Lemon'",
	template = "cooknpc",
	difficultyMultiplier = 1,
	enforceCatalogue = true,
	map = "rp_marsh_cs",
	courierPools = {
		"valuables_provisions",
		"valuables_cleaning_supplies",
		"valuables_cutting_tools",
		"valuables_fuel_supplies",
	},
	job = {
		category = "Meal deliveries",
		description = "Meal deliveries",
		kind = "regionalMeals",
		maps = {
			easy = "rp_marsh_cs",
			hard = "rp_pripyat_remaster",
			medium = "rp_waystation",
		},
	},
	legacyJob = {
		category = "Meal deliveries",
		deliveryTiers = {
			easy = {
				pools = {"valuables_provisions"},
				quantity = 1,
			},
			hard = {
				pools = {"valuables_provisions"},
				quantity = 2,
			},
			medium = {
				pools = {"valuables_provisions"},
				quantity = 1,
			},
		},
		description = "Meal deliveries",
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		pools = {"common_meals", "predator_meals"},
		quantities = {2, 4, 7},
	},
	supplies = {
		"food_can_corn",
		"food_can_beans",
		"food_can_chilibeans",
		"drink_vodka_2",
		"drug_cigarette_1",
		"drink_energydrink_4",
	},
	rewards = {
		bonusCash = true,
		bonusPackages = {
			{
				items = {
					"food_can_corn",
					"food_can_beans",
					"food_can_chilibeans",
					"food_can_tomato",
					"food_can_tuna",
					"food_can_olive",
					"food_can_tushonka",
					"food_can_sprats",
				},
				label = "Canned supplies",
			},
			{
				items = {"lowtiercookerfuel"},
				label = "Cooking fuel",
			},
		},
		packages = {
			{
				items = {"hidestasher_cutlery"},
				label = "Cutlery",
			},
			{
				items = {
					"food_can_corn",
					"food_can_beans",
					"food_can_chilibeans",
					"food_can_tomato",
					"food_can_tuna",
					"food_can_olive",
					"food_can_tushonka",
					"food_can_sprats",
				},
				label = "Canned provisions",
			},
			{
				items = {"lowtiercookerfuel"},
				label = "Cooking fuel",
			},
		},
	},
	dialogue = {
		completedGreeting = "Back again? Good. Tell me what you need before everyone else discovers I'm taking a moment to talk.",
		jobBriefing = "I've people to feed, and they have opinions about everything. {details}",
		jobFinished = "There, something I can work with. Let's get you paid before somebody asks for seconds.",
		jobReminder = "I can't put an empty pot on the table. {details}",
		offerPrompt = "Do you have a food delivery request?",
		progression = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
		progressionPrompt = "What needs doing for the kitchen?",
		work = "Food requests. Meals and provisions, whatever the actual order asks for. Read it before deciding your favourite dish must be the one I need. I have enough opinions about supper to manage without discovering a delivery was an entirely different meal. Bring it here and keep it clear of the rest of your scavenging.",
		workPrompt = "About the food request I'm filling.",
	},
	disabledItems = {
		meal_human = true,
		meat_human = true,
	},
	catalogue = {
		drug_cigarette_2 = {
			step = "v3/weak-drugs/drug_cigarette_2",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drug_mints = {
			step = "v3/weak-drugs/drug_mints",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drug_cigarette_3 = {
			step = "v3/weak-drugs/drug_cigarette_3",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drug_painkillers = {
			step = "v3/weak-drugs/drug_painkillers",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drug_cigarette_5 = {
			step = "v3/weak-drugs/drug_cigarette_5",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drug_caffeine = {
			step = "v3/weak-drugs/drug_caffeine",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drug_cigarette_4 = {
			step = "v3/weak-drugs/drug_cigarette_4",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drug_cigar = {
			step = "v3/weak-drugs/drug_cigar",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drug_cigarette_6 = {
			step = "v3/weak-drugs/drug_cigarette_6",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drug_tobacco_1 = {
			step = "v3/weak-drugs/drug_tobacco_1",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drug_tobacco_2 = {
			step = "v3/weak-drugs/drug_tobacco_2",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_canbeer_2 = {
			step = "v3/weak-alcohol/drink_canbeer_2",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_canbeer_3 = {
			step = "v3/weak-alcohol/drink_canbeer_3",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_canbeer_1 = {
			step = "v3/weak-alcohol/drink_canbeer_1",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_bottlebeer_4 = {
			step = "v3/weak-alcohol/drink_bottlebeer_4",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_canbeer_4 = {
			step = "v3/weak-alcohol/drink_canbeer_4",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_canbeer_6 = {
			step = "v3/weak-alcohol/drink_canbeer_6",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_bottlebeer_3 = {
			step = "v3/weak-alcohol/drink_bottlebeer_3",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_bottlebeer_6 = {
			step = "v3/weak-alcohol/drink_bottlebeer_6",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_canbeer_5 = {
			step = "v3/weak-alcohol/drink_canbeer_5",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_bottlebeer_2 = {
			step = "v3/weak-alcohol/drink_bottlebeer_2",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_bottlebeer_5 = {
			step = "v3/weak-alcohol/drink_bottlebeer_5",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_bottlebeer_1 = {
			step = "v3/weak-alcohol/drink_bottlebeer_1",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_energydrink_2 = {
			step = "v3/energy-drinks/drink_energydrink_2",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_energydrink_1 = {
			step = "v3/energy-drinks/drink_energydrink_1",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_energydrink_5 = {
			step = "v3/energy-drinks/drink_energydrink_5",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_energydrink_6 = {
			step = "v3/energy-drinks/drink_energydrink_6",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_energydrink_3 = {
			step = "v3/energy-drinks/drink_energydrink_3",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
	},
	progression = {
		{
			id = "v3/weak-drugs/drug_cigarette_1",
			branch = "weak-drugs",
			name = "'Glory' Cigarettes (10pk)",
			kind = "delivery",
			requires = {},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 450,
			stock = {
				item = "drug_cigarette_1",
				bonus = 1,
			},
		},
		{
			id = "v3/weak-drugs/drug_cigarette_2",
			branch = "weak-drugs",
			name = "'Petr 1.' Cigarettes (10pk)",
			kind = "delivery",
			requires = {"v3/weak-drugs/drug_cigarette_1"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 650,
		},
		{
			id = "v3/weak-drugs/drug_mints",
			branch = "weak-drugs",
			name = "Altoid Mints",
			kind = "delivery",
			requires = {"v3/weak-drugs/drug_cigarette_2"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 900,
		},
		{
			id = "v3/weak-drugs/drug_cigarette_3",
			branch = "weak-drugs",
			name = "'Star' Cigarettes (10pk)",
			kind = "delivery",
			requires = {"v3/weak-drugs/drug_mints"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 1100,
		},
		{
			id = "v3/weak-drugs/drug_painkillers",
			branch = "weak-drugs",
			name = "Codeine Tablets",
			kind = "delivery",
			requires = {"v3/weak-drugs/drug_cigarette_3"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1350,
		},
		{
			id = "v3/weak-drugs/drug_cigarette_5",
			branch = "weak-drugs",
			name = "Lucky Strike Cigarettes (10pk)",
			kind = "delivery",
			requires = {"v3/weak-drugs/drug_painkillers"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1600,
		},
		{
			id = "v3/weak-drugs/drug_caffeine",
			branch = "weak-drugs",
			name = "Caffeine Tablets",
			kind = "delivery",
			requires = {"v3/weak-drugs/drug_cigarette_5"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1800,
		},
		{
			id = "v3/weak-drugs/drug_cigarette_4",
			branch = "weak-drugs",
			name = "'Spark' Cigarettes (20pk)",
			kind = "delivery",
			requires = {"v3/weak-drugs/drug_caffeine"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 2050,
		},
		{
			id = "v3/weak-drugs/drug_cigar",
			branch = "weak-drugs",
			name = "Cuban Cigar",
			kind = "delivery",
			requires = {"v3/weak-drugs/drug_cigarette_4"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2300,
		},
		{
			id = "v3/weak-drugs/drug_cigarette_6",
			branch = "weak-drugs",
			name = "Marlboro Cigarettes (20pk)",
			kind = "delivery",
			requires = {"v3/weak-drugs/drug_cigar"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2500,
		},
		{
			id = "v3/weak-drugs/drug_tobacco_1",
			branch = "weak-drugs",
			name = "Golden Virginia Tobacco",
			kind = "delivery",
			requires = {"v3/weak-drugs/drug_cigarette_6"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2750,
		},
		{
			id = "v3/weak-drugs/drug_tobacco_2",
			branch = "weak-drugs",
			name = "Russian Cigarette Tobacco",
			kind = "delivery",
			requires = {"v3/weak-drugs/drug_tobacco_1"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_kitchen_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
		},
		{
			id = "v3/weak-alcohol/drink_canbeer_2",
			branch = "weak-alcohol",
			name = "Chernihivske White, 500ml",
			kind = "delivery",
			requires = {},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 450,
		},
		{
			id = "v3/weak-alcohol/drink_canbeer_3",
			branch = "weak-alcohol",
			name = "Lvivske 1715, 500ml",
			kind = "delivery",
			requires = {"v3/weak-alcohol/drink_canbeer_2"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 650,
		},
		{
			id = "v3/weak-alcohol/drink_canbeer_1",
			branch = "weak-alcohol",
			name = "OBOLON Strong, 500ml",
			kind = "delivery",
			requires = {"v3/weak-alcohol/drink_canbeer_3"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 900,
		},
		{
			id = "v3/weak-alcohol/drink_bottlebeer_4",
			branch = "weak-alcohol",
			name = "Tuborg GREEN, 330ml",
			kind = "delivery",
			requires = {"v3/weak-alcohol/drink_canbeer_1"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 1100,
		},
		{
			id = "v3/weak-alcohol/drink_canbeer_4",
			branch = "weak-alcohol",
			name = "Utenos Porteris, 500ml",
			kind = "delivery",
			requires = {"v3/weak-alcohol/drink_bottlebeer_4"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1350,
		},
		{
			id = "v3/weak-alcohol/drink_canbeer_6",
			branch = "weak-alcohol",
			name = "Heineken, 500ml",
			kind = "delivery",
			requires = {"v3/weak-alcohol/drink_canbeer_4"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1600,
		},
		{
			id = "v3/weak-alcohol/drink_bottlebeer_3",
			branch = "weak-alcohol",
			name = "Baltika no.3, 850ml",
			kind = "delivery",
			requires = {"v3/weak-alcohol/drink_canbeer_6"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1800,
		},
		{
			id = "v3/weak-alcohol/drink_bottlebeer_6",
			branch = "weak-alcohol",
			name = "Lvivske Porter, 1l",
			kind = "delivery",
			requires = {"v3/weak-alcohol/drink_bottlebeer_3"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 2050,
		},
		{
			id = "v3/weak-alcohol/drink_canbeer_5",
			branch = "weak-alcohol",
			name = "Baltika no 7, 900ml",
			kind = "delivery",
			requires = {"v3/weak-alcohol/drink_bottlebeer_6"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2300,
		},
		{
			id = "v3/weak-alcohol/drink_bottlebeer_2",
			branch = "weak-alcohol",
			name = "Lvivske Svitle, 1.5l",
			kind = "delivery",
			requires = {"v3/weak-alcohol/drink_canbeer_5"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2500,
		},
		{
			id = "v3/weak-alcohol/drink_bottlebeer_5",
			branch = "weak-alcohol",
			name = "Zaporizske, 2.5l",
			kind = "delivery",
			requires = {"v3/weak-alcohol/drink_bottlebeer_2"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2750,
		},
		{
			id = "v3/weak-alcohol/drink_bottlebeer_1",
			branch = "weak-alcohol",
			name = "Ochakovo Beer, 2l",
			kind = "delivery",
			requires = {"v3/weak-alcohol/drink_bottlebeer_5"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_kitchen_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
		},
		{
			id = "v3/energy-drinks/drink_energydrink_4",
			branch = "energy-drinks",
			name = "EuroShopper Energy Drink, 250ml",
			kind = "delivery",
			requires = {},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 450,
			stock = {
				item = "drink_energydrink_4",
				bonus = 1,
			},
		},
		{
			id = "v3/energy-drinks/drink_energydrink_2",
			branch = "energy-drinks",
			name = "Revo Alco Energy, 500ml",
			kind = "delivery",
			requires = {"v3/energy-drinks/drink_energydrink_4"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 950,
		},
		{
			id = "v3/energy-drinks/drink_energydrink_1",
			branch = "energy-drinks",
			name = "Red Bull, 250ml",
			kind = "delivery",
			requires = {"v3/energy-drinks/drink_energydrink_2"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1450,
		},
		{
			id = "v3/energy-drinks/drink_energydrink_5",
			branch = "energy-drinks",
			name = "Monster Energy Classic, 500ml",
			kind = "delivery",
			requires = {"v3/energy-drinks/drink_energydrink_1"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1950,
		},
		{
			id = "v3/energy-drinks/drink_energydrink_6",
			branch = "energy-drinks",
			name = "Monster Energy Ultra White, 500ml",
			kind = "delivery",
			requires = {"v3/energy-drinks/drink_energydrink_5"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2450,
		},
		{
			id = "v3/energy-drinks/drink_energydrink_3",
			branch = "energy-drinks",
			name = "Redline Extreme, 240ml",
			kind = "delivery",
			requires = {"v3/energy-drinks/drink_energydrink_6"},
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_kitchen_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
		},
	},
	startingServices = {},
	retiredCommissions = {
		{
			id = "SL02",
			name = "The Cold Kitchen",
			briefing = "My recipe notebook is still out in Marsh. I can cook without it. I'd prefer not to keep proving that point every time someone asks for something different. Recover the kitchen recipe journal from the assigned search area in Marsh. Bring it back to me in Marsh.",
		},
		{
			id = "SL04",
			name = "A small delivery",
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "SL06",
			name = "The Spoiled Shipment",
			briefing = "Bring back the shipment evidence. I'd like to know which consignment we're discussing before everyone blames the kitchen. Recover the spoiled consignment evidence from the assigned search area in Marsh. Bring it back to me in Marsh.",
		},
		{
			id = "SL08",
			name = "Restocking",
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "SL10",
			name = "The Supplier's Ledger",
			briefing = "I want the supplier's book. Everybody remembers having sent enough food; a written entry would make a lovely change. Recover the food supplier's ledger from the assigned search area in Garbage. Bring it back to me in Marsh.",
		},
		{
			id = "SL12",
			name = "Restocking",
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "SL14",
			name = "Jitters' Complaint",
			briefing = "Jitters needs the ration observations. I am perfectly prepared to have this discussion with a page between us for once. Recover the clinic ration log for Jitters from the assigned search area in Marsh. Deliver it to 'Jitters' in Marsh, then come back to me in Marsh.",
		},
		{
			id = "SL16",
			name = "Building the reserve",
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "SL18",
			name = "The Long Walk",
			briefing = "Gasket should have the ration-test record. He's usually the one who remembers to ask what was available on the journey. Recover the ration trial recorder for Gasket from the assigned search area in Marsh. Deliver it to 'Gasket' in Marsh, then come back to me in Marsh.",
		},
		{
			id = "SL20",
			name = "Building the reserve",
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "SL22",
			name = "The Cook's Detour",
			briefing = "The cook's surviving personal papers should come back together. Leave them as they are until they're here. Recover the cook's personal records from the assigned search area in Marsh. Bring it back to me in Marsh.",
		},
		{
			id = "SL24",
			name = "A full supply order",
			briefing = "I need supplies for the kitchen. Read the list; I have enough people explaining what I should cook without bringing me anything to cook with. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "SL26",
			name = "Room at the Table",
			briefing = "Bring the album home, away from anything leaking in your pack. I can wipe a table clean. Photographs are less forgiving. Recover the cook's photograph album from the assigned search area in Marsh. Bring it back to me in Marsh.",
		},
	},
})
