PLUGIN:Register("haggler", {
	name = "'Haggler'",
	template = "tradernpc",
	difficultyMultiplier = 2,
	enforceCatalogue = true,
	map = "rp_marsh_cs",
	courierPools = {
		"valuables_decorative_valuables",
		"valuables_personal_effects",
		"valuables_portable_power",
		"valuables_transit_cases",
	},
	job = {
		kind = "regionalHumans",
		category = "Regional human elimination",
		description = "Regional human elimination",
		maps = {
			easy = "rp_marsh_cs",
			medium = "rp_garbage_cotz",
			hard = "rp_waystation",
		},
	},
	legacyJob = {
		kind = "humans",
		trigger = "banditKilled",
		category = "Hostile human elimination",
		description = "Hostile human elimination",
		quantities = {5, 9, 15},
	},
	supplies = {},
	rewards = {
		packages = {
			{label = "Pistol ammunition", items = {"9x18", "9x19", "762x25"}},
			{label = "Canned provisions", items = {"food_can_chilibeans"}},
			{label = "Road drinks", items = {"drink_bottlewater"}},
		},
		bonusPackages = {
			{label = "Dollar notes", items = {"value_currency_dollar"}},
		},
		bonusCash = true,
	},
	dialogue = {
		jobBriefing = "There's a little trouble making journeys more expensive than they ought to be. {details}",
		jobReminder = "I'm still waiting to hear that you've dealt with them. {details}",
		jobFinished = "You've made that journey a little less troublesome. And yes, I remember our price.",
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
		["762x51"] = {step = "HG17",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["22lr"] = {step = "HG01",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["357magnum"] = {step = "HG07",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["44magnum"] = {step = "HG07",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["45acp"] = {step = "HG04",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["45acp41"] = {step = "HG14",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["500magnum"] = {step = "HG17",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["556x45"] = {step = "HG10",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x25"] = {step = "HG01",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x39"] = {step = "HG10",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["762x54"] = {step = "HG20",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["9x18"] = {step = "HG01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["9x19"] = {step = "HG04",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["beretta92"] = {step = "HG07",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["brhp"] = {step = "HG04",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["c96"] = {step = "HG08",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["c96carbine"] = {step = "HG13",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["cz52"] = {step = "HG05",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["fort12"] = {step = "HG06",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["g2contender"] = {step = "HG02",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["g2contender500"] = {step = "HG16",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["glock17"] = {step = "HG11",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["lax44"] = {step = "HG25",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["lugerp08"] = {step = "HG09",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["m1911"] = {step = "HG12",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["m1917"] = {step = "HG03",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["makarov"] = {step = "HG04",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["mateba"] = {step = "HG22",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["mosin"] = {step = "HG25",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["mr96"] = {step = "HG17",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["nagantrev"] = {step = "HG01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["obrez"] = {step = "HG15",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["obrezmalfunction"] = {step = "HG16",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["p99"] = {step = "HG09",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["ruger1022"] = {step = "HG13",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["rugermini14"] = {step = "HG19",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["rugermk3"] = {step = "HG07",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["sako85"] = {step = "HG26",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["sako85nato"] = {step = "HG20",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["sako85varmint"] = {step = "HG10",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["sks"] = {step = "HG20",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["sw500"] = {step = "HG23",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["swmodel29"] = {step = "HG18",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["swr8"] = {step = "HG18",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["taurusjudge"] = {step = "HG14",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["taurusragingbull"] = {step = "HG21",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["tokarev"] = {step = "HG02",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["w1895"] = {step = "HG23",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["w9422"] = {step = "HG11",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["w9422357"] = {step = "HG24",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
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
			benefits = {},
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
			stock = {item = "nagantrev", bonus = 1},
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
			plannedUnlocks = {
				-- TODO: Implement barter consumer; verify these proposed terms before enabling.
				{
					id = "haggler/HG04/future",
					provider = "haggler",
					status = "unimplemented",
					kind = "barter",
					name = "lowtiercooker exchange",
					effect = "Permanent multi-input offer; consume inputs each time, enforce equipment tiers and audit resale value.",
					inputs = {
						{
							item = "value_tape_duct",
							quantity = 2,
						},
						{
							item = "value_bolts",
							quantity = 4,
						},
					},
					outputs = {
						{
							item = "lowtiercooker",
							quantity = 1,
						},
					},
				},
			},
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
			benefits = {},
		},
		{
			id = "HG07",
			stock = {item = "22lr", bonus = 1},
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
			stock = {item = "762x25", bonus = 1},
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
			plannedUnlocks = {
				-- TODO: Implement barter consumer; verify these proposed terms before enabling.
				{
					id = "haggler/HG12/future",
					provider = "haggler",
					status = "unimplemented",
					kind = "barter",
					name = "brhp exchange",
					effect = "Permanent multi-input offer; consume inputs each time, enforce equipment tiers and audit resale value.",
					inputs = {
						{
							item = "value_tape_duct",
							quantity = 2,
						},
						{
							item = "value_bolts",
							quantity = 4,
						},
					},
					outputs = {
						{
							item = "brhp",
							quantity = 1,
						},
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
			benefits = {},
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
			stock = {item = "45acp41", bonus = 1},
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
			benefits = {},
		},
		{
			id = "HG19",
			stock = {item = "9x18", bonus = 1},
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
			plannedUnlocks = {
				-- TODO: Implement barter consumer; verify these proposed terms before enabling.
				{
					id = "haggler/HG20/future",
					provider = "haggler",
					status = "unimplemented",
					kind = "barter",
					name = "c96carbine exchange",
					effect = "Permanent multi-input offer; consume inputs each time, enforce equipment tiers and audit resale value.",
					inputs = {
						{
							item = "value_tape_duct",
							quantity = 2,
						},
						{
							item = "value_bolts",
							quantity = 4,
						},
					},
					outputs = {
						{
							item = "c96carbine",
							quantity = 1,
						},
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
			stock = {item = "g2contender", bonus = 1},
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
			benefits = {},
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
