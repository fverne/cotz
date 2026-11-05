ITEM.name = "Novice Ammo Box"
ITEM.description= "The box rattles when you shake it."
ITEM.longdesc = "The Novice Ammo Box represents a larger class of ammunition allowance than the introductory package. Its plain shell keeps the transaction's stock together as one object. The actual offered loads are identified by the supplying contact before exchange."
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
		{2, "task_reward_ammo_02_small"},
		{1, "task_reward_ammo_02_aphp"},
	},
	{
		{1, "task_reward_ammo_02"},
	},
}