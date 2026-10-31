PLUGIN:Register("boss", {
	name = "'Boss'",
	template = "unisgnpc2",
	map = "rp_waystation",
	job = {
		kind = "humans",
		trigger = "banditKilled",
		category = "Hostile human elimination",
		description = "Hostile human elimination",
		pools = {"maintenance", "administrative_documents"},
		quantities = {5, 9, 15},
		maps = {
			easy = "rp_waystation",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"545x39", "556x45", "medic_bandage_1", "drug_painkillers"},
	dialogue = {
		completedGreeting = "Operation concluded. File the report and get some rest.",
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = "Bandits threatening the operation. The targets on the order. No freelancing.",
		progressionPrompt = "What else needs doing?",
		progression = "Supplies and field reports. Tell me which assignment you can finish.",
	},
	catalogue = {
		["accesscard_bunker"] = {step = "BO01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["headwear_rad"] = {step = "BO11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["headwear_spartan"] = {step = "BO15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_berill"] = {step = "BO05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_exoskeleton"] = {step = "BO17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_io7a"] = {step = "BO01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_ps5m"] = {step = "BO03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_radsuit"] = {step = "BO13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_skat10"] = {step = "BO07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_skat9"] = {step = "BO09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "BO01",
			name = "Operational Basics",
			kind = "delivery",
			requires = {},
			briefing = "Deliver the supplies on this list. Report back here when you have them.",
			completion = "Received.",
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 1,
				},
			},
			benefits = {
				items = {
					{
						item = "545x39",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "BO02",
			name = "The Missing Patrol",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"BO01"},
			briefing = "Recover a patrol report in Waystation territory.",
			completion = "Hand it over. I'll review it.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
			},
			benefits = {
				items = {
					{
						item = "556x45",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "BO03",
			name = "Follow Instructions",
			kind = "tracker",
			requires = {"BO02"},
			briefing = "Bandits threatening the operation. The targets on the order. No freelancing.",
			completion = "You've dealt with the assigned targets. Keep to the orders.",
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
			id = "BO04",
			name = "The Forward Record",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"BO03"},
			briefing = "Recover an NPC outpost's field orders.",
			completion = "Good. Keep the records together.",
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
			id = "BO05",
			name = "Staying Equipped",
			kind = "delivery",
			requires = {"BO03"},
			briefing = "Deliver the supplies on this list. Report back here when you have them.",
			completion = "That covers the requirement.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 3,
				},
			},
			benefits = {
				items = {
					{
						item = "545x39",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "BO06",
			name = "The Interrupted Shipment",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"BO04"},
			briefing = "Recover a freight case along a regional route.",
			completion = "I'll check this against the report.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
			},
			benefits = {
				items = {
					{
						item = "556x45",
						data = {
							quantity = 1,
						},
					},
				},
			},
			stock = {
				item = "545x39",
				bonus = 1,
			},
		},
		{
			id = "BO07",
			name = "Pressure on the Route",
			kind = "tracker",
			requires = {"BO05"},
			briefing = "Bandits threatening the operation. The targets on the order. No freelancing.",
			completion = "You've dealt with the assigned targets. Keep to the orders.",
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
			id = "BO08",
			name = "The Supply Register",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"BO06"},
			briefing = "Retrieve hostile supply records in Garbage.",
			completion = "Hand it over. I'll review it.",
			field = {
				kind = "recovery",
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
			id = "BO09",
			name = "Orders and Receipts",
			kind = "delivery",
			requires = {"BO07"},
			briefing = "Deliver the supplies on this list. Report back here when you have them.",
			completion = "Good. Leave it with the stores.",
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 1,
				},
			},
			benefits = {
				items = {
					{
						item = "545x39",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "BO10",
			name = "The Missing Names",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"BO08"},
			briefing = "Recover expedition evidence related to Wake's search.",
			completion = "Good. Keep the records together.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
			},
			benefits = {
				items = {
					{
						item = "556x45",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "BO11",
			name = "A Smaller Network",
			kind = "tracker",
			requires = {"BO09"},
			briefing = "Bandits threatening the operation. The targets on the order. No freelancing.",
			completion = "You've dealt with the assigned targets. Keep to the orders.",
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
			id = "BO12",
			name = "The Second Command Post",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"BO10"},
			briefing = "Recover a field recorder from a hostile NPC position.",
			completion = "I'll check this against the report.",
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
			id = "BO13",
			name = "Packed for Contact",
			kind = "delivery",
			requires = {"BO11"},
			briefing = "Deliver the supplies on this list. Report back here when you have them.",
			completion = "Received.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 4,
				},
			},
			benefits = {
				items = {
					{
						item = "545x39",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "BO14",
			name = "The Pripyat Outpost",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"BO12"},
			briefing = "Recover orders at a Pripyat NPC operation site.",
			completion = "Hand it over. I'll review it.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
			},
			benefits = {
				items = {
					{
						item = "556x45",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "BO15",
			name = "Holding the Initiative",
			kind = "tracker",
			requires = {"BO13"},
			briefing = "Bandits threatening the operation. The targets on the order. No freelancing.",
			completion = "You've dealt with the assigned targets. Keep to the orders.",
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
			id = "BO16",
			name = "The Handler's Orders",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"BO14"},
			briefing = "Retrieve a command recording in Pripyat.",
			completion = "Good. Keep the records together.",
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
			id = "BO17",
			name = "A Report That Holds",
			kind = "delivery",
			requires = {"BO15"},
			briefing = "Deliver the supplies on this list. Report back here when you have them.",
			completion = "That covers the requirement.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 5,
				},
			},
			benefits = {
				items = {
					{
						item = "545x39",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "BO18",
			name = "The Withheld Annex",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"BO16"},
			briefing = "Recover the missing expedition record in Pripyat.",
			completion = "I'll check this against the report.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
			},
			benefits = {
				items = {
					{
						item = "556x45",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "BO19",
			name = "End of the Operation",
			kind = "tracker",
			requires = {"BO17", "BO18"},
			briefing = "Bandits threatening the operation. The targets on the order. No freelancing.",
			completion = "You've dealt with the assigned targets. Keep to the orders.",
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
			id = "BO20",
			name = "The Last Command",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"BO19"},
			briefing = "Recover the final command record.",
			completion = "Hand it over. I'll review it.",
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
			stock = {
				item = "545x39",
				bonus = 2,
			},
		},
		{
			id = "BO21",
			name = "Return to Readiness",
			kind = "delivery",
			requires = {"BO20"},
			briefing = "Deliver the supplies on this list. Report back here when you have them.",
			completion = "Good. Leave it with the stores.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 6,
				},
			},
			benefits = {
				items = {
					{
						item = "545x39",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "BO22",
			name = "The Missing Patrol's Answer",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"BO21"},
			briefing = "Recover the patrol's final record and return the complete report.",
			completion = "Good. Keep the records together.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
			},
			benefits = {
				items = {
					{
						item = "556x45",
						data = {
							quantity = 1,
						},
					},
				},
			},
			recognition = "Boss's trusted contact",
		},
	},
})
