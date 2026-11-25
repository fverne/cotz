ITEM.name = "MP-412 Rex"
ITEM.description = "MP-412 Rex, chambered for .357 Magnum."
ITEM.longdesc = "The top-break frame opens at the rear of the cylinder and tips it forward for access."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_mp412_w.mdl"

ITEM.price = 9500
ITEM.width = 2
ITEM.height = 1
ITEM.unloadedweight = 0.9
ITEM.bulletweight = 0.017

ITEM.class = "cw_anomaly_mp412_vmrecoil"
ITEM.weaponCategory = "secondary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(2.8, -205, 3.3),
	ang = Angle(0, 90, 0),
	fov = 3.4,
}

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
					[1] = {
						["children"] = {},
						["self"] = {
							["Angles"] = Angle(0, 270, -30),
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_mp412_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(-9.38, 5.552, -2.062),
							["EditorExpand"] = true,
							["UniqueID"] = "1803035224",
							["Bone"] = "pelvis",
							["Name"] = "mp412",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "2269338150",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_mp412_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "3509392452",
			["EditorExpand"] = true,
		},
	},
}
