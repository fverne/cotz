PLUGIN:Register("carbon", {
	name = "'Carbon'",
	template = "carbonnpc",
	difficultyMultiplier = 4,
	enforceCatalogue = true,
	map = "rp_waystation",
	courierPools = {
		"valuables_office_records",
		"valuables_technical_records",
		"valuables_field_records",
		"valuables_printed_material",
	},
	job = {
		category = "No ordinary repeatable work",
		description = "No ordinary repeatable work",
		kind = "none",
	},
	legacyJob = {
		category = "Document deliveries",
		deliveryTiers = {
			easy = {
				pools = {"valuables_office_records", "valuables_field_records", "valuables_printed_material"},
				quantity = 1,
			},
			hard = {
				pools = {"valuables_data_archives"},
				quantity = 2,
			},
			medium = {
				pools = {"valuables_technical_records"},
				quantity = 1,
			},
		},
		description = "Document deliveries",
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		pools = {"administrative_documents", "documents_field", "documents_technical"},
		quantities = {2, 4, 7},
	},
	supplies = {},
	rewards = {
		packages = {
			{
				items = {"food_can_beans", "food_can_tuna"},
				label = "Canned provisions",
			},
			{
				items = {"drink_bottletea", "food_bread"},
				label = "Reading provisions",
			},
			{
				items = {"medic_bandage_1", "drink_bottlewater"},
				label = "Field research",
			},
		},
	},
	dialogue = {
		completedGreeting = "Hello again. I've got time if you want to talk. You've been patient enough with my questions.",
		delivery = "On the clear part of the desk. Keep any loose pages with it.",
		jobBriefing = "There's an arrangement we haven't finished. {details}",
		jobFinished = "That will do. Your payment is ready.",
		jobReminder = "The arrangement hasn't changed. {details}",
		offerPrompt = "Are there documents you need?",
		progression = "I would like some ordinary source material for the collection. Even a working record can tell us what somebody thought was worth writing down. Bring everything on the list back here; I need the full delivery.",
		progressionPrompt = "Which part of the archive are you examining?",
		work = "Surviving documents, kept intact and brought here. Check the request before choosing what looks important. An ordinary record may help place a much more exciting account. Please keep loose pages with the bundle they came from. I'd rather discover an uninteresting page myself than wonder whether it was left behind.",
		workPrompt = "About the records I'm collecting.",
	},
	catalogue = {},
	progression = {
		{
			id = "v3/ap-ammo/22lrap",
			branch = "ap-ammo",
			name = ".22LR FMJ",
			kind = "delivery",
			requires = {},
			briefing = "I would like some ordinary source material for the collection. Even a working record can tell us what somebody thought was worth writing down. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. I will look through these before deciding where they belong.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 450,
			ammoExchange = {
				input = "22lr",
				output = "22lrap",
				boxes = 3,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/hp-ammo/22lrhp",
				},
			},
		},
		{
			id = "v3/ap-ammo/762x25ap",
			branch = "ap-ammo",
			name = "7.62x25mm Armor-Piercing",
			kind = "delivery",
			requires = {"v3/ap-ammo/22lrap"},
			briefing = "I would like some ordinary source material for the collection. Even a working record can tell us what somebody thought was worth writing down. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. I will look through these before deciding where they belong.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 550,
			ammoExchange = {
				input = "762x25",
				output = "762x25ap",
				boxes = 3,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/hp-ammo/762x25hp",
				},
			},
		},
		{
			id = "v3/ap-ammo/9x19ap",
			branch = "ap-ammo",
			name = "9x19mm 7N21",
			kind = "delivery",
			requires = {"v3/ap-ammo/762x25ap"},
			briefing = "I would like some ordinary source material for the collection. Even a working record can tell us what somebody thought was worth writing down. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. I will look through these before deciding where they belong.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 700,
			ammoExchange = {
				input = "9x19",
				output = "9x19ap",
				boxes = 3,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/hp-ammo/9x19hp",
				},
			},
		},
		{
			id = "v3/ap-ammo/45acpap",
			branch = "ap-ammo",
			name = ".45 ACP Armor-Piercing",
			kind = "delivery",
			requires = {"v3/ap-ammo/9x19ap"},
			briefing = "I would like some ordinary source material for the collection. Even a working record can tell us what somebody thought was worth writing down. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. I will look through these before deciding where they belong.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 850,
			ammoExchange = {
				input = "45acp",
				output = "45acpap",
				boxes = 3,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/hp-ammo/45acphp",
				},
			},
		},
		{
			id = "v3/ap-ammo/545x39ap",
			branch = "ap-ammo",
			name = "5.45x39mm 7N22 AP",
			kind = "delivery",
			requires = {"v3/ap-ammo/45acpap"},
			briefing = "I would like some ordinary source material for the collection. Even a working record can tell us what somebody thought was worth writing down. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. I will look through these before deciding where they belong.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 1000,
			ammoExchange = {
				input = "545x39",
				output = "545x39ap",
				boxes = 3,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/hp-ammo/545x39hp",
				},
			},
		},
		{
			id = "v3/ap-ammo/762x39ap",
			branch = "ap-ammo",
			name = "7.62x39mm MAI AP",
			kind = "delivery",
			requires = {"v3/ap-ammo/545x39ap"},
			briefing = "I would like some ordinary source material for the collection. Even a working record can tell us what somebody thought was worth writing down. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. I will look through these before deciding where they belong.",
			requirements = {
				{
					pool = "town_delivery_records_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 1150,
			ammoExchange = {
				input = "762x39",
				output = "762x39ap",
				boxes = 3,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/hp-ammo/762x39hp",
				},
			},
		},
		{
			id = "v3/ap-ammo/556x45ap",
			branch = "ap-ammo",
			name = "5.56x45mm SS190",
			kind = "delivery",
			requires = {"v3/ap-ammo/762x39ap"},
			briefing = "I would like some ordinary source material for the collection. Even a working record can tell us what somebody thought was worth writing down. Bring everything on the list back here; I need the full delivery.",
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
			completionCash = 1300,
			ammoExchange = {
				input = "556x45",
				output = "556x45ap",
				boxes = 3,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/hp-ammo/556x45hp",
				},
			},
		},
		{
			id = "v3/ap-ammo/9x18ap",
			branch = "ap-ammo",
			name = "9x18mm JSP-AP",
			kind = "delivery",
			requires = {"v3/ap-ammo/556x45ap"},
			briefing = "I would like some ordinary source material for the collection. Even a working record can tell us what somebody thought was worth writing down. Bring everything on the list back here; I need the full delivery.",
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
			completionCash = 1400,
			ammoExchange = {
				input = "9x18",
				output = "9x18ap",
				boxes = 3,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/hp-ammo/9x18hp",
				},
			},
		},
		{
			id = "v3/ap-ammo/762x54ap",
			branch = "ap-ammo",
			name = "7.62x54mm 7N14",
			kind = "delivery",
			requires = {"v3/ap-ammo/9x18ap"},
			briefing = "I would like some ordinary source material for the collection. Even a working record can tell us what somebody thought was worth writing down. Bring everything on the list back here; I need the full delivery.",
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
			completionCash = 1550,
			ammoExchange = {
				input = "762x54",
				output = "762x54ap",
				boxes = 3,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/hp-ammo/762x54hp",
				},
			},
		},
		{
			id = "v3/ap-ammo/357magnumap",
			branch = "ap-ammo",
			name = ".357 Magnum Armor-Piercing",
			kind = "delivery",
			requires = {"v3/ap-ammo/762x54ap"},
			briefing = "I would like some ordinary source material for the collection. Even a working record can tell us what somebody thought was worth writing down. Bring everything on the list back here; I need the full delivery.",
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
			completionCash = 1700,
			ammoExchange = {
				input = "357magnum",
				output = "357magnumap",
				boxes = 3,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/hp-ammo/357magnumhp",
				},
			},
		},
		{
			id = "v3/ap-ammo/9x39ap",
			branch = "ap-ammo",
			name = "9x39mm SP-6",
			kind = "delivery",
			requires = {"v3/ap-ammo/357magnumap"},
			briefing = "I would like some ordinary source material for the collection. Even a working record can tell us what somebody thought was worth writing down. Bring everything on the list back here; I need the full delivery.",
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
			completionCash = 1850,
			ammoExchange = {
				input = "9x39",
				output = "9x39ap",
				boxes = 3,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/hp-ammo/9x39hp",
				},
			},
		},
		{
			id = "v3/ap-ammo/44magnumap",
			branch = "ap-ammo",
			name = ".44 Magnum Armor-Piercing",
			kind = "delivery",
			requires = {"v3/ap-ammo/9x39ap"},
			briefing = "I would like some ordinary source material for the collection. Even a working record can tell us what somebody thought was worth writing down. Bring everything on the list back here; I need the full delivery.",
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
			completionCash = 2000,
			ammoExchange = {
				input = "44magnum",
				output = "44magnumap",
				boxes = 3,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/hp-ammo/44magnumhp",
				},
			},
		},
		{
			id = "v3/ap-ammo/9x21ap",
			branch = "ap-ammo",
			name = "9x21mm Gyurza SP-10 (7N29)",
			kind = "delivery",
			requires = {"v3/ap-ammo/44magnumap"},
			briefing = "I would like some ordinary source material for the collection. Even a working record can tell us what somebody thought was worth writing down. Bring everything on the list back here; I need the full delivery.",
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
			completionCash = 2150,
			ammoExchange = {
				input = "9x21",
				output = "9x21ap",
				boxes = 3,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/hp-ammo/9x21hp",
				},
			},
		},
		{
			id = "v3/ap-ammo/762x51ap",
			branch = "ap-ammo",
			name = "7.62x51mm M993 AP",
			kind = "delivery",
			requires = {"v3/ap-ammo/9x21ap"},
			briefing = "I would like some ordinary source material for the collection. Even a working record can tell us what somebody thought was worth writing down. Bring everything on the list back here; I need the full delivery.",
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
			completionCash = 2250,
			ammoExchange = {
				input = "762x51",
				output = "762x51ap",
				boxes = 3,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/hp-ammo/762x51hp",
				},
			},
		},
		{
			id = "v3/ap-ammo/500magnumap",
			branch = "ap-ammo",
			name = ".500 Magnum Armor Piercing",
			kind = "delivery",
			requires = {"v3/ap-ammo/762x51ap"},
			briefing = "I would like some ordinary source material for the collection. Even a working record can tell us what somebody thought was worth writing down. Bring everything on the list back here; I need the full delivery.",
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
			completionCash = 2400,
			ammoExchange = {
				input = "500magnum",
				output = "500magnumap",
				boxes = 3,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/hp-ammo/500magnumhp",
				},
			},
		},
		{
			id = "v3/ap-ammo/338lapuaap",
			branch = "ap-ammo",
			name = ".338 Lapua Armor-Piercing",
			kind = "delivery",
			requires = {"v3/ap-ammo/500magnumap"},
			briefing = "I would like some ordinary source material for the collection. Even a working record can tell us what somebody thought was worth writing down. Bring everything on the list back here; I need the full delivery.",
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
			completionCash = 2550,
			ammoExchange = {
				input = "338lapua",
				output = "338lapuaap",
				boxes = 3,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/hp-ammo/338lapuahp",
				},
			},
		},
		{
			id = "v3/ap-ammo/50aeap",
			branch = "ap-ammo",
			name = ".50AE Armor-Piercing",
			kind = "delivery",
			requires = {"v3/ap-ammo/338lapuaap"},
			briefing = "I would like some ordinary source material for the collection. Even a working record can tell us what somebody thought was worth writing down. Bring everything on the list back here; I need the full delivery.",
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
			completionCash = 2700,
			ammoExchange = {
				input = "50ae",
				output = "50aeap",
				boxes = 3,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/hp-ammo/50aehp",
				},
			},
		},
		{
			id = "v3/ap-ammo/57x28ap",
			branch = "ap-ammo",
			name = "5.7x28mm SS190",
			kind = "delivery",
			requires = {"v3/ap-ammo/50aeap"},
			briefing = "I would like some ordinary source material for the collection. Even a working record can tell us what somebody thought was worth writing down. Bring everything on the list back here; I need the full delivery.",
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
			completionCash = 2850,
			ammoExchange = {
				input = "57x28",
				output = "57x28ap",
				boxes = 3,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/hp-ammo/57x28hp",
				},
			},
		},
		{
			id = "v3/ap-ammo/145x114ap",
			branch = "ap-ammo",
			name = "14.5x114mm B-32",
			kind = "delivery",
			requires = {"v3/ap-ammo/57x28ap"},
			briefing = "I would like some ordinary source material for the collection. Even a working record can tell us what somebody thought was worth writing down. Bring everything on the list back here; I need the full delivery.",
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
			completionCash = 3000,
			ammoExchange = {
				input = "145x114",
				output = "145x114ap",
				boxes = 3,
			},
			crossRequires = {
				{
					contact = "brass",
					step = "v3/hp-ammo/145x114hp",
				},
			},
		},
	},
	startingServices = {},
	retiredCommissions = {
		{
			id = "CA02",
			name = "The Maintenance Office",
			briefing = "I'd like the facility index. An index often survives in conversation as a list of things someone remembers being important. Recover the facility maintenance index from the assigned search area in Waystation. Bring it back to me in Waystation.",
		},
		{
			id = "CA04",
			name = "A small delivery",
			briefing = "I would like some ordinary source material for the collection. Even a working record can tell us what somebody thought was worth writing down. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "CA06",
			name = "The Original's Account",
			briefing = "The Original should read the expedition note himself. A detail may mean something to him that I wouldn't think to ask about. Recover the contemporary expedition diary from the assigned search area in Waystation. Deliver it to 'The Original' in Marsh, then come back to me in Waystation.",
		},
		{
			id = "CA08",
			name = "Restocking",
			briefing = "I would like some ordinary source material for the collection. Even a working record can tell us what somebody thought was worth writing down. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "CA10",
			name = "Egghead's Citation",
			briefing = "I'd like to find the record Egghead cited. Following a reference is more interesting when it leads somewhere other than another person's summary. Recover the cited research record from the assigned search area in Waystation. Bring it back to me in Waystation.",
		},
		{
			id = "CA12",
			name = "Restocking",
			briefing = "I would like some ordinary source material for the collection. Even a working record can tell us what somebody thought was worth writing down. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "CA14",
			name = "The Pripyat Index",
			briefing = "The archive index may show how the records were arranged. I want to understand that before borrowing its headings for my own account. Recover the Pripyat archive index from the assigned search area in Pripyat. Bring it back to me in Waystation.",
		},
		{
			id = "CA16",
			name = "Building the reserve",
			briefing = "I would like some ordinary source material for the collection. Even a working record can tell us what somebody thought was worth writing down. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "CA18",
			name = "The False Summary",
			briefing = "I want the source record behind the summary. We need the surrounding text before deciding what was changed and why. Recover the source of the altered summary from the assigned search area in Waystation. Bring it back to me in Waystation.",
		},
		{
			id = "CA20",
			name = "A full supply order",
			briefing = "I would like some ordinary source material for the collection. Even a working record can tell us what somebody thought was worth writing down. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "CA22",
			name = "A full supply order",
			briefing = "I would like some ordinary source material for the collection. Even a working record can tell us what somebody thought was worth writing down. Bring everything on the list back here; I need the full delivery.",
		},
	},
})
