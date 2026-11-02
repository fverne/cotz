PLUGIN:Register("brass", {
	name = "'Brass'",
	template = "brassnpc",
	map = "mz_garbage",
	job = {
		kind = "delivery",
		minimumValue = {1200, 2400, 4000},
		category = "Ammunition deliveries",
		description = "Ammunition deliveries",
		pools = {"town_ammunition"},
		deliveryTiers = {
			easy = {
				pools = {
					"valuables_equipment_pouches",
				},
				quantity = 1,
			},
			medium = {
				pools = {
					"valuables_military_cases",
				},
				quantity = 1,
			},
			hard = {
				pools = {
					"valuables_ordnance_salvage",
				},
				quantity = 2,
			},
		},
		quantities = {2, 4, 7},
	},
	supplies = {"12gauge", "9x18", "9x19", "medic_bandage_1"},
	rewards = {
		packages = {
			{label = "Pistol allocation",
				items = {"9x18", "9x19", "45acp"}},
			{label = "Rifle allocation",
				items = {"545x39", "556x45", "762x39", "762x51", "762x54"}},
			{label = "Specialist allocation",
				items = {"12gaugemg", "545x39ap", "556x45ap", "762x54ap"}},
		},
	},
	dialogue = {
		delivery = "Set it down. I will check the consignment against the entry.",
		completedGreeting = (
			"Good to see you. An order to discuss, or have you brought something for us to count?"
		),
		workPrompt = "About the supply order I'm filling.",
		offerPrompt = "Do you have a delivery order?",
		work = (
			"Supply orders. Ammunition, freight goods, the requested stock on the page. Check the request "
			.. "before packing, and keep different goods clearly separated. We count what arrives and settle the "
			.. "delivery against that. If something doesn't match, say so before we both waste time defending the "
			.. "wrong total."
		),
		progressionPrompt = "Which part of the depot account needs attention?",
		progression = (
			"I need supplies and the records behind some uncertain consignments. There is no benefit in "
			.. "bringing a convincing explanation without the requested material. We'll begin with work that can "
			.. "be checked here. Where another contact needs an original, deliver it and return. I want the whole "
			.. "movement accounted for."
		),
	},
	catalogue = {
		["127x55"] = {step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["12gaugedt"] = {step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["12gaugesg"] = {step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["12gaugemg"] = {step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["12gaugetr"] = {step = "BR21",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["145x114"] = {step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["145x114ap"] = {step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["145x114hp"] = {step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["22lrap"] = {step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["22lrhp"] = {step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["338lapua"] = {step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["338lapuaap"] = {step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["338lapuahp"] = {step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["357magnum"] = {step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["357magnumap"] = {step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["357magnumhp"] = {step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["44magnum"] = {step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["44magnumap"] = {step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["44magnumhp"] = {step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["45acp"] = {step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["45acpap"] = {step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["45acphp"] = {step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["45acp41"] = {step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["500magnum"] = {step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["500magnumap"] = {step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["500magnumhp"] = {step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["50ae"] = {step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["50aeap"] = {step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["50aehp"] = {step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["545x39"] = {step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["545x39ap"] = {step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["545x39hp"] = {step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["556x45"] = {step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["556x45ap"] = {step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["556x45hp"] = {step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["57x28"] = {step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["57x28ap"] = {step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["57x28hp"] = {step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["700nitro"] = {step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x25"] = {step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x25ap"] = {step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x25hp"] = {step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x39"] = {step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x39ap"] = {step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x39hp"] = {step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x51"] = {step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x51ap"] = {step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x51hp"] = {step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x54"] = {step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x54ap"] = {step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["762x54hp"] = {step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["93x64"] = {step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x18ap"] = {step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x18hp"] = {step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x19"] = {step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x19ap"] = {step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x19hp"] = {step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x21"] = {step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x21ap"] = {step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x21hp"] = {step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x39"] = {step = "BR03",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x39ap"] = {step = "BR09",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["9x39hp"] = {step = "BR15",
			terms = {nil, 2, "SELLANDBUY", 2, 12, 1}},
		["ithaca37"] = {step = "BR11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["lax410"] = {step = "BR11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["m3super90"] = {step = "BR11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mossberg500"] = {step = "BR11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["mp153"] = {step = "BR11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["rem870ae"] = {step = "BR11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["saiga12"] = {step = "BR17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["saiga410"] = {step = "BR17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["stoegerdd"] = {step = "BR11",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["striker"] = {step = "BR17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
		["toz34special"] = {step = "BR17",
			terms = {nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	progression = {
		{
			id = "BR01",
			completionCash = 275,
			name = "Count It Twice",
			kind = "delivery",
			requires = {},
			briefing = (
				"I need the ammunition specified on the list. Bring it here and we'll check the markings and "
				.. "count it together. It isn't a complicated order. I'd like us both to know exactly what's "
				.. "been handed over."
			),
			completion = (
				"The count agrees. Thank you. I'll enter it now while the boxes are in front of me, and we "
				.. "won't have to rely on either of us remembering later."
			),
			requirements = {
				{
					pool = "town_ammunition",
					quantity = 12,
				},
			},
			benefits = {
				items = {
					{
						item = "12gauge",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "BR02",
			completionCash = 450,
			name = "The Broken Seal",
			kind = "field",
			objective = (
				"Recover the depot seal register from the assigned search area in Garbage. Bring it back to the "
				.. "issuing contact in Garbage."
			),
			requires = {"BR01"},
			briefing = (
				"I need the packing record behind the broken seal. A damaged fastening doesn't tell us what was "
				.. "counted before it closed. Recover the depot seal register from the assigned search area in "
				.. "Garbage. Bring it back to me in Garbage."
			),
			completion = "The record is here. I'll compare the totals before assigning responsibility.",
			field = {
				description = (
					"A printed packing list on a small clipboard with a metal clip and a circular stamp. Brass's "
					.. "note: \"I need the packing record behind the broken seal.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_manifest",
				label = "Depot seal register",
			},
			benefits = {},
		},
		{
			id = "BR03",
			completionCash = 0,
			name = "Reliable Quantities",
			kind = "tracker",
			requires = {"BR02"},
			briefing = "Continue the supply deliveries. I want completed orders on which to base the next allocation.",
			completion = "A sound beginning. Your deliveries are accounted for.",
			target = 2,
			benefits = {},
		},
		{
			id = "BR04",
			completionCash = 650,
			name = "The Missing Boxes",
			kind = "field",
			objective = (
				"Recover the missing depot freight case from the assigned search area in Garbage. Bring it back to "
				.. "the issuing contact in Garbage."
			),
			requires = {"BR03"},
			briefing = (
				"A freight case is missing from the return. I'd like the case recovered before anyone writes its "
				.. "contents into a loss total. Recover the missing depot freight case from the assigned search area "
				.. "in Garbage. Bring it back to me in Garbage."
			),
			completion = "Set it down with the markings facing me. We'll inspect what actually came back.",
			field = {
				description = (
					"A low hard case with long contrasting strips across its ribbed lid. Brass's note: \"A freight "
					.. "case is missing from the return.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_equipment",
				label = "Missing depot freight case",
			},
			benefits = {},
		},
		{
			id = "BR05",
			completionCash = 575,
			name = "Another Chamber",
			kind = "delivery",
			requires = {"BR03"},
			briefing = "Bring the supplies specified on the order. We'll count what arrives before closing it.",
			completion = "That matches the request. Thank you.",
			requirements = {
				{
					pool = "town_ammunition",
					quantity = 12,
				},
			},
			benefits = {},
		},
		{
			id = "BR06",
			completionCash = 850,
			name = "The Depot Register",
			kind = "field",
			objective = (
				"Recover the depot inventory from the assigned search area in Garbage. Bring it back to the "
				.. "issuing contact in Garbage."
			),
			requires = {"BR04"},
			briefing = (
				"I need the depot inventory. People have been quoting totals without bringing the page they read "
				.. "them from. Recover the depot inventory from the assigned search area in Garbage. Bring it back to "
				.. "me in Garbage."
			),
			completion = "Thank you. Now I can count against the original entry.",
			field = {
				description = (
					"A clipboard carrying a densely printed packing list and a stamped mark. Brass's note: \"I need "
					.. "the depot inventory.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_receipt",
				label = "depot inventory",
			},
			benefits = {
				items = {
					{
						item = "9x18",
						data = {
							quantity = 1,
						},
					},
				},
			},
			stock = {
				item = "12gauge",
				bonus = 1,
			},
		},
		{
			id = "BR07",
			completionCash = 0,
			name = "Not One Round Short",
			kind = "tracker",
			requires = {"BR05"},
			briefing = "Keep the supply orders moving. Check the requested goods rather than guessing from the category.",
			completion = "Another run completed. The account has been straightforward.",
			target = 5,
			benefits = {},
		},
		{
			id = "BR08",
			completionCash = 1050,
			name = "The Mixed Shipment",
			kind = "field",
			objective = (
				"Recover the mislabelled consignment evidence from the assigned search area in Garbage. Bring it "
				.. "back to the issuing contact in Garbage."
			),
			requires = {"BR06"},
			briefing = (
				"There's evidence from a wrongly labelled consignment. I want to check the markings against the "
				.. "paperwork. Recover the mislabelled consignment evidence from the assigned search area in Garbage. "
				.. "Bring it back to me in Garbage."
			),
			completion = "Keep those pieces together. The mismatch is what I need to examine.",
			field = {
				description = (
					"A printed packing list on a small clipboard with a metal clip and a circular stamp. Brass's "
					.. "note: \"There's evidence from a wrongly labelled consignment.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 1,
				cargo = "town_quest_manifest",
				label = "Mislabelled consignment evidence",
			},
			benefits = {},
		},
		{
			id = "BR09",
			completionCash = 875,
			name = "Shot and Shell",
			kind = "delivery",
			requires = {"BR07"},
			briefing = "I need another delivery against this list. Keep the markings readable.",
			completion = "Received. I'll keep the count with the order.",
			requirements = {
				{
					pool = "town_ammunition",
					quantity = 24,
				},
			},
			benefits = {},
		},
		{
			id = "BR10",
			completionCash = 1250,
			name = "The Supplier's Stamp",
			kind = "field",
			objective = (
				"Recover the supplier papers for Latch from the assigned search area in Garbage. Deliver it to "
				.. "'Latch' in Garbage, then come back to the issuing contact in Garbage."
			),
			requires = {"BR08"},
			briefing = (
				"Latch needs the supplier paperwork. He can check the part details more usefully than I can repeat "
				.. "them. Recover the supplier papers for Latch from the assigned search area in Garbage. Deliver it "
				.. "to 'Latch' in Garbage, then come back to me in Garbage."
			),
			completion = "He has the papers. That should settle which specification we're discussing.",
			field = {
				description = (
					"A creased printed letter with a corporate mark and several small blocks of text. Brass's note: "
					.. "\"Latch needs the supplier paperwork.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_contract",
				label = "Supplier papers for Latch",
				recipient = "latch",
			},
			benefits = {},
		},
		{
			id = "BR11",
			completionCash = 0,
			name = "Enough for the Shift",
			kind = "tracker",
			requires = {"BR09"},
			briefing = "More delivery work when you're ready. I need quantities I can verify.",
			completion = "You've kept a reliable account. That makes the next promise easier to judge.",
			target = 9,
			benefits = {},
		},
		{
			id = "BR12",
			completionCash = 1450,
			name = "Ledger's Missing Receipt",
			kind = "field",
			objective = (
				"Recover the freight receipt for Ledger from the assigned search area in Garbage. Deliver it to "
				.. "'Ledger' in Waystation, then come back to the issuing contact in Garbage."
			),
			requires = {"BR10"},
			briefing = (
				"Ledger needs the receipt from that route. I'd like both ends of the transaction working from the "
				.. "same entry. Recover the freight receipt for Ledger from the assigned search area in Garbage. "
				.. "Deliver it to 'Ledger' in Waystation, then come back to me in Garbage."
			),
			completion = "Delivered. Good. I'll stop keeping a space for somebody else's version.",
			field = {
				description = (
					"A clipboard carrying a densely printed packing list and a stamped mark. Brass's note: \"Ledger "
					.. "needs the receipt from that route.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_receipt",
				label = "Freight receipt for Ledger",
				recipient = "ledger",
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
			id = "BR13",
			completionCash = 1175,
			name = "Rifle Stock",
			kind = "delivery",
			requires = {"BR11"},
			briefing = (
				"Check what is requested before packing. Similar packaging doesn't make the contents "
				.. "interchangeable."
			),
			completion = "The delivery checks out. You can put the empty packing aside.",
			requirements = {
				{
					pool = "town_ammunition",
					quantity = 24,
				},
			},
			benefits = {},
		},
		{
			id = "BR14",
			completionCash = 1650,
			name = "The Military Manifest",
			kind = "field",
			objective = (
				"Recover the military depot manifest from the assigned search area in Waystation. Deliver it to "
				.. "'Quartermaster' in Waystation, then come back to the issuing contact in Garbage."
			),
			requires = {"BR12"},
			briefing = (
				"Quartermaster needs the military supply record. A usable account matters more than a reassuring "
				.. "summary. Recover the military depot manifest from the assigned search area in Waystation. Deliver "
				.. "it to 'Quartermaster' in Waystation, then come back to me in Garbage."
			),
			completion = "He has the manifest. We can each check our side without borrowing a memory.",
			field = {
				description = (
					"A buff-coloured document folder with printed sheets protruding at uneven angles. Brass's note: "
					.. "\"Quartermaster needs the military supply record.\""
				),
				kind = "recovery",
				map = "rp_waystation",
				tier = 2,
				cargo = "town_quest_military",
				label = "Military depot manifest",
				recipient = "quartermaster",
			},
			benefits = {},
		},
		{
			id = "BR15",
			completionCash = 0,
			name = "A Working Depot",
			kind = "tracker",
			requires = {"BR13"},
			briefing = "Continue bringing the requested supplies. Consistency matters after the introduction as well.",
			completion = "A substantial amount of work now. Thank you for keeping it checkable.",
			target = 14,
			benefits = {},
		},
		{
			id = "BR16",
			completionCash = 1850,
			name = "The Empty Truck",
			kind = "field",
			objective = (
				"Recover the freight driver's recording from the assigned search area in Garbage. Bring it back to "
				.. "the issuing contact in Garbage."
			),
			requires = {"BR14"},
			briefing = (
				"I want the driver's recording. There may be a useful detail between the departure and the missing "
				.. "freight. Recover the freight driver's recording from the assigned search area in Garbage. Bring "
				.. "it back to me in Garbage."
			),
			completion = "I'll listen to the whole thing. No point checking an account in selected pieces.",
			field = {
				description = (
					"A pale audio cassette with a handwritten dedication above the spool windows. Brass's note: \"I "
					.. "want the driver's recording.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_tape",
				label = "Freight driver's recording",
			},
			benefits = {},
		},
		{
			id = "BR17",
			completionCash = 1475,
			name = "Specialist Loads",
			kind = "delivery",
			requires = {"BR15"},
			briefing = "Bring the listed supplies here. A smaller correct load is more useful than a larger argument.",
			completion = "Count agreed. I'll put it with the appropriate stock.",
			requirements = {
				{
					pool = "town_ammunition",
					quantity = 36,
				},
			},
			benefits = {},
		},
		{
			id = "BR18",
			completionCash = 2050,
			name = "The Pripyat Consignment",
			kind = "field",
			objective = (
				"Recover the Pripyat consignment case from the assigned search area in Pripyat. Bring it back to "
				.. "the issuing contact in Garbage."
			),
			requires = {"BR16"},
			briefing = (
				"The sealed consignment is still out in Pripyat. Bring the case as it is; the inspection can wait "
				.. "until it's here. Recover the Pripyat consignment case from the assigned search area in Pripyat. "
				.. "Bring it back to me in Garbage."
			),
			completion = "Case received. Give me room to check the fastenings.",
			field = {
				description = (
					"A low hard case with long contrasting strips across its ribbed lid. Brass's note: \"The sealed "
					.. "consignment is still out in Pripyat.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_equipment",
				label = "Pripyat consignment case",
			},
			benefits = {
				items = {
					{
						item = "9x18",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "BR19",
			completionCash = 0,
			name = "Supply Under Pressure",
			kind = "tracker",
			requires = {"BR17"},
			briefing = "Keep filling the supply orders while I reconcile the recovered records.",
			completion = "I've been able to rely on those returns. That is worth more than a persuasive estimate.",
			target = 20,
			benefits = {},
		},
		{
			id = "BR20",
			completionCash = 2250,
			name = "The Wrong Recipient",
			kind = "field",
			objective = (
				"Recover the corrected destination record from the assigned search area in Pripyat. Deliver it to "
				.. "'Ledger' in Waystation, then come back to the issuing contact in Garbage."
			),
			requires = {"BR18"},
			briefing = (
				"Ledger needs the destination record. A plausible recipient isn't necessarily the one the sender "
				.. "wrote down. Recover the corrected destination record from the assigned search area in Pripyat. "
				.. "Deliver it to 'Ledger' in Waystation, then come back to me in Garbage."
			),
			completion = "Ledger has it. If the destination needs correcting, he can do it from the record.",
			field = {
				description = (
					"A cardboard file folder with a small coloured crest on its cover. Brass's note: \"Ledger needs "
					.. "the destination record.\""
				),
				kind = "recovery",
				map = "rp_pripyat_remaster",
				tier = 3,
				cargo = "town_quest_official",
				label = "Corrected destination record",
				recipient = "ledger",
			},
			benefits = {},
		},
		{
			id = "BR21",
			completionCash = 1775,
			name = "Rounds in Reserve",
			kind = "delivery",
			requires = {"BR19", "BR20"},
			briefing = "Bring the supplies specified on the order. We'll count what arrives before closing it.",
			completion = "That matches the request. Thank you.",
			requirements = {
				{
					pool = "town_ammunition",
					quantity = 36,
				},
			},
			benefits = {},
		},
		{
			id = "BR22",
			completionCash = 2450,
			name = "The Final Receipt",
			kind = "field",
			objective = (
				"Recover the final freight receipt from the assigned search area in Garbage. Bring it back to the "
				.. "issuing contact in Garbage."
			),
			requires = {"BR21"},
			briefing = (
				"I want the last freight entry. I'd rather keep an account open a little longer than close it "
				.. "against an assumed receipt. Recover the final freight receipt from the assigned search area in "
				.. "Garbage. Bring it back to me in Garbage."
			),
			completion = "There it is. I'll reconcile the remaining entries against it.",
			field = {
				description = (
					"A clipboard carrying a densely printed packing list and a stamped mark. Brass's note: \"I want "
					.. "the last freight entry.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_receipt",
				label = "Final freight receipt",
			},
			benefits = {},
		},
		{
			id = "BR23",
			completionCash = 0,
			name = "Every Box Accounted For",
			kind = "tracker",
			requires = {"BR22"},
			briefing = "There are further supply orders to complete. Keep checking them with the same care.",
			completion = "You've stayed reliable across a long account. I appreciate it. No qualification attached.",
			target = 27,
			benefits = {},
		},
		{
			id = "BR24",
			completionCash = 2650,
			name = "The Depot's Copy",
			kind = "field",
			objective = (
				"Recover the supplier agreement letter from the assigned search area in Garbage. Bring it back to "
				.. "the issuing contact in Garbage."
			),
			requires = {"BR23"},
			briefing = (
				"The supplier's surviving letter belongs with the depot papers, including the terms nobody enjoyed "
				.. "repeating. Recover the supplier agreement letter from the assigned search area in Garbage. Bring "
				.. "it back to me in Garbage."
			),
			completion = (
				"I'll keep this with the agreement. You've given me an account I can check, and you've been paid "
				.. "for the work it took. That suits me very well."
			),
			field = {
				description = (
					"A creased printed letter with a corporate mark and several small blocks of text. Brass's note: "
					.. "\"The supplier's surviving letter belongs with the depot papers, including the terms nobody "
					.. "enjoyed repeating.\""
				),
				kind = "recovery",
				map = "mz_garbage",
				tier = 2,
				cargo = "town_quest_contract",
				label = "Supplier agreement letter",
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
			recognition = "Brass's trusted contact",
		},
	},
})
