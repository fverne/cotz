ITEM.name = "Novice Weapon Box"
ITEM.description= "Feels heavy, has something inside."
ITEM.longdesc = "The Novice Weapon Box represents an equipment allowance rather than an identified gun waiting beneath the lid. The wooden shell gives it a familiar transport form. Its available redemption choice is shown at the supplying contact."
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
		{3, "task_reward_weapon_02_low"},
		{1, "task_reward_weapon_02_high"},
	},
}