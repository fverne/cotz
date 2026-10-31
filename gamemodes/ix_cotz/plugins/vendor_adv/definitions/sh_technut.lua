local SELLANDBUY = 1
local SELLONLY = 2

ix.npctemplates.templates["technpc"] = {
	name = "'Technut'",
	description = "A weak man, his tone is very overjoyous.",
	model = "models/legends/griyc.mdl",
	skin = 0,
	bubble = 0,
	scale = 0.4,
	dialogueid = "technpc",
	soundgroup = "GenericHello",
	idleanim = "trader_idle2",
	items = {
		["22lr"] = {nil, 4, SELLANDBUY, 4, 12, 1},
		["45acp"] = {nil, 4, SELLANDBUY, 4, 12, 1},
		["45acp41"] = {nil, 4, SELLANDBUY, 4, 12, 1},

		["ruger1022"] = {nil, 1, SELLANDBUY, 1, 48, 1},
		["rugermk3"] = {nil, 1, SELLANDBUY, 1, 48, 1},
		["w9422"] = {nil, 1, SELLANDBUY, 1, 48, 1},
		["sako85varmint"] = {nil, 1, SELLANDBUY, 1, 48, 1},
		["nagantrev"] = {nil, 1, SELLANDBUY, 1, 48, 1},
		["g2contender"] = {nil, 1, SELLANDBUY, 1, 48, 1},
		["mp18"] = {nil, 1, SELLANDBUY, 1, 48, 1},
		["toz106"] = {nil, 1, SELLANDBUY, 1, 48, 1},

		["crowbar"] = {nil, 1, SELLANDBUY, 1, 48, 1},
		["leadpipe"] = {nil, 1, SELLANDBUY, 1, 48, 1},
		["sledgehammer"] = {nil, 1, SELLANDBUY, 1, 48, 1},

		["headwear_riot"] = {nil, 1, SELLANDBUY, 1, 48, 1},
		["helm_tanker"] = {nil, 1, SELLANDBUY, 1, 48, 1},
		["mask_cloth"] = {nil, 1, SELLONLY, 1, 48, 1},
		["suit_anorak"] = {nil, 1, SELLANDBUY, 1, 48, 1},

		["food_nuts_1"] = {nil, 4, SELLANDBUY, 4, 12, 1},
	},
}
