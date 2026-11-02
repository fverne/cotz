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
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
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
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Artifacts. Bring the specimens requested on the order; I need to make a comparison. Keep to the "
			.. "requested specimens. Something unusual is interesting, but it won't fill a particular gap just by "
			.. "being unusual."
		),
		progressionPrompt = "What else needs doing?",
		progression = (
			"There are specimens to collect and old field records to check. Which would you like to help with? "
			.. "The collection needs context, which means old records as well as specimens. I would rather check a "
			.. "dull detail now than discover later that we've been comparing quite different things."
		),
	},
	catalogue = {
		["medic_psyheal_1"] = {step = "EG01",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["medic_antipsychotic_1"] = {step = "EG07",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["accesscard_laboratory"] = {step = "EG01",
			terms = {nil, 5, "SELLANDBUY", 5, 1, 5}},
		["detectorbear"] = {step = "EG11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["detectorecho"] = {step = "EG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["detectorveles"] = {step = "EG21",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_antipsychotic_2"] = {step = "EG09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_antipsychotic_3"] = {step = "EG13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_psyheal_2"] = {step = "EG03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_stimpak_1"] = {step = "EG07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_stimpak_2"] = {step = "EG11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_stimpak_3"] = {step = "EG15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["quest_computeraccess"] = {step = "EG01",
			terms = {nil, 5, "SELLANDBUY", 5, 1, 5}},
		["suit_seva"] = {step = "EG19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_ssp99m"] = {step = "EG17",
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
				"Bring the material listed here. I'd like to check it before putting it with the others. "
				.. "We need a reference before we can make much of a comparison. You may find that less "
				.. "exciting than collecting something nobody recognises."
			),
			completion = (
				"Thank you. I'll label these before they get mixed in. A useful beginning. I'll keep the "
				.. "labelling clear so we don't spend the rest of the programme regretting our first "
				.. "afternoon."
			),
			requirements = {
				{
					pool = "common_artifacts",
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
			objective = "Recover Scientist's Field Diary from the assigned search area in Waystation. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"EG01"},
			briefing = "Recover a reference notebook near a regional field site.",
			completion = "Let's look at the record before deciding what it means.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_diary",
				label = "The Control Notebook - Scientist's Field Diary",
			},
			benefits = {},
		},
		{
			id = "EG03",
			completionCash = 0,
			name = "A Useful Assistant",
			kind = "tracker",
			requires = {"EG02"},
			briefing = "Artifacts. Bring the specimens requested on the order; I need to make a comparison.",
			completion = "You've brought enough specimens for a useful comparison. Thank you for keeping at it.",
			target = 2,
			benefits = {},
		},
		{
			id = "EG04",
			completionCash = 650,
			name = "The Old Field Station",
			kind = "field",
			objective = "Recover Marked Research Case from the assigned search area in Waystation. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"EG03"},
			briefing = "Recover a calibration case in accessible regional territory.",
			completion = "Thank you. I'll keep that with the comparison material.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_research",
				label = "The Old Field Station - Marked Research Case",
			},
			benefits = {},
		},
		{
			id = "EG05",
			completionCash = 575,
			name = "Different Origins",
			kind = "delivery",
			requires = {"EG04"},
			briefing = "Bring the material listed here. I'd like to check it before putting it with the others.",
			completion = "Good. Let me compare the condition.",
			requirements = {
				{
					pool = "common_artifacts",
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
			objective = "Deploy the recorder in Waystation, leave it to record, then retrieve Numbered Data Module"
				.. " 0013. Return it to this contact to finish the assignment.",
			requires = {"EG04"},
			briefing = "Deploy and retrieve a recorder near an anomaly field.",
			completion = "Good. I can check this against the other records.",
			field = {
				kind = "sensor",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_module",
				label = "The Comparison Site - Numbered Data Module 0013",
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
			briefing = "Artifacts. Bring the specimens requested on the order; I need to make a comparison.",
			completion = "You've brought enough specimens for a useful comparison. Thank you for keeping at it.",
			target = 5,
			benefits = {},
		},
		{
			id = "EG08",
			completionCash = 1050,
			name = "The Missing Calibration",
			kind = "field",
			objective = "Recover Laboratory Log Folder from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"EG06"},
			briefing = "Recover a detector test record in Garbage.",
			completion = "Let's look at the record before deciding what it means.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_lab",
				label = "The Missing Calibration - Laboratory Log Folder",
			},
			benefits = {},
		},
		{
			id = "EG09",
			completionCash = 875,
			name = "A Reliable Reading",
			kind = "delivery",
			requires = {"EG07"},
			briefing = "Bring the material listed here. I'd like to check it before putting it with the others.",
			completion = "Yes, that's what I asked for.",
			requirements = {
				{
					pool = "common_artifacts",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "EG10",
			completionCash = 1250,
			name = "The Failed Trial",
			kind = "field",
			objective = "Recover Numbered Data Module 0022 from the assigned search area in Waystation. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"EG08"},
			briefing = "Retrieve a test recorder at a remote research site.",
			completion = "Thank you. I'll keep that with the comparison material.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_module2",
				label = "The Failed Trial - Numbered Data Module 0022",
			},
			benefits = {},
		},
		{
			id = "EG11",
			completionCash = 0,
			name = "A Better Instrument",
			kind = "tracker",
			requires = {"EG09"},
			briefing = "Artifacts. Bring the specimens requested on the order; I need to make a comparison.",
			completion = "You've brought enough specimens for a useful comparison. Thank you for keeping at it.",
			target = 9,
			benefits = {},
		},
		{
			id = "EG12",
			completionCash = 1450,
			name = "The Paired Samples",
			kind = "field",
			objective = "Recover Laboratory Log Folder from the assigned search area in Waystation. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"EG10"},
			briefing = "Recover a comparison record from the field.",
			completion = "Good. I can check this against the other records.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_lab",
				label = "The Paired Samples - Laboratory Log Folder",
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
			briefing = "Bring the material listed here. I'd like to check it before putting it with the others.",
			completion = "Thank you. I'll label these before they get mixed in.",
			requirements = {
				{
					pool = "electrical_artifacts",
					quantity = 4,
				},
			},
			benefits = {},
		},
		{
			id = "EG14",
			completionCash = 1650,
			name = "Beanstalk's Objection",
			kind = "field",
			objective = "Recover Clinical Records Folder I from the assigned search area in Garbage. Deliver it to"
				.. " 'Vesper' in Garbage, then return here to finish the assignment.",
			requires = {"EG12"},
			briefing = (
				"Recover environmental control evidence in Garbage. Take the records to Vesper in "
				.. "Garbage, then return here. I would like the field perspective considered before we "
				.. "settle the comparison."
			),
			completion = (
				"Good. A comparison is rather easier when both people have the records. Good. Let her "
				.. "examine the record without us supplying the conclusion in advance. I can survive a "
				.. "little disagreement."
			),
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_clinic",
				label = "Beanstalk's Objection - Clinical Records Folder I",
				recipient = "vesper",
			},
			benefits = {},
		},
		{
			id = "EG15",
			completionCash = 0,
			name = "A Collection With Context",
			kind = "tracker",
			requires = {"EG13"},
			briefing = "Artifacts. Bring the specimens requested on the order; I need to make a comparison.",
			completion = "You've brought enough specimens for a useful comparison. Thank you for keeping at it.",
			target = 14,
			benefits = {},
		},
		{
			id = "EG16",
			completionCash = 1850,
			name = "The Archived Finding",
			kind = "field",
			objective = "Recover Blue Research Dossier from the assigned search area in Waystation. Deliver it to"
				.. " 'Carbon' in Waystation, then return here to finish the assignment.",
			requires = {"EG14"},
			briefing = "Recover a research record for comparison with Carbon.",
			completion = "Good. A comparison is rather easier when both people have the records.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_dossier",
				label = "The Archived Finding - Blue Research Dossier",
				recipient = "carbon",
			},
			benefits = {},
		},
		{
			id = "EG17",
			completionCash = 1475,
			name = "Before Pripyat",
			kind = "delivery",
			requires = {"EG15"},
			briefing = "Bring the material listed here. I'd like to check it before putting it with the others.",
			completion = "Good. Let me compare the condition.",
			requirements = {
				{
					pool = "small_electronics",
					quantity = 5,
				},
			},
			benefits = {},
		},
		{
			id = "EG18",
			completionCash = 2050,
			name = "The Pripyat Baseline",
			kind = "field",
			objective = "Recover Numbered Data Module 0013 from the assigned search area in Pripyat. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"EG16"},
			briefing = "Recover an earlier research team's recorder in Pripyat.",
			completion = "Good. I can check this against the other records.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module",
				label = "The Pripyat Baseline - Numbered Data Module 0013",
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
			briefing = "Artifacts. Bring the specimens requested on the order; I need to make a comparison.",
			completion = "You've brought enough specimens for a useful comparison. Thank you for keeping at it.",
			target = 20,
			benefits = {},
		},
		{
			id = "EG20",
			completionCash = 2250,
			name = "The Unfinished Experiment",
			kind = "field",
			objective = "Recover Marked Research Case from the assigned search area in Pripyat. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"EG18"},
			briefing = "Retrieve a calibration case at a second Pripyat site.",
			completion = "Let's look at the record before deciding what it means.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_research",
				label = "The Unfinished Experiment - Marked Research Case",
			},
			benefits = {},
		},
		{
			id = "EG21",
			completionCash = 1775,
			name = "Precision at Last",
			kind = "delivery",
			requires = {"EG19", "EG20"},
			briefing = "Bring the material listed here. I'd like to check it before putting it with the others.",
			completion = "Yes, that's what I asked for.",
			requirements = {
				{
					pool = "common_artifacts",
					quantity = 2,
				},
			},
			benefits = {},
		},
		{
			id = "EG22",
			completionCash = 2450,
			name = "The Family Resemblance",
			kind = "field",
			objective = "Recover Numbered Data Module 0022 from the assigned search area in Pripyat. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"EG21"},
			briefing = "Recover the final comparison recorder in Pripyat.",
			completion = "Thank you. I'll keep that with the comparison material.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module2",
				label = "The Family Resemblance - Numbered Data Module 0022",
			},
			benefits = {},
		},
		{
			id = "EG23",
			completionCash = 0,
			name = "A Complete Reference",
			kind = "tracker",
			requires = {"EG22"},
			briefing = "Artifacts. Bring the specimens requested on the order; I need to make a comparison.",
			completion = "You've brought enough specimens for a useful comparison. Thank you for keeping at it.",
			target = 27,
			benefits = {},
		},
		{
			id = "EG24",
			completionCash = 2650,
			name = "The Programme's Missing Page",
			kind = "field",
			objective = "Recover Corporate Records Folder from the assigned search area in Waystation. Deliver it to"
				.. " 'Carbon' in Waystation, then return here to finish the assignment.",
			requires = {"EG23"},
			briefing = "Recover a final archived research record.",
			completion = "Good. A comparison is rather easier when both people have the records.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_archive",
				label = "The Programme's Missing Page - Corporate Records Folder",
				recipient = "carbon",
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
			briefing = "Bring the material listed here. I'd like to check it before putting it with the others.",
			completion = "Thank you. I'll label these before they get mixed in.",
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "EG26",
			completionCash = 2850,
			name = "The Last Control Record",
			kind = "field",
			objective = "Recover Laboratory Log Folder from the assigned search area in Waystation. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"EG25"},
			briefing = (
				"Recover the final field control and return the complete programme. Bring the complete log back. A "
				.. "control record is most useful when we can see what was done, rather than just the result someone "
				.. "liked enough to underline."
			),
			completion = (
				"Let's look at the record before deciding what it means. Good. I can work with this. You have been "
				.. "remarkably persistent about the less spectacular parts of research. I mean that kindly. Those are "
				.. "usually the parts that let us trust the rest."
			),
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_lab",
				label = "The Last Control Record - Laboratory Log Folder",
			},
			benefits = {},
			recognition = "Egghead's trusted contact",
		},
	},
})
