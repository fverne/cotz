PLUGIN:Register("intern", {
	name = "'Intern'",
	template = "ecologistnpc3",
	map = "rp_waystation",
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
	rewards = {
		packages = {
			{label = "Routine survey",
				items = {"drink_bottlewater", "medic_bandage_1"}},
			{label = "Exposure precautions",
				items = {"medic_antirad_1"}},
			{label = "Overtime",
				items = {"drug_caffeine", "food_raisins"}},
		},
	},
	dialogue = {
		completedGreeting = (
			"Hello! I've been keeping my own notes in order. It's rather nice to know what I want to say "
			.. "before anyone asks."
		),
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Sensor surveys. Set it up at the marked site, wait for it to finish, and bring the recorder back. "
			.. "Please give the recorder the time it needs. I can check a full set of readings; I can't recreate "
			.. "the missing part by staring at the page harder."
		),
		progressionPrompt = "What else needs doing?",
		progression = (
			"I've got supplies to collect and readings to check. I can show you what I still need. I've got the "
			.. "supply lists and field records here. I want to understand the whole survey, including the awkward "
			.. "bits, before I ask anyone to take my conclusions seriously."
		),
	},
	catalogue = {
	},
	progression = {
		{
			id = "IN01",
			completionCash = 275,
			name = "An Instrument of My Own",
			kind = "delivery",
			requires = {},
			briefing = (
				"I've written down what I'm short of. Could you bring it here? I'll check it against the "
				.. "list. I've checked the list. Twice, actually. I'd like to have the equipment ready "
				.. "without having to ask everyone else for a spare at the last minute."
			),
			completion = (
				"Oh, good. That's one thing ready. Thank you. I'll put these aside before somebody "
				.. "assumes they're part of the general supply. I'm allowed to organise my own work too."
			),
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
			completionCash = 450,
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
			benefits = {},
		},
		{
			id = "IN03",
			completionCash = 0,
			name = "Readings on Time",
			kind = "tracker",
			requires = {"IN02"},
			briefing = (
				"Sensor surveys. Set it up at the marked site, wait for it to finish, and bring the recorder "
				.. "back."
			),
			completion = "Those surveys have helped. I can account for the readings now.",
			target = 2,
			benefits = {},
		},
		{
			id = "IN04",
			completionCash = 650,
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
			benefits = {},
		},
		{
			id = "IN05",
			completionCash = 575,
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
			benefits = {},
		},
		{
			id = "IN06",
			completionCash = 850,
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
			completionCash = 0,
			name = "Same Place Same Method",
			kind = "tracker",
			requires = {"IN05"},
			briefing = (
				"Sensor surveys. Set it up at the marked site, wait for it to finish, and bring the recorder "
				.. "back."
			),
			completion = "Those surveys have helped. I can account for the readings now.",
			target = 5,
			benefits = {},
		},
		{
			id = "IN08",
			completionCash = 1050,
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
			benefits = {},
		},
		{
			id = "IN09",
			completionCash = 875,
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
			benefits = {},
		},
		{
			id = "IN10",
			completionCash = 1250,
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
			benefits = {},
		},
		{
			id = "IN11",
			completionCash = 0,
			name = "A Wider Baseline",
			kind = "tracker",
			requires = {"IN09"},
			briefing = (
				"Sensor surveys. Set it up at the marked site, wait for it to finish, and bring the recorder "
				.. "back."
			),
			completion = "Those surveys have helped. I can account for the readings now.",
			target = 9,
			benefits = {},
		},
		{
			id = "IN12",
			completionCash = 1450,
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
			completionCash = 1175,
			name = "Ready for the Distance",
			kind = "delivery",
			requires = {"IN11"},
			briefing = (
				"I've written down what I'm short of. Could you bring it here? I'll check it against the "
				.. "list. Please follow the instructions on the order. I want to be able to explain the "
				.. "work afterwards without filling the gaps with guesses."
			),
			completion = (
				"Oh, good. That's one thing ready. Right. I'll check it against my notes before I show "
				.. "anyone. It takes me a little longer when I'm determined not to borrow somebody else's "
				.. "answer."
			),
			requirements = {
				{
					pool = "canned_food",
					quantity = 4,
				},
			},
			benefits = {},
		},
		{
			id = "IN14",
			completionCash = 1650,
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
			benefits = {},
		},
		{
			id = "IN15",
			completionCash = 0,
			name = "My Own Figures",
			kind = "tracker",
			requires = {"IN13"},
			briefing = (
				"Sensor surveys. Set it up at the marked site, wait for it to finish, and bring the recorder "
				.. "back."
			),
			completion = "Those surveys have helped. I can account for the readings now.",
			target = 14,
			benefits = {},
		},
		{
			id = "IN16",
			completionCash = 1850,
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
			benefits = {},
		},
		{
			id = "IN17",
			completionCash = 1475,
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
			benefits = {},
		},
		{
			id = "IN18",
			completionCash = 2050,
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
			completionCash = 0,
			name = "Enough to Stand Behind",
			kind = "tracker",
			requires = {"IN17"},
			briefing = (
				"Sensor surveys. Set it up at the marked site, wait for it to finish, and bring the recorder "
				.. "back."
			),
			completion = "Those surveys have helped. I can account for the readings now.",
			target = 20,
			benefits = {},
		},
		{
			id = "IN20",
			completionCash = 2250,
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
			benefits = {},
		},
		{
			id = "IN21",
			completionCash = 1775,
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
			benefits = {},
		},
		{
			id = "IN22",
			completionCash = 2450,
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
			benefits = {},
		},
		{
			id = "IN23",
			completionCash = 0,
			name = "Put My Name on It",
			kind = "tracker",
			requires = {"IN22"},
			briefing = (
				"Sensor surveys. Set it up at the marked site, wait for it to finish, and bring the recorder "
				.. "back."
			),
			completion = "Those surveys have helped. I can account for the readings now.",
			target = 27,
			benefits = {},
		},
		{
			id = "IN24",
			completionCash = 2650,
			name = "The Missing Observation",
			kind = "field",
			objective = "Recover Laboratory Log Folder from the assigned search area in Waystation. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"IN23"},
			briefing = (
				"Recover the last field record and present a complete independent survey. Bring the full log back. "
				.. "If there's something missing from my account, I want to find it before I call the survey "
				.. "complete."
			),
			completion = (
				"Good. Give me a moment to compare the figures. Let me check that once more. Yes, I'll write up "
				.. "what the figures support. My own wording this time. Thank you for sticking with it; I know it "
				.. "wasn't all exciting fieldwork."
			),
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
