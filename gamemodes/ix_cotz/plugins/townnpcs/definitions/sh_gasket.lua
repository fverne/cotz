PLUGIN:Register("gasket", {
	name = "'Gasket'",
	template = "gasketnpc",
	map = "rp_marsh_cs",
	job = {
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		category = "Utility supply deliveries",
		description = "Utility supply deliveries",
		pools = {"fuel", "filters", "engine_care"},
		deliveryTiers = {
			easy = {
				pools = {
					"valuables_cleaning_supplies",
					"valuables_fuel_supplies",
				},
				quantity = 1,
			},
			medium = {
				pools = {
					"valuables_filtration",
					"valuables_electrical_supplies",
				},
				quantity = 1,
			},
			hard = {
				pools = {
					"valuables_portable_power",
					"valuables_reinforced_cases",
				},
				quantity = 2,
			},
		},
		quantities = {2, 4, 7},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Fuel allowance",
				items = {"lowtiercookerfuel"}},
			{label = "Utility stores (trade goods)",
				items = {"value_battery", "value_waterfilter", "value_airfilter"}},
			{label = "Reserve provisions",
				items = {"drink_bottlewater", "food_bread"}},
		},
	},
	dialogue = {
		delivery = "Put it on the clear bench. Not beside the fuel.",
		completedGreeting = (
			"Good to see you. Give me a moment to finish this before you tell me what somebody's been "
			.. "touching."
		),
		workPrompt = "What are we doing about the current supply order?",
		offerPrompt = "Do you need utility supplies brought in?",
		work = (
			"Fuel, filters, cleaning stock, the things we use and then forget to replace. Take a request you "
			.. "can fill, check what it actually asks for, and bring the supplies here. I'll inspect what comes in "
			.. "before deciding where it belongs. I'd enjoy having tomorrow's problem on a shelf instead of "
			.. "arriving through the door at breakfast."
		),
		progressionPrompt = "What's the next part of the utility work?",
		progression = (
			"I've got supplies to build up and old utility records to recover. Start with what you can manage. "
			.. "I want to check the maintenance against something more useful than the last person's assurance "
			.. "that it was always like that. When a delivery belongs on somebody else's bench, the order says who "
			.. "gets it. Come back afterwards; I still need to know you got through."
		),
	},
	catalogue = {
		["mask_cloth"] = {step = "GK01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mask_gp5"] = {step = "GK07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mask_halfmask"] = {step = "GK03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mask_respirator"] = {step = "GK05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "GK01",
			completionCash = 275,
			name = "Keep It Turning",
			kind = "delivery",
			requires = {},
			briefing = (
				"There are supplies missing again. Everybody notices when something stops working; fewer people "
				.. "notice what it takes to keep it going. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
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
			id = "GK02",
			completionCash = 450,
			name = "The Empty Service Shed",
			kind = "field",
			objective = (
				"Recover the generator service journal from the assigned search area in Marsh. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"GK01"},
			briefing = (
				"Someone kept the generator serviced before I inherited everyone else's guesses. I'd like to see "
				.. "what they wrote down. Recover the generator service journal from the assigned search area in "
				.. "Marsh. Bring it back to me in Marsh."
			),
			completion = "Good, the binding held. I'll read it before I take another cover off.",
			field = {
				description = (
					"A thick brown journal held together by a narrow tie around its cover. Gasket's note: \"Someone "
					.. "kept the generator serviced before I inherited everyone else's guesses.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "Generator service journal",
			},
			benefits = {},
		},
		{
			id = "GK03",
			completionCash = 0,
			name = "The First Reserve",
			kind = "tracker",
			requires = {"GK02"},
			briefing = (
				"Keep the utility deliveries coming. I want the cupboard useful between the exciting recoveries "
				.. "too."
			),
			completion = "A useful beginning. I can plan a little further ahead now.",
			target = 2,
			benefits = {},
		},
		{
			id = "GK04",
			completionCash = 650,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"GK03"},
			briefing = (
				"There are supplies missing again. Everybody notices when something stops working; fewer people "
				.. "notice what it takes to keep it going. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "GK05",
			completionCash = 575,
			name = "Water Before Comfort",
			kind = "delivery",
			requires = {"GK03"},
			briefing = (
				"There are supplies missing again. Everybody notices when something stops working; fewer people "
				.. "notice what it takes to keep it going. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "GK06",
			completionCash = 850,
			name = "The Pump Log",
			kind = "field",
			objective = (
				"Recover the water-pump maintenance log from the assigned search area in Marsh. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"GK04"},
			briefing = (
				"I want the last pump entries, including the dull ones. People always remember a failure and "
				.. "forget the weeks of small complaints before it. Recover the water-pump maintenance log from the "
				.. "assigned search area in Marsh. Bring it back to me in Marsh."
			),
			completion = "Here we are. I'll start with the service dates and work forward.",
			field = {
				description = (
					"A thick brown journal held together by a narrow tie around its cover. Gasket's note: \"I want the "
					.. "last pump entries, including the dull ones.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "Water-pump maintenance log",
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
			id = "GK07",
			completionCash = 0,
			name = "A Steady Supply",
			kind = "tracker",
			requires = {"GK05"},
			briefing = (
				"Another stretch of utility deliveries. The order still matters more than what happened to be "
				.. "nearest."
			),
			completion = "You've kept things arriving. I haven't had to chase this lot.",
			target = 5,
			benefits = {},
		},
		{
			id = "GK08",
			completionCash = 1050,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"GK06"},
			briefing = (
				"There are supplies missing again. Everybody notices when something stops working; fewer people "
				.. "notice what it takes to keep it going. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "GK09",
			completionCash = 875,
			name = "Backup Power",
			kind = "delivery",
			requires = {"GK07"},
			briefing = (
				"There are supplies missing again. Everybody notices when something stops working; fewer people "
				.. "notice what it takes to keep it going. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "GK10",
			completionCash = 1250,
			name = "The Scrap Specification",
			kind = "field",
			objective = (
				"Recover the replacement-part specification from the assigned search area in Garbage. Deliver it "
				.. "to 'Latch' in Garbage, then come back to the issuing contact in Marsh."
			),
			requires = {"GK08"},
			briefing = (
				"Latch can judge a replacement if he has the specification. I'm tired of describing a fitting with "
				.. "my hands. Recover the replacement-part specification from the assigned search area in Garbage. "
				.. "Deliver it to 'Latch' in Garbage, then come back to me in Marsh."
			),
			completion = "He has the drawing now. That should spare both of us a conversation about what I meant by small.",
			field = {
				description = (
					"A cardboard file folder with a small coloured crest on its cover. Gasket's note: \"Latch can "
					.. "judge a replacement if he has the specification.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_official",
				label = "Replacement-part specification",
				recipient = "latch",
			},
			benefits = {},
		},
		{
			id = "GK11",
			completionCash = 0,
			name = "More Than One Tank",
			kind = "tracker",
			requires = {"GK09"},
			briefing = "Continue supplying the utility orders. I need the regular work as much as the unusual cases.",
			completion = "That's been steady work. I appreciate not having to ask twice.",
			target = 9,
			benefits = {},
		},
		{
			id = "GK12",
			completionCash = 1450,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"GK10"},
			briefing = (
				"There are supplies missing again. Everybody notices when something stops working; fewer people "
				.. "notice what it takes to keep it going. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_3",
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
			id = "GK13",
			completionCash = 1175,
			name = "Before the Blowout",
			kind = "delivery",
			requires = {"GK11"},
			briefing = (
				"There are supplies missing again. Everybody notices when something stops working; fewer people "
				.. "notice what it takes to keep it going. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "GK14",
			completionCash = 1650,
			name = "The Shelter Circuit",
			kind = "field",
			objective = (
				"Recover the shelter service recorder from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"GK12"},
			briefing = (
				"The shelter's service recorder may tell me more than a report saying everything seemed fine. I'd "
				.. "like the actual record. Recover the shelter service recorder from the assigned search area in "
				.. "Marsh. Bring it back to me in Marsh."
			),
			completion = "Leave the number visible. I want to keep this separate while I go through it.",
			field = {
				description = (
					"A flat dark electronic module marked with a number and three pale bars. Gasket's note: \"The "
					.. "shelter's service recorder may tell me more than a report saying everything seemed fine.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_module2",
				label = "Shelter service recorder",
			},
			benefits = {},
		},
		{
			id = "GK15",
			completionCash = 0,
			name = "Nothing Left Dry",
			kind = "tracker",
			requires = {"GK13"},
			briefing = "There's more utility supply work on the books. Choose an order you can actually bring back.",
			completion = "You've kept at it. Plenty of people would have got bored of fuel by now.",
			target = 14,
			benefits = {},
		},
		{
			id = "GK16",
			completionCash = 1850,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"GK14"},
			briefing = (
				"There are supplies missing again. Everybody notices when something stops working; fewer people "
				.. "notice what it takes to keep it going. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "GK17",
			completionCash = 1475,
			name = "A Season of Spares",
			kind = "delivery",
			requires = {"GK15"},
			briefing = (
				"There are supplies missing again. Everybody notices when something stops working; fewer people "
				.. "notice what it takes to keep it going. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "GK18",
			completionCash = 2050,
			name = "The Original Manual",
			kind = "field",
			objective = (
				"Recover the original utility manual from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"GK16"},
			briefing = (
				"I want the original utility papers. If the last fellow changed something, I'd like to know what "
				.. "he was changing it from. Recover the original utility manual from the assigned search area in "
				.. "Marsh. Bring it back to me in Marsh."
			),
			completion = "Careful with the edges. I'll make a clean copy of anything I need beside the machinery.",
			field = {
				description = (
					"A cardboard file folder with a small coloured crest on its cover. Gasket's note: \"I want the "
					.. "original utility papers.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_official",
				label = "Original utility manual",
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
			id = "GK19",
			completionCash = 0,
			name = "A Town That Runs",
			kind = "tracker",
			requires = {"GK17", "GK18"},
			briefing = "Keep up the utility deliveries while I work through the service records.",
			completion = (
				"We've had a proper run of supplies. I can put some thought into maintenance instead of the next "
				.. "shortage."
			),
			target = 20,
			benefits = {},
		},
		{
			id = "GK20",
			completionCash = 2250,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"GK19"},
			briefing = (
				"There are supplies missing again. Everybody notices when something stops working; fewer people "
				.. "notice what it takes to keep it going. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_utilities_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_4",
					quantity = 1,
				},
			},
			benefits = {},
			stock = {
				item = "drink_bottlewater",
				bonus = 2,
			},
		},
		{
			id = "GK21",
			completionCash = 1775,
			name = "Enough in Reserve",
			kind = "delivery",
			requires = {"GK20"},
			briefing = (
				"There are supplies missing again. Everybody notices when something stops working; fewer people "
				.. "notice what it takes to keep it going. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_utilities_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_4",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "GK22",
			completionCash = 2450,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"GK21"},
			briefing = (
				"There are supplies missing again. Everybody notices when something stops working; fewer people "
				.. "notice what it takes to keep it going. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Good. Leave those where I can reach them. Someone will need them soon enough.",
			requirements = {
				{
					pool = "town_delivery_utilities_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_utilities_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_utilities_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_utilities_marsh_4",
					quantity = 1,
				},
			},
			benefits = {},
			recognition = "Gasket's trusted contact",
		},
	},
})
