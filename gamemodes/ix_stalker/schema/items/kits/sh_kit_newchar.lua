ITEM.name = "Damaged Bag with Supplies"
ITEM.description= "A bag with your possessions from back home. Contains the very basic neccessities from what you've heard from rumours about the zone."
ITEM.model = "models/lostsignalproject/items/misc/kithunt.mdl"

ITEM.width = 3
ITEM.height = 2

ITEM.weight = 9

ITEM.itemsForcedDrop = {
	{"medic_medkit_1"}, -- medkit
	{"value_personal_1"}, -- small valuable, mostly for setting, not worth a lot
}

-- food
ITEM.items[1] = {
	dropAmount = 2,
	dropRareChance = 35,
	itemsCommon = {
		{"food_can_beans"},
		{"food_can_chilibeans"},
		{"food_can_corn"},
		{"food_can_olive"},
		{"food_can_sprats"},
		{"food_can_tomato"},
		{"food_can_tuna"},
		{"food_can_tushonka"},
		{"food_sausage_1"},
		{"food_sausage_2"},
		{"food_bread"},
	},
	itemsRare = {
		{"food_cheese_1"},
		{"food_cheese_3"},
		{"food_nuts_1"},
		{"food_nuts_2"},
		{"food_raisins"},
	},
}

-- drinks
ITEM.items[2] = {
	dropAmount = 2,
	dropRareChance = 35,
	itemsCommon = {
		{"drink_canwater"},
		{"drink_bottlewater"},
	},
	itemsRare = {
		{"drink_orangejuice"},
		{"drink_milk"},	
	},
}

--light alcohol
ITEM.items[3] = {
	dropAmount = 1,
	dropRareChance = 25,
	itemsCommon = {
		{"drink_canbeer_1"},
		{"drink_canbeer_2"},
		{"drink_canbeer_3"},
		{"drink_canbeer_4"},
		{"drink_bottlebeer_2"},
		{"drink_bottlebeer_3"},
		{"drink_bottlebeer_4"},
		{"drink_bottlebeer_6"},
	},
	itemsRare = {
		{"drink_bottlebeer_5"},
		{"drink_canbeer_6"},
	},
}

--strong alcohol
ITEM.items[4] = {
	dropAmount = 1,
	dropRareChance = 35,
	itemsCommon = {
		{"drink_vodka_1"},
		{"drink_vodka_2"},
		{"drink_vodka_4"},
		{"drink_vodka_6"},
	},
	itemsRare = {
		{"drink_wine"},
		{"drink_spirit_1"},
		{"drink_spirit_2"},
		{"drink_spirit_3"},
	},
}

-- energydrink
ITEM.items[5] = {
	dropAmount = 1,
	dropRareChance = 35,
	dropVeryRareChance = 5,
	itemsCommon = {
		{"drink_energydrink_2"},
		{"drink_energydrink_4"},
	},
	itemsRare = {
		{"drink_energydrink_5"},
		{"drink_energydrink_1"},
	},
	itemsVeryRare = {
		{"drink_energydrink_6"},
		{"drink_energydrink_3"},
	},
}

-- tobacco
ITEM.items[6] = {
	dropAmount = 1,
	dropRareChance = 35,
	dropVeryRareChance = 5,
	itemsCommon = {
		{"drug_cigarette_1", {["quantity"] = math.random(5,8)}},
		{"drug_cigarette_2", {["quantity"] = math.random(5,8)}},
		{"drug_cigarette_3", {["quantity"] = math.random(5,8)}},
	},
	itemsRare = {
		{"drug_tobacco_1", {["quantity"] = math.random(10,12)}},
		{"drug_cigarette_6", {["quantity"] = math.random(5,8)}},
	},
	itemsVeryRare = {
		{"drug_tobacco_2", {["quantity"] = math.random(10,12)}},
		{"drug_cigarette_5", {["quantity"] = math.random(5,8)}},
	},
}

-- bandages
ITEM.items[7] = {
	dropAmount = 2,
	dropRareChance = 35,
	dropVeryRareChance = 5,
	itemsCommon = {
		{"medic_bandage_1"},
	},
	itemsRare = {
		{"medic_bandage_2"},
	},
	itemsVeryRare = {
		{"medic_bandage_3"},
	},
}