ITEM.name = "Small Doctors Bag"
ITEM.description= "A bag containing some medical supplies."
ITEM.longdesc = "Loose packets and small containers settle unevenly at the bottom. It is the sort of modest"
	.. " reserve a traveller puts together before risking a long walk."
ITEM.model = "models/illusion/eftcontainers/docbag.mdl"

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
		{1, "reward_aid_low"},
	},
	{
		{1, "reward_aid_low"},
	},
	{
		{9, "reward_aid_low"},
		{1, "reward_aid_high"},
	},
}