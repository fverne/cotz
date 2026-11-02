PLUGIN:Register("cleaner", {
	name = "'Cleaner'",
	template = "owlnpc",
	map = "mz_garbage",
	job = {
		kind = "deadDrop",
		category = "Dead-drop circuits",
		description = "Dead-drop circuits",
		maps = {
			easy = "mz_garbage",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Cache upkeep",
				items = {"hidestasher_cleaningkit"}},
			{label = "Courier supplies",
				items = {"food_raisins", "drink_bottlewater"}},
			{label = "Contingency",
				items = {"9x19", "medic_bandage_1"}},
		},
	},
	dialogue = {
		delivery = "Leave it here. Keep it closed.",
		completedGreeting = (
			"You're here. Good. We can spare ourselves the usual discussion about whether instructions "
			.. "need following."
		),
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Collect the parcel. Take it to the other drop. Leave it sealed. Check both ends of the route. Once "
			.. "you're carrying it, curiosity won't make the package any easier to deliver."
		),
		progressionPrompt = "What else needs doing?",
		progression = (
			"Supplies. Missing records. Deliveries. Pick one, and keep the details to yourself. Some records "
			.. "need finding. Some supplies need replacing. I will give you enough to do the work. Don't confuse "
			.. "that with an invitation to discuss everyone involved."
		),
	},
	catalogue = {
		["hidestasher_cleaningkit"] = {step = "CL05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["hidestasher_shovel"] = {step = "CL09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "CL01",
			completionCash = 275,
			name = "A Package That Stays Shut",
			kind = "delivery",
			requires = {},
			briefing = (
				"Bring the maintenance supplies on the list. Here. I need a few things prepared before I "
				.. "send anything out. You can read an order and bring what it asks for; that's enough to start "
				.. "with."
			),
			completion = (
				"That's what I asked for. Leave it there. If you've questions about further work, ask them "
				.. "before you pick anything up."
			),
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 2,
				},
			},
			benefits = {
				items = {
					{
						item = "drink_bottlewater",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "CL02",
			completionCash = 450,
			name = "The Unattended Drop",
			kind = "field",
			objective = "Recover Orange Evidence Case from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"CL01"},
			briefing = "Complete a two-point drop in Garbage.",
			completion = "Leave it. I'll check it later.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_evidence",
				label = "The Unattended Drop - Orange Evidence Case",
			},
			benefits = {},
		},
		{
			id = "CL03",
			completionCash = 0,
			name = "On Time and Unopened",
			kind = "tracker",
			requires = {"CL02"},
			briefing = "Collect the parcel. Take it to the other drop. Leave it sealed.",
			completion = "The deliveries are counted. No need to tell me about them twice.",
			target = 2,
			benefits = {},
		},
		{
			id = "CL04",
			completionCash = 650,
			name = "The Wrong Marker",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"CL03"},
			briefing = "Recover a drop's placement record.",
			completion = "Seal looks intact. Good.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "The Wrong Marker - Tied Leather Journal",
			},
			benefits = {},
		},
		{
			id = "CL05",
			completionCash = 575,
			name = "A Cleaner Way In",
			kind = "delivery",
			requires = {"CL04"},
			briefing = "Bring what's on the list. Leave it with me.",
			completion = "That's enough.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "CL06",
			completionCash = 850,
			name = "An Empty Hiding Place",
			kind = "field",
			objective = "Recover Tagged Security Flash Drive from the assigned search area in Garbage. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"CL04"},
			briefing = "Recover evidence from a compromised cache.",
			completion = "That's what I needed.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_security",
				label = "An Empty Hiding Place - Tagged Security Flash Drive",
			},
			benefits = {
				items = {
					{
						item = "medic_bandage_1",
						data = {
							quantity = 1,
						},
					},
				},
			},
			stock = {
				item = "drink_bottlewater",
				bonus = 1,
			},
		},
		{
			id = "CL07",
			completionCash = 0,
			name = "No Questions",
			kind = "tracker",
			requires = {"CL05"},
			briefing = "Collect the parcel. Take it to the other drop. Leave it sealed.",
			completion = "The deliveries are counted. No need to tell me about them twice.",
			target = 5,
			benefits = {},
		},
		{
			id = "CL08",
			completionCash = 1050,
			name = "The Missing Runner",
			kind = "field",
			objective = "Recover Handwritten Audio Cassette from the assigned search area in Garbage. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"CL06"},
			briefing = "Recover a runner's recorder at a freight route.",
			completion = "Leave it. I'll check it later.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_tape",
				label = "The Missing Runner - Handwritten Audio Cassette",
			},
			benefits = {},
		},
		{
			id = "CL09",
			completionCash = 875,
			name = "Digging Deeper",
			kind = "delivery",
			requires = {"CL07"},
			briefing = "Bring what's on the list. Leave it with me.",
			completion = "Good. We're finished with that.",
			requirements = {
				{
					pool = "basic_tools",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "CL10",
			completionCash = 1250,
			name = "The Buried Register",
			kind = "field",
			objective = "Recover Warehouse Packing List B from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"CL08"},
			briefing = "Recover the distribution register from a hidden field site.",
			completion = "Seal looks intact. Good.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_receipt",
				label = "The Buried Register - Warehouse Packing List B",
			},
			benefits = {},
		},
		{
			id = "CL11",
			completionCash = 0,
			name = "A Quiet Service",
			kind = "tracker",
			requires = {"CL09"},
			briefing = "Collect the parcel. Take it to the other drop. Leave it sealed.",
			completion = "The deliveries are counted. No need to tell me about them twice.",
			target = 9,
			benefits = {},
		},
		{
			id = "CL12",
			completionCash = 1450,
			name = "The Duplicate Seal",
			kind = "field",
			objective = "Recover Orange Evidence Case from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"CL10"},
			briefing = "Retrieve evidence from a second compromised drop.",
			completion = "That's what I needed.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_evidence",
				label = "The Duplicate Seal - Orange Evidence Case",
			},
			benefits = {
				items = {
					{
						item = "lowtiercookerfuel",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "CL13",
			completionCash = 1175,
			name = "Safe and Dry",
			kind = "delivery",
			requires = {"CL11"},
			briefing = "Bring what's on the list. Leave it with me.",
			completion = "Put it there.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 4,
				},
			},
			benefits = {},
		},
		{
			id = "CL14",
			capacity = {kind = "rows", amount = 1},
			completionCash = 1650,
			name = "Ledger's Missing Copy",
			kind = "field",
			objective = "Recover Warehouse Packing List A from the assigned search area in Garbage. Deliver it to"
				.. " 'Ledger' in Waystation, then return here to finish the assignment.",
			requires = {"CL12"},
			briefing = "Recover freight evidence from a regional cache.",
			completion = "It arrived. Good. Leave the rest with me.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_manifest",
				label = "Ledger's Missing Copy - Warehouse Packing List A",
				recipient = "ledger",
			},
			benefits = {},
		},
		{
			id = "CL15",
			completionCash = 0,
			name = "Across the Boundary",
			kind = "tracker",
			requires = {"CL13"},
			briefing = (
				"Collect the parcel. Take it to the other drop. Leave it sealed. Keep doing the "
				.. "deliveries as instructed. Changing the arrangement to make yourself comfortable leaves "
				.. "somebody else wondering what happened."
			),
			completion = (
				"The deliveries are counted. No need to tell me about them twice. Reliable work. No, "
				.. "that doesn't mean you should start taking liberties with the next parcel."
			),
			target = 14,
			benefits = {},
		},
		{
			id = "CL16",
			completionCash = 1850,
			name = "The False Destination",
			kind = "field",
			objective = "Recover Tagged Security Flash Drive from the assigned search area in Garbage. Deliver it to"
				.. " the assigned cache using Field work, then return here.",
			requires = {"CL14"},
			briefing = "Complete a delivery to a corrected cache endpoint.",
			completion = "Seal looks intact. Good.",
			field = {
				kind = "deadDrop",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_security",
				label = "The False Destination - Tagged Security Flash Drive",
			},
			benefits = {},
		},
		{
			id = "CL17",
			completionCash = 1475,
			name = "A Better Reserve",
			kind = "delivery",
			requires = {"CL15"},
			briefing = "Bring what's on the list. Leave it with me.",
			completion = "That's enough.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 5,
				},
			},
			benefits = {},
		},
		{
			id = "CL18",
			completionCash = 2050,
			name = "The Other Register",
			kind = "field",
			objective = "Recover Corporate Records Folder from the assigned search area in Waystation. Deliver it to"
				.. " 'Ledger' in Waystation, then return here to finish the assignment.",
			requires = {"CL16"},
			briefing = "Recover a distribution backup in Waystation territory.",
			completion = "It arrived. Good. Leave the rest with me.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_archive",
				label = "The Other Register - Corporate Records Folder",
				recipient = "ledger",
			},
			benefits = {
				items = {
					{
						item = "medic_bandage_1",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "CL19",
			completionCash = 0,
			name = "Without a Trace",
			kind = "tracker",
			requires = {"CL17"},
			briefing = "Collect the parcel. Take it to the other drop. Leave it sealed.",
			completion = "The deliveries are counted. No need to tell me about them twice.",
			target = 20,
			benefits = {},
		},
		{
			id = "CL20",
			completionCash = 2250,
			name = "The Unmanned Depot",
			kind = "field",
			objective = "Recover Striped Equipment Case from the assigned search area in Pripyat. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"CL18"},
			briefing = "Recover a case at a Pripyat supply cache.",
			completion = "Leave it. I'll check it later.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_equipment",
				label = "The Unmanned Depot - Striped Equipment Case",
			},
			benefits = {},
		},
		{
			id = "CL21",
			completionCash = 1775,
			name = "Nobody's Spare Key",
			kind = "delivery",
			requires = {"CL19"},
			briefing = "Bring what's on the list. Leave it with me.",
			completion = "Good. We're finished with that.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 6,
				},
			},
			benefits = {},
		},
		{
			id = "CL22",
			completionCash = 2450,
			name = "A Cache With Two Owners",
			kind = "field",
			objective = "Recover Corporate Letter from the assigned search area in Pripyat. Return it to this contact"
				.. " to finish the assignment.",
			requires = {"CL20"},
			briefing = "Recover the cache ownership record in Pripyat.",
			completion = "Seal looks intact. Good.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_contract",
				label = "A Cache With Two Owners - Corporate Letter",
			},
			benefits = {},
		},
		{
			id = "CL23",
			completionCash = 0,
			name = "The Last Circuit",
			kind = "tracker",
			requires = {"CL21"},
			briefing = "Collect the parcel. Take it to the other drop. Leave it sealed.",
			completion = "The deliveries are counted. No need to tell me about them twice.",
			target = 27,
			benefits = {},
		},
		{
			id = "CL24",
			completionCash = 2650,
			name = "The Burned Address",
			kind = "field",
			objective = "Recover Official File Folder from the assigned search area in Pripyat. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"CL22"},
			briefing = "Recover the final routing record in Pripyat.",
			completion = "That's what I needed.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_official",
				label = "The Burned Address - Official File Folder",
			},
			benefits = {
				items = {
					{
						item = "lowtiercookerfuel",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "CL25",
			completionCash = 2000,
			name = "Room to Keep It",
			kind = "delivery",
			requires = {"CL23", "CL24"},
			briefing = "Bring what's on the list. Leave it with me.",
			completion = "Put it there.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 7,
				},
			},
			benefits = {},
		},
		{
			id = "CL26",
			completionCash = 2850,
			name = "The Cache That Stayed Closed",
			kind = "field",
			objective = "Recover Orange Evidence Case from the assigned search area in Garbage. Deliver it to the"
				.. " assigned cache using Field work, then return here.",
			requires = {"CL25"},
			briefing = "Complete the network's last sealed delivery.",
			completion = "Leave it. I'll check it later.",
			field = {
				kind = "deadDrop",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_evidence",
				label = "The Cache That Stayed Closed - Orange Evidence Case",
			},
			benefits = {},
		},
		{
			id = "CL27",
			completionCash = 0,
			name = "Trusted With the Route",
			kind = "tracker",
			requires = {"CL26"},
			briefing = "Collect the parcel. Take it to the other drop. Leave it sealed.",
			completion = "The deliveries are counted. No need to tell me about them twice.",
			target = 35,
			benefits = {},
		},
		{
			id = "CL28",
			completionCash = 3000,
			name = "No More Missing Parcels",
			kind = "field",
			objective = "Recover Warehouse Packing List B from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"CL27"},
			briefing = (
				"Recover closure evidence from the supply route and return. Bring the packing list back complete. "
				.. "A missing line is enough to leave an argument open. I'd like this one finished."
			),
			completion = (
				"Seal looks intact. Good. That covers it. You did the work without making it everybody's business. "
				.. "That's why I kept giving you work. Take the compliment; I'm not repeating it."
			),
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_receipt",
				label = "No More Missing Parcels - Warehouse Packing List B",
			},
			benefits = {},
			recognition = "Cleaner's trusted contact",
		},
	},
})
