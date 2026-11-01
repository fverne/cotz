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
	dialogue = {
		delivery = "Right, one moment. Let me find the matching entry.",
		completedGreeting = (
			"Oh, hello. Nice to have someone here I don't need to ask to repeat themselves through the "
			.. "interference."
		),
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Take the bearings, find the source, and bring the transmitter back. I'll listen to the recording "
			.. "here. Take the bearings properly rather than choosing the one that looks convenient. I'm fond of "
			.. "hearing people arrive where they meant to go."
		),
		progressionPrompt = "What else needs doing?",
		progression = (
			"I've got missing recordings and equipment to sort. Have a look while I finish listening. There are "
			.. "recordings to recover and equipment to keep usable. We can work through them without deciding in "
			.. "advance what every silence means."
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
				"I'm short of what's on this list. Bring it over when you can. Mind the receiver when "
				.. "you put it down. I'm trying to get ahead of the faults instead of chasing whichever one "
				.. "shouts loudest. A few decent components would be a start."
			),
			completion = (
				"Thanks. I'll put that where I can find it. Good timing. I'll keep these separate from "
				.. "the bits I'm still arguing with. That pile is less useful than it looks."
			),
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
			id = "SO02",
			completionCash = 450,
			name = "The Local Silence",
			kind = "field",
			objective = "Take the required bearings in Waystation and recover Red-Trimmed Control Unit. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"SO01"},
			briefing = "Triangulate and recover a transmitter near Waystation.",
			completion = "Give me a moment. I want to hear this properly.",
			field = {
				kind = "triangulation",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_control",
				label = "The Local Silence - Red-Trimmed Control Unit",
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
				"Take the bearings, find the source, and bring the transmitter back. I'll listen to the "
				.. "recording here."
			),
			completion = "You've brought back a useful set of sources. It's good to have something to listen to.",
			target = 2,
			benefits = {},
		},
		{
			id = "SO04",
			completionCash = 650,
			name = "The Station Log",
			kind = "field",
			objective = "Recover Handwritten Audio Cassette from the assigned search area in Waystation. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"SO02"},
			briefing = "Recover a failed station's recorder.",
			completion = "You found it. Leave it beside the receiver.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_tape",
				label = "The Station Log - Handwritten Audio Cassette",
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
				"I'm short of what's on this list. Bring it over when you can. Mind the receiver when you "
				.. "put it down."
			),
			completion = "Good. That's something I was running short of.",
			requirements = {
				{
					pool = "small_electronics",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "SO06",
			completionCash = 850,
			name = "The Crossed Bearings",
			kind = "field",
			objective = "Recover Numbered Data Module 0013 from the assigned search area in Waystation. Deliver it to"
				.. " 'Technut' in Marsh, then return here to finish the assignment.",
			requires = {"SO04"},
			briefing = "Recover a calibration record disputed by Smartass.",
			completion = "Good. I will let them know which entry it belongs with. Saves another call going in circles.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_module",
				label = "The Crossed Bearings - Numbered Data Module 0013",
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
				"Take the bearings, find the source, and bring the transmitter back. I'll listen to the "
				.. "recording here."
			),
			completion = "You've brought back a useful set of sources. It's good to have something to listen to.",
			target = 5,
			benefits = {},
		},
		{
			id = "SO08",
			completionCash = 1050,
			name = "The Absent Operator",
			kind = "field",
			objective = "Recover Red-Trimmed Control Unit from the assigned search area in Waystation. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"SO06"},
			briefing = "Locate a source and retrieve its recorded message.",
			completion = "Give me a moment. I want to hear this properly.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_control",
				label = "The Absent Operator - Red-Trimmed Control Unit",
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
				"I'm short of what's on this list. Bring it over when you can. Mind the receiver when you "
				.. "put it down."
			),
			completion = "Set it here. Mind the leads.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "SO10",
			completionCash = 1250,
			name = "Mute's Header",
			kind = "field",
			objective = "Recover Tape-Labelled Flash Drive from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SO08"},
			briefing = "Recover a damaged network record in Marsh.",
			completion = "You found it. Leave it beside the receiver.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_drive",
				label = "Mute's Header - Tape-Labelled Flash Drive",
			},
			benefits = {},
		},
		{
			id = "SO11",
			completionCash = 0,
			name = "Across the Static",
			kind = "tracker",
			requires = {"SO09"},
			briefing = (
				"Take the bearings, find the source, and bring the transmitter back. I'll listen to the "
				.. "recording here."
			),
			completion = "You've brought back a useful set of sources. It's good to have something to listen to.",
			target = 9,
			benefits = {},
		},
		{
			id = "SO12",
			completionCash = 1450,
			name = "The Garbage Relay",
			kind = "field",
			objective = "Recover Red-Trimmed Control Unit from the assigned search area in Waystation. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"SO10"},
			briefing = (
				"Locate and retrieve a source near a freight route. Take the time to check what the "
				.. "order actually needs. I'm tired enough to appreciate not sorting an avoidable mix-up "
				.. "afterwards."
			),
			completion = (
				"Thanks. I'll check the recording. Thanks for seeing it through. I'll finish the "
				.. "checking before I let myself get distracted by the receiver again."
			),
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_control",
				label = "The Garbage Relay - Red-Trimmed Control Unit",
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
				"I'm short of what's on this list. Bring it over when you can. Mind the receiver when you "
				.. "put it down."
			),
			completion = "Thanks. I'll put that where I can find it.",
			requirements = {
				{
					pool = "canned_food",
					quantity = 4,
				},
			},
			benefits = {},
		},
		{
			id = "SO14",
			completionCash = 1650,
			name = "The Unsent Call",
			kind = "field",
			objective = "Recover Blue-Label Audio Cassette from the assigned search area in Waystation. Deliver it to"
				.. " 'Wake' in Garbage, then return here to finish the assignment.",
			requires = {"SO12"},
			briefing = "Recover an expedition check-in recording in regional ruins.",
			completion = "Good. I will let them know which entry it belongs with. Saves another call going in circles.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_tape2",
				label = "The Unsent Call - Blue-Label Audio Cassette",
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
			briefing = (
				"Take the bearings, find the source, and bring the transmitter back. I'll listen to the "
				.. "recording here."
			),
			completion = "You've brought back a useful set of sources. It's good to have something to listen to.",
			target = 14,
			benefits = {},
		},
		{
			id = "SO16",
			completionCash = 1850,
			name = "The First Pripyat Call",
			kind = "field",
			objective = "Take the required bearings in Pripyat and recover Red-Trimmed Control Unit. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"SO14"},
			briefing = "Triangulate and collect a transmitter in Pripyat.",
			completion = "You found it. Leave it beside the receiver.",
			field = {
				kind = "triangulation",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_control",
				label = "The First Pripyat Call - Red-Trimmed Control Unit",
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
				"I'm short of what's on this list. Bring it over when you can. Mind the receiver when you "
				.. "put it down."
			),
			completion = "Good. That's something I was running short of.",
			requirements = {
				{
					pool = "small_electronics",
					quantity = 5,
				},
			},
			benefits = {},
		},
		{
			id = "SO18",
			completionCash = 2050,
			name = "The Last Check-in",
			kind = "field",
			objective = "Recover Handwritten Audio Cassette from the assigned search area in Pripyat. Deliver it to"
				.. " 'Wake' in Garbage, then return here to finish the assignment.",
			requires = {"SO16"},
			briefing = "Recover a second expedition recorder deeper in Pripyat.",
			completion = "Good. I will let them know which entry it belongs with. Saves another call going in circles.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_tape",
				label = "The Last Check-in - Handwritten Audio Cassette",
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
			briefing = (
				"Take the bearings, find the source, and bring the transmitter back. I'll listen to the "
				.. "recording here."
			),
			completion = "You've brought back a useful set of sources. It's good to have something to listen to.",
			target = 20,
			benefits = {},
		},
		{
			id = "SO20",
			completionCash = 2250,
			name = "The Receiver That Stayed On",
			kind = "field",
			objective = "Recover Red-Trimmed Control Unit from the assigned search area in Waystation. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"SO19"},
			briefing = "Locate and retrieve the expedition's final source.",
			completion = "Give me a moment. I want to hear this properly.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_control",
				label = "The Receiver That Stayed On - Red-Trimmed Control Unit",
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
				"I'm short of what's on this list. Bring it over when you can. Mind the receiver when you "
				.. "put it down."
			),
			completion = "Set it here. Mind the leads.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 6,
				},
			},
			benefits = {},
		},
		{
			id = "SO22",
			completionCash = 2450,
			name = "The Message Home",
			kind = "field",
			objective = "Recover Blue-Label Audio Cassette from the assigned search area in Waystation. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"SO21"},
			briefing = (
				"Recover the last unsent recording and return it to the station. Bring the cassette back here. "
				.. "Don't try to play it in the middle of the trip; let's get it somewhere we can listen properly."
			),
			completion = (
				"You found it. Leave it beside the receiver. Thanks. I'll listen when it's quiet enough to give it "
				.. "my attention. You spend enough time waiting for a call and you forget how strange it feels to "
				.. "have something definite in your hand."
			),
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_tape2",
				label = "The Message Home - Blue-Label Audio Cassette",
			},
			benefits = {},
			recognition = "Spool's trusted contact",
		},
	},
})
