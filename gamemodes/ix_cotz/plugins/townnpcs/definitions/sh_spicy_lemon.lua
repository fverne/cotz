PLUGIN:Register("spicy-lemon", {
	name = "'Spicy Lemon'",
	template = "cooknpc",
	map = "rp_marsh_cs",
	job = {
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		category = "Meal deliveries",
		description = "Meal deliveries",
		pools = {"common_meals", "predator_meals"},
		deliveryTiers = {
			easy = {
				pools = {
					"valuables_provisions",
				},
				quantity = 1,
			},
			medium = {
				pools = {
					"valuables_provisions",
				},
				quantity = 1,
			},
			hard = {
				pools = {
					"valuables_provisions",
				},
				quantity = 2,
			},
		},
		quantities = {2, 4, 7},
	},
	supplies = {"drink_bottlewater", "food_bread", "food_can_tushonka", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Packed lunch",
				items = {"food_can_tushonka", "food_can_beans", "food_bread"}},
			{label = "Drinks",
				items = {"drink_bottlewater", "drink_bottletea", "drink_energydrink_2"}},
			{label = "Camp cooking",
				items = {"lowtiercookerfuel", "food_can_corn"}},
		},
	},
	dialogue = {
		completedGreeting = (
			"Back again? Good. Tell me what you need before everyone else discovers I'm taking a moment "
			.. "to talk."
		),
		workPrompt = "About the food request I'm filling.",
		offerPrompt = "Do you have a food delivery request?",
		work = (
			"Food requests. Meals and provisions, whatever the actual order asks for. Read it before deciding "
			.. "your favourite dish must be the one I need. I have enough opinions about supper to manage without "
			.. "discovering a delivery was an entirely different meal. Bring it here and keep it clear of the rest "
			.. "of your scavenging."
		),
		progressionPrompt = "What needs doing for the kitchen?",
		progression = (
			"There's the pantry to supply and a cook's scattered records to recover. I want the working notes "
			.. "as well as the recipes people remember liking. We'll begin with an ordinary kitchen request. Some "
			.. "papers need checking by other contacts. Deliver those properly and return; I'd prefer to know they "
			.. "arrived before somebody asks why I've sent them."
		),
	},
	catalogue = {
		["drink_bottlebeer_6"] = {step = "SL05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_canwater"] = {step = "SL05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_energydrink_2"] = {step = "SL11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_energydrink_4"] = {step = "SL11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_spirit_1"] = {step = "SL19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_spirit_2"] = {step = "SL19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_spirit_3"] = {step = "SL19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_vodka_4"] = {step = "SL13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_vodka_5"] = {step = "SL15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_vodka_6"] = {step = "SL15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_wine"] = {step = "SL17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drug_adrenaline"] = {step = "SL11",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["drug_caffeine"] = {step = "SL03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["drug_mints"] = {step = "SL01",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["drug_morphine"] = {step = "SL13",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["drug_painkillers"] = {step = "SL09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["food_can_tomato"] = {step = "SL09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_can_tushonka"] = {step = "SL09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_cheese_2"] = {step = "SL07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_nuts_2"] = {step = "SL07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_antipsychotic_1"] = {step = "SL07",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["medic_psyheal_1"] = {step = "SL05",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["miscaid_swampbrew"] = {step = "SL21",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "SL01",
			completionCash = 275,
			name = "Pots Before Plates",
			kind = "delivery",
			requires = {},
			briefing = (
				"I need the meals on the list. Yes, meals. Before you ask why a cook wants someone else's "
				.. "cooking, I can't keep every pot going at once, and there are people waiting to eat. Bring "
				.. "them here and I'll have a look."
			),
			completion = (
				"Let me see. Good. No, I'm not giving you a score. There's enough to do without starting a "
				.. "competition over who made dinner."
			),
			requirements = {
				{
					pool = "common_meals",
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
			id = "SL02",
			completionCash = 450,
			name = "The Cold Kitchen",
			kind = "field",
			objective = (
				"Recover the kitchen recipe journal from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"SL01"},
			briefing = (
				"My recipe notebook is still out in Marsh. I can cook without it. I'd prefer not to keep proving "
				.. "that point every time someone asks for something different. Recover the kitchen recipe journal "
				.. "from the assigned search area in Marsh. Bring it back to me in Marsh."
			),
			completion = "There it is. Put it well away from the wet things. I'd like to be the next person to stain it.",
			field = {
				description = (
					"A thick brown journal held together by a narrow tie around its cover. Spicy Lemon's note: \"My "
					.. "recipe notebook is still out in Marsh.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "Kitchen recipe journal",
			},
			benefits = {},
		},
		{
			id = "SL03",
			completionCash = 0,
			name = "A Steady Table",
			kind = "tracker",
			requires = {"SL02"},
			briefing = "Continue the meal deliveries. Fill the requested dishes and quantities before coming back.",
			completion = "A useful start. People have strong opinions about food once it's actually here.",
			target = 2,
			benefits = {},
		},
		{
			id = "SL04",
			completionCash = 650,
			name = "Spoor's Contribution",
			kind = "field",
			objective = (
				"Recover the meat-handling notes for Spoor from the assigned search area in Marsh. Deliver it to "
				.. "'Spoor' in Garbage, then come back to the issuing contact in Marsh."
			),
			requires = {"SL02"},
			briefing = (
				"Spoor should have the camp's meat-handling notes. If we're arguing over what can be used, I'd "
				.. "like him looking at the account instead of my face. Recover the meat-handling notes for Spoor "
				.. "from the assigned search area in Marsh. Deliver it to 'Spoor' in Garbage, then come back to me in "
				.. "Marsh."
			),
			completion = "He's got them. Good. We can resume disagreeing with a little more information.",
			field = {
				description = (
					"A thick blue diary with a label fixed to the front cover. Spicy Lemon's note: \"Spoor should have "
					.. "the camp's meat-handling notes.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_diary",
				label = "Meat-handling notes for Spoor",
				recipient = "spoor",
			},
			benefits = {},
		},
		{
			id = "SL05",
			completionCash = 575,
			name = "Clean Enough",
			kind = "delivery",
			requires = {"SL03"},
			briefing = "There's another pantry request. Keep it clear of the leaking things in your pack.",
			completion = (
				"That's the requested lot. A pleasant change from an explanation of why something else was nearly "
				.. "the same."
			),
			requirements = {
				{
					pool = "canned_food",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "SL06",
			completionCash = 850,
			name = "The Spoiled Shipment",
			kind = "field",
			objective = (
				"Recover the spoiled consignment evidence from the assigned search area in Marsh. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"SL04"},
			briefing = (
				"Bring back the shipment evidence. I'd like to know which consignment we're discussing before "
				.. "everyone blames the kitchen. Recover the spoiled consignment evidence from the assigned search "
				.. "area in Marsh. Bring it back to me in Marsh."
			),
			completion = "Leave it sealed. I can inspect it without introducing it to anybody's supper.",
			field = {
				description = (
					"A printed packing list on a small clipboard with a metal clip and a circular stamp. Spicy "
					.. "Lemon's note: \"Bring back the shipment evidence.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_manifest",
				label = "Spoiled consignment evidence",
			},
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
			stock = {
				item = "drink_bottlewater",
				bonus = 1,
			},
		},
		{
			id = "SL07",
			completionCash = 0,
			name = "Same Dish Twice",
			kind = "tracker",
			requires = {"SL05"},
			briefing = (
				"More meal orders when you're prepared. Read what is wanted before deciding what you enjoy "
				.. "cooking."
			),
			completion = "Another steady run. I haven't had to invent a polite description for the returns.",
			target = 5,
			benefits = {},
		},
		{
			id = "SL08",
			completionCash = 1050,
			name = "The Missing Crate",
			kind = "field",
			objective = (
				"Recover the cookware case from the assigned search area in Garbage. Bring it back to the issuing "
				.. "contact in Marsh."
			),
			requires = {"SL06"},
			briefing = (
				"There's a cookware case left along the route. Bring the whole thing; your idea of a useless "
				.. "little fitting may differ from mine. Recover the cookware case from the assigned search area in "
				.. "Garbage. Bring it back to me in Marsh."
			),
			completion = "Good. I'll lay it out before deciding what needs cleaning.",
			field = {
				description = (
					"A small yellow hard case with ribbed corners and a large label on its lid. Spicy Lemon's note: "
					.. "\"There's a cookware case left along the route.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_case",
				label = "cookware case",
			},
			benefits = {},
		},
		{
			id = "SL09",
			completionCash = 875,
			name = "A Proper Pantry",
			kind = "delivery",
			requires = {"SL07"},
			briefing = "Bring the requested food here. Check the dish rather than guessing what I ought to want.",
			completion = "Good. Put it where I can check it before it joins anything else.",
			requirements = {
				{
					pool = "common_meals",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "SL10",
			completionCash = 1250,
			name = "The Supplier's Ledger",
			kind = "field",
			objective = (
				"Recover the food supplier's ledger from the assigned search area in Garbage. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"SL08"},
			briefing = (
				"I want the supplier's book. Everybody remembers having sent enough food; a written entry would "
				.. "make a lovely change. Recover the food supplier's ledger from the assigned search area in "
				.. "Garbage. Bring it back to me in Marsh."
			),
			completion = (
				"Let me read the dates. Quantities become much more interesting when you know which delivery they "
				.. "belong to."
			),
			field = {
				description = (
					"A clipboard carrying a densely printed packing list and a stamped mark. Spicy Lemon's note: \"I "
					.. "want the supplier's book.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_receipt",
				label = "Food supplier's ledger",
			},
			benefits = {},
		},
		{
			id = "SL11",
			completionCash = 0,
			name = "Feeding Travellers",
			kind = "tracker",
			requires = {"SL09"},
			briefing = "Keep completing the meal deliveries while I sort the kitchen records.",
			completion = "You've kept the food coming. That is a useful skill to have around this place.",
			target = 9,
			benefits = {},
		},
		{
			id = "SL12",
			completionCash = 1450,
			name = "Smoke Without Supper",
			kind = "field",
			objective = (
				"Recover the abandoned camp cooking journal from the assigned search area in Marsh. Bring it back "
				.. "to the issuing contact in Marsh."
			),
			requires = {"SL10"},
			briefing = (
				"Bring the cooking log back. People improvise useful things when they stop pretending the proper "
				.. "ingredients are arriving tomorrow. Recover the abandoned camp cooking journal from the assigned "
				.. "search area in Marsh. Bring it back to me in Marsh."
			),
			completion = "Here, away from the stove. I'll read it before deciding which ideas I can steal gracefully.",
			field = {
				description = (
					"A thick brown journal held together by a narrow tie around its cover. Spicy Lemon's note: \"Bring "
					.. "the cooking log back.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_notebook",
				label = "Abandoned camp cooking journal",
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
			id = "SL13",
			completionCash = 1175,
			name = "Something With Flavour",
			kind = "delivery",
			requires = {"SL11"},
			briefing = "Bring the requested food here. Check the dish rather than guessing what I ought to want.",
			completion = "Good. Put it where I can check it before it joins anything else.",
			requirements = {
				{
					pool = "predator_meals",
					quantity = 4,
				},
			},
			benefits = {},
		},
		{
			id = "SL14",
			completionCash = 1650,
			name = "Jitters' Complaint",
			kind = "field",
			objective = (
				"Recover the clinic ration log for Jitters from the assigned search area in Marsh. Deliver it to "
				.. "'Jitters' in Marsh, then come back to the issuing contact in Marsh."
			),
			requires = {"SL12"},
			briefing = (
				"Jitters needs the ration observations. I am perfectly prepared to have this discussion with a "
				.. "page between us for once. Recover the clinic ration log for Jitters from the assigned search area "
				.. "in Marsh. Deliver it to 'Jitters' in Marsh, then come back to me in Marsh."
			),
			completion = "Delivered. He can read the account before explaining what I ought to have put in the pot.",
			field = {
				description = (
					"A blue-green folder with medical record sheets protruding from its cover. Spicy Lemon's note: "
					.. "\"Jitters needs the ration observations.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_clinic",
				label = "Clinic ration log for Jitters",
				recipient = "jitters",
			},
			benefits = {},
		},
		{
			id = "SL15",
			completionCash = 0,
			name = "The Lunch Rush",
			kind = "tracker",
			requires = {"SL13"},
			briefing = "Continue filling the meal requests. Consistency matters after the first impressive effort.",
			completion = "You've stayed dependable. I've begun counting on it, which I hope you appreciate as a compliment.",
			target = 14,
			benefits = {},
		},
		{
			id = "SL16",
			completionCash = 1850,
			name = "An Unfinished Menu",
			kind = "field",
			objective = (
				"Recover the traveller's annotated menu from the assigned search area in Waystation. Bring it back "
				.. "to the issuing contact in Marsh."
			),
			requires = {"SL14"},
			briefing = (
				"I'd like the traveller's menu recovered. A note beside a dish can tell you more than the "
				.. "impressive name on top. Recover the traveller's annotated menu from the assigned search area in "
				.. "Waystation. Bring it back to me in Marsh."
			),
			completion = "Oh, good. I'll see what they actually changed rather than admiring the handwriting.",
			field = {
				description = (
					"A thick brown journal held together by a narrow tie around its cover. Spicy Lemon's note: \"I'd "
					.. "like the traveller's menu recovered.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_notebook",
				label = "Traveller's annotated menu",
			},
			benefits = {},
		},
		{
			id = "SL17",
			completionCash = 1475,
			name = "Food That Travels",
			kind = "delivery",
			requires = {"SL15"},
			briefing = "Bring the requested food here. Check the dish rather than guessing what I ought to want.",
			completion = "Good. Put it where I can check it before it joins anything else.",
			requirements = {
				{
					pool = "common_meals",
					quantity = 5,
				},
			},
			benefits = {},
		},
		{
			id = "SL18",
			completionCash = 2050,
			name = "The Long Walk",
			kind = "field",
			objective = (
				"Recover the ration trial recorder for Gasket from the assigned search area in Marsh. Deliver it "
				.. "to 'Gasket' in Marsh, then come back to the issuing contact in Marsh."
			),
			requires = {"SL16"},
			briefing = (
				"Gasket should have the ration-test record. He's usually the one who remembers to ask what was "
				.. "available on the journey. Recover the ration trial recorder for Gasket from the assigned search "
				.. "area in Marsh. Deliver it to 'Gasket' in Marsh, then come back to me in Marsh."
			),
			completion = "He has it. Fine. I'll listen to his practical objections after he's heard the practical account.",
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. Spicy Lemon's "
					.. "note: \"Gasket should have the ration-test record.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_module",
				label = "Ration trial recorder for Gasket",
				recipient = "gasket",
			},
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
			id = "SL19",
			completionCash = 0,
			name = "A Place at the Fire",
			kind = "tracker",
			requires = {"SL17"},
			briefing = "There are more meal orders. Bring what is requested and leave yourself something to eat.",
			completion = (
				"A substantial amount of kitchen work now. You can accept the thanks before I start complaining "
				.. "again."
			),
			target = 20,
			benefits = {},
		},
		{
			id = "SL20",
			completionCash = 2250,
			name = "The Last Cookfire",
			kind = "field",
			objective = (
				"Recover the missing cook's journal from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"SL18"},
			briefing = (
				"Bring the cook's journal home. I'd like the everyday entries as well as the recipes people "
				.. "thought worth quoting. Recover the missing cook's journal from the assigned search area in Marsh. "
				.. "Bring it back to me in Marsh."
			),
			completion = "Set it here. I'll read the working days before I start wondering about the last one.",
			field = {
				description = (
					"A thick blue diary with a label fixed to the front cover. Spicy Lemon's note: \"Bring the cook's "
					.. "journal home.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_diary",
				label = "Missing cook's journal",
			},
			benefits = {},
		},
		{
			id = "SL21",
			completionCash = 1775,
			name = "Enough for Everyone",
			kind = "delivery",
			requires = {"SL19"},
			briefing = "Bring the requested food here. Check the dish rather than guessing what I ought to want.",
			completion = "Good. Put it where I can check it before it joins anything else.",
			requirements = {
				{
					pool = "predator_meals",
					quantity = 6,
				},
			},
			benefits = {},
		},
		{
			id = "SL22",
			completionCash = 2450,
			name = "The Cook's Detour",
			kind = "field",
			objective = (
				"Recover the cook's personal records from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"SL20"},
			briefing = (
				"The cook's surviving personal papers should come back together. Leave them as they are until "
				.. "they're here. Recover the cook's personal records from the assigned search area in Marsh. Bring "
				.. "it back to me in Marsh."
			),
			completion = "Thank you. I'll keep the papers clear of the kitchen work.",
			field = {
				description = (
					"A cardboard file folder with an emblem and printed wording on the front. Spicy Lemon's note: "
					.. "\"The cook's surviving personal papers should come back together.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_personnel",
				label = "Cook's personal records",
			},
			benefits = {},
		},
		{
			id = "SL23",
			completionCash = 0,
			name = "Reliable Hands",
			kind = "tracker",
			requires = {"SL21", "SL22"},
			briefing = "Keep the requested meals coming when you're ready.",
			completion = (
				"You've helped with the ordinary meals too. Everybody remembers a feast; somebody still has to "
				.. "think about the following day."
			),
			target = 27,
			benefits = {},
		},
		{
			id = "SL24",
			completionCash = 2650,
			name = "The Recipe He Kept",
			kind = "field",
			objective = (
				"Recover the cook's loose recipe pages from the assigned search area in Marsh. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"SL23"},
			briefing = (
				"There's another part of the journal to recover. Keep the pages together; I don't want a missing "
				.. "measure improved by someone's confidence. Recover the cook's loose recipe pages from the assigned "
				.. "search area in Marsh. Bring it back to me in Marsh."
			),
			completion = "There. I'll put them beside the book before deciding where they belong.",
			field = {
				description = (
					"A thick blue diary with a label fixed to the front cover. Spicy Lemon's note: \"There's another "
					.. "part of the journal to recover.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_diary",
				label = "Cook's loose recipe pages",
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
			id = "SL25",
			completionCash = 2000,
			name = "The Feast",
			kind = "delivery",
			requires = {"SL24"},
			briefing = (
				"Bring the requested provisions through. I would like to prepare the food before everyone begins "
				.. "asking whether it's ready."
			),
			completion = "There we are. I can work with that.",
			requirements = {
				{
					pool = "canned_food",
					quantity = 7,
				},
			},
			benefits = {},
		},
		{
			id = "SL26",
			completionCash = 2850,
			name = "Room at the Table",
			kind = "field",
			objective = (
				"Recover the cook's photograph album from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"SL25"},
			briefing = (
				"Bring the album home, away from anything leaking in your pack. I can wipe a table clean. "
				.. "Photographs are less forgiving. Recover the cook's photograph album from the assigned search area "
				.. "in Marsh. Bring it back to me in Marsh."
			),
			completion = (
				"Put it here. You've helped with more than keeping the kitchen supplied. I'm not going to make a "
				.. "speech about it. Stay a while; I'd like some company that isn't asking when the food will be "
				.. "ready."
			),
			field = {
				description = (
					"A thick worn photograph album with a small picture set into its brown cover. Spicy Lemon's note: "
					.. "\"Bring the album home, away from anything leaking in your pack.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_photo",
				label = "Cook's photograph album",
			},
			benefits = {},
			recognition = "Spicy Lemon's trusted contact",
		},
	},
})
