PLUGIN:Register("gasket", {
	name = "'Gasket'",
	template = "gasketnpc",
	map = "rp_marsh_cs",
	job = {
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		category = "Utility supply deliveries",
		description = "Utility supply deliveries",
		pools = {"fuel", "filters", "engine_care"},
		quantities = {2, 4, 7},
		maps = {
			easy = "rp_marsh_cs",
			medium = "mz_garbage",
			hard = "rp_pripyat_remaster",
		},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	dialogue = {
		completedGreeting = (
			"You've covered what I needed for the service work. Now let's see who borrows it "
			.. "first."
		),
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = "Fuel, filters, service supplies. I need things we use up, not another broken machine.",
		progressionPrompt = "What else needs doing?",
		progression = (
			"Start with the supplies. I've also got service records to find; guessing what a pump needs "
			.. "gets expensive."
		),
	},
	progression = {
		{
			id = "GK01",
			name = "Keep It Turning",
			kind = "delivery",
			requires = {},
			briefing = "This is what I'm short of. Check the list before carrying something heavy all the way here.",
			completion = "Put it down before you spill it.",
			requirements = {
				{
					pool = "fuel",
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
			id = "GK02",
			name = "The Empty Service Shed",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"GK01"},
			briefing = "Recover generator service notes in Marsh.",
			completion = "Here, away from the fuel. Let me open it.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
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
			id = "GK03",
			name = "The First Reserve",
			kind = "tracker",
			requires = {"GK02"},
			briefing = "Fuel, filters, service supplies. I need things we use up, not another broken machine.",
			completion = "You've kept the consumables coming. Keep an eye on what runs out first.",
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
			id = "GK04",
			name = "Technut's Regulator",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"GK03"},
			briefing = "Recover a utility component case from a Marsh service site.",
			completion = "Good. Let's see what they wrote down.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
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
			id = "GK05",
			name = "Water Before Comfort",
			kind = "delivery",
			requires = {"GK03"},
			briefing = "This is what I'm short of. Check the list before carrying something heavy all the way here.",
			completion = "Right. I can use that.",
			requirements = {
				{
					pool = "filters",
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
			id = "GK06",
			name = "The Pump Log",
			kind = "field",
			objective = (
				"Deploy the recorder at the marked site, remain in range until it finishes, and collect it "
				.. "in Marsh. Return to this contact to finish the assignment."
			),
			requires = {"GK04"},
			briefing = "Retrieve the last maintenance record at a waterside facility.",
			completion = "You found it. Saves another argument about the specifications.",
			field = {
				kind = "sensor",
				map = "rp_marsh_cs",
				tier = 1,
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
			id = "GK07",
			name = "A Steady Supply",
			kind = "tracker",
			requires = {"GK05"},
			briefing = "Fuel, filters, service supplies. I need things we use up, not another broken machine.",
			completion = "You've kept the consumables coming. Keep an eye on what runs out first.",
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
			id = "GK08",
			name = "The Bad Intake",
			kind = "field",
			objective = (
				"Deploy the recorder at the marked site, remain in range until it finishes, and collect it "
				.. "in Marsh. Return to this contact to finish the assignment."
			),
			requires = {"GK06"},
			briefing = "Deploy and recover a recorder near an intake site.",
			completion = "Here, away from the fuel. Let me open it.",
			field = {
				kind = "sensor",
				map = "rp_marsh_cs",
				tier = 1,
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
			id = "GK09",
			name = "Backup Power",
			kind = "delivery",
			requires = {"GK07"},
			briefing = "This is what I'm short of. Check the list before carrying something heavy all the way here.",
			completion = "That'll cover the next service.",
			requirements = {
				{
					pool = "engine_care",
					quantity = 3,
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
			id = "GK10",
			name = "The Scrap Specification",
			kind = "field",
			objective = "Recover the marked case in Garbage. Return to this contact to finish the assignment.",
			requires = {"GK08"},
			briefing = "Recover a part specification in Garbage for Latch.",
			completion = "Good. Let's see what they wrote down.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
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
			id = "GK11",
			name = "More Than One Tank",
			kind = "tracker",
			requires = {"GK09"},
			briefing = "Fuel, filters, service supplies. I need things we use up, not another broken machine.",
			completion = "You've kept the consumables coming. Keep an eye on what runs out first.",
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
			id = "GK12",
			name = "The Forgotten Store",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"GK10"},
			briefing = "Recover a reserve supply case near industrial wreckage.",
			completion = "You found it. Saves another argument about the specifications.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
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
			id = "GK13",
			name = "Before the Blowout",
			kind = "delivery",
			requires = {"GK11"},
			briefing = "This is what I'm short of. Check the list before carrying something heavy all the way here.",
			completion = "Put it down before you spill it.",
			requirements = {
				{
					pool = "fuel",
					quantity = 4,
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
			id = "GK14",
			name = "The Shelter Circuit",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"GK12"},
			briefing = "Recover a service recorder at a remote shelter.",
			completion = "Here, away from the fuel. Let me open it.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
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
			id = "GK15",
			name = "Nothing Left Dry",
			kind = "tracker",
			requires = {"GK13"},
			briefing = "Fuel, filters, service supplies. I need things we use up, not another broken machine.",
			completion = "You've kept the consumables coming. Keep an eye on what runs out first.",
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
			id = "GK16",
			name = "The Long Supply Line",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"GK14"},
			briefing = "Retrieve freight evidence on a regional utility route.",
			completion = "Good. Let's see what they wrote down.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
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
			id = "GK17",
			name = "A Season of Spares",
			kind = "delivery",
			requires = {"GK15"},
			briefing = "This is what I'm short of. Check the list before carrying something heavy all the way here.",
			completion = "Right. I can use that.",
			requirements = {
				{
					pool = "filters",
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
			id = "GK18",
			name = "The Original Manual",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"GK16"},
			briefing = "Recover old utility documentation at a remote facility.",
			completion = "You found it. Saves another argument about the specifications.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
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
			id = "GK19",
			name = "A Town That Runs",
			kind = "tracker",
			requires = {"GK17", "GK18"},
			briefing = "Fuel, filters, service supplies. I need things we use up, not another broken machine.",
			completion = "You've kept the consumables coming. Keep an eye on what runs out first.",
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
			id = "GK20",
			name = "The Emergency Test",
			kind = "field",
			objective = (
				"Deploy the recorder at the marked site, remain in range until it finishes, and collect it "
				.. "in Marsh. Return to this contact to finish the assignment."
			),
			requires = {"GK19"},
			briefing = "Deploy and recover a recorder at a service site.",
			completion = "Here, away from the fuel. Let me open it.",
			field = {
				kind = "sensor",
				map = "rp_marsh_cs",
				tier = 2,
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
			id = "GK21",
			name = "Enough in Reserve",
			kind = "delivery",
			requires = {"GK20"},
			briefing = "This is what I'm short of. Check the list before carrying something heavy all the way here.",
			completion = "That'll cover the next service.",
			requirements = {
				{
					pool = "engine_care",
					quantity = 6,
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
			id = "GK22",
			name = "A Light Left On",
			kind = "field",
			objective = "Recover the marked case in Marsh. Return to this contact to finish the assignment.",
			requires = {"GK21"},
			briefing = "Recover the last service record and conclude the utilities project.",
			completion = "Good. Let's see what they wrote down.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
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
			recognition = "Gasket's trusted contact",
		},
	},
})
