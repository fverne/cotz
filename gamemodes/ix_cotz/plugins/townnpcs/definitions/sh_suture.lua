PLUGIN:Register("suture", {
	name = "'Suture'",
	template = "suturenpc",
	map = "rp_waystation",
	job = {
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		category = "Textile supply deliveries",
		description = "Textile supply deliveries",
		pools = {"town_textiles"},
		quantities = {2, 4, 7},
		maps = {
			easy = "rp_waystation",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	dialogue = {
		completedGreeting = "It fits. It holds. Now try bringing it back that way.",
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = "Repair and carrying supplies. Bring what's on the list; I'll check what is fit to use.",
		progressionPrompt = "What else needs doing?",
		progression = (
			"There are materials to collect and fitting records to recover. Show me which job you're "
			.. "considering."
		),
	},
	catalogue = {
		["backpack_sling"] = {step = "SU03", terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_tourist"] = {step = "SU09", terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_vkbo"] = {step = "SU15", terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_1_large"] = {step = "SU19", terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "SU01",
			name = "A Bench and a Needle",
			kind = "delivery",
			requires = {},
			briefing = "Bring the supplies listed here. Let me check the condition before putting them to use.",
			completion = "Let me check it for damage first.",
			requirements = {
				{
					pool = "town_textiles",
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
			id = "SU02",
			name = "The Missing Pattern",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"SU01"},
			briefing = "Recover a workshop pattern case in Waystation territory.",
			completion = "Keep it together. I want to see how it was packed.",
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
			id = "SU03",
			name = "Seams That Hold",
			kind = "tracker",
			requires = {"SU02"},
			briefing = "Repair and carrying supplies. Bring what's on the list; I'll check what is fit to use.",
			completion = "You've kept the materials coming. I have something worth working with now.",
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
			id = "SU04",
			name = "A Broken Strap",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"SU03"},
			briefing = "Recover a freight worker's equipment case.",
			completion = "Let me look at the measurements.",
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
			id = "SU05",
			name = "Cloth for the Weather",
			kind = "delivery",
			requires = {"SU04"},
			briefing = "Bring the supplies listed here. Let me check the condition before putting them to use.",
			completion = "Yes, I can use this.",
			requirements = {
				{
					pool = "town_textiles",
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
			id = "SU06",
			name = "The Forgotten Measurements",
			kind = "field",
			objective = (
				"Deploy the recorder at the marked site, remain in range until it finishes, and collect it "
				.. "in Waystation. Return to this contact to finish the assignment."
			),
			requires = {"SU04"},
			briefing = "Retrieve a fitting record at a regional workshop.",
			completion = "Thank you. I'll examine it at the bench.",
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
			id = "SU07",
			name = "A Proper Fit",
			kind = "tracker",
			requires = {"SU05"},
			briefing = "Repair and carrying supplies. Bring what's on the list; I'll check what is fit to use.",
			completion = "You've kept the materials coming. I have something worth working with now.",
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
			id = "SU08",
			name = "The Workshop Scrapbook",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"SU06"},
			briefing = "Recover materials notes in Garbage.",
			completion = "Keep it together. I want to see how it was packed.",
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
			id = "SU09",
			name = "Load Before Luxury",
			kind = "delivery",
			requires = {"SU07"},
			briefing = "Bring the supplies listed here. Let me check the condition before putting them to use.",
			completion = "Good. Set it on the clean side of the table.",
			requirements = {
				{
					pool = "town_textiles",
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
			id = "SU10",
			name = "The Loaded Pack",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"SU08"},
			briefing = "Retrieve a field-test recorder along a freight route.",
			completion = "Let me look at the measurements.",
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
			id = "SU11",
			name = "Built to Last",
			kind = "tracker",
			requires = {"SU09"},
			briefing = "Repair and carrying supplies. Bring what's on the list; I'll check what is fit to use.",
			completion = "You've kept the materials coming. I have something worth working with now.",
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
			id = "SU12",
			name = "The Quartermaster's Specification",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"SU10"},
			briefing = "Recover an equipment specification at a remote supply site.",
			completion = "Thank you. I'll examine it at the bench.",
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
			id = "SU13",
			name = "More Than Canvas",
			kind = "delivery",
			requires = {"SU11"},
			briefing = "Bring the supplies listed here. Let me check the condition before putting them to use.",
			completion = "Let me check it for damage first.",
			requirements = {
				{
					pool = "town_textiles",
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
			id = "SU14",
			name = "The Failed Seam",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"SU12"},
			briefing = "Recover a damaged trial case in regional ruins.",
			completion = "Keep it together. I want to see how it was packed.",
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
			id = "SU15",
			name = "Work Under Weight",
			kind = "tracker",
			requires = {"SU13"},
			briefing = "Repair and carrying supplies. Bring what's on the list; I'll check what is fit to use.",
			completion = "You've kept the materials coming. I have something worth working with now.",
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
			id = "SU16",
			name = "The Long Expedition's Kit",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"SU14"},
			briefing = "Recover an expedition equipment record in Waystation territory.",
			completion = "Let me look at the measurements.",
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
			id = "SU17",
			name = "Weather and Fallout",
			kind = "delivery",
			requires = {"SU15"},
			briefing = "Bring the supplies listed here. Let me check the condition before putting them to use.",
			completion = "Yes, I can use this.",
			requirements = {
				{
					pool = "town_textiles",
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
			id = "SU18",
			name = "The Pripyat Trial",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"SU16"},
			briefing = "Retrieve an outfitting test recorder in Pripyat.",
			completion = "Thank you. I'll examine it at the bench.",
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
			id = "SU19",
			name = "No Loose Ends",
			kind = "tracker",
			requires = {"SU17"},
			briefing = "Repair and carrying supplies. Bring what's on the list; I'll check what is fit to use.",
			completion = "You've kept the materials coming. I have something worth working with now.",
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
			id = "SU20",
			name = "The Missing Outfitter",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"SU18"},
			briefing = "Recover a field fitter's personal case in Pripyat.",
			completion = "Keep it together. I want to see how it was packed.",
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
			id = "SU21",
			name = "Final Fittings",
			kind = "delivery",
			requires = {"SU19", "SU20"},
			briefing = "Bring the supplies listed here. Let me check the condition before putting them to use.",
			completion = "Good. Set it on the clean side of the table.",
			requirements = {
				{
					pool = "town_textiles",
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
			id = "SU22",
			name = "The Return Journey Test",
			kind = "field",
			objective = (
				"Deploy the recorder at the marked site, remain in range until it finishes, and collect it "
				.. "in Waystation. Return to this contact to finish the assignment."
			),
			requires = {"SU21"},
			briefing = "Deploy and retrieve a equipment recorder along an expedition route.",
			completion = "Let me look at the measurements.",
			field = {
				kind = "sensor",
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
			stock = {
				item = "drink_bottlewater",
				bonus = 2,
			},
		},
		{
			id = "SU23",
			name = "Fit for the Journey",
			kind = "tracker",
			requires = {"SU22"},
			briefing = "Repair and carrying supplies. Bring what's on the list; I'll check what is fit to use.",
			completion = "You've kept the materials coming. I have something worth working with now.",
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
			id = "SU24",
			name = "The Outfitter's Pattern",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"SU23"},
			briefing = "Recover the final expedition pattern and finish the project.",
			completion = "Thank you. I'll examine it at the bench.",
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
			recognition = "Suture's trusted contact",
		},
	},
	unlocks = {
		{
			step = "SU03",
			item = "backpack_sling",
			previous = "",
		},
		{
			step = "SU09",
			item = "backpack_tourist",
			previous = "backpack_sling",
		},
		{
			step = "SU15",
			item = "backpack_vkbo",
			previous = "backpack_tourist",
		},
		{
			step = "SU19",
			item = "backpack_1_large",
			previous = "backpack_vkbo",
		},
	},
})
