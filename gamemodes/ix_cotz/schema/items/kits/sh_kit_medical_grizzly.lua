ITEM.name = "Emergency Supplies Kit"
ITEM.description= "A big kit with emergency supplies."
ITEM.longdesc = "The large emergency kit holds medkits, a bandage and psychic recovery medication beneath a broad cover. Its bulk belongs to a reserve that can support more than one immediate need. The individual supplies remain separate items within the packed case."
ITEM.model = "models/illusion/eftcontainers/grizzly.mdl"

ITEM.width = 3
ITEM.height = 3
ITEM.flag = "A"

-- ITEM.exRender = true
-- ITEM.iconCam = {
-- 	pos = Vector(277.58795166016, 232.89892578125, 177.14739990234),
-- 	ang = Angle(25, 220, 0),
-- 	fov = 5.0663454801178,
-- }

ITEM.items = {
	{
		{1, "medical_medkit_tier02"},
	},
	{
		{1, "medical_medkit_tier02"},
	},
	{
		{1, "medical_bandage_tier03"},
	},
	{
		{1, "medical_psy_tier02"},
	},
}