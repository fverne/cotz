ITEM.name = "RG-6"
ITEM.description = "RG-6, chambered for 40 mm rounds."
ITEM.longdesc = "The cluster of six chambers accounts for most of the launcher's width."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_rg6_w.mdl"

ITEM.price = 38000
ITEM.width = 4
ITEM.height = 2
ITEM.unloadedweight = 5.6
ITEM.bulletweight = 0.23

ITEM.class = "cw_anomaly_rg6_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(4.5, -205, 4.5),
	ang = Angle(0, 90, 0),
	fov = 7.8,
}

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
					[1] = {
						["children"] = {},
						["self"] = {
							["Angles"] = Angle(0, 180, 180),
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_rg6_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(5.922, -2.804, -4.465),
							["EditorExpand"] = true,
							["UniqueID"] = "1110061763",
							["Bone"] = "spine 2",
							["Name"] = "rg6",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "2920368829",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_rg6_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "4169073887",
			["EditorExpand"] = true,
		},
	},
}
