PLUGIN:Register("beanstalk", {
	name = "'Beanstalk'",
	template = "ecologistnpc2",
	difficultyMultiplier = 5,
	enforceCatalogue = true,
	map = "rp_marsh_cs",
	bunker = true,
	courierPools = {
		"valuables_research_samples",
		"valuables_sample_carriers",
		"valuables_instruments",
		"valuables_technical_records",
	},
	job = {
		kind = "defence",
		category = "Research defence",
		description = "Research defence",
	},
	legacyJob = {
		kind = "defence",
		category = "Research defence",
		description = "Research defence",
		maps = {
			easy = "rp_marsh_cs",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {},
	rewards = {
		packages = {
			{label = "Emergency medicine", items = {"medic_stimpak_1"}},
			{label = "Research safety", items = {"medic_psyheal_1", "medic_antipsychotic_1"}},
			{label = "Canned provisions", items = {"food_can_tuna"}},
		},
		bonusPackages = {
			{label = "Specialist medicine", items = {"medic_psyheal_2", "medic_stimpak_2"}},
			{label = "Dollar notes", items = {"value_currency_dollar"}},
		},
	},
	dialogue = {
		jobBriefing = "I need someone to stay with the equipment while it takes its readings. {details}",
		jobReminder = "We still need those readings brought back. {details}",
		jobFinished = "You brought it through. Thank you. I'll look at the recordings after we've settled your payment.",
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
		["127x55"] = {step = "BN20",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["22lr"] = {step = "BN03",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["22lrap"] = {step = "BN05",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["22lrhp"] = {step = "BN04",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["338lapua"] = {step = "BN17",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["338lapuaap"] = {step = "BN19",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["338lapuahp"] = {step = "BN18",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["357magnum"] = {step = "BN11",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["357magnumap"] = {step = "BN13",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["357magnumhp"] = {step = "BN12",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["44magnum"] = {step = "BN13",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["44magnumap"] = {step = "BN15",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["44magnumhp"] = {step = "BN14",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["45acp"] = {step = "BN02",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["45acpap"] = {step = "BN04",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["45acphp"] = {step = "BN03",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["500magnum"] = {step = "BN16",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["500magnumap"] = {step = "BN18",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["500magnumhp"] = {step = "BN17",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["50ae"] = {step = "BN18",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["50aeap"] = {step = "BN20",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["50aehp"] = {step = "BN19",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["545x39"] = {step = "BN04",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["545x39ap"] = {step = "BN06",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["545x39hp"] = {step = "BN05",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["556x45"] = {step = "BN08",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["556x45ap"] = {step = "BN10",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["556x45hp"] = {step = "BN09",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["57x28"] = {step = "BN19",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["57x28ap"] = {step = "BN21",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["57x28hp"] = {step = "BN20",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x25"] = {step = "BN01",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x25ap"] = {step = "BN03",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x25hp"] = {step = "BN02",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x39"] = {step = "BN07",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x39ap"] = {step = "BN09",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x39hp"] = {step = "BN08",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x51"] = {step = "BN15",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x51ap"] = {step = "BN17",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x51hp"] = {step = "BN16",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x54"] = {step = "BN10",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x54ap"] = {step = "BN12",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["762x54hp"] = {step = "BN11",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["93x64"] = {step = "BN22",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["9x18"] = {step = "BN09",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["9x18ap"] = {step = "BN11",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["9x18hp"] = {step = "BN10",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["9x19"] = {step = "BN01",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["9x19ap"] = {step = "BN03",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["9x19hp"] = {step = "BN02",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["9x21"] = {step = "BN14",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["9x21ap"] = {step = "BN16",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["9x21hp"] = {step = "BN15",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["9x39"] = {step = "BN12",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["9x39ap"] = {step = "BN14",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["9x39hp"] = {step = "BN13",
			terms = {nil, 2, "SELLONLY", 2, 12, 1}},
		["suit_seva"] = {step = "BN24",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["suit_ssp99"] = {step = "BN01",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
		["suit_ssp99m"] = {step = "BN13",
			terms = {nil, 1, "SELLONLY", 1, 48, 1}},
	},
	progression = {
		{
			id = "BN01",
			completionCash = 275,
			name = "A Station in the Dust",
			kind = "delivery",
			requires = {},
			briefing = (
				"I need supplies for handling and checking samples. I would rather spend time preparing them than "
				.. "explain a result I cannot trust. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Thank you. I will check what we can use for the next set of samples.",
			requirements = {
				{
					pool = "common_artifacts",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BN02",
			completionCash = 450,
			name = "The First Baseline",
			kind = "field",
			objective = (
				"Deploy and protect the sampler at the assigned site in Garbage until the run finishes, then "
				.. "collect the results. Bring it back to the issuing contact in Marsh."
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
				map = "rp_garbage_cotz",
				tier = 1,
			},
			benefits = {},
		},
		{
			id = "BN03",
			stock = {item = "22lr", bonus = 1},
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
			name = "A small delivery",
			kind = "delivery",
			retiredCommission = true,
			objective = "Bring all 1 listed item type to this contact. The request shows each selected item and required units.",
			requires = {"BN03"},
			briefing = (
				"I need supplies for handling and checking samples. I would rather spend time preparing them than "
				.. "explain a result I cannot trust. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Thank you. I will check what we can use for the next set of samples.",
			requirements = {
				{
					pool = "common_artifacts",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "BN05",
			completionCash = 575,
			name = "Keeping It Sealed",
			kind = "delivery",
			requires = {"BN03"},
			briefing = (
				"I need supplies for handling and checking samples. I would rather spend time preparing them than "
				.. "explain a result I cannot trust. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Thank you. I will check what we can use for the next set of samples.",
			requirements = {
				{
					pool = "common_artifacts",
					quantity = 1,
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
				.. "issuing contact in Marsh."
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
				map = "rp_garbage_cotz",
				tier = 1,
				cargo = "town_quest_lab",
				label = "Dump comparison log",
			},
			benefits = {},
		},
		{
			id = "BN07",
			stock = {item = "22lrap", bonus = 1},
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
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement cosmetic consumer; verify these proposed terms before enabling.
				{
					baseSuit = "suit_anorak",
					effect = "Apply environmental research colours to suit_anorak; appearance only, with no gameplay variant changes.",
					finish = "beanstalk-bn08",
					id = "beanstalk/BN08/future",
					kind = "cosmetic",
					name = "Restocking: environmental research colours",
					provider = "beanstalk",
					status = "unimplemented",
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
			requires = {"BN06"},
			briefing = (
				"I need supplies for handling and checking samples. I would rather spend time preparing them than "
				.. "explain a result I cannot trust. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Thank you. I will check what we can use for the next set of samples.",
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
			id = "BN09",
			completionCash = 875,
			name = "Clean Instruments",
			kind = "delivery",
			requires = {"BN07"},
			briefing = (
				"I need supplies for handling and checking samples. I would rather spend time preparing them than "
				.. "explain a result I cannot trust. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Thank you. I will check what we can use for the next set of samples.",
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
			id = "BN10",
			completionCash = 1250,
			name = "The Control Site",
			kind = "field",
			objective = (
				"Deploy and protect the sampler at the assigned site in Garbage until the run finishes, then "
				.. "collect the results. Bring it back to the issuing contact in Marsh."
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
				map = "rp_garbage_cotz",
				tier = 2,
			},
			benefits = {},
		},
		{
			id = "BN11",
			stock = {item = "22lrhp", bonus = 1},
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
			plannedUnlocks = {
				-- TODO: Implement cosmetic consumer; verify these proposed terms before enabling.
				{
					baseSuit = "suit_mailjacket",
					effect = (
						"Apply environmental research colours to suit_mailjacket; appearance only, with no "
						.. "gameplay variant changes."
					),
					finish = "beanstalk-bn12",
					id = "beanstalk/BN12/future",
					kind = "cosmetic",
					name = "Restocking: environmental research colours",
					provider = "beanstalk",
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
			requires = {"BN10"},
			briefing = (
				"I need supplies for handling and checking samples. I would rather spend time preparing them than "
				.. "explain a result I cannot trust. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Thank you. I will check what we can use for the next set of samples.",
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
			id = "BN13",
			completionCash = 1175,
			name = "A Field Lab in Reserve",
			kind = "delivery",
			requires = {"BN11"},
			briefing = (
				"I need supplies for handling and checking samples. I would rather spend time preparing them than "
				.. "explain a result I cannot trust. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Thank you. I will check what we can use for the next set of samples.",
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
			id = "BN14",
			completionCash = 1650,
			name = "Beyond the Dumps",
			kind = "field",
			objective = (
				"Deploy and protect the sampler at the assigned site in Garbage until the run finishes, then "
				.. "collect the results. Bring it back to the issuing contact in Marsh."
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
				map = "rp_garbage_cotz",
				tier = 2,
			},
			benefits = {},
		},
		{
			id = "BN15",
			stock = {item = "762x25", bonus = 1},
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
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"BN14"},
			briefing = (
				"I need supplies for handling and checking samples. I would rather spend time preparing them than "
				.. "explain a result I cannot trust. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Thank you. I will check what we can use for the next set of samples.",
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
			benefits = {},
		},
		{
			id = "BN17",
			completionCash = 1475,
			name = "Preparing the Comparison",
			kind = "delivery",
			requires = {"BN15"},
			briefing = (
				"I need supplies for handling and checking samples. I would rather spend time preparing them than "
				.. "explain a result I cannot trust. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Thank you. I will check what we can use for the next set of samples.",
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
			benefits = {},
		},
		{
			id = "BN18",
			completionCash = 2050,
			name = "Pripyat Baseline",
			kind = "field",
			objective = (
				"Deploy and protect the sampler at the assigned site in Pripyat until the run finishes, then "
				.. "collect the results. Bring it back to the issuing contact in Marsh."
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
			benefits = {},
		},
		{
			id = "BN19",
			stock = {item = "762x25ap", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement cosmetic consumer; verify these proposed terms before enabling.
				{
					baseSuit = "suit_sunrise",
					effect = (
						"Apply environmental research colours to suit_sunrise; appearance only, with no "
						.. "gameplay variant changes."
					),
					finish = "beanstalk-bn19",
					id = "beanstalk/BN19/future",
					kind = "cosmetic",
					name = "Holding the Site: environmental research colours",
					provider = "beanstalk",
					status = "unimplemented",
				},
			},
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
		},
		{
			id = "BN20",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement cosmetic consumer; verify these proposed terms before enabling.
				{
					baseSuit = "suit_io7a",
					effect = "Apply environmental research colours to suit_io7a; appearance only, with no gameplay variant changes.",
					finish = "beanstalk-bn20",
					id = "beanstalk/BN20/future",
					kind = "cosmetic",
					name = "A full supply order: environmental research colours",
					provider = "beanstalk",
					status = "unimplemented",
				},
			},
			completionCash = 2250,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"BN19"},
			briefing = (
				"I need supplies for handling and checking samples. I would rather spend time preparing them than "
				.. "explain a result I cannot trust. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Thank you. I will check what we can use for the next set of samples.",
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
			id = "BN21",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement cosmetic consumer; verify these proposed terms before enabling.
				{
					baseSuit = "suit_cs1",
					effect = "Apply environmental research colours to suit_cs1; appearance only, with no gameplay variant changes.",
					finish = "beanstalk-bn21",
					id = "beanstalk/BN21/future",
					kind = "cosmetic",
					name = "A Clean Comparison: environmental research colours",
					provider = "beanstalk",
					status = "unimplemented",
				},
			},
			completionCash = 1775,
			name = "A Clean Comparison",
			kind = "delivery",
			requires = {"BN20"},
			briefing = (
				"I need supplies for handling and checking samples. I would rather spend time preparing them than "
				.. "explain a result I cannot trust. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Thank you. I will check what we can use for the next set of samples.",
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
			id = "BN22",
			stock = {item = "762x25hp", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement cosmetic consumer; verify these proposed terms before enabling.
				{
					baseSuit = "suit_ps5m",
					effect = "Apply environmental research colours to suit_ps5m; appearance only, with no gameplay variant changes.",
					finish = "beanstalk-bn22",
					id = "beanstalk/BN22/future",
					kind = "cosmetic",
					name = "The Last Control: environmental research colours",
					provider = "beanstalk",
					status = "unimplemented",
				},
			},
			completionCash = 2450,
			name = "The Last Control",
			kind = "field",
			objective = (
				"Recover the final control recording from the assigned search area in Pripyat. Bring it back to "
				.. "the issuing contact in Marsh."
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
		},
		{
			id = "BN23",
			stock = {item = "9x18", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement cosmetic consumer; verify these proposed terms before enabling.
				{
					baseSuit = "suit_nbc",
					effect = "Apply environmental research colours to suit_nbc; appearance only, with no gameplay variant changes.",
					finish = "beanstalk-bn23",
					id = "beanstalk/BN23/future",
					kind = "cosmetic",
					name = "Findings Worth Keeping: environmental research colours",
					provider = "beanstalk",
					status = "unimplemented",
				},
			},
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
		},
		{
			id = "BN24",
			completionCash = 2650,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"BN23"},
			briefing = (
				"I need supplies for handling and checking samples. I would rather spend time preparing them than "
				.. "explain a result I cannot trust. Bring everything on the list back here; I need the full "
				.. "delivery."
			),
			completion = "Thank you. I will check what we can use for the next set of samples.",
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
			recognition = "Beanstalk's trusted contact",
		},
	},
})
