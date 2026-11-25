ITEM.name = "Karabiner 98 Kurz"
ITEM.description = "Karabiner 98 Kurz with no compatible ammunition in this conversion."
ITEM.longdesc = "The turned-down bolt handle lies close against the wooden stock."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_kar98k_w.mdl"

ITEM.price = 19000
ITEM.width = 6
ITEM.height = 1
ITEM.unloadedweight = 3.9
ITEM.bulletweight = 0

ITEM.class = "cw_anomaly_k98_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(6.8, -205, 2.8),
	ang = Angle(0, 90, 0),
	fov = 15.6,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_kar98k_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(16.349, -3.266, -1.726),
							["EditorExpand"] = true,
							["UniqueID"] = "3208348802",
							["Bone"] = "spine 2",
							["Name"] = "k98",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "1392573692",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_k98_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "91140766",
			["EditorExpand"] = true,
		},
	},
}
