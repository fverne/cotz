PLUGIN:Register("jitters", {
	name = "'Jitters'",
	template = "medicnpc",
	map = "rp_marsh_cs",
	job = {
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		category = "Medical supply deliveries",
		description = "Medical supply deliveries",
		pools = {"town_medical"},
		deliveryTiers = {
			easy = {
				pools = {
					"valuables_clinical_supplies",
				},
				quantity = 1,
			},
			medium = {
				pools = {
					"valuables_trauma_supplies",
					"valuables_medical_equipment",
				},
				quantity = 1,
			},
			hard = {
				pools = {
					"valuables_research_injectors_a",
					"valuables_research_injectors_b",
				},
				quantity = 2,
			},
		},
		quantities = {2, 4, 7},
	},
	supplies = {"medic_bandage_1", "medic_medkit_1", "medic_antirad_1", "drug_painkillers"},
	rewards = {
		packages = {
			{label = "Bleeding control",
				items = {"medic_bandage_1", "medic_bandage_2", "medic_bandage_3"}},
			{label = "Trauma supplies",
				items = {"medic_medkit_1", "medic_medkit_2", "drug_painkillers"}},
			{label = "Exposure treatment",
				items = {"medic_antirad_1", "medic_antirad_2"}},
		},
	},
	dialogue = {
		delivery = "Here, here. Let me check the label before you go.",
		completedGreeting = (
			"Oh, hello. No fresh injuries, I hope? It's nice when somebody visits and I can finish a "
			.. "sentence before reaching for something."
		),
		workPrompt = "About the clinic request I'm filling.",
		offerPrompt = "Do you need supplies brought in?",
		work = (
			"Medical supplies and the recovered goods on the request. Check the actual list before packing. "
			.. "I'll inspect what comes in before deciding where it belongs; I'd rather do that here than trust a "
			.. "reassuring label while someone is waiting for treatment. Please keep everything apart from the "
			.. "dirty things in your pack."
		),
		progressionPrompt = "What needs checking for the clinic?",
		progression = (
			"I'm comparing the exposure accounts as well as trying to keep the clinic supplied. There are "
			.. "ordinary requests and records to recover. Choose something you can prepare for; I don't want "
			.. "another patient because I made the order sound hurried. If another contact needs the record, "
			.. "deliver it and come back. We'll examine the uncertainty somewhere quiet."
		),
	},
	catalogue = {
		["medic_antirad_1"] = {step = "JT09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_antirad_2"] = {step = "JT21",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_bandage_2"] = {step = "JT05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_bandage_3"] = {step = "JT13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_1"] = {step = "JT07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_2"] = {step = "JT11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_3"] = {step = "JT15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_4"] = {step = "JT17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_5"] = {step = "JT19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_6"] = {step = "JT23",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "JT01",
			completionCash = 275,
			name = "Clean Hands",
			kind = "delivery",
			requires = {},
			briefing = (
				"I'm short of the medical supplies on this list. Could you bring them here? I'd like to sort "
				.. "them before the next person arrives needing something urgently. They always seem to arrive "
				.. "just when I've started rearranging the cabinet."
			),
			completion = (
				"Thank you. Put them here, please. I'll check and put them away. That's one less thing to "
				.. "worry about until I think of another one."
			),
			requirements = {
				{
					pool = "town_medical",
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
			id = "JT02",
			completionCash = 450,
			name = "The Empty Cabinet",
			kind = "field",
			objective = (
				"Recover the aid-station inventory journal from the assigned search area in Marsh. Bring it back "
				.. "to the issuing contact in Marsh."
			),
			requires = {"JT01"},
			briefing = (
				"I'd like the aid-station inventory recovered. Before I decide what was missing, I need to know "
				.. "what they thought they had. Recover the aid-station inventory journal from the assigned search "
				.. "area in Marsh. Bring it back to me in Marsh."
			),
			completion = "Thank you. I'll read it before trying to reconstruct the shelves in my head.",
			field = {
				description = (
					"A blue-green folder with medical record sheets protruding from its cover. Jitters's note: \"I'd "
					.. "like the aid-station inventory recovered.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_clinic",
				label = "Aid-station inventory journal",
			},
			benefits = {},
		},
		{
			id = "JT03",
			completionCash = 0,
			name = "Keep the Shelves Filled",
			kind = "tracker",
			requires = {"JT02"},
			briefing = (
				"Continue the medical supply deliveries. I want the regular requests filled alongside the "
				.. "recovered cases."
			),
			completion = "A useful start. There's a little less I have to keep in my head now.",
			target = 2,
			benefits = {},
		},
		{
			id = "JT04",
			completionCash = 650,
			name = "A Missing Bag",
			kind = "field",
			objective = (
				"Recover the abandoned medic's case from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"JT03"},
			briefing = (
				"There's a medic's case still out in Marsh. Please keep everything together; an unfamiliar little "
				.. "fitting may have a purpose. Recover the abandoned medic's case from the assigned search area in "
				.. "Marsh. Bring it back to me in Marsh."
			),
			completion = "Set it on the clean end. I'll check it before anything joins the treatment supplies.",
			field = {
				description = (
					"A pale hard case with dark catches, a carrying handle and a medical cross marking. Jitters's "
					.. "note: \"There's a medic's case still out in Marsh.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_medical",
				label = "Abandoned medic's case",
			},
			benefits = {},
		},
		{
			id = "JT05",
			completionCash = 575,
			name = "A Proper Dressing",
			kind = "delivery",
			requires = {"JT03"},
			briefing = (
				"I'd like the listed medical supplies brought here. Keep them apart from anything dirty in your "
				.. "pack, please."
			),
			completion = "Thank you. I'll check these before putting them with the treatment supplies.",
			requirements = {
				{
					pool = "town_medical",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "JT06",
			completionCash = 850,
			name = "The Exposure Log",
			kind = "field",
			objective = (
				"Recover the field exposure observations from the assigned search area in Marsh. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"JT04"},
			briefing = (
				"I'd like the patient observations from the shelter. A remembered symptom isn't always remembered "
				.. "at the right point in the account. Recover the field exposure observations from the assigned "
				.. "search area in Marsh. Bring it back to me in Marsh."
			),
			completion = "Here. I'll compare the entries without trying to diagnose a page at a glance.",
			field = {
				description = (
					"A blue-green records folder with loose printed sheets and a marked cover. Jitters's note: \"I'd "
					.. "like the patient observations from the shelter.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_clinic2",
				label = "Field exposure observations",
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
				item = "medic_bandage_1",
				bonus = 1,
			},
		},
		{
			id = "JT07",
			completionCash = 0,
			name = "A Steady Clinic",
			kind = "tracker",
			requires = {"JT05"},
			briefing = "More medical orders when you're prepared. Check the requested supplies before leaving.",
			completion = "Another steady run. Thank you for keeping the returns straightforward.",
			target = 5,
			benefits = {},
		},
		{
			id = "JT08",
			completionCash = 1050,
			name = "The Broken Instrument",
			kind = "field",
			objective = (
				"Recover the diagnostic case for Technut from the assigned search area in Marsh. Deliver it to "
				.. "'Technut' in Marsh, then come back to the issuing contact in Marsh."
			),
			requires = {"JT06"},
			briefing = (
				"Technut needs the diagnostic equipment. I'd rather he inspect it than reassure me about my "
				.. "description of the fault. Recover the diagnostic case for Technut from the assigned search area "
				.. "in Marsh. Deliver it to 'Technut' in Marsh, then come back to me in Marsh."
			),
			completion = "He has it? Good. That's one thing I can stop trying to solve between patients.",
			field = {
				description = (
					"A finned grey control box with a red stripe and several round front connectors. Jitters's note: "
					.. "\"Technut needs the diagnostic equipment.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_control",
				label = "Diagnostic case for Technut",
				recipient = "technut",
			},
			benefits = {},
			discounts = {{npc = "'Jitters'", service = "treatment", fraction = 0.05}},
		},
		{
			id = "JT09",
			completionCash = 875,
			name = "Fever and Fallout",
			kind = "delivery",
			requires = {"JT07"},
			briefing = "There is another clinical request. Please read it before deciding a similar packet will do.",
			completion = "That's the requested lot. I'll keep the labels with it.",
			requirements = {
				{
					pool = "town_medical",
					quantity = 3,
				},
			},
			benefits = {},
		},
		{
			id = "JT10",
			completionCash = 1250,
			name = "The Contaminated Batch",
			kind = "field",
			objective = (
				"Recover the suspect batch evidence from the assigned search area in Garbage. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"JT08"},
			briefing = (
				"Bring the batch evidence back sealed. I need to check the account before deciding what the "
				.. "contamination claim supports. Recover the suspect batch evidence from the assigned search area in "
				.. "Garbage. Bring it back to me in Marsh."
			),
			completion = "Leave it apart from the supplies. I'll examine the records first.",
			field = {
				description = (
					"A long tinted research tube with dark caps at both ends. Jitters's note: \"Bring the batch "
					.. "evidence back sealed.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_tube",
				label = "Suspect batch evidence",
			},
			benefits = {},
		},
		{
			id = "JT11",
			completionCash = 0,
			name = "The Long Queue",
			kind = "tracker",
			requires = {"JT09"},
			briefing = "Keep filling the medical supply requests while I compare the observations.",
			completion = "You've kept the supplies moving. I've had more time to look at the actual cases.",
			target = 9,
			benefits = {},
		},
		{
			id = "JT12",
			completionCash = 1450,
			name = "Where the Water Came From",
			kind = "field",
			objective = (
				"Recover the water-source recorder for Gasket from the assigned search area in Marsh. Deliver it "
				.. "to 'Gasket' in Marsh, then come back to the issuing contact in Marsh."
			),
			requires = {"JT10"},
			briefing = (
				"Gasket needs the recording from the water-source survey. He can check the utility side without my "
				.. "interpretation getting there first. Recover the water-source recorder for Gasket from the "
				.. "assigned search area in Marsh. Deliver it to 'Gasket' in Marsh, then come back to me in Marsh."
			),
			completion = (
				"Delivered. Thank you. I'll wait to hear what he establishes before worrying at the next "
				.. "explanation."
			),
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. Jitters's note: "
					.. "\"Gasket needs the recording from the water-source survey.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_module",
				label = "Water-source recorder for Gasket",
				recipient = "gasket",
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
			id = "JT13",
			completionCash = 1175,
			name = "Better Instruments",
			kind = "delivery",
			requires = {"JT11"},
			briefing = (
				"I'd like the listed medical supplies brought here. Keep them apart from anything dirty in your "
				.. "pack, please."
			),
			completion = "Thank you. I'll check these before putting them with the treatment supplies.",
			requirements = {
				{
					pool = "town_medical",
					quantity = 4,
				},
			},
			benefits = {},
		},
		{
			id = "JT14",
			completionCash = 1650,
			name = "A Second Opinion",
			kind = "field",
			objective = (
				"Recover the exposure research note from the assigned search area in Marsh. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"JT12"},
			briefing = (
				"I'd like another research note to compare. Two similar cases can be terribly persuasive until you "
				.. "check what differed. Recover the exposure research note from the assigned search area in Marsh. "
				.. "Bring it back to me in Marsh."
			),
			completion = "That's useful. Let me put the accounts beside each other before I begin agreeing with them.",
			field = {
				description = (
					"A blue laboratory folder with loose printed record sheets extending from its edges. Jitters's "
					.. "note: \"I'd like another research note to compare.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_lab",
				label = "Exposure research note",
			},
			benefits = {},
		},
		{
			id = "JT15",
			completionCash = 0,
			name = "Cases From Outside",
			kind = "tracker",
			requires = {"JT13"},
			briefing = "Continue the supply work. Your own return kit still matters after filling the order.",
			completion = "A considerable amount brought through. I haven't taken that for granted.",
			target = 14,
			benefits = {},
		},
		{
			id = "JT16",
			completionCash = 1850,
			name = "The Missing Volunteer",
			kind = "field",
			objective = (
				"Recover the volunteer medic's records from the assigned search area in Garbage. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"JT14"},
			briefing = (
				"The volunteer's surviving records should come back intact. I'd like to know what they actually "
				.. "recorded before deciding what happened to them. Recover the volunteer medic's records from the "
				.. "assigned search area in Garbage. Bring it back to me in Marsh."
			),
			completion = "Thank you. I'll take a moment with this. You can put your things down.",
			field = {
				description = (
					"A pale hard case with dark catches, a carrying handle and a medical cross marking. Jitters's "
					.. "note: \"The volunteer's surviving records should come back intact.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_medical",
				label = "Volunteer medic's records",
			},
			benefits = {},
		},
		{
			id = "JT17",
			completionCash = 1475,
			name = "For the Journey",
			kind = "delivery",
			requires = {"JT15"},
			briefing = (
				"Bring the listed provisions here. And leave yourself food for the way back; I do mean yourself as "
				.. "well."
			),
			completion = "Good. I'll put this with the expedition supplies.",
			requirements = {
				{
					pool = "canned_food",
					quantity = 5,
				},
			},
			benefits = {},
		},
		{
			id = "JT18",
			completionCash = 2050,
			name = "The Field Ward",
			kind = "field",
			objective = (
				"Recover the field treatment log for Wake from the assigned search area in Marsh. Deliver it to "
				.. "'Wake' in Garbage, then come back to the issuing contact in Marsh."
			),
			requires = {"JT16"},
			briefing = (
				"Wake should have the field ward's log. There may be a useful detail about the people that I'd "
				.. "overlook concentrating on treatment. Recover the field treatment log for Wake from the assigned "
				.. "search area in Marsh. Deliver it to 'Wake' in Garbage, then come back to me in Marsh."
			),
			completion = (
				"She has it. Good. She should have the account without waiting for me to finish every clinical "
				.. "question."
			),
			field = {
				description = (
					"A blue-green folder with medical record sheets protruding from its cover. Jitters's note: \"Wake "
					.. "should have the field ward's log.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_clinic",
				label = "Field treatment log for Wake",
				recipient = "wake",
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
			id = "JT19",
			completionCash = 0,
			name = "Ready for Returns",
			kind = "tracker",
			requires = {"JT17"},
			briefing = "There are more medical requests to complete. Keep the supplies together and the labels readable.",
			completion = "You've stayed dependable. It helps to have a thing I don't need to worry about quite so much.",
			target = 20,
			benefits = {},
		},
		{
			id = "JT20",
			completionCash = 2250,
			name = "No One Came Back",
			kind = "field",
			objective = (
				"Recover the expedition clinic recording from the assigned search area in Pripyat. Bring it back "
				.. "to the issuing contact in Marsh."
			),
			requires = {"JT18"},
			briefing = (
				"I'd like the clinic recording brought back from Pripyat. Don't try to listen while you're still "
				.. "making the journey. Recover the expedition clinic recording from the assigned search area in "
				.. "Pripyat. Bring it back to me in Marsh."
			),
			completion = "You're back. Leave it here; I'll listen somewhere I can keep the notes open.",
			field = {
				description = (
					"A pale audio cassette with a handwritten dedication above the spool windows. Jitters's note: "
					.. "\"I'd like the clinic recording brought back from Pripyat.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_tape",
				label = "Expedition clinic recording",
			},
			benefits = {},
		},
		{
			id = "JT21",
			completionCash = 1775,
			name = "Comparing the Cases",
			kind = "delivery",
			requires = {"JT19"},
			briefing = (
				"I'd like the requested records kept together. I need the context before trying to make sense of "
				.. "the cases."
			),
			completion = "Thank you. I'll read the whole account before comparing it with the others.",
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 2,
				},
			},
			benefits = {},
		},
		{
			id = "JT22",
			completionCash = 2450,
			name = "The Patient's Route",
			kind = "field",
			objective = (
				"Recover the last exposure survey record from the assigned search area in Pripyat. Bring it back "
				.. "to the issuing contact in Marsh."
			),
			requires = {"JT20"},
			briefing = (
				"Recover the expedition's later exposure record. I'd rather compare the sequence than select the "
				.. "reading that suits my worry. Recover the last exposure survey record from the assigned search "
				.. "area in Pripyat. Bring it back to me in Marsh."
			),
			completion = (
				"Let me put it with the observations. I'll check the dates before the figures start looking like "
				.. "an answer."
			),
			field = {
				description = (
					"A flat dark electronic module marked with a number and three pale bars. Jitters's note: \"Recover "
					.. "the expedition's later exposure record.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_module2",
				label = "Last exposure survey record",
			},
			benefits = {},
		},
		{
			id = "JT23",
			completionCash = 0,
			name = "Still Taking Patients",
			kind = "tracker",
			requires = {"JT21", "JT22"},
			briefing = "Keep the medical deliveries going when you're ready for another trip.",
			completion = (
				"You've given the clinic steady attention. Thank you. I should probably stop and say that before I "
				.. "find another shelf to count."
			),
			target = 27,
			benefits = {},
		},
		{
			id = "JT24",
			completionCash = 2650,
			name = "An Answer on Tape",
			kind = "field",
			objective = (
				"Recover the final medical cassette from the assigned search area in Pripyat. Bring it back to the "
				.. "issuing contact in Marsh."
			),
			requires = {"JT23"},
			briefing = (
				"There's one more medical recording in Pripyat. Bring the whole account home before interpreting a "
				.. "voice or a symptom you recognise. Recover the final medical cassette from the assigned search "
				.. "area in Pripyat. Bring it back to me in Marsh."
			),
			completion = "Thank you. I'll hear it through before deciding which case it belongs beside.",
			field = {
				description = (
					"A pale audio cassette with a broad blue printed label and twin spool windows. Jitters's note: "
					.. "\"There's one more medical recording in Pripyat.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_tape2",
				label = "Final medical cassette",
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
			discounts = {{npc = "'Jitters'", service = "treatment", fraction = 0.1}},
		},
		{
			id = "JT25",
			completionCash = 2000,
			name = "A Clinic That Holds",
			kind = "delivery",
			requires = {"JT24"},
			briefing = "There is another clinical request. Please read it before deciding a similar packet will do.",
			completion = "That's the requested lot. I'll keep the labels with it.",
			requirements = {
				{
					pool = "town_medical",
					quantity = 7,
				},
			},
			benefits = {},
		},
		{
			id = "JT26",
			completionCash = 2850,
			name = "The Case Closed",
			kind = "field",
			objective = (
				"Recover the final exposure identification file from the assigned search area in Marsh. Bring it "
				.. "back to the issuing contact in Marsh."
			),
			requires = {"JT25"},
			briefing = (
				"The identifying papers need to stay together. I don't want to fill a gap by guessing because a "
				.. "page went missing on the way home. Recover the final exposure identification file from the "
				.. "assigned search area in Marsh. Bring it back to me in Marsh."
			),
			completion = (
				"You've given me time to look properly instead of trying to remember everything at once. I "
				.. "appreciate that more than I've probably managed to say. Sit down. We can talk without me handing "
				.. "you another list."
			),
			field = {
				description = (
					"A cardboard file folder with an emblem and printed wording on the front. Jitters's note: \"The "
					.. "identifying papers need to stay together.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_personnel",
				label = "Final exposure identification file",
			},
			benefits = {},
			recognition = "Jitters's trusted contact",
		},
	},
})
