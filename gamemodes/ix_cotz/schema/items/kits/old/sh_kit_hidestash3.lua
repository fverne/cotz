ITEM.name = "Experienced stalkers backpack"
ITEM.description= "A backpack covered in dirt. It has something inside."
ITEM.model = "models/lostsignalproject/items/misc/backpack.mdl"
ITEM.width = 3
ITEM.height = 3
ITEM.flag = "A"
ITEM.itemsForcedDrop = {
	{"bagrubles", {["quantity"] = 350}},
}

ITEM.items[1] = {
	dropAmount = 3,
	dropRareChance = 35,
	dropVeryRareChance = 8,
	itemsCommon = {
		{"9x18", {["quantity"] = 50}},
		{"9x19", {["quantity"] = 50}},
		{"12gauge", {["quantity"] = 50}},
		{"12gaugebd", {["quantity"] = 50}},
		{"22lr", {["quantity"] = 50}},
		{"762x25", {["quantity"] = 50}},
		{"radio"},
		{"headlamp"},
		{"geigercounter"},
				{"hatchet"},
		{"fubar"},
		{"machete"},	
		{"fireaxe"},
		{"leadpipe"},
		{"medkit"},
	},
	itemsRare = {
		{"documents0"},
		{"documents1"},
		{"documents2"},
		{"documents8"},
		{"documents9"},
		{"binoculars"},
	},
	itemsVeryRare = {
		{"backpack1"},
		{"backpack3"},
		{"steelhelmetrussian"},
		{"steelhelmetgerman"},
	},
}

ITEM.items[2] = {
	dropAmount = 1,
	dropRareChance = 35,
	dropVeryRareChance = 5,
	itemsCommon = {
		{"bagrubles", {["quantity"] = 400}},
	},
	itemsRare = {
		{"component", {["quantity"] = 60}},
	},
	itemsVeryRare = {
		{"trenchcoat"},
		{"mailjacket"},
		{"tooloil2"},
		{"halfmask"},
	},
}