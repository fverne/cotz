ITEM.name = "PKP “Pecheneg”"
ITEM.description = "PKP “Pecheneg”, chambered for 7.62x54mmR."
ITEM.longdesc = "The long barrel jacket extends to the bipod near the muzzle."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_pkp_w.mdl"

ITEM.price = 61500
ITEM.width = 6
ITEM.height = 2
ITEM.unloadedweight = 8.2
ITEM.bulletweight = 0.022

ITEM.class = "cw_anomaly_pkp_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(7.8, -205, 4.3),
	ang = Angle(0, 90, 0),
	fov = 12.5,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_pkp_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(11.188, -4.425, -0.658),
							["EditorExpand"] = true,
							["UniqueID"] = "2936647183",
							["Bone"] = "spine 2",
							["Name"] = "pkp",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "1127405169",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_pkp_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "358389779",
			["EditorExpand"] = true,
		},
	},
}
