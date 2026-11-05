ITEM.name = "Experienced Weapon Box"
ITEM.description= "Feels heavy, has something inside."
ITEM.longdesc = "The Experienced Weapon Box packages an equipment allowance in a plain wooden shell. Its issue class matters more than the weathering of the lid. A contact's redemption preview specifies the available choice before the entitlement is used."
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
		{3, "task_reward_weapon_04_low"},
		{1, "task_reward_weapon_04_high"},
	},
}