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
				"I need the records on this list delivered here. Labels, accounts, and the paperwork around "
				.. "a shipment are only useful if they survive long enough to be read. Bring the requested "
				.. "materials and I'll put them to work."
			),
			completion = (
				"Thank you. I'll enter the delivery while it's here. That gives us an account at both ends, "
				.. "and one less thing to reconstruct from memory."
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
			name = "The Missing Receipt",
			kind = "field",
			objective = (
				"Recover the Waystation freight receipt from the assigned search area in Waystation. Bring it back "
				.. "to the issuing contact in Waystation."
			),
			requires = {"LE02"},
			briefing = (
				"I need the receipt from the freight cache. The sender remembers dispatching it very clearly; the "
				.. "other end would like something in writing. Recover the Waystation freight receipt from the "
				.. "assigned search area in Waystation. Bring it back to me in Waystation."
			),
			completion = "Leave it here. I'll match the entry before notifying anyone.",
			field = {
				description = (
					"A clipboard carrying a densely printed packing list and a stamped mark. Ledger's note: \"I need "
					.. "the receipt from the freight cache.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_receipt",
				label = "Waystation freight receipt",
			},
			benefits = {},
		},
		{
			id = "LE05",
			completionCash = 575,
			name = "Stock for the Road",
			kind = "delivery",
			requires = {"LE03"},
			briefing = "The listed provisions are needed here. Leave enough of your own for the return journey.",
			completion = "Delivery received. I'll keep this lot with the freight supplies.",
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
			name = "The Interrupted Connection",
			kind = "field",
			objective = (
				"Recover the interrupted-route case for Cleaner from the assigned search area in Garbage. Deliver "
				.. "it to 'Cleaner' in Garbage, then come back to the issuing contact in Waystation."
			),
			requires = {"LE06"},
			briefing = (
				"Cleaner needs the case from the interrupted connection. Keep it sealed; he asked for the "
				.. "delivery, not a courier's inventory. Recover the interrupted-route case for Cleaner from the "
				.. "assigned search area in Garbage. Deliver it to 'Cleaner' in Garbage, then come back to me in "
				.. "Waystation."
			),
			completion = "He has it. That settles your part of the movement.",
			field = {
				description = (
					"A low hard case with long contrasting strips across its ribbed lid. Ledger's note: \"Cleaner "
					.. "needs the case from the interrupted connection.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_equipment",
				label = "Interrupted-route case for Cleaner",
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
			briefing = (
				"There is another document order. Please resist sorting it into a more convincing account on the "
				.. "road."
			),
			completion = "Good. I can check the original bundle now.",
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
			name = "The Missing Dispatcher",
			kind = "field",
			objective = (
				"Recover the missing dispatcher's recording from the assigned search area in Waystation. Bring it "
				.. "back to the issuing contact in Waystation."
			),
			requires = {"LE10"},
			briefing = (
				"The dispatcher's recorder needs recovering. I'm interested in the whole account, not just the "
				.. "last destination mentioned. Recover the missing dispatcher's recording from the assigned search "
				.. "area in Waystation. Bring it back to me in Waystation."
			),
			completion = "Thank you. I'll listen before updating the route record.",
			field = {
				description = (
					"A pale audio cassette with a handwritten dedication above the spool windows. Ledger's note: \"The "
					.. "dispatcher's recorder needs recovering.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_tape",
				label = "Missing dispatcher's recording",
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
			briefing = "The listed provisions are needed here. Leave enough of your own for the return journey.",
			completion = "Delivery received. I'll keep this lot with the freight supplies.",
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
			name = "The Unmanned Pripyat Cache",
			kind = "field",
			objective = (
				"Collect the Pripyat cache consignment at the assigned pickup in Pripyat and deliver it to the "
				.. "assigned cache. Come back to the issuing contact in Waystation."
			),
			requires = {"LE14"},
			briefing = (
				"This consignment uses a Pripyat cache. Make your preparations before accepting; the destination "
				.. "will not become nearer because somebody is waiting. Collect the Pripyat cache consignment at the "
				.. "assigned pickup in Pripyat and deliver it to the assigned cache. Come back to me in Waystation."
			),
			completion = "Delivery recorded. Thank you for coming back to finish the account.",
			field = {
				description = (
					"A dark reinforced case covered in pale symbols and contrasting trim. Ledger's note: \"This "
					.. "consignment uses a Pripyat cache.\""
				),
				kind = "deadDrop",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_research",
				label = "Pripyat cache consignment",
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
				"There is another document order. Please resist sorting it into a more convincing account on the "
				.. "road."
			),
			completion = "Good. I can check the original bundle now.",
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
			name = "The Return Consignment",
			kind = "field",
			objective = (
				"Collect the return circuit parcel at the assigned pickup in Pripyat and deliver it to the "
				.. "assigned cache. Come back to the issuing contact in Waystation."
			),
			requires = {"LE19"},
			briefing = (
				"There is a return circuit to complete through the assigned drops. Please read the direction of "
				.. "travel rather than assuming it from the title. Collect the return circuit parcel at the assigned "
				.. "pickup in Pripyat and deliver it to the assigned cache. Come back to me in Waystation."
			),
			completion = "Return delivery complete. Both the movement and your return are accounted for.",
			field = {
				description = (
					"A small yellow hard case with ribbed corners and a large label on its lid. Ledger's note: \"There "
					.. "is a return circuit to complete through the assigned drops.\""
				),
				kind = "deadDrop",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_case",
				label = "Return circuit parcel",
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
				"Bring the supplies on this request. If something is missing, leave it missing rather than "
				.. "guessing a substitute."
			),
			completion = "All listed supplies received. Thank you for keeping the account straightforward.",
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
