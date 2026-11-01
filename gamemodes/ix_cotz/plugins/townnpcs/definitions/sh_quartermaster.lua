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
	dialogue = {
		delivery = "Place the consignment here for inspection.",
		completedGreeting = "The agreement stands. Keep your end of it and we'll keep ours.",
		workPrompt = "About the assignments.",
		offerPrompt = "Do you have an assignment?",
		work = "Ammunition deliveries. Correct calibre, correct quantity. Check the order.",
		progressionPrompt = "What else needs doing?",
		progression = "Requisitions and missing supply records. Read what is needed before committing yourself.",
	},
	catalogue = {
		["aek971"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["aimpoint"] = {step = "QM03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["ak12"] = {step = "QM17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["ak74"] = {step = "QM07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["an94k"] = {step = "QM13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["aug"] = {step = "QM09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["eotech"] = {step = "QM03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["famas"] = {step = "QM07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["fiveseven"] = {step = "QM07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["fnfal"] = {step = "QM13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["foregrip"] = {step = "QM01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["g36c"] = {step = "QM13",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["knife4"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["kobra"] = {step = "QM01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["l85"] = {step = "QM09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["lax44"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["lr300"] = {step = "QM09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["m16a4"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["m3super90"] = {step = "QM05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mateba"] = {step = "QM05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["microt1"] = {step = "QM03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mossberg500"] = {step = "QM03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mp153"] = {step = "QM07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mp5"] = {step = "QM01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mp9a1"] = {step = "QM05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mr96"] = {step = "QM05",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["nitro"] = {step = "QM23",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["p90"] = {step = "QM11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["pp1901vityaz"] = {step = "QM09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["rem870ae"] = {step = "QM03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["rk95"] = {step = "QM15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sg552"] = {step = "QM15",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sv98"] = {step = "QM07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["svd"] = {step = "QM09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["sw500"] = {step = "QM21",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["swr8"] = {step = "QM01",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["taurusragingbull"] = {step = "QM03",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["ump45"] = {step = "QM09",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["uzi"] = {step = "QM07",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["vssk"] = {step = "QM23",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "QM01",
			name = "A Supplier's Credentials",
			kind = "delivery",
			requires = {},
			briefing = "Bring the listed supplies. I will check them against the requirement.",
			completion = "The quantity is correct.",
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
			name = "The Missing Requisition",
			kind = "field",
			objective = "Recover Military Records Folder I from the assigned search area in Waystation. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"QM01"},
			briefing = "Recover a procurement record in Waystation territory.",
			completion = "Hand over the case and its records.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_orders",
				label = "The Missing Requisition - Military Records Folder I",
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
			id = "QM03",
			name = "On the Register",
			kind = "tracker",
			requires = {"QM02"},
			briefing = "Ammunition deliveries. Correct calibre, correct quantity. Check the order.",
			completion = "Your deliveries have been consistent. I can make further equipment available as agreed.",
			target = 2,
			benefits = {
				items = {
					{
						item = "9x19",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "QM04",
			name = "The Misrouted Crate",
			kind = "field",
			objective = "Recover Striped Equipment Case from the assigned search area in Waystation. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"QM03"},
			briefing = "Recover a sealed equipment case on a regional route.",
			completion = "I will compare it with the requisition.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_equipment",
				label = "The Misrouted Crate - Striped Equipment Case",
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
			id = "QM05",
			name = "Standard Issue",
			kind = "delivery",
			requires = {"QM04"},
			briefing = "Bring the listed supplies. I will check them against the requirement.",
			completion = "Accepted. Put it with the stores.",
			requirements = {
				{
					pool = "town_ammunition",
					quantity = 12,
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
			id = "QM06",
			name = "The Depot Copy",
			kind = "field",
			objective = "Recover Warehouse Packing List B from the assigned search area in Garbage. Deliver it to"
				.. " 'Brass' in Garbage, then return here to finish the assignment.",
			requires = {"QM04"},
			briefing = "Retrieve a depot register in Garbage.",
			completion = "Receipt confirmed. The consignment is accounted for.",
			field = {
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_receipt",
				label = "The Depot Copy - Warehouse Packing List B",
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
			name = "Enough for the Patrol",
			kind = "tracker",
			requires = {"QM05"},
			briefing = "Ammunition deliveries. Correct calibre, correct quantity. Check the order.",
			completion = "Your deliveries have been consistent. I can make further equipment available as agreed.",
			target = 5,
			benefits = {
				items = {
					{
						item = "9x19",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "QM08",
			name = "The Supplier's Mark",
			kind = "field",
			objective = "Recover Warehouse Packing List A from the assigned search area in Waystation. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"QM06"},
			briefing = "Recover supplier evidence from an abandoned freight site.",
			completion = "Hand over the case and its records.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 1,
				cargo = "town_quest_manifest",
				label = "The Supplier's Mark - Warehouse Packing List A",
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
			id = "QM09",
			name = "Fittings and Mounts",
			kind = "delivery",
			requires = {"QM07"},
			briefing = "Bring the listed supplies. I will check them against the requirement.",
			completion = "That meets the requirement.",
			requirements = {
				{
					pool = "town_ammunition_military",
					quantity = 3,
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
			id = "QM10",
			name = "The Returned Equipment",
			kind = "field",
			objective = "Recover Official File Folder from the assigned search area in Waystation. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"QM08"},
			briefing = "Recover a field inspection record in Waystation territory.",
			completion = "I will compare it with the requisition.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_official",
				label = "The Returned Equipment - Official File Folder",
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
			id = "QM11",
			name = "Steel Earned",
			kind = "tracker",
			requires = {"QM09"},
			briefing = "Ammunition deliveries. Correct calibre, correct quantity. Check the order.",
			completion = "Your deliveries have been consistent. I can make further equipment available as agreed.",
			target = 9,
			benefits = {
				items = {
					{
						item = "9x19",
						data = {
							quantity = 1,
						},
					},
				},
			},
			crossRequires = {
				{
					contact = "old-timer",
					step = "OT12",
				},
			},
		},
		{
			id = "QM12",
			name = "The Lost Agreement",
			kind = "field",
			objective = "Recover Corporate Letter from the assigned search area in Waystation. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"QM10"},
			briefing = "Recover the old procurement contract.",
			completion = "Received. Wait while I check the markings.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_contract",
				label = "The Lost Agreement - Corporate Letter",
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
			name = "More Than One Role",
			kind = "delivery",
			requires = {"QM11"},
			briefing = "Bring the listed supplies. I will check them against the requirement.",
			completion = "The quantity is correct.",
			requirements = {
				{
					pool = "town_ammunition",
					quantity = 24,
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
			id = "QM14",
			name = "The Wrong Model",
			kind = "field",
			objective = "Recover Military Records Folder II from the assigned search area in Waystation. Deliver it"
				.. " to 'Latch' in Garbage, then return here to finish the assignment.",
			requires = {"QM12"},
			briefing = "Recover a serial-number record for a diverted shipment.",
			completion = "Receipt confirmed. The consignment is accounted for.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_military",
				label = "The Wrong Model - Military Records Folder II",
				recipient = "latch",
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
			id = "QM15",
			name = "A Dependable Reserve",
			kind = "tracker",
			requires = {"QM13"},
			briefing = "Ammunition deliveries. Correct calibre, correct quantity. Check the order.",
			completion = "Your deliveries have been consistent. I can make further equipment available as agreed.",
			target = 14,
			benefits = {
				items = {
					{
						item = "9x19",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "QM16",
			name = "The Field Test",
			kind = "field",
			objective = "Recover Numbered Data Module 0013 from the assigned search area in Waystation. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"QM14"},
			briefing = "Retrieve an equipment-trial recorder from a remote site.",
			completion = "I will compare it with the requisition.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_module",
				label = "The Field Test - Numbered Data Module 0013",
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
			id = "QM17",
			name = "Ready for Deployment",
			kind = "delivery",
			requires = {"QM15"},
			briefing = "Bring the listed supplies. I will check them against the requirement.",
			completion = "Accepted. Put it with the stores.",
			requirements = {
				{
					pool = "town_ammunition",
					quantity = 36,
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
			id = "QM18",
			name = "The Pripyat Manifest",
			kind = "field",
			objective = "Recover Warehouse Packing List A from the assigned search area in Pripyat. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"QM16"},
			briefing = "Recover expedition supply records in Pripyat.",
			completion = "Received. Wait while I check the markings.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_manifest",
				label = "The Pripyat Manifest - Warehouse Packing List A",
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
			name = "Kept Supplied",
			kind = "tracker",
			requires = {"QM17"},
			briefing = "Ammunition deliveries. Correct calibre, correct quantity. Check the order.",
			completion = "Your deliveries have been consistent. I can make further equipment available as agreed.",
			target = 20,
			benefits = {
				items = {
					{
						item = "9x19",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "QM20",
			name = "The Abandoned Stores",
			kind = "field",
			objective = "Recover Striped Equipment Case from the assigned search area in Pripyat. Return it to this"
				.. " contact to finish the assignment.",
			requires = {"QM18"},
			briefing = "Recover an equipment case at a Pripyat supply site.",
			completion = "Hand over the case and its records.",
			field = {
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_equipment",
				label = "The Abandoned Stores - Striped Equipment Case",
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
			id = "QM21",
			name = "Procurement Evidence",
			kind = "delivery",
			requires = {"QM19", "QM20"},
			briefing = "Bring the listed supplies. I will check them against the requirement.",
			completion = "That meets the requirement.",
			requirements = {
				{
					pool = "administrative_documents",
					quantity = 2,
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
			id = "QM22",
			name = "The Contractor's Copy",
			kind = "field",
			objective = "Recover Corporate Letter from the assigned search area in Waystation. Deliver it to 'Carbon'"
				.. " in Waystation, then return here to finish the assignment.",
			requires = {"QM21"},
			briefing = "Recover the supply agreement's surviving annex.",
			completion = "Receipt confirmed. The consignment is accounted for.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_contract",
				label = "The Contractor's Copy - Corporate Letter",
				recipient = "carbon",
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
				bonus = 2,
			},
		},
		{
			id = "QM23",
			name = "A Standing Agreement",
			kind = "tracker",
			requires = {"QM22"},
			briefing = "Ammunition deliveries. Correct calibre, correct quantity. Check the order.",
			completion = "Your deliveries have been consistent. I can make further equipment available as agreed.",
			target = 27,
			benefits = {
				items = {
					{
						item = "9x19",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "QM24",
			name = "The Signed Requisition",
			kind = "field",
			objective = "Recover Military Records Folder I from the assigned search area in Waystation. Return it to"
				.. " this contact to finish the assignment.",
			requires = {"QM23"},
			briefing = "Retrieve the agreement's last field record and return.",
			completion = "Received. Wait while I check the markings.",
			field = {
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_orders",
				label = "The Signed Requisition - Military Records Folder I",
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
