ITEM.name = "Fort-500"
ITEM.description = "Fort-500, chambered for 12 Gauge."
ITEM.longdesc = "The Fort's sliding fore-end cycles the action below the fixed barrel."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_fort500500_w.mdl"

ITEM.price = 11000
ITEM.width = 4
ITEM.height = 1
ITEM.unloadedweight = 3.8
ITEM.bulletweight = 0.031

ITEM.class = "cw_anomaly_fort500_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(12.9, -205, 3.5),
	ang = Angle(0, 90, 0),
	fov = 9,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_fort500500_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(-2.502, -3.06, -2.254),
							["EditorExpand"] = true,
							["UniqueID"] = "2150688494",
							["Bone"] = "spine 2",
							["Name"] = "fort500",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "1812700816",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_fort500_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "979751154",
			["EditorExpand"] = true,
		},
	},
}
