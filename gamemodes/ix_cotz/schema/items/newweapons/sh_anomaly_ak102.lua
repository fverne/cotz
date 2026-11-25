ITEM.name = "AK-102"
ITEM.description = "AK-102, chambered for 5.56x45mm."
ITEM.longdesc = "The AK-102 keeps the full-size furniture around a shorter barrel."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_ak102.mdl"

ITEM.price = 14500
ITEM.width = 4
ITEM.height = 2
ITEM.unloadedweight = 3.0
ITEM.bulletweight = 0.012

ITEM.class = "cw_anomaly_ak102_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(4.4, -205, 0.8),
	ang = Angle(0, 90, 0),
	fov = 8.9,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_ak102.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(11.522, -4.744, -1.16),
							["EditorExpand"] = true,
							["UniqueID"] = "1655117105",
							["Bone"] = "spine 2",
							["Name"] = "ak102",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "2392616271",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_ak102_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "3639747373",
			["EditorExpand"] = true,
		},
	},
}
