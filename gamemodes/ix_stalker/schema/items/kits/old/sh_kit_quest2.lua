ITEM.name = "Small plastic crate"
ITEM.description= "A small plastic crate, rewarded for completing a quest. Something is inside."
ITEM.model = "models/lostsignalproject/items/quest/toolkit_ammo.mdl"
ITEM.width = 3
ITEM.height = 3
ITEM.flag = "A"
ITEM.itemsForcedDrop = {
	{"bagrubles", {["quantity"] = 4000}},
}

ITEM.items[1] = {
	dropAmount = 1,
	dropRareChance = 35,
	dropVeryRareChance = 5,
	itemsCommon = {
		{"rugermk3"},
		{"w9422"},
		{"cz52"},
	},
	itemsRare = {
		{"tokarev"},
		{"ruger1022"},	
	},
	itemsVeryRare = {
		{"makarov"},
		{"toz66short"},
		{"toz34short"},
	},
}