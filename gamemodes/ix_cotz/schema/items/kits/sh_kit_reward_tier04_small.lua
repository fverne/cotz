ITEM.name = "Experienced Reward Small"
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

ITEM.upgradeItem = "kit_reward_tier05_small"
ITEM.upgradeCost = 45000

ITEM.items = {
	{
		{45, "task_reward_weapon_04_low"},
		{15, "task_reward_weapon_04_high"},
		{60, "task_reward_ammo_02_small"}
	},
	{
		{1, "task_reward_ammo_02_aphp"},
	},
	{
		{1, "task_reward_medical_03"},
	},
	{
		{1, "task_reward_money_04"},
	},
}