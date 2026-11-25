ITEM.name = "L85A2"
ITEM.description = "L85A2, chambered for 5.56x45mm."
ITEM.longdesc = "The revised charging handle is an easy way to pick the A2 out from the earlier L85."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_l85a2_w.mdl"

ITEM.price = 27000
ITEM.width = 4
ITEM.height = 2
ITEM.unloadedweight = 4.2
ITEM.bulletweight = 0.012

ITEM.class = "cw_anomaly_l85a2_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(1.3, -205, 5.8),
	ang = Angle(0, 90, 0),
	fov = 8.4,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_l85a2_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(2.141, -4.694, 2.193),
							["EditorExpand"] = true,
							["UniqueID"] = "4025721563",
							["Bone"] = "spine 2",
							["Name"] = "l85a2",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "63494821",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_l85a2_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "1436980423",
			["EditorExpand"] = true,
		},
	},
}
