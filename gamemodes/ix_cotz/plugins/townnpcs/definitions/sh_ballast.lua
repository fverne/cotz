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
				"I need the maintenance supplies on this list. Bring them here and I'll put them with the "
				.. "cargo gear. No point discovering a fastening has failed once the package is halfway down a "
				.. "bank and both hands are occupied."
			),
			completion = (
				"Good. Set them down there. I'll check the gear before I need it, which is a habit I "
				.. "recommend even when there isn't an audience to admire it."
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
			name = "The Rotten Landing",
			kind = "field",
			objective = (
				"Recover the landing inspection journal from the assigned search area in Marsh. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"BA02"},
			briefing = (
				"I'd like the inspection journal before anyone tells me that landing was perfectly sound when they "
				.. "last used it. Recover the landing inspection journal from the assigned search area in Marsh. "
				.. "Bring it back to me in Marsh."
			),
			completion = "Good. I'll read what the inspector actually checked.",
			field = {
				description = (
					"A thick brown journal held together by a narrow tie around its cover. Ballast's note: \"I'd like "
					.. "the inspection journal before anyone tells me that landing was perfectly sound when they last "
					.. "used it.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "Landing inspection journal",
			},
			benefits = {},
		},
		{
			id = "BA05",
			completionCash = 575,
			name = "Fuel for the Return",
			kind = "delivery",
			requires = {"BA03"},
			briefing = "I need the listed supplies brought here. Leave enough room to carry your own kit home too.",
			completion = "Put it down gently. That's a useful load.",
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
			name = "The Crew List",
			kind = "field",
			objective = (
				"Recover the missing crew roster from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"BA06"},
			briefing = (
				"I want the crew roster. People remember who was supposed to travel, then start treating that as "
				.. "who actually went. Recover the missing crew roster from the assigned search area in Marsh. Bring "
				.. "it back to me in Marsh."
			),
			completion = "Let me lay it flat. I'll go through the names without an audience at my shoulder.",
			field = {
				description = (
					"A cardboard file folder with an emblem and printed wording on the front. Ballast's note: \"I want "
					.. "the crew roster.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_personnel",
				label = "Missing crew roster",
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
				"Bring the requested supplies. Packing them properly is worth the minute it takes before setting "
				.. "off."
			),
			completion = "All here. I'll stow them before anyone starts moving the pile.",
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
			name = "The Disputed Cargo",
			kind = "field",
			objective = (
				"Recover the disputed freight evidence from the assigned search area in Garbage. Deliver it to "
				.. "'Brass' in Garbage, then come back to the issuing contact in Marsh."
			),
			requires = {"BA10"},
			briefing = (
				"Brass can settle the disputed freight figures if he gets the case. I'd like to stop being asked "
				.. "to choose a total by how convincing it sounds. Recover the disputed freight evidence from the "
				.. "assigned search area in Garbage. Deliver it to 'Brass' in Garbage, then come back to me in Marsh."
			),
			completion = "Brass has it now. If someone wants the figures argued over, they know where to stand.",
			field = {
				description = (
					"A compact hard case with orange panels, dark protective ribs and a carrying handle. Ballast's "
					.. "note: \"Brass can settle the disputed freight figures if he gets the case.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_evidence",
				label = "Disputed freight evidence",
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
			briefing = (
				"There are supplies to replace before the next recovery. Check the order, then decide what you can "
				.. "carry."
			),
			completion = "Good. You can get the weight off your shoulders now.",
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
			name = "A Voice From Shore",
			kind = "field",
			objective = (
				"Recover the crew's shore message from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"BA14"},
			briefing = (
				"There's another crew recording to collect. Don't spend the journey trying to decide what sort of "
				.. "message it must be. Recover the crew's shore message from the assigned search area in Marsh. "
				.. "Bring it back to me in Marsh."
			),
			completion = "You can sit while I put this away. No need to keep standing as if I'll send you straight back.",
			field = {
				description = (
					"A pale audio cassette with a broad blue printed label and twin spool windows. Ballast's note: "
					.. "\"There's another crew recording to collect.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_tape2",
				label = "Crew's shore message",
			},
			benefits = {},
		},
		{
			id = "BA17",
			completionCash = 1475,
			name = "A Boat in Reserve",
			kind = "delivery",
			requires = {"BA15"},
			briefing = "I'd like the reserve brought up without turning your own return into a struggle.",
			completion = "Thank you. I'll keep it dry from this end.",
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
			name = "The Missing Logbook",
			kind = "field",
			objective = (
				"Recover the landing log for Carbon from the assigned search area in Marsh. Deliver it to 'Carbon' "
				.. "in Waystation, then come back to the issuing contact in Marsh."
			),
			requires = {"BA19"},
			briefing = (
				"Carbon should have the landing log to compare. I can remember a journey; he can put it beside "
				.. "accounts I haven't seen. Recover the landing log for Carbon from the assigned search area in "
				.. "Marsh. Deliver it to 'Carbon' in Waystation, then come back to me in Marsh."
			),
			completion = "He's got the book. Let him read it before anyone asks him for a tidy ending.",
			field = {
				description = (
					"A thick brown journal held together by a narrow tie around its cover. Ballast's note: \"Carbon "
					.. "should have the landing log to compare.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_notebook",
				label = "Landing log for Carbon",
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
			briefing = "I need the listed supplies brought here. Leave enough room to carry your own kit home too.",
			completion = "Put it down gently. That's a useful load.",
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
			objective = (
				"Recover the return freight case from the assigned search area in Marsh. Deliver it to 'Ledger' in "
				.. "Waystation, then come back to the issuing contact in Marsh."
			),
			requires = {"BA21"},
			briefing = (
				"Ledger is waiting for the recovered case. A route looks quite different when you have to finish "
				.. "carrying the load. Recover the return freight case from the assigned search area in Marsh. "
				.. "Deliver it to 'Ledger' in Waystation, then come back to me in Marsh."
			),
			completion = (
				"You made it through and came back. I'd work with you again. Take a moment before you start "
				.. "offering your shoulders to somebody else."
			),
			field = {
				description = (
					"A small yellow hard case with ribbed corners and a large label on its lid. Ballast's note: "
					.. "\"Ledger is waiting for the recovered case.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_case",
				label = "Return freight case",
				recipient = "ledger",
			},
			benefits = {},
			recognition = "Ballast's trusted contact",
		},
	},
})
