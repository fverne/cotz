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
ix.npctemplates.animtemplatestranslation[4] = "testtech"

ix.npctemplates.templates["testcook"] = {
	name 		= "Greaser",
	description = "A bearded, lonely man. He looks displeased.",
	model 		= "models/legends/krohobor.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 1.0,
	dialogueid 	= "testcook",
	soundgroup 	= "GenericHello",
	idleanim 	= "trader_idle",
	--animgroup 	= 4,
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["12gauge"] 	= { 20, 2, SELLONLY, 4, 0.25, 2 },
		["22lr"] 		= { 10, 1, SELLONLY, 2, 0.10, 1 },
	},
}

ix.npctemplates.templates["Barmantest"] = {
	name 		= "Flake",
	description = "A skinny, tall man. He has a stern look on his face.",
	model 		= "models/legends/capitan.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 1.0,
	dialogueid 	= "universalunion",
	soundgroup 	= "nosound",
	buyAll 		= true,
	--animgroup 	= 2,
	idleanim = "trader_idle",
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["12gauge"] 	= { 20, 2, SELLONLY, 4, 0.25, 2 },
		["22lr"] 		= { 10, 1, SELLONLY, 2, 0.10, 1 },
	},
}

ix.npctemplates.templates["Stalkertest1"] = {
	name 		= "Pussy",
	description = "A frail stalker. He has a worried look on his face.",
	model 		= "models/legends/kostoprav.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 1.0,
	dialogueid 	= "generictest",
	soundgroup 	= "GenericIdle",
	--animgroup 	= 1,
	idleanim = "sidit3",
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["tea"] 	= { 20, 2, SELLONLY, 4, 0.25, 2 },
		["skinningknife1"] 		= { 10, 1, SELLONLY, 2, 0.10, 1 },
	},
}

ix.npctemplates.templates["Stalkertestguard"] = {
	name 		= "Godfather",
	description = "You can smell this man as you get close to him. The look on his face tells you he means business.",
	model 		= "models/legends/kastet.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 1.0,
	dialogueid 	= "universalunion",
	soundgroup 	= "GenericGuard",
	animgroup 	= 3,
	idleanim = "pistolidle1",
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["12gauge"] 	= { 20, 2, SELLONLY, 4, 0.25, 2 },
		["22lr"] 		= { 10, 1, SELLONLY, 2, 0.10, 1 },
	},
}

ix.npctemplates.templates["Stalkertestguard2"] = {
	name 		= "Babysitter",
	description = "The guy gives you such an angry look, you are compelled to break eye contact, despite his very young face.",
	model 		= "models/legends/garyk.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 1.0,
	dialogueid 	= "guardtest",
	soundgroup 	= "nosound",
	animgroup 	= 1,
	idleanim = "bandit2_idle2",
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["12gauge"] 	= { 20, 2, SELLONLY, 4, 0.25, 2 },
		["22lr"] 		= { 10, 1, SELLONLY, 2, 0.10, 1 },
	},
}

ix.npctemplates.templates["TaskNPCTest"] = {
	name 		= "Sneed",
	description = "Feeds and seeds.",
	model 		= "models/legends/kostoprav.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 1.0,
	dialogueid 	= "tasknpctest",
	soundgroup 	= "nosound",
	animgroup 	= 1,
	idleanim = "sidit3",
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["12gauge"] 	= { 20, 2, SELLONLY, 4, 0.25, 2 },
		["22lr"] 		= { 10, 1, SELLONLY, 2, 0.10, 1 },
	},
}

ix.npctemplates.templates["TechNPCTest"] = {
	name 		= "Chuck",
	description = "Fucks and sucks.",
	model 		= "models/legends/kastet.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 1.0,
	dialogueid 	= "techtest",
	soundgroup 	= "nosound",
	animgroup 	= 1,
	idleanim = "pistolidle1",
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["12gauge"] 	= { 20, 2, SELLONLY, 4, 0.25, 2 },
		["22lr"] 		= { 10, 1, SELLONLY, 2, 0.10, 1 },
	},
}

ix.npctemplates.templates["TraderNPCTest"] = {
	name 		= "Sorter",
	description = "A bulky man. He looks at you with disdain.",
	model 		= "models/legends/chich.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 0.5,
	dialogueid 	= "tradertest",
	soundgroup 	= "TraderHello",
	--animgroup 	= 2,
	idleanim = "bandit2_idle2",
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["g2contender"] 	= { nil, 2, SELLANDBUY, 2, 0.25, 1 },
		["brhp"] 		= { nil, 2, SELLANDBUY, 2, 0.10, 1 },
		["c96"] 	= { nil, 2, SELLANDBUY, 2, 0.10, 1 },
		["cz52"] 	= { nil, 2, SELLANDBUY, 2, 0.10, 1 },
		["makarov"] 	= { nil, 2, SELLANDBUY, 2, 0.10, 1 },
		["tokarev"] 	= { nil, 2, SELLANDBUY, 2, 0.25, 1 },
		["rugermk3"] 	= { nil, 2, SELLANDBUY, 2, 0.25, 1 },
		["ppsh"] 	= { nil, 2, SELLANDBUY, 2, 0.25, 1 },
		["skorpion"] 	= { nil, 2, SELLANDBUY, 2, 0.25, 1 },
		["kiparis"] 	= { nil, 2, SELLANDBUY, 2, 0.25, 1 },
		["stechaps"] 	= { nil, 2, SELLANDBUY, 2, 0.25, 1 },
		["w9422"] 	= { nil, 2, SELLANDBUY, 2, 0.25, 1 },
		["ruger1022"] 	= { nil, 2, SELLANDBUY, 2, 0.25, 1 },
		["taurusjudge"] 	= { nil, 2, SELLANDBUY, 2, 0.25, 1 },
		["m1917"] 	= { nil, 2, SELLANDBUY, 2, 0.25, 1 },
		["anaconda"] 	= { nil, 2, SELLANDBUY, 2, 0.25, 1 },
		["obrez"] 	= { nil, 2, SELLANDBUY, 2, 0.25, 1 },
		["mac11"] 	= { nil, 2, SELLANDBUY, 2, 0.25, 1 },
		["sten"] 	= { nil, 2, SELLANDBUY, 2, 0.25, 1 },
		["toz34short"] 	= { nil, 2, SELLANDBUY, 2, 0.25, 1 },
		["toz66short"] 	= { nil, 2, SELLANDBUY, 2, 0.25, 1 },
		["m3supershort"] 	= { nil, 2, SELLANDBUY, 2, 0.25, 1 },
		["toz66"] 	= { nil, 2, SELLANDBUY, 2, 0.25, 1 },
		["toz34"] 	= { nil, 2, SELLANDBUY, 2, 0.25, 1 },
		["mossberg500"] 	= { nil, 2, SELLANDBUY, 2, 0.25, 2 },
		["12gauge"] 	= { nil, 6, SELLANDBUY, 10, 0.10, 4 },
		["12gaugesg"] 	= { nil, 6, SELLANDBUY, 10, 0.10, 4 },
		["9x18"] 	= { nil, 6, SELLANDBUY, 10, 0.10, 4 },
		["9x19"] 	= { nil, 6, SELLANDBUY, 10, 0.10, 4 },
		["762x25"] 	= { nil, 6, SELLANDBUY, 10, 0.10, 10 },
		["22lr"] 	= { nil, 6, SELLANDBUY, 10, 0.10, 10 },
		["45acp"] 	= { nil, 6, SELLANDBUY, 10, 0.10, 4 },
		["44magnum"] 	= { nil, 6, SELLANDBUY, 10, 0.10, 4 },
		["762x54"] 	= { nil, 6, SELLANDBUY, 10, 0.10, 4 },

		["bat"] 		= { nil, 4, SELLANDBUY, 4, 0.10, 1 },
		["crowbar"] 	= { nil, 4, SELLANDBUY, 4, 0.10, 1 },
		["fireaxe"] 	= { nil, 4, SELLANDBUY, 4, 0.10, 1 },
		["fubar"] 	= { nil, 4, SELLANDBUY, 4, 0.10, 1 },
		["hatchet"] 	= { nil, 4, SELLANDBUY, 4, 0.10, 1 },
		["leadpipe"] 	= { nil, 4, SELLANDBUY, 4, 0.10, 1 },
		["machete"] 	= { nil, 4, SELLANDBUY, 4, 0.10, 1 },
		["sledgehammer"] 	= { nil, 4, SELLANDBUY, 4, 0.10, 1 },
	},
}

ix.npctemplates.templates["technpc"] = {
	name 		= "'Technut'",
	description = "A weak man, his tone is very overjoyous.",
	model 		= "models/legends/griyc.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 0.5,
	dialogueid 	= "technpc",
	soundgroup 	= "GenericHello",
	idleanim 	= "trader_idle2",
	--animgroup 	= 4,
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["flashlight"] 	= { nil, 10, SELLANDBUY, 10, 0.10, 2 },
		["headlamp"] 	= { nil, 10, SELLANDBUY, 10, 0.10, 2 },
		["geigercounter"] 	= { nil, 10, SELLANDBUY, 10, 0.10, 2 },
		["anomalydetector"] 	= { nil, 10, SELLANDBUY, 10, 0.10, 2 },
		["guitar"] 	= { nil, 4, SELLANDBUY, 4, 0.10, 1 },
		["harmonica"] 	= { nil, 4, SELLANDBUY, 4, 0.10, 1 },
		["diecup"] 	= { nil, 4, SELLANDBUY, 4, 0.10, 1 },
		["lowtiercooker"] 	= { nil, 4, SELLANDBUY, 4, 0.10, 1 },
		["lowtiercookerfuel"] 	= { nil, 4, SELLANDBUY, 4, 0.10, 2 },
		["drug_cigarette_1"] 	= { nil, 10, SELLANDBUY, 10, 0.10, 2 },
		["drug_cigarette_2"] 	= { nil, 10, SELLANDBUY, 10, 0.10, 2 },
		["drug_cigarette_3"] 	= { nil, 10, SELLANDBUY, 10, 0.10, 2 },
		["medic_medkit_1"] 	= { nil, 10, SELLANDBUY, 10, 0.10, 2 },
		["medic_medkit_2"] 	= { nil, 10, SELLANDBUY, 10, 0.10, 2 },
		["medic_bandage_1"] 	= { nil, 15, SELLANDBUY, 15, 0.10, 2 },
		["drink_bottlebeer_1"] 	= { nil, 6, SELLANDBUY, 6, 0.10, 2 },
		["drink_bottletea"] 	= { nil, 6, SELLANDBUY, 6, 0.10, 2 },
		["drink_bottlwater"] 	= { nil, 6, SELLANDBUY, 6, 0.10, 2 },
		["drink_vodka_1"] 	= { nil, 6, SELLANDBUY, 6, 0.10, 2 },
		["drink_vodka_2"] 	= { nil, 6, SELLANDBUY, 6, 0.10, 2 },
		["drink_vodka_3"] 	= { nil, 6, SELLANDBUY, 6, 0.10, 2 },
		["mailjacket"] 	= { nil, 1, SELLANDBUY, 2, 2, 1 },
		["trenchcoat"] 	= { nil, 1, SELLANDBUY, 2, 2, 1 },
		["halfmask"] 	= { nil, 1, SELLANDBUY, 2, 0.5, 1 },
		["steelhelmetgerman"] 	= { nil, 1, SELLANDBUY, 2, 2, 1 },
		["steelhelmetrussian"] 	= { nil, 1, SELLANDBUY, 2, 2, 1 },

		["bloodsuckerjaw"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["boarhoof"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["burershand"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["cattail"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["controllerhand"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["crowbeak"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["flesheye"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["dogtail"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["izlomhand"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["pseudodogtail"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["psydogbrain"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["snorksfoot"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["rodentshead"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["zombiehand"] 	= { nil, nil, BUYONLY, nil, nil, nil },
	},
}

ix.npctemplates.templates["tutorialnpc"] = {
	name 		= "'Old Timer'",
	description = "An older, but experienced looking man. He has a stern look on his face.",
	model 		= "models/legends/shram.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 0.1,
	dialogueid 	= "tutorialnpc",
	soundgroup 	= "TutorialNpc",
	idleanim 	= "idle_lider",
	--animgroup 	= 4,
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["flashlight"] 	= { nil, 10, SELLANDBUY, 10, 0.10, 2 },
		["headlamp"] 	= { nil, 10, SELLANDBUY, 10, 0.10, 2 },
		["geigercounter"] 	= { nil, 10, SELLANDBUY, 10, 0.10, 2 },
		["anomalydetector"] 	= { nil, 10, SELLANDBUY, 10, 0.10, 2 },
		["guitar"] 	= { nil, 4, SELLANDBUY, 4, 0.10, 1 },
		["harmonica"] 	= { nil, 4, SELLANDBUY, 4, 0.10, 1 },
		["diecup"] 	= { nil, 4, SELLANDBUY, 4, 0.10, 1 },
		["lowtiercooker"] 	= { nil, 4, SELLANDBUY, 4, 0.10, 1 },
		["lowtiercookerfuel"] 	= { nil, 4, SELLANDBUY, 4, 0.10, 2 },
		["drug_cigarette_1"] 	= { nil, 10, SELLANDBUY, 10, 0.10, 2 },
		["drug_cigarette_2"] 	= { nil, 10, SELLANDBUY, 10, 0.10, 2 },
		["drug_cigarette_3"] 	= { nil, 10, SELLANDBUY, 10, 0.10, 2 },
		["medic_medkit_1"] 	= { nil, 10, SELLANDBUY, 10, 0.10, 2 },
		["medic_medkit_2"] 	= { nil, 10, SELLANDBUY, 10, 0.10, 2 },
		["medic_bandage_1"] 	= { nil, 15, SELLANDBUY, 15, 0.10, 2 },
		["drink_bottlebeer_1"] 	= { nil, 6, SELLANDBUY, 6, 0.10, 2 },
		["drink_bottletea"] 	= { nil, 6, SELLANDBUY, 6, 0.10, 2 },
		["drink_bottlwater"] 	= { nil, 6, SELLANDBUY, 6, 0.10, 2 },
		["drink_vodka_1"] 	= { nil, 6, SELLANDBUY, 6, 0.10, 2 },
		["drink_vodka_2"] 	= { nil, 6, SELLANDBUY, 6, 0.10, 2 },
		["drink_vodka_3"] 	= { nil, 6, SELLANDBUY, 6, 0.10, 2 },
		["mailjacket"] 	= { nil, 1, SELLANDBUY, 2, 2, 1 },
		["trenchcoat"] 	= { nil, 1, SELLANDBUY, 2, 2, 1 },
		["halfmask"] 	= { nil, 1, SELLANDBUY, 2, 0.5, 1 },
		["steelhelmetgerman"] 	= { nil, 1, SELLANDBUY, 2, 2, 1 },
		["steelhelmetrussian"] 	= { nil, 1, SELLANDBUY, 2, 2, 1 },

		["bloodsuckerjaw"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["boarhoof"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["burershand"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["cattail"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["controllerhand"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["crowbeak"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["flesheye"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["dogtail"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["izlomhand"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["pseudodogtail"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["psydogbrain"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["snorksfoot"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["rodentshead"] 	= { nil, nil, BUYONLY, nil, nil, nil },
		["zombiehand"] 	= { nil, nil, BUYONLY, nil, nil, nil },
	},
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
	"npc/shram/idle_17.ogg",
	"npc/shram/idle_18.ogg",
	"npc/shram/idle_20.ogg",
	"npc/shram/idle_4.ogg"
}


ix.npctemplates.soundtemplates["nosound"] = {
	"stalkersound/inv_nosound.mp3",
}

ix.npctemplates.animtemplates["TestAnimations"] = {
	"bandit2_idle1",
	"bandit2_idle3",
}

ix.npctemplates.animtemplates["Bartrader"] = {
	"trader_idle2",
}

ix.npctemplates.animtemplates["Guard"] = {
	"hello_idle",
}

ix.npctemplates.animtemplates["testtech"] = {
	"sidit2",
}