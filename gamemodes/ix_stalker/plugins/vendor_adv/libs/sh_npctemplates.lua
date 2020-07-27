ix.npctemplates = {}
ix.npctemplates.templates = {}
ix.npctemplates.soundtemplates = {}
ix.npctemplates.animtemplates = {}

local BUYSELL 	= 1
local SELLONLY 	= 2
local BUYONLY 	= 3


ix.npctemplates.templates["Sidorovich"] = {
	name 		= "Sidorovich",
	description = "A bearded, lonely man. He looks displeased..",
	model 		= "models/legends/lesnik.mdl",
	skin 		= 0,
	bubble 		= 0,
	scale 		= 1.0,
	dialogueid 	= "universalunion",
	soundgroup 	= "GenericPain",
	animgroup 	= "TestAnimations",
	items = {
	-- ["uniqueid"] = { 1: Special set price, 2: Starting stock, 3: Mode [1:B/S, 2:S, 3:B], 4: Maximum stock, 5: Restock interval in hours, 6: Restock amount }
		["12gauge"] 	= { 20, 2, SELLONLY, 4, 0.25, 2 },
		["22lr"] 		= { 10, 1, SELLONLY, 2, 0.10, 1 },
	},
}




ix.npctemplates.soundtemplates["GenericPain"] = {
	"npc/barman/barman_hello1.ogg",
	"npc/barman/barman_hello2.ogg",
}

ix.npctemplates.animtemplates["TestAnimations"] = {
	"bandit2_idle1",
}