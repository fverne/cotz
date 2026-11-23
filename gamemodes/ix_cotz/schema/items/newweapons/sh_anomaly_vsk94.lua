ITEM.name = "VSK-94"
ITEM.description = "VSK-94, chambered for 9x39mm."
ITEM.longdesc = "A skeleton stock and full-length suppressor extend the compact 9A-91-derived receiver at either end."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_vsk94_w.mdl"

ITEM.price = 35500
ITEM.width = 5
ITEM.height = 1
ITEM.unloadedweight = 2.8
ITEM.bulletweight = 0.023

ITEM.class = "cw_anomaly_vsk94_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(5.4, -205, 4.5),
	ang = Angle(0, 90, 0),
	fov = 10.9,
}

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
					[1] = {
						["children"] = {},
						["self"] = {
							["Angles"] = Angle(-6, 0, 180),
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_vsk94_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(-1.724, -4.195, -3.961),
							["EditorExpand"] = true,
							["UniqueID"] = "3444193990",
							["Bone"] = "spine 2",
							["Name"] = "vsk94",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "561070776",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_vsk94_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "1998523610",
			["EditorExpand"] = true,
		},
	},
}
