ITEM.name = "M79"
ITEM.description = "M79, chambered for 40 mm rounds."
ITEM.longdesc = "The barrel hinges down and exposes the chamber directly above the wooden fore-end."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_m79_w.mdl"

ITEM.price = 31000
ITEM.width = 4
ITEM.height = 1
ITEM.unloadedweight = 2.7
ITEM.bulletweight = 0.23

ITEM.class = "cw_anomaly_m79_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(2.8, -205, 7.2),
	ang = Angle(0, 90, 0),
	fov = 9.5,
}

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
					[1] = {
						["children"] = {},
						["self"] = {
							["Angles"] = Angle(0, 0, 180),
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_m79_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(9.6, -4.18, -4.8),
							["EditorExpand"] = true,
							["UniqueID"] = "1577799936",
							["Bone"] = "spine 2",
							["Name"] = "m79",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "2989500798",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_m79_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "3831392028",
			["EditorExpand"] = true,
		},
	},
}
