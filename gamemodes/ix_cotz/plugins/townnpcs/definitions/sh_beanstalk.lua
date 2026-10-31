PLUGIN:Register("beanstalk", {
	name = "'Beanstalk'",
	template = "ecologistnpc2",
	map = "mz_garbage",
	access = {contact = "smartass", step = "SM07"},
	job = {
		kind = "defence",
		category = "Research defence",
		description = "Research defence",
		pools = {"filters", "documents_research"},
		quantities = {5, 9, 15},
		maps = {
			easy = "mz_garbage",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	dialogue = {
		completedGreeting = "This agrees with the control. Finally, something we can both stand behind.",
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Keep the sampler intact until it finishes, then bring me the results. Stay close enough to "
			.. "protect it."
		),
		progressionPrompt = "What else needs doing?",
		progression = (
			"There are supplies to collect and controls to check. We need the comparison before we can "
			.. "trust the result."
		),
	},
	progression = {
		{
			id = "BN01",
			name = "A Station in the Dust",
			kind = "delivery",
			requires = {},
			briefing = "These are the supplies I need for the work. Keep them separate from anything contaminated.",
			completion = "Put it on the clear tray.",
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
			id = "BN02",
			name = "The First Baseline",
			kind = "field",
			objective = (
				"Start the sampler, defend it until it finishes, and collect the results in Garbage. Return "
				.. "to this contact to finish the assignment."
			),
			requires = {"BN01"},
			briefing = "Defend a sampler at a Garbage contamination site.",
			completion = "Give me the record before it gets mixed in with the others.",
			field = {
				kind = "defence",
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
			id = "BN03",
			name = "Results That Survive",
			kind = "tracker",
			requires = {"BN02"},
			briefing = (
				"Keep the sampler intact until it finishes, then bring me the results. Stay close enough to "
				.. "protect it."
			),
			completion = "You've brought back a useful set of results. Please keep using the same care.",
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
			id = "BN04",
			name = "The Buried Meter",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"BN03"},
			briefing = "Recover a lost instrument case at a dump.",
			completion = "Good. I'll compare it with the control.",
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
			id = "BN05",
			name = "Keeping It Sealed",
			kind = "delivery",
			requires = {"BN03"},
			briefing = "These are the supplies I need for the work. Keep them separate from anything contaminated.",
			completion = "Thank you. I'll check it before use.",
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
			id = "BN06",
			name = "Two Sides of the Heap",
			kind = "field",
			objective = (
				"Deploy the recorder at the marked site, remain in range until it finishes, and collect it "
				.. "in Garbage. Return to this contact to finish the assignment."
			),
			requires = {"BN04"},
			briefing = "Recover the dump comparison record.",
			completion = "Carefully, please. That still needs checking.",
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
			id = "BN07",
			name = "A Consistent Sample",
			kind = "tracker",
			requires = {"BN05"},
			briefing = (
				"Keep the sampler intact until it finishes, then bring me the results. Stay close enough to "
				.. "protect it."
			),
			completion = "You've brought back a useful set of results. Please keep using the same care.",
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
			id = "BN08",
			name = "Vesper's Reading",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"BN06"},
			briefing = "Recover a disputed recorder from an anomaly approach.",
			completion = "Give me the record before it gets mixed in with the others.",
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
			id = "BN09",
			name = "Clean Instruments",
			kind = "delivery",
			requires = {"BN07"},
			briefing = "These are the supplies I need for the work. Keep them separate from anything contaminated.",
			completion = "Good. Keep the packaging with it.",
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
			id = "BN10",
			name = "The Control Site",
			kind = "field",
			objective = (
				"Start the sampler, defend it until it finishes, and collect the results in Garbage. Return "
				.. "to this contact to finish the assignment."
			),
			requires = {"BN08"},
			briefing = "Defend a sampler away from the contested field.",
			completion = "Good. I'll compare it with the control.",
			field = {
				kind = "defence",
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
			id = "BN11",
			name = "Enough to Compare",
			kind = "tracker",
			requires = {"BN09"},
			briefing = (
				"Keep the sampler intact until it finishes, then bring me the results. Stay close enough to "
				.. "protect it."
			),
			completion = "You've brought back a useful set of results. Please keep using the same care.",
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
			id = "BN12",
			name = "The Dirty Filter",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"BN10"},
			briefing = "Retrieve a field station's exposure record.",
			completion = "Carefully, please. That still needs checking.",
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
			id = "BN13",
			name = "A Field Lab in Reserve",
			kind = "delivery",
			requires = {"BN11"},
			briefing = "These are the supplies I need for the work. Keep them separate from anything contaminated.",
			completion = "Put it on the clear tray.",
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
			id = "BN14",
			name = "Beyond the Dumps",
			kind = "field",
			objective = (
				"Start the sampler, defend it until it finishes, and collect the results in Garbage. Return "
				.. "to this contact to finish the assignment."
			),
			requires = {"BN12"},
			briefing = "Defend a sampler at a regional industrial site.",
			completion = "Give me the record before it gets mixed in with the others.",
			field = {
				kind = "defence",
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
			id = "BN15",
			name = "Work Under Pressure",
			kind = "tracker",
			requires = {"BN13"},
			briefing = (
				"Keep the sampler intact until it finishes, then bring me the results. Stay close enough to "
				.. "protect it."
			),
			completion = "You've brought back a useful set of results. Please keep using the same care.",
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
			id = "BN16",
			name = "The Contradictory Result",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"BN14"},
			briefing = "Recover a second control recorder in Waystation territory.",
			completion = "Good. I'll compare it with the control.",
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
			id = "BN17",
			name = "Preparing the Comparison",
			kind = "delivery",
			requires = {"BN15"},
			briefing = "These are the supplies I need for the work. Keep them separate from anything contaminated.",
			completion = "Thank you. I'll check it before use.",
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
			id = "BN18",
			name = "Pripyat Baseline",
			kind = "field",
			objective = (
				"Start the sampler, defend it until it finishes, and collect the results in Pripyat. Return "
				.. "to this contact to finish the assignment."
			),
			requires = {"BN16"},
			briefing = "Defend a sampler at a Pripyat contamination site.",
			completion = "Carefully, please. That still needs checking.",
			field = {
				kind = "defence",
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
			id = "BN19",
			name = "Holding the Site",
			kind = "tracker",
			requires = {"BN17", "BN18"},
			briefing = (
				"Keep the sampler intact until it finishes, then bring me the results. Stay close enough to "
				.. "protect it."
			),
			completion = "You've brought back a useful set of results. Please keep using the same care.",
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
			id = "BN20",
			name = "The Abandoned Station",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"BN19"},
			briefing = "Recover an earlier team's recorder in Pripyat.",
			completion = "Give me the record before it gets mixed in with the others.",
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
			id = "BN21",
			name = "A Clean Comparison",
			kind = "delivery",
			requires = {"BN20"},
			briefing = "These are the supplies I need for the work. Keep them separate from anything contaminated.",
			completion = "Good. Keep the packaging with it.",
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
			id = "BN22",
			name = "The Last Control",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"BN21"},
			briefing = "Complete the final defended Pripyat recording.",
			completion = "Good. I'll compare it with the control.",
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
			id = "BN23",
			name = "Findings Worth Keeping",
			kind = "tracker",
			requires = {"BN22"},
			briefing = (
				"Keep the sampler intact until it finishes, then bring me the results. Stay close enough to "
				.. "protect it."
			),
			completion = "You've brought back a useful set of results. Please keep using the same care.",
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
			id = "BN24",
			name = "A Result They Both Accept",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"BN23"},
			briefing = "Recover missing control evidence and return the completed comparison.",
			completion = "Carefully, please. That still needs checking.",
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
			recognition = "Beanstalk's trusted contact",
		},
	},
})
