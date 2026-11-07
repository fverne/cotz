PLUGIN:Register("spool", {
	name = "'Spool'",
	template = "spoolnpc",
	difficultyMultiplier = 3.5,
	enforceCatalogue = true,
	map = "rp_garbage_cotz",
	courierPools = {
		"valuables_radio_equipment",
		"valuables_radio_components",
		"valuables_recording_equipment",
		"valuables_portable_power",
	},
	job = {
		category = "Radio triangulation",
		description = "Radio triangulation",
		kind = "triangulation",
		maps = {
			easy = "rp_garbage_cotz",
			hard = "rp_pripyat_remaster",
			medium = "rp_waystation",
		},
	},
	legacyJob = {
		category = "Radio triangulation",
		description = "Radio triangulation",
		kind = "triangulation",
		maps = {
			easy = "rp_garbage_cotz",
			hard = "rp_pripyat_remaster",
			medium = "rp_waystation",
		},
	},
	supplies = {},
	rewards = {
		bonusPackages = {
			{
				items = {"value_currency_euro"},
				label = "Euro notes",
			},
			{
				items = {"value_currency_dollar"},
				label = "Dollar notes",
			},
		},
		cashPerTier = 200,
		packages = {},
	},
	dialogue = {
		completedGreeting = "Oh, hello. Nice to have someone here I don't need to ask to repeat themselves through the interference.",
		delivery = "Right, one moment. Let me find the matching entry.",
		jobBriefing = "There's something out there I can't place from here. {details}",
		jobFinished = "There it is. I'll leave the listening for a moment and get your payment sorted.",
		jobReminder = "I still haven't got that source in front of me. {details}",
		offerPrompt = "Do you have a triangulation job?",
		progression = "I need supplies for the radio bench. I would like the set ready when somebody calls, without holding a connection together by hand. Bring everything on the list back here; I need the full delivery.",
		progressionPrompt = "What are you checking in the station recordings?",
		work = "Take the required bearings, locate the source, and bring the transmitter back. I'll listen to the recording here. Check the destination before accepting. I like hearing somebody arrive where they meant to go; gives me a moment to enjoy the ordinary part before we discover what the equipment has been doing.",
		workPrompt = "About the source I'm locating.",
	},
	disabledItems = {
		rfreceiver = true,
	},
	catalogue = {
		helm_tanker = {
			step = "v3/steel-headwear/helm_tanker",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		helm_steel_arab = {
			step = "v3/steel-headwear/helm_steel_arab",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		helm_steel_ger = {
			step = "v3/steel-headwear/helm_steel_ger",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		helm_steel_rus = {
			step = "v3/steel-headwear/helm_steel_rus",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		headwear_riot = {
			step = "v3/steel-headwear/headwear_riot",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drug_adrenaline = {
			step = "v3/strong-drugs/drug_adrenaline",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drug_morphine = {
			step = "v3/strong-drugs/drug_morphine",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drug_marijuana = {
			step = "v3/strong-drugs/drug_marijuana",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		miscaid_swampbrew = {
			step = "v3/strong-drugs/miscaid_swampbrew",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drug_glucose = {
			step = "v3/strong-drugs/drug_glucose",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		drug_cocaine = {
			step = "v3/strong-drugs/drug_cocaine",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
	},
	progression = {
		{
			id = "v3/steel-headwear/helm_tanker",
			branch = "steel-headwear",
			name = "Russian Tank Helmet",
			kind = "delivery",
			requires = {},
			briefing = "I need supplies for the radio bench. I would like the set ready when somebody calls, without holding a connection together by hand. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. Leave those by the bench; I will check them between calls.",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 450,
		},
		{
			id = "v3/steel-headwear/helm_steel_arab",
			branch = "steel-headwear",
			name = "Arab Steel Helmet",
			kind = "delivery",
			requires = {"v3/steel-headwear/helm_tanker"},
			briefing = "I need supplies for the radio bench. I would like the set ready when somebody calls, without holding a connection together by hand. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. Leave those by the bench; I will check them between calls.",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 1050,
		},
		{
			id = "v3/steel-headwear/helm_steel_ger",
			branch = "steel-headwear",
			name = "German Steel Helmet",
			kind = "delivery",
			requires = {"v3/steel-headwear/helm_steel_arab"},
			briefing = "I need supplies for the radio bench. I would like the set ready when somebody calls, without holding a connection together by hand. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. Leave those by the bench; I will check them between calls.",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1700,
		},
		{
			id = "v3/steel-headwear/helm_steel_rus",
			branch = "steel-headwear",
			name = "Russian Steel Helmet",
			kind = "delivery",
			requires = {"v3/steel-headwear/helm_steel_ger"},
			briefing = "I need supplies for the radio bench. I would like the set ready when somebody calls, without holding a connection together by hand. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. Leave those by the bench; I will check them between calls.",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_electronics_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2350,
		},
		{
			id = "v3/steel-headwear/headwear_riot",
			branch = "steel-headwear",
			name = "Riot Helmet",
			kind = "delivery",
			requires = {"v3/steel-headwear/helm_steel_rus"},
			briefing = "I need supplies for the radio bench. I would like the set ready when somebody calls, without holding a connection together by hand. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. Leave those by the bench; I will check them between calls.",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_electronics_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_electronics_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_marsh_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
		},
		{
			id = "v3/strong-drugs/drug_adrenaline",
			branch = "strong-drugs",
			name = "Adrenaline Injector",
			kind = "delivery",
			requires = {},
			briefing = "I need supplies for the radio bench. I would like the set ready when somebody calls, without holding a connection together by hand. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. Leave those by the bench; I will check them between calls.",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 450,
		},
		{
			id = "v3/strong-drugs/drug_morphine",
			branch = "strong-drugs",
			name = "Morphine Syringe",
			kind = "delivery",
			requires = {"v3/strong-drugs/drug_adrenaline"},
			briefing = "I need supplies for the radio bench. I would like the set ready when somebody calls, without holding a connection together by hand. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. Leave those by the bench; I will check them between calls.",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 950,
		},
		{
			id = "v3/strong-drugs/drug_marijuana",
			branch = "strong-drugs",
			name = "Marijuana Joint",
			kind = "delivery",
			requires = {"v3/strong-drugs/drug_morphine"},
			briefing = "I need supplies for the radio bench. I would like the set ready when somebody calls, without holding a connection together by hand. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. Leave those by the bench; I will check them between calls.",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1450,
		},
		{
			id = "v3/strong-drugs/miscaid_swampbrew",
			branch = "strong-drugs",
			name = "Swamp Doctor's Brew",
			kind = "delivery",
			requires = {"v3/strong-drugs/drug_marijuana"},
			briefing = "I need supplies for the radio bench. I would like the set ready when somebody calls, without holding a connection together by hand. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. Leave those by the bench; I will check them between calls.",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1950,
		},
		{
			id = "v3/strong-drugs/drug_glucose",
			branch = "strong-drugs",
			name = "Glucose Syringe",
			kind = "delivery",
			requires = {"v3/strong-drugs/miscaid_swampbrew"},
			briefing = "I need supplies for the radio bench. I would like the set ready when somebody calls, without holding a connection together by hand. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. Leave those by the bench; I will check them between calls.",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_electronics_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2450,
		},
		{
			id = "v3/strong-drugs/drug_cocaine",
			branch = "strong-drugs",
			name = "Cocaine",
			kind = "delivery",
			requires = {"v3/strong-drugs/drug_glucose"},
			briefing = "I need supplies for the radio bench. I would like the set ready when somebody calls, without holding a connection together by hand. Bring everything on the list back here; I need the full delivery.",
			completion = "Thanks. Leave those by the bench; I will check them between calls.",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_electronics_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_electronics_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_marsh_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
		},
	},
	startingServices = {},
	retiredCommissions = {
		{
			id = "SO02",
			name = "The Local Silence",
			briefing = "There's a source we aren't hearing properly. I'd like it located and brought back before I blame the equipment on this side. Take the required bearings in Waystation, locate the source, and collect the local silent transmitter. Bring it back to me in Garbage.",
		},
		{
			id = "SO04",
			name = "A small delivery",
			briefing = "I need supplies for the radio bench. I would like the set ready when somebody calls, without holding a connection together by hand. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "SO06",
			name = "The Crossed Bearings",
			briefing = "Technut needs the calibration record. He can check the hardware side without me making increasingly elaborate sounds at him. Recover the calibration file for Technut from the assigned search area in Waystation. Deliver it to 'Technut' in Marsh, then come back to me in Garbage.",
		},
		{
			id = "SO08",
			name = "Restocking",
			briefing = "I need supplies for the radio bench. I would like the set ready when somebody calls, without holding a connection together by hand. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "SO10",
			name = "Mute's Header",
			briefing = "There's a damaged network record out in Marsh. I'd like to see what remains before deciding who it connects to. Recover the network header from the assigned search area in Marsh. Bring it back to me in Garbage.",
		},
		{
			id = "SO12",
			name = "Building the reserve",
			briefing = "I need supplies for the radio bench. I would like the set ready when somebody calls, without holding a connection together by hand. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "SO14",
			name = "The Unsent Call",
			briefing = "Wake should have the check-in recording. She may recognise something about the journey that I'd miss while concentrating on the voice. Recover the unsent check-in for Wake from the assigned search area in Waystation. Deliver it to 'Wake' in Garbage, then come back to me in Garbage.",
		},
		{
			id = "SO16",
			name = "Building the reserve",
			briefing = "I need supplies for the radio bench. I would like the set ready when somebody calls, without holding a connection together by hand. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "SO18",
			name = "The Last Check-in",
			briefing = "The later expedition recording goes to Wake. She should hear it without my account standing between her and the speaker. Recover the later check-in for Wake from the assigned search area in Pripyat. Deliver it to 'Wake' in Garbage, then come back to me in Garbage.",
		},
		{
			id = "SO20",
			name = "A full supply order",
			briefing = "I need supplies for the radio bench. I would like the set ready when somebody calls, without holding a connection together by hand. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "SO22",
			name = "The Message Home",
			briefing = "Bring the last cassette back here. There'll be time to listen when neither of us has to keep one ear on the journey. Recover the unsent message cassette from the assigned search area in Waystation. Bring it back to me in Garbage.",
		},
	},
})
