local SELLANDBUY = 1

ix.npctemplates.templates["ecologistnpc3"] = {
	name = "'Intern'",
	description = "You cannot make out what he looks like underneath the visor.",
	model = "models/legends/vasilev.mdl",
	skin = 0,
	bubble = 0,
	scale = 0.3,
	dialogueid = "ecologistnpc3",
	soundgroup = "ecologistnpc3",
	idleanim = "lineidle01",
	buyAll = true,
	items = {
		["anomalydetector"] = {nil, 1, SELLANDBUY, 1, 48, 1},
		["geigercounter"] = {nil, 1, SELLANDBUY, 1, 48, 1},
		["medic_psyheal_1"] = {nil, 2, SELLANDBUY, 2, 12, 1},
		["medic_antirad_1"] = {nil, 3, SELLANDBUY, 3, 12, 1},
		["medic_medkit_5"] = {4500, 3, SELLANDBUY, 3, 12, 1},
		["medic_medkit_6"] = {6500, 3, SELLANDBUY, 3, 12, 1},
		["medic_antipsychotic_1"] = {nil, 2, SELLANDBUY, 2, 12, 1},

	},
}
