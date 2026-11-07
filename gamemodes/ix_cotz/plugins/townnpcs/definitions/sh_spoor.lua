PLUGIN:Register("spoor", {
	name = "'Spoor'",
	template = "spoornpc",
	difficultyMultiplier = 2,
	enforceCatalogue = true,
	map = "rp_garbage_cotz",
	courierPools = {
		"valuables_survey_equipment",
		"valuables_field_records",
		"valuables_sample_carriers",
		"valuables_cutting_tools",
	},
	job = {
		category = "Mutant category hunting",
		description = "Mutant category hunting",
		kind = "categoryHunting",
		maps = {
			easy = "rp_garbage_cotz",
			hard = "rp_pripyat_remaster",
			medium = "rp_waystation",
		},
	},
	legacyJob = {
		category = "Mutant hunting",
		description = "Mutant hunting",
		kind = "hunting",
		quantities = {5, 9, 15},
	},
	supplies = {"sako85varmint", "w9422"},
	rewards = {
		bonusPackages = {
			{
				items = {"sharpening_stone_fine"},
				label = "Fine edge upkeep",
			},
			{
				items = {"hidestash_3"},
				label = "Pripyat stash",
			},
		},
		packages = {
			{
				items = {"12gauge"},
				label = "Hunting shells",
			},
			{
				items = {"sharpening_stone"},
				label = "Edge upkeep",
			},
			{
				items = {"food_can_tushonka"},
				label = "Canned provisions",
			},
		},
	},
	dialogue = {
		completedGreeting = "Hello. Seen anything worth a closer look? You know I'm happy to hear what you actually noticed.",
		delivery = "Set it down. Tell me if anything happened to it on the way.",
		jobBriefing = "I've been watching the movement out there. {details}",
		jobFinished = "You've done the hunting we agreed on. Let's settle up.",
		jobReminder = "I still need you to cover that ground. {details}",
		offerPrompt = "Do you have a hunting order?",
		progression = "I need supplies for the hunting kit. Check the list and bring them back here when you have them. Bring everything on the list back here; I need the full delivery.",
		progressionPrompt = "What are you checking in the hunting records?",
		work = "These orders concern groups of quarry rather than one species. The request names the category and the region. Different animals contribute according to the size of their usual packs, so a handful of small scavengers does not count like a pack of larger predators. Watch the tally, and come back when the order is met.",
		workPrompt = "About the hunt I have taken.",
	},
	catalogue = {
		mp18 = {
			step = "v3/slow-rifles/mp18",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		sako85nato = {
			step = "v3/slow-rifles/sako85nato",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		obrez = {
			step = "v3/slow-rifles/obrez",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		w9422357 = {
			step = "v3/slow-rifles/w9422357",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		mosin = {
			step = "v3/slow-rifles/mosin",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		sako85 = {
			step = "v3/slow-rifles/sako85",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		w1895 = {
			step = "v3/slow-rifles/w1895",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		obrezmalfunction = {
			step = "v3/slow-rifles/obrezmalfunction",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		sv98 = {
			step = "v3/slow-rifles/sv98",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		lax44 = {
			step = "v3/slow-rifles/lax44",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		l115 = {
			step = "v3/slow-rifles/l115",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		trg42 = {
			step = "v3/slow-rifles/trg42",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
	},
	progression = {
		{
			id = "v3/slow-rifles/mp18",
			branch = "slow-rifles",
			name = "MP-18",
			kind = "delivery",
			requires = {},
			briefing = "I need supplies for the hunting kit. Check the list and bring them back here when you have them. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. I will look these over before the next walk.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 1,
				},
			},
			completionCash = 450,
		},
		{
			id = "v3/slow-rifles/sako85nato",
			branch = "slow-rifles",
			name = "Sako 85 NATO",
			kind = "delivery",
			requires = {"v3/slow-rifles/mp18"},
			briefing = "I need supplies for the hunting kit. Check the list and bring them back here when you have them. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. I will look these over before the next walk.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 1,
				},
			},
			completionCash = 650,
		},
		{
			id = "v3/slow-rifles/obrez",
			branch = "slow-rifles",
			name = "Obrez",
			kind = "delivery",
			requires = {"v3/slow-rifles/sako85nato"},
			briefing = "I need supplies for the hunting kit. Check the list and bring them back here when you have them. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. I will look these over before the next walk.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 1,
				},
			},
			completionCash = 900,
		},
		{
			id = "v3/slow-rifles/w9422357",
			branch = "slow-rifles",
			name = "Marlin 1894C .357 Magnum",
			kind = "delivery",
			requires = {"v3/slow-rifles/obrez"},
			briefing = "I need supplies for the hunting kit. Check the list and bring them back here when you have them. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. I will look these over before the next walk.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 1,
				},
			},
			completionCash = 1100,
		},
		{
			id = "v3/slow-rifles/mosin",
			branch = "slow-rifles",
			name = "Mosin Nagant",
			kind = "delivery",
			requires = {"v3/slow-rifles/w9422357"},
			briefing = "I need supplies for the hunting kit. Check the list and bring them back here when you have them. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. I will look these over before the next walk.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 1,
				},
			},
			completionCash = 1350,
		},
		{
			id = "v3/slow-rifles/sako85",
			branch = "slow-rifles",
			name = "Sako 85",
			kind = "delivery",
			requires = {"v3/slow-rifles/mosin"},
			briefing = "I need supplies for the hunting kit. Check the list and bring them back here when you have them. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. I will look these over before the next walk.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 1,
				},
			},
			completionCash = 1600,
		},
		{
			id = "v3/slow-rifles/w1895",
			branch = "slow-rifles",
			name = "Winchester 1895",
			kind = "delivery",
			requires = {"v3/slow-rifles/sako85"},
			briefing = "I need supplies for the hunting kit. Check the list and bring them back here when you have them. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. I will look these over before the next walk.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 1,
				},
			},
			completionCash = 1800,
		},
		{
			id = "v3/slow-rifles/obrezmalfunction",
			branch = "slow-rifles",
			name = "Mercenary Malfunction",
			kind = "delivery",
			requires = {"v3/slow-rifles/w1895"},
			briefing = "I need supplies for the hunting kit. Check the list and bring them back here when you have them. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. I will look these over before the next walk.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 1,
				},
			},
			completionCash = 2050,
		},
		{
			id = "v3/slow-rifles/sv98",
			branch = "slow-rifles",
			name = "SV-98",
			kind = "delivery",
			requires = {"v3/slow-rifles/obrezmalfunction"},
			briefing = "I need supplies for the hunting kit. Check the list and bring them back here when you have them. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. I will look these over before the next walk.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_3",
					quantity = 1,
				},
			},
			completionCash = 2300,
		},
		{
			id = "v3/slow-rifles/lax44",
			branch = "slow-rifles",
			name = "Henry Lever Action X Model .44",
			kind = "delivery",
			requires = {"v3/slow-rifles/sv98"},
			briefing = "I need supplies for the hunting kit. Check the list and bring them back here when you have them. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. I will look these over before the next walk.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_3",
					quantity = 1,
				},
			},
			completionCash = 2500,
		},
		{
			id = "v3/slow-rifles/l115",
			branch = "slow-rifles",
			name = "L115",
			kind = "delivery",
			requires = {"v3/slow-rifles/lax44"},
			briefing = "I need supplies for the hunting kit. Check the list and bring them back here when you have them. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. I will look these over before the next walk.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_3",
					quantity = 1,
				},
			},
			completionCash = 2750,
		},
		{
			id = "v3/slow-rifles/trg42",
			branch = "slow-rifles",
			name = "SAKO TRG-42",
			kind = "delivery",
			requires = {"v3/slow-rifles/l115"},
			briefing = "I need supplies for the hunting kit. Check the list and bring them back here when you have them. Bring everything on the list back here; I need the full delivery.",
			completion = "Good. I will look these over before the next walk.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_garbage_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
		},
	},
	startingServices = {},
	retiredCommissions = {
		{
			id = "SP02",
			name = "The Scavenger's Camp",
			briefing = "I want the observations from the hunting ground. What was feeding there matters before we decide what drove it away. Recover the scavenging-ground observations from the assigned search area in Garbage. Bring it back to me in Garbage.",
		},
		{
			id = "SP04",
			name = "A small delivery",
			briefing = "I need supplies for the hunting kit. Check the list and bring them back here when you have them. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "SP06",
			name = "Lemon's Complaint",
			briefing = "Jitters needs the meat-handling notes. He can judge the health concerns better with the account in front of him. Recover the camp meat-handling notes from the assigned search area in Garbage. Deliver it to 'Jitters' in Marsh, then come back to me in Garbage.",
		},
		{
			id = "SP08",
			name = "Restocking",
			briefing = "I need supplies for the hunting kit. Check the list and bring them back here when you have them. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "SP10",
			name = "Tracks in the Wrong Place",
			briefing = "The route recorder may help place the disturbance. Don't decide every noise on it must be the quarry. Recover the disturbed-route recorder from the assigned search area in Garbage. Bring it back to me in Garbage.",
		},
		{
			id = "SP12",
			name = "Building the reserve",
			briefing = "I need supplies for the hunting kit. Check the list and bring them back here when you have them. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "SP14",
			name = "The Pattern Breaks",
			briefing = "Atlas needs the survey record. I'd like him to check the ground account without me selecting the useful bits for him. Recover the survey recorder for Atlas from the assigned search area in Waystation. Deliver it to 'Atlas' in Marsh, then come back to me in Garbage.",
		},
		{
			id = "SP16",
			name = "Building the reserve",
			briefing = "I need supplies for the hunting kit. Check the list and bring them back here when you have them. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "SP18",
			name = "The Survivor's Cache",
			briefing = "Recover the hunter's case. An abandoned load can mean several things; bring it home before we choose one. Recover the abandoned hunter's case from the assigned search area in Pripyat. Bring it back to me in Garbage.",
		},
		{
			id = "SP20",
			name = "A full supply order",
			briefing = "I need supplies for the hunting kit. Check the list and bring them back here when you have them. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "SP22",
			name = "The Hunter's Proof",
			briefing = "The final observations are back in Garbage. I want them beside the rest before calling the account complete. Recover the final hunting journal from the assigned search area in Garbage. Bring it back to me in Garbage.",
		},
	},
})
