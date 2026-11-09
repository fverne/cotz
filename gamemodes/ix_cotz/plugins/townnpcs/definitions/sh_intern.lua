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
		category = "Sensor deployment and retrieval",
		description = "Sensor deployment and retrieval",
		kind = "sensor",
		maps = {
			easy = "rp_marsh_cs",
			hard = "rp_pripyat_remaster",
			medium = "rp_waystation",
		},
	},
	legacyJob = {
		category = "Bunker sensor deployment and retrieval",
		description = "Sensor deployment and retrieval",
		kind = "sensor",
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
				items = {"medic_stimpak_1"},
				label = "Emergency medicine",
			},
			{
				items = {"value_currency_euro"},
				label = "Euro notes",
			},
		},
		packages = {
			{
				items = {"medic_antirad_1"},
				label = "Exposure treatment",
			},
			{
				items = {"drug_caffeine"},
				label = "Overtime",
			},
			{
				items = {"food_can_corn"},
				label = "Canned provisions",
			},
		},
	},
	dialogue = {
		completedGreeting = "Hello! I've been keeping my own notes in order. It's rather nice to know what I want to say before anyone asks.",
		jobBriefing = "I have a survey I can use some help with. {details}",
		jobFinished = "Thank you. I'll check it against my notes. Let's settle your payment first.",
		jobReminder = "I'm keeping the rest of the survey together while you're out there. {details}",
		offerPrompt = "Do you have a sensor survey?",
		progression = "I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely on the readings. Bring everything on the list back here; I need the full delivery.",
		progressionPrompt = "What needs checking in your survey work?",
		work = "Sensor surveys. Deploy the recorder at the assigned site, let the run finish, then retrieve it and bring the results back. Check the destination before accepting. I can examine a complete recording; I can't recreate the part we missed by looking increasingly worried at the page. I've tested that approach rather thoroughly.",
		workPrompt = "About the survey I'm doing.",
	},
	disabledItems = {
		gasanalyzer = true,
	},
	catalogue = {
		detectorecho = {
			step = "v3/artifact-detectors/detectorecho",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		detectorbear = {
			step = "v3/artifact-detectors/detectorbear",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		detectorveles = {
			step = "v3/artifact-detectors/detectorveles",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
	},
	progressionIdentity = {
		name = "Detector calibration and survey equipment",
		core = {
			"field_instruments",
			"valuables_survey_equipment",
			"valuables_sample_carriers",
		},
		support = {"batteries", "valuables_technical_records"},
	},

	progression = {
		{
			id = "v3/artifact-detectors/detectorecho",
			branch = "artifact-detectors",
			name = "Artifact Detector (Echo)",
			kind = "delivery",
			requires = {},
			briefing = "I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely on the readings. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "town_expansion_a9a6a4663f7e",
					quantity = 1,
					artifactPool = "common_artifacts",
				},
			},
			branchIndex = 1,
			branchLength = 3,
			acquisitionMaps = {"rp_marsh_cs"},
			requirementPolicy = 4,
		},
		{
			id = "v3/artifact-detectors/detectorbear/stock",
			branch = "artifact-detectors",
			name = "Stock preparation: Artifact Detector (Echo)",
			kind = "delivery",
			requires = {"v3/artifact-detectors/detectorecho"},
			briefing = "I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely on the readings. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{pool = "town_expansion_8619904d9216", quantity = 1},
				{pool = "town_expansion_eb7056313562", quantity = 1},
			},
			stock = {
				items = {"detectorecho"},
				bonus = 1,
			},
			intermissionFor = "v3/artifact-detectors/detectorbear",
			branchIndex = 2,
			branchLength = 3,
			acquisitionMaps = {"rp_marsh_cs"},
			requirementPolicy = 4,
		},
		{
			id = "v3/artifact-detectors/detectorbear",
			branch = "artifact-detectors",
			name = "Artifact Detector (Bear)",
			kind = "delivery",
			requires = {
				"v3/artifact-detectors/detectorecho",
				"v3/artifact-detectors/detectorbear/stock",
			},
			briefing = "I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely on the readings. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "town_expansion_a9a6a4663f7e",
					quantity = 2,
					artifactPool = "common_artifacts",
				},
				{
					pool = "town_expansion_6af4f494aa60",
					quantity = 1,
					artifactPool = "electrical_artifacts",
				},
			},
			branchIndex = 2,
			branchLength = 3,
			acquisitionMaps = {"rp_marsh_cs"},
			requirementPolicy = 4,
		},
		{
			id = "v3/artifact-detectors/detectorveles/stock",
			branch = "artifact-detectors",
			name = "Stock preparation: Artifact Detector (Bear)",
			kind = "delivery",
			requires = {"v3/artifact-detectors/detectorbear"},
			briefing = "I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely on the readings. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{pool = "town_expansion_96f10f2d5514", quantity = 2},
				{pool = "town_expansion_7056d335ecb3", quantity = 2},
				{pool = "town_expansion_e010d2b94975", quantity = 1},
				{pool = "town_expansion_52c92cccdf1a", quantity = 1},
			},
			stock = {
				items = {"detectorbear"},
				bonus = 1,
			},
			intermissionFor = "v3/artifact-detectors/detectorveles",
			branchIndex = 3,
			branchLength = 3,
			acquisitionMaps = {
				"rp_marsh_cs",
				"rp_garbage_cotz",
				"rp_waystation",
				"rp_pripyat_remaster",
			},
			requirementPolicy = 4,
		},
		{
			id = "v3/artifact-detectors/detectorveles",
			branch = "artifact-detectors",
			name = "Artifact Detector (Veles)",
			kind = "delivery",
			requires = {
				"v3/artifact-detectors/detectorbear",
				"v3/artifact-detectors/detectorveles/stock",
			},
			briefing = "I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely on the readings. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "town_expansion_a9a6a4663f7e",
					quantity = 4,
					artifactPool = "common_artifacts",
				},
				{
					pool = "town_expansion_6af4f494aa60",
					quantity = 3,
					artifactPool = "electrical_artifacts",
				},
				{
					pool = "town_expansion_9ee1d71f61fc",
					quantity = 2,
					artifactPool = "rare_field_artifacts",
				},
				{
					pool = "town_expansion_eb5fb8c496fa",
					quantity = 1,
					artifactPool = "exceptional_artifacts",
				},
			},
			branchIndex = 3,
			branchLength = 3,
			acquisitionMaps = {
				"rp_marsh_cs",
				"rp_garbage_cotz",
				"rp_waystation",
				"rp_pripyat_remaster",
			},
			requirementPolicy = 4,
		},
	},
	startingServices = {},
	retiredCommissions = {
		{
			id = "IN02",
			name = "The Calibration Point",
			briefing = "I'd like to start with a recording near Waystation. I want to check my preparation against a complete return, not just an instrument on a shelf. Deploy the recorder at the assigned site in Waystation, let it finish recording, then retrieve the first calibration recorder. Bring it back to me in Waystation.",
		},
		{
			id = "IN04",
			name = "A small delivery",
			briefing = "I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely on the readings. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "IN06",
			name = "Beanstalk's Control",
			briefing = "We need a recording at the Garbage control site. I'd like a comparison I can explain without borrowing somebody else's confidence. Deploy the recorder at the assigned site in Garbage, let it finish recording, then retrieve the Garbage control recorder. Bring it back to me in Waystation.",
		},
		{
			id = "IN08",
			name = "Restocking",
			briefing = "I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely on the readings. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "IN10",
			name = "The Senior's Notebook",
			briefing = "I'd like the research note brought back intact. It's difficult to ask a useful question about a page everyone remembers differently. Recover the senior researcher's notebook from the assigned search area in Waystation. Bring it back to me in Waystation.",
		},
		{
			id = "IN12",
			name = "Restocking",
			briefing = "I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely on the readings. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "IN14",
			name = "The Lost Calibration Case",
			briefing = "Technut should inspect the instrument case. I can describe the fault, but I'd rather he saw the equipment himself. Recover the calibration case for Technut from the assigned search area in Waystation. Deliver it to 'Technut' in Marsh, then come back to me in Waystation.",
		},
		{
			id = "IN16",
			name = "Building the reserve",
			briefing = "I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely on the readings. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "IN18",
			name = "The Contradictory Site",
			briefing = "We need another recording from the disputed site. If it disagrees, I want to know that before I start making the graph look tidy. Deploy the recorder at the assigned site in Pripyat, let it finish recording, then retrieve the contradictory-site recorder. Bring it back to me in Waystation.",
		},
		{
			id = "IN20",
			name = "Building the reserve",
			briefing = "I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely on the readings. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "IN22",
			name = "The Independent Control",
			briefing = "One more control recording in Pripyat. I want to be able to explain this comparison in my own words. Deploy the recorder at the assigned site in Pripyat, let it finish recording, then retrieve the independent control recorder. Bring it back to me in Waystation.",
		},
		{
			id = "IN24",
			name = "A full supply order",
			briefing = "I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely on the readings. Bring everything on the list back here; I need the full delivery.",
		},
	},
})
