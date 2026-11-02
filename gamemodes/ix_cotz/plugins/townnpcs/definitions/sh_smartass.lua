PLUGIN:Register("smartass", {
	name = "'Smartass'",
	template = "unisgnpc3",
	map = "rp_waystation",
	job = {
		kind = "dataExtract",
		category = "Computer data extraction",
		description = "Extract data from %d computer types using the issued flash drive.",
		quantities = {1, 2, 5},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Electronics stock (trade goods)",
				items = {"value_capacitors", "value_pcpart_ram", "value_pcpart_cpu"}},
			{label = "Overtime",
				items = {"drug_caffeine", "drink_energydrink_2"}},
			{label = "Extraction provisions",
				items = {"drink_bottlewater", "food_raisins"}},
		},
		bonusItems = {
			"pso1",
			"cmore",
			"acog",
			"shortdot",
			"nightforce",
			"cobrasuppressor",
			"pbssuppressor",
			"sakersuppressor",
			"tundrasuppressor",
		},
	},
	dialogue = {
		completedGreeting = (
			"You again. At least I can reasonably expect something useful to come of the interruption. "
			.. "What is it?"
		),
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"I need data extracted from the computers on the assignment. Take the issued flash drive, "
			.. "find the computers, and let each extraction finish. Bring the results back. Half the data "
			.. "and a very confident explanation still leaves me with half the data."
		),
		progressionPrompt = "What else needs doing?",
		progression = (
			"There are records to recover and supplies to stop the equipment becoming an expensive "
			.. "ornament. Pick something useful. Read the details before you leave, and I'll do my best to "
			.. "save the difficult remarks until you get back."
		),
	},
	catalogue = {
		["acog"] = {step = "SM03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["cmore"] = {step = "SM01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["cobrasuppressor"] = {step = "SM05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["nightforce"] = {step = "SM05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["pbssuppressor"] = {step = "SM05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["pso1"] = {step = "SM01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sakersuppressor"] = {step = "SM05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["shortdot"] = {step = "SM03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["tundrasuppressor"] = {step = "SM05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "SM01",
			completionCash = 275,
			name = "Something to Listen With",
			kind = "delivery",
			requires = {},
			briefing = (
				"Bring the small electronics on this list. I need a few things in working order before I "
				.. "start asking anyone to go near a computer. If you find something interesting on the way, "
				.. "resist the urge to take it apart with your knife."
			),
			completion = (
				"Good. Let me check these. You brought what I asked for and didn't demonstrate your repair "
				.. "technique on them. We're already ahead of several people I could name."
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
			id = "SM02",
			completionCash = 450,
			name = "The Lost Beacon",
			kind = "field",
			objective = "Take the required bearings in Garbage and recover Red-Trimmed Control Unit. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"SM01"},
			briefing = "Triangulate and recover a source in Garbage.",
			completion = "Let's hear what all the fuss was about.",
			field = {
				kind = "triangulation",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_control",
				label = "The Lost Beacon - Red-Trimmed Control Unit",
			},
			benefits = {},
		},
		{
			id = "SM03",
			completionCash = 0,
			name = "Three Bearings",
			kind = "tracker",
			requires = {"SM02"},
			briefing = (
				"Take the bearings, find the transmitter, bring it back. Pointing in a promising direction "
				.. "isn't a bearing."
			),
			completion = "You've found enough sources that I'm starting to believe the bearings aren't luck.",
			target = 2,
			benefits = {},
		},
		{
			id = "SM04",
			completionCash = 650,
			name = "The Wrong Frequency",
			kind = "field",
			objective = "Recover Numbered Data Module 0013 from the assigned search area in Garbage. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"SM02"},
			briefing = "Recover a beacon calibration record.",
			completion = "Hand it over. I'll see whether it agrees with the last one.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_module",
				label = "The Wrong Frequency - Numbered Data Module 0013",
			},
			benefits = {},
		},
		{
			id = "SM05",
			completionCash = 575,
			name = "Mounts and Glass",
			kind = "delivery",
			requires = {"SM03"},
			briefing = "Bring the supplies on the list. The list is the useful bit; the excuse can stay with you.",
			completion = "Put it there. I'll check it.",
			requirements = {
				{
					pool = "small_electronics",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "SM06",
			completionCash = 850,
			name = "The Interference Site",
			kind = "field",
			objective = "Take the required bearings in Garbage and recover Red-Trimmed Control Unit. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"SM04"},
			briefing = "Take bearings and recover a jammer's field record.",
			completion = "Good. Something I can actually check.",
			field = {
				kind = "triangulation",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_control",
				label = "The Interference Site - Red-Trimmed Control Unit",
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
			id = "SM07",
			completionCash = 0,
			name = "Less Guesswork",
			kind = "tracker",
			requires = {"SM05"},
			briefing = (
				"Take the bearings, find the transmitter, bring it back. Pointing in a promising direction "
				.. "isn't a bearing."
			),
			completion = "You've found enough sources that I'm starting to believe the bearings aren't luck.",
			target = 5,
			benefits = {},
		},
		{
			id = "SM08",
			completionCash = 1050,
			name = "Spool's Correction",
			kind = "field",
			objective = "Recover Numbered Data Module 0022 from the assigned search area in Garbage. Deliver it to"
				.. " 'Spool' in Garbage, then return here to finish the assignment.",
			requires = {"SM06"},
			briefing = "Recover a disputed signal recorder along a freight route.",
			completion = "It reached the right desk. Miracles do happen. I will mark it off.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_module2",
				label = "Spool's Correction - Numbered Data Module 0022",
				recipient = "spool",
			},
			benefits = {},
		},
		{
			id = "SM09",
			completionCash = 875,
			name = "An Honest Test",
			kind = "delivery",
			requires = {"SM07"},
			briefing = "Bring the supplies on the list. The list is the useful bit; the excuse can stay with you.",
			completion = "Good. The parts, rather than an explanation of why you forgot them.",
			requirements = {
				{
					pool = "small_electronics",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "SM10",
			completionCash = 1250,
			name = "The False Beacon",
			kind = "field",
			objective = "Take the required bearings in Garbage and recover Red-Trimmed Control Unit. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"SM08"},
			briefing = "Triangulate and recover a deliberately misleading source.",
			completion = "Hand it over. I'll see whether it agrees with the last one.",
			field = {
				kind = "triangulation",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_control",
				label = "The False Beacon - Red-Trimmed Control Unit",
			},
			benefits = {},
		},
		{
			id = "SM11",
			completionCash = 0,
			name = "Still on Bearing",
			kind = "tracker",
			requires = {"SM09"},
			briefing = (
				"Take the bearings, find the transmitter, bring it back. Pointing in a promising direction "
				.. "isn't a bearing."
			),
			completion = "You've found enough sources that I'm starting to believe the bearings aren't luck.",
			target = 9,
			benefits = {},
		},
		{
			id = "SM12",
			completionCash = 1450,
			name = "The Receiver List",
			kind = "field",
			objective = "Recover Corporate Records Folder from the assigned search area in Waystation. Deliver it to"
				.. " 'Quartermaster' in Waystation, then return here to finish the assignment.",
			requires = {"SM10"},
			briefing = "Recover a receiver register in Waystation territory.",
			completion = "It reached the right desk. Miracles do happen. I will mark it off.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_archive",
				label = "The Receiver List - Corporate Records Folder",
				recipient = "quartermaster",
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
			id = "SM13",
			completionCash = 1175,
			name = "Quiet Equipment",
			kind = "delivery",
			requires = {"SM11"},
			briefing = (
				"Bring the supplies on the list. The list is the useful bit; the excuse can stay with "
				.. "you. Read the instruction through before doing the clever part. Particularly if the "
				.. "clever part involves deciding you don't need the instruction."
			),
			completion = (
				"Yes, that will do. Try not to look so surprised. That gives me something to check. Stay "
				.. "there a moment; I may even manage it without making you explain the obvious twice."
			),
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 4,
				},
			},
			benefits = {},
		},
		{
			id = "SM14",
			completionCash = 1650,
			name = "Mute's Missing Packet",
			kind = "field",
			objective = "Recover Tape-Labelled Flash Drive from the assigned search area in Garbage. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"SM12"},
			briefing = "Recover a diagnostic recording at a remote relay.",
			completion = "Let's hear what all the fuss was about.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_drive",
				label = "Mute's Missing Packet - Tape-Labelled Flash Drive",
			},
			benefits = {},
		},
		{
			id = "SM15",
			completionCash = 0,
			name = "Better Than Luck",
			kind = "tracker",
			requires = {"SM13"},
			briefing = (
				"Take the bearings, find the transmitter, bring it back. Pointing in a promising direction "
				.. "isn't a bearing."
			),
			completion = "You've found enough sources that I'm starting to believe the bearings aren't luck.",
			target = 14,
			benefits = {},
		},
		{
			id = "SM16",
			completionCash = 1850,
			name = "A Signal Across Maps",
			kind = "field",
			objective = "Take the required bearings in Garbage and recover Red-Trimmed Control Unit. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"SM14"},
			briefing = "Take bearings at a regional transmitter site.",
			completion = "Hand it over. I'll see whether it agrees with the last one.",
			field = {
				kind = "triangulation",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_control",
				label = "A Signal Across Maps - Red-Trimmed Control Unit",
			},
			benefits = {},
		},
		{
			id = "SM17",
			completionCash = 1475,
			name = "Packed for the Roofs",
			kind = "delivery",
			requires = {"SM15"},
			briefing = "Bring the supplies on the list. The list is the useful bit; the excuse can stay with you.",
			completion = "Put it there. I'll check it.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 5,
				},
			},
			benefits = {},
		},
		{
			id = "SM18",
			completionCash = 2050,
			name = "The Rooftop Source",
			kind = "field",
			objective = "Recover Red-Trimmed Control Unit from the assigned search area in Pripyat. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SM16"},
			briefing = "Locate and recover a transmitter at a Pripyat signal site.",
			completion = "Good. Something I can actually check.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_control",
				label = "The Rooftop Source - Red-Trimmed Control Unit",
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
			id = "SM19",
			completionCash = 0,
			name = "No More False Positives",
			kind = "tracker",
			requires = {"SM17"},
			briefing = (
				"Take the bearings, find the transmitter, bring it back. Pointing in a promising direction "
				.. "isn't a bearing."
			),
			completion = "You've found enough sources that I'm starting to believe the bearings aren't luck.",
			target = 20,
			benefits = {},
		},
		{
			id = "SM20",
			completionCash = 2250,
			name = "The Handler's Record",
			kind = "field",
			objective = "Recover Handwritten Audio Cassette from the assigned search area in Pripyat. Deliver it to"
				.. " 'Carbon' in Waystation, then return here to finish the assignment.",
			requires = {"SM18"},
			briefing = "Recover the operation's command recording in Pripyat.",
			completion = "It reached the right desk. Miracles do happen. I will mark it off.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_tape",
				label = "The Handler's Record - Handwritten Audio Cassette",
				recipient = "carbon",
			},
			benefits = {},
		},
		{
			id = "SM21",
			completionCash = 1775,
			name = "The Last Calibration",
			kind = "delivery",
			requires = {"SM19", "SM20"},
			briefing = "Bring the supplies on the list. The list is the useful bit; the excuse can stay with you.",
			completion = "Good. The parts, rather than an explanation of why you forgot them.",
			requirements = {
				{
					pool = "small_electronics",
					quantity = 6,
				},
			},
			benefits = {},
		},
		{
			id = "SM22",
			completionCash = 2450,
			name = "Two Signals One Source",
			kind = "field",
			objective = "Recover Red-Trimmed Control Unit from the assigned search area in Pripyat. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SM21"},
			briefing = "Locate and recover a transmitter in Pripyat.",
			completion = "Hand it over. I'll see whether it agrees with the last one.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_control",
				label = "Two Signals One Source - Red-Trimmed Control Unit",
			},
			benefits = {},
		},
		{
			id = "SM23",
			completionCash = 0,
			name = "Found You",
			kind = "tracker",
			requires = {"SM22"},
			briefing = (
				"Take the bearings, find the transmitter, bring it back. Pointing in a promising direction "
				.. "isn't a bearing."
			),
			completion = "You've found enough sources that I'm starting to believe the bearings aren't luck.",
			target = 27,
			benefits = {},
		},
		{
			id = "SM24",
			completionCash = 2650,
			name = "The Silent Frequency",
			kind = "field",
			objective = "Recover Tagged Security Flash Drive from the assigned search area in Garbage. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"SM23"},
			briefing = (
				"Recover the operation's last transmitter and return its records. Bring the drive here before "
				.. "deciding what the records mean. Yes, even if you have a magnificent theory already prepared."
			),
			completion = (
				"Good. Something I can actually check. All right. I'll check it properly. You've done enough work "
				.. "that I won't waste your time pretending it was nothing. Don't spread that around; people will "
				.. "expect me to be agreeable."
			),
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_security",
				label = "The Silent Frequency - Tagged Security Flash Drive",
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
			recognition = "Smartass's trusted contact",
		},
	},
})
