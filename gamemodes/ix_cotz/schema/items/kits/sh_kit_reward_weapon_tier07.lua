ITEM.name = "Expert Weapon Box"
ITEM.description= "Feels heavy, has something inside."
ITEM.longdesc = "The Expert Weapon Box is an equipment allowance near the upper end of the package series. Its plain wooden shell provides a physical carrier for that entitlement. The actual return is identified by the supplying contact before the box changes hands."
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
		{3, "task_reward_weapon_07_low"},
		{1, "task_reward_weapon_07_high"},
	},
}