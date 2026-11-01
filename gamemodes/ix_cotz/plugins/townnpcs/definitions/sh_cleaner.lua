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
	dialogue = {
		delivery = "Leave it here. Keep it closed.",
		completedGreeting = "Everything arrived. That's all anyone needs to know.",
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = "Collect the parcel. Take it to the other drop. Leave it sealed.",
		progressionPrompt = "What else needs doing?",
		progression = "Supplies. Missing records. Deliveries. Pick one, and keep the details to yourself.",
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
			name = "A Package That Stays Shut",
			kind = "delivery",
			requires = {},
			briefing = "Bring what's on the list. Leave it with me.",
			completion = "Put it there.",
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
			id = "CL03",
			name = "On Time and Unopened",
			kind = "tracker",
			requires = {"CL02"},
			briefing = "Collect the parcel. Take it to the other drop. Leave it sealed.",
			completion = "The deliveries are counted. No need to tell me about them twice.",
			target = 2,
			benefits = {
				items = {
					{
						item = "food_bread",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "CL04",
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
			id = "CL05",
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
			id = "CL06",
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
			name = "No Questions",
			kind = "tracker",
			requires = {"CL05"},
			briefing = "Collect the parcel. Take it to the other drop. Leave it sealed.",
			completion = "The deliveries are counted. No need to tell me about them twice.",
			target = 5,
			benefits = {
				items = {
					{
						item = "food_bread",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "CL08",
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
			id = "CL09",
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
			id = "CL10",
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
			id = "CL11",
			name = "A Quiet Service",
			kind = "tracker",
			requires = {"CL09"},
			briefing = "Collect the parcel. Take it to the other drop. Leave it sealed.",
			completion = "The deliveries are counted. No need to tell me about them twice.",
			target = 9,
			benefits = {
				items = {
					{
						item = "food_bread",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "CL12",
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
			id = "CL14",
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
			id = "CL15",
			name = "Across the Boundary",
			kind = "tracker",
			requires = {"CL13"},
			briefing = "Collect the parcel. Take it to the other drop. Leave it sealed.",
			completion = "The deliveries are counted. No need to tell me about them twice.",
			target = 14,
			benefits = {
				items = {
					{
						item = "food_bread",
						data = {
							quantity = 1,
						},
					},
				},
			},
			discounts = {{npc = "'Cleaner'", service = "storage", fraction = 0.05}},
		},
		{
			id = "CL16",
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
			id = "CL17",
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
			id = "CL18",
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
			name = "Without a Trace",
			kind = "tracker",
			requires = {"CL17"},
			briefing = "Collect the parcel. Take it to the other drop. Leave it sealed.",
			completion = "The deliveries are counted. No need to tell me about them twice.",
			target = 20,
			benefits = {
				items = {
					{
						item = "food_bread",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "CL20",
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
			id = "CL21",
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
			id = "CL22",
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
			id = "CL23",
			name = "The Last Circuit",
			kind = "tracker",
			requires = {"CL21"},
			briefing = "Collect the parcel. Take it to the other drop. Leave it sealed.",
			completion = "The deliveries are counted. No need to tell me about them twice.",
			target = 27,
			benefits = {
				items = {
					{
						item = "food_bread",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "CL24",
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
			id = "CL26",
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
				bonus = 2,
			},
		},
		{
			id = "CL27",
			name = "Trusted With the Route",
			kind = "tracker",
			requires = {"CL26"},
			briefing = "Collect the parcel. Take it to the other drop. Leave it sealed.",
			completion = "The deliveries are counted. No need to tell me about them twice.",
			target = 35,
			benefits = {
				items = {
					{
						item = "food_bread",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "CL28",
			name = "No More Missing Parcels",
			kind = "field",
			objective = "Recover Warehouse Packing List B from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"CL27"},
			briefing = "Recover closure evidence from the supply route and return.",
			completion = "Seal looks intact. Good.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_receipt",
				label = "No More Missing Parcels - Warehouse Packing List B",
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
			recognition = "Cleaner's trusted contact",
		},
	},
})
