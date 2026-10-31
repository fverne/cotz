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
		quantities = {2, 4, 7},
		maps = {
			easy = "rp_marsh_cs",
			medium = "mz_garbage",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	dialogue = {
		completedGreeting = "Paper remembers one thing. People remember another. Keep both.",
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = "Mutant parts. Not just the impressive ones. Small changes tell you a great deal.",
		progressionPrompt = "What else needs doing?",
		progression = "There are a few things I'd like to compare with what I remember. You can help with that.",
	},
	progression = {
		{
			id = "OR01",
			name = "A Familiar Beast",
			kind = "delivery",
			requires = {},
			briefing = "Bring what's listed here. I want to examine it before deciding what to make of it.",
			completion = "Let me see the condition of it.",
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
			name = "Where It Fed",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"OR01"},
			briefing = "Retrieve observations from a Marsh feeding site.",
			completion = "Let's see what they thought worth writing down.",
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
			id = "OR03",
			name = "Proof in the Bag",
			kind = "tracker",
			requires = {"OR02"},
			briefing = "Mutant parts. Not just the impressive ones. Small changes tell you a great deal.",
			completion = "You've brought enough specimens for a useful comparison. Keep looking at the small details.",
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
			id = "OR04",
			name = "The First Account",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"OR03"},
			briefing = "Recover an early expedition note near a local landmark.",
			completion = "Hand it here. I may recognise something.",
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
			id = "OR05",
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
			id = "OR06",
			name = "The Wrong Tracks",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"OR04"},
			briefing = "Collect a recorder from a disputed hunting site.",
			completion = "Interesting. I'll need time with this.",
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
			id = "OR07",
			name = "Different Quarry",
			kind = "tracker",
			requires = {"OR05"},
			briefing = "Mutant parts. Not just the impressive ones. Small changes tell you a great deal.",
			completion = "You've brought enough specimens for a useful comparison. Keep looking at the small details.",
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
			id = "OR08",
			name = "The Scarred Tree",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"OR06"},
			briefing = "Recover a field sketch in Garbage.",
			completion = "Let's see what they thought worth writing down.",
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
			id = "OR09",
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
			id = "OR10",
			name = "A Story With Dates",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"OR08"},
			briefing = "Recover a dated expedition log for Carbon to compare.",
			completion = "Hand it here. I may recognise something.",
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
			id = "OR11",
			name = "Enough to Compare",
			kind = "tracker",
			requires = {"OR09"},
			briefing = "Mutant parts. Not just the impressive ones. Small changes tell you a great deal.",
			completion = "You've brought enough specimens for a useful comparison. Keep looking at the small details.",
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
			id = "OR12",
			name = "The Second Witness",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"OR10"},
			briefing = "Recover a recorded eyewitness account at an abandoned camp.",
			completion = "Interesting. I'll need time with this.",
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
			id = "OR13",
			name = "Old Wounds",
			kind = "delivery",
			requires = {"OR11"},
			briefing = "Bring what's listed here. I want to examine it before deciding what to make of it.",
			completion = "Let me see the condition of it.",
			requirements = {
				{
					pool = "common_parts",
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
			id = "OR14",
			name = "The Camp Before This One",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"OR12"},
			briefing = "Retrieve the original expedition's camp record in Waystation territory.",
			completion = "Let's see what they thought worth writing down.",
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
			id = "OR15",
			name = "A Hunter's Patience",
			kind = "tracker",
			requires = {"OR13"},
			briefing = "Mutant parts. Not just the impressive ones. Small changes tell you a great deal.",
			completion = "You've brought enough specimens for a useful comparison. Keep looking at the small details.",
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
			id = "OR16",
			name = "The Name He Forgot",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"OR14"},
			briefing = "Recover a missing page from a remote field cache.",
			completion = "Hand it here. I may recognise something.",
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
			id = "OR17",
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
			id = "OR18",
			name = "The Route He Remembers",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"OR16"},
			briefing = "Recover a survey record on the old Pripyat approach.",
			completion = "Interesting. I'll need time with this.",
			field = {
				kind = "recovery",
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
			id = "OR19",
			name = "The Worst of It",
			kind = "tracker",
			requires = {"OR17"},
			briefing = "Mutant parts. Not just the impressive ones. Small changes tell you a great deal.",
			completion = "You've brought enough specimens for a useful comparison. Keep looking at the small details.",
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
			id = "OR20",
			name = "Under the Old Mark",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"OR18"},
			briefing = "Retrieve expedition evidence from a Pripyat landmark.",
			completion = "Let's see what they thought worth writing down.",
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
			id = "OR21",
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
			id = "OR22",
			name = "The Place in the Story",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"OR21"},
			briefing = "Recover the encounter's final recorder in Pripyat.",
			completion = "Hand it here. I may recognise something.",
			field = {
				kind = "recovery",
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
			id = "OR23",
			name = "First Does Not Mean Last",
			kind = "tracker",
			requires = {"OR22"},
			briefing = "Mutant parts. Not just the impressive ones. Small changes tell you a great deal.",
			completion = "You've brought enough specimens for a useful comparison. Keep looking at the small details.",
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
			id = "OR24",
			name = "What Actually Happened",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"OR23"},
			briefing = "Recover the last expedition evidence and confront the complete account.",
			completion = "Interesting. I'll need time with this.",
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
			recognition = "The Original's trusted contact",
		},
	},
})
