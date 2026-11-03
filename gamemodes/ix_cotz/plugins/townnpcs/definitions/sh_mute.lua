PLUGIN:Register("mute", {
	name = "'Mute'",
	template = "stalkernetnpc",
	map = "rp_marsh_cs",
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
	supplies = {"drink_bottlewater", "medic_bandage_1", "drink_bottlewaterdirty", },
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
		},
	},
	dialogue = {
		completedGreeting = (
			"** He looks up from the bench as you approach. He clears a space for your things, then "
			.. "waits with his hands resting beside his tools. **"
		),
		workPrompt = "About the component order.",
		offerPrompt = "May I see a delivery request?",
		work = (
			"** He lays a component list beside a clean tray. An example part is turned so the contacts face "
			.. "you. He taps the list, then clears a place for the return. **"
		),
		progressionPrompt = "May I see the field orders?",
		progression = (
			"** He separates the supply requests from the field orders. The latter stay under his hand a moment "
			.. "longer. Then he turns them towards you, with the destinations and return instructions "
			.. "unobstructed. **"
		),
	},
	-- Author-disabled suggestions must not be restored by catalogue or stock generation.
	disabledItems = {
		["pda"] = true,
		["quest_flashdrive"] = true,
	},
	catalogue = {
		["food_raisins"] = {step = "MU01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_can_beans"] = {step = "MU01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drug_caffeine"] = {step = "MU01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_bottletea"] = {step = "MU01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["pda"] = {step = "MU01",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		-- ["quest_flashdrive"] = {step = "MU01",
		-- 	terms = {nil, 1, "SELLANDBUY", 1, 3, 1}},
		["value_9vbattery"] = {step = "MU05",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["value_capacitors"] = {step = "MU02",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["value_radio_repeater"] = {step = "MU07",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["value_tape_electric"] = {step = "MU04",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
	},
	progression = {
		{
			id = "MU01",
			completionCash = 275,
			name = "A Loose Connection",
			kind = "delivery",
			requires = {},
			briefing = (
				"** He lays a supply list beside the equipment and underlines every entry before sliding it "
				.. "towards you. **"
			),
			completion = "** He checks the delivery against the list, makes a small mark, and nods. **",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
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
			id = "MU02",
			completionCash = 450,
			name = "The Silent Repeater",
			kind = "field",
			objective = (
				"Recover the repeater controller from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"MU01"},
			briefing = (
				"** He sets a disconnected plug beside the order, traces its contacts with the tip of his pen, and "
				.. "circles the search instruction. ** ** The written order reads: Recover the repeater controller "
				.. "from the assigned search area in Marsh. Bring it back to the bench in Marsh. **"
			),
			completion = (
				"** He holds the recovered unit beside the plug. The pen stops tapping. He clears a space on the "
				.. "bench. **"
			),
			field = {
				description = (
					"A finned grey control box with a red stripe and several round front connectors. Mute has marked "
					.. "the accompanying order \"repeater controller\"."
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_control",
				label = "repeater controller",
			},
			benefits = {},
		},
		{
			id = "MU03",
			stock = {item = "drink_bottlewaterdirty", bonus = 1},
			completionCash = 0,
			name = "Signals Getting Through",
			kind = "tracker",
			requires = {"MU02"},
			briefing = (
				"** He turns the electronics delivery tally towards you and places the current request beside it. "
				.. "**"
			),
			completion = "** He enters the completed deliveries and draws a short line beneath them. **",
			target = 2,
			benefits = {},
		},
		{
			id = "MU04",
			completionCash = 650,
			name = "A small delivery",
			kind = "delivery",
			retiredCommission = true,
			objective = "Bring all 1 listed item type to this contact. The request shows each selected item and required units.",
			requires = {"MU02"},
			briefing = (
				"** He lays a supply list beside the equipment and underlines every entry before sliding it "
				.. "towards you. **"
			),
			completion = "** He checks the delivery against the list, makes a small mark, and nods. **",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "MU05",
			completionCash = 575,
			name = "A Clearer Picture",
			kind = "delivery",
			requires = {"MU03"},
			briefing = (
				"** He lays a supply list beside the equipment and underlines every entry before sliding it "
				.. "towards you. **"
			),
			completion = "** He checks the delivery against the list, makes a small mark, and nods. **",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "MU06",
			completionCash = 850,
			name = "A Line Through the Marsh",
			kind = "field",
			objective = (
				"Recover the Marsh connection record from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"MU04"},
			briefing = (
				"** He follows a line across the network sketch, stops at an unfinished section, and places the "
				.. "order beside his finger. ** ** The written order reads: Recover the Marsh connection record from "
				.. "the assigned search area in Marsh. Bring it back to the bench in Marsh. **"
			),
			completion = "** He puts the recovered record beside the sketch. After a moment, he shifts the lamp closer. **",
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. Mute has marked "
					.. "the accompanying order \"Marsh connection record\"."
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_module",
				label = "Marsh connection record",
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
			briefing = (
				"** He opens the components drawer, checks the list, and rests the pen beside the delivery tally. "
				.. "**"
			),
			completion = "** He checks the tally against the drawer labels, then nods. **",
			target = 5,
			benefits = {},
		},
		{
			id = "MU08",
			stock = {item = "medic_bandage_1", bonus = 1},
			completionCash = 1050,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"MU06"},
			briefing = (
				"** He lays a supply list beside the equipment and underlines every entry before sliding it "
				.. "towards you. **"
			),
			completion = "** He checks the delivery against the list, makes a small mark, and nods. **",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "MU09",
			completionCash = 875,
			name = "Noisy Components",
			kind = "delivery",
			requires = {"MU07"},
			briefing = (
				"** He lays a supply list beside the equipment and underlines every entry before sliding it "
				.. "towards you. **"
			),
			completion = "** He checks the delivery against the list, makes a small mark, and nods. **",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "MU10",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on repeater identification; author actionable guidance tied "
						.. "to verified mechanics and locations."
					),
					id = "mute/MU10/future",
					kind = "information",
					name = "Record: repeater identification",
					provider = "mute",
					status = "unimplemented",
					topic = "repeater identification",
				},
			},
			completionCash = 1250,
			name = "The Duplicate Message",
			kind = "field",
			objective = (
				"Recover the duplicate-message recording from the assigned search area in Marsh. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"MU08"},
			briefing = (
				"** He places two short notes side by side. Their headings match. He turns over the field order "
				.. "and taps the recovery instruction. ** ** The written order reads: Recover the duplicate-message "
				.. "recording from the assigned search area in Marsh. Bring it back to the bench in Marsh. **"
			),
			completion = "** He lays the recording between the two notes. He does not cross either out. **",
			field = {
				description = (
					"A pale optical disc with a handwritten numeral beside the centre hole. Mute has marked the "
					.. "accompanying order \"Duplicate-message recording\"."
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_disc",
				label = "Duplicate-message recording",
			},
		},
		{
			id = "MU11",
			stock = {item = "drink_bottletea", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on coverage gap register; author actionable guidance tied to "
						.. "verified mechanics and locations."
					),
					id = "mute/MU11/future",
					kind = "information",
					name = "Record: coverage gap register",
					provider = "mute",
					status = "unimplemented",
					topic = "coverage gap register",
				},
			},
			completionCash = 0,
			name = "A Stable Link",
			kind = "tracker",
			requires = {"MU09"},
			briefing = (
				"** He sets the supply requests apart from the recovery orders and turns the delivery tally "
				.. "towards you. **"
			),
			completion = "** He adds the completed deliveries. The tally stays open beside the work. **",
			target = 9,
		},
		{
			id = "MU12",
			stock = {item = "drug_caffeine", bonus = 1},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on message authentication; author actionable guidance tied to "
						.. "verified mechanics and locations."
					),
					id = "mute/MU12/future",
					kind = "information",
					name = "Record: message authentication",
					provider = "mute",
					status = "unimplemented",
					topic = "message authentication",
				},
			},
			completionCash = 1450,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"MU10"},
			briefing = (
				"** He lays a supply list beside the equipment and underlines every entry before sliding it "
				.. "towards you. **"
			),
			completion = "** He checks the delivery against the list, makes a small mark, and nods. **",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_marsh_2",
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
			id = "MU13",
			stock = {item = "food_can_beans", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on lost operator records; author actionable guidance tied to "
						.. "verified mechanics and locations."
					),
					id = "mute/MU13/future",
					kind = "information",
					name = "Record: lost operator records",
					provider = "mute",
					status = "unimplemented",
					topic = "lost operator records",
				},
			},
			completionCash = 1175,
			name = "Looking Further",
			kind = "delivery",
			requires = {"MU11"},
			briefing = (
				"** He lays a supply list beside the equipment and underlines every entry before sliding it "
				.. "towards you. **"
			),
			completion = "** He checks the delivery against the list, makes a small mark, and nods. **",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_electronics_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_marsh_3",
					quantity = 1,
				},
			},
		},
		{
			id = "MU14",
			stock = {item = "food_raisins", bonus = 1},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on battery budgeting; author actionable guidance tied to "
						.. "verified mechanics and locations."
					),
					id = "mute/MU14/future",
					kind = "information",
					name = "Record: battery budgeting",
					provider = "mute",
					status = "unimplemented",
					topic = "battery budgeting",
				},
			},
			completionCash = 1650,
			name = "The Second Copy",
			kind = "field",
			objective = (
				"Recover the second data copy for Spool from the assigned search area in Waystation. Deliver it to "
				.. "'Spool' in Garbage, then come back to the issuing contact in Marsh."
			),
			requires = {"MU12"},
			briefing = (
				"** He marks the disc on the order, writes Spool's name below it, and underlines the instruction "
				.. "to return here afterwards. ** ** The written order reads: Recover the second data copy for Spool "
				.. "from the assigned search area in Waystation. Deliver it to 'Spool' in Garbage, then come back to "
				.. "the bench in Marsh. **"
			),
			completion = "** He files the delivery slip, then takes out the earlier note and puts them together. **",
			field = {
				description = (
					"A pale optical disc with a handwritten numeral beside the centre hole. Mute has marked the "
					.. "accompanying order \"Second data copy for Spool\"."
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_disc",
				label = "Second data copy for Spool",
				recipient = "spool",
			},
		},
		{
			id = "MU15",
			completionCash = 0,
			name = "Beyond Local Range",
			kind = "tracker",
			requires = {"MU13"},
			briefing = "** He checks the supply tally, uncaps his pen, and leaves a clear space for the next entries. **",
			completion = "** He finishes the entries, closes the pen, and shifts the list out of the loose components. **",
			target = 14,
			benefits = {},
		},
		{
			id = "MU16",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on interference signatures; author actionable guidance tied "
						.. "to verified mechanics and locations."
					),
					id = "mute/MU16/future",
					kind = "information",
					name = "Record: interference signatures",
					provider = "mute",
					status = "unimplemented",
					topic = "interference signatures",
				},
			},
			completionCash = 1850,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"MU14"},
			briefing = (
				"** He lays a supply list beside the equipment and underlines every entry before sliding it "
				.. "towards you. **"
			),
			completion = "** He checks the delivery against the list, makes a small mark, and nods. **",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_electronics_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_marsh_3",
					quantity = 1,
				},
			},
		},
		{
			id = "MU17",
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on relay outage reports; author actionable guidance tied to "
						.. "verified mechanics and locations."
					),
					id = "mute/MU17/future",
					kind = "information",
					name = "Record: relay outage reports",
					provider = "mute",
					status = "unimplemented",
					topic = "relay outage reports",
				},
			},
			completionCash = 1475,
			name = "The Final Lens",
			kind = "delivery",
			requires = {"MU15"},
			briefing = (
				"** He lays a supply list beside the equipment and underlines every entry before sliding it "
				.. "towards you. **"
			),
			completion = "** He checks the delivery against the list, makes a small mark, and nods. **",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_electronics_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_marsh_3",
					quantity = 1,
				},
			},
		},
		{
			id = "MU18",
			stock = {item = "drink_bottlewaterdirty", bonus = 2},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on emergency signal protocol; author actionable guidance tied "
						.. "to verified mechanics and locations."
					),
					id = "mute/MU18/future",
					kind = "information",
					name = "Record: emergency signal protocol",
					provider = "mute",
					status = "unimplemented",
					topic = "emergency signal protocol",
				},
			},
			completionCash = 2050,
			name = "The Old Routing Table",
			kind = "field",
			objective = (
				"Recover the routing archive for Carbon from the assigned search area in Pripyat. Deliver it to "
				.. "'Carbon' in Waystation, then come back to the issuing contact in Marsh."
			),
			requires = {"MU16"},
			briefing = (
				"** He marks Carbon's name on the folder order. A small arrow leads back to the bench. He waits "
				.. "until the page is facing you before letting it go. ** ** The written order reads: Recover the "
				.. "routing archive for Carbon from the assigned search area in Pripyat. Deliver it to 'Carbon' in "
				.. "Waystation, then come back to the bench in Marsh. **"
			),
			completion = "** He reads the delivery slip twice, then stores it beneath the routing sketch. **",
			field = {
				description = (
					"A blue records folder with contrasting corporate lettering along the cover. Mute has marked the "
					.. "accompanying order \"Routing archive for Carbon\"."
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_archive",
				label = "Routing archive for Carbon",
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
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on regional network comparison; author actionable guidance "
						.. "tied to verified mechanics and locations."
					),
					id = "mute/MU19/future",
					kind = "information",
					name = "Record: regional network comparison",
					provider = "mute",
					status = "unimplemented",
					topic = "regional network comparison",
				},
			},
			completionCash = 0,
			name = "No Lost Packets",
			kind = "tracker",
			requires = {"MU17"},
			briefing = (
				"** He lays the current component request beside the growing tally. He waits while the page faces "
				.. "you. **"
			),
			completion = "** He checks the entries twice, then clears a place for the next delivery. **",
			target = 20,
		},
		{
			id = "MU20",
			stock = {item = "drink_bottletea", bonus = 2},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on intrusion incident records; author actionable guidance "
						.. "tied to verified mechanics and locations."
					),
					id = "mute/MU20/future",
					kind = "information",
					name = "Record: intrusion incident records",
					provider = "mute",
					status = "unimplemented",
					topic = "intrusion incident records",
				},
			},
			completionCash = 2250,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"MU18"},
			briefing = (
				"** He lays a supply list beside the equipment and underlines every entry before sliding it "
				.. "towards you. **"
			),
			completion = "** He checks the delivery against the list, makes a small mark, and nods. **",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_electronics_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_marsh_3",
					quantity = 1,
				},
			},
		},
		{
			id = "MU21",
			stock = {item = "drug_caffeine", bonus = 2},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on Pripyat signal notes; author actionable guidance tied to "
						.. "verified mechanics and locations."
					),
					id = "mute/MU21/future",
					kind = "information",
					name = "Record: Pripyat signal notes",
					provider = "mute",
					status = "unimplemented",
					topic = "Pripyat signal notes",
				},
			},
			completionCash = 1775,
			name = "Parts for a Clean Link",
			kind = "delivery",
			requires = {"MU19", "MU20"},
			briefing = (
				"** He lays a supply list beside the equipment and underlines every entry before sliding it "
				.. "towards you. **"
			),
			completion = "** He checks the delivery against the list, makes a small mark, and nods. **",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_electronics_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_electronics_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_marsh_4",
					quantity = 1,
				},
			},
		},
		{
			id = "MU22",
			stock = {item = "food_can_beans", bonus = 2},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on operator handover procedure; author actionable guidance "
						.. "tied to verified mechanics and locations."
					),
					id = "mute/MU22/future",
					kind = "information",
					name = "Record: operator handover procedure",
					provider = "mute",
					status = "unimplemented",
					topic = "operator handover procedure",
				},
			},
			completionCash = 2450,
			name = "The Broken Handshake",
			kind = "field",
			objective = (
				"Take the required bearings in Pripyat, locate the source, and collect the failed connection "
				.. "controller. Bring it back to the issuing contact in Marsh."
			),
			requires = {"MU21"},
			briefing = (
				"** He brings two disconnected leads together without joining them, lays them down, and turns the "
				.. "recovery order towards you. ** ** The written order reads: Take the required bearings in Pripyat, "
				.. "locate the source, and collect the failed connection controller. Bring it back to the bench in "
				.. "Marsh. **"
			),
			completion = (
				"** He examines the recovered contacts. One lead is moved aside; the other stays beside the unit. "
				.. "**"
			),
			field = {
				description = (
					"A finned grey control box with a red stripe and several round front connectors. Mute has marked "
					.. "the accompanying order \"Failed connection controller\"."
				),
				kind = "triangulation",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_control",
				label = "Failed connection controller",
			},
		},
		{
			id = "MU23",
			stock = {item = "food_raisins", bonus = 2},
			benefits = {},
			plannedUnlocks = {
				-- TODO: Implement information consumer; verify these proposed terms before enabling.
				{
					effect = (
						"Persistent reference on offline network recovery; author actionable guidance tied "
						.. "to verified mechanics and locations."
					),
					id = "mute/MU23/future",
					kind = "information",
					name = "Record: offline network recovery",
					provider = "mute",
					status = "unimplemented",
					topic = "offline network recovery",
				},
			},
			completionCash = 0,
			name = "Message Received",
			kind = "tracker",
			requires = {"MU22"},
			briefing = (
				"** He turns the component ledger to its marked page and lays the request across the lower edge. "
				.. "**"
			),
			completion = (
				"** He closes the ledger after entering the returns. He leaves it beside the receiver rather than "
				.. "putting it away. **"
			),
			target = 27,
		},
		{
			id = "MU24",
			stock = {item = "medic_bandage_1", bonus = 2},
			completionCash = 2650,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"MU23"},
			briefing = (
				"** He lays a supply list beside the equipment and underlines every entry before sliding it "
				.. "towards you. **"
			),
			completion = "** He checks the delivery against the list, makes a small mark, and nods. **",
			requirements = {
				{
					pool = "town_delivery_electronics_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_electronics_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_electronics_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_electronics_marsh_4",
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
			recognition = "Mute's trusted contact",
		},
	},
})
