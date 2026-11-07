PLUGIN:Register("boss", {
	name = "'Boss'",
	template = "unisgnpc2",
	difficultyMultiplier = 3,
	enforceCatalogue = true,
	map = "rp_waystation",
	courierPools = {
		"valuables_secured_cases",
		"valuables_military_cases",
		"valuables_control_electronics",
		"valuables_technical_records",
	},
	job = {
		category = "Regional human elimination",
		description = "Regional human elimination",
		kind = "regionalHumans",
		maps = {
			easy = "rp_garbage_cotz",
			hard = "rp_pripyat_remaster",
			medium = "rp_waystation",
		},
	},
	legacyJob = {
		category = "Hostile human elimination",
		description = "Hostile human elimination",
		kind = "humans",
		quantities = {5, 9, 15},
		trigger = "banditKilled",
	},
	supplies = {},
	rewards = {
		bonusCash = true,
		bonusPackages = {
			{
				items = {"545x39ap", "556x45ap"},
				label = "Specialist ammunition",
			},
		},
		packages = {
			{
				items = {"545x39"},
				label = "Combat ammunition",
			},
			{
				items = {"medic_medkit_1"},
				label = "Medical supplies",
			},
			{
				items = {"food_can_tushonka"},
				label = "Canned provisions",
			},
		},
	},
	dialogue = {
		completedGreeting = "Good to see you back. You've earned a proper hearing. What do you need?",
		jobBriefing = "There's a job I need carried out. {details}",
		jobFinished = "The work is done. Your payment can be settled here.",
		jobReminder = "Our arrangement still stands. {details}",
		offerPrompt = "Do you have an elimination assignment?",
		progression = "There is an allocation to fill. Check the request before bringing anything; I need to know what I can actually issue. Bring everything on the list back here; I need the full delivery.",
		progressionPrompt = "What needs checking in the operation's reports?",
		work = "Hostile elimination orders, against the targets specified. Read the assignment before accepting it. I need a defined threat dealt with and an accurate return, rather than another problem created by an expanded interpretation. Ask about anything that affects your decision while we can still settle it here.",
		workPrompt = "About my current orders.",
	},
	disabledItems = {
		accesscard_bunker = true,
	},
	catalogue = {
		helm_operator_rus_1 = {
			step = "v3/helmets/helm_operator_rus_1",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		headwear_cs4 = {
			step = "v3/helmets/headwear_cs4",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		headwear_screen = {
			step = "v3/helmets/headwear_screen",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		helm_sphere08 = {
			step = "v3/helmets/helm_sphere08",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		helm_sphere12 = {
			step = "v3/helmets/helm_sphere12",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		helm_operator_nato = {
			step = "v3/helmets/helm_operator_nato",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		headwear_pracs = {
			step = "v3/helmets/headwear_pracs",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		headwear_psz12 = {
			step = "v3/helmets/headwear_psz12",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
	},
	progression = {
		{
			id = "v3/helmets/helm_operator_rus_1",
			branch = "helmets",
			name = "PASGT",
			kind = "delivery",
			requires = {},
			briefing = "There is an allocation to fill. Check the request before bringing anything; I need to know what I can actually issue. Bring everything on the list back here; I need the full delivery.",
			completion = "Received. I will account for these with the other supplies.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 450,
		},
		{
			id = "v3/helmets/headwear_cs4",
			branch = "helmets",
			name = "FSB Helmet (CS-4)",
			kind = "delivery",
			requires = {"v3/helmets/helm_operator_rus_1"},
			briefing = "There is an allocation to fill. Check the request before bringing anything; I need to know what I can actually issue. Bring everything on the list back here; I need the full delivery.",
			completion = "Received. I will account for these with the other supplies.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 800,
		},
		{
			id = "v3/helmets/headwear_screen",
			branch = "helmets",
			name = "Screen Helmet",
			kind = "delivery",
			requires = {"v3/helmets/headwear_cs4"},
			briefing = "There is an allocation to fill. Check the request before bringing anything; I need to know what I can actually issue. Bring everything on the list back here; I need the full delivery.",
			completion = "Received. I will account for these with the other supplies.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 1150,
		},
		{
			id = "v3/helmets/helm_sphere08",
			branch = "helmets",
			name = "Sphere-08 Helmet",
			kind = "delivery",
			requires = {"v3/helmets/headwear_screen"},
			briefing = "There is an allocation to fill. Check the request before bringing anything; I need to know what I can actually issue. Bring everything on the list back here; I need the full delivery.",
			completion = "Received. I will account for these with the other supplies.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_waystation_2",
					quantity = 1,
				},
			},
			completionCash = 1500,
		},
		{
			id = "v3/helmets/helm_sphere12",
			branch = "helmets",
			name = "Sphere-12 Helmet",
			kind = "delivery",
			requires = {"v3/helmets/helm_sphere08"},
			briefing = "There is an allocation to fill. Check the request before bringing anything; I need to know what I can actually issue. Bring everything on the list back here; I need the full delivery.",
			completion = "Received. I will account for these with the other supplies.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_waystation_2",
					quantity = 1,
				},
			},
			completionCash = 1900,
		},
		{
			id = "v3/helmets/helm_operator_nato",
			branch = "helmets",
			name = "ACH Helmet",
			kind = "delivery",
			requires = {"v3/helmets/helm_sphere12"},
			briefing = "There is an allocation to fill. Check the request before bringing anything; I need to know what I can actually issue. Bring everything on the list back here; I need the full delivery.",
			completion = "Received. I will account for these with the other supplies.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_waystation_3",
					quantity = 1,
				},
			},
			completionCash = 2250,
		},
		{
			id = "v3/helmets/headwear_pracs",
			branch = "helmets",
			name = "PRACS",
			kind = "delivery",
			requires = {"v3/helmets/helm_operator_nato"},
			briefing = "There is an allocation to fill. Check the request before bringing anything; I need to know what I can actually issue. Bring everything on the list back here; I need the full delivery.",
			completion = "Received. I will account for these with the other supplies.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_waystation_3",
					quantity = 1,
				},
			},
			completionCash = 2600,
		},
		{
			id = "v3/helmets/headwear_psz12",
			branch = "helmets",
			name = "PSZ-12",
			kind = "delivery",
			requires = {"v3/helmets/headwear_pracs"},
			briefing = "There is an allocation to fill. Check the request before bringing anything; I need to know what I can actually issue. Bring everything on the list back here; I need the full delivery.",
			completion = "Received. I will account for these with the other supplies.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_military_waystation_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_waystation_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_waystation_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
		},
	},
	startingServices = {},
	retiredCommissions = {
		{
			id = "BO02",
			name = "The Missing Patrol",
			briefing = "The patrol report needs recovering. I want the surviving account before we decide which part of the plan failed. Recover the missing patrol report from the assigned search area in Waystation. Bring it back to me in Waystation.",
		},
		{
			id = "BO04",
			name = "Restocking",
			briefing = "There is an allocation to fill. Check the request before bringing anything; I need to know what I can actually issue. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "BO06",
			name = "The Interrupted Shipment",
			briefing = "The freight case needs bringing back. Don't convert the recovery into a search for an explanation outside your assignment. Recover the interrupted supply case from the assigned search area in Waystation. Bring it back to me in Waystation.",
		},
		{
			id = "BO08",
			name = "Restocking",
			briefing = "There is an allocation to fill. Check the request before bringing anything; I need to know what I can actually issue. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "BO10",
			name = "The Missing Names",
			briefing = "Wake needs the expedition evidence. She should not have to work from a summary chosen for operational convenience. Recover the expedition record for Wake from the assigned search area in Waystation. Deliver it to 'Wake' in Garbage, then come back to me in Waystation.",
		},
		{
			id = "BO12",
			name = "Building the reserve",
			briefing = "There is an allocation to fill. Check the request before bringing anything; I need to know what I can actually issue. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "BO14",
			name = "The Pripyat Outpost",
			briefing = "The outpost's surviving orders are in Pripyat. Recover the record; do not extend the assignment based on a name you find. Recover the Pripyat outpost orders from the assigned search area in Pripyat. Bring it back to me in Waystation.",
		},
		{
			id = "BO16",
			name = "Building the reserve",
			briefing = "There is an allocation to fill. Check the request before bringing anything; I need to know what I can actually issue. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "BO18",
			name = "The Withheld Annex",
			briefing = "Wake needs the expedition annex. Restricting the rest of the file isn't a reason to leave her without evidence relevant to the search. Recover the missing annex for Wake from the assigned search area in Pripyat. Deliver it to 'Wake' in Garbage, then come back to me in Waystation.",
		},
		{
			id = "BO20",
			name = "A full supply order",
			briefing = "There is an allocation to fill. Check the request before bringing anything; I need to know what I can actually issue. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "BO22",
			name = "A full supply order",
			briefing = "There is an allocation to fill. Check the request before bringing anything; I need to know what I can actually issue. Bring everything on the list back here; I need the full delivery.",
		},
	},
})
