PLUGIN:Register("ballast", {
	name = "'Ballast'",
	template = "ballastnpc",
	map = "rp_marsh_cs",
	job = {
		kind = "recovery",
		category = "Equipment recovery",
		description = "Equipment recovery",
		maps = {
			easy = "rp_marsh_cs",
			medium = "mz_garbage",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Recovery provisions",
				items = {"food_can_tushonka", "drink_bottlewater"}},
			{label = "Wet-work injuries",
				items = {"medic_bandage_1", "drug_painkillers"}},
			{label = "Overnight supplies",
				items = {"lowtiercookerfuel", "food_can_beans"}},
		},
	},
	dialogue = {
		delivery = "Over here. If it is still dry, we are off to a good start.",
		completedGreeting = (
			"Back with both boots, I see. Always a promising start to a conversation. What do you need?"
		),
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Recover the marked case and bring it back intact. Think about the weight before you climb down for "
			.. "it. Have a look at the way out before you load yourself down. Finding a case and getting it home "
			.. "are two different amounts of effort."
		),
		progressionPrompt = "What else needs doing?",
		progression = (
			"There are stranded cases and missing freight records. Tell me which one you're going after. Some "
			.. "freight needs collecting. Some needs records straightened out so it stops being everyone else's "
			.. "responsibility. Neither improves by sitting here arguing about it."
		),
	},
	catalogue = {
	},
	progression = {
		{
			id = "BA01",
			completionCash = 275,
			name = "A Dry Package",
			kind = "delivery",
			requires = {},
			briefing = (
				"I need these supplies. Bring them here, and leave yourself room to carry your own kit. "
				.. "Leave enough room for your own things. Starting a supply job by making yourself "
				.. "helpless is a peculiar way to be useful."
			),
			completion = (
				"Set it down. No need to throw it. Dry enough, and you're not bent double. A perfectly "
				.. "respectable start."
			),
			requirements = {
				{
					pool = "field_maintenance",
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
			id = "BA02",
			completionCash = 450,
			name = "The First Stranding",
			kind = "field",
			objective = "Recover Small Yellow Transit Case from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"BA01"},
			briefing = "Recover a shipment case on a Marsh shore.",
			completion = "Dry enough. Let's have a look.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_case",
				label = "The First Stranding - Small Yellow Transit Case",
			},
			benefits = {},
		},
		{
			id = "BA03",
			completionCash = 0,
			name = "Nothing Left Behind",
			kind = "tracker",
			requires = {"BA02"},
			briefing = (
				"Recover the marked case and bring it back intact. Think about the weight before you climb "
				.. "down for it."
			),
			completion = "You've brought enough cargo back for me to know you can carry it without losing half of it.",
			target = 2,
			benefits = {},
		},
		{
			id = "BA04",
			completionCash = 650,
			name = "The Rotten Landing",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"BA02"},
			briefing = "Retrieve a landing inspection record.",
			completion = "You and the case made it back. That's a start.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "The Rotten Landing - Tied Leather Journal",
			},
			benefits = {},
		},
		{
			id = "BA05",
			completionCash = 575,
			name = "Fuel for the Return",
			kind = "delivery",
			requires = {"BA03"},
			briefing = "I need these supplies. Bring them here, and leave yourself room to carry your own kit.",
			completion = "That's what I asked for.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "BA06",
			completionCash = 850,
			name = "A Missing Mooring",
			kind = "field",
			objective = "Recover Stickered Tool Case from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"BA04"},
			briefing = "Recover a landing maintenance case.",
			completion = "Leave it here. I'll check the contents.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_tools",
				label = "A Missing Mooring - Stickered Tool Case",
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
			id = "BA07",
			completionCash = 0,
			name = "A Reliable Pair of Hands",
			kind = "tracker",
			requires = {"BA05"},
			briefing = (
				"Recover the marked case and bring it back intact. Think about the weight before you climb "
				.. "down for it."
			),
			completion = "You've brought enough cargo back for me to know you can carry it without losing half of it.",
			target = 5,
			benefits = {},
		},
		{
			id = "BA08",
			completionCash = 1050,
			name = "The Crew List",
			kind = "field",
			objective = "Recover Personnel File Folder from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"BA06"},
			briefing = "Recover a missing crew's roster from a shore cache.",
			completion = "Dry enough. Let's have a look.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_personnel",
				label = "The Crew List - Personnel File Folder",
			},
			benefits = {},
		},
		{
			id = "BA09",
			completionCash = 875,
			name = "Names on the Manifest",
			kind = "delivery",
			requires = {"BA07"},
			briefing = "I need these supplies. Bring them here, and leave yourself room to carry your own kit.",
			completion = "Good. I'll stow it properly.",
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BA10",
			completionCash = 1250,
			name = "The Floating Trail",
			kind = "field",
			objective = "Recover Handwritten Audio Cassette from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"BA08"},
			briefing = "Recover the crew's recorder near a remote Marsh water route.",
			completion = "You and the case made it back. That's a start.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_tape",
				label = "The Floating Trail - Handwritten Audio Cassette",
			},
			benefits = {},
		},
		{
			id = "BA11",
			completionCash = 0,
			name = "Recover What Matters",
			kind = "tracker",
			requires = {"BA09"},
			briefing = (
				"Recover the marked case and bring it back intact. Think about the weight before you climb "
				.. "down for it."
			),
			completion = "You've brought enough cargo back for me to know you can carry it without losing half of it.",
			target = 9,
			benefits = {},
		},
		{
			id = "BA12",
			completionCash = 1450,
			name = "The Disputed Cargo",
			kind = "field",
			objective = "Recover Orange Evidence Case from the assigned search area in Garbage. Deliver it to 'Brass'"
				.. " in Garbage, then return here to finish the assignment.",
			requires = {"BA10"},
			briefing = (
				"Retrieve shipment evidence at a Garbage freight site. Brass gets the case in Garbage. "
				.. "Then come back here. He can argue the figures; I just want the delivery finished "
				.. "properly."
			),
			completion = (
				"Delivered dry, I hope. Good. That is one less parcel sitting between two names. Brass "
				.. "can check what he has now. That saves me trying to settle an argument while the "
				.. "evidence is still outside."
			),
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_evidence",
				label = "The Disputed Cargo - Orange Evidence Case",
				recipient = "brass",
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
			id = "BA13",
			completionCash = 1175,
			name = "Patch and Pack",
			kind = "delivery",
			requires = {"BA11"},
			briefing = "I need these supplies. Bring them here, and leave yourself room to carry your own kit.",
			completion = "Set it down. No need to throw it.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 4,
				},
			},
			benefits = {},
		},
		{
			id = "BA14",
			completionCash = 1650,
			name = "The Other Landing",
			kind = "field",
			objective = "Recover Warehouse Packing List A from the assigned search area in Marsh. Deliver it to"
				.. " 'Ledger' in Waystation, then return here to finish the assignment.",
			requires = {"BA12"},
			briefing = "Recover a landing record at a regional supply stop.",
			completion = "Delivered dry, I hope. Good. That is one less parcel sitting between two names.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_manifest",
				label = "The Other Landing - Warehouse Packing List A",
				recipient = "ledger",
			},
			benefits = {},
		},
		{
			id = "BA15",
			completionCash = 0,
			name = "The Long Haul Back",
			kind = "tracker",
			requires = {"BA13"},
			briefing = (
				"Recover the marked case and bring it back intact. Think about the weight before you climb "
				.. "down for it."
			),
			completion = "You've brought enough cargo back for me to know you can carry it without losing half of it.",
			target = 14,
			benefits = {},
		},
		{
			id = "BA16",
			completionCash = 1850,
			name = "A Voice From Shore",
			kind = "field",
			objective = "Recover Blue-Label Audio Cassette from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"BA14"},
			briefing = "Retrieve the crew's recorded message at an abandoned camp.",
			completion = "You and the case made it back. That's a start.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_tape2",
				label = "A Voice From Shore - Blue-Label Audio Cassette",
			},
			benefits = {},
		},
		{
			id = "BA17",
			completionCash = 1475,
			name = "A Boat in Reserve",
			kind = "delivery",
			requires = {"BA15"},
			briefing = "I need these supplies. Bring them here, and leave yourself room to carry your own kit.",
			completion = "That's what I asked for.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 5,
				},
			},
			benefits = {},
		},
		{
			id = "BA18",
			completionCash = 2050,
			name = "The Last Mooring",
			kind = "field",
			objective = "Recover Personnel File Folder from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"BA16"},
			briefing = "Recover the crew's final personal case.",
			completion = "Leave it here. I'll check the contents.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_personnel",
				label = "The Last Mooring - Personnel File Folder",
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
			id = "BA19",
			completionCash = 0,
			name = "Safe to Bring Home",
			kind = "tracker",
			requires = {"BA17", "BA18"},
			briefing = (
				"Recover the marked case and bring it back intact. Think about the weight before you climb "
				.. "down for it."
			),
			completion = "You've brought enough cargo back for me to know you can carry it without losing half of it.",
			target = 20,
			benefits = {},
		},
		{
			id = "BA20",
			completionCash = 2250,
			name = "The Missing Logbook",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Marsh. Deliver it to 'Carbon'"
				.. " in Waystation, then return here to finish the assignment.",
			requires = {"BA19"},
			briefing = "Recover a regional landing log proving what happened.",
			completion = "Delivered dry, I hope. Good. That is one less parcel sitting between two names.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_notebook",
				label = "The Missing Logbook - Tied Leather Journal",
				recipient = "carbon",
			},
			benefits = {},
			stock = {
				item = "drink_bottlewater",
				bonus = 2,
			},
		},
		{
			id = "BA21",
			completionCash = 1775,
			name = "A Working Landing",
			kind = "delivery",
			requires = {"BA20"},
			briefing = "I need these supplies. Bring them here, and leave yourself room to carry your own kit.",
			completion = "Good. I'll stow it properly.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 6,
				},
			},
			benefits = {},
		},
		{
			id = "BA22",
			completionCash = 2450,
			name = "The First Return Cargo",
			kind = "field",
			objective = "Recover Small Yellow Transit Case from the assigned search area in Marsh. Deliver it to"
				.. " 'Ledger' in Waystation, then return here to finish the assignment.",
			requires = {"BA21"},
			briefing = (
				"Complete one recovery along the supply route. The case goes to Ledger in Waystation. After that, "
				.. "come back here. I want to hear you've finished the return journey as well."
			),
			completion = (
				"Delivered dry, I hope. Good. That is one less parcel sitting between two names. Good. Ledger has "
				.. "the case and you're back to tell me. I can put that job down without wondering about either of "
				.. "you. You'd be surprised how pleasant that is."
			),
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_case",
				label = "The First Return Cargo - Small Yellow Transit Case",
				recipient = "ledger",
			},
			benefits = {},
			recognition = "Ballast's trusted contact",
		},
	},
})
