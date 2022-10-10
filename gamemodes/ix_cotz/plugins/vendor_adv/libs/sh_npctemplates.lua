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
	scale 		= 0.2,
	dialogueid 	= "owlnpc",
	soundgroup 	= "TraderHello",
	--animgroup 	= 2,
	idleanim = "bandit2_idle2",
	buyAll 		= true,
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
		["12gauge"] 	= { nil, 4, SELLANDBUY, 4, 1, 1 },
		["9x18"] 	= { nil, 4, SELLANDBUY, 4, 1, 1 },
		["9x19"] 	= { nil, 3, SELLANDBUY, 3, 1, 1 },
		["762x25"] 	= { nil, 4, SELLANDBUY, 4, 1, 1 },
		["22lr"] 	= { nil, 6, SELLANDBUY, 6, 1, 1 },
		["45acp"] 	= { nil, 4, SELLANDBUY, 4, 1, 1 },
		["45acp410"] 	= { nil, 4, SELLANDBUY, 4, 1, 1 },

		["crowbar"] 	= { nil, 4, SELLANDBUY, 4, 0.5, 2 },
		["leadpipe"] 	= { nil, 4, SELLANDBUY, 4, 0.5, 2 },
		["sledgehammer"] 	= { nil, 4, SELLANDBUY, 4, 0.5, 2 },

		["backpack_1"] 	= { nil, 2, SELLANDBUY, 2, 3, 1 },
		["backpack_3"] 	= { nil, 2, SELLANDBUY, 2, 3, 1 },

		["anorak"] 	= { nil, 6, SELLANDBUY, 6, 3, 2 },

		["binoculars_2"] 	= { nil, 5, SELLANDBUY, 5, 3, 1 },
		["binoculars_5"] 	= { nil, 5, SELLANDBUY, 5, 3, 1 },

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
		["flashlight"] 	= { nil, 8, SELLANDBUY, 8, 0.10, 2 },
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

		["ruger1022"] 	= { nil, 4, SELLANDBUY, 4, 2, 1 },
		["rugermk3"] 	= { nil, 4, SELLANDBUY, 4, 2, 1 },
		["w9422"] 	= { nil, 4, SELLANDBUY, 4, 2, 1 },

		["trenchcoat"] 	= { nil, 1, SELLANDBUY, 1, 2, 1 },
		["mailjacket"] 	= { nil, 1, SELLANDBUY, 1, 2, 1 },

		["backpack_1"] 	= { nil, 1, SELLANDBUY, 1, 2, 1 },
		["backpack_1_large"] 	= { nil, 1, SELLANDBUY, 1, 2, 1 }, -- make me progression unlock?
		["backpack_3"] 	= { nil, 1, SELLANDBUY, 1, 2, 1 },
		["backpack_3_large"] 	= { nil, 1, SELLANDBUY, 1, 2, 1 }, -- make me progression unlock?

		["part_bear"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["part_blinddog"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["part_bloodsucker"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["part_boar"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["part_burer_1"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["part_burer_2"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["part_cat"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["part_chimera"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["part_controller_1"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["part_controller_2"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["part_electrocontroller"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["part_flesh"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["part_izlom"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["part_pseudodog"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["part_pseudogigant"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["part_psydog"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["part_snork_1"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["part_snork_2"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["part_sprig"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["part_swampcontroller_1"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["part_swampcontroller_2"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["part_tushkano"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["part_zombie_1"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["part_zombie_2"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["hide_blinddog"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["hide_bloodsucker"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["hide_boar"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["hide_burer"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["hide_cat"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["hide_chimera"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["hide_controller"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["hide_flesh"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["hide_pseudodog"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["hide_pseudogigant"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["hide_sprig"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["hide_swampcontroller"] 	= { 1, nil, BUYONLY, nil, nil, nil },
		["hide_tushkano"] 	= { 1, nil, BUYONLY, nil, nil, nil },
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
		["lowtiercookerfuel"] 	= { nil, 10, SELLANDBUY, 10, 1, 5 },

		["drug_cigarette_1"] 	= { nil, 15, SELLANDBUY, 15, 1, 6 },
		["drug_cigarette_2"] 	= { nil, 12, SELLANDBUY, 12, 1, 5 },
		["drug_cigarette_3"] 	= { nil, 8, SELLANDBUY, 8, 1, 4 },

		["drink_bottlebeer_1"] 	= { nil, 16, SELLANDBUY, 16, 0.5, 6 },

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
		["22lr"] 	= { nil, 10, SELLANDBUY, 15, 0.5, 6 },
		["45acp"] 	= { nil, 10, SELLANDBUY, 10, 0.5, 3 },

		["toz34short"] 	= { nil, 4, SELLANDBUY, 4, 2, 1 },
		["toz66short"] 	= { nil, 4, SELLANDBUY, 4, 2, 1 },
		["c96"] 	= { nil, 4, SELLANDBUY, 4, 2, 1 },
		["cz52"] 	= { nil, 4, SELLANDBUY, 4, 2, 1 },
		["g2contender"] 	= { nil, 4, SELLANDBUY, 4, 2, 1 },
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
		["flashlight"] 	= { nil, 10, SELLANDBUY, 10, 0.1, 2 },
		["headlamp"] 	= { nil, 10, SELLANDBUY, 10, 1, 1 },
		["geigercounter"] 	= { nil, 5, SELLANDBUY, 5, 1, 1 },
		["anomalydetector"] 	= { nil, 6, SELLANDBUY, 6, 1, 1 },
		["binoculars_2"] 	= { nil, 4, SELLANDBUY, 4, 1, 1 },
		["compass"] 	= { nil, 6, SELLANDBUY, 6, 1, 1 },
		["gpstracker"] 	= { nil, 6, SELLANDBUY, 6, 1, 1 },
	},
}

ix.npctemplates.templates["ecologistnpc"] = {
	name 		= "'Egghead'",
	description = "The coat-clad scientist looks at you with a relaxed look.",
	model 		= "models/legends/ozerskiy.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 0.4,
	dialogueid 	= "ecologistnpc",
	soundgroup 	= "ecologistnpc",
	idleanim 	= "bandit_idle2",
	--animgroup 	= 4,
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["anomalydetector"] 	= { nil, 12, SELLANDBUY, 12, 8, 12 },
		["geigercounter"] 	= { nil, 12, SELLANDBUY, 12, 8, 12 },
		["compass"] 	= { nil, 12, SELLANDBUY, 12, 8, 12 },
		["medic_psyheal_1"] 	= { nil, 6, SELLANDBUY, 6, 8, 6 },
		["medic_antirad_1"] 	= { nil, 6, SELLANDBUY, 6, 8, 6 },
		["medic_medkit_5"] 	= { 4500, 3, SELLANDBUY, 3, 8, 3 },
		["medic_medkit_6"] 	= { 6500, 3, SELLANDBUY, 3, 8, 3 },
		["halfmask"] 	= { nil, 5, SELLANDBUY, 5, 4, 2 },
		["sr2"] 	= { nil, 2, SELLANDBUY, 2, 8, 1 },
		["pp2000"] 	= { nil, 2, SELLANDBUY, 2, 8, 1 },
		["9x21"] 	= { nil, 5, SELLANDBUY, 5, 8, 5 },
		["ssp99"] 	= { nil, 1, SELLANDBUY, 1, 8, 1 },
		["gp5"] 	= { nil, 3, SELLANDBUY, 3, 8, 3 },
	},
}

ix.npctemplates.templates["bodyguardnpc"] = {
	name 		= "'Quartermaster'",
	description = "Looking at the stern gaze from the man in front of you makes you want to break eye contact.",
	model 		= "models/legends/garyk.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 0.4,
	dialogueid 	= "bodyguardnpc",
	soundgroup 	= "bodyguardnpc",
	idleanim 	= "trader_idle",
	--animgroup 	= 4,
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["9x18hp"] 	= { nil, 4, SELLANDBUY, 4, 8, 4 },
		["9x19"] 	= { nil, 8, SELLANDBUY, 8, 8, 8 },
		["9x19hp"] 	= { nil, 4, SELLANDBUY, 4, 8, 4 },
		["45acp"] 	= { nil, 8, SELLANDBUY, 8, 8, 8 },
		["357magnum"] 	= { nil, 8, SELLANDBUY, 8, 8, 8 },
		["44magnum"] 	= { nil, 8, SELLANDBUY, 8, 8, 8 },
		["762x39"] 	= { nil, 8, SELLANDBUY, 8, 8, 8 },
		["556x45"] 	= { nil, 8, SELLANDBUY, 8, 8, 8 },
		["545x39"] 	= { nil, 8, SELLANDBUY, 8, 8, 8 },
		["762x51"] 	= { nil, 8, SELLANDBUY, 8, 8, 8 },
		["762x54"] 	= { nil, 8, SELLANDBUY, 8, 8, 8 },
		["12gauge"] 	= { nil, 8, SELLANDBUY, 8, 8, 8 },
		["12gaugesg"] 	= { nil, 8, SELLANDBUY, 8, 8, 8 },
		["12gaugetr"] 	= { nil, 8, SELLANDBUY, 8, 8, 8 },
		["aks74u"] 	= { nil, 2, SELLANDBUY, 2, 8, 1 },
		["mp9a1"] 	= { nil, 2, SELLANDBUY, 2, 8, 1 },
		["sks"] 	= { nil, 2, SELLANDBUY, 2, 8, 1 },
		["pp1901vityaz"] 	= { nil, 2, SELLANDBUY, 2, 8, 1 },
		["brhp"] 	= { nil, 2, SELLANDBUY, 2, 8, 1 },
		["fort12"] 	= { nil, 2, SELLANDBUY, 2, 8, 1 },
		["mp153"] 	= { nil, 2, SELLANDBUY, 2, 8, 1 },
		["kiparis"] 	= { nil, 2, SELLANDBUY, 2, 8, 1 },
		["m1911"] 	= { nil, 2, SELLANDBUY, 2, 8, 1 },
		["stoegerdd"] 	= { nil, 2, SELLANDBUY, 2, 8, 1 },
		["taurusjudge"] 	= { nil, 2, SELLANDBUY, 2, 8, 1 },
		["swr8"] 	= { nil, 2, SELLANDBUY, 2, 8, 1 },
		["io7a"] 	= { nil, 2, SELLANDBUY, 2, 8, 1 },

		["backpack_2"] 	= { nil, 1, SELLANDBUY, 1, 2, 1 },
		["backpack_2_large"] 	= { nil, 1, SELLANDBUY, 1, 1, 1 }, -- make me progression unlock?
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
		["aek971"] 	= { nil, 1, SELLANDBUY, 1, 8, 1 },
		["asval"] 	= { nil, 1, SELLANDBUY, 1, 8, 1 },
		["f2000"] 	= { nil, 1, SELLANDBUY, 1, 8, 1 },
		["famas"] 	= { nil, 1, SELLANDBUY, 1, 8, 1 },
		["g36c"] 	= { nil, 1, SELLANDBUY, 1, 8, 1 },
		["m16a4"] 	= { nil, 1, SELLANDBUY, 1, 8, 1 },
		["saiga12"] 	= { nil, 1, SELLANDBUY, 1, 8, 1 },
		["svd"] 	= { nil, 1, SELLANDBUY, 1, 8, 1 },
		["ragingbull"] 	= { nil, 1, SELLANDBUY, 1, 8, 1 },
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

ix.npctemplates.soundtemplates["bodyguardnpc"] = {
	"npc/garyk/bar_guard_prohodi_1.ogg",
	"npc/garyk/bar_guard_stop_1.ogg",
	"npc/garyk/bar_guard_stop_3.ogg",
}

ix.npctemplates.soundtemplates["computer_beep"] = {
	"ambient/levels/labs/equipment_beep_loop1.wav",
	"ambient/levels/canals/generator_ambience_loop1.wav",
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
