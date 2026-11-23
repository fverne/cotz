ITEM.name = "AK-47"
ITEM.description = "AK-47, chambered for 7.62x39mm."
ITEM.longdesc = "The thick receiver and solid wooden furniture make this early AK noticeably heavier than an AKM."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_ak.mdl"

ITEM.price = 17000
ITEM.width = 5
ITEM.height = 2
ITEM.unloadedweight = 4.3
ITEM.bulletweight = 0.019

ITEM.class = "cw_anomaly_ak_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(5.1, -205, 0.9),
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_ak.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(11.522, -4.244, -1.16),
							["EditorExpand"] = true,
							["UniqueID"] = "2613172717",
							["Bone"] = "spine 2",
							["Name"] = "ak",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "2012914067",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_ak_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "563408881",
			["EditorExpand"] = true,
		},
	},
}
