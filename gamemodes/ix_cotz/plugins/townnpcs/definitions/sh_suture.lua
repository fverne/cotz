PLUGIN:Register("suture", {
	name = "'Suture'",
	template = "suturenpc",
	difficultyMultiplier = 5,
	enforceCatalogue = true,
	map = "rp_waystation",
	courierPools = {
		"valuables_textile_supplies",
		"valuables_protective_textiles",
		"valuables_equipment_pouches",
		"valuables_cutting_tools",
	},
	job = {
		kind = "none",
		category = "No ordinary repeatable work",
		description = "No ordinary repeatable work",
	},
	legacyJob = {
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		category = "Textile supply deliveries",
		description = "Textile supply deliveries",
		pools = {"town_textiles"},
		deliveryTiers = {
			easy = {
				pools = {
					"valuables_textile_supplies",
					"valuables_equipment_pouches",
				},
				quantity = 1,
			},
			medium = {
				pools = {
					"valuables_protective_textiles",
				},
				quantity = 1,
			},
			hard = {
				pools = {
					"valuables_armour_panels",
				},
				quantity = 2,
			},
		},
		quantities = {2, 4, 7},
	},
	supplies = {},
	rewards = {
		packages = {
			{label = "Field dressings",
				items = {"medic_bandage_1", "medic_bandage_2"}},
			{label = "Pain relief",
				items = {"drug_painkillers"}},
			{label = "Expedition provisions",
				items = {"food_raisins", "drink_bottlewater"}},
		},
	},
	dialogue = {
		jobBriefing = "There's something I can use your help with. {details}",
		jobReminder = "I haven't got everything I need yet. {details}",
		jobFinished = "Thank you. Put it here and let me settle your payment.",
		delivery = "Set it down carefully. I want to see what condition it arrived in.",
		completedGreeting = (
			"Come in. Put your pack down carefully; I'd like to hear how the equipment has been treating "
			.. "you."
		),
		workPrompt = "About the material order.",
		offerPrompt = "Do you need textiles brought in?",
		work = (
			"Textiles, webbing, protective materials, according to the request. Keep them clear of sharp "
			.. "salvage and leaking containers. I'd prefer to judge the material before your packing gives it a "
			.. "second career as rags. Choose an order, check it, and bring the supplies here for inspection."
		),
		progressionPrompt = "What are you working on for the expedition gear?",
		progression = (
			"I want the material stock in order and the old fitting records brought together. A pattern has to "
			.. "meet a person eventually; I'd like to know what was changed between the drawing and the return. "
			.. "We'll begin with a manageable request. Deliveries for another contact need finishing there before "
			.. "you come back to me."
		),
	},
	catalogue = {
		["attachment_ceramicplate_2"] = {step = "SU05",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["attachment_ceramicplate_3"] = {step = "SU20",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["attachment_fabric_2"] = {step = "SU09",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["attachment_kevlar_1"] = {step = "SU13",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["attachment_kevlar_2"] = {step = "SU24",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["attachment_steelplate_2"] = {step = "SU01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["attachment_steelplate_3"] = {step = "SU16",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["suit_berill"] = {step = "SU13",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["suit_io7a"] = {step = "SU01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["suit_ps5m"] = {step = "SU07",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["suit_skat10"] = {step = "SU18",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["suit_skat9"] = {step = "SU24",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
	},
	progression = {
		{
			id = "SU01",
			completionCash = 275,
			name = "A Bench and a Needle",
			kind = "delivery",
			requires = {},
			briefing = (
				"I need material for the work here. Check the list before you bring a bundle; I have to see what "
				.. "I am working with before promising a fit. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "SU02",
			completionCash = 450,
			name = "The Missing Pattern",
			kind = "field",
			objective = (
				"Recover the workshop pattern case from the assigned search area in Waystation. Bring it back to "
				.. "the issuing contact in Waystation."
			),
			requires = {"SU01"},
			briefing = (
				"There's a pattern case left at the workshop site. A fold in the wrong place can make a perfectly "
				.. "good drawing difficult to use. Recover the workshop pattern case from the assigned search area in "
				.. "Waystation. Bring it back to me in Waystation."
			),
			completion = "Put it flat. I'll see which measurements are actually recorded.",
			field = {
				description = (
					"A cardboard file folder with a small coloured crest on its cover. Suture's note: \"There's a "
					.. "pattern case left at the workshop site.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_official",
				label = "Workshop pattern case",
			},
			benefits = {},
		},
		{
			id = "SU03",
			stock = {item = "attachment_steelplate_2", bonus = 1},
			completionCash = 0,
			name = "Seams That Hold",
			kind = "tracker",
			requires = {"SU02"},
			briefing = (
				"Continue the textile deliveries. I need the stock work kept going alongside the interesting "
				.. "cases."
			),
			completion = "A useful start. You have been careful with the material.",
			target = 2,
			benefits = {},
		},
		{
			id = "SU04",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement cosmetic consumer; verify these proposed terms before enabling.
				{
					baseSuit = "suit_anorak",
					effect = "Apply outfitter colours to suit_anorak; appearance only, with no gameplay variant changes.",
					finish = "suture-su04",
					id = "suture/SU04/future",
					kind = "cosmetic",
					name = "Restocking: outfitter colours",
					provider = "suture",
					status = "unimplemented",
				},
			},
			completionCash = 650,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"SU03"},
			briefing = (
				"I need material for the work here. Check the list before you bring a bundle; I have to see what "
				.. "I am working with before promising a fit. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 1,
				},
			},
		},
		{
			id = "SU05",
			completionCash = 575,
			name = "Cloth for the Weather",
			kind = "delivery",
			requires = {"SU04"},
			briefing = (
				"I need material for the work here. Check the list before you bring a bundle; I have to see what "
				.. "I am working with before promising a fit. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "SU06",
			stock = {item = "attachment_ceramicplate_2", bonus = 1},
			completionCash = 850,
			name = "The Forgotten Measurements",
			kind = "field",
			objective = (
				"Recover the workshop fitting record from the assigned search area in Waystation. Bring it back to "
				.. "the issuing contact in Waystation."
			),
			requires = {"SU04"},
			briefing = (
				"The fitting notes are missing. People remember that something was comfortable and forget what was "
				.. "changed to make it so. Recover the workshop fitting record from the assigned search area in "
				.. "Waystation. Bring it back to me in Waystation."
			),
			completion = "Thank you. I'll read the alterations before copying the final measurements.",
			field = {
				description = (
					"A thick brown journal held together by a narrow tie around its cover. Suture's note: \"The "
					.. "fitting notes are missing.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "Workshop fitting record",
			},
			benefits = {},
		},
		{
			id = "SU07",
			stock = {item = "suit_io7a", bonus = 1},
			completionCash = 0,
			name = "A Proper Fit",
			kind = "tracker",
			requires = {"SU05"},
			briefing = "More completed textile orders when you're ready. Check the requested goods.",
			completion = "Another reliable run. I can prepare with those returns in mind.",
			target = 5,
			benefits = {},
		},
		{
			id = "SU08",
			plannedUnlocks = {
				-- TODO: Implement barter consumer; verify these proposed terms before enabling.
				{
					id = "suture/SU08/future",
					provider = "suture",
					status = "unimplemented",
					kind = "barter",
					name = "backpack_sling exchange",
					effect = "Permanent multi-input offer; consume inputs each time, enforce equipment tiers and audit resale value.",
					inputs = {
						{
							item = "value_tape_duct",
							quantity = 3,
						},
						{
							item = "value_bolts",
							quantity = 2,
						},
					},
					outputs = {
						{
							item = "backpack_sling",
							quantity = 1,
						},
					},
				},
			},
			completionCash = 1050,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"SU06"},
			briefing = (
				"I need material for the work here. Check the list before you bring a bundle; I have to see what "
				.. "I am working with before promising a fit. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "SU09",
			completionCash = 875,
			name = "Load Before Luxury",
			kind = "delivery",
			requires = {"SU07"},
			briefing = (
				"I need material for the work here. Check the list before you bring a bundle; I have to see what "
				.. "I am working with before promising a fit. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "SU10",
			completionCash = 1250,
			name = "The Loaded Pack",
			kind = "field",
			objective = (
				"Recover the loaded-pack trial recording from the assigned search area in Waystation. Bring it "
				.. "back to the issuing contact in Waystation."
			),
			requires = {"SU08"},
			briefing = (
				"I'd like the load-test recording recovered. Looking comfortable at the beginning of a walk isn't "
				.. "the entire test. Recover the loaded-pack trial recording from the assigned search area in "
				.. "Waystation. Bring it back to me in Waystation."
			),
			completion = "Here. I'll go through the account without skipping the return journey.",
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. Suture's note: "
					.. "\"I'd like the load-test recording recovered.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_module",
				label = "Loaded-pack trial recording",
			},
			benefits = {},
		},
		{
			id = "SU11",
			stock = {item = "attachment_fabric_2", bonus = 1},
			completionCash = 0,
			name = "Built to Last",
			kind = "tracker",
			requires = {"SU09"},
			briefing = "Keep bringing the requested textiles. The ordinary stock still needs attention.",
			completion = "You've stayed consistent. That makes the work at this end easier.",
			target = 9,
			benefits = {},
		},
		{
			id = "SU12",
			completionCash = 1450,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"SU10"},
			briefing = (
				"I need material for the work here. Check the list before you bring a bundle; I have to see what "
				.. "I am working with before promising a fit. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "SU13",
			completionCash = 1175,
			name = "More Than Canvas",
			kind = "delivery",
			requires = {"SU11"},
			briefing = (
				"I need material for the work here. Check the list before you bring a bundle; I have to see what "
				.. "I am working with before promising a fit. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "SU14",
			completionCash = 1650,
			name = "The Failed Seam",
			kind = "field",
			objective = (
				"Recover the failed trial equipment case from the assigned search area in Waystation. Bring it "
				.. "back to the issuing contact in Waystation."
			),
			requires = {"SU12"},
			briefing = (
				"Bring the trial case back unchanged. If something failed, I want the arrangement that failed, not "
				.. "somebody's improved version. Recover the failed trial equipment case from the assigned search "
				.. "area in Waystation. Bring it back to me in Waystation."
			),
			completion = "Keep it closed a moment. I'll clear a place where nothing loose gets lost.",
			field = {
				description = (
					"A heavily worn hard case with faded strips running across its lid. Suture's note: \"Bring the "
					.. "trial case back unchanged.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_worncase",
				label = "Failed trial equipment case",
			},
			benefits = {},
		},
		{
			id = "SU15",
			stock = {item = "attachment_kevlar_1", bonus = 1},
			completionCash = 0,
			name = "Work Under Weight",
			kind = "tracker",
			requires = {"SU13"},
			briefing = "Continue the supply orders while I inspect the recovered fitting records.",
			completion = "A substantial amount of material brought through. Thank you.",
			target = 14,
			benefits = {},
		},
		{
			id = "SU16",
			plannedUnlocks = {
				-- TODO: Implement barter consumer; verify these proposed terms before enabling.
				{
					id = "suture/SU16/future",
					provider = "suture",
					status = "unimplemented",
					kind = "barter",
					name = "backpack_vkbo exchange",
					effect = "Permanent multi-input offer; consume inputs each time, enforce equipment tiers and audit resale value.",
					inputs = {
						{
							item = "value_tape_duct",
							quantity = 3,
						},
						{
							item = "value_bolts",
							quantity = 2,
						},
					},
					outputs = {
						{
							item = "backpack_vkbo",
							quantity = 1,
						},
					},
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
			requires = {"SU14"},
			briefing = (
				"I need material for the work here. Check the list before you bring a bundle; I have to see what "
				.. "I am working with before promising a fit. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "SU17",
			completionCash = 1475,
			name = "Weather and Fallout",
			kind = "delivery",
			requires = {"SU15"},
			briefing = (
				"I need material for the work here. Check the list before you bring a bundle; I have to see what "
				.. "I am working with before promising a fit. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "SU18",
			completionCash = 2050,
			name = "The Pripyat Trial",
			kind = "field",
			objective = (
				"Recover the Pripyat outfitting trial tape from the assigned search area in Pripyat. Bring it back "
				.. "to the issuing contact in Waystation."
			),
			requires = {"SU16"},
			briefing = (
				"There's an outfitting trial recording in Pripyat. I'd like to hear the account before selecting "
				.. "the convenient parts for a pattern. Recover the Pripyat outfitting trial tape from the assigned "
				.. "search area in Pripyat. Bring it back to me in Waystation."
			),
			completion = "Leave it with the trial notes. I'll listen all the way through.",
			field = {
				description = (
					"A flat dark electronic module marked with a number and three pale bars. Suture's note: \"There's "
					.. "an outfitting trial recording in Pripyat.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module2",
				label = "Pripyat outfitting trial tape",
			},
			benefits = {},
		},
		{
			id = "SU19",
			stock = {item = "attachment_steelplate_3", bonus = 1},
			completionCash = 0,
			name = "No Loose Ends",
			kind = "tracker",
			requires = {"SU17"},
			briefing = "There are further textile orders. Pack them so they arrive usable.",
			completion = "You've treated the stock with care. I've had less to discard at this end.",
			target = 20,
			benefits = {},
		},
		{
			id = "SU20",
			completionCash = 2250,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"SU18"},
			briefing = (
				"I need material for the work here. Check the list before you bring a bundle; I have to see what "
				.. "I am working with before promising a fit. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "SU21",
			completionCash = 1775,
			name = "Final Fittings",
			kind = "delivery",
			requires = {"SU19", "SU20"},
			briefing = (
				"I need material for the work here. Check the list before you bring a bundle; I have to see what "
				.. "I am working with before promising a fit. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_waystation_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_4",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "SU22",
			plannedUnlocks = {
				-- TODO: Implement barter consumer; verify these proposed terms before enabling.
				{
					id = "suture/SU22/future",
					provider = "suture",
					status = "unimplemented",
					kind = "barter",
					name = "backpack_1_large exchange",
					effect = "Permanent multi-input offer; consume inputs each time, enforce equipment tiers and audit resale value.",
					inputs = {
						{
							item = "value_tape_duct",
							quantity = 3,
						},
						{
							item = "value_bolts",
							quantity = 2,
						},
					},
					outputs = {
						{
							item = "backpack_1_large",
							quantity = 1,
						},
					},
				},
			},
			completionCash = 2450,
			name = "The Return Journey Test",
			kind = "field",
			objective = (
				"Deploy the recorder at the assigned site in Waystation, let it finish recording, then retrieve "
				.. "the return-journey equipment recorder. Bring it back to the issuing contact in Waystation."
			),
			requires = {"SU21"},
			briefing = (
				"I want a recording from the return-journey test. People pack very differently once they're tired. "
				.. "Deploy the recorder at the assigned site in Waystation, let it finish recording, then retrieve "
				.. "the return-journey equipment recorder. Bring it back to me in Waystation."
			),
			completion = "Good. We can examine that part of the trip without relying on a cheerful departure account.",
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. Suture's note: "
					.. "\"I want a recording from the return-journey test.\""
				),
				kind = "sensor",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_module",
				label = "Return-journey equipment recorder",
			},
			benefits = {},
		},
		{
			id = "SU23",
			stock = {item = "attachment_ceramicplate_3", bonus = 1},
			completionCash = 0,
			name = "Fit for the Journey",
			kind = "tracker",
			requires = {"SU22"},
			briefing = "Keep the textile deliveries going when you're prepared.",
			completion = "You've given the work sustained attention. I appreciate a person who notices how things arrive.",
			target = 27,
			benefits = {},
		},
		{
			id = "SU24",
			capacity = {kind = "rows", amount = 1},
			completionCash = 2650,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"SU23"},
			briefing = (
				"I need material for the work here. Check the list before you bring a bundle; I have to see what "
				.. "I am working with before promising a fit. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_waystation_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_4",
					quantity = 1,
				},
			},
			benefits = {},
			recognition = "Suture's trusted contact",
		},
	},
	unlocks = {
		{
			step = "SU03",
			item = "backpack_sling",
			previous = "",
		},
		{
			step = "SU09",
			item = "backpack_tourist",
			previous = "backpack_sling",
		},
		{
			step = "SU15",
			item = "backpack_vkbo",
			previous = "backpack_tourist",
		},
		{
			step = "SU19",
			item = "backpack_1_large",
			previous = "backpack_vkbo",
		},
	},
})
