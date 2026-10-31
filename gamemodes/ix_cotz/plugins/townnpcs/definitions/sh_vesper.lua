PLUGIN:Register("vesper", {
	name = "'Vesper'",
	template = "vespernpc",
	map = "mz_garbage",
	job = {
		kind = "sensor",
		category = "Sensor deployment and retrieval",
		description = "Sensor deployment and retrieval",
		pools = {"field_maintenance", "documents_research"},
		quantities = {5, 9, 15},
		maps = {
			easy = "mz_garbage",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	dialogue = {
		completedGreeting = "We brought the results home. That's what makes it a successful expedition.",
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Deploy the sensor, let it finish, then collect it. Stay within range and keep yourself fit to "
			.. "carry it home."
		),
		progressionPrompt = "What else needs doing?",
		progression = "There are supplies to sort and field readings to check. Pick a trip you can prepare for.",
	},
	progression = {
		{
			id = "VE01",
			name = "Before the Field",
			kind = "delivery",
			requires = {},
			briefing = (
				"Bring what's on the list. Check your own kit before giving away the supplies you need to "
				.. "get home."
			),
			completion = "Good. Check your own supplies before you leave.",
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
			id = "VE02",
			name = "The Quiet Edge",
			kind = "field",
			objective = (
				"Deploy the recorder at the marked site, remain in range until it finishes, and collect it "
				.. "in Garbage. Return to this contact to finish the assignment."
			),
			requires = {"VE01"},
			briefing = "Deploy and retrieve a sensor at a Garbage anomaly approach.",
			completion = "You're back. Let me check the recorder.",
			field = {
				kind = "sensor",
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
			id = "VE03",
			name = "Readings Worth Keeping",
			kind = "tracker",
			requires = {"VE02"},
			briefing = (
				"Deploy the sensor, let it finish, then collect it. Stay within range and keep yourself fit "
				.. "to carry it home."
			),
			completion = "You've brought back usable readings. Keep allowing enough supplies for the return trip.",
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
			id = "VE04",
			name = "Beanstalk's Baseline",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"VE02"},
			briefing = "Recover a control recorder away from the field.",
			completion = "Good. We'll look at the reading here.",
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
			id = "VE05",
			name = "Reliable Instruments",
			kind = "delivery",
			requires = {"VE03"},
			briefing = (
				"Bring what's on the list. Check your own kit before giving away the supplies you need to "
				.. "get home."
			),
			completion = "Put it down here. I'll pack it later.",
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
			id = "VE06",
			name = "The Second Field",
			kind = "field",
			objective = (
				"Deploy the recorder at the marked site, remain in range until it finishes, and collect it "
				.. "in Garbage. Return to this contact to finish the assignment."
			),
			requires = {"VE04"},
			briefing = "Record conditions at a different Garbage field.",
			completion = "Leave it with me. Have some water.",
			field = {
				kind = "sensor",
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
			id = "VE07",
			name = "Same Method Twice",
			kind = "tracker",
			requires = {"VE05"},
			briefing = (
				"Deploy the sensor, let it finish, then collect it. Stay within range and keep yourself fit "
				.. "to carry it home."
			),
			completion = "You've brought back usable readings. Keep allowing enough supplies for the return trip.",
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
			id = "VE08",
			name = "The Abandoned Detector",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"VE06"},
			briefing = "Recover a prospector's field case.",
			completion = "You're back. Let me check the recorder.",
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
			id = "VE09",
			name = "Keep It Sealed",
			kind = "delivery",
			requires = {"VE07"},
			briefing = (
				"Bring what's on the list. Check your own kit before giving away the supplies you need to "
				.. "get home."
			),
			completion = "That covers what I needed.",
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
			id = "VE10",
			name = "The Unstable Reading",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"VE08"},
			briefing = "Retrieve a recorder from a disputed field site.",
			completion = "Good. We'll look at the reading here.",
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
			id = "VE11",
			name = "Outside Familiar Ground",
			kind = "tracker",
			requires = {"VE09"},
			briefing = (
				"Deploy the sensor, let it finish, then collect it. Stay within range and keep yourself fit "
				.. "to carry it home."
			),
			completion = "You've brought back usable readings. Keep allowing enough supplies for the return trip.",
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
			id = "VE12",
			name = "The Control Run",
			kind = "field",
			objective = (
				"Deploy the recorder at the marked site, remain in range until it finishes, and collect it "
				.. "in Garbage. Return to this contact to finish the assignment."
			),
			requires = {"VE10"},
			briefing = "Record at a regional control site.",
			completion = "Leave it with me. Have some water.",
			field = {
				kind = "sensor",
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
			id = "VE13",
			name = "Supplies for Distance",
			kind = "delivery",
			requires = {"VE11"},
			briefing = (
				"Bring what's on the list. Check your own kit before giving away the supplies you need to "
				.. "get home."
			),
			completion = "Good. Check your own supplies before you leave.",
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
			id = "VE14",
			name = "The Lost Team's Notes",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"VE12"},
			briefing = "Recover a prospecting log in Waystation territory.",
			completion = "You're back. Let me check the recorder.",
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
			id = "VE15",
			name = "Know When to Leave",
			kind = "tracker",
			requires = {"VE13"},
			briefing = (
				"Deploy the sensor, let it finish, then collect it. Stay within range and keep yourself fit "
				.. "to carry it home."
			),
			completion = "You've brought back usable readings. Keep allowing enough supplies for the return trip.",
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
			id = "VE16",
			name = "The First Pripyat Field",
			kind = "field",
			objective = (
				"Deploy the recorder at the marked site, remain in range until it finishes, and collect it "
				.. "in Pripyat. Return to this contact to finish the assignment."
			),
			requires = {"VE14"},
			briefing = "Deploy and retrieve a recorder at a Pripyat field.",
			completion = "Good. We'll look at the reading here.",
			field = {
				kind = "sensor",
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
			id = "VE17",
			name = "No Borrowed Luck",
			kind = "delivery",
			requires = {"VE15"},
			briefing = (
				"Bring what's on the list. Check your own kit before giving away the supplies you need to "
				.. "get home."
			),
			completion = "Put it down here. I'll pack it later.",
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
			id = "VE18",
			name = "The Team's Cache",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"VE16"},
			briefing = "Recover a lost prospecting team's equipment case.",
			completion = "Leave it with me. Have some water.",
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
			id = "VE19",
			name = "A Measured Risk",
			kind = "tracker",
			requires = {"VE17"},
			briefing = (
				"Deploy the sensor, let it finish, then collect it. Stay within range and keep yourself fit "
				.. "to carry it home."
			),
			completion = "You've brought back usable readings. Keep allowing enough supplies for the return trip.",
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
			id = "VE20",
			name = "The Field They Chose",
			kind = "field",
			objective = (
				"Deploy the recorder at the marked site, remain in range until it finishes, and collect it "
				.. "in Garbage. Return to this contact to finish the assignment."
			),
			requires = {"VE18"},
			briefing = "Record the team's last known anomaly site.",
			completion = "You're back. Let me check the recorder.",
			field = {
				kind = "sensor",
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
			id = "VE21",
			name = "Enough to Compare",
			kind = "delivery",
			requires = {"VE19", "VE20"},
			briefing = (
				"Bring what's on the list. Check your own kit before giving away the supplies you need to "
				.. "get home."
			),
			completion = "That covers what I needed.",
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
			id = "VE22",
			name = "A Different Explanation",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"VE21"},
			briefing = "Recover a missing control recorder in Pripyat.",
			completion = "Good. We'll look at the reading here.",
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
			id = "VE23",
			name = "Everyone Comes Back",
			kind = "tracker",
			requires = {"VE22"},
			briefing = (
				"Deploy the sensor, let it finish, then collect it. Stay within range and keep yourself fit "
				.. "to carry it home."
			),
			completion = "You've brought back usable readings. Keep allowing enough supplies for the return trip.",
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
			id = "VE24",
			name = "The Last Recorder",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"VE23"},
			briefing = "Retrieve the expedition's final recorder and return its account.",
			completion = "Leave it with me. Have some water.",
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
			recognition = "Vesper's trusted contact",
		},
	},
})
