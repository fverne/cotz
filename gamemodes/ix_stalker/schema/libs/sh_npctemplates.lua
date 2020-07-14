ix.npctemplates = {}
ix.npctemplates.templates = {}
ix.npctemplates.soundtemplates = {}
ix.npctemplates.animtemplates = {}

local BUYSELL 	= 1
local SELLONLY 	= 2
local BUYONLY 	= 3


ix.npctemplates.templates["Sidorovich"] = {
	name 		= "Sidorovich",
	description = "A squat, fat man. He looks displeased.",
	model 		= "models/kleiner.mdl",
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
	"stalkersound/pain1.wav",
	"stalkersound/pain2.wav",
	"stalkersound/pain3.wav",
	"stalkersound/pain4.wav",
	"stalkersound/pain5.wav",
	"stalkersound/pain6.wav",
	"stalkersound/pain7.wav",
	"stalkersound/pain8.wav",
	"stalkersound/pain9.wav",
	"stalkersound/pain10.wav",
	"stalkersound/pain11.wav",
	"stalkersound/pain12.wav",
}

ix.npctemplates.animtemplates["TestAnimations"] = {
	"sprint_all",
	"ss_alyx_move",
	"typinggesture",
	"seafloor_poses",
	"wave",
	"wave_close",
	"welder_loop",
}