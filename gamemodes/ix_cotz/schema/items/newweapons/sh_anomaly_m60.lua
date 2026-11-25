ITEM.name = "M60"
ITEM.description = "M60, chambered for 7.62x51mm."
ITEM.longdesc = "The broad feed cover and long receiver give the M60 much of its bulk."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_m60_w.mdl"

ITEM.price = 55500
ITEM.width = 6
ITEM.height = 2
ITEM.unloadedweight = 10.5
ITEM.bulletweight = 0.026

ITEM.class = "cw_anomaly_m60_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(6.4, -205, 6.2),
	ang = Angle(0, 90, 0),
	fov = 12,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_m60_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(11.188, -4.675, -0.658),
							["EditorExpand"] = true,
							["UniqueID"] = "81171613",
							["Bone"] = "spine 2",
							["Name"] = "m60",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "3907906787",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_m60_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "3196297857",
			["EditorExpand"] = true,
		},
	},
}
