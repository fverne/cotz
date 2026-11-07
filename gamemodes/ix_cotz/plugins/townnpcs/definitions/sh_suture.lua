PLUGIN:Register("suture", {
	name = "'Suture'",
	template = "suturenpc",
	difficultyMultiplier = 5,
	enforceCatalogue = true,
	map = "rp_waystation",
	courierPools = {
		"valuables_textile_supplies",
		"valuables_protective_textiles",
		"valuables_equipment_pouches",
		"valuables_cutting_tools",
	},
	job = {
		category = "No ordinary repeatable work",
		description = "No ordinary repeatable work",
		kind = "none",
	},
	legacyJob = {
		category = "Textile supply deliveries",
		deliveryTiers = {
			easy = {
				pools = {"valuables_textile_supplies", "valuables_equipment_pouches"},
				quantity = 1,
			},
			hard = {
				pools = {"valuables_armour_panels"},
				quantity = 2,
			},
			medium = {
				pools = {"valuables_protective_textiles"},
				quantity = 1,
			},
		},
		description = "Textile supply deliveries",
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		pools = {"town_textiles"},
		quantities = {2, 4, 7},
	},
	supplies = {},
	rewards = {
		packages = {
			{
				items = {"medic_bandage_1", "medic_bandage_2"},
				label = "Field dressings",
			},
			{
				items = {"drug_painkillers"},
				label = "Pain relief",
			},
			{
				items = {"food_raisins", "drink_bottlewater"},
				label = "Expedition provisions",
			},
		},
	},
	dialogue = {
		completedGreeting = "Come in. Put your pack down carefully; I'd like to hear how the equipment has been treating you.",
		delivery = "Set it down carefully. I want to see what condition it arrived in.",
		jobBriefing = "There's something I can use your help with. {details}",
		jobFinished = "Thank you. Put it here and let me settle your payment.",
		jobReminder = "I haven't got everything I need yet. {details}",
		offerPrompt = "Do you need textiles brought in?",
		progression = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
		progressionPrompt = "What are you working on for the expedition gear?",
		work = "Textiles, webbing, protective materials, according to the request. Keep them clear of sharp salvage and leaking containers. I'd prefer to judge the material before your packing gives it a second career as rags. Choose an order, check it, and bring the supplies here for inspection.",
		workPrompt = "About the material order.",
	},
	catalogue = {
		attachment_ceramicplate_1 = {
			step = "v3/suit-attachments/attachment_ceramicplate_1",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		attachment_steelplate_1 = {
			step = "v3/suit-attachments/attachment_steelplate_1",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		attachment_fabric_1 = {
			step = "v3/suit-attachments/attachment_fabric_1",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		attachment_steelplate_2 = {
			step = "v3/suit-attachments/attachment_steelplate_2",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		attachment_ceramicplate_2 = {
			step = "v3/suit-attachments/attachment_ceramicplate_2",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		attachment_fabric_2 = {
			step = "v3/suit-attachments/attachment_fabric_2",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		attachment_kevlar_1 = {
			step = "v3/suit-attachments/attachment_kevlar_1",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		attachment_aluframe = {
			step = "v3/suit-attachments/attachment_aluframe",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		attachment_steelplate_3 = {
			step = "v3/suit-attachments/attachment_steelplate_3",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		attachment_carbonfibre = {
			step = "v3/suit-attachments/attachment_carbonfibre",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		attachment_steelframe = {
			step = "v3/suit-attachments/attachment_steelframe",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		attachment_ceramicplate_3 = {
			step = "v3/suit-attachments/attachment_ceramicplate_3",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		attachment_kevlar_2 = {
			step = "v3/suit-attachments/attachment_kevlar_2",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
	},
	progression = {
		{
			id = "v3/suit-attachments/attachment_ceramicplate_1",
			branch = "suit-attachments",
			name = "Old Ceramic Plate",
			kind = "delivery",
			requires = {},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 450,
		},
		{
			id = "v3/suit-attachments/attachment_steelplate_1",
			branch = "suit-attachments",
			name = "Well Worn Steel Plate",
			kind = "delivery",
			requires = {"v3/suit-attachments/attachment_ceramicplate_1"},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 650,
		},
		{
			id = "v3/suit-attachments/attachment_fabric_1",
			branch = "suit-attachments",
			name = "Insulating Fabrics",
			kind = "delivery",
			requires = {"v3/suit-attachments/attachment_steelplate_1"},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 850,
		},
		{
			id = "v3/suit-attachments/attachment_steelplate_2",
			branch = "suit-attachments",
			name = "Steel Plate",
			kind = "delivery",
			requires = {"v3/suit-attachments/attachment_fabric_1"},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 1050,
		},
		{
			id = "v3/suit-attachments/attachment_ceramicplate_2",
			branch = "suit-attachments",
			name = "Ceramic Plate",
			kind = "delivery",
			requires = {"v3/suit-attachments/attachment_steelplate_2"},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 1,
				},
			},
			completionCash = 1300,
		},
		{
			id = "v3/suit-attachments/attachment_fabric_2",
			branch = "suit-attachments",
			name = "Thick Insulating Fabrics",
			kind = "delivery",
			requires = {"v3/suit-attachments/attachment_ceramicplate_2"},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 1,
				},
			},
			completionCash = 1500,
		},
		{
			id = "v3/suit-attachments/attachment_kevlar_1",
			branch = "suit-attachments",
			name = "Kevlar K119 Plates",
			kind = "delivery",
			requires = {"v3/suit-attachments/attachment_fabric_2"},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 1,
				},
			},
			completionCash = 1700,
		},
		{
			id = "v3/suit-attachments/attachment_aluframe",
			branch = "suit-attachments",
			name = "Aluminium Frame",
			kind = "delivery",
			requires = {"v3/suit-attachments/attachment_kevlar_1"},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 1,
				},
			},
			completionCash = 1900,
		},
		{
			id = "v3/suit-attachments/attachment_steelplate_3",
			branch = "suit-attachments",
			name = "Galvanized Steel Plate",
			kind = "delivery",
			requires = {"v3/suit-attachments/attachment_aluframe"},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_3",
					quantity = 1,
				},
			},
			completionCash = 2150,
		},
		{
			id = "v3/suit-attachments/attachment_carbonfibre",
			branch = "suit-attachments",
			name = "Carbon Fibre Layers",
			kind = "delivery",
			requires = {"v3/suit-attachments/attachment_steelplate_3"},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_3",
					quantity = 1,
				},
			},
			completionCash = 2350,
		},
		{
			id = "v3/suit-attachments/attachment_steelframe",
			branch = "suit-attachments",
			name = "Steel Frame",
			kind = "delivery",
			requires = {"v3/suit-attachments/attachment_carbonfibre"},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_3",
					quantity = 1,
				},
			},
			completionCash = 2550,
		},
		{
			id = "v3/suit-attachments/attachment_ceramicplate_3",
			branch = "suit-attachments",
			name = "Modern Ceramic Plate",
			kind = "delivery",
			requires = {"v3/suit-attachments/attachment_steelframe"},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_3",
					quantity = 1,
				},
			},
			completionCash = 2750,
		},
		{
			id = "v3/suit-attachments/attachment_kevlar_2",
			branch = "suit-attachments",
			name = "Kevlar K29 Plates",
			kind = "delivery",
			requires = {"v3/suit-attachments/attachment_ceramicplate_3"},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_waystation_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
		},
		{
			id = "v3/suit-variants/suit_anorak",
			branch = "suit-variants",
			name = "Anorak",
			kind = "delivery",
			requires = {},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 450,
			crossRequires = {},
			variantBase = "suit_anorak",
		},
		{
			id = "v3/suit-variants/suit_mailjacket",
			branch = "suit-variants",
			name = "Mail Jacket",
			kind = "delivery",
			requires = {"v3/suit-variants/suit_anorak"},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 600,
			crossRequires = {
				{
					contact = "technut",
					step = "v3/suits/suit_mailjacket",
				},
			},
			variantBase = "suit_mailjacket",
		},
		{
			id = "v3/suit-variants/suit_sunrise",
			branch = "suit-variants",
			name = "Sunrise STALKER Suit",
			kind = "delivery",
			requires = {"v3/suit-variants/suit_mailjacket"},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 900,
			crossRequires = {
				{
					contact = "technut",
					step = "v3/suits/suit_sunrise",
				},
			},
			variantBase = "suit_sunrise",
		},
		{
			id = "v3/suit-variants/suit_io7a",
			branch = "suit-variants",
			name = "IO7a Suit",
			kind = "delivery",
			requires = {"v3/suit-variants/suit_sunrise"},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 1050,
			crossRequires = {
				{
					contact = "technut",
					step = "v3/suits/suit_io7a",
				},
			},
			variantBase = "suit_io7a",
		},
		{
			id = "v3/suit-variants/suit_cs1",
			branch = "suit-variants",
			name = "Sky-1 Suit",
			kind = "delivery",
			requires = {"v3/suit-variants/suit_io7a"},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 1200,
			crossRequires = {
				{
					contact = "technut",
					step = "v3/suits/suit_cs1",
				},
			},
			variantBase = "suit_cs1",
		},
		{
			id = "v3/suit-variants/suit_wind",
			branch = "suit-variants",
			name = "Pathfinder Suit",
			kind = "delivery",
			requires = {"v3/suit-variants/suit_cs1"},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 1,
				},
			},
			completionCash = 1550,
			crossRequires = {
				{
					contact = "technut",
					step = "v3/suits/suit_wind",
				},
			},
			variantBase = "suit_wind",
		},
		{
			id = "v3/suit-variants/suit_ps5m",
			branch = "suit-variants",
			name = "Universal Protection Suit",
			kind = "delivery",
			requires = {"v3/suit-variants/suit_wind"},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 1,
				},
			},
			completionCash = 1700,
			crossRequires = {
				{
					contact = "technut",
					step = "v3/suits/suit_ps5m",
				},
			},
			variantBase = "suit_ps5m",
		},
		{
			id = "v3/suit-variants/suit_cs2",
			branch = "suit-variants",
			name = "Sky-2 Suit",
			kind = "delivery",
			requires = {"v3/suit-variants/suit_ps5m"},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 1,
				},
			},
			completionCash = 1850,
			crossRequires = {
				{
					contact = "technut",
					step = "v3/suits/suit_cs2",
				},
			},
			variantBase = "suit_cs2",
		},
		{
			id = "v3/suit-variants/suit_nbc",
			branch = "suit-variants",
			name = "NBC Suit",
			kind = "delivery",
			requires = {"v3/suit-variants/suit_cs2"},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 1,
				},
			},
			completionCash = 2000,
			crossRequires = {
				{
					contact = "technut",
					step = "v3/suits/suit_nbc",
				},
			},
			variantBase = "suit_nbc",
		},
		{
			id = "v3/suit-variants/suit_berill",
			branch = "suit-variants",
			name = "Berill-5M",
			kind = "delivery",
			requires = {"v3/suit-variants/suit_nbc"},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_3",
					quantity = 1,
				},
			},
			completionCash = 2200,
			crossRequires = {
				{
					contact = "technut",
					step = "v3/suits/suit_berill",
				},
			},
			variantBase = "suit_berill",
		},
		{
			id = "v3/suit-variants/suit_cs3",
			branch = "suit-variants",
			name = "Sky-3 Suit",
			kind = "delivery",
			requires = {"v3/suit-variants/suit_berill"},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_3",
					quantity = 1,
				},
			},
			completionCash = 2350,
			crossRequires = {
				{
					contact = "technut",
					step = "v3/suits/suit_cs3",
				},
			},
			variantBase = "suit_cs3",
		},
		{
			id = "v3/suit-variants/suit_seva",
			branch = "suit-variants",
			name = "SEVA Suit",
			kind = "delivery",
			requires = {"v3/suit-variants/suit_cs3"},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_3",
					quantity = 1,
				},
			},
			completionCash = 2650,
			crossRequires = {
				{
					contact = "egghead",
					step = "v3/science-suits/suit_seva",
				},
			},
			variantBase = "suit_seva",
		},
		{
			id = "v3/suit-variants/suit_skat10",
			branch = "suit-variants",
			name = "Skat-10 Armored Suit",
			kind = "delivery",
			requires = {"v3/suit-variants/suit_seva"},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_3",
					quantity = 1,
				},
			},
			completionCash = 2800,
			crossRequires = {
				{
					contact = "technut",
					step = "v3/suits/suit_skat10",
				},
			},
			variantBase = "suit_skat10",
		},
		{
			id = "v3/suit-variants/suit_skat9",
			branch = "suit-variants",
			name = "Skat-9 Armored Suit",
			kind = "delivery",
			requires = {"v3/suit-variants/suit_skat10"},
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
			completion = "Thank you. Leave them flat while I inspect the material.",
			requirements = {
				{
					pool = "town_delivery_textiles_waystation_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_textiles_waystation_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_textiles_waystation_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_textiles_waystation_4",
					quantity = 1,
				},
			},
			completionCash = 3000,
			crossRequires = {
				{
					contact = "technut",
					step = "v3/suits/suit_skat9",
				},
			},
			variantBase = "suit_skat9",
		},
	},
	startingServices = {
		{
			id = "suitVariants",
			name = "Paid suit variant conversions",
		},
	},
	retiredCommissions = {
		{
			id = "SU02",
			name = "The Missing Pattern",
			briefing = "There's a pattern case left at the workshop site. A fold in the wrong place can make a perfectly good drawing difficult to use. Recover the workshop pattern case from the assigned search area in Waystation. Bring it back to me in Waystation.",
		},
		{
			id = "SU04",
			name = "Restocking",
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "SU06",
			name = "The Forgotten Measurements",
			briefing = "The fitting notes are missing. People remember that something was comfortable and forget what was changed to make it so. Recover the workshop fitting record from the assigned search area in Waystation. Bring it back to me in Waystation.",
		},
		{
			id = "SU08",
			name = "Restocking",
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "SU10",
			name = "The Loaded Pack",
			briefing = "I'd like the load-test recording recovered. Looking comfortable at the beginning of a walk isn't the entire test. Recover the loaded-pack trial recording from the assigned search area in Waystation. Bring it back to me in Waystation.",
		},
		{
			id = "SU12",
			name = "Building the reserve",
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "SU14",
			name = "The Failed Seam",
			briefing = "Bring the trial case back unchanged. If something failed, I want the arrangement that failed, not somebody's improved version. Recover the failed trial equipment case from the assigned search area in Waystation. Bring it back to me in Waystation.",
		},
		{
			id = "SU16",
			name = "Building the reserve",
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "SU18",
			name = "The Pripyat Trial",
			briefing = "There's an outfitting trial recording in Pripyat. I'd like to hear the account before selecting the convenient parts for a pattern. Recover the Pripyat outfitting trial tape from the assigned search area in Pripyat. Bring it back to me in Waystation.",
		},
		{
			id = "SU20",
			name = "Building the reserve",
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "SU22",
			name = "The Return Journey Test",
			briefing = "I want a recording from the return-journey test. People pack very differently once they're tired. Deploy the recorder at the assigned site in Waystation, let it finish recording, then retrieve the return-journey equipment recorder. Bring it back to me in Waystation.",
		},
		{
			id = "SU24",
			name = "A full supply order",
			briefing = "I need material for the work here. Check the list before you bring a bundle; I have to see what I am working with before promising a fit. Bring everything on the list back here; I need the full delivery.",
		},
	},
})
