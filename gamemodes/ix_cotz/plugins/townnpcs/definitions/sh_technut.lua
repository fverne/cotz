PLUGIN:Register("technut", {
	name = "'Technut'",
	template = "technpc",
	map = "rp_marsh_cs",
	job = {
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		category = "Industrial salvage deliveries",
		description = "Industrial salvage deliveries",
		pools = {"fasteners", "basic_tools", "workshop_supplies"},
		quantities = {2, 4, 7},
		maps = {
			easy = "rp_marsh_cs",
			medium = "mz_garbage",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	dialogue = {
		completedGreeting = (
			"You've brought back enough for me to get on with the work, buddy. What else have you "
			.. "found?"
		),
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = "Workshop tools and mechanical parts, buddy. Mute can have the loose circuit boards.",
		progressionPrompt = "What else needs doing?",
		progression = (
			"I've got several things on the bench. Some need parts; some need somebody willing to go and "
			.. "find the paperwork."
		),
	},
	catalogue = {
		["attachment_aluframe"] = {step = "TN15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["attachment_carbonfibre"] = {step = "TN15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["attachment_ceramicplate_1"] = {step = "TN01",
			terms = {nil, 1, "SELLANDBUY", 1, 3, 1}},
		["attachment_ceramicplate_2"] = {step = "TN15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["attachment_ceramicplate_3"] = {step = "TN19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["attachment_fabric_1"] = {step = "TN01",
			terms = {nil, 1, "SELLANDBUY", 1, 3, 1}},
		["attachment_fabric_2"] = {step = "TN13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["attachment_kevlar_1"] = {step = "TN13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["attachment_kevlar_2"] = {step = "TN15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["attachment_steelframe"] = {step = "TN17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["attachment_steelplate_1"] = {step = "TN01",
			terms = {nil, 1, "SELLANDBUY", 1, 3, 1}},
		["attachment_steelplate_2"] = {step = "TN13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["attachment_steelplate_3"] = {step = "TN17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["headwear_cs1"] = {step = "TN09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["headwear_cs2"] = {step = "TN13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["headwear_cs4"] = {step = "TN13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["headwear_psz12"] = {step = "TN17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["helm_operator_nato"] = {step = "TN21",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["helm_operator_rus_1"] = {step = "TN11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["helm_operator_rus_2"] = {step = "TN11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["helm_sphere08"] = {step = "TN15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["helm_sphere12"] = {step = "TN19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["helm_steel_arab"] = {step = "TN07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["helm_steel_ger"] = {step = "TN07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["helm_steel_rus"] = {step = "TN07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mask_eo20"] = {step = "TN05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mask_gp5"] = {step = "TN03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mask_halfmask"] = {step = "TN01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mask_m40"] = {step = "TN11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mask_m50"] = {step = "TN13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mask_pmk3"] = {step = "TN07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mask_respirator"] = {step = "TN01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mask_xm40"] = {step = "TN09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_cs1"] = {step = "TN07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_cs2"] = {step = "TN11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_cs3"] = {step = "TN13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_mailjacket"] = {step = "TN01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_nbc"] = {step = "TN07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_sunrise"] = {step = "TN05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_trenchcoat_black"] = {step = "TN03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_trenchcoat_brown"] = {step = "TN03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_trenchcoat_green"] = {step = "TN03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_trenchcoat_tan"] = {step = "TN03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_wind"] = {step = "TN09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "TN01",
			name = "A Bench to Work On",
			kind = "delivery",
			requires = {},
			briefing = (
				"These are the supplies I'm missing, buddy. Bring them to the bench and I can get on with "
				.. "it."
			),
			completion = "Yes! That's the bit I needed.",
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
			id = "TN02",
			name = "The Missing Toolbox",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"TN01"},
			briefing = "Recover a Marsh workshop case.",
			completion = "Oh, let me see! Mind the oil on the bench.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
			},
			benefits = {
				services = {
					{
						npc = "'Technut'",
						service = "repair",
						amount = 500,
					},
				},
			},
		},
		{
			id = "TN03",
			name = "Keeping Busy",
			kind = "tracker",
			requires = {"TN02"},
			briefing = "Workshop tools and mechanical parts, buddy. Mute can have the loose circuit boards.",
			completion = (
				"You've kept the workshop supplied. Makes a pleasant change from taking something else apart "
				.. "for spares."
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
			id = "TN04",
			name = "A Regulator for Gasket",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"TN03"},
			briefing = "Recover a regulator from a utility service cache.",
			completion = "You found it! Let's see what we've got.",
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
			id = "TN05",
			name = "Something Accurate",
			kind = "delivery",
			requires = {"TN04"},
			briefing = (
				"These are the supplies I'm missing, buddy. Bring them to the bench and I can get on with "
				.. "it."
			),
			completion = "Put it on the clear end of the bench. There is one, I promise.",
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
			id = "TN06",
			name = "The Misaligned Jig",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"TN04"},
			briefing = "Retrieve a workshop calibration record.",
			completion = "Careful with the case, buddy. I want to open it myself.",
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
			id = "TN07",
			name = "Reliable Parts",
			kind = "tracker",
			requires = {"TN05"},
			briefing = "Workshop tools and mechanical parts, buddy. Mute can have the loose circuit boards.",
			completion = (
				"You've kept the workshop supplied. Makes a pleasant change from taking something else apart "
				.. "for spares."
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
			id = "TN08",
			name = "An Engineer's Notes",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"TN06"},
			briefing = "Recover machinery notes in Garbage.",
			completion = "Oh, let me see! Mind the oil on the bench.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
			},
			benefits = {
				services = {
					{
						npc = "'Technut'",
						service = "repair",
						amount = 500,
					},
				},
			},
		},
		{
			id = "TN09",
			name = "Steel and Seals",
			kind = "delivery",
			requires = {"TN07"},
			briefing = (
				"These are the supplies I'm missing, buddy. Bring them to the bench and I can get on with "
				.. "it."
			),
			completion = "Good condition, too. I can work with this.",
			requirements = {
				{
					pool = "workshop_supplies",
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
			id = "TN10",
			name = "Latch's Find",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"TN08"},
			briefing = "Recover an identification plate from industrial wreckage.",
			completion = "You found it! Let's see what we've got.",
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
			id = "TN11",
			name = "Proper Workshop",
			kind = "tracker",
			requires = {"TN09"},
			briefing = "Workshop tools and mechanical parts, buddy. Mute can have the loose circuit boards.",
			completion = (
				"You've kept the workshop supplied. Makes a pleasant change from taking something else apart "
				.. "for spares."
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
			discounts = {{npc = "'Technut'", service = "repair", fraction = 0.05}},
		},
		{
			id = "TN12",
			name = "The Precision Crate",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"TN10"},
			briefing = "Recover a tool case in Garbage.",
			completion = "Careful with the case, buddy. I want to open it myself.",
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
			id = "TN13",
			name = "A Better Fit",
			kind = "delivery",
			requires = {"TN11"},
			briefing = (
				"These are the supplies I'm missing, buddy. Bring them to the bench and I can get on with "
				.. "it."
			),
			completion = "Yes! That's the bit I needed.",
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
			id = "TN14",
			name = "Patterns in Metal",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"TN12"},
			briefing = "Retrieve an assembly drawing at a regional workshop.",
			completion = "Oh, let me see! Mind the oil on the bench.",
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
			id = "TN15",
			name = "More Than a Patch",
			kind = "tracker",
			requires = {"TN13"},
			briefing = "Workshop tools and mechanical parts, buddy. Mute can have the loose circuit boards.",
			completion = (
				"You've kept the workshop supplied. Makes a pleasant change from taking something else apart "
				.. "for spares."
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
			id = "TN16",
			name = "The Missing Technician",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"TN14"},
			briefing = "Recover a technician's recorder near an abandoned workshop.",
			completion = "You found it! Let's see what we've got.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
			},
			benefits = {
				services = {
					{
						npc = "'Technut'",
						service = "repair",
						amount = 500,
					},
				},
			},
		},
		{
			id = "TN17",
			name = "Instrument Grade",
			kind = "delivery",
			requires = {"TN15"},
			briefing = (
				"These are the supplies I'm missing, buddy. Bring them to the bench and I can get on with "
				.. "it."
			),
			completion = "Put it on the clear end of the bench. There is one, I promise.",
			requirements = {
				{
					pool = "basic_tools",
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
			id = "TN18",
			name = "The Test Assembly",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"TN16"},
			briefing = "Recover a test assembly case in Waystation territory.",
			completion = "Careful with the case, buddy. I want to open it myself.",
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
			id = "TN19",
			name = "Holding Together",
			kind = "tracker",
			requires = {"TN17"},
			briefing = "Workshop tools and mechanical parts, buddy. Mute can have the loose circuit boards.",
			completion = (
				"You've kept the workshop supplied. Makes a pleasant change from taking something else apart "
				.. "for spares."
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
			id = "TN20",
			name = "The Damaged Register",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"TN18"},
			briefing = "Recover equipment-service records from a remote facility.",
			completion = "Oh, let me see! Mind the oil on the bench.",
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
			id = "TN21",
			name = "A Workshop in Reserve",
			kind = "delivery",
			requires = {"TN19"},
			briefing = (
				"These are the supplies I'm missing, buddy. Bring them to the bench and I can get on with "
				.. "it."
			),
			completion = "Good condition, too. I can work with this.",
			requirements = {
				{
					pool = "workshop_supplies",
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
			id = "TN22",
			name = "The Machine's Origin",
			kind = "field",
			objective = (
				"Deploy the recorder at the marked site, remain in range until it finishes, and collect it "
				.. "in Pripyat. Return to this contact to finish the assignment."
			),
			requires = {"TN20"},
			briefing = "Retrieve a manufacturing record at a Pripyat industrial site.",
			completion = "You found it! Let's see what we've got.",
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
			id = "TN23",
			name = "Precision Work",
			kind = "tracker",
			requires = {"TN21", "TN22"},
			briefing = "Workshop tools and mechanical parts, buddy. Mute can have the loose circuit boards.",
			completion = (
				"You've kept the workshop supplied. Makes a pleasant change from taking something else apart "
				.. "for spares."
			),
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
			id = "TN24",
			name = "The Last Component",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"TN23"},
			briefing = "Recover the restoration machine's final case in Pripyat.",
			completion = "Careful with the case, buddy. I want to open it myself.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
			},
			benefits = {
				services = {
					{
						npc = "'Technut'",
						service = "repair",
						amount = 500,
					},
				},
			},
		},
		{
			id = "TN25",
			name = "Ready to Rebuild",
			kind = "delivery",
			requires = {"TN24"},
			briefing = (
				"These are the supplies I'm missing, buddy. Bring them to the bench and I can get on with "
				.. "it."
			),
			completion = "Yes! That's the bit I needed.",
			requirements = {
				{
					pool = "fasteners",
					quantity = 7,
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
			discounts = {{npc = "'Technut'", service = "repair", fraction = 0.1}},
		},
		{
			id = "TN26",
			name = "A Test Under Load",
			kind = "field",
			objective = (
				"Deploy the recorder at the marked site, remain in range until it finishes, and collect it "
				.. "in Marsh. Return to this contact to finish the assignment."
			),
			requires = {"TN25"},
			briefing = "Deploy and retrieve a test recorder at the machinery survey site.",
			completion = "Oh, let me see! Mind the oil on the bench.",
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
			stock = {
				item = "drink_bottlewater",
				bonus = 2,
			},
		},
		{
			id = "TN27",
			name = "It Runs Again",
			kind = "tracker",
			requires = {"TN26"},
			briefing = "Workshop tools and mechanical parts, buddy. Mute can have the loose circuit boards.",
			completion = (
				"You've kept the workshop supplied. Makes a pleasant change from taking something else apart "
				.. "for spares."
			),
			target = 35,
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
			id = "TN28",
			name = "The Engineer's Signature",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"TN27"},
			briefing = "Recover the machine's commissioning record and finish the restoration.",
			completion = "You found it! Let's see what we've got.",
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
			recognition = "Technut's trusted contact",
		},
	},
})
