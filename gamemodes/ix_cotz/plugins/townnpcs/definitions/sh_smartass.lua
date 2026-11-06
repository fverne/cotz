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
		kind = "dataExtract",
		category = "Computer data extraction",
		description = "Computer data extraction",
	},
	legacyJob = {
		kind = "dataExtract",
		category = "Computer data extraction",
		description = "Extract data from %d computer types using the issued flash drive.",
		quantities = {1, 2, 5},
	},
	supplies = {},
	rewards = {
		packages = {
			{label = "Overtime", items = {"drug_caffeine"}},
			{label = "Energy drinks", items = {"drink_energydrink_2"}},
			{label = "Euro notes", items = {"value_currency_euro"}},
		},
		bonusPackages = {
			{label = "Dollar notes", items = {"value_currency_dollar"}},
		},
		bonusCash = true,
	},
	dialogue = {
		completedGreeting = (
			"You again. At least I can reasonably expect something useful to come of the interruption. "
			.. "What is it?"
		),
		workPrompt = "About the extraction I'm doing.",
		offerPrompt = "Do you have a computer extraction job?",
		work = (
			"Files, if we're fortunate. An explanation for somebody's filing system if we're very fortunate. "
			.. "Take the issued flash drive to the computer types listed on the assignment, let the extractions "
			.. "finish, and bring it back. Another machine of the same type won't replace one you're missing. "
			.. "Leave the contents alone; I'd like the opportunity to be confused by the original."
		),
		progressionPrompt = "What needs checking in the signal records?",
		progression = (
			"The separate signal investigation needs hardware and surviving records. Some commissions mean "
			.. "taking bearings, others mean recovering a file or carrying it to somebody who can compare it. Read "
			.. "the particular order before leaving. Your computer extraction work is still available separately. "
			.. "I promise to complain about the data whichever way it gets here."
		),
	},
	-- Author-disabled suggestions must not be restored by catalogue or stock generation.
	disabledItems = {
		["dataextractor"] = true,
		["quest_computeraccess"] = true,
	},
	catalogue = {
		-- ["quest_computeraccess"] = {step = "SM20",
		-- 	terms = {nil, 5, "SELLANDBUY", 5, 1, 5}},
		-- ["dataextractor"] = {step = "SM01",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drug_adrenaline"] = {step = "SM13",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drug_glucose"] = {step = "SM24",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["food_mre_russia"] = {step = "SM07",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["food_mre_ukraine"] = {step = "SM01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["food_mre_usa"] = {step = "SM18",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["medic_antipsychotic_1"] = {step = "SM01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["medic_antipsychotic_2"] = {step = "SM24",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["medic_antirad_2"] = {step = "SM01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["medic_bandage_2"] = {step = "SM01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["medic_medkit_3"] = {step = "SM01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["medic_medkit_4"] = {step = "SM24",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["medic_psyheal_1"] = {step = "SM01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
	},
	progression = {
		{
			id = "SM01",
			completionCash = 275,
			name = "Something to Listen With",
			kind = "delivery",
			requires = {},
			briefing = (
				"I need parts. The list should spare us the performance where you bring something vaguely "
				.. "technical and I explain why it is useless. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "SM02",
			stock = {item = "medic_bandage_2", bonus = 1},
			completionCash = 450,
			name = "The Lost Beacon",
			kind = "field",
			objective = (
				"Take the required bearings in Garbage, locate the source, and collect the beacon controller. "
				.. "Bring it back to the issuing contact in Waystation."
			),
			requires = {"SM01"},
			briefing = (
				"There's a beacon source to locate. I'd like the hardware before hearing another theory about who "
				.. "must have switched it on. Take the required bearings in Garbage, locate the source, and collect "
				.. "the beacon controller. Bring it back to me in Waystation."
			),
			completion = "Here we are. Actual equipment. My favourite improvement to a technical discussion.",
			field = {
				description = (
					"A finned grey control box with a red stripe and several round front connectors. Smartass's note: "
					.. "\"There's a beacon source to locate.\""
				),
				kind = "triangulation",
				map = "rp_garbage_cotz",
				tier = 1,
				cargo = "town_quest_control",
				label = "beacon controller",
			},
			benefits = {},
		},
		{
			id = "SM03",
			stock = {item = "medic_antipsychotic_1", bonus = 1},
			completionCash = 0,
			name = "Three Bearings",
			kind = "tracker",
			requires = {"SM02"},
			briefing = (
				"Continue the computer extractions. Use the issued drive at the required distinct computer types "
				.. "and return it."
			),
			completion = "A few completed extractions. There is actual data to complain about now.",
			target = 2,
			benefits = {},
		},
		{
			id = "SM04",
			completionCash = 650,
			name = "A small delivery",
			kind = "delivery",
			retiredCommission = true,
			objective = "Bring all 1 listed item type to this contact. The request shows each selected item and required units.",
			requires = {"SM02"},
			briefing = (
				"I need parts. The list should spare us the performance where you bring something vaguely "
				.. "technical and I explain why it is useless. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "These I can use. Give me a moment to get them away from the pile that only looks useful.",
			requirements = {
				{
					pool = "town_delivery_electronics_waystation_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "SM05",
			stock = {item = "food_mre_ukraine", bonus = 1},
			completionCash = 575,
			name = "Mounts and Glass",
			kind = "delivery",
			requires = {"SM03"},
			briefing = (
				"I need parts. The list should spare us the performance where you bring something vaguely "
				.. "technical and I explain why it is useless. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
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
			benefits = {},
		},
		{
			id = "SM06",
			stock = {item = "medic_psyheal_1", bonus = 1},
			completionCash = 850,
			name = "The Interference Site",
			kind = "field",
			objective = (
				"Take the required bearings in Garbage, locate the source, and collect the interference source "
				.. "record. Bring it back to the issuing contact in Waystation."
			),
			requires = {"SM04"},
			briefing = (
				"I want the source behind that interference. Take the bearings properly; irritation isn't a "
				.. "direction. Take the required bearings in Garbage, locate the source, and collect the interference "
				.. "source record. Bring it back to me in Waystation."
			),
			completion = "Set it down. I'll see what it actually does before enjoying my explanation.",
			field = {
				description = (
					"A finned grey control box with a red stripe and several round front connectors. Smartass's note: "
					.. "\"I want the source behind that interference.\""
				),
				kind = "triangulation",
				map = "rp_garbage_cotz",
				tier = 1,
				cargo = "town_quest_control",
				label = "Interference source record",
			},
			benefits = {},
		},
		{
			id = "SM07",
			stock = {item = "food_mre_russia", bonus = 1},
			completionCash = 0,
			name = "Less Guesswork",
			kind = "tracker",
			requires = {"SM05"},
			briefing = "More extraction assignments when you're ready. Check the required computer types before leaving.",
			completion = (
				"You've kept to the extraction requests. That makes sorting the returns considerably less "
				.. "entertaining."
			),
			target = 5,
			benefits = {},
		},
		{
			id = "SM08",
			completionCash = 1050,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"SM06"},
			briefing = (
				"I need parts. The list should spare us the performance where you bring something vaguely "
				.. "technical and I explain why it is useless. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
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
			benefits = {},
		},
		{
			id = "SM09",
			stock = {item = "medic_medkit_3", bonus = 1},
			completionCash = 875,
			name = "An Honest Test",
			kind = "delivery",
			requires = {"SM07"},
			briefing = (
				"I need parts. The list should spare us the performance where you bring something vaguely "
				.. "technical and I explain why it is useless. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
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
			benefits = {},
		},
		{
			id = "SM10",
			completionCash = 1250,
			name = "The False Beacon",
			kind = "field",
			objective = (
				"Take the required bearings in Garbage, locate the source, and collect the misleading beacon "
				.. "source. Bring it back to the issuing contact in Waystation."
			),
			requires = {"SM08"},
			briefing = (
				"There's another source to locate. Follow the measured bearings rather than the explanation that "
				.. "makes the journey shortest. Take the required bearings in Garbage, locate the source, and collect "
				.. "the misleading beacon source. Bring it back to me in Waystation."
			),
			completion = "You found the source. Now we can decide which part of the behaviour deserves suspicion.",
			field = {
				description = (
					"A finned grey control box with a red stripe and several round front connectors. Smartass's note: "
					.. "\"There's another source to locate.\""
				),
				kind = "triangulation",
				map = "rp_garbage_cotz",
				tier = 2,
				cargo = "town_quest_control",
				label = "Misleading beacon source",
			},
			benefits = {},
		},
		{
			id = "SM11",
			stock = {item = "medic_antirad_2", bonus = 1},
			completionCash = 0,
			name = "Still on Bearing",
			kind = "tracker",
			requires = {"SM09"},
			briefing = "Keep the computer extraction work going. Repeating a computer type won't replace a missing one.",
			completion = "Another solid run of returns. I might have to become accustomed to it.",
			target = 9,
			benefits = {},
		},
		{
			id = "SM12",
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on computer type identification; author actionable guidance "
						.. "tied to verified mechanics and locations."
					),
					id = "smartass/SM12/future",
					kind = "information",
					name = "Record: computer type identification",
					provider = "smartass",
					status = "unimplemented",
					topic = "computer type identification",
				},
			},
			completionCash = 1450,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"SM10"},
			briefing = (
				"I need parts. The list should spare us the performance where you bring something vaguely "
				.. "technical and I explain why it is useless. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
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
			benefits = {},
		},
		{
			id = "SM13",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on flash drive provenance; author actionable guidance tied to "
						.. "verified mechanics and locations."
					),
					id = "smartass/SM13/future",
					kind = "information",
					name = "Record: flash drive provenance",
					provider = "smartass",
					status = "unimplemented",
					topic = "flash drive provenance",
				},
			},
			completionCash = 1175,
			name = "Quiet Equipment",
			kind = "delivery",
			requires = {"SM11"},
			briefing = (
				"I need parts. The list should spare us the performance where you bring something vaguely "
				.. "technical and I explain why it is useless. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
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
		},
		{
			id = "SM14",
			stock = {item = "drug_adrenaline", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on data integrity checks; author actionable guidance tied to "
						.. "verified mechanics and locations."
					),
					id = "smartass/SM14/future",
					kind = "information",
					name = "Record: data integrity checks",
					provider = "smartass",
					status = "unimplemented",
					topic = "data integrity checks",
				},
			},
			completionCash = 1650,
			name = "Mute's Missing Packet",
			kind = "field",
			objective = (
				"Recover the relay diagnostic recording from the assigned search area in Garbage. Bring it back to "
				.. "the issuing contact in Waystation."
			),
			requires = {"SM12"},
			briefing = (
				"Recover the diagnostic recording. Mute's equipment doesn't become easier to understand because "
				.. "somebody has already decided it's mysterious. Recover the relay diagnostic recording from the "
				.. "assigned search area in Garbage. Bring it back to me in Waystation."
			),
			completion = "Leave it here. I'll listen before supplying the commentary it apparently lacked.",
			field = {
				description = (
					"A dark USB drive with a pale handwritten tape label around its body. Smartass's note: \"Recover "
					.. "the diagnostic recording.\""
				),
				kind = "recovery",
				map = "rp_garbage_cotz",
				tier = 2,
				cargo = "town_quest_drive",
				label = "Relay diagnostic recording",
			},
		},
		{
			id = "SM15",
			stock = {item = "medic_bandage_2", bonus = 2},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on terminal power failures; author actionable guidance tied "
						.. "to verified mechanics and locations."
					),
					id = "smartass/SM15/future",
					kind = "information",
					name = "Record: terminal power failures",
					provider = "smartass",
					status = "unimplemented",
					topic = "terminal power failures",
				},
			},
			completionCash = 0,
			name = "Better Than Luck",
			kind = "tracker",
			requires = {"SM13"},
			briefing = "Continue the extraction assignments while I examine the source records.",
			completion = (
				"You've kept bringing something I can inspect. I appreciate the restraint involved in leaving it "
				.. "alone."
			),
			target = 14,
		},
		{
			id = "SM16",
			stock = {item = "medic_antipsychotic_1", bonus = 2},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on archive access protocol; author actionable guidance tied "
						.. "to verified mechanics and locations."
					),
					id = "smartass/SM16/future",
					kind = "information",
					name = "Record: archive access protocol",
					provider = "smartass",
					status = "unimplemented",
					topic = "archive access protocol",
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
			requires = {"SM14"},
			briefing = (
				"I need parts. The list should spare us the performance where you bring something vaguely "
				.. "technical and I explain why it is useless. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
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
		},
		{
			id = "SM17",
			stock = {item = "food_mre_ukraine", bonus = 2},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on cross-system file comparison; author actionable guidance "
						.. "tied to verified mechanics and locations."
					),
					id = "smartass/SM17/future",
					kind = "information",
					name = "Record: cross-system file comparison",
					provider = "smartass",
					status = "unimplemented",
					topic = "cross-system file comparison",
				},
			},
			completionCash = 1475,
			name = "Packed for the Roofs",
			kind = "delivery",
			requires = {"SM15"},
			briefing = (
				"I need parts. The list should spare us the performance where you bring something vaguely "
				.. "technical and I explain why it is useless. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
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
		},
		{
			id = "SM18",
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on damaged media handling; author actionable guidance tied to "
						.. "verified mechanics and locations."
					),
					id = "smartass/SM18/future",
					kind = "information",
					name = "Record: damaged media handling",
					provider = "smartass",
					status = "unimplemented",
					topic = "damaged media handling",
				},
			},
			completionCash = 2050,
			name = "The Rooftop Source",
			kind = "field",
			objective = (
				"Recover the Pripyat signal transmitter from the assigned search area in Pripyat. Bring it back to "
				.. "the issuing contact in Waystation."
			),
			requires = {"SM16"},
			briefing = (
				"There's a source in Pripyat to locate. The assignment doesn't require you to invent a rooftop "
				.. "route because somebody liked the title. Recover the Pripyat signal transmitter from the assigned "
				.. "search area in Pripyat. Bring it back to me in Waystation."
			),
			completion = (
				"Back with the source. Excellent. I'll keep my magnificent theory to myself until I've looked at "
				.. "it."
			),
			field = {
				description = (
					"A finned grey control box with a red stripe and several round front connectors. Smartass's note: "
					.. "\"There's a source in Pripyat to locate.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_control",
				label = "Pripyat signal transmitter",
			},
			benefits = {},
		},
		{
			id = "SM19",
			stock = {item = "food_mre_usa", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on field extraction precautions; author actionable guidance "
						.. "tied to verified mechanics and locations."
					),
					id = "smartass/SM19/future",
					kind = "information",
					name = "Record: field extraction precautions",
					provider = "smartass",
					status = "unimplemented",
					topic = "field extraction precautions",
				},
			},
			completionCash = 0,
			name = "No More False Positives",
			kind = "tracker",
			requires = {"SM17"},
			briefing = "There are more computer extraction orders. Bring the issued drive back after meeting the request.",
			completion = "A useful body of work now. We can disagree over evidence instead of enthusiasm.",
			target = 20,
		},
		{
			id = "SM20",
			stock = {item = "medic_psyheal_1", bonus = 2},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on research workstation records; author actionable guidance "
						.. "tied to verified mechanics and locations."
					),
					id = "smartass/SM20/future",
					kind = "information",
					name = "Record: research workstation records",
					provider = "smartass",
					status = "unimplemented",
					topic = "research workstation records",
				},
			},
			completionCash = 2250,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"SM18"},
			briefing = (
				"I need parts. The list should spare us the performance where you bring something vaguely "
				.. "technical and I explain why it is useless. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
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
		},
		{
			id = "SM21",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on log timestamp comparison; author actionable guidance tied "
						.. "to verified mechanics and locations."
					),
					id = "smartass/SM21/future",
					kind = "information",
					name = "Record: log timestamp comparison",
					provider = "smartass",
					status = "unimplemented",
					topic = "log timestamp comparison",
				},
			},
			completionCash = 1775,
			name = "The Last Calibration",
			kind = "delivery",
			requires = {"SM19", "SM20"},
			briefing = (
				"I need parts. The list should spare us the performance where you bring something vaguely "
				.. "technical and I explain why it is useless. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
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
		},
		{
			id = "SM22",
			stock = {item = "food_mre_russia", bonus = 2},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on Pripyat terminal reports; author actionable guidance tied "
						.. "to verified mechanics and locations."
					),
					id = "smartass/SM22/future",
					kind = "information",
					name = "Record: Pripyat terminal reports",
					provider = "smartass",
					status = "unimplemented",
					topic = "Pripyat terminal reports",
				},
			},
			completionCash = 2450,
			name = "Two Signals One Source",
			kind = "field",
			objective = (
				"Recover the second Pripyat signal source from the assigned search area in Pripyat. Bring it back "
				.. "to the issuing contact in Waystation."
			),
			requires = {"SM21"},
			briefing = (
				"Locate the next source and bring it home. Similar behaviour doesn't mean we get to skip the "
				.. "second inspection. Recover the second Pripyat signal source from the assigned search area in "
				.. "Pripyat. Bring it back to me in Waystation."
			),
			completion = "There. Now I can compare actual sources instead of drawing increasingly smug arrows.",
			field = {
				description = (
					"A finned grey control box with a red stripe and several round front connectors. Smartass's note: "
					.. "\"Locate the next source and bring it home.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_control",
				label = "Second Pripyat signal source",
			},
		},
		{
			id = "SM23",
			stock = {item = "medic_medkit_3", bonus = 2},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on forged file identification; author actionable guidance "
						.. "tied to verified mechanics and locations."
					),
					id = "smartass/SM23/future",
					kind = "information",
					name = "Record: forged file identification",
					provider = "smartass",
					status = "unimplemented",
					topic = "forged file identification",
				},
			},
			completionCash = 0,
			name = "Found You",
			kind = "tracker",
			requires = {"SM22"},
			briefing = "Keep completing the computer extractions when you're prepared.",
			completion = (
				"You've been dependable long enough that I'm running out of amusing qualifications. Thank you. "
				.. "That one can stand."
			),
			target = 27,
		},
		{
			id = "SM24",
			completionCash = 2650,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"SM23"},
			briefing = (
				"I need parts. The list should spare us the performance where you bring something vaguely "
				.. "technical and I explain why it is useless. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
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
			benefits = {},
			recognition = "Smartass's trusted contact",
		},
	},
})
