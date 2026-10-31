local SELLANDBUY = 1

ix.npctemplates.templates["firststalkernpc"] = {
	name = "'The Original'",
	description = "The first stalker in the zone.",
	model = "models/legends/freeman.mdl",
	skin = 0,
	bubble = 0,
	scale = 0.3,
	dialogueid = "firststalkernpc",
	soundgroup = "technpc2",
	idleanim = "trader_idle",
	buyAll = false,
	items = {
		["drink_vodka_2"] = {nil, 2, SELLANDBUY, 2, 12, 1},
		["drink_bottlebeer_3"] = {nil, 2, SELLANDBUY, 2, 12, 1},
		["drink_canbeer_1"] = {nil, 2, SELLANDBUY, 2, 12, 1},
		["drink_canbeer_2"] = {nil, 2, SELLANDBUY, 2, 12, 1},
		["drink_bottlewaterdirty"] = {nil, 4, SELLANDBUY, 4, 12, 1},

		["food_oldmeat"] = {nil, 4, SELLANDBUY, 4, 12, 1},
		["food_can_tushonka"] = {110, 4, SELLANDBUY, 4, 12, 1},
		["food_can_sprats"] = {130, 4, SELLANDBUY, 4, 12, 1},

		["knife1"] = {nil, 1, SELLANDBUY, 1, 48, 1},
		["hidestasher_cutlery"] = {nil, 1, SELLANDBUY, 1, 48, 1},
		["lowtiercooker"] = {nil, 1, SELLANDBUY, 1, 48, 1},
		["lowtiercookerfuel"] = {nil, 2, SELLANDBUY, 2, 12, 1},

	},
}
