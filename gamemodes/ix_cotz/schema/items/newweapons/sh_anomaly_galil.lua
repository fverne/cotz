ITEM.name = "Galil AR"
ITEM.description = "Galil AR, chambered for 7.62x51mm."
ITEM.longdesc = "The Galil AR combines a substantial steel receiver with a folding stock and an upright charging handle."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_galil_w.mdl"

ITEM.price = 34000
ITEM.width = 5
ITEM.height = 2
ITEM.unloadedweight = 4.3
ITEM.bulletweight = 0.026

ITEM.class = "cw_anomaly_galil_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(6.8, -205, 6.4),
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_galil_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(11.522, -3.244, -1.16),
							["EditorExpand"] = true,
							["UniqueID"] = "1064187544",
							["Bone"] = "spine 2",
							["Name"] = "galil",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "3545583334",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_galil_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "2235236484",
			["EditorExpand"] = true,
		},
	},
}
