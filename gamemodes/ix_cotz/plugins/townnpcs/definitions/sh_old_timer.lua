PLUGIN:Register("old-timer", {
	name = "'Old Timer'",
	template = "tutorialnpc",
	map = "rp_marsh_cs",
	job = {
		kind = "hunting",
		category = "Mutant hunting",
		description = "Mutant hunting",
		pools = {"common_parts", "common_hides"},
		quantities = {5, 9, 15},
		maps = {
			easy = "rp_marsh_cs",
			medium = "mz_garbage",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"medic_bandage_1", "12gauge", "22lr", "food_bread"},
	dialogue = {
		completedGreeting = "Still in one piece? Good. Pull up a chair.",
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = "Mutants. Keep the approaches clear, and come back with enough ammunition to do it again.",
		progressionPrompt = "What else needs doing?",
		progression = "A few things before you wander off. After that, there's something I'd like you to look for.",
	},
	catalogue = {
		["hatchet"] = {step = "OT08",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["knife2"] = {step = "OT03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["knife3"] = {step = "OT12",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sharpening_stone"] = {step = "OT07",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["sharpening_stone_fine"] = {step = "OT19",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
	},
	progression = {
		{
			id = "OT01",
			name = "Before You Leave",
			kind = "delivery",
			requires = {},
			briefing = "Food first. If you can't spare enough to leave here, you haven't packed enough to wander off.",
			completion = "Good. Keep enough in your own pack. I don't want to hear you went hungry getting here.",
			requirements = {
				{
					pool = "canned_food",
					quantity = 2,
				},
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
			id = "OT02",
			name = "Know Your Ground",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"OT01"},
			briefing = "Recover a field notebook near a Marsh landmark.",
			completion = "Let me have a look. Sit down while I read it.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
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
			id = "OT03",
			name = "Something With Teeth",
			kind = "tracker",
			requires = {"OT02"},
			briefing = "You came back. Good. Don't let a few dead mutants convince you that you know everything.",
			completion = "You came back. Good. I'll let you buy a better knife. Don't mistake it for experience.",
			target = 2,
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
			id = "OT04",
			name = "Bring Something Back",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"OT03"},
			briefing = "Investigate an abandoned hunting camp and recover its observations.",
			completion = "You made it back. Show me what you found.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
			},
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
			id = "OT05",
			name = "A Place to Hide",
			kind = "delivery",
			requires = {"OT04"},
			briefing = "Bring the supplies on this list. Keep enough in your own pack for the walk back.",
			completion = "That will do. Keep enough for yourself.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 3,
				},
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
			id = "OT06",
			name = "Ready Enough",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"OT04"},
			briefing = "Recover a supply case beyond the Marsh camp outskirts.",
			completion = "Leave it here. I want to go through it properly.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
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
			stock = {
				item = "medic_bandage_1",
				bonus = 1,
			},
		},
		{
			id = "OT07",
			name = "Look After Your Kit",
			kind = "tracker",
			requires = {"OT05"},
			briefing = "Mutants. Keep the approaches clear, and come back with enough ammunition to do it again.",
			completion = "You came back. Good. Don't let a few dead mutants convince you that you know everything.",
			target = 5,
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
			id = "OT08",
			name = "Travel Light",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"OT06"},
			briefing = "Recover a scout pack from a Marsh search area.",
			completion = "Let me have a look. Sit down while I read it.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
			},
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
			id = "OT09",
			name = "Bad Water",
			kind = "delivery",
			requires = {"OT07"},
			briefing = "Bring the supplies on this list. Keep enough in your own pack for the walk back.",
			completion = "You remembered the supplies. Good start.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 3,
				},
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
			id = "OT10",
			name = "Enough for the Walk Home",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"OT08"},
			briefing = "Retrieve a lost supply case along an exposed Marsh return route.",
			completion = "You made it back. Show me what you found.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
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
			id = "OT11",
			name = "Old Habits",
			kind = "tracker",
			requires = {"OT09"},
			briefing = "Mutants. Keep the approaches clear, and come back with enough ammunition to do it again.",
			completion = "You came back. Good. Don't let a few dead mutants convince you that you know everything.",
			target = 9,
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
			id = "OT12",
			name = "Keep Yourself Alive",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"OT10"},
			briefing = "Recover the final equipment case from the Marsh survival expedition.",
			completion = "Leave it here. I want to go through it properly.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
			},
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
			id = "OT13",
			name = "Tracks at the Fence",
			kind = "delivery",
			requires = {"OT11"},
			briefing = "Bring the supplies on this list. Keep enough in your own pack for the walk back.",
			completion = "Good. Put it with the rest.",
			requirements = {
				{
					pool = "common_parts",
					quantity = 2,
				},
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
			id = "OT14",
			name = "Thin the Pack",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"OT12"},
			briefing = "Recover observer notes from a Marsh hunting site.",
			completion = "Let me have a look. Sit down while I read it.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
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
			id = "OT15",
			name = "What They Leave Behind",
			kind = "tracker",
			requires = {"OT13"},
			briefing = "Mutants. Keep the approaches clear, and come back with enough ammunition to do it again.",
			completion = "You came back. Good. Don't let a few dead mutants convince you that you know everything.",
			target = 14,
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
			id = "OT16",
			name = "Not Normal Behaviour",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"OT14"},
			briefing = "Retrieve a recorder from a disturbed feeding ground in Marsh.",
			completion = "You made it back. Show me what you found.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
			},
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
			id = "OT17",
			name = "The Empty Camp",
			kind = "delivery",
			requires = {"OT15"},
			briefing = "Bring the supplies on this list. Keep enough in your own pack for the walk back.",
			completion = "That will do. Keep enough for yourself.",
			requirements = {
				{
					pool = "common_parts",
					quantity = 2,
				},
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
			id = "OT18",
			name = "Leave a Way Out",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"OT16"},
			briefing = "Recover observations along a missing party route in Marsh.",
			completion = "Leave it here. I want to go through it properly.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
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
			id = "OT19",
			name = "An Old Name",
			kind = "tracker",
			requires = {"OT17"},
			briefing = "Mutants. Keep the approaches clear, and come back with enough ammunition to do it again.",
			completion = "You came back. Good. Don't let a few dead mutants convince you that you know everything.",
			target = 20,
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
			id = "OT20",
			name = "The Convoy That Never Arrived",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"OT18"},
			briefing = (
				"There's a case from the missing convoy out in Garbage. Bring it back sealed. I want to see "
				.. "what's left."
			),
			completion = "Put it here. Give me a moment with it.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
			},
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
			id = "OT21",
			name = "Someone Kept Records",
			kind = "delivery",
			requires = {"OT19"},
			briefing = "Bring the supplies on this list. Keep enough in your own pack for the walk back.",
			completion = "You remembered the supplies. Good start.",
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 2,
				},
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
			id = "OT22",
			name = "A Voice on Tape",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"OT20"},
			briefing = "Recover a recording from a remote signal site in Waystation territory.",
			completion = "You made it back. Show me what you found.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
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
			id = "OT23",
			name = "What He Was Carrying",
			kind = "tracker",
			requires = {"OT21"},
			briefing = "Mutants. Keep the approaches clear, and come back with enough ammunition to do it again.",
			completion = "You came back. Good. Don't let a few dead mutants convince you that you know everything.",
			target = 27,
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
			id = "OT24",
			name = "The Last Address",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"OT22"},
			briefing = "The next case is in Pripyat. Take enough supplies to change your mind halfway there.",
			completion = "You're back. Let me look at it before you tell me the rest.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
			},
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
			id = "OT25",
			name = "Past the Turn Back Point",
			kind = "delivery",
			requires = {"OT23", "OT24"},
			briefing = "Bring the supplies on this list. Keep enough in your own pack for the walk back.",
			completion = "Good. Put it with the rest.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 7,
				},
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
			id = "OT26",
			name = "He Made It This Far",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"OT25"},
			briefing = "Recover the final equipment case and keepsake in Pripyat.",
			completion = "Let me have a look. Sit down while I read it.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
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
			stock = {
				item = "medic_bandage_1",
				bonus = 2,
			},
		},
		{
			id = "OT27",
			name = "Bring Him Home",
			kind = "tracker",
			requires = {"OT26"},
			briefing = "Mutants. Keep the approaches clear, and come back with enough ammunition to do it again.",
			completion = "You came back. Good. Don't let a few dead mutants convince you that you know everything.",
			target = 35,
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
			id = "OT28",
			name = "Nothing Left Unsaid",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"OT27"},
			briefing = "One last case in Pripyat. Bring it here. That's all I'm asking.",
			completion = "Leave it here. And sit down a minute. There's no hurry.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
			},
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
			recognition = "Old Timer's trusted contact",
		},
	},
})
