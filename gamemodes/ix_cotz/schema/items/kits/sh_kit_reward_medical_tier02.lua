ITEM.name = "Novice Medical Box"
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

ITEM.upgradeItem = "kit_reward_medical_tier03"
ITEM.upgradeCost = 24000

ITEM.items = {
	{
		{1, "medical_medkit_tier02"},
	},
	{
		{2, "medical_bandage_tier02"},
		{1, "medical_psy_tier01"},
		{1, "medical_rad_tier01"},
	},
}