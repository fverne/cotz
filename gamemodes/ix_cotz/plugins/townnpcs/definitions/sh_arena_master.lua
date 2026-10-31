PLUGIN:Register("arena-master", {
	name = "'Arena Master'",
	template = "arenanpc",
	map = "rp_marsh_cs",
	job = {
		kind = "arena",
		category = "Arena bouts",
		description = "Arena bouts",
		pools = {"town_medical", "maintenance"},
		quantities = {5, 9, 15},
		maps = {
			easy = "rp_marsh_cs",
			medium = "mz_garbage",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	dialogue = {
		completedGreeting = "You've earned your place. Try not to make the next contender too nervous.",
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Sanctioned bouts against different human opponents. Fighting the same friend all afternoon "
			.. "doesn't count."
		),
		progressionPrompt = "What else needs doing?",
		progression = "I've got equipment to sort and a few missing records. And, of course, there's the arena.",
	},
	progression = {
		{
			id = "AR01",
			name = "Before the Bell",
			kind = "delivery",
			requires = {},
			briefing = "Bring these supplies over when you can. There's always something to replace around here.",
			completion = "Lovely. Put it with the arena supplies.",
			requirements = {
				{
					pool = "town_medical",
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
			id = "AR02",
			name = "The Missing Register",
			kind = "arena",
			requires = {"AR01"},
			briefing = (
				"Join a sanctioned bout here in Marsh against someone you haven't faced before. Finish the "
				.. "match properly."
			),
			completion = "Good match. Take a breather before you sign up again.",
			target = 1,
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
			id = "AR03",
			name = "First Opponents",
			kind = "tracker",
			requires = {"AR02"},
			briefing = (
				"Sanctioned bouts against different human opponents. Fighting the same friend all afternoon "
				.. "doesn't count."
			),
			completion = "A few different opponents now. You're getting a proper feel for it.",
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
			id = "AR04",
			name = "A Fair Match",
			kind = "arena",
			requires = {"AR03"},
			briefing = (
				"Join a sanctioned bout here in Marsh against someone you haven't faced before. Finish the "
				.. "match properly."
			),
			completion = "Good match. Take a breather before you sign up again.",
			target = 1,
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
			id = "AR05",
			name = "Equipment Inspection",
			kind = "delivery",
			requires = {"AR04"},
			briefing = "Bring these supplies over when you can. There's always something to replace around here.",
			completion = "That'll do nicely.",
			requirements = {
				{
					pool = "field_maintenance",
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
			id = "AR06",
			name = "The Damaged Shipment",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"AR04"},
			briefing = "Recover a protective-equipment case along the supply route.",
			completion = "You found it. Much appreciated.",
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
			id = "AR07",
			name = "Not the Same Face",
			kind = "tracker",
			requires = {"AR05"},
			briefing = (
				"Sanctioned bouts against different human opponents. Fighting the same friend all afternoon "
				.. "doesn't count."
			),
			completion = "A few different opponents now. You're getting a proper feel for it.",
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
			id = "AR08",
			name = "The Referee's Record",
			kind = "arena",
			requires = {"AR06"},
			briefing = (
				"Join a sanctioned bout here in Marsh against someone you haven't faced before. Finish the "
				.. "match properly."
			),
			completion = "Good match. Take a breather before you sign up again.",
			target = 1,
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
			id = "AR09",
			name = "Patch the Kit",
			kind = "delivery",
			requires = {"AR07"},
			briefing = "Bring these supplies over when you can. There's always something to replace around here.",
			completion = "Thanks. I'll keep that out of the ring.",
			requirements = {
				{
					pool = "field_maintenance",
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
			id = "AR10",
			name = "The Supplier's Seal",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"AR08"},
			briefing = "Recover evidence identifying an interrupted arena shipment.",
			completion = "Set it here. I'll go through it between matches.",
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
			id = "AR11",
			name = "A Broader Field",
			kind = "tracker",
			requires = {"AR09"},
			briefing = (
				"Sanctioned bouts against different human opponents. Fighting the same friend all afternoon "
				.. "doesn't count."
			),
			completion = "A few different opponents now. You're getting a proper feel for it.",
			target = 9,
			benefits = {
				services = {
					{
						npc = "'Arena Master'",
						service = "treatment",
						amount = 150,
					},
				},
			},
		},
		{
			id = "AR12",
			name = "An Honest Result",
			kind = "arena",
			requires = {"AR10"},
			briefing = (
				"Join a sanctioned bout here in Marsh against someone you haven't faced before. Finish the "
				.. "match properly."
			),
			completion = "Good match. Take a breather before you sign up again.",
			target = 1,
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
			id = "AR13",
			name = "No Empty Cabinets",
			kind = "delivery",
			requires = {"AR11"},
			briefing = "Bring these supplies over when you can. There's always something to replace around here.",
			completion = "Lovely. Put it with the arena supplies.",
			requirements = {
				{
					pool = "town_medical",
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
			id = "AR14",
			name = "A Fighter's Effects",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"AR12"},
			briefing = "Recover a former competitor's equipment case.",
			completion = "Let's see what you brought back.",
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
			id = "AR15",
			name = "Veteran Company",
			kind = "tracker",
			requires = {"AR13"},
			briefing = (
				"Sanctioned bouts against different human opponents. Fighting the same friend all afternoon "
				.. "doesn't count."
			),
			completion = "A few different opponents now. You're getting a proper feel for it.",
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
			id = "AR16",
			name = "The Missing Result",
			kind = "arena",
			requires = {"AR14"},
			briefing = (
				"Join a sanctioned bout here in Marsh against someone you haven't faced before. Finish the "
				.. "match properly."
			),
			completion = "Good match. Take a breather before you sign up again.",
			target = 1,
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
			id = "AR17",
			name = "Ready for the Final",
			kind = "delivery",
			requires = {"AR15"},
			briefing = "Bring these supplies over when you can. There's always something to replace around here.",
			completion = "That'll do nicely.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 5,
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
			id = "AR18",
			name = "A Place in the Record",
			kind = "arena",
			requires = {"AR16"},
			briefing = (
				"Join a sanctioned bout here in Marsh against someone you haven't faced before. Finish the "
				.. "match properly."
			),
			completion = "Good match. Take a breather before you sign up again.",
			target = 1,
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
			id = "AR19",
			name = "Championship Form",
			kind = "tracker",
			requires = {"AR17", "AR18"},
			briefing = (
				"Sanctioned bouts against different human opponents. Fighting the same friend all afternoon "
				.. "doesn't count."
			),
			completion = "A few different opponents now. You're getting a proper feel for it.",
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
			id = "AR20",
			name = "The Championship Bout",
			kind = "arena",
			requires = {"AR19"},
			briefing = (
				"Join a sanctioned bout here in Marsh against someone you haven't faced before. Finish the "
				.. "match properly."
			),
			completion = "Good match. Take a breather before you sign up again.",
			target = 1,
			discounts = {{npc = "'Arena Master'", service = "treatment", fraction = 0.1}},
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
			id = "AR21",
			name = "The Next Season",
			kind = "delivery",
			requires = {"AR20"},
			briefing = "Bring these supplies over when you can. There's always something to replace around here.",
			completion = "Thanks. I'll keep that out of the ring.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 6,
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
			id = "AR22",
			name = "The Name on the Board",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"AR21"},
			briefing = "Recover the historic competitor's final evidence for the arena records.",
			completion = "Set it here. I'll go through it between matches.",
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
			recognition = "Arena Master's trusted contact",
		},
	},
})
