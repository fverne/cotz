PLUGIN:Register("atlas", {
	name = "'Atlas'",
	template = "atlasnpc",
	difficultyMultiplier = 1,
	enforceCatalogue = true,
	map = "rp_marsh_cs",
	job = {
		kind = "photography",
		category = "Alternating mutant and anomaly photography",
		description = "Alternating mutant and anomaly photography",
	},
	legacyJob = {
		kind = "sensor",
		category = "Sensor deployment and retrieval",
		description = "Sensor deployment and retrieval",
		maps = {
			easy = "rp_marsh_cs",
			medium = "rp_garbage_cotz",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {},
	rewards = {
		packages = {
			{label = "Survey provisions",
				items = {"drink_bottlewater", "food_raisins"}},
			{label = "Field safety",
				items = {"medic_bandage_1", "medic_antirad_1"}},
			{label = "Long survey",
				items = {"food_can_beans", "drink_bottletea"}},
		},
		bonusItems = {
			"compass",
		},
	},
	dialogue = {
		delivery = (
			"Here, beside the notes. Thank you for bringing it through; I'll check the details before I "
			.. "file it."
		),
		completedGreeting = (
			"Hello again. I've made room beside the finished sheets. Sit down, if you have time. I'd like "
			.. "to hear about a walk that didn't begin with me asking you to fetch something."
		),
		workPrompt = "About the photographs I am taking.",
		offerPrompt = "Do you need photographs?",
		work = "Photographs, this time. We will alternate between living mutants and anomalies; the list tells you how many different types I need. I can lend you a camera. Take it out, frame the actual subject and bring the completed survey back to me. Another photograph of the same type will not give us another comparison, though you are welcome to keep looking.",
		progressionPrompt = "What are you working on at the moment?",
		progression = (
			"I'm comparing our surveys with records left by other teams. Some entries are very careful. "
			.. "Others make perfect sense until you try to follow them. I'd like help checking the gaps, and "
			.. "recovering what hasn't made it back. We'll begin here in Marsh. There's no need to commit "
			.. "yourself to the whole undertaking today. Choose something manageable, and we can see how we "
			.. "work together."
		),
	},
	catalogue = {
		["anomalydetector"] = {step = "AT15",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["backpack_duffle"] = {step = "AT06",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["backpack_sanitar"] = {step = "AT11",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["backpack_sling"] = {step = "AT01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["backpack_tbag"] = {step = "AT17",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["backpack_tourist"] = {step = "AT22",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["binoculars_1"] = {step = "AT08",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["binoculars_2"] = {step = "AT01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["binoculars_3"] = {step = "AT22",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["binoculars_4"] = {step = "AT15",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["compass"] = {step = "AT08",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["geigercounter"] = {step = "AT01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["gpstracker"] = {step = "AT22",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
	},
	progression = {
		{
			id = "AT01",
			completionCash = 275,
			name = "Marks on Paper",
			kind = "delivery",
			requires = {},
			briefing = (
				"I am putting together supplies for the survey work. A useful measurement starts with having the "
				.. "right things in the pack. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thank you. I will check these over before taking them out.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "AT02",
			completionCash = 450,
			name = "The First Landmark",
			kind = "field",
			objective = (
				"Deploy the recorder at the assigned site in Marsh, let it finish recording, then retrieve the "
				.. "first Marsh survey recording. Bring it back to the issuing contact in Marsh."
			),
			requires = {"AT01"},
			briefing = (
				"Let's begin with a recording here in Marsh. Take the recorder to the assigned site, let it "
				.. "finish, and bring the results back here. Have a look at the approach while you're there. "
				.. "Afterwards we can compare what the instrument recorded with how you found the place."
			),
			completion = (
				"You're back. Good. Put the results here. How did you find the approach? Take a moment to "
				.. "think; I can check the recording while you catch your breath."
			),
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. An initial "
					.. "Marsh recording for comparison with the approach on foot."
				),
				kind = "sensor",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_module",
				label = "First Marsh survey recording",
			},
			benefits = {},
		},
		{
			id = "AT03",
			stock = {item = "geigercounter", bonus = 1},
			completionCash = 0,
			name = "Repeatable Ground",
			kind = "tracker",
			requires = {"AT02"},
			briefing = (
				"A single trip leaves me with rather a lot of questions. Keep taking my survey assignments: "
				.. "deploy the recorder, let it finish, and return the results. A few completed runs will give "
				.. "us something to compare without asking one reading to explain everything."
			),
			completion = (
				"That's a useful start. I can begin comparing the surveys now. You've also given me a better "
				.. "idea of what I can reasonably ask of you, which matters just as much when I'm planning the "
				.. "next trip."
			),
			target = 2,
			benefits = {},
		},
		{
			id = "AT04",
			stock = {item = "backpack_sling", bonus = 1},
			completionCash = 650,
			name = "A small delivery",
			kind = "delivery",
			retiredCommission = true,
			objective = "Bring all 1 listed item type to this contact. The request shows each selected item and required units.",
			requires = {"AT02"},
			briefing = (
				"I am putting together supplies for the survey work. A useful measurement starts with having the "
				.. "right things in the pack. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thank you. I will check these over before taking them out.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "AT05",
			completionCash = 575,
			name = "A Better Baseline",
			kind = "delivery",
			requires = {"AT03"},
			briefing = (
				"I am putting together supplies for the survey work. A useful measurement starts with having the "
				.. "right things in the pack. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thank you. I will check these over before taking them out.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "AT06",
			completionCash = 850,
			name = "Ballast's Shortcut",
			kind = "field",
			objective = (
				"Recover the waterside journal for Ballast from the assigned search area in Marsh. Deliver it to "
				.. "'Ballast' in Marsh, then come back to the issuing contact in Marsh."
			),
			requires = {"AT04"},
			briefing = (
				"Recover the waterside journal from the assigned area in Marsh and take it to Ballast, also "
				.. "here in Marsh. Then come back to me. He should have the record to consult himself before I "
				.. "ask him more questions about the approach. He already accuses me of discussing ground I "
				.. "haven't stood on recently enough."
			),
			completion = (
				"The journal reached Ballast, then. Good. I can ask him about it without making him rely on "
				.. "my account of somebody else's notes. That should remove at least one of his objections."
			),
			field = {
				description = (
					"A thick brown journal held together by a narrow tie around its cover. A waterside account for "
					.. "Ballast to check against his local knowledge."
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "Waterside journal for Ballast",
				recipient = "ballast",
			},
			benefits = {},
		},
		{
			id = "AT07",
			stock = {item = "backpack_duffle", bonus = 1},
			completionCash = 0,
			name = "Measured Twice",
			kind = "tracker",
			requires = {"AT05"},
			briefing = (
				"Keep bringing back completed survey assignments. We're building a comparison across several "
				.. "runs. Don't hurry the recorder to get through them; each one still needs to finish before "
				.. "you retrieve the results and return here."
			),
			completion = (
				"We've enough completed work for the next comparison. Thank you for staying with it. "
				.. "Repetition can feel rather unrewarding when you're the one doing the walking; this is where "
				.. "it starts helping me spot what deserves another look."
			),
			target = 5,
			benefits = {},
		},
		{
			id = "AT08",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement passage consumer; verify these proposed terms before enabling.
				{
					destination = "Garbage",
					effect = "Optional Marsh–Garbage shortcut via Marsh survey trail; author distinct safe endpoints and permissions.",
					id = "atlas/AT08/future",
					kind = "passage",
					name = "Marsh survey trail",
					origin = "Marsh",
					provider = "atlas",
					status = "unimplemented",
					route = "Marsh survey trail",
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
			requires = {"AT06"},
			briefing = (
				"I am putting together supplies for the survey work. A useful measurement starts with having the "
				.. "right things in the pack. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thank you. I will check these over before taking them out.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_marsh_2",
					quantity = 1,
				},
			},
		},
		{
			id = "AT09",
			stock = {item = "compass", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering Marsh flooded detours; author actionable "
						.. "guidance tied to verified mechanics and locations."
					),
					id = "atlas/AT09/future",
					kind = "information",
					name = "Record: Marsh flooded detours",
					provider = "atlas",
					status = "unimplemented",
					topic = "Marsh flooded detours",
				},
			},
			completionCash = 875,
			name = "Paper Trail",
			kind = "delivery",
			requires = {"AT07"},
			briefing = (
				"I am putting together supplies for the survey work. A useful measurement starts with having the "
				.. "right things in the pack. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thank you. I will check these over before taking them out.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_marsh_2",
					quantity = 1,
				},
			},
		},
		{
			id = "AT10",
			stock = {item = "binoculars_2", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering Garbage eastern approaches; author "
						.. "actionable guidance tied to verified mechanics and locations."
					),
					id = "atlas/AT10/future",
					kind = "information",
					name = "Record: Garbage eastern approaches",
					provider = "atlas",
					status = "unimplemented",
					topic = "Garbage eastern approaches",
				},
			},
			completionCash = 1250,
			name = "An Unfinished Map",
			kind = "field",
			objective = (
				"Recover the unfinished survey cassette from the assigned search area in Garbage. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"AT08"},
			briefing = (
				"There's an audio cassette to recover in the assigned search area in Garbage. Bring it back "
				.. "to me in Marsh. Written notes often leave out the small decisions made along the way; I'm "
				.. "hoping the recording gives me something I can check against them."
			),
			completion = (
				"Here, please. I'll listen through before making any additions. If the account is unclear, "
				.. "I'd like to hear it twice before I decide what the speaker meant."
			),
			field = {
				description = (
					"A pale audio cassette with a handwritten dedication above the spool windows. A surviving audio "
					.. "account intended to accompany the written survey notes."
				),
				kind = "recovery",
				map = "rp_garbage_cotz",
				tier = 2,
				cargo = "town_quest_tape",
				label = "Unfinished survey cassette",
			},
		},
		{
			id = "AT11",
			stock = {item = "backpack_sanitar", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering Garbage western return route; author "
						.. "actionable guidance tied to verified mechanics and locations."
					),
					id = "atlas/AT11/future",
					kind = "information",
					name = "Record: Garbage western return route",
					provider = "atlas",
					status = "unimplemented",
					topic = "Garbage western return route",
				},
			},
			completionCash = 0,
			name = "Ground Truth",
			kind = "tracker",
			requires = {"AT09"},
			briefing = (
				"Continue the survey assignments and return each completed set of results. I need more "
				.. "observations to compare. We're quite good at inventing explanations once we have a little "
				.. "information; I'd like enough information to discard a few of mine."
			),
			completion = (
				"That's enough completed surveys for this stage. I can sit down with the comparison now. "
				.. "It's rather satisfying to reach the point where I can ask a narrower question than 'what on "
				.. "earth happened here?'"
			),
			target = 9,
		},
		{
			id = "AT12",
			stock = {item = "binoculars_1", bonus = 1},
			plannedUnlocks = {
				-- TODO: Implement passage consumer; verify these proposed terms before enabling.
				{
					destination = "Garbage",
					effect = (
						"Optional Marsh–Garbage shortcut via Garbage overland detour; author distinct safe "
						.. "endpoints and permissions."
					),
					id = "atlas/AT12/future",
					kind = "passage",
					name = "Garbage overland detour",
					origin = "Marsh",
					provider = "atlas",
					status = "unimplemented",
					route = "Garbage overland detour",
				},
			},
			completionCash = 1450,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"AT10"},
			briefing = (
				"I am putting together supplies for the survey work. A useful measurement starts with having the "
				.. "right things in the pack. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thank you. I will check these over before taking them out.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "AT13",
			completionCash = 1175,
			name = "Lines That Agree",
			kind = "delivery",
			requires = {"AT11"},
			briefing = (
				"I am putting together supplies for the survey work. A useful measurement starts with having the "
				.. "right things in the pack. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thank you. I will check these over before taking them out.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "AT14",
			stock = {item = "geigercounter", bonus = 2},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering Waystation shelter approaches; author "
						.. "actionable guidance tied to verified mechanics and locations."
					),
					id = "atlas/AT14/future",
					kind = "information",
					name = "Record: Waystation shelter approaches",
					provider = "atlas",
					status = "unimplemented",
					topic = "Waystation shelter approaches",
				},
			},
			completionCash = 1650,
			name = "The Wrong Coordinates",
			kind = "field",
			objective = (
				"Recover the disputed coordinate file from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"AT12"},
			briefing = (
				"Recover the file folder from the assigned search area in Marsh and bring it here. I want to "
				.. "check the disputed coordinates against the source. A copied number can look completely "
				.. "respectable through several more copies; I'd rather start as close to the original account "
				.. "as we can."
			),
			completion = (
				"That's the folder. Thank you. I'll compare the entries carefully. Finding a discrepancy is "
				.. "the easy part; explaining which entry deserves confidence takes a little longer."
			),
			field = {
				description = (
					"A cardboard file folder with a small coloured crest on its cover. A source file Atlas wants to "
					.. "examine before trusting copied coordinates."
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_official",
				label = "Disputed coordinate file",
			},
		},
		{
			id = "AT15",
			stock = {item = "anomalydetector", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering Pripyat survey approaches; author "
						.. "actionable guidance tied to verified mechanics and locations."
					),
					id = "atlas/AT15/future",
					kind = "information",
					name = "Record: Pripyat survey approaches",
					provider = "atlas",
					status = "unimplemented",
					topic = "Pripyat survey approaches",
				},
			},
			completionCash = 0,
			name = "Beyond the Margin",
			kind = "tracker",
			requires = {"AT13"},
			briefing = (
				"Keep completing the survey assignments and bringing back the results. I need a broader set "
				.. "of observations before I take this comparison further. The individual trips still matter, "
				.. "even when the paperwork starts calling them a total."
			),
			completion = (
				"You've kept the surveys coming. I appreciate it. I spend enough time with the results that "
				.. "I have to remind myself how much walking sits behind each neat entry."
			),
			target = 14,
		},
		{
			id = "AT16",
			stock = {item = "binoculars_4", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering Pripyat retreat planning; author "
						.. "actionable guidance tied to verified mechanics and locations."
					),
					id = "atlas/AT16/future",
					kind = "information",
					name = "Record: Pripyat retreat planning",
					provider = "atlas",
					status = "unimplemented",
					topic = "Pripyat retreat planning",
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
			requires = {"AT14"},
			briefing = (
				"I am putting together supplies for the survey work. A useful measurement starts with having the "
				.. "right things in the pack. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thank you. I will check these over before taking them out.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_marsh_3",
					quantity = 1,
				},
			},
		},
		{
			id = "AT17",
			completionCash = 1475,
			name = "Preparing the Last Sheet",
			kind = "delivery",
			requires = {"AT15"},
			briefing = (
				"I am putting together supplies for the survey work. A useful measurement starts with having the "
				.. "right things in the pack. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thank you. I will check these over before taking them out.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "AT18",
			stock = {item = "backpack_tbag", bonus = 1},
			plannedUnlocks = {
				-- TODO: Implement passage consumer; verify these proposed terms before enabling.
				{
					destination = "Garbage",
					effect = (
						"Optional Marsh–Garbage shortcut via Waystation survey approach; author distinct "
						.. "safe endpoints and permissions."
					),
					id = "atlas/AT18/future",
					kind = "passage",
					name = "Waystation survey approach",
					origin = "Marsh",
					provider = "atlas",
					status = "unimplemented",
					route = "Waystation survey approach",
				},
			},
			completionCash = 2050,
			name = "The First Pripyat Mark",
			kind = "field",
			objective = (
				"Deploy the recorder at the assigned site in Pripyat, let it finish recording, then retrieve the "
				.. "first Pripyat survey recording. Bring it back to the issuing contact in Marsh."
			),
			requires = {"AT16"},
			briefing = (
				"This recording is in Pripyat. Check your supplies and the assigned destination before "
				.. "setting out. Deploy the recorder, allow it to finish, retrieve the results, and return here "
				.. "to Marsh. If you need to turn back and prepare again, do so. I'd rather discuss a postponed "
				.. "survey than wait for someone who felt obliged to press on."
			),
			completion = (
				"It's good to see you. Put the results down and take a moment. I'll want to hear how you "
				.. "found the journey, but there's time for that. You needn't give me a report while you're "
				.. "still standing with your pack on."
			),
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. A Pripyat "
					.. "survey recording for comparison with the earlier route work."
				),
				kind = "sensor",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module",
				label = "First Pripyat survey recording",
			},
			benefits = {},
		},
		{
			id = "AT19",
			stock = {item = "compass", bonus = 2},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering survey notebook comparison; author "
						.. "actionable guidance tied to verified mechanics and locations."
					),
					id = "atlas/AT19/future",
					kind = "information",
					name = "Record: survey notebook comparison",
					provider = "atlas",
					status = "unimplemented",
					topic = "survey notebook comparison",
				},
			},
			completionCash = 0,
			name = "A Map Worth Carrying",
			kind = "tracker",
			requires = {"AT17", "AT18"},
			briefing = (
				"Both parts of the work have brought us this far. Keep completing my survey assignments; I "
				.. "need the remaining comparison before the final work. You've already spent a great deal of "
				.. "time on this. Take the next trips at a pace you can sustain."
			),
			completion = (
				"We've reached the survey total I needed. Thank you. Having both the recovered records and "
				.. "this much completed fieldwork gives me a much better place to begin the final comparison."
			),
			target = 20,
		},
		{
			id = "AT20",
			stock = {item = "backpack_duffle", bonus = 2},
			completionCash = 2250,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"AT19"},
			briefing = (
				"I am putting together supplies for the survey work. A useful measurement starts with having the "
				.. "right things in the pack. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thank you. I will check these over before taking them out.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_research_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_marsh_4",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "AT21",
			stock = {item = "backpack_sanitar", bonus = 2},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering seasonal route changes; author actionable "
						.. "guidance tied to verified mechanics and locations."
					),
					id = "atlas/AT21/future",
					kind = "information",
					name = "Record: seasonal route changes",
					provider = "atlas",
					status = "unimplemented",
					topic = "seasonal route changes",
				},
			},
			completionCash = 1775,
			name = "An Atlas With Names",
			kind = "delivery",
			requires = {"AT20"},
			briefing = (
				"I am putting together supplies for the survey work. A useful measurement starts with having the "
				.. "right things in the pack. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thank you. I will check these over before taking them out.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_research_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_marsh_4",
					quantity = 1,
				},
			},
		},
		{
			id = "AT22",
			completionCash = 2450,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"AT21"},
			briefing = (
				"I am putting together supplies for the survey work. A useful measurement starts with having the "
				.. "right things in the pack. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thank you. I will check these over before taking them out.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_research_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_marsh_4",
					quantity = 1,
				},
			},
			benefits = {},
			recognition = "Atlas's trusted contact",
		},
	},
})
