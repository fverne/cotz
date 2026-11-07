PLUGIN:Register("wake", {
	name = "'Wake'",
	template = "wakenpc",
	difficultyMultiplier = 1.5,
	enforceCatalogue = true,
	map = "rp_garbage_cotz",
	courierPools = {
		"valuables_personal_effects",
		"valuables_field_records",
		"valuables_transit_cases",
		"valuables_recording_equipment",
	},
	job = {
		category = "Information courier and return",
		description = "Information courier and return",
		kind = "courier",
	},
	legacyJob = {
		category = "Equipment recovery",
		description = "Equipment recovery",
		kind = "recovery",
		maps = {
			easy = "rp_garbage_cotz",
			hard = "rp_pripyat_remaster",
			medium = "rp_waystation",
		},
	},
	supplies = {"medic_bandage_1", "medic_medkit_1"},
	rewards = {
		packages = {
			{
				items = {"medic_bandage_1", "medic_medkit_1"},
				label = "Recovery medicine",
			},
			{
				items = {"medic_antirad_1", "medic_antirad_2"},
				label = "Exposure supplies",
			},
			{
				items = {"food_can_tushonka", "drink_bottlewater"},
				label = "Search provisions",
			},
		},
	},
	dialogue = {
		completedGreeting = "Hello again. Thank you for coming back. If you have something to discuss, we can take our time.",
		delivery = "Put it here. I will keep it with the search records.",
		jobBriefing = "Someone is waiting for these records. {details}",
		jobFinished = "Thank you for seeing it through. We can settle your payment now.",
		jobReminder = "I haven't heard from the recipient yet. {details}",
		offerPrompt = "Do you need something delivered?",
		progression = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
		progressionPrompt = "Where can I help with the search records?",
		work = "There are records I need to send to people outside Garbage. I can give you a sealed parcel and the name of the person waiting for it. Take it to them, then come back here. Please check where they are before agreeing; some of the longer journeys include the Eco Bunker, and you will need permission to buy its access card.",
		workPrompt = "About the parcel I'm taking for you.",
	},
	catalogue = {
		backpack_sling = {
			step = "v3/backpacks/backpack_sling",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		backpack_duffle = {
			step = "v3/backpacks/backpack_duffle",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		backpack_sanitar = {
			step = "v3/backpacks/backpack_sanitar",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		backpack_tbag = {
			step = "v3/backpacks/backpack_tbag",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		backpack_tourist = {
			step = "v3/backpacks/backpack_tourist",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		backpack_takedown_1 = {
			step = "v3/backpacks/backpack_takedown_1",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		backpack_takedown_2 = {
			step = "v3/backpacks/backpack_takedown_2",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		backpack_mbss = {
			step = "v3/backpacks/backpack_mbss",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		backpack_vkbo = {
			step = "v3/backpacks/backpack_vkbo",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		backpack_pilgrim = {
			step = "v3/backpacks/backpack_pilgrim",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		backpack_scavbackpack = {
			step = "v3/backpacks/backpack_scavbackpack",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		backpack_1 = {
			step = "v3/backpacks/backpack_1",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		backpack_3 = {
			step = "v3/backpacks/backpack_3",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		backpack_2 = {
			step = "v3/backpacks/backpack_2",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		backpack_1_large = {
			step = "v3/backpacks/backpack_1_large",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		backpack_3_large = {
			step = "v3/backpacks/backpack_3_large",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		backpack_2_large = {
			step = "v3/backpacks/backpack_2_large",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
	},
	progression = {
		{
			id = "v3/backpacks/backpack_sling",
			branch = "backpacks",
			name = "Sling Backpack",
			kind = "delivery",
			requires = {},
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 450,
		},
		{
			id = "v3/backpacks/backpack_duffle",
			branch = "backpacks",
			name = "Worn Sportsbag",
			kind = "delivery",
			requires = {"v3/backpacks/backpack_sling"},
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 600,
		},
		{
			id = "v3/backpacks/backpack_sanitar",
			branch = "backpacks",
			name = "Old Paramedic Bag",
			kind = "delivery",
			requires = {"v3/backpacks/backpack_duffle"},
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 750,
		},
		{
			id = "v3/backpacks/backpack_tbag",
			branch = "backpacks",
			name = "School Backpack",
			kind = "delivery",
			requires = {"v3/backpacks/backpack_sanitar"},
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 900,
		},
		{
			id = "v3/backpacks/backpack_tourist",
			branch = "backpacks",
			name = "Large School Backpack",
			kind = "delivery",
			requires = {"v3/backpacks/backpack_tbag"},
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 1050,
		},
		{
			id = "v3/backpacks/backpack_takedown_1",
			branch = "backpacks",
			name = "Large Sling Backpack",
			kind = "delivery",
			requires = {"v3/backpacks/backpack_tourist"},
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 1200,
		},
		{
			id = "v3/backpacks/backpack_takedown_2",
			branch = "backpacks",
			name = "Large Sling Backpack (Black)",
			kind = "delivery",
			requires = {"v3/backpacks/backpack_takedown_1"},
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1400,
		},
		{
			id = "v3/backpacks/backpack_mbss",
			branch = "backpacks",
			name = "MBSS Backpack",
			kind = "delivery",
			requires = {"v3/backpacks/backpack_takedown_2"},
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1550,
		},
		{
			id = "v3/backpacks/backpack_vkbo",
			branch = "backpacks",
			name = "Army Backpack",
			kind = "delivery",
			requires = {"v3/backpacks/backpack_mbss"},
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1700,
		},
		{
			id = "v3/backpacks/backpack_pilgrim",
			branch = "backpacks",
			name = "Pilgrim Backpack",
			kind = "delivery",
			requires = {"v3/backpacks/backpack_vkbo"},
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1850,
		},
		{
			id = "v3/backpacks/backpack_scavbackpack",
			branch = "backpacks",
			name = "MBSS Backpack (Upgraded)",
			kind = "delivery",
			requires = {"v3/backpacks/backpack_pilgrim"},
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 2000,
		},
		{
			id = "v3/backpacks/backpack_1",
			branch = "backpacks",
			name = "Modern Military Backpack (Ukrainian)",
			kind = "delivery",
			requires = {"v3/backpacks/backpack_scavbackpack"},
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2200,
		},
		{
			id = "v3/backpacks/backpack_3",
			branch = "backpacks",
			name = "Modern Military Backpack (Russian)",
			kind = "delivery",
			requires = {"v3/backpacks/backpack_1"},
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2350,
		},
		{
			id = "v3/backpacks/backpack_2",
			branch = "backpacks",
			name = "Modern Military Backpack (USA)",
			kind = "delivery",
			requires = {"v3/backpacks/backpack_3"},
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2500,
		},
		{
			id = "v3/backpacks/backpack_1_large",
			branch = "backpacks",
			name = "Large Modern Military Backpack (Ukrainian)",
			kind = "delivery",
			requires = {"v3/backpacks/backpack_2"},
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2650,
		},
		{
			id = "v3/backpacks/backpack_3_large",
			branch = "backpacks",
			name = "Large Modern Military Backpack (Russian)",
			kind = "delivery",
			requires = {"v3/backpacks/backpack_1_large"},
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2800,
		},
		{
			id = "v3/backpacks/backpack_2_large",
			branch = "backpacks",
			name = "Large Modern Military Backpack (USA)",
			kind = "delivery",
			requires = {"v3/backpacks/backpack_3_large"},
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_medical_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
		},
		{
			id = "v3/carry-weight/01",
			branch = "carry-weight",
			name = "Carried weight +1 kg",
			kind = "delivery",
			requires = {},
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 450,
			capacity = {
				kind = "weight",
				amount = 1,
			},
		},
		{
			id = "v3/carry-weight/02",
			branch = "carry-weight",
			name = "Carried weight +1 kg",
			kind = "delivery",
			requires = {"v3/carry-weight/01"},
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 1050,
			capacity = {
				kind = "weight",
				amount = 1,
			},
		},
		{
			id = "v3/carry-weight/03",
			branch = "carry-weight",
			name = "Carried weight +1 kg",
			kind = "delivery",
			requires = {"v3/carry-weight/02"},
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1700,
			capacity = {
				kind = "weight",
				amount = 1,
			},
		},
		{
			id = "v3/carry-weight/04",
			branch = "carry-weight",
			name = "Carried weight +1 kg",
			kind = "delivery",
			requires = {"v3/carry-weight/03"},
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2350,
			capacity = {
				kind = "weight",
				amount = 1,
			},
		},
		{
			id = "v3/carry-weight/05",
			branch = "carry-weight",
			name = "Carried weight +1 kg",
			kind = "delivery",
			requires = {"v3/carry-weight/04"},
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_medical_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
			capacity = {
				kind = "weight",
				amount = 1,
			},
		},
		{
			id = "v3/inventory-rows/01",
			branch = "inventory-rows",
			name = "Inventory +1 row",
			kind = "delivery",
			requires = {},
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 450,
			capacity = {
				kind = "rows",
				amount = 1,
			},
		},
		{
			id = "v3/inventory-rows/02",
			branch = "inventory-rows",
			name = "Inventory +1 row",
			kind = "delivery",
			requires = {"v3/inventory-rows/01"},
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_medical_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
			capacity = {
				kind = "rows",
				amount = 1,
			},
		},
	},
	startingServices = {},
	retiredCommissions = {
		{
			id = "WA02",
			name = "The Unmarked Camp",
			briefing = "I'd like the scavenger's surviving records brought back together. Finding belongings gives us something to examine, not permission to settle the person's fate. Recover the missing scavenger's records from the assigned search area in Garbage. Bring it back to me in Garbage.",
		},
		{
			id = "WA04",
			name = "Restocking",
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "WA06",
			name = "The Convoy List",
			briefing = "Brass needs the convoy roster. He can compare the freight account with the people recorded as travelling. Recover the convoy roster for Brass from the assigned search area in Garbage. Deliver it to 'Brass' in Garbage, then come back to me in Garbage.",
		},
		{
			id = "WA08",
			name = "Restocking",
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "WA10",
			name = "Atlas' Missing Mark",
			briefing = "Atlas should have the survey note. A place described poorly can make the whole route look more certain than it is. Recover the survey note for Atlas from the assigned search area in Garbage. Deliver it to 'Atlas' in Marsh, then come back to me in Garbage.",
		},
		{
			id = "WA12",
			name = "Building the reserve",
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "WA14",
			name = "The Withheld Copy",
			briefing = "Carbon needs the evidence supporting that report. I want the missing information examined without choosing a conclusion for him. Recover the restricted report's supporting file from the assigned search area in Garbage. Deliver it to 'Carbon' in Waystation, then come back to me in Garbage.",
		},
		{
			id = "WA16",
			name = "Building the reserve",
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "WA18",
			name = "The Last Transmission",
			briefing = "I'd like the later recording brought home. A voice deserves a quieter hearing than a hurried listen on the route. Recover the expedition's last transmission from the assigned search area in Pripyat. Bring it back to me in Garbage.",
		},
		{
			id = "WA20",
			name = "A full supply order",
			briefing = "I need supplies and recovered belongings brought here for sorting. Check the request, and keep personal effects together while you carry them. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "WA22",
			name = "The Final Name",
			briefing = "The final identification record needs to come back complete. I don't want a familiar name on one page deciding how we read the rest. Recover the final identification file from the assigned search area in Garbage. Bring it back to me in Garbage.",
		},
	},
})
