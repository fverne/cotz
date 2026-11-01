PLUGIN:Register("atlas", {
	name = "'Atlas'",
	template = "atlasnpc",
	map = "rp_marsh_cs",
	job = {
		kind = "sensor",
		category = "Sensor deployment and retrieval",
		description = "Sensor deployment and retrieval",
		maps = {
			easy = "rp_marsh_cs",
			medium = "mz_garbage",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	dialogue = {
		delivery = "Here, please. I will check it against the route record.",
		completedGreeting = "I'll put their names on the finished sheet. They earned that much.",
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = "Set down the recorder at the assigned site. Give it time, collect it, and bring it back to me.",
		progressionPrompt = "What else needs doing?",
		progression = (
			"I'm checking routes and the records left by the survey teams. Choose something you can get "
			.. "back from."
		),
	},
	catalogue = {
	},
	progression = {
		{
			id = "AT01",
			completionCash = 275,
			name = "Marks on Paper",
			kind = "delivery",
			requires = {},
			briefing = "I need these supplies for the survey work. Bring them here; I'll check them before packing.",
			completion = "Thank you. I'll put it with the survey supplies.",
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
			id = "AT02",
			completionCash = 450,
			name = "The First Landmark",
			kind = "field",
			objective = "Deploy the recorder in Marsh, leave it to record, then retrieve Numbered Data Module 0013."
				.. " Return it to this contact to finish the assignment.",
			requires = {"AT01"},
			briefing = "Deploy and retrieve a recorder near a Marsh landmark.",
			completion = "Let me check the recording before we draw anything from it.",
			field = {
				kind = "sensor",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_module",
				label = "The First Landmark - Numbered Data Module 0013",
			},
			benefits = {},
		},
		{
			id = "AT03",
			completionCash = 0,
			name = "Repeatable Ground",
			kind = "tracker",
			requires = {"AT02"},
			briefing = (
				"Set down the recorder at the assigned site. Give it time, collect it, and bring it back to "
				.. "me."
			),
			completion = (
				"You've brought back enough sound readings to be useful. I'd rather have those than a quick "
				.. "guess."
			),
			target = 2,
			benefits = {},
		},
		{
			id = "AT04",
			completionCash = 650,
			name = "The Route That Shifted",
			kind = "field",
			objective = "Recover Numbered Data Module 0022 from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"AT02"},
			briefing = "Retrieve a recorder near a blocked Marsh approach.",
			completion = "Thank you. I'll mark where it came from.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_module2",
				label = "The Route That Shifted - Numbered Data Module 0022",
			},
			benefits = {},
		},
		{
			id = "AT05",
			completionCash = 575,
			name = "A Better Baseline",
			kind = "delivery",
			requires = {"AT03"},
			briefing = "I need these supplies for the survey work. Bring them here; I'll check them before packing.",
			completion = "That covers what I asked for.",
			requirements = {
				{
					pool = "basic_tools",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "AT06",
			completionCash = 850,
			name = "Ballast's Shortcut",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Marsh. Deliver it to 'Ballast'"
				.. " in Marsh, then return here to finish the assignment.",
			requires = {"AT04"},
			briefing = "Recover the waterside survey record.",
			completion = "That copy is where it can be used. I will mark the delivery beside the route.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "Ballast's Shortcut - Tied Leather Journal",
				recipient = "ballast",
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
			id = "AT07",
			completionCash = 0,
			name = "Measured Twice",
			kind = "tracker",
			requires = {"AT05"},
			briefing = (
				"Set down the recorder at the assigned site. Give it time, collect it, and bring it back to "
				.. "me."
			),
			completion = (
				"You've brought back enough sound readings to be useful. I'd rather have those than a quick "
				.. "guess."
			),
			target = 5,
			benefits = {},
		},
		{
			id = "AT08",
			completionCash = 1050,
			name = "The Missing Surveyor",
			kind = "field",
			objective = "Recover Scientist's Field Diary from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"AT06"},
			briefing = "Recover a surveyor's notebook near the Garbage approach.",
			completion = "Let me check the recording before we draw anything from it.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_diary",
				label = "The Missing Surveyor - Scientist's Field Diary",
			},
			benefits = {},
		},
		{
			id = "AT09",
			completionCash = 875,
			name = "Paper Trail",
			kind = "delivery",
			requires = {"AT07"},
			briefing = "I need these supplies for the survey work. Bring them here; I'll check them before packing.",
			completion = "Good. We can pack that properly now.",
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "AT10",
			completionCash = 1250,
			name = "An Unfinished Map",
			kind = "field",
			objective = "Recover Handwritten Audio Cassette from the assigned search area in Garbage. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"AT08"},
			briefing = "Collect the surveyor's recorder in Garbage.",
			completion = "Thank you. I'll mark where it came from.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_tape",
				label = "An Unfinished Map - Handwritten Audio Cassette",
			},
			benefits = {},
		},
		{
			id = "AT11",
			completionCash = 0,
			name = "Ground Truth",
			kind = "tracker",
			requires = {"AT09"},
			briefing = (
				"Set down the recorder at the assigned site. Give it time, collect it, and bring it back to "
				.. "me."
			),
			completion = (
				"You've brought back enough sound readings to be useful. I'd rather have those than a quick "
				.. "guess."
			),
			target = 9,
			benefits = {},
		},
		{
			id = "AT12",
			completionCash = 1450,
			name = "The Freight Route",
			kind = "field",
			objective = "Recover Warehouse Packing List A from the assigned search area in Marsh. Deliver it to"
				.. " 'Ledger' in Waystation, then return here to finish the assignment.",
			requires = {"AT10"},
			briefing = "Retrieve a survey record along Ledger's recorded route.",
			completion = "That copy is where it can be used. I will mark the delivery beside the route.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_manifest",
				label = "The Freight Route - Warehouse Packing List A",
				recipient = "ledger",
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
			id = "AT13",
			completionCash = 1175,
			name = "Lines That Agree",
			kind = "delivery",
			requires = {"AT11"},
			briefing = "I need these supplies for the survey work. Bring them here; I'll check them before packing.",
			completion = "Thank you. I'll put it with the survey supplies.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 4,
				},
			},
			benefits = {},
		},
		{
			id = "AT14",
			completionCash = 1650,
			name = "The Wrong Coordinates",
			kind = "field",
			objective = "Recover Official File Folder from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"AT12"},
			briefing = "Recover the record of the disputed coordinates.",
			completion = "Let me check the recording before we draw anything from it.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_official",
				label = "The Wrong Coordinates - Official File Folder",
			},
			benefits = {},
		},
		{
			id = "AT15",
			completionCash = 0,
			name = "Beyond the Margin",
			kind = "tracker",
			requires = {"AT13"},
			briefing = (
				"Set down the recorder at the assigned site. Give it time, collect it, and bring it back to "
				.. "me."
			),
			completion = (
				"You've brought back enough sound readings to be useful. I'd rather have those than a quick "
				.. "guess."
			),
			target = 14,
			benefits = {},
		},
		{
			id = "AT16",
			completionCash = 1850,
			name = "The Lost Team's Cache",
			kind = "field",
			objective = "Recover Striped Equipment Case from the assigned search area in Waystation. Deliver it to"
				.. " 'Wake' in Garbage, then return here to finish the assignment.",
			requires = {"AT14"},
			briefing = "Recover a team case in Waystation territory.",
			completion = "That copy is where it can be used. I will mark the delivery beside the route.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_equipment",
				label = "The Lost Team's Cache - Striped Equipment Case",
				recipient = "wake",
			},
			benefits = {},
		},
		{
			id = "AT17",
			completionCash = 1475,
			name = "Preparing the Last Sheet",
			kind = "delivery",
			requires = {"AT15"},
			briefing = "I need these supplies for the survey work. Bring them here; I'll check them before packing.",
			completion = "That covers what I asked for.",
			requirements = {
				{
					pool = "small_electronics",
					quantity = 5,
				},
			},
			benefits = {},
		},
		{
			id = "AT18",
			completionCash = 2050,
			name = "The First Pripyat Mark",
			kind = "field",
			objective = "Deploy the recorder in Pripyat, leave it to record, then retrieve Numbered Data Module 0013."
				.. " Return it to this contact to finish the assignment.",
			requires = {"AT16"},
			briefing = "Deploy and retrieve a recorder at a Pripyat entry landmark.",
			completion = "Set it here, beside the survey sheet.",
			field = {
				kind = "sensor",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module",
				label = "The First Pripyat Mark - Numbered Data Module 0013",
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
			id = "AT19",
			completionCash = 0,
			name = "A Map Worth Carrying",
			kind = "tracker",
			requires = {"AT17", "AT18"},
			briefing = (
				"Set down the recorder at the assigned site. Give it time, collect it, and bring it back to "
				.. "me."
			),
			completion = (
				"You've brought back enough sound readings to be useful. I'd rather have those than a quick "
				.. "guess."
			),
			target = 20,
			benefits = {},
		},
		{
			id = "AT20",
			completionCash = 2250,
			name = "The Last Survey Station",
			kind = "field",
			objective = "Recover Handwritten Audio Cassette from the assigned search area in Pripyat. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"AT19"},
			briefing = "Recover the team's final recorder deeper in Pripyat.",
			completion = "Let me check the recording before we draw anything from it.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_tape",
				label = "The Last Survey Station - Handwritten Audio Cassette",
			},
			benefits = {},
			stock = {
				item = "drink_bottlewater",
				bonus = 2,
			},
		},
		{
			id = "AT21",
			completionCash = 1775,
			name = "An Atlas With Names",
			kind = "delivery",
			requires = {"AT20"},
			briefing = "I need these supplies for the survey work. Bring them here; I'll check them before packing.",
			completion = "Good. We can pack that properly now.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 6,
				},
			},
			benefits = {},
		},
		{
			id = "AT22",
			completionCash = 2450,
			name = "Finish Their Route",
			kind = "field",
			objective = "Deploy the recorder in Pripyat, leave it to record, then retrieve Numbered Data Module 0022."
				.. " Return it to this contact to finish the assignment.",
			requires = {"AT21"},
			briefing = "Record the final Pripyat site and return the completed evidence.",
			completion = "Thank you. I'll mark where it came from.",
			field = {
				kind = "sensor",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module2",
				label = "Finish Their Route - Numbered Data Module 0022",
			},
			benefits = {},
			recognition = "Atlas's trusted contact",
		},
	},
})
