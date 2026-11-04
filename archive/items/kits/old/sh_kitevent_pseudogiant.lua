ITEM.name = "Damaged backpack"
ITEM.description= "A tattered backpack, it might still be usable."
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
		{"morphine"},
		{"component", {["quantity"] = 10}}
},
	itemsRare = {
		{"documents1"},
		{"documents0"},
		{"radio"},
		{"geigercounter"},
		{"backpack_stalker"},
},
	itemsVeryRare = {
		{"component"},
		{"documents5"},
		{"pseudogiantsfoot"},
},
}