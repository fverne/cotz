ITEM.name = "TOZ-34 “Bizon”"
ITEM.description = "TOZ-34 “Bizon”, chambered for 12 Gauge."
ITEM.longdesc = "The Bizon retains the narrow over-under barrel arrangement of the TOZ-34."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_toz34_mark4_w.mdl"

ITEM.price = 9500
ITEM.width = 6
ITEM.height = 1
ITEM.unloadedweight = 3.25
ITEM.bulletweight = 0.031

ITEM.class = "cw_anomaly_toz34_mark4_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(9.3, -205, 5.8),
	ang = Angle(0, 90, 0),
	fov = 22.6,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_toz34_mark4_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(0.066, -2.827, -3.147),
							["EditorExpand"] = true,
							["UniqueID"] = "784631056",
							["Bone"] = "spine 2",
							["Name"] = "toz34_mark4",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "3271556462",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_toz34_mark4_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "2492576524",
			["EditorExpand"] = true,
		},
	},
}
