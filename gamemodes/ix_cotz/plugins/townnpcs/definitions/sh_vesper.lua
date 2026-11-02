PLUGIN:Register("vesper", {
	name = "'Vesper'",
	template = "vespernpc",
	map = "mz_garbage",
	job = {
		kind = "sensor",
		category = "Sensor deployment and retrieval",
		description = "Sensor deployment and retrieval",
		maps = {
			easy = "mz_garbage",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Radiation supplies",
				items = {"medic_antirad_1", "medic_antirad_2"}},
			{label = "Emergency extraction",
				items = {"medic_bandage_1", "medic_medkit_1"}},
			{label = "Prospecting provisions",
				items = {"drink_bottlewater", "food_raisins"}},
		},
	},
	dialogue = {
		delivery = "Put it where I can check the label. Tell me if it was damaged on the way.",
		completedGreeting = (
			"Good to see you on this side of the trip. We can talk for a moment before either of us "
			.. "starts planning another."
		),
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Deploy the sensor, let it finish, then collect it. Stay within range and keep yourself fit to "
			.. "carry it home. Decide when you'll turn back before you set out. Don't keep changing that decision "
			.. "just because the recorder isn't quite finished."
		),
		progressionPrompt = "What else needs doing?",
		progression = (
			"There are supplies to sort and field readings to check. Pick a trip you can prepare for. The "
			.. "equipment and the field accounts both need attention. Bring back what the order asks for; we can "
			.. "argue about the interpretation somewhere we can hear ourselves think."
		),
	},
	catalogue = {
		["mask_m40"] = {step = "VE19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mask_m50"] = {step = "VE21",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mask_xm40"] = {step = "VE15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_wind"] = {step = "VE11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "VE01",
			completionCash = 275,
			name = "Before the Field",
			kind = "delivery",
			requires = {},
			briefing = (
				"Before the next field trip I need the maintenance supplies on this list. Bring them here "
				.. "and I'll check the kit. Preparation isn't very exciting to watch, but it gives me more "
				.. "freedom to pay attention once I'm outside."
			),
			completion = (
				"Good. I'll check these against the kit. I like an interesting trip as much as anyone; I "
				.. "just prefer the equipment to be boringly dependable."
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
			id = "VE02",
			completionCash = 450,
			name = "The Quiet Edge",
			kind = "field",
			objective = (
				"Deploy the recorder at the assigned site in Garbage, let it finish recording, then retrieve the "
				.. "anomaly approach survey recorder. Bring it back to the issuing contact in Garbage."
			),
			requires = {"VE01"},
			briefing = (
				"I'd like a recording from the field approach. A quiet-looking edge still deserves the full "
				.. "preparation. Deploy the recorder at the assigned site in Garbage, let it finish recording, then "
				.. "retrieve the anomaly approach survey recorder. Bring it back to me in Garbage."
			),
			completion = "You're back. I'll check the recorded conditions before calling it a straightforward trip.",
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. Vesper's note: "
					.. "\"I'd like a recording from the field approach.\""
				),
				kind = "sensor",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_module",
				label = "Anomaly approach survey recorder",
			},
			benefits = {},
		},
		{
			id = "VE03",
			completionCash = 0,
			name = "Readings Worth Keeping",
			kind = "tracker",
			requires = {"VE02"},
			briefing = "Continue the sensor surveys. Let the run finish, retrieve the recorder, and return the result.",
			completion = "A useful start. You can enjoy a completed trip now.",
			target = 2,
			benefits = {},
		},
		{
			id = "VE04",
			completionCash = 650,
			name = "Beanstalk's Baseline",
			kind = "field",
			objective = (
				"Recover the baseline recorder for Spool from the assigned search area in Garbage. Deliver it to "
				.. "'Spool' in Garbage, then come back to the issuing contact in Garbage."
			),
			requires = {"VE02"},
			briefing = (
				"Spool needs the recovered baseline recorder. I'd like the recording checked before anyone tries "
				.. "to settle the field argument from memory. Recover the baseline recorder for Spool from the "
				.. "assigned search area in Garbage. Deliver it to 'Spool' in Garbage, then come back to me in "
				.. "Garbage."
			),
			completion = "Delivered. He can examine the record without my opinion talking over it.",
			field = {
				description = (
					"A flat dark electronic module marked with a number and three pale bars. Vesper's note: \"Spool "
					.. "needs the recovered baseline recorder.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_module2",
				label = "Baseline recorder for Spool",
				recipient = "spool",
			},
			benefits = {},
		},
		{
			id = "VE05",
			completionCash = 575,
			name = "Reliable Instruments",
			kind = "delivery",
			requires = {"VE03"},
			briefing = (
				"I need the requested components. Check the actual request before carrying a useful-looking "
				.. "substitute."
			),
			completion = "That's what I needed. I'll keep the lot together for the checks.",
			requirements = {
				{
					pool = "small_electronics",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "VE06",
			completionCash = 850,
			name = "The Second Field",
			kind = "field",
			objective = (
				"Deploy the recorder at the assigned site in Garbage, let it finish recording, then retrieve the "
				.. "second field survey recorder. Bring it back to the issuing contact in Garbage."
			),
			requires = {"VE04"},
			briefing = (
				"We need another field recording. Don't pack for the last trip simply because this one sounds "
				.. "similar. Deploy the recorder at the assigned site in Garbage, let it finish recording, then "
				.. "retrieve the second field survey recorder. Bring it back to me in Garbage."
			),
			completion = "Set it down. I'll keep this reading separate while I compare the conditions.",
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. Vesper's note: "
					.. "\"We need another field recording.\""
				),
				kind = "sensor",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_module",
				label = "Second field survey recorder",
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
			id = "VE07",
			completionCash = 0,
			name = "Same Method Twice",
			kind = "tracker",
			requires = {"VE05"},
			briefing = "More survey recordings when prepared. Check the return before accepting.",
			completion = "You've kept the work consistent. That gives us something worth comparing.",
			target = 5,
			benefits = {},
		},
		{
			id = "VE08",
			completionCash = 1050,
			name = "The Abandoned Detector",
			kind = "field",
			objective = (
				"Recover the abandoned prospector's case from the assigned search area in Garbage. Bring it back "
				.. "to the issuing contact in Garbage."
			),
			requires = {"VE06"},
			briefing = (
				"A prospector's case is still out there. Bring it back unchanged; I'd like to inspect the "
				.. "equipment before deciding why it was left. Recover the abandoned prospector's case from the "
				.. "assigned search area in Garbage. Bring it back to me in Garbage."
			),
			completion = "Good. I'll check the case beside the field account.",
			field = {
				description = (
					"A dark reinforced case covered in pale symbols and contrasting trim. Vesper's note: \"A "
					.. "prospector's case is still out there.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_research",
				label = "Abandoned prospector's case",
			},
			benefits = {},
		},
		{
			id = "VE09",
			completionCash = 875,
			name = "Keep It Sealed",
			kind = "delivery",
			requires = {"VE07"},
			briefing = "There is another supply order. Keep your own return provisions out of the hand-in.",
			completion = "All here. You've still left yourself what you need, I hope.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "VE10",
			completionCash = 1250,
			name = "The Unstable Reading",
			kind = "field",
			objective = (
				"Recover the disputed-site audio record from the assigned search area in Garbage. Bring it back to "
				.. "the issuing contact in Garbage."
			),
			requires = {"VE08"},
			briefing = (
				"Recover the disputed site's recording. An unstable reading is interesting, but I'd prefer it "
				.. "somewhere I can listen without watching the ground. Recover the disputed-site audio record from "
				.. "the assigned search area in Garbage. Bring it back to me in Garbage."
			),
			completion = "Leave it here. We'll hear the whole account before choosing the exciting explanation.",
			field = {
				description = (
					"A pale audio cassette with a handwritten dedication above the spool windows. Vesper's note: "
					.. "\"Recover the disputed site's recording.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_tape",
				label = "Disputed-site audio record",
			},
			benefits = {},
		},
		{
			id = "VE11",
			completionCash = 0,
			name = "Outside Familiar Ground",
			kind = "tracker",
			requires = {"VE09"},
			briefing = "Keep completing the sensor work while I examine the recovered accounts.",
			completion = "A steady run of results. I appreciate the attention between departures.",
			target = 9,
			benefits = {},
		},
		{
			id = "VE12",
			completionCash = 1450,
			name = "The Control Run",
			kind = "field",
			objective = (
				"Deploy the recorder at the assigned site in Garbage, let it finish recording, then retrieve the "
				.. "regional control recorder. Bring it back to the issuing contact in Garbage."
			),
			requires = {"VE10"},
			briefing = (
				"I'd like a recording from the control site. Do the same careful work even if the journey promises "
				.. "to be less interesting. Deploy the recorder at the assigned site in Garbage, let it finish "
				.. "recording, then retrieve the regional control recorder. Bring it back to me in Garbage."
			),
			completion = "Thank you. A comparison is much easier when the boring trip wasn't treated casually.",
			field = {
				description = (
					"A flat dark electronic module marked with a number and three pale bars. Vesper's note: \"I'd like "
					.. "a recording from the control site.\""
				),
				kind = "sensor",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_module2",
				label = "Regional control recorder",
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
			id = "VE13",
			completionCash = 1175,
			name = "Supplies for Distance",
			kind = "delivery",
			requires = {"VE11"},
			briefing = (
				"Bring what's on the list. Check your own kit before giving away the supplies you need "
				.. "to get home. Go through the return instructions before you leave. It's easier to ask a "
				.. "sensible question here than invent an answer in the field."
			),
			completion = (
				"Good. Check your own supplies before you leave. Good. You can leave that with me and "
				.. "take a minute to settle. I'll check it without someone trying to rush the answer."
			),
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 4,
				},
			},
			benefits = {},
		},
		{
			id = "VE14",
			completionCash = 1650,
			name = "The Lost Team's Notes",
			kind = "field",
			objective = (
				"Recover the prospecting log for Wake from the assigned search area in Waystation. Deliver it to "
				.. "'Wake' in Garbage, then come back to the issuing contact in Garbage."
			),
			requires = {"VE12"},
			briefing = (
				"Wake needs the lost team's log. She should have the people and the route in their own words, not "
				.. "my selection of technical details. Recover the prospecting log for Wake from the assigned search "
				.. "area in Waystation. Deliver it to 'Wake' in Garbage, then come back to me in Garbage."
			),
			completion = "Delivered. She can take time with it before we compare our questions.",
			field = {
				description = (
					"A thick blue diary with a label fixed to the front cover. Vesper's note: \"Wake needs the lost "
					.. "team's log.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_diary",
				label = "Prospecting log for Wake",
				recipient = "wake",
			},
			benefits = {},
		},
		{
			id = "VE15",
			completionCash = 0,
			name = "Know When to Leave",
			kind = "tracker",
			requires = {"VE13"},
			briefing = "Continue the survey assignments. Prepare for this trip rather than relying on the last one.",
			completion = "You've stayed careful as the work accumulated. Good.",
			target = 14,
			benefits = {},
		},
		{
			id = "VE16",
			completionCash = 1850,
			name = "The First Pripyat Field",
			kind = "field",
			objective = (
				"Deploy the recorder at the assigned site in Pripyat, let it finish recording, then retrieve the "
				.. "first Pripyat field recorder. Bring it back to the issuing contact in Garbage."
			),
			requires = {"VE14"},
			briefing = (
				"This survey is in Pripyat. Check the return provisions before accepting; I want you interested in "
				.. "the result when you get home. Deploy the recorder at the assigned site in Pripyat, let it finish "
				.. "recording, then retrieve the first Pripyat field recorder. Bring it back to me in Garbage."
			),
			completion = "You're back with the recording. Good. We can enjoy the interesting part from here.",
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. Vesper's note: "
					.. "\"This survey is in Pripyat.\""
				),
				kind = "sensor",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module",
				label = "First Pripyat field recorder",
			},
			benefits = {},
		},
		{
			id = "VE17",
			completionCash = 1475,
			name = "No Borrowed Luck",
			kind = "delivery",
			requires = {"VE15"},
			briefing = (
				"Bring the requested supplies through intact. Equipment isn't ready just because I want another "
				.. "trip."
			),
			completion = "Thank you. I'll put this aside before planning around it.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 5,
				},
			},
			benefits = {},
		},
		{
			id = "VE18",
			completionCash = 2050,
			name = "The Team's Cache",
			kind = "field",
			objective = (
				"Recover the lost team's equipment case from the assigned search area in Garbage. Bring it back to "
				.. "the issuing contact in Garbage."
			),
			requires = {"VE16"},
			briefing = (
				"Recover the team's equipment case intact. I want to see what survived before making a story about "
				.. "what they must have needed. Recover the lost team's equipment case from the assigned search area "
				.. "in Garbage. Bring it back to me in Garbage."
			),
			completion = "Set it somewhere steady. I'll inspect it before separating anything.",
			field = {
				description = (
					"A low hard case with long contrasting strips across its ribbed lid. Vesper's note: \"Recover the "
					.. "team's equipment case intact.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_equipment",
				label = "Lost team's equipment case",
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
			id = "VE19",
			completionCash = 0,
			name = "A Measured Risk",
			kind = "tracker",
			requires = {"VE17"},
			briefing = "There are more recordings to make. Bring the completed results home.",
			completion = "A lot of work returned now. I'm glad you've given the return its share of the preparation.",
			target = 20,
			benefits = {},
		},
		{
			id = "VE20",
			completionCash = 2250,
			name = "The Field They Chose",
			kind = "field",
			objective = (
				"Deploy the recorder at the assigned site in Garbage, let it finish recording, then retrieve the "
				.. "team's last field recorder. Bring it back to the issuing contact in Garbage."
			),
			requires = {"VE18"},
			briefing = (
				"We need a recording at the assigned field site. Keep the survey and the journey as careful as the "
				.. "earlier work. Deploy the recorder at the assigned site in Garbage, let it finish recording, then "
				.. "retrieve the team's last field recorder. Bring it back to me in Garbage."
			),
			completion = "Thank you. I'll examine the reading before borrowing a conclusion from the team's account.",
			field = {
				description = (
					"A flat dark electronic module marked with a number and three pale bars. Vesper's note: \"We need "
					.. "a recording at the assigned field site.\""
				),
				kind = "sensor",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_module2",
				label = "Team's last field recorder",
			},
			benefits = {},
		},
		{
			id = "VE21",
			completionCash = 1775,
			name = "Enough to Compare",
			kind = "delivery",
			requires = {"VE19", "VE20"},
			briefing = (
				"Bring the listed maintenance supplies here. I want the preparation done before we become excited "
				.. "about the destination."
			),
			completion = "Good. I'll inspect this before packing it.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 6,
				},
			},
			benefits = {},
		},
		{
			id = "VE22",
			completionCash = 2450,
			name = "A Different Explanation",
			kind = "field",
			objective = (
				"Recover the control cassette for Carbon from the assigned search area in Pripyat. Deliver it to "
				.. "'Carbon' in Waystation, then come back to the issuing contact in Garbage."
			),
			requires = {"VE21"},
			briefing = (
				"Carbon needs the recovered control recording. Another reading of the account may show where we've "
				.. "been asking it the wrong question. Recover the control cassette for Carbon from the assigned "
				.. "search area in Pripyat. Deliver it to 'Carbon' in Waystation, then come back to me in Garbage."
			),
			completion = "He has it. Good. I'll wait for his questions instead of preparing an answer for him.",
			field = {
				description = (
					"A pale audio cassette with a handwritten dedication above the spool windows. Vesper's note: "
					.. "\"Carbon needs the recovered control recording.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_tape",
				label = "Control cassette for Carbon",
				recipient = "carbon",
			},
			benefits = {},
		},
		{
			id = "VE23",
			completionCash = 0,
			name = "Everyone Comes Back",
			kind = "tracker",
			requires = {"VE22"},
			briefing = "Keep the survey recordings going when you're ready.",
			completion = (
				"You've made yourself dependable company for this work. I'd be pleased to discuss another trip "
				.. "after we've enjoyed finishing these."
			),
			target = 27,
			benefits = {},
		},
		{
			id = "VE24",
			completionCash = 2650,
			name = "The Last Recorder",
			kind = "field",
			objective = (
				"Recover the expedition's final cassette from the assigned search area in Garbage. Bring it back "
				.. "to the issuing contact in Garbage."
			),
			requires = {"VE23"},
			briefing = (
				"Bring the final cassette home before listening. There is nothing on it worth letting the journey "
				.. "out of your attention. Recover the expedition's final cassette from the assigned search area in "
				.. "Garbage. Bring it back to me in Garbage."
			),
			completion = (
				"You brought the record back. We've worked a long way through this together, and I appreciate the "
				.. "care you've given it. Sit down a moment. The next trip can remain an idea for now."
			),
			field = {
				description = (
					"A pale audio cassette with a broad blue printed label and twin spool windows. Vesper's note: "
					.. "\"Bring the final cassette home before listening.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_tape2",
				label = "Expedition's final cassette",
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
			recognition = "Vesper's trusted contact",
		},
	},
})
