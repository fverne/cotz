PLUGIN:Register("jitters", {
	name = "'Jitters'",
	template = "medicnpc",
	map = "rp_marsh_cs",
	job = {
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		category = "Medical supply deliveries",
		description = "Medical supply deliveries",
		pools = {"town_medical"},
		quantities = {2, 4, 7},
		maps = {
			easy = "rp_marsh_cs",
			medium = "mz_garbage",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"medic_bandage_1", "medic_medkit_1", "medic_antirad_1", "drug_painkillers"},
	dialogue = {
		completedGreeting = "A full cabinet. I might actually sleep tonight.",
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = "Medical supplies. The right ones, please. I can't dress a wound with whatever was cheapest.",
		progressionPrompt = "What else needs doing?",
		progression = (
			"I'm short of supplies. And there are field records I need before I can make sense of these "
			.. "exposure cases."
		),
	},
	catalogue = {
		["medic_antirad_1"] = {step = "JT09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_antirad_2"] = {step = "JT21",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_bandage_2"] = {step = "JT05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_bandage_3"] = {step = "JT13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_1"] = {step = "JT07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_2"] = {step = "JT11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_3"] = {step = "JT15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_4"] = {step = "JT17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_5"] = {step = "JT19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_6"] = {step = "JT23",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "JT01",
			name = "Clean Hands",
			kind = "delivery",
			requires = {},
			briefing = "I'm short of these. Check the list, and keep everything clean on the way here. Please.",
			completion = "Clean enough. Put it here.",
			requirements = {
				{
					pool = "town_medical",
					quantity = 2,
				},
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
			id = "JT02",
			name = "The Empty Cabinet",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"JT01"},
			briefing = "Recover a clinic inventory from a Marsh aid station.",
			completion = "Careful with that. I need to read it.",
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
			id = "JT03",
			name = "Keep the Shelves Filled",
			kind = "tracker",
			requires = {"JT02"},
			briefing = "Medical supplies. The right ones, please. I can't dress a wound with whatever was cheapest.",
			completion = "The deliveries have helped. I can stop counting the same shelf quite so often.",
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
			id = "JT04",
			name = "A Missing Bag",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"JT03"},
			briefing = "Recover a medic's abandoned case in Marsh.",
			completion = "You brought it back. Good. Give me a moment.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
			},
			benefits = {
				services = {
					{
						npc = "'Jitters'",
						service = "treatment",
						amount = 150,
					},
				},
			},
		},
		{
			id = "JT05",
			name = "A Proper Dressing",
			kind = "delivery",
			requires = {"JT03"},
			briefing = "I'm short of these. Check the list, and keep everything clean on the way here. Please.",
			completion = "Thank you. One less thing to run out of.",
			requirements = {
				{
					pool = "town_medical",
					quantity = 3,
				},
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
			id = "JT06",
			name = "The Exposure Log",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"JT04"},
			briefing = "Retrieve patient observations from a field shelter.",
			completion = "Leave it on the clean side of the desk, please.",
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
				item = "medic_bandage_1",
				bonus = 1,
			},
		},
		{
			id = "JT07",
			name = "A Steady Clinic",
			kind = "tracker",
			requires = {"JT05"},
			briefing = "Medical supplies. The right ones, please. I can't dress a wound with whatever was cheapest.",
			completion = "The deliveries have helped. I can stop counting the same shelf quite so often.",
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
			id = "JT08",
			name = "The Broken Instrument",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"JT06"},
			briefing = "Recover diagnostic equipment from a local supply site.",
			completion = "Careful with that. I need to read it.",
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
			discounts = {{npc = "'Jitters'", service = "treatment", fraction = 0.05}},
		},
		{
			id = "JT09",
			name = "Fever and Fallout",
			kind = "delivery",
			requires = {"JT07"},
			briefing = "I'm short of these. Check the list, and keep everything clean on the way here. Please.",
			completion = "Wait, let me check the seal. Yes. Good.",
			requirements = {
				{
					pool = "town_medical",
					quantity = 3,
				},
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
			id = "JT10",
			name = "The Contaminated Batch",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"JT08"},
			briefing = "Collect sealed batch evidence from Garbage.",
			completion = "You brought it back. Good. Give me a moment.",
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
			id = "JT11",
			name = "The Long Queue",
			kind = "tracker",
			requires = {"JT09"},
			briefing = "Medical supplies. The right ones, please. I can't dress a wound with whatever was cheapest.",
			completion = "The deliveries have helped. I can stop counting the same shelf quite so often.",
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
			id = "JT12",
			name = "Where the Water Came From",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"JT10"},
			briefing = "Retrieve a recorder near a suspect water source.",
			completion = "Leave it on the clean side of the desk, please.",
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
			id = "JT13",
			name = "Better Instruments",
			kind = "delivery",
			requires = {"JT11"},
			briefing = "I'm short of these. Check the list, and keep everything clean on the way here. Please.",
			completion = "Clean enough. Put it here.",
			requirements = {
				{
					pool = "town_medical",
					quantity = 4,
				},
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
			id = "JT14",
			name = "A Second Opinion",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"JT12"},
			briefing = "Recover a research note needed to compare exposure cases.",
			completion = "Careful with that. I need to read it.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
			},
			benefits = {
				services = {
					{
						npc = "'Jitters'",
						service = "treatment",
						amount = 150,
					},
				},
			},
		},
		{
			id = "JT15",
			name = "Cases From Outside",
			kind = "tracker",
			requires = {"JT13"},
			briefing = "Medical supplies. The right ones, please. I can't dress a wound with whatever was cheapest.",
			completion = "The deliveries have helped. I can stop counting the same shelf quite so often.",
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
			id = "JT16",
			name = "The Missing Volunteer",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"JT14"},
			briefing = "Recover a volunteer medic's case in Garbage.",
			completion = "You brought it back. Good. Give me a moment.",
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
			id = "JT17",
			name = "For the Journey",
			kind = "delivery",
			requires = {"JT15"},
			briefing = "I'm short of these. Check the list, and keep everything clean on the way here. Please.",
			completion = "Thank you. One less thing to run out of.",
			requirements = {
				{
					pool = "canned_food",
					quantity = 5,
				},
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
			id = "JT18",
			name = "The Field Ward",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"JT16"},
			briefing = "Retrieve a treatment log at an abandoned regional aid post.",
			completion = "Leave it on the clean side of the desk, please.",
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
			id = "JT19",
			name = "Ready for Returns",
			kind = "tracker",
			requires = {"JT17"},
			briefing = "Medical supplies. The right ones, please. I can't dress a wound with whatever was cheapest.",
			completion = "The deliveries have helped. I can stop counting the same shelf quite so often.",
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
			id = "JT20",
			name = "No One Came Back",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"JT18"},
			briefing = "Recover a clinic recorder from a Pripyat expedition site.",
			completion = "Careful with that. I need to read it.",
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
			id = "JT21",
			name = "Comparing the Cases",
			kind = "delivery",
			requires = {"JT19"},
			briefing = "I'm short of these. Check the list, and keep everything clean on the way here. Please.",
			completion = "Wait, let me check the seal. Yes. Good.",
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 2,
				},
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
			id = "JT22",
			name = "The Patient's Route",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"JT20"},
			briefing = "Retrieve the expedition's last exposure readings in Pripyat.",
			completion = "You brought it back. Good. Give me a moment.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
			},
			benefits = {
				services = {
					{
						npc = "'Jitters'",
						service = "treatment",
						amount = 150,
					},
				},
			},
		},
		{
			id = "JT23",
			name = "Still Taking Patients",
			kind = "tracker",
			requires = {"JT21", "JT22"},
			briefing = "Medical supplies. The right ones, please. I can't dress a wound with whatever was cheapest.",
			completion = "The deliveries have helped. I can stop counting the same shelf quite so often.",
			target = 27,
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
			id = "JT24",
			name = "An Answer on Tape",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"JT23"},
			briefing = "Recover the final medical recorder in Pripyat.",
			completion = "Leave it on the clean side of the desk, please.",
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
				item = "medic_bandage_1",
				bonus = 2,
			},
			discounts = {{npc = "'Jitters'", service = "treatment", fraction = 0.1}},
		},
		{
			id = "JT25",
			name = "A Clinic That Holds",
			kind = "delivery",
			requires = {"JT24"},
			briefing = "I'm short of these. Check the list, and keep everything clean on the way here. Please.",
			completion = "Clean enough. Put it here.",
			requirements = {
				{
					pool = "town_medical",
					quantity = 7,
				},
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
			id = "JT26",
			name = "The Case Closed",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"JT25"},
			briefing = "Recover identifying evidence at the last exposure site and return to the clinic.",
			completion = "Careful with that. I need to read it.",
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
			recognition = "Jitters's trusted contact",
		},
	},
})
