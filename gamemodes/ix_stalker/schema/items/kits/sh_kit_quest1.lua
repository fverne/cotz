ITEM.name = "Small cloth bag"
ITEM.description= "A small bag made of cloth, rewarded for completing a quest. Something is inside."
ITEM.model = "models/lostsignalproject/items/repair/armor_repair_pro.mdl"
ITEM.width = 3
ITEM.height = 3
ITEM.flag = "A"
ITEM.itemsForcedDrop = {
	{"bagrubles", {["quantity"] = 100}},
}

ITEM.items[1] = {
	dropAmount = 2,
	dropRareChance = 35,
	dropVeryRareChance = 8,
	itemsCommon = {
		{"vodka"},
		{"cannedbeans"},
		{"cannedchilibeans"},
		{"cannedcorn"},
		{"cannedtomato"},
		{"cannedtuna"},
		{"cannedtushonka"},
		{"cannedolives"},
		{"kolbasa"},
		{"dietsausage"},
		{"bread"},
		{"water"},
	},
	itemsRare = {
		{"bandage"},
		{"cig1", {["quantity"] = 6}},
		{"caffeine", {["quantity"] = 6}},
		{"energydrink"},
		{"9x18zl", {["quantity"] = 50}},
		{"9x19zl", {["quantity"] = 50}},
		{"12gaugezl", {["quantity"] = 50}},
		{"12gaugebd", {["quantity"] = 50}},
		{"22lrzl", {["quantity"] = 50}},
		{"762x25zl", {["quantity"] = 50}},
		{"medkit"},

	},
	itemsVeryRare = {
		{"9x18zl", {["quantity"] = 100}},
		{"9x19zl", {["quantity"] = 100}},
		{"12gaugezl", {["quantity"] = 50}},
		{"12gaugebd", {["quantity"] = 50}},
		{"22lrzl", {["quantity"] = 100}},
		{"762x25zl", {["quantity"] = 100}},
		{"medkit"},
	},
}

ITEM.items[2] = {
	dropAmount = 1,
	dropRareChance = 35,
	dropVeryRareChance = 5,
	itemsCommon = {
		{"tooloil1"},
	},
	itemsRare = {
		{"component", {["quantity"] = 10}},
	},
	itemsVeryRare = {
		{"bagrubles", {["quantity"] = 250}},
	},
}

ITEM.items[3] = {
	dropAmount = 1,
	dropRareChance = 35,
	dropVeryRareChance = 5,
	itemsCommon = {
		{"bat"},
		{"crowbar"},
		{"leadpipe"},
	},
	itemsRare = {
		{"machete"},
		{"hatchet"},	
	},
	itemsVeryRare = {
		{"fireaxe"},
		{"sledgehammer"},
		{"fubar"},
	},
}