ITEM.name = "Professional Weapon Box"
ITEM.description= "Feels heavy, has something inside."
ITEM.longdesc = "The Professional Weapon Box represents a higher-class equipment allowance in ordinary transport packaging. The outside gives no reliable identification of a specific firearm. The supplying contact shows the concrete exchange offer rather than opening an unseen random prize."
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
		{3, "task_reward_weapon_05_low"},
		{1, "task_reward_weapon_05_high"},
	},
}