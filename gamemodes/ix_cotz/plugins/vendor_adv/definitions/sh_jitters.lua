local SELLANDBUY = 1

ix.npctemplates.templates["medicnpc"] = {
	name = "'Jitters'",
	description = "He jitters a bit.",
	model = "models/legends/feldsher.mdl",
	skin = 0,
	bubble = 0,
	scale = 0.3,
	dialogueid = "medicnpc",
	soundgroup = "medicnpc",
	idleanim = "sidit",
	buyAll = false,
	items = {
		["medic_bandage_1"] = {nil, 3, SELLANDBUY, 3, 12, 1},

	},
}
