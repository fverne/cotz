PLUGIN:Register("ballast", {
	name = "'Ballast'",
	template = "ballastnpc",
	difficultyMultiplier = 1,
	enforceCatalogue = true,
	map = "rp_marsh_cs",
	buyAll = true,
	buyScale = 0.3,
	courierPools = {
		"valuables_transit_cases",
		"valuables_reinforced_cases",
		"valuables_equipment_pouches",
		"valuables_protective_textiles",
	},
	job = {
		category = "Equipment recovery",
		description = "Equipment recovery",
		kind = "recovery",
		maps = {
			easy = "rp_marsh_cs",
			hard = "rp_garbage_cotz",
			medium = "rp_marsh_cs",
		},
	},
	legacyJob = {
		category = "Equipment recovery",
		description = "Equipment recovery",
		kind = "recovery",
		maps = {
			easy = "rp_marsh_cs",
			hard = "rp_pripyat_remaster",
			medium = "rp_garbage_cotz",
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
		completedGreeting = "Back with both boots, I see. Always a promising start to a conversation. What do you need?",
		delivery = "Over here. If it is still dry, we are off to a good start.",
		jobBriefing = "Someone left a load out there and would very much like it back. {details}",
		jobFinished = "Back with the load. Good. Put it down before we start discussing payment.",
		jobReminder = "I'm still waiting on that equipment. {details}",
		offerPrompt = "Do you have a recovery job?",
		progression = "I need packing supplies for the loads coming through. It is easier to keep a load dry than explain afterwards why nobody thought of it. Bring everything on the list back here; I need the full delivery.",
		progressionPrompt = "What needs sorting out along the freight route?",
		work = "A marked case, brought back intact. Have a look at the return before you load yourself down. People become inventive about routes once they've got both hands full, and the inventions rarely improve my afternoon. Check the region before agreeing. I can wait while you prepare.",
		workPrompt = "About the case I'm recovering.",
	},
	catalogue = {},
	progression = {
		{
			id = "v3/hideout/01",
			branch = "hideout",
			name = "Hideout improvements 1",
			kind = "delivery",
			requires = {},
			briefing = "I need packing supplies for the loads coming through. It is easier to keep a load dry than explain afterwards why nobody thought of it. Bring everything on the list back here; I need the full delivery.",
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 450,
			hideoutLevel = 1,
			services = {
				{
					id = "ballastHideout1",
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
			briefing = "I need packing supplies for the loads coming through. It is easier to keep a load dry than explain afterwards why nobody thought of it. Bring everything on the list back here; I need the full delivery.",
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 650,
			hideoutLevel = 2,
			services = {
				{
					id = "ballastHideout2",
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
			briefing = "I need packing supplies for the loads coming through. It is easier to keep a load dry than explain afterwards why nobody thought of it. Bring everything on the list back here; I need the full delivery.",
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 900,
			hideoutLevel = 3,
			services = {
				{
					id = "ballastHideout3",
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
			briefing = "I need packing supplies for the loads coming through. It is easier to keep a load dry than explain afterwards why nobody thought of it. Bring everything on the list back here; I need the full delivery.",
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 1100,
			hideoutLevel = 4,
			services = {
				{
					id = "ballastHideout4",
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
			briefing = "I need packing supplies for the loads coming through. It is easier to keep a load dry than explain afterwards why nobody thought of it. Bring everything on the list back here; I need the full delivery.",
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1350,
			hideoutLevel = 5,
			services = {
				{
					id = "ballastHideout5",
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
			briefing = "I need packing supplies for the loads coming through. It is easier to keep a load dry than explain afterwards why nobody thought of it. Bring everything on the list back here; I need the full delivery.",
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1600,
			hideoutLevel = 6,
			services = {
				{
					id = "ballastHideout6",
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
			briefing = "I need packing supplies for the loads coming through. It is easier to keep a load dry than explain afterwards why nobody thought of it. Bring everything on the list back here; I need the full delivery.",
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1800,
			hideoutLevel = 7,
			services = {
				{
					id = "ballastHideout7",
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
			briefing = "I need packing supplies for the loads coming through. It is easier to keep a load dry than explain afterwards why nobody thought of it. Bring everything on the list back here; I need the full delivery.",
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 2050,
			hideoutLevel = 8,
			services = {
				{
					id = "ballastHideout8",
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
			briefing = "I need packing supplies for the loads coming through. It is easier to keep a load dry than explain afterwards why nobody thought of it. Bring everything on the list back here; I need the full delivery.",
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2300,
			hideoutLevel = 9,
			services = {
				{
					id = "ballastHideout9",
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
			briefing = "I need packing supplies for the loads coming through. It is easier to keep a load dry than explain afterwards why nobody thought of it. Bring everything on the list back here; I need the full delivery.",
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2500,
			hideoutLevel = 10,
			services = {
				{
					id = "ballastHideout10",
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
			briefing = "I need packing supplies for the loads coming through. It is easier to keep a load dry than explain afterwards why nobody thought of it. Bring everything on the list back here; I need the full delivery.",
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2750,
			hideoutLevel = 11,
			services = {
				{
					id = "ballastHideout11",
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
			briefing = "I need packing supplies for the loads coming through. It is easier to keep a load dry than explain afterwards why nobody thought of it. Bring everything on the list back here; I need the full delivery.",
			completion = "Put them down here. I will sort the packing before anything leaves.",
			requirements = {
				{
					pool = "town_delivery_textiles_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_textiles_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_marsh_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
			hideoutLevel = 12,
			services = {
				{
					id = "ballastHideout12",
					name = "Hideout improvements 12",
				},
			},
		},
	},
	startingServices = {},
	retiredCommissions = {
		{
			id = "BA02",
			name = "The First Stranding",
			briefing = "A case has been left out along the route. Its owner has explained how urgent it is at greater length than how it got there. Recover the stranded freight case from the assigned search area in Marsh. Bring it back to me in Marsh.",
		},
		{
			id = "BA04",
			name = "A small delivery",
			briefing = "I need packing supplies for the loads coming through. It is easier to keep a load dry than explain afterwards why nobody thought of it. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "BA06",
			name = "A Missing Mooring",
			briefing = "There's a tool case left with the maintenance work. Tools are useful company, but only when somebody remembers to bring them home. Recover the landing maintenance tools from the assigned search area in Marsh. Bring it back to me in Marsh.",
		},
		{
			id = "BA08",
			name = "Restocking",
			briefing = "I need packing supplies for the loads coming through. It is easier to keep a load dry than explain afterwards why nobody thought of it. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "BA10",
			name = "The Floating Trail",
			briefing = "There's a recording from the crew's route. I'd rather hear their own account before listening to another confident explanation. Recover the crew route cassette from the assigned search area in Marsh. Bring it back to me in Marsh.",
		},
		{
			id = "BA12",
			name = "Building the reserve",
			briefing = "I need packing supplies for the loads coming through. It is easier to keep a load dry than explain afterwards why nobody thought of it. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "BA14",
			name = "The Other Landing",
			briefing = "Ledger needs the landing record. He packs things properly and remembers where he sent them; I try to return the courtesy. Recover the landing freight manifest from the assigned search area in Marsh. Deliver it to 'Ledger' in Waystation, then come back to me in Marsh.",
		},
		{
			id = "BA16",
			name = "Building the reserve",
			briefing = "I need packing supplies for the loads coming through. It is easier to keep a load dry than explain afterwards why nobody thought of it. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "BA18",
			name = "The Last Mooring",
			briefing = "I want the crew's personal records kept together. Loose pages have a way of acquiring owners who remember only the convenient parts. Recover the crew personal records from the assigned search area in Marsh. Bring it back to me in Marsh.",
		},
		{
			id = "BA20",
			name = "A full supply order",
			briefing = "I need packing supplies for the loads coming through. It is easier to keep a load dry than explain afterwards why nobody thought of it. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "BA22",
			name = "A full supply order",
			briefing = "I need packing supplies for the loads coming through. It is easier to keep a load dry than explain afterwards why nobody thought of it. Bring everything on the list back here; I need the full delivery.",
		},
	},
})
