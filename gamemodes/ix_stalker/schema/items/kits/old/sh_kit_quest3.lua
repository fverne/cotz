ITEM.name = "Small metal crate"
ITEM.description= "A small metal crate, rewarded for completing a quest. Something is inside."
ITEM.model = "models/lostsignalproject/items/quest/toolkit_drug.mdl"
ITEM.width = 3
ITEM.height = 3
ITEM.flag = "A"
ITEM.itemsForcedDrop = {
	{"bagrubles", {["quantity"] = 5500}},
}

ITEM.items[1] = {
	dropAmount = 1,
	dropRareChance = 35,
	dropVeryRareChance = 5,
	itemsCommon = {
		{"tokarev"},
		{"ruger1022"},
	},
	itemsRare = {
		{"toz66short"},
		{"toz34short"},	
		{"makarov"},		
	},
	itemsVeryRare = {
		{"toz66"},
		{"toz34"},
		{"m3supershort"},
	},
}