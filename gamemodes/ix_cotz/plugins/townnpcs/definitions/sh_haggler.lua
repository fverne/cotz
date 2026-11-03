PLUGIN:Register("haggler", {
	name = "'Haggler'",
	template = "tradernpc",
	map = "rp_marsh_cs",
	job = {
		kind = "humans",
		trigger = "banditKilled",
		category = "Hostile human elimination",
		description = "Hostile human elimination",
		quantities = {5, 9, 15},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Sidearm stock",
				items = {"9x18", "762x25", "9x19"}},
			{label = "Cheap firepower",
				items = {"12gauge", "45acp41", "762x39"}},
			{label = "Road supplies",
				items = {"food_can_beans", "drink_bottlewater"}},
		},
	},
	dialogue = {
		completedGreeting = (
			"There you are. It's pleasant to see a customer whose promises don't need chasing all over "
			.. "the Marsh."
		),
		workPrompt = "About the job I'm doing for you.",
		offerPrompt = "Do you have an elimination job?",
		work = (
			"Hostile elimination orders. The specified targets, before you become inspired by somebody else's "
			.. "valuable-looking pack. I need the work done as agreed. Read the order, decide whether the payment "
			.. "suits you, then prepare. We can have an entirely different conversation about buying things when "
			.. "you return."
		),
		progressionPrompt = "What needs doing about the trading accounts?",
		progression = (
			"There are trading records to recover and ordinary supplies to bring in. Too many people remember "
			.. "an agreement only after they've explained what it ought to have been. I'd like the originals. Some "
			.. "go to other contacts for checking; deliver them and come back. I am capable of waiting for a "
			.. "useful answer, despite what Ledger tells you."
		),
	},
	catalogue = {
		["bat"] = {step = "HG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["beretta92"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["brhp"] = {step = "HG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["c96"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["c96carbine"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["cz52"] = {step = "HG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["fort12"] = {step = "HG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["g2contender"] = {step = "HG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["g2contender500"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["glock17"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["glock18"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["ij600"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["kiparis"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["kp31"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["lugerp08"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["m1887"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["m1911"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["m1911chic"] = {step = "HG11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["m1917"] = {step = "HG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["m1928"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mac11"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["makarov"] = {step = "HG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mp18"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mp27"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mp34"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mp40"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mp5k"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["nagantrev"] = {step = "HG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["obrezmalfunction"] = {step = "HG11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["p99"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["ppsh"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["rugermini14"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["rugermk3"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["saigasemi545"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["skorpion"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sks"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["stechaps"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sten"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sterling"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["taurusjudge"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["tokarev"] = {step = "HG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["toz194"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["toz34"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["toz66"] = {step = "HG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["uzi"] = {step = "HG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "HG01",
			completionCash = 275,
			name = "Opening the Shutters",
			kind = "delivery",
			requires = {},
			briefing = (
				"I have a supply request worth your time. Bring what is on the list and we can both finish this "
				.. "bit of business satisfied. Bring everything on the list back here; I need the full delivery."
			),
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
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
			id = "HG02",
			completionCash = 450,
			name = "The Missing Invoice",
			kind = "field",
			objective = (
				"Recover the missing trading invoice from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"HG01"},
			briefing = (
				"An invoice has gone missing. Everyone remembers the amount most favourable to them, so I'd like "
				.. "the paper. Recover the missing trading invoice from the assigned search area in Marsh. Bring it "
				.. "back to me in Marsh."
			),
			completion = "Ah, something with writing on it. A refreshing addition to the discussion.",
			field = {
				description = (
					"A clipboard carrying a densely printed packing list and a stamped mark. Haggler's note: \"An "
					.. "invoice has gone missing.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_receipt",
				label = "Missing trading invoice",
			},
			benefits = {},
		},
		{
			id = "HG03",
			completionCash = 0,
			name = "A Small Problem",
			kind = "tracker",
			requires = {"HG02"},
			briefing = (
				"Continue the hostile elimination orders. The specified armed targets, not people you've had a "
				.. "disagreement with."
			),
			completion = "A few completed orders. I appreciate a problem being dealt with as agreed.",
			target = 2,
			benefits = {},
		},
		{
			id = "HG04",
			completionCash = 650,
			name = "A small delivery",
			kind = "delivery",
			retiredCommission = true,
			objective = "Bring all 1 listed item type to this contact. The request shows each selected item and required units.",
			requires = {"HG03"},
			briefing = (
				"I have a supply request worth your time. Bring what is on the list and we can both finish this "
				.. "bit of business satisfied. Bring everything on the list back here; I need the full delivery."
			),
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "HG05",
			completionCash = 575,
			name = "Working Capital",
			kind = "delivery",
			requires = {"HG04"},
			briefing = (
				"I have a supply request worth your time. Bring what is on the list and we can both finish this "
				.. "bit of business satisfied. Bring everything on the list back here; I need the full delivery."
			),
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trade_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "HG06",
			completionCash = 850,
			name = "The Wrong Seal",
			kind = "field",
			objective = (
				"Recover the consignment seal record from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"HG04"},
			briefing = (
				"I'd like the consignment seal record. A seal described from memory is worth precisely what the "
				.. "description costs. Recover the consignment seal record from the assigned search area in Marsh. "
				.. "Bring it back to me in Marsh."
			),
			completion = "Good. Now we can discuss which shipment people actually mean.",
			field = {
				description = (
					"A printed packing list on a small clipboard with a metal clip and a circular stamp. Haggler's "
					.. "note: \"I'd like the consignment seal record.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_manifest",
				label = "Consignment seal record",
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
			id = "HG07",
			completionCash = 0,
			name = "Safer Roads",
			kind = "tracker",
			requires = {"HG05"},
			briefing = "More elimination work. Read the target request before accepting.",
			completion = "You've kept to the terms. An excellent habit in a customer and an employee.",
			target = 5,
			benefits = {},
		},
		{
			id = "HG08",
			completionCash = 1050,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"HG06"},
			briefing = (
				"I have a supply request worth your time. Bring what is on the list and we can both finish this "
				.. "bit of business satisfied. Bring everything on the list back here; I need the full delivery."
			),
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trade_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "HG09",
			completionCash = 875,
			name = "Stock Worth Carrying",
			kind = "delivery",
			requires = {"HG07"},
			briefing = (
				"I have a supply request worth your time. Bring what is on the list and we can both finish this "
				.. "bit of business satisfied. Bring everything on the list back here; I need the full delivery."
			),
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trade_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "HG10",
			completionCash = 1250,
			name = "Two Sets of Books",
			kind = "field",
			objective = (
				"Recover the second freight ledger from the assigned search area in Marsh. Deliver it to 'Ledger' "
				.. "in Waystation, then come back to the issuing contact in Marsh."
			),
			requires = {"HG08"},
			briefing = (
				"Ledger gets the second book. If somebody has two accounts, I want them compared by a man who "
				.. "enjoys finding the difference. Recover the second freight ledger from the assigned search area in "
				.. "Marsh. Deliver it to 'Ledger' in Waystation, then come back to me in Marsh."
			),
			completion = "He's got it? Excellent. I can wait for an answer that comes with page numbers.",
			field = {
				description = (
					"A clipboard carrying a densely printed packing list and a stamped mark. Haggler's note: \"Ledger "
					.. "gets the second book.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_receipt",
				label = "Second freight ledger",
				recipient = "ledger",
			},
			benefits = {},
		},
		{
			id = "HG11",
			completionCash = 0,
			name = "Paying Customers",
			kind = "tracker",
			requires = {"HG09"},
			briefing = "Keep completing the specified elimination orders. I don't pay for creative interpretations.",
			completion = "A steady run of finished work. We seem to understand one another.",
			target = 9,
			benefits = {},
		},
		{
			id = "HG12",
			completionCash = 1450,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"HG10"},
			briefing = (
				"I have a supply request worth your time. Bring what is on the list and we can both finish this "
				.. "bit of business satisfied. Bring everything on the list back here; I need the full delivery."
			),
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trade_marsh_2",
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
			id = "HG13",
			completionCash = 1175,
			name = "An Honest Sample",
			kind = "delivery",
			requires = {"HG11"},
			briefing = (
				"I have a supply request worth your time. Bring what is on the list and we can both finish this "
				.. "bit of business satisfied. Bring everything on the list back here; I need the full delivery."
			),
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trade_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trade_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "HG14",
			completionCash = 1650,
			name = "A Broken Agreement",
			kind = "field",
			objective = (
				"Recover the supplier's broken agreement from the assigned search area in Garbage. Bring it back "
				.. "to the issuing contact in Marsh."
			),
			requires = {"HG12"},
			briefing = (
				"Bring the supplier contract intact. People lose things without help; I'd like evidence before I "
				.. "spend money blaming anyone. Recover the supplier's broken agreement from the assigned search area "
				.. "in Garbage. Bring it back to me in Marsh."
			),
			completion = "Let's read the terms. I'm prepared to be offended after I've established what was promised.",
			field = {
				description = (
					"A creased printed letter with a corporate mark and several small blocks of text. Haggler's note: "
					.. "\"Bring the supplier contract intact.\""
				),
				kind = "recovery",
				map = "rp_garbage_cotz",
				tier = 2,
				cargo = "town_quest_contract",
				label = "Supplier's broken agreement",
			},
			benefits = {},
		},
		{
			id = "HG15",
			completionCash = 0,
			name = "No More Tolls",
			kind = "tracker",
			requires = {"HG13"},
			briefing = "There are more target orders. Pick work you can actually finish.",
			completion = "You've kept returning with the work done. I find myself planning around that.",
			target = 14,
			benefits = {},
		},
		{
			id = "HG16",
			completionCash = 1850,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"HG14"},
			briefing = (
				"I have a supply request worth your time. Bring what is on the list and we can both finish this "
				.. "bit of business satisfied. Bring everything on the list back here; I need the full delivery."
			),
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trade_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trade_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "HG17",
			completionCash = 1475,
			name = "Shelf Space",
			kind = "delivery",
			requires = {"HG15"},
			briefing = (
				"I have a supply request worth your time. Bring what is on the list and we can both finish this "
				.. "bit of business satisfied. Bring everything on the list back here; I need the full delivery."
			),
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trade_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trade_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "HG18",
			completionCash = 2050,
			name = "The Shipment List",
			kind = "field",
			objective = (
				"Recover the distributor's shipment manifest from the assigned search area in Marsh. Deliver it to "
				.. "'Brass' in Garbage, then come back to the issuing contact in Marsh."
			),
			requires = {"HG16"},
			briefing = (
				"Brass needs the shipment manifest. I want the quantities checked by someone who won't be charmed "
				.. "out of counting. Recover the distributor's shipment manifest from the assigned search area in "
				.. "Marsh. Deliver it to 'Brass' in Garbage, then come back to me in Marsh."
			),
			completion = "Good. He'll count it, which is inconvenient right up until you need the correct figure.",
			field = {
				description = (
					"A printed packing list on a small clipboard with a metal clip and a circular stamp. Haggler's "
					.. "note: \"Brass needs the shipment manifest.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_manifest",
				label = "Distributor's shipment manifest",
				recipient = "brass",
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
			id = "HG19",
			completionCash = 0,
			name = "A Wider Market",
			kind = "tracker",
			requires = {"HG17"},
			briefing = "Continue the elimination assignments while I compare the freight accounts.",
			completion = "A useful amount of trouble dealt with. You've earned the acknowledgement.",
			target = 20,
			benefits = {},
		},
		{
			id = "HG20",
			completionCash = 2250,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"HG18"},
			briefing = (
				"I have a supply request worth your time. Bring what is on the list and we can both finish this "
				.. "bit of business satisfied. Bring everything on the list back here; I need the full delivery."
			),
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trade_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trade_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "HG21",
			completionCash = 1775,
			name = "Proof of Delivery",
			kind = "delivery",
			requires = {"HG19", "HG20"},
			briefing = (
				"I have a supply request worth your time. Bring what is on the list and we can both finish this "
				.. "bit of business satisfied. Bring everything on the list back here; I need the full delivery."
			),
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trade_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trade_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "HG22",
			completionCash = 2450,
			name = "The Unpaid Supplier",
			kind = "field",
			objective = (
				"Recover the unpaid supplier's file from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"HG21"},
			briefing = (
				"The supplier's surviving evidence is still out on the route. I'd like an account from someone "
				.. "besides the people demanding payment. Recover the unpaid supplier's file from the assigned search "
				.. "area in Marsh. Bring it back to me in Marsh."
			),
			completion = "Keep the little papers with it. Small writing can have surprisingly expensive consequences.",
			field = {
				description = (
					"A cardboard file folder with an emblem and printed wording on the front. Haggler's note: \"The "
					.. "supplier's surviving evidence is still out on the route.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_personnel",
				label = "Unpaid supplier's file",
			},
			benefits = {},
		},
		{
			id = "HG23",
			completionCash = 0,
			name = "Closing the Account",
			kind = "tracker",
			requires = {"HG22"},
			briefing = "More of the specified elimination work when you're prepared.",
			completion = (
				"You've stayed reliable after the novelty wore off. That's when a business acquaintance becomes "
				.. "valuable."
			),
			target = 27,
			benefits = {},
		},
		{
			id = "HG24",
			completionCash = 2650,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"HG23"},
			briefing = (
				"I have a supply request worth your time. Bring what is on the list and we can both finish this "
				.. "bit of business satisfied. Bring everything on the list back here; I need the full delivery."
			),
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_trade_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_trade_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_trade_marsh_4",
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
			id = "HG25",
			completionCash = 2000,
			name = "A Shop That Lasts",
			kind = "delivery",
			requires = {"HG24"},
			briefing = (
				"I have a supply request worth your time. Bring what is on the list and we can both finish this "
				.. "bit of business satisfied. Bring everything on the list back here; I need the full delivery."
			),
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_trade_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_trade_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_trade_marsh_4",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "HG26",
			completionCash = 2850,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"HG25"},
			briefing = (
				"I have a supply request worth your time. Bring what is on the list and we can both finish this "
				.. "bit of business satisfied. Bring everything on the list back here; I need the full delivery."
			),
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_trade_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_trade_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_trade_marsh_4",
					quantity = 1,
				},
			},
			benefits = {},
			recognition = "Haggler's trusted contact",
		},
	},
})
