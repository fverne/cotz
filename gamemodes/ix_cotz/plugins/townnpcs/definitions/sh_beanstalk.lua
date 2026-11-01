PLUGIN:Register("beanstalk", {
	name = "'Beanstalk'",
	template = "ecologistnpc2",
	map = "mz_garbage",
	access = {contact = "smartass", step = "SM07"},
	job = {
		kind = "defence",
		category = "Research defence",
		description = "Research defence",
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
	catalogue = {
		["medic_psyheal_1"] = {step = "BN01",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["medic_antipsychotic_1"] = {step = "BN07",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["medic_antipsychotic_2"] = {step = "BN09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_antipsychotic_3"] = {step = "BN13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_psyheal_2"] = {step = "BN03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_stimpak_1"] = {step = "BN07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_stimpak_2"] = {step = "BN11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_stimpak_3"] = {step = "BN15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mask_eo20"] = {step = "BN09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mask_pmk3"] = {step = "BN11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_nbc"] = {step = "BN14",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_ssp99"] = {step = "BN10",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "BN01",
			completionCash = 275,
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
			completionCash = 450,
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
			benefits = {},
		},
		{
			id = "BN03",
			completionCash = 0,
			name = "Results That Survive",
			kind = "tracker",
			requires = {"BN02"},
			briefing = (
				"Keep the sampler intact until it finishes, then bring me the results. Stay close enough to "
				.. "protect it."
			),
			completion = "You've brought back a useful set of results. Please keep using the same care.",
			target = 2,
			benefits = {},
		},
		{
			id = "BN04",
			completionCash = 650,
			name = "The Buried Meter",
			kind = "field",
			objective = "Recover Red-Trimmed Control Unit from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"BN03"},
			briefing = "Recover a lost instrument case at a dump.",
			completion = "Good. I'll compare it with the control.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_control",
				label = "The Buried Meter - Red-Trimmed Control Unit",
			},
			benefits = {},
		},
		{
			id = "BN05",
			completionCash = 575,
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
			benefits = {},
		},
		{
			id = "BN06",
			completionCash = 850,
			name = "Two Sides of the Heap",
			kind = "field",
			objective = "Recover Laboratory Log Folder from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"BN04"},
			briefing = "Recover the dump comparison record.",
			completion = "Carefully, please. That still needs checking.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_lab",
				label = "Two Sides of the Heap - Laboratory Log Folder",
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
			completionCash = 0,
			name = "A Consistent Sample",
			kind = "tracker",
			requires = {"BN05"},
			briefing = (
				"Keep the sampler intact until it finishes, then bring me the results. Stay close enough to "
				.. "protect it."
			),
			completion = "You've brought back a useful set of results. Please keep using the same care.",
			target = 5,
			benefits = {},
		},
		{
			id = "BN08",
			completionCash = 1050,
			name = "Vesper's Reading",
			kind = "field",
			objective = "Recover Numbered Data Module 0013 from the assigned search area in Garbage. Deliver it to"
				.. " 'Vesper' in Garbage, then return here to finish the assignment.",
			requires = {"BN06"},
			briefing = "Recover a disputed recorder from an anomaly approach.",
			completion = "They have the record now. We can stop comparing results from memory.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_module",
				label = "Vesper's Reading - Numbered Data Module 0013",
				recipient = "vesper",
			},
			benefits = {},
		},
		{
			id = "BN09",
			completionCash = 875,
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
			benefits = {},
		},
		{
			id = "BN10",
			completionCash = 1250,
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
			benefits = {},
		},
		{
			id = "BN11",
			completionCash = 0,
			name = "Enough to Compare",
			kind = "tracker",
			requires = {"BN09"},
			briefing = (
				"Keep the sampler intact until it finishes, then bring me the results. Stay close enough to "
				.. "protect it."
			),
			completion = "You've brought back a useful set of results. Please keep using the same care.",
			target = 9,
			benefits = {},
		},
		{
			id = "BN12",
			completionCash = 1450,
			name = "The Dirty Filter",
			kind = "field",
			objective = "Recover Clinical Records Folder I from the assigned search area in Garbage. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"BN10"},
			briefing = "Retrieve a field station's exposure record.",
			completion = "Carefully, please. That still needs checking.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_clinic",
				label = "The Dirty Filter - Clinical Records Folder I",
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
			completionCash = 1175,
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
			benefits = {},
		},
		{
			id = "BN14",
			completionCash = 1650,
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
			benefits = {},
		},
		{
			id = "BN15",
			completionCash = 0,
			name = "Work Under Pressure",
			kind = "tracker",
			requires = {"BN13"},
			briefing = (
				"Keep the sampler intact until it finishes, then bring me the results. Stay close enough to "
				.. "protect it."
			),
			completion = "You've brought back a useful set of results. Please keep using the same care.",
			target = 14,
			benefits = {},
		},
		{
			id = "BN16",
			completionCash = 1850,
			name = "The Contradictory Result",
			kind = "field",
			objective = "Recover Numbered Data Module 0022 from the assigned search area in Waystation. Deliver it to"
				.. " 'Vesper' in Garbage, then return here to finish the assignment.",
			requires = {"BN14"},
			briefing = "Recover a second control recorder in Waystation territory.",
			completion = "They have the record now. We can stop comparing results from memory.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_module2",
				label = "The Contradictory Result - Numbered Data Module 0022",
				recipient = "vesper",
			},
			benefits = {},
		},
		{
			id = "BN17",
			completionCash = 1475,
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
			benefits = {},
		},
		{
			id = "BN18",
			completionCash = 2050,
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
			completionCash = 0,
			name = "Holding the Site",
			kind = "tracker",
			requires = {"BN17", "BN18"},
			briefing = (
				"Keep the sampler intact until it finishes, then bring me the results. Stay close enough to "
				.. "protect it."
			),
			completion = "You've brought back a useful set of results. Please keep using the same care.",
			target = 20,
			benefits = {},
		},
		{
			id = "BN20",
			completionCash = 2250,
			name = "The Abandoned Station",
			kind = "field",
			objective = "Recover Handwritten Audio Cassette from the assigned search area in Pripyat. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"BN19"},
			briefing = "Recover an earlier team's recorder in Pripyat.",
			completion = "Give me the record before it gets mixed in with the others.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_tape",
				label = "The Abandoned Station - Handwritten Audio Cassette",
			},
			benefits = {},
		},
		{
			id = "BN21",
			completionCash = 1775,
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
			benefits = {},
		},
		{
			id = "BN22",
			completionCash = 2450,
			name = "The Last Control",
			kind = "field",
			objective = "Recover Numbered Data Module 0013 from the assigned search area in Pripyat. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"BN21"},
			briefing = "Complete the final defended Pripyat recording.",
			completion = "Good. I'll compare it with the control.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module",
				label = "The Last Control - Numbered Data Module 0013",
			},
			benefits = {},
		},
		{
			id = "BN23",
			completionCash = 0,
			name = "Findings Worth Keeping",
			kind = "tracker",
			requires = {"BN22"},
			briefing = (
				"Keep the sampler intact until it finishes, then bring me the results. Stay close enough to "
				.. "protect it."
			),
			completion = "You've brought back a useful set of results. Please keep using the same care.",
			target = 27,
			benefits = {},
		},
		{
			id = "BN24",
			completionCash = 2650,
			name = "A Result They Both Accept",
			kind = "field",
			objective = "Recover Laboratory Log Folder from the assigned search area in Garbage. Deliver it to"
				.. " 'Carbon' in Waystation, then return here to finish the assignment.",
			requires = {"BN23"},
			briefing = "Recover missing control evidence and return the completed comparison.",
			completion = "They have the record now. We can stop comparing results from memory.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_lab",
				label = "A Result They Both Accept - Laboratory Log Folder",
				recipient = "carbon",
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
