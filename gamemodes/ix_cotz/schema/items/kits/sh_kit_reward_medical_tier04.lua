ITEM.name = "Master Medical Box"
ITEM.description= "A red first aid kit."
ITEM.model = "models/illusion/eftcontainers/carmedkit.mdl"

ITEM.width = 2
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
		{1, "medical_medkit_tier03"},
	},
	{
		{2, "medical_bandage_tier03"},
		{1, "medical_psy_tier02"},
		{1, "medical_rad_tier02"},
		{1, "medical_support_tier02"},
	},
}