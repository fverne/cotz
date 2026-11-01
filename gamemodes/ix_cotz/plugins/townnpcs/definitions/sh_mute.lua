PLUGIN:Register("mute", {
	name = "'Mute'",
	template = "stalkernetnpc",
	map = "rp_marsh_cs",
	access = {contact = "old-timer", step = "OT19"},
	job = {
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		category = "Electronics deliveries",
		description = "Electronics deliveries",
		pools = {"small_electronics", "batteries", "radio_components"},
		deliveryTiers = {
			easy = {
				pools = {
					"valuables_electronic_components",
					"valuables_portable_power",
				},
				quantity = 1,
			},
			medium = {
				pools = {
					"valuables_radio_components",
					"valuables_radio_equipment",
					"valuables_flash_media",
				},
				quantity = 1,
			},
			hard = {
				pools = {
					"valuables_computer_parts",
					"valuables_portable_computers",
					"valuables_control_electronics",
					"valuables_data_archives",
					"valuables_recording_equipment",
				},
				quantity = 2,
			},
		},
		quantities = {2, 4, 7},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Components (trade goods)",
				items = {"value_battery", "value_capacitors", "value_pcpart_ram"}},
			{label = "Night shift",
				items = {"drug_caffeine", "drink_bottletea"}},
			{label = "Field callout",
				items = {"drink_bottlewater", "medic_bandage_1"}},
		},
		bonusItems = {
			"binoculars_2",
			"binoculars_1",
			"binoculars_4",
			"binoculars_3",
		},
	},
	dialogue = {
		completedGreeting = (
			"** He looks up from the bench as you approach. He clears a space for your things, then "
			.. "waits with his hands resting beside his tools. **"
		),
		workPrompt = "Anything on the list?",
		offerPrompt = "Do you have an assignment?",
		work = (
			"** He pushes a list of electronic components towards you. ** ** He places an example component "
			.. "beside the order, points to its contacts, then to the clean tray. **"
		),
		progressionPrompt = "May I see the other lists?",
		progression = (
			"** He lays several unfinished lists beside the receiver, leaving you room to read. ** ** He "
			.. "separates the supply list from the field orders. His hand rests briefly on the latter before he "
			.. "turns them so you can read. **"
		),
	},
	catalogue = {
		["anomalydetector"] = {step = "MU03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["binoculars_1"] = {step = "MU05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["binoculars_2"] = {step = "MU01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["binoculars_3"] = {step = "MU17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["binoculars_4"] = {step = "MU13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["quest_flashdrive"] = {step = "MU01",
			terms = {nil, 1, "SELLANDBUY", 1, 3, 1}},
	},
	progression = {
		{
			id = "MU01",
			completionCash = 275,
			name = "A Loose Connection",
			kind = "delivery",
			requires = {},
			briefing = (
				"** He marks the required supplies on the list and pushes it back towards you. ** ** He "
				.. "clears a space beside the order and slides a loose component out of the way, leaving "
				.. "the list unobstructed. **"
			),
			completion = (
				"** He checks the components and sets them aside. ** ** He aligns the new components "
				.. "neatly, then moves the tray closer to his tools. His shoulders relax a little. **"
			),
			requirements = {
				{
					pool = "small_electronics",
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
			id = "MU02",
			completionCash = 450,
			name = "The Silent Repeater",
			kind = "field",
			objective = "Recover Red-Trimmed Control Unit from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"MU01"},
			briefing = "** He writes \"The Silent Repeater\" on a field order, then marks the place to look. **",
			completion = "** He takes the case without looking up. **",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_control",
				label = "The Silent Repeater - Red-Trimmed Control Unit",
			},
			benefits = {},
		},
		{
			id = "MU03",
			completionCash = 0,
			name = "Signals Getting Through",
			kind = "tracker",
			requires = {"MU02"},
			briefing = "** He pushes a list of electronic components towards you. **",
			completion = "** He checks the delivery tally and underlines it once. **",
			target = 2,
			benefits = {},
		},
		{
			id = "MU04",
			completionCash = 650,
			name = "The Missing Address",
			kind = "field",
			objective = "Recover Tape-Labelled Flash Drive from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"MU02"},
			briefing = "** He writes \"The Missing Address\" on a field order, then marks the place to look. **",
			completion = "** He checks the seal, then draws it closer. **",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_drive",
				label = "The Missing Address - Tape-Labelled Flash Drive",
			},
			benefits = {},
		},
		{
			id = "MU05",
			completionCash = 575,
			name = "A Clearer Picture",
			kind = "delivery",
			requires = {"MU03"},
			briefing = "** He marks the required supplies on the list and pushes it back towards you. **",
			completion = "** He gives a small nod. **",
			requirements = {
				{
					pool = "small_electronics",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "MU06",
			completionCash = 850,
			name = "A Line Through the Marsh",
			kind = "field",
			objective = "Recover Numbered Data Module 0013 from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"MU04"},
			briefing = "** He writes \"A Line Through the Marsh\" on a field order, then marks the place to look. **",
			completion = "** He turns the record over and studies the reverse. **",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_module",
				label = "A Line Through the Marsh - Numbered Data Module 0013",
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
			id = "MU07",
			completionCash = 0,
			name = "Not Just Static",
			kind = "tracker",
			requires = {"MU05"},
			briefing = "** He pushes a list of electronic components towards you. **",
			completion = "** He checks the delivery tally and underlines it once. **",
			target = 5,
			benefits = {},
		},
		{
			id = "MU08",
			completionCash = 1050,
			name = "Spool's Packet",
			kind = "field",
			objective = "Recover Tagged Security Flash Drive from the assigned search area in Garbage. Deliver it to"
				.. " 'Spool' in Garbage, then return here to finish the assignment.",
			requires = {"MU06"},
			briefing = "** He writes \"Spool's Packet\" on a field order, then marks the place to look. **",
			completion = "** He checks the recipient against the dispatch note, then puts a line through the entry. **",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_security",
				label = "Spool's Packet - Tagged Security Flash Drive",
				recipient = "spool",
			},
			benefits = {},
		},
		{
			id = "MU09",
			completionCash = 875,
			name = "Noisy Components",
			kind = "delivery",
			requires = {"MU07"},
			briefing = "** He marks the required supplies on the list and pushes it back towards you. **",
			completion = "** He crosses an entry off the paper. **",
			requirements = {
				{
					pool = "radio_components",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "MU10",
			completionCash = 1250,
			name = "The Duplicate Message",
			kind = "field",
			objective = "Recover Marked Data Disc I from the assigned search area in Marsh. Return it to this contact"
				.. " to finish the assignment.",
			requires = {"MU08"},
			briefing = "** He writes \"The Duplicate Message\" on a field order, then marks the place to look. **",
			completion = "** He checks the seal, then draws it closer. **",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_disc",
				label = "The Duplicate Message - Marked Data Disc I",
			},
			benefits = {},
		},
		{
			id = "MU11",
			completionCash = 0,
			name = "A Stable Link",
			kind = "tracker",
			requires = {"MU09"},
			briefing = "** He pushes a list of electronic components towards you. **",
			completion = "** He checks the delivery tally and underlines it once. **",
			target = 9,
			benefits = {},
		},
		{
			id = "MU12",
			completionCash = 1450,
			name = "The Unlisted Receiver",
			kind = "field",
			objective = "Take the required bearings in Marsh and recover Red-Trimmed Control Unit. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"MU10"},
			briefing = "** He writes \"The Unlisted Receiver\" on a field order, then marks the place to look. **",
			completion = "** He turns the record over and studies the reverse. **",
			field = {
				kind = "triangulation",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_control",
				label = "The Unlisted Receiver - Red-Trimmed Control Unit",
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
			id = "MU13",
			completionCash = 1175,
			name = "Looking Further",
			kind = "delivery",
			requires = {"MU11"},
			briefing = (
				"** He marks the required supplies on the list and pushes it back towards you. ** ** He "
				.. "checks the order again, taps the relevant line, and gives you time to read it without "
				.. "reaching for the paper. **"
			),
			completion = (
				"** He checks the components and sets them aside. ** ** He studies what you brought, "
				.. "then sets it apart from the unfinished work. A brief nod acknowledges you before he "
				.. "resumes checking. **"
			),
			requirements = {
				{
					pool = "small_electronics",
					quantity = 4,
				},
			},
			benefits = {},
		},
		{
			id = "MU14",
			completionCash = 1650,
			name = "The Second Copy",
			kind = "field",
			objective = "Recover Marked Data Disc I from the assigned search area in Waystation. Deliver it to"
				.. " 'Spool' in Garbage, then return here to finish the assignment.",
			requires = {"MU12"},
			briefing = "** He writes \"The Second Copy\" on a field order, then marks the place to look. **",
			completion = "** He checks the recipient against the dispatch note, then puts a line through the entry. **",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_disc",
				label = "The Second Copy - Marked Data Disc I",
				recipient = "spool",
			},
			benefits = {},
		},
		{
			id = "MU15",
			completionCash = 0,
			name = "Beyond Local Range",
			kind = "tracker",
			requires = {"MU13"},
			briefing = "** He pushes a list of electronic components towards you. **",
			completion = "** He checks the delivery tally and underlines it once. **",
			target = 14,
			benefits = {},
		},
		{
			id = "MU16",
			completionCash = 1850,
			name = "A Message With No Sender",
			kind = "field",
			objective = "Recover Handwritten Audio Cassette from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"MU14"},
			briefing = "** He writes \"A Message With No Sender\" on a field order, then marks the place to look. **",
			completion = "** He checks the seal, then draws it closer. **",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_tape",
				label = "A Message With No Sender - Handwritten Audio Cassette",
			},
			benefits = {},
		},
		{
			id = "MU17",
			completionCash = 1475,
			name = "The Final Lens",
			kind = "delivery",
			requires = {"MU15"},
			briefing = "** He marks the required supplies on the list and pushes it back towards you. **",
			completion = "** He gives a small nod. **",
			requirements = {
				{
					pool = "small_electronics",
					quantity = 5,
				},
			},
			benefits = {},
		},
		{
			id = "MU18",
			completionCash = 2050,
			name = "The Old Routing Table",
			kind = "field",
			objective = "Recover Corporate Records Folder from the assigned search area in Pripyat. Deliver it to"
				.. " 'Carbon' in Waystation, then return here to finish the assignment.",
			requires = {"MU16"},
			briefing = "** He writes \"The Old Routing Table\" on a field order, then marks the place to look. **",
			completion = "** He checks the recipient against the dispatch note, then puts a line through the entry. **",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_archive",
				label = "The Old Routing Table - Corporate Records Folder",
				recipient = "carbon",
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
			id = "MU19",
			completionCash = 0,
			name = "No Lost Packets",
			kind = "tracker",
			requires = {"MU17"},
			briefing = "** He pushes a list of electronic components towards you. **",
			completion = "** He checks the delivery tally and underlines it once. **",
			target = 20,
			benefits = {},
		},
		{
			id = "MU20",
			completionCash = 2250,
			name = "Someone on the Line",
			kind = "field",
			objective = "Recover Numbered Data Module 0022 from the assigned search area in Pripyat. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"MU18"},
			briefing = "** He writes \"Someone on the Line\" on a field order, then marks the place to look. **",
			completion = "** He takes the case without looking up. **",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module2",
				label = "Someone on the Line - Numbered Data Module 0022",
			},
			benefits = {},
		},
		{
			id = "MU21",
			completionCash = 1775,
			name = "Parts for a Clean Link",
			kind = "delivery",
			requires = {"MU19", "MU20"},
			briefing = "** He marks the required supplies on the list and pushes it back towards you. **",
			completion = "** He crosses an entry off the paper. **",
			requirements = {
				{
					pool = "radio_components",
					quantity = 6,
				},
			},
			benefits = {},
		},
		{
			id = "MU22",
			completionCash = 2450,
			name = "The Broken Handshake",
			kind = "field",
			objective = "Take the required bearings in Pripyat and recover Red-Trimmed Control Unit. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"MU21"},
			briefing = "** He writes \"The Broken Handshake\" on a field order, then marks the place to look. **",
			completion = "** He checks the seal, then draws it closer. **",
			field = {
				kind = "triangulation",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_control",
				label = "The Broken Handshake - Red-Trimmed Control Unit",
			},
			benefits = {},
		},
		{
			id = "MU23",
			completionCash = 0,
			name = "Message Received",
			kind = "tracker",
			requires = {"MU22"},
			briefing = "** He pushes a list of electronic components towards you. **",
			completion = "** He checks the delivery tally and underlines it once. **",
			target = 27,
			benefits = {},
		},
		{
			id = "MU24",
			completionCash = 2650,
			name = "The Last Address",
			kind = "field",
			objective = "Recover Tagged Security Flash Drive from the assigned search area in Marsh. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"MU23"},
			briefing = (
				"** He writes \"The Last Address\" on a field order, then marks the place to look. ** ** He "
				.. "underlines the return instruction, closes the pen, and waits until you have finished reading "
				.. "before taking his hand away. **"
			),
			completion = (
				"** He turns the record over and studies the reverse. ** ** His thumb pauses on the edge of the "
				.. "drive. He sets it carefully beside the other records, then meets your eyes and gives a slow, "
				.. "deliberate nod. **"
			),
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_security",
				label = "The Last Address - Tagged Security Flash Drive",
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
			recognition = "Mute's trusted contact",
		},
	},
})
