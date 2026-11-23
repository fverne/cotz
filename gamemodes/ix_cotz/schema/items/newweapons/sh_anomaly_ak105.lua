ITEM.name = "AK-105"
ITEM.description = "AK-105, chambered for 5.45x39mm."
ITEM.longdesc = "The AK-105 sits between a full-length AK-74M and the stubby AKS-74U in size."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_ak105_w.mdl"

ITEM.price = 14500
ITEM.width = 4
ITEM.height = 2
ITEM.unloadedweight = 3.2
ITEM.bulletweight = 0.011

ITEM.class = "cw_anomaly_ak105_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(4.5, -205, 5.9),
	ang = Angle(0, 90, 0),
	fov = 8.9,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_ak105_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(11.522, -4.244, -1.16),
							["EditorExpand"] = true,
							["UniqueID"] = "2673798468",
							["Bone"] = "spine 2",
							["Name"] = "ak105",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "1936037178",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_ak105_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "621534040",
			["EditorExpand"] = true,
		},
	},
}
