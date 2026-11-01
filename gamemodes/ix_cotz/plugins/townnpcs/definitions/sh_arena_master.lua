PLUGIN:Register("arena-master", {
	name = "'Arena Master'",
	template = "arenanpc",
	map = "rp_marsh_cs",
	job = {
		kind = "arena",
		category = "Arena bouts",
		description = "Arena bouts",
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Between rounds",
				items = {"medic_bandage_1", "drink_bottlewater"}},
			{label = "Recovery",
				items = {"medic_medkit_1", "drug_painkillers"}},
			{label = "Next bout",
				items = {"9x19", "12gauge"}},
		},
	},
	dialogue = {
		completedGreeting = (
			"Good to see you. Match on your mind, or are you giving yourself a well-earned afternoon "
			.. "off?"
		),
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Sanctioned bouts against different human opponents. Fighting the same friend all afternoon doesn't "
			.. "count. Give yourself a breather between bouts. You won't impress anyone by turning up too tired to "
			.. "put on a proper match."
		),
		progressionPrompt = "What else needs doing?",
		progression = (
			"I've got equipment to sort and a few missing records. And, of course, there's the arena. The arena "
			.. "has its share of missing equipment and untidy records. Helping me with those is less glamorous "
			.. "than a bout, but somebody has to do it."
		),
	},
	catalogue = {
	},
	progression = {
		{
			id = "AR01",
			completionCash = 275,
			name = "Before the Bell",
			kind = "delivery",
			requires = {},
			briefing = (
				"Bring these supplies over when you can. There's always something to replace around "
				.. "here. Less exciting than a match, I know. Still, people notice very quickly when the "
				.. "supplies aren't ready."
			),
			completion = (
				"Lovely. Put it with the arena supplies. Much appreciated. Nice to meet someone who "
				.. "helps before the cheering starts."
			),
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
			completionCash = 0,
			name = "The Missing Register",
			kind = "arena",
			requires = {"AR01"},
			briefing = (
				"Join a sanctioned bout here in Marsh against someone you haven't faced before. Finish the "
				.. "match properly."
			),
			completion = "Good match. Take a breather before you sign up again.",
			target = 1,
			benefits = {},
		},
		{
			id = "AR03",
			completionCash = 0,
			name = "First Opponents",
			kind = "tracker",
			requires = {"AR02"},
			briefing = (
				"Sanctioned bouts against different human opponents. Fighting the same friend all afternoon "
				.. "doesn't count."
			),
			completion = "A few different opponents now. You're getting a proper feel for it.",
			target = 2,
			benefits = {},
		},
		{
			id = "AR04",
			completionCash = 0,
			name = "A Fair Match",
			kind = "arena",
			requires = {"AR03"},
			briefing = (
				"Join a sanctioned bout here in Marsh against someone you haven't faced before. Finish the "
				.. "match properly."
			),
			completion = "Good match. Take a breather before you sign up again.",
			target = 1,
			benefits = {},
		},
		{
			id = "AR05",
			completionCash = 575,
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
			benefits = {},
		},
		{
			id = "AR06",
			completionCash = 850,
			name = "The Damaged Shipment",
			kind = "field",
			objective = "Recover Armour Plate Transit Case from the assigned search area in Marsh. Deliver it to"
				.. " 'Suture' in Waystation, then return here to finish the assignment.",
			requires = {"AR04"},
			briefing = "Recover a protective-equipment case along the supply route.",
			completion = "Good. Someone has to keep track of what arrives between bouts.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_armour",
				label = "The Damaged Shipment - Armour Plate Transit Case",
				recipient = "suture",
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
			completionCash = 0,
			name = "Not the Same Face",
			kind = "tracker",
			requires = {"AR05"},
			briefing = (
				"Sanctioned bouts against different human opponents. Fighting the same friend all afternoon "
				.. "doesn't count."
			),
			completion = "A few different opponents now. You're getting a proper feel for it.",
			target = 5,
			benefits = {},
		},
		{
			id = "AR08",
			completionCash = 0,
			name = "The Referee's Record",
			kind = "arena",
			requires = {"AR06"},
			briefing = (
				"Join a sanctioned bout here in Marsh against someone you haven't faced before. Finish the "
				.. "match properly."
			),
			completion = "Good match. Take a breather before you sign up again.",
			target = 1,
			benefits = {},
		},
		{
			id = "AR09",
			completionCash = 875,
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
			benefits = {},
		},
		{
			id = "AR10",
			completionCash = 1250,
			name = "The Supplier's Seal",
			kind = "field",
			objective = "Recover Warehouse Packing List A from the assigned search area in Marsh. Deliver it to"
				.. " 'Brass' in Garbage, then return here to finish the assignment.",
			requires = {"AR08"},
			briefing = "Recover evidence identifying an interrupted arena shipment.",
			completion = "Good. Someone has to keep track of what arrives between bouts.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_manifest",
				label = "The Supplier's Seal - Warehouse Packing List A",
				recipient = "brass",
			},
			benefits = {},
		},
		{
			id = "AR11",
			completionCash = 0,
			name = "A Broader Field",
			kind = "tracker",
			requires = {"AR09"},
			briefing = (
				"Sanctioned bouts against different human opponents. Fighting the same friend all afternoon "
				.. "doesn't count."
			),
			completion = "A few different opponents now. You're getting a proper feel for it.",
			target = 9,
			benefits = {},
		},
		{
			id = "AR12",
			completionCash = 0,
			name = "An Honest Result",
			kind = "arena",
			requires = {"AR10"},
			briefing = (
				"Join a sanctioned bout here in Marsh against someone you haven't faced before. Finish "
				.. "the match properly. Let the match be a match. A decent opponent deserves your "
				.. "attention, and you'll get more out of it than another easy afternoon."
			),
			completion = (
				"Good match. Take a breather before you sign up again. That's the sort of result worth "
				.. "keeping. Catch your breath; the next match doesn't need you this instant."
			),
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
			completionCash = 1175,
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
			benefits = {},
		},
		{
			id = "AR14",
			completionCash = 1650,
			name = "A Fighter's Effects",
			kind = "field",
			objective = "Recover Personnel File Folder from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"AR12"},
			briefing = "Recover a former competitor's equipment case.",
			completion = "Let's see what you brought back.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_personnel",
				label = "A Fighter's Effects - Personnel File Folder",
			},
			benefits = {},
		},
		{
			id = "AR15",
			completionCash = 0,
			name = "Veteran Company",
			kind = "tracker",
			requires = {"AR13"},
			briefing = (
				"Sanctioned bouts against different human opponents. Fighting the same friend all afternoon "
				.. "doesn't count."
			),
			completion = "A few different opponents now. You're getting a proper feel for it.",
			target = 14,
			benefits = {},
		},
		{
			id = "AR16",
			completionCash = 0,
			name = "The Missing Result",
			kind = "arena",
			requires = {"AR14"},
			briefing = (
				"Join a sanctioned bout here in Marsh against someone you haven't faced before. Finish the "
				.. "match properly."
			),
			completion = "Good match. Take a breather before you sign up again.",
			target = 1,
			benefits = {},
		},
		{
			id = "AR17",
			completionCash = 1475,
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
			benefits = {},
		},
		{
			id = "AR18",
			completionCash = 0,
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
			completionCash = 0,
			name = "Championship Form",
			kind = "tracker",
			requires = {"AR17", "AR18"},
			briefing = (
				"Sanctioned bouts against different human opponents. Fighting the same friend all afternoon "
				.. "doesn't count."
			),
			completion = "A few different opponents now. You're getting a proper feel for it.",
			target = 20,
			benefits = {},
		},
		{
			id = "AR20",
			completionCash = 0,
			name = "The Championship Bout",
			kind = "arena",
			requires = {"AR19"},
			briefing = (
				"Join a sanctioned bout here in Marsh against someone you haven't faced before. Finish the "
				.. "match properly."
			),
			completion = "Good match. Take a breather before you sign up again.",
			target = 1,
			benefits = {},
			stock = {
				item = "drink_bottlewater",
				bonus = 2,
			},
		},
		{
			id = "AR21",
			completionCash = 1775,
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
			benefits = {},
		},
		{
			id = "AR22",
			completionCash = 2450,
			name = "The Name on the Board",
			kind = "field",
			objective = "Recover Corporate Records Folder from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"AR21"},
			briefing = (
				"Recover the historic competitor's final evidence for the arena records. Keep the records together "
				.. "when you bring them back. I'd like to give that old name something firmer to stand on than "
				.. "another second-hand story."
			),
			completion = (
				"Set it here. I'll go through it between matches. There we are. Something I can actually read "
				.. "between matches. You've taken the unglamorous side of this seriously as well. I notice that, even "
				.. "if it doesn't get the loudest cheer."
			),
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_archive",
				label = "The Name on the Board - Corporate Records Folder",
			},
			benefits = {},
			recognition = "Arena Master's trusted contact",
		},
	},
})
