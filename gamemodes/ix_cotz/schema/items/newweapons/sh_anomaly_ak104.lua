ITEM.name = "AK-104"
ITEM.description = "AK-104, chambered for 7.62x39mm."
ITEM.longdesc = "A short front end gives the AK-104 a noticeably different balance from the AK-103."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_ak104.mdl"

ITEM.price = 20500
ITEM.width = 4
ITEM.height = 2
ITEM.unloadedweight = 3.2
ITEM.bulletweight = 0.019

ITEM.class = "cw_anomaly_ak104_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(4.7, -205, 0.8),
	ang = Angle(0, 90, 0),
	fov = 9.2,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_ak104.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(11.522, -4.244, -1.16),
							["EditorExpand"] = true,
							["UniqueID"] = "825654485",
							["Bone"] = "spine 2",
							["Name"] = "ak104",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "3708617899",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_ak104_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "2338540233",
			["EditorExpand"] = true,
		},
	},
}
