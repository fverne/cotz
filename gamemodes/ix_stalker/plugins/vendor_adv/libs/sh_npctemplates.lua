ix.npctemplates = {}
ix.npctemplates.templates = {}
ix.npctemplates.soundtemplates = {}
ix.npctemplates.animtemplates = {}
ix.npctemplates.animtemplatestranslation = {}

local BUYSELL 	= 1
local SELLONLY 	= 2
local BUYONLY 	= 3

ix.npctemplates.animtemplatestranslation[1] = "TestAnimations"
ix.npctemplates.animtemplatestranslation[2] = "Bartrader"
ix.npctemplates.animtemplatestranslation[3] = "Guard"
ix.npctemplates.animtemplatestranslation[4] = "testtech"

ix.npctemplates.templates["testtech"] = {
	name 		= "Screwdriver",
	description = "A bearded, lonely man. He looks displeased..",
	model 		= "models/legends/griyc.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 1.0,
	dialogueid 	= "testtech",
	soundgroup 	= "GenericHello",
	idleanim 	= "sidit",
	animgroup 	= 4,
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["12gauge"] 	= { 20, 2, SELLONLY, 4, 0.25, 2 },
		["22lr"] 		= { 10, 1, SELLONLY, 2, 0.10, 1 },
	},
}

ix.npctemplates.templates["testcook"] = {
	name 		= "Greaser",
	description = "A bearded, lonely man. He looks displeased..",
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
	--animgroup 	= 2,
	idleanim = "trader_idle",
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["12gauge"] 	= { 20, 2, SELLONLY, 4, 0.25, 2 },
		["22lr"] 		= { 10, 1, SELLONLY, 2, 0.10, 1 },
	},
}

ix.npctemplates.templates["Barmantest2"] = {
	name 		= "Sorter",
	description = "A bulky man. He looks at you with disdain.",
	model 		= "models/legends/chich.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 1.0,
	dialogueid 	= "tradertest",
	soundgroup 	= "TraderHello",
	--animgroup 	= 2,
	idleanim = "sidit2",
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["12gauge"] 	= { 20, 2, SELLONLY, 4, 0.25, 2 },
		["22lr"] 		= { 10, 1, SELLONLY, 2, 0.10, 1 },
		["sunrise"] 	= { 15000, 1, SELLONLY, 2, 0.10, 1 },
		["toz66short"] 	= { 1600, 1, SELLONLY, 2, 0.10, 1 },
		["ak74"] 	= { 7400, 1, SELLONLY, 2, 0.10, 1 },
		["io7a"] 	= { 2000, 2, SELLONLY, 4, 0.25, 2 },
		["lowtiercookerfuel"] 	= { 400, 2, BUYONLY, 4, 0.25, 2 },
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