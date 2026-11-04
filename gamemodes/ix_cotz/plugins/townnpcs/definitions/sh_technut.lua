PLUGIN:Register("technut", {
	name = "'Technut'",
	template = "technpc",
	difficultyMultiplier = 3,
	enforceCatalogue = true,
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
	supplies = {},
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
		workPrompt = "About the workshop order I've taken.",
		offerPrompt = "Do you need salvage brought in?",
		work = (
			"Workshop salvage, tools, parts, the supplies on the request. Have a look at the actual list before "
			.. "bringing your most exciting find. I'd love to examine it, buddy, but I may still need the ordinary "
			.. "pieces afterwards. Keep what can be inspected together; enthusiasm doesn't make loose components "
			.. "easier to identify."
		),
		progressionPrompt = "What are you trying to restore?",
		progression = (
			"I'm collecting what survives of the machinery work: parts, records, the notes somebody thought "
			.. "worth making before they knew we'd want them. We'll begin with a supply request and see how we get "
			.. "along. Some originals go to other people for checking. Deliver them first, then come back so I "
			.. "know the work reached the right bench."
		),
	},
	catalogue = {
		["suit_anorak"] = {step = "TN01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["suit_mailjacket"] = {step = "TN04",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["suit_nbc"] = {step = "TN28",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["suit_sunrise"] = {step = "TN21",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["suit_trenchcoat_black"] = {step = "TN08",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["suit_trenchcoat_brown"] = {step = "TN11",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["suit_trenchcoat_green"] = {step = "TN15",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["suit_trenchcoat_tan"] = {step = "TN18",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["suit_wind"] = {step = "TN25",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
	},
	progression = {
		{
			id = "TN01",
			completionCash = 275,
			name = "A Bench to Work On",
			kind = "delivery",
			requires = {},
			briefing = (
				"I need supplies for the workshop. I wrote down what I actually need, before the interesting "
				.. "possibilities got in the way. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "TN02",
			stock = {item = "suit_anorak", bonus = 1},
			completionCash = 450,
			name = "The Missing Toolbox",
			kind = "field",
			objective = (
				"Recover the workshop toolbox from the assigned search area in Marsh. Bring it back to the issuing "
				.. "contact in Marsh."
			),
			requires = {"TN01"},
			briefing = (
				"There's a workshop case to recover. I'm trying not to decide what I'll do with the tools before "
				.. "I've seen them, but it's difficult. Recover the workshop toolbox from the assigned search area in "
				.. "Marsh. Bring it back to me in Marsh."
			),
			completion = "There you are! Put it here. I'll try to inspect before getting distracted.",
			field = {
				description = (
					"A handled tool case covered in bright stickers and contrasting printed decoration. Technut's "
					.. "note: \"There's a workshop case to recover.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_tools",
				label = "workshop toolbox",
			},
			benefits = {},
		},
		{
			id = "TN03",
			stock = {item = "suit_anorak", bonus = 2},
			completionCash = 0,
			name = "Keeping Busy",
			kind = "tracker",
			requires = {"TN02"},
			briefing = "Continue the workshop salvage deliveries. Check the requested tools and parts.",
			completion = "A good start! The bench is getting more useful already.",
			target = 2,
			benefits = {},
		},
		{
			id = "TN04",
			completionCash = 650,
			name = "A small delivery",
			kind = "delivery",
			retiredCommission = true,
			objective = "Bring all 1 listed item type to this contact. The request shows each selected item and required units.",
			requires = {"TN03"},
			briefing = (
				"I need supplies for the workshop. I wrote down what I actually need, before the interesting "
				.. "possibilities got in the way. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "TN05",
			stock = {item = "suit_mailjacket", bonus = 1},
			completionCash = 575,
			name = "Something Accurate",
			kind = "delivery",
			requires = {"TN04"},
			briefing = (
				"I need supplies for the workshop. I wrote down what I actually need, before the interesting "
				.. "possibilities got in the way. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "TN06",
			stock = {item = "suit_mailjacket", bonus = 2},
			completionCash = 850,
			name = "The Misaligned Jig",
			kind = "field",
			objective = (
				"Recover the workshop calibration notes from the assigned search area in Marsh. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"TN04"},
			briefing = (
				"I'd like the calibration record. A little misalignment becomes an expensive amount of enthusiasm "
				.. "once you build around it. Recover the workshop calibration notes from the assigned search area in "
				.. "Marsh. Bring it back to me in Marsh."
			),
			completion = "Lovely. I'll check how they set it up before changing the jig.",
			field = {
				description = (
					"A cardboard file folder with a small coloured crest on its cover. Technut's note: \"I'd like the "
					.. "calibration record.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_official",
				label = "Workshop calibration notes",
			},
			benefits = {},
		},
		{
			id = "TN07",
			stock = {item = "suit_anorak", bonus = 3},
			completionCash = 0,
			name = "Reliable Parts",
			kind = "tracker",
			requires = {"TN05"},
			briefing = "More salvage deliveries when you're ready. I do need the ordinary bits too.",
			completion = "You've kept the parts coming. That's saved me several searches through the same drawer.",
			target = 5,
			benefits = {},
		},
		{
			id = "TN08",
			completionCash = 1050,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"TN06"},
			briefing = (
				"I need supplies for the workshop. I wrote down what I actually need, before the interesting "
				.. "possibilities got in the way. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "TN09",
			stock = {item = "suit_trenchcoat_black", bonus = 1},
			completionCash = 875,
			name = "Steel and Seals",
			kind = "delivery",
			requires = {"TN07"},
			briefing = (
				"I need supplies for the workshop. I wrote down what I actually need, before the interesting "
				.. "possibilities got in the way. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "TN10",
			stock = {item = "suit_trenchcoat_black", bonus = 2},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent workshop procedure guidance for Latch's Find; author specific, "
						.. "actionable checks before activation."
					),
					id = "technut/TN10/future",
					kind = "information",
					name = "Latch's Find: workshop procedure",
					provider = "technut",
					status = "unimplemented",
				},
			},
			completionCash = 1250,
			name = "Latch's Find",
			kind = "field",
			objective = (
				"Recover the machine identity record for Latch from the assigned search area in Marsh. Deliver it "
				.. "to 'Latch' in Garbage, then come back to the issuing contact in Marsh."
			),
			requires = {"TN08"},
			briefing = (
				"Latch should have the identification record. He'll compare it with what he actually found, which "
				.. "saves us building a theory around the wrong machine. Recover the machine identity record for "
				.. "Latch from the assigned search area in Marsh. Deliver it to 'Latch' in Garbage, then come back to "
				.. "me in Marsh."
			),
			completion = "Delivered. Excellent. I'll wait until he's looked before suggesting improvements.",
			field = {
				description = (
					"A finned grey control box with a red stripe and several round front connectors. Technut's note: "
					.. "\"Latch should have the identification record.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_control",
				label = "Machine identity record for Latch",
				recipient = "latch",
			},
		},
		{
			id = "TN11",
			stock = {item = "suit_trenchcoat_brown", bonus = 1},
			completionCash = 0,
			name = "Proper Workshop",
			kind = "tracker",
			requires = {"TN09"},
			briefing = "Keep filling the industrial salvage orders while I read the machinery notes.",
			completion = "A proper run of workshop work. I'm trying not to spend it all on ideas at once.",
			target = 9,
			benefits = {},
			discounts = {{npc = "'Technut'", service = "repair", fraction = 0.05}},
		},
		{
			id = "TN12",
			completionCash = 1450,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"TN10"},
			briefing = (
				"I need supplies for the workshop. I wrote down what I actually need, before the interesting "
				.. "possibilities got in the way. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "TN13",
			completionCash = 1175,
			name = "A Better Fit",
			kind = "delivery",
			requires = {"TN11"},
			briefing = (
				"I need supplies for the workshop. I wrote down what I actually need, before the interesting "
				.. "possibilities got in the way. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "TN14",
			stock = {item = "suit_trenchcoat_brown", bonus = 2},
			completionCash = 1650,
			name = "Patterns in Metal",
			kind = "field",
			objective = (
				"Recover the assembly specification file from the assigned search area in Marsh. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"TN12"},
			briefing = (
				"I'd like the assembly drawing. There may be a perfectly good reason for the bit I've spent the "
				.. "morning complaining about. Recover the assembly specification file from the assigned search area "
				.. "in Marsh. Bring it back to me in Marsh."
			),
			completion = (
				"Let me turn it this way. I want to start with the drawing before my own sketch becomes too "
				.. "convincing."
			),
			field = {
				description = (
					"A cardboard file folder with a small coloured crest on its cover. Technut's note: \"I'd like the "
					.. "assembly drawing.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_official",
				label = "Assembly specification file",
			},
			benefits = {},
		},
		{
			id = "TN15",
			stock = {item = "suit_trenchcoat_green", bonus = 1},
			completionCash = 0,
			name = "More Than a Patch",
			kind = "tracker",
			requires = {"TN13"},
			briefing = "Continue the salvage requests, buddy. Useful condition matters after the exciting find.",
			completion = "You've been steady about this. The work has room to move now.",
			target = 14,
			benefits = {},
		},
		{
			id = "TN16",
			completionCash = 1850,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"TN14"},
			briefing = (
				"I need supplies for the workshop. I wrote down what I actually need, before the interesting "
				.. "possibilities got in the way. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_workshop_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "TN17",
			stock = {item = "suit_trenchcoat_green", bonus = 2},
			completionCash = 1475,
			name = "Instrument Grade",
			kind = "delivery",
			requires = {"TN15"},
			briefing = (
				"I need supplies for the workshop. I wrote down what I actually need, before the interesting "
				.. "possibilities got in the way. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_workshop_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "TN18",
			completionCash = 2050,
			name = "The Test Assembly",
			kind = "field",
			objective = (
				"Recover the test assembly from the assigned search area in Waystation. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"TN16"},
			briefing = (
				"The test assembly case is still out in Waystation territory. I'm interested in how it was put "
				.. "together, so leave everything inside as it is. Recover the test assembly from the assigned search "
				.. "area in Waystation. Bring it back to me in Marsh."
			),
			completion = "Good, buddy. I'll make room to lay it out properly.",
			field = {
				description = (
					"A dark reinforced case covered in pale symbols and contrasting trim. Technut's note: \"The test "
					.. "assembly case is still out in Waystation territory.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_research",
				label = "test assembly",
			},
			benefits = {},
		},
		{
			id = "TN19",
			stock = {item = "suit_trenchcoat_tan", bonus = 1},
			completionCash = 0,
			name = "Holding Together",
			kind = "tracker",
			requires = {"TN17"},
			briefing = "There are more workshop deliveries. Check the order before bringing a fascinating alternative.",
			completion = "You've brought useful stock through over time. I appreciate the patience.",
			target = 20,
			benefits = {},
		},
		{
			id = "TN20",
			stock = {item = "suit_trenchcoat_tan", bonus = 2},
			completionCash = 2250,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"TN18"},
			briefing = (
				"I need supplies for the workshop. I wrote down what I actually need, before the interesting "
				.. "possibilities got in the way. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_workshop_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_marsh_3",
					quantity = 1,
				},
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
				"I need supplies for the workshop. I wrote down what I actually need, before the interesting "
				.. "possibilities got in the way. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_workshop_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "TN22",
			stock = {item = "suit_sunrise", bonus = 1},
			completionCash = 2450,
			name = "The Machine's Origin",
			kind = "field",
			objective = (
				"Recover the manufacturing specification record from the assigned search area in Pripyat. Bring it "
				.. "back to the issuing contact in Marsh."
			),
			requires = {"TN20"},
			briefing = (
				"I'd like the manufacturing papers from Pripyat. They may answer something more useful than which "
				.. "factory name to argue about. Recover the manufacturing specification record from the assigned "
				.. "search area in Pripyat. Bring it back to me in Marsh."
			),
			completion = "Leave them on the dry end. I'll compare the specification with the assembly notes.",
			field = {
				description = (
					"A cardboard file folder with a small coloured crest on its cover. Technut's note: \"I'd like the "
					.. "manufacturing papers from Pripyat.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_official",
				label = "Manufacturing specification record",
			},
			benefits = {},
		},
		{
			id = "TN23",
			stock = {item = "suit_sunrise", bonus = 2},
			completionCash = 0,
			name = "Precision Work",
			kind = "tracker",
			requires = {"TN21", "TN22"},
			briefing = "Keep the requested salvage coming when you're prepared.",
			completion = (
				"A lot of dependable work there. I'll try to express my gratitude without immediately giving you "
				.. "another list."
			),
			target = 27,
			benefits = {},
		},
		{
			id = "TN24",
			completionCash = 2650,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"TN23"},
			briefing = (
				"I need supplies for the workshop. I wrote down what I actually need, before the interesting "
				.. "possibilities got in the way. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_workshop_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_workshop_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_marsh_4",
					quantity = 1,
				},
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
				"I need supplies for the workshop. I wrote down what I actually need, before the interesting "
				.. "possibilities got in the way. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_workshop_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_workshop_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_marsh_4",
					quantity = 1,
				},
			},
			benefits = {},
			discounts = {{npc = "'Technut'", service = "repair", fraction = 0.1}},
		},
		{
			id = "TN26",
			stock = {item = "suit_wind", bonus = 1},
			completionCash = 2850,
			name = "A Test Under Load",
			kind = "field",
			objective = (
				"Deploy the recorder at the assigned site in Marsh, let it finish recording, then retrieve the "
				.. "machinery test recorder. Bring it back to the issuing contact in Marsh."
			),
			requires = {"TN25"},
			briefing = (
				"We need a test recording from the machinery survey. I promise to examine the inconvenient "
				.. "readings too. Deploy the recorder at the assigned site in Marsh, let it finish recording, then "
				.. "retrieve the machinery test recorder. Bring it back to me in Marsh."
			),
			completion = (
				"All right! Now I can see whether the record agrees with the encouraging noises I keep "
				.. "remembering."
			),
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. Technut's note: "
					.. "\"We need a test recording from the machinery survey.\""
				),
				kind = "sensor",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_module",
				label = "Machinery test recorder",
			},
			benefits = {},
		},
		{
			id = "TN27",
			stock = {item = "suit_wind", bonus = 2},
			completionCash = 0,
			name = "It Runs Again",
			kind = "tracker",
			requires = {"TN26"},
			briefing = "More completed workshop orders while I compare the test records.",
			completion = "You've kept helping after the project stopped being new. That counts for a great deal, buddy.",
			target = 35,
			benefits = {},
		},
		{
			id = "TN28",
			completionCash = 3000,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"TN27"},
			briefing = (
				"I need supplies for the workshop. I wrote down what I actually need, before the interesting "
				.. "possibilities got in the way. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_workshop_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_workshop_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_marsh_4",
					quantity = 1,
				},
			},
			benefits = {},
			recognition = "Technut's trusted contact",
		},
	},
})
