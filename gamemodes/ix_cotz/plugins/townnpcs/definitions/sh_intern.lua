PLUGIN:Register("intern", {
	name = "'Intern'",
	template = "ecologistnpc3",
	map = "rp_waystation",
	job = {
		kind = "sensor",
		category = "Sensor deployment and retrieval",
		description = "Sensor deployment and retrieval",
		maps = {
			easy = "rp_waystation",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Routine survey",
				items = {"drink_bottlewater", "medic_bandage_1"}},
			{label = "Exposure precautions",
				items = {"medic_antirad_1"}},
			{label = "Overtime",
				items = {"drug_caffeine", "food_raisins"}},
		},
	},
	dialogue = {
		completedGreeting = (
			"Hello! I've been keeping my own notes in order. It's rather nice to know what I want to say "
			.. "before anyone asks."
		),
		workPrompt = "About the survey I'm doing.",
		offerPrompt = "Do you have a sensor survey?",
		work = (
			"Sensor surveys. Deploy the recorder at the assigned site, let the run finish, then retrieve it and "
			.. "bring the results back. Check the destination before accepting. I can examine a complete "
			.. "recording; I can't recreate the part we missed by looking increasingly worried at the page. I've "
			.. "tested that approach rather thoroughly."
		),
		progressionPrompt = "What needs checking in your survey work?",
		progression = (
			"I'd like to follow a survey through from preparation to comparison. There are supplies to collect "
			.. "and earlier records to recover before I can explain the complete account. We can start with an "
			.. "ordinary request. If a result disagrees, I'd rather discover that than arrange the notes until it "
			.. "stops looking troublesome."
		),
	},
	catalogue = {
	},
	progression = {
		{
			id = "IN01",
			completionCash = 275,
			name = "An Instrument of My Own",
			kind = "delivery",
			requires = {},
			briefing = (
				"Could you bring the electronics on this list? I want to make sure the instruments have what "
				.. "they need before we begin. I've checked the list twice. That isn't because I think you "
				.. "can't read it; I just don't want to have to ask you for another trip."
			),
			completion = (
				"Thank you. That's everything I wrote down. I'll check the instruments now and keep these "
				.. "together. It's nice to be able to prepare something instead of only counting what's "
				.. "missing."
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
			id = "IN02",
			completionCash = 450,
			name = "The Calibration Point",
			kind = "field",
			objective = (
				"Deploy the recorder at the assigned site in Waystation, let it finish recording, then retrieve "
				.. "the first calibration recorder. Bring it back to the issuing contact in Waystation."
			),
			requires = {"IN01"},
			briefing = (
				"I'd like to start with a recording near Waystation. I want to check my preparation against a "
				.. "complete return, not just an instrument on a shelf. Deploy the recorder at the assigned site in "
				.. "Waystation, let it finish recording, then retrieve the first calibration recorder. Bring it back "
				.. "to me in Waystation."
			),
			completion = "You brought it back. Good. I'll compare the setup notes before I look for the reading I expected.",
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. Intern's note: "
					.. "\"I'd like to start with a recording near Waystation.\""
				),
				kind = "sensor",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_module",
				label = "First calibration recorder",
			},
			benefits = {},
		},
		{
			id = "IN03",
			completionCash = 0,
			name = "Readings on Time",
			kind = "tracker",
			requires = {"IN02"},
			briefing = "Continue the survey recordings. Let each run finish, collect the results, and return them.",
			completion = "A few complete runs. I can start comparing the preparation with the returns.",
			target = 2,
			benefits = {},
		},
		{
			id = "IN04",
			completionCash = 650,
			name = "The Mislabelled Sample",
			kind = "field",
			objective = (
				"Recover the field label register from the assigned search area in Waystation. Bring it back to "
				.. "the issuing contact in Waystation."
			),
			requires = {"IN02"},
			briefing = (
				"There's a label register to recover. One uncertain label can make the rest of the figures look "
				.. "much more interesting than they deserve. Recover the field label register from the assigned "
				.. "search area in Waystation. Bring it back to me in Waystation."
			),
			completion = "Thank you. I'll check the entries against the labels before changing anything.",
			field = {
				description = (
					"A blue laboratory folder with loose printed record sheets extending from its edges. Intern's "
					.. "note: \"There's a label register to recover.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_lab",
				label = "Field label register",
			},
			benefits = {},
		},
		{
			id = "IN05",
			completionCash = 575,
			name = "Clean Containers",
			kind = "delivery",
			requires = {"IN03"},
			briefing = (
				"There are supplies to bring through. I'd like to finish the preparation before calling the "
				.. "instrument ready."
			),
			completion = "Good. That's the requested material accounted for.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "IN06",
			completionCash = 850,
			name = "Beanstalk's Control",
			kind = "field",
			objective = (
				"Deploy the recorder at the assigned site in Garbage, let it finish recording, then retrieve the "
				.. "Garbage control recorder. Bring it back to the issuing contact in Waystation."
			),
			requires = {"IN04"},
			briefing = (
				"We need a recording at the Garbage control site. I'd like a comparison I can explain without "
				.. "borrowing somebody else's confidence. Deploy the recorder at the assigned site in Garbage, let it "
				.. "finish recording, then retrieve the Garbage control recorder. Bring it back to me in Waystation."
			),
			completion = "Here it is. I'll keep the control separate while I check the records.",
			field = {
				description = (
					"A flat dark electronic module marked with a number and three pale bars. Intern's note: \"We need "
					.. "a recording at the Garbage control site.\""
				),
				kind = "sensor",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_module2",
				label = "Garbage control recorder",
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
			id = "IN07",
			completionCash = 0,
			name = "Same Place Same Method",
			kind = "tracker",
			requires = {"IN05"},
			briefing = "More completed sensor surveys when you're ready. Check the destination first.",
			completion = "Thank you. Another set of results I can check against the setup notes.",
			target = 5,
			benefits = {},
		},
		{
			id = "IN08",
			completionCash = 1050,
			name = "The Missing Interval",
			kind = "field",
			objective = (
				"Recover the interrupted recording for Spool from the assigned search area in Waystation. Deliver "
				.. "it to 'Spool' in Garbage, then come back to the issuing contact in Waystation."
			),
			requires = {"IN06"},
			briefing = (
				"Spool needs the interrupted recording. He may recognise something useful about the fault that I "
				.. "would put down to the survey. Recover the interrupted recording for Spool from the assigned "
				.. "search area in Waystation. Deliver it to 'Spool' in Garbage, then come back to me in Waystation."
			),
			completion = (
				"Delivered? Thank you. I'll wait to hear what he can establish before trying to account for the "
				.. "gap."
			),
			field = {
				description = (
					"A pale audio cassette with a handwritten dedication above the spool windows. Intern's note: "
					.. "\"Spool needs the interrupted recording.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_tape",
				label = "Interrupted recording for Spool",
				recipient = "spool",
			},
			benefits = {},
		},
		{
			id = "IN09",
			completionCash = 875,
			name = "Something to Compare",
			kind = "delivery",
			requires = {"IN07"},
			briefing = "Bring the requested records together. I want to read the comparison before quoting it to anyone.",
			completion = "Thank you. I'll take the time to check what they actually say.",
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "IN10",
			completionCash = 1250,
			name = "The Senior's Notebook",
			kind = "field",
			objective = (
				"Recover the senior researcher's notebook from the assigned search area in Waystation. Bring it "
				.. "back to the issuing contact in Waystation."
			),
			requires = {"IN08"},
			briefing = (
				"I'd like the research note brought back intact. It's difficult to ask a useful question about a "
				.. "page everyone remembers differently. Recover the senior researcher's notebook from the assigned "
				.. "search area in Waystation. Bring it back to me in Waystation."
			),
			completion = "Let me read what comes before the conclusion. I keep beginning at the end when I'm nervous.",
			field = {
				description = (
					"A thick blue diary with a label fixed to the front cover. Intern's note: \"I'd like the research "
					.. "note brought back intact.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_diary",
				label = "Senior researcher's notebook",
			},
			benefits = {},
		},
		{
			id = "IN11",
			completionCash = 0,
			name = "A Wider Baseline",
			kind = "tracker",
			requires = {"IN09"},
			briefing = "Keep the survey assignments going. I want the comparisons to survive more than one careful trip.",
			completion = "You've been consistent. That makes an awkward reading much more useful to discuss.",
			target = 9,
			benefits = {},
		},
		{
			id = "IN12",
			completionCash = 1450,
			name = "The Field Vesper Chose",
			kind = "field",
			objective = (
				"Deploy the recorder at the assigned site in Waystation, let it finish recording, then retrieve "
				.. "the anomaly approach survey recorder. Bring it back to the issuing contact in Waystation."
			),
			requires = {"IN10"},
			briefing = (
				"This recording is from the anomaly approach. I've checked the order; please check the journey "
				.. "before accepting it. Deploy the recorder at the assigned site in Waystation, let it finish "
				.. "recording, then retrieve the anomaly approach survey recorder. Bring it back to me in Waystation."
			),
			completion = "Thank you. Now I can compare the preparation with what actually came back.",
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. Intern's note: "
					.. "\"This recording is from the anomaly approach.\""
				),
				kind = "sensor",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_module",
				label = "Anomaly approach survey recorder",
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
			id = "IN13",
			completionCash = 1175,
			name = "Ready for the Distance",
			kind = "delivery",
			requires = {"IN11"},
			briefing = (
				"I've written down what I'm short of. Could you bring it here? I'll check it against the "
				.. "list. Please follow the instructions on the order. I want to be able to explain the "
				.. "work afterwards without filling the gaps with guesses."
			),
			completion = (
				"Oh, good. That's one thing ready. Right. I'll check it against my notes before I show "
				.. "anyone. It takes me a little longer when I'm determined not to borrow somebody else's "
				.. "answer."
			),
			requirements = {
				{
					pool = "canned_food",
					quantity = 4,
				},
			},
			benefits = {},
		},
		{
			id = "IN14",
			completionCash = 1650,
			name = "The Lost Calibration Case",
			kind = "field",
			objective = (
				"Recover the calibration case for Technut from the assigned search area in Waystation. Deliver it "
				.. "to 'Technut' in Marsh, then come back to the issuing contact in Waystation."
			),
			requires = {"IN12"},
			briefing = (
				"Technut should inspect the instrument case. I can describe the fault, but I'd rather he saw the "
				.. "equipment himself. Recover the calibration case for Technut from the assigned search area in "
				.. "Waystation. Deliver it to 'Technut' in Marsh, then come back to me in Waystation."
			),
			completion = "He's got it. That's a much better beginning than me attempting another drawing of the connector.",
			field = {
				description = (
					"A dark reinforced case covered in pale symbols and contrasting trim. Intern's note: \"Technut "
					.. "should inspect the instrument case.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_research",
				label = "Calibration case for Technut",
				recipient = "technut",
			},
			benefits = {},
		},
		{
			id = "IN15",
			completionCash = 0,
			name = "My Own Figures",
			kind = "tracker",
			requires = {"IN13"},
			briefing = "Continue the recording work while I examine the older notes.",
			completion = "A proper run of work now. I'm beginning to know which questions I need to ask.",
			target = 14,
			benefits = {},
		},
		{
			id = "IN16",
			completionCash = 1850,
			name = "The First Pripyat Series",
			kind = "field",
			objective = (
				"Deploy the recorder at the assigned site in Pripyat, let it finish recording, then retrieve the "
				.. "first Pripyat survey recorder. Bring it back to the issuing contact in Waystation."
			),
			requires = {"IN14"},
			briefing = (
				"I'd like a complete survey recording from Pripyat. I've written the requirements down so neither "
				.. "of us has to remember my explanation under pressure. Deploy the recorder at the assigned site in "
				.. "Pripyat, let it finish recording, then retrieve the first Pripyat survey recorder. Bring it back "
				.. "to me in Waystation."
			),
			completion = "You're back. I'll put the record with the setup notes before doing anything clever with it.",
			field = {
				description = (
					"A flat dark electronic module marked with a number and three pale bars. Intern's note: \"I'd like "
					.. "a complete survey recording from Pripyat.\""
				),
				kind = "sensor",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module2",
				label = "First Pripyat survey recorder",
			},
			benefits = {},
		},
		{
			id = "IN17",
			completionCash = 1475,
			name = "Without Missing Pages",
			kind = "delivery",
			requires = {"IN15"},
			briefing = "Bring the requested records together. I want to read the comparison before quoting it to anyone.",
			completion = "Thank you. I'll take the time to check what they actually say.",
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 2,
				},
			},
			benefits = {},
		},
		{
			id = "IN18",
			completionCash = 2050,
			name = "The Contradictory Site",
			kind = "field",
			objective = (
				"Deploy the recorder at the assigned site in Pripyat, let it finish recording, then retrieve the "
				.. "contradictory-site recorder. Bring it back to the issuing contact in Waystation."
			),
			requires = {"IN16"},
			briefing = (
				"We need another recording from the disputed site. If it disagrees, I want to know that before I "
				.. "start making the graph look tidy. Deploy the recorder at the assigned site in Pripyat, let it "
				.. "finish recording, then retrieve the contradictory-site recorder. Bring it back to me in "
				.. "Waystation."
			),
			completion = (
				"Good. I'll keep the original readings, including whatever is going to make the discussion "
				.. "awkward."
			),
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. Intern's note: "
					.. "\"We need another recording from the disputed site.\""
				),
				kind = "sensor",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module",
				label = "Contradictory-site recorder",
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
			id = "IN19",
			completionCash = 0,
			name = "Enough to Stand Behind",
			kind = "tracker",
			requires = {"IN17"},
			briefing = "There are more survey assignments. Bring the finished recordings back intact.",
			completion = "You've given me enough to check the account without hiding the inconvenient results.",
			target = 20,
			benefits = {},
		},
		{
			id = "IN20",
			completionCash = 2250,
			name = "The Earlier Team",
			kind = "field",
			objective = (
				"Recover the earlier survey recording for Wake from the assigned search area in Pripyat. Deliver "
				.. "it to 'Wake' in Garbage, then come back to the issuing contact in Waystation."
			),
			requires = {"IN18"},
			briefing = (
				"Wake needs the earlier team's recording. I don't want a useful detail about the people lost "
				.. "inside my technical summary. Recover the earlier survey recording for Wake from the assigned "
				.. "search area in Pripyat. Deliver it to 'Wake' in Garbage, then come back to me in Waystation."
			),
			completion = "She has it. Thank you for giving her the account itself.",
			field = {
				description = (
					"A pale audio cassette with a handwritten dedication above the spool windows. Intern's note: "
					.. "\"Wake needs the earlier team's recording.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_tape",
				label = "Earlier survey recording for Wake",
				recipient = "wake",
			},
			benefits = {},
		},
		{
			id = "IN21",
			completionCash = 1775,
			name = "The Last Calibration",
			kind = "delivery",
			requires = {"IN19", "IN20"},
			briefing = "I need the supplies on this request. Keep enough for your own return too.",
			completion = "All here. I'll put this lot aside before the cupboard acquires another explanation.",
			requirements = {
				{
					pool = "field_maintenance",
					quantity = 6,
				},
			},
			benefits = {},
		},
		{
			id = "IN22",
			completionCash = 2450,
			name = "The Independent Control",
			kind = "field",
			objective = (
				"Deploy the recorder at the assigned site in Pripyat, let it finish recording, then retrieve the "
				.. "independent control recorder. Bring it back to the issuing contact in Waystation."
			),
			requires = {"IN21"},
			briefing = (
				"One more control recording in Pripyat. I want to be able to explain this comparison in my own "
				.. "words. Deploy the recorder at the assigned site in Pripyat, let it finish recording, then "
				.. "retrieve the independent control recorder. Bring it back to me in Waystation."
			),
			completion = (
				"All right. I can start checking the independent record now. I'm rather looking forward to that "
				.. "part."
			),
			field = {
				description = (
					"A flat dark electronic module marked with a number and three pale bars. Intern's note: \"One more "
					.. "control recording in Pripyat.\""
				),
				kind = "sensor",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module2",
				label = "Independent control recorder",
			},
			benefits = {},
		},
		{
			id = "IN23",
			completionCash = 0,
			name = "Put My Name on It",
			kind = "tracker",
			requires = {"IN22"},
			briefing = "Keep completing the sensor surveys when you're prepared.",
			completion = (
				"Thank you. I can stand behind the work and still say which part needs checking. That feels like "
				.. "progress."
			),
			target = 27,
			benefits = {},
		},
		{
			id = "IN24",
			completionCash = 2650,
			name = "The Missing Observation",
			kind = "field",
			objective = (
				"Recover the missing survey observation log from the assigned search area in Waystation. Bring it "
				.. "back to the issuing contact in Waystation."
			),
			requires = {"IN23"},
			briefing = (
				"The last field record needs to come home whole. If I missed something, I want to find it before I "
				.. "call the survey finished. Recover the missing survey observation log from the assigned search "
				.. "area in Waystation. Bring it back to me in Waystation."
			),
			completion = (
				"Those are my figures, with the awkward parts still attached. You've helped me finish work I can "
				.. "answer questions about. Thank you. I think I can put my name on it without apologising first."
			),
			field = {
				description = (
					"A blue laboratory folder with loose printed record sheets extending from its edges. Intern's "
					.. "note: \"The last field record needs to come home whole.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_lab",
				label = "Missing survey observation log",
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
			recognition = "Intern's trusted contact",
		},
	},
})
