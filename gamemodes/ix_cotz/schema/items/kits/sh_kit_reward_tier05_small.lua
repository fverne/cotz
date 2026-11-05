ITEM.name = "Professional Reward Small"
ITEM.description = "A small reward supply package."
ITEM.longdesc = "The small Professional Reward is an equipment-and-supply entitlement packaged for carrying. Its professional issue class remains separate from any particular redemption choice. The supplying contact shows the available inventory before the exchange is completed."
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
		{1, "task_reward_medical_04"},
	},
	{
		{1, "task_reward_money_05"},
	},
}