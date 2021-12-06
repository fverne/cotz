ITEM.name = "Small cloth bag"
ITEM.description= "A small bag made of cloth, rewarded for completing a quest. Something is inside."
ITEM.model = "models/lostsignalproject/items/repair/armor_repair_pro.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.flag = "A"
ITEM.itemsForcedDrop = {
	{"bagrubles", {["quantity"] = 2000}},
}

ITEM.items[1] = {
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