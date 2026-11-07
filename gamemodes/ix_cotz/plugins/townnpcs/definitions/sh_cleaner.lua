PLUGIN:Register("cleaner", {
	name = "'Cleaner'",
	template = "owlnpc",
	difficultyMultiplier = 3,
	enforceCatalogue = true,
	map = "rp_garbage_cotz",
	buyAll = true,
	buyScale = 0.3,
	courierPools = {
		"valuables_cleaning_supplies",
		"valuables_cutting_tools",
		"valuables_secured_cases",
		"valuables_flash_media",
	},
	job = {
		category = "Dead-drop circuits",
		description = "Dead-drop circuits",
		kind = "deadDrop",
		maps = {
			easy = "rp_garbage_cotz",
			hard = "rp_waystation",
			medium = "rp_garbage_cotz",
		},
	},
	legacyJob = {
		category = "Dead-drop circuits",
		description = "Dead-drop circuits",
		kind = "deadDrop",
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
				items = {"hidestash_1"},
				label = "Swamps stash",
			},
			{
				items = {"hidestash_2"},
				label = "Waystation stash",
			},
			{
				items = {"hidestash_3"},
				label = "Pripyat stash",
			},
		},
		packages = {
			{
				items = {"hidestasher_cutlery"},
				label = "Digging tools",
			},
			{
				items = {"hidestasher_cleaningkit"},
				label = "Cache tools",
			},
			{
				items = {"food_can_beans"},
				label = "Canned provisions",
			},
		},
	},
	dialogue = {
		completedGreeting = "You're here. Good. We can spare ourselves the usual discussion about whether instructions need following.",
		delivery = "Leave it here. Keep it closed.",
		jobBriefing = "Apparently everyone remembers who carries things except the person who actually has to carry them. {details}",
		jobFinished = "Buried where it belongs? Good. One less thing left for me to chase up.",
		jobReminder = "I still need that parcel moved. {details}",
		offerPrompt = "Do you have a parcel circuit?",
		progression = "I need supplies for the next arrangements. The list is specific. Bring them here. Bring everything on the list back here; I need the full delivery.",
		progressionPrompt = "What else needs checking in the deliveries?",
		work = "Collect the sealed parcel at the assigned pickup. Deliver it to the assigned cache. Come back after finishing the delivery. Read both endpoints before accepting, and leave the package shut. If you want to know whether that is all the arrangement requires, yes. That's why I wrote it down.",
		workPrompt = "About the circuit I'm carrying.",
	},
	catalogue = {},
	progression = {
		{
			id = "v3/hideout/01",
			branch = "hideout",
			name = "Hideout improvements 1",
			kind = "delivery",
			requires = {},
			briefing = "I need supplies for the next arrangements. The list is specific. Bring them here. Bring everything on the list back here; I need the full delivery.",
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 1,
				},
			},
			completionCash = 450,
			hideoutLevel = 1,
			services = {
				{
					id = "cleanerHideout1",
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
			briefing = "I need supplies for the next arrangements. The list is specific. Bring them here. Bring everything on the list back here; I need the full delivery.",
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 1,
				},
			},
			completionCash = 650,
			hideoutLevel = 2,
			services = {
				{
					id = "cleanerHideout2",
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
			briefing = "I need supplies for the next arrangements. The list is specific. Bring them here. Bring everything on the list back here; I need the full delivery.",
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 1,
				},
			},
			completionCash = 900,
			hideoutLevel = 3,
			services = {
				{
					id = "cleanerHideout3",
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
			briefing = "I need supplies for the next arrangements. The list is specific. Bring them here. Bring everything on the list back here; I need the full delivery.",
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 1,
				},
			},
			completionCash = 1100,
			hideoutLevel = 4,
			services = {
				{
					id = "cleanerHideout4",
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
			briefing = "I need supplies for the next arrangements. The list is specific. Bring them here. Bring everything on the list back here; I need the full delivery.",
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 1,
				},
			},
			completionCash = 1350,
			hideoutLevel = 5,
			services = {
				{
					id = "cleanerHideout5",
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
			briefing = "I need supplies for the next arrangements. The list is specific. Bring them here. Bring everything on the list back here; I need the full delivery.",
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 1,
				},
			},
			completionCash = 1600,
			hideoutLevel = 6,
			services = {
				{
					id = "cleanerHideout6",
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
			briefing = "I need supplies for the next arrangements. The list is specific. Bring them here. Bring everything on the list back here; I need the full delivery.",
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 1,
				},
			},
			completionCash = 1800,
			hideoutLevel = 7,
			services = {
				{
					id = "cleanerHideout7",
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
			briefing = "I need supplies for the next arrangements. The list is specific. Bring them here. Bring everything on the list back here; I need the full delivery.",
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 1,
				},
			},
			completionCash = 2050,
			hideoutLevel = 8,
			services = {
				{
					id = "cleanerHideout8",
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
			briefing = "I need supplies for the next arrangements. The list is specific. Bring them here. Bring everything on the list back here; I need the full delivery.",
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_3",
					quantity = 1,
				},
			},
			completionCash = 2300,
			hideoutLevel = 9,
			services = {
				{
					id = "cleanerHideout9",
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
			briefing = "I need supplies for the next arrangements. The list is specific. Bring them here. Bring everything on the list back here; I need the full delivery.",
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_3",
					quantity = 1,
				},
			},
			completionCash = 2500,
			hideoutLevel = 10,
			services = {
				{
					id = "cleanerHideout10",
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
			briefing = "I need supplies for the next arrangements. The list is specific. Bring them here. Bring everything on the list back here; I need the full delivery.",
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_3",
					quantity = 1,
				},
			},
			completionCash = 2750,
			hideoutLevel = 11,
			services = {
				{
					id = "cleanerHideout11",
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
			briefing = "I need supplies for the next arrangements. The list is specific. Bring them here. Bring everything on the list back here; I need the full delivery.",
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_trail_garbage_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_garbage_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_garbage_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
			hideoutLevel = 12,
			services = {
				{
					id = "cleanerHideout12",
					name = "Hideout improvements 12",
				},
			},
		},
	},
	startingServices = {},
	retiredCommissions = {
		{
			id = "CL02",
			name = "The Unattended Drop",
			briefing = "A sealed parcel needs moving between the assigned drops. Read both ends before you take possession. Recover the first sealed drop parcel from the assigned search area in Garbage. Bring it back to me in Garbage.",
		},
		{
			id = "CL04",
			name = "A small delivery",
			briefing = "I need supplies for the next arrangements. The list is specific. Bring them here. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "CL06",
			name = "An Empty Hiding Place",
			briefing = "There's evidence to recover from a compromised cache. Bring the case unchanged. I don't need your inspection marks mixed with theirs. Recover the compromised cache evidence from the assigned search area in Garbage. Bring it back to me in Garbage.",
		},
		{
			id = "CL08",
			name = "Restocking",
			briefing = "I need supplies for the next arrangements. The list is specific. Bring them here. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "CL10",
			name = "The Buried Register",
			briefing = "I need the distribution register recovered. Too many people are relying on entries they haven't looked at recently. Recover the distribution register from the assigned search area in Garbage. Bring it back to me in Garbage.",
		},
		{
			id = "CL12",
			name = "Restocking",
			briefing = "I need supplies for the next arrangements. The list is specific. Bring them here. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "CL14",
			name = "Ledger's Missing Copy",
			briefing = "Ledger needs his missing freight copy. Deliver the original, then come back. He doesn't need a courier's summary. Recover the freight copy for Ledger from the assigned search area in Garbage. Deliver it to 'Ledger' in Waystation, then come back to me in Garbage.",
		},
		{
			id = "CL16",
			name = "Building the reserve",
			briefing = "I need supplies for the next arrangements. The list is specific. Bring them here. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "CL18",
			name = "The Other Register",
			briefing = "The backup register goes to Ledger. If the accounts disagree, he should have something more useful than my opinion. Recover the distribution backup for Ledger from the assigned search area in Waystation. Deliver it to 'Ledger' in Waystation, then come back to me in Garbage.",
		},
		{
			id = "CL20",
			name = "Building the reserve",
			briefing = "I need supplies for the next arrangements. The list is specific. Bring them here. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "CL22",
			name = "A Cache With Two Owners",
			briefing = "I need the ownership record. Two people saying mine doesn't make two separate caches. Recover the cache ownership file from the assigned search area in Pripyat. Bring it back to me in Garbage.",
		},
		{
			id = "CL24",
			name = "A full supply order",
			briefing = "I need supplies for the next arrangements. The list is specific. Bring them here. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "CL26",
			name = "The Cache That Stayed Closed",
			briefing = "One more sealed circuit delivery. Finish the drop before coming back for the account to be closed. Collect the final sealed circuit parcel at the assigned pickup in Garbage and deliver it to the assigned cache. Come back to me in Garbage.",
		},
		{
			id = "CL28",
			name = "A full supply order",
			briefing = "I need supplies for the next arrangements. The list is specific. Bring them here. Bring everything on the list back here; I need the full delivery.",
		},
	},
})
