ITEM.name = "Tourist Reward Small"
ITEM.description = "A small reward supply package."
ITEM.longdesc = "The small Tourist Reward is a compact supply package representing payment for work. Its introductory class describes the allowance rather than a guaranteed object inside."
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
		{1, "task_reward_weapon_00"},
	},
	{
		{1, "task_reward_ammo_01_small"},
	},
	{
		{1, "task_reward_medical_01"},
	},
	{
		{1, "task_reward_money_00"},
	},
}