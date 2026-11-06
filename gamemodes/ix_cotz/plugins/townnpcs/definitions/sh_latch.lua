PLUGIN:Register("latch", {
	name = "'Latch'",
	template = "latchnpc",
	difficultyMultiplier = 2,
	enforceCatalogue = true,
	map = "rp_garbage_cotz",
	job = {
		kind = "valuableCourier",
		category = "Valuable delivery and courier work",
		description = "Valuable delivery and courier work",
	},
	legacyJob = {
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
	supplies = {},
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
		workPrompt = "About the delivery order.",
		offerPrompt = "Do you have a delivery order?",
		work = "Read the order before you carry anything. The named goods can go to someone here in Garbage who requests that category. Keep any surplus; the order only takes what is still needed. Come back to me once the delivery is complete. The harder requests mean finding goods supplied from farther north.",
		progressionPrompt = "What are you trying to put together?",
		progression = (
			"I want to sort useful stock and compare the machinery records with the surviving pieces. Work "
			.. "before claims. A good drawing doesn't mean the assembly matches it, and a rusty part isn't "
			.. "automatically finished. We'll take a manageable request first. Any delivery to another workshop is "
			.. "written on its order; come back after the handover."
		),
	},
	catalogue = {
		["attachment_ceramicplate_1"] = {step = "LA01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["attachment_fabric_1"] = {step = "LA22",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["attachment_steelplate_1"] = {step = "LA11",
			terms = {nil, 1, "SELLONLY", 1, 3, 1}},
		["mask_cloth"] = {step = "LA01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["mask_eo20"] = {step = "LA22",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["mask_gp5"] = {step = "LA17",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["mask_halfmask"] = {step = "LA06",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["mask_respirator"] = {step = "LA11",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
	},
	progression = {
		{
			id = "LA01",
			completionCash = 275,
			name = "A Place to Sort",
			kind = "delivery",
			requires = {},
			briefing = (
				"I need stock for the bench. Bring what is on the list; being nearly the right part does not make "
				.. "a repair hold. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Right. I can work with these. Leave them clear of the tools I am using.",
			requirements = {
				{
					pool = "town_delivery_workshop_garbage_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "LA02",
			stock = {item = "mask_cloth", bonus = 1},
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
				map = "rp_garbage_cotz",
				tier = 1,
				cargo = "town_quest_manifest",
				label = "Sorting-yard stock journal",
			},
			benefits = {},
		},
		{
			id = "LA03",
			stock = {item = "attachment_ceramicplate_1", bonus = 1},
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
			stock = {item = "mask_cloth", bonus = 2},
			completionCash = 650,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"LA03"},
			briefing = (
				"I need stock for the bench. Bring what is on the list; being nearly the right part does not make "
				.. "a repair hold. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Right. I can work with these. Leave them clear of the tools I am using.",
			requirements = {
				{
					pool = "town_delivery_workshop_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_garbage_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "LA05",
			stock = {item = "attachment_ceramicplate_1", bonus = 2},
			completionCash = 575,
			name = "Useful Steel",
			kind = "delivery",
			requires = {"LA04"},
			briefing = (
				"I need stock for the bench. Bring what is on the list; being nearly the right part does not make "
				.. "a repair hold. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Right. I can work with these. Leave them clear of the tools I am using.",
			requirements = {
				{
					pool = "town_delivery_workshop_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_garbage_2",
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
				map = "rp_garbage_cotz",
				tier = 1,
				cargo = "town_quest_control",
				label = "Machine identification file",
			},
			benefits = {},
		},
		{
			id = "LA07",
			stock = {item = "mask_halfmask", bonus = 1},
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
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"LA06"},
			briefing = (
				"I need stock for the bench. Bring what is on the list; being nearly the right part does not make "
				.. "a repair hold. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Right. I can work with these. Leave them clear of the tools I am using.",
			requirements = {
				{
					pool = "town_delivery_workshop_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_garbage_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "LA09",
			stock = {item = "mask_halfmask", bonus = 2},
			completionCash = 875,
			name = "Moving Parts",
			kind = "delivery",
			requires = {"LA07"},
			briefing = (
				"I need stock for the bench. Bring what is on the list; being nearly the right part does not make "
				.. "a repair hold. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Right. I can work with these. Leave them clear of the tools I am using.",
			requirements = {
				{
					pool = "town_delivery_workshop_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_garbage_2",
					quantity = 1,
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
				map = "rp_garbage_cotz",
				tier = 2,
				cargo = "town_quest_equipment",
				label = "Failed replacement component",
			},
			benefits = {},
		},
		{
			id = "LA11",
			stock = {item = "attachment_steelplate_1", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement barter consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Permanent offer for sharpening_stone; consume inputs each time, enforce equipment "
						.. "tiers and audit resale value."
					),
					id = "latch/LA11/future",
					inputs = {
						{
							item = "value_bolts",
							quantity = 1,
						},
						{
							item = "value_screws",
							quantity = 2,
						},
					},
					kind = "barter",
					name = "Standing exchange: sharpening_stone",
					outputs = {
						{
							item = "sharpening_stone",
							quantity = 1,
						},
					},
					provider = "latch",
					status = "unimplemented",
				},
			},
			completionCash = 0,
			name = "More Than Scrap",
			kind = "tracker",
			requires = {"LA09"},
			briefing = "More salvage deliveries. I'd like the yard supplied while I inspect the machinery records.",
			completion = "That's been steady work. I can make room for what you bring without expecting a surprise.",
			target = 9,
		},
		{
			id = "LA12",
			stock = {item = "mask_respirator", bonus = 1},
			plannedUnlocks = {
				-- TODO: Implement barter consumer; verify these proposed terms before enabling.
				{
					effect = "Permanent offer for fireaxe; consume inputs each time, enforce equipment tiers and audit resale value.",
					id = "latch/LA12/future",
					inputs = {
						{
							item = "value_bolts",
							quantity = 1,
						},
						{
							item = "value_screws",
							quantity = 3,
						},
					},
					kind = "barter",
					name = "Standing exchange: fireaxe",
					outputs = {
						{
							item = "fireaxe",
							quantity = 1,
						},
					},
					provider = "latch",
					status = "unimplemented",
				},
			},
			completionCash = 1450,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"LA10"},
			briefing = (
				"I need stock for the bench. Bring what is on the list; being nearly the right part does not make "
				.. "a repair hold. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Right. I can work with these. Leave them clear of the tools I am using.",
			requirements = {
				{
					pool = "town_delivery_workshop_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_workshop_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_garbage_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "LA13",
			stock = {item = "attachment_steelplate_1", bonus = 2},
			completionCash = 1175,
			name = "Heavy Work",
			kind = "delivery",
			requires = {"LA11"},
			briefing = (
				"I need stock for the bench. Bring what is on the list; being nearly the right part does not make "
				.. "a repair hold. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Right. I can work with these. Leave them clear of the tools I am using.",
			requirements = {
				{
					pool = "town_delivery_workshop_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_workshop_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_garbage_3",
					quantity = 1,
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
			stock = {item = "mask_respirator", bonus = 2},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement barter consumer; verify these proposed terms before enabling.
				{
					effect = "Permanent offer for lax410s; consume inputs each time, enforce equipment tiers and audit resale value.",
					id = "latch/LA15/future",
					inputs = {
						{
							item = "value_bolts",
							quantity = 1,
						},
						{
							item = "value_screws",
							quantity = 4,
						},
					},
					kind = "barter",
					name = "Standing exchange: lax410s",
					outputs = {
						{
							item = "lax410s",
							quantity = 1,
						},
					},
					provider = "latch",
					status = "unimplemented",
				},
			},
			completionCash = 0,
			name = "A Working Yard",
			kind = "tracker",
			requires = {"LA13"},
			briefing = "Keep filling the salvage requests. There's ordinary work left after the interesting finds.",
			completion = "You've kept at the sorting as well as the carrying. Good.",
			target = 14,
		},
		{
			id = "LA16",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement barter consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Permanent offer for stoegerddshort; consume inputs each time, enforce equipment "
						.. "tiers and audit resale value."
					),
					id = "latch/LA16/future",
					inputs = {
						{
							item = "value_bolts",
							quantity = 2,
						},
						{
							item = "value_screws",
							quantity = 5,
						},
					},
					kind = "barter",
					name = "Standing exchange: stoegerddshort",
					outputs = {
						{
							item = "stoegerddshort",
							quantity = 1,
						},
					},
					provider = "latch",
					status = "unimplemented",
				},
			},
			completionCash = 1850,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"LA14"},
			briefing = (
				"I need stock for the bench. Bring what is on the list; being nearly the right part does not make "
				.. "a repair hold. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Right. I can work with these. Leave them clear of the tools I am using.",
			requirements = {
				{
					pool = "town_delivery_workshop_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_workshop_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_garbage_3",
					quantity = 1,
				},
			},
		},
		{
			id = "LA17",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement barter consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Permanent offer for m3supershort; consume inputs each time, enforce equipment "
						.. "tiers and audit resale value."
					),
					id = "latch/LA17/future",
					inputs = {
						{
							item = "value_bolts",
							quantity = 2,
						},
						{
							item = "value_screws",
							quantity = 6,
						},
					},
					kind = "barter",
					name = "Standing exchange: m3supershort",
					outputs = {
						{
							item = "m3supershort",
							quantity = 1,
						},
					},
					provider = "latch",
					status = "unimplemented",
				},
			},
			completionCash = 1475,
			name = "Parts Worth Carrying",
			kind = "delivery",
			requires = {"LA15"},
			briefing = (
				"I need stock for the bench. Bring what is on the list; being nearly the right part does not make "
				.. "a repair hold. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Right. I can work with these. Leave them clear of the tools I am using.",
			requirements = {
				{
					pool = "town_delivery_workshop_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_workshop_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_garbage_3",
					quantity = 1,
				},
			},
		},
		{
			id = "LA18",
			stock = {item = "mask_gp5", bonus = 1},
			plannedUnlocks = {
				-- TODO: Implement barter consumer; verify these proposed terms before enabling.
				{
					effect = "Permanent offer for fubar; consume inputs each time, enforce equipment tiers and audit resale value.",
					id = "latch/LA18/future",
					inputs = {
						{
							item = "value_bolts",
							quantity = 2,
						},
						{
							item = "value_screws",
							quantity = 7,
						},
					},
					kind = "barter",
					name = "Standing exchange: fubar",
					outputs = {
						{
							item = "fubar",
							quantity = 1,
						},
					},
					provider = "latch",
					status = "unimplemented",
				},
			},
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
			stock = {item = "mask_gp5", bonus = 2},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement barter consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Permanent offer for sharpening_stone_fine; consume inputs each time, enforce "
						.. "equipment tiers and audit resale value."
					),
					id = "latch/LA19/future",
					inputs = {
						{
							item = "value_bolts",
							quantity = 3,
						},
						{
							item = "value_screws",
							quantity = 8,
						},
					},
					kind = "barter",
					name = "Standing exchange: sharpening_stone_fine",
					outputs = {
						{
							item = "sharpening_stone_fine",
							quantity = 1,
						},
					},
					provider = "latch",
					status = "unimplemented",
				},
			},
			completionCash = 0,
			name = "Nothing Wasted",
			kind = "tracker",
			requires = {"LA17", "LA18"},
			briefing = "Continue the workshop salvage orders. I want a reserve I can use, not a heap to argue over.",
			completion = "You've given the bench work some breathing room. I appreciate it.",
			target = 20,
		},
		{
			id = "LA20",
			completionCash = 2250,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"LA19"},
			briefing = (
				"I need stock for the bench. Bring what is on the list; being nearly the right part does not make "
				.. "a repair hold. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Right. I can work with these. Leave them clear of the tools I am using.",
			requirements = {
				{
					pool = "town_delivery_workshop_garbage_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_workshop_garbage_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_workshop_garbage_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_garbage_4",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "LA21",
			completionCash = 1775,
			name = "Ready for Assembly",
			kind = "delivery",
			requires = {"LA20"},
			briefing = (
				"I need stock for the bench. Bring what is on the list; being nearly the right part does not make "
				.. "a repair hold. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Right. I can work with these. Leave them clear of the tools I am using.",
			requirements = {
				{
					pool = "town_delivery_workshop_garbage_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_workshop_garbage_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_workshop_garbage_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_garbage_4",
					quantity = 1,
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
				map = "rp_garbage_cotz",
				tier = 2,
				cargo = "town_quest_official",
				label = "Machine commissioning papers",
			},
			benefits = {},
			recognition = "Latch's trusted contact",
		},
	},
})
