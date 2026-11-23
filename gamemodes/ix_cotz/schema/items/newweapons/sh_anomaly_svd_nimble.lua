ITEM.name = "SVD “Lynx”"
ITEM.description = "SVD “Lynx”, chambered for 7.62x54mmR."
ITEM.longdesc = "The Lynx keeps the Dragunov's slender receiver and skeleton stock under its custom sight assembly."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_svd_nimble_w.mdl"

ITEM.price = 49200
ITEM.width = 6
ITEM.height = 1
ITEM.unloadedweight = 4.4
ITEM.bulletweight = 0.022

ITEM.class = "cw_anomaly_svd_nimble_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(13.2, -205, 5.7),
	ang = Angle(0, 90, 0),
	fov = 18.9,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_svd_nimble_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(17.784, -5.054, -1.356),
							["EditorExpand"] = true,
							["UniqueID"] = "234247630",
							["Bone"] = "spine 2",
							["Name"] = "svd_nimble",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "3788320176",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_svd_nimble_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "3080938450",
			["EditorExpand"] = true,
		},
	},
}
