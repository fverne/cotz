PLUGIN:Register("technut", {
	name = "'Technut'",
	template = "technpc",
	difficultyMultiplier = 3,
	enforceCatalogue = true,
	map = "rp_marsh_cs",
	courierPools = {
		"valuables_repair_parts",
		"valuables_workshop_tools",
		"valuables_electronic_components",
		"valuables_control_electronics",
	},
	job = {
		category = "Valuable delivery and courier work",
		description = "Valuable delivery and courier work",
		kind = "valuableCourier",
	},
	legacyJob = {
		category = "Industrial salvage deliveries",
		deliveryTiers = {
			easy = {
				pools = {"valuables_workshop_consumables", "valuables_drivers_wrenches"},
				quantity = 1,
			},
			hard = {
				pools = {"valuables_instruments", "valuables_control_electronics"},
				quantity = 2,
			},
			medium = {
				pools = {"valuables_workshop_tools", "valuables_cutting_tools", "valuables_repair_parts"},
				quantity = 1,
			},
		},
		description = "Industrial salvage deliveries",
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		pools = {"fasteners", "basic_tools", "workshop_supplies"},
		quantities = {2, 4, 7},
	},
	supplies = {"suit_anorak", "mask_cloth"},
	rewards = {
		bonusCash = true,
		bonusPackages = {
			{
				items = {"sharpening_stone_fine"},
				label = "Fine edge upkeep",
			},
		},
		packages = {
			{
				items = {"sharpening_stone"},
				label = "Edge upkeep",
			},
			{
				items = {"hidestasher_cleaningkit"},
				label = "Digging tools",
			},
			{
				items = {"food_can_beans"},
				label = "Canned provisions",
			},
		},
	},
	dialogue = {
		completedGreeting = "Buddy! Come and have a look, if you've got a minute. No, you don't have to fetch anything first.",
		delivery = "Over here, buddy. Let me see what we have got.",
		jobBriefing = "Ah, yes, I can put you to work! {details}",
		jobFinished = "That got there? Excellent! Let me sort out what I owe you before I forget myself.",
		jobReminder = "I was about to ask how that was going. {details}",
		offerPrompt = "Do you have a delivery order?",
		progression = "I need supplies for the workshop. I wrote down what I actually need, before the interesting possibilities got in the way. Bring everything on the list back here; I need the full delivery.",
		progressionPrompt = "What are you trying to restore?",
		work = "I have delivery orders, buddy. Read the item and quantity, then take the goods to someone here who requests that sort of thing. It might be my bench, it might be somebody else's. Come back to me for payment after the handover. Existing stock counts; I would be delighted if you remembered the right pieces before setting off again.",
		workPrompt = "About the delivery I have taken.",
	},
	catalogue = {
		suit_mailjacket = {
			step = "v3/suits/suit_mailjacket",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		suit_trenchcoat_black = {
			step = "v3/suits/suit_trenchcoat_black",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		suit_trenchcoat_brown = {
			step = "v3/suits/suit_trenchcoat_black",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		suit_trenchcoat_green = {
			step = "v3/suits/suit_trenchcoat_black",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		suit_trenchcoat_tan = {
			step = "v3/suits/suit_trenchcoat_black",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		suit_sunrise = {
			step = "v3/suits/suit_sunrise",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		suit_io7a = {
			step = "v3/suits/suit_io7a",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		suit_cs1 = {
			step = "v3/suits/suit_cs1",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		suit_wind = {
			step = "v3/suits/suit_wind",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		suit_ps5m = {
			step = "v3/suits/suit_ps5m",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		suit_cs2 = {
			step = "v3/suits/suit_cs2",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		suit_nbc = {
			step = "v3/suits/suit_nbc",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		suit_berill = {
			step = "v3/suits/suit_berill",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		suit_cs3 = {
			step = "v3/suits/suit_cs3",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		suit_skat10 = {
			step = "v3/suits/suit_skat10",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		suit_skat9 = {
			step = "v3/suits/suit_skat9",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
	},
	progression = {
		{
			id = "v3/suits/suit_anorak",
			branch = "suits",
			name = "Anorak",
			kind = "delivery",
			requires = {},
			briefing = "I need supplies for the workshop. I wrote down what I actually need, before the interesting possibilities got in the way. Bring everything on the list back here; I need the full delivery.",
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 450,
			stock = {
				item = "suit_anorak",
				bonus = 1,
			},
		},
		{
			id = "v3/suits/suit_mailjacket",
			branch = "suits",
			name = "Mail Jacket",
			kind = "delivery",
			requires = {"v3/suits/suit_anorak"},
			briefing = "I need supplies for the workshop. I wrote down what I actually need, before the interesting possibilities got in the way. Bring everything on the list back here; I need the full delivery.",
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 600,
		},
		{
			id = "v3/suits/suit_trenchcoat_black",
			branch = "suits",
			name = "Black Trenchcoat",
			kind = "delivery",
			requires = {"v3/suits/suit_mailjacket"},
			briefing = "I need supplies for the workshop. I wrote down what I actually need, before the interesting possibilities got in the way. Bring everything on the list back here; I need the full delivery.",
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 800,
		},
		{
			id = "v3/suits/suit_sunrise",
			branch = "suits",
			name = "Sunrise STALKER Suit",
			kind = "delivery",
			requires = {"v3/suits/suit_trenchcoat_black"},
			briefing = "I need supplies for the workshop. I wrote down what I actually need, before the interesting possibilities got in the way. Bring everything on the list back here; I need the full delivery.",
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 1000,
		},
		{
			id = "v3/suits/suit_io7a",
			branch = "suits",
			name = "IO7a Suit",
			kind = "delivery",
			requires = {"v3/suits/suit_sunrise"},
			briefing = "I need supplies for the workshop. I wrote down what I actually need, before the interesting possibilities got in the way. Bring everything on the list back here; I need the full delivery.",
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 1200,
		},
		{
			id = "v3/suits/suit_cs1",
			branch = "suits",
			name = "Sky-1 Suit",
			kind = "delivery",
			requires = {"v3/suits/suit_io7a"},
			briefing = "I need supplies for the workshop. I wrote down what I actually need, before the interesting possibilities got in the way. Bring everything on the list back here; I need the full delivery.",
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1400,
		},
		{
			id = "v3/suits/suit_wind",
			branch = "suits",
			name = "Pathfinder Suit",
			kind = "delivery",
			requires = {"v3/suits/suit_cs1"},
			briefing = "I need supplies for the workshop. I wrote down what I actually need, before the interesting possibilities got in the way. Bring everything on the list back here; I need the full delivery.",
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1600,
		},
		{
			id = "v3/suits/suit_ps5m",
			branch = "suits",
			name = "Universal Protection Suit",
			kind = "delivery",
			requires = {"v3/suits/suit_wind"},
			briefing = "I need supplies for the workshop. I wrote down what I actually need, before the interesting possibilities got in the way. Bring everything on the list back here; I need the full delivery.",
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1800,
		},
		{
			id = "v3/suits/suit_cs2",
			branch = "suits",
			name = "Sky-2 Suit",
			kind = "delivery",
			requires = {"v3/suits/suit_ps5m"},
			briefing = "I need supplies for the workshop. I wrote down what I actually need, before the interesting possibilities got in the way. Bring everything on the list back here; I need the full delivery.",
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 2000,
		},
		{
			id = "v3/suits/suit_nbc",
			branch = "suits",
			name = "NBC Suit",
			kind = "delivery",
			requires = {"v3/suits/suit_cs2"},
			briefing = "I need supplies for the workshop. I wrote down what I actually need, before the interesting possibilities got in the way. Bring everything on the list back here; I need the full delivery.",
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_workshop_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2200,
		},
		{
			id = "v3/suits/suit_berill",
			branch = "suits",
			name = "Berill-5M",
			kind = "delivery",
			requires = {"v3/suits/suit_nbc"},
			briefing = "I need supplies for the workshop. I wrote down what I actually need, before the interesting possibilities got in the way. Bring everything on the list back here; I need the full delivery.",
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_workshop_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2400,
		},
		{
			id = "v3/suits/suit_cs3",
			branch = "suits",
			name = "Sky-3 Suit",
			kind = "delivery",
			requires = {"v3/suits/suit_berill"},
			briefing = "I need supplies for the workshop. I wrote down what I actually need, before the interesting possibilities got in the way. Bring everything on the list back here; I need the full delivery.",
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_workshop_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2600,
		},
		{
			id = "v3/suits/suit_skat10",
			branch = "suits",
			name = "Skat-10 Armored Suit",
			kind = "delivery",
			requires = {"v3/suits/suit_cs3"},
			briefing = "I need supplies for the workshop. I wrote down what I actually need, before the interesting possibilities got in the way. Bring everything on the list back here; I need the full delivery.",
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_workshop_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2800,
		},
		{
			id = "v3/suits/suit_skat9",
			branch = "suits",
			name = "Skat-9 Armored Suit",
			kind = "delivery",
			requires = {"v3/suits/suit_skat10"},
			briefing = "I need supplies for the workshop. I wrote down what I actually need, before the interesting possibilities got in the way. Bring everything on the list back here; I need the full delivery.",
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_workshop_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_workshop_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_workshop_marsh_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
		},
		{
			id = "v3/painting/painting",
			branch = "painting",
			name = "Suit painting",
			kind = "delivery",
			requires = {},
			briefing = "I need supplies for the workshop. I wrote down what I actually need, before the interesting possibilities got in the way. Bring everything on the list back here; I need the full delivery.",
			completion = "Lovely. Let me sort these before I get distracted by what I could build with them.",
			requirements = {
				{
					pool = "town_delivery_workshop_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 450,
			services = {
				{
					id = "painting",
					name = "Suit painting",
				},
			},
		},
	},
	startingServices = {},
	retiredCommissions = {
		{
			id = "TN02",
			name = "The Missing Toolbox",
			briefing = "There's a workshop case to recover. I'm trying not to decide what I'll do with the tools before I've seen them, but it's difficult. Recover the workshop toolbox from the assigned search area in Marsh. Bring it back to me in Marsh.",
		},
		{
			id = "TN04",
			name = "A small delivery",
			briefing = "I need supplies for the workshop. I wrote down what I actually need, before the interesting possibilities got in the way. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "TN06",
			name = "The Misaligned Jig",
			briefing = "I'd like the calibration record. A little misalignment becomes an expensive amount of enthusiasm once you build around it. Recover the workshop calibration notes from the assigned search area in Marsh. Bring it back to me in Marsh.",
		},
		{
			id = "TN08",
			name = "Restocking",
			briefing = "I need supplies for the workshop. I wrote down what I actually need, before the interesting possibilities got in the way. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "TN10",
			name = "Latch's Find",
			briefing = "Latch should have the identification record. He'll compare it with what he actually found, which saves us building a theory around the wrong machine. Recover the machine identity record for Latch from the assigned search area in Marsh. Deliver it to 'Latch' in Garbage, then come back to me in Marsh.",
		},
		{
			id = "TN12",
			name = "Restocking",
			briefing = "I need supplies for the workshop. I wrote down what I actually need, before the interesting possibilities got in the way. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "TN14",
			name = "Patterns in Metal",
			briefing = "I'd like the assembly drawing. There may be a perfectly good reason for the bit I've spent the morning complaining about. Recover the assembly specification file from the assigned search area in Marsh. Bring it back to me in Marsh.",
		},
		{
			id = "TN16",
			name = "Building the reserve",
			briefing = "I need supplies for the workshop. I wrote down what I actually need, before the interesting possibilities got in the way. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "TN18",
			name = "The Test Assembly",
			briefing = "The test assembly case is still out in Waystation territory. I'm interested in how it was put together, so leave everything inside as it is. Recover the test assembly from the assigned search area in Waystation. Bring it back to me in Marsh.",
		},
		{
			id = "TN20",
			name = "Building the reserve",
			briefing = "I need supplies for the workshop. I wrote down what I actually need, before the interesting possibilities got in the way. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "TN22",
			name = "The Machine's Origin",
			briefing = "I'd like the manufacturing papers from Pripyat. They may answer something more useful than which factory name to argue about. Recover the manufacturing specification record from the assigned search area in Pripyat. Bring it back to me in Marsh.",
		},
		{
			id = "TN24",
			name = "A full supply order",
			briefing = "I need supplies for the workshop. I wrote down what I actually need, before the interesting possibilities got in the way. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "TN26",
			name = "A Test Under Load",
			briefing = "We need a test recording from the machinery survey. I promise to examine the inconvenient readings too. Deploy the recorder at the assigned site in Marsh, let it finish recording, then retrieve the machinery test recorder. Bring it back to me in Marsh.",
		},
		{
			id = "TN28",
			name = "A full supply order",
			briefing = "I need supplies for the workshop. I wrote down what I actually need, before the interesting possibilities got in the way. Bring everything on the list back here; I need the full delivery.",
		},
	},
})
