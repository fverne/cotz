PLUGIN:Register("the-original", {
	name = "'The Original'",
	template = "firststalkernpc",
	map = "rp_marsh_cs",
	job = {
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		category = "Mutant specimen deliveries",
		description = "Mutant specimen deliveries",
		pools = {"common_parts", "small_parts", "common_hides"},
		deliveryTiers = {
			easy = {
				pools = {
					"valuables_personal_effects",
				},
				quantity = 1,
			},
			medium = {
				pools = {
					"valuables_decorative_valuables",
				},
				quantity = 1,
			},
			hard = {
				pools = {
					"valuables_irregular_patches",
					"valuables_specialist_cases",
				},
				quantity = 2,
			},
		},
		quantities = {2, 4, 7},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Expedition provisions",
				items = {"food_can_tushonka", "drink_bottlewater"}},
			{label = "Camp supplies",
				items = {"lowtiercookerfuel", "food_bread"}},
			{label = "Close encounters",
				items = {"medic_bandage_1", "12gauge"}},
		},
	},
	dialogue = {
		delivery = "Bring it over. Let me have a look at what survived.",
		completedGreeting = (
			"Come to check another of my stories? All right. At least you usually bring a question worth "
			.. "answering."
		),
		workPrompt = "About the collection request.",
		offerPrompt = "Do you have a delivery request?",
		work = (
			"Specimens, and the recovered objects listed on the order. Parts tell one sort of story; personal "
			.. "things, old recordings and insignia tell another. Check which request you're taking before "
			.. "deciding what to bring. I want to examine what's there, not spend the afternoon arguing about a "
			.. "magnificent example you left somewhere else."
		),
		progressionPrompt = "What do you want to compare with your account?",
		progression = (
			"There are things I'd like to put beside my own account. Specimens, surviving expedition records, "
			.. "something more useful than a disagreement about which of us remembers best. Start with a request "
			.. "you can fill. We'll inspect what comes back before deciding what it proves. You can reserve the "
			.. "triumphant expression until then."
		),
	},
	catalogue = {
	},
	progression = {
		{
			id = "OR01",
			completionCash = 275,
			name = "A Familiar Beast",
			kind = "delivery",
			requires = {},
			briefing = (
				"Bring me the parts on this list. I've handled enough specimens to know a useful one when I "
				.. "see it. We'll start with something familiar, and you can decide for yourself whether "
				.. "listening to an old stalker is worth your time."
			),
			completion = (
				"Let's have a look. Yes, that will do. There's more to learn from a specimen than whether "
				.. "you managed to put it down. We'll leave the rest for another day."
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
						item = "drink_bottlewater",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "OR02",
			completionCash = 450,
			name = "Where It Fed",
			kind = "field",
			objective = (
				"Recover the feeding-ground journal from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"OR01"},
			briefing = (
				"Bring the feeding observations back. The animal people remember seeing isn't always the only "
				.. "thing that used the ground. Recover the feeding-ground journal from the assigned search area in "
				.. "Marsh. Bring it back to me in Marsh."
			),
			completion = (
				"Let me read the ordinary entries first. People rush past those when they've heard there's a story "
				.. "coming."
			),
			field = {
				description = (
					"A thick brown journal held together by a narrow tie around its cover. The Original's note: "
					.. "\"Bring the feeding observations back.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "Feeding-ground journal",
			},
			benefits = {},
		},
		{
			id = "OR03",
			completionCash = 0,
			name = "Proof in the Bag",
			kind = "tracker",
			requires = {"OR02"},
			briefing = "Continue the specimen deliveries. Bring the requested parts in a condition I can inspect.",
			completion = "A useful beginning. We've got more than a single example to discuss.",
			target = 2,
			benefits = {},
		},
		{
			id = "OR04",
			completionCash = 650,
			name = "The First Account",
			kind = "field",
			objective = (
				"Recover the early expedition diary from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"OR03"},
			briefing = (
				"There's an old expedition note to collect. I'd like to see what somebody wrote then, before we "
				.. "all became experts on our memories. Recover the early expedition diary from the assigned search "
				.. "area in Marsh. Bring it back to me in Marsh."
			),
			completion = "Hand it here. I'll see what I recognise before I explain what they must have meant.",
			field = {
				description = (
					"A thick blue diary with a label fixed to the front cover. The Original's note: \"There's an old "
					.. "expedition note to collect.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_diary",
				label = "Early expedition diary",
			},
			benefits = {},
		},
		{
			id = "OR05",
			completionCash = 575,
			name = "Teeth and Hide",
			kind = "delivery",
			requires = {"OR04"},
			briefing = "Bring the listed specimens here. I want a close look before deciding which story they belong in.",
			completion = "Leave them there. I'll examine what actually survived.",
			requirements = {
				{
					pool = "common_parts",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "OR06",
			completionCash = 850,
			name = "The Wrong Tracks",
			kind = "field",
			objective = (
				"Recover the disputed hunting recording from the assigned search area in Marsh. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"OR04"},
			briefing = (
				"I want the hunting-site recording. Spoor can have an opinion on it after I've actually heard the "
				.. "thing. Recover the disputed hunting recording from the assigned search area in Marsh. Bring it "
				.. "back to me in Marsh."
			),
			completion = "Put it down. I'll listen to the account, including the part that may spoil mine.",
			field = {
				description = (
					"A pale audio cassette with a handwritten dedication above the spool windows. The Original's "
					.. "note: \"I want the hunting-site recording.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_tape",
				label = "Disputed hunting recording",
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
			id = "OR07",
			completionCash = 0,
			name = "Different Quarry",
			kind = "tracker",
			requires = {"OR05"},
			briefing = "More specimen requests when you're ready. Check the order before choosing the quarry.",
			completion = "You've kept bringing useful material. Better than another confident description.",
			target = 5,
			benefits = {},
		},
		{
			id = "OR08",
			completionCash = 1050,
			name = "The Scarred Tree",
			kind = "field",
			objective = (
				"Recover the scarred-ground field sketchbook from the assigned search area in Garbage. Bring it "
				.. "back to the issuing contact in Marsh."
			),
			requires = {"OR06"},
			briefing = (
				"There's a field sketch to recover in Garbage. I want the drawing rather than another description "
				.. "of what it resembles. Recover the scarred-ground field sketchbook from the assigned search area "
				.. "in Garbage. Bring it back to me in Marsh."
			),
			completion = (
				"Good. Let me turn it round. People remember a shape differently after they've been told what to "
				.. "see."
			),
			field = {
				description = (
					"A thick brown journal held together by a narrow tie around its cover. The Original's note: "
					.. "\"There's a field sketch to recover in Garbage.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "Scarred-ground field sketchbook",
			},
			benefits = {},
		},
		{
			id = "OR09",
			completionCash = 875,
			name = "What Changed",
			kind = "delivery",
			requires = {"OR07"},
			briefing = (
				"There's another specimen request. A familiar animal can still give you something you weren't "
				.. "expecting."
			),
			completion = "Good. I'll compare the details rather than simply recognising the name.",
			requirements = {
				{
					pool = "common_parts",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "OR10",
			completionCash = 1250,
			name = "A Story With Dates",
			kind = "field",
			objective = (
				"Recover the dated expedition log for Carbon from the assigned search area in Marsh. Deliver it to "
				.. "'Carbon' in Waystation, then come back to the issuing contact in Marsh."
			),
			requires = {"OR08"},
			briefing = (
				"Carbon needs the dated expedition book. If he wants to question my dates, he should have the "
				.. "original beside him. Recover the dated expedition log for Carbon from the assigned search area in "
				.. "Marsh. Deliver it to 'Carbon' in Waystation, then come back to me in Marsh."
			),
			completion = "He has it. Fine. I'll hear what the pages support, even if I don't enjoy the conversation.",
			field = {
				description = (
					"A thick blue diary with a label fixed to the front cover. The Original's note: \"Carbon needs the "
					.. "dated expedition book.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_diary",
				label = "Dated expedition log for Carbon",
				recipient = "carbon",
			},
			benefits = {},
		},
		{
			id = "OR11",
			completionCash = 0,
			name = "Enough to Compare",
			kind = "tracker",
			requires = {"OR09"},
			briefing = "Keep the specimen orders moving while I compare the old accounts.",
			completion = "There's enough here to make some of my first impressions uncomfortable. Good work.",
			target = 9,
			benefits = {},
		},
		{
			id = "OR12",
			completionCash = 1450,
			name = "The Second Witness",
			kind = "field",
			objective = (
				"Recover the second witness's cassette from the assigned search area in Marsh. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"OR10"},
			briefing = (
				"There's another witness recording to bring back. I'd rather hear it before declaring we agree. "
				.. "Recover the second witness's cassette from the assigned search area in Marsh. Bring it back to me "
				.. "in Marsh."
			),
			completion = "Here. I'll listen without interrupting it to argue. A useful feature of a recording.",
			field = {
				description = (
					"A pale audio cassette with a broad blue printed label and twin spool windows. The Original's "
					.. "note: \"There's another witness recording to bring back.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_tape2",
				label = "Second witness's cassette",
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
			id = "OR13",
			completionCash = 1175,
			name = "Old Wounds",
			kind = "delivery",
			requires = {"OR11"},
			briefing = (
				"Bring what's listed here. I want to examine it before deciding what to make of it. "
				.. "Don't decide the answer before the work is done. I've heard enough confident guesses "
				.. "from people who never went to look."
			),
			completion = (
				"Let me see the condition of it. I'll consider that alongside what I already know. You "
				.. "needn't look so impatient; being old doesn't mean I read without looking."
			),
			requirements = {
				{
					pool = "common_parts",
					quantity = 2,
				},
			},
			benefits = {},
		},
		{
			id = "OR14",
			completionCash = 1650,
			name = "The Camp Before This One",
			kind = "field",
			objective = (
				"Recover the earlier camp journal from the assigned search area in Waystation. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"OR12"},
			briefing = (
				"Recover the old camp record. I want the account from when it was a working camp, before it became "
				.. "a place people tell stories about. Recover the earlier camp journal from the assigned search area "
				.. "in Waystation. Bring it back to me in Marsh."
			),
			completion = "Let me read it. The little entries may place the journey better than the memorable ones.",
			field = {
				description = (
					"A thick brown journal held together by a narrow tie around its cover. The Original's note: "
					.. "\"Recover the old camp record.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_notebook",
				label = "Earlier camp journal",
			},
			benefits = {},
		},
		{
			id = "OR15",
			completionCash = 0,
			name = "A Hunter's Patience",
			kind = "tracker",
			requires = {"OR13"},
			briefing = "Continue the requested specimen deliveries. Small differences are worth carrying too.",
			completion = "You've stayed patient with the comparisons. I notice that.",
			target = 14,
			benefits = {},
		},
		{
			id = "OR16",
			completionCash = 1850,
			name = "The Name He Forgot",
			kind = "field",
			objective = (
				"Recover the incomplete expedition diary from the assigned search area in Marsh. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"OR14"},
			briefing = (
				"Bring back the surviving diary. A missing name is worth looking into; it isn't an invitation to "
				.. "choose one that fits. Recover the incomplete expedition diary from the assigned search area in "
				.. "Marsh. Bring it back to me in Marsh."
			),
			completion = "Keep it open there. I'll check the surrounding pages before trusting recognition.",
			field = {
				description = (
					"A thick blue diary with a label fixed to the front cover. The Original's note: \"Bring back the "
					.. "surviving diary.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_diary",
				label = "Incomplete expedition diary",
			},
			benefits = {},
		},
		{
			id = "OR17",
			completionCash = 1475,
			name = "A Different Kind of Proof",
			kind = "delivery",
			requires = {"OR15"},
			briefing = (
				"Bring the requested records intact. I can argue with a page much more usefully when the whole "
				.. "thing is present."
			),
			completion = "Hand it here. I'll read before becoming offended.",
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 2,
				},
			},
			benefits = {},
		},
		{
			id = "OR18",
			completionCash = 2050,
			name = "The Route He Remembers",
			kind = "field",
			objective = (
				"Recover the old route file for Atlas from the assigned search area in Pripyat. Deliver it to "
				.. "'Atlas' in Marsh, then come back to the issuing contact in Marsh."
			),
			requires = {"OR16"},
			briefing = (
				"Atlas should have the route record. He can compare my description with what's written without me "
				.. "leaning over the paper. Recover the old route file for Atlas from the assigned search area in "
				.. "Pripyat. Deliver it to 'Atlas' in Marsh, then come back to me in Marsh."
			),
			completion = "Delivered. He'll ask awkward questions. Better those than a comfortable wrong turn.",
			field = {
				description = (
					"A cardboard file folder with a small coloured crest on its cover. The Original's note: \"Atlas "
					.. "should have the route record.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_official",
				label = "Old route file for Atlas",
				recipient = "atlas",
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
			id = "OR19",
			completionCash = 0,
			name = "The Worst of It",
			kind = "tracker",
			requires = {"OR17"},
			briefing = "There are more specimens to bring through. Keep the requested material intact.",
			completion = "You've given me something worth questioning instead of merely agreeing with me.",
			target = 20,
			benefits = {},
		},
		{
			id = "OR20",
			completionCash = 2250,
			name = "Under the Old Mark",
			kind = "field",
			objective = (
				"Recover the marked expedition evidence from the assigned search area in Pripyat. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"OR18"},
			briefing = (
				"There's expedition evidence in Pripyat. Bring it back together; I want to see what survived, not "
				.. "what someone selected to illustrate my story. Recover the marked expedition evidence from the "
				.. "assigned search area in Pripyat. Bring it back to me in Marsh."
			),
			completion = "Leave it here. I can wait to be right until we've opened the case.",
			field = {
				description = (
					"A compact hard case with orange panels, dark protective ribs and a carrying handle. The "
					.. "Original's note: \"There's expedition evidence in Pripyat.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_evidence",
				label = "Marked expedition evidence",
			},
			benefits = {},
		},
		{
			id = "OR21",
			completionCash = 1775,
			name = "No Two Alike",
			kind = "delivery",
			requires = {"OR19", "OR20"},
			briefing = "Bring the listed specimens here. I want a close look before deciding which story they belong in.",
			completion = "Leave them there. I'll examine what actually survived.",
			requirements = {
				{
					pool = "common_parts",
					quantity = 2,
				},
			},
			benefits = {},
		},
		{
			id = "OR22",
			completionCash = 2450,
			name = "The Place in the Story",
			kind = "field",
			objective = (
				"Recover the encounter witness recording from the assigned search area in Pripyat. Bring it back "
				.. "to the issuing contact in Marsh."
			),
			requires = {"OR21"},
			briefing = (
				"Recover the last encounter recording. I've told the account often enough; it's somebody else's "
				.. "turn to be heard. Recover the encounter witness recording from the assigned search area in "
				.. "Pripyat. Bring it back to me in Marsh."
			),
			completion = "I'll listen. If it contradicts me, we'll talk about that after it's finished.",
			field = {
				description = (
					"A pale audio cassette with a handwritten dedication above the spool windows. The Original's "
					.. "note: \"Recover the last encounter recording.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_tape",
				label = "Encounter witness recording",
			},
			benefits = {},
		},
		{
			id = "OR23",
			completionCash = 0,
			name = "First Does Not Mean Last",
			kind = "tracker",
			requires = {"OR22"},
			briefing = "Keep completing the specimen requests when you're prepared.",
			completion = (
				"You've kept looking after the first easy explanation ran out. I respect that sort of "
				.. "stubbornness."
			),
			target = 27,
			benefits = {},
		},
		{
			id = "OR24",
			completionCash = 2650,
			name = "What Actually Happened",
			kind = "field",
			objective = (
				"Recover the final expedition personnel file from the assigned search area in Marsh. Bring it back "
				.. "to the issuing contact in Marsh."
			),
			requires = {"OR23"},
			briefing = (
				"Bring the complete file. If we're going to pick at an old account, we can at least do it with all "
				.. "the pages in front of us. Recover the final expedition personnel file from the assigned search "
				.. "area in Marsh. Bring it back to me in Marsh."
			),
			completion = (
				"Set it beside me. You stayed to check the story after it stopped being easy company. I respect "
				.. "that. Let's read it before either of us supplies the ending."
			),
			field = {
				description = (
					"A cardboard file folder with an emblem and printed wording on the front. The Original's note: "
					.. "\"Bring the complete file.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_personnel",
				label = "Final expedition personnel file",
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
			recognition = "The Original's trusted contact",
		},
	},
})
