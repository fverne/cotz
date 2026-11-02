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
		deliveryTiers = {
			easy = {
				pools = {
					"valuables_cleaning_supplies",
					"valuables_fuel_supplies",
				},
				quantity = 1,
			},
			medium = {
				pools = {
					"valuables_filtration",
					"valuables_electrical_supplies",
				},
				quantity = 1,
			},
			hard = {
				pools = {
					"valuables_portable_power",
					"valuables_reinforced_cases",
				},
				quantity = 2,
			},
		},
		quantities = {2, 4, 7},
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Fuel allowance",
				items = {"lowtiercookerfuel"}},
			{label = "Utility stores (trade goods)",
				items = {"value_battery", "value_waterfilter", "value_airfilter"}},
			{label = "Reserve provisions",
				items = {"drink_bottlewater", "food_bread"}},
		},
	},
	dialogue = {
		delivery = "Put it on the clear bench. Not beside the fuel.",
		completedGreeting = (
			"Good to see you. Give me a moment to finish this before you tell me what somebody's been "
			.. "touching."
		),
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = (
			"Fuel, filters, service supplies. I need things we use up, not another broken machine. Everybody "
			.. "remembers fuel when something stops. I'd rather have the next lot on hand before we reach that "
			.. "interesting moment."
		),
		progressionPrompt = "What else needs doing?",
		progression = (
			"Start with the supplies. I've also got service records to find; guessing what a pump needs gets "
			.. "expensive. I want supplies I can use and records I can read without guessing what the last fellow "
			.. "meant. No grand scheme. Just fewer unpleasant surprises when I take something apart."
		),
	},
	catalogue = {
		["mask_cloth"] = {step = "GK01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mask_gp5"] = {step = "GK07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mask_halfmask"] = {step = "GK03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mask_respirator"] = {step = "GK05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "GK01",
			completionCash = 275,
			name = "Keep It Turning",
			kind = "delivery",
			requires = {},
			briefing = (
				"Fuel. The kind on the list, brought here. People get surprisingly interested in the "
				.. "generator when it stops; I'd like to have something ready before they come and explain the "
				.. "problem to me."
			),
			completion = (
				"That's what I asked for. Good. I'll put it where it belongs. If anyone asks, the lights are "
				.. "still on because people brought fuel, not because the machine developed a generous nature."
			),
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
			completionCash = 450,
			name = "The Empty Service Shed",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"GK01"},
			briefing = "Recover generator service notes in Marsh.",
			completion = "Here, away from the fuel. Let me open it.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "The Empty Service Shed - Tied Leather Journal",
			},
			benefits = {},
		},
		{
			id = "GK03",
			completionCash = 0,
			name = "The First Reserve",
			kind = "tracker",
			requires = {"GK02"},
			briefing = "Fuel, filters, service supplies. I need things we use up, not another broken machine.",
			completion = "You've kept the consumables coming. Keep an eye on what runs out first.",
			target = 2,
			benefits = {},
		},
		{
			id = "GK04",
			completionCash = 650,
			name = "Technut's Regulator",
			kind = "field",
			objective = "Recover Red-Trimmed Control Unit from the assigned search area in Marsh. Deliver it to"
				.. " 'Technut' in Marsh, then return here to finish the assignment.",
			requires = {"GK03"},
			briefing = "Recover a utility component case from a Marsh service site.",
			completion = "About time that reached the right bench. Perhaps we can keep something running now.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_control",
				label = "Technut's Regulator - Red-Trimmed Control Unit",
				recipient = "technut",
			},
			benefits = {},
		},
		{
			id = "GK05",
			completionCash = 575,
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
			benefits = {},
		},
		{
			id = "GK06",
			completionCash = 850,
			name = "The Pump Log",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"GK04"},
			briefing = "Retrieve the last maintenance record at a waterside facility.",
			completion = "You found it. Saves another argument about the specifications.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_notebook",
				label = "The Pump Log - Tied Leather Journal",
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
			completionCash = 0,
			name = "A Steady Supply",
			kind = "tracker",
			requires = {"GK05"},
			briefing = "Fuel, filters, service supplies. I need things we use up, not another broken machine.",
			completion = "You've kept the consumables coming. Keep an eye on what runs out first.",
			target = 5,
			benefits = {},
		},
		{
			id = "GK08",
			completionCash = 1050,
			name = "The Bad Intake",
			kind = "field",
			objective = "Deploy the recorder in Marsh, leave it to record, then retrieve Numbered Data Module 0013."
				.. " Return it to this contact to finish the assignment.",
			requires = {"GK06"},
			briefing = "Deploy and recover a recorder near an intake site.",
			completion = "Here, away from the fuel. Let me open it.",
			field = {
				kind = "sensor",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_module",
				label = "The Bad Intake - Numbered Data Module 0013",
			},
			benefits = {},
		},
		{
			id = "GK09",
			completionCash = 875,
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
			benefits = {},
		},
		{
			id = "GK10",
			completionCash = 1250,
			name = "The Scrap Specification",
			kind = "field",
			objective = "Recover Official File Folder from the assigned search area in Garbage. Deliver it to 'Latch'"
				.. " in Garbage, then return here to finish the assignment.",
			requires = {"GK08"},
			briefing = "Recover a part specification in Garbage for Latch.",
			completion = "About time that reached the right bench. Perhaps we can keep something running now.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_official",
				label = "The Scrap Specification - Official File Folder",
				recipient = "latch",
			},
			benefits = {},
		},
		{
			id = "GK11",
			completionCash = 0,
			name = "More Than One Tank",
			kind = "tracker",
			requires = {"GK09"},
			briefing = "Fuel, filters, service supplies. I need things we use up, not another broken machine.",
			completion = "You've kept the consumables coming. Keep an eye on what runs out first.",
			target = 9,
			benefits = {},
		},
		{
			id = "GK12",
			completionCash = 1450,
			name = "The Forgotten Store",
			kind = "field",
			objective = "Recover Small Yellow Transit Case from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"GK10"},
			briefing = (
				"Recover a reserve supply case near industrial wreckage. I'm interested in what's "
				.. "recoverable, not in you straining yourself to bring back something too damaged to use."
			),
			completion = (
				"You found it. Saves another argument about the specifications. Set it somewhere steady. "
				.. "I'll inspect it before deciding what we can rely on; we've got enough surprises "
				.. "already."
			),
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_case",
				label = "The Forgotten Store - Small Yellow Transit Case",
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
			completionCash = 1175,
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
			benefits = {},
		},
		{
			id = "GK14",
			completionCash = 1650,
			name = "The Shelter Circuit",
			kind = "field",
			objective = "Recover Numbered Data Module 0022 from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"GK12"},
			briefing = "Recover a service recorder at a remote shelter.",
			completion = "Here, away from the fuel. Let me open it.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_module2",
				label = "The Shelter Circuit - Numbered Data Module 0022",
			},
			benefits = {},
		},
		{
			id = "GK15",
			completionCash = 0,
			name = "Nothing Left Dry",
			kind = "tracker",
			requires = {"GK13"},
			briefing = "Fuel, filters, service supplies. I need things we use up, not another broken machine.",
			completion = "You've kept the consumables coming. Keep an eye on what runs out first.",
			target = 14,
			benefits = {},
		},
		{
			id = "GK16",
			completionCash = 1850,
			name = "The Long Supply Line",
			kind = "field",
			objective = "Recover Warehouse Packing List A from the assigned search area in Marsh. Deliver it to"
				.. " 'Ledger' in Waystation, then return here to finish the assignment.",
			requires = {"GK14"},
			briefing = "Retrieve freight evidence on a regional utility route.",
			completion = "About time that reached the right bench. Perhaps we can keep something running now.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_manifest",
				label = "The Long Supply Line - Warehouse Packing List A",
				recipient = "ledger",
			},
			benefits = {},
		},
		{
			id = "GK17",
			completionCash = 1475,
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
			benefits = {},
		},
		{
			id = "GK18",
			completionCash = 2050,
			name = "The Original Manual",
			kind = "field",
			objective = "Recover Official File Folder from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"GK16"},
			briefing = "Recover old utility documentation at a remote facility.",
			completion = "You found it. Saves another argument about the specifications.",
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_official",
				label = "The Original Manual - Official File Folder",
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
			completionCash = 0,
			name = "A Town That Runs",
			kind = "tracker",
			requires = {"GK17", "GK18"},
			briefing = "Fuel, filters, service supplies. I need things we use up, not another broken machine.",
			completion = "You've kept the consumables coming. Keep an eye on what runs out first.",
			target = 20,
			benefits = {},
		},
		{
			id = "GK20",
			completionCash = 2250,
			name = "The Emergency Test",
			kind = "field",
			objective = "Deploy the recorder in Marsh, leave it to record, then retrieve Numbered Data Module 0013."
				.. " Return it to this contact to finish the assignment.",
			requires = {"GK19"},
			briefing = "Deploy and recover a recorder at a service site.",
			completion = "Here, away from the fuel. Let me open it.",
			field = {
				kind = "sensor",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_module",
				label = "The Emergency Test - Numbered Data Module 0013",
			},
			benefits = {},
			stock = {
				item = "drink_bottlewater",
				bonus = 2,
			},
		},
		{
			id = "GK21",
			completionCash = 1775,
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
			benefits = {},
		},
		{
			id = "GK22",
			completionCash = 2450,
			name = "A Light Left On",
			kind = "field",
			objective = "Recover Tied Leather Journal from the assigned search area in Marsh. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"GK21"},
			briefing = (
				"Recover the last service record and conclude the utilities project. Bring the journal back whole. "
				.. "Whoever kept servicing the place may have written down the small things nobody thought worth "
				.. "putting in a manual."
			),
			completion = (
				"Good. Let's see what they wrote down. Look at that. Someone kept making notes even when the job "
				.. "was a nuisance. I know the feeling. You've saved me a fair amount of trouble. I'll try not to "
				.. "spoil the moment by asking for something else."
			),
			field = {
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_notebook",
				label = "A Light Left On - Tied Leather Journal",
			},
			benefits = {},
			recognition = "Gasket's trusted contact",
		},
	},
})
