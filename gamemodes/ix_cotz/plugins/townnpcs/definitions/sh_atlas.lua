PLUGIN:Register("atlas", {
	name = "'Atlas'",
	template = "atlasnpc",
	map = "rp_marsh_cs",
	job = {
		kind = "sensor",
		category = "Sensor deployment and retrieval",
		description = "Sensor deployment and retrieval",
		pools = {"field_maintenance", "batteries"},
		quantities = {5, 9, 15},
		maps = {
			easy = "rp_marsh_cs",
			medium = "mz_garbage",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	dialogue = {
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
	progression = {
		{
			id = "AT01",
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
			name = "The First Landmark",
			kind = "field",
			objective = (
				"Deploy the recorder at the marked site, remain in range until it finishes, and collect it "
				.. "in Marsh. Return to this contact to finish the assignment."
			),
			requires = {"AT01"},
			briefing = "Deploy and retrieve a recorder near a Marsh landmark.",
			completion = "Let me check the recording before we draw anything from it.",
			field = {
				kind = "sensor",
				map = "rp_marsh_cs",
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
			id = "AT03",
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
			id = "AT04",
			name = "The Route That Shifted",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"AT02"},
			briefing = "Retrieve a recorder near a blocked Marsh approach.",
			completion = "Thank you. I'll mark where it came from.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
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
			id = "AT05",
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
			id = "AT06",
			name = "Ballast's Shortcut",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"AT04"},
			briefing = "Recover the waterside survey record.",
			completion = "Set it here, beside the survey sheet.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
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
			id = "AT07",
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
			id = "AT08",
			name = "The Missing Surveyor",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"AT06"},
			briefing = "Recover a surveyor's notebook near the Garbage approach.",
			completion = "Let me check the recording before we draw anything from it.",
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
			id = "AT09",
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
			id = "AT10",
			name = "An Unfinished Map",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"AT08"},
			briefing = "Collect the surveyor's recorder in Garbage.",
			completion = "Thank you. I'll mark where it came from.",
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
			id = "AT11",
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
			id = "AT12",
			name = "The Freight Route",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"AT10"},
			briefing = "Retrieve a survey record along Ledger's recorded route.",
			completion = "Set it here, beside the survey sheet.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
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
			id = "AT13",
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
			id = "AT14",
			name = "The Wrong Coordinates",
			kind = "field",
			objective = (
				"Deploy the recorder at the marked site, remain in range until it finishes, and collect it "
				.. "in Marsh. Return to this contact to finish the assignment."
			),
			requires = {"AT12"},
			briefing = "Recover the record of the disputed coordinates.",
			completion = "Let me check the recording before we draw anything from it.",
			field = {
				kind = "sensor",
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
			id = "AT15",
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
			id = "AT16",
			name = "The Lost Team's Cache",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"AT14"},
			briefing = "Recover a team case in Waystation territory.",
			completion = "Thank you. I'll mark where it came from.",
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
			id = "AT17",
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
			id = "AT18",
			name = "The First Pripyat Mark",
			kind = "field",
			objective = (
				"Deploy the recorder at the marked site, remain in range until it finishes, and collect it "
				.. "in Pripyat. Return to this contact to finish the assignment."
			),
			requires = {"AT16"},
			briefing = "Deploy and retrieve a recorder at a Pripyat entry landmark.",
			completion = "Set it here, beside the survey sheet.",
			field = {
				kind = "sensor",
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
			id = "AT19",
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
			id = "AT20",
			name = "The Last Survey Station",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"AT19"},
			briefing = "Recover the team's final recorder deeper in Pripyat.",
			completion = "Let me check the recording before we draw anything from it.",
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
			stock = {
				item = "drink_bottlewater",
				bonus = 2,
			},
		},
		{
			id = "AT21",
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
			id = "AT22",
			name = "Finish Their Route",
			kind = "field",
			objective = (
				"Deploy the recorder at the marked site, remain in range until it finishes, and collect it "
				.. "in Pripyat. Return to this contact to finish the assignment."
			),
			requires = {"AT21"},
			briefing = "Record the final Pripyat site and return the completed evidence.",
			completion = "Thank you. I'll mark where it came from.",
			field = {
				kind = "sensor",
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
			recognition = "Atlas's trusted contact",
		},
	},
})
