PLUGIN:Register("egghead", {
	name = "'Egghead'",
	template = "ecologistnpc",
	difficultyMultiplier = 3,
	enforceCatalogue = true,
	map = "rp_marsh_cs",
	bunker = true,
	courierPools = {
		"valuables_research_samples",
		"valuables_instruments",
		"valuables_technical_records",
		"valuables_recording_equipment",
	},
	job = {
		category = "Bunker mutant specimens",
		description = "Specific mutant specimens",
		kind = "regionalSpecimens",
		maps = {
			easy = "rp_garbage_cotz",
			hard = "rp_pripyat_remaster",
			medium = "rp_waystation",
		},
	},
	legacyJob = {
		category = "Artifact deliveries",
		description = "Artifact deliveries",
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		pools = {"common_artifacts", "electrical_artifacts"},
		quantities = {2, 4, 7},
	},
	supplies = {
		"food_mre_ukraine",
		"food_mre_russia",
		"drink_canwater",
		"medic_antirad_1",
		"medic_bandage_1",
		"medic_medkit_1",
	},
	rewards = {
		bonusPackages = {
			{
				items = {"medic_psyheal_2", "medic_antipsychotic_2"},
				label = "Specialist medicine",
			},
			{
				items = {"value_currency_euro"},
				label = "Euro notes",
			},
		},
		packages = {
			{
				items = {"medic_antirad_1", "medic_antirad_2"},
				label = "Exposure treatment",
			},
			{
				items = {"medic_stimpak_1"},
				label = "Emergency medicine",
			},
			{
				items = {"food_can_tuna"},
				label = "Canned provisions",
			},
		},
	},
	dialogue = {
		completedGreeting = "Hello again. Something to compare, or simply a question? We can probably find time for either.",
		jobBriefing = "I have a comparison I'd like to make. {details}",
		jobFinished = "Ah, good. That gives me something to examine. Let's settle your payment before I get distracted.",
		jobReminder = "I'm still missing material for that comparison. {details}",
		offerPrompt = "Do you need mutant specimens?",
		progression = "I need material for the research bench. Yes, there is a list; I remembered to write it before getting distracted this time. Bring everything on the list back here; I need the full delivery.",
		progressionPrompt = "What are you comparing at the moment?",
		work = "Mutant specimens. A particular part, from a particular species, in the number written on the request. An impressive substitute is still a substitute, however much we might enjoy examining it. You can bring specimens you already have. Check the suggested region before going out; some of these animals are rather less obliging than the illustrations.",
		workPrompt = "About the mutant specimens I am collecting.",
	},
	disabledItems = {
		accesscard_laboratory = true,
	},
	catalogue = {
		suit_ssp99 = {
			step = "v3/science-suits/suit_ssp99",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		suit_ssp99m = {
			step = "v3/science-suits/suit_ssp99m",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		suit_seva = {
			step = "v3/science-suits/suit_seva",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
	},
	progression = {
		{
			id = "v3/science-suits/suit_ssp99",
			branch = "science-suits",
			name = "SSP-99",
			kind = "delivery",
			requires = {},
			briefing = "I need material for the research bench. Yes, there is a list; I remembered to write it before getting distracted this time. Bring everything on the list back here; I need the full delivery.",
			completion = "Excellent. Let me put these aside before I start explaining what I want to compare.",
			requirements = {
				{
					pool = "common_artifacts",
					quantity = 1,
				},
			},
			completionCash = 450,
		},
		{
			id = "v3/science-suits/suit_ssp99m",
			branch = "science-suits",
			name = "SSP-99M",
			kind = "delivery",
			requires = {"v3/science-suits/suit_ssp99"},
			briefing = "I need material for the research bench. Yes, there is a list; I remembered to write it before getting distracted this time. Bring everything on the list back here; I need the full delivery.",
			completion = "Excellent. Let me put these aside before I start explaining what I want to compare.",
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
			id = "v3/science-suits/suit_seva",
			branch = "science-suits",
			name = "SEVA Suit",
			kind = "delivery",
			requires = {"v3/science-suits/suit_ssp99m"},
			briefing = "I need material for the research bench. Yes, there is a list; I remembered to write it before getting distracted this time. Bring everything on the list back here; I need the full delivery.",
			completion = "Excellent. Let me put these aside before I start explaining what I want to compare.",
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
			id = "EG02",
			name = "The Control Notebook",
			briefing = "I'd like the reference notebook recovered. A careful result becomes rather less useful when nobody can find the method. Recover the reference field notebook from the assigned search area in Waystation. Bring it back to me in Waystation.",
		},
		{
			id = "EG04",
			name = "A small delivery",
			briefing = "I need material for the research bench. Yes, there is a list; I remembered to write it before getting distracted this time. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "EG06",
			name = "The Comparison Site",
			briefing = "We need a recording at the comparison site. I'd enjoy being able to disagree about a reading we both have in front of us. Deploy the recorder at the assigned site in Waystation, let it finish recording, then retrieve the artifact comparison recorder. Bring it back to me in Waystation.",
		},
		{
			id = "EG08",
			name = "Restocking",
			briefing = "I need material for the research bench. Yes, there is a list; I remembered to write it before getting distracted this time. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "EG10",
			name = "The Failed Trial",
			briefing = "I'd like the trial recording recovered. A failed experiment can be useful, provided nobody has edited out the embarrassment. Recover the failed-trial recording from the assigned search area in Waystation. Bring it back to me in Waystation.",
		},
		{
			id = "EG12",
			name = "Restocking",
			briefing = "I need material for the research bench. Yes, there is a list; I remembered to write it before getting distracted this time. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "EG14",
			name = "Beanstalk's Objection",
			briefing = "Vesper should examine the environmental control evidence. I'd like her field objections in the comparison before I decide it is satisfactory. Recover the environmental control for Vesper from the assigned search area in Garbage. Deliver it to 'Vesper' in Garbage, then come back to me in Waystation.",
		},
		{
			id = "EG16",
			name = "Building the reserve",
			briefing = "I need material for the research bench. Yes, there is a list; I remembered to write it before getting distracted this time. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "EG18",
			name = "The Pripyat Baseline",
			briefing = "I'd like the earlier team's recording from Pripyat. Their questions may have been different from ours. Recover the earlier team's research tape from the assigned search area in Pripyat. Bring it back to me in Waystation.",
		},
		{
			id = "EG20",
			name = "Building the reserve",
			briefing = "I need material for the research bench. Yes, there is a list; I remembered to write it before getting distracted this time. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "EG22",
			name = "The Family Resemblance",
			briefing = "Bring the final comparison recorder home. I'm interested in the awkward readings as well as the promising ones. Recover the final comparison recording from the assigned search area in Pripyat. Bring it back to me in Waystation.",
		},
		{
			id = "EG24",
			name = "A full supply order",
			briefing = "I need material for the research bench. Yes, there is a list; I remembered to write it before getting distracted this time. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "EG26",
			name = "A full supply order",
			briefing = "I need material for the research bench. Yes, there is a list; I remembered to write it before getting distracted this time. Bring everything on the list back here; I need the full delivery.",
		},
	},
})
