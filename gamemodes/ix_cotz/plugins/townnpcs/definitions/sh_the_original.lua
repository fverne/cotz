PLUGIN:Register("the-original", {
	name = "'The Original'",
	template = "firststalkernpc",
	enforceCatalogue = true,
	map = "rp_marsh_cs",
	job = {
		kind = "none",
		category = "No ordinary repeatable work",
		description = "No ordinary repeatable work",
	},
	retiredRegionalJob = {
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
		category = "Mutant specimen deliveries",
		description = "Mutant specimen deliveries",
		pools = {"common_parts", "small_parts", "common_hides"},
		deliveryTiers = {
			easy = {
				pools = {
					"valuables_personal_effects",
				},
				quantity = 1,
			},
			medium = {
				pools = {
					"valuables_decorative_valuables",
				},
				quantity = 1,
			},
			hard = {
				pools = {
					"valuables_irregular_patches",
					"valuables_specialist_cases",
				},
				quantity = 2,
			},
		},
		quantities = {2, 4, 7},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "drink_bottlewaterdirty", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Expedition provisions",
				items = {"food_can_tushonka", "drink_bottlewater"}},
			{label = "Camp supplies",
				items = {"lowtiercookerfuel", "food_bread"}},
			{label = "Close encounters",
				items = {"medic_bandage_1", "12gauge"}},
		},
	},
	dialogue = {
		jobBriefing = "There is still that little matter we discussed. {details}",
		jobReminder = "I haven't forgotten what we agreed. {details}",
		jobFinished = "You see? Work worth doing. Now, what you're owed.",
		delivery = "Bring it over. Let me have a look at what survived.",
		completedGreeting = (
			"Come to check another of my stories? All right. At least you usually bring a question worth "
			.. "answering."
		),
		workPrompt = "About the collection request.",
		offerPrompt = "Do you have a delivery request?",
		work = (
			"Specimens, and the recovered objects listed on the order. Parts tell one sort of story; personal "
			.. "things, old recordings and insignia tell another. Check which request you're taking before "
			.. "deciding what to bring. I want to examine what's there, not spend the afternoon arguing about a "
			.. "magnificent example you left somewhere else."
		),
		progressionPrompt = "What do you want to compare with your account?",
		progression = (
			"There are things I'd like to put beside my own account. Specimens, surviving expedition records, "
			.. "something more useful than a disagreement about which of us remembers best. Start with a request "
			.. "you can fill. We'll inspect what comes back before deciding what it proves. You can reserve the "
			.. "triumphant expression until then."
		),
	},
	-- Author-disabled suggestions must not be restored by catalogue or stock generation.
	disabledItems = {
		["hide_bear"] = true,
		["hide_blinddog"] = true,
		["hide_bloodsucker"] = true,
		["hide_boar"] = true,
		["hide_burer"] = true,
		["hide_cat"] = true,
		["hide_chimera"] = true,
		["hide_controller"] = true,
		["hide_electrocontroller"] = true,
		["hide_flesh"] = true,
		["hide_karlik"] = true,
		["hide_pseudodog"] = true,
		["hide_pseudogiant"] = true,
		["hide_spider"] = true,
		["hide_sprig"] = true,
		["hide_swampcontroller"] = true,
		["hide_tark"] = true,
		["hide_tushkano"] = true,
		["hide_vareshka"] = true,
		["part_bear"] = true,
		["part_blinddog"] = true,
		["part_bloodsucker"] = true,
		["part_boar"] = true,
		["part_burer_1"] = true,
		["part_burer_2"] = true,
		["part_cat"] = true,
		["part_chimera"] = true,
		["part_controller_1"] = true,
		["part_controller_2"] = true,
		["part_electrocontroller_1"] = true,
		["part_electrocontroller_2"] = true,
		["part_flesh"] = true,
		["part_hellhound"] = true,
		["part_izlom"] = true,
		["part_karlik_1"] = true,
		["part_karlik_2"] = true,
		["part_pseudodog"] = true,
		["part_pseudogiant"] = true,
		["part_psydog"] = true,
		["part_skeleton"] = true,
		["part_snork_1"] = true,
		["part_snork_2"] = true,
		["part_spider"] = true,
		["part_sprig"] = true,
		["part_swampcontroller_1"] = true,
		["part_swampcontroller_2"] = true,
		["part_tark"] = true,
		["part_tushkano"] = true,
		["part_vareshka"] = true,
		["part_zombie_1"] = true,
		["part_zombie_2"] = true,
	},
	catalogue = {
		-- ["hide_bear"] = {step = "OR16",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["hide_blinddog"] = {step = "OR02",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["hide_bloodsucker"] = {step = "OR10",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["hide_boar"] = {step = "OR05",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["hide_burer"] = {step = "OR20",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["hide_cat"] = {step = "OR09",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["hide_chimera"] = {step = "OR14",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["hide_controller"] = {step = "OR21",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["hide_electrocontroller"] = {step = "OR23",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["hide_flesh"] = {step = "OR04",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["hide_karlik"] = {step = "OR18",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["hide_pseudodog"] = {step = "OR06",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["hide_pseudogiant"] = {step = "OR24",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["hide_spider"] = {step = "OR11",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["hide_sprig"] = {step = "OR15",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["hide_swampcontroller"] = {step = "OR19",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["hide_tark"] = {step = "OR07",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["hide_tushkano"] = {step = "OR01",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["hide_vareshka"] = {step = "OR13",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_bear"] = {step = "OR20",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_blinddog"] = {step = "OR02",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_bloodsucker"] = {step = "OR12",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_boar"] = {step = "OR03",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_burer_1"] = {step = "OR13",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_burer_2"] = {step = "OR21",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_cat"] = {step = "OR07",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_chimera"] = {step = "OR17",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_controller_1"] = {step = "OR18",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_controller_2"] = {step = "OR22",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_electrocontroller_1"] = {step = "OR24",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_electrocontroller_2"] = {step = "OR23",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_flesh"] = {step = "OR05",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_hellhound"] = {step = "OR11",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_izlom"] = {step = "OR10",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_karlik_1"] = {step = "OR14",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_karlik_2"] = {step = "OR17",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_pseudodog"] = {step = "OR08",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_pseudogiant"] = {step = "OR23",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_psydog"] = {step = "OR15",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_skeleton"] = {step = "OR14",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_snork_1"] = {step = "OR08",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_snork_2"] = {step = "OR11",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_spider"] = {step = "OR06",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_sprig"] = {step = "OR09",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_swampcontroller_1"] = {step = "OR16",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_swampcontroller_2"] = {step = "OR20",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_tark"] = {step = "OR05",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_tushkano"] = {step = "OR01",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_vareshka"] = {step = "OR19",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_zombie_1"] = {step = "OR02",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["part_zombie_2"] = {step = "OR04",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {},
	retiredProgression = {
		{
			id = "OR01",
			completionCash = 275,
			name = "A Familiar Beast",
			kind = "delivery",
			requires = {},
			briefing = (
				"I have a request for you. Bring the things on the list and let me examine them myself; I have "
				.. "seen enough people misidentify what they are holding. Bring everything on the list back here; I "
				.. "need the full delivery."
			),
			completion = "Put those here. I want a proper look before anyone starts telling the story for me.",
			requirements = {
				{
					pool = "town_delivery_collectibles_marsh_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "OR02",
			completionCash = 450,
			name = "Where It Fed",
			kind = "field",
			objective = (
				"Recover the feeding-ground journal from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"OR01"},
			briefing = (
				"Bring the feeding observations back. The animal people remember seeing isn't always the only "
				.. "thing that used the ground. Recover the feeding-ground journal from the assigned search area in "
				.. "Marsh. Bring it back to me in Marsh."
			),
			completion = (
				"Let me read the ordinary entries first. People rush past those when they've heard there's a story "
				.. "coming."
			),
			field = {
				description = (
					"A thick brown journal held together by a narrow tie around its cover. The Original's note: "
					.. "\"Bring the feeding observations back.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "Feeding-ground journal",
			},
			benefits = {},
		},
		{
			id = "OR03",
			stock = {item = "medic_bandage_1", bonus = 1},
			completionCash = 0,
			name = "Proof in the Bag",
			kind = "tracker",
			requires = {"OR02"},
			briefing = "Continue the specimen deliveries. Bring the requested parts in a condition I can inspect.",
			completion = "A useful beginning. We've got more than a single example to discuss.",
			target = 2,
			benefits = {},
		},
		{
			id = "OR04",
			completionCash = 650,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"OR03"},
			briefing = (
				"I have a request for you. Bring the things on the list and let me examine them myself; I have "
				.. "seen enough people misidentify what they are holding. Bring everything on the list back here; I "
				.. "need the full delivery."
			),
			completion = "Put those here. I want a proper look before anyone starts telling the story for me.",
			requirements = {
				{
					pool = "town_delivery_collectibles_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_collectibles_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "OR05",
			completionCash = 575,
			name = "Teeth and Hide",
			kind = "delivery",
			requires = {"OR04"},
			briefing = (
				"I have a request for you. Bring the things on the list and let me examine them myself; I have "
				.. "seen enough people misidentify what they are holding. Bring everything on the list back here; I "
				.. "need the full delivery."
			),
			completion = "Put those here. I want a proper look before anyone starts telling the story for me.",
			requirements = {
				{
					pool = "town_delivery_collectibles_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_collectibles_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "OR06",
			completionCash = 850,
			name = "The Wrong Tracks",
			kind = "field",
			objective = (
				"Recover the disputed hunting recording from the assigned search area in Marsh. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"OR04"},
			briefing = (
				"I want the hunting-site recording. Spoor can have an opinion on it after I've actually heard the "
				.. "thing. Recover the disputed hunting recording from the assigned search area in Marsh. Bring it "
				.. "back to me in Marsh."
			),
			completion = "Put it down. I'll listen to the account, including the part that may spoil mine.",
			field = {
				description = (
					"A pale audio cassette with a handwritten dedication above the spool windows. The Original's "
					.. "note: \"I want the hunting-site recording.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_tape",
				label = "Disputed hunting recording",
			},
			benefits = {},
			stock = {
				item = "drink_bottlewater",
				bonus = 1,
			},
		},
		{
			id = "OR07",
			completionCash = 0,
			name = "Different Quarry",
			kind = "tracker",
			requires = {"OR05"},
			briefing = "More specimen requests when you're ready. Check the order before choosing the quarry.",
			completion = "You've kept bringing useful material. Better than another confident description.",
			target = 5,
			benefits = {},
		},
		{
			id = "OR08",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement barter consumer; verify these proposed terms before enabling.
				{
					id = "the-original/OR08/future",
					provider = "the-original",
					status = "unimplemented",
					kind = "barter",
					name = "medic_bandage_1 exchange",
					effect = "Permanent multi-input offer; consume inputs each time, enforce equipment tiers and audit resale value.",
					inputs = {
						{
							item = "part_blinddog",
							quantity = 2,
						},
						{
							item = "value_tape_duct",
							quantity = 1,
						},
					},
					outputs = {
						{
							item = "medic_bandage_1",
							quantity = 1,
						},
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
			requires = {"OR06"},
			briefing = (
				"I have a request for you. Bring the things on the list and let me examine them myself; I have "
				.. "seen enough people misidentify what they are holding. Bring everything on the list back here; I "
				.. "need the full delivery."
			),
			completion = "Put those here. I want a proper look before anyone starts telling the story for me.",
			requirements = {
				{
					pool = "town_delivery_collectibles_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_collectibles_marsh_2",
					quantity = 1,
				},
			},
		},
		{
			id = "OR09",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering unusual tissue handling; author actionable "
						.. "guidance tied to verified mechanics and locations."
					),
					id = "the-original/OR09/future",
					kind = "information",
					name = "Record: unusual tissue handling",
					provider = "the-original",
					status = "unimplemented",
					topic = "unusual tissue handling",
				},
			},
			completionCash = 875,
			name = "What Changed",
			kind = "delivery",
			requires = {"OR07"},
			briefing = (
				"I have a request for you. Bring the things on the list and let me examine them myself; I have "
				.. "seen enough people misidentify what they are holding. Bring everything on the list back here; I "
				.. "need the full delivery."
			),
			completion = "Put those here. I want a proper look before anyone starts telling the story for me.",
			requirements = {
				{
					pool = "town_delivery_collectibles_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_collectibles_marsh_2",
					quantity = 1,
				},
			},
		},
		{
			id = "OR10",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering predator adaptation notes; author "
						.. "actionable guidance tied to verified mechanics and locations."
					),
					id = "the-original/OR10/future",
					kind = "information",
					name = "Record: predator adaptation notes",
					provider = "the-original",
					status = "unimplemented",
					topic = "predator adaptation notes",
				},
			},
			completionCash = 1250,
			name = "A Story With Dates",
			kind = "field",
			objective = (
				"Recover the dated expedition log for Carbon from the assigned search area in Marsh. Deliver it to "
				.. "'Carbon' in Waystation, then come back to the issuing contact in Marsh."
			),
			requires = {"OR08"},
			briefing = (
				"Carbon needs the dated expedition book. If he wants to question my dates, he should have the "
				.. "original beside him. Recover the dated expedition log for Carbon from the assigned search area in "
				.. "Marsh. Deliver it to 'Carbon' in Waystation, then come back to me in Marsh."
			),
			completion = "He has it. Fine. I'll hear what the pages support, even if I don't enjoy the conversation.",
			field = {
				description = (
					"A thick blue diary with a label fixed to the front cover. The Original's note: \"Carbon needs the "
					.. "dated expedition book.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_diary",
				label = "Dated expedition log for Carbon",
				recipient = "carbon",
			},
		},
		{
			id = "OR11",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering early expedition testimony; author "
						.. "actionable guidance tied to verified mechanics and locations."
					),
					id = "the-original/OR11/future",
					kind = "information",
					name = "Record: early expedition testimony",
					provider = "the-original",
					status = "unimplemented",
					topic = "early expedition testimony",
				},
			},
			completionCash = 0,
			name = "Enough to Compare",
			kind = "tracker",
			requires = {"OR09"},
			briefing = "Keep the specimen orders moving while I compare the old accounts.",
			completion = "There's enough here to make some of my first impressions uncomfortable. Good work.",
			target = 9,
		},
		{
			id = "OR12",
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering mutant habitat comparison; author "
						.. "actionable guidance tied to verified mechanics and locations."
					),
					id = "the-original/OR12/future",
					kind = "information",
					name = "Record: mutant habitat comparison",
					provider = "the-original",
					status = "unimplemented",
					topic = "mutant habitat comparison",
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
			requires = {"OR10"},
			briefing = (
				"I have a request for you. Bring the things on the list and let me examine them myself; I have "
				.. "seen enough people misidentify what they are holding. Bring everything on the list back here; I "
				.. "need the full delivery."
			),
			completion = "Put those here. I want a proper look before anyone starts telling the story for me.",
			requirements = {
				{
					pool = "town_delivery_collectibles_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_collectibles_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_collectibles_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "OR13",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering old encounter account; author actionable "
						.. "guidance tied to verified mechanics and locations."
					),
					id = "the-original/OR13/future",
					kind = "information",
					name = "Record: old encounter account",
					provider = "the-original",
					status = "unimplemented",
					topic = "old encounter account",
				},
			},
			completionCash = 1175,
			name = "Old Wounds",
			kind = "delivery",
			requires = {"OR11"},
			briefing = (
				"I have a request for you. Bring the things on the list and let me examine them myself; I have "
				.. "seen enough people misidentify what they are holding. Bring everything on the list back here; I "
				.. "need the full delivery."
			),
			completion = "Put those here. I want a proper look before anyone starts telling the story for me.",
			requirements = {
				{
					pool = "town_delivery_collectibles_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_collectibles_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_collectibles_marsh_3",
					quantity = 1,
				},
			},
		},
		{
			id = "OR14",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement barter consumer; verify these proposed terms before enabling.
				{
					id = "the-original/OR14/future",
					provider = "the-original",
					status = "unimplemented",
					kind = "barter",
					name = "lowtiercookerfuel exchange",
					effect = "Permanent multi-input offer; consume inputs each time, enforce equipment tiers and audit resale value.",
					inputs = {
						{
							item = "part_boar",
							quantity = 2,
						},
						{
							item = "value_tape_duct",
							quantity = 1,
						},
					},
					outputs = {
						{
							item = "lowtiercookerfuel",
							quantity = 1,
						},
					},
				},
			},
			completionCash = 1650,
			name = "The Camp Before This One",
			kind = "field",
			objective = (
				"Recover the earlier camp journal from the assigned search area in Waystation. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"OR12"},
			briefing = (
				"Recover the old camp record. I want the account from when it was a working camp, before it became "
				.. "a place people tell stories about. Recover the earlier camp journal from the assigned search area "
				.. "in Waystation. Bring it back to me in Marsh."
			),
			completion = "Let me read it. The little entries may place the journey better than the memorable ones.",
			field = {
				description = (
					"A thick brown journal held together by a narrow tie around its cover. The Original's note: "
					.. "\"Recover the old camp record.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_notebook",
				label = "Earlier camp journal",
			},
		},
		{
			id = "OR15",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering field kitchen safety; author actionable "
						.. "guidance tied to verified mechanics and locations."
					),
					id = "the-original/OR15/future",
					kind = "information",
					name = "Record: field kitchen safety",
					provider = "the-original",
					status = "unimplemented",
					topic = "field kitchen safety",
				},
			},
			completionCash = 0,
			name = "A Hunter's Patience",
			kind = "tracker",
			requires = {"OR13"},
			briefing = "Continue the requested specimen deliveries. Small differences are worth carrying too.",
			completion = "You've stayed patient with the comparisons. I notice that.",
			target = 14,
		},
		{
			id = "OR16",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering survival equipment improvisation; author "
						.. "actionable guidance tied to verified mechanics and locations."
					),
					id = "the-original/OR16/future",
					kind = "information",
					name = "Record: survival equipment improvisation",
					provider = "the-original",
					status = "unimplemented",
					topic = "survival equipment improvisation",
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
			requires = {"OR14"},
			briefing = (
				"I have a request for you. Bring the things on the list and let me examine them myself; I have "
				.. "seen enough people misidentify what they are holding. Bring everything on the list back here; I "
				.. "need the full delivery."
			),
			completion = "Put those here. I want a proper look before anyone starts telling the story for me.",
			requirements = {
				{
					pool = "town_delivery_collectibles_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_collectibles_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_collectibles_marsh_3",
					quantity = 1,
				},
			},
		},
		{
			id = "OR17",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering conflicting expedition stories; author "
						.. "actionable guidance tied to verified mechanics and locations."
					),
					id = "the-original/OR17/future",
					kind = "information",
					name = "Record: conflicting expedition stories",
					provider = "the-original",
					status = "unimplemented",
					topic = "conflicting expedition stories",
				},
			},
			completionCash = 1475,
			name = "A Different Kind of Proof",
			kind = "delivery",
			requires = {"OR15"},
			briefing = (
				"I have a request for you. Bring the things on the list and let me examine them myself; I have "
				.. "seen enough people misidentify what they are holding. Bring everything on the list back here; I "
				.. "need the full delivery."
			),
			completion = "Put those here. I want a proper look before anyone starts telling the story for me.",
			requirements = {
				{
					pool = "town_delivery_collectibles_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_collectibles_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_collectibles_marsh_3",
					quantity = 1,
				},
			},
		},
		{
			id = "OR18",
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering rare mutation observations; author "
						.. "actionable guidance tied to verified mechanics and locations."
					),
					id = "the-original/OR18/future",
					kind = "information",
					name = "Record: rare mutation observations",
					provider = "the-original",
					status = "unimplemented",
					topic = "rare mutation observations",
				},
			},
			completionCash = 2050,
			name = "The Route He Remembers",
			kind = "field",
			objective = (
				"Recover the old route file for Atlas from the assigned search area in Pripyat. Deliver it to "
				.. "'Atlas' in Marsh, then come back to the issuing contact in Marsh."
			),
			requires = {"OR16"},
			briefing = (
				"Atlas should have the route record. He can compare my description with what's written without me "
				.. "leaning over the paper. Recover the old route file for Atlas from the assigned search area in "
				.. "Pripyat. Deliver it to 'Atlas' in Marsh, then come back to me in Marsh."
			),
			completion = "Delivered. He'll ask awkward questions. Better those than a comfortable wrong turn.",
			field = {
				description = (
					"A cardboard file folder with a small coloured crest on its cover. The Original's note: \"Atlas "
					.. "should have the route record.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_official",
				label = "Old route file for Atlas",
				recipient = "atlas",
			},
			benefits = {},
		},
		{
			id = "OR19",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering Pripyat specimen comparison; author "
						.. "actionable guidance tied to verified mechanics and locations."
					),
					id = "the-original/OR19/future",
					kind = "information",
					name = "Record: Pripyat specimen comparison",
					provider = "the-original",
					status = "unimplemented",
					topic = "Pripyat specimen comparison",
				},
			},
			completionCash = 0,
			name = "The Worst of It",
			kind = "tracker",
			requires = {"OR17"},
			briefing = "There are more specimens to bring through. Keep the requested material intact.",
			completion = "You've given me something worth questioning instead of merely agreeing with me.",
			target = 20,
		},
		{
			id = "OR20",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement barter consumer; verify these proposed terms before enabling.
				{
					id = "the-original/OR20/future",
					provider = "the-original",
					status = "unimplemented",
					kind = "barter",
					name = "medic_antirad_1 exchange",
					effect = "Permanent multi-input offer; consume inputs each time, enforce equipment tiers and audit resale value.",
					inputs = {
						{
							item = "part_bloodsucker",
							quantity = 2,
						},
						{
							item = "value_tape_duct",
							quantity = 1,
						},
					},
					outputs = {
						{
							item = "medic_antirad_1",
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
			requires = {"OR18"},
			briefing = (
				"I have a request for you. Bring the things on the list and let me examine them myself; I have "
				.. "seen enough people misidentify what they are holding. Bring everything on the list back here; I "
				.. "need the full delivery."
			),
			completion = "Put those here. I want a proper look before anyone starts telling the story for me.",
			requirements = {
				{
					pool = "town_delivery_collectibles_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_collectibles_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_collectibles_marsh_3",
					quantity = 1,
				},
			},
		},
		{
			id = "OR21",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = "Persistent field reference on specimen transport contamination; author practical, verified guidance.",
					id = "the-original/OR21/future",
					kind = "information",
					name = "Record: specimen transport contamination",
					provider = "the-original",
					status = "unimplemented",
					topic = "specimen transport contamination",
				},
			},
			completionCash = 1775,
			name = "No Two Alike",
			kind = "delivery",
			requires = {"OR19", "OR20"},
			briefing = (
				"I have a request for you. Bring the things on the list and let me examine them myself; I have "
				.. "seen enough people misidentify what they are holding. Bring everything on the list back here; I "
				.. "need the full delivery."
			),
			completion = "Put those here. I want a proper look before anyone starts telling the story for me.",
			requirements = {
				{
					pool = "town_delivery_collectibles_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_collectibles_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_collectibles_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_collectibles_marsh_4",
					quantity = 1,
				},
			},
		},
		{
			id = "OR22",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = "Persistent field reference on mutant seasonal displacement; author practical, verified guidance.",
					id = "the-original/OR22/future",
					kind = "information",
					name = "Record: mutant seasonal displacement",
					provider = "the-original",
					status = "unimplemented",
					topic = "mutant seasonal displacement",
				},
			},
			completionCash = 2450,
			name = "The Place in the Story",
			kind = "field",
			objective = (
				"Recover the encounter witness recording from the assigned search area in Pripyat. Bring it back "
				.. "to the issuing contact in Marsh."
			),
			requires = {"OR21"},
			briefing = (
				"Recover the last encounter recording. I've told the account often enough; it's somebody else's "
				.. "turn to be heard. Recover the encounter witness recording from the assigned search area in "
				.. "Pripyat. Bring it back to me in Marsh."
			),
			completion = "I'll listen. If it contradicts me, we'll talk about that after it's finished.",
			field = {
				description = (
					"A pale audio cassette with a handwritten dedication above the spool windows. The Original's "
					.. "note: \"Recover the last encounter recording.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_tape",
				label = "Encounter witness recording",
			},
		},
		{
			id = "OR23",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = "Persistent field reference on early camp equipment accounts; author practical, verified guidance.",
					id = "the-original/OR23/future",
					kind = "information",
					name = "Record: early camp equipment accounts",
					provider = "the-original",
					status = "unimplemented",
					topic = "early camp equipment accounts",
				},
			},
			completionCash = 0,
			name = "First Does Not Mean Last",
			kind = "tracker",
			requires = {"OR22"},
			briefing = "Keep completing the specimen requests when you're prepared.",
			completion = (
				"You've kept looking after the first easy explanation ran out. I respect that sort of "
				.. "stubbornness."
			),
			target = 27,
		},
		{
			id = "OR24",
			stock = {item = "medic_bandage_1", bonus = 2},
			completionCash = 2650,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"OR23"},
			briefing = (
				"I have a request for you. Bring the things on the list and let me examine them myself; I have "
				.. "seen enough people misidentify what they are holding. Bring everything on the list back here; I "
				.. "need the full delivery."
			),
			completion = "Put those here. I want a proper look before anyone starts telling the story for me.",
			requirements = {
				{
					pool = "town_delivery_collectibles_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_collectibles_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_collectibles_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_collectibles_marsh_4",
					quantity = 1,
				},
			},
			benefits = {},
			recognition = "The Original's trusted contact",
		},
	},
})
