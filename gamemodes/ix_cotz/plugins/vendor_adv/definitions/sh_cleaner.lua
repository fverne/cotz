local SELLANDBUY = 1
local SELLONLY = 2

ix.npctemplates.templates["owlnpc"] = {
	name = "'Cleaner'",
	description = "A bulky man. He looks at you with disdain.",
	model = "models/legends/chich.mdl",
	skin = 0,
	bubble = 0,
	scale = 0.3,
	dialogueid = "owlnpc",
	soundgroup = "TraderHello",
	idleanim = "bandit2_idle2",
	buyAll = true,
	items = {
		["12gauge"] = {nil, 4, SELLANDBUY, 4, 12, 1},
		["9x18"] = {nil, 4, SELLANDBUY, 4, 12, 1},
		["9x19"] = {nil, 4, SELLANDBUY, 4, 12, 1},
		["762x25"] = {nil, 4, SELLANDBUY, 4, 12, 1},
		["22lr"] = {nil, 4, SELLANDBUY, 4, 12, 1},
		["45acp"] = {nil, 4, SELLANDBUY, 4, 12, 1},
		["45acp41"] = {nil, 4, SELLANDBUY, 4, 12, 1},

		["mask_halfmask"] = {25000, 1, SELLONLY, 1, 48, 1}, -- expensive on purpose
		["mask_gp5"] = {60000, 1, SELLONLY, 1, 48, 1}, -- expensive on purpose
	},
}
