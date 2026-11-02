PLUGIN:Register("spoor", {
	name = "'Spoor'",
	template = "spoornpc",
	map = "mz_garbage",
	job = {
		kind = "hunting",
		category = "Mutant hunting",
		description = "Mutant hunting",
		quantities = {5, 9, 15},
	},
	supplies = {"12gauge", "22lr", "medic_bandage_1", "drink_bottlewater"},
	rewards = {
		packages = {
			{label = "Hunting ammunition",
				items = {"12gauge", "762x54", "762x51"}},
			{label = "Edge upkeep",
				items = {"sharpening_stone", "sharpening_stone_fine"}},
			{label = "Long hunt",
				items = {"food_raisins", "drink_bottlewater"}},
		},
	},
	dialogue = {
		delivery = "Set it down. Tell me if anything happened to it on the way.",
		completedGreeting = (
			"Hello. Seen anything worth a closer look? You know I'm happy to hear what you actually "
			.. "noticed."
		),
		workPrompt = "About the hunt I've taken.",
		offerPrompt = "Do you have a hunting order?",
		work = (
			"Mutant hunting, against the quarry on the order. Check it before you leave. Don't turn the journey "
			.. "into a trophy chase because you saw something larger. I'd rather you came back able to explain an "
			.. "ordinary hunt than left someone else to explain where you went."
		),
		progressionPrompt = "What are you checking in the hunting records?",
		progression = (
			"I want to compare observations from the hunting grounds. Some of the accounts disagree; some may "
			.. "simply describe different days. We'll need specimens, supplies, and recovered records. Choose a "
			.. "piece of work you can prepare for. We can talk about what it shows after we've seen it."
		),
	},
	catalogue = {
		["12gaugedt"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["12gaugesg"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["12gaugemg"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["12gaugetr"] = {unlockContact = "brass", step = "BR21",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["22lrap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["22lrhp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["338lapua"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["338lapuaap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["338lapuahp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x51"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x51ap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x51hp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x54"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x54ap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x54hp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["lax44"] = {step = "SP17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["machete"] = {step = "SP05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mosin"] = {step = "SP11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["obrez"] = {step = "SP07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["saigasemi"] = {step = "SP11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sako85"] = {step = "SP11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sako85nato"] = {step = "SP07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["svt40"] = {step = "SP17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sw500"] = {step = "SP17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["w1895"] = {step = "SP07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["w9422357"] = {step = "SP11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "SP01",
			completionCash = 275,
			name = "Reading the Remains",
			kind = "delivery",
			requires = {},
			briefing = (
				"Bring the parts on the list. I want to look them over properly. You can learn more from "
				.. "what's left of an animal if you keep track of what you took, instead of throwing everything "
				.. "in one bag and calling it a trophy."
			),
			completion = (
				"Set them down. I'll have a look. Thanks for bringing what I asked for; it saves us trying "
				.. "to work out which piece came from what."
			),
			requirements = {
				{
					pool = "common_parts",
					quantity = 1,
				},
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
			id = "SP02",
			completionCash = 450,
			name = "The Scavenger's Camp",
			kind = "field",
			objective = (
				"Recover the scavenging-ground observations from the assigned search area in Garbage. Bring it "
				.. "back to the issuing contact in Garbage."
			),
			requires = {"SP01"},
			briefing = (
				"I want the observations from the hunting ground. What was feeding there matters before we decide "
				.. "what drove it away. Recover the scavenging-ground observations from the assigned search area in "
				.. "Garbage. Bring it back to me in Garbage."
			),
			completion = "I'll read the feeding notes first. See if they noticed what else was using the ground.",
			field = {
				description = (
					"A thick brown journal held together by a narrow tie around its cover. Spoor's note: \"I want the "
					.. "observations from the hunting ground.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "Scavenging-ground observations",
			},
			benefits = {},
		},
		{
			id = "SP03",
			completionCash = 0,
			name = "Clear the Approach",
			kind = "tracker",
			requires = {"SP02"},
			briefing = "Continue the mutant hunting orders. Keep to the specified quarry.",
			completion = "A few completed hunts. Enough to begin seeing how you work.",
			target = 2,
			benefits = {},
		},
		{
			id = "SP04",
			completionCash = 650,
			name = "Where They Feed",
			kind = "field",
			objective = (
				"Recover the feeding-site recording from the assigned search area in Garbage. Bring it back to the "
				.. "issuing contact in Garbage."
			),
			requires = {"SP02"},
			briefing = (
				"There's a recorder left near a feeding site. I'd like to hear the observer before choosing an "
				.. "explanation. Recover the feeding-site recording from the assigned search area in Garbage. Bring "
				.. "it back to me in Garbage."
			),
			completion = "Put it here. I'll listen before looking for the part that agrees with me.",
			field = {
				description = (
					"A pale audio cassette with a handwritten dedication above the spool windows. Spoor's note: "
					.. "\"There's a recorder left near a feeding site.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_tape",
				label = "Feeding-site recording",
			},
			benefits = {},
		},
		{
			id = "SP05",
			completionCash = 575,
			name = "Tools for the Field",
			kind = "delivery",
			requires = {"SP03"},
			briefing = "There's a supply list for field work. Keep your own return kit separate from the hand-in.",
			completion = "Good. I'll put this with the field supplies.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "SP06",
			completionCash = 850,
			name = "Lemon's Complaint",
			kind = "field",
			objective = (
				"Recover the camp meat-handling notes from the assigned search area in Garbage. Deliver it to "
				.. "'Jitters' in Marsh, then come back to the issuing contact in Garbage."
			),
			requires = {"SP04"},
			briefing = (
				"Jitters needs the meat-handling notes. He can judge the health concerns better with the account "
				.. "in front of him. Recover the camp meat-handling notes from the assigned search area in Garbage. "
				.. "Deliver it to 'Jitters' in Marsh, then come back to me in Garbage."
			),
			completion = "He has the notes. Let him read them before the argument returns to whose dinner it was.",
			field = {
				description = (
					"A thick blue diary with a label fixed to the front cover. Spoor's note: \"Jitters needs the "
					.. "meat-handling notes.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_diary",
				label = "Camp meat-handling notes",
				recipient = "jitters",
			},
			benefits = {
				items = {
					{
						item = "22lr",
						data = {
							quantity = 1,
						},
					},
				},
			},
			stock = {
				item = "12gauge",
				bonus = 1,
			},
		},
		{
			id = "SP07",
			completionCash = 0,
			name = "A Safer Yard",
			kind = "tracker",
			requires = {"SP05"},
			briefing = "More hunting assignments when you're ready. Check the quarry before accepting.",
			completion = "You've kept to the requests. That's useful work.",
			target = 5,
			benefits = {},
		},
		{
			id = "SP08",
			completionCash = 1050,
			name = "The Displaced Pack",
			kind = "field",
			objective = (
				"Recover the displaced-pack notebook from the assigned search area in Garbage. Bring it back to "
				.. "the issuing contact in Garbage."
			),
			requires = {"SP06"},
			briefing = (
				"I want the second hunting-ground account. A pack turning up somewhere new doesn't tell us why it "
				.. "left the old ground. Recover the displaced-pack notebook from the assigned search area in "
				.. "Garbage. Bring it back to me in Garbage."
			),
			completion = "Good. I'll check what they saw before the animals moved.",
			field = {
				description = (
					"A thick brown journal held together by a narrow tie around its cover. Spoor's note: \"I want the "
					.. "second hunting-ground account.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "Displaced-pack notebook",
			},
			benefits = {},
		},
		{
			id = "SP09",
			completionCash = 875,
			name = "Different Quarry",
			kind = "delivery",
			requires = {"SP07"},
			briefing = "I'd like the requested material brought in without damage from the journey.",
			completion = "That's usable. I'll take a closer look.",
			requirements = {
				{
					pool = "common_parts",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "SP10",
			completionCash = 1250,
			name = "Tracks in the Wrong Place",
			kind = "field",
			objective = (
				"Recover the disturbed-route recorder from the assigned search area in Garbage. Bring it back to "
				.. "the issuing contact in Garbage."
			),
			requires = {"SP08"},
			briefing = (
				"The route recorder may help place the disturbance. Don't decide every noise on it must be the "
				.. "quarry. Recover the disturbed-route recorder from the assigned search area in Garbage. Bring it "
				.. "back to me in Garbage."
			),
			completion = "I'll take time with it. There's usually more than one thing moving out there.",
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. Spoor's note: "
					.. "\"The route recorder may help place the disturbance.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_module",
				label = "Disturbed-route recorder",
			},
			benefits = {},
		},
		{
			id = "SP11",
			completionCash = 0,
			name = "Patient Work",
			kind = "tracker",
			requires = {"SP09"},
			briefing = "Keep completing the hunting orders. There is no need to invent a better story for the return.",
			completion = "A steady amount of work. I'd sooner hear the plain account.",
			target = 9,
			benefits = {},
		},
		{
			id = "SP12",
			completionCash = 1450,
			name = "The Empty Hide",
			kind = "field",
			objective = (
				"Recover the observation-hide field case from the assigned search area in Garbage. Bring it back "
				.. "to the issuing contact in Garbage."
			),
			requires = {"SP10"},
			briefing = (
				"There's a hunter's case to recover from the observation site. Bring it as it was left. Recover "
				.. "the observation-hide field case from the assigned search area in Garbage. Bring it back to me in "
				.. "Garbage."
			),
			completion = "Set it down. I'll check the observations before judging how the position was used.",
			field = {
				description = (
					"A cardboard file folder with an emblem and printed wording on the front. Spoor's note: \"There's "
					.. "a hunter's case to recover from the observation site.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_personnel",
				label = "Observation-hide field case",
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
			id = "SP13",
			completionCash = 1175,
			name = "Proof of Change",
			kind = "delivery",
			requires = {"SP11"},
			briefing = "Bring this request through. A familiar specimen still deserves care getting it here.",
			completion = "All here. Leave it where the light reaches.",
			requirements = {
				{
					pool = "common_parts",
					quantity = 2,
				},
			},
			benefits = {},
		},
		{
			id = "SP14",
			completionCash = 1650,
			name = "The Pattern Breaks",
			kind = "field",
			objective = (
				"Recover the survey recorder for Atlas from the assigned search area in Waystation. Deliver it to "
				.. "'Atlas' in Marsh, then come back to the issuing contact in Garbage."
			),
			requires = {"SP12"},
			briefing = (
				"Atlas needs the survey record. I'd like him to check the ground account without me selecting the "
				.. "useful bits for him. Recover the survey recorder for Atlas from the assigned search area in "
				.. "Waystation. Deliver it to 'Atlas' in Marsh, then come back to me in Garbage."
			),
			completion = "Delivered. He'll tell me where the account is uncertain. That's worth hearing.",
			field = {
				description = (
					"A flat dark electronic module marked with a number and three pale bars. Spoor's note: \"Atlas "
					.. "needs the survey record.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_module2",
				label = "Survey recorder for Atlas",
				recipient = "atlas",
			},
			benefits = {},
		},
		{
			id = "SP15",
			completionCash = 0,
			name = "No Easy Quarry",
			kind = "tracker",
			requires = {"SP13"},
			briefing = "Continue the specified hunts. Prepare for the quarry, not the last successful trip.",
			completion = "You've stayed patient with the work. I appreciate that.",
			target = 14,
			benefits = {},
		},
		{
			id = "SP16",
			completionCash = 1850,
			name = "The First Pripyat Trail",
			kind = "field",
			objective = (
				"Recover the Pripyat observer's notebook from the assigned search area in Pripyat. Bring it back "
				.. "to the issuing contact in Garbage."
			),
			requires = {"SP14"},
			briefing = (
				"An observer's notebook is still in Pripyat. I want the whole sequence, including days when "
				.. "nothing seemed to happen. Recover the Pripyat observer's notebook from the assigned search area "
				.. "in Pripyat. Bring it back to me in Garbage."
			),
			completion = "Leave the pages in order. I'll start before the interesting sighting.",
			field = {
				description = (
					"A thick blue diary with a label fixed to the front cover. Spoor's note: \"An observer's notebook "
					.. "is still in Pripyat.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_diary",
				label = "Pripyat observer's notebook",
			},
			benefits = {},
		},
		{
			id = "SP17",
			completionCash = 1475,
			name = "Preparing for the Worst",
			kind = "delivery",
			requires = {"SP15"},
			briefing = "There's a supply list for field work. Keep your own return kit separate from the hand-in.",
			completion = "Good. I'll put this with the field supplies.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 5,
				},
			},
			benefits = {},
		},
		{
			id = "SP18",
			completionCash = 2050,
			name = "The Survivor's Cache",
			kind = "field",
			objective = (
				"Recover the abandoned hunter's case from the assigned search area in Pripyat. Bring it back to "
				.. "the issuing contact in Garbage."
			),
			requires = {"SP16"},
			briefing = (
				"Recover the hunter's case. An abandoned load can mean several things; bring it home before we "
				.. "choose one. Recover the abandoned hunter's case from the assigned search area in Pripyat. Bring "
				.. "it back to me in Garbage."
			),
			completion = "Here. I'll see what belongs with the observations.",
			field = {
				description = (
					"A low hard case with long contrasting strips across its ribbed lid. Spoor's note: \"Recover the "
					.. "hunter's case.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_equipment",
				label = "Abandoned hunter's case",
			},
			benefits = {
				items = {
					{
						item = "22lr",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "SP19",
			completionCash = 0,
			name = "The Dangerous Ones",
			kind = "tracker",
			requires = {"SP17", "SP18"},
			briefing = "More hunting orders. Keep enough supplies for the way back.",
			completion = "You've brought a lot of work home. Take time to put it down.",
			target = 20,
			benefits = {},
		},
		{
			id = "SP20",
			completionCash = 2250,
			name = "The Last Observation",
			kind = "field",
			objective = (
				"Recover the last species observation tape from the assigned search area in Pripyat. Bring it back "
				.. "to the issuing contact in Garbage."
			),
			requires = {"SP19"},
			briefing = (
				"I want the last observation recording. It may help us judge which behaviour was actually seen. "
				.. "Recover the last species observation tape from the assigned search area in Pripyat. Bring it back "
				.. "to me in Garbage."
			),
			completion = "Thank you. I'll listen to the account as it stands.",
			field = {
				description = (
					"A pale audio cassette with a broad blue printed label and twin spool windows. Spoor's note: \"I "
					.. "want the last observation recording.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_tape2",
				label = "Last species observation tape",
			},
			benefits = {},
			stock = {
				item = "12gauge",
				bonus = 2,
			},
		},
		{
			id = "SP21",
			completionCash = 1775,
			name = "What the Records Missed",
			kind = "delivery",
			requires = {"SP20"},
			briefing = "I'd like the requested material brought in without damage from the journey.",
			completion = "That's usable. I'll take a closer look.",
			requirements = {
				{
					pool = "common_parts",
					quantity = 2,
				},
			},
			benefits = {},
		},
		{
			id = "SP22",
			completionCash = 2450,
			name = "The Hunter's Proof",
			kind = "field",
			objective = (
				"Recover the final hunting journal from the assigned search area in Garbage. Bring it back to the "
				.. "issuing contact in Garbage."
			),
			requires = {"SP21"},
			briefing = (
				"The final observations are back in Garbage. I want them beside the rest before calling the "
				.. "account complete. Recover the final hunting journal from the assigned search area in Garbage. "
				.. "Bring it back to me in Garbage."
			),
			completion = (
				"You've stayed with the work past the first good story. I appreciate that. Leave the journal here; "
				.. "we can look through it without needing to prove anything for a moment."
			),
			field = {
				description = (
					"A thick brown journal held together by a narrow tie around its cover. Spoor's note: \"The final "
					.. "observations are back in Garbage.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_notebook",
				label = "Final hunting journal",
			},
			benefits = {},
			recognition = "Spoor's trusted contact",
		},
	},
})
