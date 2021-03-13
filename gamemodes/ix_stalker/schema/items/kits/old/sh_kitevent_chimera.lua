ITEM.name = "Tattered backpack"
ITEM.description= "A damaged backpack, it might still be usable."
ITEM.model = "models/props_junk/garbage_bag001a.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.flag = "A"

ITEM.items[1] = {
	dropAmount = 2,
	dropRareChance = 10,
	dropVeryRareChance = 3,
	itemsCommon = {
		{"medkit"},
		{"medkitarmy"},
		{"antirad"},
		{"component", {["quantity"] = 10}}
},
	itemsRare = {
		{"documents1"},
		{"documents0"},
		{"radio"},
		{"geigercounter"},
},
	itemsVeryRare = {
		{"component", {["quantity"] = 40}},
		{"documents5"},
		{"chimerasclaw"},
},
}