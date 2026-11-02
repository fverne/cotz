PLUGIN:Register("carbon", {
	name = "'Carbon'",
	template = "carbonnpc",
	map = "rp_waystation",
	job = {
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		category = "Document deliveries",
		description = "Document deliveries",
		pools = {"administrative_documents", "documents_field", "documents_technical"},
		deliveryTiers = {
			easy = {
				pools = {
					"valuables_office_records",
					"valuables_field_records",
					"valuables_printed_material",
				},
				quantity = 1,
			},
			medium = {
				pools = {
					"valuables_technical_records",
				},
				quantity = 1,
			},
			hard = {
				pools = {
					"valuables_data_archives",
				},
				quantity = 2,
			},
		},
		quantities = {2, 4, 7},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Archive supplies (trade goods)",
				items = {"value_officepaper", "value_tape_duct"}},
			{label = "Reading provisions",
				items = {"drink_bottletea", "food_bread"}},
			{label = "Field research",
				items = {"medic_bandage_1", "drink_bottlewater"}},
		},
	},
	dialogue = {
		delivery = "On the clear part of the desk. Keep any loose pages with it.",
		completedGreeting = (
			"Hello again. I've got time if you want to talk. You've been patient enough with my "
			.. "questions."
		),
		workPrompt = "About the records I'm collecting.",
		offerPrompt = "Are there documents you need?",
		work = (
			"Surviving documents, kept intact and brought here. Check the request before choosing what looks "
			.. "important. An ordinary record may help place a much more exciting account. Please keep loose pages "
			.. "with the bundle they came from. I'd rather discover an uninteresting page myself than wonder "
			.. "whether it was left behind."
		),
		progressionPrompt = "Which part of the archive are you examining?",
		progression = (
			"I'm comparing facility records and expedition accounts. Some references lead to surviving papers; "
			.. "others leave a gap. I'd like help recovering what we can actually read before I try to explain the "
			.. "absences. There are ordinary document requests too. We can begin there without making a promise "
			.. "about what the last file will tell us."
		),
	},
	catalogue = {
	},
	progression = {
		{
			id = "CA01",
			completionCash = 275,
			name = "Somewhere to File It",
			kind = "delivery",
			requires = {},
			briefing = (
				"I would like some ordinary source material for the collection. Even a working record can tell us "
				.. "what somebody thought was worth writing down. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thank you. I will look through these before deciding where they belong.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
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
			id = "CA02",
			completionCash = 450,
			name = "The Maintenance Office",
			kind = "field",
			objective = (
				"Recover the facility maintenance index from the assigned search area in Waystation. Bring it back "
				.. "to the issuing contact in Waystation."
			),
			requires = {"CA01"},
			briefing = (
				"I'd like the facility index. An index often survives in conversation as a list of things someone "
				.. "remembers being important. Recover the facility maintenance index from the assigned search area "
				.. "in Waystation. Bring it back to me in Waystation."
			),
			completion = "Good. I'll keep its order while I work through the references.",
			field = {
				description = (
					"A cardboard file folder with a small coloured crest on its cover. Carbon's note: \"I'd like the "
					.. "facility index.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_official",
				label = "Facility maintenance index",
			},
			benefits = {},
		},
		{
			id = "CA03",
			completionCash = 0,
			name = "A Useful Record",
			kind = "tracker",
			requires = {"CA02"},
			briefing = (
				"Continue the document deliveries. More surviving records give us something against which to check "
				.. "an account."
			),
			completion = "A useful beginning. There is already more to compare.",
			target = 2,
			benefits = {},
		},
		{
			id = "CA04",
			completionCash = 650,
			name = "A small delivery",
			kind = "delivery",
			retiredCommission = true,
			objective = "Bring all 1 listed item type to this contact. The request shows each selected item and required units.",
			requires = {"CA02"},
			briefing = (
				"I would like some ordinary source material for the collection. Even a working record can tell us "
				.. "what somebody thought was worth writing down. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thank you. I will look through these before deciding where they belong.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "CA05",
			completionCash = 575,
			name = "An Ordered Shelf",
			kind = "delivery",
			requires = {"CA03"},
			briefing = (
				"I would like some ordinary source material for the collection. Even a working record can tell us "
				.. "what somebody thought was worth writing down. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thank you. I will look through these before deciding where they belong.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "CA06",
			completionCash = 850,
			name = "The Original's Account",
			kind = "field",
			objective = (
				"Recover the contemporary expedition diary from the assigned search area in Waystation. Deliver it "
				.. "to 'The Original' in Marsh, then come back to the issuing contact in Waystation."
			),
			requires = {"CA04"},
			briefing = (
				"The Original should read the expedition note himself. A detail may mean something to him that I "
				.. "wouldn't think to ask about. Recover the contemporary expedition diary from the assigned search "
				.. "area in Waystation. Deliver it to 'The Original' in Marsh, then come back to me in Waystation."
			),
			completion = (
				"He has the diary. I'll wait to hear what he recognises before treating a disagreement as a "
				.. "discovery."
			),
			field = {
				description = (
					"A thick brown journal held together by a narrow tie around its cover. Carbon's note: \"The "
					.. "Original should read the expedition note himself.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "Contemporary expedition diary",
				recipient = "the-original",
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
			id = "CA07",
			completionCash = 0,
			name = "Facts With Sources",
			kind = "tracker",
			requires = {"CA05"},
			briefing = "Keep bringing the requested documents. I want the context as well as the quotable sentence.",
			completion = "You've kept records together that could easily have been scattered.",
			target = 5,
			benefits = {},
		},
		{
			id = "CA08",
			completionCash = 1050,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"CA06"},
			briefing = (
				"I would like some ordinary source material for the collection. Even a working record can tell us "
				.. "what somebody thought was worth writing down. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thank you. I will look through these before deciding where they belong.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "CA09",
			completionCash = 875,
			name = "Names and Numbers",
			kind = "delivery",
			requires = {"CA07"},
			briefing = (
				"I would like some ordinary source material for the collection. Even a working record can tell us "
				.. "what somebody thought was worth writing down. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thank you. I will look through these before deciding where they belong.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "CA10",
			completionCash = 1250,
			name = "Egghead's Citation",
			kind = "field",
			objective = (
				"Recover the cited research record from the assigned search area in Waystation. Bring it back to "
				.. "the issuing contact in Waystation."
			),
			requires = {"CA08"},
			briefing = (
				"I'd like to find the record Egghead cited. Following a reference is more interesting when it "
				.. "leads somewhere other than another person's summary. Recover the cited research record from the "
				.. "assigned search area in Waystation. Bring it back to me in Waystation."
			),
			completion = "Excellent. I can begin with what the author actually wrote.",
			field = {
				description = (
					"A blue laboratory folder with loose printed record sheets extending from its edges. Carbon's "
					.. "note: \"I'd like to find the record Egghead cited.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_lab",
				label = "Cited research record",
			},
			benefits = {},
		},
		{
			id = "CA11",
			completionCash = 0,
			name = "A History That Agrees",
			kind = "tracker",
			requires = {"CA09"},
			briefing = "More document orders when you're ready. Keep their sources distinct where the records allow it.",
			completion = "A useful range of material. I'll take time to read it without forcing an agreement.",
			target = 9,
			benefits = {},
		},
		{
			id = "CA12",
			completionCash = 1450,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"CA10"},
			briefing = (
				"I would like some ordinary source material for the collection. Even a working record can tell us "
				.. "what somebody thought was worth writing down. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thank you. I will look through these before deciding where they belong.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_2",
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
			id = "CA13",
			completionCash = 1175,
			name = "Ready for the Archive",
			kind = "delivery",
			requires = {"CA11"},
			briefing = (
				"I would like some ordinary source material for the collection. Even a working record can tell us "
				.. "what somebody thought was worth writing down. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thank you. I will look through these before deciding where they belong.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_records_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "CA14",
			completionCash = 1650,
			name = "The Pripyat Index",
			kind = "field",
			objective = (
				"Recover the Pripyat archive index from the assigned search area in Pripyat. Bring it back to the "
				.. "issuing contact in Waystation."
			),
			requires = {"CA12"},
			briefing = (
				"The archive index may show how the records were arranged. I want to understand that before "
				.. "borrowing its headings for my own account. Recover the Pripyat archive index from the assigned "
				.. "search area in Pripyat. Bring it back to me in Waystation."
			),
			completion = "Thank you. An index gives me rather more to do than it appears to.",
			field = {
				description = (
					"A blue records folder with contrasting corporate lettering along the cover. Carbon's note: \"The "
					.. "archive index may show how the records were arranged.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_archive",
				label = "Pripyat archive index",
			},
			benefits = {},
		},
		{
			id = "CA15",
			completionCash = 0,
			name = "Every Page Accounted For",
			kind = "tracker",
			requires = {"CA13"},
			briefing = "Continue the record deliveries while I examine the archive references.",
			completion = "You've stayed with the ordinary collecting. That is how a comparison becomes possible.",
			target = 14,
			benefits = {},
		},
		{
			id = "CA16",
			completionCash = 1850,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"CA14"},
			briefing = (
				"I would like some ordinary source material for the collection. Even a working record can tell us "
				.. "what somebody thought was worth writing down. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thank you. I will look through these before deciding where they belong.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_records_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "CA17",
			completionCash = 1475,
			name = "The Missing Context",
			kind = "delivery",
			requires = {"CA15", "CA16"},
			briefing = (
				"I would like some ordinary source material for the collection. Even a working record can tell us "
				.. "what somebody thought was worth writing down. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thank you. I will look through these before deciding where they belong.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_records_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "CA18",
			completionCash = 2050,
			name = "The False Summary",
			kind = "field",
			objective = (
				"Recover the source of the altered summary from the assigned search area in Waystation. Bring it "
				.. "back to the issuing contact in Waystation."
			),
			requires = {"CA17"},
			briefing = (
				"I want the source record behind the summary. We need the surrounding text before deciding what "
				.. "was changed and why. Recover the source of the altered summary from the assigned search area in "
				.. "Waystation. Bring it back to me in Waystation."
			),
			completion = "I'll put the versions side by side. That is a better beginning than announcing a culprit.",
			field = {
				description = (
					"A blue document folder with loose pages protruding from the edges. Carbon's note: \"I want the "
					.. "source record behind the summary.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_dossier",
				label = "Source of the altered summary",
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
			id = "CA19",
			completionCash = 0,
			name = "A Complete Dossier",
			kind = "tracker",
			requires = {"CA18"},
			briefing = "Keep the document deliveries going. New material can qualify an account we thought was settled.",
			completion = "I've got enough beside me to ask better questions now. Thank you.",
			target = 20,
			benefits = {},
		},
		{
			id = "CA20",
			completionCash = 2250,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"CA19"},
			briefing = (
				"I would like some ordinary source material for the collection. Even a working record can tell us "
				.. "what somebody thought was worth writing down. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thank you. I will look through these before deciding where they belong.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_records_waystation_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_records_waystation_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_4",
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
			id = "CA21",
			completionCash = 1775,
			name = "Preserve the Originals",
			kind = "delivery",
			requires = {"CA20"},
			briefing = (
				"I would like some ordinary source material for the collection. Even a working record can tell us "
				.. "what somebody thought was worth writing down. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thank you. I will look through these before deciding where they belong.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_records_waystation_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_records_waystation_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_4",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "CA22",
			completionCash = 2450,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"CA21"},
			briefing = (
				"I would like some ordinary source material for the collection. Even a working record can tell us "
				.. "what somebody thought was worth writing down. Bring everything on the list back here; I need the "
				.. "full delivery."
			),
			completion = "Thank you. I will look through these before deciding where they belong.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_records_waystation_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_records_waystation_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_records_waystation_4",
					quantity = 1,
				},
			},
			benefits = {},
			recognition = "Carbon's trusted contact",
		},
	},
})
