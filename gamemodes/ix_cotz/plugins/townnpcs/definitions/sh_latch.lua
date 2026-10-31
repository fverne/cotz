PLUGIN:Register("latch", {
	name = "'Latch'",
	template = "latchnpc",
	map = "mz_garbage",
	job = {
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		category = "Industrial salvage deliveries",
		description = "Industrial salvage deliveries",
		pools = {"fasteners", "basic_tools", "workshop_supplies"},
		quantities = {2, 4, 7},
		maps = {
			easy = "mz_garbage",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	dialogue = {
		completedGreeting = (
			"Those records give me something to work with. Better than guessing."
		),
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = "Mechanical salvage. Check the part before hauling it back; I can't mend a sack of rust.",
		progressionPrompt = "What else needs doing?",
		progression = (
			"Parts first. Then there are machinery records worth recovering. Might stop us dragging back "
			.. "the wrong thing."
		),
	},
	catalogue = {
		["fireaxe"] = {step = "LA05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["fubar"] = {step = "LA13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "LA01",
			name = "A Place to Sort",
			kind = "delivery",
			requires = {},
			briefing = "This is what I need. Check its condition before you haul it back.",
			completion = "Useful. Put it by the bench.",
			requirements = {
				{
					pool = "fasteners",
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
			id = "LA02",
			name = "The Missing Inventory",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"LA01"},
			briefing = "Recover a sorting-yard inventory in Garbage.",
			completion = "Let's see the markings.",
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
			id = "LA03",
			name = "Worth Picking Up",
			kind = "tracker",
			requires = {"LA02"},
			briefing = "Mechanical salvage. Check the part before hauling it back; I can't mend a sack of rust.",
			completion = "You've kept useful parts coming. I can tell you're looking before you pick things up.",
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
			id = "LA04",
			name = "The Broken Bench",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"LA03"},
			briefing = "Recover a workshop tool case from wreckage.",
			completion = "Set it down. I'll open it.",
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
			id = "LA05",
			name = "Useful Steel",
			kind = "delivery",
			requires = {"LA04"},
			briefing = "This is what I need. Check its condition before you haul it back.",
			completion = "That's sound enough.",
			requirements = {
				{
					pool = "basic_tools",
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
			id = "LA06",
			name = "A Machine With a Number",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"LA04"},
			briefing = "Retrieve a machinery identification plate.",
			completion = "Good. This deserves a proper look.",
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
			id = "LA07",
			name = "Sorted Properly",
			kind = "tracker",
			requires = {"LA05"},
			briefing = "Mechanical salvage. Check the part before hauling it back; I can't mend a sack of rust.",
			completion = "You've kept useful parts coming. I can tell you're looking before you pick things up.",
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
			id = "LA08",
			name = "The Borrowed Specification",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"LA06"},
			briefing = "Recover an assembly drawing near an industrial cache.",
			completion = "Let's see the markings.",
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
			id = "LA09",
			name = "Moving Parts",
			kind = "delivery",
			requires = {"LA07"},
			briefing = "This is what I need. Check its condition before you haul it back.",
			completion = "Good. Somebody checked before carrying it.",
			requirements = {
				{
					pool = "workshop_supplies",
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
			id = "LA10",
			name = "The Wrong Replacement",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"LA08"},
			briefing = "Recover a failed component case for comparison.",
			completion = "Set it down. I'll open it.",
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
			id = "LA11",
			name = "More Than Scrap",
			kind = "tracker",
			requires = {"LA09"},
			briefing = "Mechanical salvage. Check the part before hauling it back; I can't mend a sack of rust.",
			completion = "You've kept useful parts coming. I can tell you're looking before you pick things up.",
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
			id = "LA12",
			name = "The Old Workshop",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"LA10"},
			briefing = "Retrieve an engineer's repair ledger in regional ruins.",
			completion = "Good. This deserves a proper look.",
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
			id = "LA13",
			name = "Heavy Work",
			kind = "delivery",
			requires = {"LA11"},
			briefing = "This is what I need. Check its condition before you haul it back.",
			completion = "Useful. Put it by the bench.",
			requirements = {
				{
					pool = "fasteners",
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
			id = "LA14",
			name = "The Precision Crate",
			kind = "field",
			objective = "Recover the marked case in Waystation. Return to this contact to finish the assignment.",
			requires = {"LA12"},
			briefing = "Recover a machinery case in Waystation territory.",
			completion = "Let's see the markings.",
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
			id = "LA15",
			name = "A Working Yard",
			kind = "tracker",
			requires = {"LA13"},
			briefing = "Mechanical salvage. Check the part before hauling it back; I can't mend a sack of rust.",
			completion = "You've kept useful parts coming. I can tell you're looking before you pick things up.",
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
			id = "LA16",
			name = "Where It Was Built",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"LA14"},
			briefing = "Recover manufacturing records from a Pripyat service site.",
			completion = "Set it down. I'll open it.",
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
			id = "LA17",
			name = "Parts Worth Carrying",
			kind = "delivery",
			requires = {"LA15"},
			briefing = "This is what I need. Check its condition before you haul it back.",
			completion = "That's sound enough.",
			requirements = {
				{
					pool = "basic_tools",
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
			id = "LA18",
			name = "The Last Bearing",
			kind = "field",
			objective = "Recover the marked case in Pripyat. Return to this contact to finish the assignment.",
			requires = {"LA16"},
			briefing = "Recover a specialist machinery case in Pripyat.",
			completion = "Good. This deserves a proper look.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
			},
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
			id = "LA19",
			name = "Nothing Wasted",
			kind = "tracker",
			requires = {"LA17", "LA18"},
			briefing = "Mechanical salvage. Check the part before hauling it back; I can't mend a sack of rust.",
			completion = "You've kept useful parts coming. I can tell you're looking before you pick things up.",
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
			id = "LA20",
			name = "The Load Test",
			kind = "field",
			objective = (
				"Deploy the recorder at the marked site, remain in range until it finishes, and collect it "
				.. "in Garbage. Return to this contact to finish the assignment."
			),
			requires = {"LA19"},
			briefing = "Deploy and retrieve a machinery recorder at its source site.",
			completion = "Let's see the markings.",
			field = {
				kind = "sensor",
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
			id = "LA21",
			name = "Ready for Assembly",
			kind = "delivery",
			requires = {"LA20"},
			briefing = "This is what I need. Check its condition before you haul it back.",
			completion = "Good. Somebody checked before carrying it.",
			requirements = {
				{
					pool = "workshop_supplies",
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
			id = "LA22",
			name = "The Commissioning Plate",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"LA21"},
			briefing = "Recover the machine's commissioning evidence and return.",
			completion = "Set it down. I'll open it.",
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
			recognition = "Latch's trusted contact",
		},
	},
})
