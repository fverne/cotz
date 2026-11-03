PLUGIN:Register("smartass", {
	name = "'Smartass'",
	template = "unisgnpc3",
	map = "rp_waystation",
	job = {
		kind = "dataExtract",
		category = "Computer data extraction",
		description = "Extract data from %d computer types using the issued flash drive.",
		quantities = {1, 2, 5},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Electronics stock (trade goods)",
				items = {"value_capacitors", "value_pcpart_ram", "value_pcpart_cpu"}},
			{label = "Overtime",
				items = {"drug_caffeine", "drink_energydrink_2"}},
			{label = "Extraction provisions",
				items = {"drink_bottlewater", "food_raisins"}},
		},
		bonusItems = {
			"pso1",
			"cmore",
			"acog",
			"shortdot",
			"nightforce",
			"cobrasuppressor",
			"pbssuppressor",
			"sakersuppressor",
			"tundrasuppressor",
		},
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
	catalogue = {
		["acog"] = {step = "SM03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["cmore"] = {step = "SM01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["cobrasuppressor"] = {step = "SM05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["nightforce"] = {step = "SM05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["pbssuppressor"] = {step = "SM05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["pso1"] = {step = "SM01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sakersuppressor"] = {step = "SM05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["shortdot"] = {step = "SM03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["tundrasuppressor"] = {step = "SM05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
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
			id = "SM02",
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
			id = "SM07",
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
			id = "SM13",
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
			benefits = {},
		},
		{
			id = "SM14",
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
			benefits = {},
		},
		{
			id = "SM15",
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
			benefits = {},
		},
		{
			id = "SM16",
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
			benefits = {},
		},
		{
			id = "SM17",
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
			benefits = {},
		},
		{
			id = "SM18",
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
			id = "SM19",
			completionCash = 0,
			name = "No More False Positives",
			kind = "tracker",
			requires = {"SM17"},
			briefing = "There are more computer extraction orders. Bring the issued drive back after meeting the request.",
			completion = "A useful body of work now. We can disagree over evidence instead of enthusiasm.",
			target = 20,
			benefits = {},
		},
		{
			id = "SM20",
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
			benefits = {},
		},
		{
			id = "SM21",
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
			benefits = {},
		},
		{
			id = "SM22",
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
			benefits = {},
		},
		{
			id = "SM23",
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
			benefits = {},
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
			recognition = "Smartass's trusted contact",
		},
	},
})
