PLUGIN:Register("jitters", {
	name = "'Jitters'",
	template = "medicnpc",
	difficultyMultiplier = 1.5,
	enforceCatalogue = true,
	map = "rp_marsh_cs",
	job = {
		kind = "regionalSpecimens",
		category = "Specific mutant specimens",
		description = "Specific mutant specimens",
		maps = {
			easy = "rp_marsh_cs",
			medium = "rp_garbage_cotz",
			hard = "rp_waystation",
		},
	},
	legacyJob = {
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		category = "Medical supply deliveries",
		description = "Medical supply deliveries",
		pools = {"town_medical"},
		deliveryTiers = {
			easy = {
				pools = {
					"valuables_clinical_supplies",
				},
				quantity = 1,
			},
			medium = {
				pools = {
					"valuables_trauma_supplies",
					"valuables_medical_equipment",
				},
				quantity = 1,
			},
			hard = {
				pools = {
					"valuables_research_injectors_a",
					"valuables_research_injectors_b",
				},
				quantity = 2,
			},
		},
		quantities = {2, 4, 7},
	},
	supplies = {},
	rewards = {
		packages = {
			{label = "Bleeding control",
				items = {"medic_bandage_1", "medic_bandage_2", "medic_bandage_3"}},
			{label = "Trauma supplies",
				items = {"medic_medkit_1", "medic_medkit_2", "drug_painkillers"}},
			{label = "Exposure treatment",
				items = {"medic_antirad_1", "medic_antirad_2"}},
		},
	},
	dialogue = {
		delivery = "Here, here. Let me check the label before you go.",
		completedGreeting = (
			"Oh, hello. No fresh injuries, I hope? It's nice when somebody visits and I can finish a "
			.. "sentence before reaching for something."
		),
		workPrompt = "About the mutant specimens I'm collecting.",
		offerPrompt = "Do you need mutant specimens?",
		work = "I need mutant specimens to examine. Bring the exact part and number on the request, and please keep them separate from the rest of your pack. Check the suggested region before you leave. I'd much rather have a specimen to look at than another patient because I made the request sound hurried.",
		progressionPrompt = "What needs checking for the clinic?",
		progression = (
			"I'm comparing the exposure accounts as well as trying to keep the clinic supplied. There are "
			.. "ordinary requests and records to recover. Choose something you can prepare for; I don't want "
			.. "another patient because I made the order sound hurried. If another contact needs the record, "
			.. "deliver it and come back. We'll examine the uncertainty somewhere quiet."
		),
	},
	catalogue = {
		["drug_cigar"] = {step = "JT19",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drug_cigarette_1"] = {step = "JT01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drug_cigarette_2"] = {step = "JT03",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drug_cigarette_3"] = {step = "JT09",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drug_cigarette_4"] = {step = "JT16",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drug_cigarette_5"] = {step = "JT13",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drug_cigarette_6"] = {step = "JT21",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drug_mints"] = {step = "JT06",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["drug_painkillers"] = {step = "JT11",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["drug_tobacco_1"] = {step = "JT23",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["drug_tobacco_2"] = {step = "JT26",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["medic_antirad_1"] = {step = "JT01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["medic_bandage_1"] = {step = "JT01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_1"] = {step = "JT01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_2"] = {step = "JT26",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
	},
	progression = {
		{
			id = "JT01",
			completionCash = 275,
			name = "Clean Hands",
			kind = "delivery",
			requires = {},
			briefing = (
				"I need to replenish the medical supplies. Look at the list before packing; I have enough things "
				.. "to sort when someone actually needs treatment. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Thank you. Put those here so I can check them and clear some room.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "JT02",
			completionCash = 450,
			name = "The Empty Cabinet",
			kind = "field",
			objective = (
				"Recover the aid-station inventory journal from the assigned search area in Marsh. Bring it back "
				.. "to the issuing contact in Marsh."
			),
			requires = {"JT01"},
			briefing = (
				"I'd like the aid-station inventory recovered. Before I decide what was missing, I need to know "
				.. "what they thought they had. Recover the aid-station inventory journal from the assigned search "
				.. "area in Marsh. Bring it back to me in Marsh."
			),
			completion = "Thank you. I'll read it before trying to reconstruct the shelves in my head.",
			field = {
				description = (
					"A blue-green folder with medical record sheets protruding from its cover. Jitters's note: \"I'd "
					.. "like the aid-station inventory recovered.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_clinic",
				label = "Aid-station inventory journal",
			},
			benefits = {},
		},
		{
			id = "JT03",
			stock = {item = "medic_bandage_1", bonus = 1},
			completionCash = 0,
			name = "Keep the Shelves Filled",
			kind = "tracker",
			requires = {"JT02"},
			briefing = (
				"Continue the medical supply deliveries. I want the regular requests filled alongside the "
				.. "recovered cases."
			),
			completion = "A useful start. There's a little less I have to keep in my head now.",
			target = 2,
			benefits = {},
		},
		{
			id = "JT04",
			stock = {item = "drug_cigarette_1", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Permanent offer for medic_bandage_1; consume inputs each time, enforce equipment "
						.. "tiers and audit resale value."
					),
					id = "jitters/JT04/future",
					inputs = {
						{
							item = "value_tape_duct",
							quantity = 1,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: medic_bandage_1",
					outputs = {
						{
							item = "medic_bandage_1",
							quantity = 1,
						},
					},
					provider = "jitters",
					status = "unimplemented",
				},
			},
			completionCash = 650,
			name = "A small delivery",
			kind = "delivery",
			retiredCommission = true,
			objective = "Bring all 1 listed item type to this contact. The request shows each selected item and required units.",
			requires = {"JT03"},
			briefing = (
				"I need to replenish the medical supplies. Look at the list before packing; I have enough things "
				.. "to sort when someone actually needs treatment. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Thank you. Put those here so I can check them and clear some room.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 1,
				},
			},
		},
		{
			id = "JT05",
			completionCash = 575,
			name = "A Proper Dressing",
			kind = "delivery",
			requires = {"JT03"},
			briefing = (
				"I need to replenish the medical supplies. Look at the list before packing; I have enough things "
				.. "to sort when someone actually needs treatment. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Thank you. Put those here so I can check them and clear some room.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "JT06",
			completionCash = 850,
			name = "The Exposure Log",
			kind = "field",
			objective = (
				"Recover the field exposure observations from the assigned search area in Marsh. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"JT04"},
			briefing = (
				"I'd like the patient observations from the shelter. A remembered symptom isn't always remembered "
				.. "at the right point in the account. Recover the field exposure observations from the assigned "
				.. "search area in Marsh. Bring it back to me in Marsh."
			),
			completion = "Here. I'll compare the entries without trying to diagnose a page at a glance.",
			field = {
				description = (
					"A blue-green records folder with loose printed sheets and a marked cover. Jitters's note: \"I'd "
					.. "like the patient observations from the shelter.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_clinic2",
				label = "Field exposure observations",
			},
			benefits = {},
		},
		{
			id = "JT07",
			stock = {item = "drug_cigarette_2", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Permanent offer for drug_painkillers; consume inputs each time, enforce equipment "
						.. "tiers and audit resale value."
					),
					id = "jitters/JT07/future",
					inputs = {
						{
							item = "value_tape_duct",
							quantity = 1,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: drug_painkillers",
					outputs = {
						{
							item = "drug_painkillers",
							quantity = 1,
						},
					},
					provider = "jitters",
					status = "unimplemented",
				},
			},
			completionCash = 0,
			name = "A Steady Clinic",
			kind = "tracker",
			requires = {"JT05"},
			briefing = "More medical orders when you're prepared. Check the requested supplies before leaving.",
			completion = "Another steady run. Thank you for keeping the returns straightforward.",
			target = 5,
		},
		{
			id = "JT08",
			completionCash = 1050,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"JT06"},
			briefing = (
				"I need to replenish the medical supplies. Look at the list before packing; I have enough things "
				.. "to sort when someone actually needs treatment. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Thank you. Put those here so I can check them and clear some room.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
			discounts = {{npc = "'Jitters'", service = "treatment", fraction = 0.05}},
		},
		{
			id = "JT09",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Permanent offer for medic_medkit_1; consume inputs each time, enforce equipment "
						.. "tiers and audit resale value."
					),
					id = "jitters/JT09/future",
					inputs = {
						{
							item = "value_tape_duct",
							quantity = 1,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: medic_medkit_1",
					outputs = {
						{
							item = "medic_medkit_1",
							quantity = 1,
						},
					},
					provider = "jitters",
					status = "unimplemented",
				},
			},
			completionCash = 875,
			name = "Fever and Fallout",
			kind = "delivery",
			requires = {"JT07"},
			briefing = (
				"I need to replenish the medical supplies. Look at the list before packing; I have enough things "
				.. "to sort when someone actually needs treatment. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Thank you. Put those here so I can check them and clear some room.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 1,
				},
			},
		},
		{
			id = "JT10",
			stock = {item = "drug_mints", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Permanent offer for medic_antirad_1; consume inputs each time, enforce equipment "
						.. "tiers and audit resale value."
					),
					id = "jitters/JT10/future",
					inputs = {
						{
							item = "value_tape_duct",
							quantity = 2,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: medic_antirad_1",
					outputs = {
						{
							item = "medic_antirad_1",
							quantity = 1,
						},
					},
					provider = "jitters",
					status = "unimplemented",
				},
			},
			completionCash = 1250,
			name = "The Contaminated Batch",
			kind = "field",
			objective = (
				"Recover the suspect batch evidence from the assigned search area in Garbage. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"JT08"},
			briefing = (
				"Bring the batch evidence back sealed. I need to check the account before deciding what the "
				.. "contamination claim supports. Recover the suspect batch evidence from the assigned search area in "
				.. "Garbage. Bring it back to me in Marsh."
			),
			completion = "Leave it apart from the supplies. I'll examine the records first.",
			field = {
				description = (
					"A long tinted research tube with dark caps at both ends. Jitters's note: \"Bring the batch "
					.. "evidence back sealed.\""
				),
				kind = "recovery",
				map = "rp_garbage_cotz",
				tier = 2,
				cargo = "town_quest_tube",
				label = "Suspect batch evidence",
			},
		},
		{
			id = "JT11",
			stock = {item = "drug_cigarette_3", bonus = 1},
			completionCash = 0,
			name = "The Long Queue",
			kind = "tracker",
			requires = {"JT09"},
			briefing = "Keep filling the medical supply requests while I compare the observations.",
			completion = "You've kept the supplies moving. I've had more time to look at the actual cases.",
			target = 9,
			benefits = {},
		},
		{
			id = "JT12",
			stock = {item = "drug_painkillers", bonus = 1},
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Permanent offer for medic_bandage_2; consume inputs each time, enforce equipment "
						.. "tiers and audit resale value."
					),
					id = "jitters/JT12/future",
					inputs = {
						{
							item = "value_tape_duct",
							quantity = 2,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: medic_bandage_2",
					outputs = {
						{
							item = "medic_bandage_2",
							quantity = 1,
						},
					},
					provider = "jitters",
					status = "unimplemented",
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
			requires = {"JT10"},
			briefing = (
				"I need to replenish the medical supplies. Look at the list before packing; I have enough things "
				.. "to sort when someone actually needs treatment. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Thank you. Put those here so I can check them and clear some room.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "JT13",
			completionCash = 1175,
			name = "Better Instruments",
			kind = "delivery",
			requires = {"JT11"},
			briefing = (
				"I need to replenish the medical supplies. Look at the list before packing; I have enough things "
				.. "to sort when someone actually needs treatment. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Thank you. Put those here so I can check them and clear some room.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "JT14",
			stock = {item = "medic_medkit_1", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Permanent offer for medic_medkit_2; consume inputs each time, enforce equipment "
						.. "tiers and audit resale value."
					),
					id = "jitters/JT14/future",
					inputs = {
						{
							item = "value_tape_duct",
							quantity = 2,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: medic_medkit_2",
					outputs = {
						{
							item = "medic_medkit_2",
							quantity = 1,
						},
					},
					provider = "jitters",
					status = "unimplemented",
				},
			},
			completionCash = 1650,
			name = "A Second Opinion",
			kind = "field",
			objective = (
				"Recover the exposure research note from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"JT12"},
			briefing = (
				"I'd like another research note to compare. Two similar cases can be terribly persuasive until you "
				.. "check what differed. Recover the exposure research note from the assigned search area in Marsh. "
				.. "Bring it back to me in Marsh."
			),
			completion = "That's useful. Let me put the accounts beside each other before I begin agreeing with them.",
			field = {
				description = (
					"A blue laboratory folder with loose printed record sheets extending from its edges. Jitters's "
					.. "note: \"I'd like another research note to compare.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_lab",
				label = "Exposure research note",
			},
		},
		{
			id = "JT15",
			stock = {item = "drug_cigarette_5", bonus = 1},
			completionCash = 0,
			name = "Cases From Outside",
			kind = "tracker",
			requires = {"JT13"},
			briefing = "Continue the supply work. Your own return kit still matters after filling the order.",
			completion = "A considerable amount brought through. I haven't taken that for granted.",
			target = 14,
			benefits = {},
		},
		{
			id = "JT16",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Permanent offer for medic_bandage_3; consume inputs each time, enforce equipment "
						.. "tiers and audit resale value."
					),
					id = "jitters/JT16/future",
					inputs = {
						{
							item = "value_tape_duct",
							quantity = 3,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: medic_bandage_3",
					outputs = {
						{
							item = "medic_bandage_3",
							quantity = 1,
						},
					},
					provider = "jitters",
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
			requires = {"JT14"},
			briefing = (
				"I need to replenish the medical supplies. Look at the list before packing; I have enough things "
				.. "to sort when someone actually needs treatment. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Thank you. Put those here so I can check them and clear some room.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_3",
					quantity = 1,
				},
			},
		},
		{
			id = "JT17",
			completionCash = 1475,
			name = "For the Journey",
			kind = "delivery",
			requires = {"JT15"},
			briefing = (
				"I need to replenish the medical supplies. Look at the list before packing; I have enough things "
				.. "to sort when someone actually needs treatment. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Thank you. Put those here so I can check them and clear some room.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "JT18",
			stock = {item = "drug_cigarette_4", bonus = 1},
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Permanent offer for medic_medkit_3; consume inputs each time, enforce equipment "
						.. "tiers and audit resale value."
					),
					id = "jitters/JT18/future",
					inputs = {
						{
							item = "value_tape_duct",
							quantity = 3,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: medic_medkit_3",
					outputs = {
						{
							item = "medic_medkit_3",
							quantity = 1,
						},
					},
					provider = "jitters",
					status = "unimplemented",
				},
			},
			completionCash = 2050,
			name = "The Field Ward",
			kind = "field",
			objective = (
				"Recover the field treatment log for Wake from the assigned search area in Marsh. Deliver it to "
				.. "'Wake' in Garbage, then come back to the issuing contact in Marsh."
			),
			requires = {"JT16"},
			briefing = (
				"Wake should have the field ward's log. There may be a useful detail about the people that I'd "
				.. "overlook concentrating on treatment. Recover the field treatment log for Wake from the assigned "
				.. "search area in Marsh. Deliver it to 'Wake' in Garbage, then come back to me in Marsh."
			),
			completion = (
				"She has it. Good. She should have the account without waiting for me to finish every clinical "
				.. "question."
			),
			field = {
				description = (
					"A blue-green folder with medical record sheets protruding from its cover. Jitters's note: \"Wake "
					.. "should have the field ward's log.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_clinic",
				label = "Field treatment log for Wake",
				recipient = "wake",
			},
			benefits = {},
		},
		{
			id = "JT19",
			stock = {item = "medic_antirad_1", bonus = 1},
			completionCash = 0,
			name = "Ready for Returns",
			kind = "tracker",
			requires = {"JT17"},
			briefing = "There are more medical requests to complete. Keep the supplies together and the labels readable.",
			completion = "You've stayed dependable. It helps to have a thing I don't need to worry about quite so much.",
			target = 20,
			benefits = {},
		},
		{
			id = "JT20",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Permanent offer for medic_antirad_2; consume inputs each time, enforce equipment "
						.. "tiers and audit resale value."
					),
					id = "jitters/JT20/future",
					inputs = {
						{
							item = "value_tape_duct",
							quantity = 3,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: medic_antirad_2",
					outputs = {
						{
							item = "medic_antirad_2",
							quantity = 1,
						},
					},
					provider = "jitters",
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
			requires = {"JT18"},
			briefing = (
				"I need to replenish the medical supplies. Look at the list before packing; I have enough things "
				.. "to sort when someone actually needs treatment. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Thank you. Put those here so I can check them and clear some room.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_3",
					quantity = 1,
				},
			},
		},
		{
			id = "JT21",
			completionCash = 1775,
			name = "Comparing the Cases",
			kind = "delivery",
			requires = {"JT19"},
			briefing = (
				"I need to replenish the medical supplies. Look at the list before packing; I have enough things "
				.. "to sort when someone actually needs treatment. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Thank you. Put those here so I can check them and clear some room.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "JT22",
			stock = {item = "drug_cigar", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Permanent offer for medic_medkit_4; consume inputs each time, enforce equipment "
						.. "tiers and audit resale value."
					),
					id = "jitters/JT22/future",
					inputs = {
						{
							item = "value_tape_duct",
							quantity = 4,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: medic_medkit_4",
					outputs = {
						{
							item = "medic_medkit_4",
							quantity = 1,
						},
					},
					provider = "jitters",
					status = "unimplemented",
				},
			},
			completionCash = 2450,
			name = "The Patient's Route",
			kind = "field",
			objective = (
				"Recover the last exposure survey record from the assigned search area in Pripyat. Bring it back "
				.. "to the issuing contact in Marsh."
			),
			requires = {"JT20"},
			briefing = (
				"Recover the expedition's later exposure record. I'd rather compare the sequence than select the "
				.. "reading that suits my worry. Recover the last exposure survey record from the assigned search "
				.. "area in Pripyat. Bring it back to me in Marsh."
			),
			completion = (
				"Let me put it with the observations. I'll check the dates before the figures start looking like "
				.. "an answer."
			),
			field = {
				description = (
					"A flat dark electronic module marked with a number and three pale bars. Jitters's note: \"Recover "
					.. "the expedition's later exposure record.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module2",
				label = "Last exposure survey record",
			},
		},
		{
			id = "JT23",
			stock = {item = "drug_cigarette_6", bonus = 1},
			completionCash = 0,
			name = "Still Taking Patients",
			kind = "tracker",
			requires = {"JT21", "JT22"},
			briefing = "Keep the medical deliveries going when you're ready for another trip.",
			completion = (
				"You've given the clinic steady attention. Thank you. I should probably stop and say that before I "
				.. "find another shelf to count."
			),
			target = 27,
			benefits = {},
		},
		{
			id = "JT24",
			completionCash = 2650,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"JT23"},
			briefing = (
				"I need to replenish the medical supplies. Look at the list before packing; I have enough things "
				.. "to sort when someone actually needs treatment. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Thank you. Put those here so I can check them and clear some room.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_medical_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_4",
					quantity = 1,
				},
			},
			benefits = {},
			discounts = {{npc = "'Jitters'", service = "treatment", fraction = 0.1}},
		},
		{
			id = "JT25",
			stock = {item = "drug_tobacco_1", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Permanent offer for medic_medkit_5; consume inputs each time, enforce equipment "
						.. "tiers and audit resale value."
					),
					id = "jitters/JT25/future",
					inputs = {
						{
							item = "value_tape_duct",
							quantity = 4,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: medic_medkit_5",
					outputs = {
						{
							item = "medic_medkit_5",
							quantity = 1,
						},
					},
					provider = "jitters",
					status = "unimplemented",
				},
			},
			completionCash = 2000,
			name = "A Clinic That Holds",
			kind = "delivery",
			requires = {"JT24"},
			briefing = (
				"I need to replenish the medical supplies. Look at the list before packing; I have enough things "
				.. "to sort when someone actually needs treatment. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Thank you. Put those here so I can check them and clear some room.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_medical_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_4",
					quantity = 1,
				},
			},
		},
		{
			id = "JT26",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement supplyExchange consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Permanent offer for medic_medkit_6; consume inputs each time, enforce equipment "
						.. "tiers and audit resale value."
					),
					id = "jitters/JT26/future",
					inputs = {
						{
							item = "value_tape_duct",
							quantity = 4,
						},
					},
					kind = "supplyExchange",
					name = "Standing exchange: medic_medkit_6",
					outputs = {
						{
							item = "medic_medkit_6",
							quantity = 1,
						},
					},
					provider = "jitters",
					status = "unimplemented",
				},
			},
			completionCash = 2850,
			name = "The Case Closed",
			kind = "field",
			objective = (
				"Recover the final exposure identification file from the assigned search area in Marsh. Bring it "
				.. "back to the issuing contact in Marsh."
			),
			requires = {"JT25"},
			briefing = (
				"The identifying papers need to stay together. I don't want to fill a gap by guessing because a "
				.. "page went missing on the way home. Recover the final exposure identification file from the "
				.. "assigned search area in Marsh. Bring it back to me in Marsh."
			),
			completion = (
				"You've given me time to look properly instead of trying to remember everything at once. I "
				.. "appreciate that more than I've probably managed to say. Sit down. We can talk without me handing "
				.. "you another list."
			),
			field = {
				description = (
					"A cardboard file folder with an emblem and printed wording on the front. Jitters's note: \"The "
					.. "identifying papers need to stay together.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_personnel",
				label = "Final exposure identification file",
			},
			recognition = "Jitters's trusted contact",
		},
	},
})
