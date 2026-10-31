PLUGIN:Register("egghead", {
	name = "'Egghead'",
	template = "ecologistnpc",
	map = "rp_waystation",
	access = {contact = "smartass", step = "SM07"},
	job = {
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		category = "Artifact deliveries",
		description = "Artifact deliveries",
		pools = {"common_artifacts", "electrical_artifacts"},
		quantities = {2, 4, 7},
		maps = {
			easy = "rp_waystation",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	dialogue = {
		completedGreeting = (
			"A reference collection with context. "
			.. "That's considerably more useful than a shelf of curiosities."
		),
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = "Artifacts. Bring the specimens requested on the order; I need to make a comparison.",
		progressionPrompt = "What else needs doing?",
		progression = (
			"There are specimens to collect and old field records to check. Which would you like to help "
			.. "with?"
		),
	},
	catalogue = {
		["accesscard_laboratory"] = {step = "EG01",
			terms = {nil, 5, "SELLANDBUY", 5, 1, 5}},
		["detectorbear"] = {step = "EG11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["detectorecho"] = {step = "EG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["detectorveles"] = {step = "EG21",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_antipsychotic_2"] = {step = "EG09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_antipsychotic_3"] = {step = "EG13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_psyheal_2"] = {step = "EG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_stimpak_1"] = {step = "EG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_stimpak_2"] = {step = "EG11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_stimpak_3"] = {step = "EG15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["quest_computeraccess"] = {step = "EG01",
			terms = {nil, 5, "SELLANDBUY", 5, 1, 5}},
		["suit_seva"] = {step = "EG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_ssp99"] = {step = "EG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_ssp99m"] = {step = "EG05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "EG01",
			name = "A First Reference",
			kind = "delivery",
			requires = {},
			briefing = "Bring the material listed here. I'd like to check it before putting it with the others.",
			completion = "Thank you. I'll label these before they get mixed in.",
			requirements = {
				{
					pool = "common_artifacts",
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
			id = "EG02",
			name = "The Control Notebook",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"EG01"},
			briefing = "Recover a reference notebook near a regional field site.",
			completion = "Let's look at the record before deciding what it means.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
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
			id = "EG03",
			name = "A Useful Assistant",
			kind = "tracker",
			requires = {"EG02"},
			briefing = "Artifacts. Bring the specimens requested on the order; I need to make a comparison.",
			completion = "You've brought enough specimens for a useful comparison. Thank you for keeping at it.",
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
			id = "EG04",
			name = "The Old Field Station",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"EG03"},
			briefing = "Recover a calibration case in accessible regional territory.",
			completion = "Thank you. I'll keep that with the comparison material.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
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
			id = "EG05",
			name = "Different Origins",
			kind = "delivery",
			requires = {"EG04"},
			briefing = "Bring the material listed here. I'd like to check it before putting it with the others.",
			completion = "Good. Let me compare the condition.",
			requirements = {
				{
					pool = "common_artifacts",
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
			id = "EG06",
			name = "The Comparison Site",
			kind = "field",
			objective = (
				"Deploy the recorder at the marked site, remain in range until it finishes, and collect it "
				.. "in Waystation. Return to this contact to finish the assignment."
			),
			requires = {"EG04"},
			briefing = "Deploy and retrieve a recorder near an anomaly field.",
			completion = "Good. I can check this against the other records.",
			field = {
				kind = "sensor",
				map = "rp_waystation",
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
			id = "EG07",
			name = "An Orderly Collection",
			kind = "tracker",
			requires = {"EG05"},
			briefing = "Artifacts. Bring the specimens requested on the order; I need to make a comparison.",
			completion = "You've brought enough specimens for a useful comparison. Thank you for keeping at it.",
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
			id = "EG08",
			name = "The Missing Calibration",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"EG06"},
			briefing = "Recover a detector test record in Garbage.",
			completion = "Let's look at the record before deciding what it means.",
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
			id = "EG09",
			name = "A Reliable Reading",
			kind = "delivery",
			requires = {"EG07"},
			briefing = "Bring the material listed here. I'd like to check it before putting it with the others.",
			completion = "Yes, that's what I asked for.",
			requirements = {
				{
					pool = "common_artifacts",
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
			id = "EG10",
			name = "The Failed Trial",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"EG08"},
			briefing = "Retrieve a test recorder at a remote research site.",
			completion = "Thank you. I'll keep that with the comparison material.",
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
			id = "EG11",
			name = "A Better Instrument",
			kind = "tracker",
			requires = {"EG09"},
			briefing = "Artifacts. Bring the specimens requested on the order; I need to make a comparison.",
			completion = "You've brought enough specimens for a useful comparison. Thank you for keeping at it.",
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
			id = "EG12",
			name = "The Paired Samples",
			kind = "field",
			objective = (
				"Deploy the recorder at the marked site, remain in range until it finishes, and collect it "
				.. "in Waystation. Return to this contact to finish the assignment."
			),
			requires = {"EG10"},
			briefing = "Recover a comparison record from the field.",
			completion = "Good. I can check this against the other records.",
			field = {
				kind = "sensor",
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
			id = "EG13",
			name = "Protection for the Work",
			kind = "delivery",
			requires = {"EG11"},
			briefing = "Bring the material listed here. I'd like to check it before putting it with the others.",
			completion = "Thank you. I'll label these before they get mixed in.",
			requirements = {
				{
					pool = "electrical_artifacts",
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
			id = "EG14",
			name = "Beanstalk's Objection",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"EG12"},
			briefing = "Recover environmental control evidence in Garbage.",
			completion = "Let's look at the record before deciding what it means.",
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
			id = "EG15",
			name = "A Collection With Context",
			kind = "tracker",
			requires = {"EG13"},
			briefing = "Artifacts. Bring the specimens requested on the order; I need to make a comparison.",
			completion = "You've brought enough specimens for a useful comparison. Thank you for keeping at it.",
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
			id = "EG16",
			name = "The Archived Finding",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"EG14"},
			briefing = "Recover a research record for comparison with Carbon.",
			completion = "Thank you. I'll keep that with the comparison material.",
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
			id = "EG17",
			name = "Before Pripyat",
			kind = "delivery",
			requires = {"EG15"},
			briefing = "Bring the material listed here. I'd like to check it before putting it with the others.",
			completion = "Good. Let me compare the condition.",
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
			id = "EG18",
			name = "The Pripyat Baseline",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"EG16"},
			briefing = "Recover an earlier research team's recorder in Pripyat.",
			completion = "Good. I can check this against the other records.",
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
		},
		{
			id = "EG19",
			name = "Results That Repeat",
			kind = "tracker",
			requires = {"EG17"},
			briefing = "Artifacts. Bring the specimens requested on the order; I need to make a comparison.",
			completion = "You've brought enough specimens for a useful comparison. Thank you for keeping at it.",
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
			id = "EG20",
			name = "The Unfinished Experiment",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"EG18"},
			briefing = "Retrieve a calibration case at a second Pripyat site.",
			completion = "Let's look at the record before deciding what it means.",
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
			id = "EG21",
			name = "Precision at Last",
			kind = "delivery",
			requires = {"EG19", "EG20"},
			briefing = "Bring the material listed here. I'd like to check it before putting it with the others.",
			completion = "Yes, that's what I asked for.",
			requirements = {
				{
					pool = "common_artifacts",
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
			id = "EG22",
			name = "The Family Resemblance",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"EG21"},
			briefing = "Recover the final comparison recorder in Pripyat.",
			completion = "Thank you. I'll keep that with the comparison material.",
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
		},
		{
			id = "EG23",
			name = "A Complete Reference",
			kind = "tracker",
			requires = {"EG22"},
			briefing = "Artifacts. Bring the specimens requested on the order; I need to make a comparison.",
			completion = "You've brought enough specimens for a useful comparison. Thank you for keeping at it.",
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
			id = "EG24",
			name = "The Programme's Missing Page",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"EG23"},
			briefing = "Recover a final archived research record.",
			completion = "Good. I can check this against the other records.",
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
			stock = {
				item = "drink_bottlewater",
				bonus = 2,
			},
		},
		{
			id = "EG25",
			name = "Preserve the Findings",
			kind = "delivery",
			requires = {"EG24"},
			briefing = "Bring the material listed here. I'd like to check it before putting it with the others.",
			completion = "Thank you. I'll label these before they get mixed in.",
			requirements = {
				{
					pool = "administrative_documents",
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
			id = "EG26",
			name = "The Last Control Record",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"EG25"},
			briefing = "Recover the final field control and return the complete programme.",
			completion = "Let's look at the record before deciding what it means.",
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
			recognition = "Egghead's trusted contact",
		},
	},
})
