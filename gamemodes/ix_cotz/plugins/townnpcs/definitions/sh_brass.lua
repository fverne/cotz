PLUGIN:Register("brass", {
	name = "'Brass'",
	template = "brassnpc",
	difficultyMultiplier = 2,
	enforceCatalogue = true,
	map = "rp_garbage_cotz",
	courierPools = {
		"valuables_ordnance_salvage",
		"valuables_military_cases",
		"valuables_equipment_pouches",
		"valuables_technical_records",
	},
	job = {
		kind = "none",
		category = "No ordinary repeatable work",
		description = "No ordinary repeatable work",
	},
	retiredRegionalJob = {
		kind = "courier",
		category = "Information courier and return",
		description = "Information courier and return",
	},
	legacyJob = {
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		category = "Ammunition deliveries",
		description = "Ammunition deliveries",
		pools = {"town_ammunition"},
		deliveryTiers = {
			easy = {
				pools = {
					"valuables_equipment_pouches",
				},
				quantity = 1,
			},
			medium = {
				pools = {
					"valuables_military_cases",
				},
				quantity = 1,
			},
			hard = {
				pools = {
					"valuables_ordnance_salvage",
				},
				quantity = 2,
			},
		},
		quantities = {2, 4, 7},
	},
	supplies = {},
	rewards = {
		packages = {
			{label = "Rifle ammunition", items = {"762x39", "762x51"}},
			{label = "Pistol ammunition", items = {"9x19", "45acp"}},
			{label = "Dollar notes", items = {"value_currency_dollar"}},
		},
		bonusPackages = {
			{label = "Specialist ammunition", items = {"762x54ap"}},
		},
		bonusCash = true,
	},
	dialogue = {
		jobBriefing = "We still have that earlier arrangement. {details}",
		jobReminder = "That consignment hasn't been accounted for yet. {details}",
		jobFinished = "That accounts for the consignment. Let's settle what you're owed.",
		delivery = "Set it down. I will check the consignment against the entry.",
		completedGreeting = (
			"Good to see you. An order to discuss, or have you brought something for us to count?"
		),
		workPrompt = "About our earlier consignment.",
		offerPrompt = "Do you have a courier assignment?",
		work = "I haven't got any new runs for you. I'm occupied at the loading bench. If we already have a consignment between us, we can still settle it here.",
		progressionPrompt = "Which part of the depot account needs attention?",
		progression = (
			"I need supplies and the records behind some uncertain consignments. There is no benefit in "
			.. "bringing a convincing explanation without the requested material. We'll begin with work that can "
			.. "be checked here. Where another contact needs an original, deliver it and return. I want the whole "
			.. "movement accounted for."
		),
	},
	catalogue = {
		["762x54ap"] = {step = "BR12",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x54hp"] = {step = "BR11",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x54"] = {step = "BR10",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["44magnumap"] = {step = "BR15",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["44magnumhp"] = {step = "BR14",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["44magnum"] = {step = "BR13",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["45acp"] = {step = "BR02",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["45acpap"] = {step = "BR04",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["45acphp"] = {step = "BR03",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["50ae"] = {step = "BR18",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["50aeap"] = {step = "BR20",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["50aehp"] = {step = "BR19",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["545x39"] = {step = "BR04",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["545x39ap"] = {step = "BR06",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["545x39hp"] = {step = "BR05",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["57x28"] = {step = "BR19",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["57x28ap"] = {step = "BR21",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["57x28hp"] = {step = "BR20",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x25"] = {step = "BR01",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x25ap"] = {step = "BR03",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x25hp"] = {step = "BR02",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x39"] = {step = "BR07",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x39ap"] = {step = "BR09",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x39hp"] = {step = "BR08",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["9x18"] = {step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x18ap"] = {step = "BR11",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["9x18hp"] = {step = "BR10",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["9x19"] = {step = "BR01",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x19ap"] = {step = "BR03",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["9x19hp"] = {step = "BR02",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["9x21"] = {step = "BR14",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["9x21ap"] = {step = "BR16",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["9x21hp"] = {step = "BR15",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
	},
	progression = {
		{
			id = "BR01",
			completionCash = 275,
			name = "Count It Twice",
			kind = "delivery",
			requires = {},
			briefing = (
				"I have a depot request to fill. Read the list; anything outside it will only complicate the "
				.. "count. Bring everything on the list back here; I need the full delivery."
			),
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BR02",
			completionCash = 450,
			name = "The Broken Seal",
			kind = "field",
			objective = (
				"Recover the depot seal register from the assigned search area in Garbage. Bring it back to the "
				.. "issuing contact in Garbage."
			),
			requires = {"BR01"},
			briefing = (
				"I need the packing record behind the broken seal. A damaged fastening doesn't tell us what was "
				.. "counted before it closed. Recover the depot seal register from the assigned search area in "
				.. "Garbage. Bring it back to me in Garbage."
			),
			completion = "The record is here. I'll compare the totals before assigning responsibility.",
			field = {
				description = (
					"A printed packing list on a small clipboard with a metal clip and a circular stamp. Brass's "
					.. "note: \"I need the packing record behind the broken seal.\""
				),
				kind = "recovery",
				map = "rp_garbage_cotz",
				tier = 1,
				cargo = "town_quest_manifest",
				label = "Depot seal register",
			},
			benefits = {},
		},
		{
			id = "BR03",
			stock = {item = "762x25", bonus = 1},
			completionCash = 0,
			name = "Reliable Quantities",
			kind = "tracker",
			requires = {"BR02"},
			briefing = "Continue the supply deliveries. I want completed orders on which to base the next allocation.",
			completion = "A sound beginning. Your deliveries are accounted for.",
			target = 2,
			benefits = {},
		},
		{
			id = "BR04",
			completionCash = 650,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"BR03"},
			briefing = (
				"I have a depot request to fill. Read the list; anything outside it will only complicate the "
				.. "count. Bring everything on the list back here; I need the full delivery."
			),
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BR05",
			completionCash = 575,
			name = "Another Chamber",
			kind = "delivery",
			requires = {"BR03"},
			briefing = (
				"I have a depot request to fill. Read the list; anything outside it will only complicate the "
				.. "count. Bring everything on the list back here; I need the full delivery."
			),
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BR06",
			completionCash = 850,
			name = "The Depot Register",
			kind = "field",
			objective = (
				"Recover the depot inventory from the assigned search area in Garbage. Bring it back to the "
				.. "issuing contact in Garbage."
			),
			requires = {"BR04"},
			briefing = (
				"I need the depot inventory. People have been quoting totals without bringing the page they read "
				.. "them from. Recover the depot inventory from the assigned search area in Garbage. Bring it back to "
				.. "me in Garbage."
			),
			completion = "Thank you. Now I can count against the original entry.",
			field = {
				description = (
					"A clipboard carrying a densely printed packing list and a stamped mark. Brass's note: \"I need "
					.. "the depot inventory.\""
				),
				kind = "recovery",
				map = "rp_garbage_cotz",
				tier = 1,
				cargo = "town_quest_receipt",
				label = "depot inventory",
			},
			benefits = {},
		},
		{
			id = "BR07",
			stock = {item = "762x25ap", bonus = 1},
			completionCash = 0,
			name = "Not One Round Short",
			kind = "tracker",
			requires = {"BR05"},
			briefing = "Keep the supply orders moving. Check the requested goods rather than guessing from the category.",
			completion = "Another run completed. The account has been straightforward.",
			target = 5,
			benefits = {},
		},
		{
			id = "BR08",
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = "Permanent offer for 12gauge; consume inputs each time, enforce equipment tiers and audit resale value.",
					id = "brass/BR08/future",
					inputs = {
						{
							item = "value_capacitors",
							quantity = 1,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: 12gauge",
					outputs = {
						{
							item = "12gauge",
							quantity = 1,
						},
					},
					provider = "brass",
					status = "unimplemented",
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
			requires = {"BR06"},
			briefing = (
				"I have a depot request to fill. Read the list; anything outside it will only complicate the "
				.. "count. Bring everything on the list back here; I need the full delivery."
			),
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BR09",
			completionCash = 875,
			name = "Shot and Shell",
			kind = "delivery",
			requires = {"BR07"},
			briefing = (
				"I have a depot request to fill. Read the list; anything outside it will only complicate the "
				.. "count. Bring everything on the list back here; I need the full delivery."
			),
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BR10",
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = "Permanent offer for 22lr; consume inputs each time, enforce equipment tiers and audit resale value.",
					id = "brass/BR10/future",
					inputs = {
						{
							item = "value_capacitors",
							quantity = 1,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: 22lr",
					outputs = {
						{
							item = "22lr",
							quantity = 1,
						},
					},
					provider = "brass",
					status = "unimplemented",
				},
			},
			completionCash = 1250,
			name = "The Supplier's Stamp",
			kind = "field",
			objective = (
				"Recover the supplier papers for Latch from the assigned search area in Garbage. Deliver it to "
				.. "'Latch' in Garbage, then come back to the issuing contact in Garbage."
			),
			requires = {"BR08"},
			briefing = (
				"Latch needs the supplier paperwork. He can check the part details more usefully than I can repeat "
				.. "them. Recover the supplier papers for Latch from the assigned search area in Garbage. Deliver it "
				.. "to 'Latch' in Garbage, then come back to me in Garbage."
			),
			completion = "He has the papers. That should settle which specification we're discussing.",
			field = {
				description = (
					"A creased printed letter with a corporate mark and several small blocks of text. Brass's note: "
					.. "\"Latch needs the supplier paperwork.\""
				),
				kind = "recovery",
				map = "rp_garbage_cotz",
				tier = 2,
				cargo = "town_quest_contract",
				label = "Supplier papers for Latch",
				recipient = "latch",
			},
			benefits = {},
		},
		{
			id = "BR11",
			stock = {item = "762x25hp", bonus = 1},
			completionCash = 0,
			name = "Enough for the Shift",
			kind = "tracker",
			requires = {"BR09"},
			briefing = "More delivery work when you're ready. I need quantities I can verify.",
			completion = "You've kept a reliable account. That makes the next promise easier to judge.",
			target = 9,
			benefits = {},
		},
		{
			id = "BR12",
			completionCash = 1450,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"BR10"},
			briefing = (
				"I have a depot request to fill. Read the list; anything outside it will only complicate the "
				.. "count. Bring everything on the list back here; I need the full delivery."
			),
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BR13",
			completionCash = 1175,
			name = "Rifle Stock",
			kind = "delivery",
			requires = {"BR11"},
			briefing = (
				"I have a depot request to fill. Read the list; anything outside it will only complicate the "
				.. "count. Bring everything on the list back here; I need the full delivery."
			),
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BR14",
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = "Permanent offer for 9x18; consume inputs each time, enforce equipment tiers and audit resale value.",
					id = "brass/BR14/future",
					inputs = {
						{
							item = "value_capacitors",
							quantity = 1,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: 9x18",
					outputs = {
						{
							item = "9x18",
							quantity = 1,
						},
					},
					provider = "brass",
					status = "unimplemented",
				},
			},
			completionCash = 1650,
			name = "The Military Manifest",
			kind = "field",
			objective = (
				"Recover the military depot manifest from the assigned search area in Waystation. Deliver it to "
				.. "'Quartermaster' in Waystation, then come back to the issuing contact in Garbage."
			),
			requires = {"BR12"},
			briefing = (
				"Quartermaster needs the military supply record. A usable account matters more than a reassuring "
				.. "summary. Recover the military depot manifest from the assigned search area in Waystation. Deliver "
				.. "it to 'Quartermaster' in Waystation, then come back to me in Garbage."
			),
			completion = "He has the manifest. We can each check our side without borrowing a memory.",
			field = {
				description = (
					"A buff-coloured document folder with printed sheets protruding at uneven angles. Brass's note: "
					.. "\"Quartermaster needs the military supply record.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_military",
				label = "Military depot manifest",
				recipient = "quartermaster",
			},
			benefits = {},
		},
		{
			id = "BR15",
			stock = {item = "9x18", bonus = 1},
			completionCash = 0,
			name = "A Working Depot",
			kind = "tracker",
			requires = {"BR13"},
			briefing = "Continue bringing the requested supplies. Consistency matters after the introduction as well.",
			completion = "A substantial amount of work now. Thank you for keeping it checkable.",
			target = 14,
			benefits = {},
		},
		{
			id = "BR16",
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = "Permanent offer for 9x19; consume inputs each time, enforce equipment tiers and audit resale value.",
					id = "brass/BR16/future",
					inputs = {
						{
							item = "value_capacitors",
							quantity = 2,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: 9x19",
					outputs = {
						{
							item = "9x19",
							quantity = 1,
						},
					},
					provider = "brass",
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
			requires = {"BR14"},
			briefing = (
				"I have a depot request to fill. Read the list; anything outside it will only complicate the "
				.. "count. Bring everything on the list back here; I need the full delivery."
			),
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BR17",
			stock = {item = "9x18ap", bonus = 1},
			completionCash = 1475,
			name = "Specialist Loads",
			kind = "delivery",
			requires = {"BR15"},
			briefing = (
				"I have a depot request to fill. Read the list; anything outside it will only complicate the "
				.. "count. Bring everything on the list back here; I need the full delivery."
			),
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BR18",
			stock = {item = "9x18hp", bonus = 1},
			completionCash = 2050,
			name = "The Pripyat Consignment",
			kind = "field",
			objective = (
				"Recover the Pripyat consignment case from the assigned search area in Pripyat. Bring it back to "
				.. "the issuing contact in Garbage."
			),
			requires = {"BR16"},
			briefing = (
				"The sealed consignment is still out in Pripyat. Bring the case as it is; the inspection can wait "
				.. "until it's here. Recover the Pripyat consignment case from the assigned search area in Pripyat. "
				.. "Bring it back to me in Garbage."
			),
			completion = "Case received. Give me room to check the fastenings.",
			field = {
				description = (
					"A low hard case with long contrasting strips across its ribbed lid. Brass's note: \"The sealed "
					.. "consignment is still out in Pripyat.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_equipment",
				label = "Pripyat consignment case",
			},
			benefits = {},
		},
		{
			id = "BR19",
			stock = {item = "9x19", bonus = 1},
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = "Permanent offer for 545x39; consume inputs each time, enforce equipment tiers and audit resale value.",
					id = "brass/BR19/future",
					inputs = {
						{
							item = "value_capacitors",
							quantity = 2,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: 545x39",
					outputs = {
						{
							item = "545x39",
							quantity = 1,
						},
					},
					provider = "brass",
					status = "unimplemented",
				},
			},
			completionCash = 0,
			name = "Supply Under Pressure",
			kind = "tracker",
			requires = {"BR17"},
			briefing = "Keep filling the supply orders while I reconcile the recovered records.",
			completion = "I've been able to rely on those returns. That is worth more than a persuasive estimate.",
			target = 20,
			benefits = {},
		},
		{
			id = "BR20",
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = "Permanent offer for 556x45; consume inputs each time, enforce equipment tiers and audit resale value.",
					id = "brass/BR20/future",
					inputs = {
						{
							item = "value_capacitors",
							quantity = 2,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: 556x45",
					outputs = {
						{
							item = "556x45",
							quantity = 1,
						},
					},
					provider = "brass",
					status = "unimplemented",
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
			requires = {"BR18"},
			briefing = (
				"I have a depot request to fill. Read the list; anything outside it will only complicate the "
				.. "count. Bring everything on the list back here; I need the full delivery."
			),
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BR21",
			completionCash = 1775,
			name = "Rounds in Reserve",
			kind = "delivery",
			requires = {"BR19", "BR20"},
			briefing = (
				"I have a depot request to fill. Read the list; anything outside it will only complicate the "
				.. "count. Bring everything on the list back here; I need the full delivery."
			),
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_garbage_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_4",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BR22",
			stock = {item = "9x19ap", bonus = 1},
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = "Permanent offer for 762x39; consume inputs each time, enforce equipment tiers and audit resale value.",
					id = "brass/BR22/future",
					inputs = {
						{
							item = "value_capacitors",
							quantity = 3,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: 762x39",
					outputs = {
						{
							item = "762x39",
							quantity = 1,
						},
					},
					provider = "brass",
					status = "unimplemented",
				},
			},
			completionCash = 2450,
			name = "The Final Receipt",
			kind = "field",
			objective = (
				"Recover the final freight receipt from the assigned search area in Garbage. Bring it back to the "
				.. "issuing contact in Garbage."
			),
			requires = {"BR21"},
			briefing = (
				"I want the last freight entry. I'd rather keep an account open a little longer than close it "
				.. "against an assumed receipt. Recover the final freight receipt from the assigned search area in "
				.. "Garbage. Bring it back to me in Garbage."
			),
			completion = "There it is. I'll reconcile the remaining entries against it.",
			field = {
				description = (
					"A clipboard carrying a densely printed packing list and a stamped mark. Brass's note: \"I want "
					.. "the last freight entry.\""
				),
				kind = "recovery",
				map = "rp_garbage_cotz",
				tier = 2,
				cargo = "town_quest_receipt",
				label = "Final freight receipt",
			},
			benefits = {},
		},
		{
			id = "BR23",
			stock = {item = "9x19hp", bonus = 1},
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = "Permanent offer for 762x54; consume inputs each time, enforce equipment tiers and audit resale value.",
					id = "brass/BR23/future",
					inputs = {
						{
							item = "value_capacitors",
							quantity = 3,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: 762x54",
					outputs = {
						{
							item = "762x54",
							quantity = 1,
						},
					},
					provider = "brass",
					status = "unimplemented",
				},
			},
			completionCash = 0,
			name = "Every Box Accounted For",
			kind = "tracker",
			requires = {"BR22"},
			briefing = "There are further supply orders to complete. Keep checking them with the same care.",
			completion = "You've stayed reliable across a long account. I appreciate it. No qualification attached.",
			target = 27,
			benefits = {},
		},
		{
			id = "BR24",
			stock = {item = "9x21", bonus = 1},
			completionCash = 2650,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"BR23"},
			briefing = (
				"I have a depot request to fill. Read the list; anything outside it will only complicate the "
				.. "count. Bring everything on the list back here; I need the full delivery."
			),
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_garbage_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_4",
					quantity = 1,
				},
			},
			benefits = {},
			recognition = "Brass's trusted contact",
		},
	},
})
