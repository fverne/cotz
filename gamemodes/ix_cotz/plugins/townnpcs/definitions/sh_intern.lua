PLUGIN:Register("intern", {
	name = "'Intern'",
	template = "ecologistnpc3",
	map = "rp_waystation",
	access = {contact = "smartass", step = "SM07"},
	job = {
		kind = "sensor",
		category = "Sensor deployment and retrieval",
		description = "Sensor deployment and retrieval",
		maps = {
			easy = "rp_waystation",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	dialogue = {
		completedGreeting = "Those are my figures. You can put my name on the report.",
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Sensor surveys. Set it up at the marked site, wait for it to finish, and bring the recorder "
			.. "back."
		),
		progressionPrompt = "What else needs doing?",
		progression = "I've got supplies to collect and readings to check. I can show you what I still need.",
	},
	progression = {
		{
			id = "IN01",
			name = "An Instrument of My Own",
			kind = "delivery",
			requires = {},
			briefing = (
				"I've written down what I'm short of. Could you bring it here? I'll check it against the "
				.. "list."
			),
			completion = "Oh, good. That's one thing ready.",
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
			id = "IN02",
			name = "The Calibration Point",
			kind = "field",
			objective = "Deploy the recorder in Waystation, leave it to record, then retrieve Numbered Data Module"
				.. " 0013. Return it to this contact to finish the assignment.",
			requires = {"IN01"},
			briefing = "Deploy and retrieve a sensor near Waystation.",
			completion = "You got it back! Let me check the recording.",
			field = {
				kind = "sensor",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_module",
				label = "The Calibration Point - Numbered Data Module 0013",
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
			id = "IN03",
			name = "Readings on Time",
			kind = "tracker",
			requires = {"IN02"},
			briefing = (
				"Sensor surveys. Set it up at the marked site, wait for it to finish, and bring the recorder "
				.. "back."
			),
			completion = "Those surveys have helped. I can account for the readings now.",
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
			id = "IN04",
			name = "The Mislabelled Sample",
			kind = "field",
			objective = "Recover Laboratory Log Folder from the assigned search area in Waystation. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"IN02"},
			briefing = "Recover a field label register.",
			completion = "Thank you. I need to keep this one labelled.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_lab",
				label = "The Mislabelled Sample - Laboratory Log Folder",
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
			id = "IN05",
			name = "Clean Containers",
			kind = "delivery",
			requires = {"IN03"},
			briefing = (
				"I've written down what I'm short of. Could you bring it here? I'll check it against the "
				.. "list."
			),
			completion = "Thank you. I'll check it against the list.",
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
			id = "IN06",
			name = "Beanstalk's Control",
			kind = "field",
			objective = "Deploy the recorder in Garbage, leave it to record, then retrieve Numbered Data Module 0022."
				.. " Return it to this contact to finish the assignment.",
			requires = {"IN04"},
			briefing = "Record at an accessible Garbage control site.",
			completion = "Good. Give me a moment to compare the figures.",
			field = {
				kind = "sensor",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_module2",
				label = "Beanstalk's Control - Numbered Data Module 0022",
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
			id = "IN07",
			name = "Same Place Same Method",
			kind = "tracker",
			requires = {"IN05"},
			briefing = (
				"Sensor surveys. Set it up at the marked site, wait for it to finish, and bring the recorder "
				.. "back."
			),
			completion = "Those surveys have helped. I can account for the readings now.",
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
			id = "IN08",
			name = "The Missing Interval",
			kind = "field",
			objective = "Recover Handwritten Audio Cassette from the assigned search area in Waystation. Deliver it"
				.. " to 'Spool' in Garbage, then return here to finish the assignment.",
			requires = {"IN06"},
			briefing = "Recover an interrupted recording at a regional site.",
			completion = "They have it? Good. I wrote the reference down so we can find it again.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_tape",
				label = "The Missing Interval - Handwritten Audio Cassette",
				recipient = "spool",
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
			id = "IN09",
			name = "Something to Compare",
			kind = "delivery",
			requires = {"IN07"},
			briefing = (
				"I've written down what I'm short of. Could you bring it here? I'll check it against the "
				.. "list."
			),
			completion = "Yes, that's right. Put it here.",
			requirements = {
				{
					pool = "administrative_documents",
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
			id = "IN10",
			name = "The Senior's Notebook",
			kind = "field",
			objective = "Recover Scientist's Field Diary from the assigned search area in Waystation. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"IN08"},
			briefing = "Recover an abandoned research note.",
			completion = "Thank you. I need to keep this one labelled.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_diary",
				label = "The Senior's Notebook - Scientist's Field Diary",
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
			id = "IN11",
			name = "A Wider Baseline",
			kind = "tracker",
			requires = {"IN09"},
			briefing = (
				"Sensor surveys. Set it up at the marked site, wait for it to finish, and bring the recorder "
				.. "back."
			),
			completion = "Those surveys have helped. I can account for the readings now.",
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
			id = "IN12",
			name = "The Field Vesper Chose",
			kind = "field",
			objective = "Deploy the recorder in Waystation, leave it to record, then retrieve Numbered Data Module"
				.. " 0013. Return it to this contact to finish the assignment.",
			requires = {"IN10"},
			briefing = "Deploy and retrieve a recorder near an anomaly approach.",
			completion = "Good. Give me a moment to compare the figures.",
			field = {
				kind = "sensor",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_module",
				label = "The Field Vesper Chose - Numbered Data Module 0013",
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
			id = "IN13",
			name = "Ready for the Distance",
			kind = "delivery",
			requires = {"IN11"},
			briefing = (
				"I've written down what I'm short of. Could you bring it here? I'll check it against the "
				.. "list."
			),
			completion = "Oh, good. That's one thing ready.",
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
			id = "IN14",
			name = "The Lost Calibration Case",
			kind = "field",
			objective = "Recover Marked Research Case from the assigned search area in Waystation. Deliver it to"
				.. " 'Technut' in Marsh, then return here to finish the assignment.",
			requires = {"IN12"},
			briefing = "Recover an instrument case in remote regional territory.",
			completion = "They have it? Good. I wrote the reference down so we can find it again.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_research",
				label = "The Lost Calibration Case - Marked Research Case",
				recipient = "technut",
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
			id = "IN15",
			name = "My Own Figures",
			kind = "tracker",
			requires = {"IN13"},
			briefing = (
				"Sensor surveys. Set it up at the marked site, wait for it to finish, and bring the recorder "
				.. "back."
			),
			completion = "Those surveys have helped. I can account for the readings now.",
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
			id = "IN16",
			name = "The First Pripyat Series",
			kind = "field",
			objective = "Deploy the recorder in Pripyat, leave it to record, then retrieve Numbered Data Module 0022."
				.. " Return it to this contact to finish the assignment.",
			requires = {"IN14"},
			briefing = "Deploy and retrieve a sensor in Pripyat.",
			completion = "Thank you. I need to keep this one labelled.",
			field = {
				kind = "sensor",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module2",
				label = "The First Pripyat Series - Numbered Data Module 0022",
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
			id = "IN17",
			name = "Without Missing Pages",
			kind = "delivery",
			requires = {"IN15"},
			briefing = (
				"I've written down what I'm short of. Could you bring it here? I'll check it against the "
				.. "list."
			),
			completion = "Thank you. I'll check it against the list.",
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
			id = "IN18",
			name = "The Contradictory Site",
			kind = "field",
			objective = "Deploy the recorder in Pripyat, leave it to record, then retrieve Numbered Data Module 0013."
				.. " Return it to this contact to finish the assignment.",
			requires = {"IN16"},
			briefing = "Record at a second Pripyat research location.",
			completion = "Good. Give me a moment to compare the figures.",
			field = {
				kind = "sensor",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module",
				label = "The Contradictory Site - Numbered Data Module 0013",
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
			id = "IN19",
			name = "Enough to Stand Behind",
			kind = "tracker",
			requires = {"IN17"},
			briefing = (
				"Sensor surveys. Set it up at the marked site, wait for it to finish, and bring the recorder "
				.. "back."
			),
			completion = "Those surveys have helped. I can account for the readings now.",
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
			id = "IN20",
			name = "The Earlier Team",
			kind = "field",
			objective = "Recover Handwritten Audio Cassette from the assigned search area in Pripyat. Deliver it to"
				.. " 'Wake' in Garbage, then return here to finish the assignment.",
			requires = {"IN18"},
			briefing = "Recover an earlier survey recorder in Pripyat.",
			completion = "They have it? Good. I wrote the reference down so we can find it again.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_tape",
				label = "The Earlier Team - Handwritten Audio Cassette",
				recipient = "wake",
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
			id = "IN21",
			name = "The Last Calibration",
			kind = "delivery",
			requires = {"IN19", "IN20"},
			briefing = (
				"I've written down what I'm short of. Could you bring it here? I'll check it against the "
				.. "list."
			),
			completion = "Yes, that's right. Put it here.",
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
			id = "IN22",
			name = "The Independent Control",
			kind = "field",
			objective = "Deploy the recorder in Pripyat, leave it to record, then retrieve Numbered Data Module 0022."
				.. " Return it to this contact to finish the assignment.",
			requires = {"IN21"},
			briefing = "Deploy and retrieve the final independent Pripyat recorder.",
			completion = "Thank you. I need to keep this one labelled.",
			field = {
				kind = "sensor",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module2",
				label = "The Independent Control - Numbered Data Module 0022",
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
			id = "IN23",
			name = "Put My Name on It",
			kind = "tracker",
			requires = {"IN22"},
			briefing = (
				"Sensor surveys. Set it up at the marked site, wait for it to finish, and bring the recorder "
				.. "back."
			),
			completion = "Those surveys have helped. I can account for the readings now.",
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
			id = "IN24",
			name = "The Missing Observation",
			kind = "field",
			objective = "Recover Laboratory Log Folder from the assigned search area in Waystation. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"IN23"},
			briefing = "Recover the last field record and present a complete independent survey.",
			completion = "Good. Give me a moment to compare the figures.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_lab",
				label = "The Missing Observation - Laboratory Log Folder",
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
			recognition = "Intern's trusted contact",
		},
	},
})
