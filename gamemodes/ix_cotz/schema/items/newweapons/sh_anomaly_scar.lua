ITEM.name = "FN SCAR-H"
ITEM.description = "FN SCAR-H, chambered for 7.62x51mm."
ITEM.longdesc = "The thick upper receiver carries the rail, while the stock folds alongside the lower."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_scar_w.mdl"

ITEM.price = 44500
ITEM.width = 5
ITEM.height = 2
ITEM.unloadedweight = 3.8
ITEM.bulletweight = 0.026

ITEM.class = "cw_anomaly_scar_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(5.6, -205, 4.3),
	ang = Angle(0, 90, 0),
	fov = 10.7,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_scar_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(13.596, -3.444, -1.874),
							["EditorExpand"] = true,
							["UniqueID"] = "2207797293",
							["Bone"] = "spine 2",
							["Name"] = "scar",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "1872963667",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_scar_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "969762353",
			["EditorExpand"] = true,
		},
	},
}
