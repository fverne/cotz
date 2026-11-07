PLUGIN:Register("quartermaster", {
	name = "'Quartermaster'",
	template = "unisgnpc",
	difficultyMultiplier = 5,
	enforceCatalogue = true,
	map = "rp_waystation",
	courierPools = {
		"valuables_military_cases",
		"valuables_armour_panels",
		"valuables_protective_textiles",
		"valuables_ordnance_salvage",
	},
	job = {
		category = "Valuable delivery and courier work",
		description = "Valuable delivery and courier work",
		kind = "valuableCourier",
	},
	legacyJob = {
		category = "Ammunition deliveries",
		deliveryTiers = {
			easy = {
				pools = {"valuables_military_cases", "valuables_equipment_pouches"},
				quantity = 1,
			},
			hard = {
				pools = {"valuables_secured_cases", "valuables_control_electronics"},
				quantity = 2,
			},
			medium = {
				pools = {"valuables_ordnance_salvage"},
				quantity = 1,
			},
		},
		description = "Ammunition deliveries",
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		pools = {"town_ammunition_military"},
		quantities = {2, 4, 7},
	},
	supplies = {"food_mre_usa", "drink_canwater", "medic_antirad_1", "medic_bandage_1", "medic_medkit_1"},
	rewards = {
		bonusPackages = {
			{
				items = {"545x39ap"},
				label = "Specialist ammunition",
			},
			{
				items = {"value_currency_dollar"},
				label = "Dollar notes",
			},
		},
		packages = {
			{
				items = {"545x39", "556x45"},
				label = "Rifle issue",
			},
			{
				items = {"medic_bandage_1", "medic_medkit_1"},
				label = "Field medicine",
			},
			{
				items = {"food_can_tushonka"},
				label = "Canned provisions",
			},
		},
	},
	dialogue = {
		completedGreeting = "You've established that you can follow through. State what you need, and we can deal with it directly.",
		delivery = "Place the consignment here for inspection.",
		jobBriefing = "I have a supply movement that needs covering. {details}",
		jobFinished = "The delivery is accounted for. We can settle your payment.",
		jobReminder = "That supply movement is still outstanding. {details}",
		offerPrompt = "Do you have a delivery order?",
		progression = "I need this supply request filled before I can settle the allocations. Bring the listed material here for checking. Bring everything on the list back here; I need the full delivery.",
		progressionPrompt = "Which procurement records need attention?",
		work = "The order specifies an item and a quantity. Deliver it to a contact here in Waystation who requests that category, then return to me for settlement. You may use stock you already own. The harder orders concern goods sourced beyond this region; check what you are committing to before you leave.",
		workPrompt = "About my delivery order.",
	},
	catalogue = {
		rugermini14 = {
			step = "v3/nato-rifles/rugermini14",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		famas = {
			step = "v3/nato-rifles/famas",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		l85 = {
			step = "v3/nato-rifles/l85",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		m16a4 = {
			step = "v3/nato-rifles/m16a4",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		lr300 = {
			step = "v3/nato-rifles/lr300",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		sg552 = {
			step = "v3/nato-rifles/sg552",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		g36c = {
			step = "v3/nato-rifles/g36c",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		aug = {
			step = "v3/nato-rifles/aug",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		f2000 = {
			step = "v3/nato-rifles/f2000",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		hk416 = {
			step = "v3/nato-rifles/hk416",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		g3a3 = {
			step = "v3/nato-rifles/g3a3",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		fnfal = {
			step = "v3/nato-rifles/fnfal",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
		m14 = {
			step = "v3/nato-rifles/m14",
			terms = {nil, 1, "SELLONLY", 1, 48, 1},
		},
	},
	progression = {
		{
			id = "v3/nato-rifles/rugermini14",
			branch = "nato-rifles",
			name = "Ruger Mini-14",
			kind = "delivery",
			requires = {},
			briefing = "I need this supply request filled before I can settle the allocations. Bring the listed material here for checking. Bring everything on the list back here; I need the full delivery.",
			completion = "Received. I will enter the delivery before assigning it elsewhere.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 450,
		},
		{
			id = "v3/nato-rifles/famas",
			branch = "nato-rifles",
			name = "FAMAS",
			kind = "delivery",
			requires = {"v3/nato-rifles/rugermini14"},
			briefing = "I need this supply request filled before I can settle the allocations. Bring the listed material here for checking. Bring everything on the list back here; I need the full delivery.",
			completion = "Received. I will enter the delivery before assigning it elsewhere.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 650,
		},
		{
			id = "v3/nato-rifles/l85",
			branch = "nato-rifles",
			name = "L85",
			kind = "delivery",
			requires = {"v3/nato-rifles/famas"},
			briefing = "I need this supply request filled before I can settle the allocations. Bring the listed material here for checking. Bring everything on the list back here; I need the full delivery.",
			completion = "Received. I will enter the delivery before assigning it elsewhere.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 850,
		},
		{
			id = "v3/nato-rifles/m16a4",
			branch = "nato-rifles",
			name = "M16A4",
			kind = "delivery",
			requires = {"v3/nato-rifles/l85"},
			briefing = "I need this supply request filled before I can settle the allocations. Bring the listed material here for checking. Bring everything on the list back here; I need the full delivery.",
			completion = "Received. I will enter the delivery before assigning it elsewhere.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 1,
				},
			},
			completionCash = 1050,
		},
		{
			id = "v3/nato-rifles/lr300",
			branch = "nato-rifles",
			name = "LR-300",
			kind = "delivery",
			requires = {"v3/nato-rifles/m16a4"},
			briefing = "I need this supply request filled before I can settle the allocations. Bring the listed material here for checking. Bring everything on the list back here; I need the full delivery.",
			completion = "Received. I will enter the delivery before assigning it elsewhere.",
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
			completionCash = 1300,
		},
		{
			id = "v3/nato-rifles/sg552",
			branch = "nato-rifles",
			name = "SIG SG 552",
			kind = "delivery",
			requires = {"v3/nato-rifles/lr300"},
			briefing = "I need this supply request filled before I can settle the allocations. Bring the listed material here for checking. Bring everything on the list back here; I need the full delivery.",
			completion = "Received. I will enter the delivery before assigning it elsewhere.",
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
			id = "v3/nato-rifles/g36c",
			branch = "nato-rifles",
			name = "HK G36C",
			kind = "delivery",
			requires = {"v3/nato-rifles/sg552"},
			briefing = "I need this supply request filled before I can settle the allocations. Bring the listed material here for checking. Bring everything on the list back here; I need the full delivery.",
			completion = "Received. I will enter the delivery before assigning it elsewhere.",
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
			completionCash = 1700,
		},
		{
			id = "v3/nato-rifles/aug",
			branch = "nato-rifles",
			name = "Steyr AUG",
			kind = "delivery",
			requires = {"v3/nato-rifles/g36c"},
			briefing = "I need this supply request filled before I can settle the allocations. Bring the listed material here for checking. Bring everything on the list back here; I need the full delivery.",
			completion = "Received. I will enter the delivery before assigning it elsewhere.",
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
			id = "v3/nato-rifles/f2000",
			branch = "nato-rifles",
			name = "f2000",
			kind = "delivery",
			requires = {"v3/nato-rifles/aug"},
			briefing = "I need this supply request filled before I can settle the allocations. Bring the listed material here for checking. Bring everything on the list back here; I need the full delivery.",
			completion = "Received. I will enter the delivery before assigning it elsewhere.",
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
			completionCash = 2150,
		},
		{
			id = "v3/nato-rifles/hk416",
			branch = "nato-rifles",
			name = "HK416",
			kind = "delivery",
			requires = {"v3/nato-rifles/f2000"},
			briefing = "I need this supply request filled before I can settle the allocations. Bring the listed material here for checking. Bring everything on the list back here; I need the full delivery.",
			completion = "Received. I will enter the delivery before assigning it elsewhere.",
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
			completionCash = 2350,
		},
		{
			id = "v3/nato-rifles/g3a3",
			branch = "nato-rifles",
			name = "G3A3",
			kind = "delivery",
			requires = {"v3/nato-rifles/hk416"},
			briefing = "I need this supply request filled before I can settle the allocations. Bring the listed material here for checking. Bring everything on the list back here; I need the full delivery.",
			completion = "Received. I will enter the delivery before assigning it elsewhere.",
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
			completionCash = 2550,
		},
		{
			id = "v3/nato-rifles/fnfal",
			branch = "nato-rifles",
			name = "fnfal",
			kind = "delivery",
			requires = {"v3/nato-rifles/g3a3"},
			briefing = "I need this supply request filled before I can settle the allocations. Bring the listed material here for checking. Bring everything on the list back here; I need the full delivery.",
			completion = "Received. I will enter the delivery before assigning it elsewhere.",
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
			completionCash = 2750,
		},
		{
			id = "v3/nato-rifles/m14",
			branch = "nato-rifles",
			name = "m14",
			kind = "delivery",
			requires = {"v3/nato-rifles/fnfal"},
			briefing = "I need this supply request filled before I can settle the allocations. Bring the listed material here for checking. Bring everything on the list back here; I need the full delivery.",
			completion = "Received. I will enter the delivery before assigning it elsewhere.",
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
			id = "QM02",
			name = "The Missing Requisition",
			briefing = "I need the procurement record recovered. An allocation quoted from memory is insufficient for checking a missing issue. Recover the missing procurement requisition from the assigned search area in Waystation. Bring it back to me in Waystation.",
		},
		{
			id = "QM04",
			name = "Restocking",
			briefing = "I need this supply request filled before I can settle the allocations. Bring the listed material here for checking. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "QM06",
			name = "The Depot Copy",
			briefing = "Brass needs the depot copy. He should reconcile his stock against the original record. Recover the depot register for Brass from the assigned search area in Garbage. Deliver it to 'Brass' in Garbage, then come back to me in Waystation.",
		},
		{
			id = "QM08",
			name = "Restocking",
			briefing = "I need this supply request filled before I can settle the allocations. Bring the listed material here for checking. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "QM10",
			name = "The Returned Equipment",
			briefing = "I need the field inspection record. Equipment being returned doesn't establish the condition in which it was issued. Recover the returned-kit inspection record from the assigned search area in Waystation. Bring it back to me in Waystation.",
		},
		{
			id = "QM12",
			name = "Building the reserve",
			briefing = "I need this supply request filled before I can settle the allocations. Bring the listed material here for checking. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "QM14",
			name = "The Wrong Model",
			briefing = "Latch needs the serial-number record. He can verify the machinery details against the recovered equipment. Recover the serial record for Latch from the assigned search area in Waystation. Deliver it to 'Latch' in Garbage, then come back to me in Waystation.",
		},
		{
			id = "QM16",
			name = "Building the reserve",
			briefing = "I need this supply request filled before I can settle the allocations. Bring the listed material here for checking. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "QM18",
			name = "The Pripyat Manifest",
			briefing = "Recover the expedition supply record in Pripyat. Keep the supplementary pages with the manifest. Recover the Pripyat supply manifest from the assigned search area in Pripyat. Bring it back to me in Waystation.",
		},
		{
			id = "QM20",
			name = "Building the reserve",
			briefing = "I need this supply request filled before I can settle the allocations. Bring the listed material here for checking. Bring everything on the list back here; I need the full delivery.",
		},
		{
			id = "QM22",
			name = "The Contractor's Copy",
			briefing = "Carbon needs the surviving annex. He can compare the agreement's context without my selecting the relevant passage for him. Recover the supply annex for Carbon from the assigned search area in Waystation. Deliver it to 'Carbon' in Waystation, then come back to me in Waystation.",
		},
		{
			id = "QM24",
			name = "A full supply order",
			briefing = "I need this supply request filled before I can settle the allocations. Bring the listed material here for checking. Bring everything on the list back here; I need the full delivery.",
		},
	},
})
