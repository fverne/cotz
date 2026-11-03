PLUGIN:Register("wake", {
	name = "'Wake'",
	template = "wakenpc",
	map = "rp_garbage_cotz",
	job = {
		kind = "recovery",
		category = "Equipment recovery",
		description = "Equipment recovery",
		maps = {
			easy = "rp_garbage_cotz",
			medium = "rp_waystation",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Recovery medicine",
				items = {"medic_bandage_1", "medic_medkit_1"}},
			{label = "Exposure supplies",
				items = {"medic_antirad_1", "medic_antirad_2"}},
			{label = "Search provisions",
				items = {"food_can_tushonka", "drink_bottlewater"}},
		},
	},
	dialogue = {
		delivery = "Put it here. I will keep it with the search records.",
		completedGreeting = (
			"Hello again. Thank you for coming back. If you have something to discuss, we can take our "
			.. "time."
		),
		workPrompt = "About the effects case I'm recovering.",
		offerPrompt = "Is there a case you need recovered?",
		work = (
			"Recover the marked personal-effects case and bring it back intact. Keep the little things with the "
			.. "rest, even if you can't see why somebody would want them. We can examine what returned here. Check "
			.. "the region before accepting; you deserve time to prepare for the journey too."
		),
		progressionPrompt = "Where can I help with the search records?",
		progression = (
			"I'm comparing missing people's routes, records, and belongings. The supplies keep the work "
			.. "possible; the recovered accounts let us ask better questions. Neither makes a promise that the "
			.. "next case will settle a disappearance. Choose something you can bring through carefully, and we'll "
			.. "work from what actually returns."
		),
	},
	catalogue = {
		["medic_antirad_1"] = {step = "WA09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_antirad_2"] = {step = "WA21",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_bandage_2"] = {step = "WA05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_bandage_3"] = {step = "WA13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_1"] = {step = "WA07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_2"] = {step = "WA11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_3"] = {step = "WA15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_4"] = {step = "WA17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_5"] = {step = "WA19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_6"] = {step = "WA22",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "WA01",
			completionCash = 275,
			name = "Names Before Numbers",
			kind = "delivery",
			requires = {},
			briefing = (
				"I need supplies and recovered belongings brought here for sorting. Check the request, and keep "
				.. "personal effects together while you carry them. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
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
			id = "WA02",
			completionCash = 450,
			name = "The Unmarked Camp",
			kind = "field",
			objective = (
				"Recover the missing scavenger's records from the assigned search area in Garbage. Bring it back "
				.. "to the issuing contact in Garbage."
			),
			requires = {"WA01"},
			briefing = (
				"I'd like the scavenger's surviving records brought back together. Finding belongings gives us "
				.. "something to examine, not permission to settle the person's fate. Recover the missing scavenger's "
				.. "records from the assigned search area in Garbage. Bring it back to me in Garbage."
			),
			completion = "Thank you. I'll check which names and dates are actually here.",
			field = {
				description = (
					"A cardboard file folder with an emblem and printed wording on the front. Wake's note: \"I'd like "
					.. "the scavenger's surviving records brought back together.\""
				),
				kind = "recovery",
				map = "rp_garbage_cotz",
				tier = 1,
				cargo = "town_quest_personnel",
				label = "Missing scavenger's records",
			},
			benefits = {},
		},
		{
			id = "WA03",
			completionCash = 0,
			name = "Someone Goes Looking",
			kind = "tracker",
			requires = {"WA02"},
			briefing = "Continue the personal-effects case recoveries. Bring back what the assignment identifies.",
			completion = "A few cases home that would otherwise still be out there. Thank you.",
			target = 2,
			benefits = {},
		},
		{
			id = "WA04",
			completionCash = 650,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"WA03"},
			briefing = (
				"I need supplies and recovered belongings brought here for sorting. Check the request, and keep "
				.. "personal effects together while you carry them. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "WA05",
			completionCash = 575,
			name = "A Searcher's Kit",
			kind = "delivery",
			requires = {"WA04"},
			briefing = (
				"I need supplies and recovered belongings brought here for sorting. Check the request, and keep "
				.. "personal effects together while you carry them. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "WA06",
			completionCash = 850,
			name = "The Convoy List",
			kind = "field",
			objective = (
				"Recover the convoy roster for Brass from the assigned search area in Garbage. Deliver it to "
				.. "'Brass' in Garbage, then come back to the issuing contact in Garbage."
			),
			requires = {"WA04"},
			briefing = (
				"Brass needs the convoy roster. He can compare the freight account with the people recorded as "
				.. "travelling. Recover the convoy roster for Brass from the assigned search area in Garbage. Deliver "
				.. "it to 'Brass' in Garbage, then come back to me in Garbage."
			),
			completion = "He has the roster. Thank you for carrying it through instead of giving him a summary.",
			field = {
				description = (
					"A cardboard file folder with an emblem and printed wording on the front. Wake's note: \"Brass "
					.. "needs the convoy roster.\""
				),
				kind = "recovery",
				map = "rp_garbage_cotz",
				tier = 1,
				cargo = "town_quest_personnel",
				label = "Convoy roster for Brass",
				recipient = "brass",
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
			id = "WA07",
			completionCash = 0,
			name = "Bring Back What You Can",
			kind = "tracker",
			requires = {"WA05"},
			briefing = "More effects recoveries when you're prepared. Keep each case together.",
			completion = "You've been careful with what returned. I appreciate that.",
			target = 5,
			benefits = {},
		},
		{
			id = "WA08",
			completionCash = 1050,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"WA06"},
			briefing = (
				"I need supplies and recovered belongings brought here for sorting. Check the request, and keep "
				.. "personal effects together while you carry them. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "WA09",
			completionCash = 875,
			name = "Keeping the Record",
			kind = "delivery",
			requires = {"WA07"},
			briefing = (
				"I need supplies and recovered belongings brought here for sorting. Check the request, and keep "
				.. "personal effects together while you carry them. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "WA10",
			completionCash = 1250,
			name = "Atlas' Missing Mark",
			kind = "field",
			objective = (
				"Recover the survey note for Atlas from the assigned search area in Garbage. Deliver it to 'Atlas' "
				.. "in Marsh, then come back to the issuing contact in Garbage."
			),
			requires = {"WA08"},
			briefing = (
				"Atlas should have the survey note. A place described poorly can make the whole route look more "
				.. "certain than it is. Recover the survey note for Atlas from the assigned search area in Garbage. "
				.. "Deliver it to 'Atlas' in Marsh, then come back to me in Garbage."
			),
			completion = "Delivered. He can examine the description himself now.",
			field = {
				description = (
					"A thick brown journal held together by a narrow tie around its cover. Wake's note: \"Atlas should "
					.. "have the survey note.\""
				),
				kind = "recovery",
				map = "rp_garbage_cotz",
				tier = 2,
				cargo = "town_quest_notebook",
				label = "Survey note for Atlas",
				recipient = "atlas",
			},
			benefits = {},
		},
		{
			id = "WA11",
			completionCash = 0,
			name = "A Longer Search",
			kind = "tracker",
			requires = {"WA09"},
			briefing = "Keep bringing the marked recovery cases back. We can examine them here.",
			completion = "You've stayed with the search work. That matters beyond this desk.",
			target = 9,
			benefits = {},
		},
		{
			id = "WA12",
			completionCash = 1450,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"WA10"},
			briefing = (
				"I need supplies and recovered belongings brought here for sorting. Check the request, and keep "
				.. "personal effects together while you carry them. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_3",
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
			id = "WA13",
			completionCash = 1175,
			name = "Ready to Follow",
			kind = "delivery",
			requires = {"WA11"},
			briefing = (
				"I need supplies and recovered belongings brought here for sorting. Check the request, and keep "
				.. "personal effects together while you carry them. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "WA14",
			completionCash = 1650,
			name = "The Withheld Copy",
			kind = "field",
			objective = (
				"Recover the restricted report's supporting file from the assigned search area in Garbage. Deliver "
				.. "it to 'Carbon' in Waystation, then come back to the issuing contact in Garbage."
			),
			requires = {"WA12"},
			briefing = (
				"Carbon needs the evidence supporting that report. I want the missing information examined without "
				.. "choosing a conclusion for him. Recover the restricted report's supporting file from the assigned "
				.. "search area in Garbage. Deliver it to 'Carbon' in Waystation, then come back to me in Garbage."
			),
			completion = "He has the file. That's one fewer obstacle between the record and somebody willing to read it.",
			field = {
				description = (
					"A cardboard file folder with a small coloured crest on its cover. Wake's note: \"Carbon needs the "
					.. "evidence supporting that report.\""
				),
				kind = "recovery",
				map = "rp_garbage_cotz",
				tier = 2,
				cargo = "town_quest_official",
				label = "Restricted report's supporting file",
				recipient = "carbon",
			},
			benefits = {},
		},
		{
			id = "WA15",
			completionCash = 0,
			name = "No One Written Off",
			kind = "tracker",
			requires = {"WA13"},
			briefing = "Continue the case recoveries while I compare the route records.",
			completion = "A substantial amount brought home now. Thank you for treating the smaller returns carefully too.",
			target = 14,
			benefits = {},
		},
		{
			id = "WA16",
			completionCash = 1850,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"WA14"},
			briefing = (
				"I need supplies and recovered belongings brought here for sorting. Check the request, and keep "
				.. "personal effects together while you carry them. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "WA17",
			completionCash = 1475,
			name = "The Records Agree",
			kind = "delivery",
			requires = {"WA15"},
			briefing = (
				"I need supplies and recovered belongings brought here for sorting. Check the request, and keep "
				.. "personal effects together while you carry them. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "WA18",
			completionCash = 2050,
			name = "The Last Transmission",
			kind = "field",
			objective = (
				"Recover the expedition's last transmission from the assigned search area in Pripyat. Bring it "
				.. "back to the issuing contact in Garbage."
			),
			requires = {"WA16"},
			briefing = (
				"I'd like the later recording brought home. A voice deserves a quieter hearing than a hurried "
				.. "listen on the route. Recover the expedition's last transmission from the assigned search area in "
				.. "Pripyat. Bring it back to me in Garbage."
			),
			completion = "We'll take our time with it. Thank you for bringing it all the way back.",
			field = {
				description = (
					"A pale audio cassette with a broad blue printed label and twin spool windows. Wake's note: \"I'd "
					.. "like the later recording brought home.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_tape2",
				label = "Expedition's last transmission",
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
			id = "WA19",
			completionCash = 0,
			name = "Still Looking",
			kind = "tracker",
			requires = {"WA17", "WA18"},
			briefing = "There are more effects cases to recover. You don't have to take the next trip before resting.",
			completion = "You've kept returning with the work. I haven't taken that for granted.",
			target = 20,
			benefits = {},
		},
		{
			id = "WA20",
			completionCash = 2250,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"WA19"},
			briefing = (
				"I need supplies and recovered belongings brought here for sorting. Check the request, and keep "
				.. "personal effects together while you carry them. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_medical_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_4",
					quantity = 1,
				},
			},
			benefits = {},
			stock = {
				item = "drink_bottlewater",
				bonus = 2,
			},
		},
		{
			id = "WA21",
			completionCash = 1775,
			name = "A Place in the Ledger",
			kind = "delivery",
			requires = {"WA20"},
			briefing = (
				"I need supplies and recovered belongings brought here for sorting. Check the request, and keep "
				.. "personal effects together while you carry them. Bring everything on the list back here; I need "
				.. "the full delivery."
			),
			completion = "Thank you. Leave those here so I can sort them carefully.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_medical_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_4",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "WA22",
			completionCash = 2450,
			name = "The Final Name",
			kind = "field",
			objective = (
				"Recover the final identification file from the assigned search area in Garbage. Bring it back to "
				.. "the issuing contact in Garbage."
			),
			requires = {"WA21"},
			briefing = (
				"The final identification record needs to come back complete. I don't want a familiar name on one "
				.. "page deciding how we read the rest. Recover the final identification file from the assigned "
				.. "search area in Garbage. Bring it back to me in Garbage."
			),
			completion = (
				"You've given the search something firmer than the stories we began with. Thank you for staying "
				.. "with it. You can sit for a while; there is no next errand waiting in this conversation."
			),
			field = {
				description = (
					"A cardboard file folder with an emblem and printed wording on the front. Wake's note: \"The final "
					.. "identification record needs to come back complete.\""
				),
				kind = "recovery",
				map = "rp_garbage_cotz",
				tier = 2,
				cargo = "town_quest_personnel",
				label = "Final identification file",
			},
			benefits = {},
			recognition = "Wake's trusted contact",
		},
	},
})
