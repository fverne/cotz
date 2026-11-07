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
		category = "Research defence",
		description = "Research defence",
		kind = "defence",
	},
	legacyJob = {
		category = "Research defence",
		description = "Research defence",
		kind = "defence",
		maps = {
			easy = "rp_marsh_cs",
			hard = "rp_pripyat_remaster",
			medium = "rp_waystation",
		},
	},
	supplies = {},
	rewards = {
		bonusPackages = {
			{
				items = {"medic_psyheal_2", "medic_stimpak_2"},
				label = "Specialist medicine",
			},
			{
				items = {"value_currency_dollar"},
				label = "Dollar notes",
			},
		},
		packages = {
			{
				items = {"medic_stimpak_1"},
				label = "Emergency medicine",
			},
			{
				items = {"medic_psyheal_1", "medic_antipsychotic_1"},
				label = "Research safety",
			},
			{
				items = {"food_can_tuna"},
				label = "Canned provisions",
			},
		},
	},
	dialogue = {
		completedGreeting = "Hello again. Keep clear of the tray, as usual. You know why I ask, which is a considerable improvement on most conversations here.",
		jobBriefing = "I need someone to stay with the equipment while it takes its readings. {details}",
		jobFinished = "You brought it through. Thank you. I'll look at the recordings after we've settled your payment.",
		jobReminder = "We still need those readings brought back. {details}",
		offerPrompt = "Do you have research defence work?",
		progression = "I need supplies for handling and checking samples. I would rather spend time preparing them than explain a result I cannot trust. Bring everything on the list back here; I need the full delivery.",
		progressionPrompt = "What needs comparing in the research records?",
		work = "Defended sampler runs. Deploy at the assigned site, stay close enough to protect the sampler, let the recording finish, then bring the results back. Prepare for the whole run. A quiet beginning is not evidence that the equipment can be left alone. We need the completed record before discussing how reassuring the conditions looked.",
		workPrompt = "About the sampler run I'm protecting.",
	},
	catalogue = {
		tundrasuppressor = {
			step = "v3/suppressors/tundrasuppressor",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		cobrasuppressor = {
			step = "v3/suppressors/cobrasuppressor",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		pbssuppressor = {
			step = "v3/suppressors/pbssuppressor",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		sakersuppressor = {
			step = "v3/suppressors/sakersuppressor",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		trijiconrmr = {
			step = "v3/red-dots/trijiconrmr",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		kobra = {
			step = "v3/red-dots/kobra",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		microt1 = {
			step = "v3/red-dots/microt1",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		eotech = {
			step = "v3/red-dots/eotech",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		cmore = {
			step = "v3/red-dots/cmore",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		aimpoint = {
			step = "v3/red-dots/aimpoint",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		kingarmsmr = {
			step = "v3/optics/kingarmsmr",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		pso1 = {
			step = "v3/optics/pso1",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		shortdot = {
			step = "v3/optics/shortdot",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		acog = {
			step = "v3/optics/acog",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		nightforce = {
			step = "v3/optics/nightforce",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
	},
	progression = {
		{
			id = "v3/suppressors/tundrasuppressor",
			branch = "suppressors",
			name = "Tundra suppressor",
			kind = "delivery",
			requires = {},
			briefing = "I need supplies for handling and checking samples. I would rather spend time preparing them than explain a result I cannot trust. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. I will check what we can use for the next set of samples.",
			requirements = {
				{
					pool = "common_artifacts",
					quantity = 1,
				},
			},
			completionCash = 450,
		},
		{
			id = "v3/suppressors/cobrasuppressor",
			branch = "suppressors",
			name = "Cobra M2 suppressor",
			kind = "delivery",
			requires = {"v3/suppressors/tundrasuppressor"},
			briefing = "I need supplies for handling and checking samples. I would rather spend time preparing them than explain a result I cannot trust. Bring everything on the list back here; I need the full delivery.",
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
			completionCash = 1300,
		},
		{
			id = "v3/suppressors/pbssuppressor",
			branch = "suppressors",
			name = "PBS suppressor",
			kind = "delivery",
			requires = {"v3/suppressors/cobrasuppressor"},
			briefing = "I need supplies for handling and checking samples. I would rather spend time preparing them than explain a result I cannot trust. Bring everything on the list back here; I need the full delivery.",
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
			completionCash = 2150,
		},
		{
			id = "v3/suppressors/sakersuppressor",
			branch = "suppressors",
			name = "SAKER suppressor",
			kind = "delivery",
			requires = {"v3/suppressors/pbssuppressor"},
			briefing = "I need supplies for handling and checking samples. I would rather spend time preparing them than explain a result I cannot trust. Bring everything on the list back here; I need the full delivery.",
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
			completionCash = 3000,
		},
		{
			id = "v3/red-dots/trijiconrmr",
			branch = "red-dots",
			name = "Trijicon RMR",
			kind = "delivery",
			requires = {},
			briefing = "I need supplies for handling and checking samples. I would rather spend time preparing them than explain a result I cannot trust. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. I will check what we can use for the next set of samples.",
			requirements = {
				{
					pool = "common_artifacts",
					quantity = 1,
				},
			},
			completionCash = 450,
		},
		{
			id = "v3/red-dots/kobra",
			branch = "red-dots",
			name = "Kobra sight",
			kind = "delivery",
			requires = {"v3/red-dots/trijiconrmr"},
			briefing = "I need supplies for handling and checking samples. I would rather spend time preparing them than explain a result I cannot trust. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. I will check what we can use for the next set of samples.",
			requirements = {
				{
					pool = "common_artifacts",
					quantity = 1,
				},
			},
			completionCash = 950,
		},
		{
			id = "v3/red-dots/microt1",
			branch = "red-dots",
			name = "Aimpoint Micro T1",
			kind = "delivery",
			requires = {"v3/red-dots/kobra"},
			briefing = "I need supplies for handling and checking samples. I would rather spend time preparing them than explain a result I cannot trust. Bring everything on the list back here; I need the full delivery.",
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
			completionCash = 1450,
		},
		{
			id = "v3/red-dots/eotech",
			branch = "red-dots",
			name = "Eotech holographic sight",
			kind = "delivery",
			requires = {"v3/red-dots/microt1"},
			briefing = "I need supplies for handling and checking samples. I would rather spend time preparing them than explain a result I cannot trust. Bring everything on the list back here; I need the full delivery.",
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
			completionCash = 1950,
		},
		{
			id = "v3/red-dots/cmore",
			branch = "red-dots",
			name = "CMore Railway",
			kind = "delivery",
			requires = {"v3/red-dots/eotech"},
			briefing = "I need supplies for handling and checking samples. I would rather spend time preparing them than explain a result I cannot trust. Bring everything on the list back here; I need the full delivery.",
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
			completionCash = 2450,
		},
		{
			id = "v3/red-dots/aimpoint",
			branch = "red-dots",
			name = "Aimpoint CompM4",
			kind = "delivery",
			requires = {"v3/red-dots/cmore"},
			briefing = "I need supplies for handling and checking samples. I would rather spend time preparing them than explain a result I cannot trust. Bring everything on the list back here; I need the full delivery.",
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
			completionCash = 3000,
		},
		{
			id = "v3/optics/kingarmsmr",
			branch = "optics",
			name = "King Arms MR",
			kind = "delivery",
			requires = {},
			briefing = "I need supplies for handling and checking samples. I would rather spend time preparing them than explain a result I cannot trust. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. I will check what we can use for the next set of samples.",
			requirements = {
				{
					pool = "common_artifacts",
					quantity = 1,
				},
			},
			completionCash = 450,
		},
		{
			id = "v3/optics/pso1",
			branch = "optics",
			name = "PSO-1",
			kind = "delivery",
			requires = {"v3/optics/kingarmsmr"},
			briefing = "I need supplies for handling and checking samples. I would rather spend time preparing them than explain a result I cannot trust. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. I will check what we can use for the next set of samples.",
			requirements = {
				{
					pool = "common_artifacts",
					quantity = 1,
				},
			},
			completionCash = 1050,
		},
		{
			id = "v3/optics/shortdot",
			branch = "optics",
			name = "Schmidt Shortdot",
			kind = "delivery",
			requires = {"v3/optics/pso1"},
			briefing = "I need supplies for handling and checking samples. I would rather spend time preparing them than explain a result I cannot trust. Bring everything on the list back here; I need the full delivery.",
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
			completionCash = 1700,
		},
		{
			id = "v3/optics/acog",
			branch = "optics",
			name = "ACOG Sight",
			kind = "delivery",
			requires = {"v3/optics/shortdot"},
			briefing = "I need supplies for handling and checking samples. I would rather spend time preparing them than explain a result I cannot trust. Bring everything on the list back here; I need the full delivery.",
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
			completionCash = 2350,
		},
		{
			id = "v3/optics/nightforce",
			branch = "optics",
			name = "Nightforce NXS",
			kind = "delivery",
			requires = {"v3/optics/acog"},
			briefing = "I need supplies for handling and checking samples. I would rather spend time preparing them than explain a result I cannot trust. Bring everything on the list back here; I need the full delivery.",
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
			completionCash = 3000,
		},
	},
	startingServices = {},
	retiredCommissions = {
		{
			id = "BN02",
			name = "The First Baseline",
			briefing = "We need a defended recording at the contamination site. I want a complete run before we choose which variation to explain. Deploy and protect the sampler at the assigned site in Garbage until the run finishes, then collect the results. Bring it back to me in Garbage.",
		},
		{
			id = "BN04",
			name = "A small delivery",
			briefing = "I need supplies for handling and checking samples. I would rather spend time preparing them than explain a result I cannot trust. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "BN06",
			name = "Two Sides of the Heap",
			briefing = "I'd like the comparison log recovered. The two sides of a site don't become comparable merely because someone used the same heading. Recover the dump comparison log from the assigned search area in Garbage. Bring it back to me in Garbage.",
		},
		{
			id = "BN08",
			name = "Restocking",
			briefing = "I need supplies for handling and checking samples. I would rather spend time preparing them than explain a result I cannot trust. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "BN10",
			name = "The Control Site",
			briefing = "We need another defended sampler run. A control deserves the same care as the result everyone finds interesting. Deploy and protect the sampler at the assigned site in Garbage until the run finishes, then collect the results. Bring it back to me in Garbage.",
		},
		{
			id = "BN12",
			name = "Restocking",
			briefing = "I need supplies for handling and checking samples. I would rather spend time preparing them than explain a result I cannot trust. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "BN14",
			name = "Beyond the Dumps",
			briefing = "The industrial-site comparison needs a defended recording. A useful method still has to survive the place we're asking you to use it. Deploy and protect the sampler at the assigned site in Garbage until the run finishes, then collect the results. Bring it back to me in Garbage.",
		},
		{
			id = "BN16",
			name = "Building the reserve",
			briefing = "I need supplies for handling and checking samples. I would rather spend time preparing them than explain a result I cannot trust. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "BN18",
			name = "Pripyat Baseline",
			briefing = "We need a defended baseline run in Pripyat. Prepare for the whole recording, not just getting the equipment there. Deploy and protect the sampler at the assigned site in Pripyat until the run finishes, then collect the results. Bring it back to me in Garbage.",
		},
		{
			id = "BN20",
			name = "A full supply order",
			briefing = "I need supplies for handling and checking samples. I would rather spend time preparing them than explain a result I cannot trust. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "BN22",
			name = "The Last Control",
			briefing = "There's a completed control recorder to recover. This order is a retrieval; bring the surviving record home for inspection. Recover the final control recording from the assigned search area in Pripyat. Bring it back to me in Garbage.",
		},
		{
			id = "BN24",
			name = "A full supply order",
			briefing = "I need supplies for handling and checking samples. I would rather spend time preparing them than explain a result I cannot trust. Bring everything on the list back here; I need the full delivery.",
		},
	},
})
