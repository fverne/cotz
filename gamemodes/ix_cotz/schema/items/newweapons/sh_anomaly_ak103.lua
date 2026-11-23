ITEM.name = "AK-103"
ITEM.description = "AK-103, chambered for 7.62x39mm."
ITEM.longdesc = "The AK-103 brings the old curved steel-magazine profile to the modern polymer-stock AK family."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_ak103.mdl"

ITEM.price = 21000
ITEM.width = 5
ITEM.height = 2
ITEM.unloadedweight = 3.6
ITEM.bulletweight = 0.019

ITEM.class = "cw_anomaly_ak103_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(6.6, -205, 0.8),
	ang = Angle(0, 90, 0),
	fov = 10.5,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_ak103.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(11.522, -4.244, -1.16),
							["EditorExpand"] = true,
							["UniqueID"] = "3436151968",
							["Bone"] = "spine 2",
							["Name"] = "ak103",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "552926430",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_ak103_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "1989849788",
			["EditorExpand"] = true,
		},
	},
}
