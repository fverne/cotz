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
		workPrompt = "About the circuit I'm carrying.",
		offerPrompt = "Do you have a parcel circuit?",
		work = (
			"Collect the sealed parcel at the assigned pickup. Deliver it to the assigned cache. Come back "
			.. "after finishing the delivery. Read both endpoints before accepting, and leave the package shut. If "
			.. "you want to know whether that is all the arrangement requires, yes. That's why I wrote it down."
		),
		progressionPrompt = "What else needs checking in the deliveries?",
		progression = (
			"Some drops need checking and some records need recovering. The order gives the movement and the "
			.. "return. Follow that. If another contact is receiving a file, give them the file; don't explain it "
			.. "in place of delivering it. We can discuss a particular assignment once you've read it."
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
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
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
			id = "CL02",
			completionCash = 450,
			name = "The Unattended Drop",
			kind = "field",
			objective = (
				"Recover the first sealed drop parcel from the assigned search area in Garbage. Bring it back to "
				.. "the issuing contact in Garbage."
			),
			requires = {"CL01"},
			briefing = (
				"A sealed parcel needs moving between the assigned drops. Read both ends before you take "
				.. "possession. Recover the first sealed drop parcel from the assigned search area in Garbage. Bring "
				.. "it back to me in Garbage."
			),
			completion = "Delivered. That's the part I needed you to finish.",
			field = {
				description = (
					"A compact hard case with orange panels, dark protective ribs and a carrying handle. Cleaner's "
					.. "note: \"A sealed parcel needs moving between the assigned drops.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_evidence",
				label = "First sealed drop parcel",
			},
			benefits = {},
		},
		{
			id = "CL03",
			completionCash = 0,
			name = "On Time and Unopened",
			kind = "tracker",
			requires = {"CL02"},
			briefing = "Complete the assigned dead-drop circuits. Collection alone doesn't finish a delivery.",
			completion = "A few finished circuits. That's a useful start.",
			target = 2,
			benefits = {},
		},
		{
			id = "CL04",
			completionCash = 650,
			name = "A small delivery",
			kind = "delivery",
			retiredCommission = true,
			objective = "Bring all 1 listed item type to this contact. The request shows each selected item and required units.",
			requires = {"CL03"},
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
			completion = "Leave them here. That settles this request.",
			requirements = {
				{
					pool = "town_delivery_trail_garbage_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "CL05",
			completionCash = 575,
			name = "A Cleaner Way In",
			kind = "delivery",
			requires = {"CL04"},
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
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
			benefits = {},
		},
		{
			id = "CL06",
			completionCash = 850,
			name = "An Empty Hiding Place",
			kind = "field",
			objective = (
				"Recover the compromised cache evidence from the assigned search area in Garbage. Bring it back to "
				.. "the issuing contact in Garbage."
			),
			requires = {"CL04"},
			briefing = (
				"There's evidence to recover from a compromised cache. Bring the case unchanged. I don't need your "
				.. "inspection marks mixed with theirs. Recover the compromised cache evidence from the assigned "
				.. "search area in Garbage. Bring it back to me in Garbage."
			),
			completion = "Set it down. I'll check it before deciding what needs changing.",
			field = {
				description = (
					"A USB drive with a large rear loop and a handwritten paper label around its body. Cleaner's "
					.. "note: \"There's evidence to recover from a compromised cache.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_security",
				label = "Compromised cache evidence",
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
			briefing = "Continue the circuit deliveries. Use the endpoint on the order.",
			completion = "You've been consistent about finishing the drop.",
			target = 5,
			benefits = {},
		},
		{
			id = "CL08",
			completionCash = 1050,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"CL06"},
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
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
			benefits = {},
		},
		{
			id = "CL09",
			completionCash = 875,
			name = "Digging Deeper",
			kind = "delivery",
			requires = {"CL07"},
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
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
			benefits = {},
		},
		{
			id = "CL10",
			completionCash = 1250,
			name = "The Buried Register",
			kind = "field",
			objective = (
				"Recover the distribution register from the assigned search area in Garbage. Bring it back to the "
				.. "issuing contact in Garbage."
			),
			requires = {"CL08"},
			briefing = (
				"I need the distribution register recovered. Too many people are relying on entries they haven't "
				.. "looked at recently. Recover the distribution register from the assigned search area in Garbage. "
				.. "Bring it back to me in Garbage."
			),
			completion = "That's the register. I'll keep the accounts together.",
			field = {
				description = (
					"A clipboard carrying a densely printed packing list and a stamped mark. Cleaner's note: \"I need "
					.. "the distribution register recovered.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_receipt",
				label = "Distribution register",
			},
			benefits = {},
		},
		{
			id = "CL11",
			completionCash = 0,
			name = "A Quiet Service",
			kind = "tracker",
			requires = {"CL09"},
			briefing = "More sealed circuit work. Read the route before accepting it.",
			completion = "The deliveries arrived. No further explanation needed.",
			target = 9,
			benefits = {},
		},
		{
			id = "CL12",
			completionCash = 1450,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"CL10"},
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
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
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
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
			benefits = {},
		},
		{
			id = "CL14",
			capacity = {kind = "rows", amount = 1},
			completionCash = 1650,
			name = "Ledger's Missing Copy",
			kind = "field",
			objective = (
				"Recover the freight copy for Ledger from the assigned search area in Garbage. Deliver it to "
				.. "'Ledger' in Waystation, then come back to the issuing contact in Garbage."
			),
			requires = {"CL12"},
			briefing = (
				"Ledger needs his missing freight copy. Deliver the original, then come back. He doesn't need a "
				.. "courier's summary. Recover the freight copy for Ledger from the assigned search area in Garbage. "
				.. "Deliver it to 'Ledger' in Waystation, then come back to me in Garbage."
			),
			completion = "He has it. That finishes your part of the delivery.",
			field = {
				description = (
					"A printed packing list on a small clipboard with a metal clip and a circular stamp. Cleaner's "
					.. "note: \"Ledger needs his missing freight copy.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_manifest",
				label = "Freight copy for Ledger",
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
			briefing = "Keep completing the drop circuits. Familiarity doesn't change the destination.",
			completion = "You've kept the arrangement straightforward.",
			target = 14,
			benefits = {},
		},
		{
			id = "CL16",
			completionCash = 1850,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"CL14"},
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
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
			benefits = {},
		},
		{
			id = "CL17",
			completionCash = 1475,
			name = "A Better Reserve",
			kind = "delivery",
			requires = {"CL15"},
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
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
			benefits = {},
		},
		{
			id = "CL18",
			completionCash = 2050,
			name = "The Other Register",
			kind = "field",
			objective = (
				"Recover the distribution backup for Ledger from the assigned search area in Waystation. Deliver "
				.. "it to 'Ledger' in Waystation, then come back to the issuing contact in Garbage."
			),
			requires = {"CL16"},
			briefing = (
				"The backup register goes to Ledger. If the accounts disagree, he should have something more "
				.. "useful than my opinion. Recover the distribution backup for Ledger from the assigned search area "
				.. "in Waystation. Deliver it to 'Ledger' in Waystation, then come back to me in Garbage."
			),
			completion = "Delivered. I'll let him examine it before asking which entries need attention.",
			field = {
				description = (
					"A blue records folder with contrasting corporate lettering along the cover. Cleaner's note: \"The "
					.. "backup register goes to Ledger.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_archive",
				label = "Distribution backup for Ledger",
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
			briefing = "There are more circuits to complete. Keep the parcels closed.",
			completion = "A reliable run of deliveries. I can work with that.",
			target = 20,
			benefits = {},
		},
		{
			id = "CL20",
			completionCash = 2250,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"CL18"},
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
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
			benefits = {},
		},
		{
			id = "CL21",
			completionCash = 1775,
			name = "Nobody's Spare Key",
			kind = "delivery",
			requires = {"CL19"},
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
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
			benefits = {},
		},
		{
			id = "CL22",
			completionCash = 2450,
			name = "A Cache With Two Owners",
			kind = "field",
			objective = (
				"Recover the cache ownership file from the assigned search area in Pripyat. Bring it back to the "
				.. "issuing contact in Garbage."
			),
			requires = {"CL20"},
			briefing = (
				"I need the ownership record. Two people saying mine doesn't make two separate caches. Recover the "
				.. "cache ownership file from the assigned search area in Pripyat. Bring it back to me in Garbage."
			),
			completion = "I'll read the claims. Nobody gets an answer before that.",
			field = {
				description = (
					"A creased printed letter with a corporate mark and several small blocks of text. Cleaner's note: "
					.. "\"I need the ownership record.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_contract",
				label = "Cache ownership file",
			},
			benefits = {},
		},
		{
			id = "CL23",
			completionCash = 0,
			name = "The Last Circuit",
			kind = "tracker",
			requires = {"CL21"},
			briefing = "Continue the assigned circuits. Return after the delivery is finished.",
			completion = "You've done the work over time. That's what I judge.",
			target = 27,
			benefits = {},
		},
		{
			id = "CL24",
			completionCash = 2650,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"CL22"},
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
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
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
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
			benefits = {},
		},
		{
			id = "CL26",
			completionCash = 2850,
			name = "The Cache That Stayed Closed",
			kind = "field",
			objective = (
				"Collect the final sealed circuit parcel at the assigned pickup in Garbage and deliver it to the "
				.. "assigned cache. Come back to the issuing contact in Garbage."
			),
			requires = {"CL25"},
			briefing = (
				"One more sealed circuit delivery. Finish the drop before coming back for the account to be "
				.. "closed. Collect the final sealed circuit parcel at the assigned pickup in Garbage and deliver it "
				.. "to the assigned cache. Come back to me in Garbage."
			),
			completion = "Delivery finished. You've been consistent. I have work for people who can stay that way.",
			field = {
				description = (
					"A compact hard case with orange panels, dark protective ribs and a carrying handle. Cleaner's "
					.. "note: \"One more sealed circuit delivery.\""
				),
				kind = "deadDrop",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_evidence",
				label = "Final sealed circuit parcel",
			},
			benefits = {},
		},
		{
			id = "CL27",
			completionCash = 0,
			name = "Trusted With the Route",
			kind = "tracker",
			requires = {"CL26"},
			briefing = "More drop circuits when you're prepared. The same delivery terms apply.",
			completion = "You've earned my confidence in the work. Keep it that way.",
			target = 35,
			benefits = {},
		},
		{
			id = "CL28",
			completionCash = 3000,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"CL27"},
			briefing = (
				"I need supplies for the next arrangements. The list is specific. Bring them here. Bring "
				.. "everything on the list back here; I need the full delivery."
			),
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
			benefits = {},
			recognition = "Cleaner's trusted contact",
		},
	},
})
