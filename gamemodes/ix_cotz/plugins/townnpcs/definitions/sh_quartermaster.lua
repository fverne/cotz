PLUGIN:Register("quartermaster", {
	name = "'Quartermaster'",
	template = "unisgnpc",
	map = "rp_waystation",
	job = {
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		category = "Ammunition deliveries",
		description = "Ammunition deliveries",
		pools = {"town_ammunition_military"},
		deliveryTiers = {
			easy = {
				pools = {
					"valuables_military_cases",
					"valuables_equipment_pouches",
				},
				quantity = 1,
			},
			medium = {
				pools = {
					"valuables_ordnance_salvage",
				},
				quantity = 1,
			},
			hard = {
				pools = {
					"valuables_secured_cases",
					"valuables_control_electronics",
				},
				quantity = 2,
			},
		},
		quantities = {2, 4, 7},
	},
	supplies = {
		"drink_bottlewaterdirty",
		"drink_bottlewater",
		"545x39",
		"556x45",
		"9x19",
		"medic_bandage_1",
		"12gauge",
		"22lr",
		"9x18",
	},
	rewards = {
		packages = {
			{label = "Rifle issue",
				items = {"545x39", "556x45", "762x39", "762x51"}},
			{label = "Sidearm issue",
				items = {"9x19", "45acp", "57x28"}},
			{label = "Field dressing",
				items = {"medic_bandage_1", "medic_medkit_1", "medic_medkit_2"}},
		},
	},
	dialogue = {
		delivery = "Place the consignment here for inspection.",
		completedGreeting = (
			"You've established that you can follow through. State what you need, and we can deal with "
			.. "it directly."
		),
		workPrompt = "About my current supply order.",
		offerPrompt = "Do you have a supply order?",
		work = (
			"Supply deliveries. Ammunition and the other goods specified on the order. Verify the actual "
			.. "request and bring the listed quantity. Similar packaging is not evidence of interchangeable "
			.. "contents. We check what arrives before accepting the delivery. If an order cannot be filled, tell "
			.. "me while there is time to choose another arrangement."
		),
		progressionPrompt = "Which procurement records need attention?",
		progression = (
			"I need the supply account checked against surviving procurement records. There are deliveries and "
			.. "field recoveries, each with a specific instruction. Where another contact needs an original, "
			.. "finish that handover before returning here. We will consider the account on what can be verified, "
			.. "not on how useful a favourable interpretation would be."
		),
	},
	catalogue = {
		["microt1"] = {step = "QM06",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["eotech"] = {step = "QM09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["aimpoint"] = {step = "QM07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["kobra"] = {step = "QM05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["lowtiercookerfuel"] = {step = "QM01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_raisins"] = {step = "QM01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_can_beans"] = {step = "QM01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["food_bread"] = {step = "QM03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drink_bottletea"] = {step = "QM01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["127x55"] = {step = "QM21",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["12gaugedt"] = {step = "QM10",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["12gaugemg"] = {step = "QM10",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["12gaugesg"] = {step = "QM10",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["12gaugetr"] = {step = "QM10",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["145x114"] = {step = "QM23",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["145x114ap"] = {step = "QM24",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["145x114hp"] = {step = "QM24",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["22lrap"] = {step = "QM02",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["22lrhp"] = {step = "QM02",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["338lapua"] = {step = "QM19",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["338lapuaap"] = {step = "QM20",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["338lapuahp"] = {step = "QM20",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["357magnum"] = {step = "QM07",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["357magnumap"] = {step = "QM08",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["357magnumhp"] = {step = "QM08",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["44magnum"] = {step = "QM07",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["44magnumap"] = {step = "QM08",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["44magnumhp"] = {step = "QM08",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["45acp"] = {step = "QM05",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["45acp41"] = {step = "QM13",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["45acpap"] = {step = "QM06",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["45acphp"] = {step = "QM06",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["500magnum"] = {step = "QM17",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["500magnumap"] = {step = "QM18",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["500magnumhp"] = {step = "QM18",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["50ae"] = {step = "QM13",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["50aeap"] = {step = "QM14",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["50aehp"] = {step = "QM14",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["545x39"] = {step = "QM09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["545x39ap"] = {step = "QM10",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["545x39hp"] = {step = "QM10",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["556x45"] = {step = "QM11",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["556x45ap"] = {step = "QM12",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["556x45hp"] = {step = "QM12",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["57x28"] = {step = "QM05",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["57x28ap"] = {step = "QM06",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["57x28hp"] = {step = "QM06",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["700nitro"] = {step = "QM21",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x25"] = {step = "QM01",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x25ap"] = {step = "QM02",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x25hp"] = {step = "QM02",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x39"] = {step = "QM11",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x39ap"] = {step = "QM12",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x39hp"] = {step = "QM12",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x51"] = {step = "QM17",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x51ap"] = {step = "QM18",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x51hp"] = {step = "QM18",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x54"] = {step = "QM19",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x54ap"] = {step = "QM20",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x54hp"] = {step = "QM20",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["93x64"] = {step = "QM21",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x18ap"] = {step = "QM04",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x18hp"] = {step = "QM04",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x19"] = {step = "QM03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x19ap"] = {step = "QM04",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x19hp"] = {step = "QM04",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x21"] = {step = "QM03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x21ap"] = {step = "QM04",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x21hp"] = {step = "QM04",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x39"] = {step = "QM15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x39ap"] = {step = "QM16",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x39hp"] = {step = "QM16",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["aek971"] = {step = "QM18",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["ak12"] = {step = "QM24",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["ak74"] = {step = "QM09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["akm"] = {step = "QM15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["aks74u"] = {step = "QM04",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["an94k"] = {step = "QM23",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["ar159mm"] = {step = "QM12",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["aug"] = {step = "QM21",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["drug_painkillers"] = {step = "QM03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["f2000"] = {step = "QM22",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["famas"] = {step = "QM17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["g36c"] = {step = "QM20",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["gepardpdw"] = {step = "QM07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["headwear_cs1"] = {step = "QM10",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["headwear_cs2"] = {step = "QM12",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["headwear_cs4"] = {step = "QM16",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["headwear_pracs"] = {step = "QM22",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["headwear_psz12"] = {step = "QM24",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["headwear_riot"] = {step = "QM07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["headwear_screen"] = {step = "QM15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["helm_operator_nato"] = {step = "QM21",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["helm_operator_rus_1"] = {step = "QM13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["helm_operator_rus_2"] = {step = "QM09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["helm_sphere08"] = {step = "QM18",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["helm_sphere12"] = {step = "QM19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["helm_steel_arab"] = {step = "QM04",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["helm_steel_ger"] = {step = "QM04",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["helm_steel_rus"] = {step = "QM06",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["helm_tanker"] = {step = "QM04",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["hk416"] = {step = "QM23",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["l85"] = {step = "QM19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["lr300"] = {step = "QM16",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["m16a4"] = {step = "QM15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["m1928"] = {step = "QM13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_antirad_1"] = {step = "QM02",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_1"] = {step = "QM01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_2"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_3"] = {step = "QM15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_4"] = {step = "QM17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_5"] = {step = "QM19",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_6"] = {step = "QM23",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mp40"] = {step = "QM02",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mp5"] = {step = "QM05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mp9a1"] = {step = "QM03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["p90"] = {step = "QM14",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["pp19"] = {step = "QM10",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["pp1901vityaz"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["pp2000"] = {step = "QM07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["rk95"] = {step = "QM20",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sg552"] = {step = "QM18",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sr2"] = {step = "QM13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_skat10"] = {step = "QM04",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_skat9"] = {step = "QM24",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["ump45"] = {step = "QM08",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "QM01",
			completionCash = 275,
			name = "A Supplier's Credentials",
			kind = "delivery",
			requires = {},
			briefing = (
				"I need this supply request filled before I can settle the allocations. Bring the listed material "
				.. "here for checking. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Received. I will enter the delivery before assigning it elsewhere.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 9,
				},
			},
			benefits = {
				items = {
					{
						item = "545x39",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "QM02",
			completionCash = 450,
			name = "The Missing Requisition",
			kind = "field",
			objective = (
				"Recover the missing procurement requisition from the assigned search area in Waystation. Bring it "
				.. "back to the issuing contact in Waystation."
			),
			requires = {"QM01"},
			briefing = (
				"I need the procurement record recovered. An allocation quoted from memory is insufficient for "
				.. "checking a missing issue. Recover the missing procurement requisition from the assigned search "
				.. "area in Waystation. Bring it back to me in Waystation."
			),
			completion = "Record received. I'll compare the original request with the issue account.",
			field = {
				description = (
					"A buff-coloured folder with loose military record sheets extending beyond its cover. "
					.. "Quartermaster's note: \"I need the procurement record recovered.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_orders",
				label = "Missing procurement requisition",
			},
			benefits = {},
		},
		{
			id = "QM03",
			completionCash = 0,
			name = "On the Register",
			kind = "tracker",
			requires = {"QM02"},
			briefing = "Continue the supply deliveries. Fill the specified orders before reporting completion.",
			completion = "A reliable beginning. The deliveries are recorded.",
			target = 2,
			benefits = {},
		},
		{
			id = "QM04",
			completionCash = 650,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"QM03"},
			briefing = (
				"I need this supply request filled before I can settle the allocations. Bring the listed material "
				.. "here for checking. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Received. I will enter the delivery before assigning it elsewhere.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 18,
				},
				{
					pool = "town_delivery_military_waystation_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "QM05",
			completionCash = 575,
			name = "Standard Issue",
			kind = "delivery",
			requires = {"QM04"},
			briefing = (
				"I need this supply request filled before I can settle the allocations. Bring the listed material "
				.. "here for checking. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Received. I will enter the delivery before assigning it elsewhere.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 18,
				},
				{
					pool = "town_delivery_military_waystation_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "QM06",
			completionCash = 850,
			name = "The Depot Copy",
			kind = "field",
			objective = (
				"Recover the depot register for Brass from the assigned search area in Garbage. Deliver it to "
				.. "'Brass' in Garbage, then come back to the issuing contact in Waystation."
			),
			requires = {"QM04"},
			briefing = (
				"Brass needs the depot copy. He should reconcile his stock against the original record. Recover "
				.. "the depot register for Brass from the assigned search area in Garbage. Deliver it to 'Brass' in "
				.. "Garbage, then come back to me in Waystation."
			),
			completion = "Delivered. His comparison can now proceed without a summary in place of the register.",
			field = {
				description = (
					"A clipboard carrying a densely printed packing list and a stamped mark. Quartermaster's note: "
					.. "\"Brass needs the depot copy.\""
				),
				kind = "recovery",
				map = "rp_garbage_cotz",
				tier = 1,
				cargo = "town_quest_receipt",
				label = "Depot register for Brass",
				recipient = "brass",
			},
			benefits = {
				items = {
					{
						item = "556x45",
						data = {
							quantity = 1,
						},
					},
				},
			},
			stock = {item = "22lr", bonus = 1},
		},
		{
			id = "QM07",
			completionCash = 0,
			name = "Enough for the Patrol",
			kind = "tracker",
			requires = {"QM05"},
			briefing = "More supply orders when prepared. Verify the goods and quantities requested.",
			completion = "Another consistent run of completed orders.",
			target = 5,
			benefits = {},
		},
		{
			id = "QM08",
			completionCash = 1050,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"QM06"},
			briefing = (
				"I need this supply request filled before I can settle the allocations. Bring the listed material "
				.. "here for checking. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Received. I will enter the delivery before assigning it elsewhere.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 18,
				},
				{
					pool = "town_delivery_military_waystation_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "QM09",
			completionCash = 875,
			name = "Fittings and Mounts",
			kind = "delivery",
			requires = {"QM07"},
			briefing = (
				"I need this supply request filled before I can settle the allocations. Bring the listed material "
				.. "here for checking. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Received. I will enter the delivery before assigning it elsewhere.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 18,
				},
				{
					pool = "town_delivery_military_waystation_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "QM10",
			completionCash = 1250,
			name = "The Returned Equipment",
			kind = "field",
			objective = (
				"Recover the returned-kit inspection record from the assigned search area in Waystation. Bring it "
				.. "back to the issuing contact in Waystation."
			),
			requires = {"QM08"},
			briefing = (
				"I need the field inspection record. Equipment being returned doesn't establish the condition in "
				.. "which it was issued. Recover the returned-kit inspection record from the assigned search area in "
				.. "Waystation. Bring it back to me in Waystation."
			),
			completion = "Record received. I'll compare the inspection with the original issue.",
			field = {
				description = (
					"A cardboard file folder with a small coloured crest on its cover. Quartermaster's note: \"I need "
					.. "the field inspection record.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_official",
				label = "Returned-kit inspection record",
			},
			benefits = {},
		},
		{
			id = "QM11",
			completionCash = 0,
			name = "Steel Earned",
			kind = "tracker",
			requires = {"QM09"},
			briefing = "Keep filling the supply requests while I review the procurement records.",
			completion = "You've supplied verifiable returns. That makes allocation possible.",
			target = 9,
			benefits = {},
		},
		{
			id = "QM12",
			completionCash = 1450,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"QM10"},
			briefing = (
				"I need this supply request filled before I can settle the allocations. Bring the listed material "
				.. "here for checking. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Received. I will enter the delivery before assigning it elsewhere.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 27,
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
			id = "QM13",
			completionCash = 1175,
			name = "More Than One Role",
			kind = "delivery",
			requires = {"QM11"},
			briefing = (
				"I need this supply request filled before I can settle the allocations. Bring the listed material "
				.. "here for checking. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Received. I will enter the delivery before assigning it elsewhere.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 27,
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
			benefits = {},
		},
		{
			id = "QM14",
			completionCash = 1650,
			name = "The Wrong Model",
			kind = "field",
			objective = (
				"Recover the serial record for Latch from the assigned search area in Waystation. Deliver it to "
				.. "'Latch' in Garbage, then come back to the issuing contact in Waystation."
			),
			requires = {"QM12"},
			briefing = (
				"Latch needs the serial-number record. He can verify the machinery details against the recovered "
				.. "equipment. Recover the serial record for Latch from the assigned search area in Waystation. "
				.. "Deliver it to 'Latch' in Garbage, then come back to me in Waystation."
			),
			completion = "Delivered. That gives him a specific record to inspect rather than a model described from memory.",
			field = {
				description = (
					"A buff-coloured document folder with printed sheets protruding at uneven angles. Quartermaster's "
					.. "note: \"Latch needs the serial-number record.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_military",
				label = "Serial record for Latch",
				recipient = "latch",
			},
			benefits = {},
		},
		{
			id = "QM15",
			completionCash = 0,
			name = "A Dependable Reserve",
			kind = "tracker",
			requires = {"QM13"},
			briefing = "Continue the delivery work. The request remains the basis for acceptance.",
			completion = "A substantial contribution to the account. Acknowledged.",
			target = 14,
			benefits = {},
		},
		{
			id = "QM16",
			completionCash = 1850,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"QM14"},
			briefing = (
				"I need this supply request filled before I can settle the allocations. Bring the listed material "
				.. "here for checking. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Received. I will enter the delivery before assigning it elsewhere.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 27,
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
			benefits = {},
		},
		{
			id = "QM17",
			completionCash = 1475,
			name = "Ready for Deployment",
			kind = "delivery",
			requires = {"QM15"},
			briefing = (
				"I need this supply request filled before I can settle the allocations. Bring the listed material "
				.. "here for checking. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Received. I will enter the delivery before assigning it elsewhere.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 27,
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
			benefits = {},
		},
		{
			id = "QM18",
			completionCash = 2050,
			name = "The Pripyat Manifest",
			kind = "field",
			objective = (
				"Recover the Pripyat supply manifest from the assigned search area in Pripyat. Bring it back to "
				.. "the issuing contact in Waystation."
			),
			requires = {"QM16"},
			briefing = (
				"Recover the expedition supply record in Pripyat. Keep the supplementary pages with the manifest. "
				.. "Recover the Pripyat supply manifest from the assigned search area in Pripyat. Bring it back to me "
				.. "in Waystation."
			),
			completion = "Received. I'll check the allocations before comparing them with the returns.",
			field = {
				description = (
					"A printed packing list on a small clipboard with a metal clip and a circular stamp. "
					.. "Quartermaster's note: \"Recover the expedition supply record in Pripyat.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_manifest",
				label = "Pripyat supply manifest",
			},
			benefits = {
				items = {
					{
						item = "556x45",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "QM19",
			completionCash = 0,
			name = "Kept Supplied",
			kind = "tracker",
			requires = {"QM17"},
			briefing = "There are further supply orders. Prepare for the request you choose.",
			completion = "You've remained dependable through the work. I appreciate it.",
			target = 20,
			benefits = {},
		},
		{
			id = "QM20",
			completionCash = 2250,
			name = "Building the reserve",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 3 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"QM18"},
			briefing = (
				"I need this supply request filled before I can settle the allocations. Bring the listed material "
				.. "here for checking. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Received. I will enter the delivery before assigning it elsewhere.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 27,
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
			benefits = {},
		},
		{
			id = "QM21",
			completionCash = 1775,
			name = "Procurement Evidence",
			kind = "delivery",
			requires = {"QM19", "QM20"},
			briefing = (
				"I need this supply request filled before I can settle the allocations. Bring the listed material "
				.. "here for checking. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Received. I will enter the delivery before assigning it elsewhere.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 36,
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
			benefits = {},
		},
		{
			id = "QM22",
			completionCash = 2450,
			name = "The Contractor's Copy",
			kind = "field",
			objective = (
				"Recover the supply annex for Carbon from the assigned search area in Waystation. Deliver it to "
				.. "'Carbon' in Waystation, then come back to the issuing contact in Waystation."
			),
			requires = {"QM21"},
			briefing = (
				"Carbon needs the surviving annex. He can compare the agreement's context without my selecting the "
				.. "relevant passage for him. Recover the supply annex for Carbon from the assigned search area in "
				.. "Waystation. Deliver it to 'Carbon' in Waystation, then come back to me in Waystation."
			),
			completion = "Delivered. I'll wait for the complete comparison before drawing on it.",
			field = {
				description = (
					"A creased printed letter with a corporate mark and several small blocks of text. Quartermaster's "
					.. "note: \"Carbon needs the surviving annex.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_contract",
				label = "Supply annex for Carbon",
				recipient = "carbon",
			},
			benefits = {},
		},
		{
			id = "QM23",
			completionCash = 0,
			name = "A Standing Agreement",
			kind = "tracker",
			requires = {"QM22"},
			briefing = "Keep the supply deliveries moving when prepared.",
			completion = (
				"Your reliability is established by the returns. You've earned the professional confidence that "
				.. "follows from that."
			),
			target = 27,
			benefits = {},
		},
		{
			id = "QM24",
			completionCash = 2650,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"QM23"},
			briefing = (
				"I need this supply request filled before I can settle the allocations. Bring the listed material "
				.. "here for checking. Bring everything on the list back here; I need the full delivery."
			),
			completion = "Received. I will enter the delivery before assigning it elsewhere.",
			requirements = {
				{
					pool = "town_delivery_military_waystation_1",
					quantity = 36,
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
			recognition = "Quartermaster's trusted contact",
		},
	},
})
