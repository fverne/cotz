ITEM.name = "Emergency Supplies Kit"
ITEM.description= "A big kit with emergency supplies."
ITEM.longdesc = "Several treatment supplies are packed beneath the broad cover, including medkits, a bandage, and"
	.. " psychic recovery medication. The crowded arrangement rewards being sorted before an emergency."
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