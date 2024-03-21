ITEM.name = "Professional Reward Large"
ITEM.description= ""
ITEM.model = "models/lostsignalproject/items/misc/small_wood_box.mdl"

ITEM.width = 4
ITEM.height = 2
ITEM.flag = "A"

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, -0.68, 200),
	ang = Angle(449.8, 90.22, 0),
	fov = 13.55
}

ITEM.upgradeItem = "kit_reward_tier06_large"
ITEM.upgradeCost = 65000

ITEM.items = {
	{
		{30, "task_reward_weapon_05_low"},
		{10, "task_reward_weapon_05_high"},
		{60, "task_reward_ammo_03_small"},
	},
	{
		{1, "task_reward_ammo_03_small"},
	},
	{
		{1, "task_reward_ammo_03"},
	},
	{
		{1, "task_reward_medical_04"},
	},
	{
		{1, "task_reward_money_05"},
	},
}