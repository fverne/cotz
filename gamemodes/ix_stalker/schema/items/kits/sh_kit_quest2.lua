ITEM.name = "Small plastic crate"
ITEM.description= "A small plastic crate, rewarded for completing a quest. Something is inside."
ITEM.model = "models/kek1ch/safe_container.mdl"
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
		{"pda"},
		{"9x18zl", {["quantity"] = 50}},
		{"9x19zl", {["quantity"] = 50}},
		{"12gaugezl", {["quantity"] = 50 }},
		{"12gaugebd", {["quantity"] = 50}},
		{"22lrzl", {["quantity"] = 50}},
		{"762x25zl", {["quantity"] = 50}},
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
		{"tooloil2"},
	},
	itemsRare = {
		{"component", {["quantity"] = 20}},
	},
	itemsVeryRare = {
		{"bagrubles", {["quantity"] = 350}},
	},
}

ITEM.items[3] = {
	dropAmount = 1,
	dropRareChance = 35,
	dropVeryRareChance = 5,
	itemsCommon = {
		{"rugermk3"},
		{"cz52"},
	},
	itemsRare = {
		{"tokarev"},
		{"ruger1022"},	
	},
	itemsVeryRare = {
		{"makarov"},
		{"sawnoff"},
		{"toz34short"},
	},
}