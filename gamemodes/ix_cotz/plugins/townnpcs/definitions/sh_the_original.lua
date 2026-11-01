PLUGIN:Register("the-original", {
	name = "'The Original'",
	template = "firststalkernpc",
	map = "rp_marsh_cs",
	job = {
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		category = "Mutant specimen deliveries",
		description = "Mutant specimen deliveries",
		pools = {"common_parts", "small_parts", "common_hides"},
		deliveryTiers = {
			easy = {
				pools = {
					"valuables_personal_effects",
				},
				quantity = 1,
			},
			medium = {
				pools = {
					"valuables_decorative_valuables",
				},
				quantity = 1,
			},
			hard = {
				pools = {
					"valuables_irregular_patches",
					"valuables_specialist_cases",
				},
				quantity = 2,
			},
		},
		quantities = {2, 4, 7},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Expedition provisions",
				items = {"food_can_tushonka", "drink_bottlewater"}},
			{label = "Camp supplies",
				items = {"lowtiercookerfuel", "food_bread"}},
			{label = "Close encounters",
				items = {"medic_bandage_1", "12gauge"}},
		},
	},
	dialogue = {
		delivery = "Bring it over. Let me have a look at what survived.",
		completedGreeting = (
			"Come to check another of my stories? All right. At least you usually bring a question worth "
			.. "answering."
		),
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Mutant parts. Not just the impressive ones. Small changes tell you a great deal. Bring the "
			.. "specimen listed, and don't ruin it getting it here. There's more to learn from a good look than "
			.. "from another argument about what you think you saw."
		),
		progressionPrompt = "What else needs doing?",
		progression = (
			"There are a few things I'd like to compare with what I remember. You can help with that. I've told "
			.. "these stories often enough. Now there are records to put beside them. You fetch what survives and "
			.. "we'll see which questions are worth asking."
		),
	},
	catalogue = {
	},
	progression = {
		{
			id = "OR01",
			completionCash = 275,
			name = "A Familiar Beast",
			kind = "delivery",
			requires = {},
			briefing = (
				"Bring what's listed here. I want to examine it before deciding what to make of it. "
				.. "We'll start with something I can examine here. I'd rather have a specimen in front of "
				.. "us than another description of an enormous beast."
			),
			completion = (
				"Let me see the condition of it. There. Now we can look properly. Everyone remembers the "
				.. "teeth; fewer people notice anything useful around them."
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
						item = "drink_bottlewater",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "OR02",
			completionCash = 450,
			name = "Where It Fed",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"OR01"},
			briefing = "Retrieve observations from a Marsh feeding site.",
			completion = "Let's see what they thought worth writing down.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "Where It Fed - Tied Leather Journal",
			},
			benefits = {},
		},
		{
			id = "OR03",
			completionCash = 0,
			name = "Proof in the Bag",
			kind = "tracker",
			requires = {"OR02"},
			briefing = "Mutant parts. Not just the impressive ones. Small changes tell you a great deal.",
			completion = "You've brought enough specimens for a useful comparison. Keep looking at the small details.",
			target = 2,
			benefits = {},
		},
		{
			id = "OR04",
			completionCash = 650,
			name = "The First Account",
			kind = "field",
			objective = "Recover Scientist's Field Diary from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"OR03"},
			briefing = "Recover an early expedition note near a local landmark.",
			completion = "Hand it here. I may recognise something.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_diary",
				label = "The First Account - Scientist's Field Diary",
			},
			benefits = {},
		},
		{
			id = "OR05",
			completionCash = 575,
			name = "Teeth and Hide",
			kind = "delivery",
			requires = {"OR04"},
			briefing = "Bring what's listed here. I want to examine it before deciding what to make of it.",
			completion = "Keep it there. I want a closer look.",
			requirements = {
				{
					pool = "common_parts",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "OR06",
			completionCash = 850,
			name = "The Wrong Tracks",
			kind = "field",
			objective = "Recover Handwritten Audio Cassette from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"OR04"},
			briefing = "Collect a recorder from a disputed hunting site.",
			completion = "Interesting. I'll need time with this.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_tape",
				label = "The Wrong Tracks - Handwritten Audio Cassette",
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
			id = "OR07",
			completionCash = 0,
			name = "Different Quarry",
			kind = "tracker",
			requires = {"OR05"},
			briefing = "Mutant parts. Not just the impressive ones. Small changes tell you a great deal.",
			completion = "You've brought enough specimens for a useful comparison. Keep looking at the small details.",
			target = 5,
			benefits = {},
		},
		{
			id = "OR08",
			completionCash = 1050,
			name = "The Scarred Tree",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"OR06"},
			briefing = "Recover a field sketch in Garbage.",
			completion = "Let's see what they thought worth writing down.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "The Scarred Tree - Tied Leather Journal",
			},
			benefits = {},
		},
		{
			id = "OR09",
			completionCash = 875,
			name = "What Changed",
			kind = "delivery",
			requires = {"OR07"},
			briefing = "Bring what's listed here. I want to examine it before deciding what to make of it.",
			completion = "Yes, this is useful.",
			requirements = {
				{
					pool = "common_parts",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "OR10",
			completionCash = 1250,
			name = "A Story With Dates",
			kind = "field",
			objective = "Recover Scientist's Field Diary from the assigned search area in Marsh. Deliver it to"
				.. " 'Carbon' in Waystation, then return here to finish the assignment.",
			requires = {"OR08"},
			briefing = "Recover a dated expedition log for Carbon to compare.",
			completion = "They have the record. Good. Let them read it before they tell me what happened.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_diary",
				label = "A Story With Dates - Scientist's Field Diary",
				recipient = "carbon",
			},
			benefits = {},
		},
		{
			id = "OR11",
			completionCash = 0,
			name = "Enough to Compare",
			kind = "tracker",
			requires = {"OR09"},
			briefing = "Mutant parts. Not just the impressive ones. Small changes tell you a great deal.",
			completion = "You've brought enough specimens for a useful comparison. Keep looking at the small details.",
			target = 9,
			benefits = {},
		},
		{
			id = "OR12",
			completionCash = 1450,
			name = "The Second Witness",
			kind = "field",
			objective = "Recover Blue-Label Audio Cassette from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"OR10"},
			briefing = "Recover a recorded eyewitness account at an abandoned camp.",
			completion = "Interesting. I'll need time with this.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_tape2",
				label = "The Second Witness - Blue-Label Audio Cassette",
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
			id = "OR13",
			completionCash = 1175,
			name = "Old Wounds",
			kind = "delivery",
			requires = {"OR11"},
			briefing = (
				"Bring what's listed here. I want to examine it before deciding what to make of it. "
				.. "Don't decide the answer before the work is done. I've heard enough confident guesses "
				.. "from people who never went to look."
			),
			completion = (
				"Let me see the condition of it. I'll consider that alongside what I already know. You "
				.. "needn't look so impatient; being old doesn't mean I read without looking."
			),
			requirements = {
				{
					pool = "common_parts",
					quantity = 2,
				},
			},
			benefits = {},
		},
		{
			id = "OR14",
			completionCash = 1650,
			name = "The Camp Before This One",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Waystation. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"OR12"},
			briefing = "Retrieve the original expedition's camp record in Waystation territory.",
			completion = "Let's see what they thought worth writing down.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_notebook",
				label = "The Camp Before This One - Tied Leather Journal",
			},
			benefits = {},
		},
		{
			id = "OR15",
			completionCash = 0,
			name = "A Hunter's Patience",
			kind = "tracker",
			requires = {"OR13"},
			briefing = "Mutant parts. Not just the impressive ones. Small changes tell you a great deal.",
			completion = "You've brought enough specimens for a useful comparison. Keep looking at the small details.",
			target = 14,
			benefits = {},
		},
		{
			id = "OR16",
			completionCash = 1850,
			name = "The Name He Forgot",
			kind = "field",
			objective = "Recover Scientist's Field Diary from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"OR14"},
			briefing = "Recover a missing page from a remote field cache.",
			completion = "Hand it here. I may recognise something.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_diary",
				label = "The Name He Forgot - Scientist's Field Diary",
			},
			benefits = {},
		},
		{
			id = "OR17",
			completionCash = 1475,
			name = "A Different Kind of Proof",
			kind = "delivery",
			requires = {"OR15"},
			briefing = "Bring what's listed here. I want to examine it before deciding what to make of it.",
			completion = "Keep it there. I want a closer look.",
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 2,
				},
			},
			benefits = {},
		},
		{
			id = "OR18",
			completionCash = 2050,
			name = "The Route He Remembers",
			kind = "field",
			objective = "Recover Official File Folder from the assigned search area in Pripyat. Deliver it to 'Atlas'"
				.. " in Marsh, then return here to finish the assignment.",
			requires = {"OR16"},
			briefing = "Recover a survey record on the old Pripyat approach.",
			completion = "They have the record. Good. Let them read it before they tell me what happened.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_official",
				label = "The Route He Remembers - Official File Folder",
				recipient = "atlas",
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
			id = "OR19",
			completionCash = 0,
			name = "The Worst of It",
			kind = "tracker",
			requires = {"OR17"},
			briefing = "Mutant parts. Not just the impressive ones. Small changes tell you a great deal.",
			completion = "You've brought enough specimens for a useful comparison. Keep looking at the small details.",
			target = 20,
			benefits = {},
		},
		{
			id = "OR20",
			completionCash = 2250,
			name = "Under the Old Mark",
			kind = "field",
			objective = "Recover Orange Evidence Case from the assigned search area in Pripyat. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"OR18"},
			briefing = "Retrieve expedition evidence from a Pripyat landmark.",
			completion = "Let's see what they thought worth writing down.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_evidence",
				label = "Under the Old Mark - Orange Evidence Case",
			},
			benefits = {},
		},
		{
			id = "OR21",
			completionCash = 1775,
			name = "No Two Alike",
			kind = "delivery",
			requires = {"OR19", "OR20"},
			briefing = "Bring what's listed here. I want to examine it before deciding what to make of it.",
			completion = "Yes, this is useful.",
			requirements = {
				{
					pool = "common_parts",
					quantity = 2,
				},
			},
			benefits = {},
		},
		{
			id = "OR22",
			completionCash = 2450,
			name = "The Place in the Story",
			kind = "field",
			objective = "Recover Handwritten Audio Cassette from the assigned search area in Pripyat. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"OR21"},
			briefing = "Recover the encounter's final recorder in Pripyat.",
			completion = "Hand it here. I may recognise something.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_tape",
				label = "The Place in the Story - Handwritten Audio Cassette",
			},
			benefits = {},
		},
		{
			id = "OR23",
			completionCash = 0,
			name = "First Does Not Mean Last",
			kind = "tracker",
			requires = {"OR22"},
			briefing = "Mutant parts. Not just the impressive ones. Small changes tell you a great deal.",
			completion = "You've brought enough specimens for a useful comparison. Keep looking at the small details.",
			target = 27,
			benefits = {},
		},
		{
			id = "OR24",
			completionCash = 2650,
			name = "What Actually Happened",
			kind = "field",
			objective = "Recover Personnel File Folder from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"OR23"},
			briefing = (
				"Recover the last expedition evidence and confront the complete account. Bring the whole file "
				.. "back. If we're going to pick at an old account, we can at least do it with all the pages in front "
				.. "of us."
			),
			completion = (
				"Interesting. I'll need time with this. Leave it open there. I want to read it again. You're "
				.. "waiting for me to say whether I was right, aren't you? Give an old man time to find out."
			),
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_personnel",
				label = "What Actually Happened - Personnel File Folder",
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
			recognition = "The Original's trusted contact",
		},
	},
})
