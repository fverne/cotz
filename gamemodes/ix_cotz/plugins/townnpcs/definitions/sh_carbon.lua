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
				"I need the administrative records on this list brought here. A useful account deserves "
				.. "somewhere to go when it arrives. Otherwise I end up with a stack of pages and an "
				.. "increasingly imaginative system for remembering which is which."
			),
			completion = (
				"Thank you. I'll sort these before the next stack lands on top of them. A filing system is "
				.. "only impressive when someone besides its inventor can find anything."
			),
			requirements = {
				{
					pool = "administrative_documents",
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
			name = "A Date That Does Not Fit",
			kind = "field",
			objective = (
				"Recover the disputed-date record from the assigned search area in Garbage. Bring it back to the "
				.. "issuing contact in Waystation."
			),
			requires = {"CA02"},
			briefing = (
				"There's a second dated record to recover. I want to see the date in context before calling either "
				.. "account wrong. Recover the disputed-date record from the assigned search area in Garbage. Bring "
				.. "it back to me in Waystation."
			),
			completion = "Let me check the surrounding entries. One number is a tempting amount of evidence.",
			field = {
				description = (
					"A blue records folder with contrasting corporate lettering along the cover. Carbon's note: "
					.. "\"There's a second dated record to recover.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_archive",
				label = "Disputed-date record",
			},
			benefits = {},
		},
		{
			id = "CA05",
			completionCash = 575,
			name = "An Ordered Shelf",
			kind = "delivery",
			requires = {"CA03"},
			briefing = "Bring the requested documents here together. Please keep the little slips with the larger sheets.",
			completion = "Thank you. I'll record what arrived before sorting it.",
			requirements = {
				{
					pool = "administrative_documents",
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
			name = "The Missing Annex",
			kind = "field",
			objective = (
				"Recover the missing facility annex from the assigned search area in Waystation. Bring it back to "
				.. "the issuing contact in Waystation."
			),
			requires = {"CA06"},
			briefing = (
				"The annex belongs with the facility account. I'd like the pages that were inconvenient to "
				.. "summarise as well as the summary. Recover the missing facility annex from the assigned search "
				.. "area in Waystation. Bring it back to me in Waystation."
			),
			completion = "Here, beside the main file. I'll check which references it actually answers.",
			field = {
				description = (
					"A cardboard file folder with a small coloured crest on its cover. Carbon's note: \"The annex "
					.. "belongs with the facility account.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_official",
				label = "Missing facility annex",
			},
			benefits = {},
		},
		{
			id = "CA09",
			completionCash = 875,
			name = "Names and Numbers",
			kind = "delivery",
			requires = {"CA07"},
			briefing = "I'd like another set of the listed records. Their original order may be worth preserving.",
			completion = "Leave them flat. I'll read before rearranging anything.",
			requirements = {
				{
					pool = "administrative_documents",
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
			name = "The Restricted Copy",
			kind = "field",
			objective = (
				"Recover the restricted operations dossier from the assigned search area in Waystation. Bring it "
				.. "back to the issuing contact in Waystation."
			),
			requires = {"CA10"},
			briefing = (
				"There's field evidence missing from the official account. An omission is a question; I don't want "
				.. "to fill it with my preferred answer. Recover the restricted operations dossier from the assigned "
				.. "search area in Waystation. Bring it back to me in Waystation."
			),
			completion = (
				"Leave it intact. I'll read the complete dossier before pulling out anything that looks "
				.. "significant."
			),
			field = {
				description = (
					"A brown document folder with loose sheets and slips protruding from its edges. Carbon's note: "
					.. "\"There's field evidence missing from the official account.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_intel",
				label = "Restricted operations dossier",
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
				"There are more documents to collect. A dull heading is not a reason to leave a requested page "
				.. "behind."
			),
			completion = "Good. An ordinary entry may answer an unexpected question.",
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 2,
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
			name = "The Administrative Trail",
			kind = "field",
			objective = (
				"Recover the operations log for Ledger from the assigned search area in Pripyat. Deliver it to "
				.. "'Ledger' in Waystation, then come back to the issuing contact in Waystation."
			),
			requires = {"CA14"},
			briefing = (
				"Ledger should examine the operations log. He understands what a dispatch entry commits someone "
				.. "else to doing. Recover the operations log for Ledger from the assigned search area in Pripyat. "
				.. "Deliver it to 'Ledger' in Waystation, then come back to me in Waystation."
			),
			completion = "He has the log. I'll make room for whatever qualifications he brings back with his reading.",
			field = {
				description = (
					"A cardboard file folder with a small coloured crest on its cover. Carbon's note: \"Ledger should "
					.. "examine the operations log.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_official",
				label = "Operations log for Ledger",
				recipient = "ledger",
			},
			benefits = {},
		},
		{
			id = "CA17",
			completionCash = 1475,
			name = "The Missing Context",
			kind = "delivery",
			requires = {"CA15", "CA16"},
			briefing = "Bring the listed records intact. I'll decide where they belong after I've examined the originals.",
			completion = "Thank you. I'll keep this bundle separate until I've checked it.",
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 2,
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
			name = "The Surviving Archive",
			kind = "field",
			objective = (
				"Recover the surviving archive dossier from the assigned search area in Pripyat. Bring it back to "
				.. "the issuing contact in Waystation."
			),
			requires = {"CA19"},
			briefing = (
				"There's a surviving archive file in Pripyat. Keep the little slips with the larger pages; their "
				.. "order may be worth preserving. Recover the surviving archive dossier from the assigned search "
				.. "area in Pripyat. Bring it back to me in Waystation."
			),
			completion = "A complete bundle. Thank you for resisting the urge to sort it on the journey.",
			field = {
				description = (
					"A blue records folder with contrasting corporate lettering along the cover. Carbon's note: "
					.. "\"There's a surviving archive file in Pripyat.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_archive",
				label = "Surviving archive dossier",
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
			briefing = "Bring the requested documents here together. Please keep the little slips with the larger sheets.",
			completion = "Thank you. I'll record what arrived before sorting it.",
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 2,
				},
			},
			benefits = {},
		},
		{
			id = "CA22",
			completionCash = 2450,
			name = "The Last Witness on Paper",
			kind = "field",
			objective = (
				"Recover the last dated field diary from the assigned search area in Waystation. Bring it back to "
				.. "the issuing contact in Waystation."
			),
			requires = {"CA21"},
			briefing = (
				"I'd like the final diary kept intact. The dates around an entry can change how you read the entry "
				.. "itself. Recover the last dated field diary from the assigned search area in Waystation. Bring it "
				.. "back to me in Waystation."
			),
			completion = (
				"You've helped preserve more than a conclusion. I can show how we reached it, and where the record "
				.. "still falls quiet. Stay, if you're interested; I'd enjoy reading some of it with you."
			),
			field = {
				description = (
					"A thick blue diary with a label fixed to the front cover. Carbon's note: \"I'd like the final "
					.. "diary kept intact.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_diary",
				label = "Last dated field diary",
			},
			benefits = {},
			recognition = "Carbon's trusted contact",
		},
	},
})
