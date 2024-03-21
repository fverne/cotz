ITEM.name = "Master Reward Small"
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

ITEM.items = {
	{
		{45, "task_reward_weapon_08_low"},
		{15, "task_reward_weapon_08_high"},
		{155, "task_reward_weapon_07_low"},
		{85, "task_reward_weapon_07_high"},
		{140, "task_reward_ammo_04_small"},
	},
	{
		{1, "task_reward_ammo_04_aphp"},
	},
	{
		{1, "task_reward_medical_05"},
	},
	{
		{1, "task_reward_money_08"},
	},
}