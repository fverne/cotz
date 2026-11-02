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
			name = "A Regulator for Gasket",
			kind = "field",
			objective = (
				"Recover the regulator for Gasket from the assigned search area in Marsh. Deliver it to 'Gasket' "
				.. "in Marsh, then come back to the issuing contact in Marsh."
			),
			requires = {"TN03"},
			briefing = (
				"Gasket needs the recovered regulator himself. He has strong feelings about me explaining a part "
				.. "while keeping it on my bench. Recover the regulator for Gasket from the assigned search area in "
				.. "Marsh. Deliver it to 'Gasket' in Marsh, then come back to me in Marsh."
			),
			completion = "He's got it? Good. Now he can discover whether my explanation was useful at his own pace.",
			field = {
				description = (
					"A finned grey control box with a red stripe and several round front connectors. Technut's note: "
					.. "\"Gasket needs the recovered regulator himself.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_control",
				label = "Regulator for Gasket",
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
				"Bring the listed workshop tools, buddy. I'm trying to get the bench ready before filling it with "
				.. "interesting problems."
			),
			completion = "Lovely. I'll put those away before I begin explaining what I can do with them.",
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
			briefing = "More salvage deliveries when you're ready. I do need the ordinary bits too.",
			completion = "You've kept the parts coming. That's saved me several searches through the same drawer.",
			target = 5,
			benefits = {},
		},
		{
			id = "TN08",
			completionCash = 1050,
			name = "An Engineer's Notes",
			kind = "field",
			objective = (
				"Recover the engineer's machinery notebook from the assigned search area in Garbage. Bring it back "
				.. "to the issuing contact in Marsh."
			),
			requires = {"TN06"},
			briefing = (
				"There are engineer's notes still out in Garbage. I want the sketches too, even the crossed-out "
				.. "ones. Recover the engineer's machinery notebook from the assigned search area in Garbage. Bring "
				.. "it back to me in Marsh."
			),
			completion = "Look at that binding. They meant to keep using it. I'll read it carefully.",
			field = {
				description = (
					"A thick brown journal held together by a narrow tie around its cover. Technut's note: \"There are "
					.. "engineer's notes still out in Garbage.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "Engineer's machinery notebook",
			},
			benefits = {},
		},
		{
			id = "TN09",
			completionCash = 875,
			name = "Steel and Seals",
			kind = "delivery",
			requires = {"TN07"},
			briefing = "There is another workshop order to fill. Keep the little useful pieces together.",
			completion = "Thank you, buddy. I'll find them a place that isn't the floor.",
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
			benefits = {},
		},
		{
			id = "TN11",
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
			name = "The Precision Crate",
			kind = "field",
			objective = (
				"Recover the precision tool case from the assigned search area in Garbage. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"TN10"},
			briefing = (
				"There's a precision tool case out in Garbage. Bring the case, not a selection of the interesting "
				.. "bits. Recover the precision tool case from the assigned search area in Garbage. Bring it back to "
				.. "me in Marsh."
			),
			completion = (
				"All together! Thank you. That's much easier than looking for one tiny part in the bottom of a "
				.. "pack."
			),
			field = {
				description = (
					"A handled tool case covered in bright stickers and contrasting printed decoration. Technut's "
					.. "note: \"There's a precision tool case out in Garbage.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_tools",
				label = "precision tool case",
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
				"Bring the requested materials here. I'd like to check their condition before I build my next idea "
				.. "around them."
			),
			completion = "Good. I can work with this without repairing it first.",
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
			name = "The Missing Technician",
			kind = "field",
			objective = (
				"Recover the technician's workshop recording from the assigned search area in Marsh. Bring it back "
				.. "to the issuing contact in Marsh."
			),
			requires = {"TN14"},
			briefing = (
				"Recover the technician's recorder. I'd like to hear the account without somebody choosing which "
				.. "faults matter for me. Recover the technician's workshop recording from the assigned search area "
				.. "in Marsh. Bring it back to me in Marsh."
			),
			completion = "Here, away from the oil. I'll listen before touching the assembly again.",
			field = {
				description = (
					"A pale audio cassette with a handwritten dedication above the spool windows. Technut's note: "
					.. "\"Recover the technician's recorder.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_tape",
				label = "Technician's workshop recording",
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
				"Bring the listed workshop tools, buddy. I'm trying to get the bench ready before filling it with "
				.. "interesting problems."
			),
			completion = "Lovely. I'll put those away before I begin explaining what I can do with them.",
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
			briefing = "There are more workshop deliveries. Check the order before bringing a fascinating alternative.",
			completion = "You've brought useful stock through over time. I appreciate the patience.",
			target = 20,
			benefits = {},
		},
		{
			id = "TN20",
			completionCash = 2250,
			name = "The Damaged Register",
			kind = "field",
			objective = (
				"Recover the service archive for Carbon from the assigned search area in Marsh. Deliver it to "
				.. "'Carbon' in Waystation, then come back to the issuing contact in Marsh."
			),
			requires = {"TN18"},
			briefing = (
				"Carbon needs the service register. I can read a repair entry; he can help place it among records "
				.. "I haven't seen. Recover the service archive for Carbon from the assigned search area in Marsh. "
				.. "Deliver it to 'Carbon' in Waystation, then come back to me in Marsh."
			),
			completion = "He has the register. I'll try to contain myself until he's finished reading.",
			field = {
				description = (
					"A blue records folder with contrasting corporate lettering along the cover. Technut's note: "
					.. "\"Carbon needs the service register.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_archive",
				label = "Service archive for Carbon",
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
				"I need the supplies on this request. Similar parts have a remarkable talent for fitting until the "
				.. "final adjustment."
			),
			completion = "That's the right lot. Much better than another ingenious workaround.",
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
			name = "The Last Component",
			kind = "field",
			objective = (
				"Recover the restoration component case from the assigned search area in Pripyat. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"TN23"},
			briefing = (
				"There's a component case still in Pripyat. I'd rather inspect the actual pieces than decide they "
				.. "must fit because I want them to. Recover the restoration component case from the assigned search "
				.. "area in Pripyat. Bring it back to me in Marsh."
			),
			completion = "That's it. No, don't open it over the floor. Give me a moment to clear the bench.",
			field = {
				description = (
					"A low hard case with long contrasting strips across its ribbed lid. Technut's note: \"There's a "
					.. "component case still in Pripyat.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_equipment",
				label = "Restoration component case",
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
			briefing = "There is another workshop order to fill. Keep the little useful pieces together.",
			completion = "Thank you, buddy. I'll find them a place that isn't the floor.",
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
			name = "The Engineer's Signature",
			kind = "field",
			objective = (
				"Recover the engineer commissioning record from the assigned search area in Marsh. Bring it back "
				.. "to the issuing contact in Marsh."
			),
			requires = {"TN27"},
			briefing = (
				"Bring the complete commissioning record. A boring little annotation can save a marvellous amount "
				.. "of mistaken work. Recover the engineer commissioning record from the assigned search area in "
				.. "Marsh. Bring it back to me in Marsh."
			),
			completion = (
				"You've brought back the pieces of an undertaking, not just the pieces that looked exciting. I "
				.. "know what that costs in patience. Stay a moment, buddy. I'd like to go through this with someone "
				.. "who helped get it here."
			),
			field = {
				description = (
					"A cardboard file folder with a small coloured crest on its cover. Technut's note: \"Bring the "
					.. "complete commissioning record.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_official",
				label = "Engineer commissioning record",
			},
			benefits = {},
			recognition = "Technut's trusted contact",
		},
	},
})
