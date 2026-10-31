PLUGIN:Register("brass", {
	name = "'Brass'",
	template = "brassnpc",
	map = "mz_garbage",
	job = {
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		category = "Ammunition deliveries",
		description = "Ammunition deliveries",
		pools = {"town_ammunition"},
		quantities = {2, 4, 7},
		maps = {
			easy = "mz_garbage",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"12gauge", "9x18", "9x19", "medic_bandage_1"},
	dialogue = {
		completedGreeting = "Every consignment accounted for. Let's keep it that way.",
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = "Ammunition. Match the calibre and quantity on the order before bringing it over.",
		progressionPrompt = "What else needs doing?",
		progression = "We can count supplies here. Missing consignments need somebody to go and find the records.",
	},
	progression = {
		{
			id = "BR01",
			name = "Count It Twice",
			kind = "delivery",
			requires = {},
			briefing = "Match the list. I'll check the quantity and condition when you return.",
			completion = "Hold on while I count it.",
			requirements = {
				{
					pool = "town_ammunition",
					quantity = 12,
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
			id = "BR02",
			name = "The Broken Seal",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"BR01"},
			briefing = "Recover depot packing records in Garbage.",
			completion = "Let's check the consignment marks.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
			},
			benefits = {
				items = {
					{
						item = "9x18",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "BR03",
			name = "Reliable Quantities",
			kind = "tracker",
			requires = {"BR02"},
			briefing = "Ammunition. Match the calibre and quantity on the order before bringing it over.",
			completion = "Your deliveries match the orders. That makes you easier to deal with than most.",
			target = 2,
			benefits = {
				items = {
					{
						item = "9x19",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "BR04",
			name = "The Missing Boxes",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"BR03"},
			briefing = "Recover a sealed freight case near a vehicle graveyard.",
			completion = "Put it here. I want the paperwork kept together.",
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
			id = "BR05",
			name = "Another Chamber",
			kind = "delivery",
			requires = {"BR03"},
			briefing = "Match the list. I'll check the quantity and condition when you return.",
			completion = "Correct. Set it with the rest.",
			requirements = {
				{
					pool = "town_ammunition",
					quantity = 12,
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
			id = "BR06",
			name = "The Depot Register",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"BR04"},
			briefing = "Retrieve a recovered depot inventory.",
			completion = "Good. I'll compare it with my copy.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
			},
			benefits = {
				items = {
					{
						item = "9x18",
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
			id = "BR07",
			name = "Not One Round Short",
			kind = "tracker",
			requires = {"BR05"},
			briefing = "Ammunition. Match the calibre and quantity on the order before bringing it over.",
			completion = "Your deliveries match the orders. That makes you easier to deal with than most.",
			target = 5,
			benefits = {
				items = {
					{
						item = "9x19",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "BR08",
			name = "The Mixed Shipment",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"BR06"},
			briefing = "Recover evidence identifying a wrongly labelled consignment.",
			completion = "Let's check the consignment marks.",
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
			id = "BR09",
			name = "Shot and Shell",
			kind = "delivery",
			requires = {"BR07"},
			briefing = "Match the list. I'll check the quantity and condition when you return.",
			completion = "That matches the order.",
			requirements = {
				{
					pool = "town_ammunition",
					quantity = 24,
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
			id = "BR10",
			name = "The Supplier's Stamp",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"BR08"},
			briefing = "Retrieve supplier paperwork in regional ruins.",
			completion = "Put it here. I want the paperwork kept together.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
			},
			benefits = {
				items = {
					{
						item = "9x18",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "BR11",
			name = "Enough for the Shift",
			kind = "tracker",
			requires = {"BR09"},
			briefing = "Ammunition. Match the calibre and quantity on the order before bringing it over.",
			completion = "Your deliveries match the orders. That makes you easier to deal with than most.",
			target = 9,
			benefits = {
				items = {
					{
						item = "9x19",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "BR12",
			name = "Ledger's Missing Receipt",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"BR10"},
			briefing = "Recover a freight receipt on a regional route.",
			completion = "Good. I'll compare it with my copy.",
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
			id = "BR13",
			name = "Rifle Stock",
			kind = "delivery",
			requires = {"BR11"},
			briefing = "Match the list. I'll check the quantity and condition when you return.",
			completion = "Hold on while I count it.",
			requirements = {
				{
					pool = "town_ammunition",
					quantity = 24,
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
			id = "BR14",
			name = "The Military Manifest",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"BR12"},
			briefing = "Recover a military supply record in Waystation territory.",
			completion = "Let's check the consignment marks.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
			},
			benefits = {
				items = {
					{
						item = "9x18",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "BR15",
			name = "A Working Depot",
			kind = "tracker",
			requires = {"BR13"},
			briefing = "Ammunition. Match the calibre and quantity on the order before bringing it over.",
			completion = "Your deliveries match the orders. That makes you easier to deal with than most.",
			target = 14,
			benefits = {
				items = {
					{
						item = "9x19",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "BR16",
			name = "The Empty Truck",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"BR14"},
			briefing = "Recover a driver recorder at a remote supply site.",
			completion = "Put it here. I want the paperwork kept together.",
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
			id = "BR17",
			name = "Specialist Loads",
			kind = "delivery",
			requires = {"BR15"},
			briefing = "Match the list. I'll check the quantity and condition when you return.",
			completion = "Correct. Set it with the rest.",
			requirements = {
				{
					pool = "town_ammunition",
					quantity = 36,
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
			id = "BR18",
			name = "The Pripyat Consignment",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"BR16"},
			briefing = "Recover a sealed case in Pripyat.",
			completion = "Good. I'll compare it with my copy.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
			},
			benefits = {
				items = {
					{
						item = "9x18",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "BR19",
			name = "Supply Under Pressure",
			kind = "tracker",
			requires = {"BR17"},
			briefing = "Ammunition. Match the calibre and quantity on the order before bringing it over.",
			completion = "Your deliveries match the orders. That makes you easier to deal with than most.",
			target = 20,
			benefits = {
				items = {
					{
						item = "9x19",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "BR20",
			name = "The Wrong Recipient",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"BR18"},
			briefing = "Recover a destination record in Pripyat.",
			completion = "Let's check the consignment marks.",
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
			id = "BR21",
			name = "Rounds in Reserve",
			kind = "delivery",
			requires = {"BR19", "BR20"},
			briefing = "Match the list. I'll check the quantity and condition when you return.",
			completion = "That matches the order.",
			requirements = {
				{
					pool = "town_ammunition",
					quantity = 36,
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
			id = "BR22",
			name = "The Final Receipt",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"BR21"},
			briefing = "Recover the shipment's final freight record.",
			completion = "Put it here. I want the paperwork kept together.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
			},
			benefits = {
				items = {
					{
						item = "9x18",
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
			id = "BR23",
			name = "Every Box Accounted For",
			kind = "tracker",
			requires = {"BR22"},
			briefing = "Ammunition. Match the calibre and quantity on the order before bringing it over.",
			completion = "Your deliveries match the orders. That makes you easier to deal with than most.",
			target = 27,
			benefits = {
				items = {
					{
						item = "9x19",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "BR24",
			name = "The Depot's Copy",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"BR23"},
			briefing = "Recover a supplier's surviving agreement and return it.",
			completion = "Good. I'll compare it with my copy.",
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
			recognition = "Brass's trusted contact",
		},
	},
})
