ITEM.name = "Novice Reward Large"
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
		{60, "task_reward_weapon_02_low"},
		{20, "task_reward_weapon_02_high"},
		{20, "task_reward_ammo_01"}
	},
	{
		{1, "task_reward_ammo_01_aphp"},
	},
	{
		{1, "task_reward_ammo_01"},
	},
	{
		{1, "task_reward_medical_02"},
	},
}