ITEM.name = "Tourist Medical Box"
ITEM.description= "A red first aid kit."
ITEM.longdesc = "The Tourist Medical Box represents a basic allowance of treatment supplies. Red first-aid packaging gives the entitlement a familiar physical form. Its actual redemption choice is shown by the supplying contact before the kit is surrendered."
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
		{1, "medical_medkit_tier01"},
	},
	{
		{2, "medical_bandage_tier01"},
		{1, "medical_psy_tier01"},
		{1, "medical_rad_tier01"},
		{1, "medical_support_tier01"},
	},
}