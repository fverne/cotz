PLUGIN:Register("suture", {
	name = "'Suture'",
	template = "suturenpc",
	map = "rp_waystation",
	job = {
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
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Sewing stock (trade goods)",
				items = {"value_sewingkit", "value_tools_sewing"}},
			{label = "Reinforcement stock (trade goods)",
				items = {"value_tape_duct", "value_tape_heavy"}},
			{label = "Expedition provisions",
				items = {"food_raisins", "drink_bottlewater"}},
		},
		bonusItems = {
			"attachment_fabric_1",
			"attachment_fabric_2",
		},
	},
	dialogue = {
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
		["backpack_sling"] = {step = "SU01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_duffle"] = {step = "SU03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_sanitar"] = {step = "SU03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_tbag"] = {step = "SU05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_tourist"] = {step = "SU05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_takedown_1"] = {step = "SU07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_takedown_2"] = {step = "SU07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_mbss"] = {step = "SU09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_vkbo"] = {step = "SU09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_pilgrim"] = {step = "SU11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_scavbackpack"] = {step = "SU11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_1"] = {step = "SU13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_3"] = {step = "SU15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_2"] = {step = "SU17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_1_large"] = {step = "SU19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_3_large"] = {step = "SU21",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["backpack_2_large"] = {step = "SU23",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_trenchcoat_black"] = {step = "SU05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_trenchcoat_brown"] = {step = "SU05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_trenchcoat_green"] = {step = "SU05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_trenchcoat_tan"] = {step = "SU05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "SU01",
			completionCash = 275,
			name = "A Bench and a Needle",
			kind = "delivery",
			requires = {},
			briefing = (
				"I need the textiles on this list. Bring them here and let me see what condition they're in. "
				.. "There is a difference between material that's worn and material that has already given up; "
				.. "I'd like to decide which before cutting anything."
			),
			completion = (
				"Good. Put them on the bench. I'll sort them before I start. And thank you for bringing the "
				.. "material in a state where I can actually see what I have to work with."
			),
			requirements = {
				{
					pool = "town_textiles",
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
			completionCash = 650,
			name = "A Broken Strap",
			kind = "field",
			objective = (
				"Recover the freight worker's recovered kit from the assigned search area in Waystation. Bring it "
				.. "back to the issuing contact in Waystation."
			),
			requires = {"SU03"},
			briefing = (
				"I'd like the worker's equipment brought back as it was found. A failed fitting tells me more "
				.. "before somebody tries to tidy it. Recover the freight worker's recovered kit from the assigned "
				.. "search area in Waystation. Bring it back to me in Waystation."
			),
			completion = "Leave the straps where they are. I'll inspect how the load was arranged.",
			field = {
				description = (
					"A low hard case with long contrasting strips across its ribbed lid. Suture's note: \"I'd like the "
					.. "worker's equipment brought back as it was found.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_equipment",
				label = "Freight worker's recovered kit",
			},
			benefits = {},
		},
		{
			id = "SU05",
			completionCash = 575,
			name = "Cloth for the Weather",
			kind = "delivery",
			requires = {"SU04"},
			briefing = "Bring the listed textile supplies here. Keep them clear of anything wet or oily in your pack.",
			completion = "Thank you. I'll inspect the material before putting it with the clean stock.",
			requirements = {
				{
					pool = "town_textiles",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "SU06",
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
			id = "SU07",
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
			completionCash = 1050,
			name = "The Workshop Scrapbook",
			kind = "field",
			objective = (
				"Recover the material notes for Latch from the assigned search area in Garbage. Deliver it to "
				.. "'Latch' in Garbage, then come back to the issuing contact in Waystation."
			),
			requires = {"SU06"},
			briefing = (
				"Latch should have the material notes. He can check what survived at the industrial end of the "
				.. "account. Recover the material notes for Latch from the assigned search area in Garbage. Deliver "
				.. "it to 'Latch' in Garbage, then come back to me in Waystation."
			),
			completion = "He has them. Good. I would rather hear his judgement than agree with my own description twice.",
			field = {
				description = (
					"A thick blue diary with a label fixed to the front cover. Suture's note: \"Latch should have the "
					.. "material notes.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_diary",
				label = "Material notes for Latch",
				recipient = "latch",
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
				"I need the requested materials. Similar colour doesn't make two fabrics suitable for the same "
				.. "work."
			),
			completion = "That's the requested lot. I'll keep it flat until I've checked it.",
			requirements = {
				{
					pool = "town_textiles",
					quantity = 3,
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
			name = "The Quartermaster's Specification",
			kind = "field",
			objective = (
				"Recover the Quartermaster's equipment specification from the assigned search area in Waystation. "
				.. "Deliver it to 'Quartermaster' in Waystation, then come back to the issuing contact in Waystation."
			),
			requires = {"SU10"},
			briefing = (
				"Quartermaster needs the equipment specification. He should judge what was asked for from the page "
				.. "itself. Recover the Quartermaster's equipment specification from the assigned search area in "
				.. "Waystation. Deliver it to 'Quartermaster' in Waystation, then come back to me in Waystation."
			),
			completion = "Delivered. That should make the next discussion about requirements rather more precise.",
			field = {
				description = (
					"A cardboard file folder with a small coloured crest on its cover. Suture's note: \"Quartermaster "
					.. "needs the equipment specification.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_official",
				label = "Quartermaster's equipment specification",
				recipient = "quartermaster",
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
			id = "SU13",
			completionCash = 1175,
			name = "More Than Canvas",
			kind = "delivery",
			requires = {"SU11"},
			briefing = (
				"Bring the supplies listed here. Let me check the condition before putting them to use. "
				.. "Check the packing before you set out. I'd rather spend the afternoon working with what "
				.. "arrives than undoing damage from the journey."
			),
			completion = (
				"Let me check it for damage first. Thank you. I'll look at it in good light. You may sit "
				.. "down, provided you move that folded material first."
			),
			requirements = {
				{
					pool = "town_textiles",
					quantity = 4,
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
			completionCash = 1850,
			name = "The Long Expedition's Kit",
			kind = "field",
			objective = (
				"Recover the expedition kit record for Ledger from the assigned search area in Waystation. Deliver "
				.. "it to 'Ledger' in Waystation, then come back to the issuing contact in Waystation."
			),
			requires = {"SU14"},
			briefing = (
				"Ledger should examine the expedition equipment record. He can check what was dispatched against "
				.. "the outfitting account. Recover the expedition kit record for Ledger from the assigned search "
				.. "area in Waystation. Deliver it to 'Ledger' in Waystation, then come back to me in Waystation."
			),
			completion = "He has the file. I'll wait for his comparison before making a new list.",
			field = {
				description = (
					"A cardboard file folder with an emblem and printed wording on the front. Suture's note: \"Ledger "
					.. "should examine the expedition equipment record.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_personnel",
				label = "Expedition kit record for Ledger",
				recipient = "ledger",
			},
			benefits = {},
		},
		{
			id = "SU17",
			completionCash = 1475,
			name = "Weather and Fallout",
			kind = "delivery",
			requires = {"SU15"},
			briefing = "There is another material order to fill. Please leave the useful edges intact.",
			completion = "Good. That gives me something I can measure properly.",
			requirements = {
				{
					pool = "town_textiles",
					quantity = 5,
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
			id = "SU19",
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
			name = "The Missing Outfitter",
			kind = "field",
			objective = (
				"Recover the field fitter's personal file from the assigned search area in Pripyat. Bring it back "
				.. "to the issuing contact in Waystation."
			),
			requires = {"SU18"},
			briefing = (
				"The fitter's surviving papers should come home together. Work notes and personal records are "
				.. "easily separated when people search in a hurry. Recover the field fitter's personal file from the "
				.. "assigned search area in Pripyat. Bring it back to me in Waystation."
			),
			completion = "Thank you. I'll handle the personal pages separately once I've recorded what came back.",
			field = {
				description = (
					"A cardboard file folder with an emblem and printed wording on the front. Suture's note: \"The "
					.. "fitter's surviving papers should come home together.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_personnel",
				label = "Field fitter's personal file",
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
				"Bring the listed supplies through. I'd rather wait for the correct material than make a "
				.. "convincing mistake with a substitute."
			),
			completion = "All here. I'll sort it before beginning the fitting work.",
			requirements = {
				{
					pool = "town_textiles",
					quantity = 6,
				},
			},
			benefits = {},
		},
		{
			id = "SU22",
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
			name = "The Outfitter's Pattern",
			kind = "field",
			objective = (
				"Recover the final expedition pattern from the assigned search area in Waystation. Bring it back "
				.. "to the issuing contact in Waystation."
			),
			requires = {"SU23"},
			briefing = (
				"Bring the pattern papers back flat if you can. Small measurements become rather less useful under "
				.. "an impressive crease. Recover the final expedition pattern from the assigned search area in "
				.. "Waystation. Bring it back to me in Waystation."
			),
			completion = (
				"Leave them here. You've given the work your attention as well as your legs. I appreciate both. "
				.. "For once, you may sit down without me asking you to turn around first."
			),
			field = {
				description = (
					"A cardboard file folder with a small coloured crest on its cover. Suture's note: \"Bring the "
					.. "pattern papers back flat if you can.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_official",
				label = "Final expedition pattern",
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
