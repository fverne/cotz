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
	dialogue = {
		delivery = "On the clear part of the desk. Keep any loose pages with it.",
		completedGreeting = "Now the dates agree. Whether anyone likes the answer is another matter.",
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = "Documents. Keep the pages intact. A damaged date can make the rest very difficult to place.",
		progressionPrompt = "What else needs doing?",
		progression = (
			"I need records with dates and sources, and supplies to keep them readable. Which can you help "
			.. "with?"
		),
	},
	progression = {
		{
			id = "CA01",
			name = "Somewhere to File It",
			kind = "delivery",
			requires = {},
			briefing = (
				"Bring the supplies on this list. I'll keep them separate from the records until they're "
				.. "checked."
			),
			completion = "Thank you. I'll keep it away from the loose papers.",
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
			name = "The Maintenance Office",
			kind = "field",
			objective = "Recover Official File Folder from the assigned search area in Waystation. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"CA01"},
			briefing = "Recover a facility index in regional ruins.",
			completion = "Let me look at the date first.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_official",
				label = "The Maintenance Office - Official File Folder",
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
			id = "CA03",
			name = "A Useful Record",
			kind = "tracker",
			requires = {"CA02"},
			briefing = "Documents. Keep the pages intact. A damaged date can make the rest very difficult to place.",
			completion = (
				"You've kept the records coming. That gives me something to compare beyond people's "
				.. "recollections."
			),
			target = 2,
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
			id = "CA04",
			name = "A Date That Does Not Fit",
			kind = "field",
			objective = "Recover Corporate Records Folder from the assigned search area in Garbage. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"CA02"},
			briefing = "Retrieve a second dated record in Garbage.",
			completion = "Good. I'll compare it with the other copy.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_archive",
				label = "A Date That Does Not Fit - Corporate Records Folder",
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
			id = "CA05",
			name = "An Ordered Shelf",
			kind = "delivery",
			requires = {"CA03"},
			briefing = (
				"Bring the supplies on this list. I'll keep them separate from the records until they're "
				.. "checked."
			),
			completion = "Good. This should be useful.",
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
			id = "CA06",
			name = "The Original's Account",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Waystation. Deliver it to 'The"
				.. " Original' in Marsh, then return here to finish the assignment.",
			requires = {"CA04"},
			briefing = "Recover a contemporaneous expedition note for comparison.",
			completion = "The record has reached someone who can check it. Keep the dates in mind.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "The Original's Account - Tied Leather Journal",
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
			name = "Facts With Sources",
			kind = "tracker",
			requires = {"CA05"},
			briefing = "Documents. Keep the pages intact. A damaged date can make the rest very difficult to place.",
			completion = (
				"You've kept the records coming. That gives me something to compare beyond people's "
				.. "recollections."
			),
			target = 5,
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
			id = "CA08",
			name = "The Missing Annex",
			kind = "field",
			objective = "Recover Official File Folder from the assigned search area in Waystation. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"CA06"},
			briefing = "Recover a facility annex from a regional office site.",
			completion = "Let me look at the date first.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_official",
				label = "The Missing Annex - Official File Folder",
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
			id = "CA09",
			name = "Names and Numbers",
			kind = "delivery",
			requires = {"CA07"},
			briefing = (
				"Bring the supplies on this list. I'll keep them separate from the records until they're "
				.. "checked."
			),
			completion = "Put it here, please.",
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
			id = "CA10",
			name = "Egghead's Citation",
			kind = "field",
			objective = "Recover Laboratory Log Folder from the assigned search area in Waystation. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"CA08"},
			briefing = "Recover a referenced research record.",
			completion = "Good. I'll compare it with the other copy.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_lab",
				label = "Egghead's Citation - Laboratory Log Folder",
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
			id = "CA11",
			name = "A History That Agrees",
			kind = "tracker",
			requires = {"CA09"},
			briefing = "Documents. Keep the pages intact. A damaged date can make the rest very difficult to place.",
			completion = (
				"You've kept the records coming. That gives me something to compare beyond people's "
				.. "recollections."
			),
			target = 9,
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
			id = "CA12",
			name = "The Restricted Copy",
			kind = "field",
			objective = "Recover Loose Intelligence Dossier from the assigned search area in Waystation. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"CA10"},
			briefing = "Recover field evidence of an operation omitted from official records.",
			completion = "Thank you. I'll record where it was recovered.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_intel",
				label = "The Restricted Copy - Loose Intelligence Dossier",
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
			name = "Ready for the Archive",
			kind = "delivery",
			requires = {"CA11"},
			briefing = (
				"Bring the supplies on this list. I'll keep them separate from the records until they're "
				.. "checked."
			),
			completion = "Thank you. I'll keep it away from the loose papers.",
			requirements = {
				{
					pool = "administrative_documents",
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
			id = "CA14",
			name = "The Pripyat Index",
			kind = "field",
			objective = "Recover Corporate Records Folder from the assigned search area in Pripyat. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"CA12"},
			briefing = "Recover an archive index in Pripyat.",
			completion = "Let me look at the date first.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_archive",
				label = "The Pripyat Index - Corporate Records Folder",
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
			id = "CA15",
			name = "Every Page Accounted For",
			kind = "tracker",
			requires = {"CA13"},
			briefing = "Documents. Keep the pages intact. A damaged date can make the rest very difficult to place.",
			completion = (
				"You've kept the records coming. That gives me something to compare beyond people's "
				.. "recollections."
			),
			target = 14,
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
			id = "CA16",
			name = "The Administrative Trail",
			kind = "field",
			objective = "Recover Official File Folder from the assigned search area in Pripyat. Deliver it to"
				.. " 'Ledger' in Waystation, then return here to finish the assignment.",
			requires = {"CA14"},
			briefing = "Retrieve a surviving operations log at a second Pripyat site.",
			completion = "The record has reached someone who can check it. Keep the dates in mind.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_official",
				label = "The Administrative Trail - Official File Folder",
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
			id = "CA17",
			name = "The Missing Context",
			kind = "delivery",
			requires = {"CA15", "CA16"},
			briefing = (
				"Bring the supplies on this list. I'll keep them separate from the records until they're "
				.. "checked."
			),
			completion = "Good. This should be useful.",
			requirements = {
				{
					pool = "administrative_documents",
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
			id = "CA18",
			name = "The False Summary",
			kind = "field",
			objective = "Recover Blue Research Dossier from the assigned search area in Waystation. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"CA17"},
			briefing = "Recover the original record behind an altered report.",
			completion = "Thank you. I'll record where it was recovered.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_dossier",
				label = "The False Summary - Blue Research Dossier",
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
			name = "A Complete Dossier",
			kind = "tracker",
			requires = {"CA18"},
			briefing = "Documents. Keep the pages intact. A damaged date can make the rest very difficult to place.",
			completion = (
				"You've kept the records coming. That gives me something to compare beyond people's "
				.. "recollections."
			),
			target = 20,
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
			id = "CA20",
			name = "The Surviving Archive",
			kind = "field",
			objective = "Recover Corporate Records Folder from the assigned search area in Pripyat. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"CA19"},
			briefing = "Recover the central archive record in Pripyat.",
			completion = "Let me look at the date first.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_archive",
				label = "The Surviving Archive - Corporate Records Folder",
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
			stock = {
				item = "drink_bottlewater",
				bonus = 2,
			},
		},
		{
			id = "CA21",
			name = "Preserve the Originals",
			kind = "delivery",
			requires = {"CA20"},
			briefing = (
				"Bring the supplies on this list. I'll keep them separate from the records until they're "
				.. "checked."
			),
			completion = "Put it here, please.",
			requirements = {
				{
					pool = "administrative_documents",
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
			id = "CA22",
			name = "The Last Witness on Paper",
			kind = "field",
			objective = "Recover Scientist's Field Diary from the assigned search area in Waystation. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"CA21"},
			briefing = "Retrieve the final dated field record and return the complete dossier.",
			completion = "Good. I'll compare it with the other copy.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_diary",
				label = "The Last Witness on Paper - Scientist's Field Diary",
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
			recognition = "Carbon's trusted contact",
		},
	},
})
