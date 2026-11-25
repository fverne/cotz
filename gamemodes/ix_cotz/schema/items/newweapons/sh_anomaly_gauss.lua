ITEM.name = "Gauss rifle"
ITEM.description = "Gauss rifle with no compatible ammunition in this conversion."
ITEM.longdesc = "Much of the Gauss rifle's length lies ahead of the grip, inside the long housing around the accelerator."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/w_wpn_gauss.mdl"

ITEM.price = 110000
ITEM.width = 7
ITEM.height = 2
ITEM.unloadedweight = 6.2
ITEM.bulletweight = 0

ITEM.class = "cw_anomaly_gauss_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(7.6, -205, 4.3),
	ang = Angle(0, 90, 0),
	fov = 11.4,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/w_wpn_gauss.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(17.784, -4.304, -1.356),
							["EditorExpand"] = true,
							["UniqueID"] = "2759749101",
							["Bone"] = "spine 2",
							["Name"] = "gauss",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "1212487059",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_gauss_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "506158065",
			["EditorExpand"] = true,
		},
	},
}
