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
				"** He lays the component list beside an empty tray, then moves the tray clear of the loose wires. "
				.. "**"
			),
			completion = "** He checks the delivered components against the list and places them in separate spaces. **",
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
			name = "The Missing Address",
			kind = "field",
			objective = (
				"Recover the missing network address file from the assigned search area in Marsh. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"MU02"},
			briefing = (
				"** He turns a page of addresses towards you. One line is blank. He lays the field order across it "
				.. "and waits. ** ** The written order reads: Recover the missing network address file from the "
				.. "assigned search area in Marsh. Bring it back to the bench in Marsh. **"
			),
			completion = (
				"** He opens the file beside the address sheet, keeping a finger on the blank line while he reads. "
				.. "**"
			),
			field = {
				description = (
					"A dark USB drive with a pale handwritten tape label around its body. Mute has marked the "
					.. "accompanying order \"Missing network address file\"."
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_drive",
				label = "Missing network address file",
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
				"** He holds an example beside the written request, turns it to show the contacts, and points back "
				.. "to the list. **"
			),
			completion = "** He compares the markings, gives a small nod, and draws the tray closer. **",
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
			completionCash = 1050,
			name = "Spool's Packet",
			kind = "field",
			objective = (
				"Recover the network packet for Spool from the assigned search area in Garbage. Deliver it to "
				.. "'Spool' in Garbage, then come back to the issuing contact in Marsh."
			),
			requires = {"MU06"},
			briefing = (
				"** He writes Spool's name on the dispatch slip, then draws an arrow back towards his own bench. "
				.. "He leaves both instructions visible. ** ** The written order reads: Recover the network packet "
				.. "for Spool from the assigned search area in Garbage. Deliver it to 'Spool' in Garbage, then come "
				.. "back to the bench in Marsh. **"
			),
			completion = "** He checks the receipt, sets it beside the unfinished sketch, and nods once. **",
			field = {
				description = (
					"A USB drive with a large rear loop and a handwritten paper label around its body. Mute has "
					.. "marked the accompanying order \"Network packet for Spool\"."
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_security",
				label = "Network packet for Spool",
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
			briefing = (
				"** He puts the requested parts list on top of the other papers, keeping one finger on its "
				.. "heading. **"
			),
			completion = "** He checks the list, then closes the parts drawer gently. **",
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
			benefits = {},
		},
		{
			id = "MU11",
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
			benefits = {},
		},
		{
			id = "MU12",
			completionCash = 1450,
			name = "The Unlisted Receiver",
			kind = "field",
			objective = (
				"Take the required bearings in Marsh, locate the source, and collect the unlisted receiver "
				.. "controller. Bring it back to the issuing contact in Marsh."
			),
			requires = {"MU10"},
			briefing = (
				"** He compares a component list with the field order. The pen hovers over an empty line before he "
				.. "pushes the order towards you. ** ** The written order reads: Take the required bearings in Marsh, "
				.. "locate the source, and collect the unlisted receiver controller. Bring it back to the bench in "
				.. "Marsh. **"
			),
			completion = "** He turns the controller slowly, checking its markings before returning to the list. **",
			field = {
				description = (
					"A finned grey control box with a red stripe and several round front connectors. Mute has marked "
					.. "the accompanying order \"Unlisted receiver controller\"."
				),
				kind = "triangulation",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_control",
				label = "Unlisted receiver controller",
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
			benefits = {},
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
			completionCash = 1850,
			name = "A Message With No Sender",
			kind = "field",
			objective = (
				"Recover the senderless message cassette from the assigned search area in Marsh. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"MU14"},
			briefing = (
				"** He holds a cassette between two fingers, indicates the labelled recording on the order, and "
				.. "clears a place beside the receiver. ** ** The written order reads: Recover the senderless message "
				.. "cassette from the assigned search area in Marsh. Bring it back to the bench in Marsh. **"
			),
			completion = (
				"** He places the recovered cassette in the cleared space. His hand remains on the receiver switch "
				.. "for a moment. **"
			),
			field = {
				description = (
					"A pale audio cassette with a handwritten dedication above the spool windows. Mute has marked the "
					.. "accompanying order \"Senderless message cassette\"."
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_tape",
				label = "Senderless message cassette",
			},
			benefits = {},
		},
		{
			id = "MU17",
			completionCash = 1475,
			name = "The Final Lens",
			kind = "delivery",
			requires = {"MU15"},
			briefing = "** He counts the marked entries on the list, then leaves the page facing you. **",
			completion = "** He crosses the entries out, sets the pen down, and looks up. **",
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
			benefits = {},
		},
		{
			id = "MU20",
			completionCash = 2250,
			name = "Someone on the Line",
			kind = "field",
			objective = (
				"Recover the line receiver recording from the assigned search area in Pripyat. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"MU18"},
			briefing = (
				"** He stops working at the receiver. A fingertip rests on the field order; then he slides it "
				.. "across the bench without looking away from it. ** ** The written order reads: Recover the line "
				.. "receiver recording from the assigned search area in Pripyat. Bring it back to the bench in Marsh. "
				.. "**"
			),
			completion = (
				"** He fits the recording into the space beside the earlier records. He adjusts the lamp, then "
				.. "adjusts it back. **"
			),
			field = {
				description = (
					"A flat dark electronic module marked with a number and three pale bars. Mute has marked the "
					.. "accompanying order \"Line receiver recording\"."
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module2",
				label = "Line receiver recording",
			},
			benefits = {},
		},
		{
			id = "MU21",
			completionCash = 1775,
			name = "Parts for a Clean Link",
			kind = "delivery",
			requires = {"MU19", "MU20"},
			briefing = (
				"** He lays the component list beside an empty tray, then moves the tray clear of the loose wires. "
				.. "**"
			),
			completion = "** He checks the delivered components against the list and places them in separate spaces. **",
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
			benefits = {},
		},
		{
			id = "MU23",
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
			benefits = {},
		},
		{
			id = "MU24",
			completionCash = 2650,
			name = "The Last Address",
			kind = "field",
			objective = (
				"Recover the last network address drive from the assigned search area in Marsh. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"MU23"},
			briefing = (
				"** He places the drive order over the unfinished address sheet. The return instruction is "
				.. "underlined. He closes the pen and leaves his hand beside the page while you read. ** ** The "
				.. "written order reads: Recover the last network address drive from the assigned search area in "
				.. "Marsh. Bring it back to the bench in Marsh. **"
			),
			completion = (
				"** He reads the final record twice. Then he disconnects the receiver and clears the stool beside "
				.. "the bench. He looks towards it, then at you. **"
			),
			field = {
				description = (
					"A USB drive with a large rear loop and a handwritten paper label around its body. Mute has "
					.. "marked the accompanying order \"Last network address drive\"."
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_security",
				label = "Last network address drive",
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
