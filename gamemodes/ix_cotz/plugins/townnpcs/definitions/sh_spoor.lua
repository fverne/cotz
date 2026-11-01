PLUGIN:Register("spoor", {
	name = "'Spoor'",
	template = "spoornpc",
	map = "mz_garbage",
	job = {
		kind = "hunting",
		category = "Mutant hunting",
		description = "Mutant hunting",
		quantities = {5, 9, 15},
	},
	supplies = {"12gauge", "22lr", "medic_bandage_1", "drink_bottlewater"},
	dialogue = {
		delivery = "Set it down. Tell me if anything happened to it on the way.",
		completedGreeting = "Now we know why they moved. Better than another tall tale.",
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = "Mutants on the routes. The job is to clear them, not to chase a trophy into another pack.",
		progressionPrompt = "What else needs doing?",
		progression = "Supplies and field observations. I'd like to know why the animals are moving, too.",
	},
	catalogue = {
		["machete"] = {step = "SP05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "SP01",
			name = "Reading the Remains",
			kind = "delivery",
			requires = {},
			briefing = "Bring what's listed here. Keep it in good condition; I need to examine it.",
			completion = "Let me check the condition.",
			requirements = {
				{
					pool = "common_parts",
					quantity = 1,
				},
			},
			benefits = {
				items = {
					{
						item = "12gauge",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "SP02",
			name = "The Scavenger's Camp",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SP01"},
			briefing = "Recover observations beside a Garbage hunting ground.",
			completion = "Where you found it is marked? Good.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "The Scavenger's Camp - Tied Leather Journal",
			},
			benefits = {
				items = {
					{
						item = "22lr",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "SP03",
			name = "Clear the Approach",
			kind = "tracker",
			requires = {"SP02"},
			briefing = "Mutants on the routes. The job is to clear them, not to chase a trophy into another pack.",
			completion = "You've cleared enough trouble for now. Keep watching where the others go.",
			target = 2,
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
			id = "SP04",
			name = "Where They Feed",
			kind = "field",
			objective = "Recover Handwritten Audio Cassette from the assigned search area in Garbage. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"SP02"},
			briefing = "Retrieve a recorder from a feeding site.",
			completion = "Let me look at the observations.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_tape",
				label = "Where They Feed - Handwritten Audio Cassette",
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
			id = "SP05",
			name = "Tools for the Field",
			kind = "delivery",
			requires = {"SP03"},
			briefing = "Bring what's listed here. Keep it in good condition; I need to examine it.",
			completion = "Good. Keep it out of the sun.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 3,
				},
			},
			benefits = {
				items = {
					{
						item = "12gauge",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "SP06",
			name = "Lemon's Complaint",
			kind = "field",
			objective = "Recover Scientist's Field Diary from the assigned search area in Garbage. Deliver it to"
				.. " 'Jitters' in Marsh, then return here to finish the assignment.",
			requires = {"SP04"},
			briefing = "Recover meat-handling notes from an abandoned camp.",
			completion = "Good. They have the record. Now we can compare what was actually found.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_diary",
				label = "Lemon's Complaint - Scientist's Field Diary",
				recipient = "jitters",
			},
			benefits = {
				items = {
					{
						item = "22lr",
						data = {
							quantity = 1,
						},
					},
				},
			},
			stock = {
				item = "12gauge",
				bonus = 1,
			},
		},
		{
			id = "SP07",
			name = "A Safer Yard",
			kind = "tracker",
			requires = {"SP05"},
			briefing = "Mutants on the routes. The job is to clear them, not to chase a trophy into another pack.",
			completion = "You've cleared enough trouble for now. Keep watching where the others go.",
			target = 5,
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
			id = "SP08",
			name = "The Displaced Pack",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SP06"},
			briefing = "Recover observations from a second hunting ground.",
			completion = "Where you found it is marked? Good.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "The Displaced Pack - Tied Leather Journal",
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
			id = "SP09",
			name = "Different Quarry",
			kind = "delivery",
			requires = {"SP07"},
			briefing = "Bring what's listed here. Keep it in good condition; I need to examine it.",
			completion = "That will be useful.",
			requirements = {
				{
					pool = "common_parts",
					quantity = 1,
				},
			},
			benefits = {
				items = {
					{
						item = "12gauge",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "SP10",
			name = "Tracks in the Wrong Place",
			kind = "field",
			objective = "Recover Numbered Data Module 0013 from the assigned search area in Garbage. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"SP08"},
			briefing = "Collect a recorder along a disturbed regional route.",
			completion = "Let me look at the observations.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_module",
				label = "Tracks in the Wrong Place - Numbered Data Module 0013",
			},
			benefits = {
				items = {
					{
						item = "22lr",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "SP11",
			name = "Patient Work",
			kind = "tracker",
			requires = {"SP09"},
			briefing = "Mutants on the routes. The job is to clear them, not to chase a trophy into another pack.",
			completion = "You've cleared enough trouble for now. Keep watching where the others go.",
			target = 9,
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
			id = "SP12",
			name = "The Empty Hide",
			kind = "field",
			objective = "Recover Personnel File Folder from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SP10"},
			briefing = "Recover a hunter's case at a remote observation site.",
			completion = "Set it here. I'll compare the records.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_personnel",
				label = "The Empty Hide - Personnel File Folder",
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
			id = "SP13",
			name = "Proof of Change",
			kind = "delivery",
			requires = {"SP11"},
			briefing = "Bring what's listed here. Keep it in good condition; I need to examine it.",
			completion = "Let me check the condition.",
			requirements = {
				{
					pool = "common_parts",
					quantity = 2,
				},
			},
			benefits = {
				items = {
					{
						item = "12gauge",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "SP14",
			name = "The Pattern Breaks",
			kind = "field",
			objective = "Recover Numbered Data Module 0022 from the assigned search area in Waystation. Deliver it to"
				.. " 'Atlas' in Marsh, then return here to finish the assignment.",
			requires = {"SP12"},
			briefing = "Retrieve a survey recorder in Waystation territory.",
			completion = "Good. They have the record. Now we can compare what was actually found.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_module2",
				label = "The Pattern Breaks - Numbered Data Module 0022",
				recipient = "atlas",
			},
			benefits = {
				items = {
					{
						item = "22lr",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "SP15",
			name = "No Easy Quarry",
			kind = "tracker",
			requires = {"SP13"},
			briefing = "Mutants on the routes. The job is to clear them, not to chase a trophy into another pack.",
			completion = "You've cleared enough trouble for now. Keep watching where the others go.",
			target = 14,
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
			id = "SP16",
			name = "The First Pripyat Trail",
			kind = "field",
			objective = "Recover Scientist's Field Diary from the assigned search area in Pripyat. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SP14"},
			briefing = "Recover an observer's notebook at a Pripyat hunting site.",
			completion = "Let me look at the observations.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_diary",
				label = "The First Pripyat Trail - Scientist's Field Diary",
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
			id = "SP17",
			name = "Preparing for the Worst",
			kind = "delivery",
			requires = {"SP15"},
			briefing = "Bring what's listed here. Keep it in good condition; I need to examine it.",
			completion = "Good. Keep it out of the sun.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 5,
				},
			},
			benefits = {
				items = {
					{
						item = "12gauge",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "SP18",
			name = "The Survivor's Cache",
			kind = "field",
			objective = "Recover Striped Equipment Case from the assigned search area in Pripyat. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SP16"},
			briefing = "Recover a hunter's abandoned case deeper in Pripyat.",
			completion = "Set it here. I'll compare the records.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_equipment",
				label = "The Survivor's Cache - Striped Equipment Case",
			},
			benefits = {
				items = {
					{
						item = "22lr",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "SP19",
			name = "The Dangerous Ones",
			kind = "tracker",
			requires = {"SP17", "SP18"},
			briefing = "Mutants on the routes. The job is to clear them, not to chase a trophy into another pack.",
			completion = "You've cleared enough trouble for now. Keep watching where the others go.",
			target = 20,
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
			id = "SP20",
			name = "The Last Observation",
			kind = "field",
			objective = "Recover Blue-Label Audio Cassette from the assigned search area in Pripyat. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"SP19"},
			briefing = "Retrieve the target species' observation recorder in Pripyat.",
			completion = "Where you found it is marked? Good.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_tape2",
				label = "The Last Observation - Blue-Label Audio Cassette",
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
			stock = {
				item = "12gauge",
				bonus = 2,
			},
		},
		{
			id = "SP21",
			name = "What the Records Missed",
			kind = "delivery",
			requires = {"SP20"},
			briefing = "Bring what's listed here. Keep it in good condition; I need to examine it.",
			completion = "That will be useful.",
			requirements = {
				{
					pool = "common_parts",
					quantity = 2,
				},
			},
			benefits = {
				items = {
					{
						item = "12gauge",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "SP22",
			name = "The Hunter's Proof",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SP21"},
			briefing = "Recover the final hunting observations in Pripyat.",
			completion = "Let me look at the observations.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_notebook",
				label = "The Hunter's Proof - Tied Leather Journal",
			},
			benefits = {
				items = {
					{
						item = "22lr",
						data = {
							quantity = 1,
						},
					},
				},
			},
			recognition = "Spoor's trusted contact",
		},
	},
})
