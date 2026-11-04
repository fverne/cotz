local SELLANDBUY = 1

ix.npctemplates.templates["ecologistnpc2"] = {
	name = "'Beanstalk'",
	description = "The figure gives you a concerned look.",
	model = "models/legends/sokolov2.mdl",
	skin = 0,
	bubble = 0,
	scale = 0.5,
	dialogueid = "ecologistnpc2",
	soundgroup = "ecologistnpc2",
	idleanim = "idle_lider",
	items = {
		["headwear_screen"] = {nil, 1, SELLANDBUY, 1, 48, 1},

		["pp2000"] = {nil, 1, SELLANDBUY, 1, 48, 1},
		["9x19"] = {nil, 4, SELLANDBUY, 4, 12, 1},
		["9x21"] = {nil, 4, SELLANDBUY, 4, 12, 1},
	},
}
