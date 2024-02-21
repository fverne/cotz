ITEM.name = "Rookie Reward Small"
ITEM.description= "A big wooden box."
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

ITEM.upgradeItem = "kit_reward_tier02_small"
ITEM.upgradeCost = 2000

ITEM.items = {
	{
		{3, "task_reward_weapon_01_low"},
		{1, "task_reward_weapon_01_high"},
	},
	{
		{1, "task_reward_ammo_01_small"},
	},
	{
		{1, "task_reward_medical_01"},
	},
	{
		{1, "task_reward_money_01"},
	},
}