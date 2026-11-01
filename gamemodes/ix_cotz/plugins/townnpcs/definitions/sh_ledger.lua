PLUGIN:Register("ledger", {
	name = "'Ledger'",
	template = "ledgernpc",
	map = "rp_waystation",
	job = {
		kind = "deadDrop",
		category = "Dead-drop circuits",
		description = "Dead-drop circuits",
		maps = {
			easy = "rp_waystation",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	dialogue = {
		delivery = "The parcel first. Then I can close the entry.",
		completedGreeting = (
			"Good to see you. Your work has saved me a number of difficult enquiries. What can I help "
			.. "you with today?"
		),
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Collect the sealed parcel at the first point, deliver it to the second, then report back. Both "
			.. "ends matter. Check where the parcel goes before collecting it. I'd rather answer a question now "
			.. "than add another uncertain delivery to the book."
		),
		progressionPrompt = "What else needs doing?",
		progression = (
			"There's freight to move and paperwork to recover. Read the destination before taking the parcel. I "
			.. "need supplies to keep things moving and surviving records to settle the gaps. Each missing entry "
			.. "is a question I cannot responsibly cross out yet."
		),
	},
	catalogue = {
	},
	progression = {
		{
			id = "LE01",
			completionCash = 275,
			name = "Labels That Last",
			kind = "delivery",
			requires = {},
			briefing = (
				"Deliver the listed supplies here. I'll record the quantity when it arrives. Keep "
				.. "everything together until I have checked it. I would like our first entry to be clear "
				.. "enough that neither of us has to revisit it."
			),
			completion = (
				"Let me enter the quantity. Entered. Thank you for making the beginning simple; there "
				.. "will be enough complications without inventing one here."
			),
			requirements = {
				{
					pool = "administrative_documents",
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
			id = "LE02",
			completionCash = 450,
			name = "The First Route",
			kind = "field",
			objective = "Recover Small Yellow Transit Case from the assigned search area in Waystation. Deliver it to"
				.. " the assigned cache using Field work, then return here.",
			requires = {"LE01"},
			briefing = "Complete a regional dead-drop circuit.",
			completion = "I'll record that as returned.",
			field = {
				kind = "deadDrop",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_case",
				label = "The First Route - Small Yellow Transit Case",
			},
			benefits = {},
		},
		{
			id = "LE03",
			completionCash = 0,
			name = "Delivered Intact",
			kind = "tracker",
			requires = {"LE02"},
			briefing = (
				"Collect the sealed parcel at the first point, deliver it to the second, then report back. "
				.. "Both ends matter."
			),
			completion = "The completed deliveries are on the record. You've been consistent.",
			target = 2,
			benefits = {},
		},
		{
			id = "LE04",
			completionCash = 650,
			name = "The Missing Receipt",
			kind = "field",
			objective = "Recover Warehouse Packing List B from the assigned search area in Waystation. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"LE02"},
			briefing = "Recover a receipt from a Waystation freight cache.",
			completion = "Set it with the freight records.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_receipt",
				label = "The Missing Receipt - Warehouse Packing List B",
			},
			benefits = {},
		},
		{
			id = "LE05",
			completionCash = 575,
			name = "Stock for the Road",
			kind = "delivery",
			requires = {"LE03"},
			briefing = "Deliver the listed supplies here. I'll record the quantity when it arrives.",
			completion = "Received. I'll put it with the supplies.",
			requirements = {
				{
					pool = "canned_food",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "LE06",
			completionCash = 850,
			name = "Ballast's Landing Copy",
			kind = "field",
			objective = "Recover Warehouse Packing List A from the assigned search area in Marsh. Deliver it to"
				.. " 'Ballast' in Marsh, then return here to finish the assignment.",
			requires = {"LE04"},
			briefing = "Recover a landing manifest in Marsh.",
			completion = "Delivered, confirmed, entered. That closes this consignment.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_manifest",
				label = "Ballast's Landing Copy - Warehouse Packing List A",
				recipient = "ballast",
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
			id = "LE07",
			completionCash = 0,
			name = "On Both Sides",
			kind = "tracker",
			requires = {"LE05"},
			briefing = (
				"Collect the sealed parcel at the first point, deliver it to the second, then report back. "
				.. "Both ends matter."
			),
			completion = "The completed deliveries are on the record. You've been consistent.",
			target = 5,
			benefits = {},
		},
		{
			id = "LE08",
			completionCash = 1050,
			name = "The Interrupted Connection",
			kind = "field",
			objective = "Recover Striped Equipment Case from the assigned search area in Garbage. Deliver it to"
				.. " 'Cleaner' in Garbage, then return here to finish the assignment.",
			requires = {"LE06"},
			briefing = "Recover a freight case on the Garbage route.",
			completion = "Delivered, confirmed, entered. That closes this consignment.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_equipment",
				label = "The Interrupted Connection - Striped Equipment Case",
				recipient = "cleaner",
			},
			benefits = {},
		},
		{
			id = "LE09",
			completionCash = 875,
			name = "Paperwork That Matches",
			kind = "delivery",
			requires = {"LE07"},
			briefing = "Deliver the listed supplies here. I'll record the quantity when it arrives.",
			completion = "That matches the list.",
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "LE10",
			completionCash = 1250,
			name = "The Duplicate Destination",
			kind = "field",
			objective = "Recover Official File Folder from the assigned search area in Waystation. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"LE08"},
			briefing = "Recover paired route records from regional caches.",
			completion = "Set it with the freight records.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_official",
				label = "The Duplicate Destination - Official File Folder",
			},
			benefits = {},
		},
		{
			id = "LE11",
			completionCash = 0,
			name = "More Than Local",
			kind = "tracker",
			requires = {"LE09"},
			briefing = (
				"Collect the sealed parcel at the first point, deliver it to the second, then report back. "
				.. "Both ends matter."
			),
			completion = "The completed deliveries are on the record. You've been consistent.",
			target = 9,
			benefits = {},
		},
		{
			id = "LE12",
			completionCash = 1450,
			name = "The Missing Dispatcher",
			kind = "field",
			objective = "Recover Handwritten Audio Cassette from the assigned search area in Waystation. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"LE10"},
			briefing = (
				"Retrieve a dispatcher recorder in regional ruins. Check the destination and return "
				.. "instruction before leaving. A parcel waiting at the wrong end gives me two people to "
				.. "contact instead of one."
			),
			completion = (
				"Thank you. Let me check the reference. I'll update the account once I've checked the "
				.. "details. Thank you for returning rather than leaving me to infer the outcome."
			),
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_tape",
				label = "The Missing Dispatcher - Handwritten Audio Cassette",
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
			id = "LE13",
			completionCash = 1175,
			name = "For the Remote Cache",
			kind = "delivery",
			requires = {"LE11"},
			briefing = "Deliver the listed supplies here. I'll record the quantity when it arrives.",
			completion = "Let me enter the quantity.",
			requirements = {
				{
					pool = "canned_food",
					quantity = 4,
				},
			},
			benefits = {},
		},
		{
			id = "LE14",
			completionCash = 1650,
			name = "The Last Scheduled Drop",
			kind = "field",
			objective = "Recover Orange Evidence Case from the assigned search area in Waystation. Deliver it to the"
				.. " assigned cache using Field work, then return here.",
			requires = {"LE12"},
			briefing = "Complete a remote cache delivery.",
			completion = "I'll record that as returned.",
			field = {
				kind = "deadDrop",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_evidence",
				label = "The Last Scheduled Drop - Orange Evidence Case",
			},
			benefits = {},
		},
		{
			id = "LE15",
			completionCash = 0,
			name = "A Dependable Circuit",
			kind = "tracker",
			requires = {"LE13"},
			briefing = (
				"Collect the sealed parcel at the first point, deliver it to the second, then report back. "
				.. "Both ends matter."
			),
			completion = "The completed deliveries are on the record. You've been consistent.",
			target = 14,
			benefits = {},
		},
		{
			id = "LE16",
			completionCash = 1850,
			name = "The Unmanned Pripyat Cache",
			kind = "field",
			objective = "Recover Marked Research Case from the assigned search area in Pripyat. Deliver it to the"
				.. " assigned cache using Field work, then return here.",
			requires = {"LE14"},
			briefing = "Complete a delivery to a Pripyat cache.",
			completion = "Set it with the freight records.",
			field = {
				kind = "deadDrop",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_research",
				label = "The Unmanned Pripyat Cache - Marked Research Case",
			},
			benefits = {},
		},
		{
			id = "LE17",
			completionCash = 1475,
			name = "Proof on Paper",
			kind = "delivery",
			requires = {"LE15"},
			briefing = "Deliver the listed supplies here. I'll record the quantity when it arrives.",
			completion = "Received. I'll put it with the supplies.",
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 2,
				},
			},
			benefits = {},
		},
		{
			id = "LE18",
			completionCash = 2050,
			name = "The Dispatcher's Detour",
			kind = "field",
			objective = "Recover Handwritten Audio Cassette from the assigned search area in Pripyat. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"LE16"},
			briefing = "Recover the missing dispatcher's recorder in Pripyat.",
			completion = "Thank you. Let me check the reference.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_tape",
				label = "The Dispatcher's Detour - Handwritten Audio Cassette",
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
			id = "LE19",
			completionCash = 0,
			name = "The Route Holds",
			kind = "tracker",
			requires = {"LE17", "LE18"},
			briefing = (
				"Collect the sealed parcel at the first point, deliver it to the second, then report back. "
				.. "Both ends matter."
			),
			completion = "The completed deliveries are on the record. You've been consistent.",
			target = 20,
			benefits = {},
		},
		{
			id = "LE20",
			completionCash = 2250,
			name = "The Return Consignment",
			kind = "field",
			objective = "Recover Small Yellow Transit Case from the assigned search area in Pripyat. Deliver it to"
				.. " the assigned cache using Field work, then return here.",
			requires = {"LE19"},
			briefing = "Complete the return leg from a Pripyat cache.",
			completion = "I'll record that as returned.",
			field = {
				kind = "deadDrop",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_case",
				label = "The Return Consignment - Small Yellow Transit Case",
			},
			benefits = {},
			stock = {
				item = "drink_bottlewater",
				bonus = 2,
			},
		},
		{
			id = "LE21",
			completionCash = 1775,
			name = "The Next Shipment",
			kind = "delivery",
			requires = {"LE20"},
			briefing = "Deliver the listed supplies here. I'll record the quantity when it arrives.",
			completion = "That matches the list.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 6,
				},
			},
			benefits = {},
		},
		{
			id = "LE22",
			completionCash = 2450,
			name = "The Last Receipt",
			kind = "field",
			objective = "Recover Warehouse Packing List B from the assigned search area in Waystation. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"LE21"},
			briefing = (
				"Recover the route's final receipt and return to Waystation. Bring the receipt back here. An "
				.. "account is easier to close when I can read the last entry myself instead of collecting versions "
				.. "of it."
			),
			completion = (
				"Set it with the freight records. I'll put it with the rest and check the sequence. You've spared "
				.. "me a good many uncertain entries. That may sound like a modest compliment. From this side of the "
				.. "desk, it isn't."
			),
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_receipt",
				label = "The Last Receipt - Warehouse Packing List B",
			},
			benefits = {},
			recognition = "Ledger's trusted contact",
		},
	},
})
