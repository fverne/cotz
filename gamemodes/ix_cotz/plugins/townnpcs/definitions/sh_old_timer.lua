PLUGIN:Register("old-timer", {
	name = "'Old Timer'",
	template = "tutorialnpc",
	difficultyMultiplier = 3,
	enforceCatalogue = true,
	map = "rp_marsh_cs",
	courierPools = {
		"valuables_workshop_tools",
		"valuables_cutting_tools",
		"valuables_protective_textiles",
		"valuables_field_records",
	},
	job = {
		category = "Specific mutant hunting",
		description = "Specific mutant hunting",
		kind = "regionalHunting",
		maps = {
			easy = "rp_marsh_cs",
			hard = "rp_waystation",
			medium = "rp_garbage_cotz",
		},
	},
	legacyJob = {
		category = "Mutant hunting",
		description = "Mutant hunting",
		kind = "hunting",
		quantities = {5, 9, 15},
	},
	supplies = {"leadpipe", "lowtiercooker", "lowtiercookerfuel"},
	rewards = {
		bonusPackages = {
			{
				items = {"sharpening_stone_fine"},
				label = "Fine edge upkeep",
			},
			{
				items = {"hidestash_1"},
				label = "Swamps stash",
			},
		},
		packages = {
			{
				items = {"45acp41"},
				label = "Small-game shells",
			},
			{
				items = {"sharpening_stone"},
				label = "Edge upkeep",
			},
			{
				items = {"food_can_tushonka"},
				label = "Canned provisions",
			},
		},
	},
	dialogue = {
		completedGreeting = "Good to see you. Put the pack down if you're staying a while; you don't have to stand ready to leave every minute.",
		jobBriefing = "There's work you can do if you're heading out. {details}",
		jobFinished = "You made it back and did what we agreed. Let's see to your payment.",
		jobReminder = "Still on your way out there? {details}",
		offerPrompt = "Do you have a mutant hunting job?",
		progression = "There are supplies I would like brought in. Read the list before setting off, and leave enough room for what you need yourself. Bring everything on the list back here; I need the full delivery.",
		progressionPrompt = "What needs doing next?",
		work = "Mutant hunting. Read the quarry on the order and prepare for the return as carefully as the hunt. Don't chase a wounded animal so far you forget where you've left yourself room to go. I'll have more work if you come back. I won't complain if you take time to make that likely.",
		workPrompt = "About the hunt I'm on.",
	},
	catalogue = {
		knife2 = {
			step = "v3/knives/knife2",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		knife3 = {
			step = "v3/knives/knife3",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		knife4 = {
			step = "v3/knives/knife4",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		crowbar = {
			step = "v3/melee/crowbar",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		bat = {
			step = "v3/melee/crowbar",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		hatchet = {
			step = "v3/melee/hatchet",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		machete = {
			step = "v3/melee/hatchet",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		sledgehammer = {
			step = "v3/melee/sledgehammer",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		fireaxe = {
			step = "v3/melee/sledgehammer",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		fubar = {
			step = "v3/melee/sledgehammer",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		hightiercooker = {
			step = "v3/cooking/hightiercooker",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		hidestasher_cleaningkit = {
			step = "v3/hidestashers/hidestasher_cleaningkit",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		hidestasher_shovel = {
			step = "v3/hidestashers/hidestasher_shovel",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
	},
	progression = {
		{
			id = "v3/knives/knife2",
			branch = "knives",
			name = "Kitchen Knife",
			kind = "delivery",
			requires = {},
			briefing = "There are supplies I would like brought in. Read the list before setting off, and leave enough room for what you need yourself. Bring everything on the list back here; I need the full delivery.",
			completion = "That will do. Put it there, then check what you have left for your own walk.",
			requirements = {
				{
					pool = "town_delivery_trail_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 450,
		},
		{
			id = "v3/knives/knife3",
			branch = "knives",
			name = "Survival Knife",
			kind = "delivery",
			requires = {"v3/knives/knife2"},
			briefing = "There are supplies I would like brought in. Read the list before setting off, and leave enough room for what you need yourself. Bring everything on the list back here; I need the full delivery.",
			completion = "That will do. Put it there, then check what you have left for your own walk.",
			requirements = {
				{
					pool = "town_delivery_trail_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1700,
		},
		{
			id = "v3/knives/knife4",
			branch = "knives",
			name = "Battered Bayonet",
			kind = "delivery",
			requires = {"v3/knives/knife3"},
			briefing = "There are supplies I would like brought in. Read the list before setting off, and leave enough room for what you need yourself. Bring everything on the list back here; I need the full delivery.",
			completion = "That will do. Put it there, then check what you have left for your own walk.",
			requirements = {
				{
					pool = "town_delivery_trail_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_trail_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_marsh_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
		},
		{
			id = "v3/melee/crowbar",
			branch = "melee",
			name = "Crowbar / Bat",
			kind = "delivery",
			requires = {},
			briefing = "There are supplies I would like brought in. Read the list before setting off, and leave enough room for what you need yourself. Bring everything on the list back here; I need the full delivery.",
			completion = "That will do. Put it there, then check what you have left for your own walk.",
			requirements = {
				{
					pool = "town_delivery_trail_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 450,
		},
		{
			id = "v3/melee/hatchet",
			branch = "melee",
			name = "Hatchet / Machete",
			kind = "delivery",
			requires = {"v3/melee/crowbar"},
			briefing = "There are supplies I would like brought in. Read the list before setting off, and leave enough room for what you need yourself. Bring everything on the list back here; I need the full delivery.",
			completion = "That will do. Put it there, then check what you have left for your own walk.",
			requirements = {
				{
					pool = "town_delivery_trail_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1700,
		},
		{
			id = "v3/melee/sledgehammer",
			branch = "melee",
			name = "Sledgehammer / Fireaxe / FUBar",
			kind = "delivery",
			requires = {"v3/melee/hatchet"},
			briefing = "There are supplies I would like brought in. Read the list before setting off, and leave enough room for what you need yourself. Bring everything on the list back here; I need the full delivery.",
			completion = "That will do. Put it there, then check what you have left for your own walk.",
			requirements = {
				{
					pool = "town_delivery_trail_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_trail_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_marsh_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
		},
		{
			id = "v3/cooking/hightiercooker",
			branch = "cooking",
			name = "Multi-Fuel Cooker",
			kind = "delivery",
			requires = {},
			briefing = "There are supplies I would like brought in. Read the list before setting off, and leave enough room for what you need yourself. Bring everything on the list back here; I need the full delivery.",
			completion = "That will do. Put it there, then check what you have left for your own walk.",
			requirements = {
				{
					pool = "town_delivery_trail_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 450,
		},
		{
			id = "v3/hidestashers/hidestasher_cleaningkit",
			branch = "hidestashers",
			name = "Cleaning kit",
			kind = "delivery",
			requires = {},
			briefing = "There are supplies I would like brought in. Read the list before setting off, and leave enough room for what you need yourself. Bring everything on the list back here; I need the full delivery.",
			completion = "That will do. Put it there, then check what you have left for your own walk.",
			requirements = {
				{
					pool = "town_delivery_trail_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 450,
		},
		{
			id = "v3/hidestashers/hidestasher_shovel",
			branch = "hidestashers",
			name = "Shovel",
			kind = "delivery",
			requires = {"v3/hidestashers/hidestasher_cleaningkit"},
			briefing = "There are supplies I would like brought in. Read the list before setting off, and leave enough room for what you need yourself. Bring everything on the list back here; I need the full delivery.",
			completion = "That will do. Put it there, then check what you have left for your own walk.",
			requirements = {
				{
					pool = "town_delivery_trail_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_trail_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_trail_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_trail_marsh_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
		},
	},
	startingServices = {},
	retiredCommissions = {
		{
			id = "OT02",
			name = "Know Your Ground",
			briefing = "There's a field notebook out in Marsh. I'd like you to pay attention to the walk as well as bringing the book back. Recover the Marsh field notebook from the assigned search area in Marsh. Bring it back to me in Marsh.",
		},
		{
			id = "OT04",
			name = "A small delivery",
			briefing = "There are supplies I would like brought in. Read the list before setting off, and leave enough room for what you need yourself. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "OT06",
			name = "Ready Enough",
			briefing = "A supply case is still outside camp. Leave room to bring it home without throwing away what you need for yourself. Recover the expedition supply case from the assigned search area in Marsh. Bring it back to me in Marsh.",
		},
		{
			id = "OT08",
			name = "Restocking",
			briefing = "There are supplies I would like brought in. Read the list before setting off, and leave enough room for what you need yourself. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "OT10",
			name = "Enough for the Walk Home",
			briefing = "I want the lost supply case recovered. The return journey still needs food and water even when the search went well. Recover the return-route provisions from the assigned search area in Marsh. Bring it back to me in Marsh.",
		},
		{
			id = "OT12",
			name = "Restocking",
			briefing = "There are supplies I would like brought in. Read the list before setting off, and leave enough room for what you need yourself. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "OT14",
			name = "Thin the Pack",
			briefing = "There's an observer's account to recover from the hunting site. I'd like to compare what was seen with what people remember hearing. Recover the pack observer's notes from the assigned search area in Marsh. Bring it back to me in Marsh.",
		},
		{
			id = "OT16",
			name = "Building the reserve",
			briefing = "There are supplies I would like brought in. Read the list before setting off, and leave enough room for what you need yourself. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "OT18",
			name = "Leave a Way Out",
			briefing = "Recover the route observations. A party's intended path isn't always the one they managed to walk. Recover the missing party's route notes from the assigned search area in Marsh. Bring it back to me in Marsh.",
		},
		{
			id = "OT20",
			name = "Building the reserve",
			briefing = "There are supplies I would like brought in. Read the list before setting off, and leave enough room for what you need yourself. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "OT22",
			name = "A Voice on Tape",
			briefing = "Spool should hear the recording. He listens more carefully than most people talk. Recover the recording for Spool from the assigned search area in Waystation. Deliver it to 'Spool' in Garbage, then come back to me in Marsh.",
		},
		{
			id = "OT24",
			name = "A full supply order",
			briefing = "There are supplies I would like brought in. Read the list before setting off, and leave enough room for what you need yourself. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "OT26",
			name = "He Made It This Far",
			briefing = "There's a final equipment case to collect. Keep the small things with it. I want to see what survived together. Recover the companion's recovered equipment from the assigned search area in Pripyat. Bring it back to me in Marsh.",
		},
		{
			id = "OT28",
			name = "A full supply order",
			briefing = "There are supplies I would like brought in. Read the list before setting off, and leave enough room for what you need yourself. Bring everything on the list back here; I need the full delivery.",
		},
	},
})
