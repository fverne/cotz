ITEM.name = "Master Weapon Box"
ITEM.description= "Feels heavy, has something inside."
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
		{3, "task_reward_weapon_08_low"},
		{1, "task_reward_weapon_08_high"},
	},
}