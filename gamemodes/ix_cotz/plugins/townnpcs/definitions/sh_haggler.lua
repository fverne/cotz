PLUGIN:Register("haggler", {
	name = "'Haggler'",
	template = "tradernpc",
	map = "rp_marsh_cs",
	access = {contact = "old-timer", step = "OT03"},
	job = {
		kind = "humans",
		trigger = "banditKilled",
		category = "Hostile human elimination",
		description = "Hostile human elimination",
		quantities = {5, 9, 15},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Sidearm stock",
				items = {"9x18", "762x25", "9x19"}},
			{label = "Cheap firepower",
				items = {"12gauge", "45acp41", "762x39"}},
			{label = "Road supplies",
				items = {"food_can_beans", "drink_bottlewater"}},
		},
	},
	dialogue = {
		completedGreeting = (
			"There you are. It's pleasant to see a customer whose promises don't need chasing all over "
			.. "the Marsh."
		),
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Bandits are bad for deliveries. Remove the ones on the order; I still need paying customers. Read "
			.. "the order before you start shooting. A frightened courier isn't a bandit just because he's "
			.. "carrying something valuable."
		),
		progressionPrompt = "What else needs doing?",
		progression = (
			"Missing invoices, missing goods, people asking to be paid twice. Pick a problem. I can complain "
			.. "about missing goods all day. Finding out where they went takes someone willing to walk. Bring me "
			.. "something I can check and we can have an actual discussion."
		),
	},
	catalogue = {
		["bat"] = {step = "HG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["beretta92"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["brhp"] = {step = "HG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["c96"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["c96carbine"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["cz52"] = {step = "HG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["fort12"] = {step = "HG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["g2contender"] = {step = "HG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["g2contender500"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["glock17"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["glock18"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["ij600"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["kiparis"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["kp31"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["lugerp08"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["m1887"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["m1911"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["m1911chic"] = {step = "HG11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["m1917"] = {step = "HG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["m1928"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mac11"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["makarov"] = {step = "HG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mp18"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mp27"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mp34"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mp40"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mp5k"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["nagantrev"] = {step = "HG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["obrezmalfunction"] = {step = "HG11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["p99"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["ppsh"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["rugermini14"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["rugermk3"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["saigasemi545"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["skorpion"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sks"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["stechaps"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sten"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sterling"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["taurusjudge"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["tokarev"] = {step = "HG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["toz194"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["toz34"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["toz66"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["uzi"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "HG01",
			completionCash = 275,
			name = "Opening the Shutters",
			kind = "delivery",
			requires = {},
			briefing = (
				"Bring what's listed here. I'll check the goods before we settle this part of the deal. "
				.. "I'd like to see how you handle a straightforward order before we start making this "
				.. "complicated. Saves us both a great deal of talking."
			),
			completion = (
				"As agreed. Let me count it. Good. You read the order and brought the goods. We may be "
				.. "able to do business without giving each other a headache."
			),
			requirements = {
				{
					pool = "field_maintenance",
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
			id = "HG02",
			completionCash = 450,
			name = "The Missing Invoice",
			kind = "field",
			objective = "Recover Warehouse Packing List B from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"HG01"},
			briefing = "Recover an invoice from a Marsh trading stop.",
			completion = "Hand it over. I want to read the small print.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_receipt",
				label = "The Missing Invoice - Warehouse Packing List B",
			},
			benefits = {},
		},
		{
			id = "HG03",
			completionCash = 0,
			name = "A Small Problem",
			kind = "tracker",
			requires = {"HG02"},
			briefing = (
				"Bandits are bad for deliveries. Remove the ones on the order; I still need paying "
				.. "customers."
			),
			completion = "You've kept your end of the arrangement. I remember reliable people.",
			target = 2,
			benefits = {},
		},
		{
			id = "HG04",
			completionCash = 650,
			name = "Who Pays Twice",
			kind = "field",
			objective = "Recover Corporate Letter from the assigned search area in Marsh. Return it to this contact"
				.. " to finish the assignment.",
			requires = {"HG03"},
			briefing = "Recover an extortion receipt from a hostile NPC camp.",
			completion = "Let's see whose name is on this one.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_contract",
				label = "Who Pays Twice - Corporate Letter",
			},
			benefits = {},
		},
		{
			id = "HG05",
			completionCash = 575,
			name = "Working Capital",
			kind = "delivery",
			requires = {"HG04"},
			briefing = "Bring what's listed here. I'll check the goods before we settle this part of the deal.",
			completion = "That settles this part of our business.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "HG06",
			completionCash = 850,
			name = "The Wrong Seal",
			kind = "field",
			objective = "Recover Warehouse Packing List A from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"HG04"},
			briefing = "Retrieve a consignment seal record along a Marsh route.",
			completion = "Good. I prefer an account I can check.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_manifest",
				label = "The Wrong Seal - Warehouse Packing List A",
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
			id = "HG07",
			completionCash = 0,
			name = "Safer Roads",
			kind = "tracker",
			requires = {"HG05"},
			briefing = (
				"Bandits are bad for deliveries. Remove the ones on the order; I still need paying "
				.. "customers."
			),
			completion = "You've kept your end of the arrangement. I remember reliable people.",
			target = 5,
			benefits = {},
		},
		{
			id = "HG08",
			completionCash = 1050,
			name = "The Abandoned Stall",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"HG06"},
			briefing = "Recover a trader's account book in Garbage.",
			completion = "Hand it over. I want to read the small print.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "The Abandoned Stall - Tied Leather Journal",
			},
			benefits = {},
		},
		{
			id = "HG09",
			completionCash = 875,
			name = "Stock Worth Carrying",
			kind = "delivery",
			requires = {"HG07"},
			briefing = "Bring what's listed here. I'll check the goods before we settle this part of the deal.",
			completion = "Good. Something I can actually put to use.",
			requirements = {
				{
					pool = "canned_food",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "HG10",
			completionCash = 1250,
			name = "Two Sets of Books",
			kind = "field",
			objective = "Recover Warehouse Packing List B from the assigned search area in Marsh. Deliver it to"
				.. " 'Ledger' in Waystation, then return here to finish the assignment.",
			requires = {"HG08"},
			briefing = "Retrieve a second ledger from a freight cache.",
			completion = "In the right hands, finally. I was beginning to think delivery was an optional service.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_receipt",
				label = "Two Sets of Books - Warehouse Packing List B",
				recipient = "ledger",
			},
			benefits = {},
		},
		{
			id = "HG11",
			completionCash = 0,
			name = "Paying Customers",
			kind = "tracker",
			requires = {"HG09"},
			briefing = (
				"Bandits are bad for deliveries. Remove the ones on the order; I still need paying "
				.. "customers."
			),
			completion = "You've kept your end of the arrangement. I remember reliable people.",
			target = 9,
			benefits = {},
		},
		{
			id = "HG12",
			completionCash = 1450,
			name = "The Collector's Route",
			kind = "field",
			objective = "Recover Loose Intelligence Dossier from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"HG10"},
			briefing = "Recover route notes at a hostile NPC staging site.",
			completion = "Good. I prefer an account I can check.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_intel",
				label = "The Collector's Route - Loose Intelligence Dossier",
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
			id = "HG13",
			completionCash = 1175,
			name = "An Honest Sample",
			kind = "delivery",
			requires = {"HG11"},
			briefing = "Bring what's listed here. I'll check the goods before we settle this part of the deal.",
			completion = "As agreed. Let me count it.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 4,
				},
			},
			benefits = {},
		},
		{
			id = "HG14",
			completionCash = 1650,
			name = "A Broken Agreement",
			kind = "field",
			objective = "Recover Corporate Letter from the assigned search area in Garbage. Return it to this contact"
				.. " to finish the assignment.",
			requires = {"HG12"},
			briefing = (
				"Retrieve a supplier contract in Garbage. People are quite capable of losing things "
				.. "without help. I want something I can check before I start pointing fingers."
			),
			completion = (
				"Hand it over. I want to read the small print. Now I have something firmer than a "
				.. "complaint to work with. Makes a pleasant change from the usual business."
			),
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_contract",
				label = "A Broken Agreement - Corporate Letter",
			},
			benefits = {},
		},
		{
			id = "HG15",
			completionCash = 0,
			name = "No More Tolls",
			kind = "tracker",
			requires = {"HG13"},
			briefing = (
				"Bandits are bad for deliveries. Remove the ones on the order; I still need paying "
				.. "customers."
			),
			completion = "You've kept your end of the arrangement. I remember reliable people.",
			target = 14,
			benefits = {},
		},
		{
			id = "HG16",
			completionCash = 1850,
			name = "The Broker's Copy",
			kind = "field",
			objective = "Recover Corporate Letter from the assigned search area in Waystation. Deliver it to 'Carbon'"
				.. " in Waystation, then return here to finish the assignment.",
			requires = {"HG14"},
			briefing = "Recover a duplicate contract in Waystation territory.",
			completion = "In the right hands, finally. I was beginning to think delivery was an optional service.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_contract",
				label = "The Broker's Copy - Corporate Letter",
				recipient = "carbon",
			},
			benefits = {},
		},
		{
			id = "HG17",
			completionCash = 1475,
			name = "Shelf Space",
			kind = "delivery",
			requires = {"HG15"},
			briefing = "Bring what's listed here. I'll check the goods before we settle this part of the deal.",
			completion = "That settles this part of our business.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 5,
				},
			},
			benefits = {},
		},
		{
			id = "HG18",
			completionCash = 2050,
			name = "The Shipment List",
			kind = "field",
			objective = "Recover Warehouse Packing List A from the assigned search area in Marsh. Deliver it to"
				.. " 'Brass' in Garbage, then return here to finish the assignment.",
			requires = {"HG16"},
			briefing = "Recover a manifest identifying the racket's distributor.",
			completion = "In the right hands, finally. I was beginning to think delivery was an optional service.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_manifest",
				label = "The Shipment List - Warehouse Packing List A",
				recipient = "brass",
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
			id = "HG19",
			completionCash = 0,
			name = "A Wider Market",
			kind = "tracker",
			requires = {"HG17"},
			briefing = (
				"Bandits are bad for deliveries. Remove the ones on the order; I still need paying "
				.. "customers."
			),
			completion = "You've kept your end of the arrangement. I remember reliable people.",
			target = 20,
			benefits = {},
		},
		{
			id = "HG20",
			completionCash = 2250,
			name = "The Empty Depot",
			kind = "field",
			objective = "Recover Corporate Records Folder from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"HG18"},
			briefing = "Retrieve shipment records from an abandoned depot.",
			completion = "Hand it over. I want to read the small print.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_archive",
				label = "The Empty Depot - Corporate Records Folder",
			},
			benefits = {},
		},
		{
			id = "HG21",
			completionCash = 1775,
			name = "Proof of Delivery",
			kind = "delivery",
			requires = {"HG19", "HG20"},
			briefing = "Bring what's listed here. I'll check the goods before we settle this part of the deal.",
			completion = "Good. Something I can actually put to use.",
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 2,
				},
			},
			benefits = {},
		},
		{
			id = "HG22",
			completionCash = 2450,
			name = "The Unpaid Supplier",
			kind = "field",
			objective = "Recover Personnel File Folder from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"HG21"},
			briefing = "Recover a supplier's personal evidence at a remote cache.",
			completion = "Let's see whose name is on this one.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_personnel",
				label = "The Unpaid Supplier - Personnel File Folder",
			},
			benefits = {},
		},
		{
			id = "HG23",
			completionCash = 0,
			name = "Closing the Account",
			kind = "tracker",
			requires = {"HG22"},
			briefing = (
				"Bandits are bad for deliveries. Remove the ones on the order; I still need paying "
				.. "customers."
			),
			completion = "You've kept your end of the arrangement. I remember reliable people.",
			target = 27,
			benefits = {},
		},
		{
			id = "HG24",
			completionCash = 2650,
			name = "The Last Ledger",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"HG23"},
			briefing = "Recover the racket's central ledger at its final NPC outpost.",
			completion = "Good. I prefer an account I can check.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_notebook",
				label = "The Last Ledger - Tied Leather Journal",
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
			id = "HG25",
			completionCash = 2000,
			name = "A Shop That Lasts",
			kind = "delivery",
			requires = {"HG24"},
			briefing = "Bring what's listed here. I'll check the goods before we settle this part of the deal.",
			completion = "As agreed. Let me count it.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 7,
				},
			},
			benefits = {},
		},
		{
			id = "HG26",
			completionCash = 2850,
			name = "Nobody Collects Here",
			kind = "field",
			objective = "Recover Corporate Letter from the assigned search area in Marsh. Return it to this contact"
				.. " to finish the assignment.",
			requires = {"HG25"},
			briefing = (
				"Recover the final contract evidence for comparison with the other contracts. Keep the whole "
				.. "letter. People have a habit of remembering the generous half of an agreement and losing the rest."
			),
			completion = (
				"Hand it over. I want to read the small print. There it is. Small print and all. You've been more "
				.. "reliable than several people who insist I call them partners. Don't let that go to your head; I "
				.. "still expect you to read your orders."
			),
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_contract",
				label = "Nobody Collects Here - Corporate Letter",
			},
			benefits = {},
			recognition = "Haggler's trusted contact",
		},
	},
})
