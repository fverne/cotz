PLUGIN:Register("smartass", {
	name = "'Smartass'",
	template = "unisgnpc3",
	difficultyMultiplier = 2.5,
	enforceCatalogue = true,
	map = "rp_waystation",
	courierPools = {
		"valuables_computer_parts",
		"valuables_portable_computers",
		"valuables_flash_media",
		"valuables_data_archives",
	},
	job = {
		category = "Computer data extraction",
		description = "Computer data extraction",
		kind = "dataExtract",
	},
	legacyJob = {
		category = "Computer data extraction",
		description = "Extract data from %d computer types using the issued flash drive.",
		kind = "dataExtract",
		quantities = {1, 2, 5},
	},
	supplies = {},
	rewards = {
		bonusCash = true,
		bonusPackages = {
			{
				items = {"value_currency_dollar"},
				label = "Dollar notes",
			},
		},
		packages = {
			{
				items = {"drug_caffeine"},
				label = "Overtime",
			},
			{
				items = {"drink_energydrink_2"},
				label = "Energy drinks",
			},
			{
				items = {"value_currency_euro"},
				label = "Euro notes",
			},
		},
	},
	dialogue = {
		completedGreeting = "You again. At least I can reasonably expect something useful to come of the interruption. What is it?",
		jobBriefing = "I've got something for you to bring back. {details}",
		jobFinished = "You got it. Let me sort out your payment before curiosity gets the better of me.",
		jobReminder = "I'm still missing the interesting bit. {details}",
		offerPrompt = "Do you have a computer extraction job?",
		progression = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
		progressionPrompt = "What needs checking in the signal records?",
		work = "Files, if we're fortunate. An explanation for somebody's filing system if we're very fortunate. Take the issued flash drive to the computer types listed on the assignment, let the extractions finish, and bring it back. Another machine of the same type won't replace one you're missing. Leave the contents alone; I'd like the opportunity to be confused by the original.",
		workPrompt = "About the extraction I'm doing.",
	},
	disabledItems = {
		dataextractor = true,
		quest_computeraccess = true,
	},
	catalogue = {
		c96carbine = {
			step = "v3/nato-cqb/c96carbine",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		stoegerddshort = {
			step = "v3/nato-cqb/stoegerddshort",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		sten = {
			step = "v3/nato-cqb/sten",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		stoegerdd = {
			step = "v3/nato-cqb/stoegerdd",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		mac11 = {
			step = "v3/nato-cqb/mac11",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		mp34 = {
			step = "v3/nato-cqb/mp34",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		m3supershort = {
			step = "v3/nato-cqb/m3supershort",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		mp40 = {
			step = "v3/nato-cqb/mp40",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		kp31 = {
			step = "v3/nato-cqb/kp31",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		mossberg500 = {
			step = "v3/nato-cqb/mossberg500",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		ar159mm = {
			step = "v3/nato-cqb/ar159mm",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		mp5k = {
			step = "v3/nato-cqb/mp5k",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		uzi = {
			step = "v3/nato-cqb/uzi",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		ithaca37 = {
			step = "v3/nato-cqb/ithaca37",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		sterling = {
			step = "v3/nato-cqb/sterling",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		mp5 = {
			step = "v3/nato-cqb/mp5",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		m1887 = {
			step = "v3/nato-cqb/m1887",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		ump45 = {
			step = "v3/nato-cqb/ump45",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		rem870ae = {
			step = "v3/nato-cqb/rem870ae",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		m3super90 = {
			step = "v3/nato-cqb/m3super90",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		mp9a1 = {
			step = "v3/nato-cqb/mp9a1",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		m1928 = {
			step = "v3/nato-cqb/m1928",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		p90 = {
			step = "v3/nato-cqb/p90",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		striker = {
			step = "v3/nato-cqb/striker",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		accesscard_bunker = {
			step = "v3/access-cards/accesscard_bunker",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		accesscard_laboratory = {
			step = "v3/access-cards/accesscard_laboratory",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
	},
	progression = {
		{
			id = "v3/nato-cqb/c96carbine",
			branch = "nato-cqb",
			name = "Mauser C96 Carbine",
			kind = "delivery",
			requires = {},
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 450,
		},
		{
			id = "v3/nato-cqb/stoegerddshort",
			branch = "nato-cqb",
			name = "Stoeger Double Defense Short",
			kind = "delivery",
			requires = {"v3/nato-cqb/c96carbine"},
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 550,
		},
		{
			id = "v3/nato-cqb/sten",
			branch = "nato-cqb",
			name = "Sten Gun MKII",
			kind = "delivery",
			requires = {"v3/nato-cqb/stoegerddshort"},
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 650,
		},
		{
			id = "v3/nato-cqb/stoegerdd",
			branch = "nato-cqb",
			name = "Stoeger Double Defense",
			kind = "delivery",
			requires = {"v3/nato-cqb/sten"},
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 750,
		},
		{
			id = "v3/nato-cqb/mac11",
			branch = "nato-cqb",
			name = "Mac-11",
			kind = "delivery",
			requires = {"v3/nato-cqb/stoegerdd"},
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 850,
		},
		{
			id = "v3/nato-cqb/mp34",
			branch = "nato-cqb",
			name = "MP34",
			kind = "delivery",
			requires = {"v3/nato-cqb/mac11"},
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 1000,
		},
		{
			id = "v3/nato-cqb/m3supershort",
			branch = "nato-cqb",
			name = "Serbu Super Shorty",
			kind = "delivery",
			requires = {"v3/nato-cqb/mp34"},
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 1100,
		},
		{
			id = "v3/nato-cqb/mp40",
			branch = "nato-cqb",
			name = "MP40",
			kind = "delivery",
			requires = {"v3/nato-cqb/m3supershort"},
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 1200,
		},
		{
			id = "v3/nato-cqb/kp31",
			branch = "nato-cqb",
			name = "KP-31",
			kind = "delivery",
			requires = {"v3/nato-cqb/mp40"},
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_waystation_2",
					quantity = 1,
				},
			},
			completionCash = 1300,
		},
		{
			id = "v3/nato-cqb/mossberg500",
			branch = "nato-cqb",
			name = "Mossberg 500",
			kind = "delivery",
			requires = {"v3/nato-cqb/kp31"},
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_waystation_2",
					quantity = 1,
				},
			},
			completionCash = 1400,
		},
		{
			id = "v3/nato-cqb/ar159mm",
			branch = "nato-cqb",
			name = "AR15 9mm",
			kind = "delivery",
			requires = {"v3/nato-cqb/mossberg500"},
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_waystation_2",
					quantity = 1,
				},
			},
			completionCash = 1550,
		},
		{
			id = "v3/nato-cqb/mp5k",
			branch = "nato-cqb",
			name = "MP5k",
			kind = "delivery",
			requires = {"v3/nato-cqb/ar159mm"},
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_waystation_2",
					quantity = 1,
				},
			},
			completionCash = 1650,
		},
		{
			id = "v3/nato-cqb/uzi",
			branch = "nato-cqb",
			name = "IMI Uzi",
			kind = "delivery",
			requires = {"v3/nato-cqb/mp5k"},
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_waystation_2",
					quantity = 1,
				},
			},
			completionCash = 1750,
		},
		{
			id = "v3/nato-cqb/ithaca37",
			branch = "nato-cqb",
			name = "Ithaca 37",
			kind = "delivery",
			requires = {"v3/nato-cqb/uzi"},
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_waystation_2",
					quantity = 1,
				},
			},
			completionCash = 1850,
		},
		{
			id = "v3/nato-cqb/sterling",
			branch = "nato-cqb",
			name = "Sterling",
			kind = "delivery",
			requires = {"v3/nato-cqb/ithaca37"},
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_waystation_2",
					quantity = 1,
				},
			},
			completionCash = 2000,
		},
		{
			id = "v3/nato-cqb/mp5",
			branch = "nato-cqb",
			name = "HK MP5",
			kind = "delivery",
			requires = {"v3/nato-cqb/sterling"},
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_waystation_2",
					quantity = 1,
				},
			},
			completionCash = 2100,
		},
		{
			id = "v3/nato-cqb/m1887",
			branch = "nato-cqb",
			name = "M1887",
			kind = "delivery",
			requires = {"v3/nato-cqb/mp5"},
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_electronics_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_waystation_3",
					quantity = 1,
				},
			},
			completionCash = 2200,
		},
		{
			id = "v3/nato-cqb/ump45",
			branch = "nato-cqb",
			name = "H&K UMP",
			kind = "delivery",
			requires = {"v3/nato-cqb/m1887"},
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_electronics_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_waystation_3",
					quantity = 1,
				},
			},
			completionCash = 2300,
		},
		{
			id = "v3/nato-cqb/rem870ae",
			branch = "nato-cqb",
			name = "Remington 870 AE",
			kind = "delivery",
			requires = {"v3/nato-cqb/ump45"},
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_electronics_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_waystation_3",
					quantity = 1,
				},
			},
			completionCash = 2400,
		},
		{
			id = "v3/nato-cqb/m3super90",
			branch = "nato-cqb",
			name = "M3 Super 90",
			kind = "delivery",
			requires = {"v3/nato-cqb/rem870ae"},
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_electronics_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_waystation_3",
					quantity = 1,
				},
			},
			completionCash = 2550,
		},
		{
			id = "v3/nato-cqb/mp9a1",
			branch = "nato-cqb",
			name = "MP9a1",
			kind = "delivery",
			requires = {"v3/nato-cqb/m3super90"},
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_electronics_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_waystation_3",
					quantity = 1,
				},
			},
			completionCash = 2650,
		},
		{
			id = "v3/nato-cqb/m1928",
			branch = "nato-cqb",
			name = "M1928A1 'Thompson'",
			kind = "delivery",
			requires = {"v3/nato-cqb/mp9a1"},
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_electronics_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_waystation_3",
					quantity = 1,
				},
			},
			completionCash = 2750,
		},
		{
			id = "v3/nato-cqb/p90",
			branch = "nato-cqb",
			name = "FN P90",
			kind = "delivery",
			requires = {"v3/nato-cqb/m1928"},
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_electronics_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_waystation_3",
					quantity = 1,
				},
			},
			completionCash = 2850,
		},
		{
			id = "v3/nato-cqb/striker",
			branch = "nato-cqb",
			name = "Striker",
			kind = "delivery",
			requires = {"v3/nato-cqb/p90"},
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_electronics_waystation_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_electronics_waystation_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_waystation_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
		},
		{
			id = "v3/access-cards/accesscard_bunker",
			branch = "access-cards",
			name = "Access Card (Bunker)",
			kind = "delivery",
			requires = {},
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 450,
		},
		{
			id = "v3/access-cards/accesscard_laboratory",
			branch = "access-cards",
			name = "Access Card (Laboratory)",
			kind = "delivery",
			requires = {"v3/access-cards/accesscard_bunker"},
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_electronics_waystation_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_electronics_waystation_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_waystation_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
		},
	},
	startingServices = {},
	retiredCommissions = {
		{
			id = "SM02",
			name = "The Lost Beacon",
			briefing = "There's a beacon source to locate. I'd like the hardware before hearing another theory about who must have switched it on. Take the required bearings in Garbage, locate the source, and collect the beacon controller. Bring it back to me in Waystation.",
		},
		{
			id = "SM04",
			name = "A small delivery",
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "SM06",
			name = "The Interference Site",
			briefing = "I want the source behind that interference. Take the bearings properly; irritation isn't a direction. Take the required bearings in Garbage, locate the source, and collect the interference source record. Bring it back to me in Waystation.",
		},
		{
			id = "SM08",
			name = "Restocking",
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "SM10",
			name = "The False Beacon",
			briefing = "There's another source to locate. Follow the measured bearings rather than the explanation that makes the journey shortest. Take the required bearings in Garbage, locate the source, and collect the misleading beacon source. Bring it back to me in Waystation.",
		},
		{
			id = "SM12",
			name = "Restocking",
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "SM14",
			name = "Mute's Missing Packet",
			briefing = "Recover the diagnostic recording. Mute's equipment doesn't become easier to understand because somebody has already decided it's mysterious. Recover the relay diagnostic recording from the assigned search area in Garbage. Bring it back to me in Waystation.",
		},
		{
			id = "SM16",
			name = "Building the reserve",
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "SM18",
			name = "The Rooftop Source",
			briefing = "There's a source in Pripyat to locate. The assignment doesn't require you to invent a rooftop route because somebody liked the title. Recover the Pripyat signal transmitter from the assigned search area in Pripyat. Bring it back to me in Waystation.",
		},
		{
			id = "SM20",
			name = "Building the reserve",
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "SM22",
			name = "Two Signals One Source",
			briefing = "Locate the next source and bring it home. Similar behaviour doesn't mean we get to skip the second inspection. Recover the second Pripyat signal source from the assigned search area in Pripyat. Bring it back to me in Waystation.",
		},
		{
			id = "SM24",
			name = "A full supply order",
			briefing = "I need parts. The list should spare us the performance where you bring something vaguely technical and I explain why it is useless. Bring everything on the list back here; I need the full delivery.",
		},
	},
})
