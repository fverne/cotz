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
	supplies = {"drink_bottlewater", "drink_bottlewaterdirty", "food_can_tushonka", "lowtiercookerfuel"},
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
	-- Author-disabled suggestions must not be restored by catalogue or stock generation.
	disabledItems = {
		["meal_human"] = true,
		["meat_human"] = true,
	},
	catalogue = {
		["medic_bandage_1"] = {step = "SL01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_bottlebeer_1"] = {step = "SL17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_bottlebeer_2"] = {step = "SL15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_bottlebeer_3"] = {step = "SL10",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_bottlebeer_4"] = {step = "SL07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_bottlebeer_5"] = {step = "SL16",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_bottlebeer_6"] = {step = "SL13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_bottletea"] = {step = "SL19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_canbeer_1"] = {step = "SL06",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_canbeer_2"] = {step = "SL05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_canbeer_3"] = {step = "SL05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_canbeer_4"] = {step = "SL08",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_canbeer_5"] = {step = "SL14",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_canbeer_6"] = {step = "SL09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_canwater"] = {step = "SL12",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_energydrink_1"] = {step = "SL16",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_energydrink_2"] = {step = "SL14",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_energydrink_3"] = {step = "SL20",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_energydrink_4"] = {step = "SL12",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_energydrink_5"] = {step = "SL18",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_energydrink_6"] = {step = "SL18",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_milk"] = {step = "SL15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_milkold"] = {step = "SL02",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_moonshine"] = {step = "SL19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_orangejuice"] = {step = "SL20",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_spirit_1"] = {step = "SL25",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_spirit_2"] = {step = "SL26",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_spirit_3"] = {step = "SL26",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_vodka_1"] = {step = "SL21",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_vodka_2"] = {step = "SL20",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_vodka_3"] = {step = "SL22",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_vodka_4"] = {step = "SL23",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_vodka_5"] = {step = "SL25",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_vodka_6"] = {step = "SL23",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_wine"] = {step = "SL22",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drug_caffeine"] = {step = "SL01",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["food_bread"] = {step = "SL03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_burger"] = {step = "SL01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_can_beans"] = {step = "SL04",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_can_chilibeans"] = {step = "SL04",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_can_corn"] = {step = "SL03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_can_olive"] = {step = "SL10",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_can_sprats"] = {step = "SL13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_can_tomato"] = {step = "SL06",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_can_tuna"] = {step = "SL08",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_can_tushonka"] = {step = "SL10",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_cheese_1"] = {step = "SL11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_cheese_2"] = {step = "SL13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_cheese_3"] = {step = "SL17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_chocolate"] = {step = "SL21",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_mre_russia"] = {step = "SL24",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_mre_ukraine"] = {step = "SL23",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_mre_usa"] = {step = "SL24",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_nuts_1"] = {step = "SL09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_nuts_2"] = {step = "SL11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_oldmeat"] = {step = "SL01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_raisins"] = {step = "SL17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_sausage_1"] = {step = "SL04",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_sausage_2"] = {step = "SL07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["hightiercooker"] = {step = "SL18",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["lowtiercooker"] = {step = "SL26",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["lowtiercookerfuel"] = {step = "SL09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["meal_bear"] = {step = "SL19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meal_blinddog"] = {step = "SL04",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meal_bloodsucker"] = {step = "SL17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meal_boar"] = {step = "SL06",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meal_burer"] = {step = "SL14",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meal_cat"] = {step = "SL08",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meal_chimera"] = {step = "SL25",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meal_controller"] = {step = "SL21",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meal_flesh"] = {step = "SL05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meal_hellhound"] = {step = "SL23",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["meal_human"] = {step = "SL01",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meal_karlik"] = {step = "SL18",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meal_pseudodog"] = {step = "SL10",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meal_pseudogiant"] = {step = "SL26",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meal_snork"] = {step = "SL15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meal_spider"] = {step = "SL09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meal_sprig"] = {step = "SL12",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meal_tark"] = {step = "SL13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meal_tushkano"] = {step = "SL02",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meal_vareshka"] = {step = "SL22",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meat_bear"] = {step = "SL23",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meat_blinddog"] = {step = "SL04",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meat_bloodsucker"] = {step = "SL17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meat_boar"] = {step = "SL05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meat_burer"] = {step = "SL15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meat_cat"] = {step = "SL09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meat_chimera"] = {step = "SL21",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meat_controller"] = {step = "SL25",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meat_flesh"] = {step = "SL10",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meat_hellhound"] = {step = "SL22",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["meat_human"] = {step = "SL01",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meat_karlik"] = {step = "SL14",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meat_pseudodog"] = {step = "SL13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meat_pseudogiant"] = {step = "SL26",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meat_snork"] = {step = "SL18",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meat_spider"] = {step = "SL08",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meat_sprig"] = {step = "SL12",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meat_tark"] = {step = "SL06",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meat_tushkano"] = {step = "SL02",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["meat_vareshka"] = {step = "SL19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["waterflask"] = {step = "SL01",
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
				"I need supplies for the kitchen. Read the list; I have enough people explaining what I should "
				.. "cook without bringing me anything to cook with. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
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
			plannedUnlocks = {
				-- TODO: Implement recipe consumer; verify these proposed terms before enabling.
				{
					id = "spicy-lemon/SL04/future",
					provider = "spicy-lemon",
					status = "unimplemented",
					kind = "recipe",
					name = "Flesh expedition meal",
					effect = "Unlock a distinct prepared-meal recipe; retain ordinary cooking and author the recipe consumer.",
					inputs = {
						{
							item = "meat_flesh",
							quantity = 1,
						},
						{
							item = "food_bread",
							quantity = 1,
						},
					},
					output = {
						item = "meal_flesh",
						quantity = 1,
					},
					fuel = {
						item = "lowtiercookerfuel",
						quantity = 1,
					},
				},
			},
			completionCash = 650,
			name = "A small delivery",
			kind = "delivery",
			retiredCommission = true,
			objective = "Bring all 1 listed item type to this contact. The request shows each selected item and required units.",
			requires = {"SL02"},
			briefing = (
				"I need supplies for the kitchen. Read the list; I have enough people explaining what I should "
				.. "cook without bringing me anything to cook with. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "SL05",
			completionCash = 575,
			name = "Clean Enough",
			kind = "delivery",
			requires = {"SL03"},
			briefing = (
				"I need supplies for the kitchen. Read the list; I have enough people explaining what I should "
				.. "cook without bringing me anything to cook with. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 1,
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
			stock = {item = "drink_bottlewaterdirty", bonus = 1},
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
			plannedUnlocks = {
				-- TODO: Implement recipe consumer; verify these proposed terms before enabling.
				{
					id = "spicy-lemon/SL08/future",
					provider = "spicy-lemon",
					status = "unimplemented",
					kind = "recipe",
					name = "Boar expedition meal",
					effect = "Unlock a distinct prepared-meal recipe; retain ordinary cooking and author the recipe consumer.",
					inputs = {
						{
							item = "meat_boar",
							quantity = 1,
						},
						{
							item = "food_can_beans",
							quantity = 1,
						},
					},
					output = {
						item = "meal_boar",
						quantity = 1,
					},
					fuel = {
						item = "lowtiercookerfuel",
						quantity = 1,
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
			requires = {"SL06"},
			briefing = (
				"I need supplies for the kitchen. Read the list; I have enough people explaining what I should "
				.. "cook without bringing me anything to cook with. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "SL09",
			completionCash = 875,
			name = "A Proper Pantry",
			kind = "delivery",
			requires = {"SL07"},
			briefing = (
				"I need supplies for the kitchen. Read the list; I have enough people explaining what I should "
				.. "cook without bringing me anything to cook with. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 1,
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
				map = "rp_garbage_cotz",
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
			plannedUnlocks = {
				-- TODO: Implement recipe consumer; verify these proposed terms before enabling.
				{
					id = "spicy-lemon/SL12/future",
					provider = "spicy-lemon",
					status = "unimplemented",
					kind = "recipe",
					name = "Blinddog expedition meal",
					effect = "Unlock a distinct prepared-meal recipe; retain ordinary cooking and author the recipe consumer.",
					inputs = {
						{
							item = "meat_blinddog",
							quantity = 1,
						},
						{
							item = "food_can_tomato",
							quantity = 1,
						},
					},
					output = {
						item = "meal_blinddog",
						quantity = 1,
					},
					fuel = {
						item = "lowtiercookerfuel",
						quantity = 1,
					},
				},
			},
			completionCash = 1450,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"SL10"},
			briefing = (
				"I need supplies for the kitchen. Read the list; I have enough people explaining what I should "
				.. "cook without bringing me anything to cook with. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 1,
				},
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
			briefing = (
				"I need supplies for the kitchen. Read the list; I have enough people explaining what I should "
				.. "cook without bringing me anything to cook with. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_3",
					quantity = 1,
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
			plannedUnlocks = {
				-- TODO: Implement recipe consumer; verify these proposed terms before enabling.
				{
					id = "spicy-lemon/SL16/future",
					provider = "spicy-lemon",
					status = "unimplemented",
					kind = "recipe",
					name = "Pseudodog expedition meal",
					effect = "Unlock a distinct prepared-meal recipe; retain ordinary cooking and author the recipe consumer.",
					inputs = {
						{
							item = "meat_pseudodog",
							quantity = 1,
						},
						{
							item = "food_can_corn",
							quantity = 1,
						},
					},
					output = {
						item = "meal_pseudodog",
						quantity = 1,
					},
					fuel = {
						item = "lowtiercookerfuel",
						quantity = 1,
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
			requires = {"SL14"},
			briefing = (
				"I need supplies for the kitchen. Read the list; I have enough people explaining what I should "
				.. "cook without bringing me anything to cook with. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "SL17",
			completionCash = 1475,
			name = "Food That Travels",
			kind = "delivery",
			requires = {"SL15"},
			briefing = (
				"I need supplies for the kitchen. Read the list; I have enough people explaining what I should "
				.. "cook without bringing me anything to cook with. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_3",
					quantity = 1,
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
			plannedUnlocks = {
				-- TODO: Implement recipe consumer; verify these proposed terms before enabling.
				{
					id = "spicy-lemon/SL20/future",
					provider = "spicy-lemon",
					status = "unimplemented",
					kind = "recipe",
					name = "Bloodsucker expedition meal",
					effect = "Unlock a distinct prepared-meal recipe; retain ordinary cooking and author the recipe consumer.",
					inputs = {
						{
							item = "meat_bloodsucker",
							quantity = 1,
						},
						{
							item = "food_can_chilibeans",
							quantity = 1,
						},
					},
					output = {
						item = "meal_bloodsucker",
						quantity = 1,
					},
					fuel = {
						item = "lowtiercookerfuel",
						quantity = 1,
					},
				},
			},
			completionCash = 2250,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"SL18"},
			briefing = (
				"I need supplies for the kitchen. Read the list; I have enough people explaining what I should "
				.. "cook without bringing me anything to cook with. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "SL21",
			completionCash = 1775,
			name = "Enough for Everyone",
			kind = "delivery",
			requires = {"SL19"},
			briefing = (
				"I need supplies for the kitchen. Read the list; I have enough people explaining what I should "
				.. "cook without bringing me anything to cook with. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_3",
					quantity = 1,
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
			plannedUnlocks = {
				-- TODO: Implement recipe consumer; verify these proposed terms before enabling.
				{
					id = "spicy-lemon/SL24/future",
					provider = "spicy-lemon",
					status = "unimplemented",
					kind = "recipe",
					name = "Chimera expedition meal",
					effect = "Unlock a distinct prepared-meal recipe; retain ordinary cooking and author the recipe consumer.",
					inputs = {
						{
							item = "meat_chimera",
							quantity = 1,
						},
						{
							item = "food_can_tushonka",
							quantity = 1,
						},
					},
					output = {
						item = "meal_chimera",
						quantity = 1,
					},
					fuel = {
						item = "lowtiercookerfuel",
						quantity = 1,
					},
				},
			},
			completionCash = 2650,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"SL23"},
			briefing = (
				"I need supplies for the kitchen. Read the list; I have enough people explaining what I should "
				.. "cook without bringing me anything to cook with. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_kitchen_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_4",
					quantity = 2,
				},
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
				"I need supplies for the kitchen. Read the list; I have enough people explaining what I should "
				.. "cook without bringing me anything to cook with. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Good. Put those over here. I will decide where they go in the kitchen.",
			requirements = {
				{
					pool = "town_delivery_kitchen_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_kitchen_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_kitchen_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_kitchen_marsh_4",
					quantity = 2,
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
