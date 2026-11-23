ITEM.name = "AKS-74UNB (custom)"
ITEM.description = "AKS-74UNB (custom), chambered for 5.45x39mm."
ITEM.longdesc = "The compact AKS-74UNB has a custom sight arrangement on its abbreviated receiver."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_ak74u_snag_w.mdl"

ITEM.price = 15500
ITEM.width = 4
ITEM.height = 2
ITEM.unloadedweight = 2.9
ITEM.bulletweight = 0.011

ITEM.class = "cw_anomaly_ak74u_snag_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(5.8, -205, 5.5),
	ang = Angle(0, 90, 0),
	fov = 9.4,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_ak74u_snag_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(4.093, -4.807, -4.414),
							["EditorExpand"] = true,
							["UniqueID"] = "1438408038",
							["Bone"] = "spine 2",
							["Name"] = "ak74u_snag",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "3112641816",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_ak74u_snag_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "4025052026",
			["EditorExpand"] = true,
		},
	},
}
