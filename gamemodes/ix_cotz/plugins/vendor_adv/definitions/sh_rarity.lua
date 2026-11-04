local SELLANDBUY = 1

ix.npctemplates.templates["raritynpc"] = {
	name = "'Hoarder'",
	description = "The person moves in complete silence.",
	model = "models/legends/black3.mdl",
	skin = 0,
	bubble = 0,
	scale = 0.4,
	dialogueid = "raritynpc",
	soundgroup = "nosound",
	idleanim = "trans_idle2",
	animgroup = 6,
	items = {
		["500magnum"] = {nil, 4, SELLANDBUY, 4, 12, 1},
		["50ae"] = {nil, 4, SELLANDBUY, 4, 12, 1},
		["57x28"] = {nil, 4, SELLANDBUY, 4, 12, 1},
		["93x64"] = {nil, 4, SELLANDBUY, 4, 12, 1},
		["127x55"] = {nil, 4, SELLANDBUY, 4, 12, 1},
		["145x114"] = {nil, 4, SELLANDBUY, 4, 12, 1},
		["700nitro"] = {nil, 4, SELLANDBUY, 4, 12, 1},
		["338lapua"] = {nil, 4, SELLANDBUY, 4, 12, 1},
		["12gaugemg"] = {nil, 4, SELLANDBUY, 4, 12, 1},
		["12gaugedt"] = {nil, 4, SELLANDBUY, 4, 12, 1},
	},
}
