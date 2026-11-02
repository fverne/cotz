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
	rewards = {
		packages = {
			{label = "Short route",
				items = {"food_raisins", "drink_bottlewater"}},
			{label = "Long haul",
				items = {"food_can_tushonka", "food_can_beans"}},
			{label = "Emergency stop",
				items = {"medic_bandage_1", "lowtiercookerfuel"}},
		},
	},
	dialogue = {
		delivery = "The parcel first. Then I can close the entry.",
		completedGreeting = (
			"Good to see you. Your work has saved me a number of difficult enquiries. What can I help "
			.. "you with today?"
		),
		workPrompt = "About the freight circuit I'm carrying.",
		offerPrompt = "Do you have a freight circuit?",
		work = (
			"Collect the sealed parcel at the assigned pickup, deliver it to the assigned cache, then return. "
			.. "Both ends matter. Check them before collecting. I'd rather answer a question here than record "
			.. "another delivery nobody can agree has arrived. You can take time to prepare without making the "
			.. "destination uncertain."
		),
		progressionPrompt = "What needs doing in the dispatch records?",
		progression = (
			"There are freight records missing and circuits that need completing. I want each movement settled "
			.. "against an actual return, not a plausible explanation from the nearest person. Some papers need "
			.. "another contact's inspection; their destination is on the order. Come back after the handover. I "
			.. "still need to close this end of the account."
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
				"I need supplies for the dispatch work. Have a look at the request before you load up; it saves "
				.. "both ends a second journey. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thank you. I will check these into the account before the next request arrives.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
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
			objective = (
				"Collect the first sealed freight parcel at the assigned pickup in Waystation and deliver it to "
				.. "the assigned cache. Come back to the issuing contact in Waystation."
			),
			requires = {"LE01"},
			briefing = (
				"A parcel needs moving between the assigned drops. Check both destinations before you take the "
				.. "load; collection is only half the journey. Collect the first sealed freight parcel at the "
				.. "assigned pickup in Waystation and deliver it to the assigned cache. Come back to me in "
				.. "Waystation."
			),
			completion = (
				"Delivery complete. Thank you. I can close that movement rather than carrying it into tomorrow's "
				.. "enquiries."
			),
			field = {
				description = (
					"A small yellow hard case with ribbed corners and a large label on its lid. Ledger's note: \"A "
					.. "parcel needs moving between the assigned drops.\""
				),
				kind = "deadDrop",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_case",
				label = "First sealed freight parcel",
			},
			benefits = {},
		},
		{
			id = "LE03",
			completionCash = 0,
			name = "Delivered Intact",
			kind = "tracker",
			requires = {"LE02"},
			briefing = "Complete the assigned dead-drop circuits. The receiving endpoint matters as much as collection.",
			completion = "A few complete movements. Thank you for finishing both ends.",
			target = 2,
			benefits = {},
		},
		{
			id = "LE04",
			completionCash = 650,
			name = "A small delivery",
			kind = "delivery",
			retiredCommission = true,
			objective = "Bring all 1 listed item type to this contact. The request shows each selected item and required units.",
			requires = {"LE02"},
			briefing = (
				"I need supplies for the dispatch work. Have a look at the request before you load up; it saves "
				.. "both ends a second journey. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thank you. I will check these into the account before the next request arrives.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "LE05",
			completionCash = 575,
			name = "Stock for the Road",
			kind = "delivery",
			requires = {"LE03"},
			briefing = (
				"I need supplies for the dispatch work. Have a look at the request before you load up; it saves "
				.. "both ends a second journey. Bring everything on the list back here; I need the full delivery."
			),
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
			benefits = {},
		},
		{
			id = "LE06",
			completionCash = 850,
			name = "Ballast's Landing Copy",
			kind = "field",
			objective = (
				"Recover the landing manifest for Ballast from the assigned search area in Marsh. Deliver it to "
				.. "'Ballast' in Marsh, then come back to the issuing contact in Waystation."
			),
			requires = {"LE04"},
			briefing = (
				"Ballast needs the landing copy. He can check what was actually handled against the freight "
				.. "record. Recover the landing manifest for Ballast from the assigned search area in Marsh. Deliver "
				.. "it to 'Ballast' in Marsh, then come back to me in Waystation."
			),
			completion = "Delivered. Thank you. He should be able to answer from the page now.",
			field = {
				description = (
					"A printed packing list on a small clipboard with a metal clip and a circular stamp. Ledger's "
					.. "note: \"Ballast needs the landing copy.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_manifest",
				label = "Landing manifest for Ballast",
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
			briefing = "Continue the freight circuits. Read the delivery endpoint before taking the parcel.",
			completion = "Another reliable run. There are fewer open lines waiting on an arrival.",
			target = 5,
			benefits = {},
		},
		{
			id = "LE08",
			completionCash = 1050,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"LE06"},
			briefing = (
				"I need supplies for the dispatch work. Have a look at the request before you load up; it saves "
				.. "both ends a second journey. Bring everything on the list back here; I need the full delivery."
			),
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
			benefits = {},
		},
		{
			id = "LE09",
			completionCash = 875,
			name = "Paperwork That Matches",
			kind = "delivery",
			requires = {"LE07"},
			briefing = (
				"I need supplies for the dispatch work. Have a look at the request before you load up; it saves "
				.. "both ends a second journey. Bring everything on the list back here; I need the full delivery."
			),
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
			benefits = {},
		},
		{
			id = "LE10",
			completionCash = 1250,
			name = "The Duplicate Destination",
			kind = "field",
			objective = (
				"Recover the conflicting destination records from the assigned search area in Waystation. Bring it "
				.. "back to the issuing contact in Waystation."
			),
			requires = {"LE08"},
			briefing = (
				"Bring the destination record back intact. I'd like to examine the accounts before deciding which "
				.. "instruction was misunderstood. Recover the conflicting destination records from the assigned "
				.. "search area in Waystation. Bring it back to me in Waystation."
			),
			completion = "Good. I'll retain the competing entries while I check them.",
			field = {
				description = (
					"A cardboard file folder with a small coloured crest on its cover. Ledger's note: \"Bring the "
					.. "destination record back intact.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_official",
				label = "Conflicting destination records",
			},
			benefits = {},
		},
		{
			id = "LE11",
			completionCash = 0,
			name = "More Than Local",
			kind = "tracker",
			requires = {"LE09"},
			briefing = "More completed circuit deliveries when you're prepared.",
			completion = "You've kept the movements accounted for. That helps the next person plan.",
			target = 9,
			benefits = {},
		},
		{
			id = "LE12",
			completionCash = 1450,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"LE10"},
			briefing = (
				"I need supplies for the dispatch work. Have a look at the request before you load up; it saves "
				.. "both ends a second journey. Bring everything on the list back here; I need the full delivery."
			),
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
			briefing = (
				"I need supplies for the dispatch work. Have a look at the request before you load up; it saves "
				.. "both ends a second journey. Bring everything on the list back here; I need the full delivery."
			),
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
			benefits = {},
		},
		{
			id = "LE14",
			completionCash = 1650,
			name = "The Last Scheduled Drop",
			kind = "field",
			objective = (
				"Collect the scheduled remote-drop parcel at the assigned pickup in Waystation and deliver it to "
				.. "the assigned cache. Come back to the issuing contact in Waystation."
			),
			requires = {"LE12"},
			briefing = (
				"The next parcel goes between the assigned cache points. Check the return instruction as well; I "
				.. "want to know the movement is finished. Collect the scheduled remote-drop parcel at the assigned "
				.. "pickup in Waystation and deliver it to the assigned cache. Come back to me in Waystation."
			),
			completion = "Delivered. I can stop keeping that line open for a possible arrival.",
			field = {
				description = (
					"A compact hard case with orange panels, dark protective ribs and a carrying handle. Ledger's "
					.. "note: \"The next parcel goes between the assigned cache points.\""
				),
				kind = "deadDrop",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_evidence",
				label = "Scheduled remote-drop parcel",
			},
			benefits = {},
		},
		{
			id = "LE15",
			completionCash = 0,
			name = "A Dependable Circuit",
			kind = "tracker",
			requires = {"LE13"},
			briefing = "Keep the freight circuits going while I examine the dispatch records.",
			completion = "A substantial amount delivered. I haven't had to replace your returns with estimates.",
			target = 14,
			benefits = {},
		},
		{
			id = "LE16",
			completionCash = 1850,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"LE14"},
			briefing = (
				"I need supplies for the dispatch work. Have a look at the request before you load up; it saves "
				.. "both ends a second journey. Bring everything on the list back here; I need the full delivery."
			),
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
			benefits = {},
		},
		{
			id = "LE17",
			completionCash = 1475,
			name = "Proof on Paper",
			kind = "delivery",
			requires = {"LE15"},
			briefing = (
				"I need supplies for the dispatch work. Have a look at the request before you load up; it saves "
				.. "both ends a second journey. Bring everything on the list back here; I need the full delivery."
			),
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
			benefits = {},
		},
		{
			id = "LE18",
			completionCash = 2050,
			name = "The Dispatcher's Detour",
			kind = "field",
			objective = (
				"Recover the dispatcher's detour recording from the assigned search area in Pripyat. Bring it back "
				.. "to the issuing contact in Waystation."
			),
			requires = {"LE16"},
			briefing = (
				"I'd like the later dispatcher recording recovered. A changed route deserves more than a guess "
				.. "about why they took it. Recover the dispatcher's detour recording from the assigned search area "
				.. "in Pripyat. Bring it back to me in Waystation."
			),
			completion = "I'll put it beside the earlier account before trying to reconcile the detour.",
			field = {
				description = (
					"A pale audio cassette with a handwritten dedication above the spool windows. Ledger's note: \"I'd "
					.. "like the later dispatcher recording recovered.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_tape",
				label = "Dispatcher's detour recording",
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
			briefing = "Continue the assigned circuit deliveries. Check the route even when the title is familiar.",
			completion = "You've stayed dependable across the account. I appreciate that.",
			target = 20,
			benefits = {},
		},
		{
			id = "LE20",
			completionCash = 2250,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"LE19"},
			briefing = (
				"I need supplies for the dispatch work. Have a look at the request before you load up; it saves "
				.. "both ends a second journey. Bring everything on the list back here; I need the full delivery."
			),
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
			briefing = (
				"I need supplies for the dispatch work. Have a look at the request before you load up; it saves "
				.. "both ends a second journey. Bring everything on the list back here; I need the full delivery."
			),
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
			benefits = {},
		},
		{
			id = "LE22",
			completionCash = 2450,
			name = "The Last Receipt",
			kind = "field",
			objective = (
				"Recover the final route receipt from the assigned search area in Waystation. Bring it back to the "
				.. "issuing contact in Waystation."
			),
			requires = {"LE21"},
			briefing = (
				"Bring the route's final receipt back here. I'd like to read the closing entry myself instead of "
				.. "collecting versions of it. Recover the final route receipt from the assigned search area in "
				.. "Waystation. Bring it back to me in Waystation."
			),
			completion = (
				"That's the last receipt. You've spared several people some long waits and me a considerable "
				.. "number of enquiries. I appreciate the reliability. For once, we can have a conversation without a "
				.. "parcel between us."
			),
			field = {
				description = (
					"A clipboard carrying a densely printed packing list and a stamped mark. Ledger's note: \"Bring "
					.. "the route's final receipt back here.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_receipt",
				label = "Final route receipt",
			},
			benefits = {},
			recognition = "Ledger's trusted contact",
		},
	},
})
