PLUGIN:Register("technut", {
	name = "'Technut'",
	template = "technpc",
	map = "rp_marsh_cs",
	job = {
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		category = "Industrial salvage deliveries",
		description = "Industrial salvage deliveries",
		pools = {"fasteners", "basic_tools", "workshop_supplies"},
		deliveryTiers = {
			easy = {
				pools = {
					"valuables_workshop_consumables",
					"valuables_drivers_wrenches",
				},
				quantity = 1,
			},
			medium = {
				pools = {
					"valuables_workshop_tools",
					"valuables_cutting_tools",
					"valuables_repair_parts",
				},
				quantity = 1,
			},
			hard = {
				pools = {
					"valuables_instruments",
					"valuables_control_electronics",
				},
				quantity = 2,
			},
		},
		quantities = {2, 4, 7},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Bench supplies (trade goods)",
				items = {"value_nuts", "value_bolts", "value_guncleaner"}},
			{label = "Workshop stock (trade goods)",
				items = {"value_screws", "value_motorclean"}},
			{label = "Workshop provisions",
				items = {"drink_bottlewater", "food_bread"}},
		},
		bonusService = "repair",
	},
	dialogue = {
		delivery = "Over here, buddy. Let me see what we have got.",
		completedGreeting = (
			"Buddy! Come and have a look, if you've got a minute. No, you don't have to fetch anything "
			.. "first."
		),
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Workshop tools and mechanical parts, buddy. Mute can have the loose circuit boards. Don't strip a "
			.. "useful tool to make a sack of mysterious pieces for me. Let me see what you've found before we "
			.. "decide how brave to be with it."
		),
		progressionPrompt = "What else needs doing?",
		progression = (
			"I've got several things on the bench. Some need parts; some need somebody willing to go and find "
			.. "the paperwork. The supplies keep the bench working. The records tell me what the people before us "
			.. "intended. I like experimenting, buddy, but I'd rather know which part was supposed to move first."
		),
	},
	catalogue = {
		["helm_tanker"] = {step = "TN01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["helm_steel_arab"] = {step = "TN03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["helm_steel_ger"] = {step = "TN03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["helm_steel_rus"] = {step = "TN03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["headwear_riot"] = {step = "TN05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["helm_operator_rus_1"] = {step = "TN13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["headwear_screen"] = {step = "TN13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["headwear_cs4"] = {step = "TN15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["helm_sphere08"] = {step = "TN17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["helm_sphere12"] = {step = "TN19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["attachment_aluframe"] = {step = "TN15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["attachment_carbonfibre"] = {step = "TN15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["attachment_ceramicplate_1"] = {step = "TN01",
			terms = {nil, 1, "SELLANDBUY", 1, 3, 1}},
		["attachment_ceramicplate_2"] = {step = "TN15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["attachment_ceramicplate_3"] = {step = "TN19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["attachment_fabric_1"] = {step = "TN01",
			terms = {nil, 1, "SELLANDBUY", 1, 3, 1}},
		["attachment_fabric_2"] = {step = "TN13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["attachment_kevlar_1"] = {step = "TN13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["attachment_kevlar_2"] = {step = "TN15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["attachment_steelframe"] = {step = "TN17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["attachment_steelplate_1"] = {step = "TN01",
			terms = {nil, 1, "SELLANDBUY", 1, 3, 1}},
		["attachment_steelplate_2"] = {step = "TN13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["attachment_steelplate_3"] = {step = "TN17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_cs1"] = {step = "TN09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_cs2"] = {step = "TN13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_cs3"] = {step = "TN16",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_mailjacket"] = {step = "TN03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_sunrise"] = {step = "TN07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "TN01",
			completionCash = 275,
			name = "A Bench to Work On",
			kind = "delivery",
			requires = {},
			briefing = (
				"I need a tool from this list for the bench. Bring it here and I'll see what condition it's "
				.. "in. It doesn't have to be beautiful; it has to do the job. Although if it is beautiful, I "
				.. "will certainly appreciate it!"
			),
			completion = (
				"Oh, good! Put it here where I can find it again. That gives me one less reason to borrow "
				.. "Gasket's things, which should make his afternoon considerably quieter."
			),
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
			id = "TN02",
			completionCash = 450,
			name = "The Missing Toolbox",
			kind = "field",
			objective = "Recover Stickered Tool Case from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"TN01"},
			briefing = "Recover a Marsh workshop case.",
			completion = "Oh, let me see! Mind the oil on the bench.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_tools",
				label = "The Missing Toolbox - Stickered Tool Case",
			},
			benefits = {},
		},
		{
			id = "TN03",
			completionCash = 0,
			name = "Keeping Busy",
			kind = "tracker",
			requires = {"TN02"},
			briefing = "Workshop tools and mechanical parts, buddy. Mute can have the loose circuit boards.",
			completion = (
				"You've kept the workshop supplied. Makes a pleasant change from taking something else apart "
				.. "for spares."
			),
			target = 2,
			benefits = {},
		},
		{
			id = "TN04",
			completionCash = 650,
			name = "A Regulator for Gasket",
			kind = "field",
			objective = "Recover Red-Trimmed Control Unit from the assigned search area in Marsh. Deliver it to"
				.. " 'Gasket' in Marsh, then return here to finish the assignment.",
			requires = {"TN03"},
			briefing = "Recover a regulator from a utility service cache.",
			completion = "Good, buddy. Much easier when the part and the person who needs it are in the same room.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_control",
				label = "A Regulator for Gasket - Red-Trimmed Control Unit",
				recipient = "gasket",
			},
			benefits = {},
		},
		{
			id = "TN05",
			completionCash = 575,
			name = "Something Accurate",
			kind = "delivery",
			requires = {"TN04"},
			briefing = (
				"These are the supplies I'm missing, buddy. Bring them to the bench and I can get on with "
				.. "it."
			),
			completion = "Put it on the clear end of the bench. There is one, I promise.",
			requirements = {
				{
					pool = "basic_tools",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "TN06",
			completionCash = 850,
			name = "The Misaligned Jig",
			kind = "field",
			objective = "Recover Official File Folder from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"TN04"},
			briefing = "Retrieve a workshop calibration record.",
			completion = "Careful with the case, buddy. I want to open it myself.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_official",
				label = "The Misaligned Jig - Official File Folder",
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
			id = "TN07",
			completionCash = 0,
			name = "Reliable Parts",
			kind = "tracker",
			requires = {"TN05"},
			briefing = "Workshop tools and mechanical parts, buddy. Mute can have the loose circuit boards.",
			completion = (
				"You've kept the workshop supplied. Makes a pleasant change from taking something else apart "
				.. "for spares."
			),
			target = 5,
			benefits = {},
		},
		{
			id = "TN08",
			completionCash = 1050,
			name = "An Engineer's Notes",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"TN06"},
			briefing = "Recover machinery notes in Garbage.",
			completion = "Oh, let me see! Mind the oil on the bench.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "An Engineer's Notes - Tied Leather Journal",
			},
			benefits = {},
		},
		{
			id = "TN09",
			completionCash = 875,
			name = "Steel and Seals",
			kind = "delivery",
			requires = {"TN07"},
			briefing = (
				"These are the supplies I'm missing, buddy. Bring them to the bench and I can get on with "
				.. "it."
			),
			completion = "Good condition, too. I can work with this.",
			requirements = {
				{
					pool = "workshop_supplies",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "TN10",
			completionCash = 1250,
			name = "Latch's Find",
			kind = "field",
			objective = "Recover Red-Trimmed Control Unit from the assigned search area in Marsh. Deliver it to"
				.. " 'Latch' in Garbage, then return here to finish the assignment.",
			requires = {"TN08"},
			briefing = "Recover an identification plate from industrial wreckage.",
			completion = "Good, buddy. Much easier when the part and the person who needs it are in the same room.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_control",
				label = "Latch's Find - Red-Trimmed Control Unit",
				recipient = "latch",
			},
			benefits = {},
		},
		{
			id = "TN11",
			completionCash = 0,
			name = "Proper Workshop",
			kind = "tracker",
			requires = {"TN09"},
			briefing = "Workshop tools and mechanical parts, buddy. Mute can have the loose circuit boards.",
			completion = (
				"You've kept the workshop supplied. Makes a pleasant change from taking something else apart "
				.. "for spares."
			),
			target = 9,
			benefits = {},
			discounts = {{npc = "'Technut'", service = "repair", fraction = 0.05}},
		},
		{
			id = "TN12",
			completionCash = 1450,
			name = "The Precision Crate",
			kind = "field",
			objective = "Recover Stickered Tool Case from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"TN10"},
			briefing = "Recover a tool case in Garbage.",
			completion = "Careful with the case, buddy. I want to open it myself.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_tools",
				label = "The Precision Crate - Stickered Tool Case",
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
			id = "TN13",
			completionCash = 1175,
			name = "A Better Fit",
			kind = "delivery",
			requires = {"TN11"},
			briefing = (
				"These are the supplies I'm missing, buddy. Bring them to the bench and I can get on with "
				.. "it."
			),
			completion = "Yes! That's the bit I needed.",
			requirements = {
				{
					pool = "town_textiles",
					quantity = 4,
				},
			},
			benefits = {},
		},
		{
			id = "TN14",
			completionCash = 1650,
			name = "Patterns in Metal",
			kind = "field",
			objective = "Recover Official File Folder from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"TN12"},
			briefing = "Retrieve an assembly drawing at a regional workshop.",
			completion = "Oh, let me see! Mind the oil on the bench.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_official",
				label = "Patterns in Metal - Official File Folder",
			},
			benefits = {},
		},
		{
			id = "TN15",
			completionCash = 0,
			name = "More Than a Patch",
			kind = "tracker",
			requires = {"TN13"},
			briefing = (
				"Workshop tools and mechanical parts, buddy. Mute can have the loose circuit boards. I'd "
				.. "rather see what is actually there than guess from somebody's description. You bring it "
				.. "back and I'll do the peering and muttering."
			),
			completion = (
				"You've kept the workshop supplied. Makes a pleasant change from taking something else "
				.. "apart for spares. Let me clear the bench. No, that pile is organised, even if the "
				.. "organisation hasn't become obvious to anyone else yet."
			),
			target = 14,
			benefits = {},
		},
		{
			id = "TN16",
			completionCash = 1850,
			name = "The Missing Technician",
			kind = "field",
			objective = "Recover Handwritten Audio Cassette from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"TN14"},
			briefing = "Recover a technician's recorder near an abandoned workshop.",
			completion = "You found it! Let's see what we've got.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_tape",
				label = "The Missing Technician - Handwritten Audio Cassette",
			},
			benefits = {},
		},
		{
			id = "TN17",
			completionCash = 1475,
			name = "Instrument Grade",
			kind = "delivery",
			requires = {"TN15"},
			briefing = (
				"These are the supplies I'm missing, buddy. Bring them to the bench and I can get on with "
				.. "it."
			),
			completion = "Put it on the clear end of the bench. There is one, I promise.",
			requirements = {
				{
					pool = "basic_tools",
					quantity = 2,
				},
			},
			benefits = {},
		},
		{
			id = "TN18",
			completionCash = 2050,
			name = "The Test Assembly",
			kind = "field",
			objective = "Recover Marked Research Case from the assigned search area in Waystation. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"TN16"},
			briefing = "Recover a test assembly case in Waystation territory.",
			completion = "Careful with the case, buddy. I want to open it myself.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_research",
				label = "The Test Assembly - Marked Research Case",
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
			id = "TN19",
			completionCash = 0,
			name = "Holding Together",
			kind = "tracker",
			requires = {"TN17"},
			briefing = "Workshop tools and mechanical parts, buddy. Mute can have the loose circuit boards.",
			completion = (
				"You've kept the workshop supplied. Makes a pleasant change from taking something else apart "
				.. "for spares."
			),
			target = 20,
			benefits = {},
		},
		{
			id = "TN20",
			completionCash = 2250,
			name = "The Damaged Register",
			kind = "field",
			objective = "Recover Corporate Records Folder from the assigned search area in Marsh. Deliver it to"
				.. " 'Carbon' in Waystation, then return here to finish the assignment.",
			requires = {"TN18"},
			briefing = "Recover equipment-service records from a remote facility.",
			completion = "Good, buddy. Much easier when the part and the person who needs it are in the same room.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_archive",
				label = "The Damaged Register - Corporate Records Folder",
				recipient = "carbon",
			},
			benefits = {},
		},
		{
			id = "TN21",
			completionCash = 1775,
			name = "A Workshop in Reserve",
			kind = "delivery",
			requires = {"TN19"},
			briefing = (
				"These are the supplies I'm missing, buddy. Bring them to the bench and I can get on with "
				.. "it."
			),
			completion = "Good condition, too. I can work with this.",
			requirements = {
				{
					pool = "workshop_supplies",
					quantity = 6,
				},
			},
			benefits = {},
		},
		{
			id = "TN22",
			completionCash = 2450,
			name = "The Machine's Origin",
			kind = "field",
			objective = "Recover Official File Folder from the assigned search area in Pripyat. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"TN20"},
			briefing = "Retrieve a manufacturing record at a Pripyat industrial site.",
			completion = "You found it! Let's see what we've got.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_official",
				label = "The Machine's Origin - Official File Folder",
			},
			benefits = {},
		},
		{
			id = "TN23",
			completionCash = 0,
			name = "Precision Work",
			kind = "tracker",
			requires = {"TN21", "TN22"},
			briefing = "Workshop tools and mechanical parts, buddy. Mute can have the loose circuit boards.",
			completion = (
				"You've kept the workshop supplied. Makes a pleasant change from taking something else apart "
				.. "for spares."
			),
			target = 27,
			benefits = {},
		},
		{
			id = "TN24",
			completionCash = 2650,
			name = "The Last Component",
			kind = "field",
			objective = "Recover Striped Equipment Case from the assigned search area in Pripyat. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"TN23"},
			briefing = "Recover the restoration machine's final case in Pripyat.",
			completion = "Careful with the case, buddy. I want to open it myself.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_equipment",
				label = "The Last Component - Striped Equipment Case",
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
			id = "TN25",
			completionCash = 2000,
			name = "Ready to Rebuild",
			kind = "delivery",
			requires = {"TN24"},
			briefing = (
				"These are the supplies I'm missing, buddy. Bring them to the bench and I can get on with "
				.. "it."
			),
			completion = "Yes! That's the bit I needed.",
			requirements = {
				{
					pool = "fasteners",
					quantity = 7,
				},
			},
			benefits = {},
			discounts = {{npc = "'Technut'", service = "repair", fraction = 0.1}},
		},
		{
			id = "TN26",
			completionCash = 2850,
			name = "A Test Under Load",
			kind = "field",
			objective = "Deploy the recorder in Marsh, leave it to record, then retrieve Numbered Data Module 0013."
				.. " Return it to this contact to finish the assignment.",
			requires = {"TN25"},
			briefing = "Deploy and retrieve a test recorder at the machinery survey site.",
			completion = "Oh, let me see! Mind the oil on the bench.",
			field = {
				kind = "sensor",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_module",
				label = "A Test Under Load - Numbered Data Module 0013",
			},
			benefits = {},
		},
		{
			id = "TN27",
			completionCash = 0,
			name = "It Runs Again",
			kind = "tracker",
			requires = {"TN26"},
			briefing = "Workshop tools and mechanical parts, buddy. Mute can have the loose circuit boards.",
			completion = (
				"You've kept the workshop supplied. Makes a pleasant change from taking something else apart "
				.. "for spares."
			),
			target = 35,
			benefits = {},
		},
		{
			id = "TN28",
			completionCash = 3000,
			name = "The Engineer's Signature",
			kind = "field",
			objective = "Recover Official File Folder from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"TN27"},
			briefing = (
				"Recover the machine's commissioning record and finish the restoration. I'd like the complete "
				.. "commissioning record. There may be something useful in a boring little note that somebody else "
				.. "would throw away."
			),
			completion = (
				"You found it! Let's see what we've got. A signature. Somebody looked at this work and put their "
				.. "name beside it. I like that. We spend so much time calling things scrap that we forget someone "
				.. "was pleased with them once."
			),
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_official",
				label = "The Engineer's Signature - Official File Folder",
			},
			benefits = {},
			recognition = "Technut's trusted contact",
		},
	},
})
