PLUGIN:Register("intern", {
	name = "'Intern'",
	template = "ecologistnpc3",
	difficultyMultiplier = 4,
	enforceCatalogue = true,
	map = "rp_marsh_cs",
	bunker = true,
	courierPools = {
		"valuables_survey_equipment",
		"valuables_sample_carriers",
		"valuables_portable_power",
		"valuables_field_records",
	},
	job = {
		kind = "sensor",
		category = "Sensor deployment and retrieval",
		description = "Sensor deployment and retrieval",
		maps = {
			easy = "rp_marsh_cs",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	legacyJob = {
		kind = "sensor",
		category = "Bunker sensor deployment and retrieval",
		description = "Sensor deployment and retrieval",
		maps = {
			easy = "rp_marsh_cs",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {},
	rewards = {
		packages = {
			{label = "Exposure treatment", items = {"medic_antirad_1"}},
			{label = "Overtime", items = {"drug_caffeine"}},
			{label = "Canned provisions", items = {"food_can_corn"}},
		},
		bonusPackages = {
			{label = "Emergency medicine", items = {"medic_stimpak_1"}},
			{label = "Euro notes", items = {"value_currency_euro"}},
		},
	},
	dialogue = {
		jobBriefing = "I have a survey I can use some help with. {details}",
		jobReminder = "I'm keeping the rest of the survey together while you're out there. {details}",
		jobFinished = "Thank you. I'll check it against my notes. Let's settle your payment first.",
		completedGreeting = (
			"Hello! I've been keeping my own notes in order. It's rather nice to know what I want to say "
			.. "before anyone asks."
		),
		workPrompt = "About the survey I'm doing.",
		offerPrompt = "Do you have a sensor survey?",
		work = (
			"Sensor surveys. Deploy the recorder at the assigned site, let the run finish, then retrieve it and "
			.. "bring the results back. Check the destination before accepting. I can examine a complete "
			.. "recording; I can't recreate the part we missed by looking increasingly worried at the page. I've "
			.. "tested that approach rather thoroughly."
		),
		progressionPrompt = "What needs checking in your survey work?",
		progression = (
			"I'd like to follow a survey through from preparation to comparison. There are supplies to collect "
			.. "and earlier records to recover before I can explain the complete account. We can start with an "
			.. "ordinary request. If a result disagrees, I'd rather discover that than arrange the notes until it "
			.. "stops looking troublesome."
		),
	},
	-- Author-disabled suggestions must not be restored by catalogue or stock generation.
	disabledItems = {
		["gasanalyzer"] = true,
	},
	catalogue = {
		-- ["gasanalyzer"] = {step = "IN01",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["338lapua"] = {step = "IN13",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["338lapuaap"] = {step = "IN15",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["338lapuahp"] = {step = "IN14",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["545x39"] = {step = "IN01",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["545x39ap"] = {step = "IN03",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["545x39hp"] = {step = "IN02",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["556x45"] = {step = "IN04",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["556x45ap"] = {step = "IN06",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["556x45hp"] = {step = "IN05",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x39"] = {step = "IN04",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x39ap"] = {step = "IN06",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x39hp"] = {step = "IN05",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x51"] = {step = "IN10",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x51ap"] = {step = "IN12",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x51hp"] = {step = "IN11",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x54"] = {step = "IN13",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x54ap"] = {step = "IN15",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x54hp"] = {step = "IN14",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["9x39"] = {step = "IN07",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["9x39ap"] = {step = "IN09",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["9x39hp"] = {step = "IN08",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["accesscard_laboratory"] = {step = "IN24",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
	},
	progression = {
		{
			id = "IN01",
			completionCash = 275,
			name = "An Instrument of My Own",
			kind = "delivery",
			requires = {},
			briefing = (
				"I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely "
				.. "on the readings. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "common_artifacts",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "IN02",
			completionCash = 450,
			name = "The Calibration Point",
			kind = "field",
			objective = (
				"Deploy the recorder at the assigned site in Waystation, let it finish recording, then retrieve "
				.. "the first calibration recorder. Bring it back to the issuing contact in Marsh."
			),
			requires = {"IN01"},
			briefing = (
				"I'd like to start with a recording near Waystation. I want to check my preparation against a "
				.. "complete return, not just an instrument on a shelf. Deploy the recorder at the assigned site in "
				.. "Waystation, let it finish recording, then retrieve the first calibration recorder. Bring it back "
				.. "to me in Waystation."
			),
			completion = "You brought it back. Good. I'll compare the setup notes before I look for the reading I expected.",
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. Intern's note: "
					.. "\"I'd like to start with a recording near Waystation.\""
				),
				kind = "sensor",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_module",
				label = "First calibration recorder",
			},
			benefits = {},
		},
		{
			id = "IN03",
			stock = {item = "545x39", bonus = 1},
			completionCash = 0,
			name = "Readings on Time",
			kind = "tracker",
			requires = {"IN02"},
			briefing = "Continue the survey recordings. Let each run finish, collect the results, and return them.",
			completion = "A few complete runs. I can start comparing the preparation with the returns.",
			target = 2,
			benefits = {},
		},
		{
			id = "IN04",
			completionCash = 650,
			name = "A small delivery",
			kind = "delivery",
			retiredCommission = true,
			objective = "Bring all 1 listed item type to this contact. The request shows each selected item and required units.",
			requires = {"IN02"},
			briefing = (
				"I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely "
				.. "on the readings. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "common_artifacts",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "IN05",
			completionCash = 575,
			name = "Clean Containers",
			kind = "delivery",
			requires = {"IN03"},
			briefing = (
				"I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely "
				.. "on the readings. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "common_artifacts",
					quantity = 2,
				},
				{
					pool = "electrical_artifacts",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "IN06",
			completionCash = 850,
			name = "Beanstalk's Control",
			kind = "field",
			objective = (
				"Deploy the recorder at the assigned site in Garbage, let it finish recording, then retrieve the "
				.. "Garbage control recorder. Bring it back to the issuing contact in Marsh."
			),
			requires = {"IN04"},
			briefing = (
				"We need a recording at the Garbage control site. I'd like a comparison I can explain without "
				.. "borrowing somebody else's confidence. Deploy the recorder at the assigned site in Garbage, let it "
				.. "finish recording, then retrieve the Garbage control recorder. Bring it back to me in Waystation."
			),
			completion = "Here it is. I'll keep the control separate while I check the records.",
			field = {
				description = (
					"A flat dark electronic module marked with a number and three pale bars. Intern's note: \"We need "
					.. "a recording at the Garbage control site.\""
				),
				kind = "sensor",
				map = "rp_garbage_cotz",
				tier = 1,
				cargo = "town_quest_module2",
				label = "Garbage control recorder",
			},
			benefits = {},
		},
		{
			id = "IN07",
			stock = {item = "545x39ap", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement cosmetic consumer; verify these proposed terms before enabling.
				{
					baseSuit = "suit_anorak",
					effect = "Apply survey team colours to suit_anorak; appearance only, with no gameplay variant changes.",
					finish = "intern-in07",
					id = "intern/IN07/future",
					kind = "cosmetic",
					name = "Same Place Same Method: survey team colours",
					provider = "intern",
					status = "unimplemented",
				},
			},
			completionCash = 0,
			name = "Same Place Same Method",
			kind = "tracker",
			requires = {"IN05"},
			briefing = "More completed sensor surveys when you're ready. Check the destination first.",
			completion = "Thank you. Another set of results I can check against the setup notes.",
			target = 5,
		},
		{
			id = "IN08",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering Marsh baseline readings; author actionable "
						.. "guidance tied to verified mechanics and locations."
					),
					id = "intern/IN08/future",
					kind = "information",
					name = "Record: Marsh baseline readings",
					provider = "intern",
					status = "unimplemented",
					topic = "Marsh baseline readings",
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
			requires = {"IN06"},
			briefing = (
				"I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely "
				.. "on the readings. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "common_artifacts",
					quantity = 2,
				},
				{
					pool = "electrical_artifacts",
					quantity = 1,
				},
			},
		},
		{
			id = "IN09",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering Garbage baseline readings; author "
						.. "actionable guidance tied to verified mechanics and locations."
					),
					id = "intern/IN09/future",
					kind = "information",
					name = "Record: Garbage baseline readings",
					provider = "intern",
					status = "unimplemented",
					topic = "Garbage baseline readings",
				},
			},
			completionCash = 875,
			name = "Something to Compare",
			kind = "delivery",
			requires = {"IN07"},
			briefing = (
				"I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely "
				.. "on the readings. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "common_artifacts",
					quantity = 2,
				},
				{
					pool = "electrical_artifacts",
					quantity = 1,
				},
			},
		},
		{
			id = "IN10",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement cosmetic consumer; verify these proposed terms before enabling.
				{
					baseSuit = "suit_io7a",
					effect = "Apply survey team colours to suit_io7a; appearance only, with no gameplay variant changes.",
					finish = "intern-in10",
					id = "intern/IN10/future",
					kind = "cosmetic",
					name = "The Senior's Notebook: survey team colours",
					provider = "intern",
					status = "unimplemented",
				},
			},
			completionCash = 1250,
			name = "The Senior's Notebook",
			kind = "field",
			objective = (
				"Recover the senior researcher's notebook from the assigned search area in Waystation. Bring it "
				.. "back to the issuing contact in Marsh."
			),
			requires = {"IN08"},
			briefing = (
				"I'd like the research note brought back intact. It's difficult to ask a useful question about a "
				.. "page everyone remembers differently. Recover the senior researcher's notebook from the assigned "
				.. "search area in Waystation. Bring it back to me in Waystation."
			),
			completion = "Let me read what comes before the conclusion. I keep beginning at the end when I'm nervous.",
			field = {
				description = (
					"A thick blue diary with a label fixed to the front cover. Intern's note: \"I'd like the research "
					.. "note brought back intact.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_diary",
				label = "Senior researcher's notebook",
			},
		},
		{
			id = "IN11",
			stock = {item = "545x39hp", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering Pripyat comparative readings; author "
						.. "actionable guidance tied to verified mechanics and locations."
					),
					id = "intern/IN11/future",
					kind = "information",
					name = "Record: Pripyat comparative readings",
					provider = "intern",
					status = "unimplemented",
					topic = "Pripyat comparative readings",
				},
			},
			completionCash = 0,
			name = "A Wider Baseline",
			kind = "tracker",
			requires = {"IN09"},
			briefing = "Keep the survey assignments going. I want the comparisons to survive more than one careful trip.",
			completion = "You've been consistent. That makes an awkward reading much more useful to discuss.",
			target = 9,
		},
		{
			id = "IN12",
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering sensor placement errors; author actionable "
						.. "guidance tied to verified mechanics and locations."
					),
					id = "intern/IN12/future",
					kind = "information",
					name = "Record: sensor placement errors",
					provider = "intern",
					status = "unimplemented",
					topic = "sensor placement errors",
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
			requires = {"IN10"},
			briefing = (
				"I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely "
				.. "on the readings. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "common_artifacts",
					quantity = 2,
				},
				{
					pool = "electrical_artifacts",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "IN13",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement cosmetic consumer; verify these proposed terms before enabling.
				{
					baseSuit = "suit_nbc",
					effect = "Apply survey team colours to suit_nbc; appearance only, with no gameplay variant changes.",
					finish = "intern-in13",
					id = "intern/IN13/future",
					kind = "cosmetic",
					name = "Ready for the Distance: survey team colours",
					provider = "intern",
					status = "unimplemented",
				},
			},
			completionCash = 1175,
			name = "Ready for the Distance",
			kind = "delivery",
			requires = {"IN11"},
			briefing = (
				"I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely "
				.. "on the readings. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "common_artifacts",
					quantity = 3,
				},
				{
					pool = "electrical_artifacts",
					quantity = 2,
				},
				{
					pool = "rare_field_artifacts",
					quantity = 1,
				},
			},
		},
		{
			id = "IN14",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering exposure log comparison; author actionable "
						.. "guidance tied to verified mechanics and locations."
					),
					id = "intern/IN14/future",
					kind = "information",
					name = "Record: exposure log comparison",
					provider = "intern",
					status = "unimplemented",
					topic = "exposure log comparison",
				},
			},
			completionCash = 1650,
			name = "The Lost Calibration Case",
			kind = "field",
			objective = (
				"Recover the calibration case for Technut from the assigned search area in Waystation. Deliver it "
				.. "to 'Technut' in Marsh, then come back to the issuing contact in Marsh."
			),
			requires = {"IN12"},
			briefing = (
				"Technut should inspect the instrument case. I can describe the fault, but I'd rather he saw the "
				.. "equipment himself. Recover the calibration case for Technut from the assigned search area in "
				.. "Waystation. Deliver it to 'Technut' in Marsh, then come back to me in Waystation."
			),
			completion = "He's got it. That's a much better beginning than me attempting another drawing of the connector.",
			field = {
				description = (
					"A dark reinforced case covered in pale symbols and contrasting trim. Intern's note: \"Technut "
					.. "should inspect the instrument case.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_research",
				label = "Calibration case for Technut",
				recipient = "technut",
			},
		},
		{
			id = "IN15",
			stock = {item = "556x45", bonus = 1},
			completionCash = 0,
			name = "My Own Figures",
			kind = "tracker",
			requires = {"IN13"},
			briefing = "Continue the recording work while I examine the older notes.",
			completion = "A proper run of work now. I'm beginning to know which questions I need to ask.",
			target = 14,
			benefits = {},
		},
		{
			id = "IN16",
			stock = {item = "556x45ap", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering conflicting measurement review; author "
						.. "actionable guidance tied to verified mechanics and locations."
					),
					id = "intern/IN16/future",
					kind = "information",
					name = "Record: conflicting measurement review",
					provider = "intern",
					status = "unimplemented",
					topic = "conflicting measurement review",
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
			requires = {"IN14"},
			briefing = (
				"I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely "
				.. "on the readings. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "common_artifacts",
					quantity = 3,
				},
				{
					pool = "electrical_artifacts",
					quantity = 2,
				},
				{
					pool = "rare_field_artifacts",
					quantity = 1,
				},
			},
		},
		{
			id = "IN17",
			stock = {item = "556x45hp", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement cosmetic consumer; verify these proposed terms before enabling.
				{
					baseSuit = "suit_mailjacket",
					effect = "Apply survey team colours to suit_mailjacket; appearance only, with no gameplay variant changes.",
					finish = "intern-in17",
					id = "intern/IN17/future",
					kind = "cosmetic",
					name = "Without Missing Pages: survey team colours",
					provider = "intern",
					status = "unimplemented",
				},
			},
			completionCash = 1475,
			name = "Without Missing Pages",
			kind = "delivery",
			requires = {"IN15"},
			briefing = (
				"I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely "
				.. "on the readings. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "common_artifacts",
					quantity = 3,
				},
				{
					pool = "electrical_artifacts",
					quantity = 2,
				},
				{
					pool = "rare_field_artifacts",
					quantity = 1,
				},
			},
		},
		{
			id = "IN18",
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering instrument failure signatures; author "
						.. "actionable guidance tied to verified mechanics and locations."
					),
					id = "intern/IN18/future",
					kind = "information",
					name = "Record: instrument failure signatures",
					provider = "intern",
					status = "unimplemented",
					topic = "instrument failure signatures",
				},
			},
			completionCash = 2050,
			name = "The Contradictory Site",
			kind = "field",
			objective = (
				"Deploy the recorder at the assigned site in Pripyat, let it finish recording, then retrieve the "
				.. "contradictory-site recorder. Bring it back to the issuing contact in Marsh."
			),
			requires = {"IN16"},
			briefing = (
				"We need another recording from the disputed site. If it disagrees, I want to know that before I "
				.. "start making the graph look tidy. Deploy the recorder at the assigned site in Pripyat, let it "
				.. "finish recording, then retrieve the contradictory-site recorder. Bring it back to me in "
				.. "Waystation."
			),
			completion = (
				"Good. I'll keep the original readings, including whatever is going to make the discussion "
				.. "awkward."
			),
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. Intern's note: "
					.. "\"We need another recording from the disputed site.\""
				),
				kind = "sensor",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module",
				label = "Contradictory-site recorder",
			},
			benefits = {},
		},
		{
			id = "IN19",
			stock = {item = "762x39", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering return survey protocol; author actionable "
						.. "guidance tied to verified mechanics and locations."
					),
					id = "intern/IN19/future",
					kind = "information",
					name = "Record: return survey protocol",
					provider = "intern",
					status = "unimplemented",
					topic = "return survey protocol",
				},
			},
			completionCash = 0,
			name = "Enough to Stand Behind",
			kind = "tracker",
			requires = {"IN17"},
			briefing = "There are more survey assignments. Bring the finished recordings back intact.",
			completion = "You've given me enough to check the account without hiding the inconvenient results.",
			target = 20,
		},
		{
			id = "IN20",
			stock = {item = "762x39ap", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement cosmetic consumer; verify these proposed terms before enabling.
				{
					baseSuit = "suit_cs1",
					effect = "Apply survey team colours to suit_cs1; appearance only, with no gameplay variant changes.",
					finish = "intern-in20",
					id = "intern/IN20/future",
					kind = "cosmetic",
					name = "Building the reserve: survey team colours",
					provider = "intern",
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
			requires = {"IN18"},
			briefing = (
				"I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely "
				.. "on the readings. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "common_artifacts",
					quantity = 3,
				},
				{
					pool = "electrical_artifacts",
					quantity = 2,
				},
				{
					pool = "rare_field_artifacts",
					quantity = 1,
				},
			},
		},
		{
			id = "IN21",
			stock = {item = "762x39hp", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering late-expedition sensor drift; author actionable "
						.. "guidance tied to verified mechanics and locations."
					),
					id = "intern/IN21/future",
					kind = "information",
					name = "Record: late-expedition sensor drift",
					provider = "intern",
					status = "unimplemented",
					topic = "late-expedition sensor drift",
				},
			},
			completionCash = 1775,
			name = "The Last Calibration",
			kind = "delivery",
			requires = {"IN19", "IN20"},
			briefing = (
				"I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely "
				.. "on the readings. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "common_artifacts",
					quantity = 4,
				},
				{
					pool = "electrical_artifacts",
					quantity = 3,
				},
				{
					pool = "rare_field_artifacts",
					quantity = 2,
				},
				{
					pool = "exceptional_artifacts",
					quantity = 1,
				},
			},
		},
		{
			id = "IN22",
			stock = {item = "9x39", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering research-team handover protocol; author "
						.. "actionable guidance tied to verified mechanics and locations."
					),
					id = "intern/IN22/future",
					kind = "information",
					name = "Record: research-team handover protocol",
					provider = "intern",
					status = "unimplemented",
					topic = "research-team handover protocol",
				},
			},
			completionCash = 2450,
			name = "The Independent Control",
			kind = "field",
			objective = (
				"Deploy the recorder at the assigned site in Pripyat, let it finish recording, then retrieve the "
				.. "independent control recorder. Bring it back to the issuing contact in Marsh."
			),
			requires = {"IN21"},
			briefing = (
				"One more control recording in Pripyat. I want to be able to explain this comparison in my own "
				.. "words. Deploy the recorder at the assigned site in Pripyat, let it finish recording, then "
				.. "retrieve the independent control recorder. Bring it back to me in Waystation."
			),
			completion = (
				"All right. I can start checking the independent record now. I'm rather looking forward to that "
				.. "part."
			),
			field = {
				description = (
					"A flat dark electronic module marked with a number and three pale bars. Intern's note: \"One more "
					.. "control recording in Pripyat.\""
				),
				kind = "sensor",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module2",
				label = "Independent control recorder",
			},
		},
		{
			id = "IN23",
			stock = {item = "9x39ap", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement cosmetic consumer; verify these proposed terms before enabling.
				{
					baseSuit = "suit_seva",
					effect = "Apply survey team colours to suit_seva; appearance only, with no gameplay variant changes.",
					finish = "intern-in23",
					id = "intern/IN23/future",
					kind = "cosmetic",
					name = "Put My Name on It: survey team colours",
					provider = "intern",
					status = "unimplemented",
				},
			},
			completionCash = 0,
			name = "Put My Name on It",
			kind = "tracker",
			requires = {"IN22"},
			briefing = "Keep completing the sensor surveys when you're prepared.",
			completion = (
				"Thank you. I can stand behind the work and still say which part needs checking. That feels like "
				.. "progress."
			),
			target = 27,
		},
		{
			id = "IN24",
			completionCash = 2650,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"IN23"},
			briefing = (
				"I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely "
				.. "on the readings. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "common_artifacts",
					quantity = 4,
				},
				{
					pool = "electrical_artifacts",
					quantity = 3,
				},
				{
					pool = "rare_field_artifacts",
					quantity = 2,
				},
				{
					pool = "exceptional_artifacts",
					quantity = 1,
				},
			},
			benefits = {},
			recognition = "Intern's trusted contact",
		},
	},
})
