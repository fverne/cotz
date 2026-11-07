PLUGIN:Register("boss", {
	name = "'Boss'",
	template = "unisgnpc2",
	difficultyMultiplier = 3,
	enforceCatalogue = true,
	map = "rp_waystation",
	courierPools = {
		"valuables_secured_cases",
		"valuables_military_cases",
		"valuables_control_electronics",
		"valuables_technical_records",
	},
	job = {
		kind = "regionalHumans",
		category = "Regional human elimination",
		description = "Regional human elimination",
		maps = {
			easy = "rp_garbage_cotz",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
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
			{label = "Combat ammunition", items = {"545x39"}},
			{label = "Medical supplies", items = {"medic_medkit_1"}},
			{label = "Canned provisions", items = {"food_can_tushonka"}},
		},
		bonusPackages = {
			{label = "Specialist ammunition", items = {"545x39ap", "556x45ap"}},
		},
		bonusCash = true,
	},
	dialogue = {
		jobBriefing = "There's a job I need carried out. {details}",
		jobReminder = "Our arrangement still stands. {details}",
		jobFinished = "The work is done. Your payment can be settled here.",
		completedGreeting = (
			"Good to see you back. You've earned a proper hearing. What do you need?"
		),
		workPrompt = "About my current orders.",
		offerPrompt = "Do you have an elimination assignment?",
		work = (
			"Hostile elimination orders, against the targets specified. Read the assignment before accepting "
			.. "it. I need a defined threat dealt with and an accurate return, rather than another problem created "
			.. "by an expanded interpretation. Ask about anything that affects your decision while we can still "
			.. "settle it here."
		),
		progressionPrompt = "What needs checking in the operation's reports?",
		progression = (
			"Supplies and surviving field reports. I want the records recovered before we decide which "
			.. "explanation is supported. Some evidence needs to go directly to another contact. Finish that "
			.. "handover and return to me. You'll have a particular order to consider, not a general invitation to "
			.. "improvise around the operation."
		),
	},
	-- Author-disabled suggestions must not be restored by catalogue or stock generation.
	disabledItems = {
		["accesscard_bunker"] = true,
	},
	catalogue = {
		-- ["accesscard_bunker"] = {step = "BO01",
			-- terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["detectorecho"] = {step = "BO01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["headwear_cs4"] = {step = "BO09",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["headwear_screen"] = {step = "BO05",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["helm_operator_nato"] = {step = "BO22",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["helm_operator_rus_1"] = {step = "BO01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["helm_sphere08"] = {step = "BO14",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["helm_sphere12"] = {step = "BO18",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["mask_m40"] = {step = "BO15",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["mask_m50"] = {step = "BO22",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["mask_pmk3"] = {step = "BO01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["mask_xm40"] = {step = "BO08",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
	},
	progression = {
		{
			id = "BO01",
			completionCash = 275,
			name = "Operational Basics",
			kind = "delivery",
			requires = {},
			briefing = (
				"There is an allocation to fill. Check the request before bringing anything; I need to know what "
				.. "I can actually issue. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Received. I will account for these with the other supplies.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 9,
				},
			},
			benefits = {},
		},
		{
			id = "BO02",
			stock = {item = "detectorecho", bonus = 1},
			completionCash = 450,
			name = "The Missing Patrol",
			kind = "field",
			objective = (
				"Recover the missing patrol report from the assigned search area in Waystation. Bring it back to "
				.. "the issuing contact in Waystation."
			),
			requires = {"BO01"},
			briefing = (
				"The patrol report needs recovering. I want the surviving account before we decide which part of "
				.. "the plan failed. Recover the missing patrol report from the assigned search area in Waystation. "
				.. "Bring it back to me in Waystation."
			),
			completion = "Leave the complete report here. I'll establish what it supports before changing the account.",
			field = {
				description = (
					"A buff-coloured folder with loose military record sheets extending beyond its cover. Boss's "
					.. "note: \"The patrol report needs recovering.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_orders",
				label = "Missing patrol report",
			},
			benefits = {},
		},
		{
			id = "BO03",
			stock = {item = "mask_pmk3", bonus = 1},
			completionCash = 0,
			name = "Follow Instructions",
			kind = "tracker",
			requires = {"BO02"},
			briefing = (
				"Continue the specified hostile elimination orders. Keep the target requirement clear before "
				.. "accepting."
			),
			completion = "A sound beginning. You've followed the assignments.",
			target = 2,
			benefits = {},
		},
		{
			id = "BO04",
			completionCash = 650,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"BO03"},
			briefing = (
				"There is an allocation to fill. Check the request before bringing anything; I need to know what "
				.. "I can actually issue. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Received. I will account for these with the other supplies.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 18,
				},
				{
					pool = "town_delivery_military_waystation_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BO05",
			completionCash = 575,
			name = "Staying Equipped",
			kind = "delivery",
			requires = {"BO03"},
			briefing = (
				"There is an allocation to fill. Check the request before bringing anything; I need to know what "
				.. "I can actually issue. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Received. I will account for these with the other supplies.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 18,
				},
				{
					pool = "town_delivery_military_waystation_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BO06",
			stock = {item = "headwear_screen", bonus = 1},
			plannedUnlocks = {
				-- TODO: Implement passage consumer; verify these proposed terms before enabling.
				{
					id = "boss/BO06/future",
					provider = "boss",
					status = "unimplemented",
					kind = "passage",
					name = "Operational extraction passage",
					effect = "Optional Waystation–Pripyat operational passage; author endpoints and server permissions.",
					origin = "Waystation",
					destination = "Pripyat",
					route = "operations-extraction",
				},
			},
			completionCash = 850,
			name = "The Interrupted Shipment",
			kind = "field",
			objective = (
				"Recover the interrupted supply case from the assigned search area in Waystation. Bring it back to "
				.. "the issuing contact in Waystation."
			),
			requires = {"BO04"},
			briefing = (
				"The freight case needs bringing back. Don't convert the recovery into a search for an explanation "
				.. "outside your assignment. Recover the interrupted supply case from the assigned search area in "
				.. "Waystation. Bring it back to me in Waystation."
			),
			completion = "Case received. We can inspect it here without extending your exposure outside.",
			field = {
				description = (
					"A low hard case with long contrasting strips across its ribbed lid. Boss's note: \"The freight "
					.. "case needs bringing back.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_equipment",
				label = "Interrupted supply case",
			},
			benefits = {},
		},
		{
			id = "BO07",
			stock = {item = "helm_operator_rus_1", bonus = 1},
			completionCash = 0,
			name = "Pressure on the Route",
			kind = "tracker",
			requires = {"BO05"},
			briefing = "More elimination work when prepared. The order defines the targets.",
			completion = "You've kept to the terms. That matters when I allocate work.",
			target = 5,
			benefits = {},
		},
		{
			id = "BO08",
			completionCash = 1050,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"BO06"},
			briefing = (
				"There is an allocation to fill. Check the request before bringing anything; I need to know what "
				.. "I can actually issue. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Received. I will account for these with the other supplies.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 18,
				},
				{
					pool = "town_delivery_military_waystation_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BO09",
			completionCash = 875,
			name = "Orders and Receipts",
			kind = "delivery",
			requires = {"BO07"},
			briefing = (
				"There is an allocation to fill. Check the request before bringing anything; I need to know what "
				.. "I can actually issue. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Received. I will account for these with the other supplies.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 18,
				},
				{
					pool = "town_delivery_military_waystation_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BO10",
			plannedUnlocks = {
				-- TODO: Implement cosmetic consumer; verify these proposed terms before enabling.
				{
					id = "boss/BO10/future",
					provider = "boss",
					status = "unimplemented",
					kind = "cosmetic",
					name = "Operations field finish",
					effect = "Apply an operations finish to the IO7a; appearance only, without suit variant stat changes.",
					baseSuit = "suit_io7a",
					finish = "operations-field",
				},
			},
			completionCash = 1250,
			name = "The Missing Names",
			kind = "field",
			objective = (
				"Recover the expedition record for Wake from the assigned search area in Waystation. Deliver it to "
				.. "'Wake' in Garbage, then come back to the issuing contact in Waystation."
			),
			requires = {"BO08"},
			briefing = (
				"Wake needs the expedition evidence. She should not have to work from a summary chosen for "
				.. "operational convenience. Recover the expedition record for Wake from the assigned search area in "
				.. "Waystation. Deliver it to 'Wake' in Garbage, then come back to me in Waystation."
			),
			completion = "Delivered. I'll let her examine it before asking which questions remain.",
			field = {
				description = (
					"A cardboard file folder with an emblem and printed wording on the front. Boss's note: \"Wake "
					.. "needs the expedition evidence.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_personnel",
				label = "Expedition record for Wake",
				recipient = "wake",
			},
			benefits = {},
		},
		{
			id = "BO11",
			stock = {item = "headwear_cs4", bonus = 1},
			completionCash = 0,
			name = "A Smaller Network",
			kind = "tracker",
			requires = {"BO09"},
			briefing = "Keep completing the elimination requests while I review the reports.",
			completion = "A reliable stretch of completed assignments. Acknowledged.",
			target = 9,
			benefits = {},
		},
		{
			id = "BO12",
			completionCash = 1450,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"BO10"},
			briefing = (
				"There is an allocation to fill. Check the request before bringing anything; I need to know what "
				.. "I can actually issue. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Received. I will account for these with the other supplies.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 27,
				},
				{
					pool = "town_delivery_military_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_waystation_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BO13",
			completionCash = 1175,
			name = "Packed for Contact",
			kind = "delivery",
			requires = {"BO11"},
			briefing = (
				"There is an allocation to fill. Check the request before bringing anything; I need to know what "
				.. "I can actually issue. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Received. I will account for these with the other supplies.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 27,
				},
				{
					pool = "town_delivery_military_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_waystation_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BO14",
			completionCash = 1650,
			name = "The Pripyat Outpost",
			kind = "field",
			objective = (
				"Recover the Pripyat outpost orders from the assigned search area in Pripyat. Bring it back to the "
				.. "issuing contact in Waystation."
			),
			requires = {"BO12"},
			briefing = (
				"The outpost's surviving orders are in Pripyat. Recover the record; do not extend the assignment "
				.. "based on a name you find. Recover the Pripyat outpost orders from the assigned search area in "
				.. "Pripyat. Bring it back to me in Waystation."
			),
			completion = "Leave it here. I'll compare the instructions before drawing conclusions about who followed them.",
			field = {
				description = (
					"A buff-coloured folder with loose military record sheets extending beyond its cover. Boss's "
					.. "note: \"The outpost's surviving orders are in Pripyat.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_orders",
				label = "Pripyat outpost orders",
			},
			benefits = {},
		},
		{
			id = "BO15",
			stock = {item = "helm_sphere08", bonus = 1},
			completionCash = 0,
			name = "Holding the Initiative",
			kind = "tracker",
			requires = {"BO13"},
			briefing = "Continue the specified elimination work. Do not expand the targets on your own judgement.",
			completion = "You've remained consistent under a longer account. I appreciate it.",
			target = 14,
			benefits = {},
		},
		{
			id = "BO16",
			completionCash = 1850,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"BO14"},
			briefing = (
				"There is an allocation to fill. Check the request before bringing anything; I need to know what "
				.. "I can actually issue. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Received. I will account for these with the other supplies.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 27,
				},
				{
					pool = "town_delivery_military_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_waystation_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BO17",
			completionCash = 1475,
			name = "A Report That Holds",
			kind = "delivery",
			requires = {"BO15"},
			briefing = (
				"There is an allocation to fill. Check the request before bringing anything; I need to know what "
				.. "I can actually issue. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Received. I will account for these with the other supplies.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 27,
				},
				{
					pool = "town_delivery_military_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_waystation_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BO18",
			completionCash = 2050,
			name = "The Withheld Annex",
			kind = "field",
			objective = (
				"Recover the missing annex for Wake from the assigned search area in Pripyat. Deliver it to 'Wake' "
				.. "in Garbage, then come back to the issuing contact in Waystation."
			),
			requires = {"BO16"},
			briefing = (
				"Wake needs the expedition annex. Restricting the rest of the file isn't a reason to leave her "
				.. "without evidence relevant to the search. Recover the missing annex for Wake from the assigned "
				.. "search area in Pripyat. Deliver it to 'Wake' in Garbage, then come back to me in Waystation."
			),
			completion = "She has the annex. I'll wait for her assessment instead of supplying it.",
			field = {
				description = (
					"A cardboard file folder with a small coloured crest on its cover. Boss's note: \"Wake needs the "
					.. "expedition annex.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_official",
				label = "Missing annex for Wake",
				recipient = "wake",
			},
			benefits = {},
		},
		{
			id = "BO19",
			stock = {item = "mask_xm40", bonus = 1},
			completionCash = 0,
			name = "End of the Operation",
			kind = "tracker",
			requires = {"BO17", "BO18"},
			briefing = "There are more target orders. Prepare for the assignment you accept.",
			completion = "A substantial contribution. You have given me reason to rely on your judgement.",
			target = 20,
			benefits = {},
		},
		{
			id = "BO20",
			stock = {item = "helm_sphere12", bonus = 1},
			completionCash = 2250,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"BO19"},
			briefing = (
				"There is an allocation to fill. Check the request before bringing anything; I need to know what "
				.. "I can actually issue. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Received. I will account for these with the other supplies.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 36,
				},
				{
					pool = "town_delivery_military_waystation_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_waystation_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_waystation_4",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BO21",
			completionCash = 1775,
			name = "Return to Readiness",
			kind = "delivery",
			requires = {"BO20"},
			briefing = (
				"There is an allocation to fill. Check the request before bringing anything; I need to know what "
				.. "I can actually issue. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Received. I will account for these with the other supplies.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 36,
				},
				{
					pool = "town_delivery_military_waystation_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_waystation_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_waystation_4",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BO22",
			completionCash = 2450,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"BO21"},
			briefing = (
				"There is an allocation to fill. Check the request before bringing anything; I need to know what "
				.. "I can actually issue. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Received. I will account for these with the other supplies.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 36,
				},
				{
					pool = "town_delivery_military_waystation_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_waystation_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_waystation_4",
					quantity = 1,
				},
			},
			benefits = {},
			recognition = "Boss's trusted contact",
		},
	},
})
