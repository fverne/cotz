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
		deliveryTiers = {
			easy = {
				pools = {
					"valuables_workshop_tools",
					"valuables_drivers_wrenches",
					"valuables_repair_parts",
				},
				quantity = 1,
			},
			medium = {
				pools = {
					"valuables_workshop_consumables",
					"valuables_transit_cases",
					"valuables_electrical_supplies",
				},
				quantity = 1,
			},
			hard = {
				pools = {
					"valuables_reinforced_cases",
					"valuables_secured_cases",
					"valuables_instruments",
				},
				quantity = 2,
			},
		},
		quantities = {2, 4, 7},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	dialogue = {
		delivery = "Here. Keep the labels with it.",
		completedGreeting = (
			"Come in. You've earned the right to stand beside the bench without me wondering what "
			.. "useless weight you've brought."
		),
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Mechanical salvage. Check the part before hauling it back; I can't mend a sack of rust. Leave the "
			.. "useless weight where you find it. I need workable salvage, and you need your back for the next "
			.. "trip."
		),
		progressionPrompt = "What else needs doing?",
		progression = (
			"Parts first. Then there are machinery records worth recovering. Might stop us dragging back the "
			.. "wrong thing. I'll sort the material if you bring it in. The older records need fetching too; a "
			.. "proper specification can save a lot of cutting and swearing."
		),
	},
	catalogue = {
		["fireaxe"] = {step = "LA05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["fubar"] = {step = "LA13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["lax410s"] = {step = "LA07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["m3supershort"] = {step = "LA07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["stoegerddshort"] = {step = "LA07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "LA01",
			completionCash = 275,
			name = "A Place to Sort",
			kind = "delivery",
			requires = {},
			briefing = (
				"This is what I need. Check its condition before you haul it back. Fasteners aren't "
				.. "glamorous. Neither is watching a useful assembly come apart because nobody wanted to "
				.. "carry the right ones."
			),
			completion = (
				"Useful. Put it by the bench. Those will do. Small things first; the heavy things are "
				.. "much more cooperative when they're held together."
			),
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
			completionCash = 450,
			name = "The Missing Inventory",
			kind = "field",
			objective = "Recover Warehouse Packing List A from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"LA01"},
			briefing = "Recover a sorting-yard inventory in Garbage.",
			completion = "Let's see the markings.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_manifest",
				label = "The Missing Inventory - Warehouse Packing List A",
			},
			benefits = {},
		},
		{
			id = "LA03",
			completionCash = 0,
			name = "Worth Picking Up",
			kind = "tracker",
			requires = {"LA02"},
			briefing = "Mechanical salvage. Check the part before hauling it back; I can't mend a sack of rust.",
			completion = "You've kept useful parts coming. I can tell you're looking before you pick things up.",
			target = 2,
			benefits = {},
		},
		{
			id = "LA04",
			completionCash = 650,
			name = "The Broken Bench",
			kind = "field",
			objective = "Recover Stickered Tool Case from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"LA03"},
			briefing = "Recover a workshop tool case from wreckage.",
			completion = "Set it down. I'll open it.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_tools",
				label = "The Broken Bench - Stickered Tool Case",
			},
			benefits = {},
		},
		{
			id = "LA05",
			completionCash = 575,
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
			benefits = {},
		},
		{
			id = "LA06",
			completionCash = 850,
			name = "A Machine With a Number",
			kind = "field",
			objective = "Recover Red-Trimmed Control Unit from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"LA04"},
			briefing = "Retrieve a machinery identification plate.",
			completion = "Good. This deserves a proper look.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_control",
				label = "A Machine With a Number - Red-Trimmed Control Unit",
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
			completionCash = 0,
			name = "Sorted Properly",
			kind = "tracker",
			requires = {"LA05"},
			briefing = "Mechanical salvage. Check the part before hauling it back; I can't mend a sack of rust.",
			completion = "You've kept useful parts coming. I can tell you're looking before you pick things up.",
			target = 5,
			benefits = {},
		},
		{
			id = "LA08",
			capacity = {kind = "weight", amount = 1},
			completionCash = 1050,
			name = "The Borrowed Specification",
			kind = "field",
			objective = "Recover Official File Folder from the assigned search area in Garbage. Deliver it to"
				.. " 'Technut' in Marsh, then return here to finish the assignment.",
			requires = {"LA06"},
			briefing = "Recover an assembly drawing near an industrial cache.",
			completion = "Right. Now they can look at the actual thing instead of guessing what I meant.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_official",
				label = "The Borrowed Specification - Official File Folder",
				recipient = "technut",
			},
			benefits = {},
		},
		{
			id = "LA09",
			completionCash = 875,
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
			benefits = {},
		},
		{
			id = "LA10",
			completionCash = 1250,
			name = "The Wrong Replacement",
			kind = "field",
			objective = "Recover Striped Equipment Case from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"LA08"},
			briefing = "Recover a failed component case for comparison.",
			completion = "Set it down. I'll open it.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_equipment",
				label = "The Wrong Replacement - Striped Equipment Case",
			},
			benefits = {},
		},
		{
			id = "LA11",
			completionCash = 0,
			name = "More Than Scrap",
			kind = "tracker",
			requires = {"LA09"},
			briefing = "Mechanical salvage. Check the part before hauling it back; I can't mend a sack of rust.",
			completion = "You've kept useful parts coming. I can tell you're looking before you pick things up.",
			target = 9,
			benefits = {},
		},
		{
			id = "LA12",
			completionCash = 1450,
			name = "The Old Workshop",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Garbage. Deliver it to"
				.. " 'Technut' in Marsh, then return here to finish the assignment.",
			requires = {"LA10"},
			briefing = (
				"Retrieve an engineer's repair ledger in regional ruins. Check what can be recovered "
				.. "before committing yourself to a heavy load. You don't have to impress me with the "
				.. "weight of it."
			),
			completion = (
				"Right. Now they can look at the actual thing instead of guessing what I meant. Right. "
				.. "I'll see what we can learn from this before I start pulling anything else apart."
			),
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_notebook",
				label = "The Old Workshop - Tied Leather Journal",
				recipient = "technut",
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
			completionCash = 1175,
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
			benefits = {},
		},
		{
			id = "LA14",
			capacity = {kind = "weight", amount = 1},
			completionCash = 1650,
			name = "The Precision Crate",
			kind = "field",
			objective = "Recover Stickered Tool Case from the assigned search area in Waystation. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"LA12"},
			briefing = "Recover a machinery case in Waystation territory.",
			completion = "Let's see the markings.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_tools",
				label = "The Precision Crate - Stickered Tool Case",
			},
			benefits = {},
		},
		{
			id = "LA15",
			completionCash = 0,
			name = "A Working Yard",
			kind = "tracker",
			requires = {"LA13"},
			briefing = "Mechanical salvage. Check the part before hauling it back; I can't mend a sack of rust.",
			completion = "You've kept useful parts coming. I can tell you're looking before you pick things up.",
			target = 14,
			benefits = {},
		},
		{
			id = "LA16",
			completionCash = 1850,
			name = "Where It Was Built",
			kind = "field",
			objective = "Recover Corporate Records Folder from the assigned search area in Pripyat. Deliver it to"
				.. " 'Carbon' in Waystation, then return here to finish the assignment.",
			requires = {"LA14"},
			briefing = "Recover manufacturing records from a Pripyat service site.",
			completion = "Right. Now they can look at the actual thing instead of guessing what I meant.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_archive",
				label = "Where It Was Built - Corporate Records Folder",
				recipient = "carbon",
			},
			benefits = {},
		},
		{
			id = "LA17",
			completionCash = 1475,
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
			benefits = {},
		},
		{
			id = "LA18",
			completionCash = 2050,
			name = "The Last Bearing",
			kind = "field",
			objective = "Recover Striped Equipment Case from the assigned search area in Pripyat. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"LA16"},
			briefing = "Recover a specialist machinery case in Pripyat.",
			completion = "Good. This deserves a proper look.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_equipment",
				label = "The Last Bearing - Striped Equipment Case",
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
			completionCash = 0,
			name = "Nothing Wasted",
			kind = "tracker",
			requires = {"LA17", "LA18"},
			briefing = "Mechanical salvage. Check the part before hauling it back; I can't mend a sack of rust.",
			completion = "You've kept useful parts coming. I can tell you're looking before you pick things up.",
			target = 20,
			benefits = {},
		},
		{
			id = "LA20",
			completionCash = 2250,
			name = "The Load Test",
			kind = "field",
			objective = "Deploy the recorder in Garbage, leave it to record, then retrieve Numbered Data Module 0013."
				.. " Return it to this contact to finish the assignment.",
			requires = {"LA19"},
			briefing = "Deploy and retrieve a machinery recorder at its source site.",
			completion = "Let's see the markings.",
			field = {
				kind = "sensor",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_module",
				label = "The Load Test - Numbered Data Module 0013",
			},
			benefits = {},
			stock = {
				item = "drink_bottlewater",
				bonus = 2,
			},
		},
		{
			id = "LA21",
			completionCash = 1775,
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
			benefits = {},
		},
		{
			id = "LA22",
			capacity = {kind = "weight", amount = 1},
			completionCash = 2450,
			name = "The Commissioning Plate",
			kind = "field",
			objective = "Recover Official File Folder from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"LA21"},
			briefing = (
				"Recover the machine's commissioning evidence and return. Keep the commissioning papers together. "
				.. "I want to see what was actually specified before I start congratulating anyone's workmanship."
			),
			completion = (
				"Set it down. I'll open it. Right. That's something solid to work from. People see rust and decide "
				.. "the whole lot's finished. You've been willing to look a bit closer. I appreciate that."
			),
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_official",
				label = "The Commissioning Plate - Official File Folder",
			},
			benefits = {},
			recognition = "Latch's trusted contact",
		},
	},
})
