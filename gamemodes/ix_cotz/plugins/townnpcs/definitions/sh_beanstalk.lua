PLUGIN:Register("beanstalk", {
	name = "'Beanstalk'",
	template = "ecologistnpc2",
	map = "mz_garbage",
	job = {
		kind = "defence",
		category = "Research defence",
		description = "Research defence",
		maps = {
			easy = "mz_garbage",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Research safety",
				items = {"medic_psyheal_1", "medic_antipsychotic_1"}},
			{label = "Emergency response",
				items = {"medic_medkit_1", "medic_stimpak_1"}},
			{label = "Long watch",
				items = {"drug_caffeine", "food_can_beans"}},
		},
	},
	dialogue = {
		completedGreeting = (
			"Hello again. Keep clear of the tray, as usual. You know why I ask, which is a considerable "
			.. "improvement on most conversations here."
		),
		workPrompt = "About the sampler run I'm protecting.",
		offerPrompt = "Do you have research defence work?",
		work = (
			"Defended sampler runs. Deploy at the assigned site, stay close enough to protect the sampler, let "
			.. "the recording finish, then bring the results back. Prepare for the whole run. A quiet beginning is "
			.. "not evidence that the equipment can be left alone. We need the completed record before discussing "
			.. "how reassuring the conditions looked."
		),
		progressionPrompt = "What needs comparing in the research records?",
		progression = (
			"I need supplies and controls, including records left by earlier work. A discrepancy is worth "
			.. "investigating before either of us chooses a favourite explanation. Some orders are defended "
			.. "recordings; others retrieve surviving evidence. Read the particular instruction before preparing. "
			.. "I would rather clarify the method here than apologise for it after your return."
		),
	},
	catalogue = {
		["medic_psyheal_1"] = {step = "BN01",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["medic_antipsychotic_1"] = {step = "BN07",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["medic_antipsychotic_2"] = {step = "BN09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_antipsychotic_3"] = {step = "BN13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_psyheal_2"] = {step = "BN03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_stimpak_1"] = {step = "BN07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_stimpak_2"] = {step = "BN11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_stimpak_3"] = {step = "BN15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mask_eo20"] = {step = "BN09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mask_pmk3"] = {step = "BN11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_nbc"] = {step = "BN14",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_ssp99"] = {step = "BN10",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "BN01",
			completionCash = 275,
			name = "A Station in the Dust",
			kind = "delivery",
			requires = {},
			briefing = (
				"I need the maintenance supplies listed here for the station. Bring them to me, please. A "
				.. "sample isn't much use if the equipment handling it hasn't been looked after. And do keep "
				.. "the supplies separate from anything leaking in your pack."
			),
			completion = (
				"Thank you. Put them on that clear surface. I'll check them before they go near the "
				.. "equipment. No, that isn't an accusation; I check everything before it goes near the "
				.. "equipment."
			),
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 2,
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
			id = "BN02",
			completionCash = 450,
			name = "The First Baseline",
			kind = "field",
			objective = (
				"Deploy and protect the sampler at the assigned site in Garbage until the run finishes, then "
				.. "collect the results. Bring it back to the issuing contact in Garbage."
			),
			requires = {"BN01"},
			briefing = (
				"We need a defended recording at the contamination site. I want a complete run before we choose "
				.. "which variation to explain. Deploy and protect the sampler at the assigned site in Garbage until "
				.. "the run finishes, then collect the results. Bring it back to me in Garbage."
			),
			completion = "Thank you. I'll keep the result with its conditions before comparing it with anything else.",
			field = {
				description = (
					"A field recording recovered from the completed sampler run. Beanstalk's note: \"We need a "
					.. "defended recording at the contamination site.\""
				),
				label = "First contamination sampler results",
				kind = "defence",
				map = "mz_garbage",
				tier = 1,
			},
			benefits = {},
		},
		{
			id = "BN03",
			completionCash = 0,
			name = "Results That Survive",
			kind = "tracker",
			requires = {"BN02"},
			briefing = (
				"Continue the defended research recordings. Protect the sampler for the whole run and bring the "
				.. "results back."
			),
			completion = "A useful beginning. We have completed runs to compare.",
			target = 2,
			benefits = {},
		},
		{
			id = "BN04",
			completionCash = 650,
			name = "The Buried Meter",
			kind = "field",
			objective = (
				"Recover the field meter from the assigned search area in Garbage. Bring it back to the issuing "
				.. "contact in Garbage."
			),
			requires = {"BN03"},
			briefing = (
				"There's an instrument left at the dump site. I want it inspected before its absence becomes the "
				.. "explanation for every discrepancy. Recover the field meter from the assigned search area in "
				.. "Garbage. Bring it back to me in Garbage."
			),
			completion = "Set it down carefully. I'll check the instrument against the account.",
			field = {
				description = (
					"A finned grey control box with a red stripe and several round front connectors. Beanstalk's "
					.. "note: \"There's an instrument left at the dump site.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_control",
				label = "field meter",
			},
			benefits = {},
		},
		{
			id = "BN05",
			completionCash = 575,
			name = "Keeping It Sealed",
			kind = "delivery",
			requires = {"BN03"},
			briefing = "Bring the requested field supplies here. Keep them clear of anything contaminated in your pack.",
			completion = "Thank you. I'll inspect the supplies before use.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "BN06",
			completionCash = 850,
			name = "Two Sides of the Heap",
			kind = "field",
			objective = (
				"Recover the dump comparison log from the assigned search area in Garbage. Bring it back to the "
				.. "issuing contact in Garbage."
			),
			requires = {"BN04"},
			briefing = (
				"I'd like the comparison log recovered. The two sides of a site don't become comparable merely "
				.. "because someone used the same heading. Recover the dump comparison log from the assigned search "
				.. "area in Garbage. Bring it back to me in Garbage."
			),
			completion = "Good. I'll read how they selected the observations.",
			field = {
				description = (
					"A blue laboratory folder with loose printed record sheets extending from its edges. Beanstalk's "
					.. "note: \"I'd like the comparison log recovered.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_lab",
				label = "Dump comparison log",
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
			id = "BN07",
			completionCash = 0,
			name = "A Consistent Sample",
			kind = "tracker",
			requires = {"BN05"},
			briefing = "More research defence work when prepared. The sampler needs protection until it finishes.",
			completion = "Another set of intact results. Thank you for giving the ordinary run proper attention.",
			target = 5,
			benefits = {},
		},
		{
			id = "BN08",
			completionCash = 1050,
			name = "Vesper's Reading",
			kind = "field",
			objective = (
				"Recover the disputed field recorder for Vesper from the assigned search area in Garbage. Deliver "
				.. "it to 'Vesper' in Garbage, then come back to the issuing contact in Garbage."
			),
			requires = {"BN06"},
			briefing = (
				"Vesper needs the disputed field record. She should be able to inspect the result without my "
				.. "objections choosing the order for her. Recover the disputed field recorder for Vesper from the "
				.. "assigned search area in Garbage. Deliver it to 'Vesper' in Garbage, then come back to me in "
				.. "Garbage."
			),
			completion = "She has it. Good. I'll let her read it before asking which parts she disagrees with.",
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. Beanstalk's "
					.. "note: \"Vesper needs the disputed field record.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_module",
				label = "Disputed field recorder for Vesper",
				recipient = "vesper",
			},
			benefits = {},
		},
		{
			id = "BN09",
			completionCash = 875,
			name = "Clean Instruments",
			kind = "delivery",
			requires = {"BN07"},
			briefing = "I need the listed material for the preparation. Clean packaging matters as well as the label.",
			completion = "Good. Keep the packaging with the contents for now.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "BN10",
			completionCash = 1250,
			name = "The Control Site",
			kind = "field",
			objective = (
				"Deploy and protect the sampler at the assigned site in Garbage until the run finishes, then "
				.. "collect the results. Bring it back to the issuing contact in Garbage."
			),
			requires = {"BN08"},
			briefing = (
				"We need another defended sampler run. A control deserves the same care as the result everyone "
				.. "finds interesting. Deploy and protect the sampler at the assigned site in Garbage until the run "
				.. "finishes, then collect the results. Bring it back to me in Garbage."
			),
			completion = (
				"Complete results. Thank you. I'll check the recording conditions before interpreting the "
				.. "difference."
			),
			field = {
				description = (
					"A field recording recovered from the completed sampler run. Beanstalk's note: \"We need another "
					.. "defended sampler run.\""
				),
				label = "Control-site sampler results",
				kind = "defence",
				map = "mz_garbage",
				tier = 2,
			},
			benefits = {},
		},
		{
			id = "BN11",
			completionCash = 0,
			name = "Enough to Compare",
			kind = "tracker",
			requires = {"BN09"},
			briefing = "Keep completing the defended recordings while I review the controls.",
			completion = "You've kept the results usable. That is important before any interpretation begins.",
			target = 9,
			benefits = {},
		},
		{
			id = "BN12",
			completionCash = 1450,
			name = "The Dirty Filter",
			kind = "field",
			objective = (
				"Recover the field station exposure log from the assigned search area in Garbage. Bring it back to "
				.. "the issuing contact in Garbage."
			),
			requires = {"BN10"},
			briefing = (
				"Recover the field station's exposure account. I want to know what was recorded rather than what "
				.. "someone now thinks ought to have happened. Recover the field station exposure log from the "
				.. "assigned search area in Garbage. Bring it back to me in Garbage."
			),
			completion = "Here. I'll keep the entries in order while I compare them.",
			field = {
				description = (
					"A blue-green folder with medical record sheets protruding from its cover. Beanstalk's note: "
					.. "\"Recover the field station's exposure account.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_clinic",
				label = "Field station exposure log",
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
			id = "BN13",
			completionCash = 1175,
			name = "A Field Lab in Reserve",
			kind = "delivery",
			requires = {"BN11"},
			briefing = (
				"These are the supplies I need for the work. Keep them separate from anything "
				.. "contaminated. This is preparation, not a substitute for checking the equipment before "
				.. "it goes out. I'd like both habits established."
			),
			completion = (
				"Put it on the clear tray. Good. One less thing to worry about before the field work. I "
				.. "will undoubtedly find another, but this helps."
			),
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 4,
				},
			},
			benefits = {},
		},
		{
			id = "BN14",
			completionCash = 1650,
			name = "Beyond the Dumps",
			kind = "field",
			objective = (
				"Deploy and protect the sampler at the assigned site in Garbage until the run finishes, then "
				.. "collect the results. Bring it back to the issuing contact in Garbage."
			),
			requires = {"BN12"},
			briefing = (
				"The industrial-site comparison needs a defended recording. A useful method still has to survive "
				.. "the place we're asking you to use it. Deploy and protect the sampler at the assigned site in "
				.. "Garbage until the run finishes, then collect the results. Bring it back to me in Garbage."
			),
			completion = "Thank you for keeping the run intact. Now I can see what it actually recorded.",
			field = {
				description = (
					"A field recording recovered from the completed sampler run. Beanstalk's note: \"The "
					.. "industrial-site comparison needs a defended recording.\""
				),
				label = "Industrial-site sampler results",
				kind = "defence",
				map = "mz_garbage",
				tier = 2,
			},
			benefits = {},
		},
		{
			id = "BN15",
			completionCash = 0,
			name = "Work Under Pressure",
			kind = "tracker",
			requires = {"BN13"},
			briefing = "Continue the research defence assignments. Prepare to remain through the full recording.",
			completion = "A considerable amount of work. I appreciate the care outside this room.",
			target = 14,
			benefits = {},
		},
		{
			id = "BN16",
			completionCash = 1850,
			name = "The Contradictory Result",
			kind = "field",
			objective = (
				"Recover the second control record for Vesper from the assigned search area in Waystation. Deliver "
				.. "it to 'Vesper' in Garbage, then come back to the issuing contact in Garbage."
			),
			requires = {"BN14"},
			briefing = (
				"Vesper should examine the second control recorder. A contradiction is worth checking before "
				.. "either of us gives it an explanation. Recover the second control record for Vesper from the "
				.. "assigned search area in Waystation. Deliver it to 'Vesper' in Garbage, then come back to me in "
				.. "Garbage."
			),
			completion = "Delivered. I'll wait for her reading instead of rehearsing my response to it.",
			field = {
				description = (
					"A flat dark electronic module marked with a number and three pale bars. Beanstalk's note: "
					.. "\"Vesper should examine the second control recorder.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_module2",
				label = "Second control record for Vesper",
				recipient = "vesper",
			},
			benefits = {},
		},
		{
			id = "BN17",
			completionCash = 1475,
			name = "Preparing the Comparison",
			kind = "delivery",
			requires = {"BN15"},
			briefing = (
				"There is another supply request. Please check it before replacing something with a "
				.. "similar-looking object."
			),
			completion = (
				"That's the requested material. I can finish the preparation without adapting the method around "
				.. "it."
			),
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 5,
				},
			},
			benefits = {},
		},
		{
			id = "BN18",
			completionCash = 2050,
			name = "Pripyat Baseline",
			kind = "field",
			objective = (
				"Deploy and protect the sampler at the assigned site in Pripyat until the run finishes, then "
				.. "collect the results. Bring it back to the issuing contact in Garbage."
			),
			requires = {"BN16"},
			briefing = (
				"We need a defended baseline run in Pripyat. Prepare for the whole recording, not just getting the "
				.. "equipment there. Deploy and protect the sampler at the assigned site in Pripyat until the run "
				.. "finishes, then collect the results. Bring it back to me in Garbage."
			),
			completion = (
				"You're back with the results. I'll start by checking the run, before I ask it to support a "
				.. "comparison."
			),
			field = {
				description = (
					"A field recording recovered from the completed sampler run. Beanstalk's note: \"We need a "
					.. "defended baseline run in Pripyat.\""
				),
				label = "Pripyat baseline sampler results",
				kind = "defence",
				map = "rp_pripyat_remaster",
				tier = 3,
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
			id = "BN19",
			completionCash = 0,
			name = "Holding the Site",
			kind = "tracker",
			requires = {"BN17", "BN18"},
			briefing = "There are further defended sampler runs. Bring the completed results back intact.",
			completion = (
				"You've kept a consistent record through the work. I have better grounds for checking the "
				.. "comparison."
			),
			target = 20,
			benefits = {},
		},
		{
			id = "BN20",
			completionCash = 2250,
			name = "The Abandoned Station",
			kind = "field",
			objective = (
				"Recover the earlier station's research tape from the assigned search area in Pripyat. Bring it "
				.. "back to the issuing contact in Garbage."
			),
			requires = {"BN19"},
			briefing = (
				"The earlier team's recorder is still in Pripyat. Their account may qualify what we think we're "
				.. "measuring. Recover the earlier station's research tape from the assigned search area in Pripyat. "
				.. "Bring it back to me in Garbage."
			),
			completion = "Leave it beside the notes. I'll listen without assuming their question was the same as ours.",
			field = {
				description = (
					"A pale audio cassette with a handwritten dedication above the spool windows. Beanstalk's note: "
					.. "\"The earlier team's recorder is still in Pripyat.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_tape",
				label = "Earlier station's research tape",
			},
			benefits = {},
		},
		{
			id = "BN21",
			completionCash = 1775,
			name = "A Clean Comparison",
			kind = "delivery",
			requires = {"BN20"},
			briefing = (
				"Bring the listed records here intact. I need the account as written, including the "
				.. "qualifications."
			),
			completion = "Thank you. I'll read the whole record before selecting a passage.",
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 2,
				},
			},
			benefits = {},
		},
		{
			id = "BN22",
			completionCash = 2450,
			name = "The Last Control",
			kind = "field",
			objective = (
				"Recover the final control recording from the assigned search area in Pripyat. Bring it back to "
				.. "the issuing contact in Garbage."
			),
			requires = {"BN21"},
			briefing = (
				"There's a completed control recorder to recover. This order is a retrieval; bring the surviving "
				.. "record home for inspection. Recover the final control recording from the assigned search area in "
				.. "Pripyat. Bring it back to me in Garbage."
			),
			completion = "Good. I can compare the complete record instead of a remembered result.",
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. Beanstalk's "
					.. "note: \"There's a completed control recorder to recover.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module",
				label = "Final control recording",
			},
			benefits = {},
		},
		{
			id = "BN23",
			completionCash = 0,
			name = "Findings Worth Keeping",
			kind = "tracker",
			requires = {"BN22"},
			briefing = "Keep the research defence work going when you can prepare for it.",
			completion = (
				"You've stayed with the method through a long account. Thank you. Careful work deserves an answer "
				.. "more substantial than my next request."
			),
			target = 27,
			benefits = {},
		},
		{
			id = "BN24",
			completionCash = 2650,
			name = "A Result They Both Accept",
			kind = "field",
			objective = (
				"Recover the control comparison log for Carbon from the assigned search area in Garbage. Deliver "
				.. "it to 'Carbon' in Waystation, then come back to the issuing contact in Garbage."
			),
			requires = {"BN23"},
			briefing = (
				"Carbon needs the missing control evidence. I want the record somewhere another reader can examine "
				.. "it without relying on either researcher's account. Recover the control comparison log for Carbon "
				.. "from the assigned search area in Garbage. Deliver it to 'Carbon' in Waystation, then come back to "
				.. "me in Garbage."
			),
			completion = (
				"He has the file. You've helped make this work open to checking, including the parts that remain "
				.. "awkward. Thank you. We can talk about those without sending you out again today."
			),
			field = {
				description = (
					"A blue laboratory folder with loose printed record sheets extending from its edges. Beanstalk's "
					.. "note: \"Carbon needs the missing control evidence.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_lab",
				label = "Control comparison log for Carbon",
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
			recognition = "Beanstalk's trusted contact",
		},
	},
})
