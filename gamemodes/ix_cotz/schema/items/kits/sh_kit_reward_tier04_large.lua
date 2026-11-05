ITEM.name = "Experienced Reward Large"
ITEM.description = "A large reward supply package."
ITEM.longdesc = "A full bundle set aside as payment for completed work. The wrapping is plain, with the attention"
	.. " spent on what a returning field worker will actually carry away."
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
		{45, "task_reward_weapon_04_low"},
		{15, "task_reward_weapon_04_high"},
		{60, "task_reward_ammo_02_small"}
	},
	{
		{1, "task_reward_ammo_02_aphp"},
	},
	{
		{1, "task_reward_ammo_02"},
	},
	{
		{1, "task_reward_medical_04"},
	},
	{
		{1, "task_reward_money_04"},
	},
}