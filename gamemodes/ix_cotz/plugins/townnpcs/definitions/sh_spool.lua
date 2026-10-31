PLUGIN:Register("spool", {
	name = "'Spool'",
	template = "spoolnpc",
	map = "rp_waystation",
	job = {
		kind = "triangulation",
		category = "Radio triangulation",
		description = "Radio triangulation",
		pools = {"radio_components", "batteries"},
		quantities = {5, 9, 15},
		maps = {
			easy = "rp_waystation",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	dialogue = {
		completedGreeting = "They left a message. Someone should hear it.",
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Take the bearings, find the source, and bring the transmitter back. I'll listen to the "
			.. "recording here."
		),
		progressionPrompt = "What else needs doing?",
		progression = "I've got missing recordings and equipment to sort. Have a look while I finish listening.",
	},
	progression = {
		{
			id = "SO01",
			name = "Something on the Air",
			kind = "delivery",
			requires = {},
			briefing = (
				"I'm short of what's on this list. Bring it over when you can. Mind the receiver when you "
				.. "put it down."
			),
			completion = "Thanks. I'll put that where I can find it.",
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
			id = "SO02",
			name = "The Local Silence",
			kind = "field",
			objective = (
				"Take the required bearings, locate the source, and recover the transmitter in Waystation. "
				.. "Return to this contact to finish the assignment."
			),
			requires = {"SO01"},
			briefing = "Triangulate and recover a transmitter near Waystation.",
			completion = "Give me a moment. I want to hear this properly.",
			field = {
				kind = "triangulation",
				map = "rp_waystation",
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
			id = "SO03",
			name = "Clear Enough to Hear",
			kind = "tracker",
			requires = {"SO02"},
			briefing = (
				"Take the bearings, find the source, and bring the transmitter back. I'll listen to the "
				.. "recording here."
			),
			completion = "You've brought back a useful set of sources. It's good to have something to listen to.",
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
			id = "SO04",
			name = "The Station Log",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"SO02"},
			briefing = "Recover a failed station's recorder.",
			completion = "You found it. Leave it beside the receiver.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
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
			id = "SO05",
			name = "Ground and Power",
			kind = "delivery",
			requires = {"SO03"},
			briefing = (
				"I'm short of what's on this list. Bring it over when you can. Mind the receiver when you "
				.. "put it down."
			),
			completion = "Good. That's something I was running short of.",
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
			id = "SO06",
			name = "The Crossed Bearings",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"SO04"},
			briefing = "Recover a calibration record disputed by Smartass.",
			completion = "Thanks. I'll check the recording.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
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
			id = "SO07",
			name = "A Voice Worth Finding",
			kind = "tracker",
			requires = {"SO05"},
			briefing = (
				"Take the bearings, find the source, and bring the transmitter back. I'll listen to the "
				.. "recording here."
			),
			completion = "You've brought back a useful set of sources. It's good to have something to listen to.",
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
			id = "SO08",
			name = "The Absent Operator",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"SO06"},
			briefing = "Locate a source and retrieve its recorded message.",
			completion = "Give me a moment. I want to hear this properly.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
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
			id = "SO09",
			name = "A Longer Cable",
			kind = "delivery",
			requires = {"SO07"},
			briefing = (
				"I'm short of what's on this list. Bring it over when you can. Mind the receiver when you "
				.. "put it down."
			),
			completion = "Set it here. Mind the leads.",
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
			id = "SO10",
			name = "Mute's Header",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"SO08"},
			briefing = "Recover a damaged network record in Marsh.",
			completion = "You found it. Leave it beside the receiver.",
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
			id = "SO11",
			name = "Across the Static",
			kind = "tracker",
			requires = {"SO09"},
			briefing = (
				"Take the bearings, find the source, and bring the transmitter back. I'll listen to the "
				.. "recording here."
			),
			completion = "You've brought back a useful set of sources. It's good to have something to listen to.",
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
			id = "SO12",
			name = "The Garbage Relay",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"SO10"},
			briefing = "Locate and retrieve a source near a freight route.",
			completion = "Thanks. I'll check the recording.",
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
			id = "SO13",
			name = "Packed to Listen",
			kind = "delivery",
			requires = {"SO11"},
			briefing = (
				"I'm short of what's on this list. Bring it over when you can. Mind the receiver when you "
				.. "put it down."
			),
			completion = "Thanks. I'll put that where I can find it.",
			requirements = {
				{
					pool = "canned_food",
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
			id = "SO14",
			name = "The Unsent Call",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"SO12"},
			briefing = "Recover an expedition check-in recording in regional ruins.",
			completion = "Give me a moment. I want to hear this properly.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
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
			id = "SO15",
			name = "Still on Frequency",
			kind = "tracker",
			requires = {"SO13"},
			briefing = (
				"Take the bearings, find the source, and bring the transmitter back. I'll listen to the "
				.. "recording here."
			),
			completion = "You've brought back a useful set of sources. It's good to have something to listen to.",
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
			id = "SO16",
			name = "The First Pripyat Call",
			kind = "field",
			objective = (
				"Take the required bearings, locate the source, and recover the transmitter in Pripyat. "
				.. "Return to this contact to finish the assignment."
			),
			requires = {"SO14"},
			briefing = "Triangulate and collect a transmitter in Pripyat.",
			completion = "You found it. Leave it beside the receiver.",
			field = {
				kind = "triangulation",
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
			id = "SO17",
			name = "Enough Power to Return",
			kind = "delivery",
			requires = {"SO15"},
			briefing = (
				"I'm short of what's on this list. Bring it over when you can. Mind the receiver when you "
				.. "put it down."
			),
			completion = "Good. That's something I was running short of.",
			requirements = {
				{
					pool = "small_electronics",
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
			id = "SO18",
			name = "The Last Check-in",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"SO16"},
			briefing = "Recover a second expedition recorder deeper in Pripyat.",
			completion = "Thanks. I'll check the recording.",
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
			id = "SO19",
			name = "Nobody Left Calling",
			kind = "tracker",
			requires = {"SO17", "SO18"},
			briefing = (
				"Take the bearings, find the source, and bring the transmitter back. I'll listen to the "
				.. "recording here."
			),
			completion = "You've brought back a useful set of sources. It's good to have something to listen to.",
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
			id = "SO20",
			name = "The Receiver That Stayed On",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"SO19"},
			briefing = "Locate and retrieve the expedition's final source.",
			completion = "Give me a moment. I want to hear this properly.",
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
			stock = {
				item = "drink_bottlewater",
				bonus = 2,
			},
		},
		{
			id = "SO21",
			name = "Keep the Channel Open",
			kind = "delivery",
			requires = {"SO20"},
			briefing = (
				"I'm short of what's on this list. Bring it over when you can. Mind the receiver when you "
				.. "put it down."
			),
			completion = "Set it here. Mind the leads.",
			requirements = {
				{
					pool = "field_maintenance",
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
			id = "SO22",
			name = "The Message Home",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"SO21"},
			briefing = "Recover the last unsent recording and return it to the station.",
			completion = "You found it. Leave it beside the receiver.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
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
			recognition = "Spool's trusted contact",
		},
	},
})
