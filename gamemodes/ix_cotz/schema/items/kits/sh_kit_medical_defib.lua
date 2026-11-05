ITEM.name = "Emergency Rescue Kit"
ITEM.description= "A kit used in ambulances for emergency rescue and revival."
ITEM.longdesc = "The emergency rescue kit gathers medkit supplies, spare bandages and psychic recovery medication into one case. Its ambulance-style housing suggests an organised response rather than a pocket remedy. The packaged supplies can be separated for use without treating the case itself as a revival device."
ITEM.model = "models/illusion/eftcontainers/defib.mdl"

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
		{1, "medical_medkit_tier02"},
	},
	{
		{1, "medical_bandage_tier02"},
	},
	{
		{1, "medical_bandage_tier02"},
	},
	{
		{1, "medical_psy_tier02"},
	},
}