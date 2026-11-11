ITEM.name = "Professional Reward Large"
ITEM.description = "A large reward supply package."
ITEM.longdesc = "The large Professional Reward represents a substantial work payment kept in supply form. Its class and size distinguish it from lower or smaller packages."
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