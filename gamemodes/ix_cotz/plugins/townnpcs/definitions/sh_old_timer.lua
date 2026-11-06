PLUGIN:Register("old-timer", {
	name = "'Old Timer'",
	template = "tutorialnpc",
	difficultyMultiplier = 3,
	enforceCatalogue = true,
	map = "rp_marsh_cs",
	courierPools = {
		"valuables_workshop_tools",
		"valuables_cutting_tools",
		"valuables_protective_textiles",
		"valuables_field_records",
	},
	job = {
		kind = "regionalHunting",
		category = "Specific mutant hunting",
		description = "Specific mutant hunting",
		maps = {
			easy = "rp_marsh_cs",
			medium = "rp_garbage_cotz",
			hard = "rp_waystation",
		},
	},
	legacyJob = {
		kind = "hunting",
		category = "Mutant hunting",
		description = "Mutant hunting",
		quantities = {5, 9, 15},
	},
	supplies = {},
	rewards = {
		packages = {
			{label = "Small-game shells", items = {"45acp41"}},
			{label = "Edge upkeep", items = {"sharpening_stone"}},
			{label = "Canned provisions", items = {"food_can_tushonka"}},
		},
		bonusPackages = {
			{label = "Fine edge upkeep", items = {"sharpening_stone_fine"}},
			{label = "Swamps stash", items = {"hidestash_1"}},
		},
	},
	dialogue = {
		completedGreeting = (
			"Good to see you. Put the pack down if you're staying a while; you don't have to stand ready "
			.. "to leave every minute."
		),
		workPrompt = "About the hunt I'm on.",
		offerPrompt = "Do you have a mutant hunting job?",
		work = (
			"Mutant hunting. Read the quarry on the order and prepare for the return as carefully as the hunt. "
			.. "Don't chase a wounded animal so far you forget where you've left yourself room to go. I'll have "
			.. "more work if you come back. I won't complain if you take time to make that likely."
		),
		progressionPrompt = "What needs doing next?",
		progression = (
			"There are supplies to bring in and field records I'd like recovered. We can start with something "
			.. "manageable. I want you to learn the walks without pretending every trip needs to prove a point. "
			.. "Where a record belongs with somebody else, the order says so. Deliver it, then come back here."
		),
	},
	catalogue = {
		["hatchet"] = {step = "OT19",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["helm_steel_arab"] = {step = "OT10",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["helm_steel_ger"] = {step = "OT19",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["helm_steel_rus"] = {step = "OT28",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["helm_tanker"] = {step = "OT01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["knife2"] = {step = "OT01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["knife3"] = {step = "OT14",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["knife4"] = {step = "OT28",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["machete"] = {step = "OT28",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["sharpening_stone"] = {step = "OT01",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["sharpening_stone_fine"] = {step = "OT10",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
	},
	progression = {
		{
			id = "OT01",
			completionCash = 275,
			name = "Before You Leave",
			kind = "delivery",
			requires = {},
			briefing = (
				"There are supplies I would like brought in. Read the list before setting off, and leave enough "
				.. "room for what you need yourself. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "That will do. Put it there, then check what you have left for your own walk.",
			requirements = {
				{
					pool = "town_delivery_trail_marsh_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "OT02",
			stock = {item = "sharpening_stone", bonus = 1},
			completionCash = 450,
			name = "Know Your Ground",
			kind = "field",
			objective = (
				"Recover the Marsh field notebook from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"OT01"},
			briefing = (
				"There's a field notebook out in Marsh. I'd like you to pay attention to the walk as well as "
				.. "bringing the book back. Recover the Marsh field notebook from the assigned search area in Marsh. "
				.. "Bring it back to me in Marsh."
			),
			completion = "You found it and came home. Tell me where the walk became awkward, if it did.",
			field = {
				description = (
					"A thick brown journal held together by a narrow tie around its cover. Old Timer's note: \"There's "
					.. "a field notebook out in Marsh.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "Marsh field notebook",
			},
			benefits = {},
		},
		{
			id = "OT03",
			stock = {item = "helm_tanker", bonus = 1},
			completionCash = 0,
			name = "Something With Teeth",
			kind = "tracker",
			requires = {"OT02"},
			briefing = "Keep completing the mutant hunting orders. Read the quarry before setting off.",
			completion = "A few hunts finished. Don't let that persuade you the next one needs less preparation.",
			target = 2,
			benefits = {},
		},
		{
			id = "OT04",
			stock = {item = "knife2", bonus = 1},
			completionCash = 650,
			name = "A small delivery",
			kind = "delivery",
			retiredCommission = true,
			objective = "Bring all 1 listed item type to this contact. The request shows each selected item and required units.",
			requires = {"OT03"},
			briefing = (
				"There are supplies I would like brought in. Read the list before setting off, and leave enough "
				.. "room for what you need yourself. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "That will do. Put it there, then check what you have left for your own walk.",
			requirements = {
				{
					pool = "town_delivery_trail_marsh_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "OT05",
			stock = {item = "sharpening_stone", bonus = 2},
			completionCash = 575,
			name = "A Place to Hide",
			kind = "delivery",
			requires = {"OT04"},
			briefing = (
				"There are supplies I would like brought in. Read the list before setting off, and leave enough "
				.. "room for what you need yourself. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "That will do. Put it there, then check what you have left for your own walk.",
			requirements = {
				{
					pool = "town_delivery_trail_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "OT06",
			stock = {item = "helm_tanker", bonus = 2},
			completionCash = 850,
			name = "Ready Enough",
			kind = "field",
			objective = (
				"Recover the expedition supply case from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"OT04"},
			briefing = (
				"A supply case is still outside camp. Leave room to bring it home without throwing away what you "
				.. "need for yourself. Recover the expedition supply case from the assigned search area in Marsh. "
				.. "Bring it back to me in Marsh."
			),
			completion = "Both loads home, then. Good. Put it down before you start telling me it wasn't heavy.",
			field = {
				description = (
					"A small yellow hard case with ribbed corners and a large label on its lid. Old Timer's note: \"A "
					.. "supply case is still outside camp.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_case",
				label = "Expedition supply case",
			},
			benefits = {},
		},
		{
			id = "OT07",
			stock = {item = "knife2", bonus = 2},
			completionCash = 0,
			name = "Look After Your Kit",
			kind = "tracker",
			requires = {"OT05"},
			briefing = "More specified hunts when you're ready. Bring enough supplies for the return.",
			completion = "You've kept coming back with the work done. That's the part I like hearing.",
			target = 5,
			benefits = {},
		},
		{
			id = "OT08",
			capacity = {kind = "weight", amount = 1},
			completionCash = 1050,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"OT06"},
			briefing = (
				"There are supplies I would like brought in. Read the list before setting off, and leave enough "
				.. "room for what you need yourself. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "That will do. Put it there, then check what you have left for your own walk.",
			requirements = {
				{
					pool = "town_delivery_trail_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "OT09",
			completionCash = 875,
			name = "Bad Water",
			kind = "delivery",
			requires = {"OT07"},
			briefing = (
				"There are supplies I would like brought in. Read the list before setting off, and leave enough "
				.. "room for what you need yourself. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "That will do. Put it there, then check what you have left for your own walk.",
			requirements = {
				{
					pool = "town_delivery_trail_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "OT10",
			completionCash = 1250,
			name = "Enough for the Walk Home",
			kind = "field",
			objective = (
				"Recover the return-route provisions from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"OT08"},
			briefing = (
				"I want the lost supply case recovered. The return journey still needs food and water even when "
				.. "the search went well. Recover the return-route provisions from the assigned search area in Marsh. "
				.. "Bring it back to me in Marsh."
			),
			completion = "You're back. Keep your own supplies to hand while I check the case.",
			field = {
				description = (
					"A small yellow hard case with ribbed corners and a large label on its lid. Old Timer's note: \"I "
					.. "want the lost supply case recovered.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_case",
				label = "Return-route provisions",
			},
			benefits = {},
		},
		{
			id = "OT11",
			stock = {item = "sharpening_stone_fine", bonus = 1},
			completionCash = 0,
			name = "Old Habits",
			kind = "tracker",
			requires = {"OT09"},
			briefing = "Continue the hunting orders. Leave room in the plan for turning back.",
			completion = "A steady amount of work. You've had time to learn which preparations you actually use.",
			target = 9,
			benefits = {},
		},
		{
			id = "OT12",
			stock = {item = "helm_steel_arab", bonus = 1},
			completionCash = 1450,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"OT10"},
			briefing = (
				"There are supplies I would like brought in. Read the list before setting off, and leave enough "
				.. "room for what you need yourself. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "That will do. Put it there, then check what you have left for your own walk.",
			requirements = {
				{
					pool = "town_delivery_trail_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "OT13",
			completionCash = 1175,
			name = "Tracks at the Fence",
			kind = "delivery",
			requires = {"OT11"},
			briefing = (
				"There are supplies I would like brought in. Read the list before setting off, and leave enough "
				.. "room for what you need yourself. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "That will do. Put it there, then check what you have left for your own walk.",
			requirements = {
				{
					pool = "town_delivery_trail_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "OT14",
			completionCash = 1650,
			name = "Thin the Pack",
			kind = "field",
			objective = (
				"Recover the pack observer's notes from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"OT12"},
			briefing = (
				"There's an observer's account to recover from the hunting site. I'd like to compare what was seen "
				.. "with what people remember hearing. Recover the pack observer's notes from the assigned search "
				.. "area in Marsh. Bring it back to me in Marsh."
			),
			completion = "Good. I'll start with the observations before reading anybody's explanation.",
			field = {
				description = (
					"A thick brown journal held together by a narrow tie around its cover. Old Timer's note: \"There's "
					.. "an observer's account to recover from the hunting site.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_notebook",
				label = "Pack observer's notes",
			},
			benefits = {},
		},
		{
			id = "OT15",
			stock = {item = "knife3", bonus = 1},
			completionCash = 0,
			name = "What They Leave Behind",
			kind = "tracker",
			requires = {"OT13"},
			briefing = "Keep at the assigned hunts. The last success doesn't pack the next bag.",
			completion = "You've stayed with it. I hope you've been looking after yourself between trips too.",
			target = 14,
			benefits = {},
		},
		{
			id = "OT16",
			capacity = {kind = "weight", amount = 1},
			completionCash = 1850,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"OT14"},
			briefing = (
				"There are supplies I would like brought in. Read the list before setting off, and leave enough "
				.. "room for what you need yourself. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "That will do. Put it there, then check what you have left for your own walk.",
			requirements = {
				{
					pool = "town_delivery_trail_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "OT17",
			stock = {item = "sharpening_stone_fine", bonus = 2},
			completionCash = 1475,
			name = "The Empty Camp",
			kind = "delivery",
			requires = {"OT15"},
			briefing = (
				"There are supplies I would like brought in. Read the list before setting off, and leave enough "
				.. "room for what you need yourself. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "That will do. Put it there, then check what you have left for your own walk.",
			requirements = {
				{
					pool = "town_delivery_trail_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "OT18",
			completionCash = 2050,
			name = "Leave a Way Out",
			kind = "field",
			objective = (
				"Recover the missing party's route notes from the assigned search area in Marsh. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"OT16"},
			briefing = (
				"Recover the route observations. A party's intended path isn't always the one they managed to "
				.. "walk. Recover the missing party's route notes from the assigned search area in Marsh. Bring it "
				.. "back to me in Marsh."
			),
			completion = (
				"Let's look at the whole account. I don't want a guess hardening into the route simply because we "
				.. "keep repeating it."
			),
			field = {
				description = (
					"A thick blue diary with a label fixed to the front cover. Old Timer's note: \"Recover the route "
					.. "observations.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_diary",
				label = "Missing party's route notes",
			},
			benefits = {},
		},
		{
			id = "OT19",
			stock = {item = "hatchet", bonus = 1},
			completionCash = 0,
			name = "An Old Name",
			kind = "tracker",
			requires = {"OT17"},
			briefing = "More hunting work while I compare the records. Keep to the specified quarry.",
			completion = "You've put a lot of walking behind those returns. I notice more than the total.",
			target = 20,
			benefits = {},
		},
		{
			id = "OT20",
			stock = {item = "helm_steel_ger", bonus = 1},
			completionCash = 2250,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"OT18"},
			briefing = (
				"There are supplies I would like brought in. Read the list before setting off, and leave enough "
				.. "room for what you need yourself. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "That will do. Put it there, then check what you have left for your own walk.",
			requirements = {
				{
					pool = "town_delivery_trail_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "OT21",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on quarry signs; author actionable guidance tied to verified "
						.. "mechanics and locations."
					),
					id = "old-timer/OT21/future",
					kind = "information",
					name = "Record: quarry signs",
					provider = "old-timer",
					status = "unimplemented",
					topic = "quarry signs",
				},
			},
			completionCash = 1775,
			name = "Someone Kept Records",
			kind = "delivery",
			requires = {"OT19"},
			briefing = (
				"There are supplies I would like brought in. Read the list before setting off, and leave enough "
				.. "room for what you need yourself. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "That will do. Put it there, then check what you have left for your own walk.",
			requirements = {
				{
					pool = "town_delivery_trail_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_marsh_3",
					quantity = 1,
				},
			},
		},
		{
			id = "OT22",
			stock = {item = "hatchet", bonus = 2},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on safe retreat planning; author actionable guidance tied to "
						.. "verified mechanics and locations."
					),
					id = "old-timer/OT22/future",
					kind = "information",
					name = "Record: safe retreat planning",
					provider = "old-timer",
					status = "unimplemented",
					topic = "safe retreat planning",
				},
			},
			completionCash = 2450,
			name = "A Voice on Tape",
			kind = "field",
			objective = (
				"Recover the recording for Spool from the assigned search area in Waystation. Deliver it to "
				.. "'Spool' in Garbage, then come back to the issuing contact in Marsh."
			),
			requires = {"OT20"},
			briefing = (
				"Spool should hear the recording. He listens more carefully than most people talk. Recover the "
				.. "recording for Spool from the assigned search area in Waystation. Deliver it to 'Spool' in "
				.. "Garbage, then come back to me in Marsh."
			),
			completion = "You delivered it and came back. That's what I asked. Let him listen before we ask for an answer.",
			field = {
				description = (
					"A pale audio cassette with a broad blue printed label and twin spool windows. Old Timer's note: "
					.. "\"Spool should hear the recording.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_tape2",
				label = "Recording for Spool",
				recipient = "spool",
			},
		},
		{
			id = "OT23",
			stock = {item = "helm_steel_arab", bonus = 2},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on wounded mutant trails; author actionable guidance tied to "
						.. "verified mechanics and locations."
					),
					id = "old-timer/OT23/future",
					kind = "information",
					name = "Record: wounded mutant trails",
					provider = "old-timer",
					status = "unimplemented",
					topic = "wounded mutant trails",
				},
			},
			completionCash = 0,
			name = "What He Was Carrying",
			kind = "tracker",
			requires = {"OT21"},
			briefing = "Continue the hunting assignments when you've rested and prepared.",
			completion = "You've been dependable over time. I worry less when I know you've thought about the return.",
			target = 27,
		},
		{
			id = "OT24",
			stock = {item = "helm_steel_ger", bonus = 2},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on night hunting; author actionable guidance tied to verified "
						.. "mechanics and locations."
					),
					id = "old-timer/OT24/future",
					kind = "information",
					name = "Record: night hunting",
					provider = "old-timer",
					status = "unimplemented",
					topic = "night hunting",
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
			requires = {"OT22"},
			briefing = (
				"There are supplies I would like brought in. Read the list before setting off, and leave enough "
				.. "room for what you need yourself. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "That will do. Put it there, then check what you have left for your own walk.",
			requirements = {
				{
					pool = "town_delivery_trail_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_trail_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_marsh_4",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "OT25",
			stock = {item = "knife3", bonus = 2},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on companion expedition notes; author actionable guidance "
						.. "tied to verified mechanics and locations."
					),
					id = "old-timer/OT25/future",
					kind = "information",
					name = "Record: companion expedition notes",
					provider = "old-timer",
					status = "unimplemented",
					topic = "companion expedition notes",
				},
			},
			completionCash = 2000,
			name = "Past the Turn Back Point",
			kind = "delivery",
			requires = {"OT23", "OT24"},
			briefing = (
				"There are supplies I would like brought in. Read the list before setting off, and leave enough "
				.. "room for what you need yourself. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "That will do. Put it there, then check what you have left for your own walk.",
			requirements = {
				{
					pool = "town_delivery_trail_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_trail_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_marsh_4",
					quantity = 1,
				},
			},
		},
		{
			id = "OT26",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on carcass handling; author actionable guidance tied to "
						.. "verified mechanics and locations."
					),
					id = "old-timer/OT26/future",
					kind = "information",
					name = "Record: carcass handling",
					provider = "old-timer",
					status = "unimplemented",
					topic = "carcass handling",
				},
			},
			completionCash = 2850,
			name = "He Made It This Far",
			kind = "field",
			objective = (
				"Recover the companion's recovered equipment from the assigned search area in Pripyat. Bring it "
				.. "back to the issuing contact in Marsh."
			),
			requires = {"OT25"},
			briefing = (
				"There's a final equipment case to collect. Keep the small things with it. I want to see what "
				.. "survived together. Recover the companion's recovered equipment from the assigned search area in "
				.. "Pripyat. Bring it back to me in Marsh."
			),
			completion = "Put it here. Don't rush to explain what you think it means. Give me a moment to look.",
			field = {
				description = (
					"A thick worn photograph album with a small picture set into its brown cover. Old Timer's note: "
					.. "\"There's a final equipment case to collect.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_photo",
				label = "Companion's recovered equipment",
			},
		},
		{
			id = "OT27",
			stock = {item = "sharpening_stone", bonus = 3},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on Pripyat return preparation; author actionable guidance "
						.. "tied to verified mechanics and locations."
					),
					id = "old-timer/OT27/future",
					kind = "information",
					name = "Record: Pripyat return preparation",
					provider = "old-timer",
					status = "unimplemented",
					topic = "Pripyat return preparation",
				},
			},
			completionCash = 0,
			name = "Bring Him Home",
			kind = "tracker",
			requires = {"OT26"},
			briefing = "Keep completing the specified hunts. You're allowed a quiet day between them.",
			completion = "Still coming home. Still doing the work carefully. I'm pleased to see both.",
			target = 35,
		},
		{
			id = "OT28",
			completionCash = 3000,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"OT27"},
			briefing = (
				"There are supplies I would like brought in. Read the list before setting off, and leave enough "
				.. "room for what you need yourself. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "That will do. Put it there, then check what you have left for your own walk.",
			requirements = {
				{
					pool = "town_delivery_trail_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_trail_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_marsh_4",
					quantity = 1,
				},
			},
			benefits = {},
			recognition = "Old Timer's trusted contact",
		},
	},
})
