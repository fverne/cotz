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
			medium = "rp_garbage_cotz",
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
		workPrompt = "About the case I'm recovering.",
		offerPrompt = "Do you have a recovery job?",
		work = (
			"A marked case, brought back intact. Have a look at the return before you load yourself down. "
			.. "People become inventive about routes once they've got both hands full, and the inventions rarely "
			.. "improve my afternoon. Check the region before agreeing. I can wait while you prepare."
		),
		progressionPrompt = "What needs sorting out along the freight route?",
		progression = (
			"There's stranded freight and a crew's scattered records to bring through. I want the cases "
			.. "recovered and the accounts read before anyone supplies an ending. Some deliveries go to somebody "
			.. "who can check a particular part. Finish that handover, then come back here. I'll try to have "
			.. "cleared somewhere dry by then."
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
				"I need packing supplies for the loads coming through. It is easier to keep a load dry than "
				.. "explain afterwards why nobody thought of it. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
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
			id = "BA02",
			completionCash = 450,
			name = "The First Stranding",
			kind = "field",
			objective = (
				"Recover the stranded freight case from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"BA01"},
			briefing = (
				"A case has been left out along the route. Its owner has explained how urgent it is at greater "
				.. "length than how it got there. Recover the stranded freight case from the assigned search area in "
				.. "Marsh. Bring it back to me in Marsh."
			),
			completion = "You and the case, both here. Put it down gently; you've finished carrying it.",
			field = {
				description = (
					"A small yellow hard case with ribbed corners and a large label on its lid. Ballast's note: \"A "
					.. "case has been left out along the route.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_case",
				label = "Stranded freight case",
			},
			benefits = {},
		},
		{
			id = "BA03",
			completionCash = 0,
			name = "Nothing Left Behind",
			kind = "tracker",
			requires = {"BA02"},
			briefing = "Keep bringing the marked recovery cases back. Finding them is the beginning of the carrying.",
			completion = "A few good returns. You seem to think about the journey home.",
			target = 2,
			benefits = {},
		},
		{
			id = "BA04",
			completionCash = 650,
			name = "A small delivery",
			kind = "delivery",
			retiredCommission = true,
			objective = "Bring all 1 listed item type to this contact. The request shows each selected item and required units.",
			requires = {"BA02"},
			briefing = (
				"I need packing supplies for the loads coming through. It is easier to keep a load dry than "
				.. "explain afterwards why nobody thought of it. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BA05",
			completionCash = 575,
			name = "Fuel for the Return",
			kind = "delivery",
			requires = {"BA03"},
			briefing = (
				"I need packing supplies for the loads coming through. It is easier to keep a load dry than "
				.. "explain afterwards why nobody thought of it. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BA06",
			completionCash = 850,
			name = "A Missing Mooring",
			kind = "field",
			objective = (
				"Recover the landing maintenance tools from the assigned search area in Marsh. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"BA04"},
			briefing = (
				"There's a tool case left with the maintenance work. Tools are useful company, but only when "
				.. "somebody remembers to bring them home. Recover the landing maintenance tools from the assigned "
				.. "search area in Marsh. Bring it back to me in Marsh."
			),
			completion = "Handle's still attached. Better return than some I've seen.",
			field = {
				description = (
					"A handled tool case covered in bright stickers and contrasting printed decoration. Ballast's "
					.. "note: \"There's a tool case left with the maintenance work.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_tools",
				label = "Landing maintenance tools",
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
			briefing = "More recovery work. Leave yourself room for the case before you go looking.",
			completion = "You've been dependable about getting the load all the way here.",
			target = 5,
			benefits = {},
		},
		{
			id = "BA08",
			completionCash = 1050,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"BA06"},
			briefing = (
				"I need packing supplies for the loads coming through. It is easier to keep a load dry than "
				.. "explain afterwards why nobody thought of it. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BA09",
			completionCash = 875,
			name = "Names on the Manifest",
			kind = "delivery",
			requires = {"BA07"},
			briefing = (
				"I need packing supplies for the loads coming through. It is easier to keep a load dry than "
				.. "explain afterwards why nobody thought of it. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
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
			objective = (
				"Recover the crew route cassette from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"BA08"},
			briefing = (
				"There's a recording from the crew's route. I'd rather hear their own account before listening to "
				.. "another confident explanation. Recover the crew route cassette from the assigned search area in "
				.. "Marsh. Bring it back to me in Marsh."
			),
			completion = "Leave it here. I'll listen from the beginning, including the bits that don't sound important.",
			field = {
				description = (
					"A pale audio cassette with a handwritten dedication above the spool windows. Ballast's note: "
					.. "\"There's a recording from the crew's route.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_tape",
				label = "Crew route cassette",
			},
			benefits = {},
		},
		{
			id = "BA11",
			completionCash = 0,
			name = "Recover What Matters",
			kind = "tracker",
			requires = {"BA09"},
			briefing = "Continue the case recoveries. I prefer an intact return to an impressive departure.",
			completion = "Another proper set of returns. Not much to complain about there.",
			target = 9,
			benefits = {},
		},
		{
			id = "BA12",
			completionCash = 1450,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"BA10"},
			briefing = (
				"I need packing supplies for the loads coming through. It is easier to keep a load dry than "
				.. "explain afterwards why nobody thought of it. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_3",
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
			id = "BA13",
			completionCash = 1175,
			name = "Patch and Pack",
			kind = "delivery",
			requires = {"BA11"},
			briefing = (
				"I need packing supplies for the loads coming through. It is easier to keep a load dry than "
				.. "explain afterwards why nobody thought of it. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BA14",
			completionCash = 1650,
			name = "The Other Landing",
			kind = "field",
			objective = (
				"Recover the landing freight manifest from the assigned search area in Marsh. Deliver it to "
				.. "'Ledger' in Waystation, then come back to the issuing contact in Marsh."
			),
			requires = {"BA12"},
			briefing = (
				"Ledger needs the landing record. He packs things properly and remembers where he sent them; I try "
				.. "to return the courtesy. Recover the landing freight manifest from the assigned search area in "
				.. "Marsh. Deliver it to 'Ledger' in Waystation, then come back to me in Marsh."
			),
			completion = "Delivered? Good. One fewer parcel balanced between two explanations.",
			field = {
				description = (
					"A printed packing list on a small clipboard with a metal clip and a circular stamp. Ballast's "
					.. "note: \"Ledger needs the landing record.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_manifest",
				label = "Landing freight manifest",
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
			briefing = "There are still recovery orders worth taking. Pick the trip you can prepare for.",
			completion = "You've kept finishing the return walk. I notice that.",
			target = 14,
			benefits = {},
		},
		{
			id = "BA16",
			completionCash = 1850,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"BA14"},
			briefing = (
				"I need packing supplies for the loads coming through. It is easier to keep a load dry than "
				.. "explain afterwards why nobody thought of it. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BA17",
			completionCash = 1475,
			name = "A Boat in Reserve",
			kind = "delivery",
			requires = {"BA15"},
			briefing = (
				"I need packing supplies for the loads coming through. It is easier to keep a load dry than "
				.. "explain afterwards why nobody thought of it. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BA18",
			completionCash = 2050,
			name = "The Last Mooring",
			kind = "field",
			objective = (
				"Recover the crew personal records from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"BA16"},
			briefing = (
				"I want the crew's personal records kept together. Loose pages have a way of acquiring owners who "
				.. "remember only the convenient parts. Recover the crew personal records from the assigned search "
				.. "area in Marsh. Bring it back to me in Marsh."
			),
			completion = "I'll keep the papers dry. We can read them here.",
			field = {
				description = (
					"A cardboard file folder with an emblem and printed wording on the front. Ballast's note: \"I want "
					.. "the crew's personal records kept together.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_personnel",
				label = "Crew personal records",
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
			briefing = "Keep the recovery work going while I sort the freight records.",
			completion = "I'd trust you to bring a load through. You've given me reason enough.",
			target = 20,
			benefits = {},
		},
		{
			id = "BA20",
			completionCash = 2250,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"BA19"},
			briefing = (
				"I need packing supplies for the loads coming through. It is easier to keep a load dry than "
				.. "explain afterwards why nobody thought of it. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_4",
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
			id = "BA21",
			completionCash = 1775,
			name = "A Working Landing",
			kind = "delivery",
			requires = {"BA20"},
			briefing = (
				"I need packing supplies for the loads coming through. It is easier to keep a load dry than "
				.. "explain afterwards why nobody thought of it. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_4",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BA22",
			completionCash = 2450,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"BA21"},
			briefing = (
				"I need packing supplies for the loads coming through. It is easier to keep a load dry than "
				.. "explain afterwards why nobody thought of it. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_4",
					quantity = 1,
				},
			},
			benefits = {},
			recognition = "Ballast's trusted contact",
		},
	},
})
