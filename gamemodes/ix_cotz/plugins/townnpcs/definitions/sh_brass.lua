PLUGIN:Register("brass", {
	name = "'Brass'",
	template = "brassnpc",
	difficultyMultiplier = 2,
	enforceCatalogue = true,
	map = "rp_garbage_cotz",
	courierPools = {
		"valuables_ordnance_salvage",
		"valuables_military_cases",
		"valuables_equipment_pouches",
		"valuables_technical_records",
	},
	job = {
		category = "No ordinary repeatable work",
		description = "No ordinary repeatable work",
		kind = "none",
	},
	legacyJob = {
		category = "Ammunition deliveries",
		deliveryTiers = {
			easy = {
				pools = {"valuables_equipment_pouches"},
				quantity = 1,
			},
			hard = {
				pools = {"valuables_ordnance_salvage"},
				quantity = 2,
			},
			medium = {
				pools = {"valuables_military_cases"},
				quantity = 1,
			},
		},
		description = "Ammunition deliveries",
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		pools = {"town_ammunition"},
		quantities = {2, 4, 7},
	},
	retiredRegionalJob = {
		category = "Information courier and return",
		description = "Information courier and return",
		kind = "courier",
	},
	supplies = {"22lr", "762x25", "9x18", "9x19", "45acp", "45acp41", "12gauge", "12gaugesg"},
	rewards = {
		bonusCash = true,
		bonusPackages = {
			{
				items = {"762x54ap"},
				label = "Specialist ammunition",
			},
		},
		packages = {
			{
				items = {"762x39", "762x51"},
				label = "Rifle ammunition",
			},
			{
				items = {"9x19", "45acp"},
				label = "Pistol ammunition",
			},
			{
				items = {"value_currency_dollar"},
				label = "Dollar notes",
			},
		},
	},
	dialogue = {
		completedGreeting = "Good to see you. An order to discuss, or have you brought something for us to count?",
		delivery = "Set it down. I will check the consignment against the entry.",
		jobBriefing = "We still have that earlier arrangement. {details}",
		jobFinished = "That accounts for the consignment. Let's settle what you're owed.",
		jobReminder = "That consignment hasn't been accounted for yet. {details}",
		offerPrompt = "Do you have a courier assignment?",
		progression = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
		progressionPrompt = "Which part of the depot account needs attention?",
		work = "I haven't got any new runs for you. I'm occupied at the loading bench. If we already have a consignment between us, we can still settle it here.",
		workPrompt = "About our earlier consignment.",
	},
	catalogue = {
		["545x39"] = {
			step = "v3/regular-ammo/545x39",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		["762x39"] = {
			step = "v3/regular-ammo/762x39",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		["556x45"] = {
			step = "v3/regular-ammo/556x45",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		["762x54"] = {
			step = "v3/regular-ammo/762x54",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		["357magnum"] = {
			step = "v3/regular-ammo/357magnum",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		["9x39"] = {
			step = "v3/regular-ammo/9x39",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		["44magnum"] = {
			step = "v3/regular-ammo/44magnum",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		["9x21"] = {
			step = "v3/regular-ammo/9x21",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		["762x51"] = {
			step = "v3/regular-ammo/762x51",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		["500magnum"] = {
			step = "v3/regular-ammo/500magnum",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		["338lapua"] = {
			step = "v3/regular-ammo/338lapua",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		["50ae"] = {
			step = "v3/regular-ammo/50ae",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		["57x28"] = {
			step = "v3/regular-ammo/57x28",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		["127x55"] = {
			step = "v3/regular-ammo/127x55",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		["145x114"] = {
			step = "v3/regular-ammo/145x114",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		["700nitro"] = {
			step = "v3/regular-ammo/700nitro",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		["93x64"] = {
			step = "v3/regular-ammo/93x64",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		["12gaugetr"] = {
			step = "v3/shotgun-loads/12gaugetr",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		["12gaugedt"] = {
			step = "v3/shotgun-loads/12gaugedt",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		["12gaugemg"] = {
			step = "v3/shotgun-loads/12gaugemg",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
	},
	progression = {
		{
			id = "v3/regular-ammo/22lr",
			branch = "regular-ammo",
			name = ".22LR",
			kind = "delivery",
			requires = {},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 1,
				},
			},
			completionCash = 450,
			stock = {
				item = "22lr",
				bonus = 1,
			},
		},
		{
			id = "v3/regular-ammo/762x25",
			branch = "regular-ammo",
			name = "7.62x25mm",
			kind = "delivery",
			requires = {"v3/regular-ammo/22lr"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 1,
				},
			},
			completionCash = 550,
			stock = {
				item = "762x25",
				bonus = 1,
			},
		},
		{
			id = "v3/regular-ammo/45acp41",
			branch = "regular-ammo",
			name = ".410 Magnum Buck",
			kind = "delivery",
			requires = {"v3/regular-ammo/762x25"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 1,
				},
			},
			completionCash = 650,
			stock = {
				item = "45acp41",
				bonus = 1,
			},
		},
		{
			id = "v3/regular-ammo/9x19",
			branch = "regular-ammo",
			name = "9x19mm",
			kind = "delivery",
			requires = {"v3/regular-ammo/45acp41"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 1,
				},
			},
			completionCash = 750,
			stock = {
				item = "9x19",
				bonus = 1,
			},
		},
		{
			id = "v3/regular-ammo/45acp",
			branch = "regular-ammo",
			name = ".45 ACP",
			kind = "delivery",
			requires = {"v3/regular-ammo/9x19"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 1,
				},
			},
			completionCash = 850,
			stock = {
				item = "45acp",
				bonus = 1,
			},
		},
		{
			id = "v3/regular-ammo/545x39",
			branch = "regular-ammo",
			name = "5.45x39mm",
			kind = "delivery",
			requires = {"v3/regular-ammo/45acp"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 1,
				},
			},
			completionCash = 1000,
		},
		{
			id = "v3/regular-ammo/12gauge",
			branch = "regular-ammo",
			name = "12g Buckshot",
			kind = "delivery",
			requires = {"v3/regular-ammo/545x39"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 1,
				},
			},
			completionCash = 1100,
			stock = {
				item = "12gauge",
				bonus = 1,
			},
		},
		{
			id = "v3/regular-ammo/762x39",
			branch = "regular-ammo",
			name = "7.62x39mm",
			kind = "delivery",
			requires = {"v3/regular-ammo/12gauge"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 1,
				},
			},
			completionCash = 1200,
		},
		{
			id = "v3/regular-ammo/556x45",
			branch = "regular-ammo",
			name = "5.56x45mm",
			kind = "delivery",
			requires = {"v3/regular-ammo/762x39"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 1,
				},
			},
			completionCash = 1300,
		},
		{
			id = "v3/regular-ammo/9x18",
			branch = "regular-ammo",
			name = "9x18mm",
			kind = "delivery",
			requires = {"v3/regular-ammo/556x45"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 1,
				},
			},
			completionCash = 1400,
			stock = {
				item = "9x18",
				bonus = 1,
			},
		},
		{
			id = "v3/regular-ammo/762x54",
			branch = "regular-ammo",
			name = "7.62x54mm",
			kind = "delivery",
			requires = {"v3/regular-ammo/9x18"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 1,
				},
			},
			completionCash = 1550,
		},
		{
			id = "v3/regular-ammo/357magnum",
			branch = "regular-ammo",
			name = ".357 Magnum",
			kind = "delivery",
			requires = {"v3/regular-ammo/762x54"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 1,
				},
			},
			completionCash = 1650,
		},
		{
			id = "v3/regular-ammo/9x39",
			branch = "regular-ammo",
			name = "9x39mm",
			kind = "delivery",
			requires = {"v3/regular-ammo/357magnum"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 1,
				},
			},
			completionCash = 1750,
		},
		{
			id = "v3/regular-ammo/44magnum",
			branch = "regular-ammo",
			name = ".44 Magnum",
			kind = "delivery",
			requires = {"v3/regular-ammo/9x39"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 1,
				},
			},
			completionCash = 1850,
		},
		{
			id = "v3/regular-ammo/9x21",
			branch = "regular-ammo",
			name = "9x21mm Gyurza SP-11 (7N28)",
			kind = "delivery",
			requires = {"v3/regular-ammo/44magnum"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 1,
				},
			},
			completionCash = 2000,
		},
		{
			id = "v3/regular-ammo/762x51",
			branch = "regular-ammo",
			name = "7.62x51mm",
			kind = "delivery",
			requires = {"v3/regular-ammo/9x21"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 1,
				},
			},
			completionCash = 2100,
		},
		{
			id = "v3/regular-ammo/500magnum",
			branch = "regular-ammo",
			name = ".500 Magnum",
			kind = "delivery",
			requires = {"v3/regular-ammo/762x51"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_3",
					quantity = 1,
				},
			},
			completionCash = 2200,
		},
		{
			id = "v3/regular-ammo/338lapua",
			branch = "regular-ammo",
			name = ".338 Lapua",
			kind = "delivery",
			requires = {"v3/regular-ammo/500magnum"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_3",
					quantity = 1,
				},
			},
			completionCash = 2300,
		},
		{
			id = "v3/regular-ammo/50ae",
			branch = "regular-ammo",
			name = ".50AE",
			kind = "delivery",
			requires = {"v3/regular-ammo/338lapua"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_3",
					quantity = 1,
				},
			},
			completionCash = 2400,
		},
		{
			id = "v3/regular-ammo/57x28",
			branch = "regular-ammo",
			name = "5.7x28mm",
			kind = "delivery",
			requires = {"v3/regular-ammo/50ae"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_3",
					quantity = 1,
				},
			},
			completionCash = 2550,
		},
		{
			id = "v3/regular-ammo/127x55",
			branch = "regular-ammo",
			name = "12.7x55mm",
			kind = "delivery",
			requires = {"v3/regular-ammo/57x28"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_3",
					quantity = 1,
				},
			},
			completionCash = 2650,
		},
		{
			id = "v3/regular-ammo/145x114",
			branch = "regular-ammo",
			name = "14.5x114mm",
			kind = "delivery",
			requires = {"v3/regular-ammo/127x55"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_3",
					quantity = 1,
				},
			},
			completionCash = 2750,
		},
		{
			id = "v3/regular-ammo/700nitro",
			branch = "regular-ammo",
			name = ".700 Nitro Express",
			kind = "delivery",
			requires = {"v3/regular-ammo/145x114"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_3",
					quantity = 1,
				},
			},
			completionCash = 2850,
		},
		{
			id = "v3/regular-ammo/93x64",
			branch = "regular-ammo",
			name = "9.3x64mm 7N33",
			kind = "delivery",
			requires = {"v3/regular-ammo/700nitro"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_garbage_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
		},
		{
			id = "v3/hp-ammo/22lrhp",
			branch = "hp-ammo",
			name = ".22LR Subsonic 40 gr Overpressure",
			kind = "delivery",
			requires = {},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 1,
				},
			},
			completionCash = 450,
			ammoExchange = {
				input = "22lr",
				output = "22lrhp",
				boxes = 2,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/regular-ammo/22lr",
				},
			},
		},
		{
			id = "v3/hp-ammo/762x25hp",
			branch = "hp-ammo",
			name = "7.62x25mm Overpressure",
			kind = "delivery",
			requires = {"v3/hp-ammo/22lrhp"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 1,
				},
			},
			completionCash = 550,
			ammoExchange = {
				input = "762x25",
				output = "762x25hp",
				boxes = 2,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/regular-ammo/762x25",
				},
			},
		},
		{
			id = "v3/hp-ammo/9x19hp",
			branch = "hp-ammo",
			name = "9x19mm Overpressure",
			kind = "delivery",
			requires = {"v3/hp-ammo/762x25hp"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 1,
				},
			},
			completionCash = 700,
			ammoExchange = {
				input = "9x19",
				output = "9x19hp",
				boxes = 2,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/regular-ammo/9x19",
				},
			},
		},
		{
			id = "v3/hp-ammo/45acphp",
			branch = "hp-ammo",
			name = ".45 ACP Hydro-Shok",
			kind = "delivery",
			requires = {"v3/hp-ammo/9x19hp"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 1,
				},
			},
			completionCash = 850,
			ammoExchange = {
				input = "45acp",
				output = "45acphp",
				boxes = 2,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/regular-ammo/45acp",
				},
			},
		},
		{
			id = "v3/hp-ammo/545x39hp",
			branch = "hp-ammo",
			name = "5.45x39mm Overpressure",
			kind = "delivery",
			requires = {"v3/hp-ammo/45acphp"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 1,
				},
			},
			completionCash = 1000,
			ammoExchange = {
				input = "545x39",
				output = "545x39hp",
				boxes = 2,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/regular-ammo/545x39",
				},
			},
		},
		{
			id = "v3/hp-ammo/762x39hp",
			branch = "hp-ammo",
			name = "7.62x39mm Overpressure",
			kind = "delivery",
			requires = {"v3/hp-ammo/545x39hp"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 1,
				},
			},
			completionCash = 1150,
			ammoExchange = {
				input = "762x39",
				output = "762x39hp",
				boxes = 2,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/regular-ammo/762x39",
				},
			},
		},
		{
			id = "v3/hp-ammo/556x45hp",
			branch = "hp-ammo",
			name = "5.56x45mm Overpressure",
			kind = "delivery",
			requires = {"v3/hp-ammo/762x39hp"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 1,
				},
			},
			completionCash = 1300,
			ammoExchange = {
				input = "556x45",
				output = "556x45hp",
				boxes = 2,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/regular-ammo/556x45",
				},
			},
		},
		{
			id = "v3/hp-ammo/9x18hp",
			branch = "hp-ammo",
			name = "9x18mm +P",
			kind = "delivery",
			requires = {"v3/hp-ammo/556x45hp"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 1,
				},
			},
			completionCash = 1400,
			ammoExchange = {
				input = "9x18",
				output = "9x18hp",
				boxes = 2,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/regular-ammo/9x18",
				},
			},
		},
		{
			id = "v3/hp-ammo/762x54hp",
			branch = "hp-ammo",
			name = "7.62x54mm HPBT",
			kind = "delivery",
			requires = {"v3/hp-ammo/9x18hp"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 1,
				},
			},
			completionCash = 1550,
			ammoExchange = {
				input = "762x54",
				output = "762x54hp",
				boxes = 2,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/regular-ammo/762x54",
				},
			},
		},
		{
			id = "v3/hp-ammo/357magnumhp",
			branch = "hp-ammo",
			name = ".357 Magnum JHP",
			kind = "delivery",
			requires = {"v3/hp-ammo/762x54hp"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 1,
				},
			},
			completionCash = 1700,
			ammoExchange = {
				input = "357magnum",
				output = "357magnumhp",
				boxes = 2,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/regular-ammo/357magnum",
				},
			},
		},
		{
			id = "v3/hp-ammo/9x39hp",
			branch = "hp-ammo",
			name = "9x39mm PAB-9",
			kind = "delivery",
			requires = {"v3/hp-ammo/357magnumhp"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 1,
				},
			},
			completionCash = 1850,
			ammoExchange = {
				input = "9x39",
				output = "9x39hp",
				boxes = 2,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/regular-ammo/9x39",
				},
			},
		},
		{
			id = "v3/hp-ammo/44magnumhp",
			branch = "hp-ammo",
			name = ".44 Magnum Black Talon HP",
			kind = "delivery",
			requires = {"v3/hp-ammo/9x39hp"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 1,
				},
			},
			completionCash = 2000,
			ammoExchange = {
				input = "44magnum",
				output = "44magnumhp",
				boxes = 2,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/regular-ammo/44magnum",
				},
			},
		},
		{
			id = "v3/hp-ammo/9x21hp",
			branch = "hp-ammo",
			name = "9x21mm 'Gyurza' SP-12",
			kind = "delivery",
			requires = {"v3/hp-ammo/44magnumhp"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_3",
					quantity = 1,
				},
			},
			completionCash = 2150,
			ammoExchange = {
				input = "9x21",
				output = "9x21hp",
				boxes = 2,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/regular-ammo/9x21",
				},
			},
		},
		{
			id = "v3/hp-ammo/762x51hp",
			branch = "hp-ammo",
			name = "7.62x51mm M118 BTHP",
			kind = "delivery",
			requires = {"v3/hp-ammo/9x21hp"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_3",
					quantity = 1,
				},
			},
			completionCash = 2250,
			ammoExchange = {
				input = "762x51",
				output = "762x51hp",
				boxes = 2,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/regular-ammo/762x51",
				},
			},
		},
		{
			id = "v3/hp-ammo/500magnumhp",
			branch = "hp-ammo",
			name = ".500 Magnum DPX",
			kind = "delivery",
			requires = {"v3/hp-ammo/762x51hp"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_3",
					quantity = 1,
				},
			},
			completionCash = 2400,
			ammoExchange = {
				input = "500magnum",
				output = "500magnumhp",
				boxes = 2,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/regular-ammo/500magnum",
				},
			},
		},
		{
			id = "v3/hp-ammo/338lapuahp",
			branch = "hp-ammo",
			name = ".338 Lapua TAC-X",
			kind = "delivery",
			requires = {"v3/hp-ammo/500magnumhp"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_3",
					quantity = 1,
				},
			},
			completionCash = 2550,
			ammoExchange = {
				input = "338lapua",
				output = "338lapuahp",
				boxes = 2,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/regular-ammo/338lapua",
				},
			},
		},
		{
			id = "v3/hp-ammo/50aehp",
			branch = "hp-ammo",
			name = ".50AE 300gr XTP HP",
			kind = "delivery",
			requires = {"v3/hp-ammo/338lapuahp"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_3",
					quantity = 1,
				},
			},
			completionCash = 2700,
			ammoExchange = {
				input = "50ae",
				output = "50aehp",
				boxes = 2,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/regular-ammo/50ae",
				},
			},
		},
		{
			id = "v3/hp-ammo/57x28hp",
			branch = "hp-ammo",
			name = "5.7x28mm FN R37.F",
			kind = "delivery",
			requires = {"v3/hp-ammo/50aehp"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_3",
					quantity = 1,
				},
			},
			completionCash = 2850,
			ammoExchange = {
				input = "57x28",
				output = "57x28hp",
				boxes = 2,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/regular-ammo/57x28",
				},
			},
		},
		{
			id = "v3/hp-ammo/145x114hp",
			branch = "hp-ammo",
			name = "14.5x114mm BZT",
			kind = "delivery",
			requires = {"v3/hp-ammo/57x28hp"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_garbage_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
			ammoExchange = {
				input = "145x114",
				output = "145x114hp",
				boxes = 2,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/regular-ammo/145x114",
				},
			},
		},
		{
			id = "v3/shotgun-loads/12gaugetr",
			branch = "shotgun-loads",
			name = "12g Tri-Ball",
			kind = "delivery",
			requires = {},
			crossRequires = {{contact = "brass", step = "v3/regular-ammo/12gauge"}},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 1,
				},
			},
			completionCash = 450,
		},
		{
			id = "v3/shotgun-loads/12gaugedt",
			branch = "shotgun-loads",
			name = "12g Dart Rounds",
			kind = "delivery",
			requires = {"v3/shotgun-loads/12gaugetr"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 1,
				},
			},
			completionCash = 1700,
		},
		{
			id = "v3/shotgun-loads/12gaugemg",
			branch = "shotgun-loads",
			name = "12g Magnum Buckshot",
			kind = "delivery",
			requires = {"v3/shotgun-loads/12gaugedt"},
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
			completion = "That matches the request. I will enter it on my side as well.",
			requirements = {
				{
					pool = "town_delivery_military_garbage_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_military_garbage_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_military_garbage_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_military_garbage_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
		},
	},
	startingServices = {},
	retiredCommissions = {
		{
			id = "BR02",
			name = "The Broken Seal",
			briefing = "I need the packing record behind the broken seal. A damaged fastening doesn't tell us what was counted before it closed. Recover the depot seal register from the assigned search area in Garbage. Bring it back to me in Garbage.",
		},
		{
			id = "BR04",
			name = "Restocking",
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "BR06",
			name = "The Depot Register",
			briefing = "I need the depot inventory. People have been quoting totals without bringing the page they read them from. Recover the depot inventory from the assigned search area in Garbage. Bring it back to me in Garbage.",
		},
		{
			id = "BR08",
			name = "Restocking",
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "BR10",
			name = "The Supplier's Stamp",
			briefing = "Latch needs the supplier paperwork. He can check the part details more usefully than I can repeat them. Recover the supplier papers for Latch from the assigned search area in Garbage. Deliver it to 'Latch' in Garbage, then come back to me in Garbage.",
		},
		{
			id = "BR12",
			name = "Building the reserve",
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "BR14",
			name = "The Military Manifest",
			briefing = "Quartermaster needs the military supply record. A usable account matters more than a reassuring summary. Recover the military depot manifest from the assigned search area in Waystation. Deliver it to 'Quartermaster' in Waystation, then come back to me in Garbage.",
		},
		{
			id = "BR16",
			name = "Building the reserve",
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "BR18",
			name = "The Pripyat Consignment",
			briefing = "The sealed consignment is still out in Pripyat. Bring the case as it is; the inspection can wait until it's here. Recover the Pripyat consignment case from the assigned search area in Pripyat. Bring it back to me in Garbage.",
		},
		{
			id = "BR20",
			name = "Building the reserve",
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "BR22",
			name = "The Final Receipt",
			briefing = "I want the last freight entry. I'd rather keep an account open a little longer than close it against an assumed receipt. Recover the final freight receipt from the assigned search area in Garbage. Bring it back to me in Garbage.",
		},
		{
			id = "BR24",
			name = "A full supply order",
			briefing = "I have a depot request to fill. Read the list; anything outside it will only complicate the count. Bring everything on the list back here; I need the full delivery.",
		},
	},
})
