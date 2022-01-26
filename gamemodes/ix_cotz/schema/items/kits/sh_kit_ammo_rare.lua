ITEM.name = "Foreign Ammunition Box"
ITEM.description= "A box containing some less common types of ammunition, mostly of foreign origin."
ITEM.model = "models/illusion/eftcontainers/magbox.mdl"

ITEM.width = 2
ITEM.height = 2
ITEM.flag = "A"

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(277.58795166016, 232.89892578125, 177.14739990234),
	ang = Angle(25, 220, 0),
	fov = 5.0663454801178,
}

ITEM.items = {
	{
		{1, "reward_ammo_rare"},
	},
	{
		{3,  "reward_ammo_high"},
		{1, "reward_ammo_rare"},
	},
}