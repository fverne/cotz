local SELLONLY = 2

ix.npctemplates.templates["arenanpc"] = {
	name = "'Arena Master'",
	description = "You are met with a relaxed gaze as you approach.",
	model = "models/legends/garyk.mdl",
	skin = 0,
	bubble = 0,
	scale = 0.3,
	dialogueid = "arenanpc",
	soundgroup = "nosound",
	idleanim = "trader_idle",
	items = {
		["medic_medkit_1"] = {nil, 3, SELLONLY, 3, 12, 1},
	},
}
