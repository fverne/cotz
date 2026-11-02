PLUGIN:Register("atlas", {
	name = "'Atlas'",
	template = "atlasnpc",
	map = "rp_marsh_cs",
	job = {
		kind = "sensor",
		category = "Sensor deployment and retrieval",
		description = "Sensor deployment and retrieval",
		maps = {
			easy = "rp_marsh_cs",
			medium = "mz_garbage",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Survey provisions",
				items = {"drink_bottlewater", "food_raisins"}},
			{label = "Field safety",
				items = {"medic_bandage_1", "medic_antirad_1"}},
			{label = "Long survey",
				items = {"food_can_beans", "drink_bottletea"}},
		},
		bonusItems = {
			"compass",
		},
	},
	dialogue = {
		delivery = (
			"Here, beside the notes. Thank you for bringing it through; I'll check the details before I "
			.. "file it."
		),
		completedGreeting = (
			"Hello again. I've made room beside the finished sheets. Sit down, if you have time. I'd like "
			.. "to hear about a walk that didn't begin with me asking you to fetch something."
		),
		workPrompt = "Tell me about your survey work.",
		offerPrompt = "Do you have a survey assignment?",
		work = (
			"I need recordings from assigned sites. You'll deploy the recorder, let it finish, collect "
			.. "the results, and bring them back to me. The farther assignments take more preparation, so "
			.. "have a look at the destination before you agree. And pay attention to your walk, if you can. "
			.. "The recorder gives me a reading; it won't tell me why you had to double back three times to "
			.. "reach it. We can talk about that when you're home."
		),
		progressionPrompt = "What are you working on at the moment?",
		progression = (
			"I'm comparing our surveys with records left by other teams. Some entries are very careful. "
			.. "Others make perfect sense until you try to follow them. I'd like help checking the gaps, and "
			.. "recovering what hasn't made it back. We'll begin here in Marsh. There's no need to commit "
			.. "yourself to the whole undertaking today. Choose something manageable, and we can see how we "
			.. "work together."
		),
	},
	catalogue = {
	},
	progression = {
		{
			id = "AT01",
			completionCash = 275,
			name = "Marks on Paper",
			kind = "delivery",
			requires = {},
			briefing = (
				"Before we send anything out, I need to put together the maintenance supplies on this list. "
				.. "Bring them here. I tend to spread everything out and check it twice; much easier to find "
				.. "something missing on the table than halfway through a walk."
			),
			completion = (
				"Yes, that covers the list. Thank you. I'll pack these after I've cleared a space. Somehow I "
				.. "can organize a survey and still run out of table."
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
			id = "AT02",
			completionCash = 450,
			name = "The First Landmark",
			kind = "field",
			objective = (
				"Deploy the recorder at the assigned site in Marsh, let it finish recording, then retrieve the "
				.. "first Marsh survey recording. Bring it back to the issuing contact in Marsh."
			),
			requires = {"AT01"},
			briefing = (
				"Let's begin with a recording here in Marsh. Take the recorder to the assigned site, let it "
				.. "finish, and bring the results back here. Have a look at the approach while you're there. "
				.. "Afterwards we can compare what the instrument recorded with how you found the place."
			),
			completion = (
				"You're back. Good. Put the results here. How did you find the approach? Take a moment to "
				.. "think; I can check the recording while you catch your breath."
			),
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. An initial "
					.. "Marsh recording for comparison with the approach on foot."
				),
				kind = "sensor",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_module",
				label = "First Marsh survey recording",
			},
			benefits = {},
		},
		{
			id = "AT03",
			completionCash = 0,
			name = "Repeatable Ground",
			kind = "tracker",
			requires = {"AT02"},
			briefing = (
				"A single trip leaves me with rather a lot of questions. Keep taking my survey assignments: "
				.. "deploy the recorder, let it finish, and return the results. A few completed runs will give "
				.. "us something to compare without asking one reading to explain everything."
			),
			completion = (
				"That's a useful start. I can begin comparing the surveys now. You've also given me a better "
				.. "idea of what I can reasonably ask of you, which matters just as much when I'm planning the "
				.. "next trip."
			),
			target = 2,
			benefits = {},
		},
		{
			id = "AT04",
			completionCash = 650,
			name = "The Route That Shifted",
			kind = "field",
			objective = (
				"Recover the route recorder from the assigned search area in Marsh. Bring it back to the issuing "
				.. "contact in Marsh."
			),
			requires = {"AT02"},
			briefing = (
				"There's a recorder to recover from the assigned search area in Marsh. Bring it back here. I "
				.. "want to compare the surviving record with the approach as it is now. Don't assume an older "
				.. "entry describes a walk you can still make comfortably."
			),
			completion = (
				"Thank you. I'll keep the recovery location with the record. I have a habit of starting the "
				.. "comparison immediately; remind me to let you put your pack down first."
			),
			field = {
				description = (
					"A flat dark electronic module marked with a number and three pale bars. The surviving route "
					.. "record Atlas wants to compare with present conditions."
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_module2",
				label = "route recorder",
			},
			benefits = {},
		},
		{
			id = "AT05",
			completionCash = 575,
			name = "A Better Baseline",
			kind = "delivery",
			requires = {"AT03"},
			briefing = (
				"I need a tool from the selection on the list. Bring it here so I can check it before it "
				.. "goes into the survey kit. Something dependable will do. I'd rather know a tool's "
				.. "limitations than spend a morning discovering them outside."
			),
			completion = (
				"That will do nicely. I'll check it over before packing it. You'd be surprised how often a "
				.. "small adjustment here saves a very long complaint later."
			),
			requirements = {
				{
					pool = "basic_tools",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "AT06",
			completionCash = 850,
			name = "Ballast's Shortcut",
			kind = "field",
			objective = (
				"Recover the waterside journal for Ballast from the assigned search area in Marsh. Deliver it to "
				.. "'Ballast' in Marsh, then come back to the issuing contact in Marsh."
			),
			requires = {"AT04"},
			briefing = (
				"Recover the waterside journal from the assigned area in Marsh and take it to Ballast, also "
				.. "here in Marsh. Then come back to me. He should have the record to consult himself before I "
				.. "ask him more questions about the approach. He already accuses me of discussing ground I "
				.. "haven't stood on recently enough."
			),
			completion = (
				"The journal reached Ballast, then. Good. I can ask him about it without making him rely on "
				.. "my account of somebody else's notes. That should remove at least one of his objections."
			),
			field = {
				description = (
					"A thick brown journal held together by a narrow tie around its cover. A waterside account for "
					.. "Ballast to check against his local knowledge."
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "Waterside journal for Ballast",
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
			id = "AT07",
			completionCash = 0,
			name = "Measured Twice",
			kind = "tracker",
			requires = {"AT05"},
			briefing = (
				"Keep bringing back completed survey assignments. We're building a comparison across several "
				.. "runs. Don't hurry the recorder to get through them; each one still needs to finish before "
				.. "you retrieve the results and return here."
			),
			completion = (
				"We've enough completed work for the next comparison. Thank you for staying with it. "
				.. "Repetition can feel rather unrewarding when you're the one doing the walking; this is where "
				.. "it starts helping me spot what deserves another look."
			),
			target = 5,
			benefits = {},
		},
		{
			id = "AT08",
			completionCash = 1050,
			name = "The Missing Surveyor",
			kind = "field",
			objective = (
				"Recover the missing surveyor's diary from the assigned search area in Garbage. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"AT06"},
			briefing = (
				"A surveyor's notebook is still out in the assigned Garbage search area. Recover it and bring "
				.. "it here. I'd like to see what they actually wrote before deciding where their work was "
				.. "leading. A missing record can acquire a remarkably elaborate story while nobody is reading "
				.. "it."
			),
			completion = (
				"Let me clear a dry space for that. I'll read it through before trying to fit it to the "
				.. "survey. I don't want to overlook an ordinary explanation because I've become attached to a "
				.. "more interesting one."
			),
			field = {
				description = (
					"A thick blue diary with a label fixed to the front cover. The missing surveyor's surviving "
					.. "notes, kept together for Atlas to examine."
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_diary",
				label = "Missing surveyor's diary",
			},
			benefits = {},
		},
		{
			id = "AT09",
			completionCash = 875,
			name = "Paper Trail",
			kind = "delivery",
			requires = {"AT07"},
			briefing = (
				"I need records from the selection on the list, brought here. Comparing accounts is easier "
				.. "when I can lay them alongside one another. At present I keep turning back to a page and "
				.. "discovering it's the one I haven't got."
			),
			completion = (
				"Thank you. That gives me more to work with. I'll sort these before I start comparing them, "
				.. "or we'll lose the afternoon to my increasingly untidy filing."
			),
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "AT10",
			completionCash = 1250,
			name = "An Unfinished Map",
			kind = "field",
			objective = (
				"Recover the unfinished survey cassette from the assigned search area in Garbage. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"AT08"},
			briefing = (
				"There's an audio cassette to recover in the assigned search area in Garbage. Bring it back "
				.. "to me in Marsh. Written notes often leave out the small decisions made along the way; I'm "
				.. "hoping the recording gives me something I can check against them."
			),
			completion = (
				"Here, please. I'll listen through before making any additions. If the account is unclear, "
				.. "I'd like to hear it twice before I decide what the speaker meant."
			),
			field = {
				description = (
					"A pale audio cassette with a handwritten dedication above the spool windows. A surviving audio "
					.. "account intended to accompany the written survey notes."
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_tape",
				label = "Unfinished survey cassette",
			},
			benefits = {},
		},
		{
			id = "AT11",
			completionCash = 0,
			name = "Ground Truth",
			kind = "tracker",
			requires = {"AT09"},
			briefing = (
				"Continue the survey assignments and return each completed set of results. I need more "
				.. "observations to compare. We're quite good at inventing explanations once we have a little "
				.. "information; I'd like enough information to discard a few of mine."
			),
			completion = (
				"That's enough completed surveys for this stage. I can sit down with the comparison now. "
				.. "It's rather satisfying to reach the point where I can ask a narrower question than 'what on "
				.. "earth happened here?'"
			),
			target = 9,
			benefits = {},
		},
		{
			id = "AT12",
			completionCash = 1450,
			name = "The Freight Route",
			kind = "field",
			objective = (
				"Recover the freight-route manifest for Ledger from the assigned search area in Marsh. Deliver it "
				.. "to 'Ledger' in Waystation, then come back to the issuing contact in Marsh."
			),
			requires = {"AT10"},
			briefing = (
				"Recover the packing list from the assigned area in Marsh, deliver it to Ledger in "
				.. "Waystation, then return to me here. Freight records can help us place a journey, but Ledger "
				.. "needs the original to consult. I can wait for your return; don't make the journey harder by "
				.. "treating it as a race."
			),
			completion = (
				"Thank you for seeing it through to Ledger and coming back. I can mark the delivery "
				.. "complete. Keeping the records with someone who can find them again is an achievement I "
				.. "appreciate more every year."
			),
			field = {
				description = (
					"A printed packing list on a small clipboard with a metal clip and a circular stamp. The original "
					.. "freight list Ledger needs to consult while checking the journey."
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_manifest",
				label = "Freight-route manifest for Ledger",
				recipient = "ledger",
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
			id = "AT13",
			completionCash = 1175,
			name = "Lines That Agree",
			kind = "delivery",
			requires = {"AT11"},
			briefing = (
				"The survey kit needs another round of maintenance supplies. Bring what's listed here. I'd "
				.. "like to prepare it before we need it. It's terribly easy to postpone that while there's a "
				.. "more interesting page to read."
			),
			completion = (
				"Good, thank you. I'll deal with these before I go back to the papers. You may hold me to "
				.. "that if you catch me reaching for a pencil."
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
			id = "AT14",
			completionCash = 1650,
			name = "The Wrong Coordinates",
			kind = "field",
			objective = (
				"Recover the disputed coordinate file from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"AT12"},
			briefing = (
				"Recover the file folder from the assigned search area in Marsh and bring it here. I want to "
				.. "check the disputed coordinates against the source. A copied number can look completely "
				.. "respectable through several more copies; I'd rather start as close to the original account "
				.. "as we can."
			),
			completion = (
				"That's the folder. Thank you. I'll compare the entries carefully. Finding a discrepancy is "
				.. "the easy part; explaining which entry deserves confidence takes a little longer."
			),
			field = {
				description = (
					"A cardboard file folder with a small coloured crest on its cover. A source file Atlas wants to "
					.. "examine before trusting copied coordinates."
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_official",
				label = "Disputed coordinate file",
			},
			benefits = {},
		},
		{
			id = "AT15",
			completionCash = 0,
			name = "Beyond the Margin",
			kind = "tracker",
			requires = {"AT13"},
			briefing = (
				"Keep completing the survey assignments and bringing back the results. I need a broader set "
				.. "of observations before I take this comparison further. The individual trips still matter, "
				.. "even when the paperwork starts calling them a total."
			),
			completion = (
				"You've kept the surveys coming. I appreciate it. I spend enough time with the results that "
				.. "I have to remind myself how much walking sits behind each neat entry."
			),
			target = 14,
			benefits = {},
		},
		{
			id = "AT16",
			completionCash = 1850,
			name = "The Lost Team's Cache",
			kind = "field",
			objective = (
				"Recover the survey team's case for Wake from the assigned search area in Waystation. Deliver it "
				.. "to 'Wake' in Garbage, then come back to the issuing contact in Marsh."
			),
			requires = {"AT14"},
			briefing = (
				"Recover the team's equipment case from the assigned search area in Waystation. Take it to "
				.. "Wake in Garbage, then return here to Marsh. She needs the case for her own checks. I'd "
				.. "rather she examined it herself than have me tell her which details I thought worth "
				.. "noticing."
			),
			completion = (
				"Wake has the case. Thank you. There's a limit to what I can establish from a route alone, "
				.. "and I don't like pretending otherwise. I'm glad the things she needs to examine reached her "
				.. "intact."
			),
			field = {
				description = (
					"A low hard case with long contrasting strips across its ribbed lid. The survey team's surviving "
					.. "equipment, kept intact for Wake's checks."
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_equipment",
				label = "Survey team's case for Wake",
				recipient = "wake",
			},
			benefits = {},
		},
		{
			id = "AT17",
			completionCash = 1475,
			name = "Preparing the Last Sheet",
			kind = "delivery",
			requires = {"AT15"},
			briefing = (
				"I need the small electronics on this list for the survey preparations. Bring them here, "
				.. "please. I'd like time to check and pack them while we can still replace something "
				.. "unsuitable without another expedition."
			),
			completion = (
				"That covers the list. I'll check the components and set them aside. It's a relief to finish "
				.. "a bit of preparation before it becomes urgent."
			),
			requirements = {
				{
					pool = "small_electronics",
					quantity = 5,
				},
			},
			benefits = {},
		},
		{
			id = "AT18",
			completionCash = 2050,
			name = "The First Pripyat Mark",
			kind = "field",
			objective = (
				"Deploy the recorder at the assigned site in Pripyat, let it finish recording, then retrieve the "
				.. "first Pripyat survey recording. Bring it back to the issuing contact in Marsh."
			),
			requires = {"AT16"},
			briefing = (
				"This recording is in Pripyat. Check your supplies and the assigned destination before "
				.. "setting out. Deploy the recorder, allow it to finish, retrieve the results, and return here "
				.. "to Marsh. If you need to turn back and prepare again, do so. I'd rather discuss a postponed "
				.. "survey than wait for someone who felt obliged to press on."
			),
			completion = (
				"It's good to see you. Put the results down and take a moment. I'll want to hear how you "
				.. "found the journey, but there's time for that. You needn't give me a report while you're "
				.. "still standing with your pack on."
			),
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. A Pripyat "
					.. "survey recording for comparison with the earlier route work."
				),
				kind = "sensor",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module",
				label = "First Pripyat survey recording",
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
			id = "AT19",
			completionCash = 0,
			name = "A Map Worth Carrying",
			kind = "tracker",
			requires = {"AT17", "AT18"},
			briefing = (
				"Both parts of the work have brought us this far. Keep completing my survey assignments; I "
				.. "need the remaining comparison before the final work. You've already spent a great deal of "
				.. "time on this. Take the next trips at a pace you can sustain."
			),
			completion = (
				"We've reached the survey total I needed. Thank you. Having both the recovered records and "
				.. "this much completed fieldwork gives me a much better place to begin the final comparison."
			),
			target = 20,
			benefits = {},
		},
		{
			id = "AT20",
			completionCash = 2250,
			name = "The Last Survey Station",
			kind = "field",
			objective = (
				"Recover the last survey-station cassette from the assigned search area in Pripyat. Bring it back "
				.. "to the issuing contact in Marsh."
			),
			requires = {"AT19"},
			briefing = (
				"There's a final audio cassette to recover from the assigned search area in Pripyat. Bring "
				.. "it back here. I want to hear it in full before finishing the account. It may leave "
				.. "questions open. I'd still rather preserve what the team recorded than improve it with "
				.. "guesses."
			),
			completion = (
				"Thank you. Leave the cassette here. I find I've been putting off deciding where it should "
				.. "go on the table, as though that were the difficult part. I'll listen carefully. They took "
				.. "the trouble to make the record; I can take the time to hear it."
			),
			field = {
				description = (
					"A pale audio cassette with a handwritten dedication above the spool windows. The station's "
					.. "surviving audio account, to be heard in full before the survey is concluded."
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_tape",
				label = "Last survey-station cassette",
			},
			benefits = {},
			stock = {
				item = "drink_bottlewater",
				bonus = 2,
			},
		},
		{
			id = "AT21",
			completionCash = 1775,
			name = "An Atlas With Names",
			kind = "delivery",
			requires = {"AT20"},
			briefing = (
				"One more delivery of maintenance supplies, from the list. Bring them here. We still have a "
				.. "final recording ahead, and I want the equipment prepared properly. I'm trying to keep my "
				.. "mind on that rather than on how the finished sheets will look."
			),
			completion = (
				"That's everything I asked for. Thank you. I'll pack it now. There's some comfort in having "
				.. "a useful, ordinary job to do while the rest takes time to settle."
			),
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 6,
				},
			},
			benefits = {},
		},
		{
			id = "AT22",
			completionCash = 2450,
			name = "Finish Their Route",
			kind = "field",
			objective = (
				"Deploy the recorder at the assigned site in Pripyat, let it finish recording, then retrieve the "
				.. "final route survey recording. Bring it back to the issuing contact in Marsh."
			),
			requires = {"AT21"},
			briefing = (
				"There's one last site to record in Pripyat. Deploy the recorder at the assigned location, "
				.. "let it finish, retrieve the results, and bring them back here. You've helped carry this "
				.. "work a long way. I hope you'll give the return journey the same care you've given the "
				.. "survey."
			),
			completion = (
				"Here we are. Put it beside the other results. I'll enter this with the team's surviving "
				.. "work, and keep their names with their observations. You've given me the chance to finish "
				.. "the comparison properly. Thank you. Stay a little, if you can. I'd rather you weren't "
				.. "already halfway out the door when I finally put the pencil down."
			),
			field = {
				description = (
					"A flat dark electronic module marked with a number and three pale bars. The final assigned "
					.. "survey recording, brought home to complete Atlas's comparison."
				),
				kind = "sensor",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module2",
				label = "Final route survey recording",
			},
			benefits = {},
			recognition = "Atlas's trusted contact",
		},
	},
})
