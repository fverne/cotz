ITEM.name = "Items from outside the zone."
ITEM.description= "Your personal belongings from back home. This is all you have with you."
ITEM.model = "models/lostsignalproject/items/misc/kithunt.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.flag = "A"
ITEM.itemsForcedDrop = {
	{"hidestasher_cutlery"},
	{"drug_cigarette_1"},
	{"medic_bandage_1"},
	{"drink_bottlewater"},
	{"drink_bottlewaterdirty"},
	{"food_bread"},
	{"food_sausage_1"},
	{"bagrubles", {["quantity"] = math.Round(math.Rand(3000, 3200), 0)}},
	{"medic_bandage_1"},
	{"skinningknife1"},
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

ITEM.items[2] = {
	dropAmount = 1,
	itemsCommon = {
		{"backpack1"},
		{"backpack2"},
		{"backpack3"},
	},
}