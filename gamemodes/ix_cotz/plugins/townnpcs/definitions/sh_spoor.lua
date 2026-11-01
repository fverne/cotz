PLUGIN:Register("spoor", {
	name = "'Spoor'",
	template = "spoornpc",
	map = "mz_garbage",
	job = {
		kind = "hunting",
		category = "Mutant hunting",
		description = "Mutant hunting",
		quantities = {5, 9, 15},
	},
	supplies = {"12gauge", "22lr", "medic_bandage_1", "drink_bottlewater"},
	rewards = {
		packages = {
			{label = "Hunting ammunition",
				items = {"12gauge", "762x54", "762x51"}},
			{label = "Edge upkeep",
				items = {"sharpening_stone", "sharpening_stone_fine"}},
			{label = "Long hunt",
				items = {"food_raisins", "drink_bottlewater"}},
		},
	},
	dialogue = {
		delivery = "Set it down. Tell me if anything happened to it on the way.",
		completedGreeting = (
			"Hello. Seen anything worth a closer look? You know I'm happy to hear what you actually "
			.. "noticed."
		),
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Mutants on the routes. The job is to clear them, not to chase a trophy into another pack. Don't "
			.. "start firing before you've looked at the ground around you. There may be more using the area than "
			.. "the animal you came for."
		),
		progressionPrompt = "What else needs doing?",
		progression = (
			"Supplies and field observations. I'd like to know why the animals are moving, too. Bring the "
			.. "specimens we can examine and the observations left in the field. I'd like a clearer idea of what "
			.. "moves through here, not a larger pile of trophies."
		),
	},
	catalogue = {
		["12gaugedt"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["12gaugesg"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["12gaugemg"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["12gaugetr"] = {unlockContact = "brass", step = "BR21",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["22lrap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["22lrhp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["338lapua"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["338lapuaap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["338lapuahp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x51"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x51ap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x51hp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x54"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x54ap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x54hp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["lax44"] = {step = "SP17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["machete"] = {step = "SP05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mosin"] = {step = "SP11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["obrez"] = {step = "SP07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["saigasemi"] = {step = "SP11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sako85"] = {step = "SP11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sako85nato"] = {step = "SP07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["svt40"] = {step = "SP17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sw500"] = {step = "SP17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["w1895"] = {step = "SP07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["w9422357"] = {step = "SP11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "SP01",
			completionCash = 275,
			name = "Reading the Remains",
			kind = "delivery",
			requires = {},
			briefing = (
				"Bring what's listed here. Keep it in good condition; I need to examine it. Keep the "
				.. "specimen as it is. Cleaning away something you find unpleasant can remove the thing I "
				.. "wanted to see."
			),
			completion = (
				"Let me check the condition. Good. Leave it there while I look. There's no need to make "
				.. "a story out of it before we've started."
			),
			requirements = {
				{
					pool = "common_parts",
					quantity = 1,
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
			id = "SP02",
			completionCash = 450,
			name = "The Scavenger's Camp",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SP01"},
			briefing = "Recover observations beside a Garbage hunting ground.",
			completion = "Where you found it is marked? Good.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "The Scavenger's Camp - Tied Leather Journal",
			},
			benefits = {},
		},
		{
			id = "SP03",
			completionCash = 0,
			name = "Clear the Approach",
			kind = "tracker",
			requires = {"SP02"},
			briefing = "Mutants on the routes. The job is to clear them, not to chase a trophy into another pack.",
			completion = "You've cleared enough trouble for now. Keep watching where the others go.",
			target = 2,
			benefits = {},
		},
		{
			id = "SP04",
			completionCash = 650,
			name = "Where They Feed",
			kind = "field",
			objective = "Recover Handwritten Audio Cassette from the assigned search area in Garbage. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"SP02"},
			briefing = "Retrieve a recorder from a feeding site.",
			completion = "Let me look at the observations.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_tape",
				label = "Where They Feed - Handwritten Audio Cassette",
			},
			benefits = {},
		},
		{
			id = "SP05",
			completionCash = 575,
			name = "Tools for the Field",
			kind = "delivery",
			requires = {"SP03"},
			briefing = "Bring what's listed here. Keep it in good condition; I need to examine it.",
			completion = "Good. Keep it out of the sun.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "SP06",
			completionCash = 850,
			name = "Lemon's Complaint",
			kind = "field",
			objective = "Recover Scientist's Field Diary from the assigned search area in Garbage. Deliver it to"
				.. " 'Jitters' in Marsh, then return here to finish the assignment.",
			requires = {"SP04"},
			briefing = "Recover meat-handling notes from an abandoned camp.",
			completion = "Good. They have the record. Now we can compare what was actually found.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_diary",
				label = "Lemon's Complaint - Scientist's Field Diary",
				recipient = "jitters",
			},
			benefits = {
				items = {
					{
						item = "22lr",
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
			id = "SP07",
			completionCash = 0,
			name = "A Safer Yard",
			kind = "tracker",
			requires = {"SP05"},
			briefing = "Mutants on the routes. The job is to clear them, not to chase a trophy into another pack.",
			completion = "You've cleared enough trouble for now. Keep watching where the others go.",
			target = 5,
			benefits = {},
		},
		{
			id = "SP08",
			completionCash = 1050,
			name = "The Displaced Pack",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SP06"},
			briefing = "Recover observations from a second hunting ground.",
			completion = "Where you found it is marked? Good.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "The Displaced Pack - Tied Leather Journal",
			},
			benefits = {},
		},
		{
			id = "SP09",
			completionCash = 875,
			name = "Different Quarry",
			kind = "delivery",
			requires = {"SP07"},
			briefing = "Bring what's listed here. Keep it in good condition; I need to examine it.",
			completion = "That will be useful.",
			requirements = {
				{
					pool = "common_parts",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "SP10",
			completionCash = 1250,
			name = "Tracks in the Wrong Place",
			kind = "field",
			objective = "Recover Numbered Data Module 0013 from the assigned search area in Garbage. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"SP08"},
			briefing = "Collect a recorder along a disturbed regional route.",
			completion = "Let me look at the observations.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_module",
				label = "Tracks in the Wrong Place - Numbered Data Module 0013",
			},
			benefits = {},
		},
		{
			id = "SP11",
			completionCash = 0,
			name = "Patient Work",
			kind = "tracker",
			requires = {"SP09"},
			briefing = "Mutants on the routes. The job is to clear them, not to chase a trophy into another pack.",
			completion = "You've cleared enough trouble for now. Keep watching where the others go.",
			target = 9,
			benefits = {},
		},
		{
			id = "SP12",
			completionCash = 1450,
			name = "The Empty Hide",
			kind = "field",
			objective = "Recover Personnel File Folder from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SP10"},
			briefing = (
				"Recover a hunter's case at a remote observation site. Check the order and bring what I "
				.. "can use. Time spent preparing is easier to spare here than after you've left."
			),
			completion = (
				"Set it here. I'll compare the records. That helps. I'll check it properly before we "
				.. "decide what comes next."
			),
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_personnel",
				label = "The Empty Hide - Personnel File Folder",
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
			id = "SP13",
			completionCash = 1175,
			name = "Proof of Change",
			kind = "delivery",
			requires = {"SP11"},
			briefing = "Bring what's listed here. Keep it in good condition; I need to examine it.",
			completion = "Let me check the condition.",
			requirements = {
				{
					pool = "common_parts",
					quantity = 2,
				},
			},
			benefits = {},
		},
		{
			id = "SP14",
			completionCash = 1650,
			name = "The Pattern Breaks",
			kind = "field",
			objective = "Recover Numbered Data Module 0022 from the assigned search area in Waystation. Deliver it to"
				.. " 'Atlas' in Marsh, then return here to finish the assignment.",
			requires = {"SP12"},
			briefing = "Retrieve a survey recorder in Waystation territory.",
			completion = "Good. They have the record. Now we can compare what was actually found.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_module2",
				label = "The Pattern Breaks - Numbered Data Module 0022",
				recipient = "atlas",
			},
			benefits = {},
		},
		{
			id = "SP15",
			completionCash = 0,
			name = "No Easy Quarry",
			kind = "tracker",
			requires = {"SP13"},
			briefing = "Mutants on the routes. The job is to clear them, not to chase a trophy into another pack.",
			completion = "You've cleared enough trouble for now. Keep watching where the others go.",
			target = 14,
			benefits = {},
		},
		{
			id = "SP16",
			completionCash = 1850,
			name = "The First Pripyat Trail",
			kind = "field",
			objective = "Recover Scientist's Field Diary from the assigned search area in Pripyat. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SP14"},
			briefing = "Recover an observer's notebook at a Pripyat hunting site.",
			completion = "Let me look at the observations.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_diary",
				label = "The First Pripyat Trail - Scientist's Field Diary",
			},
			benefits = {},
		},
		{
			id = "SP17",
			completionCash = 1475,
			name = "Preparing for the Worst",
			kind = "delivery",
			requires = {"SP15"},
			briefing = "Bring what's listed here. Keep it in good condition; I need to examine it.",
			completion = "Good. Keep it out of the sun.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 5,
				},
			},
			benefits = {},
		},
		{
			id = "SP18",
			completionCash = 2050,
			name = "The Survivor's Cache",
			kind = "field",
			objective = "Recover Striped Equipment Case from the assigned search area in Pripyat. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SP16"},
			briefing = "Recover a hunter's abandoned case deeper in Pripyat.",
			completion = "Set it here. I'll compare the records.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_equipment",
				label = "The Survivor's Cache - Striped Equipment Case",
			},
			benefits = {
				items = {
					{
						item = "22lr",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "SP19",
			completionCash = 0,
			name = "The Dangerous Ones",
			kind = "tracker",
			requires = {"SP17", "SP18"},
			briefing = "Mutants on the routes. The job is to clear them, not to chase a trophy into another pack.",
			completion = "You've cleared enough trouble for now. Keep watching where the others go.",
			target = 20,
			benefits = {},
		},
		{
			id = "SP20",
			completionCash = 2250,
			name = "The Last Observation",
			kind = "field",
			objective = "Recover Blue-Label Audio Cassette from the assigned search area in Pripyat. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"SP19"},
			briefing = "Retrieve the target species' observation recorder in Pripyat.",
			completion = "Where you found it is marked? Good.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_tape2",
				label = "The Last Observation - Blue-Label Audio Cassette",
			},
			benefits = {},
			stock = {
				item = "12gauge",
				bonus = 2,
			},
		},
		{
			id = "SP21",
			completionCash = 1775,
			name = "What the Records Missed",
			kind = "delivery",
			requires = {"SP20"},
			briefing = "Bring what's listed here. Keep it in good condition; I need to examine it.",
			completion = "That will be useful.",
			requirements = {
				{
					pool = "common_parts",
					quantity = 2,
				},
			},
			benefits = {},
		},
		{
			id = "SP22",
			completionCash = 2450,
			name = "The Hunter's Proof",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"SP21"},
			briefing = (
				"Recover the final hunting observations in Garbage. Bring the journal back with "
				.. "the pages in order; observations are harder to judge when somebody has helpfully rearranged them."
			),
			completion = (
				"Let me look at the observations. I'll read these against what we've already got. You've kept "
				.. "bringing back things worth looking at. That's useful work, even on the days when it doesn't give "
				.. "us a neat answer."
			),
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_notebook",
				label = "The Hunter's Proof - Tied Leather Journal",
			},
			benefits = {},
			recognition = "Spoor's trusted contact",
		},
	},
})
