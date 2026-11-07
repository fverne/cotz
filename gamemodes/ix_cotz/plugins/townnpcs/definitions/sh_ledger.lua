PLUGIN:Register("ledger", {
	name = "'Ledger'",
	template = "ledgernpc",
	difficultyMultiplier = 4,
	enforceCatalogue = true,
	map = "rp_waystation",
	buyAll = true,
	buyScale = 0.3,
	courierPools = {
		"valuables_office_records",
		"valuables_transit_cases",
		"valuables_reinforced_cases",
		"valuables_printed_material",
	},
	job = {
		category = "No ordinary repeatable work",
		description = "No ordinary repeatable work",
		kind = "none",
	},
	legacyJob = {
		category = "Dead-drop circuits",
		description = "Dead-drop circuits",
		kind = "deadDrop",
		maps = {
			easy = "rp_waystation",
			hard = "rp_pripyat_remaster",
			medium = "rp_waystation",
		},
	},
	supplies = {},
	rewards = {
		packages = {
			{
				items = {"food_raisins", "drink_bottlewater"},
				label = "Short route",
			},
			{
				items = {"food_can_tushonka", "food_can_beans"},
				label = "Long haul",
			},
			{
				items = {"medic_bandage_1", "lowtiercookerfuel"},
				label = "Emergency stop",
			},
		},
	},
	dialogue = {
		completedGreeting = "Good to see you. Your work has saved me a number of difficult enquiries. What can I help you with today?",
		delivery = "The parcel first. Then I can close the entry.",
		jobBriefing = "There's something I need brought through. {details}",
		jobFinished = "Thank you for bringing it through. Let me settle what you're owed.",
		jobReminder = "I still have someone waiting at this end. {details}",
		offerPrompt = "Do you have a freight circuit?",
		progression = "I need supplies for the dispatch work. Have a look at the request before you load up; it saves both ends a second journey. Bring everything on the list back here; I need the full delivery.",
		progressionPrompt = "What needs doing in the dispatch records?",
		work = "Collect the sealed parcel at the assigned pickup, deliver it to the assigned cache, then return. Both ends matter. Check them before collecting. I'd rather answer a question here than record another delivery nobody can agree has arrived. You can take time to prepare without making the destination uncertain.",
		workPrompt = "About the freight circuit I'm carrying.",
	},
	catalogue = {},
	progression = {
		{
			id = "v3/hideout/01",
			branch = "hideout",
			name = "Hideout improvements 1",
			kind = "delivery",
			requires = {},
			briefing = "I need supplies for the dispatch work. Have a look at the request before you load up; it saves both ends a second journey. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. I will check these into the account before the next request arrives.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 450,
			hideoutLevel = 1,
			services = {
				{
					id = "ledgerHideout1",
					name = "Hideout improvements 1",
				},
			},
		},
		{
			id = "v3/hideout/02",
			branch = "hideout",
			name = "Hideout improvements 2",
			kind = "delivery",
			requires = {"v3/hideout/01"},
			briefing = "I need supplies for the dispatch work. Have a look at the request before you load up; it saves both ends a second journey. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. I will check these into the account before the next request arrives.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 650,
			hideoutLevel = 2,
			services = {
				{
					id = "ledgerHideout2",
					name = "Hideout improvements 2",
				},
			},
		},
		{
			id = "v3/hideout/03",
			branch = "hideout",
			name = "Hideout improvements 3",
			kind = "delivery",
			requires = {"v3/hideout/02"},
			briefing = "I need supplies for the dispatch work. Have a look at the request before you load up; it saves both ends a second journey. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. I will check these into the account before the next request arrives.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 900,
			hideoutLevel = 3,
			services = {
				{
					id = "ledgerHideout3",
					name = "Hideout improvements 3",
				},
			},
		},
		{
			id = "v3/hideout/04",
			branch = "hideout",
			name = "Hideout improvements 4",
			kind = "delivery",
			requires = {"v3/hideout/03"},
			briefing = "I need supplies for the dispatch work. Have a look at the request before you load up; it saves both ends a second journey. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. I will check these into the account before the next request arrives.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 1100,
			hideoutLevel = 4,
			services = {
				{
					id = "ledgerHideout4",
					name = "Hideout improvements 4",
				},
			},
		},
		{
			id = "v3/hideout/05",
			branch = "hideout",
			name = "Hideout improvements 5",
			kind = "delivery",
			requires = {"v3/hideout/04"},
			briefing = "I need supplies for the dispatch work. Have a look at the request before you load up; it saves both ends a second journey. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. I will check these into the account before the next request arrives.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_2",
					quantity = 1,
				},
			},
			completionCash = 1350,
			hideoutLevel = 5,
			services = {
				{
					id = "ledgerHideout5",
					name = "Hideout improvements 5",
				},
			},
		},
		{
			id = "v3/hideout/06",
			branch = "hideout",
			name = "Hideout improvements 6",
			kind = "delivery",
			requires = {"v3/hideout/05"},
			briefing = "I need supplies for the dispatch work. Have a look at the request before you load up; it saves both ends a second journey. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. I will check these into the account before the next request arrives.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_2",
					quantity = 1,
				},
			},
			completionCash = 1600,
			hideoutLevel = 6,
			services = {
				{
					id = "ledgerHideout6",
					name = "Hideout improvements 6",
				},
			},
		},
		{
			id = "v3/hideout/07",
			branch = "hideout",
			name = "Hideout improvements 7",
			kind = "delivery",
			requires = {"v3/hideout/06"},
			briefing = "I need supplies for the dispatch work. Have a look at the request before you load up; it saves both ends a second journey. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. I will check these into the account before the next request arrives.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_2",
					quantity = 1,
				},
			},
			completionCash = 1800,
			hideoutLevel = 7,
			services = {
				{
					id = "ledgerHideout7",
					name = "Hideout improvements 7",
				},
			},
		},
		{
			id = "v3/hideout/08",
			branch = "hideout",
			name = "Hideout improvements 8",
			kind = "delivery",
			requires = {"v3/hideout/07"},
			briefing = "I need supplies for the dispatch work. Have a look at the request before you load up; it saves both ends a second journey. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. I will check these into the account before the next request arrives.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_2",
					quantity = 1,
				},
			},
			completionCash = 2050,
			hideoutLevel = 8,
			services = {
				{
					id = "ledgerHideout8",
					name = "Hideout improvements 8",
				},
			},
		},
		{
			id = "v3/hideout/09",
			branch = "hideout",
			name = "Hideout improvements 9",
			kind = "delivery",
			requires = {"v3/hideout/08"},
			briefing = "I need supplies for the dispatch work. Have a look at the request before you load up; it saves both ends a second journey. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. I will check these into the account before the next request arrives.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_records_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_3",
					quantity = 1,
				},
			},
			completionCash = 2300,
			hideoutLevel = 9,
			services = {
				{
					id = "ledgerHideout9",
					name = "Hideout improvements 9",
				},
			},
		},
		{
			id = "v3/hideout/10",
			branch = "hideout",
			name = "Hideout improvements 10",
			kind = "delivery",
			requires = {"v3/hideout/09"},
			briefing = "I need supplies for the dispatch work. Have a look at the request before you load up; it saves both ends a second journey. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. I will check these into the account before the next request arrives.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_records_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_3",
					quantity = 1,
				},
			},
			completionCash = 2500,
			hideoutLevel = 10,
			services = {
				{
					id = "ledgerHideout10",
					name = "Hideout improvements 10",
				},
			},
		},
		{
			id = "v3/hideout/11",
			branch = "hideout",
			name = "Hideout improvements 11",
			kind = "delivery",
			requires = {"v3/hideout/10"},
			briefing = "I need supplies for the dispatch work. Have a look at the request before you load up; it saves both ends a second journey. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. I will check these into the account before the next request arrives.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_records_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_3",
					quantity = 1,
				},
			},
			completionCash = 2750,
			hideoutLevel = 11,
			services = {
				{
					id = "ledgerHideout11",
					name = "Hideout improvements 11",
				},
			},
		},
		{
			id = "v3/hideout/12",
			branch = "hideout",
			name = "Hideout improvements 12",
			kind = "delivery",
			requires = {"v3/hideout/11"},
			briefing = "I need supplies for the dispatch work. Have a look at the request before you load up; it saves both ends a second journey. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. I will check these into the account before the next request arrives.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_records_waystation_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_records_waystation_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
			hideoutLevel = 12,
			services = {
				{
					id = "ledgerHideout12",
					name = "Hideout improvements 12",
				},
			},
		},
	},
	startingServices = {},
	retiredCommissions = {
		{
			id = "LE02",
			name = "The First Route",
			briefing = "A parcel needs moving between the assigned drops. Check both destinations before you take the load; collection is only half the journey. Collect the first sealed freight parcel at the assigned pickup in Waystation and deliver it to the assigned cache. Come back to me in Waystation.",
		},
		{
			id = "LE04",
			name = "A small delivery",
			briefing = "I need supplies for the dispatch work. Have a look at the request before you load up; it saves both ends a second journey. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "LE06",
			name = "Ballast's Landing Copy",
			briefing = "Ballast needs the landing copy. He can check what was actually handled against the freight record. Recover the landing manifest for Ballast from the assigned search area in Marsh. Deliver it to 'Ballast' in Marsh, then come back to me in Waystation.",
		},
		{
			id = "LE08",
			name = "Restocking",
			briefing = "I need supplies for the dispatch work. Have a look at the request before you load up; it saves both ends a second journey. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "LE10",
			name = "The Duplicate Destination",
			briefing = "Bring the destination record back intact. I'd like to examine the accounts before deciding which instruction was misunderstood. Recover the conflicting destination records from the assigned search area in Waystation. Bring it back to me in Waystation.",
		},
		{
			id = "LE12",
			name = "Building the reserve",
			briefing = "I need supplies for the dispatch work. Have a look at the request before you load up; it saves both ends a second journey. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "LE14",
			name = "The Last Scheduled Drop",
			briefing = "The next parcel goes between the assigned cache points. Check the return instruction as well; I want to know the movement is finished. Collect the scheduled remote-drop parcel at the assigned pickup in Waystation and deliver it to the assigned cache. Come back to me in Waystation.",
		},
		{
			id = "LE16",
			name = "Building the reserve",
			briefing = "I need supplies for the dispatch work. Have a look at the request before you load up; it saves both ends a second journey. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "LE18",
			name = "The Dispatcher's Detour",
			briefing = "I'd like the later dispatcher recording recovered. A changed route deserves more than a guess about why they took it. Recover the dispatcher's detour recording from the assigned search area in Pripyat. Bring it back to me in Waystation.",
		},
		{
			id = "LE20",
			name = "A full supply order",
			briefing = "I need supplies for the dispatch work. Have a look at the request before you load up; it saves both ends a second journey. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "LE22",
			name = "The Last Receipt",
			briefing = "Bring the route's final receipt back here. I'd like to read the closing entry myself instead of collecting versions of it. Recover the final route receipt from the assigned search area in Waystation. Bring it back to me in Waystation.",
		},
	},
})
