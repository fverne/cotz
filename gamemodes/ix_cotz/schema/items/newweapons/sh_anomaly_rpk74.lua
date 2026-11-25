ITEM.name = "RPK-74"
ITEM.description = "RPK-74, chambered for 5.45x39mm."
ITEM.longdesc = "A long barrel, bipod and large magazine give it more bulk than a standard AK-74."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_rpk74_w.mdl"

ITEM.price = 37500
ITEM.width = 6
ITEM.height = 2
ITEM.unloadedweight = 4.7
ITEM.bulletweight = 0.011

ITEM.class = "cw_anomaly_rpk74_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(9.4, -205, 4.7),
	ang = Angle(0, 90, 0),
	fov = 11.5,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_rpk74_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(14.48, -3.925, -1.348),
							["EditorExpand"] = true,
							["UniqueID"] = "1641394080",
							["Bone"] = "spine 2",
							["Name"] = "rpk74",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "2381240286",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_rpk74_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "3682638268",
			["EditorExpand"] = true,
		},
	},
}
