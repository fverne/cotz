PLUGIN:Register("vesper", {
	name = "'Vesper'",
	template = "vespernpc",
	map = "mz_garbage",
	job = {
		kind = "sensor",
		category = "Sensor deployment and retrieval",
		description = "Sensor deployment and retrieval",
		maps = {
			easy = "mz_garbage",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Radiation supplies",
				items = {"medic_antirad_1", "medic_antirad_2"}},
			{label = "Emergency extraction",
				items = {"medic_bandage_1", "medic_medkit_1"}},
			{label = "Prospecting provisions",
				items = {"drink_bottlewater", "food_raisins"}},
		},
	},
	dialogue = {
		delivery = "Put it where I can check the label. Tell me if it was damaged on the way.",
		completedGreeting = (
			"Good to see you on this side of the trip. We can talk for a moment before either of us "
			.. "starts planning another."
		),
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Deploy the sensor, let it finish, then collect it. Stay within range and keep yourself fit to "
			.. "carry it home. Decide when you'll turn back before you set out. Don't keep changing that decision "
			.. "just because the recorder isn't quite finished."
		),
		progressionPrompt = "What else needs doing?",
		progression = (
			"There are supplies to sort and field readings to check. Pick a trip you can prepare for. The "
			.. "equipment and the field accounts both need attention. Bring back what the order asks for; we can "
			.. "argue about the interpretation somewhere we can hear ourselves think."
		),
	},
	catalogue = {
		["mask_m40"] = {step = "VE19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mask_m50"] = {step = "VE21",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mask_xm40"] = {step = "VE15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_wind"] = {step = "VE11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "VE01",
			completionCash = 275,
			name = "Before the Field",
			kind = "delivery",
			requires = {},
			briefing = (
				"Bring what's on the list. Check your own kit before giving away the supplies you need "
				.. "to get home. I'm asking for supplies, not for you to strip your own pack bare. Read the "
				.. "list and leave yourself ready for the journey."
			),
			completion = (
				"Good. Check your own supplies before you leave. Useful. Now make sure you haven't left "
				.. "yourself short. Preparation applies to the person making the delivery too."
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
			id = "VE02",
			completionCash = 450,
			name = "The Quiet Edge",
			kind = "field",
			objective = "Deploy the recorder in Garbage, leave it to record, then retrieve Numbered Data Module 0013."
				.. " Return it to this contact to finish the assignment.",
			requires = {"VE01"},
			briefing = "Deploy and retrieve a sensor at a Garbage anomaly approach.",
			completion = "You're back. Let me check the recorder.",
			field = {
				kind = "sensor",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_module",
				label = "The Quiet Edge - Numbered Data Module 0013",
			},
			benefits = {},
		},
		{
			id = "VE03",
			completionCash = 0,
			name = "Readings Worth Keeping",
			kind = "tracker",
			requires = {"VE02"},
			briefing = (
				"Deploy the sensor, let it finish, then collect it. Stay within range and keep yourself fit "
				.. "to carry it home."
			),
			completion = "You've brought back usable readings. Keep allowing enough supplies for the return trip.",
			target = 2,
			benefits = {},
		},
		{
			id = "VE04",
			completionCash = 650,
			name = "Beanstalk's Baseline",
			kind = "field",
			objective = "Recover Numbered Data Module 0022 from the assigned search area in Garbage. Deliver it to"
				.. " 'Spool' in Garbage, then return here to finish the assignment.",
			requires = {"VE02"},
			briefing = "Recover a control recorder away from the field.",
			completion = "Delivered, and you made it back. That is the useful part. I will mark it done.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_module2",
				label = "Beanstalk's Baseline - Numbered Data Module 0022",
				recipient = "spool",
			},
			benefits = {},
		},
		{
			id = "VE05",
			completionCash = 575,
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
			benefits = {},
		},
		{
			id = "VE06",
			completionCash = 850,
			name = "The Second Field",
			kind = "field",
			objective = "Deploy the recorder in Garbage, leave it to record, then retrieve Numbered Data Module 0013."
				.. " Return it to this contact to finish the assignment.",
			requires = {"VE04"},
			briefing = "Record conditions at a different Garbage field.",
			completion = "Leave it with me. Have some water.",
			field = {
				kind = "sensor",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_module",
				label = "The Second Field - Numbered Data Module 0013",
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
			completionCash = 0,
			name = "Same Method Twice",
			kind = "tracker",
			requires = {"VE05"},
			briefing = (
				"Deploy the sensor, let it finish, then collect it. Stay within range and keep yourself fit "
				.. "to carry it home."
			),
			completion = "You've brought back usable readings. Keep allowing enough supplies for the return trip.",
			target = 5,
			benefits = {},
		},
		{
			id = "VE08",
			completionCash = 1050,
			name = "The Abandoned Detector",
			kind = "field",
			objective = "Recover Marked Research Case from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"VE06"},
			briefing = "Recover a prospector's field case.",
			completion = "You're back. Let me check the recorder.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_research",
				label = "The Abandoned Detector - Marked Research Case",
			},
			benefits = {},
		},
		{
			id = "VE09",
			completionCash = 875,
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
			benefits = {},
		},
		{
			id = "VE10",
			completionCash = 1250,
			name = "The Unstable Reading",
			kind = "field",
			objective = "Recover Handwritten Audio Cassette from the assigned search area in Garbage. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"VE08"},
			briefing = "Retrieve a recorder from a disputed field site.",
			completion = "Good. We'll look at the reading here.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_tape",
				label = "The Unstable Reading - Handwritten Audio Cassette",
			},
			benefits = {},
		},
		{
			id = "VE11",
			completionCash = 0,
			name = "Outside Familiar Ground",
			kind = "tracker",
			requires = {"VE09"},
			briefing = (
				"Deploy the sensor, let it finish, then collect it. Stay within range and keep yourself fit "
				.. "to carry it home."
			),
			completion = "You've brought back usable readings. Keep allowing enough supplies for the return trip.",
			target = 9,
			benefits = {},
		},
		{
			id = "VE12",
			completionCash = 1450,
			name = "The Control Run",
			kind = "field",
			objective = "Deploy the recorder in Garbage, leave it to record, then retrieve Numbered Data Module 0022."
				.. " Return it to this contact to finish the assignment.",
			requires = {"VE10"},
			briefing = "Record at a regional control site.",
			completion = "Leave it with me. Have some water.",
			field = {
				kind = "sensor",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_module2",
				label = "The Control Run - Numbered Data Module 0022",
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
			completionCash = 1175,
			name = "Supplies for Distance",
			kind = "delivery",
			requires = {"VE11"},
			briefing = (
				"Bring what's on the list. Check your own kit before giving away the supplies you need "
				.. "to get home. Go through the return instructions before you leave. It's easier to ask a "
				.. "sensible question here than invent an answer in the field."
			),
			completion = (
				"Good. Check your own supplies before you leave. Good. You can leave that with me and "
				.. "take a minute to settle. I'll check it without someone trying to rush the answer."
			),
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 4,
				},
			},
			benefits = {},
		},
		{
			id = "VE14",
			completionCash = 1650,
			name = "The Lost Team's Notes",
			kind = "field",
			objective = "Recover Scientist's Field Diary from the assigned search area in Waystation. Deliver it to"
				.. " 'Wake' in Garbage, then return here to finish the assignment.",
			requires = {"VE12"},
			briefing = "Recover a prospecting log in Waystation territory.",
			completion = "Delivered, and you made it back. That is the useful part. I will mark it done.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_diary",
				label = "The Lost Team's Notes - Scientist's Field Diary",
				recipient = "wake",
			},
			benefits = {},
		},
		{
			id = "VE15",
			completionCash = 0,
			name = "Know When to Leave",
			kind = "tracker",
			requires = {"VE13"},
			briefing = (
				"Deploy the sensor, let it finish, then collect it. Stay within range and keep yourself fit "
				.. "to carry it home."
			),
			completion = "You've brought back usable readings. Keep allowing enough supplies for the return trip.",
			target = 14,
			benefits = {},
		},
		{
			id = "VE16",
			completionCash = 1850,
			name = "The First Pripyat Field",
			kind = "field",
			objective = "Deploy the recorder in Pripyat, leave it to record, then retrieve Numbered Data Module 0013."
				.. " Return it to this contact to finish the assignment.",
			requires = {"VE14"},
			briefing = "Deploy and retrieve a recorder at a Pripyat field.",
			completion = "Good. We'll look at the reading here.",
			field = {
				kind = "sensor",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module",
				label = "The First Pripyat Field - Numbered Data Module 0013",
			},
			benefits = {},
		},
		{
			id = "VE17",
			completionCash = 1475,
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
			benefits = {},
		},
		{
			id = "VE18",
			completionCash = 2050,
			name = "The Team's Cache",
			kind = "field",
			objective = "Recover Striped Equipment Case from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"VE16"},
			briefing = "Recover a lost prospecting team's equipment case.",
			completion = "Leave it with me. Have some water.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_equipment",
				label = "The Team's Cache - Striped Equipment Case",
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
			completionCash = 0,
			name = "A Measured Risk",
			kind = "tracker",
			requires = {"VE17"},
			briefing = (
				"Deploy the sensor, let it finish, then collect it. Stay within range and keep yourself fit "
				.. "to carry it home."
			),
			completion = "You've brought back usable readings. Keep allowing enough supplies for the return trip.",
			target = 20,
			benefits = {},
		},
		{
			id = "VE20",
			completionCash = 2250,
			name = "The Field They Chose",
			kind = "field",
			objective = "Deploy the recorder in Garbage, leave it to record, then retrieve Numbered Data Module 0022."
				.. " Return it to this contact to finish the assignment.",
			requires = {"VE18"},
			briefing = "Record the team's last known anomaly site.",
			completion = "You're back. Let me check the recorder.",
			field = {
				kind = "sensor",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_module2",
				label = "The Field They Chose - Numbered Data Module 0022",
			},
			benefits = {},
		},
		{
			id = "VE21",
			completionCash = 1775,
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
			benefits = {},
		},
		{
			id = "VE22",
			completionCash = 2450,
			name = "A Different Explanation",
			kind = "field",
			objective = "Recover Handwritten Audio Cassette from the assigned search area in Pripyat. Deliver it to"
				.. " 'Carbon' in Waystation, then return here to finish the assignment.",
			requires = {"VE21"},
			briefing = "Recover a missing control recorder in Pripyat.",
			completion = "Delivered, and you made it back. That is the useful part. I will mark it done.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_tape",
				label = "A Different Explanation - Handwritten Audio Cassette",
				recipient = "carbon",
			},
			benefits = {},
		},
		{
			id = "VE23",
			completionCash = 0,
			name = "Everyone Comes Back",
			kind = "tracker",
			requires = {"VE22"},
			briefing = (
				"Deploy the sensor, let it finish, then collect it. Stay within range and keep yourself fit "
				.. "to carry it home."
			),
			completion = "You've brought back usable readings. Keep allowing enough supplies for the return trip.",
			target = 27,
			benefits = {},
		},
		{
			id = "VE24",
			completionCash = 2650,
			name = "The Last Recorder",
			kind = "field",
			objective = "Recover Blue-Label Audio Cassette from the assigned search area in Garbage. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"VE23"},
			briefing = (
				"Retrieve the expedition's final recorder and return its account. Bring the recording home before "
				.. "listening. There's no account on it worth getting distracted over while you're still out there."
			),
			completion = (
				"Leave it with me. Have some water. You're back. Good. I'll give the recording a proper listen, "
				.. "and you can stop checking over your shoulder for a minute. You've earned a quieter conversation "
				.. "than the one waiting outside."
			),
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_tape2",
				label = "The Last Recorder - Blue-Label Audio Cassette",
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
