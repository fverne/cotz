PLUGIN:Register("ledger", {
	name = "'Ledger'",
	template = "ledgernpc",
	difficultyMultiplier = 4,
	enforceCatalogue = true,
	map = "rp_waystation",
	job = {
		kind = "deadDrop",
		category = "Dead-drop circuits",
		description = "Dead-drop circuits",
		maps = {
			easy = "rp_waystation",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {},
	rewards = {
		packages = {
			{label = "Short route",
				items = {"food_raisins", "drink_bottlewater"}},
			{label = "Long haul",
				items = {"food_can_tushonka", "food_can_beans"}},
			{label = "Emergency stop",
				items = {"medic_bandage_1", "lowtiercookerfuel"}},
		},
	},
	dialogue = {
		delivery = "The parcel first. Then I can close the entry.",
		completedGreeting = (
			"Good to see you. Your work has saved me a number of difficult enquiries. What can I help "
			.. "you with today?"
		),
		workPrompt = "About the freight circuit I'm carrying.",
		offerPrompt = "Do you have a freight circuit?",
		work = (
			"Collect the sealed parcel at the assigned pickup, deliver it to the assigned cache, then return. "
			.. "Both ends matter. Check them before collecting. I'd rather answer a question here than record "
			.. "another delivery nobody can agree has arrived. You can take time to prepare without making the "
			.. "destination uncertain."
		),
		progressionPrompt = "What needs doing in the dispatch records?",
		progression = (
			"There are freight records missing and circuits that need completing. I want each movement settled "
			.. "against an actual return, not a plausible explanation from the nearest person. Some papers need "
			.. "another contact's inspection; their destination is on the order. Come back after the handover. I "
			.. "still need to close this end of the account."
		),
	},
	catalogue = {
		["acog"] = {step = "LE19",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["aimpoint"] = {step = "LE11",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["backpack_1"] = {step = "LE01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["backpack_1_large"] = {step = "LE14",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["backpack_2"] = {step = "LE09",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["backpack_2_large"] = {step = "LE22",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["backpack_3"] = {step = "LE05",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["backpack_3_large"] = {step = "LE18",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["cmore"] = {step = "LE07",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["cobrasuppressor"] = {step = "LE10",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["eotech"] = {step = "LE05",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["kingarmsmr"] = {step = "LE13",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["kobra"] = {step = "LE03",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["microt1"] = {step = "LE04",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["nightforce"] = {step = "LE22",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["pbssuppressor"] = {step = "LE17",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["pso1"] = {step = "LE15",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["sakersuppressor"] = {step = "LE21",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["shortdot"] = {step = "LE16",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["trijiconrmr"] = {step = "LE01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["tundrasuppressor"] = {step = "LE09",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
	},
	progression = {
		{
			id = "LE01",
			completionCash = 275,
			name = "Labels That Last",
			kind = "delivery",
			requires = {},
			briefing = (
				"I need supplies for the dispatch work. Have a look at the request before you load up; it saves "
				.. "both ends a second journey. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thank you. I will check these into the account before the next request arrives.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "LE02",
			stock = {item = "backpack_1", bonus = 1},
			completionCash = 450,
			name = "The First Route",
			kind = "field",
			objective = (
				"Collect the first sealed freight parcel at the assigned pickup in Waystation and deliver it to "
				.. "the assigned cache. Come back to the issuing contact in Waystation."
			),
			requires = {"LE01"},
			briefing = (
				"A parcel needs moving between the assigned drops. Check both destinations before you take the "
				.. "load; collection is only half the journey. Collect the first sealed freight parcel at the "
				.. "assigned pickup in Waystation and deliver it to the assigned cache. Come back to me in "
				.. "Waystation."
			),
			completion = (
				"Delivery complete. Thank you. I can close that movement rather than carrying it into tomorrow's "
				.. "enquiries."
			),
			field = {
				description = (
					"A small yellow hard case with ribbed corners and a large label on its lid. Ledger's note: \"A "
					.. "parcel needs moving between the assigned drops.\""
				),
				kind = "deadDrop",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_case",
				label = "First sealed freight parcel",
			},
			benefits = {},
		},
		{
			id = "LE03",
			stock = {item = "trijiconrmr", bonus = 1},
			completionCash = 0,
			name = "Delivered Intact",
			kind = "tracker",
			requires = {"LE02"},
			briefing = "Complete the assigned dead-drop circuits. The receiving endpoint matters as much as collection.",
			completion = "A few complete movements. Thank you for finishing both ends.",
			target = 2,
			benefits = {},
		},
		{
			id = "LE04",
			completionCash = 650,
			name = "A small delivery",
			kind = "delivery",
			retiredCommission = true,
			objective = "Bring all 1 listed item type to this contact. The request shows each selected item and required units.",
			requires = {"LE02"},
			briefing = (
				"I need supplies for the dispatch work. Have a look at the request before you load up; it saves "
				.. "both ends a second journey. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thank you. I will check these into the account before the next request arrives.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "LE05",
			completionCash = 575,
			name = "Stock for the Road",
			kind = "delivery",
			requires = {"LE03"},
			briefing = (
				"I need supplies for the dispatch work. Have a look at the request before you load up; it saves "
				.. "both ends a second journey. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thank you. I will check these into the account before the next request arrives.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "LE06",
			stock = {item = "backpack_3", bonus = 1},
			completionCash = 850,
			name = "Ballast's Landing Copy",
			kind = "field",
			objective = (
				"Recover the landing manifest for Ballast from the assigned search area in Marsh. Deliver it to "
				.. "'Ballast' in Marsh, then come back to the issuing contact in Waystation."
			),
			requires = {"LE04"},
			briefing = (
				"Ballast needs the landing copy. He can check what was actually handled against the freight "
				.. "record. Recover the landing manifest for Ballast from the assigned search area in Marsh. Deliver "
				.. "it to 'Ballast' in Marsh, then come back to me in Waystation."
			),
			completion = "Delivered. Thank you. He should be able to answer from the page now.",
			field = {
				description = (
					"A printed packing list on a small clipboard with a metal clip and a circular stamp. Ledger's "
					.. "note: \"Ballast needs the landing copy.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_manifest",
				label = "Landing manifest for Ballast",
				recipient = "ballast",
			},
			benefits = {},
		},
		{
			id = "LE07",
			stock = {item = "kobra", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement passage consumer; verify these proposed terms before enabling.
				{
					destination = "Garbage",
					effect = (
						"Optional Waystation–Garbage shortcut via settlement freight corridor; author "
						.. "distinct safe endpoints and permissions."
					),
					id = "ledger/LE07/future",
					kind = "passage",
					name = "settlement freight corridor",
					origin = "Waystation",
					provider = "ledger",
					status = "unimplemented",
					route = "settlement freight corridor",
				},
			},
			completionCash = 0,
			name = "On Both Sides",
			kind = "tracker",
			requires = {"LE05"},
			briefing = "Continue the freight circuits. Read the delivery endpoint before taking the parcel.",
			completion = "Another reliable run. There are fewer open lines waiting on an arrival.",
			target = 5,
		},
		{
			id = "LE08",
			stock = {item = "microt1", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Permanent offer for food_bread; consume inputs each time, enforce equipment tiers "
						.. "and audit resale value."
					),
					id = "ledger/LE08/future",
					inputs = {
						{
							item = "value_officepaper",
							quantity = 1,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: food_bread",
					outputs = {
						{
							item = "food_bread",
							quantity = 1,
						},
					},
					provider = "ledger",
					status = "unimplemented",
				},
			},
			completionCash = 1050,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"LE06"},
			briefing = (
				"I need supplies for the dispatch work. Have a look at the request before you load up; it saves "
				.. "both ends a second journey. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thank you. I will check these into the account before the next request arrives.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_2",
					quantity = 1,
				},
			},
		},
		{
			id = "LE09",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Permanent offer for drink_bottlewater; consume inputs each time, enforce equipment "
						.. "tiers and audit resale value."
					),
					id = "ledger/LE09/future",
					inputs = {
						{
							item = "value_officepaper",
							quantity = 1,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: drink_bottlewater",
					outputs = {
						{
							item = "drink_bottlewater",
							quantity = 1,
						},
					},
					provider = "ledger",
					status = "unimplemented",
				},
			},
			completionCash = 875,
			name = "Paperwork That Matches",
			kind = "delivery",
			requires = {"LE07"},
			briefing = (
				"I need supplies for the dispatch work. Have a look at the request before you load up; it saves "
				.. "both ends a second journey. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thank you. I will check these into the account before the next request arrives.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_2",
					quantity = 1,
				},
			},
		},
		{
			id = "LE10",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Permanent offer for lowtiercookerfuel; consume inputs each time, enforce equipment "
						.. "tiers and audit resale value."
					),
					id = "ledger/LE10/future",
					inputs = {
						{
							item = "value_officepaper",
							quantity = 2,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: lowtiercookerfuel",
					outputs = {
						{
							item = "lowtiercookerfuel",
							quantity = 1,
						},
					},
					provider = "ledger",
					status = "unimplemented",
				},
			},
			completionCash = 1250,
			name = "The Duplicate Destination",
			kind = "field",
			objective = (
				"Recover the conflicting destination records from the assigned search area in Waystation. Bring it "
				.. "back to the issuing contact in Waystation."
			),
			requires = {"LE08"},
			briefing = (
				"Bring the destination record back intact. I'd like to examine the accounts before deciding which "
				.. "instruction was misunderstood. Recover the conflicting destination records from the assigned "
				.. "search area in Waystation. Bring it back to me in Waystation."
			),
			completion = "Good. I'll retain the competing entries while I check them.",
			field = {
				description = (
					"A cardboard file folder with a small coloured crest on its cover. Ledger's note: \"Bring the "
					.. "destination record back intact.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_official",
				label = "Conflicting destination records",
			},
		},
		{
			id = "LE11",
			stock = {item = "backpack_2", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement passage consumer; verify these proposed terms before enabling.
				{
					destination = "Garbage",
					effect = (
						"Optional Waystation–Garbage shortcut via recovered consignment corridor; author "
						.. "distinct safe endpoints and permissions."
					),
					id = "ledger/LE11/future",
					kind = "passage",
					name = "recovered consignment corridor",
					origin = "Waystation",
					provider = "ledger",
					status = "unimplemented",
					route = "recovered consignment corridor",
				},
			},
			completionCash = 0,
			name = "More Than Local",
			kind = "tracker",
			requires = {"LE09"},
			briefing = "More completed circuit deliveries when you're prepared.",
			completion = "You've kept the movements accounted for. That helps the next person plan.",
			target = 9,
		},
		{
			id = "LE12",
			stock = {item = "eotech", bonus = 1},
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Permanent offer for medic_bandage_1; consume inputs each time, enforce equipment "
						.. "tiers and audit resale value."
					),
					id = "ledger/LE12/future",
					inputs = {
						{
							item = "value_officepaper",
							quantity = 2,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: medic_bandage_1",
					outputs = {
						{
							item = "medic_bandage_1",
							quantity = 1,
						},
					},
					provider = "ledger",
					status = "unimplemented",
				},
			},
			completionCash = 1450,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"LE10"},
			briefing = (
				"I need supplies for the dispatch work. Have a look at the request before you load up; it saves "
				.. "both ends a second journey. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thank you. I will check these into the account before the next request arrives.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_records_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "LE13",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Permanent offer for food_raisins; consume inputs each time, enforce equipment "
						.. "tiers and audit resale value."
					),
					id = "ledger/LE13/future",
					inputs = {
						{
							item = "value_officepaper",
							quantity = 3,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: food_raisins",
					outputs = {
						{
							item = "food_raisins",
							quantity = 1,
						},
					},
					provider = "ledger",
					status = "unimplemented",
				},
			},
			completionCash = 1175,
			name = "For the Remote Cache",
			kind = "delivery",
			requires = {"LE11"},
			briefing = (
				"I need supplies for the dispatch work. Have a look at the request before you load up; it saves "
				.. "both ends a second journey. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thank you. I will check these into the account before the next request arrives.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_records_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_3",
					quantity = 1,
				},
			},
		},
		{
			id = "LE14",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Permanent offer for drink_bottletea; consume inputs each time, enforce equipment "
						.. "tiers and audit resale value."
					),
					id = "ledger/LE14/future",
					inputs = {
						{
							item = "value_officepaper",
							quantity = 3,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: drink_bottletea",
					outputs = {
						{
							item = "drink_bottletea",
							quantity = 1,
						},
					},
					provider = "ledger",
					status = "unimplemented",
				},
			},
			completionCash = 1650,
			name = "The Last Scheduled Drop",
			kind = "field",
			objective = (
				"Collect the scheduled remote-drop parcel at the assigned pickup in Waystation and deliver it to "
				.. "the assigned cache. Come back to the issuing contact in Waystation."
			),
			requires = {"LE12"},
			briefing = (
				"The next parcel goes between the assigned cache points. Check the return instruction as well; I "
				.. "want to know the movement is finished. Collect the scheduled remote-drop parcel at the assigned "
				.. "pickup in Waystation and deliver it to the assigned cache. Come back to me in Waystation."
			),
			completion = "Delivered. I can stop keeping that line open for a possible arrival.",
			field = {
				description = (
					"A compact hard case with orange panels, dark protective ribs and a carrying handle. Ledger's "
					.. "note: \"The next parcel goes between the assigned cache points.\""
				),
				kind = "deadDrop",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_evidence",
				label = "Scheduled remote-drop parcel",
			},
		},
		{
			id = "LE15",
			stock = {item = "cmore", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement passage consumer; verify these proposed terms before enabling.
				{
					destination = "Garbage",
					effect = (
						"Optional Waystation–Garbage shortcut via remote cache corridor; author distinct "
						.. "safe endpoints and permissions."
					),
					id = "ledger/LE15/future",
					kind = "passage",
					name = "remote cache corridor",
					origin = "Waystation",
					provider = "ledger",
					status = "unimplemented",
					route = "remote cache corridor",
				},
			},
			completionCash = 0,
			name = "A Dependable Circuit",
			kind = "tracker",
			requires = {"LE13"},
			briefing = "Keep the freight circuits going while I examine the dispatch records.",
			completion = "A substantial amount delivered. I haven't had to replace your returns with estimates.",
			target = 14,
		},
		{
			id = "LE16",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Permanent offer for food_can_tushonka; consume inputs each time, enforce equipment "
						.. "tiers and audit resale value."
					),
					id = "ledger/LE16/future",
					inputs = {
						{
							item = "value_officepaper",
							quantity = 4,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: food_can_tushonka",
					outputs = {
						{
							item = "food_can_tushonka",
							quantity = 1,
						},
					},
					provider = "ledger",
					status = "unimplemented",
				},
			},
			completionCash = 1850,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"LE14"},
			briefing = (
				"I need supplies for the dispatch work. Have a look at the request before you load up; it saves "
				.. "both ends a second journey. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thank you. I will check these into the account before the next request arrives.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_records_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_3",
					quantity = 1,
				},
			},
		},
		{
			id = "LE17",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Permanent offer for food_nuts_2; consume inputs each time, enforce equipment tiers "
						.. "and audit resale value."
					),
					id = "ledger/LE17/future",
					inputs = {
						{
							item = "value_officepaper",
							quantity = 4,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: food_nuts_2",
					outputs = {
						{
							item = "food_nuts_2",
							quantity = 1,
						},
					},
					provider = "ledger",
					status = "unimplemented",
				},
			},
			completionCash = 1475,
			name = "Proof on Paper",
			kind = "delivery",
			requires = {"LE15"},
			briefing = (
				"I need supplies for the dispatch work. Have a look at the request before you load up; it saves "
				.. "both ends a second journey. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thank you. I will check these into the account before the next request arrives.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_records_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_3",
					quantity = 1,
				},
			},
		},
		{
			id = "LE18",
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Permanent offer for food_mre_russia; consume inputs each time, enforce equipment "
						.. "tiers and audit resale value."
					),
					id = "ledger/LE18/future",
					inputs = {
						{
							item = "value_officepaper",
							quantity = 4,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: food_mre_russia",
					outputs = {
						{
							item = "food_mre_russia",
							quantity = 1,
						},
					},
					provider = "ledger",
					status = "unimplemented",
				},
			},
			completionCash = 2050,
			name = "The Dispatcher's Detour",
			kind = "field",
			objective = (
				"Recover the dispatcher's detour recording from the assigned search area in Pripyat. Bring it back "
				.. "to the issuing contact in Waystation."
			),
			requires = {"LE16"},
			briefing = (
				"I'd like the later dispatcher recording recovered. A changed route deserves more than a guess "
				.. "about why they took it. Recover the dispatcher's detour recording from the assigned search area "
				.. "in Pripyat. Bring it back to me in Waystation."
			),
			completion = "I'll put it beside the earlier account before trying to reconcile the detour.",
			field = {
				description = (
					"A pale audio cassette with a handwritten dedication above the spool windows. Ledger's note: \"I'd "
					.. "like the later dispatcher recording recovered.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_tape",
				label = "Dispatcher's detour recording",
			},
			benefits = {},
		},
		{
			id = "LE19",
			stock = {item = "tundrasuppressor", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement passage consumer; verify these proposed terms before enabling.
				{
					destination = "Garbage",
					effect = (
						"Optional Waystation–Garbage shortcut via expedition freight corridor; author "
						.. "distinct safe endpoints and permissions."
					),
					id = "ledger/LE19/future",
					kind = "passage",
					name = "expedition freight corridor",
					origin = "Waystation",
					provider = "ledger",
					status = "unimplemented",
					route = "expedition freight corridor",
				},
			},
			completionCash = 0,
			name = "The Route Holds",
			kind = "tracker",
			requires = {"LE17", "LE18"},
			briefing = "Continue the assigned circuit deliveries. Check the route even when the title is familiar.",
			completion = "You've stayed dependable across the account. I appreciate that.",
			target = 20,
		},
		{
			id = "LE20",
			stock = {item = "cobrasuppressor", bonus = 1},
			completionCash = 2250,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"LE19"},
			briefing = (
				"I need supplies for the dispatch work. Have a look at the request before you load up; it saves "
				.. "both ends a second journey. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thank you. I will check these into the account before the next request arrives.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_records_waystation_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_records_waystation_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_4",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "LE21",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Permanent offer for food_mre_ukraine; consume inputs each time, enforce equipment "
						.. "tiers and audit resale value."
					),
					id = "ledger/LE21/future",
					inputs = {
						{
							item = "value_officepaper",
							quantity = 5,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: food_mre_ukraine",
					outputs = {
						{
							item = "food_mre_ukraine",
							quantity = 1,
						},
					},
					provider = "ledger",
					status = "unimplemented",
				},
			},
			completionCash = 1775,
			name = "The Next Shipment",
			kind = "delivery",
			requires = {"LE20"},
			briefing = (
				"I need supplies for the dispatch work. Have a look at the request before you load up; it saves "
				.. "both ends a second journey. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thank you. I will check these into the account before the next request arrives.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_records_waystation_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_records_waystation_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_4",
					quantity = 1,
				},
			},
		},
		{
			id = "LE22",
			completionCash = 2450,
			name = "The Last Receipt",
			kind = "field",
			objective = (
				"Recover the final route receipt from the assigned search area in Waystation. Bring it back to the "
				.. "issuing contact in Waystation."
			),
			requires = {"LE21"},
			briefing = (
				"Bring the route's final receipt back here. I'd like to read the closing entry myself instead of "
				.. "collecting versions of it. Recover the final route receipt from the assigned search area in "
				.. "Waystation. Bring it back to me in Waystation."
			),
			completion = (
				"That's the last receipt. You've spared several people some long waits and me a considerable "
				.. "number of enquiries. I appreciate the reliability. For once, we can have a conversation without a "
				.. "parcel between us."
			),
			field = {
				description = (
					"A clipboard carrying a densely printed packing list and a stamped mark. Ledger's note: \"Bring "
					.. "the route's final receipt back here.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_receipt",
				label = "Final route receipt",
			},
			benefits = {},
			recognition = "Ledger's trusted contact",
		},
	},
})
