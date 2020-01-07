ITEM.name = "Tourists backpack"
ITEM.description= "A backpack covered in dirt. It has something inside."
ITEM.model = "models/kek1ch/dev_rukzak.mdl"
ITEM.width = 3
ITEM.height = 3
ITEM.flag = "A"
ITEM.itemsForcedDrop = {
	{"bagrubles", {["quantity"] = 100}},
}
ITEM.weight = 5

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
		{"bagrubles", {["quantity"] = 250}},
	},
	itemsRare = {
		{"component", {["quantity"] = 20}},
	},
	itemsVeryRare = {
		{"tooloil1"},
	},
}