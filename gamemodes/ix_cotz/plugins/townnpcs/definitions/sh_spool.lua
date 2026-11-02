PLUGIN:Register("spool", {
	name = "'Spool'",
	template = "spoolnpc",
	map = "mz_garbage",
	job = {
		kind = "triangulation",
		category = "Radio triangulation",
		description = "Radio triangulation",
		maps = {
			easy = "mz_garbage",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Radio spares (trade goods)",
				items = {"value_battery", "value_capacitors", "value_tape_electric"}},
			{label = "Night watch",
				items = {"drug_caffeine", "drink_bottletea"}},
			{label = "Field callout",
				items = {"food_raisins", "medic_bandage_1"}},
		},
	},
	dialogue = {
		delivery = "Right, one moment. Let me find the matching entry.",
		completedGreeting = (
			"Oh, hello. Nice to have someone here I don't need to ask to repeat themselves through the "
			.. "interference."
		),
		workPrompt = "About the source I'm locating.",
		offerPrompt = "Do you have a triangulation job?",
		work = (
			"Take the required bearings, locate the source, and bring the transmitter back. I'll listen to the "
			.. "recording here. Check the destination before accepting. I like hearing somebody arrive where they "
			.. "meant to go; gives me a moment to enjoy the ordinary part before we discover what the equipment "
			.. "has been doing."
		),
		progressionPrompt = "What are you checking in the station recordings?",
		progression = (
			"I'm comparing station records and messages that never made it back properly. There are parts to "
			.. "bring in and sources to recover. I want to listen before deciding what a silence means. Some "
			.. "recordings go to another contact; the order says who. Come back afterwards. I'd like to hear you "
			.. "finished the trip too."
		),
	},
	catalogue = {
	},
	progression = {
		{
			id = "SO01",
			completionCash = 275,
			name = "Something on the Air",
			kind = "delivery",
			requires = {},
			briefing = (
				"I need supplies for the radio bench. I would like the set ready when somebody calls, without "
				.. "holding a connection together by hand. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Thanks. Leave those by the bench; I will check them between calls.",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
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
			id = "SO02",
			completionCash = 450,
			name = "The Local Silence",
			kind = "field",
			objective = (
				"Take the required bearings in Waystation, locate the source, and collect the local silent "
				.. "transmitter. Bring it back to the issuing contact in Garbage."
			),
			requires = {"SO01"},
			briefing = (
				"There's a source we aren't hearing properly. I'd like it located and brought back before I blame "
				.. "the equipment on this side. Take the required bearings in Waystation, locate the source, and "
				.. "collect the local silent transmitter. Bring it back to me in Garbage."
			),
			completion = "You've brought it in. I'll start with what we actually received and work back from there.",
			field = {
				description = (
					"A finned grey control box with a red stripe and several round front connectors. Spool's note: "
					.. "\"There's a source we aren't hearing properly.\""
				),
				kind = "triangulation",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_control",
				label = "Local silent transmitter",
			},
			benefits = {},
		},
		{
			id = "SO03",
			completionCash = 0,
			name = "Clear Enough to Hear",
			kind = "tracker",
			requires = {"SO02"},
			briefing = (
				"Continue the radio triangulation assignments. Take the required bearings, locate the source, and "
				.. "bring it back."
			),
			completion = "A few sources recovered. I can start checking the records at this end.",
			target = 2,
			benefits = {},
		},
		{
			id = "SO04",
			completionCash = 650,
			name = "A small delivery",
			kind = "delivery",
			retiredCommission = true,
			objective = "Bring all 1 listed item type to this contact. The request shows each selected item and required units.",
			requires = {"SO02"},
			briefing = (
				"I need supplies for the radio bench. I would like the set ready when somebody calls, without "
				.. "holding a connection together by hand. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Thanks. Leave those by the bench; I will check them between calls.",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "SO05",
			completionCash = 575,
			name = "Ground and Power",
			kind = "delivery",
			requires = {"SO03"},
			briefing = (
				"I need supplies for the radio bench. I would like the set ready when somebody calls, without "
				.. "holding a connection together by hand. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Thanks. Leave those by the bench; I will check them between calls.",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "SO06",
			completionCash = 850,
			name = "The Crossed Bearings",
			kind = "field",
			objective = (
				"Recover the calibration file for Technut from the assigned search area in Waystation. Deliver it "
				.. "to 'Technut' in Marsh, then come back to the issuing contact in Garbage."
			),
			requires = {"SO04"},
			briefing = (
				"Technut needs the calibration record. He can check the hardware side without me making "
				.. "increasingly elaborate sounds at him. Recover the calibration file for Technut from the assigned "
				.. "search area in Waystation. Deliver it to 'Technut' in Marsh, then come back to me in Garbage."
			),
			completion = "He has it. Good. I was running out of ways to pronounce the fault.",
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. Spool's note: "
					.. "\"Technut needs the calibration record.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_module",
				label = "Calibration file for Technut",
				recipient = "technut",
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
			id = "SO07",
			completionCash = 0,
			name = "A Voice Worth Finding",
			kind = "tracker",
			requires = {"SO05"},
			briefing = (
				"More triangulation work when you're prepared. Follow the bearings rather than the most convincing "
				.. "guess."
			),
			completion = "Another useful set of returns. Thank you for bringing the sources all the way through.",
			target = 5,
			benefits = {},
		},
		{
			id = "SO08",
			completionCash = 1050,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"SO06"},
			briefing = (
				"I need supplies for the radio bench. I would like the set ready when somebody calls, without "
				.. "holding a connection together by hand. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Thanks. Leave those by the bench; I will check them between calls.",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "SO09",
			completionCash = 875,
			name = "A Longer Cable",
			kind = "delivery",
			requires = {"SO07"},
			briefing = (
				"I need supplies for the radio bench. I would like the set ready when somebody calls, without "
				.. "holding a connection together by hand. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Thanks. Leave those by the bench; I will check them between calls.",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "SO10",
			completionCash = 1250,
			name = "Mute's Header",
			kind = "field",
			objective = (
				"Recover the network header from the assigned search area in Marsh. Bring it back to the issuing "
				.. "contact in Garbage."
			),
			requires = {"SO08"},
			briefing = (
				"There's a damaged network record out in Marsh. I'd like to see what remains before deciding who "
				.. "it connects to. Recover the network header from the assigned search area in Marsh. Bring it back "
				.. "to me in Garbage."
			),
			completion = "Here we are. I'll keep the surviving record as it is while I check it.",
			field = {
				description = (
					"A dark USB drive with a pale handwritten tape label around its body. Spool's note: \"There's a "
					.. "damaged network record out in Marsh.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_drive",
				label = "network header",
			},
			benefits = {},
		},
		{
			id = "SO11",
			completionCash = 0,
			name = "Across the Static",
			kind = "tracker",
			requires = {"SO09"},
			briefing = "Keep locating and recovering the assigned transmitters.",
			completion = "You've been consistent. That makes sorting the recordings a little less lonely.",
			target = 9,
			benefits = {},
		},
		{
			id = "SO12",
			completionCash = 1450,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"SO10"},
			briefing = (
				"I need supplies for the radio bench. I would like the set ready when somebody calls, without "
				.. "holding a connection together by hand. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Thanks. Leave those by the bench; I will check them between calls.",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_electronics_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_marsh_3",
					quantity = 1,
				},
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
			id = "SO13",
			completionCash = 1175,
			name = "Packed to Listen",
			kind = "delivery",
			requires = {"SO11"},
			briefing = (
				"I need supplies for the radio bench. I would like the set ready when somebody calls, without "
				.. "holding a connection together by hand. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Thanks. Leave those by the bench; I will check them between calls.",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_electronics_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "SO14",
			completionCash = 1650,
			name = "The Unsent Call",
			kind = "field",
			objective = (
				"Recover the unsent check-in for Wake from the assigned search area in Waystation. Deliver it to "
				.. "'Wake' in Garbage, then come back to the issuing contact in Garbage."
			),
			requires = {"SO12"},
			briefing = (
				"Wake should have the check-in recording. She may recognise something about the journey that I'd "
				.. "miss while concentrating on the voice. Recover the unsent check-in for Wake from the assigned "
				.. "search area in Waystation. Deliver it to 'Wake' in Garbage, then come back to me in Garbage."
			),
			completion = "Delivered. Thank you. I'll let her listen before we compare what we think we heard.",
			field = {
				description = (
					"A pale audio cassette with a broad blue printed label and twin spool windows. Spool's note: "
					.. "\"Wake should have the check-in recording.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_tape2",
				label = "Unsent check-in for Wake",
				recipient = "wake",
			},
			benefits = {},
		},
		{
			id = "SO15",
			completionCash = 0,
			name = "Still on Frequency",
			kind = "tracker",
			requires = {"SO13"},
			briefing = "Continue the triangulation orders while I compare the check-ins.",
			completion = "A considerable amount of listening has started with your walking. I appreciate it.",
			target = 14,
			benefits = {},
		},
		{
			id = "SO16",
			completionCash = 1850,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"SO14"},
			briefing = (
				"I need supplies for the radio bench. I would like the set ready when somebody calls, without "
				.. "holding a connection together by hand. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Thanks. Leave those by the bench; I will check them between calls.",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_electronics_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "SO17",
			completionCash = 1475,
			name = "Enough Power to Return",
			kind = "delivery",
			requires = {"SO15"},
			briefing = (
				"I need supplies for the radio bench. I would like the set ready when somebody calls, without "
				.. "holding a connection together by hand. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Thanks. Leave those by the bench; I will check them between calls.",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_electronics_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "SO18",
			completionCash = 2050,
			name = "The Last Check-in",
			kind = "field",
			objective = (
				"Recover the later check-in for Wake from the assigned search area in Pripyat. Deliver it to "
				.. "'Wake' in Garbage, then come back to the issuing contact in Garbage."
			),
			requires = {"SO16"},
			briefing = (
				"The later expedition recording goes to Wake. She should hear it without my account standing "
				.. "between her and the speaker. Recover the later check-in for Wake from the assigned search area in "
				.. "Pripyat. Deliver it to 'Wake' in Garbage, then come back to me in Garbage."
			),
			completion = "She has it. Good. We can discuss the uncertainty after we've both heard the record.",
			field = {
				description = (
					"A pale audio cassette with a handwritten dedication above the spool windows. Spool's note: \"The "
					.. "later expedition recording goes to Wake.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_tape",
				label = "Later check-in for Wake",
				recipient = "wake",
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
			id = "SO19",
			completionCash = 0,
			name = "Nobody Left Calling",
			kind = "tracker",
			requires = {"SO17", "SO18"},
			briefing = "There are more sources to locate. Check the assignment before heading out.",
			completion = "You've kept returning with something I can examine. I'm grateful for the care.",
			target = 20,
			benefits = {},
		},
		{
			id = "SO20",
			completionCash = 2250,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"SO19"},
			briefing = (
				"I need supplies for the radio bench. I would like the set ready when somebody calls, without "
				.. "holding a connection together by hand. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Thanks. Leave those by the bench; I will check them between calls.",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_electronics_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_electronics_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_marsh_4",
					quantity = 1,
				},
			},
			benefits = {},
			stock = {
				item = "drink_bottlewater",
				bonus = 2,
			},
		},
		{
			id = "SO21",
			completionCash = 1775,
			name = "Keep the Channel Open",
			kind = "delivery",
			requires = {"SO20"},
			briefing = (
				"I need supplies for the radio bench. I would like the set ready when somebody calls, without "
				.. "holding a connection together by hand. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Thanks. Leave those by the bench; I will check them between calls.",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_electronics_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_electronics_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_marsh_4",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "SO22",
			completionCash = 2450,
			name = "The Message Home",
			kind = "field",
			objective = (
				"Recover the unsent message cassette from the assigned search area in Waystation. Bring it back to "
				.. "the issuing contact in Garbage."
			),
			requires = {"SO21"},
			briefing = (
				"Bring the last cassette back here. There'll be time to listen when neither of us has to keep one "
				.. "ear on the journey. Recover the unsent message cassette from the assigned search area in "
				.. "Waystation. Bring it back to me in Garbage."
			),
			completion = (
				"You got it home. Thank you. I don't have a neat speech ready for this. Stay a moment if you can; "
				.. "I'd rather not put the headphones on just yet."
			),
			field = {
				description = (
					"A pale audio cassette with a broad blue printed label and twin spool windows. Spool's note: "
					.. "\"Bring the last cassette back here.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_tape2",
				label = "Unsent message cassette",
			},
			benefits = {},
			recognition = "Spool's trusted contact",
		},
	},
})
