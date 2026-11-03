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
				"I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely "
				.. "on the readings. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "town_delivery_research_waystation_1",
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
			name = "A small delivery",
			kind = "delivery",
			retiredCommission = true,
			objective = "Bring all 1 listed item type to this contact. The request shows each selected item and required units.",
			requires = {"IN02"},
			briefing = (
				"I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely "
				.. "on the readings. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "town_delivery_research_waystation_1",
					quantity = 1,
				},
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
				"I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely "
				.. "on the readings. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "town_delivery_research_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_waystation_2",
					quantity = 1,
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
				map = "rp_garbage_cotz",
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
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"IN06"},
			briefing = (
				"I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely "
				.. "on the readings. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "town_delivery_research_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_waystation_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "IN09",
			completionCash = 875,
			name = "Something to Compare",
			kind = "delivery",
			requires = {"IN07"},
			briefing = (
				"I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely "
				.. "on the readings. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "town_delivery_research_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_waystation_2",
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
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"IN10"},
			briefing = (
				"I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely "
				.. "on the readings. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "town_delivery_research_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_waystation_2",
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
			id = "IN13",
			completionCash = 1175,
			name = "Ready for the Distance",
			kind = "delivery",
			requires = {"IN11"},
			briefing = (
				"I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely "
				.. "on the readings. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "town_delivery_research_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_waystation_3",
					quantity = 1,
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
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"IN14"},
			briefing = (
				"I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely "
				.. "on the readings. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "town_delivery_research_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_waystation_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "IN17",
			completionCash = 1475,
			name = "Without Missing Pages",
			kind = "delivery",
			requires = {"IN15"},
			briefing = (
				"I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely "
				.. "on the readings. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "town_delivery_research_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_waystation_3",
					quantity = 1,
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
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"IN18"},
			briefing = (
				"I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely "
				.. "on the readings. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "town_delivery_research_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_waystation_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "IN21",
			completionCash = 1775,
			name = "The Last Calibration",
			kind = "delivery",
			requires = {"IN19", "IN20"},
			briefing = (
				"I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely "
				.. "on the readings. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "town_delivery_research_waystation_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_research_waystation_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_waystation_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_waystation_4",
					quantity = 1,
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
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"IN23"},
			briefing = (
				"I am preparing my own survey supplies. I want to check them myself before I ask anyone to rely "
				.. "on the readings. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Thanks. I will check these against my preparation list.",
			requirements = {
				{
					pool = "town_delivery_research_waystation_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_research_waystation_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_research_waystation_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_research_waystation_4",
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
			recognition = "Intern's trusted contact",
		},
	},
})
