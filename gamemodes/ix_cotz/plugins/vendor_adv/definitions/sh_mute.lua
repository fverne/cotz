local SELLANDBUY = 1

ix.npctemplates.templates["stalkernetnpc"] = {
	name = "'Mute'",
	description = "The man in front of you is of frail structure. You cannot get eye contact with him.",
	model = "models/legends/petruha.mdl",
	skin = 0,
	bubble = 0,
	scale = 0.4,
	dialogueid = "stalkernetadmin",
	soundgroup = "nosound",
	idleanim = "doctor_idle",
	items = {
		["headlamp"] = {nil, 1, SELLANDBUY, 1, 48, 1},
		["geigercounter"] = {nil, 1, SELLANDBUY, 1, 48, 1},
		["binoculars_5"] = {nil, 1, SELLANDBUY, 1, 48, 1},
		["compass"] = {nil, 1, SELLANDBUY, 1, 48, 1},
		["gpstracker"] = {nil, 1, SELLANDBUY, 1, 48, 1},
		["guitar"] = {nil, 1, SELLANDBUY, 1, 48, 1},
	},
}
