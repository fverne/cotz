ITEM.name = "Infantry First Aid Kit"
ITEM.description= "An infantry first aid kit."
ITEM.longdesc = "The infantry kit pairs medkits and bandages with psychic recovery medication. Its compact packing leaves less wasted space than a general medical box. The bundle is intended to travel alongside a soldier's other equipment, with the contents kept as separate supplies."
ITEM.model = "models/illusion/eftcontainers/ifak.mdl"

ITEM.width = 2
ITEM.height = 2
ITEM.flag = "A"

-- ITEM.exRender = true
-- ITEM.iconCam = {
-- 	pos = Vector(277.58795166016, 232.89892578125, 177.14739990234),
-- 	ang = Angle(25, 220, 0),
-- 	fov = 5.0663454801178,
-- }

ITEM.items = {
	{
		{1, "medical_medkit_tier01"},
	},
	{
		{1, "medical_medkit_tier01"},
	},
	{
		{1, "medical_bandage_tier01"},
	},
	{
		{1, "medical_bandage_tier01"},
	},
	{
		{1, "medical_psy_tier01"},
	},
}