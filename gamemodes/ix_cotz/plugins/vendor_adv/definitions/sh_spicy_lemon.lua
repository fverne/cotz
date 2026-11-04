local SELLANDBUY = 1
local SELLONLY = 2

ix.npctemplates.templates["cooknpc"] = {
	name = "'Spicy Lemon'",
	description = "A large man. He has a confident smirk on his face, and smells of a mix of spices and sweat.",
	model = "models/legends/makar.mdl",
	skin = 0,
	bubble = 0,
	scale = 0.4,
	dialogueid = "cooknpc",
	soundgroup = "CookNpc",
	idleanim = "doctor_idle",
	items = {
		["hightiercooker"] = {nil, 1, SELLANDBUY, 1, 48, 1},
		["value_kerosene"] = {nil, 2, SELLONLY, 2, 12, 1},

		["lowtiercookerfuel"] = {nil, 2, SELLANDBUY, 2, 12, 1},

		["drug_cigarette_1"] = {nil, 2, SELLANDBUY, 2, 12, 1},
		["drug_cigarette_2"] = {nil, 2, SELLANDBUY, 2, 12, 1},

		["drink_bottlebeer_1"] = {nil, 2, SELLANDBUY, 2, 12, 1},

		["drink_canbeer_1"] = {nil, 2, SELLANDBUY, 2, 12, 1},
		["drink_canbeer_2"] = {nil, 2, SELLANDBUY, 2, 12, 1},

		["drink_bottletea"] = {nil, 4, SELLANDBUY, 4, 12, 1},
		["drink_bottlewater"] = {nil, 4, SELLANDBUY, 4, 12, 1},

		["drink_vodka_1"] = {nil, 2, SELLANDBUY, 2, 12, 1},
		["drink_vodka_2"] = {nil, 2, SELLANDBUY, 2, 12, 1},
		["drink_vodka_3"] = {nil, 2, SELLANDBUY, 2, 12, 1},

        ["food_can_sprats"] = {200, 4, SELLANDBUY, 4, 12, 1},

        ["waterflask"] = {nil, 1, SELLANDBUY, 1, 48, 1},

	},
}
