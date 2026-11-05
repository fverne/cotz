ITEM.name = "Emergency First Aid Kit"
ITEM.description= "A red emergency first aid kit."
ITEM.longdesc = "The red emergency kit keeps a medkit and spare bandages within one conspicuous carrier. Its bright shell favours quick recognition over discreet packing. The case organises a small reserve of treatment supplies rather than providing a single all-purpose remedy."
ITEM.model = "models/illusion/eftcontainers/salewa.mdl"

ITEM.width = 2
ITEM.height = 2
ITEM.flag = "A"

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-190.5, 5.85, -708.84),
	ang = Angle(285.05, -1.75, 0),
	fov = 0.81
}

ITEM.items = {
	{
		{1, "medical_medkit_tier01"},
	},
	{
		{1, "medical_bandage_tier01"},
	},
	{
		{1, "medical_bandage_tier01"},
	},
}