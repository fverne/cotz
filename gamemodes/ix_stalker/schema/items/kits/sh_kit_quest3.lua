ITEM.name = "Small metal crate"
ITEM.description= "A small metal crate, rewarded for completing a quest. Something is inside."
ITEM.model = "models/lostsignalproject/items/quest/toolkit_drug.mdl"
ITEM.width = 3
ITEM.height = 3
ITEM.flag = "A"
ITEM.itemsForcedDrop = {
	{"bagrubles", {["quantity"] = 350}},
}

ITEM.items[1] = {
	dropAmount = 3,
	dropRareChance = 35,
	dropVeryRareChance = 5,
	itemsCommon = {
		{"9x18zl", {["quantity"] = 50}},
		{"9x19zl", {["quantity"] = 50}},
		{"12gaugezl", {["quantity"] = 50}},
		{"12gaugebd", {["quantity"] = 50}},
		{"22lrzl", {["quantity"] = 50}},
		{"762x25zl", {["quantity"] = 50}},
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
		{"halfmask"},
		{"trenchcoat"},
		{"mailjacket"},
	},
}

ITEM.items[2] = {
	dropAmount = 1,
	dropRareChance = 35,
	dropVeryRareChance = 5,
	itemsCommon = {
		{"tooloil2"},
	},
	itemsRare = {
		{"component", {["quantity"] = 35}},
	},
	itemsVeryRare = {
		{"bagrubles", {["quantity"] = 400}},
	},
}

ITEM.items[3] = {
	dropAmount = 1,
	dropRareChance = 35,
	dropVeryRareChance = 5,
	itemsCommon = {
		{"tokarev"},
		{"ruger1022"},
	},
	itemsRare = {
		{"sawnoff"},
		{"toz34short"},	
		{"makarov"},		
	},
	itemsVeryRare = {
		{"toz66"},
		{"toz34"},
		{"m3supershort"},
	},
}