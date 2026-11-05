ITEM.name = "Ammo Crate"
ITEM.description= "A small wooden box containing some ammunition. It seems to be a good variety of calibers."
ITEM.longdesc = "The wooden ammunition crate is a general reserve rather than packaging for one identified weapon. Separate packets keep different loads together inside the same shell. It is a practical supply bundle with little decoration beyond the markings needed to organise its contents."
ITEM.model = "models/lostsignalproject/items/misc/small_wood_box.mdl"

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
		{4, "reward_ammo_low"},
		{6,  "reward_ammo_high"},
	},
	{
		{4, "reward_ammo_low"},
		{6,  "reward_ammo_high"},
	},
}