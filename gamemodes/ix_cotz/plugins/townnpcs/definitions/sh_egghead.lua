PLUGIN:Register("egghead", {
	name = "'Egghead'",
	template = "ecologistnpc",
	map = "rp_waystation",
	job = {
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		category = "Artifact deliveries",
		description = "Artifact deliveries",
		pools = {"common_artifacts", "electrical_artifacts"},
		deliveryTiers = {
			easy = {
				pools = {
					"valuables_sample_carriers",
					"valuables_survey_equipment",
				},
				quantity = 1,
			},
			medium = {
				pools = {
					"valuables_research_samples",
				},
				quantity = 1,
			},
			hard = {
				pools = {
					"valuables_instruments",
					"valuables_research_injectors_a",
					"valuables_research_injectors_b",
				},
				quantity = 2,
			},
		},
		quantities = {2, 4, 7},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "drink_bottlewaterdirty", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Anomaly recovery",
				items = {"medic_psyheal_1", "medic_psyheal_2"}},
			{label = "Exposure treatment",
				items = {"medic_antirad_1", "medic_antirad_2"}},
			{label = "Emergency research supplies",
				items = {"medic_antipsychotic_1", "medic_stimpak_1"}},
		},
	},
	dialogue = {
		completedGreeting = (
			"Hello again. Something to compare, or simply a question? We can probably find time for "
			.. "either."
		),
		workPrompt = "About the reference request I've taken.",
		offerPrompt = "Do you have a specimen delivery request?",
		work = (
			"Artifact and research supply requests. Bring what's listed; an unusual object won't fill a "
			.. "particular reference gap simply by being unusual. I'll inspect the return before deciding what "
			.. "comparison it supports. The ordinary containers and records matter too. Research accumulates "
			.. "rather more packaging than the illustrations suggest."
		),
		progressionPrompt = "What are you comparing at the moment?",
		progression = (
			"I'm building comparisons between artifacts and surviving field accounts. I need the specimens, the "
			.. "working supplies, and the records that explain what somebody actually did. Choose a manageable "
			.. "request first. We may finish with a better question instead of a grand explanation. I would "
			.. "consider that a useful result."
		),
	},
	-- Author-disabled suggestions must not be restored by catalogue or stock generation.
	disabledItems = {
		["accesscard_laboratory"] = true,
	},
	catalogue = {
		["medic_antirad_2"] = {step = "EG06",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_raisins"] = {step = "EG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_can_beans"] = {step = "EG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_bottletea"] = {step = "EG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["accesscard_laboratory"] = {step = "EG01",
		-- 	terms = {nil, 5, "SELLANDBUY", 5, 1, 5}},
		["artifact_arachno"] = {step = "EG13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_battery"] = {step = "EG11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_blowncap"] = {step = "EG08",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_bolt"] = {step = "EG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_bonecluster"] = {step = "EG02",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_capacitor"] = {step = "EG20",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_cell"] = {step = "EG08",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_compass"] = {step = "EG22",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_crystal"] = {step = "EG16",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_droplet"] = {step = "EG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_dwarfgalaxy"] = {step = "EG13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_eye"] = {step = "EG16",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_flame"] = {step = "EG24",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_flash"] = {step = "EG11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_gaia"] = {step = "EG19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_galaxy"] = {step = "EG25",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_gmamasbeads"] = {step = "EG22",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_grapes"] = {step = "EG06",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_halo"] = {step = "EG15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_kolobok"] = {step = "EG19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_mamasbeads"] = {step = "EG17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_mementomori"] = {step = "EG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_mica"] = {step = "EG14",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_midas"] = {step = "EG26",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_moon"] = {step = "EG23",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_moonlight"] = {step = "EG21",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_mycelia"] = {step = "EG10",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_panacea"] = {step = "EG18",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_photo"] = {step = "EG02",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_slime"] = {step = "EG05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_slug"] = {step = "EG12",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_sparkler"] = {step = "EG05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_storm"] = {step = "EG25",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_thorn"] = {step = "EG04",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["artifact_urchin"] = {step = "EG09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["detectorbear"] = {step = "EG13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["detectorecho"] = {step = "EG01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["detectorveles"] = {step = "EG26",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_antipsychotic_1"] = {step = "EG07",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["medic_antipsychotic_2"] = {step = "EG09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_antipsychotic_3"] = {step = "EG13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_antirad_1"] = {step = "EG02",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_psyheal_1"] = {step = "EG01",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["medic_psyheal_2"] = {step = "EG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_stimpak_1"] = {step = "EG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_stimpak_2"] = {step = "EG11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_stimpak_3"] = {step = "EG15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_seva"] = {step = "EG26",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_ssp99m"] = {step = "EG08",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "EG01",
			completionCash = 275,
			name = "A First Reference",
			kind = "delivery",
			requires = {},
			briefing = (
				"I need material for the research bench. Yes, there is a list; I remembered to write it before "
				.. "getting distracted this time. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Excellent. Let me put these aside before I start explaining what I want to compare.",
			requirements = {
				{
					pool = "town_delivery_research_waystation_1",
					quantity = 1,
				},
			},
			benefits = {
				items = {
					{
						item = "drink_bottlewater",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "EG02",
			completionCash = 450,
			name = "The Control Notebook",
			kind = "field",
			objective = (
				"Recover the reference field notebook from the assigned search area in Waystation. Bring it back "
				.. "to the issuing contact in Waystation."
			),
			requires = {"EG01"},
			briefing = (
				"I'd like the reference notebook recovered. A careful result becomes rather less useful when "
				.. "nobody can find the method. Recover the reference field notebook from the assigned search area in "
				.. "Waystation. Bring it back to me in Waystation."
			),
			completion = "Excellent. I'll begin with the notes instead of the result somebody circled.",
			field = {
				description = (
					"A thick blue diary with a label fixed to the front cover. Egghead's note: \"I'd like the "
					.. "reference notebook recovered.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_diary",
				label = "Reference field notebook",
			},
			benefits = {},
		},
		{
			id = "EG03",
			completionCash = 0,
			name = "A Useful Assistant",
			kind = "tracker",
			requires = {"EG02"},
			briefing = "Continue the artifact deliveries. I want completed requests we can actually compare.",
			completion = "A useful beginning to the collection. Thank you.",
			target = 2,
			benefits = {},
		},
		{
			id = "EG04",
			completionCash = 650,
			name = "A small delivery",
			kind = "delivery",
			retiredCommission = true,
			objective = "Bring all 1 listed item type to this contact. The request shows each selected item and required units.",
			requires = {"EG03"},
			briefing = (
				"I need material for the research bench. Yes, there is a list; I remembered to write it before "
				.. "getting distracted this time. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Excellent. Let me put these aside before I start explaining what I want to compare.",
			requirements = {
				{
					pool = "town_delivery_research_waystation_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "EG05",
			completionCash = 575,
			name = "Different Origins",
			kind = "delivery",
			requires = {"EG04"},
			briefing = (
				"I need material for the research bench. Yes, there is a list; I remembered to write it before "
				.. "getting distracted this time. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Excellent. Let me put these aside before I start explaining what I want to compare.",
			requirements = {
				{
					pool = "town_delivery_research_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_waystation_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "EG06",
			completionCash = 850,
			name = "The Comparison Site",
			kind = "field",
			objective = (
				"Deploy the recorder at the assigned site in Waystation, let it finish recording, then retrieve "
				.. "the artifact comparison recorder. Bring it back to the issuing contact in Waystation."
			),
			requires = {"EG04"},
			briefing = (
				"We need a recording at the comparison site. I'd enjoy being able to disagree about a reading we "
				.. "both have in front of us. Deploy the recorder at the assigned site in Waystation, let it finish "
				.. "recording, then retrieve the artifact comparison recorder. Bring it back to me in Waystation."
			),
			completion = "Here we are. I'll keep the raw record before attempting an elegant explanation.",
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. Egghead's note: "
					.. "\"We need a recording at the comparison site.\""
				),
				kind = "sensor",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_module",
				label = "Artifact comparison recorder",
			},
			benefits = {
				items = {
					{
						item = "medic_bandage_1",
						data = {
							quantity = 1,
						},
					},
				},
			},
			stock = {
				item = "drink_bottlewater",
				bonus = 1,
			},
		},
		{
			id = "EG07",
			completionCash = 0,
			name = "An Orderly Collection",
			kind = "tracker",
			requires = {"EG05"},
			briefing = "More artifact requests when you're ready. Check the specimen before accepting.",
			completion = "Another run completed. There is more here to examine than a first impression allows.",
			target = 5,
			benefits = {},
		},
		{
			id = "EG08",
			completionCash = 1050,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"EG06"},
			briefing = (
				"I need material for the research bench. Yes, there is a list; I remembered to write it before "
				.. "getting distracted this time. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Excellent. Let me put these aside before I start explaining what I want to compare.",
			requirements = {
				{
					pool = "town_delivery_research_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_waystation_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "EG09",
			completionCash = 875,
			name = "A Reliable Reading",
			kind = "delivery",
			requires = {"EG07"},
			briefing = (
				"I need material for the research bench. Yes, there is a list; I remembered to write it before "
				.. "getting distracted this time. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Excellent. Let me put these aside before I start explaining what I want to compare.",
			requirements = {
				{
					pool = "town_delivery_research_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_waystation_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "EG10",
			stock = {item = "medic_bandage_1", bonus = 1},
			completionCash = 1250,
			name = "The Failed Trial",
			kind = "field",
			objective = (
				"Recover the failed-trial recording from the assigned search area in Waystation. Bring it back to "
				.. "the issuing contact in Waystation."
			),
			requires = {"EG08"},
			briefing = (
				"I'd like the trial recording recovered. A failed experiment can be useful, provided nobody has "
				.. "edited out the embarrassment. Recover the failed-trial recording from the assigned search area in "
				.. "Waystation. Bring it back to me in Waystation."
			),
			completion = "Good. We can inspect what happened rather than what the report hoped to show.",
			field = {
				description = (
					"A flat dark electronic module marked with a number and three pale bars. Egghead's note: \"I'd "
					.. "like the trial recording recovered.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_module2",
				label = "Failed-trial recording",
			},
			benefits = {},
		},
		{
			id = "EG11",
			completionCash = 0,
			name = "A Better Instrument",
			kind = "tracker",
			requires = {"EG09"},
			briefing = "Keep the artifact orders moving while I compare the field records.",
			completion = "You've given the comparison some substance. I appreciate it.",
			target = 9,
			benefits = {},
		},
		{
			id = "EG12",
			plannedUnlocks = {
				-- TODO: Implement cosmetic consumer; verify these proposed terms before enabling.
				{
					baseSuit = "suit_anorak",
					effect = "Apply artifact research colours to suit_anorak; appearance only, with no gameplay variant changes.",
					finish = "egghead-eg12",
					id = "egghead/EG12/future",
					kind = "cosmetic",
					name = "Restocking: artifact research colours",
					provider = "egghead",
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
			requires = {"EG10"},
			briefing = (
				"I need material for the research bench. Yes, there is a list; I remembered to write it before "
				.. "getting distracted this time. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Excellent. Let me put these aside before I start explaining what I want to compare.",
			requirements = {
				{
					pool = "town_delivery_research_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_waystation_2",
					quantity = 1,
				},
			},
			benefits = {
				items = {
					{
						item = "lowtiercookerfuel",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "EG13",
			completionCash = 1175,
			name = "Protection for the Work",
			kind = "delivery",
			requires = {"EG11"},
			briefing = (
				"I need material for the research bench. Yes, there is a list; I remembered to write it before "
				.. "getting distracted this time. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Excellent. Let me put these aside before I start explaining what I want to compare.",
			requirements = {
				{
					pool = "town_delivery_research_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_waystation_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "EG14",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering sample contamination; author actionable "
						.. "guidance tied to verified mechanics and locations."
					),
					id = "egghead/EG14/future",
					kind = "information",
					name = "Record: sample contamination",
					provider = "egghead",
					status = "unimplemented",
					topic = "sample contamination",
				},
			},
			completionCash = 1650,
			name = "Beanstalk's Objection",
			kind = "field",
			objective = (
				"Recover the environmental control for Vesper from the assigned search area in Garbage. Deliver it "
				.. "to 'Vesper' in Garbage, then come back to the issuing contact in Waystation."
			),
			requires = {"EG12"},
			briefing = (
				"Vesper should examine the environmental control evidence. I'd like her field objections in the "
				.. "comparison before I decide it is satisfactory. Recover the environmental control for Vesper from "
				.. "the assigned search area in Garbage. Deliver it to 'Vesper' in Garbage, then come back to me in "
				.. "Waystation."
			),
			completion = "She has the records. Good. I'll leave room for an answer I may not enjoy.",
			field = {
				description = (
					"A blue-green folder with medical record sheets protruding from its cover. Egghead's note: "
					.. "\"Vesper should examine the environmental control evidence.\""
				),
				kind = "recovery",
				map = "rp_garbage_cotz",
				tier = 2,
				cargo = "town_quest_clinic",
				label = "Environmental control for Vesper",
				recipient = "vesper",
			},
		},
		{
			id = "EG15",
			completionCash = 0,
			name = "A Collection With Context",
			kind = "tracker",
			requires = {"EG13"},
			briefing = "Continue the specified artifact deliveries. Familiar examples can still qualify a theory.",
			completion = "A considerable range of work now. I have rather better questions to ask of it.",
			target = 14,
			benefits = {},
		},
		{
			id = "EG16",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering detector comparison; author actionable "
						.. "guidance tied to verified mechanics and locations."
					),
					id = "egghead/EG16/future",
					kind = "information",
					name = "Record: detector comparison",
					provider = "egghead",
					status = "unimplemented",
					topic = "detector comparison",
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
			requires = {"EG14"},
			briefing = (
				"I need material for the research bench. Yes, there is a list; I remembered to write it before "
				.. "getting distracted this time. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Excellent. Let me put these aside before I start explaining what I want to compare.",
			requirements = {
				{
					pool = "town_delivery_research_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_waystation_3",
					quantity = 1,
				},
			},
		},
		{
			id = "EG17",
			completionCash = 1475,
			name = "Before Pripyat",
			kind = "delivery",
			requires = {"EG15"},
			briefing = (
				"I need material for the research bench. Yes, there is a list; I remembered to write it before "
				.. "getting distracted this time. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Excellent. Let me put these aside before I start explaining what I want to compare.",
			requirements = {
				{
					pool = "town_delivery_research_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_waystation_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "EG18",
			plannedUnlocks = {
				-- TODO: Implement cosmetic consumer; verify these proposed terms before enabling.
				{
					baseSuit = "suit_io7a",
					effect = "Apply artifact research colours to suit_io7a; appearance only, with no gameplay variant changes.",
					finish = "egghead-eg18",
					id = "egghead/EG18/future",
					kind = "cosmetic",
					name = "The Pripyat Baseline: artifact research colours",
					provider = "egghead",
					status = "unimplemented",
				},
			},
			completionCash = 2050,
			name = "The Pripyat Baseline",
			kind = "field",
			objective = (
				"Recover the earlier team's research tape from the assigned search area in Pripyat. Bring it back "
				.. "to the issuing contact in Waystation."
			),
			requires = {"EG16"},
			briefing = (
				"I'd like the earlier team's recording from Pripyat. Their questions may have been different from "
				.. "ours. Recover the earlier team's research tape from the assigned search area in Pripyat. Bring it "
				.. "back to me in Waystation."
			),
			completion = (
				"Let me hear it from the beginning. An answer to another question can look quite misleading in "
				.. "isolation."
			),
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. Egghead's note: "
					.. "\"I'd like the earlier team's recording from Pripyat.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module",
				label = "Earlier team's research tape",
			},
			benefits = {
				items = {
					{
						item = "medic_bandage_1",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "EG19",
			completionCash = 0,
			name = "Results That Repeat",
			kind = "tracker",
			requires = {"EG17"},
			briefing = "More artifact deliveries. Keep the requested specimens distinct from the rest of your collection.",
			completion = "You've kept providing something I can check instead of simply agreeing with my explanation.",
			target = 20,
			benefits = {},
		},
		{
			id = "EG20",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent practical reference covering electrical anomaly notes; author "
						.. "actionable guidance tied to verified mechanics and locations."
					),
					id = "egghead/EG20/future",
					kind = "information",
					name = "Record: electrical anomaly notes",
					provider = "egghead",
					status = "unimplemented",
					topic = "electrical anomaly notes",
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
			requires = {"EG18"},
			briefing = (
				"I need material for the research bench. Yes, there is a list; I remembered to write it before "
				.. "getting distracted this time. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Excellent. Let me put these aside before I start explaining what I want to compare.",
			requirements = {
				{
					pool = "town_delivery_research_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_waystation_3",
					quantity = 1,
				},
			},
		},
		{
			id = "EG21",
			completionCash = 1775,
			name = "Precision at Last",
			kind = "delivery",
			requires = {"EG19", "EG20"},
			briefing = (
				"I need material for the research bench. Yes, there is a list; I remembered to write it before "
				.. "getting distracted this time. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Excellent. Let me put these aside before I start explaining what I want to compare.",
			requirements = {
				{
					pool = "town_delivery_research_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_waystation_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "EG22",
			completionCash = 2450,
			name = "The Family Resemblance",
			kind = "field",
			objective = (
				"Recover the final comparison recording from the assigned search area in Pripyat. Bring it back to "
				.. "the issuing contact in Waystation."
			),
			requires = {"EG21"},
			briefing = (
				"Bring the final comparison recorder home. I'm interested in the awkward readings as well as the "
				.. "promising ones. Recover the final comparison recording from the assigned search area in Pripyat. "
				.. "Bring it back to me in Waystation."
			),
			completion = "Here, safely back. Now we can find out which part of the explanation needs revisiting.",
			field = {
				description = (
					"A flat dark electronic module marked with a number and three pale bars. Egghead's note: \"Bring "
					.. "the final comparison recorder home.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module2",
				label = "Final comparison recording",
			},
			benefits = {},
		},
		{
			id = "EG23",
			completionCash = 0,
			name = "A Complete Reference",
			kind = "tracker",
			requires = {"EG22"},
			briefing = "Keep filling the artifact requests when you can prepare for them.",
			completion = (
				"You've stayed with the unglamorous collecting too. Research depends rather heavily on that "
				.. "courtesy."
			),
			target = 27,
			benefits = {},
		},
		{
			id = "EG24",
			plannedUnlocks = {
				-- TODO: Implement barter consumer; verify these proposed terms before enabling.
				{
					id = "egghead/EG24/future",
					provider = "egghead",
					status = "unimplemented",
					kind = "barter",
					name = "medic_psyheal_1 exchange",
					effect = "Permanent multi-input offer; consume inputs each time, enforce equipment tiers and audit resale value.",
					inputs = {
						{
							item = "value_capacitors",
							quantity = 3,
						},
						{
							item = "value_9vbattery",
							quantity = 2,
						},
					},
					outputs = {
						{
							item = "medic_psyheal_1",
							quantity = 1,
						},
					},
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
			requires = {"EG23"},
			briefing = (
				"I need material for the research bench. Yes, there is a list; I remembered to write it before "
				.. "getting distracted this time. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Excellent. Let me put these aside before I start explaining what I want to compare.",
			requirements = {
				{
					pool = "town_delivery_research_waystation_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_research_waystation_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_waystation_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_waystation_4",
					quantity = 1,
				},
			},
			benefits = {
				items = {
					{
						item = "lowtiercookerfuel",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "EG25",
			completionCash = 2000,
			name = "Preserve the Findings",
			kind = "delivery",
			requires = {"EG24"},
			briefing = (
				"I need material for the research bench. Yes, there is a list; I remembered to write it before "
				.. "getting distracted this time. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Excellent. Let me put these aside before I start explaining what I want to compare.",
			requirements = {
				{
					pool = "town_delivery_research_waystation_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_research_waystation_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_waystation_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_waystation_4",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "EG26",
			stock = {item = "medic_bandage_1", bonus = 2},
			completionCash = 2850,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"EG25"},
			briefing = (
				"I need material for the research bench. Yes, there is a list; I remembered to write it before "
				.. "getting distracted this time. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Excellent. Let me put these aside before I start explaining what I want to compare.",
			requirements = {
				{
					pool = "town_delivery_research_waystation_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_research_waystation_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_waystation_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_waystation_4",
					quantity = 1,
				},
			},
			benefits = {},
			recognition = "Egghead's trusted contact",
		},
	},
})
