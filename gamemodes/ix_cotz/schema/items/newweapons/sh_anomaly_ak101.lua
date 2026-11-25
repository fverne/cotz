ITEM.name = "AK-101"
ITEM.description = "AK-101, chambered for 5.56x45mm."
ITEM.longdesc = "The AK-101 combines an AK-74M-style folding polymer stock with a straighter magazine."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_ak101_w.mdl"

ITEM.price = 17000
ITEM.width = 5
ITEM.height = 2
ITEM.unloadedweight = 3.6
ITEM.bulletweight = 0.012

ITEM.class = "cw_anomaly_ak101_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(6.7, -205, 5.7),
	ang = Angle(0, 90, 0),
	fov = 10.5,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_ak101_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(11.522, -3.244, -1.16),
							["EditorExpand"] = true,
							["UniqueID"] = "1265607107",
							["Bone"] = "spine 2",
							["Name"] = "ak101",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "2807355837",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_ak101_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "4047149023",
			["EditorExpand"] = true,
		},
	},
}
