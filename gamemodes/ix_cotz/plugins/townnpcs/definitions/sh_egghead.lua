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
				"I need the artifacts specified on this list. Bring them here so I can compare them "
				.. "properly. A specimen without context is still interesting, but I'd rather know what I'm "
				.. "looking at before it becomes somebody else's grand conclusion."
			),
			completion = (
				"Good. Set them there. I'll make the comparison before deciding what they mean. Yes, I know "
				.. "that sounds cautious. Beanstalk would be delighted to hear it."
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
			name = "The Old Field Station",
			kind = "field",
			objective = (
				"Recover the field-station calibration case from the assigned search area in Waystation. Bring it "
				.. "back to the issuing contact in Waystation."
			),
			requires = {"EG03"},
			briefing = (
				"There's a calibration case left at the old field station. I'd like to inspect it before assuming "
				.. "the measurements were comparable. Recover the field-station calibration case from the assigned "
				.. "search area in Waystation. Bring it back to me in Waystation."
			),
			completion = (
				"Set it on the clear side. The outside has survived; let's see what we can establish about the "
				.. "rest."
			),
			field = {
				description = (
					"A dark reinforced case covered in pale symbols and contrasting trim. Egghead's note: \"There's a "
					.. "calibration case left at the old field station.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_research",
				label = "Field-station calibration case",
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
				"I'd like the listed artifacts for comparison. Keep the request in mind before choosing what you "
				.. "would most enjoy parting with."
			),
			completion = "Excellent. I'll examine the specimens before comparing them with the notes.",
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
			name = "The Missing Calibration",
			kind = "field",
			objective = (
				"Recover the detector calibration record from the assigned search area in Garbage. Bring it back "
				.. "to the issuing contact in Waystation."
			),
			requires = {"EG06"},
			briefing = (
				"The detector test record is missing. It would be pleasant to know what was actually checked "
				.. "before arguing about its accuracy. Recover the detector calibration record from the assigned "
				.. "search area in Garbage. Bring it back to me in Waystation."
			),
			completion = "Thank you. I'll read the procedure as carefully as the figures.",
			field = {
				description = (
					"A blue laboratory folder with loose printed record sheets extending from its edges. Egghead's "
					.. "note: \"The detector test record is missing.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_lab",
				label = "Detector calibration record",
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
				"There is another reference request. Bring what is listed; the interesting difference may be less "
				.. "impressive to look at."
			),
			completion = "Thank you. I'll keep this set separate while I inspect it.",
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
			completionCash = 1450,
			name = "The Paired Samples",
			kind = "field",
			objective = (
				"Recover the paired-sample comparison file from the assigned search area in Waystation. Bring it "
				.. "back to the issuing contact in Waystation."
			),
			requires = {"EG10"},
			briefing = (
				"Bring the comparison record back complete. I want to see how the two accounts were matched. "
				.. "Recover the paired-sample comparison file from the assigned search area in Waystation. Bring it "
				.. "back to me in Waystation."
			),
			completion = "That's the file. I'll keep both sides open while I read it.",
			field = {
				description = (
					"A blue laboratory folder with loose printed record sheets extending from its edges. Egghead's "
					.. "note: \"Bring the comparison record back complete.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_lab",
				label = "Paired-sample comparison file",
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
				"I'd like the listed artifacts for comparison. Keep the request in mind before choosing what you "
				.. "would most enjoy parting with."
			),
			completion = "Excellent. I'll examine the specimens before comparing them with the notes.",
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
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_clinic",
				label = "Environmental control for Vesper",
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
			briefing = "Continue the specified artifact deliveries. Familiar examples can still qualify a theory.",
			completion = "A considerable range of work now. I have rather better questions to ask of it.",
			target = 14,
			benefits = {},
		},
		{
			id = "EG16",
			completionCash = 1850,
			name = "The Archived Finding",
			kind = "field",
			objective = (
				"Recover the archived finding for Carbon from the assigned search area in Waystation. Deliver it "
				.. "to 'Carbon' in Waystation, then come back to the issuing contact in Waystation."
			),
			requires = {"EG14"},
			briefing = (
				"Carbon needs the archived finding. He can check its context without relying on the quotation I "
				.. "remembered liking. Recover the archived finding for Carbon from the assigned search area in "
				.. "Waystation. Deliver it to 'Carbon' in Waystation, then come back to me in Waystation."
			),
			completion = "Delivered. I shall resist citing it any more confidently until he has read it.",
			field = {
				description = (
					"A blue document folder with loose pages protruding from the edges. Egghead's note: \"Carbon needs "
					.. "the archived finding.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_dossier",
				label = "Archived finding for Carbon",
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
			briefing = (
				"I'd like the requested equipment brought here. Preparing the comparison includes the ordinary "
				.. "supplies too."
			),
			completion = "Good. That's something I can stop borrowing from the next piece of work.",
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
			completionCash = 2250,
			name = "The Unfinished Experiment",
			kind = "field",
			objective = (
				"Recover the unfinished calibration case from the assigned search area in Pripyat. Bring it back "
				.. "to the issuing contact in Waystation."
			),
			requires = {"EG18"},
			briefing = (
				"There's another calibration case still out in Pripyat. We should inspect it before treating that "
				.. "trial as comparable. Recover the unfinished calibration case from the assigned search area in "
				.. "Pripyat. Bring it back to me in Waystation."
			),
			completion = "Good. I'll put the case beside the trial papers and see what can be checked.",
			field = {
				description = (
					"A dark reinforced case covered in pale symbols and contrasting trim. Egghead's note: \"There's "
					.. "another calibration case still out in Pripyat.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_research",
				label = "Unfinished calibration case",
			},
			benefits = {},
		},
		{
			id = "EG21",
			completionCash = 1775,
			name = "Precision at Last",
			kind = "delivery",
			requires = {"EG19", "EG20"},
			briefing = (
				"I'd like the listed artifacts for comparison. Keep the request in mind before choosing what you "
				.. "would most enjoy parting with."
			),
			completion = "Excellent. I'll examine the specimens before comparing them with the notes.",
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
			completionCash = 2650,
			name = "The Programme's Missing Page",
			kind = "field",
			objective = (
				"Recover the programme archive for Carbon from the assigned search area in Waystation. Deliver it "
				.. "to 'Carbon' in Waystation, then come back to the issuing contact in Waystation."
			),
			requires = {"EG23"},
			briefing = (
				"The archived research record goes to Carbon. I'd prefer he had the original while he checks the "
				.. "missing references. Recover the programme archive for Carbon from the assigned search area in "
				.. "Waystation. Deliver it to 'Carbon' in Waystation, then come back to me in Waystation."
			),
			completion = "Delivered. I owe him the courtesy of waiting until he's finished reading.",
			field = {
				description = (
					"A blue records folder with contrasting corporate lettering along the cover. Egghead's note: \"The "
					.. "archived research record goes to Carbon.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_archive",
				label = "Programme archive for Carbon",
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
			briefing = "Bring the listed material intact. I want the working record as well as the attractive result.",
			completion = "Here we are. I'll record what arrived before rearranging it.",
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
			objective = (
				"Recover the final control log from the assigned search area in Waystation. Bring it back to the "
				.. "issuing contact in Waystation."
			),
			requires = {"EG25"},
			briefing = (
				"I'd like the complete control log, including the method and the dull intervals. Those have a "
				.. "habit of becoming important later. Recover the final control log from the assigned search area in "
				.. "Waystation. Bring it back to me in Waystation."
			),
			completion = (
				"We've got a collection someone else can examine and disagree with. That pleases me more than a "
				.. "shelf of impressive objects. Thank you. If you've time, I'd like to show you which result is "
				.. "still bothering me."
			),
			field = {
				description = (
					"A blue laboratory folder with loose printed record sheets extending from its edges. Egghead's "
					.. "note: \"I'd like the complete control log, including the method and the dull intervals.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_lab",
				label = "Final control log",
			},
			benefits = {},
			recognition = "Egghead's trusted contact",
		},
	},
})
