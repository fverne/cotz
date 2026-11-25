ITEM.name = "G3 SG1"
ITEM.description = "G3 SG1, chambered for 7.62x51mm."
ITEM.longdesc = "A raised cheek rest and a fitted bipod set the SG1 apart from the standard G3."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_g3sg1_w.mdl"

ITEM.price = 40000
ITEM.width = 6
ITEM.height = 2
ITEM.unloadedweight = 5.5
ITEM.bulletweight = 0.026

ITEM.class = "cw_anomaly_g3sg1_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(6.5, -205, 6.8),
	ang = Angle(0, 90, 0),
	fov = 10.6,
}

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
					[1] = {
						["children"] = {},
						["self"] = {
							["Angles"] = Angle(-7.344, 180, 180),
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_g3sg1_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(14.673, -3.125, -2.02),
							["EditorExpand"] = true,
							["UniqueID"] = "1299934608",
							["Bone"] = "spine 2",
							["Name"] = "g3sg1",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "2705331694",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_g3sg1_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "4147010444",
			["EditorExpand"] = true,
		},
	},
}
