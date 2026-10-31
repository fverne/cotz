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
		pools = {"administrative_documents"},
		quantities = {5, 9, 15},
		maps = {
			easy = "rp_marsh_cs",
			medium = "mz_garbage",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	dialogue = {
		completedGreeting = (
			"You've kept your end of the business. What can I do for you?"
		),
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = "Bandits are bad for deliveries. Remove the ones on the order; I still need paying customers.",
		progressionPrompt = "What else needs doing?",
		progression = "Missing invoices, missing goods, people asking to be paid twice. Pick a problem.",
	},
	catalogue = {
		["357magnum"] = {step = "HG13",
			terms = {nil, 4, "SELLANDBUY", 4, 12, 1}},
		["44magnum"] = {step = "HG11",
			terms = {nil, 4, "SELLANDBUY", 4, 12, 1}},
		["500magnum"] = {step = "HG15",
			terms = {nil, 4, "SELLANDBUY", 4, 12, 1}},
		["akm"] = {step = "HG11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["aks74u"] = {step = "HG09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["bat"] = {step = "HG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["brhp"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["c96carbine"] = {step = "HG05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["fort12"] = {step = "HG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["g2contender500"] = {step = "HG15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["ithaca37"] = {step = "HG09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["kiparis"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["kp31"] = {step = "HG09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["lax410"] = {step = "HG09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["lax410s"] = {step = "HG05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["m1887"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["m1911"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["m1911chic"] = {step = "HG13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mac11"] = {step = "HG11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mosin"] = {step = "HG11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mp34"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mp40"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["ppsh"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["rugermini14"] = {step = "HG09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["saigasemi"] = {step = "HG11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["saigasemi545"] = {step = "HG05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sako85"] = {step = "HG09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sako85nato"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sks"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sten"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sterling"] = {step = "HG09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["svt40"] = {step = "HG13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["swmodel29"] = {step = "HG11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["toz194"] = {step = "HG05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["toz34"] = {step = "HG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["toz34short"] = {step = "HG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["toz66"] = {step = "HG05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["toz66short"] = {step = "HG05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["w1895"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["w9422357"] = {step = "HG13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "HG01",
			name = "Opening the Shutters",
			kind = "delivery",
			requires = {},
			briefing = "Bring what's listed here. I'll check the goods before we settle this part of the deal.",
			completion = "As agreed. Let me count it.",
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
			name = "The Missing Invoice",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"HG01"},
			briefing = "Recover an invoice from a Marsh trading stop.",
			completion = "Hand it over. I want to read the small print.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
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
			id = "HG03",
			name = "A Small Problem",
			kind = "tracker",
			requires = {"HG02"},
			briefing = (
				"Bandits are bad for deliveries. Remove the ones on the order; I still need paying "
				.. "customers."
			),
			completion = "You've kept your end of the arrangement. I remember reliable people.",
			target = 2,
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
			id = "HG04",
			name = "Who Pays Twice",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"HG03"},
			briefing = "Recover an extortion receipt from a hostile NPC camp.",
			completion = "Let's see whose name is on this one.",
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
			id = "HG05",
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
			id = "HG06",
			name = "The Wrong Seal",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"HG04"},
			briefing = "Retrieve a consignment seal record along a Marsh route.",
			completion = "Good. I prefer an account I can check.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
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
			name = "Safer Roads",
			kind = "tracker",
			requires = {"HG05"},
			briefing = (
				"Bandits are bad for deliveries. Remove the ones on the order; I still need paying "
				.. "customers."
			),
			completion = "You've kept your end of the arrangement. I remember reliable people.",
			target = 5,
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
			id = "HG08",
			name = "The Abandoned Stall",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"HG06"},
			briefing = "Recover a trader's account book in Garbage.",
			completion = "Hand it over. I want to read the small print.",
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
			id = "HG09",
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
			id = "HG10",
			name = "Two Sets of Books",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"HG08"},
			briefing = "Retrieve a second ledger from a freight cache.",
			completion = "Let's see whose name is on this one.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
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
			id = "HG11",
			name = "Paying Customers",
			kind = "tracker",
			requires = {"HG09"},
			briefing = (
				"Bandits are bad for deliveries. Remove the ones on the order; I still need paying "
				.. "customers."
			),
			completion = "You've kept your end of the arrangement. I remember reliable people.",
			target = 9,
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
			id = "HG12",
			name = "The Collector's Route",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"HG10"},
			briefing = "Recover route notes at a hostile NPC staging site.",
			completion = "Good. I prefer an account I can check.",
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
			id = "HG13",
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
			id = "HG14",
			name = "A Broken Agreement",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"HG12"},
			briefing = "Retrieve a supplier contract in Garbage.",
			completion = "Hand it over. I want to read the small print.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
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
			id = "HG15",
			name = "No More Tolls",
			kind = "tracker",
			requires = {"HG13"},
			briefing = (
				"Bandits are bad for deliveries. Remove the ones on the order; I still need paying "
				.. "customers."
			),
			completion = "You've kept your end of the arrangement. I remember reliable people.",
			target = 14,
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
			id = "HG16",
			name = "The Broker's Copy",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"HG14"},
			briefing = "Recover a duplicate contract in Waystation territory.",
			completion = "Let's see whose name is on this one.",
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
			id = "HG17",
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
			id = "HG18",
			name = "The Shipment List",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"HG16"},
			briefing = "Recover a manifest identifying the racket's distributor.",
			completion = "Good. I prefer an account I can check.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
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
			name = "A Wider Market",
			kind = "tracker",
			requires = {"HG17"},
			briefing = (
				"Bandits are bad for deliveries. Remove the ones on the order; I still need paying "
				.. "customers."
			),
			completion = "You've kept your end of the arrangement. I remember reliable people.",
			target = 20,
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
			id = "HG20",
			name = "The Empty Depot",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"HG18"},
			briefing = "Retrieve shipment records from an abandoned depot.",
			completion = "Hand it over. I want to read the small print.",
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
			id = "HG21",
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
			id = "HG22",
			name = "The Unpaid Supplier",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"HG21"},
			briefing = "Recover a supplier's personal evidence at a remote cache.",
			completion = "Let's see whose name is on this one.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
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
			id = "HG23",
			name = "Closing the Account",
			kind = "tracker",
			requires = {"HG22"},
			briefing = (
				"Bandits are bad for deliveries. Remove the ones on the order; I still need paying "
				.. "customers."
			),
			completion = "You've kept your end of the arrangement. I remember reliable people.",
			target = 27,
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
			id = "HG24",
			name = "The Last Ledger",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"HG23"},
			briefing = "Recover the racket's central ledger at its final NPC outpost.",
			completion = "Good. I prefer an account I can check.",
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
			id = "HG25",
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
			id = "HG26",
			name = "Nobody Collects Here",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"HG25"},
			briefing = "Recover the final contract evidence for comparison with the other contracts.",
			completion = "Hand it over. I want to read the small print.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
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
			recognition = "Haggler's trusted contact",
		},
	},
})
