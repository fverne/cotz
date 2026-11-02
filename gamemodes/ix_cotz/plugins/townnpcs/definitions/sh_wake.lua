PLUGIN:Register("wake", {
	name = "'Wake'",
	template = "wakenpc",
	map = "mz_garbage",
	job = {
		kind = "recovery",
		category = "Equipment recovery",
		description = "Equipment recovery",
		maps = {
			easy = "mz_garbage",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Recovery medicine",
				items = {"medic_bandage_1", "medic_medkit_1"}},
			{label = "Exposure supplies",
				items = {"medic_antirad_1", "medic_antirad_2"}},
			{label = "Search provisions",
				items = {"food_can_tushonka", "drink_bottlewater"}},
		},
	},
	dialogue = {
		delivery = "Put it here. I will keep it with the search records.",
		completedGreeting = (
			"Hello again. Thank you for coming back. If you have something to discuss, we can take our "
			.. "time."
		),
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Recover the marked personal-effects case and bring it back sealed. I'll handle what we can learn "
			.. "from it. Bring the effects back intact. Don't decide on the road that something small isn't worth "
			.. "keeping; it may matter to someone else."
		),
		progressionPrompt = "What else needs doing?",
		progression = (
			"I'm checking missing people's routes and belongings. Supplies help keep the searches going, too. "
			.. "We need supplies for searches and records we can check. Finding a case is useful. Understanding "
			.. "what it does and doesn't tell us takes a little more care."
		),
	},
	catalogue = {
		["medic_antirad_1"] = {step = "WA09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_antirad_2"] = {step = "WA21",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_bandage_2"] = {step = "WA05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_bandage_3"] = {step = "WA13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_1"] = {step = "WA07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_2"] = {step = "WA11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_3"] = {step = "WA15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_4"] = {step = "WA17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_5"] = {step = "WA19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_6"] = {step = "WA22",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "WA01",
			completionCash = 275,
			name = "Names Before Numbers",
			kind = "delivery",
			requires = {},
			briefing = (
				"I need the maintenance supplies on this list brought here. There's always something to "
				.. "sort, secure, or set aside when belongings come back. I'd rather have the supplies ready "
				.. "than rush through that work because someone's waiting for an answer."
			),
			completion = (
				"Thank you. I'll put these with the recovery supplies. It's a small job, but it gives me "
				.. "time to handle the things people bring back with care."
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
			id = "WA02",
			completionCash = 450,
			name = "The Unmarked Camp",
			kind = "field",
			objective = "Recover Personnel File Folder from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"WA01"},
			briefing = "Recover a missing scavenger's personal-effects case in Garbage.",
			completion = "Thank you for bringing it back intact.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_personnel",
				label = "The Unmarked Camp - Personnel File Folder",
			},
			benefits = {},
		},
		{
			id = "WA03",
			completionCash = 0,
			name = "Someone Goes Looking",
			kind = "tracker",
			requires = {"WA02"},
			briefing = (
				"Recover the marked personal-effects case and bring it back sealed. I'll handle what we can "
				.. "learn from it."
			),
			completion = "You've brought back cases that would otherwise still be out there. I appreciate that.",
			target = 2,
			benefits = {},
		},
		{
			id = "WA04",
			completionCash = 650,
			name = "The Name on the Strap",
			kind = "field",
			objective = "Recover Old Photograph Album from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"WA03"},
			briefing = "Recover identifying evidence at a second camp.",
			completion = "I'll open it here. Give me a little room.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_photo",
				label = "The Name on the Strap - Old Photograph Album",
			},
			benefits = {},
		},
		{
			id = "WA05",
			completionCash = 575,
			name = "A Searcher's Kit",
			kind = "delivery",
			requires = {"WA04"},
			briefing = "I need these supplies to keep the searches going. Bring them here when you have them.",
			completion = "Good. That saves another trip for basics.",
			requirements = {
				{
					pool = "canned_food",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "WA06",
			completionCash = 850,
			name = "The Convoy List",
			kind = "field",
			objective = "Recover Personnel File Folder from the assigned search area in Garbage. Deliver it to"
				.. " 'Brass' in Garbage, then return here to finish the assignment.",
			requires = {"WA04"},
			briefing = "Retrieve a convoy roster near a vehicle graveyard.",
			completion = "They have it now. Thank you. We can put this beside the rest of the search record.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_personnel",
				label = "The Convoy List - Personnel File Folder",
				recipient = "brass",
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
			id = "WA07",
			completionCash = 0,
			name = "Bring Back What You Can",
			kind = "tracker",
			requires = {"WA05"},
			briefing = (
				"Recover the marked personal-effects case and bring it back sealed. I'll handle what we can "
				.. "learn from it."
			),
			completion = "You've brought back cases that would otherwise still be out there. I appreciate that.",
			target = 5,
			benefits = {},
		},
		{
			id = "WA08",
			completionCash = 1050,
			name = "The Last Check-in",
			kind = "field",
			objective = "Recover Handwritten Audio Cassette from the assigned search area in Garbage. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"WA06"},
			briefing = "Recover a convoy recorder on its abandoned route.",
			completion = "Thank you for bringing it back intact.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_tape",
				label = "The Last Check-in - Handwritten Audio Cassette",
			},
			benefits = {},
		},
		{
			id = "WA09",
			completionCash = 875,
			name = "Keeping the Record",
			kind = "delivery",
			requires = {"WA07"},
			briefing = "I need these supplies to keep the searches going. Bring them here when you have them.",
			completion = "Put it here, please.",
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "WA10",
			completionCash = 1250,
			name = "Atlas' Missing Mark",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Garbage. Deliver it to 'Atlas'"
				.. " in Marsh, then return here to finish the assignment.",
			requires = {"WA08"},
			briefing = "Recover a survey note that narrows the convoy route.",
			completion = "They have it now. Thank you. We can put this beside the rest of the search record.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_notebook",
				label = "Atlas' Missing Mark - Tied Leather Journal",
				recipient = "atlas",
			},
			benefits = {},
		},
		{
			id = "WA11",
			completionCash = 0,
			name = "A Longer Search",
			kind = "tracker",
			requires = {"WA09"},
			briefing = (
				"Recover the marked personal-effects case and bring it back sealed. I'll handle what we can "
				.. "learn from it."
			),
			completion = "You've brought back cases that would otherwise still be out there. I appreciate that.",
			target = 9,
			benefits = {},
		},
		{
			id = "WA12",
			completionCash = 1450,
			name = "The Diverted Convoy",
			kind = "field",
			objective = "Recover Orange Evidence Case from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"WA10"},
			briefing = (
				"Recover personal effects from the convoy's regional destination. Bring back what's "
				.. "assigned without deciding what it proves on the way. We'll examine it somewhere quiet."
			),
			completion = (
				"Let me check it against the missing-person records. Thank you. I'll check it carefully. "
				.. "You can put your pack down while I do; I won't need you to leave again this moment."
			),
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_evidence",
				label = "The Diverted Convoy - Orange Evidence Case",
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
			id = "WA13",
			completionCash = 1175,
			name = "Ready to Follow",
			kind = "delivery",
			requires = {"WA11"},
			briefing = "I need these supplies to keep the searches going. Bring them here when you have them.",
			completion = "Thank you. I'll keep it with the search supplies.",
			requirements = {
				{
					pool = "canned_food",
					quantity = 4,
				},
			},
			benefits = {},
		},
		{
			id = "WA14",
			completionCash = 1650,
			name = "The Withheld Copy",
			kind = "field",
			objective = "Recover Official File Folder from the assigned search area in Garbage. Deliver it to"
				.. " 'Carbon' in Waystation, then return here to finish the assignment.",
			requires = {"WA12"},
			briefing = "Recover field evidence corroborating a restricted report.",
			completion = "They have it now. Thank you. We can put this beside the rest of the search record.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_official",
				label = "The Withheld Copy - Official File Folder",
				recipient = "carbon",
			},
			benefits = {},
		},
		{
			id = "WA15",
			completionCash = 0,
			name = "No One Written Off",
			kind = "tracker",
			requires = {"WA13"},
			briefing = (
				"Recover the marked personal-effects case and bring it back sealed. I'll handle what we can "
				.. "learn from it."
			),
			completion = "You've brought back cases that would otherwise still be out there. I appreciate that.",
			target = 14,
			benefits = {},
		},
		{
			id = "WA16",
			completionCash = 1850,
			name = "The Pripyat Camp",
			kind = "field",
			objective = "Recover Striped Equipment Case from the assigned search area in Pripyat. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"WA14"},
			briefing = "Recover the expedition's camp case in Pripyat.",
			completion = "I'll open it here. Give me a little room.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_equipment",
				label = "The Pripyat Camp - Striped Equipment Case",
			},
			benefits = {},
		},
		{
			id = "WA17",
			completionCash = 1475,
			name = "The Records Agree",
			kind = "delivery",
			requires = {"WA15"},
			briefing = "I need these supplies to keep the searches going. Bring them here when you have them.",
			completion = "Good. That saves another trip for basics.",
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 2,
				},
			},
			benefits = {},
		},
		{
			id = "WA18",
			completionCash = 2050,
			name = "The Last Transmission",
			kind = "field",
			objective = "Recover Blue-Label Audio Cassette from the assigned search area in Pripyat. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"WA16"},
			briefing = "Recover a recorder deeper in Pripyat.",
			completion = "Let me check it against the missing-person records.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_tape2",
				label = "The Last Transmission - Blue-Label Audio Cassette",
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
			id = "WA19",
			completionCash = 0,
			name = "Still Looking",
			kind = "tracker",
			requires = {"WA17", "WA18"},
			briefing = (
				"Recover the marked personal-effects case and bring it back sealed. I'll handle what we can "
				.. "learn from it."
			),
			completion = "You've brought back cases that would otherwise still be out there. I appreciate that.",
			target = 20,
			benefits = {},
		},
		{
			id = "WA20",
			completionCash = 2250,
			name = "Personal Effects",
			kind = "field",
			objective = "Recover Old Photograph Album from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"WA19"},
			briefing = "Recover the missing team's final keepsake case.",
			completion = "Thank you for bringing it back intact.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_photo",
				label = "Personal Effects - Old Photograph Album",
			},
			benefits = {},
			stock = {
				item = "drink_bottlewater",
				bonus = 2,
			},
		},
		{
			id = "WA21",
			completionCash = 1775,
			name = "A Place in the Ledger",
			kind = "delivery",
			requires = {"WA20"},
			briefing = "I need these supplies to keep the searches going. Bring them here when you have them.",
			completion = "Put it here, please.",
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 2,
				},
			},
			benefits = {},
		},
		{
			id = "WA22",
			completionCash = 2450,
			name = "The Final Name",
			kind = "field",
			objective = "Recover Personnel File Folder from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"WA21"},
			briefing = (
				"Retrieve the final identification record and return the completed account. Keep the identifying "
				.. "record together. Bring it here before drawing conclusions from a name you recognise on one page."
			),
			completion = (
				"I'll open it here. Give me a little room. Thank you. I'll read it carefully. You haven't treated "
				.. "these as just things to collect, and I appreciate that. Give me a little time before we talk "
				.. "about what the papers say."
			),
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_personnel",
				label = "The Final Name - Personnel File Folder",
			},
			benefits = {},
			recognition = "Wake's trusted contact",
		},
	},
})
