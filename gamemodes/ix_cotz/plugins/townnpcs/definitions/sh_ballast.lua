PLUGIN:Register("ballast", {
	name = "'Ballast'",
	template = "ballastnpc",
	map = "rp_marsh_cs",
	job = {
		kind = "recovery",
		category = "Equipment recovery",
		description = "Equipment recovery",
		pools = {"workshop_supplies", "fuel"},
		quantities = {5, 9, 15},
		maps = {
			easy = "rp_marsh_cs",
			medium = "mz_garbage",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	dialogue = {
		completedGreeting = (
			"That freight is accounted for. Good to see you back on this side of the job."
		),
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Recover the marked case and bring it back intact. Think about the weight before you climb down "
			.. "for it."
		),
		progressionPrompt = "What else needs doing?",
		progression = "There are stranded cases and missing freight records. Tell me which one you're going after.",
	},
	progression = {
		{
			id = "BA01",
			name = "A Dry Package",
			kind = "delivery",
			requires = {},
			briefing = "I need these supplies. Bring them here, and leave yourself room to carry your own kit.",
			completion = "Set it down. No need to throw it.",
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
			id = "BA02",
			name = "The First Stranding",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"BA01"},
			briefing = "Recover a shipment case on a Marsh shore.",
			completion = "Dry enough. Let's have a look.",
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
		},
		{
			id = "BA03",
			name = "Nothing Left Behind",
			kind = "tracker",
			requires = {"BA02"},
			briefing = (
				"Recover the marked case and bring it back intact. Think about the weight before you climb "
				.. "down for it."
			),
			completion = "You've brought enough cargo back for me to know you can carry it without losing half of it.",
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
			id = "BA04",
			name = "The Rotten Landing",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"BA02"},
			briefing = "Retrieve a landing inspection record.",
			completion = "You and the case made it back. That's a start.",
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
			id = "BA05",
			name = "Fuel for the Return",
			kind = "delivery",
			requires = {"BA03"},
			briefing = "I need these supplies. Bring them here, and leave yourself room to carry your own kit.",
			completion = "That's what I asked for.",
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
			id = "BA06",
			name = "A Missing Mooring",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"BA04"},
			briefing = "Recover a landing maintenance case.",
			completion = "Leave it here. I'll check the contents.",
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
			id = "BA07",
			name = "A Reliable Pair of Hands",
			kind = "tracker",
			requires = {"BA05"},
			briefing = (
				"Recover the marked case and bring it back intact. Think about the weight before you climb "
				.. "down for it."
			),
			completion = "You've brought enough cargo back for me to know you can carry it without losing half of it.",
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
			id = "BA08",
			name = "The Crew List",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"BA06"},
			briefing = "Recover a missing crew's roster from a shore cache.",
			completion = "Dry enough. Let's have a look.",
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
			id = "BA09",
			name = "Names on the Manifest",
			kind = "delivery",
			requires = {"BA07"},
			briefing = "I need these supplies. Bring them here, and leave yourself room to carry your own kit.",
			completion = "Good. I'll stow it properly.",
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
			id = "BA10",
			name = "The Floating Trail",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"BA08"},
			briefing = "Recover the crew's recorder near a remote Marsh water route.",
			completion = "You and the case made it back. That's a start.",
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
			id = "BA11",
			name = "Recover What Matters",
			kind = "tracker",
			requires = {"BA09"},
			briefing = (
				"Recover the marked case and bring it back intact. Think about the weight before you climb "
				.. "down for it."
			),
			completion = "You've brought enough cargo back for me to know you can carry it without losing half of it.",
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
			id = "BA12",
			name = "The Disputed Cargo",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"BA10"},
			briefing = "Retrieve shipment evidence at a Garbage freight site.",
			completion = "Leave it here. I'll check the contents.",
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
		},
		{
			id = "BA13",
			name = "Patch and Pack",
			kind = "delivery",
			requires = {"BA11"},
			briefing = "I need these supplies. Bring them here, and leave yourself room to carry your own kit.",
			completion = "Set it down. No need to throw it.",
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
			id = "BA14",
			name = "The Other Landing",
			kind = "field",
			objective = (
				"Deploy the recorder at the marked site, remain in range until it finishes, and collect it "
				.. "in Marsh. Return to this contact to finish the assignment."
			),
			requires = {"BA12"},
			briefing = "Recover a landing record at a regional supply stop.",
			completion = "Dry enough. Let's have a look.",
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
			id = "BA15",
			name = "The Long Haul Back",
			kind = "tracker",
			requires = {"BA13"},
			briefing = (
				"Recover the marked case and bring it back intact. Think about the weight before you climb "
				.. "down for it."
			),
			completion = "You've brought enough cargo back for me to know you can carry it without losing half of it.",
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
			id = "BA16",
			name = "A Voice From Shore",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"BA14"},
			briefing = "Retrieve the crew's recorded message at an abandoned camp.",
			completion = "You and the case made it back. That's a start.",
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
			id = "BA17",
			name = "A Boat in Reserve",
			kind = "delivery",
			requires = {"BA15"},
			briefing = "I need these supplies. Bring them here, and leave yourself room to carry your own kit.",
			completion = "That's what I asked for.",
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
			id = "BA18",
			name = "The Last Mooring",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"BA16"},
			briefing = "Recover the crew's final personal case.",
			completion = "Leave it here. I'll check the contents.",
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
			id = "BA19",
			name = "Safe to Bring Home",
			kind = "tracker",
			requires = {"BA17", "BA18"},
			briefing = (
				"Recover the marked case and bring it back intact. Think about the weight before you climb "
				.. "down for it."
			),
			completion = "You've brought enough cargo back for me to know you can carry it without losing half of it.",
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
			id = "BA20",
			name = "The Missing Logbook",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"BA19"},
			briefing = "Recover a regional landing log proving what happened.",
			completion = "Dry enough. Let's have a look.",
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
			stock = {
				item = "drink_bottlewater",
				bonus = 2,
			},
		},
		{
			id = "BA21",
			name = "A Working Landing",
			kind = "delivery",
			requires = {"BA20"},
			briefing = "I need these supplies. Bring them here, and leave yourself room to carry your own kit.",
			completion = "Good. I'll stow it properly.",
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
			id = "BA22",
			name = "The First Return Cargo",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"BA21"},
			briefing = "Complete one recovery along the supply route.",
			completion = "You and the case made it back. That's a start.",
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
			recognition = "Ballast's trusted contact",
		},
	},
})
