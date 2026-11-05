ITEM.name = "Veteran Reward Large"
ITEM.description = "A large reward supply package."
ITEM.longdesc = "A full bundle set aside as payment for completed work. Careful packing keeps the contents"
	.. " together through the sort of transport that ruins ordinary luggage."
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
		{45, "task_reward_weapon_06_low"},
		{15, "task_reward_weapon_06_high"},
		{140, "task_reward_ammo_03_small"},
	},
	{
		{1, "task_reward_ammo_03_aphp"},
	},
	{
		{1, "task_reward_ammo_03"},
	},
	{
		{1, "task_reward_medical_05"},
	},
	{
		{1, "task_reward_money_06"},
	},
}