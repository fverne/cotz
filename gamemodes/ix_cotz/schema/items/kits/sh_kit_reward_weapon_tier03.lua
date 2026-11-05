ITEM.name = "Regular Weapon Box"
ITEM.description= "Feels heavy, has something inside."
ITEM.longdesc = "The Regular Weapon Box belongs to the equipment-package class associated with established field work. Its wooden casing keeps the entitlement together as one item. The exchange offer identifies the actual equipment instead of leaving the label to imply a particular weapon."
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
		{3, "task_reward_weapon_03_low"},
		{1, "task_reward_weapon_03_high"},
	},
}