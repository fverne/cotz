ITEM.name = "Stalkers Backpack"
ITEM.description= "A backpack that most likely belonged to a prowler of the zone. It's almost falling apart, rendering it useless, but there still seems to be something inside."
ITEM.longdesc = "The stalker's backpack has become a cache of provisions, valuables and other field belongings. Fraying seams leave it unsuitable for another long trip as ordinary equipment. The remaining load can still be unpacked even though the carrier has reached the end of its working life."
ITEM.model = "models/kek1ch/sumka5.mdl"

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
		{1, "reward_generic_valuable"},
	},
	{
		{1, "reward_consumable"},
	},
	{
		{9, "reward_ammo_high"},
		{1, "reward_generic_valuable"},
	},
}