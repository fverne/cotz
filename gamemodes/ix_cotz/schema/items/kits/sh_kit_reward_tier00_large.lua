ITEM.name = "Tourist Reward Large"
ITEM.description = "A large reward supply package."
ITEM.longdesc = "The large Tourist Reward package keeps an introductory work payment in supply form. Its size distinguishes it from the compact package of the same class. The issuing contact identifies the redeemable contents before the bundle changes hands."
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
		{1, "task_reward_ammo_01_small"},
	},
	{
		{1, "task_reward_medical_01"},
	},
	{
		{1, "task_reward_money_00"},
	},
}