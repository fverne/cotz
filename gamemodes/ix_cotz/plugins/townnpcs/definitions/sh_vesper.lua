PLUGIN:Register("vesper", {
	name = "'Vesper'",
	template = "vespernpc",
	difficultyMultiplier = 2,
	enforceCatalogue = true,
	map = "rp_garbage_cotz",
	courierPools = {
		"valuables_survey_equipment",
		"valuables_filtration",
		"valuables_protective_textiles",
		"valuables_sample_carriers",
	},
	job = {
		kind = "sensor",
		category = "Sensor deployment and retrieval",
		description = "Sensor deployment and retrieval",
		maps = {
			easy = "rp_garbage_cotz",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	legacyJob = {
		kind = "sensor",
		category = "Sensor deployment and retrieval",
		description = "Sensor deployment and retrieval",
		maps = {
			easy = "rp_garbage_cotz",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {},
	rewards = {
		packages = {
			{label = "Exposure treatment", items = {"medic_antirad_1", "medic_antirad_2"}},
			{label = "Field dressings", items = {"medic_bandage_1"}},
			{label = "Canned provisions", items = {"food_can_tuna"}},
		},
		bonusPackages = {
			{label = "Medical supplies", items = {"medic_medkit_1", "medic_antirad_2"}},
			{label = "Waystation stash", items = {"hidestash_2"}},
		},
	},
	dialogue = {
		delivery = "Put it where I can check the label. Tell me if it was damaged on the way.",
		completedGreeting = (
			"Good to see you on this side of the trip. We can talk for a moment before either of us "
			.. "starts planning another."
		),
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Deploy the sensor, let it finish, then collect it. Stay within range and keep yourself fit to "
			.. "carry it home. Decide when you'll turn back before you set out. Don't keep changing that decision "
			.. "just because the recorder isn't quite finished."
		),
		progressionPrompt = "What else needs doing?",
		progression = (
			"There are supplies to sort and field readings to check. Pick a trip you can prepare for. The "
			.. "equipment and the field accounts both need attention. Bring back what the order asks for; we can "
			.. "argue about the interpretation somewhere we can hear ourselves think."
		),
	},
	catalogue = {
		["suit_cs1"] = {step = "VE01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["suit_cs2"] = {step = "VE13",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["suit_cs3"] = {step = "VE24",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
	},
	progression = {
		{
			id = "VE01",
			services = {{id = "suitVariants", name = "Paid suit variant conversions"}},
			completionCash = 275,
			name = "Before the Field",
			kind = "delivery",
			requires = {},
			briefing = (
				"I need supplies for the next trip. Check the list; I would like to spend the walk looking at the "
				.. "field rather than regretting what I packed. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "VE02",
			stock = {item = "suit_cs1", bonus = 1},
			completionCash = 450,
			name = "The Quiet Edge",
			kind = "field",
			objective = (
				"Deploy the recorder at the assigned site in Garbage, let it finish recording, then retrieve the "
				.. "anomaly approach survey recorder. Bring it back to the issuing contact in Garbage."
			),
			requires = {"VE01"},
			briefing = (
				"I'd like a recording from the field approach. A quiet-looking edge still deserves the full "
				.. "preparation. Deploy the recorder at the assigned site in Garbage, let it finish recording, then "
				.. "retrieve the anomaly approach survey recorder. Bring it back to me in Garbage."
			),
			completion = "You're back. I'll check the recorded conditions before calling it a straightforward trip.",
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. Vesper's note: "
					.. "\"I'd like a recording from the field approach.\""
				),
				kind = "sensor",
				map = "rp_garbage_cotz",
				tier = 1,
				cargo = "town_quest_module",
				label = "Anomaly approach survey recorder",
			},
			benefits = {},
		},
		{
			id = "VE03",
			stock = {item = "suit_cs1", bonus = 2},
			completionCash = 0,
			name = "Readings Worth Keeping",
			kind = "tracker",
			requires = {"VE02"},
			briefing = "Continue the sensor surveys. Let the run finish, retrieve the recorder, and return the result.",
			completion = "A useful start. You can enjoy a completed trip now.",
			target = 2,
			benefits = {},
		},
		{
			id = "VE04",
			completionCash = 650,
			name = "A small delivery",
			kind = "delivery",
			retiredCommission = true,
			objective = "Bring all 1 listed item type to this contact. The request shows each selected item and required units.",
			requires = {"VE02"},
			briefing = (
				"I need supplies for the next trip. Check the list; I would like to spend the walk looking at the "
				.. "field rather than regretting what I packed. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
			requirements = {
				{
					pool = "town_delivery_research_marsh_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "VE05",
			completionCash = 575,
			name = "Reliable Instruments",
			kind = "delivery",
			requires = {"VE03"},
			briefing = (
				"I need supplies for the next trip. Check the list; I would like to spend the walk looking at the "
				.. "field rather than regretting what I packed. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
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
			id = "VE06",
			completionCash = 850,
			name = "The Second Field",
			kind = "field",
			objective = (
				"Deploy the recorder at the assigned site in Garbage, let it finish recording, then retrieve the "
				.. "second field survey recorder. Bring it back to the issuing contact in Garbage."
			),
			requires = {"VE04"},
			briefing = (
				"We need another field recording. Don't pack for the last trip simply because this one sounds "
				.. "similar. Deploy the recorder at the assigned site in Garbage, let it finish recording, then "
				.. "retrieve the second field survey recorder. Bring it back to me in Garbage."
			),
			completion = "Set it down. I'll keep this reading separate while I compare the conditions.",
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. Vesper's note: "
					.. "\"We need another field recording.\""
				),
				kind = "sensor",
				map = "rp_garbage_cotz",
				tier = 1,
				cargo = "town_quest_module",
				label = "Second field survey recorder",
			},
			benefits = {},
		},
		{
			id = "VE07",
			stock = {item = "suit_cs1", bonus = 3},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering field boundary observations; author "
						.. "actionable guidance tied to verified mechanics and locations."
					),
					id = "vesper/VE07/future",
					kind = "information",
					name = "Record: field boundary observations",
					provider = "vesper",
					status = "unimplemented",
					topic = "field boundary observations",
				},
			},
			completionCash = 0,
			name = "Same Method Twice",
			kind = "tracker",
			requires = {"VE05"},
			briefing = "More survey recordings when prepared. Check the return before accepting.",
			completion = "You've kept the work consistent. That gives us something worth comparing.",
			target = 5,
		},
		{
			id = "VE08",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering detector preparation; author actionable "
						.. "guidance tied to verified mechanics and locations."
					),
					id = "vesper/VE08/future",
					kind = "information",
					name = "Record: detector preparation",
					provider = "vesper",
					status = "unimplemented",
					topic = "detector preparation",
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
			requires = {"VE06"},
			briefing = (
				"I need supplies for the next trip. Check the list; I would like to spend the walk looking at the "
				.. "field rather than regretting what I packed. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
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
			id = "VE09",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering Marsh anomaly comparison; author "
						.. "actionable guidance tied to verified mechanics and locations."
					),
					id = "vesper/VE09/future",
					kind = "information",
					name = "Record: Marsh anomaly comparison",
					provider = "vesper",
					status = "unimplemented",
					topic = "Marsh anomaly comparison",
				},
			},
			completionCash = 875,
			name = "Keep It Sealed",
			kind = "delivery",
			requires = {"VE07"},
			briefing = (
				"I need supplies for the next trip. Check the list; I would like to spend the walk looking at the "
				.. "field rather than regretting what I packed. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
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
			id = "VE10",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering Garbage anomaly comparison; author "
						.. "actionable guidance tied to verified mechanics and locations."
					),
					id = "vesper/VE10/future",
					kind = "information",
					name = "Record: Garbage anomaly comparison",
					provider = "vesper",
					status = "unimplemented",
					topic = "Garbage anomaly comparison",
				},
			},
			completionCash = 1250,
			name = "The Unstable Reading",
			kind = "field",
			objective = (
				"Recover the disputed-site audio record from the assigned search area in Garbage. Bring it back to "
				.. "the issuing contact in Garbage."
			),
			requires = {"VE08"},
			briefing = (
				"Recover the disputed site's recording. An unstable reading is interesting, but I'd prefer it "
				.. "somewhere I can listen without watching the ground. Recover the disputed-site audio record from "
				.. "the assigned search area in Garbage. Bring it back to me in Garbage."
			),
			completion = "Leave it here. We'll hear the whole account before choosing the exciting explanation.",
			field = {
				description = (
					"A pale audio cassette with a handwritten dedication above the spool windows. Vesper's note: "
					.. "\"Recover the disputed site's recording.\""
				),
				kind = "recovery",
				map = "rp_garbage_cotz",
				tier = 2,
				cargo = "town_quest_tape",
				label = "Disputed-site audio record",
			},
		},
		{
			id = "VE11",
			stock = {item = "suit_cs1", bonus = 4},
			completionCash = 0,
			name = "Outside Familiar Ground",
			kind = "tracker",
			requires = {"VE09"},
			briefing = "Keep completing the sensor work while I examine the recovered accounts.",
			completion = "A steady run of results. I appreciate the attention between departures.",
			target = 9,
			benefits = {},
		},
		{
			id = "VE12",
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering Waystation anomaly comparison; author "
						.. "actionable guidance tied to verified mechanics and locations."
					),
					id = "vesper/VE12/future",
					kind = "information",
					name = "Record: Waystation anomaly comparison",
					provider = "vesper",
					status = "unimplemented",
					topic = "Waystation anomaly comparison",
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
			requires = {"VE10"},
			briefing = (
				"I need supplies for the next trip. Check the list; I would like to spend the walk looking at the "
				.. "field rather than regretting what I packed. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
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
			id = "VE13",
			completionCash = 1175,
			name = "Supplies for Distance",
			kind = "delivery",
			requires = {"VE11"},
			briefing = (
				"I need supplies for the next trip. Check the list; I would like to spend the walk looking at the "
				.. "field rather than regretting what I packed. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
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
			id = "VE14",
			completionCash = 1650,
			name = "The Lost Team's Notes",
			kind = "field",
			objective = (
				"Recover the prospecting log for Wake from the assigned search area in Waystation. Deliver it to "
				.. "'Wake' in Garbage, then come back to the issuing contact in Garbage."
			),
			requires = {"VE12"},
			briefing = (
				"Wake needs the lost team's log. She should have the people and the route in their own words, not "
				.. "my selection of technical details. Recover the prospecting log for Wake from the assigned search "
				.. "area in Waystation. Deliver it to 'Wake' in Garbage, then come back to me in Garbage."
			),
			completion = "Delivered. She can take time with it before we compare our questions.",
			field = {
				description = (
					"A thick blue diary with a label fixed to the front cover. Vesper's note: \"Wake needs the lost "
					.. "team's log.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_diary",
				label = "Prospecting log for Wake",
				recipient = "wake",
			},
			benefits = {},
		},
		{
			id = "VE15",
			stock = {item = "suit_cs2", bonus = 1},
			completionCash = 0,
			name = "Know When to Leave",
			kind = "tracker",
			requires = {"VE13"},
			briefing = "Continue the survey assignments. Prepare for this trip rather than relying on the last one.",
			completion = "You've stayed careful as the work accumulated. Good.",
			target = 14,
			benefits = {},
		},
		{
			id = "VE16",
			completionCash = 1850,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"VE14"},
			briefing = (
				"I need supplies for the next trip. Check the list; I would like to spend the walk looking at the "
				.. "field rather than regretting what I packed. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
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
			id = "VE17",
			stock = {item = "suit_cs2", bonus = 2},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering Pripyat anomaly comparison; author "
						.. "actionable guidance tied to verified mechanics and locations."
					),
					id = "vesper/VE17/future",
					kind = "information",
					name = "Record: Pripyat anomaly comparison",
					provider = "vesper",
					status = "unimplemented",
					topic = "Pripyat anomaly comparison",
				},
			},
			completionCash = 1475,
			name = "No Borrowed Luck",
			kind = "delivery",
			requires = {"VE15"},
			briefing = (
				"I need supplies for the next trip. Check the list; I would like to spend the walk looking at the "
				.. "field rather than regretting what I packed. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
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
			id = "VE18",
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering weather and visibility; author actionable "
						.. "guidance tied to verified mechanics and locations."
					),
					id = "vesper/VE18/future",
					kind = "information",
					name = "Record: weather and visibility",
					provider = "vesper",
					status = "unimplemented",
					topic = "weather and visibility",
				},
			},
			completionCash = 2050,
			name = "The Team's Cache",
			kind = "field",
			objective = (
				"Recover the lost team's equipment case from the assigned search area in Garbage. Bring it back to "
				.. "the issuing contact in Garbage."
			),
			requires = {"VE16"},
			briefing = (
				"Recover the team's equipment case intact. I want to see what survived before making a story about "
				.. "what they must have needed. Recover the lost team's equipment case from the assigned search area "
				.. "in Garbage. Bring it back to me in Garbage."
			),
			completion = "Set it somewhere steady. I'll inspect it before separating anything.",
			field = {
				description = (
					"A low hard case with long contrasting strips across its ribbed lid. Vesper's note: \"Recover the "
					.. "team's equipment case intact.\""
				),
				kind = "recovery",
				map = "rp_garbage_cotz",
				tier = 2,
				cargo = "town_quest_equipment",
				label = "Lost team's equipment case",
			},
			benefits = {},
		},
		{
			id = "VE19",
			stock = {item = "suit_cs2", bonus = 3},
			completionCash = 0,
			name = "A Measured Risk",
			kind = "tracker",
			requires = {"VE17"},
			briefing = "There are more recordings to make. Bring the completed results home.",
			completion = "A lot of work returned now. I'm glad you've given the return its share of the preparation.",
			target = 20,
			benefits = {},
		},
		{
			id = "VE20",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering survey withdrawal criteria; author "
						.. "actionable guidance tied to verified mechanics and locations."
					),
					id = "vesper/VE20/future",
					kind = "information",
					name = "Record: survey withdrawal criteria",
					provider = "vesper",
					status = "unimplemented",
					topic = "survey withdrawal criteria",
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
			requires = {"VE18"},
			briefing = (
				"I need supplies for the next trip. Check the list; I would like to spend the walk looking at the "
				.. "field rather than regretting what I packed. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
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
			id = "VE21",
			completionCash = 1775,
			name = "Enough to Compare",
			kind = "delivery",
			requires = {"VE19", "VE20"},
			briefing = (
				"I need supplies for the next trip. Check the list; I would like to spend the walk looking at the "
				.. "field rather than regretting what I packed. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
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
			id = "VE22",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering protective equipment checklist; author "
						.. "actionable guidance tied to verified mechanics and locations."
					),
					id = "vesper/VE22/future",
					kind = "information",
					name = "Record: protective equipment checklist",
					provider = "vesper",
					status = "unimplemented",
					topic = "protective equipment checklist",
				},
			},
			completionCash = 2450,
			name = "A Different Explanation",
			kind = "field",
			objective = (
				"Recover the control cassette for Carbon from the assigned search area in Pripyat. Deliver it to "
				.. "'Carbon' in Waystation, then come back to the issuing contact in Garbage."
			),
			requires = {"VE21"},
			briefing = (
				"Carbon needs the recovered control recording. Another reading of the account may show where we've "
				.. "been asking it the wrong question. Recover the control cassette for Carbon from the assigned "
				.. "search area in Pripyat. Deliver it to 'Carbon' in Waystation, then come back to me in Garbage."
			),
			completion = "He has it. Good. I'll wait for his questions instead of preparing an answer for him.",
			field = {
				description = (
					"A pale audio cassette with a handwritten dedication above the spool windows. Vesper's note: "
					.. "\"Carbon needs the recovered control recording.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_tape",
				label = "Control cassette for Carbon",
				recipient = "carbon",
			},
		},
		{
			id = "VE23",
			stock = {item = "suit_cs2", bonus = 4},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering artifact recovery notes; author actionable "
						.. "guidance tied to verified mechanics and locations."
					),
					id = "vesper/VE23/future",
					kind = "information",
					name = "Record: artifact recovery notes",
					provider = "vesper",
					status = "unimplemented",
					topic = "artifact recovery notes",
				},
			},
			completionCash = 0,
			name = "Everyone Comes Back",
			kind = "tracker",
			requires = {"VE22"},
			briefing = "Keep the survey recordings going when you're ready.",
			completion = (
				"You've made yourself dependable company for this work. I'd be pleased to discuss another trip "
				.. "after we've enjoyed finishing these."
			),
			target = 27,
		},
		{
			id = "VE24",
			completionCash = 2650,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"VE23"},
			briefing = (
				"I need supplies for the next trip. Check the list; I would like to spend the walk looking at the "
				.. "field rather than regretting what I packed. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thanks. I will check these with the rest of the kit before leaving.",
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
			recognition = "Vesper's trusted contact",
		},
	},
})
