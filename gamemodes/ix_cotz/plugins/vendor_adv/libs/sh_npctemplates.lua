ix.npctemplates = {}
ix.npctemplates.templates = {}
ix.npctemplates.soundtemplates = {}
ix.npctemplates.animtemplates = {}
ix.npctemplates.animtemplatestranslation = {}

local SELLANDBUY 	= 1
local SELLONLY 	= 2
local BUYONLY 	= 3

ix.npctemplates.animtemplatestranslation[1] = "TestAnimations"
ix.npctemplates.animtemplatestranslation[2] = "Bartrader"
ix.npctemplates.animtemplatestranslation[3] = "Guard"
ix.npctemplates.animtemplatestranslation[4] = "sitchair"
ix.npctemplates.animtemplatestranslation[5] = "banditidle"
ix.npctemplates.animtemplatestranslation[6] = "monolithidle"
ix.npctemplates.animtemplatestranslation[7] = "idle_idle"

ix.npctemplates.templates["owlnpc"] = {
	name 		= "'Cleaner'",
	description = "A bulky man. He looks at you with disdain.",
	model 		= "models/legends/chich.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 0.3,
	dialogueid 	= "owlnpc",
	soundgroup 	= "TraderHello",
	--animgroup 	= 2,
	idleanim = "bandit2_idle2",
	buyAll 		= true,
	items = {
		["12gauge"] 	= { nil, 4, SELLANDBUY, 4, 1, 2 },
		["9x18"] 	= { nil, 4, SELLANDBUY, 4, 1, 2 },
		["9x19"] 	= { nil, 3, SELLANDBUY, 3, 1, 2 },
		["762x25"] 	= { nil, 4, SELLANDBUY, 4, 1, 2 },
		["22lr"] 	= { nil, 6, SELLANDBUY, 6, 1, 2 },
		["45acp"] 	= { nil, 4, SELLANDBUY, 4, 1, 2 },
		["45acp41"] 	= { nil, 4, SELLANDBUY, 4, 1, 2 },
		
		["mask_halfmask"] 	= { 25000, 10, SELLONLY, 10, 1, 10 }, -- expensive on purpose
		["mask_gp5"] 	= { 60000, 10, SELLONLY, 10, 1, 10 }, -- expensive on purpose
	},
}

ix.npctemplates.templates["technpc"] = {
	name 		= "'Technut'",
	description = "A weak man, his tone is very overjoyous.",
	model 		= "models/legends/griyc.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 0.4,
	dialogueid 	= "technpc",
	soundgroup 	= "GenericHello",
	idleanim 	= "trader_idle2",
	--animgroup 	= 4,
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		-- ["12gauge"] 	= { nil, 4, SELLANDBUY, 4, 1, 2 },
		-- ["9x18"] 	= { nil, 4, SELLANDBUY, 4, 1, 2 },
		-- ["9x19"] 	= { nil, 3, SELLANDBUY, 3, 1, 2 },
		-- ["762x25"] 	= { nil, 4, SELLANDBUY, 4, 1, 2 },
		["22lr"] 	= { nil, 15, SELLANDBUY, 15, 1, 6 },
		["45acp"] 	= { nil, 10, SELLANDBUY, 10, 1, 3 },
		["45acp41"] 	= { nil, 10, SELLANDBUY, 10, 1, 6 },

		["ruger1022"] 	= { nil, 4, SELLANDBUY, 4, 2, 1 },
		["rugermk3"] 	= { nil, 4, SELLANDBUY, 4, 2, 1 },
		["w9422"] 	= { nil, 4, SELLANDBUY, 4, 2, 1 },
		["sako85varmint"] 	= { nil, 4, SELLANDBUY, 4, 2, 1 },
		["nagantrev"] 	= { nil, 4, SELLANDBUY, 4, 2, 1 },
		["g2contender"] 	= { nil, 4, SELLANDBUY, 4, 2, 1 },
		["mp18"] 	= { nil, 4, SELLANDBUY, 4, 2, 1 },
		["toz106"] 	= { nil, 4, SELLANDBUY, 4, 2, 1 },

		["crowbar"] 	= { nil, 4, SELLANDBUY, 4, 0.5, 2 },
		["leadpipe"] 	= { nil, 4, SELLANDBUY, 4, 0.5, 2 },
		["sledgehammer"] 	= { nil, 4, SELLANDBUY, 4, 0.5, 2 },

		["headwear_riot"] 	= { nil, 6, SELLANDBUY, 6, 3, 2 },
		["helm_tanker"] 	= { nil, 6, SELLANDBUY, 6, 3, 2 },
		["mask_cloth"] 		= {nil, 10, SELLONLY, 10, 1, 10 },
		["suit_anorak"] 	= { nil, 6, SELLANDBUY, 6, 3, 2 },

		["food_nuts_1"] 	= { nil, 20, SELLANDBUY, 20, 12, 5 },
	},
}

ix.npctemplates.templates["tutorialnpc"] = {
	name 		= "'Old Timer'",
	description = "An older, but experienced looking man. He has a stern look on his face.",
	model 		= "models/legends/shram.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 0.4,
	dialogueid 	= "tutorialnpc",
	soundgroup 	= "TutorialNpc",
	idleanim 	= "idle_lider",
	--animgroup 	= 4,
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		-- ["flashlight"] 	= { nil, 8, SELLANDBUY, 8, 0.10, 2 },
		["headlamp"] 	= { nil, 3, SELLANDBUY, 3, 1, 1 },
		["geigercounter"] 	= { nil, 5, SELLANDBUY, 5, 1, 1 },

		["medic_bandage_1"] = { nil, 12, SELLANDBUY, 12, 1, 1 },
		["medic_bandage_2"] = { nil, 6, SELLANDBUY, 6, 1, 1 },

		["drug_tobacco_1"] 	= { nil, 2, SELLANDBUY, 2, 1, 1 },
		["drug_cigarette_1"] 	= { nil, 6, SELLANDBUY, 6, 1, 3 },
		["drug_cigarette_2"] 	= { nil, 6, SELLANDBUY, 6, 1, 3 },

		["drink_vodka_2"] 	= { nil, 8, SELLANDBUY, 8, 1, 8 },
		["drink_bottlebeer_3"] 	= { nil, 6, SELLANDBUY, 6, 1, 3 },
		["drink_canbeer_1"] 	= { nil, 12, SELLANDBUY, 12, 1, 8 },
		["drink_canbeer_2"] 	= { nil, 12, SELLANDBUY, 12, 1, 8 },
		["drink_bottlewaterdirty"] 	= { nil, 10, SELLANDBUY, 10, 0.5, 5 },

		["food_oldmeat"] 	= { nil, 2, SELLANDBUY, 2, 0.1, 2 },
		["food_can_tushonka"] 	= { 110, 2, SELLANDBUY, 2, 4, 2 },
		["food_can_sprats"] 	= { 130, 2, SELLANDBUY, 2, 4, 2 },

		["knife1"] 	= { nil, 6, SELLANDBUY, 6, 8, 3 },
		["hidestasher_cutlery"] 	= { nil, 6, SELLANDBUY, 6, 8, 3 },
		["lowtiercooker"] 	= { nil, 3, SELLANDBUY, 3, 8, 3 },
		["lowtiercookerfuel"] 	= { nil, 20, SELLANDBUY, 20, 2, 15 },

		["part_bear"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_blinddog"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_bloodsucker"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_boar"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_burer_1"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_burer_2"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_cat"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_chimera"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_controller_1"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_controller_2"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_electrocontroller_1"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_electrocontroller_2"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_flesh"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_izlom"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_hellhound"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_karlik_1"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_karlik_2"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_pseudodog"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_pseudogiant"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_psydog"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_skeleton"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_snork_1"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_snork_2"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_spider"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_sprig"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_swampcontroller_1"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_swampcontroller_2"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_tark"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_tushkano"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_vareshka"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_zombie_1"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_zombie_2"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_blinddog"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_bloodsucker"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_bear"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_boar"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_burer"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_cat"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_chimera"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_controller"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_electrocontroller"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_flesh"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_karlik"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_pseudodog"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_pseudogiant"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_spider"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_sprig"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_swampcontroller"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_tushkano"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_tark"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_vareshka"] 	= { nil, nil, BUYONLY, nil, nil, nil },
	},
}

ix.npctemplates.templates["cooknpc"] = {
	name 		= "'Spicy Lemon'",
	description = "A large man. He has a confident smirk on his face, and smells of a mix of spices and sweat.",
	model 		= "models/legends/makar.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 0.4,
	dialogueid 	= "cooknpc",
	soundgroup 	= "CookNpc",
	idleanim 	= "doctor_idle",
	--animgroup 	= 4,
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["lowtiercooker"] 	= { nil, 2, SELLANDBUY, 2, 1, 2 },
		["lowtiercookerfuel"] 	= { nil, 40, SELLANDBUY, 40, 1, 20 },

		["drug_cigarette_1"] 	= { nil, 5, SELLANDBUY, 5, 1, 5 },
		["drug_cigarette_2"] 	= { nil, 4, SELLANDBUY, 4, 1, 4 },
		-- ["drug_cigarette_3"] 	= { nil, 3, SELLANDBUY, 3, 1, 3 },

		["drink_bottlebeer_1"] 	= { nil, 16, SELLANDBUY, 16, 0.5, 6 },

		["drink_canbeer_1"] 	= { nil, 3, SELLANDBUY, 3, 1, 3 },
		["drink_canbeer_2"] 	= { nil, 3, SELLANDBUY, 3, 1, 3 },

		["drink_bottletea"] 	= { nil, 6, SELLANDBUY, 6, 1, 4 },
		["drink_bottlewater"] 	= { nil, 24, SELLANDBUY, 24, 0.5, 6 },

		["drink_vodka_1"] 	= { nil, 4, SELLANDBUY, 4, 1, 3 },
		["drink_vodka_2"] 	= { nil, 8, SELLANDBUY, 8, 1, 8 },
		["drink_vodka_3"] 	= { nil, 4, SELLANDBUY, 4, 1, 3 },

        ["food_bread"] 	= { nil, 20, SELLANDBUY, 20, 1, 5 },
        ["food_nuts_1"] 	= { nil, 40, SELLANDBUY, 40, 1, 5 },
        ["food_oldmeat"] 	= { nil, 10, SELLANDBUY, 10, 1, 5 },
        ["food_sausage_1"] 	= { nil, 10, SELLANDBUY, 10, 1, 5 },
        ["food_can_sprats"] 	= { nil, 3, SELLANDBUY, 3, 1, 3 },

		--[[
		["meat_blinddog"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["meat_bloodsucker"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["meat_boar"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["meat_burer"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["meat_cat"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["meat_chimera"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["meat_flesh"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["meat_hellhound"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["meat_human"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["meat_pseudodog"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["meat_sprig"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["meat_tushkano"] 	= { nil, nil, BUYONLY, nil, nil, nil },

		["meal_blinddog"] 	= { nil, 0, SELLANDBUY, 2, nil, 1 },
		["meal_bloodsucker"] 	= { nil, 0, SELLANDBUY, 2, nil, 1 },
		["meal_boar"] 	= { nil, 0, SELLANDBUY, 2, nil, 1 },
		["meal_burer"] 	= { nil, 0, SELLANDBUY, 2, nil, 1 },
		["meal_cat"] 	= { nil, 0, SELLANDBUY, 2, nil, 1 },
		["meal_chimera"] 	= { nil, 0, SELLANDBUY, 2, nil, 1 },
		["meal_flesh"] 	= { nil, 0, SELLANDBUY, 2, nil, 1 },
		["meal_hellhound"] 	= { nil, 0, SELLANDBUY, 2, nil, 1 },
		["meal_human"] 	= { nil, 0, SELLANDBUY, 2, nil, 1 },
		["meal_pseudodog"] 	= { nil, 0, SELLANDBUY, 2, nil, 1 },
		["meal_sprig"] 	= { nil, 0, SELLANDBUY, 2, nil, 1 },
		["meal_tushkano"] 	= { nil, 0, SELLANDBUY, 2, nil, 1 },
		]]
	},
}

ix.npctemplates.templates["tradernpc"] = {
	name 		= "'Haggler'",
	description = "The man before you is of larger stature. He has a wild look in his eyes.",
	model 		= "models/legends/krohobor.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 0.4,
	dialogueid 	= "tradernpc",
	soundgroup 	= "GenericGuard",
	idleanim 	= "bandit2_idle2",
	animgroup 	= 5,
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["762x25"] 	= { nil, 10, SELLANDBUY, 10, 0.5, 3 },
		["9x18"] 	= { nil, 10, SELLANDBUY, 10, 0.5, 3 },
		["12gauge"] = { nil, 10, SELLANDBUY, 10, 0.5, 3 },
		["762x54"] 	= { nil, 10, SELLANDBUY, 10, 0.5, 3 },
		["762x39"] 	= { nil, 10, SELLANDBUY, 10, 0.5, 3 },
		["556x45"] 	= { nil, 10, SELLANDBUY, 10, 0.5, 3 },
		["545x39"] 	= { nil, 10, SELLANDBUY, 10, 0.5, 3 },
		["22lr"] 	= { nil, 15, SELLANDBUY, 15, 0.5, 6 },
		["45acp"] 	= { nil, 10, SELLANDBUY, 10, 0.5, 3 },
		["45acp41"] 	= { nil, 10, SELLANDBUY, 10, 0.5, 6 },

		["ij600"] 	= { nil, 4, SELLANDBUY, 4, 2, 1 },
		["mp27"] 	= { nil, 4, SELLANDBUY, 4, 2, 1 },
		["c96"] 	= { nil, 4, SELLANDBUY, 4, 2, 1 },
		["cz52"] 	= { nil, 4, SELLANDBUY, 4, 2, 1 },
		["makarov"] 	= { nil, 4, SELLANDBUY, 4, 2, 1 },
		["tokarev"] 	= { nil, 4, SELLANDBUY, 4, 2, 1 },
		["m1917"] 	= { nil, 4, SELLANDBUY, 4, 2, 1 },
		["skorpion"] 	= { nil, 4, SELLANDBUY, 4, 2, 1 },
		["obrez"] 	= { nil, 4, SELLANDBUY, 4, 2, 1 },
	},
}

ix.npctemplates.templates["stalkernetnpc"] = {
	name 		= "'Mute'",
	description = "The man in front of you is of frail structure. You cannot get eye contact with him.",
	model 		= "models/legends/petruha.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 0.4,
	dialogueid 	= "stalkernetadmin",
	soundgroup 	= "nosound",
	idleanim 	= "doctor_idle",
	--animgroup 	= 4,
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		-- ["flashlight"] 	= { nil, 10, SELLANDBUY, 10, 0.1, 2 },
		["headlamp"] 	= { nil, 10, SELLANDBUY, 10, 1, 1 },
		["geigercounter"] 	= { nil, 5, SELLANDBUY, 5, 1, 1 },
		["binoculars_5"] 	= { nil, 4, SELLANDBUY, 4, 1, 1 },
		["compass"] 	= { nil, 6, SELLANDBUY, 6, 1, 1 },
		["gpstracker"] 	= { nil, 6, SELLANDBUY, 6, 1, 1 },
		["guitar"] 	= { nil, 1, SELLANDBUY, 1, 8, 1 },
	},
}

ix.npctemplates.templates["ecologistnpc"] = {
	name 		= "'Egghead'",
	description = "The coat-clad scientist looks at you with a relaxed look.",
	model 		= "models/legends/ozerskiy.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 0.6,
	dialogueid 	= "ecologistnpc",
	soundgroup 	= "ecologistnpc",
	idleanim 	= "bandit_idle2",
	--animgroup 	= 4,
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["quest_computeraccess"] 	= { nil, 2, SELLANDBUY, 2, 6, 2 },

		["part_bear"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_blinddog"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_bloodsucker"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_boar"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_burer_1"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_burer_2"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_cat"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_chimera"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_controller_1"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_controller_2"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_electrocontroller_1"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_electrocontroller_2"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_flesh"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_izlom"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_hellhound"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_karlik_1"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_karlik_2"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_pseudodog"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_pseudogiant"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_psydog"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_skeleton"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_snork_1"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_snork_2"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_spider"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_sprig"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_swampcontroller_1"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_swampcontroller_2"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_tark"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_tushkano"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_vareshka"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_zombie_1"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_zombie_2"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_blinddog"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_bloodsucker"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_bear"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_boar"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_burer"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_cat"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_chimera"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_controller"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_electrocontroller"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_flesh"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_karlik"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_pseudodog"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_pseudogiant"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_spider"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_sprig"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_swampcontroller"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_tushkano"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_tark"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_vareshka"] 	= { nil, nil, BUYONLY, nil, nil, nil },

		["artifact_arachno"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_battery"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_blowncap"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_bolt"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_bonecluster"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_capacitor"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_cell"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_crystal"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_droplet"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_dwarfgalaxy"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_eye"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_flame"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_flash"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_gaia"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_galaxy"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_gmamasbeads"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_halo"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_kolobok"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_mamasbeads"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_mementomori"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_mica"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_midas"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_moonlight"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_mycelia"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_panacea"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_slime"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_slug"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_sparkler"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_thorn"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_urchin"] = { nil, nil, BUYONLY, nil, nil, nil },
	},
}

ix.npctemplates.templates["ecologistnpc2"] = {
	name 		= "'Beanstalk'",
	description = "The figure gives you a concerned look.",
	model 		= "models/legends/sokolov2.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 0.5,
	dialogueid 	= "ecologistnpc2",
	soundgroup 	= "ecologistnpc2",
	idleanim 	= "idle_lider",
	--animgroup 	= 4,
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["headwear_screen"] 	= { nil, 5, SELLANDBUY, 5, 4, 2 },

		["pp2000"] 	= { nil, 2, SELLANDBUY, 2, 8, 1 },
		["9x21"] 	= { nil, 5, SELLANDBUY, 5, 8, 5 },
	},
}

ix.npctemplates.templates["ecologistnpc3"] = {
	name 		= "'Intern'",
	description = "You cannot make out what he looks like underneath the visor.",
	model 		= "models/legends/vasilev.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 0.3,
	dialogueid 	= "ecologistnpc3",
	soundgroup 	= "ecologistnpc3",
	idleanim 	= "lineidle01",
	buyAll 		= true,
	--animgroup 	= 4,
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["anomalydetector"] 	= { nil, 12, SELLANDBUY, 12, 8, 12 },
		["geigercounter"] 	= { nil, 12, SELLANDBUY, 12, 8, 12 },
		["medic_psyheal_1"] 	= { nil, 6, SELLANDBUY, 6, 8, 6 },
		["medic_antirad_1"] 	= { nil, 6, SELLANDBUY, 6, 8, 6 },
		["medic_medkit_5"] 	= { 4500, 3, SELLANDBUY, 3, 8, 3 },
		["medic_medkit_6"] 	= { 6500, 3, SELLANDBUY, 3, 8, 3 },
		["medic_antipsychotic_1"] 	= { nil, 6, SELLANDBUY, 6, 8, 6 },

	},
}

ix.npctemplates.templates["unisgnpc"] = {
	name 		= "'Quartermaster'",
	description = "Looking at the stern gaze from the man in front of you makes you want to break eye contact.",
	model 		= "models/mirotvor/mirotvor3.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 0.3,
	dialogueid 	= "unisgnpc",
	soundgroup 	= "unisgnpc",
	idleanim 	= "pistolidle2",
	buyAll 		= true,
	--animgroup 	= 4,
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["9x18"] 	= { nil, 4, SELLANDBUY, 4, 2, 4 },
		["9x18hp"] 	= { nil, 4, SELLANDBUY, 4, 2, 4 },
		["9x19"] 	= { nil, 8, SELLANDBUY, 8, 2, 8 },
		["9x19hp"] 	= { nil, 4, SELLANDBUY, 4, 2, 4 },
		["9x21"] 	= { nil, 4, SELLANDBUY, 4, 2, 4 },
		["45acp"] 	= { nil, 8, SELLANDBUY, 8, 2, 8 },
		["357magnum"] 	= { nil, 8, SELLANDBUY, 8, 2, 8 },
		["44magnum"] 	= { nil, 8, SELLANDBUY, 8, 2, 8 },
		["762x39"] 	= { nil, 8, SELLANDBUY, 8, 2, 8 },
		["556x45"] 	= { nil, 8, SELLANDBUY, 8, 2, 8 },
		["545x39"] 	= { nil, 8, SELLANDBUY, 8, 2, 8 },
		["762x51"] 	= { nil, 8, SELLANDBUY, 8, 2, 8 },
		["762x54"] 	= { nil, 8, SELLANDBUY, 8, 2, 8 },
		["12gauge"] 	= { nil, 8, SELLANDBUY, 8, 2, 8 },
		["12gaugesg"] 	= { nil, 8, SELLANDBUY, 8, 2, 8 },
		["9x39"] 	= { nil, 4, SELLANDBUY, 4, 2, 4 },
		["57x28"] 	= { nil, 4, SELLANDBUY, 4, 2, 4 },
		["50ae"] 	= { nil, 4, SELLANDBUY, 4, 2, 4 },


		["glock17"] 	= { nil, 2, SELLANDBUY, 2, 2, 1 },
		["ar159mm"] 	= { nil, 2, SELLANDBUY, 2, 2, 1 },
		["mp5k"] 	= { nil, 2, SELLANDBUY, 2, 2, 1 },
		["pp2000"] 	= { nil, 2, SELLANDBUY, 2, 2, 1 },

		["stoegerdd"] 	= { nil, 2, SELLANDBUY, 2, 2, 1 },
		["stoegerddshort"] 	= { nil, 2, SELLANDBUY, 2, 2, 1 },
		["m3supershort"] 	= { nil, 2, SELLANDBUY, 2, 2, 1 },
		
		["beretta92"] 	= { nil, 2, SELLANDBUY, 2, 2, 1 },
		["p99"] 	= { nil, 2, SELLANDBUY, 2, 2, 1 },
	},
}

ix.npctemplates.templates["unisgnpc2"] = {
	name 		= "'Boss'",
	description = "The figure radiates authority.",
	model 		= "models/mirotvor/mirotvor7.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 0.3,
	dialogueid 	= "unisgnpc2",
	soundgroup 	= "unisgnpc2",
	idleanim 	= "idle_lider",
	--animgroup 	= 4,
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["9x18hp"] 	= { nil, 4, SELLANDBUY, 4, 2, 4 },
		["9x19"] 	= { nil, 8, SELLANDBUY, 8, 2, 8 },
		["9x19hp"] 	= { nil, 4, SELLANDBUY, 4, 2, 4 },
		["45acp"] 	= { nil, 8, SELLANDBUY, 8, 2, 8 },
		["357magnum"] 	= { nil, 8, SELLANDBUY, 8, 2, 8 },
		["44magnum"] 	= { nil, 8, SELLANDBUY, 8, 2, 8 },
		["762x39"] 	= { nil, 8, SELLANDBUY, 8, 2, 8 },
		["556x45"] 	= { nil, 8, SELLANDBUY, 8, 2, 8 },
		["545x39"] 	= { nil, 8, SELLANDBUY, 8, 2, 8 },
		["762x51"] 	= { nil, 8, SELLANDBUY, 8, 2, 8 },
		["762x54"] 	= { nil, 8, SELLANDBUY, 8, 2, 8 },
		["12gauge"] 	= { nil, 8, SELLANDBUY, 8, 2, 8 },
		["12gaugesg"] 	= { nil, 8, SELLANDBUY, 8, 2, 8 },
		["12gaugetr"] 	= { nil, 8, SELLANDBUY, 8, 2, 8 },
		-- ["suit_io7a"] 	= { nil, 2, SELLANDBUY, 2, 2, 1 },
		["headwear_altyn"] 	= { nil, 6, SELLANDBUY, 6, 3, 2 },
	},
}

ix.npctemplates.templates["unisgnpc3"] = {
	name 		= "'Smartass'",
	description = "The man smirks behind the visor.",
	model 		= "models/mirotvor/mirotvor2.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 0.5,
	dialogueid 	= "unisgnpc3",
	soundgroup 	= "unisgnpc3",
	idleanim 	= "sidit3",
	--animgroup 	= 4,
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["part_bear"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_blinddog"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_bloodsucker"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_boar"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_burer_1"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_burer_2"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_cat"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_chimera"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_controller_1"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_controller_2"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_electrocontroller_1"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_electrocontroller_2"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_flesh"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_izlom"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_hellhound"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_karlik_1"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_karlik_2"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_pseudodog"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_pseudogiant"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_psydog"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_skeleton"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_snork_1"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_snork_2"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_spider"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_sprig"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_swampcontroller_1"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_swampcontroller_2"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_tark"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_tushkano"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_vareshka"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_zombie_1"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["part_zombie_2"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_blinddog"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_bloodsucker"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_bear"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_boar"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_burer"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_cat"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_chimera"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_controller"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_electrocontroller"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_flesh"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_karlik"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_pseudodog"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_pseudogiant"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_spider"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_sprig"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_swampcontroller"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_tushkano"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_tark"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["hide_vareshka"] 	= { nil, nil, BUYONLY, nil, nil, nil },

		["artifact_arachno"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_battery"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_blowncap"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_bolt"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_bonecluster"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_capacitor"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_cell"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_crystal"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_droplet"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_dwarfgalaxy"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_eye"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_flame"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_flash"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_gaia"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_galaxy"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_gmamasbeads"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_halo"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_kolobok"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_mamasbeads"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_mementomori"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_mica"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_midas"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_moonlight"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_mycelia"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_panacea"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_slime"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_slug"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_sparkler"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_thorn"] = { nil, nil, BUYONLY, nil, nil, nil },
		["artifact_urchin"] = { nil, nil, BUYONLY, nil, nil, nil },
	},
}

ix.npctemplates.templates["raritynpc"] = {
	name 		= "'Hoarder'",
	description = "The person moves in complete silence.",
	model 		= "models/legends/black3.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 0.4,
	dialogueid 	= "raritynpc",
	soundgroup 	= "nosound",
	idleanim 	= "trans_idle2",
	animgroup 	= 6,
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["500magnum"] 	= { nil, 6, SELLANDBUY, 6, 2, 6 },
		["50ae"] 	= { nil, 6, SELLANDBUY, 6, 2, 6 },
		["57x28mm"] 	= { nil, 6, SELLANDBUY, 6, 2, 6 },
		["93x64"] 	= { nil, 6, SELLANDBUY, 6, 2, 6 },
		["127x55"] 	= { nil, 6, SELLANDBUY, 6, 2, 6 },
		["145x114"] 	= { nil, 6, SELLANDBUY, 6, 2, 6 },
		["700nitro"] 	= { nil, 6, SELLANDBUY, 6, 2, 6 },
		["338lapua"] 	= { nil, 6, SELLANDBUY, 6, 2, 6 },
		["12gaugemg"] 	= { nil, 6, SELLANDBUY, 6, 2, 6 },
		["12gaugedt"] 	= { nil, 6, SELLANDBUY, 6, 2, 6 },
	},
}

ix.npctemplates.templates["computernpc"] = {
	name 		= "'Computer'",
	description = "The computer buzzes and beeps intermittently.",
	model 		= "models/props_lab/servers.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 0.4,
	dialogueid 	= "computernpc",
	soundgroup 	= "computer_beep",
	idleanim 	= "idle",
	animgroup 	= 7,
	items = {
	},
}

ix.npctemplates.templates["medicnpc"] = {
	name 		= "'Jitters'",
	description = "He jitters a bit.",
	model 		= "models/legends/feldsher.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 0.3,
	dialogueid 	= "medicnpc",
	soundgroup 	= "medicnpc",
	idleanim 	= "sidit",
	buyAll 		= false,
	--animgroup 	= 4,
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["medic_bandage_1"] 	= { nil, 4, SELLANDBUY, 4, 2, 4 },

	},
}


ix.npctemplates.templates["technpc2"] = {
	name 		= "'Tinker'",
	description = "A free man.",
	model 		= "models/legends/freeman.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 0.3,
	dialogueid 	= "tinkernpc",
	soundgroup 	= "technpc2",
	idleanim 	= "trader_idle",
	buyAll 		= false,
	--animgroup 	= 4,
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["value_nuts"] 	= { nil, 4, SELLANDBUY, 4, 2, 4 },

	},
}

ix.npctemplates.templates["cconnpc"] = {
	name 		= "'???'",
	description = "An entity of the noosphere.",
	model 		= "models/legends/klikoso.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 0.3,
	dialogueid 	= "cconnpc",
	soundgroup 	= "cconnpc",
	idleanim 	= "trader_idle",
	buyAll 		= false,
	--animgroup 	= 4,
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }

	},
}

-- No sounds emitted
ix.npctemplates.soundtemplates["nosound"] = {
	"stalkersound/inv_nosound.mp3",
}

ix.npctemplates.soundtemplates["GenericHello"] = {
	"npc/beta/stalker_talk_1.ogg",
	"npc/beta/stalker_talk_2.ogg",
	"npc/beta/stalker_talk_3.ogg",
	"npc/beta/stalker_talk_4.ogg",
}

ix.npctemplates.soundtemplates["GenericIdle"] = {
	"npc/hunter/idle_12.ogg",
	"npc/hunter/idle_19.ogg",
	"npc/hunter/idle_17.ogg",
	"npc/hunter/idle_16.ogg",
}

ix.npctemplates.soundtemplates["GenericGuard"] = {
	"npc/bandit/meet_comander_start_1.ogg",
	"npc/bandit/meet_comander_start_2.ogg",
	"npc/bandit/meet_comander_start_3.ogg",
}

ix.npctemplates.soundtemplates["TraderHello"] = {
	"npc/barman/bar_barman_hello_1.ogg",
	"npc/barman/bar_barman_hello_2.ogg",
	"npc/barman/bar_barman_hello_3.ogg",
	"npc/barman/bar_barman_hello_4.ogg",
	"npc/barman/bar_barman_hello_5.ogg"
}

ix.npctemplates.soundtemplates["TutorialNpc"] = {
	"npc/shram/idle_16.ogg",
	"npc/shram/search_13.ogg",
	"npc/shram/idle_18.ogg",
	"npc/shram/idle_20.ogg",
	"npc/shram/idle_4.ogg"
}

ix.npctemplates.soundtemplates["CookNpc"] = {
	"npc/lesnik/red_forester_meet_hello_0.ogg",
	"npc/lesnik/red_forester_meet_hello_1.ogg",
	"npc/lesnik/red_forester_meet_hello_2.ogg",
	"npc/lesnik/red_forester_greet_1.ogg",
    "npc/lesnik/red_forester_hello_bye_0.ogg",
    "npc/lesnik/red_forester_hello_bye_1.ogg",
}

ix.npctemplates.soundtemplates["ecologistnpc"] = {
	"npc/doctor/idle_12.ogg",
	"npc/doctor/idle_13.ogg",
	"npc/doctor/idle_14.ogg",
	"npc/doctor/idle_15.ogg",
	"npc/doctor/idle_16.ogg",
	"npc/doctor/idle_17.ogg",
	"npc/doctor/idle_18.ogg",
	"npc/doctor/idle_19.ogg",
}

ix.npctemplates.soundtemplates["ecologistnpc2"] = {
	"npc/lebed/mar_csky_leader_meet_greet_1.ogg",
	"npc/lebed/mar_csky_leader_meet_greet_2.ogg",
	"npc/lebed/mar_csky_leader_meet_greet_3.ogg",
	"npc/lebed/mar_csky_leader_meet_greet_4.ogg",
}

ix.npctemplates.soundtemplates["ecologistnpc3"] = {
	"npc/ecolog/idle_2.ogg",
	"npc/ecolog/idle_3.ogg",
	"npc/ecolog/idle_4.ogg",
	"npc/ecolog/idle_5.ogg",
	"npc/ecolog/idle_6.ogg",
	"npc/ecolog/idle_7.ogg",
}

ix.npctemplates.soundtemplates["unisgnpc"] = {
	"npc/bariga/stalker_trade_1.ogg",
	"npc/bariga/stalker_trade_12.ogg",
	"npc/bariga/stalker_trade_13.ogg",
	"npc/bariga/stalker_trade_14.ogg",
	"npc/bariga/stalker_trade_15.ogg",
}

ix.npctemplates.soundtemplates["unisgnpc2"] = {
	"npc/beta/soldier_replics_1.ogg",
	"npc/beta/soldier_replics_2.ogg",
	"npc/beta/soldier_replics_3.ogg",
}

ix.npctemplates.soundtemplates["unisgnpc3"] = {
	"npc/digger_m/interes_1.ogg",
	"npc/digger_m/interes_2.ogg",
	"npc/digger_m/interes_5.ogg",
	"npc/digger_m/interes_6.ogg",
}

ix.npctemplates.soundtemplates["medicnpc"] = {
	"npc/suslov/mar_csky_doctor_hello_dialog_0.ogg",
	"npc/suslov/mar_csky_doctor_meet_greet_1.ogg",
	"npc/suslov/mar_csky_doctor_meet_greet_2.ogg",
	"npc/suslov/mar_csky_doctor_meet_greet_3.ogg",
}

ix.npctemplates.soundtemplates["technpc2"] = {
	"npc/suslov/mar_csky_tech_meet_greet_1.ogg",
	"npc/suslov/mar_csky_tech_meet_greet_2.ogg",
	"npc/suslov/mar_csky_tech_meet_greet_3.ogg",
}

ix.npctemplates.soundtemplates["computer_beep"] = {
	"ambient/levels/labs/equipment_beep_loop1.wav",
	"ambient/levels/canals/generator_ambience_loop1.wav",
}

ix.npctemplates.soundtemplates["cconnpc"] = {
	"monolith/monolith_call_1.ogg",
	"monolith/monolith_call_2.ogg",
	"monolith/monolith_call_3.ogg",
	"monolith/monolith_call_4.ogg",
	"monolith/monolith_call_5.ogg",
	"monolith/monolith_call_6.ogg",
	"monolith/monolith_call_7.ogg",
	"monolith/monolith_call_8.ogg",
}

ix.npctemplates.animtemplates["TestAnimations"] = {
	"bandit2_idle1",
	"bandit2_idle3",
}

ix.npctemplates.animtemplates["Bartrader"] = {
	"trader_idle2",
}

ix.npctemplates.animtemplates["ecotrader"] = {
	"bandit_idle2",
}

ix.npctemplates.animtemplates["Guard"] = {
	"hello_idle",
}

ix.npctemplates.animtemplates["sitchair"] = {
	"sidit2",
}

ix.npctemplates.animtemplates["banditidle"] = {
	"bandit2_idle1",
	"bandit2_idle3"
}

ix.npctemplates.animtemplates["monolithidle"] = {
	"trans_idle3",
}

ix.npctemplates.animtemplates["idle_idle"] = {
	"idle",
}
