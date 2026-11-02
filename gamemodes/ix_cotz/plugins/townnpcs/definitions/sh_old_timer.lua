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
		workPrompt = "About the hunt I'm on.",
		offerPrompt = "Do you have a mutant hunting job?",
		work = (
			"Mutant hunting. Read the quarry on the order and prepare for the return as carefully as the hunt. "
			.. "Don't chase a wounded animal so far you forget where you've left yourself room to go. I'll have "
			.. "more work if you come back. I won't complain if you take time to make that likely."
		),
		progressionPrompt = "What needs doing next?",
		progression = (
			"There are supplies to bring in and field records I'd like recovered. We can start with something "
			.. "manageable. I want you to learn the walks without pretending every trip needs to prove a point. "
			.. "Where a record belongs with somebody else, the order says so. Deliver it, then come back here."
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
				"Before we talk about anything else, bring the canned food on the list. If you're going out "
				.. "hungry already, you won't make better decisions when the walk takes longer than you "
				.. "thought. Keep something for yourself as well."
			),
			completion = (
				"That'll do. Put it there. And check your own pack before you leave; I meant what I said "
				.. "about keeping something back."
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
			objective = (
				"Recover the Marsh field notebook from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"OT01"},
			briefing = (
				"There's a field notebook out in Marsh. I'd like you to pay attention to the walk as well as "
				.. "bringing the book back. Recover the Marsh field notebook from the assigned search area in Marsh. "
				.. "Bring it back to me in Marsh."
			),
			completion = "You found it and came home. Tell me where the walk became awkward, if it did.",
			field = {
				description = (
					"A thick brown journal held together by a narrow tie around its cover. Old Timer's note: \"There's "
					.. "a field notebook out in Marsh.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "Marsh field notebook",
			},
			benefits = {},
		},
		{
			id = "OT03",
			completionCash = 0,
			name = "Something With Teeth",
			kind = "tracker",
			requires = {"OT02"},
			briefing = "Keep completing the mutant hunting orders. Read the quarry before setting off.",
			completion = "A few hunts finished. Don't let that persuade you the next one needs less preparation.",
			target = 2,
			benefits = {},
		},
		{
			id = "OT04",
			completionCash = 650,
			name = "Bring Something Back",
			kind = "field",
			objective = (
				"Recover the hunting-camp observations from the assigned search area in Marsh. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"OT03"},
			briefing = (
				"Bring the hunting camp's observations back. Read the ground while you're there, but leave the "
				.. "longer inspection until you're safe. Recover the hunting-camp observations from the assigned "
				.. "search area in Marsh. Bring it back to me in Marsh."
			),
			completion = "Let's see what they noticed. You can put your pack down before explaining the whole trip.",
			field = {
				description = (
					"A thick blue diary with a label fixed to the front cover. Old Timer's note: \"Bring the hunting "
					.. "camp's observations back.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_diary",
				label = "Hunting-camp observations",
			},
			benefits = {},
		},
		{
			id = "OT05",
			completionCash = 575,
			name = "A Place to Hide",
			kind = "delivery",
			requires = {"OT04"},
			briefing = "Bring the supplies on the list here. Keep enough of your own to walk home afterwards.",
			completion = "Good. Put your own kit back in reach before we start talking.",
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
			objective = (
				"Recover the expedition supply case from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"OT04"},
			briefing = (
				"A supply case is still outside camp. Leave room to bring it home without throwing away what you "
				.. "need for yourself. Recover the expedition supply case from the assigned search area in Marsh. "
				.. "Bring it back to me in Marsh."
			),
			completion = "Both loads home, then. Good. Put it down before you start telling me it wasn't heavy.",
			field = {
				description = (
					"A small yellow hard case with ribbed corners and a large label on its lid. Old Timer's note: \"A "
					.. "supply case is still outside camp.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_case",
				label = "Expedition supply case",
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
			briefing = "More specified hunts when you're ready. Bring enough supplies for the return.",
			completion = "You've kept coming back with the work done. That's the part I like hearing.",
			target = 5,
			benefits = {},
		},
		{
			id = "OT08",
			capacity = {kind = "weight", amount = 1},
			completionCash = 1050,
			name = "Travel Light",
			kind = "field",
			objective = (
				"Recover the scout's recovered pack from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"OT06"},
			briefing = (
				"There's a scout's load to recover. Think about carrying it back before you fill every corner of "
				.. "your own pack. Recover the scout's recovered pack from the assigned search area in Marsh. Bring "
				.. "it back to me in Marsh."
			),
			completion = (
				"There. Unload it slowly. You learn more about carrying on the return than you do picking a thing "
				.. "up."
			),
			field = {
				description = (
					"A low hard case with long contrasting strips across its ribbed lid. Old Timer's note: \"There's a "
					.. "scout's load to recover.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_equipment",
				label = "Scout's recovered pack",
			},
			benefits = {},
		},
		{
			id = "OT09",
			completionCash = 875,
			name = "Bad Water",
			kind = "delivery",
			requires = {"OT07"},
			briefing = "I'd like this request filled. Read it before deciding something similar will do.",
			completion = "That's what I asked for. I'll take it from here.",
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
			objective = (
				"Recover the return-route provisions from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"OT08"},
			briefing = (
				"I want the lost supply case recovered. The return journey still needs food and water even when "
				.. "the search went well. Recover the return-route provisions from the assigned search area in Marsh. "
				.. "Bring it back to me in Marsh."
			),
			completion = "You're back. Keep your own supplies to hand while I check the case.",
			field = {
				description = (
					"A small yellow hard case with ribbed corners and a large label on its lid. Old Timer's note: \"I "
					.. "want the lost supply case recovered.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_case",
				label = "Return-route provisions",
			},
			benefits = {},
		},
		{
			id = "OT11",
			completionCash = 0,
			name = "Old Habits",
			kind = "tracker",
			requires = {"OT09"},
			briefing = "Continue the hunting orders. Leave room in the plan for turning back.",
			completion = "A steady amount of work. You've had time to learn which preparations you actually use.",
			target = 9,
			benefits = {},
		},
		{
			id = "OT12",
			completionCash = 1450,
			name = "Keep Yourself Alive",
			kind = "field",
			objective = (
				"Recover the survival expedition equipment from the assigned search area in Marsh. Bring it back "
				.. "to the issuing contact in Marsh."
			),
			requires = {"OT10"},
			briefing = (
				"One more equipment case from the Marsh expedition. Bring it whole, and don't treat familiarity "
				.. "with the route as permission to stop looking. Recover the survival expedition equipment from the "
				.. "assigned search area in Marsh. Bring it back to me in Marsh."
			),
			completion = "Set it down. You've had a proper amount of carrying to think about now.",
			field = {
				description = (
					"A heavily worn hard case with faded strips running across its lid. Old Timer's note: \"One more "
					.. "equipment case from the Marsh expedition.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_worncase",
				label = "Survival expedition equipment",
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
			briefing = "Bring the requested material back intact. The walk is still part of the work.",
			completion = "Set it down. You can take the weight off now.",
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
			objective = (
				"Recover the pack observer's notes from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"OT12"},
			briefing = (
				"There's an observer's account to recover from the hunting site. I'd like to compare what was seen "
				.. "with what people remember hearing. Recover the pack observer's notes from the assigned search "
				.. "area in Marsh. Bring it back to me in Marsh."
			),
			completion = "Good. I'll start with the observations before reading anybody's explanation.",
			field = {
				description = (
					"A thick brown journal held together by a narrow tie around its cover. Old Timer's note: \"There's "
					.. "an observer's account to recover from the hunting site.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_notebook",
				label = "Pack observer's notes",
			},
			benefits = {},
		},
		{
			id = "OT15",
			completionCash = 0,
			name = "What They Leave Behind",
			kind = "tracker",
			requires = {"OT13"},
			briefing = "Keep at the assigned hunts. The last success doesn't pack the next bag.",
			completion = "You've stayed with it. I hope you've been looking after yourself between trips too.",
			target = 14,
			benefits = {},
		},
		{
			id = "OT16",
			capacity = {kind = "weight", amount = 1},
			completionCash = 1850,
			name = "Not Normal Behaviour",
			kind = "field",
			objective = (
				"Recover the disturbed feeding-ground tape from the assigned search area in Marsh. Bring it back "
				.. "to the issuing contact in Marsh."
			),
			requires = {"OT14"},
			briefing = (
				"I want the recording from the feeding ground. Something unusual deserves a closer account than a "
				.. "frightened description over supper. Recover the disturbed feeding-ground tape from the assigned "
				.. "search area in Marsh. Bring it back to me in Marsh."
			),
			completion = "Leave it here. I'll listen before telling you what I think it was.",
			field = {
				description = (
					"A pale audio cassette with a handwritten dedication above the spool windows. Old Timer's note: "
					.. "\"I want the recording from the feeding ground.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_tape",
				label = "Disturbed feeding-ground tape",
			},
			benefits = {},
		},
		{
			id = "OT17",
			completionCash = 1475,
			name = "The Empty Camp",
			kind = "delivery",
			requires = {"OT15"},
			briefing = "There's another hand-in to prepare. Take your time checking what you need before leaving.",
			completion = "All here. Good. No need to tell me it was easy before you've sat down.",
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
			objective = (
				"Recover the missing party's route notes from the assigned search area in Marsh. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"OT16"},
			briefing = (
				"Recover the route observations. A party's intended path isn't always the one they managed to "
				.. "walk. Recover the missing party's route notes from the assigned search area in Marsh. Bring it "
				.. "back to me in Marsh."
			),
			completion = (
				"Let's look at the whole account. I don't want a guess hardening into the route simply because we "
				.. "keep repeating it."
			),
			field = {
				description = (
					"A thick blue diary with a label fixed to the front cover. Old Timer's note: \"Recover the route "
					.. "observations.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_diary",
				label = "Missing party's route notes",
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
			briefing = "More hunting work while I compare the records. Keep to the specified quarry.",
			completion = "You've put a lot of walking behind those returns. I notice more than the total.",
			target = 20,
			benefits = {},
		},
		{
			id = "OT20",
			completionCash = 2250,
			name = "The Convoy That Never Arrived",
			kind = "field",
			objective = (
				"Recover the convoy records for Ledger from the assigned search area in Garbage. Deliver it to "
				.. "'Ledger' in Waystation, then come back to the issuing contact in Marsh."
			),
			requires = {"OT18"},
			briefing = (
				"Ledger needs the convoy record. Take it through intact, then come back here. I'd rather he read "
				.. "it himself. Recover the convoy records for Ledger from the assigned search area in Garbage. "
				.. "Deliver it to 'Ledger' in Waystation, then come back to me in Marsh."
			),
			completion = "He has it. Good. You can take your pack off while we wait for the papers to be read.",
			field = {
				description = (
					"A printed packing list on a small clipboard with a metal clip and a circular stamp. Old Timer's "
					.. "note: \"Ledger needs the convoy record.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_manifest",
				label = "Convoy records for Ledger",
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
			briefing = "Bring the supplies on the list here. Keep enough of your own to walk home afterwards.",
			completion = "Good. Put your own kit back in reach before we start talking.",
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
			objective = (
				"Recover the recording for Spool from the assigned search area in Waystation. Deliver it to "
				.. "'Spool' in Garbage, then come back to the issuing contact in Marsh."
			),
			requires = {"OT20"},
			briefing = (
				"Spool should hear the recording. He listens more carefully than most people talk. Recover the "
				.. "recording for Spool from the assigned search area in Waystation. Deliver it to 'Spool' in "
				.. "Garbage, then come back to me in Marsh."
			),
			completion = "You delivered it and came back. That's what I asked. Let him listen before we ask for an answer.",
			field = {
				description = (
					"A pale audio cassette with a broad blue printed label and twin spool windows. Old Timer's note: "
					.. "\"Spool should hear the recording.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_tape2",
				label = "Recording for Spool",
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
			briefing = "Continue the hunting assignments when you've rested and prepared.",
			completion = "You've been dependable over time. I worry less when I know you've thought about the return.",
			target = 27,
			benefits = {},
		},
		{
			id = "OT24",
			completionCash = 2650,
			name = "The Last Address",
			kind = "field",
			objective = (
				"Recover the Pripyat address file from the assigned search area in Pripyat. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"OT22"},
			briefing = (
				"The next record is in Pripyat. Take enough supplies to change your mind halfway there; having an "
				.. "address doesn't oblige you to reach it today. Recover the Pripyat address file from the assigned "
				.. "search area in Pripyat. Bring it back to me in Marsh."
			),
			completion = "Come in. Leave the file here and get the weight off your shoulders.",
			field = {
				description = (
					"A cardboard file folder with a small coloured crest on its cover. Old Timer's note: \"The next "
					.. "record is in Pripyat.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_official",
				label = "Pripyat address file",
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
			briefing = "I'd like this request filled. Read it before deciding something similar will do.",
			completion = "That's what I asked for. I'll take it from here.",
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
			objective = (
				"Recover the companion's recovered equipment from the assigned search area in Pripyat. Bring it "
				.. "back to the issuing contact in Marsh."
			),
			requires = {"OT25"},
			briefing = (
				"There's a final equipment case to collect. Keep the small things with it. I want to see what "
				.. "survived together. Recover the companion's recovered equipment from the assigned search area in "
				.. "Pripyat. Bring it back to me in Marsh."
			),
			completion = "Put it here. Don't rush to explain what you think it means. Give me a moment to look.",
			field = {
				description = (
					"A thick worn photograph album with a small picture set into its brown cover. Old Timer's note: "
					.. "\"There's a final equipment case to collect.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_photo",
				label = "Companion's recovered equipment",
			},
			benefits = {},
		},
		{
			id = "OT27",
			completionCash = 0,
			name = "Bring Him Home",
			kind = "tracker",
			requires = {"OT26"},
			briefing = "Keep completing the specified hunts. You're allowed a quiet day between them.",
			completion = "Still coming home. Still doing the work carefully. I'm pleased to see both.",
			target = 35,
			benefits = {},
		},
		{
			id = "OT28",
			completionCash = 3000,
			name = "Nothing Left Unsaid",
			kind = "field",
			objective = (
				"Recover the companion's last record from the assigned search area in Pripyat. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"OT27"},
			briefing = (
				"One last record. Bring it home before opening it on the road. There'll be time to read when "
				.. "you're back. Recover the companion's last record from the assigned search area in Pripyat. Bring "
				.. "it back to me in Marsh."
			),
			completion = (
				"Leave it beside me. You've carried enough for today. Sit down a minute. I'd rather you stayed "
				.. "while I read it."
			),
			field = {
				description = (
					"A cardboard file folder with an emblem and printed wording on the front. Old Timer's note: \"One "
					.. "last record.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_personnel",
				label = "Companion's last record",
			},
			benefits = {},
			recognition = "Old Timer's trusted contact",
		},
	},
})
