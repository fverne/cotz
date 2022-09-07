ITEM.name = "Stalkers Backpack"
ITEM.description= "A small rugged backpack."
ITEM.model = "models/lostsignalproject/items/misc/backpack.mdl"

ITEM.width = 3
ITEM.height = 2

ITEM.weight = 4

ITEM.exRender = true 
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 90, 0),
	fov = 8.8235294117647,
}

ITEM.items = {
	{
		{1, "reward_consumable"},
	},
	{
		{2, "cache_ammo_pistol_tier2"},
		{1, "cache_ammo_shotgun_tier1"},
	},
	{
		{1, "reward_aid_low"},
	},
	{
		{2, "reward_consumable"},
		{1, "reward_aid_low"},
	},
	{
		{4, "worldspawn_2"},
		{1, "cache_artifact_tier1"},
		{4, "worldspawn_3"},
	},
	{
		{1, "worldspawn_3"},
	},
}

/*
ITEM.items = {
	{
		{1, "knife_1"},
	},
	{
		{1, "medic_medkit_1"},
	},
	{
		{4, "food_can_chilibeans"},
		{4, "food_can_corn"},
		{4, "food_can_olive"},
		{4, "food_can_sprats"},
		{4, "food_can_tomato"},
		{4, "food_can_tuna"},
		{4, "food_can_tushonka"},
		{4, "food_sausage_1"},
		{4, "food_sausage_2"},
		{4, "food_bread"},
		{1, "food_cheese_1"},
		{1, "food_cheese_3"},
		{1, "food_nuts_1"},
		{1, "food_nuts_2"},
		{1, "food_raisins"},
	},
	{
		{4, "drink_canwater"},
		{4, "drink_bottlewater"},
		{1, "drink_orangejuice"},
		{1, "drink_milk"},	
	},
	{
		{4, "drink_canbeer_1"},
		{4, "drink_canbeer_2"},
		{4, "drink_canbeer_3"},
		{4, "drink_canbeer_4"},
		{4, "drink_bottlebeer_2"},
		{4, "drink_bottlebeer_3"},
		{4, "drink_bottlebeer_4"},
		{4, "drink_bottlebeer_6"},
		{1, "drink_bottlebeer_5"},
		{1, "drink_canbeer_6"},
	},
	{
		{4, "drink_vodka_1"},
		{4, "drink_vodka_2"},
		{4, "drink_vodka_4"},
		{4, "drink_vodka_6"},
		{1, "drink_wine"},
		{1, "drink_spirit_1"},
		{1, "drink_spirit_2"},
		{1, "drink_spirit_3"},
	},
	{
		{8, "drink_energydrink_2"},
		{8, "drink_energydrink_4"},
		{4, "drink_energydrink_5"},
		{4, "drink_energydrink_1"},
		{1, "drink_energydrink_6"},
		{1, "drink_energydrink_3"},
	},
	{
		{8, "drug_cigarette_1", {["quantity"] = math.random(5,8)}},
		{8, "drug_cigarette_2", {["quantity"] = math.random(5,8)}},
		{8, "drug_cigarette_3", {["quantity"] = math.random(5,8)}},
		{4, "drug_tobacco_1", {["quantity"] = math.random(6,9)}},
		{4, "drug_cigarette_6", {["quantity"] = math.random(5,8)}},
		{1, "drug_tobacco_2", {["quantity"] = math.random(6,9)}},
		{1, "drug_cigarette_5", {["quantity"] = math.random(5,8)}},
	},
	{
		{8, "medic_bandage_1"},
		{4, "medic_bandage_2"},
		{1, "medic_bandage_3"},
	},
	{
		{8, "medic_bandage_1"},
		{4, "medic_bandage_2"},
		{1, "medic_bandage_3"},
	},
}
*/