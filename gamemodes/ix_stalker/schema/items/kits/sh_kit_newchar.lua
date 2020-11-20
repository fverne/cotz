ITEM.name = "Your Personal Belongings"
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
	{"bagrubles", {["quantity"] = math.Round(math.Rand(300, 350), 0)}},
	{"medic_bandage_1"},
}
