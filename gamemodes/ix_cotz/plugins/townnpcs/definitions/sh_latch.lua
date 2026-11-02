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
	rewards = {
		packages = {
			{label = "Workshop stock (trade goods)",
				items = {"value_bolts", "value_nuts", "value_guncleaner"}},
			{label = "Salvage protection",
				items = {"medic_bandage_1", "drug_painkillers"}},
			{label = "Shift provisions",
				items = {"food_can_tushonka", "drink_bottlewater"}},
		},
		bonusItems = {
			"fireaxe",
			"fubar",
		},
	},
	dialogue = {
		delivery = "Here. Keep the labels with it.",
		completedGreeting = (
			"Come in. You've earned the right to stand beside the bench without me wondering what "
			.. "useless weight you've brought."
		),
		workPrompt = "About the salvage order.",
		offerPrompt = "Do you need workshop salvage?",
		work = (
			"Mechanical salvage, tools, stock worth working with. Pick an order and read it before hauling a "
			.. "sack across the region. If you don't know what you're looking at, ask while we're beside the "
			.. "bench. I can explain a part here more easily than you can carry a useless one home."
		),
		progressionPrompt = "What are you trying to put together?",
		progression = (
			"I want to sort useful stock and compare the machinery records with the surviving pieces. Work "
			.. "before claims. A good drawing doesn't mean the assembly matches it, and a rusty part isn't "
			.. "automatically finished. We'll take a manageable request first. Any delivery to another workshop is "
			.. "written on its order; come back after the handover."
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
				"Bring the fasteners on the list. I need a place where I can sort what comes in and keep the "
				.. "useful pieces together. Without enough of these, the workbench turns into several small "
				.. "piles on the floor."
			),
			completion = (
				"That'll do. Put them there. I can get the bench sorted without having to spend the rest of "
				.. "the day looking for the things I just put down."
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
			objective = (
				"Recover the sorting-yard stock journal from the assigned search area in Garbage. Bring it back to "
				.. "the issuing contact in Garbage."
			),
			requires = {"LA01"},
			briefing = (
				"I want the sorting-yard inventory. Hard to recover useful stock when everyone remembers a "
				.. "different pile. Recover the sorting-yard stock journal from the assigned search area in Garbage. "
				.. "Bring it back to me in Garbage."
			),
			completion = "Put it where the filings won't get into it. I'll see how they sorted the stock.",
			field = {
				description = (
					"A printed packing list on a small clipboard with a metal clip and a circular stamp. Latch's "
					.. "note: \"I want the sorting-yard inventory.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_manifest",
				label = "Sorting-yard stock journal",
			},
			benefits = {},
		},
		{
			id = "LA03",
			completionCash = 0,
			name = "Worth Picking Up",
			kind = "tracker",
			requires = {"LA02"},
			briefing = "Keep the industrial salvage deliveries coming. Useful pieces and tools, matched to the order.",
			completion = "A good start. You haven't confused weight with usefulness.",
			target = 2,
			benefits = {},
		},
		{
			id = "LA04",
			completionCash = 650,
			name = "The Broken Bench",
			kind = "field",
			objective = (
				"Recover the bench tool kit from the assigned search area in Garbage. Bring it back to the issuing "
				.. "contact in Garbage."
			),
			requires = {"LA03"},
			briefing = (
				"A workshop case is worth looking for. A decent tool can outlast the bench it was left on. Recover "
				.. "the bench tool kit from the assigned search area in Garbage. Bring it back to me in Garbage."
			),
			completion = "Let's see the tools before anyone decides which ones they need to borrow.",
			field = {
				description = (
					"A handled tool case covered in bright stickers and contrasting printed decoration. Latch's note: "
					.. "\"A workshop case is worth looking for.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_tools",
				label = "bench tool kit",
			},
			benefits = {},
		},
		{
			id = "LA05",
			completionCash = 575,
			name = "Useful Steel",
			kind = "delivery",
			requires = {"LA04"},
			briefing = (
				"Bring the listed workshop supplies here. I'd like to work with the proper pieces rather than keep "
				.. "adapting around a shortage."
			),
			completion = "Good. I'll sort them before they become another mixed pile.",
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
			objective = (
				"Recover the machine identification file from the assigned search area in Garbage. Bring it back "
				.. "to the issuing contact in Garbage."
			),
			requires = {"LA04"},
			briefing = (
				"I want the machinery identification record. Guessing from the outside wastes time once you start "
				.. "looking for parts. Recover the machine identification file from the assigned search area in "
				.. "Garbage. Bring it back to me in Garbage."
			),
			completion = "There. Something we can check against the machine instead of recognising it by argument.",
			field = {
				description = (
					"A finned grey control box with a red stripe and several round front connectors. Latch's note: \"I "
					.. "want the machinery identification record.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_control",
				label = "Machine identification file",
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
			briefing = "Continue the salvage orders. Check the working surfaces before declaring a piece worth carrying.",
			completion = "You've brought usable stock. That saves time at this end.",
			target = 5,
			benefits = {},
		},
		{
			id = "LA08",
			capacity = {kind = "weight", amount = 1},
			completionCash = 1050,
			name = "The Borrowed Specification",
			kind = "field",
			objective = (
				"Recover the assembly drawing for Technut from the assigned search area in Garbage. Deliver it to "
				.. "'Technut' in Marsh, then come back to the issuing contact in Garbage."
			),
			requires = {"LA06"},
			briefing = (
				"Technut should have the assembly drawing himself. He'll notice details I might leave out "
				.. "describing it. Recover the assembly drawing for Technut from the assigned search area in Garbage. "
				.. "Deliver it to 'Technut' in Marsh, then come back to me in Garbage."
			),
			completion = "He's got it? Good. If he wants to propose alterations, he can at least begin with the original.",
			field = {
				description = (
					"A cardboard file folder with a small coloured crest on its cover. Latch's note: \"Technut should "
					.. "have the assembly drawing himself.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_official",
				label = "Assembly drawing for Technut",
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
			briefing = "There's another supply list. Check what will actually serve the job before hauling it over.",
			completion = "That will do the work. Put it on the clear end.",
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
			objective = (
				"Recover the failed replacement component from the assigned search area in Garbage. Bring it back "
				.. "to the issuing contact in Garbage."
			),
			requires = {"LA08"},
			briefing = (
				"I want the failed replacement kept as it was found. Someone calling it defective doesn't explain "
				.. "how it was fitted. Recover the failed replacement component from the assigned search area in "
				.. "Garbage. Bring it back to me in Garbage."
			),
			completion = "Leave it assembled. I'll look at the wear before I move anything.",
			field = {
				description = (
					"A low hard case with long contrasting strips across its ribbed lid. Latch's note: \"I want the "
					.. "failed replacement kept as it was found.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_equipment",
				label = "Failed replacement component",
			},
			benefits = {},
		},
		{
			id = "LA11",
			completionCash = 0,
			name = "More Than Scrap",
			kind = "tracker",
			requires = {"LA09"},
			briefing = "More salvage deliveries. I'd like the yard supplied while I inspect the machinery records.",
			completion = "That's been steady work. I can make room for what you bring without expecting a surprise.",
			target = 9,
			benefits = {},
		},
		{
			id = "LA12",
			completionCash = 1450,
			name = "The Old Workshop",
			kind = "field",
			objective = (
				"Recover the workshop repair ledger from the assigned search area in Garbage. Deliver it to "
				.. "'Technut' in Marsh, then come back to the issuing contact in Garbage."
			),
			requires = {"LA10"},
			briefing = (
				"The repair ledger goes to Technut. I'd like another pair of eyes on the old workshop methods. "
				.. "Recover the workshop repair ledger from the assigned search area in Garbage. Deliver it to "
				.. "'Technut' in Marsh, then come back to me in Garbage."
			),
			completion = "Good. He can read it without me hovering and explaining what he ought to notice.",
			field = {
				description = (
					"A thick brown journal held together by a narrow tie around its cover. Latch's note: \"The repair "
					.. "ledger goes to Technut.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_notebook",
				label = "Workshop repair ledger",
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
			briefing = (
				"I need the requested material for the bench work. Don't damage useful pieces packing them around "
				.. "heavier scrap."
			),
			completion = "Thanks. I'll keep this apart from the rough stock.",
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
			objective = (
				"Recover the precision machinery case from the assigned search area in Waystation. Bring it back "
				.. "to the issuing contact in Garbage."
			),
			requires = {"LA12"},
			briefing = (
				"A machinery case is still out in Waystation territory. I want to inspect what's survived before "
				.. "writing it off. Recover the precision machinery case from the assigned search area in Waystation. "
				.. "Bring it back to me in Garbage."
			),
			completion = "That's the case. I'll check the contents on a clear bench.",
			field = {
				description = (
					"A handled tool case covered in bright stickers and contrasting printed decoration. Latch's note: "
					.. "\"A machinery case is still out in Waystation territory.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_tools",
				label = "Precision machinery case",
			},
			benefits = {},
		},
		{
			id = "LA15",
			completionCash = 0,
			name = "A Working Yard",
			kind = "tracker",
			requires = {"LA13"},
			briefing = "Keep filling the salvage requests. There's ordinary work left after the interesting finds.",
			completion = "You've kept at the sorting as well as the carrying. Good.",
			target = 14,
			benefits = {},
		},
		{
			id = "LA16",
			completionCash = 1850,
			name = "Where It Was Built",
			kind = "field",
			objective = (
				"Recover the manufacturing records for Carbon from the assigned search area in Pripyat. Deliver it "
				.. "to 'Carbon' in Waystation, then come back to the issuing contact in Garbage."
			),
			requires = {"LA14"},
			briefing = (
				"Carbon can compare the manufacturing papers with other records. I want the history checked before "
				.. "it becomes another workshop certainty. Recover the manufacturing records for Carbon from the "
				.. "assigned search area in Pripyat. Deliver it to 'Carbon' in Waystation, then come back to me in "
				.. "Garbage."
			),
			completion = "He has the file. We'll let him read it rather than supply the answer for him.",
			field = {
				description = (
					"A blue records folder with contrasting corporate lettering along the cover. Latch's note: "
					.. "\"Carbon can compare the manufacturing papers with other records.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_archive",
				label = "Manufacturing records for Carbon",
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
			briefing = (
				"Bring the supplies on this order. I'd like the preparation finished before I start assembling "
				.. "anything."
			),
			completion = "All here. I can get on with the bench work now.",
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
			objective = (
				"Recover the specialist bearing case from the assigned search area in Pripyat. Bring it back to "
				.. "the issuing contact in Garbage."
			),
			requires = {"LA16"},
			briefing = (
				"There's a specialist component case to recover. I'd rather inspect the proper part than spend "
				.. "another week making near enough fit. Recover the specialist bearing case from the assigned search "
				.. "area in Pripyat. Bring it back to me in Garbage."
			),
			completion = "Keep the fittings together. I'll measure it before anybody starts celebrating.",
			field = {
				description = (
					"A low hard case with long contrasting strips across its ribbed lid. Latch's note: \"There's a "
					.. "specialist component case to recover.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_equipment",
				label = "Specialist bearing case",
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
			briefing = "Continue the workshop salvage orders. I want a reserve I can use, not a heap to argue over.",
			completion = "You've given the bench work some breathing room. I appreciate it.",
			target = 20,
			benefits = {},
		},
		{
			id = "LA20",
			completionCash = 2250,
			name = "The Load Test",
			kind = "field",
			objective = (
				"Deploy the recorder at the assigned site in Garbage, let it finish recording, then retrieve the "
				.. "machinery load-test recorder. Bring it back to the issuing contact in Garbage."
			),
			requires = {"LA19"},
			briefing = (
				"I want a recording from the machinery survey. An encouraging sound isn't much of a test. Deploy "
				.. "the recorder at the assigned site in Garbage, let it finish recording, then retrieve the "
				.. "machinery load-test recorder. Bring it back to me in Garbage."
			),
			completion = "All right. I'll go through the record before deciding what we can ask the assembly to do.",
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. Latch's note: "
					.. "\"I want a recording from the machinery survey.\""
				),
				kind = "sensor",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_module",
				label = "Machinery load-test recorder",
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
			briefing = (
				"Bring the listed workshop supplies here. I'd like to work with the proper pieces rather than keep "
				.. "adapting around a shortage."
			),
			completion = "Good. I'll sort them before they become another mixed pile.",
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
			objective = (
				"Recover the machine commissioning papers from the assigned search area in Garbage. Bring it back "
				.. "to the issuing contact in Garbage."
			),
			requires = {"LA21"},
			briefing = (
				"The commissioning record should show what they intended this machine to handle. I want that "
				.. "beside our repair notes. Recover the machine commissioning papers from the assigned search area "
				.. "in Garbage. Bring it back to me in Garbage."
			),
			completion = (
				"Leave the papers here. You've done the carrying and the fetching without losing interest halfway "
				.. "through. That's work I'd be pleased to share a bench over."
			),
			field = {
				description = (
					"A cardboard file folder with a small coloured crest on its cover. Latch's note: \"The "
					.. "commissioning record should show what they intended this machine to handle.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_official",
				label = "Machine commissioning papers",
			},
			benefits = {},
			recognition = "Latch's trusted contact",
		},
	},
})
