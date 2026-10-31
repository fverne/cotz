PLUGIN:Register("smartass", {
	name = "'Smartass'",
	template = "unisgnpc3",
	map = "mz_garbage",
	job = {
		kind = "triangulation",
		category = "Radio triangulation",
		description = "Radio triangulation",
		pools = {"radio_components", "small_electronics"},
		quantities = {5, 9, 15},
		maps = {
			easy = "mz_garbage",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	dialogue = {
		completedGreeting = "There. Silence. Almost makes you miss the interference.",
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Take the bearings, find the transmitter, bring it back. Pointing in a promising direction "
			.. "isn't a bearing."
		),
		progressionPrompt = "What else needs doing?",
		progression = "Signals, missing records, a few things that don't agree. Plenty to keep us amused.",
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
			name = "Something to Listen With",
			kind = "delivery",
			requires = {},
			briefing = "Bring the supplies on the list. The list is the useful bit; the excuse can stay with you.",
			completion = "Yes, that will do. Try not to look so surprised.",
			requirements = {
				{
					pool = "small_electronics",
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
			id = "SM02",
			name = "The Lost Beacon",
			kind = "field",
			objective = (
				"Take the required bearings, locate the source, and recover the transmitter in Garbage. "
				.. "Return to this contact to finish the assignment."
			),
			requires = {"SM01"},
			briefing = "Triangulate and recover a source in Garbage.",
			completion = "Let's hear what all the fuss was about.",
			field = {
				kind = "triangulation",
				map = "mz_garbage",
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
			id = "SM03",
			name = "Three Bearings",
			kind = "tracker",
			requires = {"SM02"},
			briefing = (
				"Take the bearings, find the transmitter, bring it back. Pointing in a promising direction "
				.. "isn't a bearing."
			),
			completion = "You've found enough sources that I'm starting to believe the bearings aren't luck.",
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
			id = "SM04",
			name = "The Wrong Frequency",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"SM02"},
			briefing = "Recover a beacon calibration record.",
			completion = "Hand it over. I'll see whether it agrees with the last one.",
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
			id = "SM05",
			name = "Mounts and Glass",
			kind = "delivery",
			requires = {"SM03"},
			briefing = "Bring the supplies on the list. The list is the useful bit; the excuse can stay with you.",
			completion = "Put it there. I'll check it.",
			requirements = {
				{
					pool = "small_electronics",
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
			id = "SM06",
			name = "The Interference Site",
			kind = "field",
			objective = (
				"Take the required bearings, locate the source, and recover the transmitter in Garbage. "
				.. "Return to this contact to finish the assignment."
			),
			requires = {"SM04"},
			briefing = "Take bearings and recover a jammer's field record.",
			completion = "Good. Something I can actually check.",
			field = {
				kind = "triangulation",
				map = "mz_garbage",
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
			id = "SM07",
			name = "Less Guesswork",
			kind = "tracker",
			requires = {"SM05"},
			briefing = (
				"Take the bearings, find the transmitter, bring it back. Pointing in a promising direction "
				.. "isn't a bearing."
			),
			completion = "You've found enough sources that I'm starting to believe the bearings aren't luck.",
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
			id = "SM08",
			name = "Spool's Correction",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"SM06"},
			briefing = "Recover a disputed signal recorder along a freight route.",
			completion = "Let's hear what all the fuss was about.",
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
			id = "SM09",
			name = "An Honest Test",
			kind = "delivery",
			requires = {"SM07"},
			briefing = "Bring the supplies on the list. The list is the useful bit; the excuse can stay with you.",
			completion = "Good. The parts, rather than an explanation of why you forgot them.",
			requirements = {
				{
					pool = "small_electronics",
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
			id = "SM10",
			name = "The False Beacon",
			kind = "field",
			objective = (
				"Take the required bearings, locate the source, and recover the transmitter in Garbage. "
				.. "Return to this contact to finish the assignment."
			),
			requires = {"SM08"},
			briefing = "Triangulate and recover a deliberately misleading source.",
			completion = "Hand it over. I'll see whether it agrees with the last one.",
			field = {
				kind = "triangulation",
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
			id = "SM11",
			name = "Still on Bearing",
			kind = "tracker",
			requires = {"SM09"},
			briefing = (
				"Take the bearings, find the transmitter, bring it back. Pointing in a promising direction "
				.. "isn't a bearing."
			),
			completion = "You've found enough sources that I'm starting to believe the bearings aren't luck.",
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
			id = "SM12",
			name = "The Receiver List",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"SM10"},
			briefing = "Recover a receiver register in Waystation territory.",
			completion = "Good. Something I can actually check.",
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
			id = "SM13",
			name = "Quiet Equipment",
			kind = "delivery",
			requires = {"SM11"},
			briefing = "Bring the supplies on the list. The list is the useful bit; the excuse can stay with you.",
			completion = "Yes, that will do. Try not to look so surprised.",
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
			id = "SM14",
			name = "Mute's Missing Packet",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"SM12"},
			briefing = "Recover a diagnostic recording at a remote relay.",
			completion = "Let's hear what all the fuss was about.",
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
			id = "SM15",
			name = "Better Than Luck",
			kind = "tracker",
			requires = {"SM13"},
			briefing = (
				"Take the bearings, find the transmitter, bring it back. Pointing in a promising direction "
				.. "isn't a bearing."
			),
			completion = "You've found enough sources that I'm starting to believe the bearings aren't luck.",
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
			id = "SM16",
			name = "A Signal Across Maps",
			kind = "field",
			objective = (
				"Take the required bearings, locate the source, and recover the transmitter in Garbage. "
				.. "Return to this contact to finish the assignment."
			),
			requires = {"SM14"},
			briefing = "Take bearings at a regional transmitter site.",
			completion = "Hand it over. I'll see whether it agrees with the last one.",
			field = {
				kind = "triangulation",
				map = "mz_garbage",
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
			id = "SM17",
			name = "Packed for the Roofs",
			kind = "delivery",
			requires = {"SM15"},
			briefing = "Bring the supplies on the list. The list is the useful bit; the excuse can stay with you.",
			completion = "Put it there. I'll check it.",
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
			id = "SM18",
			name = "The Rooftop Source",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"SM16"},
			briefing = "Locate and recover a transmitter at a Pripyat signal site.",
			completion = "Good. Something I can actually check.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
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
			name = "No More False Positives",
			kind = "tracker",
			requires = {"SM17"},
			briefing = (
				"Take the bearings, find the transmitter, bring it back. Pointing in a promising direction "
				.. "isn't a bearing."
			),
			completion = "You've found enough sources that I'm starting to believe the bearings aren't luck.",
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
			id = "SM20",
			name = "The Handler's Record",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"SM18"},
			briefing = "Recover the operation's command recording in Pripyat.",
			completion = "Let's hear what all the fuss was about.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
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
			id = "SM21",
			name = "The Last Calibration",
			kind = "delivery",
			requires = {"SM19", "SM20"},
			briefing = "Bring the supplies on the list. The list is the useful bit; the excuse can stay with you.",
			completion = "Good. The parts, rather than an explanation of why you forgot them.",
			requirements = {
				{
					pool = "small_electronics",
					quantity = 6,
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
			id = "SM22",
			name = "Two Signals One Source",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"SM21"},
			briefing = "Locate and recover a transmitter in Pripyat.",
			completion = "Hand it over. I'll see whether it agrees with the last one.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
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
				bonus = 2,
			},
		},
		{
			id = "SM23",
			name = "Found You",
			kind = "tracker",
			requires = {"SM22"},
			briefing = (
				"Take the bearings, find the transmitter, bring it back. Pointing in a promising direction "
				.. "isn't a bearing."
			),
			completion = "You've found enough sources that I'm starting to believe the bearings aren't luck.",
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
			id = "SM24",
			name = "The Silent Frequency",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"SM23"},
			briefing = "Recover the operation's last transmitter and return its records.",
			completion = "Good. Something I can actually check.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
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
			recognition = "Smartass's trusted contact",
		},
	},
})
