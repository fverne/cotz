ITEM.name = "Steyr AUG A3"
ITEM.description = "Steyr AUG A3, chambered for 5.56x45mm."
ITEM.longdesc = "The A3's upper rail replaces the familiar fixed optic of the earlier AUG."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/w_aug_a3.mdl"

ITEM.price = 33000
ITEM.width = 5
ITEM.height = 2
ITEM.unloadedweight = 3.6
ITEM.bulletweight = 0.012

ITEM.class = "cw_anomaly_aug_a3_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(1.5, -205, 4.6),
	ang = Angle(0, 90, 0),
	fov = 8.7,
}

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
					[1] = {
						["children"] = {},
						["self"] = {
							["Angles"] = Angle(180, 0, 0),
							["Model"] = "models/flaymi/anomaly/weapons/w_models/w_aug_a3.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(1.943, -4.951, 1.975),
							["EditorExpand"] = true,
							["UniqueID"] = "3561163147",
							["Bone"] = "spine 2",
							["Name"] = "aug_a3",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "947417589",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_aug_a3_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "1846951831",
			["EditorExpand"] = true,
		},
	},
}
