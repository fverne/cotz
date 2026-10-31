PLUGIN:Register("ledger", {
	name = "'Ledger'",
	template = "ledgernpc",
	map = "rp_waystation",
	job = {
		kind = "deadDrop",
		category = "Dead-drop circuits",
		description = "Dead-drop circuits",
		pools = {"administrative_documents", "workshop_supplies"},
		quantities = {5, 9, 15},
		maps = {
			easy = "rp_waystation",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	dialogue = {
		completedGreeting = "Outbound, inbound, accounted for. That's a route we can keep.",
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Collect the sealed parcel at the first point, deliver it to the second, then report back. Both "
			.. "ends matter."
		),
		progressionPrompt = "What else needs doing?",
		progression = (
			"There's freight to move and paperwork to recover. Read the destination before taking the "
			.. "parcel."
		),
	},
	progression = {
		{
			id = "LE01",
			name = "Labels That Last",
			kind = "delivery",
			requires = {},
			briefing = "Deliver the listed supplies here. I'll record the quantity when it arrives.",
			completion = "Let me enter the quantity.",
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
			id = "LE02",
			name = "The First Route",
			kind = "field",
			objective = (
				"Collect the parcel at the first marker and deliver it to the second in Waystation. Return "
				.. "to this contact to finish the assignment."
			),
			requires = {"LE01"},
			briefing = "Complete a regional dead-drop circuit.",
			completion = "I'll record that as returned.",
			field = {
				kind = "deadDrop",
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
			id = "LE03",
			name = "Delivered Intact",
			kind = "tracker",
			requires = {"LE02"},
			briefing = (
				"Collect the sealed parcel at the first point, deliver it to the second, then report back. "
				.. "Both ends matter."
			),
			completion = "The completed deliveries are on the record. You've been consistent.",
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
			id = "LE04",
			name = "The Missing Receipt",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"LE02"},
			briefing = "Recover a receipt from a Waystation freight cache.",
			completion = "Set it with the freight records.",
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
			id = "LE05",
			name = "Stock for the Road",
			kind = "delivery",
			requires = {"LE03"},
			briefing = "Deliver the listed supplies here. I'll record the quantity when it arrives.",
			completion = "Received. I'll put it with the supplies.",
			requirements = {
				{
					pool = "canned_food",
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
			id = "LE06",
			name = "Ballast's Landing Copy",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"LE04"},
			briefing = "Recover a landing manifest in Marsh.",
			completion = "Thank you. Let me check the reference.",
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
			id = "LE07",
			name = "On Both Sides",
			kind = "tracker",
			requires = {"LE05"},
			briefing = (
				"Collect the sealed parcel at the first point, deliver it to the second, then report back. "
				.. "Both ends matter."
			),
			completion = "The completed deliveries are on the record. You've been consistent.",
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
			id = "LE08",
			name = "The Interrupted Connection",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"LE06"},
			briefing = "Recover a freight case on the Garbage route.",
			completion = "I'll record that as returned.",
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
			id = "LE09",
			name = "Paperwork That Matches",
			kind = "delivery",
			requires = {"LE07"},
			briefing = "Deliver the listed supplies here. I'll record the quantity when it arrives.",
			completion = "That matches the list.",
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
			id = "LE10",
			name = "The Duplicate Destination",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"LE08"},
			briefing = "Recover paired route records from regional caches.",
			completion = "Set it with the freight records.",
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
			id = "LE11",
			name = "More Than Local",
			kind = "tracker",
			requires = {"LE09"},
			briefing = (
				"Collect the sealed parcel at the first point, deliver it to the second, then report back. "
				.. "Both ends matter."
			),
			completion = "The completed deliveries are on the record. You've been consistent.",
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
			id = "LE12",
			name = "The Missing Dispatcher",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"LE10"},
			briefing = "Retrieve a dispatcher recorder in regional ruins.",
			completion = "Thank you. Let me check the reference.",
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
			id = "LE13",
			name = "For the Remote Cache",
			kind = "delivery",
			requires = {"LE11"},
			briefing = "Deliver the listed supplies here. I'll record the quantity when it arrives.",
			completion = "Let me enter the quantity.",
			requirements = {
				{
					pool = "canned_food",
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
			id = "LE14",
			name = "The Last Scheduled Drop",
			kind = "field",
			objective = (
				"Collect the parcel at the first marker and deliver it to the second in Waystation. Return "
				.. "to this contact to finish the assignment."
			),
			requires = {"LE12"},
			briefing = "Complete a remote cache delivery.",
			completion = "I'll record that as returned.",
			field = {
				kind = "deadDrop",
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
			id = "LE15",
			name = "A Dependable Circuit",
			kind = "tracker",
			requires = {"LE13"},
			briefing = (
				"Collect the sealed parcel at the first point, deliver it to the second, then report back. "
				.. "Both ends matter."
			),
			completion = "The completed deliveries are on the record. You've been consistent.",
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
			id = "LE16",
			name = "The Unmanned Pripyat Cache",
			kind = "field",
			objective = (
				"Collect the parcel at the first marker and deliver it to the second in Pripyat. Return to "
				.. "this contact to finish the assignment."
			),
			requires = {"LE14"},
			briefing = "Complete a delivery to a Pripyat cache.",
			completion = "Set it with the freight records.",
			field = {
				kind = "deadDrop",
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
			id = "LE17",
			name = "Proof on Paper",
			kind = "delivery",
			requires = {"LE15"},
			briefing = "Deliver the listed supplies here. I'll record the quantity when it arrives.",
			completion = "Received. I'll put it with the supplies.",
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
			id = "LE18",
			name = "The Dispatcher's Detour",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"LE16"},
			briefing = "Recover the missing dispatcher's recorder in Pripyat.",
			completion = "Thank you. Let me check the reference.",
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
			id = "LE19",
			name = "The Route Holds",
			kind = "tracker",
			requires = {"LE17", "LE18"},
			briefing = (
				"Collect the sealed parcel at the first point, deliver it to the second, then report back. "
				.. "Both ends matter."
			),
			completion = "The completed deliveries are on the record. You've been consistent.",
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
			id = "LE20",
			name = "The Return Consignment",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"LE19"},
			briefing = "Complete the return leg from a Pripyat cache.",
			completion = "I'll record that as returned.",
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
			stock = {
				item = "drink_bottlewater",
				bonus = 2,
			},
		},
		{
			id = "LE21",
			name = "The Next Shipment",
			kind = "delivery",
			requires = {"LE20"},
			briefing = "Deliver the listed supplies here. I'll record the quantity when it arrives.",
			completion = "That matches the list.",
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
			id = "LE22",
			name = "The Last Receipt",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"LE21"},
			briefing = "Recover the route's final receipt and return to Waystation.",
			completion = "Set it with the freight records.",
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
			recognition = "Ledger's trusted contact",
		},
	},
})
