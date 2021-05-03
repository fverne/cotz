ITEM.name = "Rookie Stalkers Backpack"
ITEM.description= "A backpack covered in dirt. It has something inside."
ITEM.model = "models/lostsignalproject/items/misc/backpack.mdl"
ITEM.width = 3
ITEM.height = 3
ITEM.flag = "A"
ITEM.itemsForcedDrop = {
	{"bagrubles", {["quantity"] = 200}},
}

ITEM.items[1] = {
	dropAmount = 2,
	dropRareChance = 35,
	dropVeryRareChance = 8,
	itemsCommon = {
		{"medkit"},
		{"radio"},
		{"headlamp"},
		{"geigercounter"},
				{"9x18", {["quantity"] = 50}},
		{"9x19", {["quantity"] = 50}},
		{"12gauge", {["quantity"] = 50 }},
		{"12gaugebd", {["quantity"] = 50}},
		{"22lr", {["quantity"] = 50}},
		{"762x25", {["quantity"] = 50}},
	},
	itemsRare = {
		{"documents4"},
		{"binoculars"},
		{"hatchet"},
		{"fubar"},
		{"machete"},	
		{"fireaxe"},
		{"leadpipe"},
	},
	itemsVeryRare = {
		{"documents2"},
		{"documents0"},
		{"documents1"},
		{"documents8"},
		{"documents9"},
	},
}

ITEM.items[2] = {
	dropAmount = 1,
	dropRareChance = 35,
	dropVeryRareChance = 5,
	itemsCommon = {
		{"bagrubles", {["quantity"] = 350}},
	},
	itemsRare = {
		{"component", {["quantity"] = 40}},
	},
	itemsVeryRare = {
		{"tooloil2"},
	},
}