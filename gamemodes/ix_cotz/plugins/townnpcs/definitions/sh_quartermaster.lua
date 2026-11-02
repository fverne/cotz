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
	supplies = {"545x39", "556x45", "9x19", "medic_bandage_1"},
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
		["127x55"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["12gaugedt"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["12gaugesg"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["12gaugemg"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["12gaugetr"] = {unlockContact = "brass", step = "BR21",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["145x114"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["145x114ap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["145x114hp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["22lrap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["22lrhp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["338lapua"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["338lapuaap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["338lapuahp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["357magnum"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["357magnumap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["357magnumhp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["44magnum"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["44magnumap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["44magnumhp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["45acp"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["45acpap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["45acphp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["45acp41"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["500magnum"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["500magnumap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["500magnumhp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["50ae"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["50aeap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["50aehp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["545x39"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["545x39ap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["545x39hp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["556x45"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["556x45ap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["556x45hp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["57x28"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["57x28ap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["57x28hp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["700nitro"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x25"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x25ap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x25hp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x39"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x39ap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x39hp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x51"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x51ap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x51hp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x54"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x54ap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x54hp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["93x64"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x18ap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x18hp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x19"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x19ap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x19hp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x21"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x21ap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x21hp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x39"] = {unlockContact = "brass", step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x39ap"] = {unlockContact = "brass", step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x39hp"] = {unlockContact = "brass", step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["helm_operator_nato"] = {step = "QM21",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["headwear_pracs"] = {step = "QM22",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["headwear_psz12"] = {step = "QM23",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["medic_medkit_1"] = {step = "QM07",
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
		["aek971"] = {step = "QM17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["aimpoint"] = {step = "QM03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["ak12"] = {step = "QM17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["ak74"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["akm"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["aks74u"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["an94k"] = {step = "QM17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["ar159mm"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["aug"] = {step = "QM17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["deagle"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["deagle44"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["eotech"] = {step = "QM03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["f2000"] = {step = "QM17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["famas"] = {step = "QM17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["fiveseven"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["fnfal"] = {step = "QM17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["foregrip"] = {step = "QM01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["g36c"] = {step = "QM17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["g3a3"] = {step = "QM17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["gepardpdw"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["hk416"] = {step = "QM17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["knife4"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["kobra"] = {step = "QM01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["l115"] = {step = "QM21",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["l85"] = {step = "QM17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["lr300"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["m14"] = {step = "QM17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["m16a4"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mateba"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["microt1"] = {step = "QM03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mp5"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mp9a1"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mr96"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["p90"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["pkm"] = {step = "QM21",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["pp19"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["pp1901vityaz"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["pp2000"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["rk95"] = {step = "QM17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sg552"] = {step = "QM17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sr2"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_skat10"] = {step = "QM21",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["suit_skat9"] = {step = "QM23",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sv98"] = {step = "QM17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["svd"] = {step = "QM21",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["swmodel29"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["swr8"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["taurusragingbull"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["trg42"] = {step = "QM17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["ump45"] = {step = "QM11",
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
				"Bring the requested documentation here complete. An account of a record is insufficient for "
				.. "verifying it."
			),
			completion = "Documents received. I'll check them against the request.",
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 1,
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
			name = "The Misrouted Crate",
			kind = "field",
			objective = (
				"Recover the misrouted equipment case from the assigned search area in Waystation. Bring it back "
				.. "to the issuing contact in Waystation."
			),
			requires = {"QM03"},
			briefing = (
				"Recover the equipment case unchanged. We can establish what arrived once it is here. Recover the "
				.. "misrouted equipment case from the assigned search area in Waystation. Bring it back to me in "
				.. "Waystation."
			),
			completion = "Case received. Leave it closed until there is room to inspect the contents.",
			field = {
				description = (
					"A low hard case with long contrasting strips across its ribbed lid. Quartermaster's note: "
					.. "\"Recover the equipment case unchanged.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_equipment",
				label = "Misrouted equipment case",
			},
			benefits = {},
		},
		{
			id = "QM05",
			completionCash = 575,
			name = "Standard Issue",
			kind = "delivery",
			requires = {"QM04"},
			briefing = "The listed ammunition is required here. Verify the request before packing the delivery.",
			completion = "Delivery received against the order.",
			requirements = {
				{
					pool = "town_ammunition",
					quantity = 12,
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
				map = "mz_garbage",
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
			stock = {
				item = "545x39",
				bonus = 1,
			},
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
			name = "The Supplier's Mark",
			kind = "field",
			objective = (
				"Recover the supplier identification evidence from the assigned search area in Waystation. Bring "
				.. "it back to the issuing contact in Waystation."
			),
			requires = {"QM06"},
			briefing = (
				"Recover the supplier evidence. I need to verify which consignment the markings belong to. Recover "
				.. "the supplier identification evidence from the assigned search area in Waystation. Bring it back "
				.. "to me in Waystation."
			),
			completion = "Set it here. I'll check the identifying details before contacting anyone.",
			field = {
				description = (
					"A printed packing list on a small clipboard with a metal clip and a circular stamp. "
					.. "Quartermaster's note: \"Recover the supplier evidence.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_manifest",
				label = "Supplier identification evidence",
			},
			benefits = {},
		},
		{
			id = "QM09",
			completionCash = 875,
			name = "Fittings and Mounts",
			kind = "delivery",
			requires = {"QM07"},
			briefing = "There is another supply requirement. Similar equipment is not an agreed substitute.",
			completion = "The requested lot is here. I'll account for it.",
			requirements = {
				{
					pool = "town_ammunition_military",
					quantity = 3,
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
			crossRequires = {
				{
					contact = "old-timer",
					step = "OT12",
				},
			},
		},
		{
			id = "QM12",
			completionCash = 1450,
			name = "The Lost Agreement",
			kind = "field",
			objective = (
				"Recover the previous procurement agreement from the assigned search area in Waystation. Bring it "
				.. "back to the issuing contact in Waystation."
			),
			requires = {"QM10"},
			briefing = (
				"Recover the old contract in full. We need the obligations as written, including the inconvenient "
				.. "clauses. Recover the previous procurement agreement from the assigned search area in Waystation. "
				.. "Bring it back to me in Waystation."
			),
			completion = "Leave the pages together. I'll read the agreement before deciding which terms still apply.",
			field = {
				description = (
					"A creased printed letter with a corporate mark and several small blocks of text. Quartermaster's "
					.. "note: \"Recover the old contract in full.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_contract",
				label = "Previous procurement agreement",
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
				"Bring the listed supplies. I will check them against the requirement. Do not substitute "
				.. "your own judgement for the listed requirement. Report a difficulty while there is still "
				.. "time to address it."
			),
			completion = (
				"The quantity is correct. I will check the remainder before filing this. You may wait "
				.. "without rearranging anything on the desk."
			),
			requirements = {
				{
					pool = "town_ammunition",
					quantity = 24,
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
			name = "The Field Test",
			kind = "field",
			objective = (
				"Recover the equipment trial recording from the assigned search area in Waystation. Bring it back "
				.. "to the issuing contact in Waystation."
			),
			requires = {"QM14"},
			briefing = (
				"I need the equipment-trial recording. Readings and conditions must be considered together. "
				.. "Recover the equipment trial recording from the assigned search area in Waystation. Bring it back "
				.. "to me in Waystation."
			),
			completion = "Recording received. I'll review the complete trial before judging the equipment.",
			field = {
				description = (
					"A flat dark electronic module with a printed number and a small circular emblem. Quartermaster's "
					.. "note: \"I need the equipment-trial recording.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_module",
				label = "Equipment trial recording",
			},
			benefits = {},
		},
		{
			id = "QM17",
			completionCash = 1475,
			name = "Ready for Deployment",
			kind = "delivery",
			requires = {"QM15"},
			briefing = "Bring the listed material through intact. Keep your own operational supplies separate.",
			completion = "All requested material received.",
			requirements = {
				{
					pool = "town_ammunition",
					quantity = 36,
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
			name = "The Abandoned Stores",
			kind = "field",
			objective = (
				"Recover the abandoned stores case from the assigned search area in Pripyat. Bring it back to the "
				.. "issuing contact in Waystation."
			),
			requires = {"QM18"},
			briefing = (
				"The equipment case is still at the Pripyat supply site. Recover the case before accounting for "
				.. "its contents. Recover the abandoned stores case from the assigned search area in Pripyat. Bring "
				.. "it back to me in Waystation."
			),
			completion = "Case received. I'll inspect what survived before entering it into the account.",
			field = {
				description = (
					"A low hard case with long contrasting strips across its ribbed lid. Quartermaster's note: \"The "
					.. "equipment case is still at the Pripyat supply site.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_equipment",
				label = "Abandoned stores case",
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
				"Bring the requested documentation here complete. An account of a record is insufficient for "
				.. "verifying it."
			),
			completion = "Documents received. I'll check them against the request.",
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 2,
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
			name = "The Signed Requisition",
			kind = "field",
			objective = (
				"Recover the signed supply requisition from the assigned search area in Waystation. Bring it back "
				.. "to the issuing contact in Waystation."
			),
			requires = {"QM23"},
			briefing = (
				"Return the complete military record. An apparently favourable page is insufficient for concluding "
				.. "an agreement. Recover the signed supply requisition from the assigned search area in Waystation. "
				.. "Bring it back to me in Waystation."
			),
			completion = (
				"You've completed the work reliably. The record can be checked and the agreement considered on its "
				.. "actual terms. I appreciate that. Take the time you need before discussing another undertaking."
			),
			field = {
				description = (
					"A buff-coloured folder with loose military record sheets extending beyond its cover. "
					.. "Quartermaster's note: \"Return the complete military record.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_orders",
				label = "Signed supply requisition",
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
