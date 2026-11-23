ITEM.name = "HK MP7"
ITEM.description = "HK MP7, chambered for 9x19mm."
ITEM.longdesc = "The magazine fits inside the grip, leaving a short nose beneath the upper rail."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_mp7_w.mdl"

ITEM.price = 14500
ITEM.width = 2
ITEM.height = 2
ITEM.unloadedweight = 1.9
ITEM.bulletweight = 0.008

ITEM.class = "cw_anomaly_mp7_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(-3.8, -205, 3.1),
	ang = Angle(0, 90, 0),
	fov = 7.3,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_mp7_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(9.2, -4.2, -3.4),
							["EditorExpand"] = true,
							["UniqueID"] = "56475156",
							["Bone"] = "spine 2",
							["Name"] = "mp7",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "4016490090",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_mp7_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "3104344072",
			["EditorExpand"] = true,
		},
	},
}
