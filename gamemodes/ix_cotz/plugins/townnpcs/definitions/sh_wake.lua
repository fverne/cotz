PLUGIN:Register("wake", {
	name = "'Wake'",
	template = "wakenpc",
	map = "mz_garbage",
	job = {
		kind = "recovery",
		category = "Equipment recovery",
		description = "Equipment recovery",
		pools = {"administrative_documents", "town_medical"},
		quantities = {5, 9, 15},
		maps = {
			easy = "mz_garbage",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	dialogue = {
		completedGreeting = "We can stop writing missing beside that name.",
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Recover the marked personal-effects case and bring it back sealed. I'll handle what we can "
			.. "learn from it."
		),
		progressionPrompt = "What else needs doing?",
		progression = (
			"I'm checking missing people's routes and belongings. Supplies help keep the searches going, "
			.. "too."
		),
	},
	progression = {
		{
			id = "WA01",
			name = "Names Before Numbers",
			kind = "delivery",
			requires = {},
			briefing = "I need these supplies to keep the searches going. Bring them here when you have them.",
			completion = "Thank you. I'll keep it with the search supplies.",
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
			name = "The Unmarked Camp",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"WA01"},
			briefing = "Recover a missing scavenger's personal-effects case in Garbage.",
			completion = "Thank you for bringing it back intact.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
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
			id = "WA03",
			name = "Someone Goes Looking",
			kind = "tracker",
			requires = {"WA02"},
			briefing = (
				"Recover the marked personal-effects case and bring it back sealed. I'll handle what we can "
				.. "learn from it."
			),
			completion = "You've brought back cases that would otherwise still be out there. I appreciate that.",
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
			id = "WA04",
			name = "The Name on the Strap",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"WA03"},
			briefing = "Recover identifying evidence at a second camp.",
			completion = "I'll open it here. Give me a little room.",
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
			id = "WA05",
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
			id = "WA06",
			name = "The Convoy List",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"WA04"},
			briefing = "Retrieve a convoy roster near a vehicle graveyard.",
			completion = "Let me check it against the missing-person records.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
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
			id = "WA07",
			name = "Bring Back What You Can",
			kind = "tracker",
			requires = {"WA05"},
			briefing = (
				"Recover the marked personal-effects case and bring it back sealed. I'll handle what we can "
				.. "learn from it."
			),
			completion = "You've brought back cases that would otherwise still be out there. I appreciate that.",
			target = 5,
			benefits = {
				services = {
					{
						npc = "'Jitters'",
						service = "treatment",
						amount = 150,
					},
				},
			},
		},
		{
			id = "WA08",
			name = "The Last Check-in",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"WA06"},
			briefing = "Recover a convoy recorder on its abandoned route.",
			completion = "Thank you for bringing it back intact.",
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
			id = "WA09",
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
			id = "WA10",
			name = "Atlas' Missing Mark",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"WA08"},
			briefing = "Recover a survey note that narrows the convoy route.",
			completion = "I'll open it here. Give me a little room.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
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
			id = "WA11",
			name = "A Longer Search",
			kind = "tracker",
			requires = {"WA09"},
			briefing = (
				"Recover the marked personal-effects case and bring it back sealed. I'll handle what we can "
				.. "learn from it."
			),
			completion = "You've brought back cases that would otherwise still be out there. I appreciate that.",
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
			id = "WA12",
			name = "The Diverted Convoy",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"WA10"},
			briefing = "Recover personal effects from the convoy's regional destination.",
			completion = "Let me check it against the missing-person records.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
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
			id = "WA13",
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
			id = "WA14",
			name = "The Withheld Copy",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"WA12"},
			briefing = "Recover field evidence corroborating a restricted report.",
			completion = "Thank you for bringing it back intact.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
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
			id = "WA15",
			name = "No One Written Off",
			kind = "tracker",
			requires = {"WA13"},
			briefing = (
				"Recover the marked personal-effects case and bring it back sealed. I'll handle what we can "
				.. "learn from it."
			),
			completion = "You've brought back cases that would otherwise still be out there. I appreciate that.",
			target = 14,
			benefits = {
				services = {
					{
						npc = "'Technut'",
						service = "repair",
						amount = 500,
					},
				},
			},
		},
		{
			id = "WA16",
			name = "The Pripyat Camp",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"WA14"},
			briefing = "Recover the expedition's camp case in Pripyat.",
			completion = "I'll open it here. Give me a little room.",
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
			id = "WA17",
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
			id = "WA18",
			name = "The Last Transmission",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"WA16"},
			briefing = "Recover a recorder deeper in Pripyat.",
			completion = "Let me check it against the missing-person records.",
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
			id = "WA19",
			name = "Still Looking",
			kind = "tracker",
			requires = {"WA17", "WA18"},
			briefing = (
				"Recover the marked personal-effects case and bring it back sealed. I'll handle what we can "
				.. "learn from it."
			),
			completion = "You've brought back cases that would otherwise still be out there. I appreciate that.",
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
			id = "WA20",
			name = "Personal Effects",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"WA19"},
			briefing = "Recover the missing team's final keepsake case.",
			completion = "Thank you for bringing it back intact.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
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
			stock = {
				item = "drink_bottlewater",
				bonus = 2,
			},
		},
		{
			id = "WA21",
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
			id = "WA22",
			name = "The Final Name",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"WA21"},
			briefing = "Retrieve the final identification record and return the completed account.",
			completion = "I'll open it here. Give me a little room.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
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
			recognition = "Wake's trusted contact",
		},
	},
})
