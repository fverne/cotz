PLUGIN:Register("gasket", {
	name = "'Gasket'",
	template = "gasketnpc",
	difficultyMultiplier = 1,
	enforceCatalogue = true,
	map = "rp_marsh_cs",
	courierPools = {
		"valuables_fuel_supplies",
		"valuables_filtration",
		"valuables_electrical_supplies",
		"valuables_workshop_consumables",
	},
	job = {
		category = "No ordinary repeatable work",
		description = "No ordinary repeatable work",
		kind = "none",
	},
	legacyJob = {
		category = "Utility supply deliveries",
		deliveryTiers = {
			easy = {
				pools = {"valuables_cleaning_supplies", "valuables_fuel_supplies"},
				quantity = 1,
			},
			hard = {
				pools = {"valuables_portable_power", "valuables_reinforced_cases"},
				quantity = 2,
			},
			medium = {
				pools = {"valuables_filtration", "valuables_electrical_supplies"},
				quantity = 1,
			},
		},
		description = "Utility supply deliveries",
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		pools = {"fuel", "filters", "engine_care"},
		quantities = {2, 4, 7},
	},
	supplies = {"nagantrev", "g2contender", "m1917", "rugermk3", "22lr", "762x25", "9x18", "45acp"},
	rewards = {
		packages = {
			{
				items = {"lowtiercookerfuel"},
				label = "Fuel allowance",
			},
			{
				items = {"medic_bandage_1", "medic_bandage_2"},
				label = "Field dressings",
			},
			{
				items = {"drink_bottlewater", "food_bread"},
				label = "Reserve provisions",
			},
		},
	},
	dialogue = {
		completedGreeting = "Good to see you. Give me a moment to finish this before you tell me what somebody's been touching.",
		delivery = "Put it on the clear bench. Not beside the fuel.",
		jobBriefing = "I could use a hand with something. {details}",
		jobFinished = "That's what I needed. Let's settle up.",
		jobReminder = "I'm still waiting for that material. {details}",
		offerPrompt = "Do you need utility supplies brought in?",
		progression = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
		progressionPrompt = "What's the next part of the utility work?",
		work = "Fuel, filters, cleaning stock, the things we use and then forget to replace. Take a request you can fill, check what it actually asks for, and bring the supplies here. I'll inspect what comes in before deciding where it belongs. I'd enjoy having tomorrow's problem on a shelf instead of arriving through the door at breakfast.",
		workPrompt = "What are we doing about the current supply order?",
	},
	catalogue = {
		tokarev = {
			step = "v3/sidearms/tokarev",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		makarov = {
			step = "v3/sidearms/makarov",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		lugerp08 = {
			step = "v3/sidearms/lugerp08",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		cz52 = {
			step = "v3/sidearms/cz52",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		c96 = {
			step = "v3/sidearms/c96",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		lax410s = {
			step = "v3/sidearms/lax410s",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		fort12 = {
			step = "v3/sidearms/fort12",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		brhp = {
			step = "v3/sidearms/brhp",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		beretta92 = {
			step = "v3/sidearms/beretta92",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		p99 = {
			step = "v3/sidearms/p99",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		glock17 = {
			step = "v3/sidearms/glock17",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		m1911 = {
			step = "v3/sidearms/m1911",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		stechaps = {
			step = "v3/sidearms/stechaps",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		glock18 = {
			step = "v3/sidearms/glock18",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		g2contender500 = {
			step = "v3/sidearms/g2contender500",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		mr96 = {
			step = "v3/sidearms/mr96",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		swr8 = {
			step = "v3/sidearms/swr8",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		taurusjudge = {
			step = "v3/sidearms/taurusjudge",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		swmodel29 = {
			step = "v3/sidearms/swmodel29",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		taurusragingbull = {
			step = "v3/sidearms/taurusragingbull",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		mateba = {
			step = "v3/sidearms/mateba",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		deagle44 = {
			step = "v3/sidearms/deagle44",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		m1911chic = {
			step = "v3/sidearms/m1911chic",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		fiveseven = {
			step = "v3/sidearms/fiveseven",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		deagle = {
			step = "v3/sidearms/deagle",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		sw500 = {
			step = "v3/sidearms/sw500",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_moonshine = {
			step = "v3/strong-alcohol/drink_moonshine",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_vodka_2 = {
			step = "v3/strong-alcohol/drink_vodka_2",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_vodka_1 = {
			step = "v3/strong-alcohol/drink_vodka_1",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_vodka_3 = {
			step = "v3/strong-alcohol/drink_vodka_3",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_wine = {
			step = "v3/strong-alcohol/drink_wine",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_vodka_6 = {
			step = "v3/strong-alcohol/drink_vodka_6",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_vodka_4 = {
			step = "v3/strong-alcohol/drink_vodka_4",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_spirit_1 = {
			step = "v3/strong-alcohol/drink_spirit_1",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_vodka_5 = {
			step = "v3/strong-alcohol/drink_vodka_5",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_spirit_2 = {
			step = "v3/strong-alcohol/drink_spirit_2",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drink_spirit_3 = {
			step = "v3/strong-alcohol/drink_spirit_3",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
	},
	progression = {
		{
			id = "v3/sidearms/tokarev",
			branch = "sidearms",
			name = "Tokarev TT-33",
			kind = "delivery",
			requires = {},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 450,
		},
		{
			id = "v3/sidearms/makarov",
			branch = "sidearms",
			name = "Makarov",
			kind = "delivery",
			requires = {"v3/sidearms/tokarev"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 550,
		},
		{
			id = "v3/sidearms/lugerp08",
			branch = "sidearms",
			name = "Luger P08",
			kind = "delivery",
			requires = {"v3/sidearms/makarov"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 650,
		},
		{
			id = "v3/sidearms/cz52",
			branch = "sidearms",
			name = "cz52",
			kind = "delivery",
			requires = {"v3/sidearms/lugerp08"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 750,
		},
		{
			id = "v3/sidearms/c96",
			branch = "sidearms",
			name = "Mauser C96",
			kind = "delivery",
			requires = {"v3/sidearms/cz52"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 850,
		},
		{
			id = "v3/sidearms/lax410s",
			branch = "sidearms",
			name = "Henry Lever Action X Model .410 Short",
			kind = "delivery",
			requires = {"v3/sidearms/c96"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 950,
		},
		{
			id = "v3/sidearms/fort12",
			branch = "sidearms",
			name = "Fort-12",
			kind = "delivery",
			requires = {"v3/sidearms/lax410s"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 1050,
		},
		{
			id = "v3/sidearms/brhp",
			branch = "sidearms",
			name = "Browning Hi-Power",
			kind = "delivery",
			requires = {"v3/sidearms/fort12"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 1150,
		},
		{
			id = "v3/sidearms/beretta92",
			branch = "sidearms",
			name = "Beretta 92",
			kind = "delivery",
			requires = {"v3/sidearms/brhp"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 1250,
		},
		{
			id = "v3/sidearms/p99",
			branch = "sidearms",
			name = "P99",
			kind = "delivery",
			requires = {"v3/sidearms/beretta92"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1350,
		},
		{
			id = "v3/sidearms/glock17",
			branch = "sidearms",
			name = "Glock 17",
			kind = "delivery",
			requires = {"v3/sidearms/p99"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1450,
		},
		{
			id = "v3/sidearms/m1911",
			branch = "sidearms",
			name = "M1911",
			kind = "delivery",
			requires = {"v3/sidearms/glock17"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1550,
		},
		{
			id = "v3/sidearms/stechaps",
			branch = "sidearms",
			name = "Stechkin APS",
			kind = "delivery",
			requires = {"v3/sidearms/m1911"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1650,
		},
		{
			id = "v3/sidearms/glock18",
			branch = "sidearms",
			name = "Glock 18",
			kind = "delivery",
			requires = {"v3/sidearms/stechaps"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1750,
		},
		{
			id = "v3/sidearms/g2contender500",
			branch = "sidearms",
			name = "g2contender500",
			kind = "delivery",
			requires = {"v3/sidearms/glock18"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1850,
		},
		{
			id = "v3/sidearms/mr96",
			branch = "sidearms",
			name = "MR96",
			kind = "delivery",
			requires = {"v3/sidearms/g2contender500"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1950,
		},
		{
			id = "v3/sidearms/swr8",
			branch = "sidearms",
			name = "Smith&Wesson M&P R8",
			kind = "delivery",
			requires = {"v3/sidearms/mr96"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 2050,
		},
		{
			id = "v3/sidearms/taurusjudge",
			branch = "sidearms",
			name = "taurusjudge",
			kind = "delivery",
			requires = {"v3/sidearms/swr8"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2150,
		},
		{
			id = "v3/sidearms/swmodel29",
			branch = "sidearms",
			name = "Smith&Wesson Model 29",
			kind = "delivery",
			requires = {"v3/sidearms/taurusjudge"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2250,
		},
		{
			id = "v3/sidearms/taurusragingbull",
			branch = "sidearms",
			name = "Taurus Raging Bull",
			kind = "delivery",
			requires = {"v3/sidearms/swmodel29"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2350,
		},
		{
			id = "v3/sidearms/mateba",
			branch = "sidearms",
			name = "Mateba Autorevolver",
			kind = "delivery",
			requires = {"v3/sidearms/taurusragingbull"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2450,
		},
		{
			id = "v3/sidearms/deagle44",
			branch = "sidearms",
			name = "IMI Desert Eagle .44",
			kind = "delivery",
			requires = {"v3/sidearms/mateba"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2550,
		},
		{
			id = "v3/sidearms/m1911chic",
			branch = "sidearms",
			name = "Colt Chicago",
			kind = "delivery",
			requires = {"v3/sidearms/deagle44"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2650,
		},
		{
			id = "v3/sidearms/fiveseven",
			branch = "sidearms",
			name = "Five-seveN",
			kind = "delivery",
			requires = {"v3/sidearms/m1911chic"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2750,
		},
		{
			id = "v3/sidearms/deagle",
			branch = "sidearms",
			name = "IMI Desert Eagle",
			kind = "delivery",
			requires = {"v3/sidearms/fiveseven"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2850,
		},
		{
			id = "v3/sidearms/sw500",
			branch = "sidearms",
			name = "Smith&Wesson .500 Magnum",
			kind = "delivery",
			requires = {"v3/sidearms/deagle"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_utilities_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
		},
		{
			id = "v3/strong-alcohol/drink_moonshine",
			branch = "strong-alcohol",
			name = "Moonshine, 200ml",
			kind = "delivery",
			requires = {},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 450,
		},
		{
			id = "v3/strong-alcohol/drink_vodka_2",
			branch = "strong-alcohol",
			name = "Zone-Produced Vodka",
			kind = "delivery",
			requires = {"v3/strong-alcohol/drink_moonshine"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 700,
		},
		{
			id = "v3/strong-alcohol/drink_vodka_1",
			branch = "strong-alcohol",
			name = "Cossacks Vodka, 700ml",
			kind = "delivery",
			requires = {"v3/strong-alcohol/drink_vodka_2"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 950,
		},
		{
			id = "v3/strong-alcohol/drink_vodka_3",
			branch = "strong-alcohol",
			name = "Smirnoff Vodka, 700ml",
			kind = "delivery",
			requires = {"v3/strong-alcohol/drink_vodka_1"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 1200,
		},
		{
			id = "v3/strong-alcohol/drink_wine",
			branch = "strong-alcohol",
			name = "Wine, 750ml",
			kind = "delivery",
			requires = {"v3/strong-alcohol/drink_vodka_3"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1450,
		},
		{
			id = "v3/strong-alcohol/drink_vodka_6",
			branch = "strong-alcohol",
			name = "Nemiroff Honey&Pepper Vodka, 750ml",
			kind = "delivery",
			requires = {"v3/strong-alcohol/drink_wine"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1700,
		},
		{
			id = "v3/strong-alcohol/drink_vodka_4",
			branch = "strong-alcohol",
			name = "Khortytsa Vodka, 700ml",
			kind = "delivery",
			requires = {"v3/strong-alcohol/drink_vodka_6"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1950,
		},
		{
			id = "v3/strong-alcohol/drink_spirit_1",
			branch = "strong-alcohol",
			name = "Baileys Irish Cream, 1l",
			kind = "delivery",
			requires = {"v3/strong-alcohol/drink_vodka_4"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2200,
		},
		{
			id = "v3/strong-alcohol/drink_vodka_5",
			branch = "strong-alcohol",
			name = "Shevkoff Black Ultra Premium Vodka, 500ml",
			kind = "delivery",
			requires = {"v3/strong-alcohol/drink_spirit_1"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2450,
		},
		{
			id = "v3/strong-alcohol/drink_spirit_2",
			branch = "strong-alcohol",
			name = "Captain Morgan Spiced Rum, 700ml",
			kind = "delivery",
			requires = {"v3/strong-alcohol/drink_vodka_5"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2700,
		},
		{
			id = "v3/strong-alcohol/drink_spirit_3",
			branch = "strong-alcohol",
			name = "Glenfiddich Whisky, 700ml",
			kind = "delivery",
			requires = {"v3/strong-alcohol/drink_spirit_2"},
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_utilities_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
		},
	},
	startingServices = {},
	retiredCommissions = {
		{
			id = "GK02",
			name = "The Empty Service Shed",
			briefing = "Someone kept the generator serviced before I inherited everyone else's guesses. I'd like to see what they wrote down. Recover the generator service journal from the assigned search area in Marsh. Bring it back to me in Marsh.",
		},
		{
			id = "GK04",
			name = "Restocking",
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "GK06",
			name = "The Pump Log",
			briefing = "I want the last pump entries, including the dull ones. People always remember a failure and forget the weeks of small complaints before it. Recover the water-pump maintenance log from the assigned search area in Marsh. Bring it back to me in Marsh.",
		},
		{
			id = "GK08",
			name = "Restocking",
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "GK10",
			name = "The Scrap Specification",
			briefing = "Latch can judge a replacement if he has the specification. I'm tired of describing a fitting with my hands. Recover the replacement-part specification from the assigned search area in Garbage. Deliver it to 'Latch' in Garbage, then come back to me in Marsh.",
		},
		{
			id = "GK12",
			name = "Building the reserve",
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "GK14",
			name = "The Shelter Circuit",
			briefing = "The shelter's service recorder may tell me more than a report saying everything seemed fine. I'd like the actual record. Recover the shelter service recorder from the assigned search area in Marsh. Bring it back to me in Marsh.",
		},
		{
			id = "GK16",
			name = "Building the reserve",
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "GK18",
			name = "The Original Manual",
			briefing = "I want the original utility papers. If the last fellow changed something, I'd like to know what he was changing it from. Recover the original utility manual from the assigned search area in Marsh. Bring it back to me in Marsh.",
		},
		{
			id = "GK20",
			name = "A full supply order",
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "GK22",
			name = "A full supply order",
			briefing = "There are supplies missing again. Everybody notices when something stops working; fewer people notice what it takes to keep it going. Bring everything on the list back here; I need the full delivery.",
		},
	},
})
