ITEM.name = "M4A1"
ITEM.description = "M4A1, chambered for 5.56x45mm."
ITEM.longdesc = "The adjustable stock and short handguard make the M4A1 more compact than a full-length M16."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_m4a1_w.mdl"

ITEM.price = 28500
ITEM.width = 5
ITEM.height = 2
ITEM.unloadedweight = 2.95
ITEM.bulletweight = 0.012

ITEM.class = "cw_anomaly_m4a1_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(5.9, -205, 5.3),
	ang = Angle(0, 90, 0),
	fov = 10.4,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_m4a1_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(16.543, -4.312, -1.374),
							["EditorExpand"] = true,
							["UniqueID"] = "1980832165",
							["Bone"] = "spine 2",
							["Name"] = "m4a1",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "2586468827",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_m4a1_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "3427020729",
			["EditorExpand"] = true,
		},
	},
}
