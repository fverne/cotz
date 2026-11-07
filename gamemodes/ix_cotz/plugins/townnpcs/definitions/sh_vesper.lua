PLUGIN:Register("vesper", {
	name = "'Vesper'",
	template = "vespernpc",
	difficultyMultiplier = 2,
	enforceCatalogue = true,
	map = "rp_garbage_cotz",
	courierPools = {
		"valuables_survey_equipment",
		"valuables_filtration",
		"valuables_protective_textiles",
		"valuables_sample_carriers",
	},
	job = {
		category = "Sensor deployment and retrieval",
		description = "Sensor deployment and retrieval",
		kind = "sensor",
		maps = {
			easy = "rp_garbage_cotz",
			hard = "rp_pripyat_remaster",
			medium = "rp_waystation",
		},
	},
	legacyJob = {
		category = "Sensor deployment and retrieval",
		description = "Sensor deployment and retrieval",
		kind = "sensor",
		maps = {
			easy = "rp_garbage_cotz",
			hard = "rp_pripyat_remaster",
			medium = "rp_waystation",
		},
	},
	supplies = {},
	rewards = {
		bonusPackages = {
			{
				items = {"medic_medkit_1", "medic_antirad_2"},
				label = "Medical supplies",
			},
			{
				items = {"hidestash_2"},
				label = "Waystation stash",
			},
		},
		packages = {
			{
				items = {"medic_antirad_1", "medic_antirad_2"},
				label = "Exposure treatment",
			},
			{
				items = {"medic_bandage_1"},
				label = "Field dressings",
			},
			{
				items = {"food_can_tuna"},
				label = "Canned provisions",
			},
		},
	},
	dialogue = {
		completedGreeting = "Good to see you on this side of the trip. We can talk for a moment before either of us starts planning another.",
		delivery = "Put it where I can check the label. Tell me if it was damaged on the way.",
		jobBriefing = "There's a site I'd like a closer look at. {details}",
		jobFinished = "Good to have you back with it. Let's settle up, then I can see what we found.",
		jobReminder = "I still want a look at what that site is doing. {details}",
		offerPrompt = "Do you have an assignment?",
		progression = "I need supplies for the next trip. Check the list; I would like to spend the walk looking at the field rather than regretting what I packed. Bring everything on the list back here; I need the full delivery.",
		progressionPrompt = "What else needs doing?",
		work = "Deploy the sensor, let it finish, then collect it. Stay within range and keep yourself fit to carry it home. Decide when you'll turn back before you set out. Don't keep changing that decision just because the recorder isn't quite finished.",
		workPrompt = "About the assignments.",
	},
	catalogue = {
		saigasemi545 = {
			step = "v3/pact-rifles/saigasemi545",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		saigasemi = {
			step = "v3/pact-rifles/saigasemi",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		aks74u = {
			step = "v3/pact-rifles/aks74u",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		sks = {
			step = "v3/pact-rifles/sks",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		ak74 = {
			step = "v3/pact-rifles/ak74",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		an94k = {
			step = "v3/pact-rifles/an94k",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		akm = {
			step = "v3/pact-rifles/akm",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		aek971 = {
			step = "v3/pact-rifles/aek971",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		ak12 = {
			step = "v3/pact-rifles/ak12",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		rk95 = {
			step = "v3/pact-rifles/rk95",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		svt40 = {
			step = "v3/pact-rifles/svt40",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		vss = {
			step = "v3/pact-rifles/vss",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		rpk = {
			step = "v3/pact-rifles/rpk",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		["9a91"] = {
			step = "v3/pact-rifles/9a91",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		asval = {
			step = "v3/pact-rifles/asval",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		svd = {
			step = "v3/pact-rifles/svd",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		dp28 = {
			step = "v3/pact-rifles/dp28",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
	},
	progression = {
		{
			id = "v3/pact-rifles/saigasemi545",
			branch = "pact-rifles",
			name = "Saiga Semi-Automatic Rifle",
			kind = "delivery",
			requires = {},
			briefing = "I need supplies for the next trip. Check the list; I would like to spend the walk looking at the field rather than regretting what I packed. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 450,
		},
		{
			id = "v3/pact-rifles/saigasemi",
			branch = "pact-rifles",
			name = "Saiga Semi-Automatic Rifle",
			kind = "delivery",
			requires = {"v3/pact-rifles/saigasemi545"},
			briefing = "I need supplies for the next trip. Check the list; I would like to spend the walk looking at the field rather than regretting what I packed. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 600,
		},
		{
			id = "v3/pact-rifles/aks74u",
			branch = "pact-rifles",
			name = "AKs-74u",
			kind = "delivery",
			requires = {"v3/pact-rifles/saigasemi"},
			briefing = "I need supplies for the next trip. Check the list; I would like to spend the walk looking at the field rather than regretting what I packed. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 750,
		},
		{
			id = "v3/pact-rifles/sks",
			branch = "pact-rifles",
			name = "SKS",
			kind = "delivery",
			requires = {"v3/pact-rifles/aks74u"},
			briefing = "I need supplies for the next trip. Check the list; I would like to spend the walk looking at the field rather than regretting what I packed. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 900,
		},
		{
			id = "v3/pact-rifles/ak74",
			branch = "pact-rifles",
			name = "AK74",
			kind = "delivery",
			requires = {"v3/pact-rifles/sks"},
			briefing = "I need supplies for the next trip. Check the list; I would like to spend the walk looking at the field rather than regretting what I packed. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 1050,
		},
		{
			id = "v3/pact-rifles/an94k",
			branch = "pact-rifles",
			name = "AN-94",
			kind = "delivery",
			requires = {"v3/pact-rifles/ak74"},
			briefing = "I need supplies for the next trip. Check the list; I would like to spend the walk looking at the field rather than regretting what I packed. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 1200,
		},
		{
			id = "v3/pact-rifles/akm",
			branch = "pact-rifles",
			name = "akm",
			kind = "delivery",
			requires = {"v3/pact-rifles/an94k"},
			briefing = "I need supplies for the next trip. Check the list; I would like to spend the walk looking at the field rather than regretting what I packed. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1400,
		},
		{
			id = "v3/pact-rifles/aek971",
			branch = "pact-rifles",
			name = "AEK-971",
			kind = "delivery",
			requires = {"v3/pact-rifles/akm"},
			briefing = "I need supplies for the next trip. Check the list; I would like to spend the walk looking at the field rather than regretting what I packed. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1550,
		},
		{
			id = "v3/pact-rifles/ak12",
			branch = "pact-rifles",
			name = "AK-12",
			kind = "delivery",
			requires = {"v3/pact-rifles/aek971"},
			briefing = "I need supplies for the next trip. Check the list; I would like to spend the walk looking at the field rather than regretting what I packed. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1700,
		},
		{
			id = "v3/pact-rifles/rk95",
			branch = "pact-rifles",
			name = "SAKO RK 95",
			kind = "delivery",
			requires = {"v3/pact-rifles/ak12"},
			briefing = "I need supplies for the next trip. Check the list; I would like to spend the walk looking at the field rather than regretting what I packed. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1850,
		},
		{
			id = "v3/pact-rifles/svt40",
			branch = "pact-rifles",
			name = "SVT 40",
			kind = "delivery",
			requires = {"v3/pact-rifles/rk95"},
			briefing = "I need supplies for the next trip. Check the list; I would like to spend the walk looking at the field rather than regretting what I packed. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 2000,
		},
		{
			id = "v3/pact-rifles/vss",
			branch = "pact-rifles",
			name = "VSS Vintorez",
			kind = "delivery",
			requires = {"v3/pact-rifles/svt40"},
			briefing = "I need supplies for the next trip. Check the list; I would like to spend the walk looking at the field rather than regretting what I packed. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2200,
		},
		{
			id = "v3/pact-rifles/rpk",
			branch = "pact-rifles",
			name = "RPK",
			kind = "delivery",
			requires = {"v3/pact-rifles/vss"},
			briefing = "I need supplies for the next trip. Check the list; I would like to spend the walk looking at the field rather than regretting what I packed. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2350,
		},
		{
			id = "v3/pact-rifles/9a91",
			branch = "pact-rifles",
			name = "9A-91",
			kind = "delivery",
			requires = {"v3/pact-rifles/rpk"},
			briefing = "I need supplies for the next trip. Check the list; I would like to spend the walk looking at the field rather than regretting what I packed. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2500,
		},
		{
			id = "v3/pact-rifles/asval",
			branch = "pact-rifles",
			name = "AS Val",
			kind = "delivery",
			requires = {"v3/pact-rifles/9a91"},
			briefing = "I need supplies for the next trip. Check the list; I would like to spend the walk looking at the field rather than regretting what I packed. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2650,
		},
		{
			id = "v3/pact-rifles/svd",
			branch = "pact-rifles",
			name = "Dragunov SVD",
			kind = "delivery",
			requires = {"v3/pact-rifles/asval"},
			briefing = "I need supplies for the next trip. Check the list; I would like to spend the walk looking at the field rather than regretting what I packed. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2800,
		},
		{
			id = "v3/pact-rifles/dp28",
			branch = "pact-rifles",
			name = "DP-28",
			kind = "delivery",
			requires = {"v3/pact-rifles/svd"},
			briefing = "I need supplies for the next trip. Check the list; I would like to spend the walk looking at the field rather than regretting what I packed. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_research_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_marsh_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
		},
	},
	startingServices = {},
	retiredCommissions = {
		{
			id = "VE02",
			name = "The Quiet Edge",
			briefing = "I'd like a recording from the field approach. A quiet-looking edge still deserves the full preparation. Deploy the recorder at the assigned site in Garbage, let it finish recording, then retrieve the anomaly approach survey recorder. Bring it back to me in Garbage.",
		},
		{
			id = "VE04",
			name = "A small delivery",
			briefing = "I need supplies for the next trip. Check the list; I would like to spend the walk looking at the field rather than regretting what I packed. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "VE06",
			name = "The Second Field",
			briefing = "We need another field recording. Don't pack for the last trip simply because this one sounds similar. Deploy the recorder at the assigned site in Garbage, let it finish recording, then retrieve the second field survey recorder. Bring it back to me in Garbage.",
		},
		{
			id = "VE08",
			name = "Restocking",
			briefing = "I need supplies for the next trip. Check the list; I would like to spend the walk looking at the field rather than regretting what I packed. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "VE10",
			name = "The Unstable Reading",
			briefing = "Recover the disputed site's recording. An unstable reading is interesting, but I'd prefer it somewhere I can listen without watching the ground. Recover the disputed-site audio record from the assigned search area in Garbage. Bring it back to me in Garbage.",
		},
		{
			id = "VE12",
			name = "Restocking",
			briefing = "I need supplies for the next trip. Check the list; I would like to spend the walk looking at the field rather than regretting what I packed. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "VE14",
			name = "The Lost Team's Notes",
			briefing = "Wake needs the lost team's log. She should have the people and the route in their own words, not my selection of technical details. Recover the prospecting log for Wake from the assigned search area in Waystation. Deliver it to 'Wake' in Garbage, then come back to me in Garbage.",
		},
		{
			id = "VE16",
			name = "Building the reserve",
			briefing = "I need supplies for the next trip. Check the list; I would like to spend the walk looking at the field rather than regretting what I packed. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "VE18",
			name = "The Team's Cache",
			briefing = "Recover the team's equipment case intact. I want to see what survived before making a story about what they must have needed. Recover the lost team's equipment case from the assigned search area in Garbage. Bring it back to me in Garbage.",
		},
		{
			id = "VE20",
			name = "Building the reserve",
			briefing = "I need supplies for the next trip. Check the list; I would like to spend the walk looking at the field rather than regretting what I packed. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "VE22",
			name = "A Different Explanation",
			briefing = "Carbon needs the recovered control recording. Another reading of the account may show where we've been asking it the wrong question. Recover the control cassette for Carbon from the assigned search area in Pripyat. Deliver it to 'Carbon' in Waystation, then come back to me in Garbage.",
		},
		{
			id = "VE24",
			name = "A full supply order",
			briefing = "I need supplies for the next trip. Check the list; I would like to spend the walk looking at the field rather than regretting what I packed. Bring everything on the list back here; I need the full delivery.",
		},
	},
})
