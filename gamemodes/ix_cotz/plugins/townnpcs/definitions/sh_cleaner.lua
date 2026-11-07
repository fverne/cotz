PLUGIN:Register("cleaner", {
	name = "'Cleaner'",
	template = "owlnpc",
	difficultyMultiplier = 3,
	enforceCatalogue = true,
	map = "rp_garbage_cotz",
	courierPools = {
		"valuables_cleaning_supplies",
		"valuables_cutting_tools",
		"valuables_secured_cases",
		"valuables_flash_media",
	},
	job = {
		kind = "deadDrop",
		category = "Dead-drop circuits",
		description = "Dead-drop circuits",
		maps = {
			easy = "rp_garbage_cotz",
			medium = "rp_garbage_cotz",
			hard = "rp_waystation",
		},
	},
	legacyJob = {
		kind = "deadDrop",
		category = "Dead-drop circuits",
		description = "Dead-drop circuits",
		maps = {
			easy = "rp_garbage_cotz",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {},
	rewards = {
		packages = {
			{label = "Digging tools", items = {"hidestasher_cutlery"}},
			{label = "Cache tools", items = {"hidestasher_cleaningkit"}},
			{label = "Canned provisions", items = {"food_can_beans"}},
		},
		bonusPackages = {
			{label = "Swamps stash", items = {"hidestash_1"}},
			{label = "Waystation stash", items = {"hidestash_2"}},
			{label = "Pripyat stash", items = {"hidestash_3"}},
		},
	},
	dialogue = {
		jobBriefing = "Apparently everyone remembers who carries things except the person who actually has to carry them. {details}",
		jobReminder = "I still need that parcel moved. {details}",
		jobFinished = "Buried where it belongs? Good. One less thing left for me to chase up.",
		delivery = "Leave it here. Keep it closed.",
		completedGreeting = (
			"You're here. Good. We can spare ourselves the usual discussion about whether instructions "
			.. "need following."
		),
		workPrompt = "About the circuit I'm carrying.",
		offerPrompt = "Do you have a parcel circuit?",
		work = (
			"Collect the sealed parcel at the assigned pickup. Deliver it to the assigned cache. Come back "
			.. "after finishing the delivery. Read both endpoints before accepting, and leave the package shut. If "
			.. "you want to know whether that is all the arrangement requires, yes. That's why I wrote it down."
		),
		progressionPrompt = "What else needs checking in the deliveries?",
		progression = (
			"Some drops need checking and some records need recovering. The order gives the movement and the "
			.. "return. Follow that. If another contact is receiving a file, give them the file; don't explain it "
			.. "in place of delivering it. We can discuss a particular assignment once you've read it."
		),
	},
	catalogue = {
		["ak74"] = {step = "CL20",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["akm"] = {step = "CL27",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["aks74u"] = {step = "CL14",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["ar159mm"] = {step = "CL24",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["deagle"] = {step = "CL15",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["deagle44"] = {step = "CL16",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["fiveseven"] = {step = "CL22",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["gepardpdw"] = {step = "CL18",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["glock18"] = {step = "CL06",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["kiparis"] = {step = "CL04",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["kp31"] = {step = "CL11",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["m1911chic"] = {step = "CL28",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["m1928"] = {step = "CL25",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["mac11"] = {step = "CL03",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["mp18"] = {step = "CL09",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["mp34"] = {step = "CL05",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["mp40"] = {step = "CL07",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["mp5"] = {step = "CL15",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["mp5k"] = {step = "CL10",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["mp9a1"] = {step = "CL13",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["p90"] = {step = "CL26",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["pp19"] = {step = "CL20",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["pp1901vityaz"] = {step = "CL23",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["pp2000"] = {step = "CL17",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["ppsh"] = {step = "CL02",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["saigasemi545"] = {step = "CL21",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["skorpion"] = {step = "CL04",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["sr2"] = {step = "CL25",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["stechaps"] = {step = "CL08",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["sten"] = {step = "CL01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["sterling"] = {step = "CL12",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["ump45"] = {step = "CL19",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["uzi"] = {step = "CL09",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
	},
	progression = {
		{
			id = "CL01",
			completionCash = 275,
			name = "A Package That Stays Shut",
			kind = "delivery",
			requires = {},
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "CL02",
			completionCash = 450,
			name = "The Unattended Drop",
			kind = "field",
			objective = (
				"Recover the first sealed drop parcel from the assigned search area in Garbage. Bring it back to "
				.. "the issuing contact in Garbage."
			),
			requires = {"CL01"},
			briefing = (
				"A sealed parcel needs moving between the assigned drops. Read both ends before you take "
				.. "possession. Recover the first sealed drop parcel from the assigned search area in Garbage. Bring "
				.. "it back to me in Garbage."
			),
			completion = "Delivered. That's the part I needed you to finish.",
			field = {
				description = (
					"A compact hard case with orange panels, dark protective ribs and a carrying handle. Cleaner's "
					.. "note: \"A sealed parcel needs moving between the assigned drops.\""
				),
				kind = "recovery",
				map = "rp_garbage_cotz",
				tier = 1,
				cargo = "town_quest_evidence",
				label = "First sealed drop parcel",
			},
			benefits = {},
		},
		{
			id = "CL03",
			stock = {item = "sten", bonus = 1},
			completionCash = 0,
			name = "On Time and Unopened",
			kind = "tracker",
			requires = {"CL02"},
			briefing = "Complete the assigned dead-drop circuits. Collection alone doesn't finish a delivery.",
			completion = "A few finished circuits. That's a useful start.",
			target = 2,
			benefits = {},
		},
		{
			id = "CL04",
			completionCash = 650,
			name = "A small delivery",
			kind = "delivery",
			retiredCommission = true,
			objective = "Bring all 1 listed item type to this contact. The request shows each selected item and required units.",
			requires = {"CL03"},
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "CL05",
			completionCash = 575,
			name = "A Cleaner Way In",
			kind = "delivery",
			requires = {"CL04"},
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "CL06",
			completionCash = 850,
			name = "An Empty Hiding Place",
			kind = "field",
			objective = (
				"Recover the compromised cache evidence from the assigned search area in Garbage. Bring it back to "
				.. "the issuing contact in Garbage."
			),
			requires = {"CL04"},
			briefing = (
				"There's evidence to recover from a compromised cache. Bring the case unchanged. I don't need your "
				.. "inspection marks mixed with theirs. Recover the compromised cache evidence from the assigned "
				.. "search area in Garbage. Bring it back to me in Garbage."
			),
			completion = "Set it down. I'll check it before deciding what needs changing.",
			field = {
				description = (
					"A USB drive with a large rear loop and a handwritten paper label around its body. Cleaner's "
					.. "note: \"There's evidence to recover from a compromised cache.\""
				),
				kind = "recovery",
				map = "rp_garbage_cotz",
				tier = 1,
				cargo = "town_quest_security",
				label = "Compromised cache evidence",
			},
			benefits = {},
		},
		{
			id = "CL07",
			stock = {item = "ppsh", bonus = 1},
			completionCash = 0,
			name = "No Questions",
			kind = "tracker",
			requires = {"CL05"},
			briefing = "Continue the circuit deliveries. Use the endpoint on the order.",
			completion = "You've been consistent about finishing the drop.",
			target = 5,
			benefits = {},
		},
		{
			id = "CL08",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement storage consumer; verify these proposed terms before enabling.
				{
					id = "cleaner/CL08/future",
					provider = "cleaner",
					status = "unimplemented",
					kind = "storage",
					name = "Stored inventory width 3",
					effect = "Unlock stored inventory width 3; preserve purchased space and contents, respect server dimension caps.",
					dimension = "width",
					target = 3,
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
			requires = {"CL06"},
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 1,
				},
			},
		},
		{
			id = "CL09",
			completionCash = 875,
			name = "Digging Deeper",
			kind = "delivery",
			requires = {"CL07"},
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "CL10",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement storage consumer; verify these proposed terms before enabling.
				{
					id = "cleaner/CL10/future",
					provider = "cleaner",
					status = "unimplemented",
					kind = "storage",
					name = "Stored inventory height 3",
					effect = "Unlock stored inventory height 3; preserve purchased space and contents, respect server dimension caps.",
					dimension = "height",
					target = 3,
				},
			},
			completionCash = 1250,
			name = "The Buried Register",
			kind = "field",
			objective = (
				"Recover the distribution register from the assigned search area in Garbage. Bring it back to the "
				.. "issuing contact in Garbage."
			),
			requires = {"CL08"},
			briefing = (
				"I need the distribution register recovered. Too many people are relying on entries they haven't "
				.. "looked at recently. Recover the distribution register from the assigned search area in Garbage. "
				.. "Bring it back to me in Garbage."
			),
			completion = "That's the register. I'll keep the accounts together.",
			field = {
				description = (
					"A clipboard carrying a densely printed packing list and a stamped mark. Cleaner's note: \"I need "
					.. "the distribution register recovered.\""
				),
				kind = "recovery",
				map = "rp_garbage_cotz",
				tier = 2,
				cargo = "town_quest_receipt",
				label = "Distribution register",
			},
		},
		{
			id = "CL11",
			stock = {item = "mac11", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement storage consumer; verify these proposed terms before enabling.
				{
					id = "cleaner/CL11/future",
					provider = "cleaner",
					status = "unimplemented",
					kind = "storage",
					name = "Stored inventory width 4",
					effect = "Unlock stored inventory width 4; preserve purchased space and contents, respect server dimension caps.",
					dimension = "width",
					target = 4,
				},
			},
			completionCash = 0,
			name = "A Quiet Service",
			kind = "tracker",
			requires = {"CL09"},
			briefing = "More sealed circuit work. Read the route before accepting it.",
			completion = "The deliveries arrived. No further explanation needed.",
			target = 9,
		},
		{
			id = "CL12",
			plannedUnlocks = {
				-- TODO: Implement storage consumer; verify these proposed terms before enabling.
				{
					id = "cleaner/CL12/future",
					provider = "cleaner",
					status = "unimplemented",
					kind = "storage",
					name = "Stored inventory height 4",
					effect = "Unlock stored inventory height 4; preserve purchased space and contents, respect server dimension caps.",
					dimension = "height",
					target = 4,
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
			requires = {"CL10"},
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "CL13",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement storage consumer; verify these proposed terms before enabling.
				{
					id = "cleaner/CL13/future",
					provider = "cleaner",
					status = "unimplemented",
					kind = "storage",
					name = "Stored inventory width 5",
					effect = "Unlock stored inventory width 5; preserve purchased space and contents, respect server dimension caps.",
					dimension = "width",
					target = 5,
				},
			},
			completionCash = 1175,
			name = "Safe and Dry",
			kind = "delivery",
			requires = {"CL11"},
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_3",
					quantity = 1,
				},
			},
		},
		{
			id = "CL14",
			capacity = {kind = "rows", amount = 1},
			completionCash = 1650,
			name = "Ledger's Missing Copy",
			kind = "field",
			objective = (
				"Recover the freight copy for Ledger from the assigned search area in Garbage. Deliver it to "
				.. "'Ledger' in Waystation, then come back to the issuing contact in Garbage."
			),
			requires = {"CL12"},
			briefing = (
				"Ledger needs his missing freight copy. Deliver the original, then come back. He doesn't need a "
				.. "courier's summary. Recover the freight copy for Ledger from the assigned search area in Garbage. "
				.. "Deliver it to 'Ledger' in Waystation, then come back to me in Garbage."
			),
			completion = "He has it. That finishes your part of the delivery.",
			field = {
				description = (
					"A printed packing list on a small clipboard with a metal clip and a circular stamp. Cleaner's "
					.. "note: \"Ledger needs his missing freight copy.\""
				),
				kind = "recovery",
				map = "rp_garbage_cotz",
				tier = 2,
				cargo = "town_quest_manifest",
				label = "Freight copy for Ledger",
				recipient = "ledger",
			},
			benefits = {},
		},
		{
			id = "CL15",
			stock = {item = "skorpion", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement storage consumer; verify these proposed terms before enabling.
				{
					id = "cleaner/CL15/future",
					provider = "cleaner",
					status = "unimplemented",
					kind = "storage",
					name = "Stored inventory height 5",
					effect = "Unlock stored inventory height 5; preserve purchased space and contents, respect server dimension caps.",
					dimension = "height",
					target = 5,
				},
			},
			completionCash = 0,
			name = "Across the Boundary",
			kind = "tracker",
			requires = {"CL13"},
			briefing = "Keep completing the drop circuits. Familiarity doesn't change the destination.",
			completion = "You've kept the arrangement straightforward.",
			target = 14,
		},
		{
			id = "CL16",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement storage consumer; verify these proposed terms before enabling.
				{
					id = "cleaner/CL16/future",
					provider = "cleaner",
					status = "unimplemented",
					kind = "storage",
					name = "Stored inventory width 6",
					effect = "Unlock stored inventory width 6; preserve purchased space and contents, respect server dimension caps.",
					dimension = "width",
					target = 6,
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
			requires = {"CL14"},
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_3",
					quantity = 1,
				},
			},
		},
		{
			id = "CL17",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement storage consumer; verify these proposed terms before enabling.
				{
					id = "cleaner/CL17/future",
					provider = "cleaner",
					status = "unimplemented",
					kind = "storage",
					name = "Stored inventory height 6",
					effect = "Unlock stored inventory height 6; preserve purchased space and contents, respect server dimension caps.",
					dimension = "height",
					target = 6,
				},
			},
			completionCash = 1475,
			name = "A Better Reserve",
			kind = "delivery",
			requires = {"CL15"},
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_3",
					quantity = 1,
				},
			},
		},
		{
			id = "CL18",
			plannedUnlocks = {
				-- TODO: Implement storage consumer; verify these proposed terms before enabling.
				{
					id = "cleaner/CL18/future",
					provider = "cleaner",
					status = "unimplemented",
					kind = "storage",
					name = "Stored inventory width 7",
					effect = "Unlock stored inventory width 7; preserve purchased space and contents, respect server dimension caps.",
					dimension = "width",
					target = 7,
				},
			},
			completionCash = 2050,
			name = "The Other Register",
			kind = "field",
			objective = (
				"Recover the distribution backup for Ledger from the assigned search area in Waystation. Deliver "
				.. "it to 'Ledger' in Waystation, then come back to the issuing contact in Garbage."
			),
			requires = {"CL16"},
			briefing = (
				"The backup register goes to Ledger. If the accounts disagree, he should have something more "
				.. "useful than my opinion. Recover the distribution backup for Ledger from the assigned search area "
				.. "in Waystation. Deliver it to 'Ledger' in Waystation, then come back to me in Garbage."
			),
			completion = "Delivered. I'll let him examine it before asking which entries need attention.",
			field = {
				description = (
					"A blue records folder with contrasting corporate lettering along the cover. Cleaner's note: \"The "
					.. "backup register goes to Ledger.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_archive",
				label = "Distribution backup for Ledger",
				recipient = "ledger",
			},
			benefits = {},
		},
		{
			id = "CL19",
			stock = {item = "kiparis", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement storage consumer; verify these proposed terms before enabling.
				{
					id = "cleaner/CL19/future",
					provider = "cleaner",
					status = "unimplemented",
					kind = "storage",
					name = "Stored inventory height 7",
					effect = "Unlock stored inventory height 7; preserve purchased space and contents, respect server dimension caps.",
					dimension = "height",
					target = 7,
				},
			},
			completionCash = 0,
			name = "Without a Trace",
			kind = "tracker",
			requires = {"CL17"},
			briefing = "There are more circuits to complete. Keep the parcels closed.",
			completion = "A reliable run of deliveries. I can work with that.",
			target = 20,
		},
		{
			id = "CL20",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement storage consumer; verify these proposed terms before enabling.
				{
					id = "cleaner/CL20/future",
					provider = "cleaner",
					status = "unimplemented",
					kind = "storage",
					name = "Stored inventory width 8",
					effect = "Unlock stored inventory width 8; preserve purchased space and contents, respect server dimension caps.",
					dimension = "width",
					target = 8,
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
			requires = {"CL18"},
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_3",
					quantity = 1,
				},
			},
		},
		{
			id = "CL21",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement storage consumer; verify these proposed terms before enabling.
				{
					id = "cleaner/CL21/future",
					provider = "cleaner",
					status = "unimplemented",
					kind = "storage",
					name = "Stored inventory height 8",
					effect = "Unlock stored inventory height 8; preserve purchased space and contents, respect server dimension caps.",
					dimension = "height",
					target = 8,
				},
			},
			completionCash = 1775,
			name = "Nobody's Spare Key",
			kind = "delivery",
			requires = {"CL19"},
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_3",
					quantity = 1,
				},
			},
		},
		{
			id = "CL22",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement storage consumer; verify these proposed terms before enabling.
				{
					id = "cleaner/CL22/future",
					provider = "cleaner",
					status = "unimplemented",
					kind = "storage",
					name = "Stored inventory width 9",
					effect = "Unlock stored inventory width 9; preserve purchased space and contents, respect server dimension caps.",
					dimension = "width",
					target = 9,
				},
			},
			completionCash = 2450,
			name = "A Cache With Two Owners",
			kind = "field",
			objective = (
				"Recover the cache ownership file from the assigned search area in Pripyat. Bring it back to the "
				.. "issuing contact in Garbage."
			),
			requires = {"CL20"},
			briefing = (
				"I need the ownership record. Two people saying mine doesn't make two separate caches. Recover the "
				.. "cache ownership file from the assigned search area in Pripyat. Bring it back to me in Garbage."
			),
			completion = "I'll read the claims. Nobody gets an answer before that.",
			field = {
				description = (
					"A creased printed letter with a corporate mark and several small blocks of text. Cleaner's note: "
					.. "\"I need the ownership record.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_contract",
				label = "Cache ownership file",
			},
		},
		{
			id = "CL23",
			stock = {item = "mp34", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement storage consumer; verify these proposed terms before enabling.
				{
					id = "cleaner/CL23/future",
					provider = "cleaner",
					status = "unimplemented",
					kind = "storage",
					name = "Stored inventory width 10",
					effect = "Unlock stored inventory width 10; preserve purchased space and contents, respect server dimension caps.",
					dimension = "width",
					target = 10,
				},
			},
			completionCash = 0,
			name = "The Last Circuit",
			kind = "tracker",
			requires = {"CL21"},
			briefing = "Continue the assigned circuits. Return after the delivery is finished.",
			completion = "You've done the work over time. That's what I judge.",
			target = 27,
		},
		{
			id = "CL24",
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					id = "cleaner/CL24/future",
					provider = "cleaner",
					status = "unimplemented",
					kind = "information",
					name = "Record: cache concealment",
					effect = "Persistent practical guide to cache concealment; author verified instructions before activation.",
					topic = "cache concealment",
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
			requires = {"CL22"},
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_garbage_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_4",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "CL25",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					id = "cleaner/CL25/future",
					provider = "cleaner",
					status = "unimplemented",
					kind = "information",
					name = "Record: dead-drop inspection",
					effect = "Persistent practical guide to dead-drop inspection; author verified instructions before activation.",
					topic = "dead-drop inspection",
				},
			},
			completionCash = 2000,
			name = "Room to Keep It",
			kind = "delivery",
			requires = {"CL23", "CL24"},
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_garbage_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_4",
					quantity = 1,
				},
			},
		},
		{
			id = "CL26",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					id = "cleaner/CL26/future",
					provider = "cleaner",
					status = "unimplemented",
					kind = "information",
					name = "Record: compromised stash recovery",
					effect = (
						"Persistent practical guide to compromised stash recovery; author verified "
						.. "instructions before activation."
					),
					topic = "compromised stash recovery",
				},
			},
			completionCash = 2850,
			name = "The Cache That Stayed Closed",
			kind = "field",
			objective = (
				"Collect the final sealed circuit parcel at the assigned pickup in Garbage and deliver it to the "
				.. "assigned cache. Come back to the issuing contact in Garbage."
			),
			requires = {"CL25"},
			briefing = (
				"One more sealed circuit delivery. Finish the drop before coming back for the account to be "
				.. "closed. Collect the final sealed circuit parcel at the assigned pickup in Garbage and deliver it "
				.. "to the assigned cache. Come back to me in Garbage."
			),
			completion = "Delivery finished. You've been consistent. I have work for people who can stay that way.",
			field = {
				description = (
					"A compact hard case with orange panels, dark protective ribs and a carrying handle. Cleaner's "
					.. "note: \"One more sealed circuit delivery.\""
				),
				kind = "deadDrop",
				map = "rp_garbage_cotz",
				tier = 2,
				cargo = "town_quest_evidence",
				label = "Final sealed circuit parcel",
			},
		},
		{
			id = "CL27",
			stock = {item = "glock18", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					id = "cleaner/CL27/future",
					provider = "cleaner",
					status = "unimplemented",
					kind = "information",
					name = "Record: secure packing",
					effect = "Persistent practical guide to secure packing; author verified instructions before activation.",
					topic = "secure packing",
				},
			},
			completionCash = 0,
			name = "Trusted With the Route",
			kind = "tracker",
			requires = {"CL26"},
			briefing = "More drop circuits when you're prepared. The same delivery terms apply.",
			completion = "You've earned my confidence in the work. Keep it that way.",
			target = 35,
		},
		{
			id = "CL28",
			completionCash = 3000,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"CL27"},
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_garbage_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_4",
					quantity = 1,
				},
			},
			benefits = {},
			recognition = "Cleaner's trusted contact",
		},
	},
})
