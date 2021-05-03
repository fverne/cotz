ITEM.name = "Event kit (OOC)"
ITEM.description= "This item is supposed to be given to people who wants to create events. Contains some items and 1000 rubles."
ITEM.model = "models/lostsignalproject/items/misc/backpack.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.flag = "A"
ITEM.itemsForcedDrop = {
	{"bagrubles", {["quantity"] = 500},},
}

ITEM.items[1] = {
	dropAmount = 4,
	dropRareChance = 30,
	dropVeryRareChance = 10,
	itemsCommon = {
		{"9x18", {["quantity"] = 20},},
		{"9x19", {["quantity"] = 20},},
		{"12gauge", {["quantity"] = 8},},
		{"762x25", {["quantity"] = 20},},
		{"22lr", {["quantity"] = 20},},
},
	itemsRare = {
		{"9x18", {["quantity"] = 30},},
		{"9x19", {["quantity"] = 30},},
		{"12gauge", {["quantity"] = 14},},
		{"762x25", {["quantity"] = 30},},
		{"22lr", {["quantity"] = 30},},
},
	itemsVeryRare = {
		{"9x18", {["quantity"] = 40},},
		{"9x19z", {["quantity"] = 40},},
		{"12gauge", {["quantity"] = 18},},
		{"762x25", {["quantity"] = 40},},
		{"22lr", {["quantity"] = 40},},
},
}

ITEM.items[2] = {
	dropAmount = 2,
	dropRareChance = 30,
	dropVeryRareChance = 10,
	itemsCommon = {
		{"fort12", {["durability"] = 0},},
		{"makarov", {["durability"] = 0},},
		{"tokarev", {["durability"] = 0},},
		{"cz52", {["durability"] = 0},},
		{"brhp", {["durability"] = 0},},
},
	itemsRare = {
		{"ppsh", {["durability"] = 0},},
		{"toz66short", {["durability"] = 0},},
		{"m1911", {["durability"] = 0},},
		{"beretta92", {["durability"] = 0},},
},
	itemsVeryRare = {
		{"toz66", {["durability"] = 5}},
		{"toz34", {["durability"] = 5}},
},
}

ITEM.items[3] = {
	dropAmount = 5,
	dropRareChance = 30,
	dropVeryRareChance = 10,
	itemsCommon = {
		{"bandage"},
		{"cig1", {["quantity"] = 1},},
		{"oldmeat", {["quantity"] = 1},},
		{"cannedcorn", {["quantity"] = 1},},
		{"cannedbeans", {["quantity"] = 1},},
		{"cannedtomato", {["quantity"] = 1},},
		{"milkold", {["quantity"] = 1},},
		{"waterdirty", {["quantity"] = 1},},
		{"moonshine", {["quantity"] = 1},},
		{"beer3", {["quantity"] = 1},},
		{"beer2", {["quantity"] = 1},},
},
	itemsRare = {
		{"documents0"},
		{"bandage"},
		{"energydrink"},
		{"cig1", {["quantity"] = 1},},
		{"water", {["quantity"] = 1},},
		{"cannedcorn", {["quantity"] = 1},},
		{"cannedbeans", {["quantity"] = 1},},
		{"cannedtomato", {["quantity"] = 1},},
		{"cannedolives", {["quantity"] = 1},},
		{"cannedchilibeans", {["quantity"] = 1},},
		{"moonshine", {["quantity"] = 1},},
		{"vodka2", {["quantity"] = 1},},
		{"vodka2", {["quantity"] = 1},},
},
	itemsVeryRare = {
		{"documents1"},
				{"radio"},
		{"sradio"},
		{"geigercounter"},
		{"guitar"},
		{"energydrink"},
		{"cig1", {["quantity"] = 2},},
		{"water", {["quantity"] = 2},},
		{"cannedcorn", {["quantity"] = 2},},
		{"cannedbeans", {["quantity"] = 2},},
		{"cannedtomato", {["quantity"] = 2},},
		{"cannedolives", {["quantity"] = 2},},
		{"cannedchilibeans", {["quantity"] = 2},},
		{"moonshine", {["quantity"] = 2},},
		{"vodka2", {["quantity"] = 2},},
		{"vodka2", {["quantity"] = 2},},
},
}

