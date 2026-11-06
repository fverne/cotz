PLUGIN:Register("ballast", {
	name = "'Ballast'",
	template = "ballastnpc",
	difficultyMultiplier = 1,
	enforceCatalogue = true,
	map = "rp_marsh_cs",
	courierPools = {
		"valuables_transit_cases",
		"valuables_reinforced_cases",
		"valuables_equipment_pouches",
		"valuables_protective_textiles",
	},
	job = {
		kind = "recovery",
		category = "Equipment recovery",
		description = "Equipment recovery",
		maps = {
			easy = "rp_marsh_cs",
			medium = "rp_marsh_cs",
			hard = "rp_garbage_cotz",
		},
	},
	legacyJob = {
		kind = "recovery",
		category = "Equipment recovery",
		description = "Equipment recovery",
		maps = {
			easy = "rp_marsh_cs",
			medium = "rp_garbage_cotz",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {},
	rewards = {
		cashPerTier = 200,
		packages = {
		},
		bonusPackages = {
			{label = "Euro notes", items = {"value_currency_euro"}},
			{label = "Dollar notes", items = {"value_currency_dollar"}},
		},
	},
	dialogue = {
		delivery = "Over here. If it is still dry, we are off to a good start.",
		completedGreeting = (
			"Back with both boots, I see. Always a promising start to a conversation. What do you need?"
		),
		workPrompt = "About the case I'm recovering.",
		offerPrompt = "Do you have a recovery job?",
		work = (
			"A marked case, brought back intact. Have a look at the return before you load yourself down. "
			.. "People become inventive about routes once they've got both hands full, and the inventions rarely "
			.. "improve my afternoon. Check the region before agreeing. I can wait while you prepare."
		),
		progressionPrompt = "What needs sorting out along the freight route?",
		progression = (
			"There's stranded freight and a crew's scattered records to bring through. I want the cases "
			.. "recovered and the accounts read before anyone supplies an ending. Some deliveries go to somebody "
			.. "who can check a particular part. Finish that handover, then come back here. I'll try to have "
			.. "cleared somewhere dry by then."
		),
	},
	catalogue = {
		["bat"] = {step = "BA13",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["crowbar"] = {step = "BA11",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drink_bottlebeer_1"] = {step = "BA09",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drink_bottlebeer_2"] = {step = "BA07",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drink_bottlebeer_3"] = {step = "BA05",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drink_bottlebeer_4"] = {step = "BA03",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drink_bottlebeer_5"] = {step = "BA08",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drink_bottlebeer_6"] = {step = "BA06",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drink_canbeer_1"] = {step = "BA02",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drink_canbeer_2"] = {step = "BA01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drink_canbeer_3"] = {step = "BA02",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drink_canbeer_4"] = {step = "BA04",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drink_canbeer_5"] = {step = "BA07",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drink_canbeer_6"] = {step = "BA05",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drink_moonshine"] = {step = "BA09",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drink_spirit_1"] = {step = "BA19",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drink_spirit_2"] = {step = "BA20",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drink_spirit_3"] = {step = "BA21",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drink_vodka_1"] = {step = "BA12",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drink_vodka_2"] = {step = "BA11",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drink_vodka_3"] = {step = "BA14",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drink_vodka_4"] = {step = "BA16",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drink_vodka_5"] = {step = "BA19",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drink_vodka_6"] = {step = "BA15",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drink_wine"] = {step = "BA14",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["fireaxe"] = {step = "BA17",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["fubar"] = {step = "BA21",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["hidestasher_cleaningkit"] = {step = "BA18",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["hidestasher_cutlery"] = {step = "BA10",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["hidestasher_shovel"] = {step = "BA22",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["sledgehammer"] = {step = "BA16",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
	},
	progression = {
		{
			id = "BA01",
			completionCash = 275,
			name = "A Dry Package",
			kind = "delivery",
			requires = {},
			briefing = (
				"I need packing supplies for the loads coming through. It is easier to keep a load dry than "
				.. "explain afterwards why nobody thought of it. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BA02",
			completionCash = 450,
			name = "The First Stranding",
			kind = "field",
			objective = (
				"Recover the stranded freight case from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"BA01"},
			briefing = (
				"A case has been left out along the route. Its owner has explained how urgent it is at greater "
				.. "length than how it got there. Recover the stranded freight case from the assigned search area in "
				.. "Marsh. Bring it back to me in Marsh."
			),
			completion = "You and the case, both here. Put it down gently; you've finished carrying it.",
			field = {
				description = (
					"A small yellow hard case with ribbed corners and a large label on its lid. Ballast's note: \"A "
					.. "case has been left out along the route.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_case",
				label = "Stranded freight case",
			},
			benefits = {},
		},
		{
			id = "BA03",
			stock = {item = "drink_canbeer_2", bonus = 1},
			completionCash = 0,
			name = "Nothing Left Behind",
			kind = "tracker",
			requires = {"BA02"},
			briefing = "Keep bringing the marked recovery cases back. Finding them is the beginning of the carrying.",
			completion = "A few good returns. You seem to think about the journey home.",
			target = 2,
			benefits = {},
		},
		{
			id = "BA04",
			completionCash = 650,
			name = "A small delivery",
			kind = "delivery",
			retiredCommission = true,
			objective = "Bring all 1 listed item type to this contact. The request shows each selected item and required units.",
			requires = {"BA02"},
			briefing = (
				"I need packing supplies for the loads coming through. It is easier to keep a load dry than "
				.. "explain afterwards why nobody thought of it. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BA05",
			completionCash = 575,
			name = "Fuel for the Return",
			kind = "delivery",
			requires = {"BA03"},
			briefing = (
				"I need packing supplies for the loads coming through. It is easier to keep a load dry than "
				.. "explain afterwards why nobody thought of it. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BA06",
			completionCash = 850,
			name = "A Missing Mooring",
			kind = "field",
			objective = (
				"Recover the landing maintenance tools from the assigned search area in Marsh. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"BA04"},
			briefing = (
				"There's a tool case left with the maintenance work. Tools are useful company, but only when "
				.. "somebody remembers to bring them home. Recover the landing maintenance tools from the assigned "
				.. "search area in Marsh. Bring it back to me in Marsh."
			),
			completion = "Handle's still attached. Better return than some I've seen.",
			field = {
				description = (
					"A handled tool case covered in bright stickers and contrasting printed decoration. Ballast's "
					.. "note: \"There's a tool case left with the maintenance work.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_tools",
				label = "Landing maintenance tools",
			},
			benefits = {},
		},
		{
			id = "BA07",
			stock = {item = "drink_canbeer_3", bonus = 1},
			completionCash = 0,
			name = "A Reliable Pair of Hands",
			kind = "tracker",
			requires = {"BA05"},
			briefing = "More recovery work. Leave yourself room for the case before you go looking.",
			completion = "You've been dependable about getting the load all the way here.",
			target = 5,
			benefits = {},
		},
		{
			id = "BA08",
			completionCash = 1050,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"BA06"},
			briefing = (
				"I need packing supplies for the loads coming through. It is easier to keep a load dry than "
				.. "explain afterwards why nobody thought of it. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BA09",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement passage consumer; verify these proposed terms before enabling.
				{
					destination = "Waystation",
					effect = (
						"Optional Marsh–Waystation shortcut via Marsh supply landing; author distinct safe "
						.. "endpoints and permissions."
					),
					id = "ballast/BA09/future",
					kind = "passage",
					name = "Marsh supply landing",
					origin = "Marsh",
					provider = "ballast",
					status = "unimplemented",
					route = "Marsh supply landing",
				},
			},
			completionCash = 875,
			name = "Names on the Manifest",
			kind = "delivery",
			requires = {"BA07"},
			briefing = (
				"I need packing supplies for the loads coming through. It is easier to keep a load dry than "
				.. "explain afterwards why nobody thought of it. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 1,
				},
			},
		},
		{
			id = "BA10",
			completionCash = 1250,
			name = "The Floating Trail",
			kind = "field",
			objective = (
				"Recover the crew route cassette from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"BA08"},
			briefing = (
				"There's a recording from the crew's route. I'd rather hear their own account before listening to "
				.. "another confident explanation. Recover the crew route cassette from the assigned search area in "
				.. "Marsh. Bring it back to me in Marsh."
			),
			completion = "Leave it here. I'll listen from the beginning, including the bits that don't sound important.",
			field = {
				description = (
					"A pale audio cassette with a handwritten dedication above the spool windows. Ballast's note: "
					.. "\"There's a recording from the crew's route.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_tape",
				label = "Crew route cassette",
			},
			benefits = {},
		},
		{
			id = "BA11",
			stock = {item = "drink_canbeer_1", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on waterlogged cargo handling; author actionable guidance "
						.. "tied to verified mechanics and locations."
					),
					id = "ballast/BA11/future",
					kind = "information",
					name = "Record: waterlogged cargo handling",
					provider = "ballast",
					status = "unimplemented",
					topic = "waterlogged cargo handling",
				},
			},
			completionCash = 0,
			name = "Recover What Matters",
			kind = "tracker",
			requires = {"BA09"},
			briefing = "Continue the case recoveries. I prefer an intact return to an impressive departure.",
			completion = "Another proper set of returns. Not much to complain about there.",
			target = 9,
		},
		{
			id = "BA12",
			services = {{id = "storage", name = "Hideout storage access"}},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on Marsh landing approaches; author actionable guidance tied "
						.. "to verified mechanics and locations."
					),
					id = "ballast/BA12/future",
					kind = "information",
					name = "Record: Marsh landing approaches",
					provider = "ballast",
					status = "unimplemented",
					topic = "Marsh landing approaches",
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
			requires = {"BA10"},
			briefing = (
				"I need packing supplies for the loads coming through. It is easier to keep a load dry than "
				.. "explain afterwards why nobody thought of it. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BA13",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on recovery load planning; author actionable guidance tied to "
						.. "verified mechanics and locations."
					),
					id = "ballast/BA13/future",
					kind = "information",
					name = "Record: recovery load planning",
					provider = "ballast",
					status = "unimplemented",
					topic = "recovery load planning",
				},
			},
			completionCash = 1175,
			name = "Patch and Pack",
			kind = "delivery",
			requires = {"BA11"},
			briefing = (
				"I need packing supplies for the loads coming through. It is easier to keep a load dry than "
				.. "explain afterwards why nobody thought of it. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_3",
					quantity = 1,
				},
			},
		},
		{
			id = "BA14",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement passage consumer; verify these proposed terms before enabling.
				{
					destination = "Waystation",
					effect = (
						"Optional Marsh–Waystation shortcut via abandoned boat landing; author distinct "
						.. "safe endpoints and permissions."
					),
					id = "ballast/BA14/future",
					kind = "passage",
					name = "abandoned boat landing",
					origin = "Marsh",
					provider = "ballast",
					status = "unimplemented",
					route = "abandoned boat landing",
				},
			},
			completionCash = 1650,
			name = "The Other Landing",
			kind = "field",
			objective = (
				"Recover the landing freight manifest from the assigned search area in Marsh. Deliver it to "
				.. "'Ledger' in Waystation, then come back to the issuing contact in Marsh."
			),
			requires = {"BA12"},
			briefing = (
				"Ledger needs the landing record. He packs things properly and remembers where he sent them; I try "
				.. "to return the courtesy. Recover the landing freight manifest from the assigned search area in "
				.. "Marsh. Deliver it to 'Ledger' in Waystation, then come back to me in Marsh."
			),
			completion = "Delivered? Good. One fewer parcel balanced between two explanations.",
			field = {
				description = (
					"A printed packing list on a small clipboard with a metal clip and a circular stamp. Ballast's "
					.. "note: \"Ledger needs the landing record.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_manifest",
				label = "Landing freight manifest",
				recipient = "ledger",
			},
		},
		{
			id = "BA15",
			stock = {item = "drink_bottlebeer_4", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on abandoned boat register; author actionable guidance tied "
						.. "to verified mechanics and locations."
					),
					id = "ballast/BA15/future",
					kind = "information",
					name = "Record: abandoned boat register",
					provider = "ballast",
					status = "unimplemented",
					topic = "abandoned boat register",
				},
			},
			completionCash = 0,
			name = "The Long Haul Back",
			kind = "tracker",
			requires = {"BA13"},
			briefing = "There are still recovery orders worth taking. Pick the trip you can prepare for.",
			completion = "You've kept finishing the return walk. I notice that.",
			target = 14,
		},
		{
			id = "BA16",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on shoreline hazard notes; author actionable guidance tied to "
						.. "verified mechanics and locations."
					),
					id = "ballast/BA16/future",
					kind = "information",
					name = "Record: shoreline hazard notes",
					provider = "ballast",
					status = "unimplemented",
					topic = "shoreline hazard notes",
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
			requires = {"BA14"},
			briefing = (
				"I need packing supplies for the loads coming through. It is easier to keep a load dry than "
				.. "explain afterwards why nobody thought of it. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_3",
					quantity = 1,
				},
			},
		},
		{
			id = "BA17",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on disputed freight records; author actionable guidance tied "
						.. "to verified mechanics and locations."
					),
					id = "ballast/BA17/future",
					kind = "information",
					name = "Record: disputed freight records",
					provider = "ballast",
					status = "unimplemented",
					topic = "disputed freight records",
				},
			},
			completionCash = 1475,
			name = "A Boat in Reserve",
			kind = "delivery",
			requires = {"BA15"},
			briefing = (
				"I need packing supplies for the loads coming through. It is easier to keep a load dry than "
				.. "explain afterwards why nobody thought of it. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_3",
					quantity = 1,
				},
			},
		},
		{
			id = "BA18",
			plannedUnlocks = {
				-- TODO: Implement passage consumer; verify these proposed terms before enabling.
				{
					destination = "Waystation",
					effect = (
						"Optional Marsh–Waystation shortcut via Waystation waterside approach; author "
						.. "distinct safe endpoints and permissions."
					),
					id = "ballast/BA18/future",
					kind = "passage",
					name = "Waystation waterside approach",
					origin = "Marsh",
					provider = "ballast",
					status = "unimplemented",
					route = "Waystation waterside approach",
				},
			},
			completionCash = 2050,
			name = "The Last Mooring",
			kind = "field",
			objective = (
				"Recover the crew personal records from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"BA16"},
			briefing = (
				"I want the crew's personal records kept together. Loose pages have a way of acquiring owners who "
				.. "remember only the convenient parts. Recover the crew personal records from the assigned search "
				.. "area in Marsh. Bring it back to me in Marsh."
			),
			completion = "I'll keep the papers dry. We can read them here.",
			field = {
				description = (
					"A cardboard file folder with an emblem and printed wording on the front. Ballast's note: \"I want "
					.. "the crew's personal records kept together.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_personnel",
				label = "Crew personal records",
			},
			benefits = {},
		},
		{
			id = "BA19",
			stock = {item = "drink_canbeer_4", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on Garbage cargo connections; author actionable guidance tied "
						.. "to verified mechanics and locations."
					),
					id = "ballast/BA19/future",
					kind = "information",
					name = "Record: Garbage cargo connections",
					provider = "ballast",
					status = "unimplemented",
					topic = "Garbage cargo connections",
				},
			},
			completionCash = 0,
			name = "Safe to Bring Home",
			kind = "tracker",
			requires = {"BA17", "BA18"},
			briefing = "Keep the recovery work going while I sort the freight records.",
			completion = "I'd trust you to bring a load through. You've given me reason enough.",
			target = 20,
		},
		{
			id = "BA20",
			completionCash = 2250,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"BA19"},
			briefing = (
				"I need packing supplies for the loads coming through. It is easier to keep a load dry than "
				.. "explain afterwards why nobody thought of it. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_4",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BA21",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on Waystation cargo handover; author actionable guidance tied "
						.. "to verified mechanics and locations."
					),
					id = "ballast/BA21/future",
					kind = "information",
					name = "Record: Waystation cargo handover",
					provider = "ballast",
					status = "unimplemented",
					topic = "Waystation cargo handover",
				},
			},
			completionCash = 1775,
			name = "A Working Landing",
			kind = "delivery",
			requires = {"BA20"},
			briefing = (
				"I need packing supplies for the loads coming through. It is easier to keep a load dry than "
				.. "explain afterwards why nobody thought of it. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_4",
					quantity = 1,
				},
			},
		},
		{
			id = "BA22",
			completionCash = 2450,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"BA21"},
			briefing = (
				"I need packing supplies for the loads coming through. It is easier to keep a load dry than "
				.. "explain afterwards why nobody thought of it. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_4",
					quantity = 1,
				},
			},
			benefits = {},
			recognition = "Ballast's trusted contact",
		},
	},
})
