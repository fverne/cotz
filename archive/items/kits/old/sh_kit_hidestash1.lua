ITEM.name = "Tourists backpack"
ITEM.description= "A backpack covered in dirt. It has something inside."
ITEM.model = "models/lostsignalproject/items/misc/backpack.mdl"
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
		{"9x18", {["quantity"] = 50}},
		{"9x19", {["quantity"] = 50}},
		{"12gauge", {["quantity"] = 50}},
		{"12gaugebd", {["quantity"] = 50}},
		{"22lr", {["quantity"] = 50}},
		{"762x25", {["quantity"] = 50}},
		{"medkit"},

	},
	itemsVeryRare = {
		{"9x18", {["quantity"] = 100}},
		{"9x19", {["quantity"] = 100}},
		{"12gauge", {["quantity"] = 50}},
		{"12gaugebd", {["quantity"] = 50}},
		{"22lr", {["quantity"] = 100}},
		{"762x25", {["quantity"] = 100}},
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