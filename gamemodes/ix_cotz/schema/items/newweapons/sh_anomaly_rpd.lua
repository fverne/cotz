ITEM.name = "RPD"
ITEM.description = "RPD, chambered for 7.62x39mm."
ITEM.longdesc = "The round case hangs under the receiver and holds a folded belt."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_rpd_w.mdl"

ITEM.price = 37000
ITEM.width = 6
ITEM.height = 2
ITEM.unloadedweight = 7.4
ITEM.bulletweight = 0.019

ITEM.class = "cw_anomaly_rpd_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(6.3, -205, 3.5),
	ang = Angle(0, 90, 0),
	fov = 11.1,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_rpd_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(14.48, -5.425, -1.348),
							["EditorExpand"] = true,
							["UniqueID"] = "974142194",
							["Bone"] = "spine 2",
							["Name"] = "rpd",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "3593159308",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_rpd_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "2152008942",
			["EditorExpand"] = true,
		},
	},
}
