PLUGIN:Register("haggler", {
	name = "'Haggler'",
	template = "tradernpc",
	difficultyMultiplier = 2,
	enforceCatalogue = true,
	map = "rp_marsh_cs",
	courierPools = {
		"valuables_decorative_valuables",
		"valuables_personal_effects",
		"valuables_portable_power",
		"valuables_transit_cases",
	},
	job = {
		category = "Regional human elimination",
		description = "Regional human elimination",
		kind = "regionalHumans",
		maps = {
			easy = "rp_marsh_cs",
			hard = "rp_waystation",
			medium = "rp_garbage_cotz",
		},
	},
	legacyJob = {
		category = "Hostile human elimination",
		description = "Hostile human elimination",
		kind = "humans",
		quantities = {5, 9, 15},
		trigger = "banditKilled",
	},
	supplies = {"22lr", "762x25", "9x18", "9x19", "45acp", "45acp41", "helm_tanker"},
	rewards = {
		bonusCash = true,
		bonusPackages = {
			{
				items = {"value_currency_dollar"},
				label = "Dollar notes",
			},
		},
		packages = {
			{
				items = {"9x18", "9x19", "762x25"},
				label = "Pistol ammunition",
			},
			{
				items = {"food_can_chilibeans"},
				label = "Canned provisions",
			},
			{
				items = {"drink_bottlewater"},
				label = "Road drinks",
			},
		},
	},
	dialogue = {
		completedGreeting = "There you are. It's pleasant to see a customer whose promises don't need chasing all over the Marsh.",
		jobBriefing = "There's a little trouble making journeys more expensive than they ought to be. {details}",
		jobFinished = "You've made that journey a little less troublesome. And yes, I remember our price.",
		jobReminder = "I'm still waiting to hear that you've dealt with them. {details}",
		offerPrompt = "Do you have an elimination job?",
		progression = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
		progressionPrompt = "What needs doing about the trading accounts?",
		work = "Hostile elimination orders. The specified targets, before you become inspired by somebody else's valuable-looking pack. I need the work done as agreed. Read the order, decide whether the payment suits you, then prepare. We can have an entirely different conversation about buying things when you return.",
		workPrompt = "About the job I'm doing for you.",
	},
	catalogue = {
		toz106 = {
			step = "v3/pact-cqb/toz106",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		mp27 = {
			step = "v3/pact-cqb/mp27",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		toz66short = {
			step = "v3/pact-cqb/toz66short",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		skorpion = {
			step = "v3/pact-cqb/skorpion",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		toz34short = {
			step = "v3/pact-cqb/toz34short",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		kiparis = {
			step = "v3/pact-cqb/kiparis",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		toz66 = {
			step = "v3/pact-cqb/toz66",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		ppsh = {
			step = "v3/pact-cqb/ppsh",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		toz34 = {
			step = "v3/pact-cqb/toz34",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		pp2000 = {
			step = "v3/pact-cqb/pp2000",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		toz194 = {
			step = "v3/pact-cqb/toz194",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		pp1901vityaz = {
			step = "v3/pact-cqb/pp1901vityaz",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		saiga410 = {
			step = "v3/pact-cqb/saiga410",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		gepardpdw = {
			step = "v3/pact-cqb/gepardpdw",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		pp19 = {
			step = "v3/pact-cqb/pp19",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		mp153 = {
			step = "v3/pact-cqb/mp153",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		sr2 = {
			step = "v3/pact-cqb/sr2",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		toz34special = {
			step = "v3/pact-cqb/toz34special",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		saiga12 = {
			step = "v3/pact-cqb/saiga12",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
	},
	progression = {
		{
			id = "v3/pact-cqb/toz106",
			branch = "pact-cqb",
			name = "TOZ-106",
			kind = "delivery",
			requires = {},
			briefing = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 450,
		},
		{
			id = "v3/pact-cqb/mp27",
			branch = "pact-cqb",
			name = "MP-27",
			kind = "delivery",
			requires = {"v3/pact-cqb/toz106"},
			briefing = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 550,
		},
		{
			id = "v3/pact-cqb/toz66short",
			branch = "pact-cqb",
			name = "TOZ BM-16 Sawnoff",
			kind = "delivery",
			requires = {"v3/pact-cqb/mp27"},
			briefing = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 700,
		},
		{
			id = "v3/pact-cqb/skorpion",
			branch = "pact-cqb",
			name = "skorpion",
			kind = "delivery",
			requires = {"v3/pact-cqb/toz66short"},
			briefing = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 850,
		},
		{
			id = "v3/pact-cqb/toz34short",
			branch = "pact-cqb",
			name = "TOZ-34 Sawnoff",
			kind = "delivery",
			requires = {"v3/pact-cqb/skorpion"},
			briefing = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 1000,
		},
		{
			id = "v3/pact-cqb/kiparis",
			branch = "pact-cqb",
			name = "kiparis",
			kind = "delivery",
			requires = {"v3/pact-cqb/toz34short"},
			briefing = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 1,
				},
			},
			completionCash = 1150,
		},
		{
			id = "v3/pact-cqb/toz66",
			branch = "pact-cqb",
			name = "TOZ-66",
			kind = "delivery",
			requires = {"v3/pact-cqb/kiparis"},
			briefing = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trade_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1300,
		},
		{
			id = "v3/pact-cqb/ppsh",
			branch = "pact-cqb",
			name = "PPSh-41",
			kind = "delivery",
			requires = {"v3/pact-cqb/toz66"},
			briefing = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trade_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1400,
		},
		{
			id = "v3/pact-cqb/toz34",
			branch = "pact-cqb",
			name = "TOZ-34 Hunting Shotgun",
			kind = "delivery",
			requires = {"v3/pact-cqb/ppsh"},
			briefing = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trade_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1550,
		},
		{
			id = "v3/pact-cqb/pp2000",
			branch = "pact-cqb",
			name = "PP-2000",
			kind = "delivery",
			requires = {"v3/pact-cqb/toz34"},
			briefing = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trade_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1700,
		},
		{
			id = "v3/pact-cqb/toz194",
			branch = "pact-cqb",
			name = "TOZ-194",
			kind = "delivery",
			requires = {"v3/pact-cqb/pp2000"},
			briefing = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trade_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 1850,
		},
		{
			id = "v3/pact-cqb/pp1901vityaz",
			branch = "pact-cqb",
			name = "PP-19-01 'Vityaz'",
			kind = "delivery",
			requires = {"v3/pact-cqb/toz194"},
			briefing = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_trade_marsh_2",
					quantity = 1,
				},
			},
			completionCash = 2000,
		},
		{
			id = "v3/pact-cqb/saiga410",
			branch = "pact-cqb",
			name = "Saiga-410",
			kind = "delivery",
			requires = {"v3/pact-cqb/pp1901vityaz"},
			briefing = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trade_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trade_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2150,
		},
		{
			id = "v3/pact-cqb/gepardpdw",
			branch = "pact-cqb",
			name = "Gepard PDW",
			kind = "delivery",
			requires = {"v3/pact-cqb/saiga410"},
			briefing = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trade_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trade_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2250,
		},
		{
			id = "v3/pact-cqb/pp19",
			branch = "pact-cqb",
			name = "PP19 'Bizon'",
			kind = "delivery",
			requires = {"v3/pact-cqb/gepardpdw"},
			briefing = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trade_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trade_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2400,
		},
		{
			id = "v3/pact-cqb/mp153",
			branch = "pact-cqb",
			name = "Baikal MP-153",
			kind = "delivery",
			requires = {"v3/pact-cqb/pp19"},
			briefing = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trade_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trade_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2550,
		},
		{
			id = "v3/pact-cqb/sr2",
			branch = "pact-cqb",
			name = "SR-2 Veresk",
			kind = "delivery",
			requires = {"v3/pact-cqb/mp153"},
			briefing = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trade_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trade_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2700,
		},
		{
			id = "v3/pact-cqb/toz34special",
			branch = "pact-cqb",
			name = "TOZ-34 Special",
			kind = "delivery",
			requires = {"v3/pact-cqb/sr2"},
			briefing = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_trade_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_trade_marsh_3",
					quantity = 1,
				},
			},
			completionCash = 2850,
		},
		{
			id = "v3/pact-cqb/saiga12",
			branch = "pact-cqb",
			name = "Saiga-12",
			kind = "delivery",
			requires = {"v3/pact-cqb/toz34special"},
			briefing = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
			completion = "There we are. A straightforward agreement, carried through.",
			requirements = {
				{
					pool = "town_delivery_trade_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_trade_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_trade_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_trade_marsh_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
		},
	},
	startingServices = {},
	retiredCommissions = {
		{
			id = "HG02",
			name = "The Missing Invoice",
			briefing = "An invoice has gone missing. Everyone remembers the amount most favourable to them, so I'd like the paper. Recover the missing trading invoice from the assigned search area in Marsh. Bring it back to me in Marsh.",
		},
		{
			id = "HG04",
			name = "A small delivery",
			briefing = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "HG06",
			name = "The Wrong Seal",
			briefing = "I'd like the consignment seal record. A seal described from memory is worth precisely what the description costs. Recover the consignment seal record from the assigned search area in Marsh. Bring it back to me in Marsh.",
		},
		{
			id = "HG08",
			name = "Restocking",
			briefing = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "HG10",
			name = "Two Sets of Books",
			briefing = "Ledger gets the second book. If somebody has two accounts, I want them compared by a man who enjoys finding the difference. Recover the second freight ledger from the assigned search area in Marsh. Deliver it to 'Ledger' in Waystation, then come back to me in Marsh.",
		},
		{
			id = "HG12",
			name = "Restocking",
			briefing = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "HG14",
			name = "A Broken Agreement",
			briefing = "Bring the supplier contract intact. People lose things without help; I'd like evidence before I spend money blaming anyone. Recover the supplier's broken agreement from the assigned search area in Garbage. Bring it back to me in Marsh.",
		},
		{
			id = "HG16",
			name = "Building the reserve",
			briefing = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "HG18",
			name = "The Shipment List",
			briefing = "Brass needs the shipment manifest. I want the quantities checked by someone who won't be charmed out of counting. Recover the distributor's shipment manifest from the assigned search area in Marsh. Deliver it to 'Brass' in Garbage, then come back to me in Marsh.",
		},
		{
			id = "HG20",
			name = "Building the reserve",
			briefing = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "HG22",
			name = "The Unpaid Supplier",
			briefing = "The supplier's surviving evidence is still out on the route. I'd like an account from someone besides the people demanding payment. Recover the unpaid supplier's file from the assigned search area in Marsh. Bring it back to me in Marsh.",
		},
		{
			id = "HG24",
			name = "A full supply order",
			briefing = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "HG26",
			name = "A full supply order",
			briefing = "I have a supply request worth your time. Bring what is on the list and we can both finish this bit of business satisfied. Bring everything on the list back here; I need the full delivery.",
		},
	},
})
