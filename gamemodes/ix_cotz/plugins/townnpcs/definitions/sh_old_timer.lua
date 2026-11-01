PLUGIN:Register("old-timer", {
	name = "'Old Timer'",
	template = "tutorialnpc",
	map = "rp_marsh_cs",
	job = {
		kind = "hunting",
		category = "Mutant hunting",
		description = "Mutant hunting",
		quantities = {5, 9, 15},
	},
	supplies = {"medic_bandage_1", "12gauge", "22lr", "food_bread"},
	rewards = {
		packages = {
			{label = "Hunting rounds",
				items = {"12gauge", "22lr"}},
			{label = "Field upkeep",
				items = {"sharpening_stone", "sharpening_stone_fine"}},
			{label = "Trail provisions",
				items = {"food_bread", "medic_bandage_1"}},
		},
	},
	dialogue = {
		completedGreeting = (
			"Good to see you. Put the pack down if you're staying a while; you don't have to stand ready "
			.. "to leave every minute."
		),
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Mutants. Keep the approaches clear, and come back with enough ammunition to do it again. Don't "
			.. "chase a wounded animal so far that you forget how you're getting back. I want the job done, but I "
			.. "want you back too."
		),
		progressionPrompt = "What else needs doing?",
		progression = (
			"A few things before you wander off. After that, there's something I'd like you to look for. Some "
			.. "of this is ordinary preparation. Some is paperwork I've put off asking anyone to fetch. Start with "
			.. "what you can manage; I'll tell you what I need it for when we get there."
		),
	},
	catalogue = {
		["hatchet"] = {step = "OT08",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["knife2"] = {step = "OT03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["knife3"] = {step = "OT12",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["ruger1022"] = {step = "OT03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sako85varmint"] = {step = "OT03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sharpening_stone"] = {step = "OT07",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["sharpening_stone_fine"] = {step = "OT19",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["suit_anorak"] = {step = "OT01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["toz106"] = {step = "OT03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["toz34short"] = {step = "OT03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["toz66short"] = {step = "OT03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["w9422"] = {step = "OT03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "OT01",
			completionCash = 275,
			name = "Before You Leave",
			kind = "delivery",
			requires = {},
			briefing = (
				"Food first. If you can't spare enough to leave here, you haven't packed enough to "
				.. "wander off. You'd be surprised how often a man remembers ammunition and forgets his "
				.. "stomach. We're not starting with that mistake."
			),
			completion = (
				"Good. Keep enough in your own pack. I don't want to hear you went hungry getting here. "
				.. "That's the sensible bit done. It isn't exciting, but you'll appreciate it later."
			),
			requirements = {
				{
					pool = "canned_food",
					quantity = 2,
				},
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
			id = "OT02",
			completionCash = 450,
			name = "Know Your Ground",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"OT01"},
			briefing = "Recover a field notebook near a Marsh landmark.",
			completion = "Let me have a look. Sit down while I read it.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "Know Your Ground - Tied Leather Journal",
			},
			benefits = {},
		},
		{
			id = "OT03",
			completionCash = 0,
			name = "Something With Teeth",
			kind = "tracker",
			requires = {"OT02"},
			briefing = "You came back. Good. Don't let a few dead mutants convince you that you know everything.",
			completion = "You came back. Good. I'll let you buy a better knife. Don't mistake it for experience.",
			target = 2,
			benefits = {},
		},
		{
			id = "OT04",
			completionCash = 650,
			name = "Bring Something Back",
			kind = "field",
			objective = "Recover Scientist's Field Diary from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"OT03"},
			briefing = "Investigate an abandoned hunting camp and recover its observations.",
			completion = "You made it back. Show me what you found.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_diary",
				label = "Bring Something Back - Scientist's Field Diary",
			},
			benefits = {},
		},
		{
			id = "OT05",
			completionCash = 575,
			name = "A Place to Hide",
			kind = "delivery",
			requires = {"OT04"},
			briefing = "Bring the supplies on this list. Keep enough in your own pack for the walk back.",
			completion = "That will do. Keep enough for yourself.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "OT06",
			completionCash = 850,
			name = "Ready Enough",
			kind = "field",
			objective = "Recover Small Yellow Transit Case from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"OT04"},
			briefing = "Recover a supply case beyond the Marsh camp outskirts.",
			completion = "Leave it here. I want to go through it properly.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_case",
				label = "Ready Enough - Small Yellow Transit Case",
			},
			benefits = {
				items = {
					{
						item = "12gauge",
						data = {
							quantity = 1,
						},
					},
				},
			},
			stock = {
				item = "medic_bandage_1",
				bonus = 1,
			},
		},
		{
			id = "OT07",
			completionCash = 0,
			name = "Look After Your Kit",
			kind = "tracker",
			requires = {"OT05"},
			briefing = "Mutants. Keep the approaches clear, and come back with enough ammunition to do it again.",
			completion = "You came back. Good. Don't let a few dead mutants convince you that you know everything.",
			target = 5,
			benefits = {},
		},
		{
			id = "OT08",
			capacity = {kind = "weight", amount = 1},
			completionCash = 1050,
			name = "Travel Light",
			kind = "field",
			objective = "Recover Striped Equipment Case from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"OT06"},
			briefing = "Recover a scout pack from a Marsh search area.",
			completion = "Let me have a look. Sit down while I read it.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_equipment",
				label = "Travel Light - Striped Equipment Case",
			},
			benefits = {},
		},
		{
			id = "OT09",
			completionCash = 875,
			name = "Bad Water",
			kind = "delivery",
			requires = {"OT07"},
			briefing = "Bring the supplies on this list. Keep enough in your own pack for the walk back.",
			completion = "You remembered the supplies. Good start.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "OT10",
			completionCash = 1250,
			name = "Enough for the Walk Home",
			kind = "field",
			objective = "Recover Small Yellow Transit Case from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"OT08"},
			briefing = "Retrieve a lost supply case along an exposed Marsh return route.",
			completion = "You made it back. Show me what you found.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_case",
				label = "Enough for the Walk Home - Small Yellow Transit Case",
			},
			benefits = {},
		},
		{
			id = "OT11",
			completionCash = 0,
			name = "Old Habits",
			kind = "tracker",
			requires = {"OT09"},
			briefing = "Mutants. Keep the approaches clear, and come back with enough ammunition to do it again.",
			completion = "You came back. Good. Don't let a few dead mutants convince you that you know everything.",
			target = 9,
			benefits = {},
		},
		{
			id = "OT12",
			completionCash = 1450,
			name = "Keep Yourself Alive",
			kind = "field",
			objective = "Recover Worn Striped Equipment Case from the assigned search area in Marsh. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"OT10"},
			briefing = "Recover the final equipment case from the Marsh survival expedition.",
			completion = "Leave it here. I want to go through it properly.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_worncase",
				label = "Keep Yourself Alive - Worn Striped Equipment Case",
			},
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
			id = "OT13",
			completionCash = 1175,
			name = "Tracks at the Fence",
			kind = "delivery",
			requires = {"OT11"},
			briefing = "Bring the supplies on this list. Keep enough in your own pack for the walk back.",
			completion = "Good. Put it with the rest.",
			requirements = {
				{
					pool = "common_parts",
					quantity = 2,
				},
			},
			benefits = {},
		},
		{
			id = "OT14",
			completionCash = 1650,
			name = "Thin the Pack",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"OT12"},
			briefing = "Recover observer notes from a Marsh hunting site.",
			completion = "Let me have a look. Sit down while I read it.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_notebook",
				label = "Thin the Pack - Tied Leather Journal",
			},
			benefits = {},
		},
		{
			id = "OT15",
			completionCash = 0,
			name = "What They Leave Behind",
			kind = "tracker",
			requires = {"OT13"},
			briefing = (
				"Mutants. Keep the approaches clear, and come back with enough ammunition to do it "
				.. "again. Look at the ground before you commit yourself. There's no prize for finding out "
				.. "too late that you chose a bad way in."
			),
			completion = (
				"You came back. Good. Don't let a few dead mutants convince you that you know "
				.. "everything. Back already? Sit your pack down properly. You can tell me about it once "
				.. "you've caught your breath."
			),
			target = 14,
			benefits = {},
		},
		{
			id = "OT16",
			capacity = {kind = "weight", amount = 1},
			completionCash = 1850,
			name = "Not Normal Behaviour",
			kind = "field",
			objective = "Recover Handwritten Audio Cassette from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"OT14"},
			briefing = "Retrieve a recorder from a disturbed feeding ground in Marsh.",
			completion = "You made it back. Show me what you found.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_tape",
				label = "Not Normal Behaviour - Handwritten Audio Cassette",
			},
			benefits = {},
		},
		{
			id = "OT17",
			completionCash = 1475,
			name = "The Empty Camp",
			kind = "delivery",
			requires = {"OT15"},
			briefing = "Bring the supplies on this list. Keep enough in your own pack for the walk back.",
			completion = "That will do. Keep enough for yourself.",
			requirements = {
				{
					pool = "common_parts",
					quantity = 2,
				},
			},
			benefits = {},
		},
		{
			id = "OT18",
			completionCash = 2050,
			name = "Leave a Way Out",
			kind = "field",
			objective = "Recover Scientist's Field Diary from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"OT16"},
			briefing = "Recover observations along a missing party route in Marsh.",
			completion = "Leave it here. I want to go through it properly.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_diary",
				label = "Leave a Way Out - Scientist's Field Diary",
			},
			benefits = {
				items = {
					{
						item = "12gauge",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "OT19",
			completionCash = 0,
			name = "An Old Name",
			kind = "tracker",
			requires = {"OT17"},
			briefing = "Mutants. Keep the approaches clear, and come back with enough ammunition to do it again.",
			completion = "You came back. Good. Don't let a few dead mutants convince you that you know everything.",
			target = 20,
			benefits = {},
		},
		{
			id = "OT20",
			completionCash = 2250,
			name = "The Convoy That Never Arrived",
			kind = "field",
			objective = "Recover Warehouse Packing List A from the assigned search area in Garbage. Deliver it to"
				.. " 'Ledger' in Waystation, then return here to finish the assignment.",
			requires = {"OT18"},
			briefing = (
				"There's a case from the missing convoy out in Garbage. Bring it back sealed. I want to see "
				.. "what's left."
			),
			completion = "They have it now. Good. Sit down a moment before you head out again.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_manifest",
				label = "The Convoy That Never Arrived - Warehouse Packing List A",
				recipient = "ledger",
			},
			benefits = {},
		},
		{
			id = "OT21",
			completionCash = 1775,
			name = "Someone Kept Records",
			kind = "delivery",
			requires = {"OT19"},
			briefing = "Bring the supplies on this list. Keep enough in your own pack for the walk back.",
			completion = "You remembered the supplies. Good start.",
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 2,
				},
			},
			benefits = {},
		},
		{
			id = "OT22",
			completionCash = 2450,
			name = "A Voice on Tape",
			kind = "field",
			objective = "Recover Blue-Label Audio Cassette from the assigned search area in Waystation. Deliver it to"
				.. " 'Spool' in Garbage, then return here to finish the assignment.",
			requires = {"OT20"},
			briefing = "Recover a recording from a remote signal site in Waystation territory.",
			completion = "They have it now. Good. Sit down a moment before you head out again.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_tape2",
				label = "A Voice on Tape - Blue-Label Audio Cassette",
				recipient = "spool",
			},
			benefits = {},
		},
		{
			id = "OT23",
			completionCash = 0,
			name = "What He Was Carrying",
			kind = "tracker",
			requires = {"OT21"},
			briefing = "Mutants. Keep the approaches clear, and come back with enough ammunition to do it again.",
			completion = "You came back. Good. Don't let a few dead mutants convince you that you know everything.",
			target = 27,
			benefits = {},
		},
		{
			id = "OT24",
			completionCash = 2650,
			name = "The Last Address",
			kind = "field",
			objective = "Recover Official File Folder from the assigned search area in Pripyat. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"OT22"},
			briefing = "The next case is in Pripyat. Take enough supplies to change your mind halfway there.",
			completion = "You're back. Let me look at it before you tell me the rest.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_official",
				label = "The Last Address - Official File Folder",
			},
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
			id = "OT25",
			completionCash = 2000,
			name = "Past the Turn Back Point",
			kind = "delivery",
			requires = {"OT23", "OT24"},
			briefing = "Bring the supplies on this list. Keep enough in your own pack for the walk back.",
			completion = "Good. Put it with the rest.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 7,
				},
			},
			benefits = {},
		},
		{
			id = "OT26",
			completionCash = 2850,
			name = "He Made It This Far",
			kind = "field",
			objective = "Recover Old Photograph Album from the assigned search area in Pripyat. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"OT25"},
			briefing = "Recover the final equipment case and keepsake in Pripyat.",
			completion = "Let me have a look. Sit down while I read it.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_photo",
				label = "He Made It This Far - Old Photograph Album",
			},
			benefits = {},
		},
		{
			id = "OT27",
			completionCash = 0,
			name = "Bring Him Home",
			kind = "tracker",
			requires = {"OT26"},
			briefing = "Mutants. Keep the approaches clear, and come back with enough ammunition to do it again.",
			completion = "You came back. Good. Don't let a few dead mutants convince you that you know everything.",
			target = 35,
			benefits = {},
		},
		{
			id = "OT28",
			completionCash = 3000,
			name = "Nothing Left Unsaid",
			kind = "field",
			objective = "Recover Personnel File Folder from the assigned search area in Pripyat. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"OT27"},
			briefing = (
				"One last case in Pripyat. Bring it here. That's all I'm asking. Don't open it on the road to "
				.. "satisfy your curiosity. Bring it back, get yourself somewhere safe, then we can take our time."
			),
			completion = (
				"Leave it here. And sit down a minute. There's no hurry. I've been finding reasons not to ask for "
				.. "this for a long time. You went anyway. I haven't got a clever bit of advice for that. Thank you."
			),
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_personnel",
				label = "Nothing Left Unsaid - Personnel File Folder",
			},
			benefits = {},
			recognition = "Old Timer's trusted contact",
		},
	},
})
