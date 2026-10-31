PLUGIN:Register("mute", {
	name = "'Mute'",
	template = "stalkernetnpc",
	map = "rp_marsh_cs",
	access = {contact = "old-timer", step = "OT19"},
	job = {
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		category = "Electronics deliveries",
		description = "Electronics deliveries",
		pools = {"small_electronics", "batteries", "radio_components"},
		quantities = {2, 4, 7},
		maps = {
			easy = "rp_marsh_cs",
			medium = "mz_garbage",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	dialogue = {
		completedGreeting = "** He reads the final address twice, then quietly disconnects the receiver. **",
		workPrompt = "Anything on the list?",
		offerPrompt = "Do you have an assignment?",
		work = "** He pushes a list of electronic components towards you. **",
		progressionPrompt = "May I see the other lists?",
		progression = "** He lays several unfinished lists beside the receiver, leaving you room to read. **",
	},
	catalogue = {
		["anomalydetector"] = {step = "MU03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["binoculars_1"] = {step = "MU05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["binoculars_2"] = {step = "MU01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["binoculars_3"] = {step = "MU17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["binoculars_4"] = {step = "MU13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["quest_flashdrive"] = {step = "MU01",
			terms = {nil, 1, "SELLANDBUY", 1, 3, 1}},
	},
	progression = {
		{
			id = "MU01",
			name = "A Loose Connection",
			kind = "delivery",
			requires = {},
			briefing = "** He marks the required supplies on the list and pushes it back towards you. **",
			completion = "** He checks the components and sets them aside. **",
			requirements = {
				{
					pool = "small_electronics",
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
			id = "MU02",
			name = "The Silent Repeater",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"MU01"},
			briefing = "** He writes \"The Silent Repeater\" on a field order, then marks the place to look. **",
			completion = "** He takes the case without looking up. **",
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
			id = "MU03",
			name = "Signals Getting Through",
			kind = "tracker",
			requires = {"MU02"},
			briefing = "** He pushes a list of electronic components towards you. **",
			completion = "** He checks the delivery tally and underlines it once. **",
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
			id = "MU04",
			name = "The Missing Address",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"MU02"},
			briefing = "** He writes \"The Missing Address\" on a field order, then marks the place to look. **",
			completion = "** He checks the seal, then draws it closer. **",
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
			id = "MU05",
			name = "A Clearer Picture",
			kind = "delivery",
			requires = {"MU03"},
			briefing = "** He marks the required supplies on the list and pushes it back towards you. **",
			completion = "** He gives a small nod. **",
			requirements = {
				{
					pool = "small_electronics",
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
			id = "MU06",
			name = "A Line Through the Marsh",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"MU04"},
			briefing = "** He writes \"A Line Through the Marsh\" on a field order, then marks the place to look. **",
			completion = "** He turns the record over and studies the reverse. **",
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
			id = "MU07",
			name = "Not Just Static",
			kind = "tracker",
			requires = {"MU05"},
			briefing = "** He pushes a list of electronic components towards you. **",
			completion = "** He checks the delivery tally and underlines it once. **",
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
			id = "MU08",
			name = "Spool's Packet",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"MU06"},
			briefing = "** He writes \"Spool's Packet\" on a field order, then marks the place to look. **",
			completion = "** He takes the case without looking up. **",
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
			id = "MU09",
			name = "Noisy Components",
			kind = "delivery",
			requires = {"MU07"},
			briefing = "** He marks the required supplies on the list and pushes it back towards you. **",
			completion = "** He crosses an entry off the paper. **",
			requirements = {
				{
					pool = "radio_components",
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
			id = "MU10",
			name = "The Duplicate Message",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"MU08"},
			briefing = "** He writes \"The Duplicate Message\" on a field order, then marks the place to look. **",
			completion = "** He checks the seal, then draws it closer. **",
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
			id = "MU11",
			name = "A Stable Link",
			kind = "tracker",
			requires = {"MU09"},
			briefing = "** He pushes a list of electronic components towards you. **",
			completion = "** He checks the delivery tally and underlines it once. **",
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
			id = "MU12",
			name = "The Unlisted Receiver",
			kind = "field",
			objective = (
				"Take the required bearings, locate the source, and recover the transmitter in Marsh. Return "
				.. "to this contact to finish the assignment."
			),
			requires = {"MU10"},
			briefing = "** He writes \"The Unlisted Receiver\" on a field order, then marks the place to look. **",
			completion = "** He turns the record over and studies the reverse. **",
			field = {
				kind = "triangulation",
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
			id = "MU13",
			name = "Looking Further",
			kind = "delivery",
			requires = {"MU11"},
			briefing = "** He marks the required supplies on the list and pushes it back towards you. **",
			completion = "** He checks the components and sets them aside. **",
			requirements = {
				{
					pool = "small_electronics",
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
			id = "MU14",
			name = "The Second Copy",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"MU12"},
			briefing = "** He writes \"The Second Copy\" on a field order, then marks the place to look. **",
			completion = "** He takes the case without looking up. **",
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
			id = "MU15",
			name = "Beyond Local Range",
			kind = "tracker",
			requires = {"MU13"},
			briefing = "** He pushes a list of electronic components towards you. **",
			completion = "** He checks the delivery tally and underlines it once. **",
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
			id = "MU16",
			name = "A Message With No Sender",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"MU14"},
			briefing = "** He writes \"A Message With No Sender\" on a field order, then marks the place to look. **",
			completion = "** He checks the seal, then draws it closer. **",
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
			id = "MU17",
			name = "The Final Lens",
			kind = "delivery",
			requires = {"MU15"},
			briefing = "** He marks the required supplies on the list and pushes it back towards you. **",
			completion = "** He gives a small nod. **",
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
			id = "MU18",
			name = "The Old Routing Table",
			kind = "field",
			objective = (
				"Deploy the recorder at the marked site, remain in range until it finishes, and collect it "
				.. "in Pripyat. Return to this contact to finish the assignment."
			),
			requires = {"MU16"},
			briefing = "** He writes \"The Old Routing Table\" on a field order, then marks the place to look. **",
			completion = "** He turns the record over and studies the reverse. **",
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
			id = "MU19",
			name = "No Lost Packets",
			kind = "tracker",
			requires = {"MU17"},
			briefing = "** He pushes a list of electronic components towards you. **",
			completion = "** He checks the delivery tally and underlines it once. **",
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
			id = "MU20",
			name = "Someone on the Line",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"MU18"},
			briefing = "** He writes \"Someone on the Line\" on a field order, then marks the place to look. **",
			completion = "** He takes the case without looking up. **",
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
			id = "MU21",
			name = "Parts for a Clean Link",
			kind = "delivery",
			requires = {"MU19", "MU20"},
			briefing = "** He marks the required supplies on the list and pushes it back towards you. **",
			completion = "** He crosses an entry off the paper. **",
			requirements = {
				{
					pool = "radio_components",
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
			id = "MU22",
			name = "The Broken Handshake",
			kind = "field",
			objective = (
				"Take the required bearings, locate the source, and recover the transmitter in Pripyat. "
				.. "Return to this contact to finish the assignment."
			),
			requires = {"MU21"},
			briefing = "** He writes \"The Broken Handshake\" on a field order, then marks the place to look. **",
			completion = "** He checks the seal, then draws it closer. **",
			field = {
				kind = "triangulation",
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
			id = "MU23",
			name = "Message Received",
			kind = "tracker",
			requires = {"MU22"},
			briefing = "** He pushes a list of electronic components towards you. **",
			completion = "** He checks the delivery tally and underlines it once. **",
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
			id = "MU24",
			name = "The Last Address",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"MU23"},
			briefing = "** He writes \"The Last Address\" on a field order, then marks the place to look. **",
			completion = "** He turns the record over and studies the reverse. **",
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
			recognition = "Mute's trusted contact",
		},
	},
})
